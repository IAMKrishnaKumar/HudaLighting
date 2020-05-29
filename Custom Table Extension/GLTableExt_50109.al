tableextension 50109 GenLedtableExt extends "G/L Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; Narration; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Check No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Check Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Sales Person"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup ("Dimension Set Entry"."Dimension Value Code" WHERE("Dimension Set ID" = FIELD("Dimension Set ID"), "Dimension Code" = const('SALESPERSON')));
        }
        field(50004; "Payee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Project Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup ("Dimension Value".Name where(Code = field("Global Dimension 1 Code"), "Global Dimension No." = CONST(1)));
        }
        field(50006; "Customer Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup (Customer.Name where("No." = field("Source No.")));
        }
        field(50007; "G/L Account Category "; Option)
        {
            OptionMembers = ,Assets,Liabilities,Equity,Income,"Cost of Goods Sold",Expense;
            FieldClass = FlowField;
            CalcFormula = lookup ("G/L Account"."Account Category" where("No." = field("G/L Account No.")));
        }
        field(50008; "Shared %"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup ("GL Entry Split"."Share %" where("Document No." = field("Document No."), "G/L Account No." = field("G/L Account No."), "Shortcut Dimension 1 Code" = field("Global Dimension 1 Code")));
            //CalcFormula = lookup ("Sales Person Main"."Share %" where("Opportunity No" = field("Global Dimension 1 Code"), Salesperson = field("Sales Person")));
        }

        //****************************PDC***********************
        field(60000; "Import L/C"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Import L/C';
            TableRelation = "G/L Account"."No.";
        }
        field(60001; "Expenditure Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Interest,"Expense Charge";
            Caption = 'Expenditure Type';
        }
        field(60002; "Cheque No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque No.';
        }
        field(60003; "Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque Date';
        }
        field(60004; "Document No2"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document No2';
        }
        /*  field(60005; Narration; Text[250])
         {
             DataClassification = ToBeClassified;
             Caption = 'Narration';
         } */

    }

    var
        myInt: Integer;
        GLEntry: Record "G/L Entry";
}