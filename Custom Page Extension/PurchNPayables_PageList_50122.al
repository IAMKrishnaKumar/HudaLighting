pageextension 50122 PnPayables extends "Purchases & Payables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Background Posting")
        {
            group("Vendor Replication Setup")
            {
                field("Domestic Gen Bus Grp"; "Domestic Gen Bus Grp")
                {
                    ApplicationArea = All;
                }
                field("Foreign Gen Bus Grp"; "Foreign Gen Bus Grp")
                {
                    ApplicationArea = All;
                }
                field("Domestic Vendor posting group"; "Domestic Vendor posting group")
                {
                    ApplicationArea = All;
                }
                field("Foreign Vendor posting Group"; "Foreign Vendor posting Group")
                {
                    ApplicationArea = All;
                }
            }
        }
        addlast(General)
        {
            field("Purchase Price Warning Check"; "Purchase Price Warning Check")
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