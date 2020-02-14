pageextension 50176 WhseReceipt extends "Warehouse Receipt"
{
    layout
    {
        // Add changes to page layout here
        addafter("Sorting Method")
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