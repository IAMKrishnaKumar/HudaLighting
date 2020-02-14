table 50102 "Sales Person Staging"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Effective Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Opportunity No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Salesperson"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Share %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Entry Date and Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Processing Date and Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Integration Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Pending,"Processed","Wait for Re-attempt",Error,Duplicate;
        }
        field(9; "Processing Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Error Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Retry Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK2; "Entry No.")
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