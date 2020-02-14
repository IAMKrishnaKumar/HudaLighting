pageextension 50169 Location extends "Location Card"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Retail Location"; "Retail Location")
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
pageextension 50170 LocationList extends "Location List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Retail Location"; "Retail Location")
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