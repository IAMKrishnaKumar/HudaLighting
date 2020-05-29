tableextension 50118 SalesInvLine extends "Sales Invoice Line"
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
            // FieldClass = FlowField;
            // CalcFormula = lookup (Item."Vendor Article No" WHERE ("No." = FIELD ("No.")));
            DataClassification = ToBeClassified;
            //  TableRelation = if (Type = const (Item)) Item."Vendor Article No" where ("No." = field ("No."));
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
        }
        field(50005; "PO Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "PO Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Estimated GP"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; "Description 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
        }
        field(50010; "Brand"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60000; "Item Type"; Option)
        {
            OptionMembers = Inventory,Service,"Non-Inventory";
            FieldClass = FlowField;
            CalcFormula = lookup (Item.Type where("No." = field("No.")));
        }
    }

    var
        myInt: Integer;
}