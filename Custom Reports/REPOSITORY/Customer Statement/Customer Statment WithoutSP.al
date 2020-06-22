report 50109 "Customer Statement Without SP"
{
    RDLCLayout = 'Custom Reports\REPOSITORY\Customer Statement\Standard Statement WithoutSP.rdlc';
    WordLayout = 'Custom Reports\REPOSITORY\Customer Statement\Standard Statement_By Krishna - WS.docx';
    Caption = 'Standard Statements Without SalesPerson';
    DefaultLayout = Word;
    //ApplicationArea = All;
    //UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Print Statements", "Currency Filter";
            column(No_Cust; "No.")
            {
            }

            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                PrintOnlyIfDetail = true;

                column(CompanyPicture; CompanyInfo.Picture)
                {
                }
                column(CompanyInfo1Picture; CompanyInfo1.Picture)
                {
                }
                column(CompanyInfo2Picture; CompanyInfo2.Picture)
                {
                }
                column(CompanyInfo3Picture; CompanyInfo3.Picture)
                {
                }
                column(CustAddr1; CustAddr[1])
                {
                }
                column(CompanyAddr1; CompanyAddr[1])
                {
                }
                column(CustAddr2; CustAddr[2])
                {
                }
                column(CompanyAddr2; CompanyAddr[2])
                {
                }
                column(CustAddr3; CustAddr[3])
                {
                }
                column(CompanyAddr3; CompanyAddr[3])
                {
                }
                column(CustAddr4; CustAddr[4])
                {
                }
                column(CompanyAddr4; CompanyAddr[4])
                {
                }
                column(CustAddr5; CustAddr[5])
                {
                }
                column(CompanyAddr5; CompanyAddr[5])
                {
                }
                column(PhoneNo_CompanyInfo; CompanyInfo."Phone No.")
                {
                }
                column(CustAddr6; CustAddr[6])
                {
                }
                column(CompanyAddr6; CompanyAddr[6])
                {
                }
                column(CompanyInfoEmail; CompanyInfo."E-Mail")
                {
                }
                column(CompanyInfoHomePage; CompanyInfo."Home Page")
                {
                }
                column(VATRegNo_CompanyInfo; CompanyInfo."VAT Registration No.")
                {
                }
                column(GiroNo_CompanyInfo; CompanyInfo."Giro No.")
                {
                }
                column(BankName_CompanyInfo; CompanyInfo."Bank Name")
                {
                }
                column(BankAccNo_CompanyInfo; CompanyInfo."Bank Account No.")
                {
                }
                column(No1_Cust; Customer."No.")
                {
                }
                column(TodayFormatted; FORMAT(TODAY))
                {
                }
                column(StartDate; FORMAT(StartDate))
                {
                }
                column(EndDate; FORMAT(EndDate))
                {
                }
                column(LastStatmntNo_Cust; FORMAT(Customer."Last Statement No."))
                {
                }
                column(CustAddr7; CustAddr[7])
                {
                }
                column(CustAddr8; CustAddr[8])
                {
                }
                column(CompanyAddr7; CompanyAddr[7])
                {
                }
                column(CompanyAddr8; CompanyAddr[8])
                {
                }
                column(StatementCaption; StatementCaptionLbl)
                {
                }
                column(PhoneNo_CompanyInfoCaption; PhoneNo_CompanyInfoCaptionLbl)
                {
                }
                column(VATRegNo_CompanyInfoCaption; VATRegNo_CompanyInfoCaptionLbl)
                {
                }
                column(GiroNo_CompanyInfoCaption; GiroNo_CompanyInfoCaptionLbl)
                {
                }
                column(BankName_CompanyInfoCaption; BankName_CompanyInfoCaptionLbl)
                {
                }
                column(BankAccNo_CompanyInfoCaption; BankAccNo_CompanyInfoCaptionLbl)
                {
                }
                column(No1_CustCaption; No1_CustCaptionLbl)
                {
                }
                column(StartDateCaption; StartDateCaptionLbl)
                {
                }
                column(EndDateCaption; EndDateCaptionLbl)
                {
                }
                column(LastStatmntNo_CustCaption; LastStatmntNo_CustCaptionLbl)
                {
                }
                column(PostDate_DtldCustLedgEntriesCaption; PostDate_DtldCustLedgEntriesCaptionLbl)
                {
                }
                column(DocNo_DtldCustLedgEntriesCaption; DtldCustLedgEntries.FIELDCAPTION("Document No."))
                {
                }
                column(Desc_CustLedgEntry2Caption; CustLedgEntry2.FIELDCAPTION(Description))
                {
                }
                column(Narr_CustLedgEntry2Caption; CustLedgEntry2.FIELDCAPTION(Narration))
                {
                }
                column(DueDate_CustLedgEntry2Caption; DueDate_CustLedgEntry2CaptionLbl)
                {
                }
                column(RemainAmtCustLedgEntry2Caption; CustLedgEntry2.FIELDCAPTION("Remaining Amount"))
                {
                }
                column(CustBalanceCaption; CustBalanceCaptionLbl)
                {
                }
                column(OriginalAmt_CustLedgEntry2Caption; CustLedgEntry2.FIELDCAPTION("Original Amount"))
                {
                }
                column(CompanyInfoHomepageCaption; CompanyInfoHomepageCaptionLbl)
                {
                }
                column(CompanyInfoEmailCaption; CompanyInfoEmailCaptionLbl)
                {
                }
                column(DocDateCaption; DocDateCaptionLbl)
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                column(CompanyLegalOffice; CompanyInfo.GetLegalOffice)
                {
                }
                column(CompanyLegalOffice_Lbl; CompanyInfo.GetLegalOfficeLbl)
                {
                }
                dataitem(CurrencyLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    PrintOnlyIfDetail = true;
                    column(Total_Caption2; Total_CaptionLbl)
                    {
                    }
                    dataitem(CustLedgEntryHdr; 2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(Currency2Code_CustLedgEntryHdr; STRSUBSTNO(EntriesLbl, CurrencyCode3))
                        {
                        }
                        column(StartBalance; StartBalance)
                        {
                            AutoFormatExpression = TempCurrency2.Code;
                            AutoFormatType = 1;
                        }
                        column(CurrencyCode3; CurrencyCode3)
                        {
                        }
                        column(CustBalance_CustLedgEntryHdr; CustBalance)
                        {
                        }
                        column(PrintLine; PrintLine)
                        {
                        }
                        column(DtldCustLedgEntryType; FORMAT(DtldCustLedgEntries."Entry Type", 0, 2))
                        {
                        }
                        column(EntriesExists; EntriesExists)
                        {
                        }
                        column(IsNewCustCurrencyGroup; IsNewCustCurrencyGroup)
                        {
                        }
                        dataitem(DtldCustLedgEntries; 379)
                        {
                            DataItemTableView = SORTING("Customer No.", "Posting Date", "Entry Type", "Currency Code");
                            column(PostDate_DtldCustLedgEntries; FORMAT("Posting Date"))
                            {
                            }
                            column(DocNo_DtldCustLedgEntries; "Document No.")
                            {
                            }
                            column(Description; Description)
                            {
                            }
                            column(DueDate_DtldCustLedgEntries; FORMAT(DueDate))
                            {
                            }
                            column(CurrCode_DtldCustLedgEntries; "Currency Code")
                            {
                            }
                            column(Amt_DtldCustLedgEntries; Amount)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(RemainAmt_DtldCustLedgEntries; RemainingAmount)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(CustBalance; CustBalance)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(Currency2Code; TempCurrency2.Code)
                            {
                            }
                            //Levtech-Start
                            column(OpportunityNo; LPORef)
                            {

                            }
                            column(SalesPerson; SalesPerson)
                            {

                            }
                            column(ProjectName; ProjectName)
                            {

                            }
                            column(ProjectReference; ProjectReference)
                            {

                            }
                            column(ExtDocNo; ExtDocNo)
                            {

                            }
                            column(Narration; Narration)
                            {
                            }
                            column(AdditionalSalesPerson; AdditionalSalesPerson)
                            {

                            }
                            column(DescNarration; DescNarration)
                            {
                            }
                            column(SoNo; SoNo)
                            {

                            }
                            //Levtech-End

                            trigger OnAfterGetRecord()
                            var
                                SILine: Record "Sales Invoice Line";
                                Sheader: Record "Sales Header";
                            begin
                                IF SkipReversedUnapplied(DtldCustLedgEntries) OR (Amount = 0) THEN
                                    CurrReport.SKIP;
                                RemainingAmount := 0;
                                PrintLine := TRUE;

                                //Levtech-Start
                                Clear(OpportunityNo);
                                Clear(SalesPerson);
                                Clear(ProjectName);
                                Clear(ExtDocNo);
                                Clear(Narration);
                                Clear(SoNo);
                                Clear(LPORef);
                                Clear(ProjectReference);
                                Clear(CustLedgerEntryG);
                                Clear(DescNarration);
                                if CustLedgerEntryG.GET("Cust. Ledger Entry No.") then begin

                                    if CustLedgerEntryG."Document Type" = CustLedgerEntryG."Document Type"::Invoice then begin
                                        Clear(SalesInvHeader);
                                        SalesInvHeader.SetRange("No.", CustLedgerEntryG."Document No.");
                                        if SalesInvHeader.FindFirst() then begin
                                            // OpportunityNo := SalesInvHeader."Shortcut Dimension 1 Code";
                                            If AdditionalSalesPerson then
                                                SalesPerson := ''
                                            else
                                                SalesPerson := SalesInvHeader."Salesperson Code";
                                            ProjectName := SalesInvHeader."Project Name";
                                            ProjectReference := SalesInvHeader."Project Reference";
                                            Clear(SILine);
                                            SILine.SetRange("Document No.", SalesInvHeader."No.");
                                            SILine.SetFilter("Sales Order No.", '<>%1', '');
                                            if SILine.FindFirst() then begin
                                                SoNo := SILine."Sales Order No.";
                                                Clear(Sheader);
                                                IF Sheader.GET(Sheader."Document Type"::Order, SILine."Sales Order No.") then
                                                    LPORef := Sheader."PO Reference";
                                            end;

                                        end;
                                    end;
                                    ExtDocNo := CustLedgerEntryG."External Document No.";
                                    Narration := CustLedgerEntryG.Narration;
                                end;
                                //Levtech-End
                                CASE "Entry Type" OF
                                    "Entry Type"::"Initial Entry":
                                        BEGIN
                                            CustLedgerEntry.GET("Cust. Ledger Entry No.");
                                            Description := CustLedgerEntry.Description;
                                            DueDate := CustLedgerEntry."Due Date";
                                            CustLedgerEntry.SETRANGE("Date Filter", 0D, EndDate);
                                            CustLedgerEntry.CALCFIELDS("Remaining Amount");
                                            RemainingAmount := CustLedgerEntry."Remaining Amount";
                                            CustLedgerEntry.SETRANGE("Date Filter");
                                        END;
                                    "Entry Type"::Application:
                                        BEGIN
                                            DetailedCustLedgEntry2.SETCURRENTKEY("Customer No.", "Posting Date", "Entry Type");
                                            DetailedCustLedgEntry2.SETRANGE("Customer No.", "Customer No.");
                                            DetailedCustLedgEntry2.SETRANGE("Posting Date", "Posting Date");
                                            DetailedCustLedgEntry2.SETRANGE("Entry Type", "Entry Type"::Application);
                                            DetailedCustLedgEntry2.SETRANGE("Transaction No.", "Transaction No.");
                                            DetailedCustLedgEntry2.SETFILTER("Currency Code", '<>%1', "Currency Code");
                                            IF NOT DetailedCustLedgEntry2.ISEMPTY THEN BEGIN
                                                Description := MulticurrencyAppLbl;
                                                DueDate := 0D;
                                            END ELSE
                                                CurrReport.SKIP;
                                        END;
                                    "Entry Type"::"Payment Discount",
                                    "Entry Type"::"Payment Discount (VAT Excl.)",
                                    "Entry Type"::"Payment Discount (VAT Adjustment)",
                                    "Entry Type"::"Payment Discount Tolerance",
                                    "Entry Type"::"Payment Discount Tolerance (VAT Excl.)",
                                    "Entry Type"::"Payment Discount Tolerance (VAT Adjustment)":
                                        BEGIN
                                            Description := PaymentDiscountLbl;
                                            DueDate := 0D;
                                        END;
                                    "Entry Type"::"Payment Tolerance",
                                    "Entry Type"::"Payment Tolerance (VAT Excl.)",
                                    "Entry Type"::"Payment Tolerance (VAT Adjustment)":
                                        BEGIN
                                            Description := WriteoffsLbl;
                                            DueDate := 0D;
                                        END;
                                    "Entry Type"::"Appln. Rounding",
                                    "Entry Type"::"Correction of Remaining Amount":
                                        BEGIN
                                            Description := RoundingLbl;
                                            DueDate := 0D;
                                        END;
                                END;
                                CustBalance := CustBalance + Amount;
                                IsNewCustCurrencyGroup := IsFirstPrintLine;
                                IsFirstPrintLine := FALSE;
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Customer No.", Customer."No.");
                                SETRANGE("Posting Date", StartDate, EndDate);
                                SETRANGE("Currency Code", TempCurrency2.Code);

                                IF TempCurrency2.Code = '' THEN BEGIN
                                    GLSetup.TESTFIELD("LCY Code");
                                    CurrencyCode3 := GLSetup."LCY Code"
                                END ELSE
                                    CurrencyCode3 := TempCurrency2.Code;

                                IsFirstPrintLine := TRUE;
                            end;
                        }
                    }
                    dataitem(CustLedgEntryFooter; 2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(CurrencyCode3_CustLedgEntryFooter; CurrencyCode3)
                        {
                        }
                        column(Total_Caption; Total_CaptionLbl)
                        {
                        }
                        column(CustBalance_CustLedgEntryHdrFooter; CustBalance)
                        {
                            AutoFormatExpression = TempCurrency2.Code;
                            AutoFormatType = 1;
                        }
                        column(EntriesExistsl_CustLedgEntryFooterCaption; EntriesExists)
                        {
                        }
                    }
                    dataitem(OverdueVisible; 2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(Total_Caption3; Total_CaptionLbl)
                        {
                        }
                        column(PostDate_DtldCustLedgEntriesCaption2; PostDate_DtldCustLedgEntriesCaptionLbl)
                        {
                        }
                        column(DocNo_DtldCustLedgEntriesCaption2; DtldCustLedgEntries.FIELDCAPTION("Document No."))
                        {
                        }
                        column(Desc_CustLedgEntry2Caption2; CustLedgEntry2.FIELDCAPTION(Description))
                        {
                        }
                        column(Narr_CustLedgEntry2Caption2; CustLedgEntry2.FIELDCAPTION(Narration))
                        {
                        }
                        column(DueDate_CustLedgEntry2Caption2; DueDate_CustLedgEntry2CaptionLbl)
                        {
                        }
                        column(RemainAmtCustLedgEntry2Caption2; CustLedgEntry2.FIELDCAPTION("Remaining Amount"))
                        {
                        }
                        column(OriginalAmt_CustLedgEntry2Caption2; CustLedgEntry2.FIELDCAPTION("Original Amount"))
                        {
                        }
                        dataitem(CustLedgEntry2; 21)
                        {
                            DataItemLink = "Customer No." = FIELD("No.");
                            DataItemLinkReference = Customer;
                            DataItemTableView = SORTING("Customer No.", Open, Positive, "Due Date");
                            column(OverDueEntries; STRSUBSTNO(OverdueEntriesLbl, TempCurrency2.Code))
                            {
                            }
                            column(RemainAmt_CustLedgEntry2; "Remaining Amount")
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(PostDate_CustLedgEntry2; FORMAT("Posting Date"))
                            {
                            }
                            column(DocNo_CustLedgEntry2; "Document No.")
                            {
                            }
                            column(Desc_CustLedgEntry2; Description)
                            {
                            }
                            //Levtech-Start1
                            column(opportunity2; LPORef2)
                            {

                            }
                            column(SalesPerson2; SalesPerson2)
                            {

                            }
                            column(ProjectName2; ProjectName2)
                            {

                            }
                            column(ProjectRef2; ProjectRef2)
                            {

                            }
                            column(SoNo2; SoNo2)
                            {

                            }
                            //Levtech-End
                            column(ExtDocNo2; ExtDocNo)
                            {

                            }
                            column(Narration2; Narration)
                            {

                            }
                            column(DueDate_CustLedgEntry2; FORMAT("Due Date"))
                            {
                            }
                            column(OriginalAmt_CustLedgEntry2; "Original Amount")
                            {
                                AutoFormatExpression = "Currency Code";
                            }
                            column(CurrCode_CustLedgEntry2; "Currency Code")
                            {
                            }
                            column(PrintEntriesDue; PrintEntriesDue)
                            {
                            }
                            column(Currency2Code_CustLedgEntry2; TempCurrency2.Code)
                            {
                            }
                            column(CurrencyCode3_CustLedgEntry2; CurrencyCode3)
                            {
                            }
                            column(CustNo_CustLedgEntry2; "Customer No.")
                            {
                            }


                            trigger OnAfterGetRecord()
                            var
                                CustLedgEntry: Record 21;
                                SILine: Record "Sales Invoice Line";
                                Sheader: Record "Sales Header";
                            begin
                                IF IncludeAgingBand THEN
                                    IF ("Posting Date" > EndDate) AND ("Due Date" >= EndDate) THEN
                                        CurrReport.SKIP;
                                CustLedgEntry := CustLedgEntry2;
                                CustLedgEntry.SETRANGE("Date Filter", 0D, EndDate);
                                CustLedgEntry.CALCFIELDS("Remaining Amount");
                                "Remaining Amount" := CustLedgEntry."Remaining Amount";
                                IF CustLedgEntry."Remaining Amount" = 0 THEN
                                    CurrReport.SKIP;

                                IF "Due Date" >= EndDate THEN
                                    CurrReport.SKIP;
                                CustBalance2 := CustBalance2 + CustLedgEntry."Remaining Amount";


                                //Levtech-Start1
                                Clear(opportunity2);
                                Clear(SalesPerson2);
                                Clear(ProjectName2);
                                Clear(ProjectRef2);
                                Clear(LPORef2);
                                if CustLedgEntry2."Document Type" = CustLedgEntry2."Document Type"::Invoice then begin
                                    Clear(SalesInvHeader);
                                    SalesInvHeader.SetRange("No.", CustLedgEntry2."Document No.");
                                    if SalesInvHeader.FindFirst() then begin
                                        //opportunity2 := SalesInvHeader."Shortcut Dimension 1 Code";
                                        If AdditionalSalesPerson then
                                            SalesPerson2 := ''
                                        else
                                            SalesPerson2 := SalesInvHeader."Salesperson Code";
                                        ProjectName2 := SalesInvHeader."Project Name";
                                        ProjectRef2 := SalesInvHeader."Project Reference";
                                        Clear(SILine);
                                        SILine.SetRange("Document No.", SalesInvHeader."No.");
                                        SILine.SetFilter("Sales Order No.", '<>%1', '');
                                        if SILine.FindFirst() then begin
                                            SoNo2 := SILine."Sales Order No.";
                                            Clear(Sheader);
                                            IF Sheader.GET(Sheader."Document Type"::Order, SILine."Sales Order No.") then
                                                LPORef2 := Sheader."PO Reference";
                                        end;
                                    end;
                                end;
                                //Levtech-End
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT IncludeAgingBand THEN
                                    SETRANGE("Due Date", 0D, EndDate - 1);
                                SETRANGE("Currency Code", TempCurrency2.Code);
                                IF (NOT PrintEntriesDue) AND (NOT IncludeAgingBand) THEN
                                    CurrReport.BREAK;
                            end;
                        }
                        dataitem(OverdueEntryFooder; 2000000026)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = CONST(1));
                            column(OverdueBalance; CustBalance2)
                            {
                            }

                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT PrintEntriesDue THEN
                                CurrReport.BREAK;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Number = 1 THEN
                            TempCurrency2.FINDFIRST;

                        REPEAT
                            IF NOT IsFirstLoop THEN
                                IsFirstLoop := TRUE
                            ELSE
                                IF TempCurrency2.NEXT = 0 THEN
                                    CurrReport.BREAK;
                            CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Currency Code");
                            CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                            CustLedgerEntry.SETRANGE("Posting Date", 0D, EndDate);
                            CustLedgerEntry.SETRANGE("Currency Code", TempCurrency2.Code);
                            EntriesExists := NOT CustLedgerEntry.ISEMPTY;
                        UNTIL EntriesExists;
                        Cust2 := Customer;
                        Cust2.SETRANGE("Date Filter", 0D, StartDate - 1);
                        Cust2.SETRANGE("Currency Filter", TempCurrency2.Code);
                        Cust2.CALCFIELDS("Net Change");
                        StartBalance := Cust2."Net Change";
                        CustBalance := Cust2."Net Change";
                        CustBalance2 := 0;
                    end;

                    trigger OnPreDataItem()
                    begin
                        Customer.COPYFILTER("Currency Filter", TempCurrency2.Code);
                    end;
                }
                dataitem(AgingBandVisible; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    dataitem(AgingCustLedgEntry; 21)
                    {
                        DataItemLink = "Customer No." = FIELD("No.");
                        DataItemLinkReference = Customer;
                        DataItemTableView = SORTING("Customer No.", Open, Positive, "Due Date");

                        trigger OnAfterGetRecord()
                        var
                            CustLedgEntry: Record 21;
                        begin
                            IF ("Posting Date" > EndDate) AND ("Due Date" >= EndDate) THEN
                                CurrReport.SKIP;
                            IF DateChoice = DateChoice::"Due Date" THEN
                                IF "Due Date" >= EndDate THEN
                                    CurrReport.SKIP;
                            CustLedgEntry := AgingCustLedgEntry;
                            CustLedgEntry.SETRANGE("Date Filter", 0D, EndDate);
                            CustLedgEntry.CALCFIELDS("Remaining Amount");
                            "Remaining Amount" := CustLedgEntry."Remaining Amount";
                            IF CustLedgEntry."Remaining Amount" = 0 THEN
                                CurrReport.SKIP;

                            IF "Posting Date" <= EndDate THEN
                                UpdateBuffer("Currency Code", GetDate("Posting Date", "Due Date"), "Remaining Amount");
                        end;

                        trigger OnPreDataItem()
                        begin
                            Customer.COPYFILTER("Currency Filter", "Currency Code");
                            SETCURRENTKEY("Customer No.", "Posting Date", "Currency Code");
                            SETRANGE("Customer No.", Customer."No.");
                            SETRANGE("Posting Date", 0D, EndDate);
                        end;
                    }
                    dataitem(AgingBandLoop; 2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));

                        column(HeaderText6; HeaderText[6])
                        {
                        }
                        column(HeaderText5; HeaderText[5])
                        {
                        }
                        column(HeaderText4; HeaderText[4])
                        {
                        }
                        column(HeaderText3; HeaderText[3])
                        {
                        }
                        column(HeaderText2; HeaderText[2])
                        {
                        }
                        column(HeaderText1; HeaderText[1])
                        {
                        }
                        column(AgingDate1; FORMAT(AgingDate[1] + 1))
                        {
                        }
                        column(AgingDate2; FORMAT(AgingDate[2]))
                        {
                        }
                        column(AgingDate21; FORMAT(AgingDate[2] + 1))
                        {
                        }
                        column(AgingDate3; FORMAT(AgingDate[3]))
                        {
                        }
                        column(AgingDate31; FORMAT(AgingDate[3] + 1))
                        {
                        }
                        column(AgingDate4; FORMAT(AgingDate[4]))
                        {
                        }
                        column(AgingBandEndingDate; STRSUBSTNO(AgedSummaryLbl, AgingBandEndingDate, PeriodLength, SELECTSTR(DateChoice + 1, DuePostingDateLbl)))
                        {
                        }
                        column(AgingDate41; FORMAT(AgingDate[4] + 1))
                        {
                        }
                        column(AgingDate5; FORMAT(AgingDate[5]))
                        {
                        }
                        column(AgingBandBufCol1Amt; TempAgingBandBuf."Column 1 Amt.")
                        {
                            AutoFormatExpression = TempAgingBandBuf."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AgingBandBufCol2Amt; TempAgingBandBuf."Column 2 Amt.")
                        {
                            AutoFormatExpression = TempAgingBandBuf."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AgingBandBufCol3Amt; TempAgingBandBuf."Column 3 Amt.")
                        {
                            AutoFormatExpression = TempAgingBandBuf."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AgingBandBufCol4Amt; TempAgingBandBuf."Column 4 Amt.")
                        {
                            AutoFormatExpression = TempAgingBandBuf."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AgingBandBufCol5Amt; TempAgingBandBuf."Column 5 Amt.")
                        {
                            AutoFormatExpression = TempAgingBandBuf."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(OverdueBalance1; TempAgingBandBuf."Column 1 Amt." + TempAgingBandBuf."Column 2 Amt." + TempAgingBandBuf."Column 3 Amt." + TempAgingBandBuf."Column 4 Amt." + TempAgingBandBuf."Column 5 Amt.")
                        {
                            AutoFormatExpression = TempAgingBandBuf."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AgingBandCurrencyCode; AgingBandCurrencyCode)
                        {
                        }
                        column(beforeCaption; beforeCaptionLbl)
                        {
                        }
                        column(AgingDateHeader1; AgingDateHeader1)
                        {
                        }
                        column(AgingDateHeader2; AgingDateHeader2)
                        {
                        }
                        column(AgingDateHeader3; AgingDateHeader3)
                        {
                        }
                        column(AgingDateHeader4; AgingDateHeader4)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT TempAgingBandBuf.FIND('-') THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF TempAgingBandBuf.NEXT = 0 THEN
                                    CurrReport.BREAK;
                            AgingBandCurrencyCode := TempAgingBandBuf."Currency Code";
                            IF AgingBandCurrencyCode = '' THEN
                                AgingBandCurrencyCode := GLSetup."LCY Code";
                        end;
                    }

                    trigger OnPreDataItem()
                    begin
                        IF NOT IncludeAgingBand THEN
                            CurrReport.BREAK
                    end;
                }
            }
            dataitem(LetterText; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(GreetingText; GreetingLbl)
                {
                }
                column(BodyText; BodyLbl)
                {
                }
                column(ClosingText; ClosingLbl)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                TempAgingBandBuf.DELETEALL;
                CurrReport.LANGUAGE := 1033;//Language.GetLanguageID("Language Code");
                PrintLine := FALSE;
                Cust2 := Customer;
                COPYFILTER("Currency Filter", TempCurrency2.Code);
                IF PrintAllHavingBal THEN BEGIN
                    IF TempCurrency2.FIND('-') THEN
                        REPEAT
                            Cust2.SETRANGE("Date Filter", 0D, EndDate);
                            Cust2.SETRANGE("Currency Filter", TempCurrency2.Code);
                            Cust2.CALCFIELDS("Net Change");
                            PrintLine := Cust2."Net Change" <> 0;
                        UNTIL (TempCurrency2.NEXT = 0) OR PrintLine;
                END;
                IF (NOT PrintLine) AND PrintAllHavingEntry THEN BEGIN
                    CustLedgerEntry.RESET;
                    CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date");
                    CustLedgerEntry.SETRANGE("Customer No.", "No.");
                    CustLedgerEntry.SETRANGE("Posting Date", StartDate, EndDate);
                    COPYFILTER("Currency Filter", CustLedgerEntry."Currency Code");
                    PrintLine := NOT CustLedgerEntry.ISEMPTY;
                END;
                IF NOT PrintLine THEN
                    CurrReport.SKIP;

                FormatAddr.Customer(CustAddr, Customer);
                // CurrReport.PAGENO := 1;

                IF NOT IsReportInPreviewMode THEN BEGIN
                    LOCKTABLE;
                    FIND;
                    "Last Statement No." := "Last Statement No." + 1;
                    MODIFY;
                    COMMIT;
                END ELSE
                    "Last Statement No." := "Last Statement No." + 1;

                IsFirstLoop := FALSE;
            end;

            trigger OnPreDataItem()
            begin
                VerifyDates;
                AgingBandEndingDate := EndDate;
                CalcAgingBandDates;

                CompanyInfo.GET;
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                CompanyInfo.CALCFIELDS(Picture);

                TempCurrency2.Code := '';
                TempCurrency2.INSERT;
                COPYFILTER("Currency Filter", Currency.Code);
                IF Currency.FIND('-') THEN
                    REPEAT
                        TempCurrency2 := Currency;
                        TempCurrency2.INSERT;
                    UNTIL Currency.NEXT = 0;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Start Date"; StartDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Start Date';
                        ToolTip = 'Specifies the date from which the report or batch job processes information.';
                    }
                    field("End Date"; EndDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'End Date';
                        ToolTip = 'Specifies the date to which the report or batch job processes information.';
                    }
                    field(ShowOverdueEntries; PrintEntriesDue)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Overdue Entries';
                        ToolTip = 'Specifies if you want overdue entries to be shown separately for each currency.';
                    }
                    group(Include)
                    {
                        Caption = 'Include';
                        field(IncludeAllCustomerswithLE; PrintAllHavingEntry)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Include All Customers with Ledger Entries';
                            MultiLine = true;
                            ToolTip = 'Specifies if you want entries displayed for customers that have ledger entries at the end of the selected period.';

                            trigger OnValidate()
                            begin
                                IF NOT PrintAllHavingEntry THEN
                                    PrintAllHavingBal := TRUE;
                            end;
                        }
                        field(IncludeAllCustomerswithBalance; PrintAllHavingBal)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Include All Customers with a Balance';
                            MultiLine = true;
                            ToolTip = 'Specifies if you want entries displayed for customers that have a balance at the end of the selected period.';

                            trigger OnValidate()
                            begin
                                IF NOT PrintAllHavingBal THEN
                                    PrintAllHavingEntry := TRUE;
                            end;
                        }
                        field(IncludeReversedEntries; PrintReversedEntries)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Include Reversed Entries';
                            ToolTip = 'Specifies if you want to include reversed entries in the report.';
                        }
                        field(IncludeUnappliedEntries; PrintUnappliedEntries)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Include Unapplied Entries';
                            ToolTip = 'Specifies if you want to include unapplied entries in the report.';
                        }
                    }
                    group("Aging Band")
                    {
                        Caption = 'Aging Band';
                        field(IncludeAgingBand; IncludeAgingBand)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Include Aging Band';
                            ToolTip = 'Specifies if you want an aging band to be included in the document. If you select the check box, then you must also fill the Aging Band Period Length and Aging Band by fields.';
                        }
                        field(AgingBandPeriodLengt; PeriodLength)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Aging Band Period Length';
                            ToolTip = 'Specifies the length of each of the four periods in the aging band, for example, enter "1M" for one month. The most recent period will end on the last day of the period in the Date Filter field.';
                        }
                        field(AgingBandby; DateChoice)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Aging Band by';
                            OptionCaption = 'Due Date,Posting Date';
                            ToolTip = 'Specifies if the aging band will be calculated from the due date or from the posting date.';
                        }
                        field(AdditionalSalesPerson; AdditionalSalesPerson)
                        {
                            ApplicationArea = All;
                            Caption = 'Sales Person';

                        }
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies if you want the program to log this interaction.';
                    }
                }
                group("Output Options")
                {
                    Caption = 'Output Options';
                    field(ReportOutput; SupportedOutputMethod)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Report Output';
                        OptionCaption = 'Print,Preview,Word,PDF,Email,XML - RDLC layouts only', Comment = 'Each item is a verb/action - to print, to preview, to export to Word, export to PDF, send email, export to XML for RDLC layouts only';
                        ToolTip = 'Specifies the output of the scheduled report, such as PDF or Word.';

                        trigger OnValidate()
                        var
                            CustomLayoutReporting: Codeunit 8800;
                        begin
                            ShowPrintRemaining := (SupportedOutputMethod = SupportedOutputMethod::Email);

                            CASE SupportedOutputMethod OF
                                SupportedOutputMethod::Print:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPrintOption;
                                SupportedOutputMethod::Preview:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPreviewOption;
                                SupportedOutputMethod::Word:
                                    ChosenOutputMethod := CustomLayoutReporting.GetWordOption;
                                SupportedOutputMethod::PDF:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPDFOption;
                                SupportedOutputMethod::Email:
                                    ChosenOutputMethod := CustomLayoutReporting.GetEmailOption;
                                SupportedOutputMethod::XML:
                                    ChosenOutputMethod := CustomLayoutReporting.GetXMLOption;
                            END;
                        end;
                    }
                    field(ChosenOutput; ChosenOutputMethod)
                    {
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                    }
                    group(EmailOptions)
                    {
                        Caption = 'Email Options';
                        Visible = ShowPrintRemaining;
                        field(PrintMissingAddresses; PrintRemaining)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Print remaining statements';
                            ToolTip = 'Specifies that amounts remaining to be paid will be included.';
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            InitRequestPageDataInternal;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
        SalesSetup.GET;

        CASE SalesSetup."Logo Position on Documents" OF
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                BEGIN
                    CompanyInfo1.GET;
                    CompanyInfo1.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Center:
                BEGIN
                    CompanyInfo2.GET;
                    CompanyInfo2.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Right:
                BEGIN
                    CompanyInfo3.GET;
                    CompanyInfo3.CALCFIELDS(Picture);
                END;
        END;

        LogInteractionEnable := TRUE;
    end;

    trigger OnPostReport()
    begin
        IF LogInteraction AND NOT IsReportInPreviewMode THEN
            IF Customer.FINDSET THEN
                REPEAT
                    SegManagement.LogDocument(
                      7, FORMAT(Customer."Last Statement No."), 0, 0, DATABASE::Customer, Customer."No.", Customer."Salesperson Code", '',
                      StatementLbl + FORMAT(Customer."Last Statement No."), '');
                UNTIL Customer.NEXT = 0;
    end;

    trigger OnPreReport()
    begin
        InitRequestPageDataInternal;
    end;

    var
        EntriesLbl: Label 'Entries %1', Comment = '%1 = Currency code';
        OverdueEntriesLbl: Label 'Overdue Entries %1', Comment = '%1=Currency code';
        StatementLbl: Label 'Statement ';
        GLSetup: Record 98;
        SalesInvHeader: Record "Sales Invoice Header";
        OpportunityNo: Text;
        ExtDocNo: Text;
        Narration: Text;
        SalesPerson: Text;
        AdditionalSalesPerson: Boolean;
        ProjectName: Text;
        ProjectReference: Text;
        SalesSetup: Record 311;
        CompanyInfo: Record 79;
        CompanyInfo1: Record 79;
        CompanyInfo2: Record 79;
        CompanyInfo3: Record 79;
        Cust2: Record 18;
        Currency: Record 4;
        TempCurrency2: Record 4 temporary;
        Language: Record 8;
        CustLedgerEntry: Record 21;
        DetailedCustLedgEntry2: Record 379;
        TempAgingBandBuf: Record 47 temporary;
        FormatAddr: Codeunit 365;
        SegManagement: Codeunit 5051;
        PrintAllHavingEntry: Boolean;
        PrintAllHavingBal: Boolean;
        PrintEntriesDue: Boolean;
        PrintUnappliedEntries: Boolean;
        PrintReversedEntries: Boolean;
        PrintLine: Boolean;
        LogInteraction: Boolean;
        EntriesExists: Boolean;
        StartDate: Date;
        EndDate: Date;
        DueDate: Date;
        CustAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        Description: Text[100];
        DescNarration: Text;
        StartBalance: Decimal;
        CustBalance: Decimal;
        RemainingAmount: Decimal;
        CurrencyCode3: Code[10];
        MulticurrencyAppLbl: Label 'Multicurrency Application';
        PaymentDiscountLbl: Label 'Payment Discount';
        RoundingLbl: Label 'Rounding';
        PeriodLength: DateFormula;
        PeriodLength2: DateFormula;
        DateChoice: Option "Due Date","Posting Date";
        AgingDate: array[5] of Date;
        AgingBandPeriodErr: Label 'You must specify the Aging Band Period Length.';
        AgingBandEndingDate: Date;
        AgingBandEndErr: Label 'You must specify Aging Band Ending Date.';
        AgedSummaryLbl: Label 'Aged Summary by %1 (%2 by %3)', Comment = '%1=Report aging band end date, %2=Aging band period, %3=Type of deadline (''due date'', ''posting date'') as given in DuePostingDateLbl';
        IncludeAgingBand: Boolean;
        PeriodLengthErr: Label 'Period Length is out of range.';
        AgingBandCurrencyCode: Code[20];
        DuePostingDateLbl: Label 'Due Date,Posting Date';
        WriteoffsLbl: Label 'Application Writeoffs';
        [InDataSet]
        LogInteractionEnable: Boolean;
        PeriodSeparatorLbl: Label '-%1', Comment = 'Negating the period length: %1 is the period length';
        StatementCaptionLbl: Label 'Statement';
        PhoneNo_CompanyInfoCaptionLbl: Label 'Phone No.';
        VATRegNo_CompanyInfoCaptionLbl: Label 'Tax Registration No.';
        GiroNo_CompanyInfoCaptionLbl: Label 'Giro No.';
        BankName_CompanyInfoCaptionLbl: Label 'Bank';
        BankAccNo_CompanyInfoCaptionLbl: Label 'Account No.';
        No1_CustCaptionLbl: Label 'Customer No.';
        StartDateCaptionLbl: Label 'Starting Date';
        EndDateCaptionLbl: Label 'Ending Date';
        LastStatmntNo_CustCaptionLbl: Label 'Statement No.';
        PostDate_DtldCustLedgEntriesCaptionLbl: Label 'Posting Date';
        DueDate_CustLedgEntry2CaptionLbl: Label 'Due Date';
        CustBalanceCaptionLbl: Label 'Balance';
        beforeCaptionLbl: Label '..before';
        isInitialized: Boolean;
        CompanyInfoHomepageCaptionLbl: Label 'Home Page';
        CompanyInfoEmailCaptionLbl: Label 'Email';
        DocDateCaptionLbl: Label 'Document Date';
        Total_CaptionLbl: Label 'Total';
        BlankStartDateErr: Label 'Start Date must have a value.';
        BlankEndDateErr: Label 'End Date must have a value.';
        StartDateLaterTheEndDateErr: Label 'Start date must be earlier than End date.';
        IsFirstLoop: Boolean;
        CurrReportPageNoCaptionLbl: Label 'Page';
        IsFirstPrintLine: Boolean;
        IsNewCustCurrencyGroup: Boolean;
        AgingDateHeader1: Text;
        AgingDateHeader2: Text;
        AgingDateHeader3: Text;
        AgingDateHeader4: Text;
        SupportedOutputMethod: Option Print,Preview,Word,PDF,Email,XML;
        ChosenOutputMethod: Integer;
        PrintRemaining: Boolean;
        [InDataSet]
        ShowPrintRemaining: Boolean;
        CustBalance2: Decimal;
        CustBalance3: Decimal;
        GreetingLbl: Label 'Hello';
        ClosingLbl: Label 'Sincerely';
        BodyLbl: Label 'Thank you for your business. Your statement is attached to this message.';
        CustLedgerEntryG: Record "Cust. Ledger Entry";
        ProjectName2: Text;
        ProjectRef2: Text;
        SalesPerson2: Text;
        opportunity2: Text;
        SoNo: Text;
        SoNo2: Text;
        LPORef: Text;
        LPORef2: Text;
        PeriodStartDate: array[6] of Date;
        PeriodEndDate: array[6] of Date;
        HeaderText: array[6] of Text[30];

        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.';
        Text000: Label 'Not Due';
        Text001: Label 'Before';
        Text002: Label 'days';
        Text003: Label 'More than';

    local procedure GetDate(PostingDate: Date; DueDate: Date): Date
    begin
        IF DateChoice = DateChoice::"Posting Date" THEN
            EXIT(PostingDate);

        EXIT(DueDate);
    end;

    local procedure CalcAgingBandDates()
    var
        i: Integer;
    begin
        IF NOT IncludeAgingBand THEN
            EXIT;
        IF AgingBandEndingDate = 0D THEN
            ERROR(AgingBandEndErr);
        IF FORMAT(PeriodLength) = '' THEN
            ERROR(AgingBandPeriodErr);
        // EVALUATE(PeriodLength, '<30D>');
        EVALUATE(PeriodLength2, STRSUBSTNO(PeriodSeparatorLbl, PeriodLength));

        AgingDate[5] := AgingBandEndingDate;
        AgingDate[4] := CALCDATE(PeriodLength2, AgingDate[5]);
        AgingDate[3] := CALCDATE(PeriodLength2, AgingDate[4]);
        AgingDate[2] := CALCDATE(PeriodLength2, AgingDate[3]);
        AgingDate[1] := CALCDATE(PeriodLength2, AgingDate[2]);
        IF AgingDate[2] <= AgingDate[1] THEN
            ERROR(PeriodLengthErr);

        AgingDateHeader1 := FORMAT(AgingDate[1]) + ' - ' + FORMAT(AgingDate[2]);
        AgingDateHeader2 := FORMAT(AgingDate[2] + 1) + ' - ' + FORMAT(AgingDate[3]);
        AgingDateHeader3 := FORMAT(AgingDate[3] + 1) + ' - ' + FORMAT(AgingDate[4]);
        AgingDateHeader4 := FORMAT(AgingDate[4] + 1);


        //Krishna- to calculate agin days

        HeaderText[2] := StrSubstNo('1-%1 Days', FORMAT(AgingDate[5] - (AgingDate[4] + 1 - 1)));

        HeaderText[3] := StrSubstNo('%1-%2 Days', FORMAT(AgingDate[5] + 1 - (AgingDate[4] + 1 - 1)), FORMAT(AgingDate[5] - (AgingDate[3] + 1 - 1)));
        HeaderText[4] := StrSubstNo('%1-%2 Days', FORMAT(AgingDate[5] + 1 - (AgingDate[3] + 1 - 1)), FORMAT(AgingDate[5] - (AgingDate[2] + 1 - 1)));
        HeaderText[5] := StrSubstNo('%1-%2 Days', FORMAT(AgingDate[5] + 1 - (AgingDate[2] + 1 - 1)), FORMAT(AgingDate[5] - (AgingDate[1] + 1 - 1)));
        HeaderText[6] := StrSubstNo('More than %1 Days', FORMAT(AgingDate[5] + 1 - (AgingDate[1] + 1 - 1)));
        //Krishna-End



        /*//Start Ramesh 8/6/2020
        PeriodEndDate[1] := DMY2Date(31, 12, 9999);
        PeriodStartDate[1] := EndDate + 1;

        for i := 2 to ArrayLen(PeriodEndDate) do begin
            PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
            PeriodStartDate[i] := CalcDate(PeriodLength2, PeriodEndDate[i] + 1);
        end;
        PeriodStartDate[i] := 0D;

        for i := 1 to ArrayLen(PeriodEndDate) do
            if PeriodEndDate[i] < PeriodStartDate[i] then
                Error(Text010, PeriodLength);


        HeaderText[1] := Text000;
        i := 2;

        while i < ArrayLen(PeriodEndDate) do begin
            HeaderText[i] := StrSubstNo('%1 - %2 %3', EndDate - PeriodEndDate[i] + 1, EndDate - PeriodStartDate[i] + 1, Text002);
            i := i + 1;
        end;
        HeaderText[i] := StrSubstNo('%1 \%2 %3', Text003, EndDate - PeriodStartDate[i - 1] + 1, Text002);

        //End Ramesh 8/6/2020*/
    end;

    local procedure UpdateBuffer(CurrencyCode: Code[10]; Date: Date; Amount: Decimal)
    var
        I: Integer;
        GoOn: Boolean;
    begin
        TempAgingBandBuf.INIT;
        TempAgingBandBuf."Currency Code" := CurrencyCode;
        IF NOT TempAgingBandBuf.FIND THEN
            TempAgingBandBuf.INSERT;
        I := 1;
        GoOn := TRUE;
        WHILE (I <= 5) AND GoOn DO BEGIN
            IF Date <= AgingDate[I] THEN
                IF I = 1 THEN BEGIN
                    TempAgingBandBuf."Column 1 Amt." := TempAgingBandBuf."Column 1 Amt." + Amount;
                    GoOn := FALSE;
                END;
            IF Date <= AgingDate[I] THEN
                IF I = 2 THEN BEGIN
                    TempAgingBandBuf."Column 2 Amt." := TempAgingBandBuf."Column 2 Amt." + Amount;
                    GoOn := FALSE;
                END;
            IF Date <= AgingDate[I] THEN
                IF I = 3 THEN BEGIN
                    TempAgingBandBuf."Column 3 Amt." := TempAgingBandBuf."Column 3 Amt." + Amount;
                    GoOn := FALSE;
                END;
            IF Date <= AgingDate[I] THEN
                IF I = 4 THEN BEGIN
                    TempAgingBandBuf."Column 4 Amt." := TempAgingBandBuf."Column 4 Amt." + Amount;
                    GoOn := FALSE;
                END;
            IF Date <= AgingDate[I] THEN
                IF I = 5 THEN BEGIN
                    TempAgingBandBuf."Column 5 Amt." := TempAgingBandBuf."Column 5 Amt." + Amount;
                    GoOn := FALSE;
                END;
            I := I + 1;
        END;
        TempAgingBandBuf.MODIFY;
    end;


    procedure SkipReversedUnapplied(var DetailedCustLedgEntry: Record 379): Boolean
    var
        CustLedgEntry: Record 21;
    begin
        IF PrintReversedEntries AND PrintUnappliedEntries THEN
            EXIT(FALSE);
        IF NOT PrintUnappliedEntries THEN
            IF DetailedCustLedgEntry.Unapplied THEN
                EXIT(TRUE);
        IF NOT PrintReversedEntries THEN BEGIN
            CustLedgEntry.GET(DetailedCustLedgEntry."Cust. Ledger Entry No.");
            IF CustLedgEntry.Reversed THEN
                EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;


    procedure InitializeRequest(NewPrintEntriesDue: Boolean; NewPrintAllHavingEntry: Boolean; NewPrintAllHavingBal: Boolean; NewPrintReversedEntries: Boolean; NewPrintUnappliedEntries: Boolean; NewIncludeAgingBand: Boolean; NewPeriodLength: Text[30]; NewDateChoice: Option "Due Date","Posting Date"; NewLogInteraction: Boolean; NewStartDate: Date; NewEndDate: Date)
    begin
        InitRequestPageDataInternal;

        PrintEntriesDue := NewPrintEntriesDue;
        PrintAllHavingEntry := NewPrintAllHavingEntry;
        PrintAllHavingBal := NewPrintAllHavingBal;
        PrintReversedEntries := NewPrintReversedEntries;
        PrintUnappliedEntries := NewPrintUnappliedEntries;
        IncludeAgingBand := NewIncludeAgingBand;
        EVALUATE(PeriodLength, NewPeriodLength);
        DateChoice := NewDateChoice;
        LogInteraction := NewLogInteraction;
        StartDate := NewStartDate;
        EndDate := NewEndDate;
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit 9520;
    begin
        EXIT(CurrReport.PREVIEW OR MailManagement.IsHandlingGetEmailBody);
    end;


    procedure InitRequestPageDataInternal()
    begin
        IF isInitialized THEN
            EXIT;

        isInitialized := TRUE;

        IF (NOT PrintAllHavingEntry) AND (NOT PrintAllHavingBal) THEN
            PrintAllHavingBal := TRUE;

        LogInteraction := SegManagement.FindInteractTmplCode(7) <> '';
        LogInteractionEnable := LogInteraction;

        IF FORMAT(PeriodLength) = '' THEN
            EVALUATE(PeriodLength, '<1M+CM>');

        ShowPrintRemaining := (SupportedOutputMethod = SupportedOutputMethod::Email);
    end;

    local procedure VerifyDates()
    begin
        IF StartDate = 0D THEN
            ERROR(BlankStartDateErr);
        IF EndDate = 0D THEN
            ERROR(BlankEndDateErr);
        IF StartDate > EndDate THEN
            ERROR(StartDateLaterTheEndDateErr);
    end;
}

