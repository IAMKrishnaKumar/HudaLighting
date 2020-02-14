table 50111 "Notification Document Type"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Notification Document Type";
    LookupPageId = "Notification Document Type";
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Document Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(pk; "Document Type")
        {

        }
        key(PK1; "Entry No.")
        {
            Clustered = true;
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