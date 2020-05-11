pageextension 50126 SalesOrderList extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Salesperson Code")
        {
            field("Created By"; "Created By")
            {
                ApplicationArea = All;
                Enabled = false;
            }
            field(Closed; Closed)
            {
                ApplicationArea = All;
            }
        }
        addbefore(Amount)
        {
            field("Share %"; "Share %")
            {
                ApplicationArea = All;
            }
        }
        addafter("Completely Shipped")
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
            field("LC Payment Terms"; "LC Payment Terms")
            {
                ApplicationArea = All;
            }
            field("LC Amount"; "LC Amount")
            {
                ApplicationArea = All;
            }
        }
        addlast(Control1)
        {
            field("G/L Invoiced"; "G/L Invoiced")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Non Stock Invoiced"; "Non Stock Invoiced")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("UE GP"; "UE GP")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("UE GP ACY"; "UE GP ACY")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("UE Sales"; "UE Sales")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("UE Sales ACY"; "UE Sales ACY")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        /* modify("P&osting")
         {
             Visible = false;
         }*/
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                RecPT: Record "Payment Terms";
                RecPM: Record "Payment Milestone";
                TotalPercentage: Decimal;
            begin
                Rec.TestField("Currency Code");
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
            end;
        }
        modify("Post &Batch")
        {
            trigger OnBeforeAction()
            begin
                Error('You are not allowed to post the Sales Order.');
            end;
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                CheckAdvanceGLAmount;
            end;
        }
        modify(PostAndSend)
        {
            trigger OnBeforeAction()
            begin
                CheckAdvanceGLAmount;
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
        addafter(Warehouse)
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
                            if RecSalesLineBuffer.FindSet() then begin
                                dlgProgress.OPEN(ValidatingRecord);
                                nRecNum := 0;
                                IsertLine.SetInsertfalg(false);
                                repeat
                                    nRecNum += 1;
                                    dlgProgress.UPDATE(1, nRecNum);
                                    // IsertLine.SetInsertfalg(false);//Calling once before loop
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
                                        //IsertLine.SetInsertfalg(true);//Calling once before loop
                                        Commit();
                                        if not IsertLine.Run(RecSalesLineBuffer) then begin
                                            ErrorMessageOnInsert := ErrorMessageOnInsert + '\' + GetLastErrorText + 'Sales Order No.: ' + RecSalesLineBuffer."Sales Order No." + ' Vendor Article No: ' + RecSalesLineBuffer."Vendor Article No." + ' Vendor No.: ' + RecSalesLineBuffer."Vendor No.";
                                            FaultCount += 1;
                                        end;
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
                action("Payment Milestone")
                {
                    ApplicationArea = All;
                    Image = SetupPayment;
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
            group(Closing)
            {
                action("Handover")
                {
                    ApplicationArea = All;
                    Image = Completed;
                    trigger OnAction()
                    begin
                        if Rec."Project Handover" then
                            Exit;
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
                        if Rec.Closed then
                            Exit;
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
            group(Printing)
            {
                /*action(Print)
                    {
                        ApplicationArea = All;
                        Image = Print;
                        trigger OnAction()
                        var
                            Sheader: Record "Sales Header";
                            DeliveryReport: Report "Sales Order Delivery Note";
                        begin
                            Clear(Sheader);
                            Sheader.SetRange("Document Type", Sheader."Document Type"::Order);
                            Sheader.SetRange("No.", Rec."No.");
                            IF Sheader.FindFirst() then begin
                                DeliveryReport.SetTableView(Sheader);
                                DeliveryReport.Run();
                            end;
                        end;
                    }*/
                action("Pro forma Invoice")
                {
                    ApplicationArea = All;
                    Image = Print;
                    trigger OnAction()
                    var
                        Sheader: Record "Sales Header";
                        DeliveryReport: Report 50121;
                    begin
                        Clear(Sheader);
                        Sheader.SetRange("Document Type", Sheader."Document Type"::Order);
                        Sheader.SetRange("No.", Rec."No.");
                        IF Sheader.FindFirst() then begin
                            DeliveryReport.SetTableView(Sheader);
                            DeliveryReport.Run();
                        end;
                    end;
                }

            }

        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        SetFilter(Closed, '=%1', false);
        IF UserSetup.GET(UserId) then begin
            IF UserSetup."Retail User" then begin
                CalcFields("Retail Location");
                SetFilter("Retail Location", '=%1', TRUE);
            end;
        end;
    end;

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


    var
        myInt: Integer;
}