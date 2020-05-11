pageextension 50109 SalesOrder extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
        moveafter(Status; "Currency Code")
        moveafter("Currency Code"; "Shortcut Dimension 1 Code")
        moveafter("Shortcut Dimension 1 Code"; "Shortcut Dimension 2 Code")

        addlast(General)
        {
            field("Estimated Order Value"; "Estimated Order Value")
            {
                ApplicationArea = All;
            }
            field("Delivery Time"; "Delivery Time")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Estimated Order Value"; "Due Date")
        moveafter("Due Date"; "Requested Delivery Date")
        moveafter("Requested Delivery Date"; "External Document No.")

        modify("Document Date")
        {
            ApplicationArea = All;
            Visible = false;
        }

        modify("Campaign No.")
        {
            Visible = false;
        }

        modify("Opportunity No.")
        {
            Visible = false;
        }
        addafter("VAT Bus. Posting Group")
        {
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Work Description")
        {
            Visible = false;
        }

        addafter("Due Date")
        {
            field("Project Reference"; "Project Reference")
            {
                ApplicationArea = All;
            }
            field("Project Name"; "Project Name")
            {
                ApplicationArea = All;
            }
            field(Closed; Closed)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Check Collected"; "Check Collected")
            {
                ApplicationArea = All;
            }
            field(Priority; Priority)
            {
                ApplicationArea = All;
            }
        }
        moveafter("Project Name"; "Payment Terms Code")
        addlast("Invoice Details")
        {
            field("Amount (In Arabic)"; "Amount (In Arabic)")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
        }
        addafter("Foreign Trade")
        {
            group("Security Details")
            {
                field("Security Check No."; "Security ChecK No.")
                {
                    ApplicationArea = All;
                    Caption = 'Security Check No.';
                }
                field("Check Amount"; "Check Amount")
                {
                    ApplicationArea = All;
                }
                field("Check Date"; "Check Date")
                {
                    ApplicationArea = All;
                }
            }
            group("Credit Facility Details")
            {
                field("Bank Guarantee No."; "Bank Guarantee No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Guarantee Date"; "Bank Guarantee Date")
                {
                    ApplicationArea = All;
                }
                field("Bank Guarantee Amount"; "Bank Guarantee Amount")
                {
                    ApplicationArea = All;
                }
                field("LC No."; "LC No.")
                {
                    ApplicationArea = All;
                }
                field("LC Exp Date"; "LC Exp Date")
                {
                    ApplicationArea = All;
                }
                field("LC Amount"; "LC Amount")
                {
                    ApplicationArea = All;
                }
                field("LC Payment Terms"; "LC Payment Terms")
                {
                    ApplicationArea = All;
                }
            }

            group("Installation Details")
            {
                field("Date of Installation"; "Date of Installation")
                {
                    ApplicationArea = All;
                }
                field("Hourly Rate"; "Hourly Rate")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; "Start Time")
                {
                    ApplicationArea = all;
                }
                field("End Time"; "End Time")
                {
                    ApplicationArea = All;
                }
                field("Total Time"; "Total Time")
                {
                    ApplicationArea = All;
                }
                field("Installation Amount"; "Installation Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
        moveafter("Salesperson Code"; "Location Code")
        modify("Your Reference")
        {
            Caption = 'Inter-company OPP-Ref';//'IC Opp Ref No';//'Opportunity Reference No.';
        }
        addafter("Your Reference")
        {
            field("PO Reference"; "PO Reference")
            {
                ApplicationArea = All;
            }
        }
        //Payment Milestone Subform
        addbefore("Invoice Details")
        {
            part(PaymentMileStone; "Payment Milestone Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = field("Document Type"), "Document No." = FIELD("No.");
            }
        }
        addafter("Salesperson Code")
        {
            field("Share %"; "Share %")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify("Send IC Sales Order")
        {
            trigger OnBeforeAction()
            var
                ICPartner: Record "IC Partner";
            begin
                if ("Document Type" <> "Document Type"::Order) OR ("Sell-to IC Partner Code" = '') then
                    exit;
                IF ICPartner.GET("Bill-to IC Partner Code") then begin
                    ICPartner.TestField("Outbound Sales Item No. Type", ICPartner."Outbound Sales Item No. Type"::"Common Item No.");
                end;
            end;
        }
        modify(CreatePurchaseInvoice)
        {
            Enabled = false;
            Visible = false;
        }

        modify(CreatePurchaseOrder)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Project Name");
            end;
        }

        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                RecPT: Record "Payment Terms";
                RecPM: Record "Payment Milestone";
                TotalPercentage: Decimal;
                Sline: Record "Sales Line";
            begin
                Rec.TestField("Payment Terms Code");
                Rec.TestField("Currency Code");
                Rec.TestField("Shortcut Dimension 1 Code");
                if WorkDate() < Today() then
                    if not Confirm('Your Order Date is in the past. Please change it to the Current date.', false) then
                        exit;
                if WorkDate() > Today() then
                    if not Confirm('Your Order Date is in the future. Please change it to the Current date.', false) then
                        exit;
                if RecPT.GET(Rec."Payment Terms Code") then begin
                    if RecPT."Payment Milestone Mandatory" then begin
                        Clear(RecPM);
                        Clear(TotalPercentage);
                        RecPM.SetRange("Document Type", "Document Type"::Order);
                        RecPM.SetRange("Document No.", Rec."No.");
                        if RecPM.FindSet() then
                            repeat
                                TotalPercentage += RecPM."Milestone %";
                            until RecPM.Next() = 0;
                        if TotalPercentage = 0 then
                            Error('Payment Milestone must be defined.')
                        else
                            if TotalPercentage <> 100 then begin
                                Error('Payment Milestone % must be 100 for this order.');
                            end;
                    end;
                end;
                CalcFields("Retail Location");
                if not "Retail Location" then begin
                    Clear(Sline);
                    Sline.SetRange("Document Type", "Document Type"::Order);
                    Sline.SetRange("Document No.", "No.");
                    Sline.SetRange(Type, Sline.Type::Item);
                    if Sline.FindSet() then begin
                        repeat
                            if Sline."Estimated Cost" = 0 then
                                Sline.TestField("FOC Reason");
                        until Sline.Next() = 0;
                    end;
                end;
            end;
        }
        addafter("&Print")
        {
            group(Closing)
            {
                action("Handover")
                {
                    ApplicationArea = All;
                    Image = Completed;
                    trigger OnAction()
                    begin
                        Rec."Project Handover" := true;
                        Rec.Modify();
                    end;
                }
                action(Close)
                {
                    ApplicationArea = All;
                    Image = Close;
                    trigger OnAction()
                    var
                        Sline: Record "Sales Line";
                        RecPM: Record "Payment Milestone";
                    begin
                        /*
                          Clear(Sline);
                          Sline.SetRange("Document Type", Rec."Document Type");
                          Sline.SetRange("Document No.", Rec."No.");
                          if Sline.FindSet() then begin
                              repeat
                                  If not ((Sline.Quantity = Sline."Quantity Shipped") AND (Sline."Quantity Shipped" = Sline."Quantity Invoiced")) then
                                      Error('Order is not Shipped or Invoiced completely.You cannot close the Order.');
                              until Sline.Next() = 0;
                          end;
                          */
                        Clear(RecPM);
                        RecPM.SetRange("Document Type", "Document Type"::Order);
                        RecPM.SetRange("Document No.", "No.");
                        RecPM.SetFilter("Line No.", '<>%1', 0);
                        if RecPM.FindFirst() then begin
                            Rec.TestField("Project Handover", true);
                        end;
                        if not Confirm('Are you sure you want to close the order?', false) then
                            Exit;
                        Rec.Closed := true;
                        Rec.Modify();
                    end;
                }
            }
        }


        addafter(History)
        {
            group(Import)
            {
                action("Upload Sales Lines")
                {
                    ApplicationArea = All;
                    Image = Import;

                    trigger OnAction()
                    var
                        IsertLine: Codeunit "Import Functions";
                        RecSalesLineBuffer: Record "Sales Line Buffer";
                        ErrorMessage: Text;
                        dlgProgress: Dialog;
                        nRecNum: Integer;
                        ValidatingRecord: Label 'Validating Records #1';
                        InsertingRecords: Label 'Inserting Sales Order Lines #1';
                        ErrorMessageOnInsert: Text;
                        FaultCount: Integer;
                    begin
                        if Confirm('Are you sure you want to import Sales Order Lines using CSV?', false) then begin
                            Clear(RecSalesLineBuffer);
                            RecSalesLineBuffer.SetFilter("Entry No.", '<>%1', 0);
                            RecSalesLineBuffer.SetFilter(UploadedBy, '=%1', UserId);
                            if RecSalesLineBuffer.FindSet() then
                                RecSalesLineBuffer.DeleteAll();
                            Xmlport.Run(50106, false, true);
                            Clear(RecSalesLineBuffer);
                            ErrorMessage := '';
                            ErrorMessageOnInsert := '';
                            RecSalesLineBuffer.SetFilter("Entry No.", '<>%1', 0);
                            RecSalesLineBuffer.SetFilter(UploadedBy, '=%1', UserId);
                            RecSalesLineBuffer.SetRange("Sales Order No.", Rec."No.");//To upload only order that is belongs to current order
                            if RecSalesLineBuffer.FindSet() then begin
                                dlgProgress.OPEN(ValidatingRecord);
                                nRecNum := 0;
                                IsertLine.SetInsertfalg(false);
                                repeat
                                    nRecNum += 1;
                                    dlgProgress.UPDATE(1, nRecNum);
                                    // IsertLine.SetInsertfalg(false);
                                    Commit();
                                    if not IsertLine.Run(RecSalesLineBuffer) then begin
                                        ErrorMessage := ErrorMessage + '\' + GetLastErrorText;
                                    end;
                                until RecSalesLineBuffer.Next() = 0;
                                dlgProgress.CLOSE;
                            end;
                            if ErrorMessage = '' then begin
                                Clear(RecSalesLineBuffer);
                                RecSalesLineBuffer.LockTable(true);//lock
                                RecSalesLineBuffer.SetFilter("Entry No.", '<>%1', 0);
                                RecSalesLineBuffer.SetFilter(UploadedBy, '=%1', UserId);
                                if RecSalesLineBuffer.FindSet() then begin
                                    dlgProgress.OPEN(InsertingRecords);
                                    nRecNum := 0;
                                    FaultCount := 0;
                                    IsertLine.SetInsertfalg(true);
                                    repeat
                                        nRecNum += 1;
                                        dlgProgress.UPDATE(1, nRecNum);
                                        //IsertLine.SetInsertfalg(true);
                                        Commit();
                                        if not IsertLine.Run(RecSalesLineBuffer) then begin
                                            ErrorMessageOnInsert := ErrorMessageOnInsert + '\' + GetLastErrorText + 'Sales Order No.: ' + RecSalesLineBuffer."Sales Order No." + ' Vendor Article No: ' + RecSalesLineBuffer."Vendor Article No." + ' Vendor No.: ' + RecSalesLineBuffer."Vendor No.";
                                            FaultCount += 1;
                                        end;
                                    //Commit();//Added later
                                    until RecSalesLineBuffer.Next() = 0;
                                    dlgProgress.CLOSE;
                                    if ErrorMessageOnInsert = '' then
                                        Message(Format(nRecNum) + ' Lines Inserted successfully.')
                                    else
                                        Message(Format(nRecNum - FaultCount) + ' Lines Inserted out of ' + format(nRecNum) + '\' + 'Error List :- ' + '\' + ErrorMessageOnInsert);
                                end;
                                Clear(RecSalesLineBuffer);
                                RecSalesLineBuffer.SetFilter("Entry No.", '<>%1', 0);
                                RecSalesLineBuffer.SetFilter(UploadedBy, '=%1', UserId);
                                if RecSalesLineBuffer.FindSet() then
                                    RecSalesLineBuffer.DeleteAll();
                            end else begin
                                Clear(RecSalesLineBuffer);
                                RecSalesLineBuffer.SetFilter("Entry No.", '<>%1', 0);
                                RecSalesLineBuffer.SetFilter(UploadedBy, '=%1', UserId);
                                if RecSalesLineBuffer.FindSet() then
                                    RecSalesLineBuffer.DeleteAll();
                                Message(ErrorMessage);
                            end;
                            Clear(RecSalesLineBuffer);
                            RecSalesLineBuffer.SetFilter("Entry No.", '<>%1', 0);
                            RecSalesLineBuffer.SetFilter(UploadedBy, '=%1', UserId);
                            if RecSalesLineBuffer.FindSet() then
                                RecSalesLineBuffer.DeleteAll();
                        end;
                    end;
                }
            }
            group("Payment Milestones")
            {
                Image = SetupPayment;
                action("Payment Milestone")
                {
                    ApplicationArea = All;
                    Image = SetupPayment;
                    ShortcutKey = 'Shift+Ctrl+M';
                    trigger OnAction()
                    var
                        PaymentMileStonePage: page "Payment Milestone";
                        RecPaymentMileStone: Record "Payment Milestone";
                        RecPT: Record "Payment Terms";
                    begin
                        Rec.TestField("Currency Code");
                        Clear(RecPT);
                        IF RecPT.GET(Rec."Payment Terms Code") then begin
                            if not RecPT."Payment Milestone Mandatory" then
                                Error('Payment Milestone is not allowed for selected Payment Terms Code.');
                        end;
                        Rec.CalcFields(Amount);
                        PaymentMileStonePage.SetDocNumber('Order', Rec."Document Date", Rec.Amount, Rec."Currency Factor", Rec."No.");
                        PaymentMileStonePage.SetEditable(true);
                        RecPaymentMileStone.SetRange("Document Type", "Document Type"::Order);
                        RecPaymentMileStone.SetRange("Document No.", Rec."No.");
                        if RecPaymentMileStone.FindSet() then;
                        PaymentMileStonePage.SetTableView(RecPaymentMileStone);
                        PaymentMileStonePage.Run();
                    end;

                }
            }
            group("Holistic Views")
            {
                Image = View;
                action("Holistic View")
                {
                    ApplicationArea = All;
                    Caption = 'Holistic View';
                    Image = View;

                    trigger OnAction()
                    var
                        SLine: Record "Sales Line";
                        HolisticView: Page "Sales Order Holistic View";
                    begin
                        Clear(SLine);
                        SLine.SetRange("Document Type", Rec."Document Type");
                        SLine.SetRange("Document No.", Rec."No.");
                        if SLine.FindSet() then;
                        HolisticView.SetTableView(SLine);
                        HolisticView.Editable(false);
                        HolisticView.Run();
                    end;

                }
            }
            group("SO Splits")
            {
                Image = DeactivateDiscounts;
                action("SO Split")
                {
                    ApplicationArea = All;
                    Caption = 'SO Split';
                    Image = DeactivateDiscounts;

                    trigger OnAction()
                    var
                        RecSOSplit: Record "Sales Person Main";
                        SoSPlit: Page "Sales Person Share Main";
                    begin
                        Clear(RecSOSplit);
                        RecSOSplit.SetRange("Opportunity No", Rec."Shortcut Dimension 1 Code");
                        if RecSOSplit.FindSet() then;
                        SoSPlit.SetTableView(RecSOSplit);
                        //SoSPlit.Editable(false);
                        SoSPlit.Run();
                    end;

                }
            }

            group(Printing)
            {
                Image = Print;
                action("Pro Forma Invoice")
                {
                    ApplicationArea = All;
                    Image = Print;
                    trigger OnAction()
                    var
                        Sheader: Record "Sales Header";
                        ProformaInvoice: Report 50121;
                        ProformaInvoiceWithholding: Report 50146;
                        RecCompanyInfo: Record "Company Information";
                    begin
                        RecCompanyInfo.GET;
                        Clear(Sheader);
                        Sheader.SetRange("Document Type", Sheader."Document Type"::Order);
                        Sheader.SetRange("No.", Rec."No.");
                        IF Sheader.FindFirst() then begin
                            if RecCompanyInfo."With Holding Tax Applicable" then begin
                                ProformaInvoiceWithholding.SetTableView(Sheader);
                                ProformaInvoiceWithholding.Run();
                            end else begin
                                ProformaInvoice.SetTableView(Sheader);
                                ProformaInvoice.Run();
                            end;
                        end;
                    end;
                }
            }
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                CheckAdvanceGLAmount();
            end;
        }
        modify(PostAndNew)
        {
            trigger OnBeforeAction()
            begin
                CheckAdvanceGLAmount();
            end;
        }
        modify(PostAndSend)
        {
            trigger OnBeforeAction()
            begin
                CheckAdvanceGLAmount();
            end;
        }

        addafter("&Order Confirmation")
        {
            action("Posted Sales Invoices")
            {
                ApplicationArea = All;
                Image = CoupledInvoice;
                trigger OnAction()
                VAR
                    SalesInvLine: Record "Sales Invoice Line";
                    SalesInvHeader: Record "Sales Invoice Header";
                    SalesInvoiceList: Page "Posted Sales Invoices";
                    CheckList: List of [Text];
                    FilterText: Text;
                begin
                    Clear(SalesInvLine);
                    Clear(FilterText);
                    SalesInvLine.SetRange("Sales Order No.", Rec."No.");
                    if SalesInvLine.FindSet() then begin
                        repeat
                            if not CheckList.Contains(SalesInvLine."Document No.") then begin
                                CheckList.Add(SalesInvLine."Document No.");
                                FilterText := FilterText + SalesInvLine."Document No." + '|';
                            end;
                        until SalesInvLine.Next() = 0;
                    end;
                    if FilterText <> '' then begin
                        FilterText := CopyStr(FilterText, 1, StrLen(FilterText) - 1);
                        Clear(SalesInvHeader);
                        SalesInvHeader.SetFilter("No.", FilterText);
                        if SalesInvHeader.FindSet() then begin
                            Clear(SalesInvoiceList);
                            SalesInvoiceList.SetTableView(SalesInvHeader);
                            SalesInvoiceList.Caption := 'Posted Sales Invoices for ' + Rec."No.";
                            SalesInvoiceList.Run;
                        end;
                    end;
                end;
            }
        }
    }

    local procedure CheckAdvanceGLAmount()
    var
        Sline: Record "Sales Line";
        RecSnRSetup: Record "Sales & Receivables Setup";
        TotalAdvanceLineAmout: Decimal;
    begin
        RecSnRSetup.GET;
        Clear(Sline);
        Clear(TotalAdvanceLineAmout);
        Sline.SetRange("Document Type", "Document Type"::Order);
        Sline.SetRange("Document No.", Rec."No.");
        Sline.SetRange(Type, Sline.Type::"G/L Account");
        Sline.SetRange("No.", RecSnRSetup."Retail Advance Account");
        If Sline.FindSet() then begin
            Repeat
                TotalAdvanceLineAmout += Sline."Amount Including VAT";
            until Sline.Next() = 0;
        end;
        if TotalAdvanceLineAmout <> 0 then
            Error('Retail Advance account balance must be Zero.');
    end;

    procedure BuildFilter(var InitialFilter: text; NewValue: Text)
    begin
        IF STRPOS(InitialFilter, NewValue) = 0 THEN BEGIN
            IF STRLEN(InitialFilter) > 0 THEN
                InitialFilter += '|';
            InitialFilter += NewValue;
        END;
    end;

    var
        myInt: Integer;
        Filtertext: Text;
}