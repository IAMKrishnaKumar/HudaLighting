pageextension 50192 PostedSalesShipmentPage extends "Posted Sales Shipments"
{
    layout
    {
        // Add changes to page layout here
        addafter("Sell-to Customer Name")
        {
            field("Order No."; "Order No.")
            {
                ApplicationArea = All;
            }
            field("Pre DN No."; "Pre DN No.")
            {
                ApplicationArea = All;
                Caption = 'Pre DN No.';
            }
            field(CompletelyInvoiced; CompletelyInvoiced)
            {
                ApplicationArea = All;
                Caption = 'Completely Invoiced';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnAfterGetRecord()
    var
        RecSalesShipmentLine: Record "Sales Shipment Line";
        TotalInvoiced: Decimal;
    begin
        Clear(RecSalesShipmentLine);
        Clear(TotalInvoiced);
        Clear(CompletelyInvoiced);
        RecSalesShipmentLine.SetRange("Document No.", Rec."No.");
        if RecSalesShipmentLine.FindSet() then begin
            RecSalesShipmentLine.CalcSums("Qty. Shipped Not Invoiced");
            TotalInvoiced := RecSalesShipmentLine."Qty. Shipped Not Invoiced";
        end;
        if TotalInvoiced = 0 then
            CompletelyInvoiced := true
        else
            CompletelyInvoiced := false;



    end;

    var
        CompletelyInvoiced: Boolean;

}