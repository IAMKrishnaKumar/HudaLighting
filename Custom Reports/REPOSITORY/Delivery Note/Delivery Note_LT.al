report 50130 "Delivery Note LT"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Custom Reports\REPOSITORY\Delivery Note\Delivery Note.rdl';
    Caption = 'Delivery Note';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Sales Header"; "Warehouse Shipment Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);

            RequestFilterFields = "No.";
            column(No_SalesHeader; "Sales Header"."No.")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(SalesOrderNo; SalesOrderNo)
            {

            }
            column(Assigned_User_ID; "Assigned User ID")
            {
            }
            column(PostingDate_SalesHeader; "Shipment Date")//"Sales Header"."Posting Date")
            {
            }
            column(CurrencyCode_SalesHeader; CurrCode)
            {
            }
            column(ExternalDocumentNo_SalesHeader; "Sales Header"."External Document No.")
            {
            }
            column(Cust_No; Customer_Rec."No.")
            {
            }
            column(Assignment_Date; "Assignment Date")
            {

            }
            column(Duplicate; Duplicate)
            {

            }
            column(Assignment_Time; "Assignment Time")
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
            column(UserName; UserName)
            {
            }
            column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Country; CompanyInfo."Country/Region Code")
            {
            }
            column(Instructions; Instructions) { }
            column(Instructions2; Instructions2) { }

            column(CompanyInfo_PostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo."Header Image")
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
            column(CustNo; CustNo)
            { }
            column(CustName; CustName)
            { }
            column(CustAdd1; CustAdd1)
            { }
            column(CustVatRegNo; CustVatRegNo)
            {
            }
            column(CompanyInfoHomPage; CompanyInfo."Home Page")
            {

            }
            column(ContactPerson; ContactPerson)
            {
            }
            column(DeliveryAddress; DeliveryAddress)
            {

            }
            column(Project_Name; ProjectName)
            {

            }
            column(PO_Reference; POReference)
            {

            }
            column(Project_Reference; ProjectRef)
            {

            }
            column(PaymentTermsDesc; PaymentTermsDesc)
            {

            }
            column(ShipmentMethod; ShipmentMethod)
            {

            }
            column(CompanyAddress; CompanyAddress)
            {

            }
            column(CompanyInfo_Email; 'E. ' + CompanyInfo."E-Mail")
            { }
            column(CompanyTelAndFax; CompanyTelAndFax)
            { }
            column(CurrencyCode; CurrencyCode)
            {

            }
            column(Delivery_Time; DeliveryTime)
            {

            }
            column(OpportunityNo; OpportunityNo)
            {

            }
            column(CompanyDisplayName; CompanyInfo.Name)//CompanyInfo."Ship-to Name")
            { }
            column(SPName; SPname)
            {

            }
            column(SPPhone; SPPhone)
            {

            }
            column(SPEmail; SPEmail)
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
            dataitem("Sales Line"; "Warehouse Shipment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.", "Line No.")
                                    ORDER(Ascending);
                column(SrNo; SrNo)
                {
                }
                column(DocumentNo_SalesLine; "Sales Line"."No.")
                {
                }
                column(Brand; Brand)
                {

                }
                column(No_SalesLine; "Sales Line"."No.")
                {
                }
                column(Description_SalesLine; DescriptionText)
                {
                }
                column(Quantity_SalesLine; "Sales Line"."Qty. to Ship")
                {
                }
                column(VendorArticleNo; "Sales Line"."Vendor Article No")
                {
                }
                column(AmountText1; AmountText1)
                {
                }
                column(UnitofMeasureCode_SalesLine; "Sales Line"."Unit of Measure Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    "Sales Line".SetFilter(Quantity, '>%1', 0);

                    IF "Sales Line"."No." <> '' THEN
                        SrNo += 1;
                    if Quantity = 0 then
                        CurrReport.Skip();
                    //   VatAmt := "Sales Line"."Amount Including VAT" - "Sales Line"."Line Amount";

                    if ("Source Document" = "Source Document"::"Sales Order") AND ("Source No." <> '') then begin
                        SalesOrderNo := "Source No.";
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

                    //<LT>
                    CLEAR(tvar);
                    CLEAR(Amount1);
                    tvar := (ROUND(TotalAmt) MOD 1 * 100);

                    InitTextVariable;
                    FormatNoText(AmtInwrd11, tvar, '');
                    AmtInwrd12 := AmtInwrd11[1];
                    IF AmtInwrd12 = '' THEN
                        AmtInwrd12 := 'ZERO';

                    InitTextVariable;
                    FormatNoText(Amount_Words, TotalAmt, '');
                    Text := Amount_Words[1];

                    AmountText1 := Text + ' AND ' + AmtInwrd12 + ' ' + DecimalDec + 'ONLY';
                    //MESSAGE('%1',AmountText1);
                    //<LT>
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

            trigger OnAfterGetRecord()
            var
                Sheader: Record "Sales Header";
                WSLine: Record "Warehouse Shipment Line";
                RecCust: Record Customer;
                PaymentTerms: Record "Payment Terms";
                RecSM: Record "Shipment Method";
                RecSP: Record "Salesperson/Purchaser";

            begin
                Customer_Rec.RESET;
                //<LT>
                Currency_Rec.RESET;
                IF Currency_Rec.GET(CurrCode) THEN
                    DecimalDec := Currency_Rec."Decimal Description";
                //<\LT>
                Clear(WSLine);
                WSLine.SetRange("No.", "Sales Header"."No.");
                if WSLine.FindFirst() then begin
                    if WSLine."Source Document" = WSLine."Source Document"::"Sales Order" then begin
                        Clear(Sheader);
                        Sheader.SetRange("Document Type", Sheader."Document Type"::Order);
                        Sheader.SetRange("No.", WSLine."Source No.");
                        if Sheader.FindFirst() then begin
                            CustNo := Sheader."Sell-to Customer No.";
                            CustName := Sheader."Sell-to Customer Name";
                            CustAdd1 := Sheader."Sell-to Address";
                            if Sheader."Sell-to Address 2" <> '' then
                                CustAdd1 += ', ' + Sheader."Sell-to Address 2";
                            if Sheader."Sell-to City" <> '' then
                                CustAdd1 += ', ' + Sheader."Sell-to City";
                            if Sheader."Sell-to Country/Region Code" <> '' then
                                CustAdd1 += ', ' + Sheader."Sell-to Country/Region Code";
                            if Sheader."Sell-to Post Code" <> '' then
                                CustAdd1 += ', ' + Sheader."Sell-to Post Code";
                            Clear(RecCust);
                            IF RecCust.GET(Sheader."Sell-to Customer No.") THEN
                                CustVatRegNo := RecCust."VAT Registration No.";
                            ContactPerson := Sheader."Sell-to Contact";

                            DeliveryAddress := Sheader."Ship-to Address";
                            if Sheader."Ship-to Address 2" <> '' then
                                DeliveryAddress += ', ' + Sheader."Ship-to Address 2";
                            if Sheader."Ship-to City" <> '' then
                                DeliveryAddress += ', ' + Sheader."Ship-to City";
                            if Sheader."Ship-to Post Code" <> '' then
                                DeliveryAddress += ', ' + Sheader."Ship-to Post Code";
                            if Sheader."Ship-to Country/Region Code" <> '' then
                                DeliveryAddress += ', ' + Sheader."Ship-to Country/Region Code";

                            ProjectName := Sheader."Project Name";
                            ProjectRef := Sheader."Project Reference";
                            Clear(PaymentTermsDesc);
                            IF PaymentTerms.GET(Sheader."Payment Terms Code") Then begin
                                PaymentTermsDesc := PaymentTerms.Description;
                            end;
                            Clear(RecSM);
                            RecSM.SetRange(Code, "Sales Header"."Shipment Method Code");
                            if RecSM.FindFirst() then
                                ShipmentMethod := RecSM.Description;
                            CurrencyCode := Sheader."Currency Code";
                            DeliveryTime := Sheader."Delivery Time";
                            OpportunityNo := Sheader."Shortcut Dimension 1 Code";


                            Clear(RecSP);
                            RecSP.SetRange(Code, Sheader."Salesperson Code");
                            if RecSP.FindFirst() then begin
                                SPName := RecSP.Name;
                                SPEmail := RecSP."E-Mail";
                                SPPhone := RecSP."Phone No.";
                            end;
                            POReference := Sheader."PO Reference";
                        end;
                    end;
                end;
            end;

            trigger OnPreDataItem()
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
                    field(Duplicate; Duplicate)
                    {
                        ApplicationArea = All;
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
        Customer_Rec: Record 18;
        Duplicate: Boolean;
        SalesOrderNo: Text;
        CompanyInfo: Record 79;
        OpportunityNo: Text;
        PaymentTermsDesc: Text;
        ShipmentMethod: Text;
        CurrencyCode: Text;
        DeliveryTime: Text;
        SPname: Text;
        SPEmail: Text;
        DescriptionText: Text;
        SPPhone: Text;
        SrNo: Integer;
        POReference: Text;
        CustNo_cap: Label 'Customer No.';
        CustName_Cap: Label 'Customer Name';
        CustAddress_Cap: Label 'Customer Address';
        CustAddress2_Cap: Label 'Customer Address2';
        VatReg_Cap: Label 'VAT Registration No.';
        Contact_cap: Label 'Contact Person';
        Sodate_cap: Label 'S.O Date';
        SONo_Cap: Label 'SO Number';
        CompanyAddress: Text;
        CompanyTelAndFax: Text;
        CusRefNo_cap: Label 'Cus.Ref.No.';
        DeliverYAdd_Cap: Label 'Delivery Address';
        DeliverYAdd2_Cap: Label 'Delivery Address2';
        CurrencyCode_cap: Label 'Currency Code';
        SrNo_Cap: Label 'SL.No.';
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
        Instructions: Label 'Delivery received in good condition';
        Instructions2: Label 'Exchange and Return Policy: Credit will be given for items returned within ten days from the date of purchase subject only if items are returned in the original condition and packing. No cash refund.';
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
        Amount_Words: array[2] of Text;
        Text: Text;
        AmountText1: Text;
        TotalAmount1: Decimal;
        Amount3: Decimal;
        Amount2: Decimal;
        CurrCode: Code[10];
        Currency_Rec: Record 4;
        DecimalDec: Text[250];
        Users: Record User;
        UserName: Text;
        CustNo: Text[20];
        CustName: Text[100];
        CustAdd1: Text[100];
        CustAdd2: Text[50];
        CustCity: Text;
        CustState: Text;
        CustCountry: Text;
        CustZip: Text;
        CustVatRegNo: Text;
        ContactPerson: Text;
        DeliveryAddress: Text;
        ProjectName: Text;
        ProjectRef: Text;






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

