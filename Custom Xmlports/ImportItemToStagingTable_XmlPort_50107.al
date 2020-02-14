xmlport 50107 "Item Import To Buffer"
{
    Caption = 'Item uploader';
    Direction = Import;
    Format = VariableText;
    TextEncoding = UTF8;
    FieldSeparator = ',';
    UseRequestPage = false;


    schema
    {
        textelement(Root)
        {
            tableelement(ItemL; "Item Buffer")
            {
                fieldelement("Vendor_Article_No."; ItemL."Vendor Article No.")
                { }
                fieldelement("Vendor_No."; ItemL."Vendor No.")
                { }
                fieldelement("Description1"; ItemL.Description1)
                { }
                fieldelement("Description2"; ItemL.Description2)
                { }
                fieldelement("Description3"; ItemL.Description3)
                { }
                fieldelement("Type"; ItemL.Type)
                { }
                fieldelement("Base_unit_of_Measure"; ItemL."Base Unit Of Measure")
                { }
                fieldelement("Purchase_unit_of_Measure"; ItemL."Purchase Unit Of Measure")
                { }
                fieldelement("Sales_Unit_of_Measure"; ItemL."Sales Unit Of Measure")
                { }
                fieldelement("Item_Category_Code"; ItemL."Item Category Code")
                { }
                fieldelement("Brand_Dimension"; ItemL."Brand Dimension")
                { }
                fieldelement("Gen_Prod_Posting_Group"; ItemL."Gen. Prod. Posting group")
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
                    ItemL.UploadedBy := UserId;
                    nRecNum += 1;
                    if NOT ((ItemL."Base Unit Of Measure" = ItemL."Purchase Unit Of Measure") AND (ItemL."Base Unit Of Measure" = ItemL."Sales Unit Of Measure")) then
                        Error('All the Unit Of Measure must be same at Row No.:%1', nRecNum + 1);
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
        tStart := TIME;
    end;

    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        dlgProgress.CLOSE;
    end;


    var
        Pagecaption: Boolean;
        RowNumber: Integer;
        EvalDecimal: Decimal;
        dlgProgress: Dialog;
        nRecNum: Integer;
        tcProgress: Label 'Uploading Records #1';
        tcComplete: Label 'Upload complete.  %1 records imported in %2 seconds';
        tStart: Time;
}