table 50116 "Sales Order Split"
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
        field(3; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "LPO No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Project Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Client Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
        }
        field(8; "Sales Person"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }
        field(9; "Share %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Invoiced GL (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Invoiced Non Stock (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Invoiced GL (ACY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Invoiced Non Stock (ACY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "UE Sales (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "UE Sales (ACY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "UE GP (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "UE GP (ACY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Shared UE Sales (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Shared UE GP (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Shared UE Sales (ACY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Shared UE GP (ACY)"; Decimal)
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