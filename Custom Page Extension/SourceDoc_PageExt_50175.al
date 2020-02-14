pageextension 50175 "Source Documents" extends "Source Documents"
{
    layout
    {
        // Add changes to page layout here
        addafter("Destination No.")
        {
            field(DestinationName; DestinationName)
            {
                ApplicationArea = All;
                Caption = 'Destination Name';
                Enabled = false;
            }
            field(PurchaserCode; PurchaserCode)
            {
                ApplicationArea = all;
                Caption = 'Sales Person/Purchaser';
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
        RecCust: Record Customer;
        RecVenor: Record Vendor;
        RecItem: Record Item;
        PurchHeader: Record "Purchase Header";
        Sheader: Record "Sales Header";
    begin
        Clear(DestinationName);
        // ,Customer,Vendor,Location,Item,Family,Sales Order
        if Rec."Destination Type" = "Destination Type"::Vendor then begin
            Clear(RecVenor);
            RecVenor.SetRange("No.", "Destination No.");
            if RecVenor.FindFirst() then
                DestinationName := RecVenor.Name;
        end;
        if Rec."Destination Type" = "Destination Type"::Item then begin
            Clear(RecItem);
            RecItem.SetRange("No.", "Destination No.");
            if RecItem.FindFirst() then
                DestinationName := RecItem.Description;
        end;
        if Rec."Destination Type" = "Destination Type"::Customer then begin
            Clear(RecCust);
            RecCust.SetRange("No.", "Destination No.");
            if RecCust.FindFirst() then
                DestinationName := RecCust.Name;
        end;

        Clear(PurchaserCode);
        IF Rec."Source Document" = "Source Document"::"Purchase Order" then begin
            Clear(PurchHeader);
            PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
            PurchHeader.SetRange("No.", "Source No.");
            //PurchHeader.GET("Source Subtype", "Source No.");
            if PurchHeader.FindFirst() then begin
                PurchaserCode := PurchHeader."Purchaser Code";
            end;
        end else
            if Rec."Source Document" = "Source Document"::"Sales Order" then begin
                Clear(Sheader);
                Sheader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                Sheader.SetRange("No.", "Source No.");
                // Sheader.GET("Source Subtype", "Source No.");
                if Sheader.FindFirst() then begin
                    PurchaserCode := Sheader."Salesperson Code";
                end;
            end else
                PurchaserCode := '';
    end;

    var
        DestinationName: Text;
        PurchaserCode: Text;
}