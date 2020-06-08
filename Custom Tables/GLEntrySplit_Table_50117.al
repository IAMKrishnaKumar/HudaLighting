table 50117 "GL Entry Split"
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
        field(4; "G/L Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
        }
        field(6; "Sales Person"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }
        field(7; "Share %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Add. Currency Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "G/L Account Category "; Option)
        {
            OptionMembers = ,Assets,Liabilities,Equity,Income,"Cost of Goods Sold",Expense;
            FieldClass = FlowField;
            CalcFormula = lookup ("G/L Account"."Account Category" where("No." = field("G/L Account No.")));
        }
        field(11; "Shared Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Shared Add. Currency Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Blocked = CONST(false));
        }
        field(14; "Project Name"; Text[100])
        {
            FieldClass = FlowField;
            //CalcFormula = lookup ("Dimension Value".Name where("Dimension Code" = field("Shortcut Dimension 1 Code")));
            CalcFormula = lookup ("Dimension Value".Name where(Code = field("Shortcut Dimension 1 Code"), "Global Dimension No." = CONST(1)));
        }
        field(15; "G/L Entry No."; Integer)
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