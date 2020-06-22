pageextension 50158 CustLed extends "Customer Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("Entry No.")
        {
            field("Check No."; "Check No.")
            {
                ApplicationArea = All;
            }
            field("Check Date"; "Check Date")
            {
                ApplicationArea = All;
            }
            field(Narration; Narration)
            {
                ApplicationArea = All;
            }
        }
        addlast(Control1)
        {
            field("PDC Entry"; "PDC Entry")
            {
                ApplicationArea = All;
            }
            field("PDC Applied Amount"; "PDC Applied Amount")
            {
                ApplicationArea = All;
            }
            field("PDC Amt to Apply"; "PDC Amt to Apply")
            {
                ApplicationArea = All;
            }
        }
        addafter("Amount (LCY)")
        {
            field("Advance Paid To Customer"; "Advance Paid To Customer")
            {
                ApplicationArea = All;
            }
        }
        addafter(Open)
        {
            field("Advance Paid To Customer Bool"; "Advance Paid To Customer Bool")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter("Ent&ry")
        {

            // Add changes to page actions here
            group(Print)
            {
                action("Receipt Voucher")
                {
                    ApplicationArea = All;
                    Image = PaymentJournal;
                    trigger OnAction()
                    var
                        PayVoucher: Report 50124;
                        GLEntry: Record "G/L Entry";
                    begin
                        Clear(GLEntry);
                        GLEntry.SetRange("Document No.", Rec."Document No.");
                        GLEntry.SetRange("Posting Date", Rec."Posting Date");
                        GLEntry.SetRange("Source Type", GLEntry."Source Type"::Customer);
                        if GLEntry.FindSet() then begin
                            PayVoucher.SetTableView(GLEntry);
                            PayVoucher.Run();
                        end;
                    end;
                }
            }
        }
    }

    var
        myInt: Integer;
}