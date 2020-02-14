table 50114 "Acc Manager Activies Cue"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "BG Sales Order - Due"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "LC Purchase Order - Due"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Customer Legal Reg Exp - Due"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Legal Registration Expiry - Due';
        }
        field(5; "LC Sales Order - Due"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Retention-Pending Invoicing"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Advance-Pending Invoice"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No")
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