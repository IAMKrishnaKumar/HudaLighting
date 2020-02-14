page 50112 "Purchase orders List"
{
    PageType = List;
    //ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = "Purchase Header";
    CardPageId = "Purchase Order";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; "Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor Name"; "Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("LC Amount"; "LC Amount")
                {
                    ApplicationArea = All;
                }
                field("LC Exp Date"; "LC Exp Date")
                {
                    ApplicationArea = All;
                }
                field("LC No."; "LC No.")
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
            /*action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }*/
        }
    }

    var
        myInt: Integer;
}