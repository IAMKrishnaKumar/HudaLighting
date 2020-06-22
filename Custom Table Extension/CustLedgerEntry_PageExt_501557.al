tableextension 50157 CustLedEntry extends "Cust. Ledger Entry"
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

        //***************************PDC******************
        field(60000; "PDC Applied Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Applied Amount';
        }
        field(60001; "PDC Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Entry';
        }
        field(60002; "PDC Amt to Apply"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Amt to Apply';
        }
        field(50903; "Advance Paid To Customer Bool"; Boolean)
        {
            Caption = 'Advance';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Exist ("G/L Entry" WHERE("G/L Account No." = FILTER('201610'), "Document No." = FIELD("Document No."), "Source Type" = FILTER(Customer), "Source No." = FIELD("Customer No."), "Posting Date" = field("Date Filter")));

            //CalcFormula = Exist ("G/L Entry" WHERE("G/L Account No." = FILTER('201610'), "Document No." = FIELD("Document No."), "Source No." = FIELD("Customer No."), "Source Type" = FILTER(Customer)));
        }

        field(50904; "Advance Paid To Customer"; Decimal)
        {
            Caption = 'Advance received Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum ("G/L Entry".Amount WHERE("G/L Account No." = FILTER('201610'), "Document No." = FIELD("Document No."), "Source Type" = FILTER(Customer), "Source No." = FIELD("Customer No."), "Posting Date" = field("Date Filter")));

            //CalcFormula = Exist ("G/L Entry" WHERE("G/L Account No." = FILTER('201610'), "Document No." = FIELD("Document No."), "Source No." = FIELD("Customer No."), "Source Type" = FILTER(Customer)));
        }
    }

    var
        myInt: Integer;
}