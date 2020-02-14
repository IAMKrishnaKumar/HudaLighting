table 50106 "Notification Details"
{
    DataClassification = ToBeClassified;

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
            // OptionMembers = LC,"Bank Guarantee","PDC Receipts","PDC Issue";
            TableRelation = "Notification Document Type"."Document Type";
        }
        field(3; "Due Date Formula"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Document Type")
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