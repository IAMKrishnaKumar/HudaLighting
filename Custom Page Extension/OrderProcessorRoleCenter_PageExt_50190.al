pageextension 50190 OrderProcessor extends "Order Processor Role Center"
{
    layout
    {
        // Add changes to page layout here
        addbefore(Control1901851508)
        {
            part("Order Processor Activity"; "Order Processor Activity")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Acc. Payables Activities HL"; "Acc. Payables Activities HL")
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