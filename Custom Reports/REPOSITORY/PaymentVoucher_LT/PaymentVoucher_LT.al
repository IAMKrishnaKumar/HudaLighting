report 50117 PaymentVoucher_LT
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Custom Reports\REPOSITORY\PaymentVoucher_LT\PaymentVoucher_LT.rdlc';
    Caption = 'PaymentVoucher_LT';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.");
            RequestFilterFields = "Document No.";
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Name2; CompanyInfo."Name 2")
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Country; CompanyInfo."Country/Region Code")
            {
            }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo."Header Image")
            {
            }
            column(UserName; UserName)
            {
            }
            column(footerImage; CompanyInfo."Footer Image")
            {

            }
            column(CompanyInfo_vatRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfo_PhoneNol; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            {
            }
            column(PostingDate_GenJournalLine; "Gen. Journal Line"."Posting Date")
            {
            }
            column(ChequeNo_GenJournalLine; "Gen. Journal Line"."Check No.")
            {
            }
            column(DocumentNo_GenJournalLine; "Gen. Journal Line"."Document No.")
            {
            }
            column(CurrencyCode_GenJournalLine; CurrCode)
            {
            }
            column(Amount_GenJournalLine; "Gen. Journal Line"."Debit Amount")
            {
            }
            column(No; No)
            {
            }
            column(Name; Name)
            {
            }
            column(Narration_GenJournalLine; "Gen. Journal Line".Narration)
            {
            }
            column(AmountText1; AmountText1)
            {
            }
            column(DocumentNo2_GenJournalLine; 'Doc No2')
            {
            }
            column(InvoiceNo; InvoiceNo)
            {
            }
            column(PostingDate; PostingDate)
            {
            }
            column(OrgAmount; OrgAmount)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "Gen. Journal Line"."Account Type" = "Gen. Journal Line"."Account Type"::Vendor THEN BEGIN
                    Vendor_Rec.RESET;
                    Vendor_Rec.SETRANGE("No.", "Gen. Journal Line"."Account No.");
                    IF Vendor_Rec.FINDFIRST THEN BEGIN
                        No := Vendor_Rec."No.";
                        Name := Vendor_Rec.Name;
                    END
                END;




                IF "Gen. Journal Line"."Currency Code" = '' THEN
                    CurrCode := 'AED'
                ELSE
                    CurrCode := "Gen. Journal Line"."Currency Code";

                //<LT>
                Currency_Rec.RESET;
                IF Currency_Rec.GET(CurrCode) THEN
                    DecimalDesc := Currency_Rec."Decimal Description";

                CLEAR(TotalAmt);

                //<\LT>
                TotalAmt += "Gen. Journal Line"."Debit Amount";
                //<LT>
                CLEAR(tvar);

                tvar := (ROUND(TotalAmt) MOD 1 * 100);



                InitTextVariable;
                FormatNoText(AmtInwrd11, tvar, '');
                AmtInwrd12 := AmtInwrd11[1];
                IF AmtInwrd12 = '' THEN
                    AmtInwrd12 := 'ZERO';


                InitTextVariable;
                FormatNoText(Amount_Words, TotalAmt, '');
                Text := Amount_Words[1];

                AmountText1 := Text + ' AND ' + AmtInwrd12 + ' ' + DecimalDesc + 'ONLY';
                //MESSAGE('%1',AmountText1);
                //<LT>

            end;

            trigger OnPreDataItem()
            begin
                CLEAR(No);
                CLEAR(Name);
                CLEAR(CurrCode);

                CLEAR(DecimalDesc);

                //"Gen. Journal Line".SETFILTER("Gen. Journal Line"."Source Code", '%1', 'PAYMENTJNL');
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

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS("Header Image");
        CompanyInfo.CalcFields("Footer Image");
        Clear(Users);
        Clear(UserName);
        Users.SetCurrentKey("User Name");
        Users.SetRange("User Name", UserId);
        IF Users.FindFirst() then begin
            if Users."Full Name" <> '' then
                UserName := Users."Full Name"
            else
                UserName := UserId;
        end;
    end;

    var
        CompanyInfo: Record 79;
        Vendor_Rec: Record 23;
        No: Code[20];
        Name: Text[50];
        CheckRep: Report 1401;
        GLSetup: Record 98;
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        GenJnlLine: Record 81;
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
        TotalAmt: Decimal;
        tvar: Decimal;
        AmtInwrd11: array[2] of Text;
        AmtInwrd12: Text;
        Amount_Words: array[2] of Text;
        Text: Text;
        AmountText1: Text;
        CurrCode: Code[20];
        CustLedEntry_Rec: Record 21;
        VendorLedEntry: Record 25;
        InvoiceNo: Code[20];
        PostingDate: Date;
        OrgAmount: Decimal;
        Currency_Rec: Record 4;
        DecimalDesc: Text[250];
        Users: Record User;
        UserName: Text;


    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
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
        NoText[1] := '';
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

        //AddToNoText(NoText,NoTextIndex,PrintExponent,Text028);
        //DecimalPosition := GetAmtDecimalPosition;
        //AddToNoText(NoText,NoTextIndex,PrintExponent,(FORMAT(No * DecimalPosition) + '/' + FORMAT(DecimalPosition)));

        IF CurrencyCode <> '' THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
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

    local procedure GetAmtDecimalPosition(): Decimal
    var
        Currency: Record 4;
    begin
        IF GenJnlLine."Currency Code" = '' THEN
            Currency.InitRoundingPrecision
        ELSE BEGIN
            Currency.GET(GenJnlLine."Currency Code");
            Currency.TESTFIELD("Amount Rounding Precision");
        END;
        EXIT(1 / Currency."Amount Rounding Precision");
    end;
}

