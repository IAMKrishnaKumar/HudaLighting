page 50111 "Sales Orders List"
{
    PageType = List;
    //ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = "Sales Header";
    CardPageId = "Sales Order";

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
                field("Bank Guarantee Date"; "Bank Guarantee Date")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = IsBGRed;
                }
                field("Bank Guarantee Amount"; "Bank Guarantee Amount")
                {
                    ApplicationArea = All;
                }
                field("Bank Guarantee No."; "Bank Guarantee No.")
                {
                    ApplicationArea = All;
                }
                field("LC No."; "LC No.")
                {
                    ApplicationArea = All;
                }
                field("LC Exp Date"; "LC Exp Date")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = IsLCRed;
                }
                field("LC Payment Terms"; "LC Payment Terms")
                {
                    ApplicationArea = All;
                }
                field("LC Amount"; "LC Amount")
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

    procedure SetLCStyle()
    begin
        IsLCRed := true;
        IsBGRed := false;
    end;

    procedure SetBGStyle()
    begin
        IsLCRed := false;
        IsBGRed := true;
    end;

    var
        IsLCRed: Boolean;
        IsBGRed: Boolean;
}