page 60004 "PDC Issue"
{
    // Code           Date        Name        Desc.
    // APNT-LCPDC1.0  20.05.12    Monica      Created New.
    // APNT-LCPDC1.1  07.06.12    Monica      Added code.
    // APNT-1.0       30.12.12    Sangeeta    Added code for following check date in IBU entries.
    // APNT-1.1       29.01.13    Shameema    Modified code for dialog window pop in RTC - Update deposit date - OnPush()
    // APNT-DUR1.3    03.02.13    Sujith      Added code for to update Bounce Date & Returned Date in RTC
    // RT-0112        14.05.13    Tanweer     Added code to pass Payee to BLE
    // Regal1.0       21.05.14    Vijay       Added code to make supplier name default for Payee
    // MS.20191001    01.10.2019  MS          code added to post Gen Journal in case of issue

    PageType = Card;
    SourceTable = "PDC Issue";
    Caption = 'PDC Payment';
    //ApplicationArea = All;
    SourceTableView = WHERE(Posted = filter(false), Bounced = filter(false), Returned = filter(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Code)
                {

                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Vendor No."; "Vendor No.")
                {

                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        //Regal1.0
                        Payee := UPPERCASE(Name);
                    end;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }

                field(Address; Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = All;
                }
                field("Country Code"; "Country Code")
                {
                    ApplicationArea = All;
                }
                field(City; City)
                {
                    ApplicationArea = All;
                }
                field(Control1000000016; '')
                {
                    CaptionClass = Text19064271;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Bank; Bank)
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Bank Address"; "Bank Address")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bank Address 2"; "Bank Address 2")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bank Post Code"; "Bank Post Code")
                {
                    ApplicationArea = All;
                }
                field("Bank City"; "Bank City")
                {
                    ApplicationArea = All;
                }
                field("Bank Country Code"; "Bank Country Code")
                {
                    ApplicationArea = All;
                }
                field("Bank Branch No."; "Bank Branch No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bank Account No."; "Bank Account No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field(Control1000000030; '')
                {
                    CaptionClass = Text19004241;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Unapplied PDC"; "UnApplied PDC")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        IF "UnApplied PDC" THEN begin
                            UnAppliedEntry := FALSE;
                        end else begin
                            "Reference Type" := "Reference Type"::" ";
                            UnAppliedEntry := TRUE;
                        end;
                    end;
                }
                field("Reference Type"; "Reference Type")
                {
                    Enabled = UnAppliedEntry;
                    ApplicationArea = All;
                }
                field("Applies-to ID"; "Applies-to ID")
                {
                    Editable = UnAppliedEntry;
                    ApplicationArea = All;
                }

                field(Control1000000104; '')
                {
                    CaptionClass = Text19079450;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Bank Payment Type"; "Bank Payment Type")
                {

                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        //LT_Check
                        IF "Bank Payment Type" = "Bank Payment Type"::"Manual Check" THEN
                            CheckNoEditable := TRUE
                        ELSE
                            CheckNoEditable := FALSE;
                        //LT_Check
                    end;
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Cheque No."; "Cheque No.")
                {
                    Editable = CheckNoEditable;
                    ApplicationArea = All;
                }
                field(Payee; Payee)
                {
                    ApplicationArea = All;
                }
                field("Cheque Date"; "Cheque Date")
                {
                    ApplicationArea = All;
                }
                field("Deposit Date"; "Deposit Date")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    AutoFormatType = 1;
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Control1000000105; '')
                {
                    CaptionClass = Text19059481;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    AutoFormatType = 1;
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    Caption = 'Status';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Remarks; Remarks)
                {
                    Caption = 'Remarks';
                    ApplicationArea = All;
                }
                field(Confirmed; Confirmed)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Check Printed"; "Check Printed")
                {
                    Caption = 'Printed';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Cleared; Cleared)
                {
                    Caption = 'Cleared';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&PDCs")
            {
                Caption = '&PDCs';
                action("&Dimensions")
                {
                    Caption = '&Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        ShowDocDim();
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action(Confirm)
                {
                    Caption = 'Confirm';
                    ApplicationArea = All;
                    Image = Confirm;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        CompInfo: Record "Company Information";
                    begin
                        //APNT-1.0
                        CompInfo.GET;

                        IF Rec.Status = Rec.Status::Issued THEN
                            ERROR('You Cannot Confirm Issued PDC');

                        // Validation Before confirmation of PDC documents..-Start
                        if Rec."UnApplied PDC" then begin
                            Rec.TestField("Reference Type", "Reference Type"::" ");
                            Rec.TestField("Applies-to ID", '');
                            Rec.TestField("Bank Payment Type");
                            Rec.TestField("Payment Method Code");
                            Rec.TestField("Cheque No.");
                            Rec.TestField("Cheque Date");
                            Rec.TestField(Payee);
                        end else begin
                            if "Reference Type" = "Reference Type"::Invoice then
                                Rec.TestField("Applies-to ID");
                        end;
                        //End

                        IF UserSetup.GET(USERID) THEN BEGIN
                            IF UserSetup."Confirm Payment Jnls." = FALSE THEN
                                ERROR('You dont have permissions to Confirm PDC for printing Cheque');
                        END ELSE
                            ERROR('You dont have permissions to Confirm Payment Journals.');
                        IF CONFIRM('Do you want to confirm Payment Journal ?') THEN BEGIN
                            Confirmed := TRUE;
                            "Confirmed By" := USERID;
                            "Date Confirmed" := TODAY;
                            MODIFY;
                            MESSAGE('PDC for printing Cheque is successfully confirmed');
                        END;
                        //APNT-1.0
                    end;
                }
                action("Undo Confirm")
                {
                    Caption = 'Undo Confirm';
                    Image = Undo;
                    Promoted = true;
                    PromotedCategory = New;
                    ApplicationArea = All;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //APNT-1.0

                        IF Rec.Status = Rec.Status::Issued THEN
                            ERROR('You Cannot Undo Confirm Issued PDC');

                        IF UserSetup.GET(USERID) THEN BEGIN
                            IF UserSetup."Confirm Payment Jnls." = FALSE THEN
                                ERROR('You dont have permissions to Undo PDC for printing Cheque');
                        END ELSE
                            ERROR('You dont have permissions to Undo Confirm Payment Journals.');
                        IF CONFIRM('Do you want to undo PDC for printing Cheque?') THEN BEGIN
                            Confirmed := FALSE;
                            "Confirmed By" := '';
                            "Date Confirmed" := 0D;
                            MODIFY;
                        END;
                        //APNT-1.0
                    end;
                }
                action("&Apply Entries")
                {
                    Caption = '&Apply Entries';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F11';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        PDCIssue.COPY(Rec);

                        WITH PDCIssue DO BEGIN
                            IF "Reference Type" = "Reference Type"::Invoice THEN BEGIN
                                GetCurrency;
                                AccType := AccType::Vendor;
                                AccNo := "Vendor No.";
                                CASE AccType OF
                                    AccType::Vendor:
                                        BEGIN
                                            CLEAR(ApplyVendEntries);
                                            VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, Positive);
                                            VendLedgEntry.SETRANGE("Vendor No.", AccNo);
                                            VendLedgEntry.SETRANGE(Open, TRUE);
                                            VendLedgEntry.SETRANGE("Applies-to ID");
                                            IF "Applies-to ID" = '' THEN
                                                "Applies-to ID" := Code;
                                            IF "Applies-to ID" = '' THEN
                                                ERROR(Text000, FIELDCAPTION("Applies-to ID"));
                                            ApplyVendEntries.SetPDCLine(PDCIssue);
                                            ApplyVendEntries.SETRECORD(VendLedgEntry);
                                            ApplyVendEntries.SETTABLEVIEW(VendLedgEntry);
                                            ApplyVendEntries.LOOKUPMODE(TRUE);
                                            Ok := ApplyVendEntries.RUNMODAL = ACTION::LookupOK;
                                            CLEAR(ApplyVendEntries);
                                            IF NOT Ok THEN
                                                EXIT;

                                            VendLedgEntry.RESET;
                                            VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, Positive);
                                            VendLedgEntry.SETRANGE("Vendor No.", AccNo);
                                            VendLedgEntry.SETRANGE(Open, TRUE);
                                            VendLedgEntry.SETRANGE("Applies-to ID", Code);
                                            IF VendLedgEntry.FIND('-') THEN BEGIN
                                                CurrencyCode2 := VendLedgEntry."Currency Code";
                                                IF Amount = 0 THEN BEGIN
                                                    PDCAppliedAmt.RESET;
                                                    PDCAppliedAmt.SETRANGE("PDC No.", "Applies-to ID");
                                                    IF PDCAppliedAmt.FIND('-') THEN
                                                        PDCAppliedAmt.DELETEALL;

                                                    REPEAT
                                                        NewCheckAgainstApplnCurrency(CurrencyCode2, VendLedgEntry."Currency Code", AccType::Customer, TRUE);
                                                        VendLedgEntry.CALCFIELDS("Remaining Amount");
                                                        IF VendLedgEntry."Currency Code" <> '' THEN BEGIN
                                                            VendLedgEntry."Remaining Amount" := ROUND(VendLedgEntry."Remaining Amount", Currency."Amount Rounding Precision");
                                                            VendLedgEntry."Remaining Pmt. Disc. Possible" := ROUND(VendLedgEntry."Remaining Pmt. Disc. Possible", Currency."Amount Rounding Precision");
                                                            VendLedgEntry."Amount to Apply" := ROUND(VendLedgEntry."Amount to Apply", Currency."Amount Rounding Precision");
                                                        END
                                                        ELSE BEGIN
                                                            VendLedgEntry."Remaining Amount" := ROUND(VendLedgEntry."Remaining Amount");
                                                            VendLedgEntry."Remaining Pmt. Disc. Possible" := ROUND(VendLedgEntry."Remaining Pmt. Disc. Possible");
                                                            VendLedgEntry."Amount to Apply" := ROUND(VendLedgEntry."Amount to Apply");
                                                        END;
                                                        IF CheckCalcPmtDiscPDCIssueCust(Rec, VendLedgEntry, 0, FALSE) AND
                                                          (ABS(VendLedgEntry."Amount to Apply") >=
                                                          ABS(VendLedgEntry."Remaining Amount" - VendLedgEntry."Remaining Pmt. Disc. Possible"))
                                                        THEN
                                                            Amount := Amount - (VendLedgEntry."Amount to Apply" - VendLedgEntry."Remaining Pmt. Disc. Possible")
                                                        ELSE
                                                            Amount := Amount - VendLedgEntry."Amount to Apply";

                                                        GLSetup.GET;
                                                        PDCAppliedAmt.INIT;
                                                        PDCAppliedAmt."PDC No." := "Applies-to ID";
                                                        PDCAppliedAmt."Transaction Type" := PDCAppliedAmt."Transaction Type"::Purchase;
                                                        PDCAppliedAmt."Document Type" := PDCAppliedAmt."Document Type"::Invoice;
                                                        PDCAppliedAmt."No." := VendLedgEntry."Document No.";
                                                        PDCAppliedAmt."Currency Code" := "Currency Code";

                                                        IF "Currency Code" = GLSetup."LCY Code" THEN BEGIN
                                                            PDCAppliedAmt."Amount (LCY)" := ApplyVendEntries.CalcApplnAmounttoApply(VendLedgEntry."Amount to Apply");
                                                            PDCAppliedAmt.Amount := ROUND(VendLedgEntry."Amount to Apply", VendLedgEntry."Original Currency Factor");
                                                        END ELSE BEGIN
                                                            PDCAppliedAmt.Amount := ApplyVendEntries.CalcApplnAmounttoApply(VendLedgEntry."Amount to Apply");
                                                            PDCAppliedAmt."Amount (LCY)" := ApplyVendEntries.CalcApplnAmounttoApply(VendLedgEntry."Amount to Apply");
                                                            ;
                                                        END;
                                                        PDCAppliedAmt.INSERT;
                                                    UNTIL VendLedgEntry.NEXT = 0;
                                                    VALIDATE(Amount);
                                                END ELSE
                                                    REPEAT
                                                        NewCheckAgainstApplnCurrency(CurrencyCode2, VendLedgEntry."Currency Code", AccType::Customer, TRUE);
                                                    UNTIL VendLedgEntry.NEXT = 0;
                                                IF "Currency Code" <> CurrencyCode2 THEN
                                                    IF Amount = 0 THEN BEGIN
                                                        IF NOT
                                                           CONFIRM(
                                                             Text001 +
                                                             Text002, TRUE,
                                                             FIELDCAPTION("Currency Code"), TABLECAPTION, "Currency Code",
                                                             VendLedgEntry."Currency Code")
                                                        THEN
                                                            ERROR(Text003);
                                                        "Currency Code" := VendLedgEntry."Currency Code"
                                                    END ELSE
                                                        NewCheckAgainstApplnCurrency("Currency Code", VendLedgEntry."Currency Code", AccType::Customer, TRUE);
                                                "Applies-to Doc. No." := '';
                                            END ELSE BEGIN
                                                "Applies-to ID" := '';
                                                Amount := 0;
                                                CLEAR(ApplyVendEntries);
                                            END;
                                            MODIFY;
                                        END;
                                END;
                            END;
                        END;
                        Rec := PDCIssue;
                    end;
                }
                action("Print Check")
                {
                    Caption = 'Print Check';
                    Image = PrintCheck;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PDCIssue: Record "PDC Issue";
                    begin
                        TESTFIELD("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                        TESTFIELD("Vendor No.");
                        TESTFIELD(Bank);
                        //TESTFIELD("Cheque No.");
                        TESTFIELD("Cheque Date");
                        TESTFIELD(Amount);
                        TESTFIELD("Currency Code");
                        //TESTFIELD("Check Printed",TRUE);
                        TESTFIELD(Confirmed, TRUE);

                        PDCIssue.SETRANGE(Code, Code);
                        PDCCodeunit.PrintPDC(PDCIssue);
                    end;
                }
                action("Void Check")
                {
                    Caption = 'Void Check';
                    Image = VoidCheck;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF (Status = Status::Issued) THEN
                            FIELDERROR(Status);

                        PDCCodeunit.VoidPDC(Rec);
                        IF PDCIssue.GET(Code) THEN BEGIN
                            PDCIssue."Check Printed" := FALSE;
                            CLEAR(PDCIssue."Cheque No.");
                            PDCIssue.MODIFY;
                        END
                    end;
                }
                action("Print Lable")
                {
                    Caption = 'Print Lable';
                    Image = PrintCheck;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        TESTFIELD("Check Printed", TRUE);
                        RecVendLedgEntry.RESET;
                        //RecVendLedgEntry.SETRANGE(RecVendLedgEntry."Document Type",RecVendLedgEntry."Document Type"::Invoice);
                        RecVendLedgEntry.SETRANGE(RecVendLedgEntry."Applies-to ID", Code);
                        IF RecVendLedgEntry.FINDFIRST THEN BEGIN
                            TgCopies := RecVendLedgEntry.COUNT;
                        END;

                        //<LT> Commented the code - PDC Upgrade
                        /*  commented by PRO.MS
                        NameDataTypeSubtypeLength
                        Rep50064ReportReport50064
                        CLEAR(Rep50064);
                        
                        RecPDCIsuue.RESET;
                        RecPDCIsuue.SETRANGE(RecPDCIsuue.Code,Rec.Code);
                        IF RecPDCIsuue.FINDFIRST THEN BEGIN
                            Rep50064.InitialiseCopies(TgCopies);
                            Rep50064.SETTABLEVIEW(RecPDCIsuue);
                            Rep50064.RUNMODAL;
                        END;
                        */
                        //</LT>

                    end;
                }
                action("&Issue")
                {
                    Caption = '&Issue';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.TestField(Confirmed, true);
                        if Status <> Status::Issued then begin
                            TESTFIELD("Cheque No.");
                            IF "Bank Payment Type" = "Bank Payment Type"::"Computer Check" THEN
                                TESTFIELD("Check Printed", TRUE);
                            IF Status = Status::Issued THEN
                                EXIT;

                            IF NOT CONFIRM('Do you want to Issue PDC ?', false) THEN
                                exit;
                            IssuePDC(Rec);
                        end;
                    end;
                }
                action("Update Deposit Date")
                {
                    Caption = 'Update Deposit Date';
                    Image = ChangeDate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Dlg: Dialog;
                        DepositDate: Date;
                        DepositDateInput: Report "Input Date";
                    begin
                        TESTFIELD(Status, Status::Issued);
                        //APNT-1.1 -
                        /*
                        //Commented Old Code
                        Dlg.OPEN('Deposit Date : #1###########');
                        Dlg.INPUT(1,DepositDate);
                        */
                        CLEAR(DepositDateInput);
                        DepositDateInput.UseRequestPage := true;
                        DepositDateInput.RUNMODAL;
                        IF DepositDateInput.GetDepositDate <> 0D THEN
                            DepositDate := DepositDateInput.GetDepositDate;
                        //APNT-1.1 +

                        IF DepositDate < "Cheque Date" THEN
                            ERROR('%1 cannot be lesser then %2.', FIELDCAPTION("Deposit Date"), FIELDCAPTION("Cheque Date"));
                        "Deposit Date" := DepositDate;
                        MODIFY;

                    end;
                }
                action(Post)
                {
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF "Bank Payment Type" = "Bank Payment Type"::"Computer Check" THEN
                            TESTFIELD("Check Printed", TRUE);
                        TESTFIELD(Status, Status::Issued);
                        IF CONFIRM('Do you want to post PDC ' + Code + ' ?') THEN
                            PostPDC(Rec);
                    end;
                }
                action("<Action1000000069>")
                {
                    Caption = '&Bounced';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Status = Status::Bounced THEN
                            EXIT;
                        IF CONFIRM('Do you want to change PDC status to Bounced ?') THEN
                            BouncePDC(Rec);
                    end;
                }
                action("<Action1000000070>")
                {
                    Caption = '&Returned';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Status = Status::Returned THEN
                            EXIT;
                        IF CONFIRM('Do you want to change PDC status to Returned ?') THEN
                            ReturnPDC(Rec);
                    end;
                }
                separator(Separator1000000098)
                {

                }
                /* action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Image = CopyDocument;
                    RunObject = Page "Copy PDC";
                    RunPageLink = Code = FIELD(Code);
                    Visible = false;
                } */
                separator(Separator1000000107)
                {
                }
                separator(Separator1000000113)
                {
                }
                separator(Separator1000000115)
                {
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("PDC Voucher")
                {
                    Caption = 'PDC Voucher';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        recPDC.RESET;
                        recPDC.SETRANGE(Code, Code);
                        REPORT.RUN(50011, TRUE, FALSE, recPDC);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF "UnApplied PDC" THEN
            UnAppliedEntry := FALSE
        ELSE
            UnAppliedEntry := TRUE;

        //LT_Check
        IF "Bank Payment Type" = "Bank Payment Type"::"Manual Check" THEN
            CheckNoEditable := TRUE
        ELSE
            CheckNoEditable := FALSE;
        //LT_Check
    end;

    trigger OnOpenPage()
    begin
        IF "UnApplied PDC" THEN
            UnAppliedEntry := FALSE
        ELSE
            UnAppliedEntry := TRUE;

        //LT_Check
        IF "Bank Payment Type" = "Bank Payment Type"::"Manual Check" THEN
            CheckNoEditable := TRUE
        ELSE
            CheckNoEditable := FALSE;
        //LT_Check
    end;

    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        Currency: Record Currency;
        PDCAppliedAmt: Record "PDC Applied Amount";
        GLSetup: Record "General Ledger Setup";
        PurchaseInvHeader: Record "Purch. Inv. Header";
        PurchaseInvLine: Record "Purch. Inv. Line";
        PurchaseOrders1: Record "Purchase Header";
        PurchaseOrders: Record "Purchase Header";
        PDCIssue: Record "PDC Issue";
        PDCIssue2: Record "PDC Issue";
        GenJnlTemplate: Record "Gen. Journal Template";
        UserSetup: Record "User Setup";
        ApplyVendEntries: Page "Apply Vendor Ledger Entries";
        // ApplyOrderEntries: Page "Apply Purchase Orders";
        Text003: Label 'The %1 in the %2 will be changed from %3 to %4.\';
        Text004: Label 'Do you wish to continue?';
        Text005: Label 'The update has been interrupted to respect the warning.';
        Text006: Label 'Amount must be Negative';
        Text000: Label 'You must specify %1 or %2.';
        Text001: Label 'The %1 in the %2 will be changed from %3 to %4.\';
        Text002: Label 'Do you wish to continue?';
        Text007: Label 'All entries in one application must be in the same currency or one or more of the EMU currencies. ';
        Text008: Label 'You must specify %1.';
        DocPrint: Codeunit "Document-Print";

        PDCCodeunit: Codeunit "PDC Codeunit";
        CheckMgt: Codeunit CheckManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        FromCurrencyCode: Code[10];
        ToCurrencyCode: Code[10];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        Ok: Boolean;
        CurrencyCode2: Code[10];
        TempAmt: Decimal;
        InvAmt: Decimal;
        PDCApplAmount: Decimal;
        AccNo: Code[20];
        InterBULineNo: Integer;
        Window: Dialog;
        recPDC: Record "PDC Issue";
        DateBounced: Date;
        DateReturned: Date;
        InputErrorTxt: Label 'There is an error in the input';
        Text19064271: Label 'Bank Details';
        Text19004241: Label 'Application';
        Text19079450: Label 'Cheque Details';
        Text19059481: Label 'Status';
        RecPDCIsuue: Record "PDC Issue";
        TgCopies: Integer;
        RecVendLedgEntry: Record "Vendor Ledger Entry";
        UnAppliedEntry: Boolean;
        CheckNoEditable: Boolean;
        CompanyInfo: Record "Company Information";

    procedure CheckAgainstApplnCurrency(ApplnCurrencyCode: Code[10]; CompareCurrencyCode: Code[10]; AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset"; Message: Boolean): Boolean
    var
        Currency: Record Currency;
        Currency2: Record Currency;
        SalesSetup: Record "Sales & Receivables Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        CurrencyAppln: Option No,EMU,All;
    begin
        IF (ApplnCurrencyCode = CompareCurrencyCode) THEN
            EXIT(TRUE);

        CASE AccType OF
            AccType::Customer:
                BEGIN
                    SalesSetup.GET;
                    CurrencyAppln := SalesSetup."Appln. between Currencies";
                    CASE CurrencyAppln OF
                        CurrencyAppln::No:
                            BEGIN
                                IF ApplnCurrencyCode <> CompareCurrencyCode THEN
                                    IF Message THEN
                                        ERROR(Text006)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                        CurrencyAppln::EMU:
                            BEGIN
                                GLSetup.GET;
                                IF NOT Currency.GET(ApplnCurrencyCode) THEN
                                    Currency."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency2.GET(CompareCurrencyCode) THEN
                                    Currency2."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency."EMU Currency" OR NOT Currency2."EMU Currency" THEN
                                    IF Message THEN
                                        ERROR(Text007)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                    END;
                END;
            AccType::Vendor:
                BEGIN
                    PurchSetup.GET;
                    CurrencyAppln := PurchSetup."Appln. between Currencies";
                    CASE CurrencyAppln OF
                        CurrencyAppln::No:
                            BEGIN
                                IF ApplnCurrencyCode <> CompareCurrencyCode THEN
                                    IF Message THEN
                                        ERROR(Text006)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                        CurrencyAppln::EMU:
                            BEGIN
                                GLSetup.GET;
                                IF NOT Currency.GET(ApplnCurrencyCode) THEN
                                    Currency."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency2.GET(CompareCurrencyCode) THEN
                                    Currency2."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency."EMU Currency" OR NOT Currency2."EMU Currency" THEN
                                    IF Message THEN
                                        ERROR(Text007)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                    END;
                END;
        END;
        EXIT(TRUE);
    end;

    procedure CheckCalcPmtDiscGenJnlVend(GenJnlLine: Record "Gen. Journal Line"; OldVendLedgEntry2: Record "Vendor Ledger Entry"; ApplnRoundingPrecision: Decimal; CheckAmount: Boolean): Boolean
    var
        NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        OldCVLedgEntryBuf2: Record "CV Ledger Entry Buffer";
    begin
        NewCVLedgEntryBuf."Document Type" := NewCVLedgEntryBuf."Document Type"::Invoice;
        NewCVLedgEntryBuf."Posting Date" := "Cheque Date";
        NewCVLedgEntryBuf."Remaining Amount" := Amount;
        //<LT> Commented the code - PDC Upgrade
        //GenJnlPostLine.TransferVendLedgEntry(OldCVLedgEntryBuf2,OldVendLedgEntry2,TRUE);
        //GenJnlPostLine.i
        OldVendLedgEntry2.CopyFromCVLedgEntryBuffer(OldCVLedgEntryBuf2);
        //EXIT(GenJnlPostLine.CheckCalcPmtDisc(NewCVLedgEntryBuf,OldCVLedgEntryBuf2,ApplnRoundingPrecision,FALSE,CheckAmount));
        //</LT>
    end;

    procedure NewCheckAgainstApplnCurrency(ApplnCurrencyCode: Code[10]; CompareCurrencyCode: Code[10]; AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset"; Message: Boolean): Boolean
    var
        Currency: Record Currency;
        Currency2: Record Currency;
        SalesSetup: Record "Sales & Receivables Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        CurrencyAppln: Option No,EMU,All;
    begin
        IF (ApplnCurrencyCode = CompareCurrencyCode) THEN
            EXIT(TRUE);

        CASE AccType OF
            AccType::Customer:
                BEGIN
                    SalesSetup.GET;
                    CurrencyAppln := SalesSetup."Appln. between Currencies";
                    CASE CurrencyAppln OF
                        CurrencyAppln::No:
                            BEGIN
                                IF ApplnCurrencyCode <> CompareCurrencyCode THEN
                                    IF Message THEN
                                        ERROR(Text006)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                        CurrencyAppln::EMU:
                            BEGIN
                                GLSetup.GET;
                                IF NOT Currency.GET(ApplnCurrencyCode) THEN
                                    Currency."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency2.GET(CompareCurrencyCode) THEN
                                    Currency2."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency."EMU Currency" OR NOT Currency2."EMU Currency" THEN
                                    IF Message THEN
                                        ERROR(Text007)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                    END;
                END;
            AccType::Vendor:
                BEGIN
                    PurchSetup.GET;
                    CurrencyAppln := PurchSetup."Appln. between Currencies";
                    CASE CurrencyAppln OF
                        CurrencyAppln::No:
                            BEGIN
                                IF ApplnCurrencyCode <> CompareCurrencyCode THEN
                                    IF Message THEN
                                        ERROR(Text006)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                        CurrencyAppln::EMU:
                            BEGIN
                                GLSetup.GET;
                                IF NOT Currency.GET(ApplnCurrencyCode) THEN
                                    Currency."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency2.GET(CompareCurrencyCode) THEN
                                    Currency2."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency."EMU Currency" OR NOT Currency2."EMU Currency" THEN
                                    IF Message THEN
                                        ERROR(Text007)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                    END;
                END;
        END;

        EXIT(TRUE);
    end;

    procedure GetCurrency()
    begin
        WITH PDCIssue DO BEGIN
            IF "Currency Code" = '' THEN
                Currency.InitRoundingPrecision
            ELSE BEGIN
                Currency.GET("Currency Code");
                Currency.TESTFIELD("Amount Rounding Precision");
            END;
        END;
    end;

    procedure CheckCalcPmtDiscPDCIssueCust(PDCIssue: Record "PDC Issue"; OldVendLedgEntry2: Record "Vendor Ledger Entry"; ApplnRoundingPrecision: Decimal; CheckAmount: Boolean): Boolean
    var
        NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        OldCVLedgEntryBuf2: Record "CV Ledger Entry Buffer";
    begin
        NewCVLedgEntryBuf."Document Type" := NewCVLedgEntryBuf."Document Type"::Payment;
        NewCVLedgEntryBuf."Posting Date" := PDCIssue."Document Date";
        NewCVLedgEntryBuf."Remaining Amount" := PDCIssue.Amount;
        //<LT> Commented the code - PDC Upgrade
        //GenJnlPostLine.TransferVendLedgEntry(OldCVLedgEntryBuf2,OldVendLedgEntry2,TRUE);
        OldVendLedgEntry2.CopyFromCVLedgEntryBuffer(OldCVLedgEntryBuf2);
        // EXIT(
        //  GenJnlPostLine.CheckCalcPmtDisc(
        //    NewCVLedgEntryBuf,OldCVLedgEntryBuf2,ApplnRoundingPrecision,FALSE,CheckAmount));
        //</LT>
    end;

    procedure SetUpNewLine(var GenJnlLineRec: Record "Gen. Journal Line"; Balance: Decimal; BottomLine: Boolean)
    begin
        WITH GenJnlLineRec DO BEGIN
            GenJnlTemplate.GET("Journal Template Name");
            GenJnlBatch.GET("Journal Template Name", "Journal Batch Name");
            IF GenJnlBatch."No. Series" <> '' THEN BEGIN
                CLEAR(NoSeriesMgt);
                "Document No." := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", Rec."Document Date", FALSE);
            END;
            "Source Code" := GenJnlTemplate."Source Code";
            "Reason Code" := GenJnlBatch."Reason Code";
            "Posting No. Series" := GenJnlBatch."Posting No. Series";
            Description := '';
        END;
    end;

    procedure IssuePDC(var PDCIssue: Record "PDC Issue")
    var
        Vendor: Record Vendor;
        VendorPostingGrp: Record "Vendor Posting Group";
        GenJournalPost: Page "General Journal";
        GenJournalTempl: Record "Gen. Journal Template";
        VendorLedEntry: Record "Vendor Ledger Entry";
    begin
        WITH PDCIssue DO BEGIN
            TESTFIELD(Payee);
            TESTFIELD(Bank);


            GLSetup.GET();
            GLSetup.TESTFIELD("PDC Issue Template");
            GLSetup.TESTFIELD("PDC Issue Batch");
            Vendor.GET("Vendor No.");
            Vendor.TESTFIELD("Vendor Posting Group");
            VendorPostingGrp.GET(Vendor."Vendor Posting Group");
            VendorPostingGrp.TESTFIELD("PDC Issue Account");
            CheckforDimensions(PDCIssue);

            Window.OPEN('Issuing PDC  #1#######################\' +
                        'Status       #2#######################\' +
                        'Document No. #3#######################');
            Window.UPDATE(1, Code);

            IF "Reference Type" = "Reference Type"::Invoice THEN BEGIN
                PDCAppliedAmt.RESET;
                PDCAppliedAmt.SETRANGE("Transaction Type", PDCAppliedAmt."Transaction Type"::Purchase);
                PDCAppliedAmt.SETRANGE("Document Type", PDCAppliedAmt."Document Type"::Invoice);
                PDCAppliedAmt.SETRANGE("PDC No.", Code);
                PDCAppliedAmt.SETRANGE(Amount, 0);
                PDCAppliedAmt.DELETEALL;

                Window.UPDATE(2, 'Checking applied entries');          //Changed Caption from Cehcking to Checking
                PDCAppliedAmt.RESET;
                PDCAppliedAmt.SETRANGE("Transaction Type", PDCAppliedAmt."Transaction Type"::Purchase);
                PDCAppliedAmt.SETRANGE("Document Type", PDCAppliedAmt."Document Type"::Invoice);
                PDCAppliedAmt.SETRANGE("PDC No.", Code);
                PDCAppliedAmt.SETFILTER(Amount, '<>%1', 0);
                IF PDCAppliedAmt.FIND('-') THEN
                    REPEAT
                        VendLedgEntry.RESET;
                        VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::Invoice);
                        VendLedgEntry.SETFILTER("Document No.", PDCAppliedAmt."No.");
                        IF VendLedgEntry.FIND('-') THEN BEGIN
                            Window.UPDATE(3, VendLedgEntry."Document No.");
                            VendLedgEntry."Applies-to ID" := PDCAppliedAmt."PDC No.";
                            VendLedgEntry.MODIFY;
                        END;
                    UNTIL PDCAppliedAmt.NEXT = 0;

                GenJnlLine.RESET;
                GenJnlLine.SETRANGE("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.SETRANGE("Journal Batch Name", GLSetup."PDC Issue Batch");
                IF GenJnlLine.FIND('-') THEN
                    GenJnlLine.DELETEALL(TRUE);

                Window.UPDATE(2, 'Inserting Journals');
                IF GenJournalTempl.GET(GLSetup."PDC Issue Template") THEN;
                GenJnlLine.INIT;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine."Line No." := 10000;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := Code;
                GenJnlLine.VALIDATE("Posting Date", "Document Date");
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Vendor);
                GenJnlLine.VALIDATE("Account No.", "Vendor No.");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, Amount);
                GenJnlLine.VALIDATE("Applies-to ID", Code);
                GenJnlLine.Narration := Remarks;
                GenJnlLine."Source Code" := GenJournalTempl."Source Code";
                //GenJnlLine."Cheque No." := "Cheque No.";
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                //APNT-1.2
                // GenJnlLine."Cheque Date" := "Cheque Date";
                GenJnlLine."Check Date" := "Cheque Date";
                //APNT-1.2
                //<LT> Commented the code - PDC Upgrade
                //GenJnlLine."Paid to / Received from" := Payee; //RT-0112
                //GenJnlLine."Received From" := Payee;
                //GenJnlLine.Remark := Remarks;

                //</LT>
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                GenJnlLine.MODIFY;

                GenJnlLine.INIT;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine."Line No." := 20000;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := Code;
                GenJnlLine.VALIDATE("Posting Date", "Document Date");
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                GenJnlLine.VALIDATE("Account No.", VendorPostingGrp."PDC Issue Account");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, -Amount);
                GenJnlLine.Narration := Remarks;
                GenJnlLine."Source Code" := GenJournalTempl."Source Code";
                // GenJnlLine."Cheque No." := "Cheque No.";
                //APNT-1.2
                // GenJnlLine."Cheque Date" := "Cheque Date";
                //APNT-1.2
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine."Check Date" := "Cheque Date";
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Deposit Bank Dim1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Deposit Bank Dim2 Code");
                GenJnlLine.MODIFY;
                //COMMIT;
                Window.UPDATE(2, 'Posting Journals');
                //>>MS.20191001 -code  added
                CLEAR(GenJnlPostBatch);
                GenJnlPostBatch.RUN(GenJnlLine);
                //<<MS.20191001 -code  added

                PDCAppliedAmt.RESET;
                PDCAppliedAmt.SETFILTER("PDC No.", Code);
                IF PDCAppliedAmt.FIND('-') THEN
                    REPEAT
                        PDCAppliedAmt.Posted := TRUE;
                        PDCAppliedAmt.MODIFY;
                    UNTIL PDCAppliedAmt.NEXT = 0;

            END;

            IF "Reference Type" = "Reference Type"::" " THEN BEGIN
                GenJnlLine.RESET;
                GenJnlLine.SETFILTER(GenJnlLine."Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.SETFILTER(GenJnlLine."Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine.DELETEALL;

                Window.UPDATE(2, 'Inserting Journals');
                IF GenJournalTempl.GET(GLSetup."PDC Issue Template") THEN;
                GenJnlLine.INIT;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine."Line No." := 10000;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := Code;
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Posting Date", "Document Date");
                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Vendor);
                GenJnlLine.VALIDATE("Account No.", "Vendor No.");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, Amount);
                GenJnlLine.Narration := Remarks;
                GenJnlLine."Source Code" := GenJournalTempl."Source Code";
                // GenJnlLine."Cheque No." := "Cheque No.";
                //APNT-1.2
                // GenJnlLine."Cheque Date" := "Cheque Date";
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine."Check Date" := "Cheque Date";
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                //</LT>
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                GenJnlLine.MODIFY;

                GenJnlLine.INIT;
                IF GenJournalTempl.GET(GLSetup."PDC Issue Template") THEN;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine."Line No." := 20000;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := Code;
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Posting Date", "Document Date");
                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                GenJnlLine.VALIDATE("Account No.", VendorPostingGrp."PDC Issue Account");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, -Amount);
                GenJnlLine.Narration := Remarks;
                GenJnlLine."Source Code" := GenJournalTempl."Source Code";
                // GenJnlLine."Cheque No." := "Cheque No.";
                //APNT-1.2
                // GenJnlLine."Cheque Date" := "Cheque Date";
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine."Check Date" := "Cheque Date";
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                //APNT-1.2
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Deposit Bank Dim1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Deposit Bank Dim2 Code");
                GenJnlLine.MODIFY;
                Window.UPDATE(2, 'Posting Journals');
                //>>MS.20191001 -code  added
                CLEAR(GenJnlPostBatch);
                GenJnlPostBatch.RUN(GenJnlLine);
                //<<MS.20191001 -code  added
            END;
            Window.CLOSE;
            Rec.VALIDATE(Status, Status::Issued);
            MODIFY;
        END;
    end;

    procedure CheckforDimensions(PDCIssue: Record "PDC Issue")
    var
        DefaultDim: Record "Default Dimension";
    begin
        WITH PDCIssue DO BEGIN
            GLSetup.GET;
            DefaultDim.RESET;
            DefaultDim.SETRANGE("Table ID", DATABASE::"G/L Account");
            DefaultDim.SETRANGE("No.", '');
            DefaultDim.SETRANGE("Dimension Code", GLSetup."Shortcut Dimension 1 Code");
            DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
            IF DefaultDim.FIND('-') THEN BEGIN
                TESTFIELD("Shortcut Dimension 1 Code");
                TESTFIELD("Deposit Bank Dim1 Code");
            END;
            DefaultDim.RESET;
            DefaultDim.SETRANGE("Table ID", DATABASE::"G/L Account");
            DefaultDim.SETRANGE("No.", '');
            DefaultDim.SETRANGE("Dimension Code", GLSetup."Shortcut Dimension 2 Code");
            DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
            IF DefaultDim.FIND('-') THEN BEGIN
                TESTFIELD("Shortcut Dimension 2 Code");
                TESTFIELD("Deposit Bank Dim2 Code");
            END;
            DefaultDim.RESET;
            DefaultDim.SETRANGE("Table ID", DATABASE::"G/L Account");
            DefaultDim.SETRANGE("No.", '');
            DefaultDim.SETRANGE("Dimension Code", GLSetup."Shortcut Dimension 3 Code");
            DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
            IF DefaultDim.FIND('-') THEN BEGIN
                TESTFIELD("Shortcut Dimension 3 Code");
                TESTFIELD("Deposit Bank Dim3 Code");
            END;
            DefaultDim.RESET;
            DefaultDim.SETRANGE("Table ID", DATABASE::"G/L Account");
            DefaultDim.SETRANGE("No.", '');
            DefaultDim.SETRANGE("Dimension Code", GLSetup."Shortcut Dimension 4 Code");
            DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
            IF DefaultDim.FIND('-') THEN BEGIN
                TESTFIELD("Shortcut Dimension 4 Code");
                TESTFIELD("Deposit Bank Dim4 Code");
            END;
            DefaultDim.RESET;
            DefaultDim.SETRANGE("Table ID", DATABASE::"G/L Account");
            DefaultDim.SETRANGE("No.", '');
            DefaultDim.SETRANGE("Dimension Code", GLSetup."Shortcut Dimension 5 Code");
            DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
            IF DefaultDim.FIND('-') THEN BEGIN
                TESTFIELD("Shortcut Dimension 5 Code");
                TESTFIELD("Deposit Bank Dim5 Code");
            END;
            DefaultDim.RESET;
            DefaultDim.SETRANGE("Table ID", DATABASE::"G/L Account");
            DefaultDim.SETRANGE("No.", '');
            DefaultDim.SETRANGE("Dimension Code", GLSetup."Shortcut Dimension 6 Code");
            DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
            IF DefaultDim.FIND('-') THEN BEGIN
                TESTFIELD("Shortcut Dimension 6 Code");
                TESTFIELD("Deposit Bank Dim6 Code");
            END;
            DefaultDim.RESET;
            DefaultDim.SETRANGE("Table ID", DATABASE::"G/L Account");
            DefaultDim.SETRANGE("No.", '');
            DefaultDim.SETRANGE("Dimension Code", GLSetup."Shortcut Dimension 7 Code");
            DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
            IF DefaultDim.FIND('-') THEN BEGIN
                TESTFIELD("Shortcut Dimension 7 Code");
                TESTFIELD("Deposit Bank Dim7 Code");
            END;
            DefaultDim.RESET;
            DefaultDim.SETRANGE("Table ID", DATABASE::"G/L Account");
            DefaultDim.SETRANGE("No.", '');
            DefaultDim.SETRANGE("Dimension Code", GLSetup."Shortcut Dimension 8 Code");
            DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
            IF DefaultDim.FIND('-') THEN BEGIN
                TESTFIELD("Shortcut Dimension 8 Code");
                TESTFIELD("Deposit Bank Dim8 Code");
            END;
        END;
    end;

    procedure PostPDC(var PDCIssue: Record "PDC Issue")
    var
        Vendor: Record Vendor;
        VendorPostingGrp: Record "Vendor Posting Group";
        GenJournalTempl: Record "Gen. Journal Template";
    begin
        WITH PDCIssue DO BEGIN
            TESTFIELD(Status, Status::Issued);
            TESTFIELD(Bank);
            IF "Deposit Date" = 0D THEN
                ERROR('Please enter Deposit Date using Functions, Update Deposit Date.');

            GLSetup.GET();
            GLSetup.TESTFIELD("PDC Issue Template");
            GLSetup.TESTFIELD("PDC Issue Batch");
            Vendor.GET("Vendor No.");
            Vendor.TESTFIELD("Vendor Posting Group");
            VendorPostingGrp.GET(Vendor."Vendor Posting Group");
            VendorPostingGrp.TESTFIELD("PDC Issue Account");
            CheckforDimensions(PDCIssue);

            Window.OPEN('Issuing PDC  #1#######################\' +
                        'Status       #2#######################');
            Window.UPDATE(1, Code);

            IF "Reference Type" = "Reference Type"::Invoice THEN BEGIN
                Window.UPDATE(2, 'Inserting Journals');
                GenJnlLine.RESET;
                GenJnlLine.SETFILTER("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.SETFILTER("Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine.DELETEALL(TRUE);

                GenJnlLine.INIT;
                IF GenJournalTempl.GET(GLSetup."PDC Issue Template") THEN;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine."Line No." += 10000;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := Code;
                GenJnlLine.VALIDATE("Posting Date", "Deposit Date");
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                GenJnlLine.VALIDATE("Account No.", VendorPostingGrp."PDC Issue Account");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, Amount);
                GenJnlLine.Narration := Remarks;
                GenJnlLine."Source Code" := GenJournalTempl."Source Code";
                // GenJnlLine."Cheque No." := "Cheque No.";
                //APNT-1.2
                //GenJnlLine."Cheque Date" := "Cheque Date";
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine."Check Date" := "Cheque Date";
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                //APNT-1.2
                IF "Deposit Bank Dim1 Code" <> '' THEN
                    GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Deposit Bank Dim1 Code");
                //IF "Deposit Bank Dim2 Code" <> '' THEN
                //GenJnlLine.VALIDATE("Shortcut Dimension 2 Code","Deposit Bank Dim2 Code");
                GenJnlLine.MODIFY;

                GenJnlLine.INIT;
                IF GenJournalTempl.GET(GLSetup."PDC Issue Template") THEN;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine."Line No." += 10000;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := Code;
                GenJnlLine.VALIDATE("Posting Date", "Deposit Date");
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"Bank Account");
                GenJnlLine.VALIDATE("Account No.", Bank);
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, -Amount);
                GenJnlLine.Narration := Remarks;
                GenJnlLine."Source Code" := GenJournalTempl."Source Code";
                // GenJnlLine."Cheque No." := "Cheque No.";
                //APNT-1.2
                /// GenJnlLine."Cheque Date" := "Cheque Date";
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                GenJnlLine."Check Date" := "Cheque Date";
                //APNT-1.2
                //<LT> Commented the code - PDC Upgrade
                IF "Deposit Bank Dim1 Code" <> '' THEN
                    GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Deposit Bank Dim1 Code");
                //IF "Deposit Bank Dim2 Code" <>'' THEN
                //GenJnlLine.VALIDATE("Shortcut Dimension 2 Code","Deposit Bank Dim2 Code");
                GenJnlLine.MODIFY;
                Window.UPDATE(2, 'Posting Journals');
                CLEAR(GenJnlPostBatch);
                GenJnlPostBatch.RUN(GenJnlLine);
                CLEAR(GenJnlPostBatch); //APNT-LCPDC1.1
                "Posting Date" := "Document Date";
                Posted := TRUE;
                Cleared := TRUE;
                "Date Cleared" := TODAY;
                MODIFY;
            END;

            IF "Reference Type" = "Reference Type"::" " THEN BEGIN
                GenJnlLine.RESET;
                GenJnlLine.SETFILTER(GenJnlLine."Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.SETFILTER(GenJnlLine."Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine.DELETEALL(TRUE);

                Window.UPDATE(2, 'Inserting Journals');
                GenJnlLine.INIT;
                IF GenJournalTempl.GET(GLSetup."PDC Issue Template") THEN;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine."Line No." += 10000;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := Code;
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Posting Date", "Deposit Date");
                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                GenJnlLine.VALIDATE("Account No.", VendorPostingGrp."PDC Issue Account");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, Amount);
                GenJnlLine.Narration := Remarks;
                GenJnlLine."Source Code" := GenJournalTempl."Source Code";
                // GenJnlLine."Cheque No." := "Cheque No.";
                //APNT-1.2
                //  GenJnlLine."Cheque Date" := "Cheque Date";
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine."Check Date" := "Cheque Date";
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                //APNT-1.2
                //<LT> Commented the code - PDC Upgrade
                //GenJnlLine."Paid to / Received from" := Payee; //RT-0112
                IF "Deposit Bank Dim1 Code" <> '' THEN
                    GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Deposit Bank Dim1 Code");
                IF "Deposit Bank Dim2 Code" <> '' THEN
                    GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Deposit Bank Dim2 Code");
                GenJnlLine.MODIFY;

                GenJnlLine.INIT;
                IF GenJournalTempl.GET(GLSetup."PDC Issue Template") THEN;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine."Line No." += 10000;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := Code;
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Posting Date", "Deposit Date");
                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"Bank Account");
                GenJnlLine.VALIDATE("Account No.", Bank);
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, -Amount);
                GenJnlLine.Narration := Remarks;
                GenJnlLine."Source Code" := GenJournalTempl."Source Code";
                // GenJnlLine."Cheque No." := "Cheque No.";
                //APNT-1.2
                // GenJnlLine."Cheque Date" := "Cheque Date";
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine."Check Date" := "Cheque Date";
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                //APNT-1.2
                //<LT> Commented the code - PDC Upgrade
                //GenJnlLine."Paid to / Received from" := Payee; //RT-0112
                IF "Deposit Bank Dim1 Code" <> '' THEN
                    GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Deposit Bank Dim1 Code");
                IF "Deposit Bank Dim2 Code" <> '' THEN
                    GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Deposit Bank Dim2 Code");
                GenJnlLine.MODIFY;
                Window.UPDATE(2, 'Posting Journals');
                CLEAR(GenJnlPostBatch);
                GenJnlPostBatch.RUN(GenJnlLine);
                CLEAR(GenJnlPostBatch); //APNT-LCPDC1.1
                "Posting Date" := WORKDATE;
                Posted := TRUE;
                Cleared := TRUE;
                "Date Cleared" := TODAY;
                MODIFY;
            END;
            Window.CLOSE;
        END;
    end;

    procedure BouncePDC(var PDCIssue: Record "PDC Issue")
    var
        Vendor: Record Vendor;
        VendorPostingGrp: Record "Vendor Posting Group";
        CheckLedgEntry: Record "Check Ledger Entry";
        BounceDateInput: Report "Input Date";
        GenJournalTempl: Record "Gen. Journal Template";
    begin
        WITH PDCIssue DO BEGIN
            //APNT-DUR1.3 -
            /*
            //Commented Old Code
            CLEAR(DateBounced);
            Window.OPEN('Bounced Date : #1###########');
            Window.INPUT(1,DateBounced);
            */
            CLEAR(DateBounced);
            CLEAR(BounceDateInput);
            BounceDateInput.RUNMODAL;
            IF BounceDateInput.GetDepositDate <> 0D THEN
                DateBounced := BounceDateInput.GetDepositDate;
            //APNT-DUR1.3 +

            IF DateBounced < "Document Date" THEN BEGIN
                //Window.CLOSE;
                ERROR('Bounced Date cannot be lesser then %1.', FIELDCAPTION("Document Date"));
            END;

            IF DateBounced = 0D THEN
                EXIT;


            TESTFIELD(Bank);
            GLSetup.GET();
            GLSetup.TESTFIELD("PDC Issue Template");
            GLSetup.TESTFIELD("PDC Issue Batch");
            Vendor.GET("Vendor No.");
            Vendor.TESTFIELD("Vendor Posting Group");
            VendorPostingGrp.GET(Vendor."Vendor Posting Group");
            VendorPostingGrp.TESTFIELD("PDC Issue Account");
            CheckforDimensions(PDCIssue);

            Window.OPEN('Issuing PDC  #1#######################\' +
                        'Status       #2#######################\' +
                        'Document No. #3#######################');
            Window.UPDATE(1, Code);

            IF "Reference Type" = "Reference Type"::Invoice THEN BEGIN
                GenJnlLine.RESET;
                GenJnlLine.SETFILTER("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.SETFILTER("Journal Batch Name", GLSetup."PDC Issue Batch");
                IF GenJnlLine.FIND('-') THEN
                    GenJnlLine.DELETEALL(TRUE);

                Window.UPDATE(2, 'Inserting Journals');
                GenJnlLine.INIT;
                IF GenJournalTempl.GET(GLSetup."PDC Issue Template") THEN;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine."Line No." := 10000;
                GenJnlLine."Document No." := Code;
                GenJnlLine.VALIDATE("Posting Date", DateBounced);
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Vendor);
                GenJnlLine.VALIDATE("Account No.", "Vendor No.");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, -Amount);
                GenJnlLine.Description := 'Bounced';
                GenJnlLine."Source Code" := GenJournalTempl."Source Code";
                //GenJnlLine."Cheque No." := "Cheque No.";
                //APNT-1.2
                //GenJnlLine."Cheque Date" := "Cheque Date";
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine."Check Date" := "Cheque Date";
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                //APNT-1.2
                //<LT> Commented the code - PDC Upgrade
                //GenJnlLine."Paid to / Received from" := Payee; //RT-0112
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                GenJnlLine.MODIFY;

                GenJnlLine.INIT;
                IF GenJournalTempl.GET(GLSetup."PDC Issue Template") THEN;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine."Line No." := 20000;
                GenJnlLine."Document No." := Code;
                GenJnlLine.VALIDATE("Posting Date", DateBounced);
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                GenJnlLine.VALIDATE("Account No.", VendorPostingGrp."PDC Issue Account");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, Amount);
                GenJnlLine.Description := 'Bounced';
                GenJnlLine."Source Code" := GenJournalTempl."Source Code";
                //GenJnlLine."Cheque No." := "Cheque No.";
                //APNT-1.2
                //GenJnlLine."Cheque Date" := "Cheque Date";
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine."Check Date" := "Cheque Date";
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                //APNT-1.2
                //<LT> Commented the code - PDC Upgrade
                //GenJnlLine."Paid to / Received from" := Payee; //RT-0112
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Deposit Bank Dim1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Deposit Bank Dim2 Code");
                GenJnlLine.MODIFY;
                Window.UPDATE(2, 'Posting Journals');
                CLEAR(GenJnlPostBatch);
                GenJnlPostBatch.RUN(GenJnlLine);
                CLEAR(GenJnlPostBatch); //APNT-LCPDC1.1
                PDCAppliedAmt.RESET;
                PDCAppliedAmt.SETFILTER("PDC No.", Code);
                IF PDCAppliedAmt.FIND('-') THEN
                    REPEAT
                        PDCAppliedAmt.Posted := FALSE;
                        PDCAppliedAmt.MODIFY;
                    UNTIL PDCAppliedAmt.NEXT = 0;
            END;

            IF "Reference Type" = "Reference Type"::" " THEN BEGIN
                GenJnlLine.RESET;
                GenJnlLine.SETFILTER(GenJnlLine."Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.SETFILTER(GenJnlLine."Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine.DELETEALL(TRUE);

                Window.UPDATE(2, 'Inserting Journals');
                GenJnlLine.INIT;
                IF GenJournalTempl.GET(GLSetup."PDC Issue Template") THEN;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine."Line No." := 10000;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := Code;
                GenJnlLine.VALIDATE("Posting Date", DateBounced);
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Vendor);
                GenJnlLine.VALIDATE("Account No.", "Vendor No.");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, Amount);
                GenJnlLine.Description := 'Bounced';
                GenJnlLine."Source Code" := GenJournalTempl."Source Code";
                // GenJnlLine."Cheque No." := "Cheque No.";
                //APNT-1.2
                // GenJnlLine."Cheque Date" := "Cheque Date";
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine."Check Date" := "Cheque Date";
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                //APNT-1.2
                //<LT> Commented the code - PDC Upgrade
                //GenJnlLine."Paid to / Received from" := Payee; //RT-0112
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                GenJnlLine.MODIFY;

                GenJnlLine.INIT;
                IF GenJournalTempl.GET(GLSetup."PDC Issue Template") THEN;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine."Line No." := 20000;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := Code;
                GenJnlLine.VALIDATE("Posting Date", DateBounced);
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                GenJnlLine.VALIDATE("Account No.", VendorPostingGrp."PDC Issue Account");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, -Amount);
                GenJnlLine.Description := 'Bounced';
                GenJnlLine."Source Code" := GenJournalTempl."Source Code";
                //  GenJnlLine."Cheque No." := "Cheque No.";
                //APNT-1.2
                //   GenJnlLine."Cheque Date" := "Cheque Date";
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine."Check Date" := "Cheque Date";
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                //APNT-1.2
                //<LT> Commented the code - PDC Upgrade
                //GenJnlLine."Paid to / Received from" := Payee; //RT-0112
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Deposit Bank Dim1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Deposit Bank Dim2 Code");
                GenJnlLine.MODIFY;
                Window.UPDATE(2, 'Posting Journals');
                CLEAR(GenJnlPostBatch);
                GenJnlPostBatch.RUN(GenJnlLine);
                CLEAR(GenJnlPostBatch); //APNT-LCPDC1.1
            END;
            CheckLedgEntry.RESET;
            CheckLedgEntry.SETCURRENTKEY("Document No.", "Posting Date");
            CheckLedgEntry.SETRANGE("Document No.", Code);
            IF CheckLedgEntry.FIND('-') THEN
                REPEAT
                    CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::Voided;
                    CheckLedgEntry.MODIFY;
                UNTIL CheckLedgEntry.NEXT = 0;
            Window.CLOSE;
            VALIDATE(Status, Status::Bounced);
            MODIFY;

        END;

    end;

    procedure ReturnPDC(var PDCIssue: Record "PDC Issue")
    var
        Vendor: Record Vendor;
        VendorPostingGrp: Record "Vendor Posting Group";
        CheckLedgEntry: Record "Check Ledger Entry";
        ReturnedDateInput: Report "Input Date";
        GenJournalTempl: Record "Gen. Journal Template";
    begin
        WITH PDCIssue DO BEGIN
            //APNT-DUR1.3 +
            /*
            //Commented Old
            CLEAR(DateReturned);
            Window.OPEN('Returned Date : #1###########');
            Window.INPUT(1,DateReturned);
            */
            CLEAR(DateReturned);
            CLEAR(ReturnedDateInput);
            ReturnedDateInput.RUNMODAL;
            IF ReturnedDateInput.GetDepositDate <> 0D THEN
                DateReturned := ReturnedDateInput.GetDepositDate;
            //APNT-DUR1.3 +

            IF DateReturned < "Document Date" THEN BEGIN
                //Window.CLOSE;
                ERROR('Returned Date cannot be lesser then %1.', FIELDCAPTION("Document Date"));
            END;

            IF DateReturned = 0D THEN
                EXIT;


            TESTFIELD(Bank);
            GLSetup.GET();
            GLSetup.TESTFIELD("PDC Issue Template");
            GLSetup.TESTFIELD("PDC Issue Batch");
            Vendor.GET("Vendor No.");
            Vendor.TESTFIELD("Vendor Posting Group");
            VendorPostingGrp.GET(Vendor."Vendor Posting Group");
            VendorPostingGrp.TESTFIELD("PDC Issue Account");
            CheckforDimensions(PDCIssue);

            Window.OPEN('Issuing PDC  #1#######################\' +
                        'Status       #2#######################\' +
                        'Document No. #3#######################');
            Window.UPDATE(1, Code);

            IF "Reference Type" = "Reference Type"::Invoice THEN BEGIN
                GenJnlLine.RESET;
                GenJnlLine.SETFILTER("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.SETFILTER("Journal Batch Name", GLSetup."PDC Issue Batch");
                IF GenJnlLine.FIND('-') THEN
                    GenJnlLine.DELETEALL(TRUE);

                Window.UPDATE(2, 'Inserting Journals');
                GenJnlLine.INIT;
                IF GenJournalTempl.GET(GLSetup."PDC Issue Template") THEN;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine."Line No." := 10000;
                GenJnlLine."Document No." := Code;
                GenJnlLine.VALIDATE("Posting Date", DateReturned);
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Vendor);
                GenJnlLine.VALIDATE("Account No.", "Vendor No.");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, -Amount);
                GenJnlLine.Description := 'Returned';
                GenJnlLine."Source Code" := GenJournalTempl."Source Code";
                // GenJnlLine."Cheque No." := "Cheque No.";
                //APNT-1.2
                //  GenJnlLine."Cheque Date" := "Cheque Date";
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine."Check Date" := "Cheque Date";
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                //APNT-1.2
                //<LT> Commented the code - PDC Upgrade
                //GenJnlLine."Paid to / Received from" := Payee; //RT-0112
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                GenJnlLine.MODIFY;

                GenJnlLine.INIT;
                IF GenJournalTempl.GET(GLSetup."PDC Issue Template") THEN;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine."Line No." := 20000;
                GenJnlLine."Document No." := Code;
                GenJnlLine.VALIDATE("Posting Date", DateReturned);
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                GenJnlLine.VALIDATE("Account No.", VendorPostingGrp."PDC Issue Account");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, Amount);
                GenJnlLine.Description := 'Returned';
                GenJnlLine."Source Code" := GenJournalTempl."Source Code";
                // GenJnlLine."Cheque No." := "Cheque No.";
                //APNT-1.2
                // GenJnlLine."Cheque Date" := "Cheque Date";
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine."Check Date" := "Cheque Date";
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                //APNT-1.2
                //<LT> Commented the code - PDC Upgrade
                //GenJnlLine."Paid to / Received from" := Payee; //RT-0112
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Deposit Bank Dim1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Deposit Bank Dim2 Code");
                GenJnlLine.MODIFY;
                Window.UPDATE(2, 'Posting Journals');
                CLEAR(GenJnlPostBatch);
                GenJnlPostBatch.RUN(GenJnlLine);
                CLEAR(GenJnlPostBatch); //APNT-LCPDC1.1
                PDCAppliedAmt.RESET;
                PDCAppliedAmt.SETFILTER("PDC No.", Code);
                IF PDCAppliedAmt.FIND('-') THEN
                    REPEAT
                        PDCAppliedAmt.Posted := FALSE;
                        PDCAppliedAmt.MODIFY;
                    UNTIL PDCAppliedAmt.NEXT = 0;
            END;

            IF "Reference Type" = "Reference Type"::" " THEN BEGIN
                GenJnlLine.RESET;
                GenJnlLine.SETFILTER(GenJnlLine."Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.SETFILTER(GenJnlLine."Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine.DELETEALL;

                Window.UPDATE(2, 'Inserting Journals');
                GenJnlLine.INIT;
                IF GenJournalTempl.GET(GLSetup."PDC Issue Template") THEN;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine."Line No." := 10000;
                //GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := Code;
                GenJnlLine.VALIDATE("Posting Date", DateReturned);
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Vendor);
                GenJnlLine.VALIDATE("Account No.", "Vendor No.");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, -Amount);
                GenJnlLine.Description := 'Returned';
                GenJnlLine."Source Code" := GenJournalTempl."Source Code";
                //GenJnlLine."Cheque No." := "Cheque No.";
                //APNT-1.2
                //GenJnlLine."Cheque Date" := "Cheque Date";
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                GenJnlLine."Check Date" := "Cheque Date";
                //APNT-1.2
                //<LT> Commented the code - PDC Upgrade
                //GenJnlLine."Paid to / Received from" := Payee; //RT-0112
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                GenJnlLine.MODIFY;

                GenJnlLine.INIT;
                IF GenJournalTempl.GET(GLSetup."PDC Issue Template") THEN;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine."Line No." := 20000;
                //GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := Code;
                GenJnlLine.VALIDATE("Posting Date", DateReturned);
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                GenJnlLine.VALIDATE("Account No.", VendorPostingGrp."PDC Issue Account");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, Amount);
                GenJnlLine.Description := 'Returned';
                GenJnlLine."Source Code" := GenJournalTempl."Source Code";
                //GenJnlLine."Cheque No." := "Cheque No.";
                //APNT-1.2
                //GenJnlLine."Cheque Date" := "Cheque Date";
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine."Check Date" := "Cheque Date";
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                //APNT-1.2
                //<LT> Commented the code - PDC Upgrade
                //GenJnlLine."Paid to / Received from" := Payee; //RT-0112
                //</LT>
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Deposit Bank Dim1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Deposit Bank Dim2 Code");
                GenJnlLine.MODIFY;
                Window.UPDATE(2, 'Posting Journals');
                CLEAR(GenJnlPostBatch);
                GenJnlPostBatch.RUN(GenJnlLine);
                CLEAR(GenJnlPostBatch); //APNT-LCPDC1.1
            END;
            CheckLedgEntry.RESET;
            CheckLedgEntry.SETCURRENTKEY("Document No.", "Posting Date");
            CheckLedgEntry.SETRANGE("Document No.", Code);
            IF CheckLedgEntry.FIND('-') THEN
                REPEAT
                    CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::Voided;
                    CheckLedgEntry.MODIFY(TRUE);
                UNTIL CheckLedgEntry.NEXT = 0;
            Window.CLOSE;
            VALIDATE(Status, Status::Returned);
            MODIFY;

        END;

    end;

    local procedure "****"()
    begin
    end;
}

