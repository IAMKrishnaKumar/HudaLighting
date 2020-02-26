report 50118 PaymentVoucherGL_LT
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Custom Reports\REPOSITORY\PaymentVoucherGL_LT\PaymentVoucherGL_LT.rdl';
    Caption = 'Payment Voucher';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "Document No.", "Source Type";
            DataItemTableView = SORTING("Entry No.");
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(Entry_No_GL; "Entry No.")
            {

            }
            column(CompanyInfo_Name2; CompanyInfo."Name 2")
            {
            }
            column(UserName; UserName)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(Check_Date; checkDate)
            {

            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyDisplayName; CompanyInfo."Ship-to Name")
            { }
            column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Country; CompanyInfo."Country/Region Code")
            {
            }
            column(CompanyAddress; CompanyAddress)
            {

            }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyTelAndFax; CompanyTelAndFax)
            {

            }
            column(CompanyInfo_Picture; CompanyInfo."Header Image")
            {
            }
            column(footerImage; CompanyInfo."Footer Image")
            {

            }
            column(CompanyInfo_vatRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfo_PhoneNol; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_WebSite; CompanyInfo."Home Page")
            { }
            column(CompanyInfo_Email; 'E. ' + CompanyInfo."E-Mail")
            { }
            column(CompanyInfoHomPage; CompanyInfo."Home Page")
            {

            }
            column(CurrencyCode_GenJournalLine; CurrCode)
            {
            }
            column(No; No)
            {
            }
            column(Name; Name)
            {
            }
            column(AmountText1; AmountText1)
            {
            }
            column(PostingDate_GLEntry; "G/L Entry"."Posting Date")
            {
            }
            column(ChequeNo_GLEntry; CheckNo)
            {
            }
            column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
            {
            }
            column(DocumentNo2_GLEntry; "G/L Entry"."Document No2")
            {
            }
            column(Amount_GLEntry; "G/L Entry".Amount)//"G/L Entry"."Debit Amount")
            {
            }
            column(TotalAmt; NewAmount)
            {

            }
            column(PaymentMethodDesc; PaymentMethodDesc)
            {

            }
            column(Narration_GLEntry; NarrationText)
            {
            }
            column(PaymentDesc; PaymentDesc)
            {
            }
            column(SourceNo; SourceNo)
            {
            }
            column(LCYCode; GLSetup."LCY Code")
            {
            }

            column(vendorNo; vendorNo)
            {

            }
            column(External_Document_No_; ExternalDocNO)
            {

            }
            column(G_L_Account_No_; AccountNo)
            {

            }
            column(IsFCY; IsFCY)
            {

            }
            column(FCYAmount; FCYAmount)
            {

            }
            column(G_L_Account_Name; AccountName)
            {

            }
            column(Description; Description)
            {

            }
            column(cash_bank; cash_bank)
            {

            }
            dataitem(DetailedVendorLedgEntry1; "Detailed Vendor Ledg. Entry")
            {
                DataItemTableView = SORTING("Applied Vend. Ledger Entry No.", "Entry Type") WHERE(Unapplied = CONST(false), "Entry Type" = CONST(Application), "Initial Document Type" = CONST(Invoice));
                column(Entry_No_DVLE; "Entry No.")
                {

                }
                column(Document_No_DVLE; VendorLedgerEntry."External Document No.")
                {

                }
                column(Document_Type_DVLE; "Initial Document Type")
                {

                }
                column(Initial_Entry_Global_Dim__1_DVLE; "Initial Entry Global Dim. 1")
                {

                }
                column(Posting_Date__DVLE; "Posting Date")//Document Date
                {
                }
                column(Amount_DVLE; Amount)
                {
                }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    DetailedVendorLedgEntry1.SETRANGE("Document No.", "G/L Entry"."Document No.");
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    VendorLedgerEntry.RESET;
                    VendorLedgerEntry.SETRANGE("Entry No.", DetailedVendorLedgEntry1."Vendor Ledger Entry No.");
                    IF VendorLedgerEntry.FINDFIRST THEN;
                end;
            }

            trigger OnAfterGetRecord()
            var
                GLEntry: Record "G/L Entry";
                RecGLAccount: Record "G/L Account";
                RecPaymentMethod: Record "Payment Method";
                RecPDCIssue: Record "PDC Issue";
                RecGLSetup: Record "General Ledger Setup";
                RecVendorPostingGroup: Record "Vendor Posting Group";
            begin
                Clear(RecGLAccount);
                RecGLAccount.SetRange("No.", "G/L Entry"."G/L Account No.");
                RecGLAccount.SetRange("Account Subcategory Entry No.", GlSubCatId);
                if RecGLAccount.FindFirst() then begin
                    CurrReport.Skip();
                end;

                Clear(RecVendorPostingGroup);
                if RecVendorPostingGroup.GET('DOMESTIC') THEN begin
                    if "G/L Account No." = RecVendorPostingGroup."PDC Issue Account" then
                        CurrReport.Skip();
                end;

                Clear(GLEntry);
                GLEntry.SetRange("Document No.", "G/L Entry"."Document No.");
                GLEntry.SetRange("Source Type", "Source Type"::Vendor);
                if GLEntry.FindFirst() then begin
                    Clear(Vendor_Rec);
                    Vendor_Rec.SETRANGE("No.", GLEntry."Source No.");
                    IF Vendor_Rec.FINDFIRST THEN BEGIN
                        vendorNo := Vendor_Rec."No.";
                        Name := Vendor_Rec.Name;
                    END;
                end else
                    Name := "Payee Name";

                /*Clear(AccountNo);
                if "Source No." <> '' then begin
                    if AccountNoTest = "Source No." then
                        AccountNo := "Bal. Account No."
                    else
                        AccountNo := "Source No.";
                    AccountNoTest := "Source No.";
                end else
                    AccountNo := "G/L Account No.";*/

                //IF (Source Type=CONST(Customer)) Customer ELSE IF (Source Type=CONST(Vendor)) 
                //Vendor ELSE IF (Source Type=CONST(Bank Account)) "Bank Account" ELSE IF (Source Type=CONST(Fixed Asset)) 
                //"Fixed Asset" ELSE IF (Source Type=CONST(Employee)) Employee
                Clear(AccountName);
                if "Source Type" = "Source Type"::" " then begin
                    CalcFields("G/L Account Name");
                    AccountName := "G/L Account Name";
                    AccountNo := "G/L Account No.";
                end else begin
                    AccountNo := "Source No.";
                    if "Source Type" = "Source Type"::"Bank Account" then begin
                        Clear(RecBankAccount);
                        RecBankAccount.GET("Source No.");
                        AccountName := RecBankAccount.Name;
                    end else
                        if "Source Type" = "Source Type"::Customer then begin
                            Clear(RecCustomer);
                            RecCustomer.GET("Source No.");
                            AccountName := RecCustomer.Name;
                        end else
                            if "Source Type" = "Source Type"::Vendor then begin
                                Clear(RecVendor);
                                RecVendor.GET("Source No.");
                                AccountName := RecVendor.Name;
                            end else
                                if "Source Type" = "Source Type"::Vendor then begin
                                    Clear(RecVendor);
                                    RecVendor.GET("Source No.");
                                    AccountName := RecVendor.Name;
                                end else
                                    if "Source Type" = "Source Type"::"Fixed Asset" then begin
                                        Clear(RecFixedAsset);
                                        RecFixedAsset.GET("Source No.");
                                        AccountName := RecFixedAsset.Description;
                                    end else
                                        if "Source Type" = "Source Type"::Employee then begin
                                            Clear(RecEmployee);
                                            RecEmployee.GET("Source No.");
                                            AccountName := RecEmployee."First Name";
                                        end;
                end;

                Clear(FCYAmount);
                IF "Source Type" = "Source Type"::Vendor THEN BEGIN
                    Clear(VendorLedEntry_Rec);
                    VendorLedEntry_Rec.SetRange("Document Type", VendorLedEntry_Rec."Document Type"::Payment);
                    VendorLedEntry_Rec.SETRANGE("Document No.", "Document No.");
                    IF VendorLedEntry_Rec.FIND('-') THEN begin
                        CurrCode := VendorLedEntry_Rec."Currency Code";
                        GLSetup.GET;
                        if GLSetup."LCY Code" <> CurrCode then
                            IsFCY := true
                        else
                            IsFCY := false;

                        VendorLedEntry_Rec.CalcFields(Amount);
                        FCYAmount := VendorLedEntry_Rec.Amount;
                        if FCYAmount < 0 then
                            FCYAmount := FCYAmount * -1;
                        Clear(RecPaymentMethod);
                        if RecPaymentMethod.GET(VendorLedEntry_Rec."Payment Method Code") then
                            PaymentMethodDesc := RecPaymentMethod.Description;
                    end;
                END;

                Clear(GLEntry);
                GLEntry.SetRange("Document No.", "G/L Entry"."Document No.");
                if GLEntry.FindSet() then begin
                    repeat
                        if GLEntry."Check Date" <> 0D then
                            checkDate := GLEntry."Check Date";
                        if GLEntry."Check No." <> '' then
                            CheckNo := GLEntry."Check No.";
                        if GLEntry."External Document No." <> '' then
                            ExternalDocNO := GLEntry."External Document No.";
                        if GLEntry.Narration <> '' then
                            NarrationText := GLEntry.Narration;
                    until GLEntry.Next() = 0;
                end;

                Clear(NewAmount);
                Clear(GLEntry);
                GLEntry.SetRange("Document No.", "G/L Entry"."Document No.");
                if GLEntry.FindSet() then begin
                    repeat
                        NewAmount += GLEntry.Amount;//"Debit Amount";
                        Clear(RecGLAccount);
                        RecGLAccount.SetRange("No.", GLEntry."G/L Account No.");
                        RecGLAccount.SetFilter("Account Subcategory Entry No.", '=%1', GlSubCatId);// 'Cash And Bank Balances');
                        if RecGLAccount.FIND('-') then begin
                            GLEntry.CalcFields("G/L Account Name");
                            if RecGLAccount.Name <> '' then begin
                                cash_bank := GLEntry."G/L Account Name"; //Description;    
                                NewAmount := NewAmount - GLEntry.Amount;
                            end;
                        end else begin
                            // NewAmount += GLEntry.Amount;//"Debit Amount";
                            RecGLSetup.GET;
                            if GLSetup."PDC Issue Batch" = GLEntry."Journal Batch Name" then begin
                                Clear(RecPDCIssue);
                                RecPDCIssue.SetRange(Code, GLEntry."Document No.");
                                if RecPDCIssue.FindFirst() then begin
                                    cash_bank := RecPDCIssue."Bank Name";
                                    NewAmount := NewAmount - GLEntry.Amount;
                                end;
                            end;
                        end;

                    until GLEntry.Next() = 0;
                end;
                IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Vendor THEN BEGIN
                    Clear(Vendor_Rec);
                    Vendor_Rec.SETRANGE("No.", "G/L Entry"."Source No.");
                    IF Vendor_Rec.FINDFIRST THEN BEGIN
                        No := Vendor_Rec."No.";
                    END
                END;

                IF CurrCode = '' THEN
                    CurrCode := GLSetup."LCY Code";
                //END;            


                Currency_Rec.RESET;
                IF Currency_Rec.GET(GLSetup."LCY Code") then//CurrCode) THEN
                    DecimalDec := Currency_Rec."Decimal Description";
                // 
                TotalAmt := TotalAmt + "G/L Entry".Amount;//"Debit Amount";

                tvar := (ROUND(TotalAmt) MOD 1 * 100);
                InitTextVariable;
                FormatNoText(AmtInwrd11, tvar, '');
                AmtInwrd12 := AmtInwrd11[1];
                IF AmtInwrd12 = '' THEN
                    AmtInwrd12 := 'ZERO';
                InitTextVariable;
                FormatNoText(Amount_Words, TotalAmt, '');
                Text := Amount_Words[1];
                // AmountText1 := Text + ' ' + CurrCode + ' AND ' + AmtInwrd12 + ' ' + DecimalDec + ' ONLY';
                AmountText1 := UpperCase(Text + ' ' + GLSetup."LCY Code" + ' AND ' + AmtInwrd12 + ' ' + DecimalDec + ' ONLY');


                Clear(Users);
                Clear(UserName);
                Users.SetCurrentKey("User Name");
                Users.SetRange("User Name", "User ID");
                IF Users.FindFirst() then begin
                    if Users."Full Name" <> '' then
                        UserName := Users."Full Name"
                    else
                        UserName := UserId;
                end;


            end;

            trigger OnPreDataItem()
            var
                RecGlSubCat: Record "G/L Account Category";
            begin
                CLEAR(No);
                CLEAR(Name);
                CLEAR(CurrCode);
                CLEAR(TotalAmt);
                Clear(RecGlSubCat);
                RecGlSubCat.SetRange(Description, 'Cash And Bank Balances');
                if RecGlSubCat.FindFirst() then
                    GlSubCatId := RecGlSubCat."Entry No.";
                GLSetup.GET;
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin

            end;
        }

    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS("Header Image");
        CompanyInfo.CalcFields("Footer Image");




        Clear(CompanyAddress);
        Clear(CompanyTelAndFax);
        if CompanyInfo.Address <> '' then
            CompanyAddress := CompanyInfo.Address + ', ';

        if CompanyInfo."Address 2" <> '' then
            CompanyAddress += CompanyInfo."Address 2" + ', ';

        if CompanyInfo."Post Code" <> '' then
            CompanyAddress += 'P.O. Box ' + CompanyInfo."Post Code" + ', ';

        if CompanyInfo.City <> '' then
            CompanyAddress += CompanyInfo.City + ' - ';

        if CompanyInfo."Country/Region Code" <> '' then
            CompanyAddress += CompanyInfo."Country/Region Code";
        if CompanyInfo."Phone No." <> '' then
            CompanyTelAndFax := 'T. ' + CompanyInfo."Phone No." + ', ';
        if CompanyInfo."Fax No." <> '' then
            CompanyTelAndFax += 'F. ' + CompanyInfo."Fax No.";
    end;

    var
        CompanyInfo: Record 79;
        checkDate: Date;
        NewAmount: Decimal;
        AccountNo: Text;
        AccountNoTest: Text;
        AccountName: Text;
        GlSubCatId: Integer;

        //IF (Source Type=CONST(Customer)) Customer ELSE IF (Source Type=CONST(Vendor)) 
        //Vendor ELSE IF (Source Type=CONST(Bank Account)) "Bank Account" ELSE IF (Source Type=CONST(Fixed Asset)) 
        //"Fixed Asset" ELSE IF (Source Type=CONST(Employee)) Employee
        RecBankAccount: Record "Bank Account";
        RecVendor: Record Vendor;
        FCYAmount: Decimal;
        IsFCY: Boolean;
        RecCustomer: Record Customer;
        RecFixedAsset: Record "Fixed Asset";
        RecEmployee: Record Employee;
        ExternalDocNO: Text;
        NarrationText: Text;
        DtlVendorLedEntry: Record "Detailed Vendor Ledg. Entry";
        AmountInWordCU: Codeunit 50645;
        PaymentMethodDesc: Text;
        CheckNo: Text;
        Vendor_Rec: Record 23;
        No: Code[20];
        Name: Text;
        CheckRep: Report 1401;
        GLSetup: Record 98;
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        vendorNo: Text;
        ExponentText: array[5] of Text[30];
        GenJnlLine: Record 81;
        Text026: Label 'ZERO';
        Text027: Label 'HUNDRED';
        Text028: Label 'AND';
        DecimalDec: Text;
        Text029: Label '%1 results in a written number that is too long.';
        Text030: Label ' is already applied to %1 %2 for customer %3.';
        Text031: Label ' is already applied to %1 %2 for vendor %3.';
        Text032: Label 'ONE';
        Text033: Label 'TWO';
        Text034: Label 'THREE';
        CompanyAddress: Text;
        CompanyTelAndFax: Text;

        Text035: Label 'FOUR';
        Text036: Label 'FIVE';
        Text037: Label 'SIX';
        Text038: Label 'SEVEN';
        Text039: Label 'EIGHT';
        Text040: Label 'NINE';
        Text041: Label 'TEN';
        Text042: Label 'ELEVEN';
        Text043: Label 'TWELVE';
        Text044: Label 'THIRTEEN';
        Text045: Label 'FOURTEEN';
        Text046: Label 'FIFTEEN';
        Text047: Label 'SIXTEEN';
        Text048: Label 'SEVENTEEN';
        Text049: Label 'EIGHTEEN';
        Text050: Label 'NINETEEN';
        Text051: Label 'TWENTY';
        Text052: Label 'THIRTY';
        Text053: Label 'FORTY';
        Text054: Label 'FIFTY';
        Text055: Label 'SIXTY';
        Text056: Label 'SEVENTY';
        Text057: Label 'EIGHTY';
        Text058: Label 'NINETY';
        Text059: Label 'THOUSAND';
        Text060: Label 'MILLION';
        Text061: Label 'BILLION';
        Text062: Label 'G/L Account,Customer,Vendor,Bank Account';
        Text063: Label 'Net Amount %1';
        Text064: Label '%1 must not be %2 for %3 %4.';
        Text065: Label 'Subtotal';
        CheckNoTextCaptionLbl: Label 'Check No.';
        LineAmountCaptionLbl: Label 'Net Amount';
        LineDiscountCaptionLbl: Label 'Discount';
        AmountCaptionLbl: Label 'Amount';
        DocNoCaptionLbl: Label 'Document No.';
        DocDateCaptionLbl: Label 'Document Date';
        CurrencyCodeCaptionLbl: Label 'Currency Code';
        YourDocNoCaptionLbl: Label 'Your Doc. No.';
        TransportCaptionLbl: Label 'Transport';
        TotalAmt: Decimal;
        tvar: Decimal;
        AmtInwrd11: array[2] of Text;
        AmtInwrd12: Text;
        Amount_Words: array[2] of Text;
        Text: Text;
        AmountText1: Text;
        CurrCode: Code[20];
        FixedAssetRec: Record 5600;
        CustomerRec: Record 18;
        VendorRec: Record 23;
        cash_bank: Text;
        GLAcctRec: Record 15;
        Employee: Record 5200;
        SourceNo: Code[20];
        PaymentDesc: Text[100];
        Custledentry_Rec: Record 21;
        VendorLedEntry_Rec: Record 25;
        // InvoiceNo: Code[250];
        // InvoiceDate: Date;
        // DocumentType: Text;
        // Dimm1Code: Text;
        // OrgAmount: Decimal;
        Amount: Decimal;
        VendorLedEntry_Rec1: Record 25;
        Currency_Rec: Record 4;
        DecimalDesc: Text[20];
        Currcode1: Code[250];
        Users: Record User;
        UserName: Text;
        VendorLedgerEntry: Record "Vendor Ledger Entry";


    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        DecimalPosition: Decimal;

    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '';
        GLSetup.GET;

        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        ELSE
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                Ones := No DIV POWER(1000, Exponent - 1);
                Hundreds := Ones DIV 100;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    IF Ones > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                END ELSE
                    IF (Tens * 10 + Ones) > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1) THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;

        //AddToNoText(NoText,NoTextIndex,PrintExponent,Text028);
        //DecimalPosition := GetAmtDecimalPosition;
        //AddToNoText(NoText,NoTextIndex,PrintExponent,(FORMAT(No * DecimalPosition) + '/' + FORMAT(DecimalPosition)));

        IF CurrencyCode <> '' THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR(Text029, AddText);
        END;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;


    procedure InitTextVariable()
    begin
        OnesText[1] := Text032;
        OnesText[2] := Text033;
        OnesText[3] := Text034;
        OnesText[4] := Text035;
        OnesText[5] := Text036;
        OnesText[6] := Text037;
        OnesText[7] := Text038;
        OnesText[8] := Text039;
        OnesText[9] := Text040;
        OnesText[10] := Text041;
        OnesText[11] := Text042;
        OnesText[12] := Text043;
        OnesText[13] := Text044;
        OnesText[14] := Text045;
        OnesText[15] := Text046;
        OnesText[16] := Text047;
        OnesText[17] := Text048;
        OnesText[18] := Text049;
        OnesText[19] := Text050;

        TensText[1] := '';
        TensText[2] := Text051;
        TensText[3] := Text052;
        TensText[4] := Text053;
        TensText[5] := Text054;
        TensText[6] := Text055;
        TensText[7] := Text056;
        TensText[8] := Text057;
        TensText[9] := Text058;

        ExponentText[1] := '';
        ExponentText[2] := Text059;
        ExponentText[3] := Text060;
        ExponentText[4] := Text061;
    end;

    local procedure GetAmtDecimalPosition(): Decimal
    var
        Currency: Record 4;
    begin
        IF GenJnlLine."Currency Code" = '' THEN
            Currency.InitRoundingPrecision
        ELSE BEGIN
            Currency.GET(GenJnlLine."Currency Code");
            Currency.TESTFIELD("Amount Rounding Precision");
        END;
        EXIT(1 / Currency."Amount Rounding Precision");
    end;
}

