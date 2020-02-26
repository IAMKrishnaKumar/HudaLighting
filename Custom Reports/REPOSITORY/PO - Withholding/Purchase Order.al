report 50155 "Purchase Order Withholding"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Custom Reports\REPOSITORY\PO - Withholding\Purchase Order.rdl';
    Caption = 'Purchase Order';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("No.", "Document Type")
                                ORDER(Ascending)
                                WHERE("Document Type" = FILTER(Order));
            RequestFilterFields = "Buy-from Vendor No.", "No.";
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
            }
            column(BuyfromVendorNo_PurchaseHeader; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(No__of_Archived_Versions; "No. of Archived Versions")
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
            //WithholdingTax
            column(WithholdingTax; WithholdingTax)
            {
            }
            column(BuyfromContact_PurchaseHeader; "Purchase Header"."Buy-from Contact")
            {
            }
            column(VATRegistrationNo_PurchaseHeader; VendorVATNo)
            {
            }
            column(PostingDate_PurchaseHeader; ApprovalDate)//"Purchase Header"."Order Date")//"Purchase Header"."Posting Date")
            {
            }
            column(ProjectName; "Purchase Header"."Project Name")
            {
            }
            column(Project_Reference; "Project Reference")
            {
            }
            column(PaymentTerms; PaymentTerms)
            {
            }
            column(ShiptoAddress_PurchaseHeader; "Purchase Header"."Ship-to Address")
            {
            }
            column(ShiptoAddress2_PurchaseHeader; "Purchase Header"."Ship-to Address 2")
            {
            }
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            {

            }
            column(ShiptoCity_PurchaseHeader; "Purchase Header"."Ship-to City")
            {
            }
            column(ShiptoCountry_PurchaseHeader; "Purchase Header"."Ship-to Country/Region Code")
            {
            }
            column(ShipToPhone; ShipToPhone) { }
            column(CurrencyCode_PurchaseHeader; CurrCode)
            {
            }
            column(ExpectedReceiptDate_PurchaseHeader; "Purchase Header"."Expected Receipt Date")
            {
            }
            column(CurrencyFactor; CurrencyFactor)
            {
            }
            column(IsDiffCurrency; IsDiffCurrency)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo."Header Image")
            {
            }
            column(UserName; UserName)
            {
            }
            column(FooterImage; CompanyInfo."Footer Image")
            {
            }
            column(Instructions; Instructions) { }
            column(Ins2; Ins2) { }
            column(Ins3; Ins3) { }
            column(Remark1; CompanyInfo."Remark Text 1")
            {

            }
            column(Delivery_Time; "Delivery Time")
            {

            }
            column(ShipmentMethod; ShipmentMethod)
            {

            }
            column(IsTandC; IsTandC)
            { }
            column(Remark2; CompanyInfo."Remark Text 2")
            {

            }
            column(IsDraft; IsDraft)
            {
            }
            column(ComName; CompanyInfo.Name)
            {
            }
            column(Amount__In_Arabic_; "Amount (In Arabic)")
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
            column(LCYCODE; GLSetupG."LCY Code")
            {

            }
            column(SPName; SPName)
            {

            }
            column(SPPhone; SPphone)
            { }
            column(SPEmail; SPEmail) { }
            column(CurrecncyCode; "Purchase Header"."Currency Code")
            {

            }
            column(CompEmail; CompanyInfo."E-Mail")
            {
            }
            column(TRN; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfoHomPage; CompanyInfo."Home Page")
            {

            }
            column(CompanyAddress; CompanyAddress)
            {

            }
            column(CompanyInfo_WebSite; CompanyInfo."Home Page")
            { }
            column(CompanyInfo_Email; 'E. ' + CompanyInfo."E-Mail")
            { }
            column(ReportCaption; ReportCaption)
            { }
            column(CompanyTelAndFax; CompanyTelAndFax)
            { }
            column(CompanyDisplayName; CompanyInfo.Name)//CompanyInfo."Ship-to Name")
            { }
            column(ForHudaLightingcaption; ForHudaLightingcaption)
            { }
            column(GeneralTnC_Caption; GeneralTnC_Caption)
            { }
            column(SalesOrderNo; SalesOrderNo)
            {
            }
            column(Receivedby_Cap; Receivedby_Cap)
            {
            }
            column(AmountText1; AmountText1)
            {
            }
            dataitem("Purch. Comment Line"; "Purch. Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemLinkReference = "Purchase Header";
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Order));
                column(Comment_PurchCommentLine; "Purch. Comment Line".Comment)
                {
                }
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    ORDER(Ascending);
                column(DocumentNo_PurchaseLine; "Purchase Line"."Document No.")
                {
                }
                column(No_PurchaseLine; "Purchase Line"."No.")
                {
                }
                column(Vendor_Article_No; ItemCode)
                {
                }
                column(Brand; BrandDesc) { }
                column(Unit_PriceLCY; "Purchase Line"."Unit Cost" * CurrencyFactor)
                {

                }
                column(LineAmountLCY; "Purchase Line"."Line Amount" * CurrencyFactor)
                {

                }
                column(VATLCY; VatAmt * CurrencyFactor)
                {

                }
                column(Description_PurchaseLine; DescriptionText)//"Purchase Line".Description)
                {
                }
                column(Quantity_PurchaseLine; LineQuantity)//"Purchase Line".Quantity)
                {
                }
                column(QuantityText; QtyText)//"Purchase Line".Quantity))
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
                column(AmountIncVAT; "Purchase Line"."Amount Including VAT" * CurrencyFactor)
                {

                }
                column(LineAmount_PurchaseLine; "Purchase Line"."Line Amount")
                {
                }
                column(InvDiscountAmount_PurchaseLine; "Purchase Line"."Inv. Discount Amount")
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
                column(ItemDescArabic; ItemDescArabic)
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
                var
                    RecBrand: Record "Item Brands";
                    GLSetup: Record "General Ledger Setup";
                begin

                    //WithholdingTax
                    GLSetup.GET;
                    if ("Purchase Line".Type = Type::"G/L Account") AND ("Purchase Line"."No." = GLSetup."With holding Tax Receivable GL") then
                        CurrReport.Skip();


                    IF "Purchase Line"."No." <> '' THEN
                        SNo += 1;

                    Clear(LineQuantity);
                    if "Purchase Line".Type = "Purchase Line".Type::"G/L Account" then
                        LineQuantity := 0
                    else
                        LineQuantity := "Purchase Line".Quantity;

                    if LineQuantity = 0 then
                        QtyText := ''
                    else
                        QtyText := Format(LineQuantity);

                    Amount := "Purchase Line"."Unit Cost" * "Purchase Line"."Unit Cost";
                    VatAmt := ("Purchase Line"."VAT Base Amount" * "Purchase Line"."VAT %") / 100;
                    //VatAmt := "Purchase Line"."Amount Including VAT" - "Purchase Line"."Line Amount";

                    Discount := "Purchase Line"."Line Discount %";

                    Clear(BrandDesc);
                    Clear(ItemCode);
                    Clear(ItemDescArabic);
                    if "Purchase Line".Type = "Purchase Line".Type::Item then begin
                        if RecItem.GET("No.") then begin
                            if RecItem.Type = RecItem.Type::Inventory then begin
                                Clear(RecBrand);
                                RecBrand.SetRange(Code, RecItem.Brand);
                                if RecBrand.FindFirst() then
                                    BrandDesc := RecBrand.Description;
                                ItemCode := "Purchase Line"."Vendor Article No";
                            end;
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

                    Clear(DescriptionText);
                    if "Purchase Line".Description <> '' then
                        DescriptionText := "Purchase Line".Description + ' ';
                    if "Purchase Line"."Description 2" <> '' then
                        DescriptionText += "Purchase Line"."Description 2" + ' ';
                    if "Purchase Line"."Description 3" <> '' then
                        DescriptionText += "Purchase Line"."Description 3" + ' ';
                    if "Purchase Line"."HL Line Type" <> '' then
                        DescriptionText += '*TYPE ' + "Purchase Line"."HL Line Type" + '*';
                end;

                trigger OnPreDataItem()
                begin
                    SNo := 0;
                    CLEAR(Amount);
                    CLEAR(SNo);
                    CLEAR(VatAmt);
                    CLEAR(Discount);
                    CLEAR(AmtIncVat);
                    IsTandC := false;
                end;
            }

            trigger OnAfterGetRecord()
            var
                RecSP: Record "Salesperson/Purchaser";
                RecSM: Record "Shipment Method";
                RecLocation: Record Location;
                RecPT: Record "Payment Terms";
                GLSetup: Record "General Ledger Setup";
                RecSalesLine: Record "Purchase Line";
                Pline: Record "Purchase Line";
                RecApprovalEntry: Record "Approval Entry";
            begin
                Clear(SPName);
                Clear(SPEmail);
                Clear(IsDraft);
                Clear(SPphone);
                Clear(ShipmentMethod);
                Clear(Name_Vend);
                Clear(Add_Vend);
                Clear(Add2_Vend);
                Clear(VendorVATNo);
                CalcFields("No. of Archived Versions");
                if "Purchase Header".Status <> "Purchase Header".Status::Released then
                    IsDraft := true
                else
                    IsDraft := false;

                IF VendorRec.GET("Buy-from Vendor No.") THEN BEGIN
                    Name_Vend := VendorRec.Name;
                    Add_Vend := VendorRec.Address;
                    Add2_Vend := VendorRec."Address 2";
                    VendorVATNo := VendorRec."VAT Registration No.";
                END;

                IF "Purchase Header"."Currency Code" = '' THEN
                    CurrCode := 'AED'
                ELSE
                    CurrCode := "Purchase Header"."Currency Code";

                //
                Clear(RecLocation);
                Clear(ShipToPhone);
                RecLocation.SetRange(Code, "Purchase Header"."Location Code");
                if RecLocation.FindFirst() then begin
                    ShipToPhone := RecLocation."Phone No.";
                end;
                //
                Clear(Pline);
                Pline.SetRange("Document Type", Pline."Document Type"::Order);
                Pline.SetRange("Document No.", "No.");
                Pline.SetFilter("HL Sales Order No.", '<>%1', '');
                if Pline.FindFirst() then begin
                    SalesOrderNo := Pline."HL Sales Order No.";
                end;
                //
                Clear(RecPT);
                RecPT.SetRange(Code, "Purchase Header"."Payment Terms Code");
                if RecPT.FindFirst() then begin
                    PaymentTerms := RecPT.Description;
                end;
                //
                //<LT>
                GLSetupG.GET;
                if "Purchase Header"."Currency Code" <> GLSetupG."LCY Code" then
                    IsDiffCurrency := False// true
                else
                    IsDiffCurrency := false;
                //<LT>
                Clear(CurrencyFactor);//
                if "Purchase Header"."Currency Factor" <> 0 then
                    CurrencyFactor := 1 / "Purchase Header"."Currency Factor"
                else
                    CurrencyFactor := 1;

                Currency_Rec.RESET;
                IF Currency_Rec.GET(CurrCode) THEN
                    DecimalDec := Currency_Rec."Decimal Description";
                //<\LT>
                Clear(RecSM);
                RecSM.SetRange(Code, "Purchase Header"."Shipment Method Code");
                if RecSM.FindFirst() then
                    ShipmentMethod := RecSM.Description;

                Clear(RecSP);
                RecSP.SetRange(Code, "Purchase Header"."Purchaser Code");
                if RecSP.FindFirst() then begin
                    SPName := RecSP.Name;
                    SPEmail := RecSP."E-Mail";
                    SPphone := RecSP."Phone No.";
                end;
                Clear(ApprovalDate);
                Clear(RecApprovalEntry);
                RecApprovalEntry.SetRange("Table ID", Database::"Purchase Header");
                RecApprovalEntry.SetRange("Document No.", "No.");
                RecApprovalEntry.SetRange(Status, RecApprovalEntry.Status::Approved);
                if RecApprovalEntry.FindLast() then
                    ApprovalDate := DT2DATE(RecApprovalEntry."Last Date-Time Modified")
                else
                    ApprovalDate := "Order Date";

                //WithholdingTax
                Clear(WithholdingTax);
                GLSetup.GET;
                Clear(RecSalesLine);
                RecSalesLine.SetRange("Document Type", "Document Type");
                RecSalesLine.SetRange("Document No.", "No.");
                RecSalesLine.SetRange(Type, RecSalesLine.Type::"G/L Account");
                RecSalesLine.SetRange("No.", GLSetup."With holding Tax Receivable GL");
                if RecSalesLine.FindSet() then;
                RecSalesLine.CalcSums("Amount Including VAT");
                WithholdingTax := RecSalesLine."Amount Including VAT";



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

        actions
        {
        }
    }


    labels
    {
    }

    var
        VendorRec: Record 23;
        SalesOrderNo: Text;
        CompanyAddress: Text;
        ApprovalDate: Date;
        WithholdingTax: Decimal;
        LineQuantity: Decimal;
        QtyText: Text;
        VendorVATNo: Text;
        DescriptionText: Text;
        ItemCode: Text;
        SPName: Text;
        SPphone: Text;
        SPEmail: Text;
        IsDraft: Boolean;
        CompanyTelAndFax: Text;
        IsTandC: Boolean;
        ShipToPhone: Text;
        PaymentTerms: Text;
        ReportCaption: Label 'PURCHASE ORDER';
        ForHudaLightingcaption: Label 'For Huda Lighting';
        GeneralTnC_Caption: Label 'General Terms & Conditions';
        RecItemCat: Record "Item Category";
        ItemCat: Record "Item Category";
        RecItem: Record "Item";
        ItemDescArabic: Text;
        Add_Vend: Text;
        Add2_Vend: Text;
        Name_Vend: Text;
        Amount: Decimal;
        SNo: Integer;
        VatAmt: Decimal;
        Discount: Decimal;
        CompanyInfo: Record 79;
        CheckRep: Report 1401;
        BrandDesc: Text;
        DisAmt: Decimal;
        AmtIncVat: Decimal;
        NoText: array[3] of Text;
        AmtInWord: Text;
        CurrCode: Code[20];
        AmtDec: Decimal;
        ShipmentMethod: Text;
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
        Receivedby_Cap: Label 'Received By';
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
        Ins3: Label 'EXCHANGE/RETURN POLICY : Credit will be given for Items returned within 10 days of product puurchase, subject to them being in good condition & in original packing. NO CASH REFUND.';

        TotalAmt: Decimal;
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        tvar: Integer;
        Amount1: Decimal;
        AmtInwrd11: array[2] of Text;
        AmtInwrd12: Text;
        Amount_Words: array[2] of Text;
        CurrencyFactor: Decimal;
        IsDiffCurrency: Boolean;
        GLSetupG: Record "General Ledger Setup";
        Text: Text;
        AmountText1: Text;
        Currency_Rec: Record 4;
        DecimalDec: Text[250];
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

