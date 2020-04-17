pageextension 50121 PurchInvCard extends "Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter("VAT Bus. Posting Group")
        {
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Order Address Code")
        {
            Visible = false;
        }
        moveafter("Purchaser Code"; "Currency Code")
        moveafter("Currency Code"; "Payment Terms Code")
        moveafter("Currency Code"; "Shortcut Dimension 1 Code")
        moveafter("Shortcut Dimension 1 Code"; "Shortcut Dimension 2 Code")
        addafter("Purchaser Code")
        {
            field("Applies-to Doc. Type"; "Applies-to Doc. Type")
            {
                ApplicationArea = All;
            }
            field("Applies-to Doc. No."; "Applies-to Doc. No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Foreign Trade")
        {
            group("Bill of Entry Details")
            {
                field("Bill Of Entry No."; "Bill Of Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Bill Of Entry Date"; "Bill Of Entry Date")
                {
                    ApplicationArea = All;
                }
                field("Foreign Vendnor Invoice No."; "Foreign Vendnor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Exchange Rate"; "Exchange Rate")
                {
                    ApplicationArea = All;
                }
            }
            group("LC Details")
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
    }

    actions
    {
        // Add changes to page actions here
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Currency Code");
            end;
        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Currency Code");
            end;
        }
        modify(PostBatch)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Currency Code");
            end;
        }
        addafter("P&osting")
        {
            action("Update VAT Bus. Posting Group")
            {
                ApplicationArea = All;

                trigger OnAction()
                VAR
                    PLines: Record "Purchase Line";
                    UpdatePosGrp: Report 50152;
                begin
                    UpdatePosGrp.SetInvoiceNo("No.");
                    UpdatePosGrp.RunModal();
                    Message('Process completed.');
                end;
            }
        }
    }

    var
        myInt: Integer;
}