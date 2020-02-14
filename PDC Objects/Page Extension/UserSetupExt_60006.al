pageextension 60006 userSetup extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Purchase Resp. Ctr. Filter")
        {
            field("Confirm Payment Jnls."; "Confirm Payment Jnls.")
            {
                ApplicationArea = All;
            }
            field("Retail User"; "Retail User")
            {
                ApplicationArea = All;
            }
            field("Receive Daily PO Report"; "Receive Daily PO Report")
            {
                ApplicationArea = All;
            }
            field("Receive Daily SO Report"; "Receive Daily SO Report")
            {
                ApplicationArea = All;
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