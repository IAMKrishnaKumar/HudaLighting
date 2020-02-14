pageextension 50135 GLPreview extends "G/L Entries Preview"
{
    layout
    {
        // Add changes to page layout here
        addafter("G/L Account No.")
        {
            field("G/L Account Name_"; "G/L Account Name")
            {
                ApplicationArea = All;
                Caption = 'G/L Account Name';
            }
        }
        addafter("Bal. Account No.")
        {
            field("Check No."; "Check No.")
            {
                ApplicationArea = All;

            }
            field(Narration; Narration)
            {
                ApplicationArea = All;
            }
            field("Check Date"; "Check Date")
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