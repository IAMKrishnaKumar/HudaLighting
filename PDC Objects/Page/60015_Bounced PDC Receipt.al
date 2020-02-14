page 60015 "Bounced PDC Receipt"
{
    // Code           Date        Name        Desc.
    // APNT-LCPDC1.0  20.05.12    Monica      Created New.
    // APNT-LCPDC1.1  07.06.12    Monica      Added Code.
    // MS.20191001    01.10.19    MS          code added to fine tune "Source Code" in G/L Register

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    Permissions = TableData "Cust. Ledger Entry" = rim;
    SourceTable = "PDC Receipt";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Code)
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Customer No."; "Customer No.")
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
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Control1000000016; '')
                {
                    CaptionClass = Text19063386;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = TRUE;
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
                field(Control1000000107; '')
                {
                    CaptionClass = Text19059481;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Bank City"; "Bank City")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field(Control1000000030; '')
                {
                    CaptionClass = Text19004241;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = TRUE;
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
                field(Control1000000108; '')
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
                field("Deposit Date"; "Deposit Date")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    AutoFormatType = 1;
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Control1000000109; '')
                {
                    CaptionClass = Text19019971;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("PDC Deposit Bank No."; "PDC Deposit Bank No.")
                {
                    ApplicationArea = All;
                }
                field("Deposit Bank Name"; "Deposit Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Deposit Bank Address 1"; "Deposit Bank Address 1")
                {
                    ApplicationArea = All;
                }
                field("Deposit Bank Address 2"; "Deposit Bank Address 2")
                {
                    ApplicationArea = All;
                }
                field("Deposit Bank Post Code"; "Deposit Bank Post Code")
                {
                    ApplicationArea = All;
                }
                field("Deposit Bank City"; "Deposit Bank City")
                {
                    ApplicationArea = All;
                }
                field("Deposit Bank Country Code"; "Deposit Bank Country Code")
                {
                    ApplicationArea = All;
                }
                field("Deposit Bank Branch No."; "Deposit Bank Branch No.")
                {
                    ApplicationArea = All;
                }
                field("Deposit Bank Account No."; "Deposit Bank Account No.")
                {
                    ApplicationArea = All;
                }
                field("Deposit Bank Currency Code"; "Deposit Bank Currency Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&PDCs")
            {
                Caption = '&PDCs';
                action("&Dimensions")
                {
                    Caption = '&Dimensions';
                    Image = Dimensions;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ShowDimensions();
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                separator(Separator1000000070)
                {

                }
                action("&Apply Entries")
                {
                    Caption = '&Apply Entries';
                    Image = ApplyEntries;
                    ShortCutKey = 'Shift+F11';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        PDCReceipt.COPY(Rec);

                        WITH PDCReceipt DO BEGIN
                            //IF "Reference Type" = "Reference Type"::"2" THEN BEGIN
                            GetCurrency;
                            AccType := AccType::Customer;
                            AccNo := "Customer No.";
                            CASE AccType OF
                                AccType::Customer:
                                    BEGIN
                                        CLEAR(ApplyCustEntries);
                                        CustLedgEntry.SETCURRENTKEY("Customer No.", Open, Positive);
                                        CustLedgEntry.SETRANGE("Customer No.", AccNo);
                                        CustLedgEntry.SETRANGE(Open, TRUE);
                                        CustLedgEntry.SETRANGE("Applies-to ID");
                                        IF "Applies-to ID" = '' THEN
                                            "Applies-to ID" := Code;
                                        IF "Applies-to ID" = '' THEN
                                            ERROR(Text000, FIELDCAPTION("Applies-to ID"));
                                        ApplyCustEntries.SetPDCLine(PDCReceipt, PDCReceipt.FIELDNO("Applies-to ID"));
                                        ApplyCustEntries.SETRECORD(CustLedgEntry);
                                        ApplyCustEntries.SETTABLEVIEW(CustLedgEntry);
                                        ApplyCustEntries.LOOKUPMODE(TRUE);
                                        OK := ApplyCustEntries.RUNMODAL = ACTION::LookupOK;
                                        CLEAR(ApplyCustEntries);
                                        IF NOT OK THEN
                                            EXIT;

                                        CustLedgEntry.RESET;
                                        CustLedgEntry.SETCURRENTKEY("Customer No.", Open, Positive);
                                        CustLedgEntry.SETRANGE("Customer No.", AccNo);
                                        CustLedgEntry.SETRANGE(Open, TRUE);
                                        CustLedgEntry.SETRANGE("Applies-to ID", Code);
                                        IF CustLedgEntry.FIND('-') THEN BEGIN
                                            CurrencyCode2 := CustLedgEntry."Currency Code";
                                            IF Amount = 0 THEN BEGIN
                                                PDCAppliedAmt.RESET;
                                                PDCAppliedAmt.SETRANGE("PDC No.", "Applies-to ID");
                                                IF PDCAppliedAmt.FIND('-') THEN
                                                    PDCAppliedAmt.DELETEALL;

                                                REPEAT
                                                    NewCheckAgainstApplnCurrency(CurrencyCode2, CustLedgEntry."Currency Code", AccType::Customer, TRUE);
                                                    CustLedgEntry.CALCFIELDS("Remaining Amount");
                                                    CustLedgEntry."Remaining Amount" :=
                                                      ROUND(CustLedgEntry."Remaining Amount", Currency."Amount Rounding Precision");
                                                    CustLedgEntry."Remaining Pmt. Disc. Possible" :=
                                                      ROUND(CustLedgEntry."Remaining Pmt. Disc. Possible", Currency."Amount Rounding Precision");
                                                    CustLedgEntry."Amount to Apply" :=
                                                      ROUND(CustLedgEntry."Amount to Apply", Currency."Amount Rounding Precision");

                                                    IF CheckCalcPmtDiscPDCReceiptCust(Rec, CustLedgEntry, 0, FALSE) AND
                                                      (ABS(CustLedgEntry."Amount to Apply") >=
                                                      ABS(CustLedgEntry."Remaining Amount" - CustLedgEntry."Remaining Pmt. Disc. Possible"))
                                                    THEN
                                                        Amount := Amount - (CustLedgEntry."Amount to Apply" - CustLedgEntry."Remaining Pmt. Disc. Possible")
                                                    ELSE
                                                        Amount := Amount - CustLedgEntry."Amount to Apply";

                                                    GLSetup.GET;
                                                    PDCAppliedAmt.INIT;
                                                    PDCAppliedAmt."PDC No." := "Applies-to ID";
                                                    PDCAppliedAmt."Transaction Type" := PDCAppliedAmt."Transaction Type"::Sales;
                                                    IF CustLedgEntry."Document Type" = CustLedgEntry."Document Type"::Invoice THEN
                                                        PDCAppliedAmt."Document Type" := PDCAppliedAmt."Document Type"::Invoice;
                                                    PDCAppliedAmt."No." := CustLedgEntry."Document No.";
                                                    PDCAppliedAmt."Currency Code" := "Currency Code";
                                                    IF "Currency Code" = GLSetup."LCY Code" THEN BEGIN
                                                        PDCAppliedAmt."Amount (LCY)" := ApplyCustEntries.CalcApplnAmounttoApply(CustLedgEntry."Amount to Apply");
                                                        PDCAppliedAmt.Amount := ROUND(CustLedgEntry."Amount to Apply", CustLedgEntry."Original Currency Factor");
                                                    END ELSE BEGIN
                                                        PDCAppliedAmt.Amount := ApplyCustEntries.CalcApplnAmounttoApply(CustLedgEntry."Amount to Apply");
                                                        PDCAppliedAmt."Amount (LCY)" := ROUND(PDCAppliedAmt.Amount);
                                                    END;
                                                    PDCAppliedAmt.INSERT;
                                                UNTIL CustLedgEntry.NEXT = 0;
                                                VALIDATE(Amount);
                                            END ELSE
                                                REPEAT
                                                    NewCheckAgainstApplnCurrency(CurrencyCode2, CustLedgEntry."Currency Code", AccType::Customer, TRUE);
                                                UNTIL CustLedgEntry.NEXT = 0;
                                            IF "Currency Code" <> CurrencyCode2 THEN
                                                IF Amount = 0 THEN BEGIN
                                                    IF NOT
                                                       CONFIRM(
                                                         Text001 +
                                                         Text002, TRUE,
                                                         FIELDCAPTION("Currency Code"), TABLECAPTION, "Currency Code",
                                                         CustLedgEntry."Currency Code")
                                                    THEN
                                                        ERROR(Text003);
                                                    "Currency Code" := CustLedgEntry."Currency Code"
                                                END ELSE
                                                    NewCheckAgainstApplnCurrency("Currency Code", CustLedgEntry."Currency Code", AccType::Customer, TRUE);
                                            "Applies-to Doc. No." := '';
                                        END ELSE BEGIN
                                            "Applies-to ID" := '';
                                            Amount := 0;
                                            CLEAR(ApplyCustEntries);
                                        END;
                                        MODIFY;
                                    END;
                            END;
                            //END;

                            /*IF "Reference Type" = "Reference Type"::Invoice THEN BEGIN
                              IF "Cheque No." = '' THEN
                                ERROR(Text000,FIELDCAPTION("Cheque No."));
                              IF "Cheque Date" = 0D THEN
                                ERROR(Text000,FIELDCAPTION("Cheque Date"));

                              IF "Currency Code" = '' THEN
                                Currency.InitRoundingPrecision
                              ELSE BEGIN
                                Currency.GET("Currency Code");
                                Currency.TESTFIELD("Amount Rounding Precision");
                              END;

                              SalesOrders.RESET;
                              SalesOrders.SETRANGE(SalesOrders."Document Type",SalesOrders."Document Type"::Order);
                              SalesOrders.SETFILTER(SalesOrders."Sell-to Customer No.","Customer No.");
                              //SalesOrders.SETFILTER(SalesOrders."Order Amount",'<>%1',0);
                              IF SalesOrders.FIND('-') THEN;

                              ApplyOrderEntries.SetPDCJnlLine(Rec);
                              ApplyOrderEntries.SETRECORD(SalesOrders);
                              ApplyOrderEntries.SETTABLEVIEW(SalesOrders);
                              ApplyOrderEntries.LOOKUPMODE(TRUE);
                              IF ApplyOrderEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                PDCAppliedAmt.RESET;
                                PDCAppliedAmt.SETRANGE("PDC No.",Code);
                                IF PDCAppliedAmt.FIND('-') THEN
                                  PDCAppliedAmt.DELETEALL;

                                CLEAR(ApplyOrderEntries);
                                CLEAR(OrderAmt);
                                SalesOrders1.RESET;
                                SalesOrders1.SETFILTER(SalesOrders1."Applies-to ID for PDC",Code);
                                IF SalesOrders1.FIND('-') THEN BEGIN
                                  REPEAT
                                    //SalesOrders1.CALCFIELDS("Order Amount");
                                    GLSetup.GET;
                                    PDCAppliedAmt.INIT;
                                    PDCAppliedAmt."PDC No." := Code;
                                    PDCAppliedAmt."Transaction Type" := PDCAppliedAmt."Transaction Type"::Sales;
                                    PDCAppliedAmt."Document Type" := PDCAppliedAmt."Document Type"::Order;
                                    PDCAppliedAmt."No." := SalesOrders1."No.";
                                    PDCAppliedAmt."Currency Code" := "Currency Code";
                                    IF "Currency Code" = GLSetup."LCY Code" THEN BEGIN
                                      PDCAppliedAmt."Amount (LCY)" := ApplyCustEntries.CalcApplnAmounttoApply(CustLedgEntry."Amount to Apply");
                                      PDCAppliedAmt.Amount := ROUND(CustLedgEntry."Amount to Apply",CustLedgEntry."Original Currency Factor");
                                    END ELSE BEGIN
                                    //PDCAppliedAmt.Amount := ApplyCustEntries.CalcApplnAmounttoApply(SalesOrders1."Order Amount");
                                    PDCAppliedAmt."Amount (LCY)" := ROUND(PDCAppliedAmt.Amount);
                                    END;
                                    PDCAppliedAmt.INSERT;
                                    OrderAmt := OrderAmt + ApplyOrderEntries.CalcApplnRemainingAmount(SalesOrders1."Remaining Amount");
                                    CLEAR(ApplyOrderEntries);
                                  UNTIL SalesOrders1.NEXT = 0;
                                  IF Amount = 0 THEN
                                    Amount := OrderAmt;
                                  "Applies-to ID" := Code;
                                  MODIFY;
                                END ELSE BEGIN
                                  CLEAR(ApplyOrderEntries);
                                  Amount := 0;
                                  "Applies-to ID" := '';
                                  "Applies-to Doc. No." := '';
                                  MODIFY;
                                END;
                              END;
                            END;*/

                        END;
                        Rec := PDCReceipt;

                    end;
                }
                separator(Separator1000000106)
                {

                }
                action("<Action1000000072>")
                {
                    Caption = '&Deposited';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Status = Status::Received THEN
                            EXIT;
                        IF CONFIRM('Do you want to Deposit PDC: ' + Code) THEN
                            DepositPDC(Rec);
                    end;
                }
                action("&Bounced")
                {
                    Caption = '&Bounced';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Status = Status::Deposited THEN
                            EXIT;
                        IF CONFIRM('Do you want to change status to Bounced ?') THEN
                            BouncePDC(Rec);
                    end;
                }
                action("<Action1000000108>")
                {
                    Caption = 'Update Deposit Date';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Dlg: Dialog;
                        DepositDate: Date;
                        DepositDateInput: Report "Input Date";
                    begin
                        TESTFIELD(Status, Status::Received);
                        //APNT-1.1 -
                        /*
                        //Commented Old Code
                        Dlg.OPEN('Deposit Date : #1###########');
                        Dlg.INPUT(1,DepositDate);
                        */
                        CLEAR(DepositDateInput);
                        DepositDateInput.RUNMODAL;
                        IF DepositDateInput.GetDepositDate <> 0D THEN
                            DepositDate := DepositDateInput.GetDepositDate;
                        //APNT-1.1 +

                        IF DepositDate < "Cheque Date" THEN
                            ERROR('%1 cannot be lesser then %2.', FIELDCAPTION("Deposit Date"), FIELDCAPTION("Cheque Date"));
                        "Deposit Date" := DepositDate;
                        MODIFY;

                    end;
                }
                action("&Return")
                {
                    Caption = '&Return';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Status = Status::Bounced THEN
                            EXIT;
                        IF CONFIRM('Do you want to change status to Returned ?') THEN
                            ReturnPDC(Rec);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action(Post)
                {
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you want to post PDC ?') THEN
                            PostPDC(Rec);
                    end;
                }
                action("Print PDC Voucher")
                {
                    Caption = 'Print PDC Voucher';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        recPDCReceipt.RESET;
                        recPDCReceipt.SETRANGE(Code, Code);
                        REPORT.RUN(50012, TRUE, FALSE, recPDCReceipt);
                    end;
                }
            }
        }
    }

    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        SalesOrders: Record "Sales Header";
        Currency: Record Currency;
        GLSetup: Record "General Ledger Setup";
        PDCReceipt: Record "PDC Receipt";
        GenJnlLine: Record "Gen. Journal Line";
        PDCAppliedAmt: Record "PDC Applied Amount";
        SalesOrders1: Record "Sales Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvLines: Record "Sales Invoice Line";
        DefaultDim: Record "Default Dimension";
        GenJnlTemplate: Record "Gen. Journal Template";
        CurrencyExcRate: Record "Currency Exchange Rate";
        GenJnlBatch: Record "Gen. Journal Batch";
        ApplyCustEntries1: Page "Apply Cust. Ledger Entries";
        ApplyCustEntries: Page "Apply Cust. Ledger Entries";
        // ApplyOrderEntries: Page "Apply Sale Orders";
        Text000: Label 'The %1 should be filled in';
        Text001: Label 'The %1 in the %2 will be changed from %3 to %4.\';
        Text002: Label 'Do you wish to continue?';
        Text003: Label 'The update has been interrupted to respect the warning.';
        Text006: Label 'All entries in one application must be in the same currency.';
        Text007: Label 'All entries in one application must be in the same currency or one or more of the EMU currencies. ';
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        AppliesToID: Code[20];
        OK: Boolean;
        CurrencyCode2: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        PDCApplAmount: Decimal;
        InvAmt: Decimal;
        TempAmt: Decimal;
        AccNo: Code[20];
        OrderAmt: Decimal;
        Window: Dialog;
        recPDCReceipt: Record "PDC Receipt";
        DateBounced: Date;
        DateReturned: Date;
        Text19063386: Label 'Customer Bank Details';
        Text19059481: Label 'Status';
        Text19004241: Label 'Application';
        Text19079450: Label 'Cheque Details';
        Text19019971: Label 'Deposit Bank Details';
    //[RunOnClient]
    //Window1: DotNet Interaction;

    procedure CheckAgainstApplnCurrency(ApplnCurrencyCode: Code[10]; CompareCurrencyCode: Code[10]; AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset"; Message: Boolean): Boolean
    var
        Currency: Record Currency;
        Currency2: Record Currency;
        SalesSetup: Record "Sales & Receivables Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        CurrencyAppln: Option No,EMU,All;
    begin
        IF (ApplnCurrencyCode = CompareCurrencyCode) THEN
            EXIT(TRUE);

        CASE AccType OF
            AccType::Customer:
                BEGIN
                    SalesSetup.GET;
                    CurrencyAppln := SalesSetup."Appln. between Currencies";
                    CASE CurrencyAppln OF
                        CurrencyAppln::No:
                            BEGIN
                                IF ApplnCurrencyCode <> CompareCurrencyCode THEN
                                    IF Message THEN
                                        ERROR(Text006)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                        CurrencyAppln::EMU:
                            BEGIN
                                GLSetup.GET;
                                IF NOT Currency.GET(ApplnCurrencyCode) THEN
                                    Currency."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency2.GET(CompareCurrencyCode) THEN
                                    Currency2."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency."EMU Currency" OR NOT Currency2."EMU Currency" THEN
                                    IF Message THEN
                                        ERROR(Text007)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                    END;
                END;
            AccType::Vendor:
                BEGIN
                    PurchSetup.GET;
                    CurrencyAppln := PurchSetup."Appln. between Currencies";
                    CASE CurrencyAppln OF
                        CurrencyAppln::No:
                            BEGIN
                                IF ApplnCurrencyCode <> CompareCurrencyCode THEN
                                    IF Message THEN
                                        ERROR(Text006)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                        CurrencyAppln::EMU:
                            BEGIN
                                GLSetup.GET;
                                IF NOT Currency.GET(ApplnCurrencyCode) THEN
                                    Currency."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency2.GET(CompareCurrencyCode) THEN
                                    Currency2."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency."EMU Currency" OR NOT Currency2."EMU Currency" THEN
                                    IF Message THEN
                                        ERROR(Text007)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                    END;
                END;
        END;
        EXIT(TRUE);
    end;

    procedure CheckCalcPmtDiscGenJnlCust(GenJnlLine: Record "Gen. Journal Line"; OldCustLedgEntry2: Record "Cust. Ledger Entry"; ApplnRoundingPrecision: Decimal; CheckAmount: Boolean): Boolean
    var
        NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        OldCVLedgEntryBuf2: Record "CV Ledger Entry Buffer";
    begin
        NewCVLedgEntryBuf."Document Type" := NewCVLedgEntryBuf."Document Type"::Invoice;
        NewCVLedgEntryBuf."Posting Date" := "Cheque Date";
        NewCVLedgEntryBuf."Remaining Amount" := Amount;
        //<LT> Commented the code - PDC Upgrade
        //GenJnlPostLine.TransferCustLedgEntry(OldCVLedgEntryBuf2,OldCustLedgEntry2,TRUE);
        OldCustLedgEntry2.CopyFromCVLedgEntryBuffer(OldCVLedgEntryBuf2);
        //EXIT(GenJnlPostLine.CheckCalcPmtDisc(NewCVLedgEntryBuf,OldCVLedgEntryBuf2,ApplnRoundingPrecision,FALSE,CheckAmount));
        //</LT>
    end;

    procedure InsertJnlLineDim(var PDCRcpt: Record "PDC Receipt"; var GenJnlLine: Record "Gen. Journal Line")
    var
        GLSetup: Record "General Ledger Setup";
        DefaultDim: Record "Default Dimension";
    begin
        //<LT> Commented the code - PDC Upgrade
        /*GLSetup.GET;
        IF GLSetup."Shortcut Dimension 1 Code" <> '' THEN BEGIN
          IF DocDim.GET(DATABASE::"PDC Receipt",DocDim."Document Type"::" ",Code,0,
                        GLSetup."Shortcut Dimension 1 Code") THEN BEGIN
            GenJnlLine."Shortcut Dimension 1 Code" := DocDim."Dimension Value Code";
            JnlLineDim.INIT;
            JnlLineDim."Table ID" := DATABASE::"Gen. Journal Line";
            JnlLineDim."Journal Template Name" := GenJnlLine."Journal Template Name";
            JnlLineDim."Journal Batch Name" := GenJnlLine."Journal Batch Name";
            JnlLineDim."Journal Line No." := GenJnlLine."Line No.";
            JnlLineDim."Allocation Line No." := 0;
            JnlLineDim."Dimension Code" := GLSetup."Shortcut Dimension 1 Code";
            JnlLineDim."Dimension Value Code" := DocDim."Dimension Value Code";
            JnlLineDim.INSERT;
          END;
        END;
        
        IF GLSetup."Shortcut Dimension 2 Code" <> '' THEN BEGIN
          IF DocDim.GET(DATABASE::"PDC Receipt",DocDim."Document Type"::" ",Code,0,
                        GLSetup."Shortcut Dimension 2 Code") THEN BEGIN
            GenJnlLine."Shortcut Dimension 2 Code" := DocDim."Dimension Value Code";
            JnlLineDim.INIT;
            JnlLineDim."Table ID" := DATABASE::"Gen. Journal Line";
            JnlLineDim."Journal Template Name" := GenJnlLine."Journal Template Name";
            JnlLineDim."Journal Batch Name" := GenJnlLine."Journal Batch Name";
            JnlLineDim."Journal Line No." := GenJnlLine."Line No.";
            JnlLineDim."Allocation Line No." := 0;
            JnlLineDim."Dimension Code" := GLSetup."Shortcut Dimension 2 Code";
            JnlLineDim."Dimension Value Code" := DocDim."Dimension Value Code";
            JnlLineDim.INSERT;
          END;
        END;
        */
        //</LT>

    end;

    procedure NewCheckAgainstApplnCurrency(ApplnCurrencyCode: Code[10]; CompareCurrencyCode: Code[10]; AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset"; Message: Boolean): Boolean
    var
        Currency: Record Currency;
        Currency2: Record Currency;
        SalesSetup: Record "Sales & Receivables Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        CurrencyAppln: Option No,EMU,All;
    begin
        IF (ApplnCurrencyCode = CompareCurrencyCode) THEN
            EXIT(TRUE);

        CASE AccType OF
            AccType::Customer:
                BEGIN
                    SalesSetup.GET;
                    CurrencyAppln := SalesSetup."Appln. between Currencies";
                    CASE CurrencyAppln OF
                        CurrencyAppln::No:
                            BEGIN
                                IF ApplnCurrencyCode <> CompareCurrencyCode THEN
                                    IF Message THEN
                                        ERROR(Text006)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                        CurrencyAppln::EMU:
                            BEGIN
                                GLSetup.GET;
                                IF NOT Currency.GET(ApplnCurrencyCode) THEN
                                    Currency."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency2.GET(CompareCurrencyCode) THEN
                                    Currency2."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency."EMU Currency" OR NOT Currency2."EMU Currency" THEN
                                    IF Message THEN
                                        ERROR(Text007)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                    END;
                END;
            AccType::Vendor:
                BEGIN
                    PurchSetup.GET;
                    CurrencyAppln := PurchSetup."Appln. between Currencies";
                    CASE CurrencyAppln OF
                        CurrencyAppln::No:
                            BEGIN
                                IF ApplnCurrencyCode <> CompareCurrencyCode THEN
                                    IF Message THEN
                                        ERROR(Text006)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                        CurrencyAppln::EMU:
                            BEGIN
                                GLSetup.GET;
                                IF NOT Currency.GET(ApplnCurrencyCode) THEN
                                    Currency."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency2.GET(CompareCurrencyCode) THEN
                                    Currency2."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency."EMU Currency" OR NOT Currency2."EMU Currency" THEN
                                    IF Message THEN
                                        ERROR(Text007)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                    END;
                END;
        END;

        EXIT(TRUE);
    end;

    procedure GetCurrency()
    begin
        WITH PDCReceipt DO BEGIN
            IF "Currency Code" = '' THEN
                Currency.InitRoundingPrecision
            ELSE BEGIN
                Currency.GET("Currency Code");
                Currency.TESTFIELD("Amount Rounding Precision");
            END;
        END;
    end;

    procedure CheckCalcPmtDiscPDCReceiptCust(PDCReceipt: Record "PDC Receipt"; OldCustLedgEntry2: Record "Cust. Ledger Entry"; ApplnRoundingPrecision: Decimal; CheckAmount: Boolean): Boolean
    var
        NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        OldCVLedgEntryBuf2: Record "CV Ledger Entry Buffer";
    begin
        NewCVLedgEntryBuf."Document Type" := NewCVLedgEntryBuf."Document Type"::Payment;
        NewCVLedgEntryBuf."Posting Date" := PDCReceipt."Document Date";
        NewCVLedgEntryBuf."Remaining Amount" := PDCReceipt.Amount;
        //<LT> Commented the code - PDC Upgrade
        //GenJnlPostLine.TransferCustLedgEntry(OldCVLedgEntryBuf2,OldCustLedgEntry2,TRUE);
        OldCustLedgEntry2.CopyFromCVLedgEntryBuffer(OldCVLedgEntryBuf2);
        /*EXIT(
          GenJnlPostLine.CheckCalcPmtDisc(
            NewCVLedgEntryBuf,OldCVLedgEntryBuf2,ApplnRoundingPrecision,FALSE,CheckAmount));*/
        //</LT>

    end;

    procedure SetUpNewLine(var GenJnlLineRec: Record "Gen. Journal Line"; Balance: Decimal; BottomLine: Boolean)
    begin
        WITH GenJnlLineRec DO BEGIN
            GenJnlTemplate.GET("Journal Template Name");
            GenJnlBatch.GET("Journal Template Name", "Journal Batch Name");
            IF GenJnlBatch."No. Series" <> '' THEN BEGIN
                CLEAR(NoSeriesMgt);
                "Document No." := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", Rec."Document Date", FALSE);
            END;
            "Source Code" := GenJnlTemplate."Source Code";
            "Reason Code" := GenJnlBatch."Reason Code";
            "Posting No. Series" := GenJnlBatch."Posting No. Series";
            Description := '';
        END;
    end;

    procedure DepositPDC(var PDCReceipt: Record "PDC Receipt")
    var
        Customer: Record Customer;
        CustomerPostingGrp: Record "Customer Posting Group";
    begin
        WITH PDCReceipt DO BEGIN
            VALIDATE(Status, Status::Received);
            MODIFY;
            TESTFIELD("PDC Deposit Bank No.");
            GLSetup.GET();
            GLSetup.TESTFIELD("PDC Receipt Template");
            GLSetup.TESTFIELD("PDC Receipt Batch");
            Customer.GET("Customer No.");
            Customer.TESTFIELD("Customer Posting Group");
            CustomerPostingGrp.GET(Customer."Customer Posting Group");
            CustomerPostingGrp.TESTFIELD("PDC Receipt Account");

            Window.OPEN('Depositing PDC  #1#######################\' +
                        'Status          #2#######################\' +
                        'Document No.    #3#######################');
            Window.UPDATE(1, Code);

            IF "Reference Type" = "Reference Type"::Invoice THEN BEGIN
                PDCAppliedAmt.RESET;
                PDCAppliedAmt.SETRANGE("Transaction Type", PDCAppliedAmt."Transaction Type"::Sales);
                PDCAppliedAmt.SETRANGE("Document Type", PDCAppliedAmt."Document Type"::Invoice);
                PDCAppliedAmt.SETRANGE("PDC No.", Code);
                PDCAppliedAmt.SETRANGE(Amount, 0);
                PDCAppliedAmt.DELETEALL;

                Window.UPDATE(2, 'Checking applied entries');
                PDCAppliedAmt.RESET;
                PDCAppliedAmt.SETRANGE("Transaction Type", PDCAppliedAmt."Transaction Type"::Sales);
                PDCAppliedAmt.SETRANGE("Document Type", PDCAppliedAmt."Document Type"::Invoice);
                PDCAppliedAmt.SETRANGE("PDC No.", Code);
                PDCAppliedAmt.SETFILTER(Amount, '<>%1', 0);
                IF PDCAppliedAmt.FIND('-') THEN
                    REPEAT
                        CustLedgEntry.RESET;
                        CustLedgEntry.SETRANGE("Document Type", CustLedgEntry."Document Type"::Invoice);
                        CustLedgEntry.SETFILTER("Document No.", PDCAppliedAmt."No.");
                        IF CustLedgEntry.FIND('-') THEN BEGIN
                            Window.UPDATE(3, CustLedgEntry."Document No.");
                            CustLedgEntry."Applies-to ID" := PDCAppliedAmt."PDC No.";
                            CustLedgEntry.MODIFY;
                        END;
                    UNTIL PDCAppliedAmt.NEXT = 0;

                GenJnlLine.RESET;
                GenJnlLine.SETRANGE("Journal Template Name", GLSetup."PDC Receipt Template");
                GenJnlLine.SETRANGE("Journal Batch Name", GLSetup."PDC Receipt Batch");
                GenJnlLine.DELETEALL(TRUE);

                Window.UPDATE(2, 'Inserting Entries');
                GenJnlLine.INIT;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Receipt Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Receipt Batch");
                GenJnlLine."Line No." += 10000;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlTemplate.GET(GLSetup."PDC Receipt Template");
                GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
                GenJnlLine."Document No." := Code;
                GenJnlLine.VALIDATE("Posting Date", "Document Date");
                GenJnlLine.INSERT(TRUE);

                GenJnlLine."Document Date" := "Document Date";
                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Customer);
                GenJnlLine.VALIDATE("Account No.", "Customer No.");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, Amount);
                GenJnlLine.VALIDATE("Applies-to ID", Code);
                //>>MS.20191001 - original code commented
                //GenJnlLine."Source Code" := "Customer No.";
                //<<MS.20191001 - original code commented

                //>>MS.20191001 - new code added
                GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
                //<<MS.20191001 - new code added
                // GenJnlLine."Cheque No." := "Cheque No.";
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine."Check Date" := "Cheque Date";//TRI SAM
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                // GenJnlLine."Cheque Date" := "Cheque Date";//TRI SAM
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                GenJnlLine."PDC Entry" := TRUE;
                GenJnlLine.Description := Remarks;
                GenJnlLine.MODIFY;

                GenJnlLine.INIT;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Receipt Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Receipt Batch");
                GenJnlLine."Line No." += 10000;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlTemplate.GET(GLSetup."PDC Receipt Template");
                GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
                GenJnlLine."Document No." := Code;
                GenJnlLine.VALIDATE("Posting Date", "Document Date");
                GenJnlLine.INSERT(TRUE);

                GenJnlLine."Document Date" := "Document Date";
                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                GenJnlLine.VALIDATE("Account No.", CustomerPostingGrp."PDC Receipt Account");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, -Amount);
                //GenJnlLine.VALIDATE("Applies-to ID",Code);
                GenJnlLine.Narration := Remarks;
                //>>MS.20191001 - original code commented
                //GenJnlLine."Source Code" := "Customer No.";
                //<<MS.20191001 - original code commented

                //>>MS.20191001 - new code added
                GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
                //<<MS.20191001 - new code added
                // GenJnlLine."Cheque No." := "Cheque No.";
                // GenJnlLine."Cheque Date" := "Cheque Date";//TRI SAM
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine."Check Date" := "Cheque Date";//TRI SAM
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Deposit Bank Dim1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Deposit Bank Dim2 Code");
                GenJnlLine."PDC Entry" := TRUE;
                GenJnlLine.Description := Remarks;
                GenJnlLine.MODIFY;
                Window.UPDATE(2, 'Posting Entries');
                CLEAR(GenJnlPostBatch);
                GenJnlPostBatch.RUN(GenJnlLine);
                CLEAR(GenJnlPostBatch); //APNT-LCPDC1.1
                PDCAppliedAmt.RESET;
                PDCAppliedAmt.SETFILTER("PDC No.", Code);
                IF PDCAppliedAmt.FIND('-') THEN
                    REPEAT
                        PDCAppliedAmt.Posted := TRUE;
                        PDCAppliedAmt.MODIFY;
                    UNTIL PDCAppliedAmt.NEXT = 0;
            END;

            IF "Reference Type" = "Reference Type"::" " THEN BEGIN
                GenJnlLine.RESET;
                GenJnlLine.SETRANGE("Journal Template Name", GLSetup."PDC Receipt Template");
                GenJnlLine.SETRANGE("Journal Batch Name", GLSetup."PDC Receipt Batch");
                GenJnlLine.DELETEALL(TRUE);

                GLSetup.GET;
                Window.UPDATE(2, 'Inserting Entries');
                GenJnlLine.INIT;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Receipt Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Receipt Batch");
                GenJnlLine."Line No." += 10000;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := Code;
                GenJnlLine.VALIDATE("Posting Date", "Document Date");
                GenJnlLine.INSERT(TRUE);

                GenJnlLine."Document Date" := "Document Date";
                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Customer);
                GenJnlLine.VALIDATE("Account No.", "Customer No.");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlTemplate.GET(GLSetup."PDC Receipt Template");
                GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
                GenJnlLine.VALIDATE(Amount, Amount);
                GenJnlLine.Narration := Remarks;
                //>>MS.20191001 - original code commented
                //GenJnlLine."Source Code" := "Customer No.";
                //<<MS.20191001 - original code commented

                //>>MS.20191001 - new code added
                GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
                //<<MS.20191001 - new code added

                // GenJnlLine."Cheque No." := "Cheque No.";
                // GenJnlLine."Cheque Date" := "Cheque Date";//TRI SAM
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine."Check Date" := "Cheque Date";//TRI SAM
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                GenJnlLine."PDC Entry" := TRUE;
                GenJnlLine.Description := Remarks;
                GenJnlLine.MODIFY;

                GenJnlLine.INIT;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Receipt Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Receipt Batch");
                GenJnlLine."Line No." += 10000;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := Code;
                GenJnlLine.VALIDATE("Posting Date", "Document Date");
                GenJnlLine.INSERT(TRUE);

                GenJnlLine."Document Date" := "Document Date";
                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                GenJnlLine.VALIDATE("Account No.", CustomerPostingGrp."PDC Receipt Account");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlTemplate.GET(GLSetup."PDC Receipt Template");
                GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
                GenJnlLine.VALIDATE(Amount, -Amount);
                GenJnlLine.Narration := Remarks;
                GenJnlLine."Source Code" := "Customer No.";
                // GenJnlLine."Cheque No." := "Cheque No.";
                // GenJnlLine."Cheque Date" := "Cheque Date";//TRI SAM
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine."Check Date" := "Cheque Date";//TRI SAM
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Deposit Bank Dim1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Deposit Bank Dim2 Code");
                GenJnlLine."PDC Entry" := TRUE;
                GenJnlLine.Description := Remarks;
                GenJnlLine.MODIFY;
                Window.UPDATE(2, 'Posting Entries');
                CLEAR(GenJnlPostBatch);
                GenJnlPostBatch.RUN(GenJnlLine);
                CLEAR(GenJnlPostBatch); //APNT-LCPDC1.1
            END;
            Window.CLOSE;
        END;
    end;

    procedure BouncePDC(var PDCReceipt: Record "PDC Receipt")
    var
        Customer: Record Customer;
        CustomerPostingGrp: Record "Customer Posting Group";
        BouncedDateText: Text;
    begin
        WITH PDCReceipt DO BEGIN
            VALIDATE(Status, Status::Deposited);
            MODIFY;
            TESTFIELD("PDC Deposit Bank No.");
            GLSetup.GET();
            GLSetup.TESTFIELD("PDC Receipt Template");
            GLSetup.TESTFIELD("PDC Receipt Batch");
            Customer.GET("Customer No.");
            Customer.TESTFIELD("Customer Posting Group");
            CustomerPostingGrp.GET(Customer."Customer Posting Group");
            CustomerPostingGrp.TESTFIELD("PDC Receipt Account");

            CLEAR(DateBounced);
            //Window.OPEN('Bounced Date : #1###########');
            //Window.INPUT(1,DateBounced);
            //BouncedDateText := Window1.InputBox('Bounced Date:', 'INPUT', '', 50, 50);  //TempMS commented
            //EVALUATE(DateBounced, BouncedDateText);   //TempMS commented


            IF DateBounced < "Document Date" THEN BEGIN
                //Window.CLOSE;
                ERROR('Bounced Date cannot be lesser than %1.', "Document Date");
            END;
            //ELSE
            //  Window.CLOSE;

            IF DateBounced = 0D THEN
                EXIT;

            Window.OPEN('Posting Bounce  #1#######################\' +
                        'Status          #2#######################');
            Window.UPDATE(1, Code);

            //IF "Reference Type" = "Reference Type"::"2" THEN BEGIN
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE("Journal Template Name", GLSetup."PDC Receipt Template");
            GenJnlLine.SETRANGE("Journal Batch Name", GLSetup."PDC Receipt Batch");
            GenJnlLine.DELETEALL(TRUE);

            Window.UPDATE(2, 'Inserting Entries');
            GenJnlLine.INIT;
            GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Receipt Template");
            GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Receipt Batch");
            GenJnlLine."Line No." += 10000;
            GenJnlTemplate.GET(GLSetup."PDC Receipt Template");
            GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
            GenJnlLine."Document No." := Code;
            GenJnlLine.VALIDATE("Posting Date", DateBounced);
            GenJnlLine.INSERT(TRUE);

            GenJnlLine."Document Date" := DateBounced;
            GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Customer);
            GenJnlLine.VALIDATE("Account No.", "Customer No.");
            GenJnlLine.VALIDATE("Currency Code", "Currency Code");
            GenJnlLine.VALIDATE(Amount, -Amount);
            GenJnlLine.Description := 'Bounced';
            GenJnlLine."Source Code" := "Customer No.";
            // GenJnlLine."Cheque No." := "Cheque No.";
            // GenJnlLine."Cheque Date" := "Cheque Date";//TRI SAM
            GenJnlLine."Check No." := "Cheque No.";
            GenJnlLine."Check Date" := "Cheque Date";//TRI SAM
            GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
            GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
            GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
            GenJnlLine."PDC Entry" := TRUE;
            GenJnlLine.MODIFY;

            GenJnlLine.INIT;
            GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Receipt Template");
            GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Receipt Batch");
            GenJnlLine."Line No." += 10000;
            GenJnlTemplate.GET(GLSetup."PDC Receipt Template");
            GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
            GenJnlLine."Document No." := Code;
            GenJnlLine.VALIDATE("Posting Date", DateBounced);
            GenJnlLine.INSERT(TRUE);

            GenJnlLine."Document Date" := DateBounced;
            GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
            GenJnlLine.VALIDATE("Account No.", CustomerPostingGrp."PDC Receipt Account");
            GenJnlLine.VALIDATE("Currency Code", "Currency Code");
            GenJnlLine.VALIDATE(Amount, Amount);
            GenJnlLine.Description := 'Bounced';
            GenJnlLine."Source Code" := "Customer No.";
            // GenJnlLine."Cheque No." := "Cheque No.";
            // GenJnlLine."Cheque Date" := "Cheque Date";//TRI SAM
            GenJnlLine."Check No." := "Cheque No.";
            GenJnlLine."Check Date" := "Cheque Date";//TRI SAM
            GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
            GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Deposit Bank Dim1 Code");
            GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Deposit Bank Dim2 Code");
            GenJnlLine."PDC Entry" := TRUE;
            GenJnlLine.MODIFY;
            Window.UPDATE(2, 'Posting Entries');
            CLEAR(GenJnlPostBatch);
            GenJnlPostBatch.RUN(GenJnlLine);
            CLEAR(GenJnlPostBatch); //APNT-LCPDC1.1
            PDCAppliedAmt.RESET;
            PDCAppliedAmt.SETFILTER("PDC No.", Code);
            IF PDCAppliedAmt.FIND('-') THEN
                REPEAT
                    PDCAppliedAmt.Posted := FALSE;
                    PDCAppliedAmt.MODIFY;
                UNTIL PDCAppliedAmt.NEXT = 0;
            //END;

            /*IF "Reference Type" = "Reference Type"::" " THEN BEGIN
              GenJnlLine.RESET;
              GenJnlLine.SETRANGE("Journal Template Name",GLSetup."PDC Receipt Template");
              GenJnlLine.SETRANGE("Journal Batch Name",GLSetup."PDC Receipt Batch");
              GenJnlLine.DELETEALL(TRUE);

              GLSetup.GET;
              Window.UPDATE(2,'Inserting Entries');
              GenJnlLine.INIT;
              GenJnlLine.VALIDATE("Journal Template Name",GLSetup."PDC Receipt Template");
              GenJnlLine.VALIDATE("Journal Batch Name",GLSetup."PDC Receipt Batch");
              GenJnlLine."Line No." += 10000;
              GenJnlLine."Document No." := Code;
              GenJnlLine.VALIDATE("Posting Date",DateBounced);
              GenJnlLine.INSERT(TRUE);

              GenJnlLine."Document Date" := DateBounced;
              GenJnlLine.VALIDATE("Account Type",GenJnlLine."Account Type"::Customer);
              GenJnlLine.VALIDATE("Account No.","Customer No.");
              GenJnlLine.VALIDATE("Currency Code","Currency Code");
              GenJnlTemplate.GET(GLSetup."PDC Receipt Template");
              GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
              GenJnlLine.VALIDATE(Amount,-Amount);
              GenJnlLine.Description := 'Bounced';
              GenJnlLine."Source Code" := "Customer No.";
              GenJnlLine."Cheque No." := "Cheque No.";
              GenJnlLine."Cheque Date" := "Cheque Date";//TRI SAM
              GenJnlLine.VALIDATE("Shortcut Dimension 1 Code","Shortcut Dimension 1 Code");
              GenJnlLine.VALIDATE("Shortcut Dimension 2 Code","Shortcut Dimension 2 Code");
              GenJnlLine."PDC Entry" := TRUE;
              GenJnlLine.MODIFY;

              GenJnlLine.INIT;
              GenJnlLine.VALIDATE("Journal Template Name",GLSetup."PDC Receipt Template");
              GenJnlLine.VALIDATE("Journal Batch Name",GLSetup."PDC Receipt Batch");
              GenJnlLine."Line No." += 10000;
              GenJnlLine."Document No." := Code;
              GenJnlLine.VALIDATE("Posting Date",DateBounced);
              GenJnlLine.INSERT(TRUE);

              GenJnlLine."Document Date" := DateBounced;
              GenJnlLine.VALIDATE("Account Type",GenJnlLine."Account Type"::"G/L Account");
              GenJnlLine.VALIDATE("Account No.",CustomerPostingGrp."PDC Receipt Account");
              GenJnlLine.VALIDATE("Currency Code","Currency Code");
              GenJnlTemplate.GET(GLSetup."PDC Receipt Template");
              GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
              GenJnlLine.VALIDATE(Amount,Amount);
              GenJnlLine.Description := 'Bounced';
              GenJnlLine."Source Code" := "Customer No.";
              GenJnlLine."Cheque No." := "Cheque No.";
              GenJnlLine."Cheque Date" := "Cheque Date";//TRI SAM
              GenJnlLine.VALIDATE("Shortcut Dimension 1 Code","Deposit Bank Dim1 Code");
              GenJnlLine.VALIDATE("Shortcut Dimension 2 Code","Deposit Bank Dim2 Code");
              GenJnlLine."PDC Entry" := TRUE;
              GenJnlLine.MODIFY;
              Window.UPDATE(2,'Posting Entries');
              CLEAR(GenJnlPostBatch);
              GenJnlPostBatch.RUN(GenJnlLine);
              CLEAR(GenJnlPostBatch); //APNT-LCPDC1.1
            END;*/
            Window.CLOSE;
        END;

    end;

    procedure ReturnPDC(var PDCReceipt: Record "PDC Receipt")
    var
        Customer: Record Customer;
        CustomerPostingGrp: Record "Customer Posting Group";
        DateReturnedText: Text;
    begin
        WITH PDCReceipt DO BEGIN
            VALIDATE(Status, Status::Bounced);
            MODIFY;
            TESTFIELD("PDC Deposit Bank No.");
            GLSetup.GET();
            GLSetup.TESTFIELD("PDC Receipt Template");
            GLSetup.TESTFIELD("PDC Receipt Batch");
            Customer.GET("Customer No.");
            Customer.TESTFIELD("Customer Posting Group");
            CustomerPostingGrp.GET(Customer."Customer Posting Group");
            CustomerPostingGrp.TESTFIELD("PDC Receipt Account");

            CLEAR(DateReturned);
            //DateReturnedText := Window1.InputBox('Returned Date:', 'INPUT', '', 50, 50);  //TempMS commneted
            EVALUATE(DateReturned, DateReturnedText);
            //Window.OPEN('Returned Date : #1###########');
            //Window.INPUT(1,DateReturned);
            IF DateReturned < "Document Date" THEN BEGIN
                //Window.CLOSE;
                ERROR('Returned Date cannot be lesser than %1.', "Document Date");
            END;
            //ELSE
            //  Window.CLOSE;

            IF DateReturned = 0D THEN
                EXIT;

            Window.OPEN('Posting Return  #1#######################\' +
                        'Status          #2#######################');
            Window.UPDATE(1, Code);

            // IF "Reference Type" = "Reference Type"::"2" THEN BEGIN
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE("Journal Template Name", GLSetup."PDC Receipt Template");
            GenJnlLine.SETRANGE("Journal Batch Name", GLSetup."PDC Receipt Batch");
            GenJnlLine.DELETEALL(TRUE);

            Window.UPDATE(2, 'Inserting Entries');
            GenJnlLine.INIT;
            GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Receipt Template");
            GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Receipt Batch");
            GenJnlLine."Line No." += 10000;
            GenJnlTemplate.GET(GLSetup."PDC Receipt Template");
            GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
            GenJnlLine."Document No." := Code;
            GenJnlLine.VALIDATE("Posting Date", DateReturned);
            GenJnlLine.INSERT(TRUE);

            GenJnlLine."Document Date" := DateReturned;
            GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Customer);
            GenJnlLine.VALIDATE("Account No.", "Customer No.");
            GenJnlLine.VALIDATE("Currency Code", "Currency Code");
            GenJnlLine.VALIDATE(Amount, -Amount);
            GenJnlLine.Description := 'Returned';
            GenJnlLine."Source Code" := "Customer No.";
            // GenJnlLine."Cheque No." := "Cheque No.";
            // GenJnlLine."Cheque Date" := "Cheque Date";//TRI SAM
            GenJnlLine."Check No." := "Cheque No.";
            GenJnlLine."Check Date" := "Cheque Date";//TRI SAM
            GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
            GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
            GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
            GenJnlLine."PDC Entry" := TRUE;
            GenJnlLine.MODIFY;

            GenJnlLine.INIT;
            GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Receipt Template");
            GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Receipt Batch");
            GenJnlLine."Line No." += 10000;
            GenJnlTemplate.GET(GLSetup."PDC Receipt Template");
            GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
            GenJnlLine."Document No." := Code;
            GenJnlLine.VALIDATE("Posting Date", DateReturned);
            GenJnlLine.INSERT(TRUE);

            GenJnlLine."Document Date" := DateReturned;
            GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
            GenJnlLine.VALIDATE("Account No.", CustomerPostingGrp."PDC Receipt Account");
            GenJnlLine.VALIDATE("Currency Code", "Currency Code");
            GenJnlLine.VALIDATE(Amount, Amount);
            GenJnlLine.Description := 'Returned';
            GenJnlLine."Source Code" := "Customer No.";
            // GenJnlLine."Cheque No." := "Cheque No.";
            // GenJnlLine."Cheque Date" := "Cheque Date";//TRI SAM
            GenJnlLine."Check No." := "Cheque No.";
            GenJnlLine."Check Date" := "Cheque Date";//TRI SAM
            GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
            GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Deposit Bank Dim1 Code");
            GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Deposit Bank Dim2 Code");
            GenJnlLine."PDC Entry" := TRUE;
            GenJnlLine.MODIFY;
            Window.UPDATE(2, 'Posting Entries');
            CLEAR(GenJnlPostBatch);
            GenJnlPostBatch.RUN(GenJnlLine);
            CLEAR(GenJnlPostBatch); //APNT-LCPDC1.1
            PDCAppliedAmt.RESET;
            PDCAppliedAmt.SETFILTER("PDC No.", Code);
            IF PDCAppliedAmt.FIND('-') THEN
                REPEAT
                    PDCAppliedAmt.Posted := FALSE;
                    PDCAppliedAmt.MODIFY;
                UNTIL PDCAppliedAmt.NEXT = 0;
            //END;

            /*IF "Reference Type" = "Reference Type"::" " THEN BEGIN
              GenJnlLine.RESET;
              GenJnlLine.SETRANGE("Journal Template Name",GLSetup."PDC Receipt Template");
              GenJnlLine.SETRANGE("Journal Batch Name",GLSetup."PDC Receipt Batch");
              GenJnlLine.DELETEALL(TRUE);

              GLSetup.GET;
              Window.UPDATE(2,'Inserting Entries');
              GenJnlLine.INIT;
              GenJnlLine.VALIDATE("Journal Template Name",GLSetup."PDC Receipt Template");
              GenJnlLine.VALIDATE("Journal Batch Name",GLSetup."PDC Receipt Batch");
              GenJnlLine."Line No." += 10000;
              GenJnlLine."Document No." := Code;
              GenJnlLine.VALIDATE("Posting Date",DateReturned);
              GenJnlLine.INSERT(TRUE);

              GenJnlLine."Document Date" := DateReturned;
              GenJnlLine.VALIDATE("Account Type",GenJnlLine."Account Type"::Customer);
              GenJnlLine.VALIDATE("Account No.","Customer No.");
              GenJnlLine.VALIDATE("Currency Code","Currency Code");
              GenJnlTemplate.GET(GLSetup."PDC Receipt Template");
              GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
              GenJnlLine.VALIDATE(Amount,-Amount);
              GenJnlLine.Description := 'Returned';
              GenJnlLine."Source Code" := "Customer No.";
              GenJnlLine."Cheque No." := "Cheque No.";
              GenJnlLine."Cheque Date" := "Cheque Date";//TRI SAM
              GenJnlLine.VALIDATE("Shortcut Dimension 1 Code","Shortcut Dimension 1 Code");
              GenJnlLine.VALIDATE("Shortcut Dimension 2 Code","Shortcut Dimension 2 Code");
              GenJnlLine."PDC Entry" := TRUE;
              GenJnlLine.MODIFY;

              GenJnlLine.INIT;
              GenJnlLine.VALIDATE("Journal Template Name",GLSetup."PDC Receipt Template");
              GenJnlLine.VALIDATE("Journal Batch Name",GLSetup."PDC Receipt Batch");
              GenJnlLine."Line No." += 10000;
              GenJnlLine."Document No." := Code;
              GenJnlLine.VALIDATE("Posting Date",DateReturned);
              GenJnlLine.INSERT(TRUE);

              GenJnlLine."Document Date" := DateReturned;
              GenJnlLine.VALIDATE("Account Type",GenJnlLine."Account Type"::"G/L Account");
              GenJnlLine.VALIDATE("Account No.",CustomerPostingGrp."PDC Receipt Account");
              GenJnlLine.VALIDATE("Currency Code","Currency Code");
              GenJnlTemplate.GET(GLSetup."PDC Receipt Template");
              GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
              GenJnlLine.VALIDATE(Amount,Amount);
              GenJnlLine.Description := 'Returned';
              GenJnlLine."Source Code" := "Customer No.";
              GenJnlLine."Cheque No." := "Cheque No.";
              GenJnlLine."Cheque Date" := "Cheque Date";//TRI SAM
              GenJnlLine.VALIDATE("Shortcut Dimension 1 Code","Deposit Bank Dim1 Code");
              GenJnlLine.VALIDATE("Shortcut Dimension 2 Code","Deposit Bank Dim2 Code");
              GenJnlLine."PDC Entry" := TRUE;
              GenJnlLine.MODIFY;
              Window.UPDATE(2,'Posting Entries');
              CLEAR(GenJnlPostBatch);
              GenJnlPostBatch.RUN(GenJnlLine);
              CLEAR(GenJnlPostBatch); //APNT-LCPDC1.1
            END;*/
            Window.CLOSE;
        END;

    end;

    procedure PostPDC(var PDCReceipt: Record "PDC Receipt")
    var
        Customer: Record Customer;
        CustomerPostingGrp: Record "Customer Posting Group";
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntryCopy: Record "Cust. Ledger Entry";
    begin
        WITH PDCReceipt DO BEGIN
            TESTFIELD("Deposit Date");//TRI SAM 150516
            TESTFIELD(Status, Status::Received);
            TESTFIELD("PDC Deposit Bank No.");
            GLSetup.GET();
            GLSetup.TESTFIELD("PDC Receipt Template");
            GLSetup.TESTFIELD("PDC Receipt Batch");
            Customer.GET("Customer No.");
            Customer.TESTFIELD("Customer Posting Group");
            CustomerPostingGrp.GET(Customer."Customer Posting Group");
            CustomerPostingGrp.TESTFIELD("PDC Receipt Account");

            Window.OPEN('Posting PDC #1#######################\' +
                        'Status      #2#######################');
            Window.UPDATE(1, Code);

            IF "Reference Type" = "Reference Type"::Invoice THEN BEGIN
                Window.UPDATE(2, 'Inserting Journals');
                GenJnlLine.RESET;
                GenJnlLine.SETRANGE("Journal Template Name", GLSetup."PDC Receipt Template");
                GenJnlLine.SETRANGE("Journal Batch Name", GLSetup."PDC Receipt Batch");
                GenJnlLine.DELETEALL(TRUE);

                GenJnlLine.INIT;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Receipt Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Receipt Batch");
                GenJnlLine."Line No." += 10000;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlTemplate.GET(GLSetup."PDC Receipt Template");
                GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
                GenJnlLine."Document No." := Code;
                //GenJnlLine.VALIDATE("Cheque Date", "Cheque Date");
                //GenJnlLine."Cheque Date" := "Cheque Date";//TRI SAM
                GenJnlLine."Check Date" := "Cheque Date";//TRI SAM
                GenJnlLine.VALIDATE("Posting Date", "Deposit Date");//TRI SAM 150516
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                GenJnlLine.VALIDATE("Account No.", CustomerPostingGrp."PDC Receipt Account");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, Amount);
                GenJnlLine.Narration := Remarks;
                //>>MS.20191001 - original code commented
                //GenJnlLine."Source Code" := "Customer No.";
                //<<MS.20191001 - original code commented

                //>>MS.20191001 - new code added
                GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
                //<<MS.20191001 - new code added
                // GenJnlLine."Cheque No." := "Cheque No.";
                // GenJnlLine."Cheque Date" := "Cheque Date";//TRI SAM
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine."Check Date" := "Cheque Date";//TRI SAM
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Deposit Bank Dim1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Deposit Bank Dim2 Code");
                GenJnlLine.Description := Remarks;
                GenJnlLine.MODIFY;

                GenJnlLine.INIT;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Receipt Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Receipt Batch");
                GenJnlLine."Line No." += 10000;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlTemplate.GET(GLSetup."PDC Receipt Template");
                GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
                GenJnlLine."Document No." := Code;
                //GenJnlLine.VALIDATE("Cheque Date", "Cheque Date");
                GenJnlLine.VALIDATE("Check Date", "Cheque Date");
                GenJnlLine.VALIDATE("Posting Date", "Deposit Date");///TRI SAM 150516
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"Bank Account");
                GenJnlLine.VALIDATE("Account No.", "PDC Deposit Bank No.");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, -Amount);
                GenJnlLine.Narration := Remarks;
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                //>>MS.20191001 - original code commented
                //GenJnlLine."Source Code" := "Customer No.";
                //<<MS.20191001 - original code commented

                //>>MS.20191001 - new code added
                GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
                //<<MS.20191001 - new code added
                // GenJnlLine."Cheque No." := "Cheque No.";
                // GenJnlLine."Cheque Date" := "Cheque Date";//TRI SAM
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine."Check Date" := "Cheque Date";//TRI SAM
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Deposit Bank Dim1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Deposit Bank Dim2 Code");
                GenJnlLine.Description := Remarks;
                GenJnlLine.MODIFY;
                Window.UPDATE(2, 'Posting Journals');
                CLEAR(GenJnlPostBatch);
                GenJnlPostBatch.RUN(GenJnlLine);
                CLEAR(GenJnlPostBatch); //APNT-LCPDC1.1
                "Posting Date" := TODAY;
                Status := Status::Deposited;//TRI SAM 150516
                Posted := TRUE;
                "Date Cleared" := TODAY;
                Cleared := TRUE;
                MODIFY;
            END;

            IF "Reference Type" = "Reference Type"::" " THEN BEGIN
                Window.UPDATE(2, 'Inserting Journals');
                GenJnlLine.RESET;
                GenJnlLine.SETRANGE("Journal Template Name", GLSetup."PDC Receipt Template");
                GenJnlLine.SETRANGE("Journal Batch Name", GLSetup."PDC Receipt Batch");
                GenJnlLine.DELETEALL(TRUE);

                GenJnlLine.INIT;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Receipt Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Receipt Batch");
                GenJnlLine."Line No." += 10000;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := Code;
                // GenJnlLine.VALIDATE("Cheque Date", "Cheque Date");
                GenJnlLine.VALIDATE("Check Date", "Cheque Date");
                GenJnlLine.VALIDATE("Posting Date", "Deposit Date");///TRI SAM 150516
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                GenJnlLine.VALIDATE("Account No.", CustomerPostingGrp."PDC Receipt Account");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, Amount);
                GenJnlLine.Narration := Remarks;
                //>>MS.20191001 - original code commented
                //GenJnlLine."Source Code" := "Customer No.";
                //<<MS.20191001 - original code commented

                //>>MS.20191001 - new code added
                GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
                //<<MS.20191001 - new code added
                // GenJnlLine."Cheque No." := "Cheque No.";
                // GenJnlLine."Cheque Date" := "Cheque Date";//TRI SAM
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                GenJnlLine."Check Date" := "Cheque Date";//TRI SAM
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Deposit Bank Dim1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Deposit Bank Dim2 Code");
                GenJnlLine.Description := Remarks;
                GenJnlLine.MODIFY;

                GenJnlLine.INIT;
                GenJnlLine.VALIDATE("Journal Template Name", GLSetup."PDC Receipt Template");
                GenJnlLine.VALIDATE("Journal Batch Name", GLSetup."PDC Receipt Batch");
                GenJnlLine."Line No." += 10000;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := Code;
                // GenJnlLine.VALIDATE("Cheque Date", "Cheque Date");
                // GenJnlLine."Cheque Date" := "Cheque Date";//TRI SAM
                GenJnlLine.VALIDATE("Check Date", "Cheque Date");
                GenJnlLine."Check Date" := "Cheque Date";//TRI SAM
                GenJnlLine.VALIDATE("Posting Date", "Deposit Date");///TRI SAM 150516
                GenJnlLine.INSERT(TRUE);

                GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"Bank Account");
                GenJnlLine.VALIDATE("Account No.", "PDC Deposit Bank No.");
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine.VALIDATE(Amount, -Amount);
                GenJnlLine.Narration := Remarks;
                //>>MS.20191001 - original code commented
                //GenJnlLine."Source Code" := "Customer No.";
                //<<MS.20191001 - original code commented

                //>>MS.20191001 - new code added
                GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
                //<<MS.20191001 - new code added
                // GenJnlLine."Cheque No." := "Cheque No.";
                // GenJnlLine."Cheque Date" := "Cheque Date";//TRI SAM
                GenJnlLine."Check No." := "Cheque No.";
                GenJnlLine.Validate("Payment Method Code", "Payment Method Code");
                GenJnlLine."Check Date" := "Cheque Date";//TRI SAM
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Deposit Bank Dim1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Deposit Bank Dim2 Code");
                GenJnlLine.Description := Remarks;
                GenJnlLine.MODIFY;
                Window.UPDATE(2, 'Posting Journals');
                CLEAR(GenJnlPostBatch);
                GenJnlPostBatch.RUN(GenJnlLine);
                CLEAR(GenJnlPostBatch); //APNT-LCPDC1.1
                "Posting Date" := WORKDATE;
                Posted := TRUE;
                "Date Cleared" := TODAY;
                Cleared := TRUE;
                MODIFY;
            END;
            CustLedgEntry.RESET;
            CustLedgEntry.SETCURRENTKEY("Customer No.", "Document No.", "PDC Entry");
            CustLedgEntry.SETRANGE("Customer No.", "Customer No.");
            CustLedgEntry.SETRANGE("Document No.", Code);
            CustLedgEntry.SETRANGE("PDC Entry", TRUE);
            IF CustLedgEntry.FIND('-') THEN
                REPEAT
                    CustLedgEntryCopy.COPY(CustLedgEntry);
                    CustLedgEntryCopy."PDC Entry" := FALSE;
                    CustLedgEntryCopy.MODIFY;
                UNTIL CustLedgEntry.NEXT = 0;
            Window.CLOSE;
        END;
    end;
}

