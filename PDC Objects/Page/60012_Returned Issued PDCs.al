page 60012 "Returned Issued PDCs"
{
    // Code           Date        Name        Desc.
    // APNT-LCPDC1.0  20.05.12    Monica      Created New.

    Editable = false;
    PageType = Card;
    Caption = 'Returned Payment PDCs';
    SourceTable = "PDC Issue";
    SourceTableView = WHERE(Returned = CONST(true),
                            Posted = CONST(true),
                            Bounced = CONST(false));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Code"; Code)
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(Address; Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = All;
                }
                field(City; City)
                {
                    ApplicationArea = All;
                }
                field("Country Code"; "Country Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                }
                field(Control1000000050; '')
                {
                    CaptionClass = Text19064271;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Bank; Bank)
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Bank Address"; "Bank Address")
                {
                    ApplicationArea = All;
                }
                field("Bank Address 2"; "Bank Address 2")
                {
                    ApplicationArea = All;
                }
                field("Bank Post Code"; "Bank Post Code")
                {
                    ApplicationArea = All;
                }
                field("Bank City"; "Bank City")
                {
                    ApplicationArea = All;
                }
                field("Bank Country Code"; "Bank Country Code")
                {
                    ApplicationArea = All;
                }
                field("Bank Branch No."; "Bank Branch No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Account No."; "Bank Account No.")
                {
                    ApplicationArea = All;
                }
                field("Deposit Bank Dim1 Code"; "Deposit Bank Dim1 Code")
                {
                    ApplicationArea = All;
                }
                field("Deposit Bank Dim2 Code"; "Deposit Bank Dim2 Code")
                {
                    ApplicationArea = All;
                }
                field("Deposit Bank Dim3 Code"; "Deposit Bank Dim3 Code")
                {
                    ApplicationArea = All;
                }
                field("Deposit Bank Dim4 Code"; "Deposit Bank Dim4 Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field(Control1000000016; '')
                {
                    CaptionClass = Text19079450;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = All;
                }
                field("Cheque Date"; "Cheque Date")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Reference Type"; "Reference Type")
                {
                    ApplicationArea = All;
                }
                field("Applies-to ID"; "Applies-to ID")
                {
                    ApplicationArea = All;
                }
                field("UnApplied PDC"; "UnApplied PDC")
                {
                    ApplicationArea = All;
                }
                field(Control1000000030; '')
                {
                    CaptionClass = Text19059481;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
                field(Cleared; Cleared)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Applied Entries")
                {
                    Caption = 'Applied Entries';
                    RunObject = Page "Applied PDC Documents";
                    RunPageLink = "PDC No." = FIELD(Code);
                    ShortCutKey = 'Shift+F11';
                    ApplicationArea = All;
                }
                separator(Separator1000000063)
                {
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to reopen the PDC ?') then begin
                            if (Status = Status::Bounced) or (Status = Status::Returned) then begin
                                PDCAppliedAmtRec.Reset;
                                PDCAppliedAmtRec.SetFilter(PDCAppliedAmtRec."PDC No.", Code);
                                if PDCAppliedAmtRec.Find('-') then
                                    repeat
                                        PDCAppliedAmtRec.Delete;
                                    until PDCAppliedAmtRec.Next = 0;
                                Status := Status::" ";
                                Bounced := false;
                                Returned := false;
                                Posted := false;
                                Modify;
                            end;
                        end;
                    end;
                }
            }
        }
    }

    var
        PDCAppliedAmtRec: Record "PDC Applied Amount";
        Text19064271: Label 'Bank Details';
        Text19079450: Label 'Cheque Details';
        Text19059481: Label 'Status';
}

