pageextension 60008 vendorPostingGrp extends "Vendor Posting Group Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Service Charge Acc.")
        {
            field("PDC Issue Account"; "PDC Issue Account")
            {
                ApplicationArea = All;
                Caption = 'PDC Payment Account';
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