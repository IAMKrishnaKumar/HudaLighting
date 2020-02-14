tableextension 50148 RequisionLine extends "Requisition Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Vendor Article No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Brand"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Brands".Code;
        }
        field(50002; "HL Line Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
        }
        field(50003; "Ref Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}