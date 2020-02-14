page 60001 "Apply Vendor Ledger Entries"
{
    // Code           Date        Name        Desc.
    // APNT-LCPDC1.0  20.05.12    Monica      Created New.

    Caption = 'Apply Vendor Entries';
    DataCaptionFields = "Vendor No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Vendor Ledger Entry";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("ApplyingVendLedgEntry.""Posting Date"""; ApplyingVendLedgEntry."Posting Date")
                {
                    Caption = 'Posting Date';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ApplyingVendLedgEntry.""Document Type"""; ApplyingVendLedgEntry."Document Type")
                {
                    Caption = 'Document Type';
                    Editable = false;
                    ApplicationArea = All;
                    OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
                }
                field("ApplyingVendLedgEntry.""Document No."""; ApplyingVendLedgEntry."Document No.")
                {
                    Caption = 'Document No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ApplyingVendLedgEntry.""Vendor No."""; ApplyingVendLedgEntry."Vendor No.")
                {
                    Caption = 'Vendor No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ApplyingVendLedgEntry.Description"; ApplyingVendLedgEntry.Description)
                {
                    Caption = 'Description';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ApplyingVendLedgEntry.""Currency Code"""; ApplyingVendLedgEntry."Currency Code")
                {
                    Caption = 'Currency Code';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ApplyingVendLedgEntry.Amount"; ApplyingVendLedgEntry.Amount)
                {
                    Caption = 'Amount';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ApplyingVendLedgEntry.""Remaining Amount"""; ApplyingVendLedgEntry."Remaining Amount")
                {
                    Caption = 'Remaining Amount';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(ShowAppliedEntries; ShowAppliedEntries)
                {
                    Caption = 'Show Only Selected Entries to Be Applied';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ShowAppliedEntriesOnPush;
                    end;
                }
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("Applies-to ID"; "Applies-to ID")
                {
                    Visible = "Applies-to IDVisible";
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Type"; "Document Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; "Vendor No.")
                {
                    Editable = false;
                    ApplicationArea=All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Original Amount"; "Original Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Amount; Amount)
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Remaining Amount"; "Remaining Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("CalcApplnRemainingAmount(""Remaining Amount"")"; CalcApplnRemainingAmount("Remaining Amount"))
                {
                    AutoFormatExpression = ApplnCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Appln. Remaining Amount';
                    ApplicationArea = All;
                }
                field("Amount to Apply"; "Amount to Apply")
                {
                    ApplicationArea = All;
                }
                field("CalcApplnAmounttoApply(""Amount to Apply"")"; CalcApplnAmounttoApply("Amount to Apply"))
                {
                    AutoFormatExpression = ApplnCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Appln. Amount to Apply';
                    ApplicationArea = All;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; "Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Disc. Tolerance Date"; "Pmt. Disc. Tolerance Date")
                {
                    ApplicationArea = All;
                }
                field("Original Pmt. Disc. Possible"; "Original Pmt. Disc. Possible")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Remaining Pmt. Disc. Possible"; "Remaining Pmt. Disc. Possible")
                {
                    ApplicationArea = All;
                }
                field("CalcApplnRemainingAmount(""Remaining Pmt. Disc. Possible"")"; CalcApplnRemainingAmount("Remaining Pmt. Disc. Possible"))
                {
                    AutoFormatExpression = ApplnCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Appln. Pmt. Disc. Possible';
                    ApplicationArea = All;
                }
                field("Max. Payment Tolerance"; "Max. Payment Tolerance")
                {
                    ApplicationArea = All;
                }
                field(Open; Open)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Positive; Positive)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
            group(Control41)
            {
                ShowCaption = false;
                field(ApplnCurrencyCode; ApplnCurrencyCode)
                {
                    Caption = 'Appln. Currency';
                    Editable = false;
                    TableRelation = Currency;
                    ApplicationArea = All;
                }
                field(AppliedAmount; AppliedAmount)
                {
                    AutoFormatExpression = ApplnCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Amount to Apply';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("-PmtDiscAmount"; -PmtDiscAmount)
                {
                    AutoFormatExpression = ApplnCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Pmt. Disc. Amount';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(ApplnRounding; ApplnRounding)
                {
                    AutoFormatExpression = ApplnCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Rounding';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("AppliedAmount + (-PmtDiscAmount) + ApplnRounding"; AppliedAmount + (-PmtDiscAmount) + ApplnRounding)
                {
                    AutoFormatExpression = ApplnCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Applied Amount';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(ApplyingAmount; ApplyingAmount)
                {
                    AutoFormatExpression = ApplnCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Available Amount';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("AppliedAmount + (-PmtDiscAmount) + ApplyingAmount + ApplnRounding"; AppliedAmount + (-PmtDiscAmount) + ApplyingAmount + ApplnRounding)
                {
                    AutoFormatExpression = ApplnCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Balance';
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                action("Applied E&ntries")
                {
                    Caption = 'Applied E&ntries';
                    RunObject = Page "Applied Vendor Entries";
                    RunPageOnRec = true;
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;
                }
                action("Detailed &Ledger Entries")
                {
                    Caption = 'Detailed &Ledger Entries';
                    RunObject = Page "Detailed Vendor Ledg. Entries";
                    RunPageLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                    RunPageView = SORTING("Vendor Ledger Entry No.", "Posting Date");
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = All;
                }
            }
            group("&Application")
            {
                Caption = '&Application';
                action("Set Applying Entry")
                {
                    Caption = 'Set Applying Entry';
                    ShortCutKey = 'Shift+F11';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        if CalcType = CalcType::Direct then begin
                            "Applying Entry" := true;
                            SetApplyingVendLedgEntry;
                        end else
                            Error(Text001);
                    end;
                }
                action("Remove Applying Entry")
                {
                    Caption = 'Remove Applying Entry';
                    ShortCutKey = 'Ctrl+F11';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        if CalcType = CalcType::Direct then begin
                            "Applying Entry" := false;
                            SetApplyingVendLedgEntry;
                        end else
                            Error(Text001);
                    end;
                }
                action("Set Applies-to ID")
                {
                    Caption = 'Set Applies-to ID';
                    Image = SelectLineToApply;
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        if CalcType = CalcType::GenJnlLine then begin
                            if ApplnType = ApplnType::"Applies-to Doc. No." then
                                Error(Text004);

                            if ((ApplyingVendLedgEntry."Document Type" = ApplyingVendLedgEntry."Document Type"::Payment) or
                              (ApplyingVendLedgEntry."Document Type" = ApplyingVendLedgEntry."Document Type"::Refund)) and
                              (ApplyingVendLedgEntry."Posting Date" < "Posting Date")
                            then
                                Error(
                                  Text006, ApplyingVendLedgEntry."Document Type", ApplyingVendLedgEntry."Document No.",
                                  "Document Type", "Document No.");
                        end;
                        SetVendApplId;
                    end;
                }
                action("Post Application")
                {
                    Caption = 'Post Application';
                    Ellipsis = true;
                    Image = PostApplication;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        VendEntryApplyPostedEntries: Codeunit "VendEntry-Apply Posted Entries";
                        Window: Dialog;
                        CustVendAppEntry: Record "Customer Vendor Applied Entry";
                        EntryNo: Integer;
                        VendorLedgEntry: Record "Vendor Ledger Entry";
                    begin
                        //APNT-IBU1.0
                        Window.Open('Updating Customer Vendor Applied Entries.\' +
                                    'Document No.             #1##############\' +
                                    'Amount to Apply          #2##############');
                        CustVendAppEntry.Reset;
                        if CustVendAppEntry.Find('+') then
                            EntryNo := CustVendAppEntry."Entry No." + 1
                        else
                            EntryNo := 1;

                        VendorLedgEntry.Reset;
                        VendorLedgEntry.SetCurrentKey("Vendor No.", "Applies-to ID", Open, Positive, "Due Date");
                        VendorLedgEntry.SetRange("Vendor No.", "Vendor No.");
                        VendorLedgEntry.SetRange(Open, true);
                        if VendorLedgEntry.Find('-') then
                            repeat
                                Window.Update(1, VendorLedgEntry."Document No.");
                                Window.Update(2, VendorLedgEntry."Amount to Apply");
                                if (VendorLedgEntry."Applies-to ID" <> '') or (VendorLedgEntry."Amount to Apply" <> 0) then begin
                                    CustVendAppEntry.Reset;
                                    CustVendAppEntry.SetRange("Document Type", CustVendAppEntry."Document Type"::Purchases);
                                    CustVendAppEntry.SetRange("Document No.", VendorLedgEntry."Document No.");
                                    CustVendAppEntry.SetRange("Source Type", CustVendAppEntry."Source Type"::Vendor);
                                    CustVendAppEntry.SetRange("Source No.", VendorLedgEntry."Vendor No.");
                                    if CustVendAppEntry.Find('-') then begin
                                        CustVendAppEntry."Source Document No." := ApplyingVendLedgEntry."Document No.";
                                        CustVendAppEntry."Applied Amount (ICY)" := VendorLedgEntry."Amount to Apply";
                                        CustVendAppEntry."Applied Amount (LCY)" := CurrExchRate.ExchangeAmtFCYToLCY(VendorLedgEntry."Posting Date",
                                        VendorLedgEntry."Currency Code", VendorLedgEntry."Amount to Apply", VendorLedgEntry."Original Currency Factor");
                                        CustVendAppEntry."Shortcut Dimension 1 Code" := VendorLedgEntry."Global Dimension 1 Code";
                                        CustVendAppEntry."Shortcut Dimension 2 Code" := VendorLedgEntry."Global Dimension 2 Code";
                                        CustVendAppEntry.Modify;
                                    end else begin
                                        CustVendAppEntry.Init;
                                        CustVendAppEntry."Entry No." := EntryNo;
                                        CustVendAppEntry."Document Type" := CustVendAppEntry."Document Type"::Purchases;
                                        CustVendAppEntry."Document No." := VendorLedgEntry."Document No.";
                                        CustVendAppEntry."Source Type" := CustVendAppEntry."Source Type"::Vendor;
                                        CustVendAppEntry."Source No." := VendorLedgEntry."Vendor No.";
                                        CustVendAppEntry."Applied Amount (ICY)" := VendorLedgEntry."Amount to Apply";
                                        CustVendAppEntry."Applied Amount (LCY)" := CurrExchRate.ExchangeAmtFCYToLCY(VendorLedgEntry."Posting Date",
                                        VendorLedgEntry."Currency Code", VendorLedgEntry."Amount to Apply", VendorLedgEntry."Original Currency Factor");
                                        CustVendAppEntry."Shortcut Dimension 1 Code" := VendorLedgEntry."Global Dimension 1 Code";
                                        CustVendAppEntry."Shortcut Dimension 2 Code" := VendorLedgEntry."Global Dimension 2 Code";
                                        CustVendAppEntry."Source Document No." := ApplyingVendLedgEntry."Document No.";
                                        CustVendAppEntry.Insert;
                                        EntryNo += 1;
                                    end;
                                end else begin
                                    CustVendAppEntry.Reset;
                                    CustVendAppEntry.SetRange("Document Type", CustVendAppEntry."Document Type"::Purchases);
                                    CustVendAppEntry.SetRange("Document No.", VendorLedgEntry."Document No.");
                                    CustVendAppEntry.SetRange("Source Type", CustVendAppEntry."Source Type"::Vendor);
                                    CustVendAppEntry.SetRange("Source No.", VendorLedgEntry."Vendor No.");
                                    CustVendAppEntry.DeleteAll;
                                end;
                            until VendorLedgEntry.Next = 0;
                        Window.Close;
                        //APNT-IBU1.0

                        if CalcType = CalcType::Direct then begin
                            if ApplyingVendLedgEntry."Entry No." <> 0 then begin
                                Rec := ApplyingVendLedgEntry;
                                // Post Application
                                VendEntryApplyPostedEntries.Run(Rec);
                                ApplyingVendLedgEntry."Entry No." := 0;
                                ApplyingVendLedgEntry.Init;
                                ApplnCurrencyCode := '';
                                ApplyingAmount := 0;
                                SetRange("Entry No.");
                                FindApplyingEntry;
                                CurrPage.Update(false);
                            end else
                                Error(Text002);
                        end else
                            ERROR(Text003);
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Navigate.SetDoc("Posting Date", "Document No.");
                    Navigate.Run;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        fnOnAfterGetCurrRecord;
    end;

    trigger OnClosePage()
    begin
        if ApplnType = ApplnType::"Applies-to Doc. No." then begin
            if ((ApplyingVendLedgEntry."Document Type" = ApplyingVendLedgEntry."Document Type"::Payment) or
              (ApplyingVendLedgEntry."Document Type" = ApplyingVendLedgEntry."Document Type"::Refund)) and
              (ApplyingVendLedgEntry."Posting Date" < "Posting Date")
            then
                Error(
                  Text006, ApplyingVendLedgEntry."Document Type", ApplyingVendLedgEntry."Document No.",
                  "Document Type", "Document No.");

            if OK then begin
                if "Amount to Apply" = 0 then
                    "Amount to Apply" := "Remaining Amount";

                CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", Rec);
            end;
        end;
    end;

    trigger OnInit()
    begin
        "Applies-to IDVisible" := true;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", Rec);
        exit(false);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        fnOnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        if CalcType = CalcType::Direct then begin
            Vend.Get("Vendor No.");
            ApplnCurrencyCode := Vend."Currency Code";
            FindApplyingEntry;
        end;

        if ApplnType = ApplnType::"Applies-to Doc. No." then
            "Applies-to IDVisible" := false
        else
            "Applies-to IDVisible" := true;

        GLSetup.Get;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        Window: Dialog;
        CustVendAppEntry: Record "Customer Vendor Applied Entry";
        EntryNo: Integer;
        VendorLedgEntry: Record "Vendor Ledger Entry";
    begin
        if CloseAction = ACTION::LookupOK then
            LookupOKOnPush;
        //APNT-IBU1.0
        Window.Open('Updating Customer Vendor Applied Entries.\' +
                    'Document No.             #1##############\' +
                    'Amount to Apply          #2##############');
        CustVendAppEntry.Reset;
        if CustVendAppEntry.Find('+') then
            EntryNo := CustVendAppEntry."Entry No." + 1
        else
            EntryNo := 1;

        VendorLedgEntry.Reset;
        VendorLedgEntry.SetCurrentKey("Vendor No.", "Applies-to ID", Open, Positive, "Due Date");
        VendorLedgEntry.SetRange("Vendor No.", "Vendor No.");
        VendorLedgEntry.SetRange(Open, true);
        VendorLedgEntry.SetRange("Applies-to ID", ApplyingVendLedgEntry."Document No.");
        if VendorLedgEntry.Find('-') then begin
            if CurrPage.LookupMode = true then
                if OKPressed = false then
                    Error('Please select OK to Apply Vendor Ledger Entries');
            repeat
                Window.Update(1, VendorLedgEntry."Document No.");
                Window.Update(2, VendorLedgEntry."Amount to Apply");
                if (VendorLedgEntry."Applies-to ID" <> '') or (VendorLedgEntry."Amount to Apply" <> 0) then begin
                    CustVendAppEntry.Reset;
                    CustVendAppEntry.SetRange("Document Type", CustVendAppEntry."Document Type"::Purchases);
                    CustVendAppEntry.SetRange("Document No.", VendorLedgEntry."Document No.");
                    CustVendAppEntry.SetRange("Source Type", CustVendAppEntry."Source Type"::Vendor);
                    CustVendAppEntry.SetRange("Source No.", VendorLedgEntry."Vendor No.");
                    CustVendAppEntry.SetRange("Application Entry No.", VendorLedgEntry."Entry No.");
                    CustVendAppEntry.SetRange("Inter Dimension Posted", false);
                    if CustVendAppEntry.Find('-') then begin
                        CustVendAppEntry."Source Document No." := ApplyingVendLedgEntry."Document No.";
                        CustVendAppEntry."Posting Date" := PDCIssue."Document Date";
                        CustVendAppEntry.Validate("ICY Currency Code", VendorLedgEntry."Currency Code");
                        CustVendAppEntry.Validate("Applied Amount (ICY)", VendorLedgEntry."Amount to Apply");
                        CustVendAppEntry.Validate("FCY Currency Code", ApplyingVendLedgEntry."Currency Code");
                        CustVendAppEntry.Validate("Applied Amount (FCY)", CalcApplnAmounttoApply(VendorLedgEntry."Amount to Apply"));
                        CustVendAppEntry."Shortcut Dimension 1 Code" := VendorLedgEntry."Global Dimension 1 Code";
                        CustVendAppEntry."Shortcut Dimension 2 Code" := VendorLedgEntry."Global Dimension 2 Code";
                        CustVendAppEntry.Modify;
                    end else begin
                        CustVendAppEntry.Init;
                        CustVendAppEntry."Entry No." := EntryNo;
                        CustVendAppEntry."Document Type" := CustVendAppEntry."Document Type"::Purchases;
                        CustVendAppEntry."Document No." := VendorLedgEntry."Document No.";
                        CustVendAppEntry."Source Type" := CustVendAppEntry."Source Type"::Vendor;
                        CustVendAppEntry."Source No." := VendorLedgEntry."Vendor No.";
                        CustVendAppEntry."Posting Date" := PDCIssue."Document Date";
                        CustVendAppEntry.Validate("ICY Currency Code", VendorLedgEntry."Currency Code");
                        CustVendAppEntry.Validate("Applied Amount (ICY)", VendorLedgEntry."Amount to Apply");
                        CustVendAppEntry.Validate("FCY Currency Code", ApplyingVendLedgEntry."Currency Code");
                        CustVendAppEntry.Validate("Applied Amount (FCY)", CalcApplnAmounttoApply(VendorLedgEntry."Amount to Apply"));
                        CustVendAppEntry."Shortcut Dimension 1 Code" := VendorLedgEntry."Global Dimension 1 Code";
                        CustVendAppEntry."Shortcut Dimension 2 Code" := VendorLedgEntry."Global Dimension 2 Code";
                        CustVendAppEntry."Source Document No." := ApplyingVendLedgEntry."Document No.";
                        CustVendAppEntry."Application Entry No." := VendorLedgEntry."Entry No.";
                        CustVendAppEntry.Insert;
                        EntryNo += 1;
                    end;
                end;
            until VendorLedgEntry.Next = 0;
        end else begin
            CustVendAppEntry.Reset;
            CustVendAppEntry.SetRange("Document Type", CustVendAppEntry."Document Type"::Purchases);
            CustVendAppEntry.SetRange("Source Type", CustVendAppEntry."Source Type"::Vendor);
            CustVendAppEntry.SetRange("Source No.", "Vendor No.");
            CustVendAppEntry.SetRange("Source Document No.", ApplyingVendLedgEntry."Document No.");
            CustVendAppEntry.DeleteAll;
        end;
        Window.Close;
        //APNT-IBU1.0
    end;

    var
        Text000: Label 'Undefined';
        ApplyingVendLedgEntry: Record "Vendor Ledger Entry" temporary;
        AppliedVendLedgEntry: Record "Vendor Ledger Entry";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        PDCIssue: Record "PDC Issue";
        PDCIssue2: Record "PDC Issue";
        PurchHeader: Record "Purchase Header";
        Vend: Record Vendor;
        VendLedgEntry: Record "Vendor Ledger Entry";
        GLSetup: Record "General Ledger Setup";
        TotalPurchLine: Record "Purchase Line";
        TotalPurchLineLCY: Record "Purchase Line";
        Navigate: Page Navigate;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        VendEntrySetApplID: Codeunit "Vend. Entry-SetAppl.ID";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        PurchPost: Codeunit "Purch.-Post";
        GenJnlLineApply: Boolean;
        AppliedAmount: Decimal;
        ApplyingAmount: Decimal;
        PmtDiscAmount: Decimal;
        ApplnDate: Date;
        ApplnCurrencyCode: Code[10];
        ApplnRoundingPrecision: Decimal;
        ApplnRounding: Decimal;
        ApplnType: Option " ","Applies-to Doc. No.","Applies-to ID";
        AmountRoundingPrecision: Decimal;
        VATAmount: Decimal;
        VATAmountText: Text[30];
        CalcType: Option Direct,GenJnlLine,PurchHeader,PDCIssue;
        VendEntryApplID: Code[20];
        ValidExchRate: Boolean;
        DifferentCurrenciesFound: Boolean;
        DifferentCurrenciesInAppln: Boolean;
        Text001: Label 'You are not allowed to choose a new applying entry while selecting apply entries.';
        Text002: Label 'You must select an applying entry before you can post the application.';
        Text003: Label 'You must post the application from the window where you entered the applying entry.';
        Text004: Label 'You are not allowed to set Applies-to ID while selecting Applies-to Doc. No.';
        ShowAppliedEntries: Boolean;
        OK: Boolean;
        Text006: Label 'You are not allowed to apply and post an entry to an entry with an earlier posting date.\\Instead, post %1 %2 and then apply it to %3 %4.';
        PDCLineApply: Boolean;
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        OKPressed: Boolean;
        [InDataSet]
        "Applies-to IDVisible": Boolean;

    procedure SetPDCLine(NewPDCIssue: Record "PDC Issue")
    begin
        PDCIssue := NewPDCIssue;
        PDCLineApply := true;
        ApplyingAmount := PDCIssue.Amount;

        ApplnDate := PDCIssue."Document Date";
        ApplnCurrencyCode := PDCIssue."Currency Code";
        CalcType := CalcType::PDCIssue;
        ApplnType := ApplnType::"Applies-to ID";

        SetApplyingVendLedgEntry;
    end;

    procedure SetPurch(NewPurchHeader: Record "Purchase Header"; var NewVendLedgEntry: Record "Vendor Ledger Entry"; ApplnTypeSelect: Integer)
    begin
        PurchHeader := NewPurchHeader;
        Rec.CopyFilters(NewVendLedgEntry);

        PurchPost.SumPurchLines(
          PurchHeader, 0, TotalPurchLine, TotalPurchLineLCY,
          VATAmount, VATAmountText);

        case PurchHeader."Document Type" of
            PurchHeader."Document Type"::"Return Order",
          PurchHeader."Document Type"::"Credit Memo":
                ApplyingAmount := TotalPurchLine."Amount Including VAT"
            else
                ApplyingAmount := -TotalPurchLine."Amount Including VAT";
        end;

        ApplnDate := PurchHeader."Posting Date";
        ApplnCurrencyCode := PurchHeader."Currency Code";
        CalcType := CalcType::PurchHeader;

        case ApplnTypeSelect of
            PurchHeader.FieldNo("Applies-to Doc. No."):
                ApplnType := ApplnType::"Applies-to Doc. No.";
            PurchHeader.FieldNo("Applies-to ID"):
                ApplnType := ApplnType::"Applies-to ID";
        end;

        SetApplyingVendLedgEntry;
    end;

    procedure SetApplyingVendLedgEntry()
    var
        "VendEntry-Edit": Codeunit "Vend. Entry-Edit";
    begin
        case CalcType of
            CalcType::PurchHeader:
                begin
                    ApplyingVendLedgEntry."Posting Date" := PurchHeader."Posting Date";
                    if PurchHeader."Document Type" = PurchHeader."Document Type"::"Return Order" then
                        ApplyingVendLedgEntry."Document Type" := PurchHeader."Document Type"::"Credit Memo"
                    else
                        ApplyingVendLedgEntry."Document Type" := PurchHeader."Document Type";
                    ApplyingVendLedgEntry."Document No." := PurchHeader."No.";
                    ApplyingVendLedgEntry."Vendor No." := PurchHeader."Pay-to Vendor No.";
                    ApplyingVendLedgEntry.Description := PurchHeader."Posting Description";
                    ApplyingVendLedgEntry."Currency Code" := PurchHeader."Currency Code";
                    if ApplyingVendLedgEntry."Document Type" = ApplyingVendLedgEntry."Document Type"::"Credit Memo" then begin
                        ApplyingVendLedgEntry.Amount := TotalPurchLine."Amount Including VAT";
                        ApplyingVendLedgEntry."Remaining Amount" := TotalPurchLine."Amount Including VAT";
                    end else begin
                        ApplyingVendLedgEntry.Amount := -TotalPurchLine."Amount Including VAT";
                        ApplyingVendLedgEntry."Remaining Amount" := -TotalPurchLine."Amount Including VAT";
                    end;
                    CalcApplnAmount;
                end;
            CalcType::Direct:
                begin
                    if "Applying Entry" then begin
                        if ApplyingVendLedgEntry."Entry No." <> 0 then
                            VendLedgEntry := ApplyingVendLedgEntry;
                        "VendEntry-Edit".Run(Rec);
                        if "Applies-to ID" = '' then
                            SetVendApplId;
                        CalcFields(Amount);
                        ApplyingVendLedgEntry := Rec;
                        if VendLedgEntry."Entry No." <> 0 then begin
                            Rec := VendLedgEntry;
                            "Applying Entry" := false;
                            SetVendApplId;
                        end;
                        SetCurrentKey("Entry No.");
                        SetFilter("Entry No.", '<> %1', ApplyingVendLedgEntry."Entry No.");
                        ApplyingAmount := ApplyingVendLedgEntry."Remaining Amount";
                        ApplnDate := ApplyingVendLedgEntry."Posting Date";
                        ApplnCurrencyCode := ApplyingVendLedgEntry."Currency Code";
                    end else begin
                        Rec := ApplyingVendLedgEntry;
                        "Applying Entry" := false;
                        ApplyingVendLedgEntry.Init;
                        ApplyingVendLedgEntry."Entry No." := 0;
                        SetVendApplId;
                        ApplyingAmount := 0;
                        ApplnDate := 0D;
                        ApplnCurrencyCode := '';
                        SetRange("Entry No.");
                    end;
                    CalcApplnAmount;
                end;
            CalcType::GenJnlLine:
                begin
                    ApplyingVendLedgEntry."Posting Date" := GenJnlLine."Posting Date";
                    ApplyingVendLedgEntry."Document Type" := GenJnlLine."Document Type";
                    ApplyingVendLedgEntry."Document No." := GenJnlLine."Document No.";
                    ApplyingVendLedgEntry."Vendor No." := GenJnlLine."Account No.";
                    ApplyingVendLedgEntry.Description := GenJnlLine.Description;
                    ApplyingVendLedgEntry."Currency Code" := GenJnlLine."Currency Code";
                    ApplyingVendLedgEntry.Amount := GenJnlLine.Amount;
                    ApplyingVendLedgEntry."Remaining Amount" := GenJnlLine.Amount;
                    CalcApplnAmount;
                end;
            CalcType::PDCIssue:
                begin
                    ApplyingVendLedgEntry."Posting Date" := PDCIssue."Posting Date";
                    ApplyingVendLedgEntry."Document Type" := ApplyingVendLedgEntry."Document Type"::Payment;
                    ApplyingVendLedgEntry."Document No." := PDCIssue.Code;
                    ApplyingVendLedgEntry."Vendor No." := PDCIssue."Vendor No.";
                    ApplyingVendLedgEntry.Description := PDCIssue.Name;
                    ApplyingVendLedgEntry."Currency Code" := PDCIssue."Currency Code";
                    ApplyingVendLedgEntry.Amount := PDCIssue.Amount;
                    ApplyingVendLedgEntry."Remaining Amount" := PDCIssue.Amount;
                    CalcApplnAmount;
                end;

        end;
    end;

    procedure SetVendApplId()
    begin
        if ApplyingVendLedgEntry."Entry No." <> 0 then
            GenJnlApply.CheckAgainstApplnCurrency(
              ApplnCurrencyCode, "Currency Code", GenJnlLine."Account Type"::Vendor, true);

        VendLedgEntry.Copy(Rec);
        CurrPage.SetSelectionFilter(VendLedgEntry);
        if PDCLineApply then
            VendEntrySetApplID.SetApplId(VendLedgEntry, ApplyingVendLedgEntry, PDCIssue."Applies-to ID")
        //VendEntrySetApplID.SetApplId(VendLedgEntry,ApplyingVendLedgEntry,AppliedAmount,PmtDiscAmount,PDCIssue."Applies-to ID")
        else
            VendEntrySetApplID.SetApplId(VendLedgEntry, ApplyingVendLedgEntry, PurchHeader."Applies-to ID");
        //VendEntrySetApplID.SetApplId(VendLedgEntry,ApplyingVendLedgEntry,AppliedAmount,PmtDiscAmount,PurchHeader."Applies-to ID");}

        CalcApplnAmount;
    end;

    procedure CalcApplnAmount()
    var
        TempAppliedVendLedgEntry: Record "Vendor Ledger Entry" temporary;
        ExchAccGLJnlLine: Codeunit "Exchange Acc. G/L Journal Line";
        I: Integer;
        CurrentAmount: Decimal;
        PossiblePmtDisc: Decimal;
        ToCurrency: Record Currency;
    begin
        AppliedAmount := 0;
        PmtDiscAmount := 0;
        DifferentCurrenciesInAppln := false;

        case CalcType of
            CalcType::Direct:
                begin
                    FindAmountRounding;
                    VendEntryApplID := UserId;
                    if VendEntryApplID = '' then
                        VendEntryApplID := '***';

                    VendLedgEntry := ApplyingVendLedgEntry;

                    AppliedVendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
                    AppliedVendLedgEntry.SetRange("Vendor No.", "Vendor No.");
                    AppliedVendLedgEntry.SetRange(Open, true);
                    AppliedVendLedgEntry.SetRange("Applies-to ID", VendEntryApplID);

                    if ApplyingVendLedgEntry."Entry No." <> 0 then begin
                        VendLedgEntry.CalcFields("Remaining Amount");
                        AppliedVendLedgEntry.SetFilter("Entry No.", '<>%1', VendLedgEntry."Entry No.");
                    end;
                    if AppliedVendLedgEntry.FindSet(false, false) then begin
                        repeat
                            TempAppliedVendLedgEntry := AppliedVendLedgEntry;
                            TempAppliedVendLedgEntry.Insert;
                        until AppliedVendLedgEntry.Next = 0;

                        CurrentAmount := VendLedgEntry."Remaining Amount";
                        PossiblePmtDisc := 0;
                        //<LT> Commented to Code - PDC Upgrade
                        repeat
                            TempAppliedVendLedgEntry.SetRange(Positive, CurrentAmount < 0);
                            if TempAppliedVendLedgEntry.FindFirst then begin
                                TempAppliedVendLedgEntry.CalcFields("Remaining Amount");


                                if (VendLedgEntry."Currency Code" <> TempAppliedVendLedgEntry."Currency Code") and
                                  (ApplyingVendLedgEntry."Entry No." <> 0)
                                then begin
                                    if VendLedgEntry."Currency Code" <> '' then begin
                                        ToCurrency.Get(VendLedgEntry."Currency Code");
                                        TempAppliedVendLedgEntry."Remaining Amount" := Round(TempAppliedVendLedgEntry."Remaining Amount", ToCurrency."Amount Rounding Precision");
                                        TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible" := Round(TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible", ToCurrency."Amount Rounding Precision");
                                        TempAppliedVendLedgEntry."Amount to Apply" := Round(TempAppliedVendLedgEntry."Amount to Apply", ToCurrency."Amount Rounding Precision");
                                    end else begin
                                        TempAppliedVendLedgEntry."Remaining Amount" := Round(TempAppliedVendLedgEntry."Remaining Amount");
                                        TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible" := Round(TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible");
                                        TempAppliedVendLedgEntry."Amount to Apply" := Round(TempAppliedVendLedgEntry."Amount to Apply");
                                    end;
                                end;

                                if
                                  //GenJnlPostLine.CheckCalcPmtDiscVend(VendLedgEntry,TempAppliedVendLedgEntry,0,FALSE,FALSE) AND
                                  (Abs(TempAppliedVendLedgEntry."Amount to Apply") >= Abs(TempAppliedVendLedgEntry."Remaining Amount" -
                                   TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible")) then begin


                                    if (Abs(CurrentAmount - PossiblePmtDisc) > Abs(TempAppliedVendLedgEntry."Remaining Amount" -
                                      TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible"))
                                    then begin
                                        PmtDiscAmount := PmtDiscAmount + TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                                        CurrentAmount := CurrentAmount + TempAppliedVendLedgEntry."Remaining Amount" -
                                          TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                                    end else
                                        if (Abs(CurrentAmount - PossiblePmtDisc) = Abs(TempAppliedVendLedgEntry."Remaining Amount" -
                                 TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible"))
                               then begin
                                            PmtDiscAmount := PmtDiscAmount + TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible" + PossiblePmtDisc;
                                            CurrentAmount := CurrentAmount + TempAppliedVendLedgEntry."Remaining Amount" -
                                              TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible" - PossiblePmtDisc;
                                            PossiblePmtDisc := 0;
                                        end else begin
                                            if (CurrentAmount + TempAppliedVendLedgEntry."Remaining Amount" >= 0) <> (CurrentAmount >= 0) then begin
                                                PmtDiscAmount := PmtDiscAmount + PossiblePmtDisc;
                                                CurrentAmount := CurrentAmount - PossiblePmtDisc;
                                            end;
                                            CurrentAmount := CurrentAmount + TempAppliedVendLedgEntry."Remaining Amount";
                                            PossiblePmtDisc := TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                                        end;
                                end else begin
                                    if (CurrentAmount + TempAppliedVendLedgEntry."Amount to Apply" >= 0) <> (CurrentAmount >= 0) then begin
                                        PmtDiscAmount := PmtDiscAmount + PossiblePmtDisc;
                                        CurrentAmount := CurrentAmount - PossiblePmtDisc;
                                        PossiblePmtDisc := 0;
                                    end;
                                    CurrentAmount := CurrentAmount + TempAppliedVendLedgEntry."Amount to Apply";
                                end;
                            end else begin
                                TempAppliedVendLedgEntry.SetRange(Positive);
                                TempAppliedVendLedgEntry.FindFirst;
                            end;

                            AppliedAmount := AppliedAmount + TempAppliedVendLedgEntry."Amount to Apply";

                            if not DifferentCurrenciesInAppln then
                                DifferentCurrenciesInAppln := ApplnCurrencyCode <> AppliedVendLedgEntry."Currency Code";

                            TempAppliedVendLedgEntry.Delete;
                            TempAppliedVendLedgEntry.SetRange(Positive);

                        until not TempAppliedVendLedgEntry.FindFirst;
                        CheckRounding;
                        //</LT>
                    end;
                end;


            CalcType::GenJnlLine:
                begin
                    FindAmountRounding;
                    if GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor then
                        ExchAccGLJnlLine.Run(GenJnlLine);

                    case ApplnType of
                        ApplnType::"Applies-to Doc. No.":
                            begin
                                AppliedVendLedgEntry := Rec;
                                with AppliedVendLedgEntry do begin
                                    CalcFields("Remaining Amount");
                                    if "Currency Code" <> ApplnCurrencyCode then begin
                                        "Remaining Amount" :=
                                          CurrExchRate.ExchangeAmtFCYToFCY(
                                            ApplnDate, "Currency Code", ApplnCurrencyCode, "Remaining Amount");
                                        "Remaining Pmt. Disc. Possible" :=
                                          CurrExchRate.ExchangeAmtFCYToFCY(
                                            ApplnDate, "Currency Code", ApplnCurrencyCode, "Remaining Pmt. Disc. Possible");
                                        "Amount to Apply" :=
                                          CurrExchRate.ExchangeAmtFCYToFCY(
                                            ApplnDate, "Currency Code", ApplnCurrencyCode, "Amount to Apply");
                                    end;

                                    if "Amount to Apply" <> 0 then
                                        AppliedAmount := Round("Amount to Apply", AmountRoundingPrecision)
                                    else
                                        AppliedAmount := Round("Remaining Amount", AmountRoundingPrecision);

                                    //<LT> Commented the code - PDC Upgrade

                                    if
                                       /*GenJnlPostLine.CheckCalcPmtDiscGenJnlVend(
                                            GenJnlLine,AppliedVendLedgEntry,0,FALSE) AND*/
                                       ((Abs(GenJnlLine.Amount) + ApplnRoundingPrecision >=
                                         Abs(AppliedAmount - "Remaining Pmt. Disc. Possible")) or
                                        (GenJnlLine.Amount = 0))
                                    then
                                        PmtDiscAmount := "Remaining Pmt. Disc. Possible";

                                    //</LT>
                                    if not DifferentCurrenciesInAppln then
                                        DifferentCurrenciesInAppln := ApplnCurrencyCode <> "Currency Code";

                                end;
                                CheckRounding;
                            end;

                        ApplnType::"Applies-to ID":
                            begin
                                GenJnlLine2 := GenJnlLine;
                                AppliedVendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
                                AppliedVendLedgEntry.SetRange("Vendor No.", GenJnlLine."Account No.");
                                AppliedVendLedgEntry.SetRange(Open, true);

                                if GenJnlLine."Applies-to ID" <> '' then
                                    AppliedVendLedgEntry.SetRange("Applies-to ID", GenJnlLine."Applies-to ID")
                                else
                                    AppliedVendLedgEntry.SetRange("Applies-to ID", PurchHeader."No.");

                                if AppliedVendLedgEntry.Find('-') then begin
                                    repeat
                                        TempAppliedVendLedgEntry := AppliedVendLedgEntry;
                                        TempAppliedVendLedgEntry.Insert;
                                    until AppliedVendLedgEntry.Next = 0;

                                    CurrentAmount := GenJnlLine2.Amount;
                                    PossiblePmtDisc := 0;
                                    //<LT> Commented the code - PDC Upgrade

                                    repeat
                                        TempAppliedVendLedgEntry.SetRange(Positive, CurrentAmount < 0);
                                        if TempAppliedVendLedgEntry.FindFirst then begin
                                            TempAppliedVendLedgEntry.CalcFields("Remaining Amount");

                                            if (GenJnlLine2."Currency Code" <> TempAppliedVendLedgEntry."Currency Code") then begin
                                                if GenJnlLine2."Currency Code" <> '' then begin
                                                    ToCurrency.Get(GenJnlLine2."Currency Code");
                                                    TempAppliedVendLedgEntry."Remaining Amount" := Round(TempAppliedVendLedgEntry."Remaining Amount", ToCurrency."Amount Rounding Precision");
                                                    TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible" := Round(TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible", ToCurrency."Amount Rounding Precision");
                                                    TempAppliedVendLedgEntry."Amount to Apply" := Round(TempAppliedVendLedgEntry."Amount to Apply", ToCurrency."Amount Rounding Precision");
                                                end else begin
                                                    TempAppliedVendLedgEntry."Remaining Amount" := Round(TempAppliedVendLedgEntry."Remaining Amount");
                                                    TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible" := Round(TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible");
                                                    TempAppliedVendLedgEntry."Amount to Apply" := Round(TempAppliedVendLedgEntry."Amount to Apply");
                                                end;
                                            end;

                                            //GenJnlPostLine.CheckCalcPmtDiscGenJnlVend(GenJnlLine2,TempAppliedVendLedgEntry,0,FALSE) AND
                                            if (Abs(TempAppliedVendLedgEntry."Amount to Apply") >= Abs(TempAppliedVendLedgEntry."Remaining Amount" -
                                               TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible")) then begin

                                                if (Abs(CurrentAmount - PossiblePmtDisc) > Abs(TempAppliedVendLedgEntry."Remaining Amount" -
                                                  TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible"))
                                                then begin
                                                    PmtDiscAmount := PmtDiscAmount + TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                                                    CurrentAmount := CurrentAmount + TempAppliedVendLedgEntry."Remaining Amount" -
                                                      TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                                                end else
                                                    if (Abs(CurrentAmount - PossiblePmtDisc) = Abs(TempAppliedVendLedgEntry."Remaining Amount" -
                                             TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible"))
                                           then begin
                                                        PmtDiscAmount := PmtDiscAmount + TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible" + PossiblePmtDisc;
                                                        CurrentAmount := CurrentAmount + TempAppliedVendLedgEntry."Remaining Amount" -
                                                          TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible" - PossiblePmtDisc;
                                                        PossiblePmtDisc := 0;
                                                    end else begin
                                                        if (CurrentAmount + TempAppliedVendLedgEntry."Remaining Amount" >= 0) <> (CurrentAmount >= 0) then begin
                                                            PmtDiscAmount := PmtDiscAmount + PossiblePmtDisc;
                                                            CurrentAmount := CurrentAmount - PossiblePmtDisc;
                                                        end;
                                                        CurrentAmount := CurrentAmount + TempAppliedVendLedgEntry."Remaining Amount";
                                                        PossiblePmtDisc := TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                                                    end;
                                            end else begin
                                                if (CurrentAmount + TempAppliedVendLedgEntry."Amount to Apply" >= 0) <> (CurrentAmount >= 0) then begin
                                                    PmtDiscAmount := PmtDiscAmount + PossiblePmtDisc;
                                                    CurrentAmount := CurrentAmount - PossiblePmtDisc;
                                                    PossiblePmtDisc := 0;
                                                end;
                                                CurrentAmount := CurrentAmount + TempAppliedVendLedgEntry."Amount to Apply";
                                            end;
                                        end else begin
                                            TempAppliedVendLedgEntry.SetRange(Positive);
                                            TempAppliedVendLedgEntry.FindFirst;
                                        end;

                                        AppliedAmount := AppliedAmount + TempAppliedVendLedgEntry."Amount to Apply";

                                        if not DifferentCurrenciesInAppln then
                                            DifferentCurrenciesInAppln := ApplnCurrencyCode <> AppliedVendLedgEntry."Currency Code";

                                        TempAppliedVendLedgEntry.Delete;
                                        TempAppliedVendLedgEntry.SetRange(Positive);

                                    until not TempAppliedVendLedgEntry.FindFirst;

                                    //<LT> Commented the code - PDC Upgrade
                                    CheckRounding;
                                end;
                            end;
                    end;
                end;

            CalcType::PDCIssue:
                begin
                    FindAmountRounding;
                    case ApplnType of
                        ApplnType::"Applies-to ID":
                            begin
                                PDCIssue2 := PDCIssue;
                                AppliedVendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
                                AppliedVendLedgEntry.SetRange("Vendor No.", PDCIssue."Vendor No.");
                                AppliedVendLedgEntry.SetRange(Open, true);

                                if PDCIssue."Applies-to ID" <> '' then
                                    AppliedVendLedgEntry.SetRange("Applies-to ID", PDCIssue."Applies-to ID")
                                else
                                    AppliedVendLedgEntry.SetRange("Applies-to ID", PurchHeader."No.");

                                if AppliedVendLedgEntry.Find('-') then begin
                                    repeat
                                        TempAppliedVendLedgEntry := AppliedVendLedgEntry;
                                        TempAppliedVendLedgEntry.Insert;
                                    until AppliedVendLedgEntry.Next = 0;

                                    CurrentAmount := PDCIssue2.Amount;
                                    PossiblePmtDisc := 0;
                                    repeat
                                        TempAppliedVendLedgEntry.SetRange(Positive, CurrentAmount < 0);
                                        if TempAppliedVendLedgEntry.FindFirst then begin
                                            TempAppliedVendLedgEntry.CalcFields("Remaining Amount");

                                            if (PDCIssue2."Currency Code" <> TempAppliedVendLedgEntry."Currency Code") then begin
                                                if PDCIssue2."Currency Code" <> '' then begin
                                                    ToCurrency.Get(PDCIssue2."Currency Code");
                                                    TempAppliedVendLedgEntry."Remaining Amount" := Round(TempAppliedVendLedgEntry."Remaining Amount", ToCurrency."Amount Rounding Precision");
                                                    TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible" := Round(TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible", ToCurrency."Amount Rounding Precision");
                                                    TempAppliedVendLedgEntry."Amount to Apply" := Round(TempAppliedVendLedgEntry."Amount to Apply", ToCurrency."Amount Rounding Precision");
                                                end else begin
                                                    TempAppliedVendLedgEntry."Remaining Amount" := Round(TempAppliedVendLedgEntry."Remaining Amount");
                                                    TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible" := Round(TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible");
                                                    TempAppliedVendLedgEntry."Amount to Apply" := Round(TempAppliedVendLedgEntry."Amount to Apply");
                                                end;
                                            end;

                                            if (Abs(TempAppliedVendLedgEntry."Amount to Apply") >= Abs(TempAppliedVendLedgEntry."Remaining Amount" -
                                               TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible")) then begin
                                                if (Abs(CurrentAmount - PossiblePmtDisc) > Abs(TempAppliedVendLedgEntry."Remaining Amount" -
                                                  TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible"))
                                                then begin
                                                    PmtDiscAmount := PmtDiscAmount + TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                                                    CurrentAmount := CurrentAmount + TempAppliedVendLedgEntry."Remaining Amount" -
                                                      TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                                                end else
                                                    if (Abs(CurrentAmount - PossiblePmtDisc) = Abs(TempAppliedVendLedgEntry."Remaining Amount" -
                                             TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible"))
                                           then begin
                                                        PmtDiscAmount := PmtDiscAmount + TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible" + PossiblePmtDisc;
                                                        CurrentAmount := CurrentAmount + TempAppliedVendLedgEntry."Remaining Amount" -
                                                          TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible" - PossiblePmtDisc;
                                                        PossiblePmtDisc := 0;
                                                    end else begin
                                                        if (CurrentAmount + TempAppliedVendLedgEntry."Remaining Amount" >= 0) <> (CurrentAmount >= 0) then begin
                                                            PmtDiscAmount := PmtDiscAmount + PossiblePmtDisc;
                                                            CurrentAmount := CurrentAmount - PossiblePmtDisc;
                                                        end;
                                                        CurrentAmount := CurrentAmount + TempAppliedVendLedgEntry."Remaining Amount";
                                                        PossiblePmtDisc := TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                                                    end;
                                            end else begin
                                                if (CurrentAmount + TempAppliedVendLedgEntry."Amount to Apply" >= 0) <> (CurrentAmount >= 0) then begin
                                                    PmtDiscAmount := PmtDiscAmount + PossiblePmtDisc;
                                                    CurrentAmount := CurrentAmount - PossiblePmtDisc;
                                                    PossiblePmtDisc := 0;
                                                end;
                                                CurrentAmount := CurrentAmount + TempAppliedVendLedgEntry."Amount to Apply";
                                            end;
                                        end else begin
                                            TempAppliedVendLedgEntry.SetRange(Positive);
                                            TempAppliedVendLedgEntry.FindFirst;
                                        end;

                                        AppliedAmount := AppliedAmount + TempAppliedVendLedgEntry."Amount to Apply";

                                        if not DifferentCurrenciesInAppln then
                                            DifferentCurrenciesInAppln := ApplnCurrencyCode <> AppliedVendLedgEntry."Currency Code";

                                        TempAppliedVendLedgEntry.Delete;
                                        TempAppliedVendLedgEntry.SetRange(Positive);

                                    until not TempAppliedVendLedgEntry.FindFirst;
                                    CheckRounding;
                                end;
                            end;
                    end;
                end;
            CalcType::PurchHeader:
                begin
                    FindAmountRounding;

                    case ApplnType of
                        ApplnType::"Applies-to Doc. No.":
                            begin
                                AppliedVendLedgEntry := Rec;
                                with AppliedVendLedgEntry do begin
                                    CalcFields("Remaining Amount");

                                    if "Currency Code" <> ApplnCurrencyCode then
                                        "Remaining Amount" :=
                                          CurrExchRate.ExchangeAmtFCYToFCY(
                                            ApplnDate, "Currency Code", ApplnCurrencyCode, "Remaining Amount");

                                    AppliedAmount := AppliedAmount + Round("Remaining Amount", AmountRoundingPrecision);

                                    if not DifferentCurrenciesInAppln then
                                        DifferentCurrenciesInAppln := ApplnCurrencyCode <> "Currency Code";

                                end;
                                CheckRounding;
                            end;

                        ApplnType::"Applies-to ID":
                            begin
                                with VendLedgEntry do begin
                                    AppliedVendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
                                    AppliedVendLedgEntry.SetRange("Vendor No.", PurchHeader."Pay-to Vendor No.");
                                    AppliedVendLedgEntry.SetRange(Open, true);

                                    if PurchHeader."Applies-to ID" <> '' then
                                        AppliedVendLedgEntry.SetRange("Applies-to ID", PurchHeader."Applies-to ID")
                                    else
                                        AppliedVendLedgEntry.SetRange("Applies-to ID", PurchHeader."No.");

                                    for I := 1 to 2 do begin
                                        if GenJnlLine.Amount <> 0 then begin
                                            if I = 1 then
                                                AppliedVendLedgEntry.SetRange(Positive, GenJnlLine.Amount > 0)
                                            else
                                                AppliedVendLedgEntry.SetRange(Positive, GenJnlLine.Amount < 0);
                                        end
                                        else
                                            I := 2;

                                        with AppliedVendLedgEntry do begin
                                            if Find('-') then
                                                repeat
                                                    CalcFields("Remaining Amount");

                                                    if "Currency Code" <> ApplnCurrencyCode then
                                                        "Remaining Amount" :=
                                                          CurrExchRate.ExchangeAmtFCYToFCY(
                                                            ApplnDate, "Currency Code", ApplnCurrencyCode, "Remaining Amount");

                                                    AppliedAmount := AppliedAmount + Round("Remaining Amount", AmountRoundingPrecision);

                                                    if not DifferentCurrenciesInAppln then
                                                        DifferentCurrenciesInAppln := ApplnCurrencyCode <> "Currency Code";

                                                until Next = 0;
                                        end;
                                        CheckRounding;
                                    end;
                                end;
                            end;
                    end;
                end;
        end;

    end;

    procedure CalcApplnRemainingAmount(Amount: Decimal): Decimal
    var
        ApplnRemainingAmount: Decimal;
    begin
        ValidExchRate := true;
        if ApplnCurrencyCode = "Currency Code" then
            exit(Amount)
        else begin
            if ApplnDate = 0D then
                ApplnDate := "Posting Date";
            ApplnRemainingAmount :=
              CurrExchRate.ApplnExchangeAmtFCYToFCY(
                ApplnDate, "Currency Code", ApplnCurrencyCode, Amount, ValidExchRate);
            exit(ApplnRemainingAmount);
        end;
    end;

    procedure CalcApplnAmounttoApply(AmounttoApply: Decimal): Decimal
    var
        ApplnAmountToApply: Decimal;
    begin
        ValidExchRate := true;

        if ApplnCurrencyCode = "Currency Code" then
            exit(AmounttoApply)
        else begin
            if ApplnDate = 0D then
                ApplnDate := "Posting Date";
            ApplnAmountToApply :=
              CurrExchRate.ApplnExchangeAmtFCYToFCY(
                ApplnDate, "Currency Code", ApplnCurrencyCode, AmounttoApply, ValidExchRate);
            exit(ApplnAmountToApply);
        end;
    end;

    procedure FindAmountRounding()
    begin
        if ApplnCurrencyCode = '' then begin
            Currency.Init;
            Currency.Code := '';
            Currency.InitRoundingPrecision;
        end else
            if ApplnCurrencyCode <> Currency.Code then
                Currency.Get(ApplnCurrencyCode);

        AmountRoundingPrecision := Currency."Amount Rounding Precision";
    end;

    procedure CheckRounding()
    begin
        ApplnRounding := 0;

        case CalcType of
            CalcType::PurchHeader:
                exit;
            CalcType::GenJnlLine:
                if ("Document Type" <> "Document Type"::Payment) and
                  ("Document Type" <> "Document Type"::Refund)
                then
                    exit;
        end;

        if ApplnCurrencyCode = '' then
            ApplnRoundingPrecision := GLSetup."Appln. Rounding Precision"
        else begin
            if ApplnCurrencyCode <> "Currency Code" then
                Currency.Get(ApplnCurrencyCode);
            ApplnRoundingPrecision := Currency."Appln. Rounding Precision";
        end;

        if (Abs((AppliedAmount - PmtDiscAmount) + ApplyingAmount) <= ApplnRoundingPrecision) and DifferentCurrenciesInAppln then
            ApplnRounding := -((AppliedAmount - PmtDiscAmount) + ApplyingAmount);
    end;

    procedure GetVendLedgEntry(var VendLedgEntry: Record "Vendor Ledger Entry")
    begin
        VendLedgEntry := Rec;
    end;

    procedure FindApplyingEntry()
    begin
        if CalcType = CalcType::Direct then begin
            VendEntryApplID := UserId;
            if VendEntryApplID = '' then
                VendEntryApplID := '***';

            VendLedgEntry.SetCurrentKey("Vendor No.", "Applies-to ID", Open);
            VendLedgEntry.SetRange("Vendor No.", "Vendor No.");
            VendLedgEntry.SetRange("Applies-to ID", VendEntryApplID);
            VendLedgEntry.SetRange(Open, true);
            VendLedgEntry.SetRange("Applying Entry", true);
            if VendLedgEntry.Find('-') then begin
                VendLedgEntry.CalcFields(Amount, "Remaining Amount");
                ApplyingVendLedgEntry := VendLedgEntry;
                SetCurrentKey("Entry No.");
                SetFilter("Entry No.", '<> %1', VendLedgEntry."Entry No.");
                ApplyingAmount := VendLedgEntry."Remaining Amount";
                ApplnDate := VendLedgEntry."Posting Date";
                ApplnCurrencyCode := VendLedgEntry."Currency Code";
            end;
            CalcApplnAmount;
        end;
    end;

    local procedure AmounttoApplyOnAfterValidate()
    begin
        if ApplnType <> ApplnType::"Applies-to Doc. No." then begin
            CalcApplnAmount;
            CurrPage.Update(false);
        end;
    end;

    local procedure fnOnAfterGetCurrRecord()
    begin
        xRec := Rec;
        if CalcType = CalcType::GenJnlLine then
            CalcApplnAmount;
    end;

    local procedure ShowAppliedEntriesOnPush()
    begin
        if ShowAppliedEntries then begin
            if CalcType = CalcType::GenJnlLine then
                SetRange("Applies-to ID", GenJnlLine."Applies-to ID")
            else begin
                VendEntryApplID := UserId;
                if VendEntryApplID = '' then
                    VendEntryApplID := '***';
                SetRange("Applies-to ID", VendEntryApplID);
            end;
        end else
            SetRange("Applies-to ID");
    end;

    local procedure LookupOKOnPush()
    begin
        OKPressed := true;
    end;
}

