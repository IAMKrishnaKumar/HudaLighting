page 50110 "Notification Details"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Notification Details";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                }
                field("Due Date Formula"; "Due Date Formula")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        /* area(Processing)
         {
             action(ActionName)
             {
                 ApplicationArea = All;

                 trigger OnAction()
                 begin

                 end;
             }
         }*/
    }

    var
        myInt: Integer;
}