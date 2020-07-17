report 60021 "Cheque Report BLOM BANK"
{
    // version NAVW114.00

    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    RDLCLayout = 'Custom Reports\REPOSITORY\Cheque Report Custom\Blom Bank_Final.rdl';
    Caption = 'Check Report BLOM BANK';
    Permissions = TableData 270 = m;

    dataset
    {
        dataitem(GenJnlLine; "Gen. Journal Line")//Modified
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
            RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Line No.";
            column(JournalTempName_GenJnlLine; "Journal Template Name")
            {
            }
            column(Posting_Date; format("Check Date")) { }
            column(Description; "Payee Name") { }
            column(Amount; ABS(Amount)) { }
            column(AmountInWord11; AmountInWord11) { }
            column(JournalBatchName_GenJnlLine; "Journal Batch Name")
            {
            }
            column(Payee; Payee)
            {

            }
            column(LineNo_GenJnlLine; "Line No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                Amount1 := ABS(GenJnlLine.amount);
                AmountInWordCU.InitTextVariable();
                AmountInWordCU.FormatNoText(AmountText, Amount1, "Currency Code");
                AmountInWord11 := AmountText[1];
            end;

            trigger OnPostDataItem();
            var
                RecGenJnlLine: Record "Gen. Journal Line";
            begin
                Clear(RecGenJnlLine);
                RecGenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                RecGenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                RecGenJnlLine.SetRange("Line No.", GenJnlLine."Line No.");
                if RecGenJnlLine.FindFirst() then begin
                    RecGenJnlLine."Cheque Printed" := true;
                    RecGenJnlLine.Modify();
                end;
            end;
        }
    }


    labels
    {
    }

    trigger OnPreReport();
    begin
        InitTextVariable;
    end;

    var
        Text000: Label 'Preview is not allowed.';
        Text001: Label 'Last Check No. must be filled in.';
        Text002: Label 'Filters on %1 and %2 are not allowed.';
        Text003: Label 'XXXXXXXXXXXXXXXX';
        Text004: Label 'must be entered.';
        Text005: Label 'The Bank Account and the General Journal Line must have the same currency.';
        Text008: Label 'Both Bank Accounts must have the same currency.';
        Text010: Label 'XXXXXXXXXX';
        Text011: Label 'XXXX';
        Text012: Label 'XX.XXXXXXXXXX.XXXX';
        Text013: Label '%1 already exists.';
        Text014: Label 'Check for %1 %2';
        Text016: Label 'In the Check report, One Check per Vendor and Document No.\must not be activated when Applies-to ID is specified in the journal lines.';
        Text019: Label 'Total';
        Text020: Label 'The total amount of check %1 is %2. The amount must be positive.';
        Text021: Label 'VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID';
        Text022: Label 'NON-NEGOTIABLE';
        Text023: Label 'Test print';
        Text024: Label 'XXXX.XX';
        Text025: Label 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        Text026: Label 'ZERO';
        Text027: Label 'HUNDRED';
        Text028: Label 'AND';
        Text029: Label '%1 results in a written number that is too long.';
        Text030: Label '" is already applied to %1 %2 for customer %3."';
        Text031: Label '" is already applied to %1 %2 for vendor %3."';
        Text032: Label 'ONE';
        Text033: Label 'TWO';
        Text034: Label 'THREE';
        Text035: Label 'FOUR';
        Text036: Label 'FIVE';
        Text037: Label 'SIX';
        Text038: Label 'SEVEN';
        Text039: Label 'EIGHT';
        Text040: Label 'NINE';
        Text041: Label 'TEN';
        Text042: Label 'ELEVEN';
        Text043: Label 'TWELVE';
        Text044: Label 'THIRTEEN';
        Text045: Label 'FOURTEEN';
        Text046: Label 'FIFTEEN';
        Text047: Label 'SIXTEEN';
        Text048: Label 'SEVENTEEN';
        Text049: Label 'EIGHTEEN';
        Text050: Label 'NINETEEN';
        Text051: Label 'TWENTY';
        Text052: Label 'THIRTY';
        Text053: Label 'FORTY';
        Text054: Label 'FIFTY';
        Text055: Label 'SIXTY';
        Text056: Label 'SEVENTY';
        Text057: Label 'EIGHTY';
        Text058: Label 'NINETY';
        Text059: Label 'THOUSAND';
        Text060: Label 'MILLION';
        Text061: Label 'BILLION';
        CompanyInfo: Record "Company Information";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlLine3: Record "Gen. Journal Line";
        Cust: Record "Customer";
        CustLedgEntry: Record "Cust. Ledger Entry";
        Vend: Record "Vendor";
        VendLedgEntry: Record "Vendor Ledger Entry";
        BankAcc: Record "Bank Account";
        BankAcc2: Record "Bank Account";
        CheckLedgEntry: Record "Check Ledger Entry";
        Currency: Record "Currency";
        GLSetup: Record "General Ledger Setup";
        Employee: Record "Employee";
        EmployeeLedgerEntry: Record "Employee Ledger Entry";
        FormatAddr: Codeunit "Format Address";
        CheckManagement: Codeunit "CheckManagement";
        CompanyAddr: array[8] of Text[100];
        CheckToAddr: array[8] of Text[100];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        BalancingType: Enum "Gen. Journal Account Type"; //Option "G/L Account",Customer,Vendor,"Bank Account",,,Employee;
        BalancingNo: Code[20];
        CheckNoText: Text[30];
        CheckDateText: Text[30];
        CheckAmountText: Text[30];
        DescriptionLine: array[2] of Text[80];
        DocNo: Text[30];
        ExtDocNo: Text[35];
        VoidText: Text[30];
        LineAmount: Decimal;
        LineDiscount: Decimal;
        TotalLineAmount: Decimal;
        TotalLineDiscount: Decimal;
        RemainingAmount: Decimal;
        CurrentLineAmount: Decimal;
        UseCheckNo: Code[20];
        FoundLast: Boolean;
        ReprintChecks: Boolean;
        TestPrint: Boolean;
        FirstPage: Boolean;
        OneCheckPrVendor: Boolean;
        FoundNegative: Boolean;
        AddedRemainingAmount: Boolean;
        ApplyMethod: Option Payment,OneLineOneEntry,OneLineID,MoreLinesOneEntry;
        ChecksPrinted: Integer;
        HighestLineNo: Integer;
        PreprintedStub: Boolean;
        TotalText: Text[10];
        DocDate: Date;
        JournalPostingDate: Date;
        i: Integer;
        Text062: Label 'G/L Account,Customer,Vendor,Bank Account,,,Employee';
        CurrencyCode2: Code[10];
        NetAmount: Text[30];
        LineAmount2: Decimal;
        Text063: Label 'Net Amount %1';
        Text064: Label '%1 must not be %2 for %3 %4.';
        Text065: Label 'Subtotal';
        CheckNoTextCaptionLbl: Label 'Check No.';
        LineAmountCaptionLbl: Label 'Net Amount';
        LineDiscountCaptionLbl: Label 'Discount';
        AmountCaptionLbl: Label 'Amount';
        DocNoCaptionLbl: Label 'Document No.';
        DocDateCaptionLbl: Label 'Document Date';
        CurrencyCodeCaptionLbl: Label 'Currency Code';
        YourDocNoCaptionLbl: Label 'Your Doc. No.';
        TransportCaptionLbl: Label 'Transport';
        AmountInWordCU: Codeunit "Amount In Word LT";
        AmountInWord11: Text[250];
        AmountText: array[2] of Text[250];


        Amount1: Decimal;
        BlockedEmplForCheckErr: Label 'You cannot print check because employee %1 is blocked due to privacy.', Comment = '%1 - Employee no.';
        AlreadyAppliedToEmployeeErr: TextConst Comment = '%1 = Document type, %2 = Document No., %3 = Employee No.', ENU = ' is already applied to %1 %2 for employee %3.';


    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10]);
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        DecimalPosition: Decimal;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '****';
        GLSetup.GET;

        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        ELSE
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                Ones := No DIV POWER(1000, Exponent - 1);
                Hundreds := Ones DIV 100;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    IF Ones > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                END ELSE
                    IF (Tens * 10 + Ones) > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1) THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
        DecimalPosition := GetAmtDecimalPosition;
        AddToNoText(NoText, NoTextIndex, PrintExponent, (FORMAT(No * DecimalPosition) + '/' + FORMAT(DecimalPosition)));

        IF CurrencyCode <> '' THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30]);
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR(Text029, AddText);
        END;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    local procedure CustUpdateAmounts(var CustLedgEntry2: Record "Cust. Ledger Entry"; RemainingAmount2: Decimal);
    var
        AmountToApply: Decimal;
    begin
        IF (ApplyMethod = ApplyMethod::OneLineOneEntry) OR
           (ApplyMethod = ApplyMethod::MoreLinesOneEntry)
        THEN BEGIN
            GenJnlLine3.RESET;
            GenJnlLine3.SETCURRENTKEY("Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
            CheckGLEntriesForCustomers(CustLedgEntry2);
        END;

        DocNo := CustLedgEntry2."Document No.";
        ExtDocNo := CustLedgEntry2."External Document No.";
        DocDate := CustLedgEntry2."Posting Date";
        CurrencyCode2 := CustLedgEntry2."Currency Code";

        CustLedgEntry2.CALCFIELDS("Remaining Amount");

        LineAmount :=
          -ABSMin(
            CustLedgEntry2."Remaining Amount" -
            CustLedgEntry2."Remaining Pmt. Disc. Possible" -
            CustLedgEntry2."Accepted Payment Tolerance",
            CustLedgEntry2."Amount to Apply");
        LineAmount2 :=
          ROUND(ExchangeAmt(GenJnlLine."Currency Code", CurrencyCode2, LineAmount), Currency."Amount Rounding Precision");

        IF ((CustLedgEntry2."Document Type" IN [CustLedgEntry2."Document Type"::Invoice,
                                                CustLedgEntry2."Document Type"::"Credit Memo"]) AND
            (CustLedgEntry2."Remaining Pmt. Disc. Possible" <> 0) AND
            (CustLedgEntry2."Posting Date" <= CustLedgEntry2."Pmt. Discount Date")) OR
           CustLedgEntry2."Accepted Pmt. Disc. Tolerance"
        THEN BEGIN
            LineDiscount := -CustLedgEntry2."Remaining Pmt. Disc. Possible";
            IF CustLedgEntry2."Accepted Payment Tolerance" <> 0 THEN
                LineDiscount := LineDiscount - CustLedgEntry2."Accepted Payment Tolerance";
        END ELSE BEGIN
            AmountToApply :=
              ROUND(-ExchangeAmt(
                  GenJnlLine."Currency Code", CurrencyCode2, CustLedgEntry2."Amount to Apply"), Currency."Amount Rounding Precision");
            IF RemainingAmount2 >= AmountToApply THEN
                LineAmount2 := AmountToApply
            ELSE BEGIN
                LineAmount2 := RemainingAmount2;
                LineAmount := ROUND(ExchangeAmt(CurrencyCode2, GenJnlLine."Currency Code", LineAmount2), Currency."Amount Rounding Precision");
            END;
            LineDiscount := 0;
        END;
    end;

    local procedure VendUpdateAmounts(var VendLedgEntry2: Record "Vendor Ledger Entry"; RemainingAmount2: Decimal);
    var
        AmountToApply: Decimal;
    begin
        IF (ApplyMethod = ApplyMethod::OneLineOneEntry) OR
           (ApplyMethod = ApplyMethod::MoreLinesOneEntry)
        THEN BEGIN
            GenJnlLine3.RESET;
            GenJnlLine3.SETCURRENTKEY("Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
            CheckGLEntiresForVendors(VendLedgEntry2);
        END;

        DocNo := VendLedgEntry2."Document No.";
        ExtDocNo := VendLedgEntry2."External Document No.";
        DocDate := VendLedgEntry2."Posting Date";
        CurrencyCode2 := VendLedgEntry2."Currency Code";
        VendLedgEntry2.CALCFIELDS("Remaining Amount");

        LineAmount :=
          -ABSMin(
            VendLedgEntry2."Remaining Amount" -
            VendLedgEntry2."Remaining Pmt. Disc. Possible" -
            VendLedgEntry2."Accepted Payment Tolerance",
            VendLedgEntry2."Amount to Apply");

        LineAmount2 :=
          ROUND(ExchangeAmt(GenJnlLine."Currency Code", CurrencyCode2, LineAmount), Currency."Amount Rounding Precision");

        IF ((VendLedgEntry2."Document Type" IN [VendLedgEntry2."Document Type"::Invoice,
                                                VendLedgEntry2."Document Type"::"Credit Memo"]) AND
            (VendLedgEntry2."Remaining Pmt. Disc. Possible" <> 0) AND
            (GenJnlLine."Posting Date" <= VendLedgEntry2."Pmt. Discount Date")) OR
           VendLedgEntry2."Accepted Pmt. Disc. Tolerance"
        THEN BEGIN
            LineDiscount := -VendLedgEntry2."Remaining Pmt. Disc. Possible";
            IF VendLedgEntry2."Accepted Payment Tolerance" <> 0 THEN
                LineDiscount := LineDiscount - VendLedgEntry2."Accepted Payment Tolerance";
        END ELSE BEGIN
            AmountToApply := ROUND(-ExchangeAmt(
                  GenJnlLine."Currency Code", CurrencyCode2, VendLedgEntry2."Amount to Apply"), Currency."Amount Rounding Precision");
            IF ABS(RemainingAmount2) >= ABS(AmountToApply) THEN BEGIN
                LineAmount2 := AmountToApply;
                LineAmount :=
                  ROUND(ExchangeAmt(CurrencyCode2, GenJnlLine."Currency Code", LineAmount2), Currency."Amount Rounding Precision");
            END ELSE BEGIN
                LineAmount2 := RemainingAmount2;
                LineAmount :=
                  ROUND(
                    ExchangeAmt(CurrencyCode2, GenJnlLine."Currency Code", LineAmount2), Currency."Amount Rounding Precision");
            END;
            LineDiscount := 0;
        END;
    end;

    local procedure EmployeeUpdateAmounts(var EmployeeLedgerEntry2: Record "Employee Ledger Entry"; RemainingAmount2: Decimal);
    var
        AmountToApply: Decimal;
    begin
        IF (ApplyMethod = ApplyMethod::OneLineOneEntry) OR
           (ApplyMethod = ApplyMethod::MoreLinesOneEntry)
        THEN BEGIN
            GenJnlLine3.RESET;
            GenJnlLine3.SETCURRENTKEY("Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
            CheckGLEntriesForEmployee(EmployeeLedgerEntry2);
        END;

        DocNo := EmployeeLedgerEntry2."Document No.";
        DocDate := EmployeeLedgerEntry2."Posting Date";

        CurrencyCode2 := EmployeeLedgerEntry2."Currency Code";
        EmployeeLedgerEntry2.CALCFIELDS("Remaining Amount");

        LineAmount := -EmployeeLedgerEntry2."Remaining Amount";

        LineAmount2 :=
          ROUND(ExchangeAmt(GenJnlLine."Currency Code", CurrencyCode2, LineAmount), Currency."Amount Rounding Precision");
        AmountToApply :=
          ROUND(-ExchangeAmt(
              GenJnlLine."Currency Code", CurrencyCode2, EmployeeLedgerEntry2."Amount to Apply"), Currency."Amount Rounding Precision");
        IF (RemainingAmount2 >= AmountToApply) AND (RemainingAmount2 > 0) THEN
            LineAmount2 := AmountToApply
        ELSE
            LineAmount2 := RemainingAmount2;
        LineAmount :=
          ROUND(
            ExchangeAmt(CurrencyCode2, GenJnlLine."Currency Code", LineAmount2), Currency."Amount Rounding Precision");
        LineDiscount := 0;
    end;


    procedure InitTextVariable();
    begin
        OnesText[1] := Text032;
        OnesText[2] := Text033;
        OnesText[3] := Text034;
        OnesText[4] := Text035;
        OnesText[5] := Text036;
        OnesText[6] := Text037;
        OnesText[7] := Text038;
        OnesText[8] := Text039;
        OnesText[9] := Text040;
        OnesText[10] := Text041;
        OnesText[11] := Text042;
        OnesText[12] := Text043;
        OnesText[13] := Text044;
        OnesText[14] := Text045;
        OnesText[15] := Text046;
        OnesText[16] := Text047;
        OnesText[17] := Text048;
        OnesText[18] := Text049;
        OnesText[19] := Text050;

        TensText[1] := '';
        TensText[2] := Text051;
        TensText[3] := Text052;
        TensText[4] := Text053;
        TensText[5] := Text054;
        TensText[6] := Text055;
        TensText[7] := Text056;
        TensText[8] := Text057;
        TensText[9] := Text058;

        ExponentText[1] := '';
        ExponentText[2] := Text059;
        ExponentText[3] := Text060;
        ExponentText[4] := Text061;
    end;


    procedure InitializeRequest(BankAcc: Code[20]; LastCheckNo: Code[20]; NewOneCheckPrVend: Boolean; NewReprintChecks: Boolean; NewTestPrint: Boolean; NewPreprintedStub: Boolean);
    begin
        IF BankAcc <> '' THEN
            IF BankAcc2.GET(BankAcc) THEN BEGIN
                UseCheckNo := LastCheckNo;
                OneCheckPrVendor := NewOneCheckPrVend;
                ReprintChecks := NewReprintChecks;
                TestPrint := NewTestPrint;
                PreprintedStub := NewPreprintedStub;
            END;
    end;

    local procedure ExchangeAmt(CurrencyCode: Code[10]; CurrencyCode2: Code[10]; Amount: Decimal) Amount2: Decimal;
    begin
        IF (CurrencyCode <> '') AND (CurrencyCode2 = '') THEN
            Amount2 :=
              CurrencyExchangeRate.ExchangeAmtLCYToFCY(
                JournalPostingDate, CurrencyCode, Amount, CurrencyExchangeRate.ExchangeRate(JournalPostingDate, CurrencyCode))
        ELSE
            IF (CurrencyCode = '') AND (CurrencyCode2 <> '') THEN
                Amount2 :=
                  CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                    JournalPostingDate, CurrencyCode2, Amount, CurrencyExchangeRate.ExchangeRate(JournalPostingDate, CurrencyCode2))
            ELSE
                IF (CurrencyCode <> '') AND (CurrencyCode2 <> '') AND (CurrencyCode <> CurrencyCode2) THEN
                    Amount2 := CurrencyExchangeRate.ExchangeAmtFCYToFCY(JournalPostingDate, CurrencyCode2, CurrencyCode, Amount)
                ELSE
                    Amount2 := Amount;
    end;

    local procedure ABSMin(Decimal1: Decimal; Decimal2: Decimal): Decimal;
    begin
        IF ABS(Decimal1) < ABS(Decimal2) THEN
            EXIT(Decimal1);
        EXIT(Decimal2);
    end;


    procedure InputBankAccount();
    begin
        IF BankAcc2."No." <> '' THEN BEGIN
            BankAcc2.GET(BankAcc2."No.");
            BankAcc2.TESTFIELD("Last Check No.");
            UseCheckNo := BankAcc2."Last Check No.";
        END;
    end;

    local procedure GetAmtDecimalPosition(): Decimal;
    var
        Currency: Record "Currency";
    begin
        IF GenJnlLine."Currency Code" = '' THEN
            Currency.InitRoundingPrecision
        ELSE BEGIN
            Currency.GET(GenJnlLine."Currency Code");
            Currency.TESTFIELD("Amount Rounding Precision");
        END;
        EXIT(1 / Currency."Amount Rounding Precision");
    end;

    local procedure CheckGenJournalBatchAndLineIsApproved(GenJournalLine: Record "Gen. Journal Line"): Boolean;
    var
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        GenJournalBatch.GET(GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name");
        EXIT(
          VerifyRecordIdIsApproved(DATABASE::"Gen. Journal Batch", GenJournalBatch.RECORDID) OR
          VerifyRecordIdIsApproved(DATABASE::"Gen. Journal Line", GenJournalLine.RECORDID));
    end;

    local procedure VerifyRecordIdIsApproved(TableNo: Integer; RecordId: RecordID): Boolean;
    var
        ApprovalEntry: Record "Approval Entry";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        ApprovalEntry.SETRANGE("Table ID", TableNo);
        ApprovalEntry.SETRANGE("Record ID to Approve", RecordId);
        ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
        ApprovalEntry.SETRANGE("Related to Change", FALSE);
        IF ApprovalEntry.ISEMPTY THEN
            EXIT(FALSE);
        EXIT(NOT ApprovalsMgmt.HasOpenOrPendingApprovalEntries(RecordId));
    end;

    local procedure PrintOneLineOneEntryOnAfterGetRecordForCustomer(CustLedgEntry1: Record "Cust. Ledger Entry");
    begin
        CustLedgEntry1.RESET;
        CustLedgEntry1.SETCURRENTKEY("Document No.");
        CustLedgEntry1.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
        CustLedgEntry1.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
        CustLedgEntry1.SETRANGE("Customer No.", BalancingNo);
        CustLedgEntry1.FINDFIRST;
        CustUpdateAmounts(CustLedgEntry1, RemainingAmount);
    end;

    local procedure PrintOneLineOneEntryOnAfterGetRecordForVendor(VendLedgEntry1: Record "Vendor Ledger Entry");
    begin
        VendLedgEntry1.RESET;
        VendLedgEntry1.SETCURRENTKEY("Document No.");
        VendLedgEntry1.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
        VendLedgEntry1.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
        VendLedgEntry1.SETRANGE("Vendor No.", BalancingNo);
        VendLedgEntry1.FINDFIRST;
        VendUpdateAmounts(VendLedgEntry1, RemainingAmount);
    end;

    local procedure PrintOneLineOneEntryOnAfterGetRecordForEmployee(EmployeeLedgerEntry1: Record "Employee Ledger Entry");
    begin
        EmployeeLedgerEntry1.RESET;
        EmployeeLedgerEntry1.SETCURRENTKEY("Document No.");
        EmployeeLedgerEntry1.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
        EmployeeLedgerEntry1.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
        EmployeeLedgerEntry1.SETRANGE("Employee No.", BalancingNo);
        EmployeeLedgerEntry1.FINDFIRST;
        EmployeeUpdateAmounts(EmployeeLedgerEntry1, RemainingAmount);
    end;

    local procedure CheckGLEntriesForEmployee(var EmployeeLedgerEntry3: Record "Employee Ledger Entry");
    begin
        GenJnlLine3.SETRANGE("Account Type", GenJnlLine3."Account Type"::Employee);
        GenJnlLine3.SETRANGE("Account No.", EmployeeLedgerEntry3."Employee No.");
        GenJnlLine3.SETRANGE("Applies-to Doc. Type", EmployeeLedgerEntry3."Document Type");
        GenJnlLine3.SETRANGE("Applies-to Doc. No.", EmployeeLedgerEntry3."Document No.");
        IF ApplyMethod = ApplyMethod::OneLineOneEntry THEN
            GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine."Line No.")
        ELSE
            GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine2."Line No.");
        IF EmployeeLedgerEntry3."Document Type" <> EmployeeLedgerEntry3."Document Type"::" " THEN
            IF GenJnlLine3.FIND('-') THEN
                GenJnlLine3.FIELDERROR(
                  "Applies-to Doc. No.",
                  STRSUBSTNO(
                    AlreadyAppliedToEmployeeErr, EmployeeLedgerEntry3."Document Type", EmployeeLedgerEntry3."Document No.",
                    EmployeeLedgerEntry3."Employee No."));
    end;

    local procedure CheckGLEntriesForCustomers(var CustLedgEntry3: Record "Cust. Ledger Entry");
    begin
        GenJnlLine3.SETRANGE("Account Type", GenJnlLine3."Account Type"::Customer);
        GenJnlLine3.SETRANGE("Account No.", CustLedgEntry3."Customer No.");
        GenJnlLine3.SETRANGE("Applies-to Doc. Type", CustLedgEntry3."Document Type");
        GenJnlLine3.SETRANGE("Applies-to Doc. No.", CustLedgEntry3."Document No.");
        IF ApplyMethod = ApplyMethod::OneLineOneEntry THEN
            GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine."Line No.")
        ELSE
            GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine2."Line No.");
        IF CustLedgEntry3."Document Type" <> CustLedgEntry3."Document Type"::" " THEN
            IF GenJnlLine3.FIND('-') THEN
                GenJnlLine3.FIELDERROR(
                  "Applies-to Doc. No.",
                  STRSUBSTNO(
                    Text030,
                    CustLedgEntry3."Document Type", CustLedgEntry3."Document No.",
                    CustLedgEntry3."Customer No."));
    end;

    local procedure CheckGLEntiresForVendors(var VendLedgEntry3: Record "Vendor Ledger Entry");
    begin
        GenJnlLine3.SETRANGE("Account Type", GenJnlLine3."Account Type"::Vendor);
        GenJnlLine3.SETRANGE("Account No.", VendLedgEntry3."Vendor No.");
        GenJnlLine3.SETRANGE("Applies-to Doc. Type", VendLedgEntry3."Document Type");
        GenJnlLine3.SETRANGE("Applies-to Doc. No.", VendLedgEntry3."Document No.");
        IF ApplyMethod = ApplyMethod::OneLineOneEntry THEN
            GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine."Line No.")
        ELSE
            GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine2."Line No.");
        IF VendLedgEntry3."Document Type" <> VendLedgEntry3."Document Type"::" " THEN
            IF GenJnlLine3.FIND('-') THEN
                GenJnlLine3.FIELDERROR(
                  "Applies-to Doc. No.",
                  STRSUBSTNO(
                    Text031,
                    VendLedgEntry3."Document Type", VendLedgEntry3."Document No.",
                    VendLedgEntry3."Vendor No."));
    end;
}

