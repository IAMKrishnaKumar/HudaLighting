tableextension 50106 SalesShipmentLine extends "Sales Shipment Line"
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
        field(50004; "HL_Purchase Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchase Order No.';
            TableRelation = "Purchase Header"."No." where("No." = field("Document No."), "Document Type" = const(Order));
        }
        field(50005; "PO Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchase Order Quantity';
        }
        field(50006; "PO Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchase Order Line No.';
        }
        field(50007; "Estimated GP"; Decimal)
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

        modify("No.")
        {
            trigger OnAfterValidate()
            var
                RecItem: Record Item;
                RecIC: Record "Item Category";
            begin
                if (Type = Type::Item) AND ("No." <> '') then begin
                    Clear(RecIC);
                    Clear(RecItem);
                    IF RecItem.GET("No.") then begin
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
        if (Type = Type::Item) AND ("No." <> '') then begin
            Clear(RecIC);
            Clear(RecItem);
            IF RecItem.GET("No.") then begin
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