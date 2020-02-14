pageextension 50110 SalesShipmentHdr extends "Posted Sales Shipment"
{
    layout
    {
        // Add changes to page layout here
        addafter("Order No.")
        {
            field("Project Reference"; "Project Reference")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Project Name"; "Project Name")
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