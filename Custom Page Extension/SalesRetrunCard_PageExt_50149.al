pageextension 50149 SalesRetrun extends "Sales Return Order"
{
    layout
    {
        // Add changes to page layout here
        modify("Campaign No.")
        {
            Visible = false;
        }
        addafter("VAT Bus. Posting Group")
        {
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        addafter("Currency Code")
        {
            field("Estimated Order Value"; "Estimated Order Value")
            {
                ApplicationArea = All;
            }
        }
        addafter("Order Date")
        {
            field("Project Name"; "Project Name")
            {
                ApplicationArea = All;
            }
            field("Project Reference"; "Project Reference")
            {
                ApplicationArea = All;
            }
        }
        modify("Location Code")
        {
            Visible = false;
        }
        addafter("Salesperson Code")
        {
            field(Location_Code; "Location Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Foreign Trade")
        {
            group("Security Details")
            {
                field("Security ChecK No."; "Security ChecK No.")
                {
                    ApplicationArea = All;
                }
                field("Check Amount"; "Check Amount")
                {
                    ApplicationArea = All;
                }
                field("Check Date"; "Check Date")
                {
                    ApplicationArea = All;
                }
            }
            group("Bank Guarantee Details")
            {
                field("Bank Guarantee No."; "Bank Guarantee No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Guarantee Date"; "Bank Guarantee Date")
                {
                    ApplicationArea = All;
                }
                field("Bank Guarantee Amount"; "Bank Guarantee Amount")
                {
                    ApplicationArea = All;
                }
            }
            group("Installation Details")
            {
                field("Date of Installation"; "Date of Installation")
                {
                    ApplicationArea = All;
                }
                field("Hourly Rate"; "Hourly Rate")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; "Start Time")
                {
                    ApplicationArea = all;
                }
                field("End Time"; "End Time")
                {
                    ApplicationArea = All;
                }
                field("Total Time"; "Total Time")
                {
                    ApplicationArea = All;
                }
                field("Installation Amount"; "Installation Amount")
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