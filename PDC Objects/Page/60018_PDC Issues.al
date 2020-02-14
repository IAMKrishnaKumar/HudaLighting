page 60018 "PDC Issues"
{
    // Code           Date        Name        Desc.
    // APNT-LCPDC1.0  20.05.12    Monica      Created New.
    Caption = 'PDC Payment';
    CardPageID = "PDC Issue";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "PDC Issue";
    SourceTableView = WHERE(Posted = CONST(false),
                            Bounced = CONST(false),
                            Returned = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Code"; Code)
                {
                    ApplicationArea = All;
                }
                field("Reference Type"; "Reference Type")
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
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Deposit Date"; "Deposit Date")
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
                field(Bank; Bank)
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
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
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        if Cleared = true then begin
                            PDCIssueRec.Copy(Rec);
                            PAGE.RunModal(PAGE::"Posted Issued PDCs", PDCIssueRec);
                        end else
                            if Bounced then begin
                                PDCIssueRec.Copy(Rec);
                                PAGE.RunModal(PAGE::"Bounced Issued PDCs", PDCIssueRec);
                            end else
                                if Returned then begin
                                    PDCIssueRec.Copy(Rec);
                                    PAGE.RunModal(PAGE::"Returned Issued PDCs", PDCIssueRec);
                                end;
                    end;
                }
            }
            group(Closing)
            {
                action(Close)
                {
                    ApplicationArea = All;
                    Image = Close;

                    trigger OnAction()
                    var
                        UserSetup: Record "User Setup";
                    begin
                        Clear(UserSetup);
                        UserSetup.GET(UserId);
                        UserSetup.TestField("Retail User", true);
                        if (Status = Status::Issued) OR (Status = Status::" ") then begin
                            Rec.Status := Rec.Status::Closed;
                            Rec.Modify();
                        end else
                            Error('Status must be Issued/" " to close the selected row.');
                    end;
                }
            }
        }
    }

    var
        PDCIssueRec: Record "PDC Issue";
}

