pageextension 50176 WhseReceipt extends "Warehouse Receipt"
{
    layout
    {
        // Add changes to page layout here
        addafter("Sorting Method")
        {
            field("Airway Bill No."; "Airway Bill No.")
            {
                ApplicationArea = All;
            }

        }
        addafter("Bin Code")
        {
            field(SourceDocument; SourceDocument)
            {
                Caption = 'Source Document';
                ApplicationArea = All;
                Enabled = false;
            }
            field(SourceNo; SourceNo)
            {
                Caption = 'Source No.';
                ApplicationArea = All;
                Enabled = false;
            }
            field(ClientName; ClientName)
            {
                Caption = 'Client Name';
                ApplicationArea = All;
                Enabled = false;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnAfterGetRecord()
    var
        RecWhseShipLine: Record "Warehouse Receipt Line";
        Sheader: Record "Sales Header";
        Pheader: Record "Purchase Header";
    begin
        Clear(RecWhseShipLine);
        Clear(SourceDocument);
        Clear(ClientName);
        RecWhseShipLine.SetRange("No.", Rec."No.");
        if RecWhseShipLine.FindFirst() then begin
            SourceDocument := RecWhseShipLine."Source Document";
            SourceNo := RecWhseShipLine."Source No.";
            if RecWhseShipLine."Source Document" = RecWhseShipLine."Source Document"::"Sales Order" then begin
                Clear(Sheader);
                Sheader.SetRange("Document Type", Sheader."Document Type"::Order);
                Sheader.SetRange("No.", RecWhseShipLine."Source No.");
                if Sheader.FindFirst() then begin
                    ClientName := Sheader."Sell-to Customer Name";
                end;
            end else
                if RecWhseShipLine."Source Document" = RecWhseShipLine."Source Document"::"Purchase Order" then begin
                    Clear(Pheader);
                    Pheader.SetRange("Document Type", Pheader."Document Type"::Order);
                    Pheader.SetRange("No.", RecWhseShipLine."Source No.");
                    if Pheader.FindFirst() then begin
                        ClientName := Pheader."Buy-from Vendor Name";
                    end;
                end;
        end;
    end;

    var
        SourceDocument: Option ,"Sales Order",,,"Sales Return Order","Purchase Order",,,"Purchase Return Order",,"Outbound Transfer",,,,,,,,"Service Order";
        SourceNo: Code[20];
        ClientName: Text;
}