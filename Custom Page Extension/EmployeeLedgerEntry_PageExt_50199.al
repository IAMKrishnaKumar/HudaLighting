pageextension 50200 EmplLedEntry extends "Employee Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addlast(Group)
        {
            field("Check Date"; "Check Date")
            {
                ApplicationArea = All;
            }
            field("Check No."; "Check No.")
            {
                ApplicationArea = All;
            }
            field(Narration; Narration)
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

pageextension 50201 EmployeeLedEntryP extends "Empl. Ledger Entries Preview"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {
            field("Check Date"; "Check Date")
            {
                ApplicationArea = All;
            }
            field("Check No."; "Check No.")
            {
                ApplicationArea = All;
            }
            field(Narration; Narration)
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