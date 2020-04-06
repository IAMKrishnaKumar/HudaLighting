pageextension 50111 GenLedEntries extends "General Ledger Entries"
{
    layout
    {
        modify("G/L Account Name")
        {
            Visible = false;
        }
        addafter("G/L Account No.")
        {
            field("G/L Account Name_"; "G/L Account Name")
            {
                ApplicationArea = All;
                Caption = 'G/L Account Name';
            }
        }
        addafter("External Document No.")
        {
            field("Payee Name"; "Payee Name")
            {
                ApplicationArea = All;
            }
            field("Check No."; "Check No.")
            {
                ApplicationArea = All;

            }
            field(Narration; Narration)
            {
                ApplicationArea = All;
            }
            field("Check Date"; "Check Date")
            {
                ApplicationArea = All;
            }
            field("Sales Person"; "Sales Person")
            {
                ApplicationArea = All;
            }
            field("Shared %"; "Shared %")
            {
                ApplicationArea = All;
            }
            field("Source Type"; "Source Type")
            {
                ApplicationArea = All;
            }
            field("Source No."; "Source No.")
            {
                ApplicationArea = All;
            }
            field("G/L Account Category "; "G/L Account Category ")
            {
                ApplicationArea = All;
            }
            field("Project Name"; "Project Name")
            {
                ApplicationArea = All;
            }
        }
        addlast(Control1)
        {
            field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addbefore("Ent&ry")
        {
            group(Update)
            {
                action("Update G/L Acc. No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnAction()
                    var
                        UpdateGLReport: Report 50142;
                    begin
                        UpdateGLReport.Run();
                    end;
                }
            }
        }
        addafter("Ent&ry")
        {

            group(Print)
            {
                action("Payment Voucher")
                {
                    ApplicationArea = All;
                    // Caption = 'Print';
                    Image = PrintVoucher;
                    trigger OnAction()
                    var
                        PayVoucher: Report 50118;
                        GLEntry: Record "G/L Entry";
                    begin
                        Clear(GLEntry);
                        GLEntry.SetRange("Document No.", Rec."Document No.");
                        if GLEntry.FindSet() then begin
                            PayVoucher.SetTableView(GLEntry);
                            PayVoucher.Run();
                        end;
                    end;
                }
                action("Journal Voucher")
                {
                    ApplicationArea = All;
                    Image = PaymentJournal;
                    trigger OnAction()
                    var
                        PayVoucher: Report 50116;
                        GLEntry: Record "G/L Entry";
                    begin
                        Clear(GLEntry);
                        GLEntry.SetRange("Document No.", Rec."Document No.");
                        if GLEntry.FindFirst() then begin
                            PayVoucher.SetTableView(GLEntry);
                            PayVoucher.Run();
                        end;
                    end;
                }
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