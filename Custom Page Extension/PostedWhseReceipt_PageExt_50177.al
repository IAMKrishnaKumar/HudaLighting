pageextension 50177 PostedWhseReceipt extends "Posted Whse. Receipt"
{
    layout
    {
        // Add changes to page layout here
        addafter("Whse. Receipt No.")
        {
            field("Airway Bill No."; "Airway Bill No.")
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