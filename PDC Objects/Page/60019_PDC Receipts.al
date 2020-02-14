page 60019 "PDC Receipts"
{
    // Code           Date        Name        Desc.
    // APNT-LCPDC1.0  20.05.12    Monica      Created New.

    CardPageID = "PDC Receipt";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "PDC Receipt";
    SourceTableView = SORTING(Code)
                      WHERE(Posted = FILTER(false),
                            Bounced = FILTER(false),
                            "Returned/ Not Encashed" = FILTER(false));

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
                field("Customer No."; "Customer No.")
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
                field("Customer Bank"; "Customer Bank")
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; "Bank Name")
                {
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
                field(Status; Status)
                {
                    OptionCaption = '';
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
                            PDCReceiptRec.Copy(Rec);
                            PAGE.RunModal(PAGE::"Posted PDC Receipts", PDCReceiptRec);
                        end
                        else
                            if Bounced then begin
                                PDCReceiptRec.Copy(Rec);
                                PAGE.RunModal(PAGE::"Bounced PDC Receipts", PDCReceiptRec);
                            end
                            else
                                if "Returned/ Not Encashed" then begin
                                    PDCReceiptRec.Copy(Rec);
                                    PAGE.RunModal(PAGE::"Returned PDC Receipts", PDCReceiptRec);
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
                        if (Status = Status::Received) OR (Status = Status::" ") then begin
                            Rec.Status := Rec.Status::Closed;
                            Rec.Modify();
                        end else
                            Error('Status must be Received/" " to close the selected row.');
                    end;
                }
            }
        }
    }

    var
        PDCReceiptRec: Record "PDC Receipt";
}

