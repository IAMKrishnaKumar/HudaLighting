pageextension 50129 BankLedgEntries extends "Bank Account Ledger Entries"
{
    layout
    {
        // Add changes to page layout here

        addafter(Description)
        {
            field(Narration; Narration)
            {
                ApplicationArea = All;
            }
            field("Check Date"; "Check Date")
            {
                ApplicationArea = All;
            }
            field("Check No."; "Check No.")
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