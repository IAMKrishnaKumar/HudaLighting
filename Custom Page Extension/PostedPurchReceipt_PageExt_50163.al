pageextension 50163 PostedPurchReceipt extends "Posted Purchase Receipt"
{
    layout
    {
        // Add changes to page layout here
        addafter(Shipping)
        {
            group("Credit Facility Details")
            {
                field("LC No."; "LC No.")
                {
                    ApplicationArea = All;
                }
                field("LC Exp Date"; "LC Exp Date")
                {
                    ApplicationArea = All;
                }
                field("LC Amount"; "LC Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Vendor Shipment No.")
        {
            field("Project Name";"Project Name")
            {
                ApplicationArea=All;
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