tableextension 50142 TransferShipmen extends "Transfer Shipment Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Vendor Article No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Description 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                Recitem: Record Item;
            begin
                Clear(Recitem);
                if "Item No." <> '' then begin
                    IF Recitem.GET("Item No.") then begin
                        "Vendor Article No." := Recitem."Vendor Article No";
                        "Description 2" := Recitem."Description 2";
                        "Description 3" := Recitem."Description 3";
                    end;
                end else begin
                    "Vendor Article No." := '';
                    "Description 2" := '';
                    "Description 3" := '';
                end;
            end;
        }
    }

    var
        myInt: Integer;
}