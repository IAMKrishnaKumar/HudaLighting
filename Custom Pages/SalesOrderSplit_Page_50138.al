page 50142 "Sales Order Split"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Order Split";

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
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("LPO No."; "LPO No.")
                {
                    ApplicationArea = All;
                }
                field("Project Name"; "Project Name")
                {
                    ApplicationArea = All;
                }
                field("Client Name"; "Client Name")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
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
                field("Invoiced GL (LCY)"; "Invoiced GL (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Invoiced GL (ACY)"; "Invoiced GL (ACY)")
                {
                    ApplicationArea = All;
                }
                field("Invoiced Non Stock (LCY)"; "Invoiced Non Stock (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Invoiced Non Stock (ACY)"; "Invoiced Non Stock (ACY)")
                {
                    ApplicationArea = All;
                }
                field("UE Sales (LCY)"; "UE Sales (LCY)")
                {
                    ApplicationArea = All;
                }
                field("UE Sales (ACY)"; "UE Sales (ACY)")
                {
                    ApplicationArea = All;
                }
                field("UE GP (LCY)"; "UE GP (LCY)")
                {
                    ApplicationArea = All;
                }
                field("UE GP (ACY)"; "UE GP (ACY)")
                {
                    ApplicationArea = All;
                }
                field("Shared UE Sales (LCY)"; "Shared UE Sales (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Shared UE Sales (ACY)"; "Shared UE Sales (ACY)")
                {
                    ApplicationArea = All;
                }
                field("Shared UE GP (LCY)"; "Shared UE GP (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Shared UE GP (ACY)"; "Shared UE GP (ACY)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}