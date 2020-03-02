pageextension 50128 SalesInv extends "Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Discount Approval"; "Discount Approval")
            {
                ApplicationArea = All;
                Caption = 'Discount Approval';
                Enabled = false;
            }
            field("PO Reference"; "PO Reference")
            {
                ApplicationArea = All;
            }
            field("Applies-to Doc. Type"; "Applies-to Doc. Type")
            {
                ApplicationArea = All;
            }
            field("Applies-to Doc. No."; "Applies-to Doc. No.")
            {
                ApplicationArea = All;
            }
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        addafter("VAT Bus. Posting Group")
        {
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        addafter("Due Date")
        {
            field("Project Reference"; "Project Reference")
            {
                ApplicationArea = All;
                // Enabled = false;
            }
            field("Project Name"; "Project Name")
            {
                ApplicationArea = All;
                // Enabled = false;
            }
        }
        moveafter("Project Name"; "Payment Method Code")
        moveafter("Payment Method Code"; "Payment Terms Code")
        moveafter("Payment Terms Code"; "Currency Code")

        moveafter("Shortcut Dimension 1 Code"; "Shortcut Dimension 2 Code")
        moveafter("Currency Code"; "Location Code")
        moveafter("Salesperson Code"; "Shortcut Dimension 1 Code")

        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        addafter("Invoice Details")
        {
            group("Security Details")
            {
                field("Security Check No."; "Security ChecK No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Caption = 'Security Check No.';
                }
                field("Check Amount"; "Check Amount")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Check Date"; "Check Date")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
            group("Bank Guarantee Details")
            {
                field("Bank Guarantee No."; "Bank Guarantee No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Bank Guarantee Date"; "Bank Guarantee Date")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Bank Guarantee Amount"; "Bank Guarantee Amount")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }

            group("Installation Details")
            {
                Visible = false;
                field("Date of Installation"; "Date of Installation")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Hourly Rate"; "Hourly Rate")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Start Time"; "Start Time")
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
                field("End Time"; "End Time")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Total Time"; "Total Time")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Installation Amount"; "Installation Amount")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
        }
        addlast("Invoice Details")
        {
            field("Amount (In Arabic)"; "Amount (In Arabic)")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
        }

        //Payment Milestone Subform
        addbefore("Invoice Details")
        {
            part(PaymentMileStone; "Payment Milestone Subform")
            {
                ApplicationArea = All;
                Enabled = false;
                Editable = false;
                SubPageLink = "Document Type" = field("Document Type"), "Document No." = FIELD("No.");
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
                        Rec.CalcFields(Amount);
                        PaymentMileStonePage.SetDocNumber('Invoice', Rec."Document Date", Rec.Amount, Rec."Currency Factor", Rec."No.");
                        PaymentMileStonePage.SetEditable(false);
                        PaymentMileStonePage.Editable(false);
                        RecPaymentMileStone.SetRange("Document Type", "Document Type"::Invoice);
                        RecPaymentMileStone.SetRange("Document No.", Rec."No.");
                        if RecPaymentMileStone.FindSet() then;
                        PaymentMileStonePage.SetTableView(RecPaymentMileStone);
                        PaymentMileStonePage.Run();
                    end;

                }
            }
        }

        addafter("P&osting")
        {
            action("Update VAT Bus. Posting Group")
            {
                ApplicationArea = All;

                trigger OnAction()
                VAR
                    PLines: Record "Purchase Line";
                    UpdatePosGrp: Report 50156;
                begin
                    UpdatePosGrp.SetInvoiceNo("No.");
                    UpdatePosGrp.RunModal();
                    Message('Process completed.');
                end;
            }
        }

        modify(Post)
        {
            trigger OnBeforeAction()
            var
                RecPaymentMilestone: Record "Payment Milestone";
            begin
                Rec.TestField("Currency Code");

                //added later for payment milestone confirmation in invoice
                ConfirmPaymentMilestone;
            end;
        }
        modify(PostAndNew)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Currency Code");
                //added later for payment milestone confirmation in invoice
                ConfirmPaymentMilestone;
            end;
        }
        modify(PostAndSend)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Currency Code");
                //added later for payment milestone confirmation in invoice
                ConfirmPaymentMilestone;
            end;
        }
    }

    procedure ConfirmPaymentMilestone()
    var
        RecPM: Record "Payment Milestone";
        RecPT: Record "Payment Terms";
        TotalPercentage: Decimal;
        RecSalesLine: Record "Sales Line";
    begin
        /*Clear(RecPaymentMilestone);
          RecPaymentMilestone.SetRange("Document Type", "Document Type");
          RecPaymentMilestone.SetRange("Document No.", "No.");
          if RecPaymentMilestone.FindFirst() then
              if not Confirm('Please review the payment milestone entries.', false) then
                  exit;*/
        if RecPT.GET(Rec."Payment Terms Code") then begin
            if RecPT."Payment Milestone Mandatory" then begin
                Clear(RecPM);
                Clear(TotalPercentage);
                RecPM.SetRange("Document Type", "Document Type"::Invoice);
                RecPM.SetRange("Document No.", Rec."No.");
                if RecPM.FindSet() then
                    repeat
                        TotalPercentage += RecPM."Milestone %";
                    until RecPM.Next() = 0;
                if TotalPercentage = 0 then
                    Error('Payment Milestone must be defined.')
                else
                    if TotalPercentage <> 100 then begin
                        Error('Payment Milestone % must be 100 for this order.');
                    end;
            end;
        end;
    end;

    var
        myInt: Integer;
}
