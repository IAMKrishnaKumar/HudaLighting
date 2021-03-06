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
            //**********************************Daily Activity*********************
            field("Daily Activity"; "Daily Activity")
            {
                ApplicationArea = All;
            }
            field("VAT Note"; "VAT Note")
            {
                ApplicationArea = All;
            }
            field("Show Actions to Print Cheque"; "Show Actions to Print Cheque")
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
        addlast(content)
        {
            //OptionMembers = ,"OA Approval Alert","Materials Received by the Whse. Alert","Invoice Posting Alert","Pick Materials Alert","Scheduled Gen. Proj. Status Report";
            group("Email Alerts")
            {
                //Visible = false;
                field("OA Approval"; "OA Approval")
                {
                    ApplicationArea = All;
                    //Visible = false;
                }
                field("Materials Received by Whse."; "Materials Received by Whse.")
                {
                    ApplicationArea = All;
                    //Visible = false;
                }
                field("Sales Invoice Posting"; "Sales Invoice Posting")
                {
                    ApplicationArea = All;
                    //Visible = false;
                }
                field("Pick Materials"; "Pick Materials")
                {
                    ApplicationArea = All;
                    //Visible = false;
                }
                field("General Project Status"; "General Project Status")
                {
                    ApplicationArea = All;
                    //Visible = false;
                }
            }
            group("Teams Email Ids")
            {
                //Visible = false;
                field("OA Approval Email"; "OA Approval Email")
                {
                    ApplicationArea = All;
                    Caption = 'OA Approval - Teams Email Id';
                    Visible = false;
                }
                field("Materials Rec. by Whse. Email"; "Materials Rec. by Whse. Email")
                {
                    ApplicationArea = All;
                    Caption = 'Materials Received - Teams Email Id';
                    Visible = false;
                }
                field("Sales Invoice Posting Email"; "Sales Invoice Posting Email")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Invoice Posting - Teams Email Id';
                    Visible = false;
                }
                field("Pick Materials Email"; "Pick Materials Email")
                {
                    ApplicationArea = All;
                    Caption = 'Pick Materials - Teams Email Id';
                    //Visible = false;
                }
                field("GPS Sharepoint Link"; "GPS Sharepoint Link")
                {
                    ApplicationArea = All;
                }
                field("General Project Status Email"; "General Project Status Email")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Caption = 'General Project Status - Teams  Email Id';
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