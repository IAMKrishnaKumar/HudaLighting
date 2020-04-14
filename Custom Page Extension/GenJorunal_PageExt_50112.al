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
        /*modify(Post)
        {
            /* trigger OnBeforeAction()
             begin
                 Clear(DocumentNO);
                 DocumentNO := Rec."Document No.";
             end;

             trigger OnAfterAction()
             var
                 GenLedSetup: Record "General Ledger Setup";
                 GenVoucher: Report 50116;
                 GLEntry: Record "G/L Entry";
                 NoSeries: Record "No. Series";
                 GenJlnBatch: Record "Gen. Journal Batch";
                 NOSeriesLine: Record "No. Series Line";
             begin
                 GenLedSetup.GET;
                 if GenLedSetup."Gen. Jln. Post & Print" then begin
                     if not Confirm('Do you want to print the Voucher?', false) then
                         exit;
                     COMMIT;
                     COMMIT;
                     Clear(GenJlnBatch);
                     IF GenJlnBatch.GET(Rec."Journal Template Name", Rec."Journal Batch Name") then begin
                         clear(NOSeriesLine);
                         NOSeriesLine.SetRange("Series Code", GenJlnBatch."Posting No. Series");
                         if NOSeriesLine.FindFirst() then begin
                             Clear(GLEntry);
                             GLEntry.SetRange("Document No.", NOSeriesLine."Last No. Used");
                             if GLEntry.FindSet() then begin
                                 GenVoucher.SetTableView(GLEntry);
                                 GenVoucher.UseRequestPage(false);
                                 GenVoucher.Run();
                             end;
                         end;
                     end;

                 end;
             end;
    }*/


    }

    var
        DocumentNO: Text;
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


}