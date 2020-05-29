table 50118 "Email Alert Log"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Email Alert Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,"OA Approval Alert","Materials Received by the Whse. Alert","Invoice Posting Alert","Pick Materials Alert","Scheduled Gen. Proj. Status Report";
        }
        field(3; "Email Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Sent,Error;
        }
        field(4; "Error Remarks"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Last Modified DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Email For Record"; RecordID)
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
        abc: Record "Approval Entry";

    trigger OnInsert()
    begin
        "Last Modified DateTime" := CurrentDateTime();
    end;

    trigger OnModify()
    begin
        "Last Modified DateTime" := CurrentDateTime();
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}