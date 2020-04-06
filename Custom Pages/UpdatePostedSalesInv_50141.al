page 50141 "Update Sales Invoice"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Invoice Header";
    InsertAllowed = false;
    DeleteAllowed = false;
    Permissions = tabledata 112 = RIMD;
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

            }
            group(Project)
            {
                field("Project Name"; "Project Name")
                {
                    ApplicationArea = All;
                }
                field("Project Reference"; "Project Reference")
                {
                    ApplicationArea = All;
                }
                field("Amount (In Arabic)"; "Amount (In Arabic)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        myInt: Integer;
}