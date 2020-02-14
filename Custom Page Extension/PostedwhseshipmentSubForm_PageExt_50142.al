pageextension 50142 PostedWhseSubform extends "Posted Whse. Shipment Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Item No.")
        {
            field("Vendor Article No"; "Vendor Article No")
            {
                ApplicationArea = All;
                Enabled = false;

            }
            field("Description 3"; "Description 3")
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit of Measure Code")
        {
            field("Warranty Date"; "Warranty Date")
            {
                ApplicationArea = All;
                Enabled = false;
            }
            field("HL Line Type"; "HL Line Type")
            {
                ApplicationArea = All;
                Caption = 'Ref Type';
                Enabled = false;
            }
            field(Brand; Brand)
            {
                ApplicationArea = All;
                Enabled = false;
            }
            field("Estimated Cost"; "Estimated Cost")
            {
                ApplicationArea = All;
                Enabled = false;
            }
            field("Estimated GP"; "Estimated GP")
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