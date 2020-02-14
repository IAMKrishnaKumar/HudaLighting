pageextension 60009 ReturnReceiptHdr extends "Posted Return Receipt"
{
    layout
    {
        // Add changes to page layout here
        addafter("No. Printed")
        {
            field("Applies-to ID for PDC"; "Applies-to ID for PDC")
            {
                ApplicationArea = All;
            }
            field("Remaining Amount"; "Remaining Amount")
            {
                ApplicationArea = All;
            }
            field("Order Amount"; "Order Amount")
            {
                ApplicationArea = All;
            }
            field("PDC Applied Amount"; "PDC Applied Amount")
            {
                ApplicationArea = All;
            }
            field("Export L.C. No."; "Export L.C. No.")
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