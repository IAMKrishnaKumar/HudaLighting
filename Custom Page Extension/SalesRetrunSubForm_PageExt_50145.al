pageextension 50145 SalesRetrunSF extends "Sales Return Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Line Amount")
        {
            field("VAT Prod. Posting Group_"; "VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'VAT Prod. Posting Group"';
            }
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = false;
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
            field("Vendor Article No"; "Vendor Article No")
            {
                ApplicationArea = All;
                Enabled = false;
            }
            field("HL Type"; "HL Line Type")
            {
                ApplicationArea = All;
                Caption = 'Ref Type';
            }
            field(Brand; Brand)
            {
                ApplicationArea = All;
                Enabled = false;
            }
        }
        addbefore("Line Amount")
        {
            field("Estimated Cost"; "Estimated Cost")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Estimated GP"; "Estimated GP")
            {
                ApplicationArea = All;
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