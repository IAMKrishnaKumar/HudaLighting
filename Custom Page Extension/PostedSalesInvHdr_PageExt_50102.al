pageextension 50102 PostedSalesInv extends "Posted Sales Invoice"
{
    Editable = true;
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
                //Editable = false;//made it editable as per client request
            }
        }
        addafter("Invoice Details")
        {
            group("Security Details")
            {
                field("Security ChecK No."; "Security ChecK No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Check Amount"; "Check Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Check Date"; "Check Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Bank Guarantee Details")
            {
                field("Bank Guarantee No."; "Bank Guarantee No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bank Guarantee Date"; "Bank Guarantee Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bank Guarantee Amount"; "Bank Guarantee Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Installation Details")
            {
                field("Date of Installation"; "Date of Installation")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Hourly Rate"; "Hourly Rate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Start Time"; "Start Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("End Time"; "End Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Time"; "Total Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Installation Amount"; "Installation Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        addafter("Tax Area Code")
        {
            field("Amount (In Arabic)"; "Amount (In Arabic)")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Invoice")
        {
            group("Payment Milestones")
            {
                action("Payment Milestone")
                {
                    ApplicationArea = All;
                    Image = SetupPayment;
                    trigger OnAction()
                    var
                        PaymentMileStonePage: page "Payment Milestone";
                        RecPaymentMileStone: Record "Payment Milestone";
                    begin
                        if Rec."Pre-Assigned No." = '' then
                            exit;
                        Rec.CalcFields(Amount);
                        PaymentMileStonePage.SetDocNumber('Invoice', Rec."Document Date", Rec.Amount, Rec."Currency Factor", Rec."Pre-Assigned No.");
                        PaymentMileStonePage.SetEditable(false);
                        PaymentMileStonePage.Editable(false);
                        RecPaymentMileStone.SetRange("Document Type", RecPaymentMileStone."Document Type"::Invoice);
                        RecPaymentMileStone.SetRange("Document No.", Rec."Pre-Assigned No.");
                        if RecPaymentMileStone.FindSet() then;
                        PaymentMileStonePage.SetTableView(RecPaymentMileStone);
                        PaymentMileStonePage.Run();
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
        }
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
                    RecSalesShipHeader.SetFilter("Posting Description", 'Invoice ' + "Pre-Assigned No.");
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
                    GLEntry.SetRange("Document Type", GLEntry."Document Type"::Payment);
                    GLEntry.SetRange("Document No.", Rec."No.");
                    GLEntry.SetRange("Source Type", GLEntry."Source Type"::Customer);
                    GLEntry.SetRange("Source No.", Rec."Sell-to Customer No.");
                    if GLEntry.FindSet() then begin
                        ReceiptReport.SetTableView(GLEntry);
                        ReceiptReport.Run();
                    end;
                end;
            }

        }
    }

    var
        myInt: Integer;
}