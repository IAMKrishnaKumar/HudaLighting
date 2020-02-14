page 50118 "Sales Line Buffer"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Line Buffer";

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
                field("vendor No."; "vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Article No."; "Vendor Article No.")
                {
                    ApplicationArea = All;
                }
                field("Line Type"; "Line Type")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    ApplicationArea = All;
                }
                field("Estimated Cost"; "Estimated Cost")
                {
                    ApplicationArea = All;
                }
                field(UploadedBy; UploadedBy)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}