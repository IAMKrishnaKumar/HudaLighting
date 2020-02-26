report 50122 "Purchase  Credit Memo Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Custom Reports\REPOSITORY\Purch Credit Memo\Purchase Cr Memo.rdlc';
    Caption = 'Purchase  Credit Memo Report';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Purchase Header"; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Buy-from Vendor No.";
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
            }
            column(BuyfromVendorNo_PurchaseHeader; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(IsArabic; IsArabic)
            {

            }
            column(IsDiffCurrency; IsDiffCurrency)//
            {

            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(Applies_to_Doc__No_; "Applies-to Doc. No.")
            {
            }
            column(CompanyInfo_vatRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyTelAndFax; CompanyTelAndFax)
            { }
            column(CompanyInfo_WebSite; CompanyInfo."Home Page")
            { }
            column(CompanyInfo_Email; 'E. ' + CompanyInfo."E-Mail")
            { }
            column(CompanyInfoHomPage; CompanyInfo."Home Page")
            {
            }

            column(CompanyDisplayName; CompanyInfo.Name)
            { }
            column(CurrecncyCode; "Purchase Header"."Currency Code")//
            {

            }
            column(CustNameArabic; CustNameArabic)
            { }
            column(CustAdd2Arabic; CustAdd2Arabic)
            { }
            column(CustAddressArabic; CustAddressArabic)
            {

            }
            column(Arabic_OA; Arabic_OA)
            {

            }
            column(Arabic_CustNOCap; Arabic_CustNOCap)
            {

            }
            column(Arabic_VATRegCap; Arabic_VATRegCap)
            {

            }
            column(contactPerson; contactPerson)
            {

            }
            column(DelAddCaption; DelAddCaption)
            {

            }
            column(OADateCaption; OADateCaption)
            {

            }
            column(OANumberCaption; OANumberCaption)
            {

            }

            column(custRefNo; custRefNo)
            {

            }
            column(currencyCodeCaption; currencyCodeCaption)
            {

            }
            column(ProjectNameCaption; ProjectNameCaption)
            {

            }
            column(ProjectRefCaption; ProjectRefCaption)
            {

            }
            column(ItemCodeCaption; ItemCodeCaption)
            {

            }
            column(ItemDescCaption; ItemDescCaption)
            {

            }
            column(Quanity; Quanity)
            {

            }
            column(LCYCODE; GLSetupG."LCY Code")
            {

            }
            column(UnitCaption; UnitCaption)
            {

            }
            column(PriceCaption; PriceCaption)
            {

            }
            column(DiscCaption; DiscCaption)
            {

            }
            column(AmountCaption; AmountCaption)
            {

            }
            column(VATCaption; VATCaption)
            {

            }
            column(VAT_; "VAT%")
            {

            }
            column(NetAmountCaption; NetAmountCaption)
            {

            }
            column(TotalCaption; TotalCaption)
            {

            }
            column(SummaryCaption; SummaryCaption)
            {

            }
            column(TotalAmountCaption; TotalAmountCaption)
            {

            }
            column(TotalDiscountCaption; TotalDiscountCaption)
            {

            }
            column(CurrencyFactor; CurrencyFactor)//
            {

            }
            column(TotalVATAmount; TotalVATAmount)
            {

            }
            column(NetTotal_; NetTotal)
            {

            }
            column(TotalAmountInArabic; TotalAmountInArabic)
            {

            }
            column(Amount__In_Arabic_; "Amount (In Arabic)")
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
            column(BuyfromContact_PurchaseHeader; "Purchase Header"."Buy-from Contact")
            {
            }
            column(VATRegistrationNo_PurchaseHeader; "Purchase Header"."VAT Registration No.")
            {
            }
            column(PostingDate_PurchaseHeader; "Purchase Header"."Posting Date")
            {
            }
            column(ShiptoAddress_PurchaseHeader; "Purchase Header"."Ship-to Address")
            {
            }
            column(ShiptoAddress2_PurchaseHeader; "Purchase Header"."Ship-to Address 2")
            {
            }
            column(CurrencyCode_PurchaseHeader; CurrCode)
            {
            }
            column(No; InvoiceNo)
            {
            }
            column(Purch_VendorInvoiceNo; VendorInvoiceNo)
            {
            }
            column(ExpectedReceiptDate_PurchaseHeader; "Purchase Header"."Expected Receipt Date")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo."Header Image")
            {
            }
            column(FooterImage; CompanyInfo."Footer Image")
            {
            }
            column(Instructions; Instructions) { }
            column(Ins2; Ins2) { }
            column(Ins3; Ins3) { }
            column(ComName; CompanyInfo.Name)
            {
            }
            column(UserName; UserName)
            {
            }
            column(CompAddress; CompanyInfo.Address)
            {
            }
            column(CompCity; CompanyInfo.City)
            {
            }
            column(CoMpanyInfo_Add2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_Postcode; CompanyInfo."Post Code")
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
            column(TRN; CompanyInfo."VAT Registration No.")
            {
            }
            column(PurchHead_VendorShipmentNo; "Purchase Header"."Vendor Cr. Memo No.")
            {
            }
            column(AmountText1; AmountText1)
            {
            }
            dataitem("Purchase Line"; "Purch. Cr. Memo Line")
            {
                DataItemLinkReference = "Purchase Header";
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending);
                column(DocumentNo_PurchaseLine; "Purchase Line"."Document No.")
                {
                }
                column(VatPercentagevalue; "Purchase Line"."VAT %")//
                {

                }
                column(ItemDescArabic; ItemDescArabic)//
                {

                }

                column(No_PurchaseLine; "Purchase Line"."No.")
                {
                }
                column(Vendor_Article_No; ItemCode)//"Purchase Line"."Vendor Article No")
                {
                }
                column(Unit_PriceLCY; "Purchase Line"."Unit Cost" * CurrencyFactor)
                {
                }
                column(LineAmountLCY; "Purchase Line".Amount * CurrencyFactor)
                {
                }
                column(VATLCY; VatAmt * CurrencyFactor)
                {
                }
                column(Description_PurchaseLine; "Purchase Line".Description)
                {
                }
                column(Quantity_PurchaseLine; "Purchase Line".Quantity)
                {
                }
                column(UnitCost_PurchaseLine; "Purchase Line"."Unit Cost")
                {
                }
                column(UnitofMeasure_PurchaseLine; "Purchase Line"."Unit of Measure")
                {
                }
                column(VAT_PurchaseLine; "Purchase Line"."VAT %")
                {
                }
                column(LineAmount_PurchaseLine; "Purchase Line"."Line Amount" - "Purchase Line"."Inv. Discount Amount")
                {
                }
                column(InvDiscountAmount_PurchaseLine; "Purchase Line"."Inv. Discount Amount")
                {
                }
                column(AmountIncVAT; "Purchase Line"."Amount Including VAT" * CurrencyFactor)
                {

                }
                column(VATBaseAmount_PurchaseLine; "Purchase Line"."VAT Base Amount")
                {
                }
                column(AmountIncludingVAT_PurchaseLine; "Purchase Line"."Amount Including VAT")
                {
                }
                column(LineDiscount_PurchaseLine; Discount)
                {
                }
                column(LineDiscountAmount_PurchaseLine; "Purchase Line"."Line Discount Amount")
                {
                }
                column(Amount; Amount)
                {
                }
                column(SNo; SNo)
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
                column(UnitofMeasureCode_PurchaseLine; "Purchase Line"."Unit of Measure Code")
                {
                }
                column(Amount_PurchaseLine; "Purchase Line".Amount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF "Purchase Line"."No." <> '' THEN
                        SNo += 1;

                    Amount := "Purchase Line"."Unit Cost" * "Purchase Line"."Unit Cost";
                    VatAmt := ("Purchase Line"."VAT Base Amount" * "Purchase Line"."VAT %") / 100;
                    //VatAmt := "Purchase Line"."Amount Including VAT" - "Purchase Line"."Line Amount";

                    Discount := "Purchase Line"."Line Discount %";
                    //MESSAGE('%1',"Purchase Line"."Line Discount %");
                    Clear(ItemCode);
                    if "Purchase Line".Type = "Purchase Line".Type::Item then
                        ItemCode := "Purchase Line"."Vendor Article No"
                    else
                        ItemCode := '';

                    AmtIncVat += "Purchase Line"."Amount Including VAT";

                    tvar := (ROUND(AmtIncVat) MOD 1 * 100);

                    Clear(CurrencyFactor);//
                    if "Purchase Header"."Currency Factor" <> 0 then
                        CurrencyFactor := 1 / "Purchase Header"."Currency Factor"
                    else
                        CurrencyFactor := 1;

                    if "Purchase Line".Type = "Purchase Line".Type::Item then begin
                        Clear(RecItem);
                        Clear(ItemDescArabic);
                        if RecItem.GET("No.") then begin
                            Clear(RecItemCat);
                            RecItemCat.SetRange(Code, RecItem."Item Category Code");
                            if RecItemCat.FindFirst() then begin
                                if RecItemCat."Arabic Name" <> '' then
                                    ItemDescArabic := RecItemCat."Arabic Name"
                                else begin
                                    Clear(ItemCat);
                                    ItemCat.SetRange(Code, RecItemCat."Parent Category");
                                    if ItemCat.FindFirst() then
                                        ItemDescArabic := ItemCat."Arabic Name";
                                end;
                            end;
                        end;
                    end;

                end;

                trigger OnPreDataItem()
                begin
                    SNo := 0;

                    CLEAR(Amount);
                    CLEAR(SNo);
                    CLEAR(VatAmt);
                    CLEAR(Discount);
                    CLEAR(AmtIncVat)
                end;
            }

            dataitem("Purch. Comment Line"; "Purch. Comment Line")
            {
                DataItemLinkReference = "Purchase Header";
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.");
                column(Comment_PurchCommentLine; "Purch. Comment Line".Comment)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF VendorRec.GET("Buy-from Vendor No.") THEN BEGIN
                    Name_Vend := VendorRec.Name;
                    Add_Vend := VendorRec.Address;
                    Add2_Vend := VendorRec."Address 2";
                END;
                GLSetupG.GET;
                /*if "Purchase Header"."Currency Code" <> GLSetupG."LCY Code" then
                    IsDiffCurrency := True//true
                else
                    IsDiffCurrency := false;*/

                IF "Purchase Header"."Currency Code" = '' THEN
                    CurrCode := 'AED'
                ELSE
                    CurrCode := "Purchase Header"."Currency Code";

                CLEAR(VendorInvoiceNo);
                CLEAR(InvoiceNo);

                //<LT>
                PurchaseInvoiceHeader_Rec.RESET;
                IF PurchaseInvoiceHeader_Rec.GET("Applies-to Doc. No.") THEN BEGIN
                    VendorInvoiceNo := PurchaseInvoiceHeader_Rec."Vendor Invoice No.";
                    InvoiceNo := PurchaseInvoiceHeader_Rec."No.";
                END;
                //<LT>
                Currency_Rec.RESET;
                IF Currency_Rec.GET(CurrCode) THEN
                    DecimalDec := Currency_Rec."Decimal Description";
                //<\LT>


                //header
                Clear(tvar);
                Clear(TotalAmt);
                "Purchase Header".CalcFields("Amount Including VAT");
                TotalAmt := "Purchase Header"."Amount Including VAT";
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
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(CompanyInfo."Header Image");
                CompanyInfo.CalcFields("Footer Image");
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
            area(Content)
            {
                group(General)
                {
                    field(IsArabic; IsArabic)
                    {
                        Caption = 'Print Arabic';
                        ApplicationArea = All;
                    }
                    field(IsDiffCurrency; IsDiffCurrency)
                    {
                        ApplicationArea = All;
                        Caption = 'Print in Dual Currency';
                    }
                }
            }
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
        ItemDescArabic: Text;
        CustNameArabic: Text;
        IsArabic: Boolean;
        ItemCode: Text;
        CurrencyFactor: Decimal;//
        IsDiffCurrency: Boolean;
        CustAddressArabic: Text;
        CustAdd2Arabic: Text;
        CompanyAddress: Text;
        CompanyTelAndFax: Text;
        RecItemCat: Record "Item Category";
        ItemCat: Record "Item Category";
        Arabic_OA: Label 'إشعار مدين ضريبي';
        Arabic_CustNOCap: Label 'رقم العميل';
        Arabic_VATRegCap: Label 'رقم التسجيل بضريبة القيمة المضافة';
        contactPerson: Label 'مسؤول التواصل';
        DelAddCaption: Label 'عنوان التسليم';
        OADateCaption: Label 'تاريخ';
        OANumberCaption: Label 'رقم مذكرة الائتمان';
        custRefNo: Label 'رقم مرجع العميل';
        currencyCodeCaption: Label 'العملة';
        ProjectNameCaption: Label 'إسم المشروع';
        ProjectRefCaption: Label 'رقم مرجع المشروع';
        ItemCodeCaption: Label 'رقم الصنف';
        ItemDescCaption: Label 'البيان';
        Quanity: Label 'الكمية';
        UnitCaption: Label 'وحدة القياس';
        PriceCaption: Label 'السعر';
        DiscCaption: Label 'خصم';
        AmountCaption: Label 'القيمة';
        VATCaption: Label 'قيمة ضريبة القيمة المضافة';
        "VAT%": Label 'نسبة ضريبة القيمة المضافة';
        NetAmountCaption: Label 'ﺻﺎﻓﻲ اﻟﻘﯾﻣﺔ';
        TotalCaption: Label 'مجموع';
        SummaryCaption: Label 'ملخص';
        TotalAmountCaption: Label 'المبلغ الإجمالي';
        TotalDiscountCaption: Label 'إجمالي الخصم';
        TotalVATAmount: Label 'المبلغ الإجمالي لضريبة القيمة المضافة';
        NetTotal: Label 'المجموع الصافي';
        TotalAmountInArabic: Label 'المبلغ الإجمالي ﻛﺗﺎﺑﺔ';
        RecItem: Record Item;

        Add_Vend: Text;
        Add2_Vend: Text;
        Name_Vend: Text;
        Amount: Decimal;
        SNo: Integer;
        VatAmt: Decimal;
        Discount: Decimal;
        CompanyInfo: Record 79;
        CheckRep: Report 1401;
        DisAmt: Decimal;
        AmtIncVat: Decimal;
        NoText: array[3] of Text;
        AmtInWord: Text;
        CurrCode: Code[20];
        AmtDec: Decimal;
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
        Instructions: Label 'Cheque to be issued in favour of BAYT AL TAWREED TRADING L.L.C.';
        Ins2: Label 'Goods recieved in good condition.';
        Ins3: Label 'EXCHANGE/RETRUN POLICY : Credit will be given for Items returned within 10 days of product puurchase, subject to them being in good condition & in original packing. NO CASH REFUND.';

        PurchaseInvoiceHeader_Rec: Record 122;
        PurchaseHeader_Rec: Record 38;
        VendorInvoiceNo: Code[20];
        InvoiceNo: Code[20];
        Am: Decimal;
        Currency_Rec: Record 4;
        DecimalDec: Text[250];
        TotalAmt: Decimal;
        OnesText: array[20] of Text[30];
        GLSetupG: Record "General Ledger Setup";
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        tvar: Integer;
        Amount1: Decimal;
        AmtInwrd11: array[2] of Text;
        AmtInwrd12: Text;
        Amount_Words: array[2] of Text;
        Text: Text;
        AmountText1: Text;
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

