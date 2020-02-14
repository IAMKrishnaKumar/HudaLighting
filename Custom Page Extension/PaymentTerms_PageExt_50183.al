pageextension 50183 Paymentterms extends "Payment Terms"
{
    layout
    {
        // Add changes to page layout here
        addafter("Calc. Pmt. Disc. on Cr. Memos")
        {
            field("Payment Milestone Mandatory"; "Payment Milestone Mandatory")
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