pageextension 50104 PostedSalescrMemo extends "Posted Sales Credit Memo"
{
    layout
    {
        // Add changes to page layout here
        addafter("External Document No.")
        {
            field("Project Reference"; "Project Reference")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Project Name"; "Project Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addlast("Invoice Details")
        {
            field("Amount (In Arabic)"; "Amount (In Arabic)")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
        }
        addafter("Invoice Details")
        {
            group("Security Details")
            {
                field("Security ChecK No."; "Security ChecK No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Check Amount"; "Check Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Check Date"; "Check Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Bank Guarantee Details")
            {
                field("Bank Guarantee No."; "Bank Guarantee No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bank Guarantee Date"; "Bank Guarantee Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bank Guarantee Amount"; "Bank Guarantee Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Installation Details")
            {
                field("Date of Installation"; "Date of Installation")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Hourly Rate"; "Hourly Rate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Start Time"; "Start Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("End Time"; "End Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Time"; "Total Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Installation Amount"; "Installation Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
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