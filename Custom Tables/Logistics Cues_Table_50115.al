table 50115 "Logistics Cues"
{
    DataClassification = ToBeClassified;
    Caption = 'Logistics Cues';
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Available EXW"; Integer)
        {
            Caption = 'Available EXW This Week Projects';
            DataClassification = ToBeClassified;
        }
        field(3; "Shipments Arrival"; Integer)
        {
            Caption = 'Shipments Arrival This Week';
            DataClassification = ToBeClassified;
        }
        field(4; "Available EXW Retail"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Available EXW This Week Retail';
        }
        field(5; "Shipments Arrival Retail"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Shipments Arrival This Week Retail';
        }
        field(6; "Late Shipments"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Late Shipments';
        }
        field(7; "Customer Blocked"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Blocked';
        }
        field(8; "Focused Deliveries"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Focused Deliveries';
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