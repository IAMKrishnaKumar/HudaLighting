table 60012 "PDC Issue"
{
    // Code           Date        Name        Desc.
    // APNT-LCPDC1.0  20.05.12    Monica      Created New.
    // APNT-DIM1.0    22.01.13    Sujith      Added code for update Shortcut Dimension 2 Code

    Permissions = TableData "Vendor Ledger Entry" = rim;
    Caption = 'PDC Payment';
    fields
    {
        field(1; "Code"; Code[20])
        {

            trigger OnValidate()
            begin
                if Code <> xRec.Code then begin
                    GLSetup.Get;
                    NoSeriesMgt.TestManual(GLSetup."PDC Issue Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Vendor No."; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
                Vendor.Get("Vendor No.");
                Name := Vendor.Name;
                Address := Vendor.Address;
                "Address 2" := Vendor."Address 2";
                City := Vendor.City;
                "Post Code" := Vendor."Post Code";
                "Country Code" := Vendor."Country/Region Code";
                //<LT>
                //Payee := Vendor."Payee Name";
                //</LT>
            end;
        }
        field(3; Name; Text[50])
        {
            Editable = false;
        }
        field(4; Address; Text[50])
        {
            Editable = false;
        }
        field(5; "Address 2"; Text[50])
        {
            Editable = false;
        }
        field(6; "Post Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Post Code";
        }
        field(7; "Country Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Country/Region";
        }
        field(8; Bank; Code[20])
        {
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
                if BankAcc.Get(Bank) then begin
                    "Bank Name" := BankAcc.Name;
                    "Bank Address" := BankAcc.Address;
                    "Bank Address 2" := BankAcc."Address 2";
                    "Bank City" := BankAcc.City;
                    "Bank Post Code" := BankAcc."Post Code";
                    "Bank Country Code" := BankAcc."Country/Region Code";
                    "Bank Branch No." := BankAcc."Bank Branch No.";
                    "Bank Account No." := BankAcc."Bank Account No.";
                    Validate("Currency Code", BankAcc."Currency Code");
                end else begin
                    Clear("Bank Name");
                    Clear("Bank Address");
                    Clear("Bank Address 2");
                    Clear("Bank City");
                    Clear("Bank Post Code");
                    Clear("Bank Country Code");
                    Clear("Bank Branch No.");
                    Clear("Bank Account No.");
                    Validate("Currency Code", '');
                end;
            end;
        }
        field(9; "Bank Name"; Text[50])
        {
            Editable = false;
        }
        field(10; "Cheque No."; Code[20])
        {
        }
        field(11; "Reference Type"; Option)
        {
            OptionCaption = ' ,Invoice';
            OptionMembers = " ",Invoice;

            trigger OnValidate()
            begin
                if "Reference Type" <> "Reference Type"::" " then
                    "UnApplied PDC" := false;
            end;
        }
        field(12; "Applies-to ID"; Code[20])
        {
        }
        field(13; "Cheque Date"; Date)
        {

            trigger OnValidate()
            begin
                //APNT-1.0 - Added condition as per Mr. Zia's Request - 30.10.11
                if "Cheque Date" <= Today then
                    Error('You cannot enter Cheque Date less than or equal to %1.', Today);
                //APNT-1.0
            end;
        }
        field(14; Status; Option)
        {
            Editable = true;
            OptionCaption = ' ,Issued,Bounced,Returned,Closed';
            OptionMembers = " ",Issued,Bounced,Returned,Closed;

            trigger OnValidate()
            begin

                if Status = xRec.Status then
                    exit;

                if Status = Status::Issued then begin
                    if Amount = 0 then
                        Error('Amount cannot be Zero');
                    if "Cheque No." = '' then
                        Error('Please enter Cheque No.');
                    if "Cheque Date" = 0D then
                        Error('Please enter "Cheque Date"');

                    if ("Applies-to ID" = '') then begin
                        if "UnApplied PDC" = false then
                            Error('Please apply the entries against PDC or Check as "UnApplied PDC"');

                        if "Reference Type" = "Reference Type"::" " then begin
                            PDCAppliedAmt.Init;
                            PDCAppliedAmt."PDC No." := Code;
                            PDCAppliedAmt."Transaction Type" := PDCAppliedAmt."Transaction Type"::Purchase;
                            PDCAppliedAmt."Document Type" := PDCAppliedAmt."Document Type"::" ";
                            PDCAppliedAmt.Amount := -Amount;
                            GLSetup.Get;
                            if "Currency Code" = '' then begin
                                GLSetup.TestField("LCY Code");
                                PDCAppliedAmt."Currency Code" := GLSetup."LCY Code";
                                PDCAppliedAmt."Amount (LCY)" := -Amount;
                            end else begin
                                PDCAppliedAmt."Currency Code" := "Currency Code";
                                //<LT> Commented the code
                                PDCAppliedAmt."Amount (LCY)" := -Amount;
                                //</LT>
                            end;
                            PDCAppliedAmt.Insert;
                        end;
                    end else begin
                        if "Reference Type" = "Reference Type"::" " then
                            Error('Please enter "Reference Type"');
                    end;
                end;

                if (Status = Status::Bounced) then begin
                    if xRec.Status <> xRec.Status::Issued then
                        Error('PDC not yet Issued.');
                    PDCAppliedAmt.Reset;
                    PDCAppliedAmt.SetFilter("PDC No.", Code);
                    PDCAppliedAmt.SetRange("Transaction Type", PDCAppliedAmt."Transaction Type"::Purchase);
                    //PDCAppliedAmt.SETRANGE("Document Type",PDCAppliedAmt."Document Type"::Invoice);
                    if PDCAppliedAmt.Find('-') then
                        repeat
                            PDCAppliedAmt.Bounced := true;
                            PDCAppliedAmt.Modify;
                        until PDCAppliedAmt.Next = 0;
                    Bounced := true;
                    Posted := true;
                end;

                if Status = Status::Returned then begin
                    if xRec.Status <> xRec.Status::Issued then
                        Error('PDC not yet Issued.');
                    Status := Status::Returned;
                    Returned := true;
                    Posted := true;
                end;
            end;
        }
        field(15; Cleared; Boolean)
        {
            Editable = false;
        }
        field(16; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                if Amount < 0 then
                    Error('Amount must be Positive.');
                TestField("Document Date");
                if "Currency Code" = '' then
                    "Amount (LCY)" := Amount
                else
                    "Amount (LCY)" := Round(
                      CurrExchRate.ExchangeAmtFCYToLCY(
                        "Document Date", "Currency Code",
                        Amount, "Currency Factor"));
            end;
        }
        field(17; "Document Date"; Date)
        {
        }
        field(18; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(19; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(20; "Currency Code"; Code[10])
        {
            TableRelation = Currency;

            trigger OnValidate()
            begin
                TestField("Document Date");
                if "Currency Code" <> '' then begin
                    GetCurrency;
                    "Currency Factor" :=
                      CurrExchRate.ExchangeRate("Document Date", "Currency Code");
                end else
                    "Currency Factor" := 0;
                Validate("Currency Factor");
            end;
        }
        field(21; "Bank Address"; Text[50])
        {
            Editable = false;
        }
        field(22; "Bank Address 2"; Text[50])
        {
            Editable = false;
        }
        field(23; "Bank Post Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Post Code";
        }
        field(24; "Bank Country Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Country/Region";
        }
        field(25; City; Text[30])
        {
            Editable = false;
        }
        field(26; "Bank City"; Text[30])
        {
            Editable = false;
        }
        field(27; "Bank Branch No."; Code[20])
        {
            Editable = false;
        }
        field(28; "Bank Account No."; Code[20])
        {
            Editable = false;
        }
        field(29; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(30; Remarks; Text[250])
        {
            Description = 'changes to 250';
        }
        field(31; "Applies-to Doc. No."; Code[20])
        {

            trigger OnLookup()
            begin
                if "Cheque No." = '' then
                    Error('Please enter the Cheque No.');

                if "Cheque Date" = 0D then
                    Error('Please enter the Cheque Date');

                if "Reference Type" = "Reference Type"::Invoice then begin
                    VendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive, "Due Date");
                    VendLedgEntry.SetRange("Vendor No.", "Vendor No.");
                    VendLedgEntry.SetRange(Open, true);
                    if "Applies-to Doc. No." <> '' then begin
                        VendLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
                        if VendLedgEntry.Find('-') then;
                        VendLedgEntry.SetRange("Document Type");
                        VendLedgEntry.SetRange("Document No.");
                    end else
                        if "Applies-to ID" <> '' then begin
                            VendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                            if VendLedgEntry.Find('-') then;
                            VendLedgEntry.SetRange("Applies-to ID");
                        end;
                    //ApplyVendEntries.SetPDCLine(Rec);    //commented Temp MS
                    ApplyVendEntries.SETTABLEVIEW(VendLedgEntry);
                    ApplyVendEntries.SETRECORD(VendLedgEntry);
                    ApplyVendEntries.LOOKUPMODE(true);
                    if ApplyVendEntries.RUNMODAL = ACTION::LookupOK then begin
                        ApplyVendEntries.GETRECORD(VendLedgEntry);
                        Clear(ApplyVendEntries);
                        if "Currency Code" <> VendLedgEntry."Currency Code" then
                            if Amount = 0 then begin
                                FromCurrencyCode := GetShowCurrencyCode("Currency Code");
                                ToCurrencyCode := GetShowCurrencyCode(VendLedgEntry."Currency Code");
                                if not
                                   Confirm(
                                     Text003 +
                                     Text004, true,
                                     FieldCaption("Currency Code"), TableCaption, FromCurrencyCode,
                                     ToCurrencyCode)
                                then
                                    Error(Text005);
                                Validate("Currency Code", VendLedgEntry."Currency Code");
                            end else
                                GenJnlApply.CheckAgainstApplnCurrency(
                                  "Currency Code", VendLedgEntry."Currency Code", AccType::Vendor, true);
                        if Amount = 0 then begin
                            VendLedgEntry.CalcFields("Remaining Amount");
                            if CheckCalcPmtDiscGenJnlVend(VendLedgEntry, 0, false)
                            then
                                Amount := -(VendLedgEntry."Remaining Amount" -
                                  VendLedgEntry."Remaining Pmt. Disc. Possible")
                            else
                                Amount := -VendLedgEntry."Remaining Amount";
                            Validate(Amount);
                        end;
                        "Applies-to Doc. No." := VendLedgEntry."Document No.";
                        "Applies-to ID" := '';
                    end else
                        Clear(ApplyVendEntries);
                end;
            end;
        }
        field(32; Bounced; Boolean)
        {
        }
        field(33; "UnApplied PDC"; Boolean)
        {

            trigger OnValidate()
            begin
                if "UnApplied PDC" = true then begin
                    if "Reference Type" = "Reference Type"::Invoice then begin
                        VendLedgEntry.Reset;
                        VendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
                        VendLedgEntry.SetRange("Vendor No.", "Vendor No.");
                        VendLedgEntry.SetRange(Open, true);
                        VendLedgEntry.SetRange("Applies-to ID", Code);
                        if VendLedgEntry.Find('-') then
                            repeat
                                VendLedgEntry."Applies-to ID" := '';
                                VendLedgEntry.Modify;
                            until VendLedgEntry.Next = 0;
                        Validate(Amount, 0);
                    end;

                    /* ELSE IF "Reference Type" = "Reference Type"::Invoice THEN BEGIN
                      PurchaseOrders.RESET;
                      PurchaseOrders.SETRANGE("Document Type",PurchaseOrders."Document Type"::Order);
                      PurchaseOrders.SETRANGE("Buy-from Vendor No.","Vendor No.");
                      PurchaseOrders.SETRANGE("Applies-to ID for PDC",Code);
                      IF PurchaseOrders.FIND('-') THEN REPEAT
                        PurchaseOrders."Applies-to ID for PDC" := '';
                        PurchaseOrders.MODIFY;
                      UNTIL PurchaseOrders.NEXT = 0;
                    END;*/
                    CustVendLedEntry.Reset;
                    CustVendLedEntry.SetRange("Source Document No.", Code);
                    CustVendLedEntry.SetRange("Inter Dimension Posted", false);
                    if CustVendLedEntry.FindSet then
                        CustVendLedEntry.DeleteAll;
                    "Reference Type" := "Reference Type"::" ";
                    "Applies-to Doc. No." := '';
                    "Applies-to ID" := '';
                    Amount := 0;
                    "Amount (LCY)" := 0;

                    // Changing the value of reference Type - as per requirement in HUDA LIGHTING
                    "Reference Type" := "Reference Type"::" ";
                end;

            end;
        }
        field(34; Returned; Boolean)
        {
        }
        field(35; "Posting Date"; Date)
        {
        }
        field(36; "User ID"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(37; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(38; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(39; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(40; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(41; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
            end;
        }
        field(42; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(8, "Shortcut Dimension 8 Code");
            end;
        }
        field(43; "Deposit Bank Dim1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(1));

            trigger OnValidate()
            begin
                //APNT-3rdDim
                /*
                IF "Deposit Bank Dim1 Code" <> '' THEN BEGIN
                  GLSetup.GET;
                  DimensionValue.GET(GLSetup."Shortcut Dimension 1 Code","Shortcut Dimension 1 Code");
                  //APNT-DIM1.0
                  //<LT> Commented the code - PDC Upgrade
                  //VALIDATE("Deposit Bank Dim2 Code",DimensionValue."Shortcut Dimension 2 Code");
                  //</LT>
                  //APNT-DIM1.0
                END;
                //APNT-3rdDim
                */

            end;
        }
        field(44; "Deposit Bank Dim2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(2));
        }
        field(45; "Deposit Bank Dim3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(3));
        }
        field(46; "Deposit Bank Dim4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(4));
        }
        field(47; "Deposit Bank Dim5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(5));
        }
        field(48; "Deposit Bank Dim6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(6));
        }
        field(49; "Deposit Bank Dim7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(7));
        }
        field(50; "Deposit Bank Dim8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(8));
        }
        field(100; Payee; Text[70])
        {
        }
        field(101; "Check Printed"; Boolean)
        {
        }
        field(102; "Date Cleared"; Date)
        {
        }
        field(103; Posted; Boolean)
        {
        }
        field(110; "Bank Payment Type"; Option)
        {
            OptionCaption = ' ,Computer Check,Manual Check';
            OptionMembers = " ","Computer Check","Manual Check";
        }
        field(480; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(1001; "Deposit Date"; Date)
        {
            Editable = false;
        }
        field(2001; "Amount (LCY)"; Decimal)
        {
        }
        field(2010; "Currency Factor"; Decimal)
        {

            trigger OnValidate()
            begin
                if ("Currency Code" = '') and ("Currency Factor" <> 0) then
                    FieldError("Currency Factor", StrSubstNo(Text002, FieldCaption("Currency Code")));
                Validate(Amount);
            end;
        }
        field(50001; Confirmed; Boolean)
        {
        }
        field(50002; "Confirmed By"; Code[50])
        {
        }
        field(50003; "Date Confirmed"; Date)
        {
        }
        field(50004; "A/C Payee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Payment Method Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }

    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; Bank, "Cheque Date", "Code")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField(Status, Status::" ");
    end;

    trigger OnInsert()
    begin
        if Code = '' then begin
            GLSetup.Get;
            GLSetup.TestField("PDC Issue Nos.");
            NoSeriesMgt.InitSeries(GLSetup."PDC Issue Nos.", xRec."No. Series", 0D, Code, "No. Series");
        end;
        "Document Date" := WorkDate;
        "User ID" := CopyStr(UserId, 1, 20);
    end;

    trigger OnModify()
    begin
        TestField(Status, Status::" ");
        "User ID" := UserId;
        TestField("Check Printed", false);
    end;

    var
        Banker: Record "Bank Account";
        GLSetup: Record "General Ledger Setup";
        Vendor: Record Vendor;
        BankAcc: Record "Bank Account";
        VendLedgEntry: Record "Vendor Ledger Entry";
        PurchaseOrders: Record "Purchase Header";
        PurchaseOrders1: Record "Purchase Header";
        DimensionValue: Record "Dimension Value";
        CurrExchRate: Record "Currency Exchange Rate";
        Currency: Record Currency;
        PDCAppliedAmt: Record "PDC Applied Amount";
        // ApplyVendEntries: Page Page50025;
        ApplyVendEntries: Page "Applied Vendor Entries";
        //ApplyVendOrders: Page Page50039;
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        ChequeAmt: Decimal;
        PDCAmt: Decimal;
        FromCurrencyCode: Code[10];
        ToCurrencyCode: Code[10];
        Bounced: Boolean;
        Cleared: Boolean;
        Ok: Boolean;
        ExRate: Boolean;
        Text003: Label 'The %1 in the %2 will be changed from %3 to %4.\';
        Text004: Label 'Do you wish to continue?';
        Text005: Label 'The update has been interrupted to respect the warning.';
        Text006: Label 'Amount must be Negative';
        Text001: Label 'You cannot modify the record if Status is Deposited Successfully ';
        Text002: Label 'cannot be specified without %1';
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        CustVendLedEntry: Record "Customer Vendor Applied Entry";
        OldDimSetID: Integer;

    procedure AssistEdit(OldIssueRec: Record "PDC Issue"): Boolean
    var
        IssueRec: Record "PDC Issue";
    begin
        with IssueRec do begin
            IssueRec := Rec;
            GLSetup.Get;
            GLSetup.TestField(GLSetup."PDC Issue Nos.");
            if NoSeriesMgt.SelectSeries(GLSetup."PDC Issue Nos.", OldIssueRec."No. Series", "No. Series") then begin
                GLSetup.Get;
                GLSetup.TestField(GLSetup."PDC Issue Nos.");
                NoSeriesMgt.SetSeries(Code);
                Rec := IssueRec;
                exit(true);
            end;
        end;
    end;

    procedure GetShowCurrencyCode(CurrencyCode: Code[10]): Code[10]
    begin
        if CurrencyCode <> '' then
            exit(CurrencyCode)
        else
            exit('LCY');
    end;

    procedure CheckCalcPmtDiscGenJnlVend(OldVendLedgEntry2: Record "Vendor Ledger Entry"; ApplnRoundingPrecision: Decimal; CheckAmount: Boolean): Boolean
    var
        NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        OldCVLedgEntryBuf2: Record "CV Ledger Entry Buffer";
    begin
        NewCVLedgEntryBuf."Document Type" := NewCVLedgEntryBuf."Document Type"::Invoice;
        NewCVLedgEntryBuf."Posting Date" := "Cheque Date";
        NewCVLedgEntryBuf."Remaining Amount" := Amount;
        //<LT> Commented the code
        //GenJnlPostLine.TransferVendLedgEntry(OldCVLedgEntryBuf2,OldVendLedgEntry2,TRUE);
        //EXIT(GenJnlPostLine.CheckCalcPmtDisc(NewCVLedgEntryBuf,OldCVLedgEntryBuf2,ApplnRoundingPrecision,FALSE,CheckAmount));
        //</LT>
    end;

    procedure CalcApplnRemainingAmount(PDCAppliedAmount: Decimal; PostingDate: Date; CurrCode: Code[20]) AmountFCY: Decimal
    var
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        ExRate := true;
        if CurrCode = "Currency Code" then
            exit(Amount)
        else begin
            AmountFCY := CurrExchRate.ExchangeAmtFCYToFCY(PostingDate, "Currency Code", CurrCode, PDCAppliedAmount);
            exit(AmountFCY);
        end;
    end;

    procedure ShowDocDim()
    begin
        //<LT> Commented the code
        /*
        DocDim.RESET;
        DocDim.SETRANGE("Table ID",DATABASE::"PDC Issue");
        DocDim.SETRANGE("Document Type",DocDim."Document Type"::" ");
        DocDim.SETRANGE("Document No.",Code);
        DocDim.SETRANGE("Line No.",0);
        DocDims.SETTABLEVIEW(DocDim);
        DocDims.RUNMODAL;
        GET(Code);*/
        //</LT>
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", STRSUBSTNO('%1 %2', Code, bank),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
        END;
    end;

    local procedure GetCurrency()
    var
        CurrencyCode: Code[10];
    begin
        CurrencyCode := "Currency Code";

        if CurrencyCode = '' then begin
            Clear(Currency);
            Currency.InitRoundingPrecision
        end else
            if CurrencyCode <> Currency.Code then begin
                Currency.Get(CurrencyCode);
                Currency.TestField("Amount Rounding Precision");
            end;
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        //<LT>
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if Code <> '' then
            Modify;

        if OldDimSetID <> "Dimension Set ID" then
            Modify;

        //</LT>
    end;
}

