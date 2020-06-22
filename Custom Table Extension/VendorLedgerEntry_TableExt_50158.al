tableextension 50158 VendorLedgEntry extends "Vendor Ledger Entry"
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

        //**************************PDC*******************
        field(60000; "Cheque No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque No.';
        }
        field(60001; "Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque Date';
        }
        field(60002; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Remarks';
        }
        field(60003; "PDC Applied Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Applied Amount';
        }
        field(60004; "LC No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'LC No.';
        }
        field(50900; "Advance Paid To Vendor Bool"; Boolean)
        {
            Caption = 'Advance';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Exist ("G/L Entry" WHERE("G/L Account No." = FILTER('103340'), "Document No." = FIELD("Document No."), "Source Type" = FILTER(Vendor), "Source No." = FIELD("Vendor No."), "Posting Date" = field("Date Filter")));
        }

        field(50901; "Advance Paid To Vendor"; Decimal)
        {
            Caption = 'Advance Paid Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
            //CalcFormula = sum ("G/L Entry".Amount WHERE("G/L Account No." = FILTER('103370'), "Document No." = FIELD("Document No."), "Source Type" = FILTER(Vendor), "Source No." = FIELD("Vendor No."), "Posting Date" = field("Date Filter")));
            CalcFormula = sum ("G/L Entry".Amount WHERE("G/L Account No." = FILTER('103340'), "Document No." = FIELD("Document No."), "Source Type" = FILTER(Vendor), "Source No." = FIELD("Vendor No."), "Posting Date" = field("Date Filter")));
        }
    }

    var
        myInt: Integer;
}