pageextension 50124 SalesCrMemoSubForm extends "Sales Cr. Memo Subform"
{
    layout
    {
        // Add changes to page layout here
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("IC Partner Ref. Type")
        {
            Visible = false;
        }
        modify("IC Partner Reference")
        {
            Visible = false;
        }

        addafter("Line Amount")
        {
            field("VAT Prod. Posting Group_"; "VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'VAT Prod. Posting Group';
            }
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            field("IC Partner Code_"; "IC Partner Code")
            {
                ApplicationArea = All;
                Caption = 'IC Partner Code';
            }
            field("IC Partner Ref. Type___"; "IC Partner Ref. Type")
            {
                ApplicationArea = All;
                Caption = 'IC Partner Ref. Type';
            }
            field("IC Partner Reference_"; "IC Partner Reference")
            {
                ApplicationArea = All;
                Caption = 'IC Partner Reference';
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
        }
        addafter("No.")
        {
            field("Vendor Article No"; "Vendor Article No")
            {
                ApplicationArea = All;
                Enabled = false;
            }
        }
        addafter(Quantity)
        {

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
            field("Estimated Cost"; "Estimated Cost")
            {
                ApplicationArea = All;
            }
            field("Estimated GP"; "Estimated GP")
            {
                ApplicationArea = All;
            }
            field("Warranty Date"; "Warranty Date")
            {
                ApplicationArea = All;
                Enabled = false;
            }
            field("HL_Purchase Order No."; "HL_Purchase Order No.")
            {
                ApplicationArea = All;
                Enabled = false;
                Caption = 'Purchase Order No.';
            }
            field("PO Qty"; "PO Qty")
            {
                ApplicationArea = All;
                Enabled = false;
                Caption = 'Purchase Order Quanity';
            }

            field("PO Line No."; "PO Line No.")
            {
                ApplicationArea = All;
                Enabled = false;
                Caption = 'Purchase Order Line No.';
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