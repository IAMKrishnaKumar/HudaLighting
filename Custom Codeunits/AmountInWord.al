codeunit 50645 "Amount In Word LT"
{
    trigger OnRun()
    begin
        //InitTextVariable;
        //FormatNoText(AmountText, 125000.25, 'AED');
        // Message('%1 ---- %2', AmountText[1], AmountText[2]);
    end;

    var
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
        Text062: Label 'G/L Account,Customer,Vendor,Bank Account';
        Text063: Label 'Net Amount %1';
        Text064: Label '%1 must not be %2 for %3 %4.';
        Text1020: Label 'The total amount of check %1 is %2. The amount must be negative.';
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        TotalAmount: Decimal;
        AmountText: array[2] of Text[250];
        DrawnOn: Text[250];
        AppliedDocNo: Code[20];
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        DimValue: Record "Dimension Value";
        CustName: Text[100];
        BankName: Text[100];
        GLSetup: Record "General Ledger Setup";
        Currencycode1: Text[20];
        DecimalDesc: Text[20];
        PageCaption: Label 'Page %1 of %2';
        Users: Record User;

    local procedure AddToNoText(var NoText: array[2] of Text[250]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30]);
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR(Text029, AddText);
        END;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
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

    procedure FormatNoText(var NoText: array[2] of Text[250]; No: Decimal; CurrencyCode: Code[10]);
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        DecimalPosition: Decimal;
        DecimalPart: Integer;
        RecCurr: Record Currency;
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
                GLSetup.Reset();
                GLSetup.Get();
                if GLSetup."LCY Code" <> CurrencyCode then begin
                    RecCurr.RESET;
                    IF RecCurr.GET(CurrencyCode) THEN
                        DecimalDesc := RecCurr."Decimal Description";

                    IF (Exponent = 1) THEN
                        IF CurrencyCode <> ' ' THEN
                            AddToNoText(NoText, NoTextIndex, PrintExponent, DecimalDesc + ' ONLY')
                        ELSE
                            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + ' ONLY');
                end else begin
                    DecimalDesc := 'FILS';

                    IF (Exponent = 1) THEN
                        IF CurrencyCode <> ' ' THEN
                            AddToNoText(NoText, NoTextIndex, PrintExponent, DecimalDesc + ' ONLY')
                        ELSE
                            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + ' ONLY');
                end;
                // <LT>
            END;

    end;


}