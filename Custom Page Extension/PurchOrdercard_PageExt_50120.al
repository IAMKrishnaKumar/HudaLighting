pageextension 50120 POCard extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
        moveafter(Status; "Document Date")
        moveafter("Document Date"; "Due Date")
        moveafter("Due Date"; "Vendor Invoice No.")
        moveafter("Vendor Invoice No."; "Vendor Order No.")
        moveafter("Vendor Order No."; "Vendor Shipment No.")
        moveafter("Vendor Shipment No."; "Currency Code")
        moveafter("Currency Code"; "Expected Receipt Date")
        moveafter("Currency Code"; "Payment Terms Code")
        moveafter("Payment Terms Code"; "Shortcut Dimension 1 Code")
        moveafter("Shortcut Dimension 1 Code"; "Shortcut Dimension 2 Code")
        moveafter("Shortcut Dimension 2 Code"; "Location Code")
        addlast(General)
        {
            field("Delivery Time"; "Delivery Time")
            {
                ApplicationArea = All;
            }
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
        }

        modify("Order Address Code")
        {
            Visible = false;
        }

        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            ApplicationArea = All;
        }

        addafter("Purchaser Code")
        {
            field("Project Name"; "Project Name")
            {
                ApplicationArea = All;
            }
            field("Project Reference"; "Project Reference")
            {
                ApplicationArea = All;
            }
        }
        addafter("Foreign Trade")
        {
            group("Credit Facility Details")
            {
                field("LC No."; "LC No.")
                {
                    ApplicationArea = All;
                }
                field("LC Exp Date"; "LC Exp Date")
                {
                    ApplicationArea = All;
                }
                field("LC Amount"; "LC Amount")
                {
                    ApplicationArea = All;
                }
            }

        }
        addlast("Invoice Details")
        {
            field("Amount (In Arabic)"; "Amount (In Arabic)")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                Rec.TestField("Currency Code");

                if WorkDate() < Today() then
                    if not Confirm('Your Order Date is in the past. Please change it to the Current date.', false) then
                        exit;
                if WorkDate() > Today() then
                    if not Confirm('Your Order Date is in the future. Please change it to the Current date.', false) then
                        exit;
            end;
        }
        // modify("P&osting")
        // {
        //     Visible = false;
        // }
        modify("Send Intercompany Purchase Order")
        {
            trigger OnBeforeAction()
            var
                ICPartner: Record "IC Partner";
            begin
                if ("Document Type" <> "Document Type"::Order) OR ("Buy-from IC Partner Code" = '') then
                    exit;
                IF ICPartner.GET("Buy-from IC Partner Code") then begin
                    ICPartner.TestField("Outbound Sales Item No. Type", ICPartner."Outbound Sales Item No. Type"::"Common Item No.");
                end;
            end;

        }
        /*addafter(Warehouse)
        {
            group("Logistics Views")
            {
                Image = View;
                action("Logistics View")
                {
                    ApplicationArea = All;
                    Caption = 'Logistics';
                    Image = View;

                    trigger OnAction()
                    var
                        PurchLIne: Record "Purchase Line";
                        Logistics: Page "Sales Order Holistic View";
                    begin
                        Clear(PurchLIne);
                        PurchLIne.SetRange("Document Type", Rec."Document Type");
                        PurchLIne.SetRange("Document No.", Rec."No.");
                        if PurchLIne.FindSet() then;
                        Logistics.SetTableView(PurchLIne);
                        Logistics.Editable(false);
                        Logistics.Run();
                    end;

                }
            }
        }*/
    }

    var
        myInt: Integer;
}