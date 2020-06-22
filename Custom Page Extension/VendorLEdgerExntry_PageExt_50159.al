pageextension 50159 VendorLedger extends "Vendor Ledger Entries"
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
            field(Remarks; Remarks)
            {
                ApplicationArea = All;
            }
            field("PDC Applied Amount"; "PDC Applied Amount")
            {
                ApplicationArea = All;
            }
            field("LC No."; "LC No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Open)
        {
            field("Advance Paid To Vendor Bool"; "Advance Paid To Vendor Bool")
            {
                ApplicationArea = All;
            }
        }
        addafter("Amount (LCY)")
        {
            field("Advance Paid To Vendor"; "Advance Paid To Vendor")
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
                action("Payment Voucher")
                {
                    ApplicationArea = All;
                    Image = PrintVoucher;
                    trigger OnAction()
                    var
                        PayVoucher: Report 50118;
                        GLEntry: Record "G/L Entry";
                    begin
                        Clear(GLEntry);
                        GLEntry.SetRange("Document No.", Rec."Document No.");
                        GLEntry.SetRange("Posting Date", Rec."Posting Date");
                        GLEntry.SetRange("Source Type", GLEntry."Source Type"::Vendor);
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