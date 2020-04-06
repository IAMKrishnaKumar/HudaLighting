pageextension 50112 GenJournalLine extends "General Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("Business Unit Code")//addafter(Comment)
        {
            field(Narration; Narration)
            {
                ApplicationArea = All;
            }
            field("Check No."; "Check No.")
            {
                ApplicationArea = All;
            }
            field("Check Date"; "Check Date")
            {
                ApplicationArea = All;
            }
        }
        addlast(Control1)
        {
            field("Non PDC App. Entries"; "Non PDC App. Entries")
            {
                ApplicationArea = All;
            }
            field("L.C. No."; "L.C. No.")
            {
                ApplicationArea = All;
            }
            field("PDC Entry"; "PDC Entry")
            {
                ApplicationArea = All;
            }
            // field("Cheque No."; "Cheque No.")
            // {
            //     ApplicationArea = All;
            // }
            // field("Cheque Date"; "Cheque Date")
            // {
            //     ApplicationArea = All;
            // }
            field("Document No2"; "Document No2")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        modify(Post)
        {
            trigger OnAfterAction()
            var
                GenLedSetup: Record "General Ledger Setup";
                GenVoucher: Report 50116;
                GLEntry: Record "G/L Entry";
            begin
                GenLedSetup.GET;
                if GenLedSetup."Gen. Jln. Post & Print" then begin
                    if not Confirm('Do you want to print the Voucher?', false) then
                        exit;
                    Clear(GLEntry);
                    GLEntry.SetRange("Document No.", Rec."Document No.");
                    if GLEntry.FindFirst() then begin
                        GenVoucher.SetTableView(GLEntry);
                        GenVoucher.Run();
                    end;
                end;
            end;
        }


    }

    var
        myInt: Integer;
}

pageextension 50186 InterCompanyJournal extends "IC General Journal"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {
            field("Payee Name"; "Payee Name")
            {
                ApplicationArea = All;
                Caption = 'Payee Name';
            }
            field(Narration; Narration)
            {
                ApplicationArea = All;
            }
            field("Check No."; "Check No.")
            {
                ApplicationArea = All;
            }
            field("Check Date"; "Check Date")
            {
                ApplicationArea = All;
            }
            field("Amount (LCY)"; "Amount (LCY)")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        myInt: Integer;
}