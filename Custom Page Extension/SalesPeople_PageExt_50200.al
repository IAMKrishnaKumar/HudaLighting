pageextension 50205 SalesPeople extends "Salesperson/Purchaser Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Alias Name"; "Alias Name")
            {
                ApplicationArea = All;
                MultiLine = true;
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