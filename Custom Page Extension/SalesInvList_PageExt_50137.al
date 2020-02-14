pageextension 50137 SalesInvList extends "Sales Invoice List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addbefore("&Invoice")
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
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Currency Code");
            end;
        }
        modify(PostAndSend)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Currency Code");
            end;
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