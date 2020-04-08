page 50143 "G/L Entry Split"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "GL Entry Split";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("G/L Entry No."; "G/L Entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("G/L Account No."; "G/L Account No.")
                {
                    ApplicationArea = All;
                }
                field("G/L Account Category "; "G/L Account Category ")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Project Name"; "Project Name")
                {
                    ApplicationArea = All;
                }
                field("Sales Person"; "Sales Person")
                {
                    ApplicationArea = All;
                }
                field("Share %"; "Share %")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Shared Amount"; "Shared Amount")
                {
                    ApplicationArea = All;
                }
                field("Add. Currency Amount"; "Add. Currency Amount")
                {
                    ApplicationArea = All;
                }
                field("Shared Add. Currency Amount"; "Shared Add. Currency Amount")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    var
        Test: Record "GL Entry Split";
}