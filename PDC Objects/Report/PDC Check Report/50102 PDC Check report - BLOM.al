report 50102 "PDC BLOM BANK CHECK"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'PDC Objects\Report\PDC Check Report\Blom Bank_Final.rdl';

    dataset
    {
        dataitem("PDC Issue"; "PDC Issue")
        {
            column(VendorCode; "PDC Issue"."Vendor No.")
            {
            }
            column(UnapplliedPDC; "PDC Issue"."UnApplied PDC")
            {
            }
            column(VendorName; "PDC Issue".Name)
            {
            }
            column(bANKcODE; "PDC Issue".Bank)
            {
            }
            column(Payee; "A/C Payee")
            {
            }
            column(CheckDateText; CheckDateText)
            {
            }
            column(CheckNo; CheckNo)
            {
            }
            column(PDCIssueCode; "PDC Issue".Code)
            {
            }
            column(PosDateText; PosDateText)
            {
            }
            column(CheckToAddr1; CheckToAddr[1])
            {
            }
            column(PDCIssueUserID; User."Full Name")
            {
            }
            column(AccPayeeText; AccPayeeText)
            {
            }
            column(DescriptionLine1; DescriptionLine[1])
            {
            }
            column(DescriptionLine2; DescriptionLine[2])
            {
            }
            column(TotalLineAmount; TotalLineAmount)
            {
            }
            column(TotalAmountToApply; TotalAmountToApply)
            {
            }
            column(ChDocNo1; ChDocNo[1])
            {
            }
            column(ChDocNo2; ChDocNo[2])
            {
            }
            column(ChDocNo3; ChDocNo[3])
            {
            }
            column(ChDocNo4; ChDocNo[4])
            {
            }
            column(ChDocNo5; ChDocNo[5])
            {
            }
            column(ChDocNo6; ChDocNo[6])
            {
            }
            column(ChDocNo7; ChDocNo[7])
            {
            }
            column(ChDocNo8; ChDocNo[8])
            {
            }
            column(ChDocNo9; ChDocNo[9])
            {
            }
            column(ChDocNo10; ChDocNo[10])
            {
            }
            column(ChDocNo11; ChDocNo[11])
            {
            }
            column(ChDocNo12; ChDocNo[12])
            {
            }
            column(ChDocNo13; ChDocNo[13])
            {
            }
            column(ChDocNo14; ChDocNo[14])
            {
            }
            column(ChDocNo15; ChDocNo[15])
            {
            }
            column(ChDocNo16; ChDocNo[16])
            {
            }
            column(ChDocNo17; ChDocNo[17])
            {
            }
            column(ChDocNo18; ChDocNo[18])
            {
            }
            column(ChProfitCentre1; ChProfitCentre[1])
            {
            }
            column(ChProfitCentre2; ChProfitCentre[2])
            {
            }
            column(ChProfitCentre3; ChProfitCentre[3])
            {
            }
            column(ChProfitCentre4; ChProfitCentre[4])
            {
            }
            column(ChProfitCentre5; ChProfitCentre[5])
            {
            }
            column(ChProfitCentre6; ChProfitCentre[6])
            {
            }
            column(ChProfitCentre7; ChProfitCentre[7])
            {
            }
            column(ChProfitCentre8; ChProfitCentre[8])
            {
            }
            column(ChProfitCentre9; ChProfitCentre[9])
            {
            }
            column(ChProfitCentre10; ChProfitCentre[10])
            {
            }
            column(ChProfitCentre11; ChProfitCentre[11])
            {
            }
            column(ChProfitCentre12; ChProfitCentre[12])
            {
            }
            column(ChProfitCentre13; ChProfitCentre[13])
            {
            }
            column(ChProfitCentre14; ChProfitCentre[14])
            {
            }
            column(ChProfitCentre15; ChProfitCentre[15])
            {
            }
            column(ChProfitCentre16; ChProfitCentre[16])
            {
            }
            column(ChProfitCentre17; ChProfitCentre[17])
            {
            }
            column(ChProfitCentre18; ChProfitCentre[18])
            {
            }
            column(ChDesc1; ChDesc[1])
            {
            }
            column(ChDesc2; ChDesc[2])
            {
            }
            column(ChDesc3; ChDesc[3])
            {
            }
            column(ChDesc4; ChDesc[4])
            {
            }
            column(ChDesc5; ChDesc[5])
            {
            }
            column(ChDesc6; ChDesc[6])
            {
            }
            column(ChDesc7; ChDesc[7])
            {
            }
            column(ChDesc8; ChDesc[8])
            {
            }
            column(ChDesc9; ChDesc[9])
            {
            }
            column(ChDesc10; ChDesc[10])
            {
            }
            column(ChDesc11; ChDesc[11])
            {
            }
            column(ChDesc12; ChDesc[12])
            {
            }
            column(ChDesc13; ChDesc[13])
            {
            }
            column(ChDesc14; ChDesc[14])
            {
            }
            column(ChDesc15; ChDesc[15])
            {
            }
            column(ChDesc16; ChDesc[16])
            {
            }
            column(ChDesc17; ChDesc[17])
            {
            }
            column(ChDesc18; ChDesc[18])
            {
            }
            column(ChExterDocNo1; ChExterDocNo[1])
            {
            }
            column(ChExterDocNo2; ChExterDocNo[2])
            {
            }
            column(ChExterDocNo3; ChExterDocNo[3])
            {
            }
            column(ChExterDocNo4; ChExterDocNo[4])
            {
            }
            column(ChExterDocNo5; ChExterDocNo[5])
            {
            }
            column(ChExterDocNo6; ChExterDocNo[6])
            {
            }
            column(ChExterDocNo7; ChExterDocNo[7])
            {
            }
            column(ChExterDocNo8; ChExterDocNo[8])
            {
            }
            column(ChExterDocNo9; ChExterDocNo[9])
            {
            }
            column(ChExterDocNo10; ChExterDocNo[10])
            {
            }
            column(ChExterDocNo11; ChExterDocNo[11])
            {
            }
            column(ChExterDocNo12; ChExterDocNo[12])
            {
            }
            column(ChExterDocNo13; ChExterDocNo[13])
            {
            }
            column(ChExterDocNo14; ChExterDocNo[14])
            {
            }
            column(ChExterDocNo15; ChExterDocNo[15])
            {
            }
            column(ChExterDocNo16; ChExterDocNo[16])
            {
            }
            column(ChExterDocNo17; ChExterDocNo[17])
            {
            }
            column(ChExterDocNo18; ChExterDocNo[18])
            {
            }
            column(ChAmount1; ChAmount[1])
            {
            }
            column(ChAmount2; ChAmount[2])
            {
            }
            column(ChAmount3; ChAmount[3])
            {
            }
            column(ChAmount4; ChAmount[4])
            {
            }
            column(ChAmount5; ChAmount[5])
            {
            }
            column(ChAmount6; ChAmount[6])
            {
            }
            column(ChAmount7; ChAmount[7])
            {
            }
            column(ChAmount8; ChAmount[8])
            {
            }
            column(ChAmount9; ChAmount[9])
            {
            }
            column(ChAmount10; ChAmount[10])
            {
            }
            column(ChAmount11; ChAmount[11])
            {
            }
            column(ChAmount12; ChAmount[12])
            {
            }
            column(ChAmount13; ChAmount[13])
            {
            }
            column(ChAmount14; ChAmount[14])
            {
            }
            column(ChAmount15; ChAmount[15])
            {
            }
            column(ChAmount16; ChAmount[16])
            {
            }
            column(ChAmount17; ChAmount[17])
            {
            }
            column(ChAmount18; ChAmount[18])
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Applies-to ID" = FIELD(Code);

                trigger OnAfterGetRecord()
                begin
                    IF ("Vendor Ledger Entry"."Document Type" = "Vendor Ledger Entry"."Document Type"::"Credit Memo") THEN
                        TotalAmountToApply += "Amount to Apply" * -1
                    ELSE
                        TotalAmountToApply += "Amount to Apply" * -1;
                    zctr += 1;
                    CLEAR(ProfitCenterName);
                    DimensionValue.RESET;
                    DimensionValue.SETRANGE(Code, "Global Dimension 1 Code");
                    IF DimensionValue.FINDFIRST THEN BEGIN
                        ProfitCenterName := DimensionValue.Name;
                    END;
                    IF zctr <= 18 THEN BEGIN
                        ChDocNo[zctr] := "Document No.";
                        ChProfitCentre[zctr] := "Vendor Ledger Entry"."Global Dimension 1 Code";
                        IF ("Vendor Ledger Entry"."Document Type" = "Vendor Ledger Entry"."Document Type"::"Credit Memo") THEN
                            ChAmount[zctr] := "Vendor Ledger Entry"."Amount to Apply" * -1
                        ELSE
                            ChAmount[zctr] := "Vendor Ledger Entry"."Amount to Apply" * -1;
                        //ChDesc[zctr]  := "Vendor Ledger Entry".Description;
                        ChDesc[zctr] := ProfitCenterName;
                        ChExterDocNo[zctr] := "Vendor Ledger Entry"."External Document No.";
                    END;

                    IF zctr > 18 THEN
                        MESSAGE('Since the number of Invoices applied are more than 18 the Invoice Application has not been fully printed!');
                end;
            }
            dataitem(PDCIssueLine; 2000000026)
            {

                trigger OnPreDataItem()
                begin
                    PDCIssueLine.SETRANGE(Number, 1, 25);
                end;
            }

            trigger OnAfterGetRecord()
            var
                RecRef: RecordRef;
            begin
                User.RESET;
                User.SETRANGE("User Name", "PDC Issue"."User ID");
                IF User.FINDFIRST THEN;
                //TESTFIELD("Cheque No.");
                IF "Cheque No." = '' THEN BEGIN
                    BankRec.TESTFIELD("Last Check No.");
                    CheckNo := INCSTR(BankRec."Last Check No.");
                END ELSE
                    CheckNo := "Cheque No.";

                BalancingType := BalancingType::"Bank Account";
                BalancingNo := BankRec."No.";

                CheckDateText := FORMAT("Cheque Date", 0, '<day,2>-<month,2>-<year4>');
                PosDateText := FORMAT("Document Date", 0, '<day,2>-<month,2>-<year4>');

                //TotalLineAmount := "PDC Issue".Amount;
                TotalLineAmount := "PDC Issue"."Amount (LCY)";

                IF AccPayee THEN
                    AccPayeeText := 'A/C PAYEE';

                TESTFIELD(Payee);
                CheckToAddr[1] := Payee;

                Currencycode1 := 'AED';
                InitTextVariable;
                FormatNoText(DescriptionLine, TotalLineAmount, Currencycode1);
                /*
                IF (DescriptionLine[2] = '') AND (MAXSTRLEN(DescriptionLine[1]) - STRLEN(DescriptionLine[1]) > 4) THEN
                  DescriptionLine[1] := DescriptionLine[1] + ' ONLY'
                ELSE
                  DescriptionLine[2] := DescriptionLine[2] + ' ONLY';
                  */

                VendorCode := "PDC Issue"."Vendor No.";
                VendorName := "PDC Issue".Name;

                CheckLedgEntry.INIT;
                CheckLedgEntry."Bank Account No." := BankRec."No.";
                CheckLedgEntry."Posting Date" := "Document Date";
                CheckLedgEntry."Document Type" := CheckLedgEntry."Document Type"::Payment;
                CheckLedgEntry."Document No." := Code;
                CheckLedgEntry.Description := Payee;
                CheckLedgEntry."Bank Payment Type" := CheckLedgEntry."Bank Payment Type"::"Computer Check";
                CheckLedgEntry."Bal. Account Type" := BalancingType;
                CheckLedgEntry."Bal. Account No." := BalancingNo;
                CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::Printed;
                CheckLedgEntry.Amount := TotalLineAmount;
                CheckLedgEntry."Check Date" := "Cheque Date";
                CheckLedgEntry."Check No." := CheckNo;
                //LT
                //RecRef.SETTABLE(CheckLedgEntry);
                //LT
                CheckManagement.InsertCheck(CheckLedgEntry, RECORDID);    //Commented Base
                //CheckManagement.InsertCheck(
                //Regal1.0-
                IF "PDC Issue"."UnApplied PDC" = TRUE THEN BEGIN
                    //ChDocNo[2]         := "PDC Issue"."Shortcut Dimension 1 Code";
                    ChDocNo[2] := "PDC Issue"."Deposit Bank Dim1 Code";
                    ChProfitCentre[2] := "PDC Issue".Bank;
                    ChDesc[2] := "PDC Issue"."Bank Name";
                    ChExterDocNo[2] := "PDC Issue"."Currency Code";
                    ChAmount[2] := "PDC Issue"."Amount (LCY)" * -1;
                    ChDocNo[3] := "PDC Issue"."Shortcut Dimension 1 Code";
                    ChProfitCentre[3] := "PDC Issue"."Vendor No.";
                    ChDesc[3] := "PDC Issue".Name;
                    ChExterDocNo[3] := "PDC Issue"."Currency Code";
                    ChAmount[3] := "PDC Issue"."Amount (LCY)";
                    ChDesc[4] := "PDC Issue".Remarks;
                END
                //Regal1.0+

            end;

            trigger OnPreDataItem()
            begin
                /*
                IF CurrReport.PREVIEW THEN
                  ERROR('Preview is not allowed.');
                  */
                PDCIssue2.COPYFILTERS("PDC Issue");
                IF PDCIssue2.FIND('-') THEN;
                IF BankRec.GET(PDCIssue2.Bank) THEN;

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        IF PDCIssue2."Cheque No." = '' THEN BEGIN
            PDCIssue2."Cheque No." := CheckNo;
            BankRec."Last Check No." := CheckNo;
            BankRec.MODIFY;
        END;
        PDCIssue2."Check Printed" := TRUE;
        PDCIssue2.MODIFY;
    end;

    var
        Text000: Label 'Preview is not allowed.';
        Text001: Label 'Last Check No. must be filled in.';
        Text002: Label 'Filters on %1 and %2 are not allowed.';
        Text003: Label 'XXXXXXXXXXXXXXXX';
        Text004: Label 'must be entered.';
        Text005: Label 'The Bank Account and the General Journal Line must have the same currency.';
        Text006: Label 'Salesperson';
        Text007: Label 'Purchaser';
        Text008: Label 'Both Bank Accounts must have the same currency.';
        Text009: Label 'Our Contact';
        Text010: Label 'XXXXXXXXXX';
        Text011: Label 'XXXX';
        Text012: Label 'XX.XXXXXXXXXX.XXXX';
        Text013: Label '%1 already exists.';
        Text014: Label 'Check for %1 %2';
        Text015: Label 'Payment';
        Text016: Label 'In the Check report, One Check per Vendor and Document No.\';
        Text017: Label 'must not be activated when Applies-to ID is specified in the journal lines.';
        Text018: Label 'XXX';
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
        Text030: Label ' is already applied to %1 %2 for customer %3.';
        Text031: Label ' is already applied to %1 %2 for vendor %3.';
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
        Text062: Label 'G/L Account,Customer,Vendor,Bank Account';
        Text063: Label 'Net Amount %1';
        Text064: Label '%1 must not be %2 for %3 %4.';
        CompanyInfo: Record 79;
        SalesPurchPerson: Record 13;
        GenJnlLine2: Record 81;
        GenJnlLine3: Record 81;
        Cust: Record 18;
        CustLedgEntry: Record 21;
        Vend: Record 23;
        VendLedgEntry: Record 25;
        BankAcc: Record 270;
        BankAcc2: Record 270;
        CheckLedgEntry: Record 272;
        Currency: Record 4;
        FormatAddr: Codeunit 365;
        CheckManagement: Codeunit 367;
        DimensionManagement: Codeunit 408;
        CompanyAddr: array[8] of Text[50];
        CheckToAddr: array[8] of Text[50];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        BalancingType: Option "G/L Account",Customer,Vendor,"Bank Account";
        BalancingNo: Code[20];
        ContactText: Text[30];
        CheckNoText: Text[30];
        CheckDateText: Text[30];
        CheckAmountText: Text[30];
        DescriptionLine: array[2] of Text[60];
        DocType: Text[30];
        DocNo: Text[30];
        ExtDocNo: Text[30];
        VoidText: Text[30];
        LineAmount: Decimal;
        LineDiscount: Decimal;
        TotalLineAmount: Decimal;
        TotalLineDiscount: Decimal;
        RemainingAmount: Decimal;
        CurrentLineAmount: Decimal;
        FoundLast: Boolean;
        ReprintChecks: Boolean;
        TestPrint: Boolean;
        FirstPage: Boolean;
        OneCheckPrVendor: Boolean;
        FoundNegative: Boolean;
        ApplyMethod: Option Payment,OneLineOneEntry,OneLineID,MoreLinesOneEntry;
        ChecksPrinted: Integer;
        HighestLineNo: Integer;
        PreprintedStub: Boolean;
        TotalText: Text[10];
        DocDate: Date;
        i: Integer;
        CurrencyCode2: Code[10];
        NetAmount: Text[30];
        CurrencyExchangeRate: Record 330;
        LineAmount2: Decimal;
        GLSetup: Record 98;
        GenJnlLineRec: Record 81;
        BankRec: Record 270;
        AccPayee: Boolean;
        AccPayeeText: Text[30];
        PDCIssue2: Record 60012;
        PDCIssue3: Record 60012;
        CheckNo: Code[20];
        TotalAmountToApply: Decimal;
        RecordsPerPage: Integer;
        RecordsFromPage2: Integer;
        RemainingRecords: Integer;
        NoofPages: Integer;
        NoofRecords: Integer;
        IntegerRecords: Integer;
        CountRec: Decimal;
        ChDocNo: array[40] of Code[20];
        ChProfitCentre: array[40] of Code[10];
        ChAmount: array[40] of Decimal;
        zctr: Decimal;
        PosDateText: Text[30];
        ChDesc: array[40] of Text[50];
        ChExterDocNo: array[40] of Code[50];
        DimensionValue: Record 349;
        ProfitCenterName: Text[50];
        Currencycode1: Code[20];
        DecimalDesc: Text[20];
        PaymentDesc: Text[100];
        WIN: Dialog;
        VendorCode: Code[20];
        VendorName: Text;
        User: Record 2000000120;

    local procedure AddToNoText(var NoText: array[2] of Text[250]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin

        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR(Text029, AddText);
        END;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure InitTextVariable()
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

    procedure FormatNoText(var NoText: array[2] of Text[250]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        DecimalPosition: Decimal;
        DecimalPart: Integer;
        RecCurr: Record 4;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := ' ';
        //GLSetup.GET;

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
        //<LT> Standard code -
        /*
        AddToNoText(NoText,NoTextIndex,PrintExponent,Text028);
        DecimalPosition := GetAmtDecimalPosition;
        AddToNoText(NoText,NoTextIndex,PrintExponent,(FORMAT(No * DecimalPosition) + '/' + FORMAT(DecimalPosition)));
        //<LT>
        
        //2008-12-04 START
        IF No <> 0 THEN BEGIN
          AddToNoText(NoText,NoTextIndex,PrintExponent,Text028);
          //AddToNoText(NoText,NoTextIndex,PrintExponent,FORMAT(No * 100) + '/100');
          AddToNoText(NoText,NoTextIndex,PrintExponent,FORMAT(No * 100));
        END;
        AddToNoText(NoText,NoTextIndex,PrintExponent,currency."Decimal Description"+ ' Only.');
        //2008-12-04 STOP
        
        IF CurrencyCode <> '' THEN
          //AddToNoText(NoText,NoTextIndex,PrintExponent,CurrencyCode);
          AddToNoText(NoText,NoTextIndex,PrintExponent,currency."Decimal Description");
        */

        //IF (DecimalPart <= 0)  THEN
        //AddToNoText(NoText,NoTextIndex,PrintExponent,'Only')
        //AddToNoText(NoText,NoTextIndex,PrintExponent,'')
        //ELSE
        AddToNoText(NoText, NoTextIndex, PrintExponent, '');//RecCurr.Description + "Sales Invoice Header"."Currency Code");
        //LCS - 090914
        //DecimalPosition := GetAmtDecimalPosition;
        IF No < 1 THEN BEGIN
            No := ROUND(No, 0.01, '>');
            DecimalPart := No * 100;
        END;

        //LCS - 090914
        IF DecimalPart > 0 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
        //LCS - 090914

        IF (DecimalPart) < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, '' + 'ONLY')
        ELSE
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                Ones := DecimalPart DIV POWER(1000, Exponent - 1);
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
                DecimalPart := DecimalPart - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);

                //<LT>
                RecCurr.RESET;
                IF RecCurr.GET(Currencycode1) THEN
                    DecimalDesc := RecCurr."Decimal Description";
                IF (Exponent = 1) THEN
                    IF Currencycode1 <> 'AED' THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, DecimalDesc + ' ONLY')
                    ELSE
                        AddToNoText(NoText, NoTextIndex, PrintExponent, 'FILS' + ' ONLY');
                //<LT>
            END;

    end;

    procedure InitializeRequest(BankAcc: Code[20]; LastCheckNo: Code[20]; NewOneCheckPrVend: Boolean; NewReprintChecks: Boolean; NewTestPrint: Boolean; NewPreprintedStub: Boolean)
    begin
        IF BankAcc <> '' THEN
            IF BankAcc2.GET(BankAcc) THEN BEGIN
                OneCheckPrVendor := NewOneCheckPrVend;
                ReprintChecks := NewReprintChecks;
                TestPrint := NewTestPrint;
                PreprintedStub := NewPreprintedStub;
            END;
    end;

    procedure ExchangeAmt(PostingDate: Date; CurrencyCode: Code[10]; CurrencyCode2: Code[10]; Amount: Decimal) Amount2: Decimal
    begin
        IF (CurrencyCode <> '') AND (CurrencyCode2 = '') THEN
            Amount2 :=
              CurrencyExchangeRate.ExchangeAmtLCYToFCY(
                PostingDate, CurrencyCode, Amount, CurrencyExchangeRate.ExchangeRate(PostingDate, CurrencyCode))
        ELSE
            IF (CurrencyCode = '') AND (CurrencyCode2 <> '') THEN
                Amount2 :=
                  CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                    PostingDate, CurrencyCode2, Amount, CurrencyExchangeRate.ExchangeRate(PostingDate, CurrencyCode2))
            ELSE
                IF (CurrencyCode <> '') AND (CurrencyCode2 <> '') AND (CurrencyCode <> CurrencyCode2) THEN
                    Amount2 := CurrencyExchangeRate.ExchangeAmtFCYToFCY(PostingDate, CurrencyCode2, CurrencyCode, Amount)
                ELSE
                    Amount2 := Amount;
    end;

    procedure SetIntegerRange()
    begin
        //RecordsPerPage := 36;
        //NoofPages := ROUND((NoofRecords / RecordsPerPage),1,'>');
        //RecordsFromPage2 := RecordsPerPage + 1;

        //IF NoofRecords = RecordsPerPage THEN BEGIN
        //  TransferLine2.SETRANGE(Number,0);
        //END ELSE IF NoofRecords <= RecordsPerPage THEN BEGIN
        //  IntegerRecords := RecordsPerPage - NoofRecords;
        //  TransferLine2.SETRANGE(Number,1,ABS(IntegerRecords));
        //END ELSE IF (NoofRecords > RecordsPerPage) AND (NoofRecords < NoofPages * RecordsPerPage) THEN BEGIN
        // IntegerRecords := (NoofPages * RecordsPerPage) - NoofRecords;
        PDCIssueLine.SETRANGE(Number, 1, 25);
        //END;
    end;
}

