pageextension 50106 Itemcat extends "Item Category Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Arabic Name"; "Arabic Name")
            {
                ApplicationArea = All;
            }
            field("Warranty Days"; "Warranty Days")
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