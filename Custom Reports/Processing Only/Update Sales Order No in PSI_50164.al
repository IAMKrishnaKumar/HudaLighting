report 50164 "Update Sales Order No."
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = TableData 113 = RIMD;
    dataset
    {
    }

    requestpage
    {
        layout
        {

        }
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var

        begin
            If CloseAction IN [ACTION::OK, ACTION::LookupOK] then begin

            end;
        end;
    }
    trigger OnPostReport()
    var
        RecSalesInvLine: Record "Sales Invoice Line";
        RecsalesInvHdr: Record "Sales Invoice Header";
        RecSalesInvLine2: Record "Sales Invoice Line";
        RecSalesShipmentLine: Record "Sales Shipment Line";
    //RecSalesShipmentHdr: Record "Sales Shipment Header";
    begin
        if not Confirm('Are you sure you want to update Sales Order No. for all the Posted Invoices?', false) then
            exit;
        Clear(RecsalesInvHdr);
        RecsalesInvHdr.SetFilter("No.", '<>%1', '');
        if RecsalesInvHdr.FindSet() then begin
            repeat
                Clear(RecSalesInvLine);
                RecSalesInvLine.SetFilter("Document No.", RecsalesInvHdr."No.");
                RecSalesInvLine.SetFilter("Shipment No.", '<>%1', '');
                if RecSalesInvLine.FindFirst() then begin
                    Clear(RecSalesShipmentLine);
                    RecSalesShipmentLine.SetRange("Document No.", RecSalesInvLine."Shipment No.");
                    RecSalesShipmentLine.SetFilter("Order No.", '<>%1', '');
                    if RecSalesShipmentLine.FindFirst() then begin
                        Clear(RecSalesInvLine2);
                        RecSalesInvLine2.SetRange("Document No.", RecsalesInvHdr."No.");
                        if RecSalesInvLine2.FindSet() then
                            RecSalesInvLine2.ModifyAll("Sales Order No.", RecSalesShipmentLine."Order No.");
                    end;
                end;
            until RecsalesInvHdr.Next() = 0;
        end;
    end;

    var
        FilterText: Text;
        GLAccNo: Code[20];
}



///


