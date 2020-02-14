pageextension 50172 TransferReceiptSF extends "Posted Transfer Rcpt. Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Item No.")
        {
            field("Vendor Article No."; "Vendor Article No.")
            {
                ApplicationArea = all;
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