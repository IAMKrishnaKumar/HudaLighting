tableextension 50113 PurchInvLine extends "Purch. Inv. Line"
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
        //Do not add from 50004 to 50017, 50020,50023,50024,50025
        field(50018; "Description 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Purchase Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
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