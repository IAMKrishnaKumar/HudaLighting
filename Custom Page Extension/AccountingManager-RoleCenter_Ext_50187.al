pageextension 50187 AccmanagerRolecenter extends "Accounting Manager Role Center"
{
    layout
    {
        // Add changes to page layout here
        addbefore(Control1902304208)
        {
            part("Account Manager Activity"; "Account Manager Activity")
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