tableextension 50139 PurchCrMemo extends "Purch. Cr. Memo Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "HL Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(50001; "HL Sales Line No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(50002; "Vendor Article No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; Comments; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Description 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Brand"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Brands".Code;
        }
        field(50022; "HL Line Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}