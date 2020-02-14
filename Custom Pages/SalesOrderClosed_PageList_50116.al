page 50116 "Sales Orders - Closed"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Header";
    CardPageId = "Sales Order";
    Editable = false;
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
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Completely Shipped"; "Completely Shipped")
                {
                    ApplicationArea = All;
                }

                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; "Amount Including VAT")
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

            action("Re-Open")
            {
                ApplicationArea = All;
                Image = ReOpen;
                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to Re-Open the selected Order?', FALSE) then
                        exit;
                    Rec.Closed := false;
                    Rec.Modify();
                end;
            }

        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetFilter(Closed, '=%1', true);
    end;

    var
        myInt: Integer;
}