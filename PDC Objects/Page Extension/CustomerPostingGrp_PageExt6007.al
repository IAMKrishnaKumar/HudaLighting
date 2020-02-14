pageextension 60007 CustPostGrpCard extends "Customer Posting Group Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Service Charge Acc.")
        {
            field("PDC Receipt Account"; "PDC Receipt Account")
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