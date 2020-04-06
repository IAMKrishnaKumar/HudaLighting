tableextension 50107 GenLedSetExt extends "General Ledger Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Payroll Journal Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name;
        }
        field(50002; "Payroll Journal Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payroll Journal Template"));
        }
        field(50003; "Department Dimension Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(50004; "Branch Dimension Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(50005; "Loan & Adv Adj Jln Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name;
            Caption = 'Loan & Advance Adjustment Journal Template';
        }
        field(50006; "Loan & Adv Adj Jln Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payroll Journal Template"));
            Caption = 'Loan & Advance Adjustment Journal Batch';
        }
        field(50007; "With holding Tax Receivable GL"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
            Caption = 'With Holding Tax Receivable GL';
        }
        field(50008; "With Holding Tax Payable GL"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(50009; "Check Printing No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50010; "Gen. Jln. Post & Print"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //********************************PDC****************
        field(60000; "CQ Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'CQ Template';
            TableRelation = "Gen. Journal Template";
        }
        field(60001; "CQ No Series."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
            Caption = 'CQ No Series.';
        }
        field(60002; "PDC Receipt Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Receipt Nos.';
            TableRelation = "No. Series";
        }
        field(60003; "PDC Bank Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Bank Account No.';
            TableRelation = "Bank Account";
        }
        field(60004; "PDC Issue Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Payment Template';
            TableRelation = "Gen. Journal Template";
        }
        field(60005; "PDC Issue Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Payment Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("PDC Issue Template"));
        }
        field(60006; "PDC Issue Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Payment Nos.';
            TableRelation = "No. Series";
        }
        field(60007; "Bank Facility Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Facility Nos.';
            TableRelation = "No. Series";
        }
        field(60008; "PDC Receipt Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Receipt Template';
            TableRelation = "Gen. Journal Template";
        }
        field(60009; "PDC Receipt Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Receipt Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("PDC Receipt Template"));
        }

    }

    var
        myInt: Integer;
}