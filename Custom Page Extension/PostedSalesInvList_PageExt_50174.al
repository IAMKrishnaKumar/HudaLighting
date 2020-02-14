pageextension 50174 PostedSalesInvLost extends "Posted Sales Invoices"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(Invoice)
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