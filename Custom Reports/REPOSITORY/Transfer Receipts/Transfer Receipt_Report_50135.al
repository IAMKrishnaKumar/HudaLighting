report 50135 "Transfer Receipt Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Custom Reports\REPOSITORY\Transfer Receipts\Transfer Receipt.rdlc';
    Caption = 'Posted Transfer Receipt';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Receipt Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Posting Date";
            column(No_; "No.")
            {

            }
            column(Transfer_Order_Date; "Transfer Order Date")
            {

            }
            column(ComName; CompanyInfo.Name)
            {
            }
            column(Transfer_Order_No_; "Transfer Order No.")
            {

            }
            column(CompanyAddress; CompanyAddress)
            {

            }
            column(CompanyInfo_WebSite; CompanyInfo."Home Page")
            { }
            column(CompanyInfoHomPage; CompanyInfo."Home Page")
            {

            }
            column(CompanyInfo_Email; 'E. ' + CompanyInfo."E-Mail")
            { }
            column(CompanyInfo_vatRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(Instructions; Instructions) { }
            column(Instructions2; Instructions2) { }
            column(CompanyTelAndFax; CompanyTelAndFax)
            { }

            column(Transfer_from_Address; "Transfer-from Address")
            {

            }
            column(CompanyInfo_FooterImagee_; CompanyInfo."Footer Image")
            {
            }
            column(CompanyInfoPicture; CompanyInfo."Header Image")
            {
            }
            column(UserName; UserName)
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
            column(Transfer_from_Address_2; "Transfer-from Address 2")
            {
            }
            column(Transfer_from_City; "Transfer-from City")
            {
            }
            column(Transfer_from_Code; "Transfer-from Code")
            {

            }
            column(Transfer_from_Contact; "Transfer-from Contact")
            {

            }
            column(Transfer_from_County; "Transfer-from County")
            {

            }
            column(Transfer_from_Name; "Transfer-from Name")
            {

            }
            column(Transfer_from_Name_2; "Transfer-from Name 2")
            {

            }
            column(Transfer_from_Post_Code; "Transfer-from Post Code")
            {

            }
            column(Transfer_to_Address; "Transfer-to Address")
            {

            }
            column(Transfer_to_Address_2; "Transfer-to Address 2")
            {

            }
            column(Transfer_to_City; "Transfer-to City")
            {

            }
            column(Transfer_to_Code; "Transfer-to Code")
            {

            }
            column(Transfer_to_Contact; "Transfer-to Contact")
            {

            }
            column(Transfer_to_County; "Transfer-to County")
            {

            }
            column(Transfer_to_Name; "Transfer-to Name")
            {

            }
            column(Transfer_to_Name_2; "Transfer-to Name 2")
            {

            }
            column(Transfer_to_Post_Code; "Transfer-to Post Code")
            {

            }
            column(Trsf__to_Country_Region_Code; "Trsf.-to Country/Region Code")
            {

            }
            column(Trsf__from_Country_Region_Code; "Trsf.-from Country/Region Code")
            {

            }
            column(Comment; Comment)
            {

            }
            column(Transport_Method; "Transport Method")
            {

            }
            column(Direct_Transfer; "Direct Transfer")
            {

            }
            column(Shipment_Date; "Shipment Date")
            {

            }
            column(Receipt_Date; "Receipt Date")
            {

            }

            dataitem("Transfer Shipment Line"; "Transfer Receipt Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending);
                column(SrNo; SrNo)
                {
                }
                column(Vendor_Article_No_; "Vendor Article No.")
                {

                }
                column(TotalQty; TotalQty)
                {

                }
                column(QtyShipped; QtyShipped)
                {

                }
                column(Item_No_; "Item No.")
                {

                }
                column(Description; Description + ' ' + "Description 2" + ' ' + "Description 3")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_of_Measure; "Unit of Measure")
                {

                }


                trigger OnAfterGetRecord()
                var
                    RecTrsnferLine: Record "Transfer Line";
                begin

                    IF "Transfer Shipment Line"."Item No." <> '' THEN
                        SrNo += 1;
                    Clear(RecTrsnferLine);
                    Clear(TotalQty);
                    Clear(QtyShipped);
                    RecTrsnferLine.SetRange("Document No.", "Transfer Order No.");
                    RecTrsnferLine.SetRange("Line No.", "Line No.");
                    if RecTrsnferLine.FindFirst() then begin
                        TotalQty := RecTrsnferLine.Quantity;
                        QtyShipped := RecTrsnferLine."Quantity Received";
                    end;
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
            begin

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
        }

        actions
        {
        }
    }

    labels
    {
    }

    var

        CompanyInfo: Record 79;
        SrNo: Integer;
        CustNo_cap: Label 'Customer No.';
        CustName_Cap: Label 'Customer Name';
        CompanyAddress: Text;
        CompanyTelAndFax: Text;
        CustAddress_Cap: Label 'Customer Address';
        CustAddress2_Cap: Label 'Customer Address2';
        VatReg_Cap: Label 'VAT Registration No.';
        Contact_cap: Label 'Contact Person';
        Sodate_cap: Label 'S.O Date';
        SONo_Cap: Label 'SO Number';
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
        TotalQty: Decimal;
        QtyShipped: Decimal;

}

