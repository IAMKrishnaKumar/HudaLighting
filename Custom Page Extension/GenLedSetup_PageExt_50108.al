pageextension 50108 GenLedSetrupPExt extends "General Ledger Setup"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Gen. Jln. Post & Print"; "Gen. Jln. Post & Print")
            {
                ApplicationArea = All;
            }
        }
        addafter(Application)
        {
            group("Integrations Mapping")
            {
                field("Payroll Journal Template"; "Payroll Journal Template")
                {
                    ApplicationArea = All;
                }
                field("Payroll Journal Batch"; "Payroll Journal Batch")
                {
                    ApplicationArea = All;
                }
                field("Department Dimension Code"; "Department Dimension Code")
                {
                    ApplicationArea = All;
                }
                field("Branch Dimension Code"; "Branch Dimension Code")
                {
                    ApplicationArea = All;
                }
                field("Loan & Advance Adjustment Journal Template"; "Loan & Adv Adj Jln Template")
                {
                    ApplicationArea = All;
                }
                field("Loan & Advance Adjustment Journal Batch"; "Loan & Adv Adj Jln Batch")
                {
                    ApplicationArea = All;
                }
            }
            group(Taxation)
            {
                field("With Holding Tax Payable GL"; "With Holding Tax Payable GL")
                {
                    ApplicationArea = All;
                    Caption = 'Withholding Tax Payable GL';
                }
                field("With Holding Tax Receivable GL"; "With Holding Tax Receivable GL")
                {
                    ApplicationArea = All;
                    Caption = 'Withholding Tax Receivable GL';
                }
            }

            group("Check Printing No. Series")
            {
                field("Check Printing No Series"; "Check Printing No. Series")
                {
                    ApplicationArea = All;
                    Caption = 'Check Printing No. Series';
                }

            }
            group("PDC Configuration")
            {
                field("PDC Bank Account No."; "PDC Bank Account No.")
                {
                    ApplicationArea = All;
                }
                field("PDC Issue Template"; "PDC Issue Template")
                {
                    ApplicationArea = All;
                }
                field("PDC Issue Batch"; "PDC Issue Batch")
                {
                    ApplicationArea = All;
                }
                field("PDC Issue Nos."; "PDC Issue Nos.")
                {
                    ApplicationArea = All;
                }
                field("PDC Receipt Template"; "PDC Receipt Template")
                {
                    ApplicationArea = All;
                }
                field("PDC Receipt Batch"; "PDC Receipt Batch")
                {
                    ApplicationArea = All;
                }
                field("PDC Receipt Nos."; "PDC Receipt Nos.")
                {
                    ApplicationArea = All;
                }
                field("CQ Template"; "CQ Template")
                {
                    ApplicationArea = All;
                }
                field("CQ No Series."; "CQ No Series.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}