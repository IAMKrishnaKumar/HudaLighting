table 50107 "Sales Order Staging"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Customer No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Project Reference No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Project Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Sales Person"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Estimated Order Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Order Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Requested Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Promised Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Currency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Payment Terms "; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Opportunity No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Entry Date and Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Processing Date and Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Integration Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Pending,Processed,"Wait for Re-attempt",Error,Duplicate;
        }
        field(16; "Processing Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Error Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Retry Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
        }
        field(20; "PO Reference"; Text[50])
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