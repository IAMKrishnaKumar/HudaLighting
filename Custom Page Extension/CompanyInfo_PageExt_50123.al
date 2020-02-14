pageextension 50123 companyInfo extends "Company Information"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Tax Type"; "Tax Type")
            {
                ApplicationArea = All;
            }
            field("Enable Auto Report"; "Enable Auto Report")
            {
                ApplicationArea = All;
            }
        }
        addafter("System Indicator")
        {
            group("Data Replication")
            {
                field("Vendor Replication Master"; "Vendor Replication Master")
                {
                    ApplicationArea = All;
                }
                field("Replicate Vendor"; "Replicate Vendor")
                {
                    ApplicationArea = All;
                }
            }
            group("Taxation")
            {
                field("With Holding Tax Applicable"; "With Holding Tax Applicable")
                {
                    ApplicationArea = All;
                    Caption = 'Withholding Tax Applicable';
                }
            }
            group(Remarks)
            {
                field("Remark Text 1"; "Remark Text 1")
                {
                    ApplicationArea = All;
                }
                field("Remark Text 2"; "Remark Text 2")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter(Picture)
        {
            field("Header Image"; "Header Image")
            {
                ApplicationArea = All;
            }
            field("Footer Image"; "Footer Image")
            {
                ApplicationArea = All;
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