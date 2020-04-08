report 50126 "Sales Invoice Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Custom Reports\REPOSITORY\Sales Invoice\Sales Invoice Report.rdlc';
    Caption = 'Sales Invoice Report';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Sales Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(No_SalesHeader; "Sales Header"."No.")
            {
            }
            column(PostingDate_SalesHeader; "Sales Header"."Posting Date")
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
            column(CompanyInfo_BankName; CompanyInfo."Bank Name")
            {

            }
            column(CompanyInfo_BankAccountNo; CompanyInfo."Bank Account No.")
            {

            }
            column(CompanyInfo_SWIFT; CompanyInfo."SWIFT Code")
            {

            }
            column(LPORef; LPORef)
            {

            }
            column(CompanyInfo_IBAN; CompanyInfo.IBAN)
            {

            }
            column(Arabic_VATRegCap; Arabic_VATRegCap)
            {
            }
            column(contactPerson; contactPerson)
            {

            }
            column(OANo; OANo)
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
            column(IsArabic; IsArabic)
            {

            }
            column(currencyCodeCaption; currencyCodeCaption)
            {

            }
            column(Currency_Factor; "Currency Factor")
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

            column(UnitCaption; UnitCaption)
            {

            }
            column(PriceCaption; PriceCaption)
            {

            }
            column(DiscCaption; DiscCaption)
            {

            }
            column(SPEmail; SPEmail)
            {

            }
            column(SPName; SPName)
            {

            }
            column(PaymentTermsDesc; PaymentTermsDesc)
            {

            }
            column(Remark1; CompanyInfo."Remark Text 1")
            {

            }
            column(Remark2; CompanyInfo."Remark Text 2")
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
            column(IsTandC; IsTandC)
            {

            }
            column(CompanyAddress; CompanyAddress)
            {

            }
            column(CompanyInfoHomPage; CompanyInfo."Home Page")
            {

            }
            column(Duplicate; Duplicate)
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
            column(CurrencyCode_SalesHeader; CurrCode)
            {
            }
            column(ShiptoAddress_SalesHeader; "Sales Header"."Ship-to Address")
            {
            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {

            }
            column(ShipmentMethod; ShipmentMethod)
            {

            }
            column(CustCity; Customer_Rec.City)
            {

            }
            column(CustCountry; Customer_Rec."Country/Region Code")
            {

            }
            column(SPPhone; SPPhone)
            {
            }
            column(Project_Name; "Project Name")
            {
            }
            column(Project_Reference; "Project Reference")
            {
            }
            column(ShiptoAddress2_SalesHeader; "Sales Header"."Ship-to Address 2")
            {
            }
            column(Ship_to_City; "Ship-to City")
            {

            }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code")
            {

            }
            column(ExternalDocumentNo_SalesHeader; "Sales Header"."External Document No.")
            {
            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {
            }
            column(Cust_No; Customer_Rec."No.")
            {
            }
            column(Cust_Name; Customer_Rec.Name)
            {
            }
            column(Cust_Address; Customer_Rec.Address)
            {
            }
            column(Cust_Address2; Customer_Rec."Address 2")
            {
            }
            column(Cust_VatTegNo; Customer_Rec."VAT Registration No.")
            {
            }
            column(Customer_Contact; Customer_Rec.Contact)
            {
            }
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
            column(CurrencyFactor; CurrencyFactor)
            {

            }
            column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Country; CompanyInfo."Country/Region Code")
            {
            }
            column(Instructions; Instructions) { }
            column(Ins2; Ins2) { }
            column(Ins3; Ins3) { }
            column(IsDiffCurrency; IsDiffCurrency)
            {
            }
            column(CurrecncyCode; "Sales Header"."Currency Code")
            {

            }
            column(LCYCODE; GLSetupG."LCY Code")
            {

            }
            column(CompanyInfo_PostCode;
            CompanyInfo."Post Code")
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
            column(CompanyInfo_vatRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfo_PhoneNol; CompanyInfo."Phone No.")
            {
            }
            column(CustNo_cap; CustNo_cap)
            {
            }
            column(CustName_Cap; CustName_Cap)
            {
            }
            column(CustAddress_Cap; CustAddress_Cap)
            {
            }
            column(CustAddress2_Cap; CustAddress2_Cap)
            {
            }
            column(VatReg_Cap; VatReg_Cap)
            {
            }
            column(Contact_cap; Contact_cap)
            {
            }
            column(Sodate_cap; Sodate_cap)
            {
            }
            column(SONo_Cap; SONo_Cap)
            {
            }
            column(CusRefNo_cap; CusRefNo_cap)
            {
            }
            column(DeliverYAdd_Cap; DeliverYAdd_Cap)
            {
            }
            column(DeliverYAdd2_Cap; DeliverYAdd2_Cap)
            {
            }
            column(CurrencyCode_cap; CurrencyCode_cap)
            {
            }
            column(SrNo_Cap; SrNo_Cap)
            {
            }
            column(ItemCode_Cap; ItemCode_Cap)
            {
            }
            column(Desc_cap; Desc_cap)
            {
            }
            column(Qty_cap; Qty_cap)
            {
            }
            column(UOM_Cap; UOM_Cap)
            {
            }
            column(Price_Cap; Price_Cap)
            {
            }
            column(Discount_cap; Discount_cap)
            {
            }
            column(Amount_Cap; Amount_Cap)
            {
            }
            column(VatAmt_Cap; VatAmt_Cap)
            {
            }
            column(NetAmount_Cap; NetAmount_Cap)
            {
            }
            column(Summary_Cap; Summary_Cap)
            {
            }
            column(TotalAmt_cap; TotalAmt_cap)
            {
            }
            column(TotalDisc_cap; TotalDisc_cap)
            {
            }
            column(TotalvatAmt_Cap; TotalvatAmt_Cap)
            {
            }
            column(NetTotal_cap; NetTotal_cap)
            {
            }
            column(Createdby_cap; Createdby_cap)
            {
            }
            column(Approvedby_Cap; Approvedby_Cap)
            {
            }
            column(Receivedby_Cap; Receivedby_Cap)
            {
            }
            dataitem("Sales Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending);
                column(SrNo; SrNo)
                {
                }
                column(DocumentNo_SalesLine; "Sales Line"."Document No.")
                {
                }
                column(No_SalesLine; "Sales Line"."No.")
                {
                }
                column(Line_No_; "Line No.")
                {

                }
                column(Description_SalesLine; DescriptionText)
                //"Sales Line".Description + ' ' + "Sales Line"."Description 2" + ' ' + "Sales Line"."Description 3")
                {
                }
                column(Brand; BrandDesc)//Brand)
                {

                }
                column(Quantity_SalesLine; LineQuantity)
                {
                }
                column(UnitofMeasure_SalesLine; "Sales Line"."Unit of Measure")
                {
                }
                column(UnitPrice_SalesLine; "Sales Line"."Unit Price")
                {
                }
                column(Unit_PriceLCY; "Sales Line"."Unit Price" * CurrencyFactor)
                {

                }
                column(LineAmountLCY; ("Sales Line".Amount - "Sales Line"."Inv. Discount Amount") * CurrencyFactor)
                {

                }
                column(VATLCY; VatAmt * CurrencyFactor)
                {

                }
                column(LineDiscount_SalesLine; "Sales Line"."Line Discount %")
                {
                }
                column(Amount_SalesLine; "Sales Line".Amount)
                {
                }
                column(VatAmt; VatAmt)
                {
                }
                column(VendorArticleNo; Itemcode)//"Sales Line"."Vendor Article No")
                {
                }
                column(AmountText1; AmountText1)
                {
                }
                column(LineDiscountAmount_SalesLine; "Sales Line"."Line Discount Amount")
                {
                }
                column(DicsountLCY; "Sales Line"."Line Discount Amount" * CurrencyFactor)
                {
                }
                column(AmountIncludingVAT_SalesLine; "Sales Line"."Amount Including VAT")
                {
                }
                column(AmountIncVAT; "Sales Line"."Amount Including VAT" * CurrencyFactor)
                {
                }
                column(InvDiscountAmount_SalesLine; "Sales Line"."Inv. Discount Amount")
                {
                }
                column(LineAmount_SalesLine; "Sales Line"."Line Amount" - "Sales Line"."Inv. Discount Amount")
                {
                }
                column(UnitofMeasureCode_SalesLine; "Sales Line"."Unit of Measure Code")
                {
                }
                column(VatPercentagevalue; "Sales Line"."VAT %")
                {

                }
                column(ItemDescArabic; ItemDescArabic)
                {

                }
                trigger OnAfterGetRecord()
                var
                    RecSnpSetup: Record "Sales & Receivables Setup";
                    RecBrand: Record "Item Brands";
                begin
                    RecSnpSetup.GET;
                    if ("Sales Line".Type = Type::"G/L Account") AND ("Sales Line"."No." = RecSnpSetup."Retail Advance Account") then
                        CurrReport.Skip();
                    IF "Sales Line"."No." <> '' THEN
                        SrNo += 1;

                    Clear(LineQuantity);
                    if "Sales Line".Type = "Sales Line".Type::"G/L Account" then
                        LineQuantity := 0
                    else
                        LineQuantity := "Sales Line".Quantity;


                    // VatAmt := "Sales Line"."Amount Including VAT" - "Sales Line"."Line Amount";
                    VatAmt := ("Sales Line"."VAT Base Amount" * "Sales Line"."VAT %") / 100;

                    // TotalAmt += "Sales Line"."Amount Including VAT";

                    Clear(CurrencyFactor);
                    if "Sales Header"."Currency Factor" <> 0 then
                        CurrencyFactor := 1 / "Sales Header"."Currency Factor"
                    else
                        if "Sales Header"."Currency Factor" <> 0 then
                            CurrencyFactor := 1;
                    //<LT>

                    //MESSAGE('%1',AmountText1);
                    //<LT>
                    Clear(ItemCode);
                    Clear(BrandDesc);
                    if "Sales Line".Type = "Sales Line".Type::Item then begin
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

                            if RecItem.Type = RecItem.Type::Inventory then begin
                                ItemCode := "Sales Line"."Vendor Article No";
                                Clear(RecBrand);
                                RecBrand.SetRange(Code, RecItem.Brand);
                                if RecBrand.FindFirst() then
                                    BrandDesc := RecBrand.Description;
                            end;
                        end;


                    end;

                    Clear(DescriptionText);
                    if "Sales Line".Description <> '' then
                        DescriptionText := "Sales Line".Description + ' ';
                    if "Sales Line"."Description 2" <> '' then
                        DescriptionText += "Sales Line"."Description 2" + ' ';
                    if "Sales Line"."Description 3" <> '' then
                        DescriptionText += "Sales Line"."Description 3" + ' ';
                    if "Sales Line"."HL Line Type" <> '' then
                        DescriptionText += '*TYPE ' + "Sales Line"."HL Line Type" + '*';
                end;

                trigger OnPreDataItem()
                begin
                    SrNo := 0;

                    CLEAR(VatAmt);
                    CLEAR(Amount2);
                    CLEAR(Amount3);
                    CLEAR(TotalAmt);
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLinkReference = "Sales Header";
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("Posted Invoice"));

                column(Comment_SalesCommentLine; "Sales Comment Line".Comment)
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                RecSP: Record "Salesperson/Purchaser";
                RecSM: Record "Shipment Method";
                RecPT: Record "Payment Terms";
                RecSnpSetup: Record "Sales & Receivables Setup";
                RecSalesLine: Record "Sales Invoice Line";
                Sheader: Record "Sales Header";
            begin
                Clear(CustNameArabic);
                Clear(CustAddressArabic);
                Clear(CustAdd2Arabic);
                Clear(Customer_Rec);
                Clear(SPName);
                Clear(SPEmail);
                Clear(SPPhone);
                Clear(ShipmentMethod);
                Clear(LPORef);
                Clear(RecSalesLine);
                RecSalesLine.SetRange("Document No.", "No.");
                RecSalesLine.SetFilter("Sales Order No.", '<>%1', '');
                if RecSalesLine.FindFirst() then begin
                    OANo := RecSalesLine."Sales Order No.";
                    Clear(Sheader);
                    if Sheader.GET(Sheader."Document Type"::Order, RecSalesLine."Sales Order No.") then
                        LPORef := Sheader."PO Reference";
                end;
                IF Customer_Rec.GET("Sales Header"."Sell-to Customer No.") THEN begin
                    CustNameArabic := Customer_Rec."Name - Arabic";
                    CustAddressArabic := Customer_Rec."Address-Arabic";
                    CustAdd2Arabic := Customer_Rec."Address 2 - Arabic";
                end;

                Clear(RecPT);
                Clear(PaymentTermsDesc);
                IF RecPT.GET("Payment Terms Code") then
                    PaymentTermsDesc := RecPT.Description;

                IF "Sales Header"."Currency Code" = '' THEN
                    CurrCode := 'AED'
                ELSE
                    CurrCode := "Sales Header"."Currency Code";

                GLSetupG.GET;
                /* if "Sales Header"."Currency Code" <> GLSetupG."LCY Code" then
                     IsDiffCurrency := true
                 else
                     IsDiffCurrency := false;
                     */
                //<LT>
                Currency_Rec.RESET;
                IF Currency_Rec.GET(CurrCode) THEN
                    DecimalDec := Currency_Rec."Decimal Description";
                //<\LT>
                Clear(RecSM);
                RecSM.SetRange(Code, "Sales Header"."Shipment Method Code");
                if RecSM.FindFirst() then
                    ShipmentMethod := RecSM.Description;

                Clear(RecSP);
                RecSP.SetRange(Code, "Sales Header"."Salesperson Code");
                if RecSP.FindFirst() then begin
                    SPName := RecSP.Name;
                    SPEmail := RecSP."E-Mail";
                    SPPhone := RecSP."Phone No.";
                end;

                RecSnPSetup.GET;
                Clear(RecSalesLine);
                //RecSalesLine.SetRange("Document Type", RecSalesLine."Document Type"::Invoice);
                RecSalesLine.SetRange("Document No.", "No.");
                RecSalesLine.SetRange(Type, RecSalesLine.Type::"G/L Account");
                RecSalesLine.SetRange("No.", RecSnPSetup."Retail Advance Account");
                if RecSalesLine.FindSet() then;
                RecSalesLine.CalcSums("Amount Including VAT");

                "Sales Header".CalcFields("Amount Including VAT");
                Clear(tvar);
                Clear(TotalAmt);
                TotalAmt := "Sales Header"."Amount Including VAT" - RecSalesLine."Amount Including VAT";
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
            var

            begin

                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS("Header Image");
                CompanyInfo.CalcFields("Footer Image");
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
                    field(IsTandC; IsTandC)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Terms and Conditions';
                    }
                    field(IsArabic; IsArabic)
                    {
                        Caption = 'Print Arabic';
                        ApplicationArea = All;
                    }
                    field(Duplicate; Duplicate)
                    {
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
    }

    labels
    {
    }

    var
        ItemDescArabic: Text;
        OANo: Text;
        BrandDesc: Text;
        Duplicate: Boolean;
        AmountIncVAT: Decimal;
        PaymentTermsDesc: Text;
        CompanyAddress: Text;
        CompanyTelAndFax: Text;
        ForHudaLightingcaption: Label 'For Huda Lighting';
        GeneralTnC_Caption: Label 'General Terms & Conditions';
        ReportCaption: Label 'TAX INVOICE';
        CustNameArabic: Text;
        DescriptionText: Text;
        ItemCode: Text;
        SPName: Text;
        SPEmail: Text;
        IsTandC: Boolean;
        CustAddressArabic: Text;
        CustAdd2Arabic: Text;
        RecItem: Record Item;
        ShipmentMethod: Text;
        SPPhone: Text;
        IsArabic: Boolean;
        LineQuantity: Decimal;
        RecItemCat: Record "Item Category";
        ItemCat: Record "Item Category";
        Arabic_OA: Label 'فاتورة ضريبية';
        Arabic_CustNOCap: Label 'رقم العميل';
        Arabic_VATRegCap: Label 'رقم التسجيل بضريبة القيمة المضافة';
        contactPerson: Label 'مسؤول التواصل';
        DelAddCaption: Label 'عنوان التسليم';
        OADateCaption: Label 'التاريخ';
        OANumberCaption: Label 'رقم الفاتورة';
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
        NetTotal: Label 'صافي القيمة';
        TotalAmountInArabic: Label 'المبلغ الإجمالي ﻛﺗﺎﺑﺔ';
        Customer_Rec: Record 18;
        CompanyInfo: Record 79;
        SrNo: Integer;
        CustNo_cap: Label 'Customer No.';
        CustName_Cap: Label 'Customer Name';
        CustAddress_Cap: Label 'Customer Address';
        CustAddress2_Cap: Label 'Customer Address2';
        VatReg_Cap: Label 'VAT Reg. No.';
        Contact_cap: Label 'Contact Person';
        Sodate_cap: Label 'S.O Date';
        SONo_Cap: Label 'SO Number';
        CusRefNo_cap: Label 'Cus.Ref.No.';
        DeliverYAdd_Cap: Label 'Delivery Address';
        DeliverYAdd2_Cap: Label 'Delivery Address2';
        CurrencyCode_cap: Label 'Currency Code';
        SrNo_Cap: Label 'Sr.No.';
        ItemCode_Cap: Label 'Item Code';
        Desc_cap: Label 'Description';
        Qty_cap: Label 'Quantity';
        UOM_Cap: Label 'UOM';
        Price_Cap: Label 'Price';
        Discount_cap: Label 'Dis.Amt';
        Amount_Cap: Label 'Amount';
        VatAmt_Cap: Label 'VAT Amt';
        NetAmount_Cap: Label 'Net Amount';
        Summary_Cap: Label 'Summary';
        TotalAmt_cap: Label 'Total Amount';
        TotalDisc_cap: Label 'Total Discount';
        TotalvatAmt_Cap: Label 'Total VAT Amount';
        NetTotal_cap: Label 'Net Total';
        Createdby_cap: Label 'Created By';
        Approvedby_Cap: Label 'Approved By';
        Receivedby_Cap: Label 'Received By';
        VatAmt: Decimal;
        Instructions: Label 'Cheque to be issued in favour of ';
        Ins2: Label 'Goods recieved in good condition.';
        Ins3: Label 'EXCHANGE/RETURN POLICY : Credit will be given for Items returned within 10 days of product puurchase, subject to them being in good condition & in original packing. NO CASH REFUND.';

        GLSetup: Record 98;
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
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        GenJnlLine: Record 81;
        tvar: Decimal;
        Amount1: Decimal;
        TotalAmt: Decimal;
        AmtInwrd11: array[2] of Text;
        AmtInwrd12: Text;
        GLSetupG: Record "General Ledger Setup";
        Amount_Words: array[2] of Text;
        Text: Text;
        CurrencyFactor: Decimal;
        AmountText1: Text;
        TotalAmount1: Decimal;
        Amount3: Decimal;
        IsDiffCurrency: Boolean;
        Amount2: Decimal;
        CurrCode: Code[10];
        Currency_Rec: Record 4;
        DecimalDec: Text[250];
        Users: Record User;
        UserName: Text;
        LPORef: Text;


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

