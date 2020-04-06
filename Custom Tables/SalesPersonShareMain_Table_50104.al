table 50103 "Sales Person Main"
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
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            // "Dimension Value".Code WHERE (Global Dimension No.=CONST(1),Blocked=CONST(No))
        }
        field(4; "Salesperson"; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Salesperson/Purchaser".Code;
            // ValidateTableRelation = true;
        }
        field(5; "Share %"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CalcFields(Sales, COGS);
                "Shared Sales" := (Sales * "Share %") / 100;
                "Shared COGS" := (COGS * "Share %") / 100;
            end;
        }
        field(6; SOGS; Decimal)
        {
            Caption = 'Sales';
            FieldClass = FlowField;
            CalcFormula = - Sum ("G/L Entry".Amount WHERE("G/L Account No." = FILTER(300110 .. 300160)));
            ObsoleteState = Removed;
        }
        field(7; COGS; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("G/L Entry".Amount where("G/L Account No." = filter(300310 .. 300340 | 300510 .. 300850), "Global Dimension 1 Code" = field("Opportunity No")));
        }
        field(8; "Shared SOGS"; Decimal)
        {
            Caption = 'Shared Sales';
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
        }
        field(9; "Shared COGS"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Shared Sales"; Decimal)
        {
            Caption = 'Shared Sales';
            DataClassification = ToBeClassified;
        }
        field(11; Sales; Decimal)
        {
            Caption = 'Sales';
            FieldClass = FlowField;
            CalcFormula = - Sum ("G/L Entry".Amount WHERE("G/L Account No." = FILTER(300110 .. 300160), "Global Dimension 1 Code" = field("Opportunity No")));
        }
        field(12; "Oustanding Amount (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Sales Line"."Outstanding Amount (LCY)" where("Document Type" = const(Order), "Shortcut Dimension 1 Code" = field("Opportunity No")));
        }
    }

    keys
    {
        key(PK; "Opportunity No", Salesperson)
        {
            Clustered = true;
        }
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