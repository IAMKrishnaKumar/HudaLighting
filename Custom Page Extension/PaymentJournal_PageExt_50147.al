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
                Editable = IsEditable;
            }
        }
        addafter(Description)
        {
            field("Payee Name"; "Payee Name")
            {
                ApplicationArea = All;
                Editable = IsEditable;
            }
            field(Narration; Narration)
            {
                ApplicationArea = All;
                Editable = IsEditable;
            }
            field("Check Date"; "Check Date")
            {
                ApplicationArea = All;
                Editable = IsEditable;
            }
            field("Cheque Printed"; "Cheque Printed")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Payee; Payee)
            {
                ApplicationArea = All;
                Editable = IsEditable;
            }

        }

        Modify("Account No.")
        {
            Editable = IsEditable;
        }
        Modify("Account Type")
        {
            Editable = IsEditable;
        }

        Modify("Amount (LCY)")
        {
            Editable = IsEditable;
        }

        Modify("Applies-to Doc. Type")
        {
            Editable = IsEditable;
        }
        Modify("Applies-to Ext. Doc. No.")
        {
            Editable = IsEditable;
        }
        Modify("Applies-to ID")
        {
            Editable = IsEditable;
        }

        Modify("Bal. Account No.")
        {
            Editable = IsEditable;
        }
        Modify("Bal. Account Type")
        {
            Editable = IsEditable;
        }
        Modify("Bal. Gen. Bus. Posting Group")
        {
            Editable = IsEditable;
        }
        Modify("Bal. Gen. Posting Type")
        {
            Editable = IsEditable;
        }
        Modify("Bal. Gen. Prod. Posting Group")
        {
            Editable = IsEditable;
        }

        Modify("Bal. VAT Amount")
        {
            Editable = IsEditable;
        }

        Modify("Bal. VAT Bus. Posting Group")
        {
            Editable = IsEditable;
        }

        Modify("Bal. VAT Difference")
        {
            Editable = IsEditable;
        }
        Modify("Bal. VAT Prod. Posting Group")
        {
            Editable = IsEditable;
        }

        Modify("Bank Payment Type")
        {
            Editable = IsEditable;
        }

        Modify("Campaign No.")
        {
            Editable = IsEditable;
        }

        Modify("Check Printed")
        {
            Editable = IsEditable;
            Visible = false;
        }


        Modify("Credit Amount")
        {
            Editable = IsEditable;
        }

        Modify("Creditor No.")
        {
            Editable = IsEditable;
        }
        Modify("Currency Code")
        {
            Editable = IsEditable;
        }

        Modify("Debit Amount")
        {
            Editable = IsEditable;
        }

        Modify("Document Date")
        {
            Editable = IsEditable;
        }
        Modify("Document No.")
        {
            Editable = IsEditable;
        }

        Modify("Document Type")
        {
            Editable = IsEditable;
        }

        Modify("Exported to Payment File")
        {
            Editable = IsEditable;
        }
        Modify("External Document No.")
        {
            Editable = IsEditable;
        }

        Modify("Gen. Bus. Posting Group")
        {
            Editable = IsEditable;
        }
        Modify("Gen. Posting Type")
        {
            Editable = IsEditable;
        }
        Modify("Gen. Prod. Posting Group")
        {
            Editable = IsEditable;
        }
        Modify("Has Payment Export Error")
        {
            Editable = IsEditable;
        }

        Modify("Incoming Document Entry No.")
        {
            Editable = IsEditable;
        }

        Modify("Job Queue Status")
        {
            Editable = IsEditable;
        }



        Modify("Message to Recipient")
        {
            Editable = IsEditable;
        }


        Modify("Payment Method Code")
        {
            Editable = IsEditable;
        }

        Modify("Payment Reference")
        {
            Editable = IsEditable;
        }


        Modify("Posting Date")
        {
            Editable = IsEditable;
        }



        Modify("Reason Code")
        {
            Editable = IsEditable;
        }
        Modify("Recipient Bank Account")
        {
            Editable = IsEditable;
        }

        Modify("Salespers./Purch. Code")
        {
            Editable = IsEditable;
        }

        Modify("Shortcut Dimension 1 Code")
        {
            Editable = IsEditable;
        }
        Modify("Shortcut Dimension 2 Code")
        {
            Editable = IsEditable;
        }

        Modify("VAT Amount")
        {
            Editable = IsEditable;
        }

        Modify("VAT Difference")
        {
            Editable = IsEditable;
        }

        Modify("VAT Prod. Posting Group")
        {
            Editable = IsEditable;
        }

        Modify(Amount)
        {
            Editable = IsEditable;
        }

        Modify(Correction)
        {
            Editable = IsEditable;
        }
        Modify(Description)
        {
            Editable = IsEditable;
        }

    }

    actions
    {
        modify(PreviewCheck)
        {
            Visible = false;
        }
        modify(PrintCheck)
        {
            Visible = false;
        }
        modify("Void Check")
        {
            Visible = false;
        }
        modify("Void &All Checks")
        {
            Visible = false;
        }

        addafter(Approvals)
        {
            group("Cheque Printing")
            {
                action("Print Arab Bank Cheque")
                {
                    ApplicationArea = All;
                    Image = Print;
                    PromotedCategory = Category11;
                    Promoted = true;
                    Visible = ShowChequePrintAction;
                    trigger OnAction()
                    var
                        RecGenJln: Record "Gen. Journal Line";
                        ArabBnkCheck: Report "Cheque Report ARAB";
                        RecUserSetup: Record "User Setup";
                    begin
                        RecUserSetup.GET(UserId);
                        RecUserSetup.TestField("Cheque Printing");
                        Rec.TestField("Cheque Printed", false);
                        Clear(RecGenJln);
                        RecGenJln.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                        RecGenJln.SetRange("Journal Template Name", Rec."Journal Template Name");
                        RecGenJln.SetRange("Line No.", Rec."Line No.");
                        if RecGenJln.FindFirst() then begin
                            Clear(ArabBnkCheck);
                            ArabBnkCheck.SetTableView(RecGenJln);
                            ArabBnkCheck.Run();

                        end;
                    end;
                }
                action("Print Blom Bank Cheque")
                {
                    ApplicationArea = All;
                    Image = Print;
                    PromotedCategory = Category11;
                    Promoted = true;
                    Visible = ShowChequePrintAction;
                    trigger OnAction()
                    var
                        RecGenJln: Record "Gen. Journal Line";
                        BlomBnkCheck: Report "Cheque Report BLOM BANK";
                        RecUserSetup: Record "User Setup";
                    begin
                        RecUserSetup.GET(UserId);
                        RecUserSetup.TestField("Cheque Printing");
                        Rec.TestField("Cheque Printed", false);
                        Clear(RecGenJln);
                        RecGenJln.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                        RecGenJln.SetRange("Journal Template Name", Rec."Journal Template Name");
                        RecGenJln.SetRange("Line No.", Rec."Line No.");
                        if RecGenJln.FindFirst() then begin
                            Clear(BlomBnkCheck);
                            BlomBnkCheck.SetTableView(RecGenJln);
                            BlomBnkCheck.Run();

                        end;
                    end;
                }
                action("Print ENBD Cheque")
                {
                    ApplicationArea = All;
                    Image = Print;
                    PromotedCategory = Category11;
                    Promoted = true;
                    Visible = ShowChequePrintAction;
                    trigger OnAction()
                    var
                        RecGenJln: Record "Gen. Journal Line";
                        NBDBnkCheck: Report "Cheque Report NBD";
                        RecUserSetup: Record "User Setup";
                    begin
                        RecUserSetup.GET(UserId);
                        RecUserSetup.TestField("Cheque Printing");
                        Rec.TestField("Cheque Printed", false);
                        Clear(RecGenJln);
                        RecGenJln.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                        RecGenJln.SetRange("Journal Template Name", Rec."Journal Template Name");
                        RecGenJln.SetRange("Line No.", Rec."Line No.");
                        if RecGenJln.FindFirst() then begin
                            Clear(NBDBnkCheck);
                            NBDBnkCheck.SetTableView(RecGenJln);
                            NBDBnkCheck.Run();
                        end;
                    end;
                }


                action("Cancel Cheque")
                {
                    ApplicationArea = All;
                    Image = VoidCheck;
                    PromotedCategory = Category11;
                    Promoted = true;
                    Visible = ShowChequePrintAction;
                    trigger OnAction()
                    var
                        RecGenJln: Record "Gen. Journal Line";
                        RecUserSetup: Record "User Setup";
                    begin
                        RecUserSetup.GET(UserId);
                        RecUserSetup.TestField("Cheque Voiding");
                        Rec.TestField("Cheque Printed", true);
                        Clear(RecGenJln);
                        RecGenJln.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                        RecGenJln.SetRange("Journal Template Name", Rec."Journal Template Name");
                        RecGenJln.SetRange("Line No.", Rec."Line No.");
                        if RecGenJln.FindFirst() then begin
                            RecGenJln."Cheque Printed" := false;
                            RecGenJln.Modify();
                            Message('Selected cheque has been cancelled.');
                        end;
                    end;
                }
            }
        }
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
        IsEditable: Boolean;
        ShowChequePrintAction: Boolean;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IsEditable := true;
    end;

    trigger OnOpenPage()
    var
        ReccompanyInfo: Record "Company Information";
    begin
        IsEditable := true;
        ReccompanyInfo.GET;
        if ReccompanyInfo."Show Actions to Print Cheque" then
            ShowChequePrintAction := true
        else
            ShowChequePrintAction := false;
    end;

    trigger OnAfterGetRecord()
    begin

        if Rec."Cheque Printed" then
            IsEditable := false
        else
            IsEditable := true;
    end;

    trigger OnModifyRecord(): Boolean
    var
        myInt: Integer;
    begin
        Rec.TestField("Cheque Printed", false);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        myInt: Integer;
    begin
        Rec.TestField("Cheque Printed", false);
    end;
}