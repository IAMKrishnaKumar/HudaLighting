pageextension 50148 CurrencyCard extends "Currency Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Decimal Description"; "Decimal Description")
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