table 50104 "Sales Line Buffer"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Line Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Vendor Article No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Quantity; text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Unit Price"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Line Discount %"; text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Estimated Cost"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; UploadedBy; Code[50])
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