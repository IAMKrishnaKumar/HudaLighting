pageextension 50151 CustList extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Contact)
        {
            field("Legal Registration Expiry Date"; "Legal Registration Expiry Date")
            {
                ApplicationArea = All;
                Enabled = false;
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