pageextension 50143 PurchCrMemoSF extends "Purch. Cr. Memo Subform"
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
        addafter("Line Amount")
        {
            field("VAT Prod. Posting Group_"; "VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'VAT Prod. Posting Group';
            }
            field("Gen. Prod. Posting Group_"; "Gen. Prod. Posting Group")
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
        modify("VAT Prod. Posting Group")
        {
            Visible = false;
        }
        /* modify("Gen. Prod. Posting Group")
         {
             Visible = false;
         }*/
        addafter("No.")
        {
            field("Vendor Article No"; "Vendor Article No")
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