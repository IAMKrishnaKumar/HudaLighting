table 60011 "PDC Receipt"
{
    // Code           Date        Name        Desc.
    // APNT-LCPDC1.0  20.05.12    Monica      Created New.
    // MS.20191001    01.10.2019  MS          Add Customer filter in Customer Bank Account

    Permissions = TableData "Cust. Ledger Entry" = rim;


    fields
    {
        field(1; "Code"; Code[20])
        {

            trigger OnValidate()
            begin
                if Code <> xRec.Code then begin
                    GLSetup.Get;
                    NoSeriesMgt.TestManual(GLSetup."PDC Receipt Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Customer No."; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate()
            var
                RemoveApplEntry: Record "Cust. Ledger Entry";
            begin
                TestField(Status, Status::" ");
                if not CustRec.Get("Customer No.") then
                    CustRec.Init;
                Name := CustRec.Name;
                Address := CustRec.Address;
                "Address 2" := CustRec."Address 2";
                "Post Code" := CustRec."Post Code";
                "Country Code" := CustRec."Country/Region Code";
                City := CustRec.City;
                "Currency Code" := CustRec."Currency Code";



                if xRec."Customer No." <> '' then
                    if xRec."Customer No." <> Rec."Customer No." then begin
                        Validate("Customer Bank", '');
                        Remarks := '';
                        Validate("Cheque No.", '');
                        Validate("Cheque Date", 0D);
                        RemoveApplEntry.Reset;
                        RemoveApplEntry.SetRange("Customer No.", xRec."Customer No.");
                        RemoveApplEntry.SetRange(Open, true);
                        RemoveApplEntry.SetRange("Applies-to ID", Code);
                        if RemoveApplEntry.Find('-') then
                            repeat
                                RemoveApplEntry.Validate("Applies-to ID", '');
                                RemoveApplEntry.Modify;
                            until RemoveApplEntry.Next = 0;
                        "Applies-to ID" := '';
                        Amount := 0;
                    end;

            end;
        }
        field(3; Name; Text[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
            end;
        }
        field(4; Address; Text[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
            end;
        }
        field(5; "Address 2"; Text[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
            end;
        }
        field(6; "Post Code"; Code[20])
        {
            Description = 'MS.20191008 - length increased to 20';
            Editable = false;
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
            end;
        }
        field(7; "Country Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
            end;
        }
        field(8; "Customer Bank"; Code[20])
        {
            Description = 'MS.20191001- add filter customer';
            TableRelation = "Customer Bank Account".Code WHERE("Customer No." = FIELD("Customer No."));

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
                if not BankRec.Get("Customer No.", "Customer Bank") then
                    BankRec.Init;
                "Bank Name" := BankRec.Name;
                "Bank Address" := BankRec.Address;
                "Bank Address 2" := BankRec."Address 2";
                "Bank Post Code" := BankRec."Post Code";
                "Bank City" := BankRec.City;
                "Bank Country Code" := BankRec."Country/Region Code";
                "Bank Branch No." := BankRec."Bank Branch No.";
                "Bank Account No." := BankRec."Bank Account No.";
                //"Currency Code" := BankRec."Currency Code";
            end;
        }
        field(9; "Bank Name"; Text[50])
        {
            Editable = false;
        }
        field(10; "Cheque No."; Code[20])
        {

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
            end;
        }
        field(11; "Reference Type"; Option)
        {
            OptionCaption = ' ,Invoice';
            OptionMembers = " ",Invoice;

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
            end;
        }
        field(12; "Applies-to ID"; Code[20])
        {

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
            end;
        }
        field(13; "Cheque Date"; Date)
        {

            trigger OnValidate()
            begin
                //TESTFIELD(Status,Status::Received);
                if "Cheque Date" <> 0D then
                    if "Cheque Date" < "Document Date" then
                        Error('Cheque Date must be greater than Document Date');
            end;
        }
        field(14; Status; Option)
        {
            Editable = true;
            OptionCaption = ' ,Received,Deposited,Bounced,Returned,Closed';
            OptionMembers = " ",Received,Deposited,Bounced,Returned,Closed;

            trigger OnValidate()
            begin
                if Status = xRec.Status then
                    exit;
                /*
                IF Status = Status::" " THEN
                  IF xRec.Status = xRec.Status::"Deposited Successfully" THEN
                    ERROR('Deposited PDCs cannot be modified');
                */

                if Status = Status::Received then begin
                    if Amount = 0 then
                        Error('Amount cannot be Zero');
                    if "Cheque No." = '' then
                        Error('Please enter Cheque No.');
                    if "Cheque Date" = 0D then
                        Error('Please enter "Cheque Date"');

                    if "Applies-to ID" = '' then begin
                        if "UnApplied PDC" = false then
                            Error('Please apply the entries against PDC or Check as "UnApplied PDC"');

                        if "Reference Type" = "Reference Type"::" " then begin
                            PDCAppliedAmt.Init;
                            PDCAppliedAmt."PDC No." := Code;
                            PDCAppliedAmt."Transaction Type" := PDCAppliedAmt."Transaction Type"::Sales;
                            PDCAppliedAmt."Document Type" := PDCAppliedAmt."Document Type"::" ";
                            PDCAppliedAmt.Amount := -1 * Amount;
                            GLSetup.Get;
                            if "Currency Code" = '' then begin
                                GLSetup.TestField("LCY Code");
                                PDCAppliedAmt."Currency Code" := GLSetup."LCY Code";
                                PDCAppliedAmt."Amount (LCY)" := -1 * Amount;
                            end else begin
                                PDCAppliedAmt."Currency Code" := "Currency Code";
                                //<LT> Commented the code - PDC Upgrade
                                /*
                                PDCAppliedAmt."Amount (LCY)" := GenJnlPostLine.ExchAmount(PDCAppliedAmt.Amount,GLSetup."LCY Code",
                                                               "Currency Code","Cheque Date");*/
                                //</LT>
                            end;
                            PDCAppliedAmt.Insert;
                        end;
                    end else begin
                        if "Reference Type" = "Reference Type"::" " then
                            Error('Please enter "Reference Type"');
                    end;
                end;

                if (Status = Status::Deposited) then begin
                    if xRec.Status <> xRec.Status::Received then
                        Error('PDC not yet Deposited.');

                    PDCAppliedAmt.Reset;
                    PDCAppliedAmt.SetRange(PDCAppliedAmt."PDC No.", Code);
                    PDCAppliedAmt.SetRange(PDCAppliedAmt."Transaction Type", PDCAppliedAmt."Transaction Type"::Sales);
                    //PDCAppliedAmt.SETRANGE(PDCAppliedAmt."Document Type",PDCAppliedAmt."Document Type"::Invoice);
                    if PDCAppliedAmt.Find('-') then
                        repeat
                            PDCAppliedAmt.Bounced := true;
                            PDCAppliedAmt.Modify;
                        until PDCAppliedAmt.Next = 0;
                    Bounced := true;

                    Posted := true;
                    Modify;
                end;

                if (Status = Status::Bounced) then begin
                    if xRec.Status <> xRec.Status::Received then
                        Error('PDC not yet Deposited.');

                    Status := Status::Bounced;
                    "Returned/ Not Encashed" := true;
                    Posted := true;
                    Modify;
                end;

            end;
        }
        field(15; Cleared; Boolean)
        {
        }
        field(16; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
                if Amount > 0 then
                    Error(Text006);
            end;
        }
        field(17; "Document Date"; Date)
        {
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
            end;
        }
        field(18; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(19; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(20; "Currency Code"; Code[10])
        {
            TableRelation = Currency;

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
            end;
        }
        field(21; "Bank Address"; Text[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
            end;
        }
        field(22; "Bank Address 2"; Text[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
            end;
        }
        field(23; "Bank Post Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
            end;
        }
        field(24; "Bank Country Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
            end;
        }
        field(25; City; Text[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
            end;
        }
        field(26; "Bank City"; Text[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
            end;
        }
        field(27; "Bank Branch No."; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
            end;
        }
        field(28; "Bank Account No."; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
            end;
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
        }
        field(32; Bounced; Boolean)
        {

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
            end;
        }
        field(33; "UnApplied PDC"; Boolean)
        {

            trigger OnValidate()
            begin
                if Status <> Status::" " then
                    Error('Cannot modify this PDC');

                if "UnApplied PDC" = true then begin
                    if ("Applies-to ID" <> '') or ("Applies-to Doc. No." <> '') then
                        if Confirm('Do you want to reset the applied entries') then begin
                            if "Reference Type" = "Reference Type"::Invoice then begin
                                CustLedgEntry.Reset;
                                CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::Invoice);
                                CustLedgEntry.SetRange("Customer No.", "Customer No.");
                                CustLedgEntry.SetRange("Applies-to ID", Code);
                                if CustLedgEntry.Find('-') then
                                    repeat
                                        CustLedgEntry."Applies-to ID" := '';
                                        CustLedgEntry.Modify;
                                    until CustLedgEntry.Next = 0;
                                "Reference Type" := "Reference Type"::" ";
                                "Applies-to ID" := '';
                                "Applies-to Doc. No." := '';
                                Modify;
                            end else begin
                                "Reference Type" := "Reference Type"::" ";
                                "Applies-to ID" := '';
                                "Applies-to Doc. No." := '';
                                Modify;
                            end;
                        end else
                            "UnApplied PDC" := false;

                    // Changing the value of reference Type - as per requirement in HUDA LIGHTING
                    "Reference Type" := "Reference Type"::" ";
                end;
            end;
        }
        field(34; "Returned/ Not Encashed"; Boolean)
        {
        }
        field(35; "Posting Date"; Date)
        {
        }
        field(36; "User ID"; Code[50])
        {
            TableRelation = User;
        }
        field(37; "PDC Deposit Bank No."; Code[20])
        {
            Caption = 'Deposit Bank No.';
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
                if PDCBankRec.Get("PDC Deposit Bank No.") then begin
                    "Deposit Bank Name" := PDCBankRec.Name;
                    "Deposit Bank Address 1" := PDCBankRec.Address;
                    "Deposit Bank Address 2" := PDCBankRec."Address 2";
                    "Deposit Bank Post Code" := PDCBankRec."Post Code";
                    "Deposit Bank City" := PDCBankRec.City;
                    "Deposit Bank Country Code" := PDCBankRec."Country/Region Code";
                    "Deposit Bank Branch No." := PDCBankRec."Bank Branch No.";
                    "Deposit Bank Account No." := PDCBankRec."Bank Account No.";
                    "Deposit Bank Currency Code" := PDCBankRec."Currency Code";
                end;
            end;
        }
        field(38; "Deposit Bank Name"; Text[50])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(39; "Deposit Bank Address 1"; Text[50])
        {
            Caption = 'Address 1';
            Editable = false;
        }
        field(40; "Deposit Bank Address 2"; Text[50])
        {
            Caption = 'Address 2';
            Editable = false;
        }
        field(41; "Deposit Bank Post Code"; Code[10])
        {
            Caption = 'Post Code';
            Editable = false;
            TableRelation = "Post Code";
        }
        field(42; "Deposit Bank Country Code"; Code[10])
        {
            Caption = 'Country Code';
            Editable = false;
        }
        field(43; "Deposit Bank City"; Text[30])
        {
            Caption = 'City';
            Editable = false;
        }
        field(44; "Deposit Bank Branch No."; Code[20])
        {
            Caption = 'Branch No.';
            Editable = false;
        }
        field(45; "Deposit Bank Account No."; Code[20])
        {
            Caption = 'Account No.';
            Editable = false;
        }
        field(46; "Deposit Bank Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(47; "Deposit Bank Dim1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(1));

            trigger OnValidate()
            begin
                TestField(Status, Status::" ");
                /*
                //APNT-3rdDim
                IF "Deposit Bank Dim1 Code" <> '' THEN BEGIN
                  GLSetup.GET;
                  DimensionValue.GET(GLSetup."Shortcut Dimension 1 Code","Deposit Bank Dim1 Code");
                END;
                //APNT-3rdDim
                */
            end;
        }
        field(48; "Deposit Bank Dim2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(2));
        }
        field(49; "Deposit Bank Dim3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(3));
        }
        field(50; "Deposit Bank Dim4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(4));
        }
        field(51; "Deposit Bank Dim5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(5));
        }
        field(52; "Deposit Bank Dim6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(6));
        }
        field(53; "Deposit Bank Dim7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(7));
        }
        field(54; "Deposit Bank Dim8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(8));
        }
        field(56; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(57; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(58; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(59; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(60; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
            end;
        }
        field(61; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(8, "Shortcut Dimension 8 Code");
            end;
        }
        field(62; "Date Cleared"; Date)
        {
        }
        field(63; Posted; Boolean)
        {
        }
        field(101; "Check Printed"; Boolean)
        {
        }
        field(1001; "Deposit Date"; Date)
        {
            Editable = false;
        }
        field(1002; "Return Date"; Date)
        {
            Description = 'TRI SAM';
        }
        field(1003; "Return ProfitCenter"; Code[20])
        {
            Description = 'TRI SAM';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50001; "Payment Method Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
        field(50003; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; "PDC Deposit Bank No.", "Cheque Date", "Code")
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

        CustLedgEntry.Next;
        CustLedgEntry.SetCurrentKey("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
        CustLedgEntry.SetFilter("Customer No.", "Customer No.");
        CustLedgEntry.SetFilter("Applies-to ID", "Applies-to ID");
        if CustLedgEntry.Find('-') then
            repeat
                CustLedgEntry."Applies-to ID" := '';
                CustLedgEntry.Modify;
            until CustLedgEntry.Next = 0;
    end;

    trigger OnInsert()
    begin
        if Code = '' then begin
            GLSetup.Get;
            GLSetup.TestField(GLSetup."PDC Receipt Nos.");
            NoSeriesMgt.InitSeries(GLSetup."PDC Receipt Nos.", xRec."No. Series", 0D, Code, "No. Series");
        end;
        "Document Date" := WorkDate;
        "User ID" := UserId;
        Validate("PDC Deposit Bank No.", GLSetup."PDC Bank Account No.");
    end;

    trigger OnModify()
    begin
        "User ID" := UserId;
    end;

    var
        BankRec: Record "Customer Bank Account";
        CustRec: Record Customer;
        GLSetup: Record "General Ledger Setup";
        CustLedgEntry: Record "Cust. Ledger Entry";
        SalesOrders: Record "Sales Header";
        DimensionValue: Record "Dimension Value";
        PDCAppliedAmt: Record "PDC Applied Amount";
        SalesOrders1: Record "Sales Header";
        CurrExchRate: Record "Currency Exchange Rate";
        PDCBankRec: Record "Bank Account";
        //ApplyCustEntries: Page Page50026;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        DimMgt: Codeunit DimensionManagement;
        FromCurrencyCode: Code[10];
        ToCurrencyCode: Code[10];
        ApplnCurrencyCode: Code[10];
        ChequeAmt: Decimal;
        PDCAmt: Decimal;
        PDCApplAmount: Decimal;
        TempRemAmount: Decimal;
        OK: Boolean;
        ExRate: Boolean;
        Text003: Label 'The %1 in the %2 will be changed from %3 to %4.\';
        Text004: Label 'Do you wish to continue?';
        Text005: Label 'The update has been interrupted to respect the warning.';
        Text006: Label 'Amount must be Negative';
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        OldDimSetID: Integer;

    procedure AssistEdit(OldReceiptRec: Record "PDC Receipt"): Boolean
    var
        ReceiptRec: Record "PDC Receipt";
    begin
        with ReceiptRec do begin
            ReceiptRec := Rec;
            GLSetup.Get;
            GLSetup.TestField(GLSetup."PDC Receipt Nos.");
            if NoSeriesMgt.SelectSeries(GLSetup."PDC Receipt Nos.", OldReceiptRec."No. Series", "No. Series") then begin
                GLSetup.Get;
                GLSetup.TestField(GLSetup."PDC Receipt Nos.");
                NoSeriesMgt.SetSeries(Code);
                Rec := ReceiptRec;
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

    procedure CheckCalcPmtDiscGenJnlCust(OldCustLedgEntry2: Record "Cust. Ledger Entry"; ApplnRoundingPrecision: Decimal; CheckAmount: Boolean): Boolean
    var
        NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        OldCVLedgEntryBuf2: Record "CV Ledger Entry Buffer";
    begin
        NewCVLedgEntryBuf."Document Type" := NewCVLedgEntryBuf."Document Type"::Invoice;
        NewCVLedgEntryBuf."Posting Date" := "Cheque Date";
        NewCVLedgEntryBuf."Remaining Amount" := Amount;
        //<LT> Commented the code PDC Upgrade
        /*
        GenJnlPostLine.TransferCustLedgEntry(OldCVLedgEntryBuf2,OldCustLedgEntry2,TRUE);
        EXIT(GenJnlPostLine.CheckCalcPmtDisc(NewCVLedgEntryBuf,OldCVLedgEntryBuf2,ApplnRoundingPrecision,FALSE,CheckAmount));
        */
        //</LT>

    end;

    procedure CalcApplnRemainingAmount(Amount: Decimal; PostDate: Date; CurrCode: Code[10]): Decimal
    var
        ApplnRemainingAmount: Decimal;
    begin
        ExRate := true;
        if CurrCode = "Currency Code" then
            exit(Amount)
        else begin
            ApplnRemainingAmount := CurrExchRate.ApplnExchangeAmtFCYToFCY(PostDate, "Currency Code", CurrCode, Amount, ExRate);
            exit(ApplnRemainingAmount);
        end;
    end;

    procedure ValidateShortcutDimCode(FieldNo: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNo, ShortcutDimCode);
        //<LT> Commented the code PDC Upgrade
        //DimMgt.SaveDocDim(DATABASE::"PDC Receipt", DocDim."Document Type"::" ", Code, 0, FieldNo, ShortcutDimCode);
        //</LT>
        //MODIFY;

        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNo, ShortcutDimCode, "Dimension Set ID");
        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
        END;


    end;

    procedure ShowDimensions()
    VAR
        DocDim: Record "Default Dimension";
    begin
        /*
        //<LT> Commented the code PDC Upgrade
        DocDim.RESET;
        DocDim.SETFILTER(DocDim."Table ID", '%1', DATABASE::"PDC Receipt");
        DocDim.SETRANGE(DocDim."Document Type", DocDim."Document Type"::" ");
        DocDim.SETFILTER(DocDim."Document No.", Code);
        DocDim.SETRANGE(DocDim."Line No.", 0);
        DocDims.SETTABLEVIEW(DocDim);
        DocDims.RUNMODAL;
        */
        //</LT>


        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", STRSUBSTNO('%1 %2', Code, "PDC Deposit Bank No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
        END;

    end;
}

