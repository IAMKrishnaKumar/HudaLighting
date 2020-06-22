table 50161 "Daily Activities"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Posted,UnPosted;
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Business Unit"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Source Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Creation Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Posted Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(11; "Unposted Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = General,Sales,Purchases,"Cash Receipts",Payments,Assets,Intercompany,Jobs,"Payroll Accrual",Deposits,"Sales Tax","Whse Receipt","Whse Shipment","Sales Invoice","Purchase Invoice";
        }
    }

    keys
    {
        key(PK; Status, "Document No.", "Business Unit")
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