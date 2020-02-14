pageextension 50107 PostedSalesShipSubF extends "Posted Sales Shpt. Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Vendor Article No"; "Vendor Article No")
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
            field("HL_Purchase Order No."; "HL_Purchase Order No.")
            {
                ApplicationArea = All;
                Caption = 'Purchase Order No.';
                Enabled = false;
                Visible = false;
            }
            field("PO Qty"; "PO Qty")
            {
                ApplicationArea = All;
                Caption = 'Purchase Order No.';
                Enabled = false;
            }
            field("Order No."; "Order No.")
            {
                ApplicationArea = All;
            }
            field("PO Line No."; "PO Line No.")
            {
                ApplicationArea = All;
                Caption = 'Purchase Order Line No.';
                Enabled = false;
                Visible = false;
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