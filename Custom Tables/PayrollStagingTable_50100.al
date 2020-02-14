table 50100 "Payroll Staging"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Document Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation="G/L Account"."No.";
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Dimension Value".Code;
        }
        field(7; "Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Dimension Value".Code;
        }
        field(8; Narration; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Entry Date and Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Processing Date and Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Integration Status"; Option)
        {
            OptionMembers = Pending,Processed,"Wait for Re-attempt",Error,Duplicate;
            DataClassification = ToBeClassified;
        }
        field(12; "Processing Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Error Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Retry Count"; Integer)
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