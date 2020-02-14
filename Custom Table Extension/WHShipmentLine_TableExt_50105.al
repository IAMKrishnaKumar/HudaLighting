tableextension 50105 WHShipment extends "Warehouse Shipment Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Warranty Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Vendor Article No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "HL Line Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
        }
        field(50003; "Estimated Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Estimated GP"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Description 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Brand"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                RecItem: Record Item;
                RecIC: Record "Item Category";
            begin
                if "Item No." <> '' then begin
                    Clear(RecIC);
                    Clear(RecItem);
                    IF RecItem.GET("Item No.") then begin
                        if RecItem."Item Category Code" <> '' then begin
                            IF RecIC.Get(RecItem."Item Category Code") then begin
                                "Warranty Date" := CALCDATE(RecIC."Warranty Days", "Shipment Date");
                            end;
                        end;
                    end;
                end;
            end;
        }
        modify("Shipment Date")
        {
            trigger OnAfterValidate()
            var
                RecItem: Record Item;
                RecIC: Record "Item Category";

            begin
                if "Shipment Date" <> 0D then begin
                    Clear(RecIC);
                    Clear(RecItem);
                    IF RecItem.GET("Item No.") then begin
                        if RecItem."Item Category Code" <> '' then begin
                            IF RecIC.Get(RecItem."Item Category Code") then begin
                                "Warranty Date" := CALCDATE(RecIC."Warranty Days", "Shipment Date");
                            end;
                        end;
                    end;
                end;
            end;
        }
    }

    trigger OnBeforeModify()
    var

        RecItem: Record Item;
        RecIC: Record "Item Category";
    begin
        if "Shipment Date" <> 0D then begin
            Clear(RecIC);
            Clear(RecItem);
            IF RecItem.GET("Item No.") then begin
                if RecItem."Item Category Code" <> '' then begin
                    IF RecIC.Get(RecItem."Item Category Code") then begin
                        "Warranty Date" := CALCDATE(RecIC."Warranty Days", "Shipment Date");
                    end;
                end;
            end;
        end;
    end;


    var
        myInt: Integer;
}