pageextension 50166 CustCard extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here

        addbefore("Salesperson Code")
        {
            field("Legal Registration Expiry Date"; "Legal Registration Expiry Date")
            {
                ApplicationArea = All;
            }
            field("GP Reference"; "GP Reference")
            {
                ApplicationArea = All;
            }
        }
        addafter("Gen. Bus. Posting Group")
        {
            field("VAT Bus. Posting Group_"; "VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'VAT Bus. Posting Group';
            }

        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        addafter("Privacy Blocked")
        {
            field("VAT Registration No._"; "VAT Registration No.")
            {
                ApplicationArea = ALl;
                Caption = 'VAT Registration No.';
            }
            field("Payment Terms Code_"; "Payment Terms Code")
            {
                ApplicationArea = ALl;
                Caption = 'Payment Terms Code';
            }
        }
        modify("VAT Registration No.")
        {
            Visible = false;
        }
        modify("Payment Terms Code")
        {
            Visible = false;
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Document Sending Profile")
        {
            Visible = false;
        }
        addafter(Name)
        {
            field("Name - Arabic"; "Name - Arabic")
            {
                ApplicationArea = All;
            }
        }
        addafter(Address)
        {
            field("Address-Arabic"; "Address-Arabic")
            {
                ApplicationArea = All;
            }
        }
        addafter("Address 2")
        {
            field("Address 2 - Arabic"; "Address 2 - Arabic")
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