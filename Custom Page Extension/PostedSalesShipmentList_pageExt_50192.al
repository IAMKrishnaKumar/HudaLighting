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
        RecPurcRcpLine: Record "Sales Shipment Line";
        TotalInvoiced: Decimal;
    begin
        Clear(RecPurcRcpLine);
        Clear(TotalInvoiced);
        Clear(CompletelyInvoiced);
        RecPurcRcpLine.SetRange("Document No.", Rec."No.");
        if RecPurcRcpLine.FindSet() then begin
            repeat
                TotalInvoiced += RecPurcRcpLine."Qty. Shipped Not Invoiced";
            until RecPurcRcpLine.Next() = 0;
        end;
        if TotalInvoiced = 0 then
            CompletelyInvoiced := true
        else
            CompletelyInvoiced := false;
    end;

    var
        CompletelyInvoiced: Boolean;
}