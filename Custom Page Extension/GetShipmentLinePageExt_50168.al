pageextension 50168 GetShipmentLInes extends "Get Shipment Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter("Location Code")
        {
            field("Order No."; "Order No.")
            {
                ApplicationArea = All;
            }
            field("Order Line No."; "Order Line No.")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        RecLine: Record "Sales Shipment Line";
        DocNo: Text;
        LineNo: Text;
        RecSalesLine: Record "Sales Line";
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN begin
            Clear(DocNo);
            Clear(RecLine);
            CurrPage.SetSelectionFilter(RecLine);
            if RecLine.FindFirst() then begin
                DocNo := RecLine."Order No.";
            end;
            Clear(RecLine);
            CurrPage.SetSelectionFilter(RecLine);
            if RecLine.FindSet() then begin
                repeat
                    if RecLine."Order No." <> DocNo then
                        Error('You cannot select lines from two different orders.');
                until RecLine.Next() = 0;
            end;

        end;
    end;

    var
        myInt: Integer;
}