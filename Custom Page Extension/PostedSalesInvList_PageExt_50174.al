pageextension 50174 PostedSalesInvLost extends "Posted Sales Invoices"
{
    layout
    {
    }

    actions
    {
        // Add changes to page actions here
        addafter(Invoice)
        {
            group("Print Voucher")
            {
                action("Print Delivery Note")
                {
                    ApplicationArea = All;
                    Image = Print;
                    trigger OnAction()
                    var
                        RecSalesShipHeader: Record "Sales Shipment Header";
                        PostedDeliveryNote: Report "Posted Delivery Note";
                    begin
                        Clear(RecSalesShipHeader);
                        RecSalesShipHeader.SetFilter("Posting Description", '@*' + "Pre-Assigned No." + '*');
                        if RecSalesShipHeader.FindFirst() then begin
                            PostedDeliveryNote.SetTableView(RecSalesShipHeader);
                            PostedDeliveryNote.Run();
                        end;
                    end;
                }
                action("Print Receipt Voucher")
                {
                    ApplicationArea = All;
                    Image = PrintCover;
                    trigger OnAction()
                    var
                        ReceiptReport: Report ReceiptVoucherGL_LT;
                        GLEntry: Record "G/L Entry";
                    begin
                        Clear(GLEntry);
                        //GLEntry.SetRange("Document Type", GLEntry."Document Type"::Payment);
                        GLEntry.SetRange("Document No.", Rec."No.");
                        //GLEntry.SetRange("Source Type", GLEntry."Source Type"::Customer);
                        //GLEntry.SetRange("Source No.", Rec."Sell-to Customer No.");
                        if GLEntry.FindSet() then begin
                            ReceiptReport.SetTableView(GLEntry);
                            ReceiptReport.Run();
                        end;
                    end;
                }
            }
        }
        addafter(Print)
        {
            action("Update Document")
            {
                ApplicationArea = All;
                Image = UpdateDescription;
                trigger OnAction()
                VAR
                    UpdateCard: Page "Update Sales Invoice";
                    RecSalesInvHeader: Record "Sales Invoice Header";
                begin
                    Clear(RecSalesInvHeader);
                    RecSalesInvHeader.SetRange("No.", "No.");
                    UpdateCard.SetTableView(RecSalesInvHeader);
                    UpdateCard.Editable(true);
                    UpdateCard.LookupMode(true);
                    UpdateCard.RunModal();
                end;
            }
            action("Update Sales Order No.")
            {
                ApplicationArea = All;
                Image = EditAdjustments;
                AccessByPermission = Tabledata 113 = RIMD;
                trigger OnAction()
                Var
                    RecSalesInvLine: Record "Sales Invoice Line";
                    RecSalesShipmentLine: Record "Sales Shipment Line";
                    UpdatePSI: Report "Update Sales Order No.";
                begin
                    UpdatePSI.UseRequestPage(false);
                    UpdatePSI.Run();
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        IF UserSetup.GET(UserId) then begin
            IF UserSetup."Retail User" then begin
                CalcFields("Retail Location");
                SetFilter("Retail Location", '=%1', TRUE);
            end;
        end;
    end;

    var
        myInt: Integer;
}