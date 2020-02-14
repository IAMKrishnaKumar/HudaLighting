page 60000 "Applied PDC Documents"
{
    // Code           Date        Name        Desc.
    // APNT-LCPDC1.0  20.05.12    Monica      Created New.

    Editable = false;
    PageType = Card;
    SourceTable = "PDC Applied Amount";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("PDC No."; "PDC No.")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field(Bounced; Bounced)
                {
                    ApplicationArea = All;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Applied PDCs")
            {
                Caption = '&Applied PDCs';
                action("&Card")
                {
                    Caption = '&Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        if "Transaction Type" = "Transaction Type"::Sales then begin
                            if "Document Type" = "Document Type"::Order then begin
                                SalesOrder.Reset;
                                SalesOrder.SetRange("Document Type", SalesOrder."Document Type"::Order);
                                SalesOrder.SetRange("No.", "No.");
                                PAGE.RunModal(42, SalesOrder);
                            end else begin
                                PostedSalesInv.Reset;
                                PostedSalesInv.SetRange("No.", "No.");
                                PAGE.RunModal(132, PostedSalesInv);
                            end;
                        end else
                            if "Transaction Type" = "Transaction Type"::Purchase then begin
                                if "Document Type" = "Document Type"::Order then begin
                                    PurchHeader.Reset;
                                    PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                                    PurchHeader.SetRange(PurchHeader."No.", "No.");
                                    PAGE.RunModal(53, PurchHeader);
                                end else begin
                                    PurhInvHeader.Reset;
                                    PurhInvHeader.SetRange(PurhInvHeader."No.", "No.");
                                    PAGE.RunModal(138, PurhInvHeader);
                                end;
                            end;
                    end;
                }
            }
        }
    }

    var
        SalesOrder: Record "Sales Header";
        PostedSalesInv: Record "Sales Invoice Header";
        PurchHeader: Record "Purchase Header";
        PurhInvHeader: Record "Purch. Inv. Header";
}

