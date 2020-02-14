table 50110 "Vendor Article List"
{
    DataClassification = ToBeClassified;
    DataPerCompany = false;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(3; "Vendor Article No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Common Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {

        key(PK; "Vendor No.", "Vendor Article No.")
        {

        }
        key(pk2; "Entry No.")
        {

        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}