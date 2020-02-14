pageextension 50189 AccReceivable extends "Acc. Receivables Adm. RC"
{
    layout
    {
        // Add changes to page layout here
        addafter(Control1902899408)
        {
            part("Acc Receivable Activity"; "Acc Receivable Activity")
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