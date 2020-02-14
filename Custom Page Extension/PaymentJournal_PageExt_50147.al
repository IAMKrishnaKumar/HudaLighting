pageextension 50147 PaymentJOurnal extends "Payment Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("Document No.")
        {
            field("Check No."; "Check No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Payee Name"; "Payee Name")
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
            field(Payee; Payee)
            {
                ApplicationArea = All;
            }
        }


    }

    actions
    {
        /*
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                if ("Bal. Account Type" = "Bal. Account Type"::Customer) OR ("Bal. Account Type" = "Bal. Account Type"::Vendor) then
                    Rec.TestField("Currency Code");
                Rec.TestField("Document Type");
            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            begin
                if ("Bal. Account Type" = "Bal. Account Type"::Customer) OR ("Bal. Account Type" = "Bal. Account Type"::Vendor) then
                    Rec.TestField("Currency Code");
                Rec.TestField("Document Type");
            end;
        }
        */
        /*// Add changes to page actions here
        modify("Void Check")
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
                GenJnlLine: Record "Gen. Journal Line";
            begin
                GenJnlLine.RESET;
                GenJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
                GenJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
                GenJnlLine.SetRange("Line No.", Rec."Line No.");
                if GenJnlLine.FindFirst() then begin
                    if GenJnlLine."Check Printed" then begin
                        GenJnlLine."Document No." := GenJnlLine."Check No.";
                        GenJnlLine.Modify();
                    end;
                end;
            end;
        }
        
        modify(PrintCheck)
        {
            trigger OnBeforeAction()
            var
                GLSetup: Record "General Ledger Setup";
            begin
                GLSetup.GET;
                GLSetup.TestField("Check Printing No. Series");
            end;

            trigger OnAfterAction()
            var
                GLSetup: Record "General Ledger Setup";
                NOseries: Codeunit NoSeriesManagement;
                GenJnlLine: Record "Gen. Journal Line";
            begin
                GLSetup.GET;
                GenJnlLine.RESET;
                GenJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
                GenJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
                GenJnlLine.SetRange("Line No.", Rec."Line No.");
                if GenJnlLine.FindFirst() then begin
                    if GenJnlLine."Check Printed" then begin
                        GenJnlLine."Check No." := GenJnlLine."Document No.";
                        //GenJnlLine."Document No." := NOseries.GetNextNo(GLSetup."Check Printing No. Series", WorkDate(), true);
                        GenJnlLine.Modify();
                    end;
                end;

            end;

        }*/
    }

    var
        myInt: Integer;
}