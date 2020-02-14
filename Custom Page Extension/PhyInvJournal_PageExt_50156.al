pageextension 50156 PhysInJourna extends "Phys. Inventory Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("Item No.")
        {
            field("Vendor Article No."; "Vendor Article No.")
            {
                ApplicationArea = All;
                Enabled = false;
            }
        }
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
                Enabled = false;
            }
            field("Description 3"; "Description 3")
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