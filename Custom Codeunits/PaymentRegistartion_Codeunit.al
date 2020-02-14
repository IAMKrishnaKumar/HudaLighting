codeunit 50115 "Payment Reg. mgmt Custom"
{
    EventSubscriberInstance = Manual;
    TableNo = 981;

    trigger OnRun()
    begin
        IF PreviewMode THEN
            RunPreview(Rec, AsLumpPreviewContext);
    end;

    var
        NothingToPostErr: Label 'There is nothing to post.';
        EmptyDateReceivedErr: Label 'Date Received is missing for line with Document No. %1.';
        ConfirmPostPaymentsQst: Label 'Do you want to post the %1 payments?', Comment = '%1=number of payments to post';
        CloseQst: Label 'The %1 check box is selected on one or more lines. Do you want to close the window without posting these lines?';
        TempTableErr: Label 'The table passed as a parameter must be temporary.';
        SalesOrderTxt: Label 'Sales Order';
        SalesBlanketOrderTxt: Label 'Sales Blanket Order';
        SalesQuoteTxt: Label 'Sales Quote';
        SalesInvoiceTxt: Label 'Sales Invoice';
        SalesReturnOrderTxt: Label 'Sales Return Order';
        SalesCreditMemoTxt: Label 'Sales Credit Memo';
        ServiceQuoteTxt: Label 'Service Quote';
        ServiceOrderTxt: Label 'Service Order';
        ServiceInvoiceTxt: Label 'Service Invoice';
        ServiceCreditMemoTxt: Label 'Service Credit Memo';
        ReminderTxt: Label 'Reminder';
        FinChrgMemoTxt: Label 'Finance Charge Memo ';
        DistinctDateReceivedErr: Label 'To post as a lump payment, the %1 field must have the same value in all lines where the %2 check box is selected.';
        DistinctCustomerErr: Label 'To post as lump payment, the customer must be same value on all lines where the %1 check box is selected.';
        ConfirmLumpPaymentQst: Label 'Do you want to post the %1 payments as a lump sum of %2?', Comment = '%1=number of payments to post, %2 sum of amount received.';
        ForeignCurrNotSuportedErr: Label 'The document with type %1 and description %2 must have the same currency code as the payment you are registering.\\To register the payment, you must change %3 to use a balancing account with the same currency as the document. Alternatively, use the Cash Receipt Journal page to process the payment.', Comment = '%1 = Document Type; %2 = Description; %3 = Payment Registration Setup; Cash Receipt Journal should have the same translation as the pages with the same name.';
        PreviewMode: Boolean;
        AsLumpPreviewContext: Boolean;


    procedure RunSetup()
    var
        PaymentRegistrationSetup: Record 980;
        SetupOK: Boolean;
        RunFullSetup: Boolean;
    begin
        IF NOT PaymentRegistrationSetup.GET(USERID) THEN
            RunFullSetup := TRUE
        ELSE
            RunFullSetup := NOT PaymentRegistrationSetup.ValidateMandatoryFields(FALSE);

        IF RunFullSetup THEN
            SetupOK := PAGE.RUNMODAL(PAGE::"Payment Registration Setup") = ACTION::LookupOK
        ELSE
            IF PaymentRegistrationSetup."Use this Account as Def." THEN
                SetupOK := TRUE
            ELSE
                SetupOK := PAGE.RUNMODAL(PAGE::"Balancing Account Setup") = ACTION::LookupOK;

        IF NOT SetupOK THEN
            ERROR('');
    end;

    //[Scope('Internal')]
    procedure Post(var TempPaymentRegistrationBuffer: Record 981 temporary; LumpPayment: Boolean)
    var
        BankAcc: Record 270;
        PaymentRegistrationSetup: Record 980;
        GenJournalLine: Record 81;
        GenJnlBatch: Record 232;
        GenJnlTemplate: Record 80;
        NoSeriesMgt: Codeunit 396;
        GenJnlPostBatch: Codeunit 13;
    begin
        WITH PaymentRegistrationSetup DO BEGIN
            GET(USERID);
            ValidateMandatoryFields(TRUE);
            GenJnlTemplate.GET("Journal Template Name");
            GenJnlBatch.GET("Journal Template Name", "Journal Batch Name");
        END;

        GenJournalLine.SETRANGE("Journal Template Name", PaymentRegistrationSetup."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", PaymentRegistrationSetup."Journal Batch Name");
        IF GenJournalLine.FINDLAST THEN
            GenJournalLine.SETFILTER("Line No.", '>%1', GenJournalLine."Line No.");

        TempPaymentRegistrationBuffer.FINDSET;
        REPEAT
            IF TempPaymentRegistrationBuffer."Date Received" = 0D THEN
                ERROR(EmptyDateReceivedErr, TempPaymentRegistrationBuffer."Document No.");
            IF NOT LumpPayment THEN
                UpdatePmtDiscountDateOnCustLedgerEntry(TempPaymentRegistrationBuffer);
            WITH GenJournalLine DO BEGIN
                INIT;
                "Journal Template Name" := PaymentRegistrationSetup."Journal Template Name";
                "Journal Batch Name" := PaymentRegistrationSetup."Journal Batch Name";
                "Line No." += 10000;

                "Source Code" := GenJnlTemplate."Source Code";
                "Reason Code" := GenJnlBatch."Reason Code";
                "Posting No. Series" := GenJnlBatch."Posting No. Series";

                VALIDATE("Posting Date", TempPaymentRegistrationBuffer."Date Received");
                VALIDATE("Account Type", "Account Type"::Customer);
                VALIDATE("Document Type", "Document Type"::Payment);
                "Document No." := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", "Posting Date", FALSE);
                VALIDATE("Bal. Account Type", PaymentRegistrationSetup.GetGLBalAccountType);
                VALIDATE("Account No.", TempPaymentRegistrationBuffer."Source No.");
                VALIDATE(Amount, -TempPaymentRegistrationBuffer."Amount Received");
                VALIDATE("Bal. Account No.", PaymentRegistrationSetup."Bal. Account No.");
                VALIDATE("Payment Method Code", TempPaymentRegistrationBuffer."Payment Method Code");
                //LT-Star
                Validate("Check No.", TempPaymentRegistrationBuffer."Check No.");
                Validate("Check Date", TempPaymentRegistrationBuffer."Check Date");
                Validate(Narration, TempPaymentRegistrationBuffer.Narration);
                //LT-End
                IF "Bal. Account Type" = "Bal. Account Type"::"Bank Account" THEN BEGIN
                    BankAcc.GET("Bal. Account No.");
                    VALIDATE("Currency Code", BankAcc."Currency Code");
                END;
                CheckCurrencyCode(TempPaymentRegistrationBuffer, GenJournalLine, PaymentRegistrationSetup, LumpPayment);
                IF LumpPayment THEN
                    "Applies-to ID" := "Document No."
                ELSE BEGIN
                    VALIDATE("Applies-to Doc. Type", TempPaymentRegistrationBuffer."Document Type");
                    VALIDATE("Applies-to Doc. No.", TempPaymentRegistrationBuffer."Document No.");
                END;
                VALIDATE("External Document No.", TempPaymentRegistrationBuffer."External Document No.");
                INSERT(TRUE);
            END;
        UNTIL TempPaymentRegistrationBuffer.NEXT = 0;

        IF NOT PreviewMode THEN BEGIN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
            OnAfterPostPaymentRegistration(TempPaymentRegistrationBuffer);
        END ELSE
            exit;
        //GenJnlPostBatch.Preview(GenJournalLine);//Preview not allowed in BC VS code
    end;


    procedure ConfirmClose(var PaymentRegistrationBuffer: Record 981): Boolean
    begin
        WITH PaymentRegistrationBuffer DO BEGIN
            RESET;
            SETRANGE("Payment Made", TRUE);
            IF NOT ISEMPTY THEN
                EXIT(CONFIRM(STRSUBSTNO(CloseQst, FIELDCAPTION("Payment Made"))));
        END;

        EXIT(TRUE);
    end;


    procedure ConfirmPost(var PaymentRegistrationBuffer: Record 981)
    var
        PaymentRegistrationBuffer2: Record 981;
        Confirmed: Boolean;
    begin
        PaymentRegistrationBuffer2.COPYFILTERS(PaymentRegistrationBuffer);
        WITH PaymentRegistrationBuffer DO BEGIN
            CheckPaymentsToPost(PaymentRegistrationBuffer);
            IF NOT PreviewMode THEN
                Confirmed := CONFIRM(STRSUBSTNO(ConfirmPostPaymentsQst, COUNT), TRUE);

            IF PreviewMode OR Confirmed THEN BEGIN
                Post(PaymentRegistrationBuffer, FALSE);
                PopulateTable;
            END;
            COPYFILTERS(PaymentRegistrationBuffer2);
        END
    end;


    procedure FindRecords(var TempDocumentSearchResult: Record 983 temporary; DocNoFilter: Code[20]; AmountFilter: Decimal; AmountTolerancePerc: Decimal)
    begin
        IF NOT TempDocumentSearchResult.ISTEMPORARY THEN
            ERROR(TempTableErr);

        TempDocumentSearchResult.RESET;
        TempDocumentSearchResult.DELETEALL;
        DocNoFilter := STRSUBSTNO('*%1*', DocNoFilter);

        FindSalesHeaderRecords(TempDocumentSearchResult, DocNoFilter, AmountFilter, AmountTolerancePerc);
        FindServiceHeaderRecords(TempDocumentSearchResult, DocNoFilter, AmountFilter, AmountTolerancePerc);
        FindReminderHeaderRecords(TempDocumentSearchResult, DocNoFilter, AmountFilter, AmountTolerancePerc);
        FindFinChargeMemoHeaderRecords(TempDocumentSearchResult, DocNoFilter, AmountFilter, AmountTolerancePerc);
    end;

    local procedure FindSalesHeaderRecords(var TempDocumentSearchResult: Record 983 temporary; DocNoFilter: Code[20]; AmountFilter: Decimal; AmountTolerancePerc: Decimal)
    var
        SalesHeader: Record 36;
    begin
        IF SalesHeader.READPERMISSION THEN BEGIN
            SalesHeader.RESET;
            SalesHeader.SETFILTER("No.", DocNoFilter);
            IF SalesHeader.FINDSET THEN
                REPEAT
                    SalesHeader.CALCFIELDS(Amount, "Amount Including VAT");
                    IF IsWithinTolerance(SalesHeader."Amount Including VAT", AmountFilter, AmountTolerancePerc) THEN
                        InsertDocSearchResult(TempDocumentSearchResult, SalesHeader."No.", SalesHeader."Document Type", DATABASE::"Sales Header",
                          GetSalesHeaderDescription(SalesHeader), SalesHeader."Amount Including VAT");
                UNTIL SalesHeader.NEXT = 0;
        END;
    end;

    local procedure FindServiceHeaderRecords(var TempDocumentSearchResult: Record 983 temporary; DocNoFilter: Code[20]; AmountFilter: Decimal; AmountTolerancePerc: Decimal)
    var
        ServiceHeader: Record 5900;
        ServiceLine: Record 5902;
    begin
        IF ServiceHeader.READPERMISSION THEN BEGIN
            ServiceHeader.RESET;
            ServiceHeader.SETFILTER("No.", DocNoFilter);
            IF ServiceHeader.FINDSET THEN
                REPEAT
                    ServiceLine.RESET;
                    ServiceLine.SETRANGE("Document Type", ServiceHeader."Document Type");
                    ServiceLine.SETRANGE("Document No.", ServiceHeader."No.");
                    ServiceLine.CALCSUMS("Amount Including VAT");
                    IF IsWithinTolerance(ServiceLine."Amount Including VAT", AmountFilter, AmountTolerancePerc) THEN
                        InsertDocSearchResult(
                          TempDocumentSearchResult, ServiceHeader."No.", ServiceHeader."Document Type", DATABASE::"Service Header",
                          GetServiceHeaderDescription(ServiceHeader), ServiceLine."Amount Including VAT");
                UNTIL ServiceHeader.NEXT = 0;
        END;
    end;

    local procedure FindReminderHeaderRecords(var TempDocumentSearchResult: Record 983 temporary; DocNoFilter: Code[20]; AmountFilter: Decimal; AmountTolerancePerc: Decimal)
    var
        ReminderHeader: Record 295;
    begin
        IF ReminderHeader.READPERMISSION THEN BEGIN
            ReminderHeader.RESET;
            ReminderHeader.SETFILTER("No.", DocNoFilter);
            IF ReminderHeader.FINDSET THEN
                REPEAT
                    ReminderHeader.CALCFIELDS("Remaining Amount", "Interest Amount");
                    IF IsWithinTolerance(ReminderHeader."Remaining Amount", AmountFilter, AmountTolerancePerc) OR
                       IsWithinTolerance(ReminderHeader."Interest Amount", AmountFilter, AmountTolerancePerc)
                    THEN
                        InsertDocSearchResult(TempDocumentSearchResult, ReminderHeader."No.", 0, DATABASE::"Reminder Header",
                          ReminderTxt, ReminderHeader."Remaining Amount");
                UNTIL ReminderHeader.NEXT = 0;
        END;
    end;

    local procedure FindFinChargeMemoHeaderRecords(var TempDocumentSearchResult: Record 983 temporary; DocNoFilter: Code[20]; AmountFilter: Decimal; AmountTolerancePerc: Decimal)
    var
        FinChargeMemoHeader: Record 302;
    begin
        IF FinChargeMemoHeader.READPERMISSION THEN BEGIN
            FinChargeMemoHeader.RESET;
            FinChargeMemoHeader.SETFILTER("No.", DocNoFilter);
            IF FinChargeMemoHeader.FINDSET THEN
                REPEAT
                    FinChargeMemoHeader.CALCFIELDS("Remaining Amount", "Interest Amount");
                    IF IsWithinTolerance(FinChargeMemoHeader."Remaining Amount", AmountFilter, AmountTolerancePerc) OR
                       IsWithinTolerance(FinChargeMemoHeader."Interest Amount", AmountFilter, AmountTolerancePerc)
                    THEN
                        InsertDocSearchResult(TempDocumentSearchResult, FinChargeMemoHeader."No.", 0, DATABASE::"Finance Charge Memo Header",
                          FinChrgMemoTxt, FinChargeMemoHeader."Remaining Amount");
                UNTIL FinChargeMemoHeader.NEXT = 0;
        END;
    end;


    procedure ShowRecords(var TempDocumentSearchResult: Record 983 temporary)
    var
        ReminderHeader: Record 295;
        FinanceChargeMemoHeader: Record 302;
    begin
        CASE TempDocumentSearchResult."Table ID" OF
            DATABASE::"Sales Header":
                ShowSalesHeaderRecords(TempDocumentSearchResult);
            DATABASE::"Service Header":
                ShowServiceHeaderRecords(TempDocumentSearchResult);
            DATABASE::"Reminder Header":
                BEGIN
                    ReminderHeader.GET(TempDocumentSearchResult."Doc. No.");
                    PAGE.RUN(PAGE::Reminder, ReminderHeader);
                END;
            DATABASE::"Finance Charge Memo Header":
                BEGIN
                    FinanceChargeMemoHeader.GET(TempDocumentSearchResult."Doc. No.");
                    PAGE.RUN(PAGE::"Finance Charge Memo", FinanceChargeMemoHeader);
                END;
        END;
    end;

    local procedure ShowSalesHeaderRecords(var TempDocumentSearchResult: Record 983 temporary)
    var
        SalesHeader: Record 36;
    begin
        TempDocumentSearchResult.TESTFIELD("Table ID", DATABASE::"Sales Header");
        SalesHeader.SETRANGE("Document Type", TempDocumentSearchResult."Doc. Type");
        SalesHeader.SETRANGE("No.", TempDocumentSearchResult."Doc. No.");

        CASE TempDocumentSearchResult."Doc. Type" OF
            SalesHeader."Document Type"::Quote:
                PAGE.RUN(PAGE::"Sales Quote", SalesHeader);
            SalesHeader."Document Type"::"Blanket Order":
                PAGE.RUN(PAGE::"Blanket Sales Order", SalesHeader);
            SalesHeader."Document Type"::Order:
                PAGE.RUN(PAGE::"Sales Order", SalesHeader);
            SalesHeader."Document Type"::Invoice:
                PAGE.RUN(PAGE::"Sales Invoice", SalesHeader);
            SalesHeader."Document Type"::"Return Order":
                PAGE.RUN(PAGE::"Sales Return Order", SalesHeader);
            SalesHeader."Document Type"::"Credit Memo":
                PAGE.RUN(PAGE::"Sales Credit Memo", SalesHeader);
            ELSE
                PAGE.RUN(0, SalesHeader);
        END;
    end;

    local procedure ShowServiceHeaderRecords(var TempDocumentSearchResult: Record 983 temporary)
    var
        ServiceHeader: Record 5900;
    begin
        TempDocumentSearchResult.TESTFIELD("Table ID", DATABASE::"Service Header");
        ServiceHeader.SETRANGE("Document Type", TempDocumentSearchResult."Doc. Type");
        ServiceHeader.SETRANGE("No.", TempDocumentSearchResult."Doc. No.");

        CASE TempDocumentSearchResult."Doc. Type" OF
            ServiceHeader."Document Type"::Quote:
                PAGE.RUN(PAGE::"Service Quote", ServiceHeader);
            ServiceHeader."Document Type"::Order:
                PAGE.RUN(PAGE::"Service Order", ServiceHeader);
            ServiceHeader."Document Type"::Invoice:
                PAGE.RUN(PAGE::"Service Invoice", ServiceHeader);
            ServiceHeader."Document Type"::"Credit Memo":
                PAGE.RUN(PAGE::"Service Credit Memo", ServiceHeader);
            ELSE
                PAGE.RUN(0, ServiceHeader);
        END;
    end;


    procedure ConfirmPostLumpPayment(var SourcePaymentRegistrationBuffer: Record 981)
    var
        CopyPaymentRegistrationBuffer: Record 981;
        TempPaymentRegistrationBuffer: Record 981 temporary;
        Confirmed: Boolean;
    begin
        CopyPaymentRegistrationBuffer.COPY(SourcePaymentRegistrationBuffer);

        WITH SourcePaymentRegistrationBuffer DO BEGIN
            RESET;
            IF FINDSET THEN
                REPEAT
                    TempPaymentRegistrationBuffer := SourcePaymentRegistrationBuffer;
                    TempPaymentRegistrationBuffer.INSERT;
                UNTIL NEXT = 0;
        END;

        WITH TempPaymentRegistrationBuffer DO BEGIN
            CheckPaymentsToPost(TempPaymentRegistrationBuffer);
            CreateLumpPayment(TempPaymentRegistrationBuffer);
            IF NOT PreviewMode THEN
                Confirmed := CONFIRM(
                    STRSUBSTNO(
                      ConfirmLumpPaymentQst,
                      COUNT,
                      FORMAT("Amount Received", 0, '<Precision,2><Standard Format,0>')), TRUE);

            IF PreviewMode OR Confirmed THEN BEGIN
                MODIFY;
                SETRANGE("Amount Received", "Amount Received");
                Post(TempPaymentRegistrationBuffer, TRUE);
                SourcePaymentRegistrationBuffer.PopulateTable;
            END ELSE
                ClearApplicationFieldsOnCustLedgerEntry(TempPaymentRegistrationBuffer);
        END;

        SourcePaymentRegistrationBuffer.COPY(CopyPaymentRegistrationBuffer);
    end;

    local procedure UpdatePmtDiscountDateOnCustLedgerEntry(TempPaymentRegistrationBuffer: Record 981 temporary)
    var
        CustLedgerEntry: Record 21;
    begin
        CustLedgerEntry.LOCKTABLE;
        CustLedgerEntry.GET(TempPaymentRegistrationBuffer."Ledger Entry No.");
        IF CustLedgerEntry."Pmt. Discount Date" <> TempPaymentRegistrationBuffer."Pmt. Discount Date" THEN BEGIN
            CustLedgerEntry."Pmt. Discount Date" := TempPaymentRegistrationBuffer."Pmt. Discount Date";
            CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit", CustLedgerEntry);
        END;
    end;

    local procedure InsertDocSearchResult(var TempDocumentSearchResult: Record 983 temporary; DocNo: Code[20]; DocType: Integer; TableID: Integer; DocTypeDescription: Text[50]; Amount: Decimal)
    begin
        IF NOT TempDocumentSearchResult.GET(DocType, DocNo, TableID) THEN BEGIN
            TempDocumentSearchResult.INIT;
            TempDocumentSearchResult."Doc. No." := DocNo;
            TempDocumentSearchResult."Doc. Type" := DocType;
            TempDocumentSearchResult."Table ID" := TableID;
            TempDocumentSearchResult.Description := DocTypeDescription;
            TempDocumentSearchResult.Amount := Amount;
            TempDocumentSearchResult.INSERT(TRUE);
        END;
    end;


    procedure SetToleranceLimits(Amount: Decimal; AmountTolerance: Decimal; ToleranceTxt: Text): Text
    var
        GLSetup: Record 98;
    begin
        GLSetup.GET;
        IF (AmountTolerance > 0) AND (AmountTolerance <= 100) AND (Amount <> 0) THEN
            EXIT(STRSUBSTNO(ToleranceTxt, FORMAT((1 - AmountTolerance / 100) * Amount, 0, '<Precision,2><Standard Format,0>'),
                FORMAT((1 + AmountTolerance / 100) * Amount, 0, '<Precision,2><Standard Format,0>')));

        EXIT('');
    end;

    local procedure IsWithinTolerance(Amount: Decimal; FilterAmount: Decimal; TolerancePct: Decimal): Boolean
    begin
        IF FilterAmount = 0 THEN
            EXIT(TRUE);

        EXIT((Amount >= (1 - TolerancePct / 100) * FilterAmount) AND
          (Amount <= (1 + TolerancePct / 100) * FilterAmount));
    end;

    local procedure GetSalesHeaderDescription(SalesHeader: Record 36): Text[50]
    begin
        CASE SalesHeader."Document Type" OF
            SalesHeader."Document Type"::Quote:
                EXIT(SalesQuoteTxt);
            SalesHeader."Document Type"::"Blanket Order":
                EXIT(SalesBlanketOrderTxt);
            SalesHeader."Document Type"::Order:
                EXIT(SalesOrderTxt);
            SalesHeader."Document Type"::Invoice:
                EXIT(SalesInvoiceTxt);
            SalesHeader."Document Type"::"Return Order":
                EXIT(SalesReturnOrderTxt);
            SalesHeader."Document Type"::"Credit Memo":
                EXIT(SalesCreditMemoTxt);
            ELSE
                EXIT(SalesOrderTxt);
        END;
    end;

    local procedure GetServiceHeaderDescription(ServiceHeader: Record 5900): Text[50]
    begin
        CASE ServiceHeader."Document Type" OF
            ServiceHeader."Document Type"::Quote:
                EXIT(ServiceQuoteTxt);
            ServiceHeader."Document Type"::Order:
                EXIT(ServiceOrderTxt);
            ServiceHeader."Document Type"::Invoice:
                EXIT(ServiceInvoiceTxt);
            ServiceHeader."Document Type"::"Credit Memo":
                EXIT(ServiceCreditMemoTxt);
            ELSE
                EXIT(ServiceOrderTxt);
        END;
    end;

    local procedure UpdateApplicationFieldsOnCustLedgerEntry(TempPaymentRegistrationBuffer: Record 981 temporary)
    var
        PaymentRegistrationSetup: Record 980;
        CustLedgerEntry: Record 21;
        GenJnlBatch: Record 232;
        NoSeriesMgt: Codeunit 396;
    begin
        PaymentRegistrationSetup.GET(USERID);
        GenJnlBatch.GET(PaymentRegistrationSetup."Journal Template Name", PaymentRegistrationSetup."Journal Batch Name");

        CustLedgerEntry.LOCKTABLE;
        CustLedgerEntry.GET(TempPaymentRegistrationBuffer."Ledger Entry No.");
        CustLedgerEntry."Applies-to ID" :=
          NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", TempPaymentRegistrationBuffer."Date Received", FALSE);
        CustLedgerEntry."Amount to Apply" := TempPaymentRegistrationBuffer."Amount Received";
        CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit", CustLedgerEntry);
    end;

    local procedure ClearApplicationFieldsOnCustLedgerEntry(var TempPaymentRegistrationBuffer: Record 981 temporary)
    var
        CustLedgerEntry: Record 21;
    begin
        IF TempPaymentRegistrationBuffer.FINDSET THEN
            REPEAT
                CustLedgerEntry.GET(TempPaymentRegistrationBuffer."Ledger Entry No.");
                CustLedgerEntry."Applies-to ID" := '';
                CustLedgerEntry."Amount to Apply" := 0;
                CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit", CustLedgerEntry);
            UNTIL TempPaymentRegistrationBuffer.NEXT = 0;
    end;

    local procedure CreateLumpPayment(var PaymentRegistrationBuffer: Record 981)
    var
        AmountReceived: Decimal;
    begin
        CheckDistinctSourceNo(PaymentRegistrationBuffer);
        CheckDistinctDateReceived(PaymentRegistrationBuffer);
        IF PaymentRegistrationBuffer.FINDSET THEN
            REPEAT
                UpdatePmtDiscountDateOnCustLedgerEntry(PaymentRegistrationBuffer);
                UpdateApplicationFieldsOnCustLedgerEntry(PaymentRegistrationBuffer);
                AmountReceived += PaymentRegistrationBuffer."Amount Received";
            UNTIL PaymentRegistrationBuffer.NEXT = 0;

        PaymentRegistrationBuffer."Amount Received" := AmountReceived;
    end;

    local procedure CheckDistinctSourceNo(var PaymentRegistrationBuffer: Record 981)
    begin
        PaymentRegistrationBuffer.SETFILTER("Source No.", '<>%1', PaymentRegistrationBuffer."Source No.");
        IF NOT PaymentRegistrationBuffer.ISEMPTY THEN
            ERROR(DistinctCustomerErr, PaymentRegistrationBuffer.FIELDCAPTION("Payment Made"));

        PaymentRegistrationBuffer.SETRANGE("Source No.");
    end;

    local procedure CheckDistinctDateReceived(var PaymentRegistrationBuffer: Record 981)
    begin
        PaymentRegistrationBuffer.SETFILTER("Date Received", '<>%1', PaymentRegistrationBuffer."Date Received");
        IF NOT PaymentRegistrationBuffer.ISEMPTY THEN
            ERROR(DistinctDateReceivedErr, PaymentRegistrationBuffer.FIELDCAPTION("Date Received"),
              PaymentRegistrationBuffer.FIELDCAPTION("Payment Made"));

        PaymentRegistrationBuffer.SETRANGE("Date Received");
    end;

    local procedure CheckPaymentsToPost(var PaymentRegistrationBuffer: Record 981)
    begin
        PaymentRegistrationBuffer.RESET;
        PaymentRegistrationBuffer.SETRANGE("Payment Made", TRUE);
        PaymentRegistrationBuffer.SETFILTER("Amount Received", '<>0');
        IF NOT PaymentRegistrationBuffer.FINDSET THEN
            ERROR(NothingToPostErr);
    end;

    local procedure CheckCurrencyCode(var TempPaymentRegistrationBuffer: Record 981 temporary; GenJnlLine: Record 81; PaymentRegistrationSetup: Record 980; LumpPayment: Boolean)
    var
        CustLedgerEntry: Record 21;
    begin
        IF LumpPayment THEN
            CustLedgerEntry.SETRANGE("Applies-to ID", GenJnlLine."Document No.")
        ELSE
            CustLedgerEntry.SETRANGE("Entry No.", TempPaymentRegistrationBuffer."Ledger Entry No.");

        CustLedgerEntry.SETFILTER("Currency Code", '<>%1', GenJnlLine."Currency Code");
        IF NOT CustLedgerEntry.ISEMPTY THEN
            ERROR(ForeignCurrNotSuportedErr, TempPaymentRegistrationBuffer."Document Type", TempPaymentRegistrationBuffer.Description,
              PaymentRegistrationSetup.TABLECAPTION);
    end;


    procedure CalculateBalance(var PostedBalance: Decimal; var UnpostedBalance: Decimal)
    var
        PaymentRegistrationSetup: Record 980;
        GLAccount: Record 15;
        BankAccount: Record 270;
        GenJnlLine: Record 81;
    begin
        PaymentRegistrationSetup.GET(USERID);

        CASE PaymentRegistrationSetup."Bal. Account Type" OF
            PaymentRegistrationSetup."Bal. Account Type"::"G/L Account":
                BEGIN
                    IF GLAccount.GET(PaymentRegistrationSetup."Bal. Account No.") THEN
                        GLAccount.CALCFIELDS(Balance);
                    PostedBalance := GLAccount.Balance;
                    GenJnlLine.SETRANGE("Bal. Account Type", GenJnlLine."Bal. Account Type"::"G/L Account");
                END;
            PaymentRegistrationSetup."Bal. Account Type"::"Bank Account":
                BEGIN
                    IF BankAccount.GET(PaymentRegistrationSetup."Bal. Account No.") THEN
                        BankAccount.CALCFIELDS(Balance);
                    PostedBalance := BankAccount.Balance;
                    GenJnlLine.SETRANGE("Bal. Account Type", GenJnlLine."Bal. Account Type"::"Bank Account");
                END;
        END;

        GenJnlLine.SETRANGE("Bal. Account No.", PaymentRegistrationSetup."Bal. Account No.");
        GenJnlLine.CALCSUMS(Amount);
        UnpostedBalance := GenJnlLine.Amount;
    end;


    procedure OpenGenJnl()
    var
        PaymentRegistrationSetup: Record 980;
        GenJnlLine: Record 81;
    begin
        PaymentRegistrationSetup.GET(USERID);

        GenJnlLine.FILTERGROUP := 2;
        GenJnlLine.SETRANGE("Journal Template Name", PaymentRegistrationSetup."Journal Template Name");
        GenJnlLine.FILTERGROUP := 0;

        GenJnlLine."Journal Template Name" := '';
        GenJnlLine."Journal Batch Name" := PaymentRegistrationSetup."Journal Batch Name";
        PAGE.RUN(PAGE::"General Journal", GenJnlLine);
    end;


    procedure Preview(var PaymentRegistrationBuffer: Record 981; AsLump: Boolean)
    var
        GenJnlPostPreview: Codeunit 19;
        PaymentRegistrationMgt: Codeunit 980;
    begin
        BINDSUBSCRIPTION(PaymentRegistrationMgt);
        PaymentRegistrationMgt.SetPreviewContext(AsLump);
        GenJnlPostPreview.Preview(PaymentRegistrationMgt, PaymentRegistrationBuffer);
    end;

    local procedure RunPreview(var PaymentRegistrationBuffer: Record 981; AsLump: Boolean)
    var
        TempPaymentRegistrationBuffer: Record 981 temporary;
    begin
        // Copy checked payments to a temp table so that we can restore the checked state after the preview.
        CheckPaymentsToPost(PaymentRegistrationBuffer);
        REPEAT
            TempPaymentRegistrationBuffer := PaymentRegistrationBuffer;
            TempPaymentRegistrationBuffer.INSERT;
        UNTIL PaymentRegistrationBuffer.NEXT = 0;

        IF AsLump THEN
            ConfirmPostLumpPayment(PaymentRegistrationBuffer)
        ELSE
            ConfirmPost(PaymentRegistrationBuffer);

        // Populate the table so that all records show. Then restore the checked state of the originally checked records.
        PaymentRegistrationBuffer.PopulateTable;
        CheckPaymentsToPost(TempPaymentRegistrationBuffer);
        REPEAT
            // Check to see if the record already exists before updating
            PaymentRegistrationBuffer := TempPaymentRegistrationBuffer;
            IF PaymentRegistrationBuffer.FIND('=') THEN BEGIN
                PaymentRegistrationBuffer := TempPaymentRegistrationBuffer;
                PaymentRegistrationBuffer.MODIFY;
            END ELSE BEGIN
                PaymentRegistrationBuffer := TempPaymentRegistrationBuffer;
                PaymentRegistrationBuffer.INSERT;
            END;
        UNTIL TempPaymentRegistrationBuffer.NEXT = 0;
    end;


    procedure SetPreviewContext(AsLump: Boolean)
    begin
        AsLumpPreviewContext := AsLump;
    end;

    [EventSubscriber(ObjectType::Codeunit, 19, 'OnRunPreview', '', false, false)]
    local procedure OnRunPreview(var Result: Boolean; Subscriber: Variant; RecVar: Variant)
    var
        PaymentRegistrationMgt: Codeunit 980;
    begin
        PaymentRegistrationMgt := Subscriber;
        PreviewMode := TRUE;
        Result := PaymentRegistrationMgt.RUN(RecVar);
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterPostPaymentRegistration(var TempPaymentRegistrationBuffer: Record 981 temporary)
    begin
    end;
}

