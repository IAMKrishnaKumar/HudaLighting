codeunit 50104 HudaEvents
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmSalesPost', '', false, false)]
    procedure ToCheckTaxInfobeforePost(VAR SalesHeader: Record "Sales Header"; VAR HideDialog: Boolean; VAR IsHandled: Boolean)
    var
        compInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        SLine: Record "Sales Line";
        UserSetup: Record "User Setup";
        RecLocation: Record Location;
        RecPT: Record "Payment Terms";
        RecPaymentMilestone: Record "Payment Milestone";
        TotalPercentage: Decimal;
    begin
        compInfo.GET;
        GLSetup.GET;
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) AND (compInfo."With Holding Tax Applicable") then begin
            Clear(SLine);
            SLine.SetRange("Document Type", SalesHeader."Document Type");
            SLine.SetRange("Document No.", SalesHeader."No.");
            SLine.SetRange(Type, SLine.Type::"G/L Account");
            SLine.SetRange("No.", GLSetup."With Holding Tax Payable GL");
            if not SLine.FindFirst() then
                Error('Select Withholding Tax Payable GL in sales invoice Line');
        end;
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) then begin
            Clear(SLine);
            SLine.SetRange("Document Type", SLine."Document Type"::Order);
            SLine.SetRange("Document No.", SalesHeader."No.");
            SLine.SetRange("Drop Shipment", true);
            if not SLine.FindFirst() then begin
                Clear(UserSetup);
                if UserSetup.GET(UserId) then begin
                    if not UserSetup."Retail User" then
                        Error('You are not allowed to post the sales order.');
                end else
                    Error('You are not allowed to post the sales order.');
            end;
        end;
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) then begin
            SalesHeader.TestField("Payment Terms Code");
            //SalesHeader.TestField("Currency Code");
            Clear(RecLocation);
            IF RecLocation.GET(SalesHeader."Location Code") then begin
                if RecLocation."Retail Location" then begin
                    SalesHeader.TestField("Payment Method Code");
                end;
            end;

            Clear(RecPT);
            Clear(TotalPercentage);
            If RecPT.GET(SalesHeader."Payment Terms Code") then begin
                if RecPT."Payment Milestone Mandatory" then begin
                    Clear(RecPaymentMilestone);
                    RecPaymentMilestone.SetRange("Document Type", RecPaymentMilestone."Document Type"::Invoice);
                    RecPaymentMilestone.SetRange("Document No.", SalesHeader."No.");
                    if RecPaymentMilestone.FindSet() then begin
                        repeat
                            TotalPercentage += RecPaymentMilestone."Milestone %";
                        until RecPaymentMilestone.Next() = 0;
                    end else
                        Error('Payment Milestone is mandatory for this order.');

                    if TotalPercentage <> 100 then
                        Error('Total Payment Milestone % must be 100.');
                end;
            end;

        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', false, false)]
    procedure ToCheckTaxDetailsBeforePosting(VAR PurchaseHeader: Record "Purchase Header"; VAR HideDialog: Boolean; VAR IsHandled: Boolean)
    var
        compInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        PLine: Record "Purchase Line";
        UserSetup: Record "User Setup";
    begin
        compInfo.GET;
        GLSetup.GET;
        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice) AND (compInfo."With Holding Tax Applicable") then begin
            Clear(PLine);
            PLine.SetFilter("Document Type", '=%1', PurchaseHeader."Document Type");
            PLine.SetRange("Document No.", PurchaseHeader."No.");
            PLine.SetRange(Type, PLine.Type::"G/L Account");
            PLine.SetRange("No.", GLSetup."With holding Tax Receivable GL");
            if not PLine.FindFirst() then
                Error('Select Withholding Tax Receivable in Purchase Invoice Line');
        end;
        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) then begin
            Clear(PLine);
            Pline.SetRange("Document Type", PLine."Document Type"::Order);
            PLine.SetRange("Document No.", PurchaseHeader."No.");
            PLine.SetRange("Drop Shipment", true);
            if not PLine.FindFirst() then begin
                Clear(UserSetup);
                if UserSetup.GET(UserId) then begin
                    if not UserSetup."Retail User" then
                        Error('You are not allowed to post the Purchase Order.');
                end else
                    Error('You are not allowed to post the Purchase Order.');
            end;
        end;
        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice) then begin
            PurchaseHeader.TestField("Payment Terms Code");
            // PurchaseHeader.TestField("Currency Code");
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitBankAccLedgEntry', '', false, false)]
    procedure ToInsertCustomFieldsInBLE(VAR BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        // Narration check date and Check No.
        BankAccountLedgerEntry.Narration := GenJournalLine.Narration;
        BankAccountLedgerEntry."Check No." := GenJournalLine."Check No.";
        BankAccountLedgerEntry."Check Date" := GenJournalLine."Check Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitVendLedgEntry', '', false, false)]
    procedure ToInsertCustomFieldsInVLE(VAR VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin

        // Narration check date and Check No.
        VendorLedgerEntry.Narration := GenJournalLine.Narration;
        VendorLedgerEntry."Check No." := GenJournalLine."Check No.";
        VendorLedgerEntry."Check Date" := GenJournalLine."Check Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', false, false)]
    procedure ToInsertCustomFieldsInCLE(VAR CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        // Narration check date and Check No.
        CustLedgerEntry.Narration := GenJournalLine.Narration;
        CustLedgerEntry."Check No." := GenJournalLine."Check No.";
        CustLedgerEntry."Check Date" := GenJournalLine."Check Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', false, false)]
    procedure ToInsertCustomFielsInGL(VAR GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry.Narration := GenJournalLine.Narration;
        GLEntry."Check No." := GenJournalLine."Check No.";
        GLEntry."Check Date" := GenJournalLine."Check Date";
        GLEntry."Payee Name" := GenJournalLine."Payee Name";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnAfterConfirmPost', '', false, false)]
    procedure CheckShipentDate(SalesHeader: Record "Sales Header")
    var
        Sline: Record "Sales Line";
    begin
        if (SalesHeader.Ship) then begin
            SalesHeader.TestField("Shipment Date");
            Clear(Sline);
            Sline.SetRange("Document Type", SalesHeader."Document Type");
            Sline.SetRange("Document No.", SalesHeader."No.");
            Sline.SetFilter(Type, '<>%1', Sline.Type::" ");
            If Sline.FindSet() then
                repeat
                    Sline.TestField("Shipment Date");
                until Sline.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Vendor Card", 'OnNewRecordEvent', '', false, false)]
    procedure CheckVendorReplication(VAR Rec: Record Vendor; BelowxRec: Boolean; VAR xRec: Record Vendor)
    var
        RecCompInfo: Record "Company Information";
    begin
        RecCompInfo.GET;
        //RecCompInfo.TestField("Vendor Replication Master", true);
        if not RecCompInfo."Vendor Replication Master" then
            Error('You do not have permission to create Vendor. Please contact the Administrator.');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Get Shipment", 'OnAfterInsertLine', '', false, false)]
    procedure InsertPaymentMileStoneLines(VAR SalesShptLine: Record "Sales Shipment Line"; VAR SalesLine: Record "Sales Line")
    var
        RecPm: Record "Payment Milestone";
        Sheader: Record "Sales Header";
        RecPm2: Record "Payment Milestone";
        Sheader2: Record "Sales Header";
        Sline: Record "Sales Line";
        RecSalesLine: Record "Sales Line";
        RecItem: Record Item;
        SalesLine2: Record "Sales Line";
    begin
        Clear(Sheader);
        Sheader.SetRange("Document Type", SalesLine."Document Type");
        Sheader.SetRange("No.", SalesLine."Document No.");
        Sheader.FindFirst();
        Sheader.CalcFields(Amount);//calc
        RecPm2.SetRange("Document Type", RecPm2."Document Type"::Order);
        RecPm2.SetRange("Document No.", SalesShptLine."Order No.");
        if RecPm2.FindSet() then begin
            repeat
                Clear(RecPm);
                RecPm.SetRange("Document Type", SalesLine."Document Type");
                RecPm.SetRange("Document No.", SalesLine."Document No.");
                RecPm.SetRange("Line No.", RecPm2."Line No.");
                if not RecPm.FindSet() then begin
                    RecPm.Init();
                    RecPm."Document Type" := SalesLine."Document Type";
                    RecPm."Document No." := SalesLine."Document No.";
                    RecPm.Validate("Document Date", Sheader."Document Date");
                    RecPm.Validate("Posting Type", RecPm2."Posting Type");
                    RecPm.Validate("Currency Factor", Sheader."Currency Factor");
                    Sheader.CalcFields(Amount);
                    RecPm.Validate("Total Value", Sheader.Amount);
                    RecPm.Validate("Customer No.", Sheader."Sell-to Customer No.");
                    RecPm.Validate("Milestone %", RecPm2."Milestone %");
                    RecPm.Validate("Milestone Description", RecPm2."Milestone Description");
                    Recpm.Validate("Payment Terms", RecPm2."Payment Terms");
                    RecPm.Invoiced := RecPm2.Invoiced;
                    RecPm."Line No." := RecPm2."Line No.";
                    RecPm.Insert();
                end else begin
                    Sheader.CalcFields(Amount);
                    RecPm.Validate("Total Value", Sheader.Amount);
                    RecPm.Modify();
                end;
            until RecPm2.Next() = 0;
        end;

        // Inserting Non Inventory Items to the sales line Table        
        Clear(Sline);
        Sline.SetRange("Document Type", Sline."Document Type"::Order);
        Sline.SetRange("Document No.", SalesShptLine."Order No.");
        Sline.SetRange(Type, Sline.Type::Item);
        //Sline.SetFilter("Line No.", '<>%1', SalesLine."Line No.");
        if Sline.FindSet() then begin
            repeat
                Clear(RecItem);
                RecItem.GET(Sline."No.");
                if RecItem.Type <> RecItem.Type::Inventory then begin
                    Clear(SalesLine2);
                    SalesLine2.SetRange("Document Type", SalesLine2."Document Type"::Invoice);
                    SalesLine2.SetRange("Document No.", SalesLine."Document No.");
                    SalesLine2.SetRange(Type, SalesLine2.Type::Item);
                    SalesLine2.SetRange("No.", Sline."No.");
                    if not SalesLine2.FindSet() then begin
                        Clear(RecSalesLine);
                        Clear(SalesLine2);
                        SalesLine2.SetRange("Document Type", SalesLine."Document Type");
                        SalesLine2.SetRange("Document No.", SalesLine."Document No.");
                        if SalesLine2.FindLast() then;
                        RecSalesLine.Init();
                        RecSalesLine.SetHideValidationDialog(true);
                        RecSalesLine.TransferFields(Sline);
                        RecSalesLine.Validate("Document Type", SalesLine."Document Type");
                        RecSalesLine.Validate("Document No.", SalesLine."Document No.");
                        RecSalesLine.Validate("Line No.", SalesLine2."Line No." + 10000);
                        RecSalesLine."Sales Order No." := SalesShptLine."Order No.";
                        //RecSalesLine."Shipment No." := SalesShptLine."Document No.";//Creating problem while get shipment as it is a service Item
                        RecSalesLine.Validate(Quantity, Sline.Quantity);
                        RecSalesLine.Insert(true);
                    end;
                end;
            until Sline.Next() = 0;
        end;
        Clear(Sheader2);
        Sheader2.SetRange("Document Type", Sheader2."Document Type"::Order);
        Sheader2.SetRange("No.", SalesShptLine."Order No.");
        if Sheader2.FindFirst() then begin
            Sheader.SetHideValidationDialog(true);
            //Sheader.Validate("Shortcut Dimension 1 Code", Sheader2."Shortcut Dimension 1 Code");
            Sheader.Validate("Payment Terms Code", Sheader2."Payment Terms Code");
            Sheader.Validate("Payment Method Code", Sheader2."Payment Method Code");
            Sheader.Validate("Location Code", Sheader2."Location Code");
            Sheader.Validate("Salesperson Code", Sheader2."Salesperson Code");
            //Sheader.Validate("Dimension Set ID", Sheader2."Dimension Set ID");
            Sheader.Validate("Currency Code", Sheader2."Currency Code");
            Sheader."Project Reference" := Sheader2."Project Reference";
            Sheader."Project Name" := Sheader2."Project Name";
            Sheader."Bank Guarantee No." := Sheader2."Bank Guarantee No.";
            Sheader."Security ChecK No." := Sheader2."Security ChecK No.";
            Sheader."Check Date" := Sheader2."Check Date";
            Sheader."Bank Guarantee Amount" := Sheader2."Bank Guarantee Amount";
            Sheader."Bank Guarantee Date" := Sheader2."Bank Guarantee Date";
            Sheader."Date of Installation" := Sheader2."Date of Installation";
            Sheader."Installation Amount" := Sheader2."Installation Amount";
            Sheader."Hourly Rate" := Sheader2."Hourly Rate";
            Sheader."Start Time" := Sheader2."Start Time";
            Sheader."End Time" := Sheader2."End Time";
            Sheader."Total Time" := Sheader2."Total Time";
            Sheader."PO Reference" := Sheader2."PO Reference";
            Sheader.Ship := true;
            Sheader.Modify();
        end;
    End;


    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnBeforeInsertInvLineFromShptLine', '', false, false)]
    procedure InsertSONumberInLine(VAR SalesShptLine: Record "Sales Shipment Line"; VAR SalesLine: Record "Sales Line"; SalesOrderLine: Record "Sales Line")
    VAR
        RecSalesLine: Record "Sales Line";
    begin
        SalesLine."Sales Order No." := SalesShptLine."Order No.";

        Clear(RecSalesLine);
        RecSalesLine.SetRange("Document Type", RecSalesLine."Document Type"::Invoice);
        RecSalesLine.SetRange("Document No.", SalesLine."Document No.");
        RecSalesLine.SetFilter("Sales Order No.", '<>%1', '');
        RecSalesLine.SetFilter("Sales Order No.", '<>%1', SalesShptLine."Order No.");
        RecSalesLine.SetRange(Type, RecSalesLine.Type::Item);
        RecSalesLine.SetFilter("No.", '<>%1', '');
        if RecSalesLine.FindFirst() then
            Error('You cannot select lines from two different orders.');
    end;

    //GetreceiptLine
    [EventSubscriber(ObjectType::Table, DATABASE::"Purch. Rcpt. Line", 'OnBeforeInsertInvLineFromRcptLine', '', false, false)]
    procedure InsertPurchOrderNoToInvoice(VAR PurchRcptLine: Record "Purch. Rcpt. Line"; VAR PurchLine: Record "Purchase Line"; PurchOrderLine: Record "Purchase Line")
    VAR
        Pheader: Record "Purchase Header";
        Pheader2: Record "Purchase Header";
    begin
        PurchLine."Purchase Order No." := PurchRcptLine."Order No.";
        Clear(Pheader);
        Pheader.SetRange("Document Type", PurchLine."Document Type");
        Pheader.SetRange("No.", PurchLine."Document No.");
        if Pheader.FindFirst() then begin
            Clear(Pheader2);
            Pheader2.SetRange("Document Type", Pheader2."Document Type"::Order);
            Pheader2.SetRange("No.", PurchRcptLine."Order No.");
            if Pheader2.FindFirst() then begin
                Pheader.SetHideValidationDialog(true);
                //Pheader.Validate("Shortcut Dimension 1 Code", Pheader2."Shortcut Dimension 1 Code");
                Pheader.Validate("Payment Terms Code", Pheader2."Payment Terms Code");
                // Pheader.Validate("Payment Method Code", Pheader2."Payment Method Code");
                Pheader.Validate("Location Code", Pheader2."Location Code");
                //Pheader.Validate("Purchaser Code", Pheader2."Purchaser Code");
                //Pheader."Shortcut Dimension 1 Code" := Pheader2."Shortcut Dimension 1 Code";
                //Pheader."Dimension Set ID" := Pheader2."Dimension Set ID";//Removed Validate 
                Pheader.Validate("Currency Code", Pheader2."Currency Code");
                // Pheader."Project Reference" := Pheader2."Project Reference";
                // Pheader."Project Name" := Pheader2."Project Name";
                Pheader.Modify();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment (Yes/No)", 'OnAfterConfirmPost', '', false, false)]
    procedure RestrictInvoice(WhseShipmentLine: Record "Warehouse Shipment Line"; Invoice: Boolean)
    var
        WHSHeader: Record "Warehouse Shipment Header";
    begin
        if Invoice then
            Error('You are not allowed to Invoice the Warehouse Shipment Lines.');
        Clear(WHSHeader);
        WHSHeader.SetRange("No.", WhseShipmentLine."No.");
        if WHSHeader.FindFirst() then
            WHSHeader.TestField("Assigned User ID");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt (Yes/No)", 'OnAfterConfirmPost', '', false, false)]
    procedure CheckAssignedUserId(WhseReceiptLine: Record "Warehouse Receipt Line")
    var
        WhseReceiptheader: Record "Warehouse Receipt Header";
    begin
        Clear(WhseReceiptheader);
        WhseReceiptheader.SetRange("No.", WhseReceiptLine."No.");
        if WhseReceiptheader.FindFirst() then begin
            WhseReceiptheader.TestField("Assigned User ID");
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Warehouse Shipment Line", 'OnAfterInsertEvent', '', false, false)]
    procedure AddwarrantyDate(VAR Rec: Record "Warehouse Shipment Line"; RunTrigger: Boolean)
    var
        RecItem: Record Item;
        RecIC: Record "Item Category";
        Sline: Record "Sales Line";
    begin
        if Rec."Item No." <> '' then begin
            if Rec."Source Document" = Rec."Source Document"::"Sales Order" then begin
                Clear(Sline);
                Clear(RecIC);
                Clear(RecItem);
                Sline.SetRange("Document Type", Sline."Document Type"::Order);
                Sline.SetRange("Document No.", Rec."Source No.");
                Sline.SetRange("Line No.", Rec."Source Line No.");
                if Sline.FindFirst() then begin
                    IF RecItem.GET(Rec."Item No.") then begin
                        if RecItem."Item Category Code" <> '' then begin
                            IF RecIC.Get(RecItem."Item Category Code") then begin
                                Rec."Warranty Date" := CALCDATE(RecIC."Warranty Days", Rec."Shipment Date");
                            end;
                        end;
                    end;
                    Rec."Vendor Article No" := Sline."Vendor Article No";
                    Rec."HL Line Type" := Sline."HL Line Type";
                    Rec."Estimated Cost" := Sline."Estimated Cost";
                    Rec."Estimated GP" := Sline."Estimated GP";
                    Rec."Description 3" := Sline."Description 3";
                    Rec."HL Line Type" := Sline."HL Line Type";
                    Rec.Brand := Sline.Brand;
                    Rec.Modify();
                end;
            end;

        end;
    end;

    //

    [EventSubscriber(ObjectType::Table, Database::"Warehouse Receipt Line", 'OnAfterInsertEvent', '', false, false)]
    procedure AddcustomValues(VAR Rec: Record "Warehouse Receipt Line"; RunTrigger: Boolean)
    var
        RecItem: Record Item;
        Pline: Record "Purchase Line";
        PHeader: Record "Purchase Header";
        WHRHeader: Record "Warehouse Receipt Header";
    begin
        if Rec."Item No." <> '' then begin
            if Rec."Source Document" = Rec."Source Document"::"Purchase Order" then begin
                Clear(Pline);
                Clear(RecItem);
                Pline.SetRange("Document Type", Pline."Document Type"::Order);
                Pline.SetRange("Document No.", Rec."Source No.");
                Pline.SetRange("Line No.", Rec."Source Line No.");
                if Pline.FindFirst() then begin
                    Rec."Vendor Article No" := Pline."Vendor Article No";
                    Rec.Description := Pline.Description;
                    Rec."Description 2" := Pline."Description 2";
                    Rec."Description 3" := Pline."Description 3";
                    Rec."HL Sales Order No." := Pline."HL Sales Order No.";
                    Rec."HL Sales Line No." := Pline."HL Sales Line No.";
                    Rec."HL Line Type" := Pline."HL Line Type";
                    Rec.Brand := Pline.Brand;
                    Clear(PHeader);
                    PHeader.SetRange("Document Type", Pline."Document Type");
                    PHeader.SetRange("No.", Pline."Document No.");
                    if PHeader.FindFirst() then
                        Rec."Purchaser Code" := PHeader."Purchaser Code";
                    Rec.Modify();
                end;
            end;

        end;
    end;



    [EventSubscriber(ObjectType::Table, Database::"Warehouse Activity Line", 'OnAfterInsertEvent', '', false, false)]
    procedure AddcustomValuesToPutAway(VAR Rec: Record "Warehouse Activity Line"; RunTrigger: Boolean)
    var
        RecItem: Record Item;
    begin
        if Rec."Item No." <> '' then begin
            Clear(RecItem);
            if RecItem.GET(Rec."Item No.") then begin
                Rec."Vendor Article No." := RecItem."Vendor Article No";
                Rec.Description := RecItem.Description;
                Rec."Description 2" := RecItem."Description 2";
                Rec."Description 3" := RecItem."Description 3";
                Rec.Modify();
            end;

        end;
    end;

    //

    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnAfterInsertEvent', '', false, false)]
    procedure AddWarranty(VAR Rec: Record "Sales Shipment Line"; RunTrigger: Boolean)
    var
        RecItem: Record Item;
        RecIC: Record "Item Category";
    begin
        if Rec.Type = Rec.Type::Item then begin
            Clear(RecItem);
            IF RecItem.GET(Rec."No.") then begin
                if RecItem."Item Category Code" <> '' then begin
                    IF RecIC.Get(RecItem."Item Category Code") then begin
                        Rec."Warranty Date" := CALCDATE(RecIC."Warranty Days", Rec."Shipment Date");
                        // Rec.Modify();
                    end;
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    procedure SetShipFlag(VAR SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    var
        RecPM: Record "Payment Milestone";
        SNRSetup: Record "Sales & Receivables Setup";
        SalesLine: Record "Sales Line";
        Sline2: Record "Sales Line";
        LineNO: Integer;
    begin
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) then begin
            Clear(RecPM);
            SNRSetup.GET;
            Clear(Sline2);
            Sline2.SetRange("Document Type", SalesHeader."Document Type");
            Sline2.SetRange("Document No.", SalesHeader."No.");
            if Sline2.FindLast() then
                LineNO := Sline2."Line No."
            else
                LineNO := 0;
            RecPM.SetRange("Document Type", RecPM."Document Type"::Invoice);
            RecPM.SetRange("Document No.", SalesHeader."No.");
            RecPM.SetFilter("Posting Type", '<>%1', RecPM."Posting Type"::Running);
            if RecPM.FindSet() then begin
                repeat
                    SNRSetup.TestField("Prepayment G/L Account");
                    SNRSetup.TestField("Retention G/L Account");
                    Clear(SalesLine);
                    SalesLine.Init();
                    LineNO += 10000;
                    SalesLine.SetHideValidationDialog(true);
                    SalesLine.SetHasBeenShown();
                    SalesLine.Validate("Document Type", SalesLine."Document Type"::Invoice);
                    SalesLine.Validate("Document No.", SalesHeader."No.");
                    SalesLine."System-Created Entry" := true;
                    SalesLine."Line No." := LineNO;
                    SalesLine.Validate(Type, SalesLine.Type::"G/L Account");
                    if RecPM."Posting Type" = RecPM."Posting Type"::Advance then
                        SalesLine.Validate("No.", SNRSetup."Prepayment G/L Account")
                    else
                        SalesLine.Validate("No.", SNRSetup."Retention G/L Account");
                    SalesLine.Validate("Shipment Date", SalesHeader."Shipment Date");
                    SalesLine.Validate("Unit Price", RecPM.Amount * 1);
                    SalesLine.Validate(Quantity, -1);
                    SalesLine."VAT Bus. Posting Group" := SalesHeader."VAT Bus. Posting Group";// Added on 30 Jan 2020
                    SalesLine.Insert(true);
                until RecPM.Next() = 0;
                SalesHeader.Ship := true;
                SalesHeader.Modify();
            end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeDeleteAfterPosting', '', false, false)]
    procedure ModifyPaymentMileStone(VAR SalesHeader: Record "Sales Header"; VAR SalesInvoiceHeader: Record "Sales Invoice Header"; VAR SalesCrMemoHeader: Record "Sales Cr.Memo Header"; VAR SkipDelete: Boolean)
    var
        RecPm: Record "Payment Milestone";
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then begin
            Clear(RecPm);
            RecPm.SetRange("Document Type", RecPm."Document Type"::Invoice);
            RecPm.SetRange("Document No.", SalesHeader."No.");
            if RecPm.FindSet() then begin
                repeat
                    RecPm.IsPosted := true;
                    RecPm.Modify();
                until RecPm.Next() = 0;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeInsertTransShptLine', '', false, false)]
    procedure InsertCustomField(VAR TransShptLine: Record "Transfer Shipment Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean)
    begin
        TransShptLine."Vendor Article No." := TransLine."Vendor Article No.";
        TransShptLine."Description 2" := TransLine."Description 2";
        TransShptLine."Description 3" := TransLine."Description 3";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeInsertTransRcptLine', '', false, false)]
    procedure InsertCustomFieldToTransferLine(VAR TransRcptLine: Record "Transfer Receipt Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean)
    begin
        TransRcptLine."Vendor Article No." := TransLine."Vendor Article No.";
        TransRcptLine."Description 2" := TransLine."Description 2";
        TransRcptLine."Description 3" := TransLine."Description 3";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Order Planning Mgt.", 'OnInsertDemandLinesOnBeforeReqLineInsert', '', false, false)]
    procedure InsertItemDetails(VAR RequisitionLine: Record "Requisition Line")
    VAR
        SHeader: Record "Sales Header";
        Sline: Record "Sales Line";
    begin
        if RequisitionLine."Demand Type" = 37 then begin
            Clear(Sline);
            Sline.SetRange("Document Type", Sline."Document Type"::Order);
            Sline.SetRange("Document No.", RequisitionLine."Demand Order No.");
            Sline.SetRange("Line No.", RequisitionLine."Demand Line No.");
            if Sline.FindFirst() then begin
                RequisitionLine."Vendor Article No." := Sline."Vendor Article No";
                RequisitionLine."HL Line Type" := Sline."HL Line Type";
                RequisitionLine.Brand := Sline.Brand;
                RequisitionLine."Ref Type" := Sline."HL Line Type";
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnBeforeCode', '', false, false)]
    procedure CheckCurrencyCode(VAR GenJournalLine: Record "Gen. Journal Line"; VAR HideDialog: Boolean)
    begin
        if (GenJournalLine."Bal. Account Type" = GenJournalLine."Bal. Account Type"::Customer) OR (GenJournalLine."Bal. Account Type" = GenJournalLine."Bal. Account Type"::Vendor) then
            GenJournalLine.TestField("Currency Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnBeforePrintCheck', '', false, false)]
    procedure GetTheReportIdAndPrint(VAR GenJournalLine: Record "Gen. Journal Line"; VAR IsPrinted: Boolean)
    var
        BankAcc: Record "Bank Account";
        ReportSelections: Record 77;
    begin
        if GenJournalLine."Bal. Account Type" = GenJournalLine."Bal. Account Type"::"Bank Account" then begin
            Clear(BankAcc);
            BankAcc.SetRange("No.", GenJournalLine."Bal. Account No.");
            if BankAcc.FindFirst() then begin
                if BankAcc."Check Report ID" <> 0 then begin
                    Report.Run(BankAcc."Check Report ID", TRUE, false, GenJournalLine);
                    IsPrinted := true;
                    //  ReportSelections.Print(BankAcc."Check Report ID", GenJournalLine, 0);
                end;

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterModifyEvent', '', false, false)]
    procedure EnableDiscountApproval(VAR Rec: Record "Sales Line"; VAR xRec: Record "Sales Line"; RunTrigger: Boolean)
    var
        SnRSetup: Record "Sales & Receivables Setup";
        Sheader: Record "Sales Header";
        Sline: Record "Sales Line";
    begin
        if (Rec."Document Type" = Rec."Document Type"::Invoice) AND (Rec."Line Discount %" <> 0) then begin
            SnRSetup.GET;
            SnRSetup.TestField("Maximum Discount %");
            Clear(Sline);
            Sline.SetRange("Document Type", Sline."Document Type"::Invoice);
            Sline.SetRange("Document No.", Rec."Document No.");
            Sline.SetFilter("Line Discount %", '>%1', SnRSetup."Maximum Discount %");
            if not Sline.FindFirst() then begin
                Clear(Sheader);
                Sheader.SetRange("Document Type", Sheader."Document Type"::Invoice);
                Sheader.SetRange("No.", Rec."Document No.");
                if Sheader.FindFirst() then begin
                    Sheader."Discount Approval" := false;
                    Sheader.Modify();
                end;
            end else begin
                Clear(Sheader);
                Sheader.SetRange("Document Type", Sheader."Document Type"::Invoice);
                Sheader.SetRange("No.", Rec."Document No.");
                if Sheader.FindFirst() then begin
                    Sheader."Discount Approval" := true;
                    Sheader.Modify();
                end;
            end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnBeforePurchOrderLineInsert', '', false, false)]
    procedure populateCustomDataInPO(VAR PurchOrderHeader: Record "Purchase Header"; VAR PurchOrderLine: Record "Purchase Line"; VAR ReqLine: Record "Requisition Line"; CommitIsSuppressed: Boolean)
    var
        Sheader: Record "Sales Header";
        Sline: Record "Sales Line";

        TempDocumentEntry: Record "Document Entry";
        NoFilter: Text;
        PPSetup: Record "Purchases & Payables Setup";
        NoSeries: Record "No. Series Line";
        RecSP: Record "Salesperson/Purchaser";
        RecPT: Record "Payment Terms";
        CurrencyFactor: Decimal;
    begin
        Clear(Sline);
        Clear(Sheader);
        Sheader.SetRange("Document Type", Sheader."Document Type"::Order);
        Sheader.SetRange("No.", ReqLine."Demand Order No.");
        if Sheader.FindFirst() then begin
            Sline.SetRange("Document Type", Sline."Document Type"::Order);
            Sline.SetRange("Document No.", ReqLine."Demand Order No.");
            Sline.SetRange("Line No.", ReqLine."Demand Line No.");
            if Sline.FindFirst() then begin
                PurchOrderLine."HL Sales Order No." := ReqLine."Demand Order No.";
                PurchOrderLine."HL Sales Line No." := ReqLine."Demand Line No.";
                PurchOrderLine.Validate("Shortcut Dimension 1 Code", SLine."Shortcut Dimension 1 Code");
                PurchOrderLine.Validate("Shortcut Dimension 2 Code", SLine."Shortcut Dimension 2 Code");
                PurchOrderLine."Dimension Set ID" := SLine."Dimension Set ID";
                PurchOrderLine.SalesDocDate := Sheader."Document Date";
                PurchOrderLine.SalesCity := Sheader."Ship-to City";
                Clear(RecSP);
                if RecSP.GET(Sheader."Salesperson Code") then
                    PurchOrderLine.SalesPerson := RecSP.Name;
                PurchOrderLine."Sell To Customer No." := Sheader."Sell-to Customer No.";
                PurchOrderLine.SalesProjectName := Sheader."Project Name";
                PurchOrderLine.SalesLineAmount := SLine.Amount;
                Clear(RecPT);
                If RecPT.GET(Sheader."Payment Terms Code") then
                    PurchOrderLine.SalesPaymentTerms := RecPT.Description;
                PurchOrderLine.PODocDate := PurchOrderHeader."Document Date";
                PurchOrderLine.BuyFromVendor := PurchOrderHeader."Buy-from Vendor Name";
                PurchOrderLine.PoCurrency := PurchOrderHeader."Currency Code";
                PurchOrderLine.PromisedDelDate := Sheader."Promised Delivery Date";
                PurchOrderLine.Brand := SLine.Brand;
                PurchOrderLine."HL Line Type" := SLine."HL Line Type";
                if Sheader."Currency Factor" <> 0 then
                    PurchOrderLine."SO Unit Price" := SLine."Unit Price" / Sheader."Currency Factor"
                else
                    PurchOrderLine."SO Unit Price" := SLine."Unit Price";
                //PurchOrderLine.Modify();
                SLine."HL_Purchase Order No." := PurchOrderLine."Document No.";
                SLine."PO Qty" := PurchOrderLine.Quantity;
                SLine."PO Line No." := PurchOrderLine."Line No.";
                SLine.Modify();

                PurchOrderHeader.SetHideValidationDialog(true);
                PurchOrderHeader.Validate("Purchaser Code", Sheader."Salesperson Code");
                PurchOrderHeader."Project Name" := Sheader."Project Name";
                PurchOrderHeader."Project Reference" := Sheader."Project Reference";
                PurchOrderHeader.Validate("Location Code", Sheader."Location Code");
                PurchOrderHeader.Validate("Purchaser Code", Sheader."Salesperson Code");
                PurchOrderHeader.Validate("Dimension Set ID", Sheader."Dimension Set ID");
                PurchOrderHeader.Modify();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::CheckManagement, 'OnBeforeVoidCheckGenJnlLine2Modify', '', false, false)]
    procedure RemoveCheckNoAndKeepDocNo(VAR GenJournalLine2: Record "Gen. Journal Line"; GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine2."Document No." := GenJournalLine."Document No.";
        GenJournalLine2."Check No." := '';
        GenJournalLine2."Check Date" := 0D;
    end;



    procedure CheckCurrencyForJournal(VAR Rec: Record "Gen. Journal Line")
    var
        RecJln: Record "Gen. Journal Line";
    begin
        Clear(RecJln);
        RecJln.COPY(Rec);
        RecJln.SetFilter("Bal. Account Type", '=%1|%2', RecJln."Bal. Account Type"::Vendor, RecJln."Bal. Account Type"::Customer);
        if RecJln.FindSet() then begin
            RecJln.TestField("Currency Code");
        end;
    end;
    //General Journal Post and print 

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post+Print", 'OnAfterPostJournalBatch', '', false, false)]
    procedure StoreVariables(VAR GenJournalLine: Record "Gen. Journal Line")
    var
        GenLedSetup: Record "General Ledger Setup";
        GenVoucher: Report 50116;
        GLEntry: Record "G/L Entry";
        NoSeries: Record "No. Series";
        GenJlnBatch: Record "Gen. Journal Batch";
        NOSeriesLine: Record "No. Series Line";
        BatchPostingPrintMgt: Codeunit "Batch Posting Print Mgt.";
    begin
        GenLedSetup.GET;
        if GenLedSetup."Gen. Jln. Post & Print" then begin
            // COMMIT;
            // COMMIT;
            Clear(GenJlnBatch);
            IF GenJlnBatch.GET(GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name") then begin
                clear(NOSeriesLine);
                NOSeriesLine.SetRange("Series Code", GenJlnBatch."Posting No. Series");
                if NOSeriesLine.FindFirst() then begin
                    Clear(GLEntry);
                    GLEntry.SetRange("Document No.", NOSeriesLine."Last No. Used");
                    if GLEntry.FindSet() then begin
                        GenVoucher.SetTableView(GLEntry);
                        GenVoucher.UseRequestPage(false);
                        GenVoucher.RunModal();
                    end;
                end;
            end;

        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Batch Posting Print Mgt.", 'OnBeforeGLRegPostingReportPrint', '', false, false)]
    procedure PrintAfterPost(VAR ReportID: Integer; ReqWindow: Boolean; SystemPrinter: Boolean; VAR GLRegister: Record "G/L Register"; VAR Handled: Boolean)
    VAR
        GenLedSetup: Record "General Ledger Setup";
    begin
        GenLedSetup.GET;
        if GenLedSetup."Gen. Jln. Post & Print" then begin
            Handled := true;
        end;
    end;


    var
        JlnBatchName: Text;
        JlnTemplateName: Text;
}