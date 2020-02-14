page 60002 "Apply Cust. Ledger Entries"
{
    // Code           Date        Name        Desc.
    // APNT-LCPDC1.0  20.05.12    Monica      Created New.

    Caption = 'Apply Customer Entries';
    DataCaptionFields = "Customer No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Cust. Ledger Entry";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("ApplyingCustLedgEntry.""Posting Date"""; ApplyingCustLedgEntry."Posting Date")
                {
                    Caption = 'Posting Date';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ApplyingCustLedgEntry.""Document Type"""; ApplyingCustLedgEntry."Document Type")
                {
                    Caption = 'Document Type';
                    Editable = false;
                    ApplicationArea = All;
                    OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
                }
                field("ApplyingCustLedgEntry.""Document No."""; ApplyingCustLedgEntry."Document No.")
                {
                    Caption = 'Document No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ApplyingCustLedgEntry.""Customer No."""; ApplyingCustLedgEntry."Customer No.")
                {
                    Caption = 'Customer No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ApplyingCustLedgEntry.Description"; ApplyingCustLedgEntry.Description)
                {
                    Caption = 'Description';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ApplyingCustLedgEntry.""Currency Code"""; ApplyingCustLedgEntry."Currency Code")
                {
                    Caption = 'Currency Code';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ApplyingCustLedgEntry.Amount"; ApplyingCustLedgEntry.Amount)
                {
                    Caption = 'Amount';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ApplyingCustLedgEntry.""Remaining Amount"""; ApplyingCustLedgEntry."Remaining Amount")
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
                field("Customer No."; "Customer No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Original Amount"; "Original Amount")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("External Document No."; "External Document No.")
                {
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
                field("PDC Amount to Apply"; AmtToApply)
                {
                    ToolTip = 'Specify PDC amount to be applied';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Validate("Amount to Apply", AmtToApply);
                        CurrPage.Update;
                    end;
                }
                field("Amount to Apply"; "Amount to Apply")
                {

                    Caption = 'Amount to Apply';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin

                        CODEUNIT.Run(CODEUNIT::"Cust. Entry-Edit", Rec);

                        if (xRec."Amount to Apply" = 0) or (Rec."Amount to Apply" = 0) and
                           (ApplnType = ApplnType::"Applies-to ID")
                        then
                            SetCustApplId;
                        Get("Entry No.");
                        AmounttoApplyOnAfterValidate;

                    end;
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
                action("Reminder/Fin. Charge Entries")
                {
                    Caption = 'Reminder/Fin. Charge Entries';
                    RunObject = Page "Reminder/Fin. Charge Entries";
                    RunPageLink = "Customer Entry No." = FIELD("Entry No.");
                    RunPageView = SORTING("Customer Entry No.");
                    ApplicationArea = All;
                }
                action("Applied E&ntries")
                {
                    Caption = 'Applied E&ntries';
                    RunObject = Page "Applied Customer Entries";
                    RunPageOnRec = true;
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    //RunObject = Page Page544;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        ShowDimensions();
                    end;
                }
                action("Detailed &Ledger Entries")
                {
                    Caption = 'Detailed &Ledger Entries';
                    RunObject = Page "Detailed Cust. Ledg. Entries";
                    RunPageLink = "Cust. Ledger Entry No." = FIELD("Entry No.");
                    RunPageView = SORTING("Cust. Ledger Entry No.", "Posting Date");
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
                            SetApplyingCustLedgEntry;
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
                            SetApplyingCustLedgEntry;
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
                            if ((ApplyingCustLedgEntry."Document Type" = ApplyingCustLedgEntry."Document Type"::Payment) or
                                (ApplyingCustLedgEntry."Document Type" = ApplyingCustLedgEntry."Document Type"::Refund)) and
                               (ApplyingCustLedgEntry."Posting Date" < "Posting Date")
                            then
                                Error(
                                  Text006, ApplyingCustLedgEntry."Document Type", ApplyingCustLedgEntry."Document No.",
                                  "Document Type", "Document No.");
                        end;
                        if CalcType = CalcType::PDCReceipt then begin
                            if ApplnType = ApplnType::"Applies-to Doc. No." then
                                Error(Text004);
                            if ((ApplyingCustLedgEntry."Document Type" = ApplyingCustLedgEntry."Document Type"::Payment) or
                                (ApplyingCustLedgEntry."Document Type" = ApplyingCustLedgEntry."Document Type"::Refund)) and
                               (ApplyingCustLedgEntry."Posting Date" < "Posting Date")
                            then
                                Error(
                                  Text006, ApplyingCustLedgEntry."Document Type", ApplyingCustLedgEntry."Document No.",
                                  "Document Type", "Document No.");
                        end;

                        SetCustApplId;
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
                        CustEntryApplyPostedEntries: Codeunit "CustEntry-Apply Posted Entries";
                        Window: Dialog;
                        CustVendAppEntry: Record "Customer Vendor Applied Entry";
                        EntryNo: Integer;
                        CustomerLedgEntry: Record "Cust. Ledger Entry";
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

                        CustomerLedgEntry.Reset;
                        CustomerLedgEntry.SetCurrentKey("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
                        CustomerLedgEntry.SetRange("Customer No.", "Customer No.");
                        CustomerLedgEntry.SetRange(Open, true);
                        if CustomerLedgEntry.Find('-') then
                            repeat
                                Window.Update(1, CustomerLedgEntry."Document No.");
                                Window.Update(2, CustomerLedgEntry."Amount to Apply");
                                if (CustomerLedgEntry."Applies-to ID" <> '') or (CustomerLedgEntry."Amount to Apply" <> 0) then begin
                                    CustVendAppEntry.Reset;
                                    CustVendAppEntry.SetRange("Document Type", CustVendAppEntry."Document Type"::Sales);
                                    CustVendAppEntry.SetRange("Document No.", CustomerLedgEntry."Document No.");
                                    CustVendAppEntry.SetRange("Source Type", CustVendAppEntry."Source Type"::Customer);
                                    CustVendAppEntry.SetRange("Source No.", CustomerLedgEntry."Customer No.");
                                    if CustVendAppEntry.Find('-') then begin
                                        CustVendAppEntry."Source Document No." := ApplyingCustLedgEntry."Document No.";
                                        CustVendAppEntry."Applied Amount (ICY)" := CustomerLedgEntry."Amount to Apply";
                                        CustVendAppEntry."Applied Amount (LCY)" := CurrExchRate.ExchangeAmtFCYToLCY(CustomerLedgEntry."Posting Date",
                                        CustomerLedgEntry."Currency Code", CustomerLedgEntry."Amount to Apply", CustomerLedgEntry."Original Currency Factor");
                                        CustVendAppEntry."Shortcut Dimension 1 Code" := CustomerLedgEntry."Global Dimension 1 Code";
                                        CustVendAppEntry."Shortcut Dimension 2 Code" := CustomerLedgEntry."Global Dimension 2 Code";
                                        CustVendAppEntry.Modify;
                                    end else begin
                                        CustVendAppEntry.Init;
                                        CustVendAppEntry."Entry No." := EntryNo;
                                        CustVendAppEntry."Document Type" := CustVendAppEntry."Document Type"::Sales;
                                        CustVendAppEntry."Document No." := CustomerLedgEntry."Document No.";
                                        CustVendAppEntry."Source Type" := CustVendAppEntry."Source Type"::Customer;
                                        CustVendAppEntry."Source No." := CustomerLedgEntry."Customer No.";
                                        CustVendAppEntry."Applied Amount (ICY)" := CustomerLedgEntry."Amount to Apply";
                                        CustVendAppEntry."Applied Amount (LCY)" := CurrExchRate.ExchangeAmtFCYToLCY(CustomerLedgEntry."Posting Date",
                                        CustomerLedgEntry."Currency Code", CustomerLedgEntry."Amount to Apply", CustomerLedgEntry."Original Currency Factor");
                                        CustVendAppEntry."Shortcut Dimension 1 Code" := CustomerLedgEntry."Global Dimension 1 Code";
                                        CustVendAppEntry."Shortcut Dimension 2 Code" := CustomerLedgEntry."Global Dimension 2 Code";
                                        CustVendAppEntry."Source Document No." := ApplyingCustLedgEntry."Document No.";
                                        CustVendAppEntry.Insert;
                                        EntryNo += 1;
                                    end;
                                end else begin
                                    CustVendAppEntry.Reset;
                                    CustVendAppEntry.SetRange("Document Type", CustVendAppEntry."Document Type"::Sales);
                                    CustVendAppEntry.SetRange("Document No.", CustomerLedgEntry."Document No.");
                                    CustVendAppEntry.SetRange("Source Type", CustVendAppEntry."Source Type"::Customer);
                                    CustVendAppEntry.SetRange("Source No.", CustomerLedgEntry."Customer No.");
                                    CustVendAppEntry.DeleteAll;
                                end;
                            until CustomerLedgEntry.Next = 0;
                        Window.Close;
                        //APNT-IBU1.0

                        if CalcType = CalcType::Direct then begin
                            if ApplyingCustLedgEntry."Entry No." <> 0 then begin
                                Rec := ApplyingCustLedgEntry;
                                // Post Application
                                CustEntryApplyPostedEntries.Run(Rec);
                                ApplyingCustLedgEntry."Entry No." := 0;
                                ApplyingCustLedgEntry.Init;
                                ApplnCurrencyCode := '';
                                ApplyingAmount := 0;
                                SetRange("Entry No.");
                                FindApplyingEntry;
                                CurrPage.Update(false);
                            end else
                                Error(Text002);
                        end else
                            Error(Text003);
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
            if ((ApplyingCustLedgEntry."Document Type" = ApplyingCustLedgEntry."Document Type"::Payment) or
                (ApplyingCustLedgEntry."Document Type" = ApplyingCustLedgEntry."Document Type"::Refund)) and
               (ApplyingCustLedgEntry."Posting Date" < "Posting Date")
            then
                Error(
                  Text006, ApplyingCustLedgEntry."Document Type", ApplyingCustLedgEntry."Document No.",
                  "Document Type", "Document No.");

            if OK then begin
                if "Amount to Apply" = 0 then
                    "Amount to Apply" := "Remaining Amount";

                CODEUNIT.Run(CODEUNIT::"Cust. Entry-Edit", Rec);
            end;
        end;
    end;

    trigger OnInit()
    begin
        "Applies-to IDVisible" := true;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        editbool := true;
        CODEUNIT.Run(CODEUNIT::"Cust. Entry-Edit", Rec);
        exit(false);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        fnOnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        if CalcType = CalcType::Direct then begin
            Cust.Get("Customer No.");
            ApplnCurrencyCode := Cust."Currency Code";
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
        CustomerLedgEntry: Record "Cust. Ledger Entry";
    begin
        if CloseAction = ACTION::LookupOK then
            LookupOKOnPush;
        //APNT-IBU1.0
        Window.Open('Updating Customer Vendor Applied Entries.\' +
                    'Document No.             #1##############\' +
                    'Amount to Apply          #2##############');

        CustVendAppEntry.Reset;
        CustVendAppEntry.SetRange("Source No.", "Customer No.");
        CustVendAppEntry.SetRange("Source Document No.", ApplyingCustLedgEntry."Document No.");
        CustVendAppEntry.DeleteAll;

        CustVendAppEntry.Reset;
        if CustVendAppEntry.Find('+') then
            EntryNo := CustVendAppEntry."Entry No." + 1
        else
            EntryNo := 1;

        CustomerLedgEntry.Reset;
        CustomerLedgEntry.SetCurrentKey("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
        CustomerLedgEntry.SetRange("Customer No.", "Customer No.");
        CustomerLedgEntry.SetRange(Open, true);
        CustomerLedgEntry.SetRange("Applies-to ID", ApplyingCustLedgEntry."Document No.");
        if CustomerLedgEntry.Find('-') then begin
            if CurrPage.LookupMode = true then
                if OKPressed = false then
                    Error('Please select OK to Apply Customer Ledger Entries');
            repeat
                Window.Update(1, CustomerLedgEntry."Document No.");
                Window.Update(2, CustomerLedgEntry."Amount to Apply");
                if (CustomerLedgEntry."Applies-to ID" <> '') or (CustomerLedgEntry."Amount to Apply" <> 0) then begin
                    CustVendAppEntry.Reset;
                    CustVendAppEntry.SetRange("Document Type", CustVendAppEntry."Document Type"::Sales);
                    CustVendAppEntry.SetRange("Document No.", CustomerLedgEntry."Document No.");
                    CustVendAppEntry.SetRange("Source Type", CustVendAppEntry."Source Type"::Customer);
                    CustVendAppEntry.SetRange("Source No.", CustomerLedgEntry."Customer No.");
                    CustVendAppEntry.SetRange("Application Entry No.", CustomerLedgEntry."Entry No.");
                    CustVendAppEntry.SetRange("Inter Dimension Posted", false);
                    if CustVendAppEntry.Find('-') then begin
                        CustVendAppEntry."Source Document No." := ApplyingCustLedgEntry."Document No.";
                        CustVendAppEntry."Posting Date" := PDCReceipt."Document Date";
                        CustVendAppEntry.Validate("ICY Currency Code", CustomerLedgEntry."Currency Code");
                        CustVendAppEntry.Validate("Applied Amount (ICY)", CustomerLedgEntry."Amount to Apply");
                        CustVendAppEntry.Validate("FCY Currency Code", ApplyingCustLedgEntry."Currency Code");
                        CustVendAppEntry.Validate("Applied Amount (FCY)", CalcApplnAmounttoApply(CustomerLedgEntry."Amount to Apply"));
                        CustVendAppEntry."Shortcut Dimension 1 Code" := CustomerLedgEntry."Global Dimension 1 Code";
                        CustVendAppEntry."Shortcut Dimension 2 Code" := CustomerLedgEntry."Global Dimension 2 Code";
                        CustVendAppEntry.Modify;
                    end else begin
                        CustVendAppEntry.Init;
                        CustVendAppEntry."Entry No." := EntryNo;
                        CustVendAppEntry."Document Type" := CustVendAppEntry."Document Type"::Sales;
                        CustVendAppEntry."Document No." := CustomerLedgEntry."Document No.";
                        CustVendAppEntry."Source Type" := CustVendAppEntry."Source Type"::Customer;
                        CustVendAppEntry."Source No." := CustomerLedgEntry."Customer No.";
                        CustVendAppEntry."Posting Date" := PDCReceipt."Document Date";
                        CustVendAppEntry.Validate("ICY Currency Code", CustomerLedgEntry."Currency Code");
                        CustVendAppEntry.Validate("Applied Amount (ICY)", CustomerLedgEntry."Amount to Apply");
                        CustVendAppEntry.Validate("FCY Currency Code", ApplyingCustLedgEntry."Currency Code");
                        CustVendAppEntry.Validate("Applied Amount (FCY)", CalcApplnAmounttoApply(CustomerLedgEntry."Amount to Apply"));
                        CustVendAppEntry."Shortcut Dimension 1 Code" := CustomerLedgEntry."Global Dimension 1 Code";
                        CustVendAppEntry."Shortcut Dimension 2 Code" := CustomerLedgEntry."Global Dimension 2 Code";
                        CustVendAppEntry."Source Document No." := ApplyingCustLedgEntry."Document No.";
                        CustVendAppEntry."Application Entry No." := CustomerLedgEntry."Entry No.";
                        CustVendAppEntry.Insert;
                        EntryNo += 1;
                    end;
                end;
            until CustomerLedgEntry.Next = 0;
        end else begin
            CustVendAppEntry.Reset;
            CustVendAppEntry.SetRange("Document Type", CustVendAppEntry."Document Type"::Sales);
            CustVendAppEntry.SetRange("Source Type", CustVendAppEntry."Source Type"::Customer);
            CustVendAppEntry.SetRange("Source No.", "Customer No.");
            CustVendAppEntry.SetRange("Source Document No.", ApplyingCustLedgEntry."Document No.");
            CustVendAppEntry.DeleteAll;
        end;
        Window.Close;
        //APNT-IBU1.0
    end;

    var
        Text000: Label 'Undefined';
        ApplyingCustLedgEntry: Record "Cust. Ledger Entry" temporary;
        AppliedCustLedgEntry: Record "Cust. Ledger Entry";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        PDCReceipt: Record "PDC Receipt";
        PDCReceipt2: Record "PDC Receipt";
        SalesHeader: Record "Sales Header";
        ServHeader: Record "Service Header";
        Cust: Record Customer;
        CustLedgEntry: Record "Cust. Ledger Entry";
        GLSetup: Record "General Ledger Setup";
        TotalSalesLine: Record "Sales Line";
        TotalSalesLineLCY: Record "Sales Line";
        TotalServLine: Record "Service Line";
        TotalServLineLCY: Record "Service Line";
        Navigate: Page Navigate;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        SalesPost: Codeunit "Sales-Post";
        PDCLineApply: Boolean;
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
        ProfitLCY: Decimal;
        ProfitPct: Decimal;
        CalcType: Option Direct,GenJnlLine,SalesHeader,ServHeader,PDCReceipt;
        CustEntryApplID: Code[20];
        ValidExchRate: Boolean;
        DifferentCurrenciesInAppln: Boolean;
        Text001: Label 'You are not allowed to choose a new applying entry while selecting apply entries.';
        Text002: Label 'You must select an applying entry before you can post the application.';
        ShowAppliedEntries: Boolean;
        Text003: Label 'You must post the application from the window where you entered the applying entry.';
        Text004: Label 'You are not allowed to set Applies-to ID while selecting Applies-to Doc. No.';
        OK: Boolean;
        Text006: Label 'You are not allowed to apply and post an entry to an entry with an earlier posting date.\\Instead, post %1 %2 and then apply it to %3 %4.';
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLineApply: Boolean;
        GenJnlLine2: Record "Gen. Journal Line";
        PDCReceiptApply: Page "PDC Receipt";
        OKPressed: Boolean;
        [InDataSet]
        "Applies-to IDVisible": Boolean;
        AmtToApply: Decimal;
        editbool: Boolean;

    procedure SetPDCLine(NewPDCReceipt: Record "PDC Receipt"; ApplnTypeSelect: Integer)
    begin
        PDCReceipt := NewPDCReceipt;
        PDCLineApply := true;
        ApplyingAmount := PDCReceipt.Amount;

        ApplnDate := PDCReceipt."Document Date";
        ApplnCurrencyCode := PDCReceipt."Currency Code";
        CalcType := CalcType::PDCReceipt;
        ApplnType := ApplnType::"Applies-to ID";

        SetApplyingCustLedgEntry;
    end;

    procedure SetSales(NewSalesHeader: Record "Sales Header"; var NewCustLedgEntry: Record "Cust. Ledger Entry"; ApplnTypeSelect: Integer)
    var
        TotalAdjCostLCY: Decimal;
    begin
        SalesHeader := NewSalesHeader;
        Rec.CopyFilters(NewCustLedgEntry);

        SalesPost.SumSalesLines(
          SalesHeader, 0, TotalSalesLine, TotalSalesLineLCY,
          VATAmount, VATAmountText, ProfitLCY, ProfitPct, TotalAdjCostLCY);

        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::"Return Order",
          SalesHeader."Document Type"::"Credit Memo":
                ApplyingAmount := -TotalSalesLine."Amount Including VAT"
            else
                ApplyingAmount := TotalSalesLine."Amount Including VAT";
        end;

        ApplnDate := SalesHeader."Posting Date";
        ApplnCurrencyCode := SalesHeader."Currency Code";
        CalcType := CalcType::SalesHeader;

        case ApplnTypeSelect of
            SalesHeader.FieldNo("Applies-to Doc. No."):
                ApplnType := ApplnType::"Applies-to Doc. No.";
            SalesHeader.FieldNo("Applies-to ID"):
                ApplnType := ApplnType::"Applies-to ID";
        end;

        SetApplyingCustLedgEntry;
    end;

    procedure SetService(NewServHeader: Record "Service Header"; var NewCustLedgEntry: Record "Cust. Ledger Entry"; ApplnTypeSelect: Integer)
    var
        ServAmountsMgt: Codeunit "Serv-Amounts Mgt.";
        TotalAdjCostLCY: Decimal;
    begin
        ServHeader := NewServHeader;
        Rec.CopyFilters(NewCustLedgEntry);

        ServAmountsMgt.SumServiceLines(
          ServHeader, 0, TotalServLine, TotalServLineLCY,
          VATAmount, VATAmountText, ProfitLCY, ProfitPct, TotalAdjCostLCY);

        case ServHeader."Document Type" of
            ServHeader."Document Type"::"Credit Memo":
                ApplyingAmount := -TotalServLine."Amount Including VAT"
            else
                ApplyingAmount := TotalServLine."Amount Including VAT";
        end;

        ApplnDate := ServHeader."Posting Date";
        ApplnCurrencyCode := ServHeader."Currency Code";
        CalcType := CalcType::ServHeader;

        case ApplnTypeSelect of
            ServHeader.FieldNo("Applies-to Doc. No."):
                ApplnType := ApplnType::"Applies-to Doc. No.";
            ServHeader.FieldNo("Applies-to ID"):
                ApplnType := ApplnType::"Applies-to ID";
        end;

        SetApplyingCustLedgEntry;
    end;

    procedure SetApplyingCustLedgEntry()
    var
        "CustEntry-Edit": Codeunit "Cust. Entry-Edit";
    begin
        case CalcType of
            CalcType::SalesHeader:
                begin
                    ApplyingCustLedgEntry."Entry No." := 1;
                    ApplyingCustLedgEntry."Posting Date" := SalesHeader."Posting Date";
                    if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then
                        ApplyingCustLedgEntry."Document Type" := SalesHeader."Document Type"::"Credit Memo"
                    else
                        ApplyingCustLedgEntry."Document Type" := SalesHeader."Document Type";
                    ApplyingCustLedgEntry."Document No." := SalesHeader."No.";
                    ApplyingCustLedgEntry."Customer No." := SalesHeader."Bill-to Customer No.";
                    ApplyingCustLedgEntry.Description := SalesHeader."Posting Description";
                    ApplyingCustLedgEntry."Currency Code" := SalesHeader."Currency Code";
                    if ApplyingCustLedgEntry."Document Type" = ApplyingCustLedgEntry."Document Type"::"Credit Memo" then begin
                        ApplyingCustLedgEntry.Amount := -TotalSalesLine."Amount Including VAT";
                        ApplyingCustLedgEntry."Remaining Amount" := -TotalSalesLine."Amount Including VAT";
                    end else begin
                        ApplyingCustLedgEntry.Amount := TotalSalesLine."Amount Including VAT";
                        ApplyingCustLedgEntry."Remaining Amount" := TotalSalesLine."Amount Including VAT";
                    end;
                    CalcApplnAmount;
                end;
            CalcType::ServHeader:
                begin
                    ApplyingCustLedgEntry."Entry No." := 1;
                    ApplyingCustLedgEntry."Posting Date" := ServHeader."Posting Date";
                    ApplyingCustLedgEntry."Document Type" := ServHeader."Document Type";
                    ApplyingCustLedgEntry."Document No." := ServHeader."No.";
                    ApplyingCustLedgEntry."Customer No." := ServHeader."Bill-to Customer No.";
                    ApplyingCustLedgEntry.Description := ServHeader."Posting Description";
                    ApplyingCustLedgEntry."Currency Code" := ServHeader."Currency Code";
                    if ApplyingCustLedgEntry."Document Type" = ApplyingCustLedgEntry."Document Type"::"Credit Memo" then begin
                        ApplyingCustLedgEntry.Amount := -TotalServLine."Amount Including VAT";
                        ApplyingCustLedgEntry."Remaining Amount" := -TotalServLine."Amount Including VAT";
                    end else begin
                        ApplyingCustLedgEntry.Amount := TotalServLine."Amount Including VAT";
                        ApplyingCustLedgEntry."Remaining Amount" := TotalServLine."Amount Including VAT";
                    end;
                    CalcApplnAmount;
                end;
            CalcType::Direct:
                begin
                    if "Applying Entry" then begin
                        if ApplyingCustLedgEntry."Entry No." <> 0 then
                            CustLedgEntry := ApplyingCustLedgEntry;
                        "CustEntry-Edit".Run(Rec);
                        if "Applies-to ID" = '' then
                            SetCustApplId;
                        CalcFields(Amount);
                        ApplyingCustLedgEntry := Rec;
                        if CustLedgEntry."Entry No." <> 0 then begin
                            Rec := CustLedgEntry;
                            "Applying Entry" := false;
                            SetCustApplId;
                        end;
                        SetCurrentKey("Entry No.");
                        SetFilter("Entry No.", '<> %1', ApplyingCustLedgEntry."Entry No.");
                        ApplyingAmount := ApplyingCustLedgEntry."Remaining Amount";
                        ApplnDate := ApplyingCustLedgEntry."Posting Date";
                        ApplnCurrencyCode := ApplyingCustLedgEntry."Currency Code";
                    end else begin
                        Rec := ApplyingCustLedgEntry;
                        "Applying Entry" := false;
                        ApplyingCustLedgEntry.Init;
                        ApplyingCustLedgEntry."Entry No." := 0;
                        SetCustApplId;
                        ApplyingAmount := 0;
                        ApplnDate := 0D;
                        ApplnCurrencyCode := '';
                        SetRange("Entry No.");
                    end;
                    CalcApplnAmount;
                end;
            CalcType::GenJnlLine:
                begin
                    ApplyingCustLedgEntry."Entry No." := 1;
                    ApplyingCustLedgEntry."Posting Date" := GenJnlLine."Posting Date";
                    ApplyingCustLedgEntry."Document Type" := GenJnlLine."Document Type";
                    ApplyingCustLedgEntry."Document No." := GenJnlLine."Document No.";
                    ApplyingCustLedgEntry."Customer No." := GenJnlLine."Account No.";
                    ApplyingCustLedgEntry.Description := GenJnlLine.Description;
                    ApplyingCustLedgEntry."Currency Code" := GenJnlLine."Currency Code";
                    ApplyingCustLedgEntry.Amount := GenJnlLine.Amount;
                    ApplyingCustLedgEntry."Remaining Amount" := GenJnlLine.Amount;
                    CalcApplnAmount;
                end;
            CalcType::PDCReceipt:
                begin
                    ApplyingCustLedgEntry."Entry No." := 1;
                    ApplyingCustLedgEntry."Posting Date" := PDCReceipt."Document Date";
                    ApplyingCustLedgEntry."Document Type" := ApplyingCustLedgEntry."Document Type"::Payment;
                    ApplyingCustLedgEntry."Document No." := PDCReceipt.Code;
                    ApplyingCustLedgEntry."Customer No." := PDCReceipt."Customer No.";
                    ApplyingCustLedgEntry.Description := PDCReceipt.Name;
                    ApplyingCustLedgEntry."Currency Code" := PDCReceipt."Currency Code";
                    ApplyingCustLedgEntry.Amount := PDCReceipt.Amount;
                    ApplyingCustLedgEntry."Remaining Amount" := PDCReceipt.Amount;
                    CalcApplnAmount;
                end;
        end;
    end;

    procedure SetCustApplId()
    begin
        if ApplyingCustLedgEntry."Entry No." <> 0 then
            PDCReceiptApply.NewCheckAgainstApplnCurrency(
                ApplnCurrencyCode, "Currency Code", GenJnlLine."Account Type"::Customer, true);

        CustLedgEntry.Copy(Rec);
        CurrPage.SetSelectionFilter(CustLedgEntry);

        if PDCLineApply then
            CustEntrySetApplID.SetApplId(
              CustLedgEntry, ApplyingCustLedgEntry, PDCReceipt."Applies-to ID")
        else
            if CalcType = CalcType::SalesHeader then
                CustEntrySetApplID.SetApplId(
                  CustLedgEntry, ApplyingCustLedgEntry, SalesHeader."Applies-to ID")
            else
                CustEntrySetApplID.SetApplId(
                  CustLedgEntry, ApplyingCustLedgEntry, ServHeader."Applies-to ID");

        CalcApplnAmount;
    end;

    procedure CalcApplnAmount()
    var
        ExchAccGLJnlLine: Codeunit "Exchange Acc. G/L Journal Line";
        I: Integer;
        TempAppliedCustLedgEntry: Record "Cust. Ledger Entry" temporary;
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
                    CustEntryApplID := UserId;
                    if CustEntryApplID = '' then
                        CustEntryApplID := '***';

                    CustLedgEntry := ApplyingCustLedgEntry;

                    AppliedCustLedgEntry.SetCurrentKey("Customer No.", Open, Positive);
                    AppliedCustLedgEntry.SetRange("Customer No.", "Customer No.");
                    AppliedCustLedgEntry.SetRange(Open, true);
                    AppliedCustLedgEntry.SetRange("Applies-to ID", CustEntryApplID);

                    if ApplyingCustLedgEntry."Entry No." <> 0 then begin
                        CustLedgEntry.CalcFields("Remaining Amount");
                        AppliedCustLedgEntry.SetFilter("Entry No.", '<>%1', ApplyingCustLedgEntry."Entry No.");
                    end;

                    if AppliedCustLedgEntry.FindSet(false, false) then begin
                        repeat
                            TempAppliedCustLedgEntry := AppliedCustLedgEntry;
                            TempAppliedCustLedgEntry.Insert;
                        until AppliedCustLedgEntry.Next = 0;

                        CurrentAmount := CustLedgEntry."Remaining Amount";
                        PossiblePmtDisc := 0;

                        repeat
                            TempAppliedCustLedgEntry.SetRange(Positive, CurrentAmount < 0);
                            if TempAppliedCustLedgEntry.FindFirst then begin
                                TempAppliedCustLedgEntry.CalcFields("Remaining Amount");

                                if (CustLedgEntry."Currency Code" <> AppliedCustLedgEntry."Currency Code") and
                                  (ApplyingCustLedgEntry."Entry No." <> 0)
                                then begin
                                    if CustLedgEntry."Currency Code" <> '' then begin
                                        ToCurrency.Get(CustLedgEntry."Currency Code");
                                        TempAppliedCustLedgEntry."Remaining Amount" := Round(TempAppliedCustLedgEntry."Remaining Amount", ToCurrency."Amount Rounding Precision");
                                        TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible" := Round(TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible", ToCurrency."Amount Rounding Precision");
                                        TempAppliedCustLedgEntry."Amount to Apply" := Round(TempAppliedCustLedgEntry."Amount to Apply", ToCurrency."Amount Rounding Precision");
                                    end
                                    else begin
                                        TempAppliedCustLedgEntry."Remaining Amount" := Round(TempAppliedCustLedgEntry."Remaining Amount");
                                        TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible" := Round(TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible");
                                        TempAppliedCustLedgEntry."Amount to Apply" := Round(TempAppliedCustLedgEntry."Amount to Apply");
                                    end;
                                end;

                                if
                                  //GenJnlPostLine.CheckCalcPmtDiscCust(CustLedgEntry,TempAppliedCustLedgEntry,0,FALSE,FALSE) AND
                                  (Abs(TempAppliedCustLedgEntry."Amount to Apply") >= Abs(TempAppliedCustLedgEntry."Remaining Amount" -
                                  TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible")) then begin

                                    if (Abs(CurrentAmount - PossiblePmtDisc) > Abs(TempAppliedCustLedgEntry."Remaining Amount" -
                                      TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible"))
                                    then begin
                                        PmtDiscAmount := PmtDiscAmount + TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                                        CurrentAmount := CurrentAmount + TempAppliedCustLedgEntry."Remaining Amount" -
                                          TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                                    end else
                                        if (Abs(CurrentAmount - PossiblePmtDisc) = Abs(TempAppliedCustLedgEntry."Remaining Amount" -
                                 TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible"))
                               then begin
                                            PmtDiscAmount := PmtDiscAmount + TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible" + PossiblePmtDisc;
                                            CurrentAmount := CurrentAmount + TempAppliedCustLedgEntry."Remaining Amount" -
                                              TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible" - PossiblePmtDisc;
                                            PossiblePmtDisc := 0;
                                        end else begin
                                            if (CurrentAmount + TempAppliedCustLedgEntry."Remaining Amount" >= 0) <> (CurrentAmount >= 0) then begin
                                                PmtDiscAmount := PmtDiscAmount + PossiblePmtDisc;
                                                CurrentAmount := CurrentAmount - PossiblePmtDisc;
                                            end;
                                            CurrentAmount := CurrentAmount + TempAppliedCustLedgEntry."Remaining Amount";
                                            PossiblePmtDisc := TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                                        end;
                                end else begin
                                    if (CurrentAmount + TempAppliedCustLedgEntry."Amount to Apply" >= 0) <> (CurrentAmount >= 0) then begin
                                        PmtDiscAmount := PmtDiscAmount + PossiblePmtDisc;
                                        CurrentAmount := CurrentAmount - PossiblePmtDisc;
                                        PossiblePmtDisc := 0;
                                    end;
                                    CurrentAmount := CurrentAmount + TempAppliedCustLedgEntry."Amount to Apply";
                                end;
                            end else begin
                                TempAppliedCustLedgEntry.SetRange(Positive);
                                TempAppliedCustLedgEntry.FindFirst;
                            end;

                            AppliedAmount := AppliedAmount + TempAppliedCustLedgEntry."Amount to Apply";

                            if not DifferentCurrenciesInAppln then
                                DifferentCurrenciesInAppln := ApplnCurrencyCode <> TempAppliedCustLedgEntry."Currency Code";

                            TempAppliedCustLedgEntry.Delete;
                            TempAppliedCustLedgEntry.SetRange(Positive);

                        until not TempAppliedCustLedgEntry.FindFirst;
                        CheckRounding;
                    end;
                end;

            CalcType::GenJnlLine:
                begin
                    FindAmountRounding;
                    if GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer then
                        ExchAccGLJnlLine.Run(GenJnlLine);

                    case ApplnType of
                        ApplnType::"Applies-to Doc. No.":
                            begin
                                AppliedCustLedgEntry := Rec;
                                with AppliedCustLedgEntry do begin
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

                                    if
                                       //GenJnlPostLine.CheckCalcPmtDiscGenJnlCust(GenJnlLine,AppliedCustLedgEntry,0,FALSE) AND
                                       ((Abs(GenJnlLine.Amount) + ApplnRoundingPrecision >=
                                         Abs(AppliedAmount - "Remaining Pmt. Disc. Possible")) or
                                        (GenJnlLine.Amount = 0))
                                    then
                                        PmtDiscAmount := "Remaining Pmt. Disc. Possible";

                                    if not DifferentCurrenciesInAppln then
                                        DifferentCurrenciesInAppln := ApplnCurrencyCode <> "Currency Code";

                                end;
                                CheckRounding;
                            end;

                        ApplnType::"Applies-to ID":
                            begin
                                GenJnlLine2 := GenJnlLine;
                                AppliedCustLedgEntry.SetCurrentKey("Customer No.", Open, Positive);
                                AppliedCustLedgEntry.SetRange("Customer No.", GenJnlLine."Account No.");
                                AppliedCustLedgEntry.SetRange(Open, true);

                                if GenJnlLine."Applies-to ID" <> '' then
                                    AppliedCustLedgEntry.SetRange("Applies-to ID", GenJnlLine."Applies-to ID")
                                else
                                    if CalcType = CalcType::SalesHeader then
                                        AppliedCustLedgEntry.SetRange("Applies-to ID", SalesHeader."No.")
                                    else
                                        AppliedCustLedgEntry.SetRange("Applies-to ID", ServHeader."No.");

                                if AppliedCustLedgEntry.FindSet(false, false) then begin
                                    repeat
                                        TempAppliedCustLedgEntry := AppliedCustLedgEntry;
                                        TempAppliedCustLedgEntry.Insert;
                                    until AppliedCustLedgEntry.Next = 0;

                                    CurrentAmount := GenJnlLine2.Amount;
                                    PossiblePmtDisc := 0;

                                    repeat
                                        TempAppliedCustLedgEntry.SetRange(Positive, CurrentAmount < 0);
                                        if TempAppliedCustLedgEntry.FindFirst then begin
                                            TempAppliedCustLedgEntry.CalcFields("Remaining Amount");

                                            if (GenJnlLine2."Currency Code" <> TempAppliedCustLedgEntry."Currency Code") then begin
                                                /*
                                                TempAppliedCustLedgEntry."Remaining Amount" :=
                                                  GenJnlPostLine.ExchAmount(
                                                    TempAppliedCustLedgEntry."Remaining Amount",
                                                    TempAppliedCustLedgEntry."Currency Code",
                                                    GenJnlLine2."Currency Code",GenJnlLine2."Posting Date");
                                                TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible" :=
                                                  GenJnlPostLine.ExchAmount(
                                                    TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible",
                                                    TempAppliedCustLedgEntry."Currency Code",
                                                    GenJnlLine2."Currency Code",GenJnlLine2."Posting Date");
                                                TempAppliedCustLedgEntry."Amount to Apply" :=
                                                  GenJnlPostLine.ExchAmount(
                                                    TempAppliedCustLedgEntry."Amount to Apply",
                                                    TempAppliedCustLedgEntry."Currency Code",
                                                    GenJnlLine2."Currency Code",GenJnlLine2."Posting Date");
                                                    */
                                                if GenJnlLine2."Currency Code" <> '' then begin
                                                    ToCurrency.Get(GenJnlLine2."Currency Code");
                                                    TempAppliedCustLedgEntry."Remaining Amount" := Round(TempAppliedCustLedgEntry."Remaining Amount", ToCurrency."Amount Rounding Precision");
                                                    TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible" := Round(TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible", ToCurrency."Amount Rounding Precision");
                                                    TempAppliedCustLedgEntry."Amount to Apply" := Round(TempAppliedCustLedgEntry."Amount to Apply", ToCurrency."Amount Rounding Precision");
                                                end
                                                else begin
                                                    TempAppliedCustLedgEntry."Remaining Amount" := Round(TempAppliedCustLedgEntry."Remaining Amount");
                                                    TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible" := Round(TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible");
                                                    TempAppliedCustLedgEntry."Amount to Apply" := Round(TempAppliedCustLedgEntry."Amount to Apply");
                                                end;
                                            end;

                                            if
                                              //GenJnlPostLine.CheckCalcPmtDiscGenJnlCust(GenJnlLine2,TempAppliedCustLedgEntry,0,FALSE) AND
                                              (Abs(TempAppliedCustLedgEntry."Amount to Apply") >= Abs(TempAppliedCustLedgEntry."Remaining Amount" -
                                              TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible")) then begin

                                                if (Abs(CurrentAmount - PossiblePmtDisc) > Abs(TempAppliedCustLedgEntry."Remaining Amount" -
                                                  TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible"))
                                                then begin
                                                    PmtDiscAmount := PmtDiscAmount + TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                                                    CurrentAmount := CurrentAmount + TempAppliedCustLedgEntry."Remaining Amount" -
                                                      TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                                                end else
                                                    if (Abs(CurrentAmount - PossiblePmtDisc) = Abs(TempAppliedCustLedgEntry."Remaining Amount" -
                                             TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible"))
                                           then begin
                                                        PmtDiscAmount := PmtDiscAmount + TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible" + PossiblePmtDisc;
                                                        CurrentAmount := CurrentAmount + TempAppliedCustLedgEntry."Remaining Amount" -
                                                          TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible" - PossiblePmtDisc;
                                                        PossiblePmtDisc := 0;
                                                    end else begin
                                                        if (CurrentAmount + TempAppliedCustLedgEntry."Remaining Amount" >= 0) <> (CurrentAmount >= 0) then begin
                                                            PmtDiscAmount := PmtDiscAmount + PossiblePmtDisc;
                                                            CurrentAmount := CurrentAmount - PossiblePmtDisc;
                                                        end;
                                                        CurrentAmount := CurrentAmount + TempAppliedCustLedgEntry."Remaining Amount";
                                                        PossiblePmtDisc := TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                                                    end;
                                            end else begin
                                                if (CurrentAmount + TempAppliedCustLedgEntry."Amount to Apply" >= 0) <> (CurrentAmount >= 0) then begin
                                                    PmtDiscAmount := PmtDiscAmount + PossiblePmtDisc;
                                                    CurrentAmount := CurrentAmount - PossiblePmtDisc;
                                                    PossiblePmtDisc := 0;
                                                end;
                                                CurrentAmount := CurrentAmount + TempAppliedCustLedgEntry."Amount to Apply";
                                            end;
                                        end else begin
                                            TempAppliedCustLedgEntry.SetRange(Positive);
                                            TempAppliedCustLedgEntry.FindFirst;
                                        end;

                                        AppliedAmount := AppliedAmount + TempAppliedCustLedgEntry."Amount to Apply";

                                        if not DifferentCurrenciesInAppln then
                                            DifferentCurrenciesInAppln := ApplnCurrencyCode <> TempAppliedCustLedgEntry."Currency Code";

                                        TempAppliedCustLedgEntry.Delete;
                                        TempAppliedCustLedgEntry.SetRange(Positive);

                                    until not TempAppliedCustLedgEntry.FindFirst;

                                    CheckRounding;
                                end;
                            end;
                    end;
                end;

            CalcType::PDCReceipt:
                begin
                    FindAmountRounding;
                    case ApplnType of
                        ApplnType::"Applies-to ID":
                            begin
                                PDCReceipt2 := PDCReceipt;
                                AppliedCustLedgEntry.SetCurrentKey("Customer No.", Open, Positive);
                                AppliedCustLedgEntry.SetRange("Customer No.", PDCReceipt."Customer No.");
                                AppliedCustLedgEntry.SetRange(Open, true);

                                if PDCReceipt."Applies-to ID" <> '' then
                                    AppliedCustLedgEntry.SetRange("Applies-to ID", PDCReceipt."Applies-to ID")
                                else
                                    if CalcType = CalcType::SalesHeader then
                                        AppliedCustLedgEntry.SetRange("Applies-to ID", SalesHeader."No.")
                                    else
                                        AppliedCustLedgEntry.SetRange("Applies-to ID", ServHeader."No.");

                                if AppliedCustLedgEntry.FindSet(false, false) then begin
                                    repeat
                                        TempAppliedCustLedgEntry := AppliedCustLedgEntry;
                                        TempAppliedCustLedgEntry.Insert;
                                    until AppliedCustLedgEntry.Next = 0;

                                    CurrentAmount := PDCReceipt2.Amount;
                                    PossiblePmtDisc := 0;

                                    repeat
                                        TempAppliedCustLedgEntry.SetRange(Positive, CurrentAmount < 0);
                                        if TempAppliedCustLedgEntry.FindFirst then begin
                                            TempAppliedCustLedgEntry.CalcFields("Remaining Amount");

                                            if (PDCReceipt2."Currency Code" <> TempAppliedCustLedgEntry."Currency Code") then begin
                                                /*
                                                TempAppliedCustLedgEntry."Remaining Amount" :=
                                                  GenJnlPostLine.ExchAmount(
                                                    TempAppliedCustLedgEntry."Remaining Amount",
                                                    TempAppliedCustLedgEntry."Currency Code",
                                                    PDCReceipt2."Currency Code",PDCReceipt2."Document Date");
                                                TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible" :=
                                                  GenJnlPostLine.ExchAmount(
                                                    TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible",
                                                    TempAppliedCustLedgEntry."Currency Code",
                                                    PDCReceipt2."Currency Code",PDCReceipt2."Document Date");
                                                TempAppliedCustLedgEntry."Amount to Apply" :=
                                                  GenJnlPostLine.ExchAmount(
                                                    TempAppliedCustLedgEntry."Amount to Apply",
                                                    TempAppliedCustLedgEntry."Currency Code",
                                                    PDCReceipt2."Currency Code",PDCReceipt2."Document Date");
                                                    */
                                                if PDCReceipt2."Currency Code" <> '' then begin
                                                    ToCurrency.Get(PDCReceipt2."Currency Code");
                                                    TempAppliedCustLedgEntry."Remaining Amount" := Round(TempAppliedCustLedgEntry."Remaining Amount", ToCurrency."Amount Rounding Precision");
                                                    TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible" := Round(TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible", ToCurrency."Amount Rounding Precision");
                                                    TempAppliedCustLedgEntry."Amount to Apply" := Round(TempAppliedCustLedgEntry."Amount to Apply", ToCurrency."Amount Rounding Precision");
                                                end
                                                else begin
                                                    TempAppliedCustLedgEntry."Remaining Amount" := Round(TempAppliedCustLedgEntry."Remaining Amount");
                                                    TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible" := Round(TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible");
                                                    TempAppliedCustLedgEntry."Amount to Apply" := Round(TempAppliedCustLedgEntry."Amount to Apply");
                                                end;
                                            end;

                                            if (Abs(TempAppliedCustLedgEntry."Amount to Apply") >= Abs(TempAppliedCustLedgEntry."Remaining Amount" -
                                              TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible")) then begin

                                                if (Abs(CurrentAmount - PossiblePmtDisc) > Abs(TempAppliedCustLedgEntry."Remaining Amount" -
                                                  TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible"))
                                                then begin
                                                    PmtDiscAmount := PmtDiscAmount + TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                                                    CurrentAmount := CurrentAmount + TempAppliedCustLedgEntry."Remaining Amount" -
                                                      TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                                                end else
                                                    if (Abs(CurrentAmount - PossiblePmtDisc) = Abs(TempAppliedCustLedgEntry."Remaining Amount" -
                                             TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible"))
                                           then begin
                                                        PmtDiscAmount := PmtDiscAmount + TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible" + PossiblePmtDisc;
                                                        CurrentAmount := CurrentAmount + TempAppliedCustLedgEntry."Remaining Amount" -
                                                          TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible" - PossiblePmtDisc;
                                                        PossiblePmtDisc := 0;
                                                    end else begin
                                                        if (CurrentAmount + TempAppliedCustLedgEntry."Remaining Amount" >= 0) <> (CurrentAmount >= 0) then begin
                                                            PmtDiscAmount := PmtDiscAmount + PossiblePmtDisc;
                                                            CurrentAmount := CurrentAmount - PossiblePmtDisc;
                                                        end;
                                                        CurrentAmount := CurrentAmount + TempAppliedCustLedgEntry."Remaining Amount";
                                                        PossiblePmtDisc := TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                                                    end;
                                            end else begin
                                                if (CurrentAmount + TempAppliedCustLedgEntry."Amount to Apply" >= 0) <> (CurrentAmount >= 0) then begin
                                                    PmtDiscAmount := PmtDiscAmount + PossiblePmtDisc;
                                                    CurrentAmount := CurrentAmount - PossiblePmtDisc;
                                                    PossiblePmtDisc := 0;
                                                end;
                                                CurrentAmount := CurrentAmount + TempAppliedCustLedgEntry."Amount to Apply";
                                            end;
                                        end else begin
                                            TempAppliedCustLedgEntry.SetRange(Positive);
                                            TempAppliedCustLedgEntry.FindFirst;
                                        end;

                                        AppliedAmount := AppliedAmount + TempAppliedCustLedgEntry."Amount to Apply";

                                        if not DifferentCurrenciesInAppln then
                                            DifferentCurrenciesInAppln := ApplnCurrencyCode <> TempAppliedCustLedgEntry."Currency Code";

                                        TempAppliedCustLedgEntry.Delete;
                                        TempAppliedCustLedgEntry.SetRange(Positive);

                                    until not TempAppliedCustLedgEntry.FindFirst;

                                    CheckRounding;
                                end;
                            end;
                    end;
                end;

            CalcType::SalesHeader, CalcType::ServHeader:
                begin
                    FindAmountRounding;

                    case ApplnType of
                        ApplnType::"Applies-to Doc. No.":
                            begin
                                AppliedCustLedgEntry := Rec;
                                with AppliedCustLedgEntry do begin
                                    CalcFields("Remaining Amount");

                                    if "Currency Code" <> ApplnCurrencyCode then
                                        "Remaining Amount" :=
                                          CurrExchRate.ExchangeAmtFCYToFCY(
                                            ApplnDate, "Currency Code", ApplnCurrencyCode, "Remaining Amount");

                                    AppliedAmount := Round("Remaining Amount", AmountRoundingPrecision);

                                    if not DifferentCurrenciesInAppln then
                                        DifferentCurrenciesInAppln := ApplnCurrencyCode <> "Currency Code";

                                end;
                                CheckRounding;
                            end;

                        ApplnType::"Applies-to ID":
                            begin
                                AppliedCustLedgEntry.SetCurrentKey("Customer No.", Open, Positive);
                                if CalcType = CalcType::SalesHeader then
                                    AppliedCustLedgEntry.SetRange("Customer No.", SalesHeader."Bill-to Customer No.")
                                else
                                    AppliedCustLedgEntry.SetRange("Customer No.", ServHeader."Bill-to Customer No.");
                                AppliedCustLedgEntry.SetRange(Open, true);

                                if CalcType = CalcType::SalesHeader then
                                    if SalesHeader."Applies-to ID" <> '' then
                                        AppliedCustLedgEntry.SetRange("Applies-to ID", SalesHeader."Applies-to ID")
                                    else
                                        AppliedCustLedgEntry.SetRange("Applies-to ID", SalesHeader."No.")
                                else
                                    if ServHeader."Applies-to ID" <> '' then
                                        AppliedCustLedgEntry.SetRange("Applies-to ID", ServHeader."Applies-to ID")
                                    else
                                        AppliedCustLedgEntry.SetRange("Applies-to ID", ServHeader."No.");

                                for I := 1 to 2 do begin
                                    if GenJnlLine.Amount <> 0 then begin
                                        if I = 1 then
                                            AppliedCustLedgEntry.SetRange(Positive, GenJnlLine.Amount > 0)
                                        else
                                            AppliedCustLedgEntry.SetRange(Positive, GenJnlLine.Amount < 0);
                                    end
                                    else
                                        I := 2;

                                    with AppliedCustLedgEntry do begin
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

    procedure CalcApplnRemainingAmount(Amount: Decimal): Decimal
    var
        ApplnRemainingAmount: Decimal;
    begin
        ValidExchRate := true;
        if ApplnCurrencyCode = "Currency Code" then
            exit(Amount);

        if ApplnDate = 0D then
            ApplnDate := "Posting Date";
        ApplnRemainingAmount :=
          CurrExchRate.ApplnExchangeAmtFCYToFCY(
            ApplnDate, "Currency Code", ApplnCurrencyCode, Amount, ValidExchRate);
        exit(ApplnRemainingAmount);
    end;

    procedure CalcApplnAmounttoApply(AmounttoApply: Decimal): Decimal
    var
        ApplnAmounttoApply: Decimal;
    begin
        ValidExchRate := true;

        if ApplnCurrencyCode = "Currency Code" then
            exit(AmounttoApply);

        if ApplnDate = 0D then
            ApplnDate := "Posting Date";
        ApplnAmounttoApply :=
          CurrExchRate.ApplnExchangeAmtFCYToFCY(
            ApplnDate, "Currency Code", ApplnCurrencyCode, AmounttoApply, ValidExchRate);
        exit(ApplnAmounttoApply);
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
            CalcType::SalesHeader, CalcType::ServHeader:
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

    procedure GetCustLedgEntry(var CustLedgEntry: Record "Cust. Ledger Entry")
    begin
        CustLedgEntry := Rec;
    end;

    procedure FindApplyingEntry()
    begin
        if CalcType = CalcType::Direct then begin
            CustEntryApplID := UserId;
            if CustEntryApplID = '' then
                CustEntryApplID := '***';

            CustLedgEntry.SetCurrentKey("Customer No.", "Applies-to ID", Open);
            CustLedgEntry.SetRange("Customer No.", "Customer No.");
            CustLedgEntry.SetRange("Applies-to ID", CustEntryApplID);
            CustLedgEntry.SetRange(Open, true);
            CustLedgEntry.SetRange("Applying Entry", true);
            if CustLedgEntry.Find('-') then begin
                CustLedgEntry.CalcFields(Amount, "Remaining Amount");
                ApplyingCustLedgEntry := CustLedgEntry;
                SetCurrentKey("Entry No.");
                SetFilter("Entry No.", '<> %1', CustLedgEntry."Entry No.");
                ApplyingAmount := CustLedgEntry."Remaining Amount";
                ApplnDate := CustLedgEntry."Posting Date";
                ApplnCurrencyCode := CustLedgEntry."Currency Code";
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

    local procedure ShowAppliedEntriesOnPush()
    begin
        if ShowAppliedEntries then begin
            if CalcType = CalcType::GenJnlLine then
                SetRange("Applies-to ID", GenJnlLine."Applies-to ID")
            else begin
                CustEntryApplID := UserId;
                if CustEntryApplID = '' then
                    CustEntryApplID := '***';
                SetRange("Applies-to ID", CustEntryApplID);
            end;
        end else
            SetRange("Applies-to ID");
    end;

    local procedure LookupOKOnPush()
    begin
        OKPressed := true;
    end;

    local procedure fnOnAfterGetCurrRecord()
    begin
        //xRec := Rec;
        //IF ApplnType = ApplnType::"Applies-to Doc. No." THEN
        //  CalcApplnAmount;
        xRec := Rec;
        editbool := true;
        if CalcType = CalcType::GenJnlLine then
            CalcApplnAmount;
        AmtToApply := 0;    //MS.20191012
    end;
}

