xmlport 50106 ImporSalesLineToStaging
{
    Caption = 'Import Sales Line To Staging';
    Direction = Import;
    Format = VariableText;
    TextEncoding = UTF8;
    FieldSeparator = ',';
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(SalesLine; "Sales Line Buffer")
            {
                Fieldelement("Sales_Order_No."; SalesLine."Sales Order No.")
                { }
                Fieldelement("HL_Line_Type"; SalesLine."Line Type")
                { }
                Fieldelement("Vendor_Article_No."; SalesLine."Vendor Article No.")
                { }
                Fieldelement(VendorNumber; SalesLine."vendor No.")
                {
                }
                Fieldelement("Line_Quantity"; SalesLine.Quantity)
                { }
                Fieldelement("Unit_Price_Excl_VAT"; SalesLine."Unit Price")
                { }
                Fieldelement("Line_Discount_Percentage"; SalesLine."Line Discount %")
                { }
                Fieldelement("Estimated_Cost"; SalesLine."Estimated Cost")
                { }
                trigger OnAfterInitRecord()
                begin
                    if Pagecaption = true then begin
                        Pagecaption := false;
                        RowNumber += 1;
                        currXMLport.Skip();
                    end;
                end;

                trigger OnBeforeInsertRecord()
                var
                    myInt: Integer;
                begin
                    SalesLine.UploadedBy := UserId;
                    nRecNum += 1;
                    dlgProgress.UPDATE(1, nRecNum);
                end;
            }
        }
    }
    trigger OnPreXmlPort()
    begin
        Pagecaption := true;
        RowNumber := 0;

        dlgProgress.OPEN(tcProgress);
    end;


    trigger OnPostXmlPort()
    begin
        dlgProgress.CLOSE;
    end;

    var
        Pagecaption: Boolean;
        RowNumber: Integer;
        EvalDecimal: Decimal;

        dlgProgress: Dialog;
        nRecNum: Integer;
        tcProgress: Label 'Uploading Records #1';
}