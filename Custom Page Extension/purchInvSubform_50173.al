pageextension 50178 PurchInvSF extends "Purch. Invoice Subform"
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
            }
            field("Description 3"; "Description 3")
            {
                ApplicationArea = All;
            }
        }
        addafter("Qty. Assigned")
        {
            field("Purchase Order No."; "Purchase Order No.")
            {
                ApplicationArea = All;
                Enabled = false;
            }
        }
        addafter("VAT Prod. Posting Group")
        {
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("HL Line Type"; "HL Line Type")
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

    }


    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}