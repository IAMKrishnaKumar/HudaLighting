pageextension 50188 AccManager extends "Acc. Payables Coordinator RC"
{
    layout
    {
        // Add changes to page layout here
        addafter(Control1900601808)
        {
            part("Acc.  Payable Activities"; "Acc.  Payable Activities")
            {
                ApplicationArea = Basic, Suite;
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