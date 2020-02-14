table 50112 "Item Buffer"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Vendor Article No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Vendor No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Description1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Description2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Description3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Base Unit Of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Purchase Unit Of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Sales Unit Of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Item Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Brand Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Gen. Prod. Posting group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; UploadedBy; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        UploadedBy := UserId;
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