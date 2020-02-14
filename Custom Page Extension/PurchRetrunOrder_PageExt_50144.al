pageextension 50144 PurchRetrunOrder extends "Purchase Return Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
            }
            field("Description 3"; "Description 3")
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