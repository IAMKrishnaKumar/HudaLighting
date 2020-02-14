pageextension 50132 InvetorySetup extends "Inventory Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter(Numbering)
        {
            group("Item Uploader")
            {
                field("Brand Dimension"; "Brand Dimension")
                {
                    ApplicationArea = All;
                }
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