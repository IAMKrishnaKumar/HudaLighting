pageextension 50167 ItemJournal extends "Item Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("Item No.")
        {
            field("Vendor Article No."; "Vendor Article No.")
            {
                ApplicationArea = All;
            }
        }
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