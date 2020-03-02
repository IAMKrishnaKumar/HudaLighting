report 50120 "Purchase Tax Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Custom Reports\REPOSITORY\PO Tax Invoice\Purchase Tax Invoice.rdl';
    Caption = 'Purchase Tax Invoice';
    PreviewMode = PrintLayout;
    // ApplicationArea = All;
    // UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.";
            column(No_PurchInvHeader; "Purch. Inv. Header"."No.")
            {
            }
            column(BuyfromVendorNo_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor No.")
            {
            }
            column(BuyfromContact_PurchInvHeader; "Purch. Inv. Header"."Buy-from Contact")
            {
            }
            column(TRN; CompanyInfo."VAT Registration No.")
            {
            }
            column(VATRegistrationNo_PurchInvHeader; "Purch. Inv. Header"."VAT Registration No.")
            {
            }
            column(CompanyTelAndFax; CompanyTelAndFax)
            { }
            column(PostingDate_PurchInvHeader; "Purch. Inv. Header"."Posting Date")
            {
            }
            column(CompanyDisplayName; CompanyInfo.Name)//CompanyInfo."Ship-to Name")
            { }
            column(CompanyAddress; CompanyAddress)
            {

            }
            column(ShiptoAddress_PurchInvHeader; "Purch. Inv. Header"."Ship-to Address")
            {
            }
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            {

            }
            column(ShiptoAddress2_PurchInvHeader; "Purch. Inv. Header"."Ship-to Address 2")
            {
            }
            column(CurrencyCode_PurchInvHeader; "Purch. Inv. Header"."Currency Code")
            {
            }
            column(VendorInvoiceNo_PurchInvHeader; "Purch. Inv. Header"."Vendor Invoice No.")
            {
            }
            column(OrderNo_PurchInvHeader; PurchaseOrderNO)//"Purch. Inv. Header"."Order No.")
            {
            }
            column(Name_Vend; Name_Vend)
            {
            }
            column(Add_Vend; Add_Vend)
            {
            }
            column(Add2_Vend; Add2_Vend)
            {
            }
            column(CompanyInfoPicture; CompanyInfo."Header Image")
            {
            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {

            }
            column(footerImage; CompanyInfo."Footer Image")
            {
            }
            column(ComName; CompanyInfo.Name)
            {
            }
            column(CompAddress; CompanyInfo.Address)
            {
            }
            column(CompCity; CompanyInfo.City)
            {
            }
            column(CompCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(CompPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_Email; 'E. ' + CompanyInfo."E-Mail")
            { }
            column(CompanyInfoHomPage; CompanyInfo."Home Page")
            {

            }
            column(CompanyInfo_Add2; CompanyInfo."Address 2")
            {
            }
            column(Instructions; Instructions) { }
            column(Ins2; Ins2) { }
            column(Ins3; Ins3) { }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code")
            {
            }
            column(UserName; UserName)
            {
            }
            column(CurrCode; CurrCode)
            {
            }
            column(OrderNo; OrderNo)
            {
            }
            column(CurrencyFactor; CurrencyFactor)
            {

            }
            column(IsDiffCurrency; IsDiffCurrency)
            {

            }

            column(LCYCODE; GLSetupG."LCY Code")
            {

            }
            column(CurrecncyCode; "Purch. Inv. Header"."Currency Code")
            {

            }
            column(AmountText1; AmountText1)
            {
            }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending);
                column(Amount; Amount)
                {
                }
                column(SNo; SNo)
                {
                }
                column(Type; Type)
                {

                }
                column(IsComment; IsComment)
                {

                }
                column(VatAmt; VatAmt)
                {
                }
                column(AmtInWord; AmtInWord)
                {
                }
                column(AmtIncVat; AmtIncVat)
                {
                }
                column(DocumentNo_PurchInvLine; "Purch. Inv. Line"."Document No.")
                {
                }
                column(No_PurchInvLine; "Purch. Inv. Line"."No.")
                {
                }
                column(Vendor_Article_No; "Purch. Inv. Line"."Vendor Article No")
                {
                }
                column(Description_PurchInvLine; DescriptionText)
                {
                }
                column(Quantity_PurchInvLine; "Purch. Inv. Line".Quantity)
                {
                }
                column(Unit_PriceLCY; "Purch. Inv. Line"."Unit Cost" * CurrencyFactor)
                {

                }
                column(LineAmountLCY; "Purch. Inv. Line"."Line Amount" * CurrencyFactor)
                {

                }
                column(VATLCY; VatAmt * CurrencyFactor)
                {

                }
                column(AmountIncVAT; "Purch. Inv. Line"."Amount Including VAT" * CurrencyFactor)
                {

                }
                column(UnitCost_PurchInvLine; "Purch. Inv. Line"."Unit Cost")
                {
                }
                column(UnitofMeasure_PurchInvLine; "Purch. Inv. Line"."Unit of Measure")
                {
                }
                column(VAT_PurchInvLine; "Purch. Inv. Line"."VAT %")
                {
                }
                column(VATBaseAmount_PurchInvLine; "Purch. Inv. Line"."VAT Base Amount")
                {
                }
                column(LineAmount_PurchInvLine; "Purch. Inv. Line"."Line Amount")
                {
                }
                column(LineDiscountAmount_PurchInvLine; "Purch. Inv. Line"."Line Discount Amount")
                {
                }
                column(AmountIncludingVAT_PurchInvLine; "Purch. Inv. Line"."Amount Including VAT")
                {
                }
                column(Amount_PurchInvLine; "Purch. Inv. Line".Amount)
                {
                }

                column(UnitofMeasureCode_PurchInvLine; "Purch. Inv. Line"."Unit of Measure Code")
                {
                }
                column(Brand; BrandDesc) { }
                column(InvDiscountAmount_PurchInvLine; "Purch. Inv. Line"."Inv. Discount Amount")
                {
                }

                trigger OnAfterGetRecord()
                var
                    RecBrand: Record "Item Brands";
                    RecItem: Record Item;
                begin
                    //IF "Purch. Inv. Line"."No." <> '' THEN
                    IF "Purch. Inv. Line".Type <> "Purch. Inv. Line".Type::" " THEN
                        SNo += 1;

                    if "Purch. Inv. Line".Type = "Purch. Inv. Line".Type::" " then
                        IsComment := true
                    else
                        IsComment := false;
                    //Amount := "Purchase Line"."Unit Cost" * "Purchase Line"."Unit Cost";

                    VatAmt := ("Purch. Inv. Line"."VAT Base Amount" * "Purch. Inv. Line"."VAT %") / 100;


                    if "Purch. Inv. Line".Type = "Purch. Inv. Line".Type::Item then
                        ItemCode := "Purch. Inv. Line"."Vendor Article No"
                    else
                        ItemCode := '';//"Purchase Line"."No.";//Item code not required in case of G/L and charge
                    Clear(DescriptionText);
                    if "Purch. Inv. Line".Description <> '' then
                        DescriptionText := "Purch. Inv. Line".Description + ' ';
                    if "Purch. Inv. Line"."Description 2" <> '' then
                        DescriptionText += "Purch. Inv. Line"."Description 2" + ' ';
                    if "Purch. Inv. Line"."Description 3" <> '' then
                        DescriptionText += "Purch. Inv. Line"."Description 3" + ' ';
                    if "Purch. Inv. Line"."HL Line Type" <> '' then
                        DescriptionText += '*TYPE ' + "Purch. Inv. Line"."HL Line Type" + '*';

                    Clear(BrandDesc);
                    if "Purch. Inv. Line".Type = "Purch. Inv. Line".Type::Item then begin
                        if RecItem.GET("No.") then begin
                            if RecItem.Type = RecItem.Type::Inventory then begin
                                Clear(RecBrand);
                                RecBrand.SetRange(Code, RecItem.Brand);
                                if RecBrand.FindFirst() then
                                    BrandDesc := RecBrand.Description;
                            end;
                        end;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    SNo := 0;

                    CLEAR(tvar);
                    CLEAR(Amount1);
                    CLEAR(TotalAmt);
                end;
            }
            dataitem("Purch. Comment Line"; "Purch. Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemLinkReference = "Purch. Inv. Header";
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("Posted Invoice"));
                column(Comment_PurchCommentLine; "Purch. Comment Line".Comment)
                {
                }
            }

            trigger OnAfterGetRecord()
            VAR
                RecPurchLine: Record "Purch. Inv. Line";
            begin

                IF VendorRec.GET("Buy-from Vendor No.") THEN BEGIN
                    Name_Vend := VendorRec.Name;
                    Add_Vend := VendorRec.Address;
                    Add2_Vend := VendorRec."Address 2";
                END;
                Clear(RecPurchLine);
                //RecPurchLine.SetRange("Document Type", RecPurchLine."Document Type"::Invoice);
                RecPurchLine.SetRange("Document No.", "No.");
                RecPurchLine.SetFilter("Purchase Order No.", '<>%1', '');
                if RecPurchLine.FindFirst() then begin
                    PurchaseOrderNO := RecPurchLine."Purchase Order No.";

                    CLEAR(OrderNo);
                    PurchReceipt_Rec.RESET;
                    PurchReceipt_Rec.SETRANGE("Order No.", PurchaseOrderNO);
                    IF PurchReceipt_Rec.FINDFIRST THEN
                        OrderNo := PurchReceipt_Rec."No.";
                end else begin
                    PurchaseOrderNO := '';
                    OrderNo := '';
                end;


                IF "Purch. Inv. Header"."Currency Code" = '' THEN
                    CurrCode := 'AED'
                ELSE
                    CurrCode := "Purch. Inv. Header"."Currency Code";
                //<LT>


                //LT>
                //<LT>
                Currency_Rec.RESET;
                IF Currency_Rec.GET(CurrCode) THEN
                    DecimalDec := Currency_Rec."Decimal Description";
                //<\LT>
                //<LT>
                GLSetupG.GET;
                if "Purch. Inv. Header"."Currency Code" <> GLSetupG."LCY Code" then
                    IsDiffCurrency := true
                else
                    IsDiffCurrency := false;
                Clear(CurrencyFactor);//
                if "Purch. Inv. Header"."Currency Factor" <> 0 then
                    CurrencyFactor := 1 / "Purch. Inv. Header"."Currency Factor"
                else
                    CurrencyFactor := 1;


                Clear(tvar);
                Clear(TotalAmt);
                "Purch. Inv. Header".CalcFields("Amount Including VAT");
                TotalAmt := "Purch. Inv. Header"."Amount Including VAT";
                tvar := (ROUND(TotalAmt) MOD 1 * 100);
                InitTextVariable;
                FormatNoText(AmtInwrd11, tvar, '');
                AmtInwrd12 := AmtInwrd11[1];
                IF AmtInwrd12 = '' THEN
                    AmtInwrd12 := 'ZERO';
                InitTextVariable;
                FormatNoText(Amount_Words, TotalAmt, '');
                Text := Amount_Words[1];
                AmountText1 := Text + ' ' + CurrCode + ' AND ' + AmtInwrd12 + ' ' + DecimalDec + ' ONLY';
                //<LT>
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(CompanyInfo."Header Image");
                CompanyInfo.CalcFields("Footer Image");
                CLEAR(Name_Vend);
                CLEAR(Add2_Vend);
                CLEAR(CurrCode);
                CLEAR(DecimalDec);
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


                Clear(CompanyAddress);
                Clear(CompanyTelAndFax);
                if CompanyInfo.Address <> '' then
                    CompanyAddress := CompanyInfo.Address + ', ';

                if CompanyInfo."Address 2" <> '' then
                    CompanyAddress += CompanyInfo."Address 2" + ', ';

                if CompanyInfo."Post Code" <> '' then
                    CompanyAddress += 'P.O. Box ' + CompanyInfo."Post Code" + ', ';

                if CompanyInfo.City <> '' then
                    CompanyAddress += CompanyInfo.City + ' - ';

                if CompanyInfo."Country/Region Code" <> '' then
                    CompanyAddress += CompanyInfo."Country/Region Code";
                if CompanyInfo."Phone No." <> '' then
                    CompanyTelAndFax := 'T. ' + CompanyInfo."Phone No." + ', ';
                if CompanyInfo."Fax No." <> '' then
                    CompanyTelAndFax += 'F. ' + CompanyInfo."Fax No.";
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

    var
        VendorRec: Record 23;
        PurchaseOrderNO: Text;
        IsComment: Boolean;
        DescriptionText: Text;
        ItemCode: Text;
        Add_Vend: Text;
        Add2_Vend: Text;
        Name_Vend: Text;
        Amount: Decimal;
        SNo: Integer;
        VatAmt: Decimal;
        Discount: Decimal;
        CompanyAddress: Text;
        CompanyInfo: Record 79;
        CheckRep: Report 1401;
        DisAmt: Decimal;
        CompanyTelAndFax: Text;
        AmtIncVat: Decimal;
        NoText: array[3] of Text;
        AmtInWord: Text;
        CurrCode: Code[20];
        AmtDec: Decimal;
        BrandDesc: Text;
        Amount1: Decimal;
        TotalAmt: Decimal;
        AmtInwrd11: array[2] of Text;
        AmtInwrd12: Text;
        Amount_Words: array[2] of Text;
        Text: Text;
        AmountText1: Text;
        TotalAmount1: Decimal;
        Amount3: Decimal;
        Amount2: Decimal;
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
        Instructions: Label 'This is electronically generated document, no stamp or signature is required.';
        Ins2: Label 'Goods recieved in good condition.';
        Ins3: Label 'EXCHANGE/RETRUN POLICY : Credit will be given for Items returned within 10 days of product puurchase, subject to them being in good condition & in original packing. NO CASH REFUND.';

        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        tvar: Integer;
        PurchReceipt_Rec: Record 120;
        OrderNo: Code[20];
        Currency_Rec: Record 4;
        DecimalDec: Text[250];
        Users: Record User;
        CurrencyFactor: Decimal;
        IsDiffCurrency: Boolean;
        GLSetupG: Record "General Ledger Setup";

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
        /*IF GenJnlLine."Currency Code" = '' THEN
          Currency.InitRoundingPrecision
        ELSE BEGIN
          Currency.GET(GenJnlLine."Currency Code");
          Currency.TESTFIELD("Amount Rounding Precision");
        END;
        EXIT(1 / Currency."Amount Rounding Precision");*/

    end;
}

