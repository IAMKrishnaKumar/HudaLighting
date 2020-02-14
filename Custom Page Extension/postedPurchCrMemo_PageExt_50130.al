pageextension 50131 PostedpurchCrMemo extends "Posted Purchase Credit Memo"
{
    layout
    {
        // Add changes to page layout here
        addafter("Location Code")
        {
            field("LC No."; "LC No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("LC Exp Date"; "LC Exp Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("LC Amount"; "LC Amount")
            {
                ApplicationArea = All;
                Editable = false;
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