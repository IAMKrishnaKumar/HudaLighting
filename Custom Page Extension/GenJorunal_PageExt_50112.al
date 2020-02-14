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
        // Add changes to page actions here
        /* addafter("Opening Balance")
         {
             group(Print)
             {
                 action("Print Voucher")
                 {
                     ApplicationArea = All;
                     Caption = 'Print';
                     Image = Print;
                     trigger OnAction()
                     var
                         GenVoucher: Report 50115;
                         GJln: Record "Gen. Journal Line";
                     begin
                         Clear(GJln);
                         GJln.SetRange("Journal Template Name", Rec."Journal Template Name");
                         GJln.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                         if GJln.FindSet() then begin
                             GenVoucher.SetTableView(GJln);
                             GenVoucher.Run();
                         end;
                     end;
                 }
             }
         }*/

        modify(Post)
        {
            trigger OnBeforeAction()
            var
                Check: Codeunit 50104;
            begin
                // Check.CheckCurrencyForJournal(Rec);
                // RecJln.COPY(Rec);
                // // Clear(RecJln);
                // // RecJln.SetRange("Journal Template Name", Rec."Journal Template Name");
                // // RecJln.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                // // RecJln.SetRange();
                // RecJln.SetFilter("Bal. Account Type", '=%1|%2', "Bal. Account Type"::Vendor, "Bal. Account Type"::Customer);
                // if RecJln.FindSet() then begin
                //     RecJln.TestField("Currency Code");
                //  end;
            end;
        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            var
                Check: Codeunit 50104;
            begin
                //  Check.CheckCurrencyForJournal(Rec);
                // RecJln.COPY(Rec);
                // // Clear(RecJln);
                // // RecJln.SetRange("Journal Template Name", Rec."Journal Template Name");
                // // RecJln.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                // // RecJln.SetRange();
                // RecJln.SetFilter("Bal. Account Type", '=%1|%2', "Bal. Account Type"::Vendor, "Bal. Account Type"::Customer);
                // if RecJln.FindSet() then begin
                //     RecJln.TestField("Currency Code");
                //  end;
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
        // Add changes to page actions here
        /*  modify("P&ost")
          {
              trigger OnBeforeAction()
              var
                  RecJln: Record "Gen. Journal Line";
              begin
                  Clear(RecJln);
                  RecJln.SetRange("Journal Template Name", Rec."Journal Template Name");
                  RecJln.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                  if RecJln.FindSet() then begin
                      RecJln.TestField("Currency Code");
                  end;
              end;
          }
          modify("Post and &Print")
          {
              trigger OnBeforeAction()
              var
                  RecJln: Record "Gen. Journal Line";
              begin
                  Clear(RecJln);
                  RecJln.SetRange("Journal Template Name", Rec."Journal Template Name");
                  RecJln.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                  if RecJln.FindSet() then begin
                      RecJln.TestField("Currency Code");
                  end;
              end;
          }
          */
    }

    var
        myInt: Integer;
}