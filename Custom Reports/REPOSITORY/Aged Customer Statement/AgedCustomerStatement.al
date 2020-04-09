report 50163 "Aged Customer Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Custom Reports\REPOSITORY\Aged Customer Statement\Aged Accounts Receivable.rdlc';
    ApplicationArea = All;//Basic, Suite;
    Caption = 'Aged Customer Statement';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Header; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));
            column(TodayFormatted; TodayFormatted)
            {
            }
            column(CompanyName; CompanyDisplayName)
            {
            }
            column(Logo; RecCompanyInfo.Picture)
            {

            }
            column(FormatEndingDate; STRSUBSTNO(Text006, FORMAT(EndingDate, 0, 4)))
            {
            }
            column(PostingDate; STRSUBSTNO(Text007, SELECTSTR(AgingBy + 1, Text009)))
            {
            }
            column(PrintAmountInLCY; PrintAmountInLCY)
            {
            }
            column(TableCaptnCustFilter; TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(AgingByDueDate; AgingBy = AgingBy::"Due Date")
            {
            }
            column(AgedbyDocumnetDate; STRSUBSTNO(Text004, SELECTSTR(AgingBy + 1, Text009)))
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
            column(PrintDetails; PrintDetails)
            {
            }
            column(AgedAccReceivableCptn; AgedAccReceivableCptnLbl)
            {
            }
            column(CurrReportPageNoCptn; CurrReportPageNoCptnLbl)
            {
            }
            column(AllAmtinLCYCptn; AllAmtinLCYCptnLbl)
            {
            }
            column(AgedOverdueAmtCptn; AgedOverdueAmtCptnLbl)
            {
            }
            column(CLEEndDateAmtLCYCptn; CLEEndDateAmtLCYCptnLbl)
            {
            }
            column(CLEEndDateDueDateCptn; CLEEndDateDueDateCptnLbl)
            {
            }
            column(CLEEndDateDocNoCptn; CLEEndDateDocNoCptnLbl)
            {
            }
            column(CLEEndDatePstngDateCptn; CLEEndDatePstngDateCptnLbl)
            {
            }
            column(CLEEndDateDocTypeCptn; CLEEndDateDocTypeCptnLbl)
            {
            }
            column(OriginalAmtCptn; OriginalAmtCptnLbl)
            {
            }
            column(TotalLCYCptn; TotalLCYCptnLbl)
            {
            }
            column(NewPagePercustomer; NewPagePercustomer)
            {
            }
            column(GrandTotalCLE5RemAmt; GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE4RemAmt; GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE3RemAmt; GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE2RemAmt; GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE1RemAmt; GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLEAmtLCY; GrandTotalCustLedgEntry[1]."Amount (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE1CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE2CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE3CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE4CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE5CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE1AmtLCY; GrandTotalCustLedgEntry[1]."Amount (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE5PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE3PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE2PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE1PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE5RemAmtLCY; GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE4RemAmtLCY; GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE3RemAmtLCY; GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE2RemAmtLCY; GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE1RemAmtLCY; GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            dataitem(Customer; 18)
            {
                RequestFilterFields = "No.";
                column(PageGroupNo; PageGroupNo)
                {
                }
                dataitem("Cust. Ledger Entry"; 21)
                {
                    DataItemLink = "Customer No." = FIELD("No.");
                    DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code");

                    trigger OnAfterGetRecord()
                    var
                        CustLedgEntry: Record 21;
                    begin
                        CustLedgEntry.SETCURRENTKEY("Closed by Entry No.");
                        IF "Closed by Entry No." <> 0 THEN
                            CustLedgEntry.SETFILTER("Closed by Entry No.", '%1|%2', "Entry No.", "Closed by Entry No.")
                        ELSE
                            CustLedgEntry.SETRANGE("Closed by Entry No.", "Entry No.");
                        CustLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                        CopyDimFiltersFromCustomer(CustLedgEntry);
                        IF CustLedgEntry.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                InsertTemp(CustLedgEntry);
                            UNTIL CustLedgEntry.NEXT = 0;

                        CustLedgEntry.RESET;
                        CustLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                        CustLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                        CopyDimFiltersFromCustomer(CustLedgEntry);
                        IF CustLedgEntry.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                InsertTemp(CustLedgEntry);
                            UNTIL CustLedgEntry.NEXT = 0;
                        CurrReport.SKIP;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETRANGE("Posting Date", EndingDate + 1, DMY2DATE(31, 12, 9999));
                        CopyDimFiltersFromCustomer("Cust. Ledger Entry");
                    end;
                }
                dataitem(OpenCustLedgEntry; 21)
                {
                    DataItemLink = "Customer No." = FIELD("No.");
                    DataItemTableView = SORTING("Customer No.", Open, Positive, "Due Date", "Currency Code");

                    trigger OnAfterGetRecord()
                    begin
                        InsertTemp(OpenCustLedgEntry);
                        //Aswin
                        // CurrReport.SKIP;
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF AgingBy = AgingBy::"Posting Date" THEN BEGIN
                            SETRANGE("Posting Date", 0D, EndingDate);
                            SETRANGE("Date Filter", 0D, EndingDate);
                            SETAUTOCALCFIELDS("Remaining Amt. (LCY)");
                            SETFILTER("Remaining Amt. (LCY)", '<>0');
                        END;
                        CopyDimFiltersFromCustomer(OpenCustLedgEntry);
                    end;
                }
                dataitem(CurrencyLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    PrintOnlyIfDetail = true;
                    dataitem(TempCustLedgEntryLoop; 2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(Name1_Cust; Customer.Name)
                        {
                            IncludeCaption = true;
                        }
                        column(No_Cust; Customer."No.")
                        {
                            IncludeCaption = true;
                        }
                        column(CLEEndDateRemAmtLCY; CustLedgEntryEndingDate."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(AgedCLE1RemAmtLCY; AgedCustLedgEntry[1]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(AgedCLE2RemAmtLCY; AgedCustLedgEntry[2]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(AgedCLE3RemAmtLCY; AgedCustLedgEntry[3]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(AgedCLE4RemAmtLCY; AgedCustLedgEntry[4]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(AgedCLE5RemAmtLCY; AgedCustLedgEntry[5]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(CLEEndDateAmtLCY; CustLedgEntryEndingDate."Amount (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(CLEEndDueDate; FORMAT(CustLedgEntryEndingDate."Due Date"))
                        {
                        }
                        column(CLEEndDateDocNo; CustLedgEntryEndingDate."Document No.")
                        {
                        }
                        column(CLEDocType; FORMAT(CustLedgEntryEndingDate."Document Type"))
                        {
                        }
                        column(CLEExtDocNo; CustLedgEntryEndingDate."External Document No.")
                        {
                        }
                        column(CLENarration; CustLedgEntryEndingDate.Narration)
                        {
                        }
                        //Levtech-Start
                        column(OpportunityNo; OpportunityNo)
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
                        //Levtech-End
                        column(CLEPostingDate; FORMAT(CustLedgEntryEndingDate."Posting Date"))
                        {
                        }
                        column(AgedCLE5TempRemAmt; AgedCustLedgEntry[5]."Remaining Amount")
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AgedCLE4TempRemAmt; AgedCustLedgEntry[4]."Remaining Amount")
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AgedCLE3TempRemAmt; AgedCustLedgEntry[3]."Remaining Amount")
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AgedCLE2TempRemAmt; AgedCustLedgEntry[2]."Remaining Amount")
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AgedCLE1TempRemAmt; AgedCustLedgEntry[1]."Remaining Amount")
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(RemAmt_CLEEndDate; CustLedgEntryEndingDate."Remaining Amount")
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(CLEEndDate; CustLedgEntryEndingDate.Amount)
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Name_Cust; STRSUBSTNO(Text005, Customer.Name))
                        {
                        }
                        column(TotalCLE1AmtLCY; TotalCustLedgEntry[1]."Amount (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE1RemAmtLCY; TotalCustLedgEntry[1]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE2RemAmtLCY; TotalCustLedgEntry[2]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE3RemAmtLCY; TotalCustLedgEntry[3]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE4RemAmtLCY; TotalCustLedgEntry[4]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE5RemAmtLCY; TotalCustLedgEntry[5]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(CurrrencyCode; CurrencyCode)
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalCLE5RemAmt; TotalCustLedgEntry[5]."Remaining Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE4RemAmt; TotalCustLedgEntry[4]."Remaining Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE3RemAmt; TotalCustLedgEntry[3]."Remaining Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE2RemAmt; TotalCustLedgEntry[2]."Remaining Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE1RemAmt; TotalCustLedgEntry[1]."Remaining Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE1Amt; TotalCustLedgEntry[1].Amount)
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCheck; CustFilterCheck)
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            PeriodIndex: Integer;
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT TempCustLedgEntry.FINDSET(FALSE, FALSE) THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF TempCustLedgEntry.NEXT = 0 THEN
                                    CurrReport.BREAK;

                            CustLedgEntryEndingDate := TempCustLedgEntry;
                            //Levtech-Start
                            Clear(OpportunityNo);
                            Clear(SalesPerson);
                            Clear(ProjectName);
                            Clear(ProjectReference);
                            if TempCustLedgEntry."Document Type" = TempCustLedgEntry."Document Type"::Invoice then begin
                                Clear(SalesInvHeader);
                                SalesInvHeader.SetRange("No.", TempCustLedgEntry."Document No.");
                                if SalesInvHeader.FindFirst() then begin
                                    OpportunityNo := SalesInvHeader."Shortcut Dimension 1 Code";
                                    SalesPerson := SalesInvHeader."Salesperson Code";
                                    ProjectName := SalesInvHeader."Project Name";
                                    ProjectReference := SalesInvHeader."Project Reference";
                                end;
                            end;
                            //Levtech-End
                            DetailedCustomerLedgerEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntryEndingDate."Entry No.");
                            IF DetailedCustomerLedgerEntry.FINDSET(FALSE, FALSE) THEN
                                REPEAT
                                    IF (DetailedCustomerLedgerEntry."Entry Type" =
                                        DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry") AND
                                       (CustLedgEntryEndingDate."Posting Date" > EndingDate) AND
                                       (AgingBy <> AgingBy::"Posting Date")
                                    THEN BEGIN
                                        IF CustLedgEntryEndingDate."Document Date" <= EndingDate THEN
                                            DetailedCustomerLedgerEntry."Posting Date" :=
                                              CustLedgEntryEndingDate."Document Date"
                                        ELSE
                                            IF (CustLedgEntryEndingDate."Due Date" <= EndingDate) AND
                                               (AgingBy = AgingBy::"Due Date")
                                            THEN
                                                DetailedCustomerLedgerEntry."Posting Date" :=
                                                  CustLedgEntryEndingDate."Due Date"
                                    END;

                                    IF (DetailedCustomerLedgerEntry."Posting Date" <= EndingDate) OR
                                       (TempCustLedgEntry.Open AND
                                        (AgingBy = AgingBy::"Due Date") AND
                                        (CustLedgEntryEndingDate."Due Date" > EndingDate) AND
                                        (CustLedgEntryEndingDate."Posting Date" <= EndingDate))
                                    THEN BEGIN
                                        IF DetailedCustomerLedgerEntry."Entry Type" IN
                                           [DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Loss",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Gain",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Realized Loss",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Realized Gain",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Excl.)",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Adjustment)",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Excl.)",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Adjustment)",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Excl.)",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)"]
                                        THEN BEGIN
                                            CustLedgEntryEndingDate.Amount := CustLedgEntryEndingDate.Amount + DetailedCustomerLedgerEntry.Amount;
                                            CustLedgEntryEndingDate."Amount (LCY)" :=
                                              CustLedgEntryEndingDate."Amount (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                        END;
                                        IF DetailedCustomerLedgerEntry."Posting Date" <= EndingDate THEN BEGIN
                                            CustLedgEntryEndingDate."Remaining Amount" :=
                                              CustLedgEntryEndingDate."Remaining Amount" + DetailedCustomerLedgerEntry.Amount;
                                            CustLedgEntryEndingDate."Remaining Amt. (LCY)" :=
                                              CustLedgEntryEndingDate."Remaining Amt. (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                        END;
                                    END;
                                UNTIL DetailedCustomerLedgerEntry.NEXT = 0;

                            /*Aswin Suggested
                            IF CustLedgEntryEndingDate."Remaining Amount" = 0 THEN
                                CurrReport.SKIP;
                                */

                            CASE AgingBy OF
                                AgingBy::"Due Date":
                                    PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Due Date");
                                AgingBy::"Posting Date":
                                    PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Posting Date");
                                AgingBy::"Document Date":
                                    BEGIN
                                        IF CustLedgEntryEndingDate."Document Date" > EndingDate THEN BEGIN
                                            CustLedgEntryEndingDate."Remaining Amount" := 0;
                                            CustLedgEntryEndingDate."Remaining Amt. (LCY)" := 0;
                                            CustLedgEntryEndingDate."Document Date" := CustLedgEntryEndingDate."Posting Date";
                                        END;
                                        PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Document Date");
                                    END;
                            END;
                            CLEAR(AgedCustLedgEntry);
                            AgedCustLedgEntry[PeriodIndex]."Remaining Amount" := CustLedgEntryEndingDate."Remaining Amount";
                            AgedCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" := CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                            TotalCustLedgEntry[PeriodIndex]."Remaining Amount" += CustLedgEntryEndingDate."Remaining Amount";
                            TotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                            GrandTotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                            TotalCustLedgEntry[1].Amount += CustLedgEntryEndingDate."Remaining Amount";
                            TotalCustLedgEntry[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                            GrandTotalCustLedgEntry[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        end;

                        trigger OnPostDataItem()
                        begin
                            IF NOT PrintAmountInLCY THEN
                                UpdateCurrencyTotals;
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT PrintAmountInLCY THEN BEGIN
                                IF (TempCurrency.Code = '') OR (TempCurrency.Code = GLSetup."LCY Code") THEN
                                    TempCustLedgEntry.SETFILTER("Currency Code", '%1|%2', GLSetup."LCY Code", '')
                                ELSE
                                    TempCustLedgEntry.SETRANGE("Currency Code", TempCurrency.Code);
                            END;

                            PageGroupNo := NextPageGroupNo;
                            IF NewPagePercustomer AND (NumberOfCurrencies > 0) THEN
                                NextPageGroupNo := PageGroupNo + 1;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CLEAR(TotalCustLedgEntry);

                        IF Number = 1 THEN BEGIN
                            IF NOT TempCurrency.FINDSET(FALSE, FALSE) THEN
                                CurrReport.BREAK;
                        END ELSE
                            IF TempCurrency.NEXT = 0 THEN
                                CurrReport.BREAK;

                        IF TempCurrency.Code <> '' THEN
                            CurrencyCode := TempCurrency.Code
                        ELSE
                            CurrencyCode := GLSetup."LCY Code";

                        NumberOfCurrencies := NumberOfCurrencies + 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        NumberOfCurrencies := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF NewPagePercustomer THEN
                        PageGroupNo += 1;
                    TempCurrency.RESET;
                    TempCurrency.DELETEALL;
                    TempCustLedgEntry.RESET;
                    TempCustLedgEntry.DELETEALL;

                    // IF NOT CustomersWithLedgerEntriesList.Contains("No.") THEN
                    //   CurrReport.SKIP;
                    IF NOT CustomersWithLedgerEntriesListL.Contains("No.") THEN
                        CurrReport.SKIP;

                end;

                trigger OnPreDataItem()
                begin
                    // CustomersWithLedgerEntriesList := CustomersWithLedgerEntriesList.List;//KK

                    /*IF CustLedgEntryAll.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                           // IF NOT CustomersWithLedgerEntriesList.Contains(CustLedgEntryAll."Customer No.") THEN//KK
                           //     CustomersWithLedgerEntriesList.Add(CustLedgEntryAll."Customer No.");//KK
                        UNTIL CustLedgEntryAll.NEXT = 0;
                        */
                    IF CustLedgEntryAll.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            IF NOT CustomersWithLedgerEntriesListL.Contains(CustLedgEntryAll."Customer No.") THEN//KK
                                CustomersWithLedgerEntriesListL.Add(CustLedgEntryAll."Customer No.");//KK
                        UNTIL CustLedgEntryAll.NEXT = 0
                end;
            }
            dataitem(CurrencyTotals; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = FILTER(1 ..));
                column(CurrNo; Number = 1)
                {
                }
                column(TempCurrCode; TempCurrency2.Code)
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(AgedCLE6RemAmt; AgedCustLedgEntry[6]."Remaining Amount")
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(AgedCLE1RemAmt; AgedCustLedgEntry[1]."Remaining Amount")
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(AgedCLE2RemAmt; AgedCustLedgEntry[2]."Remaining Amount")
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(AgedCLE3RemAmt; AgedCustLedgEntry[3]."Remaining Amount")
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(AgedCLE4RemAmt; AgedCustLedgEntry[4]."Remaining Amount")
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(AgedCLE5RemAmt; AgedCustLedgEntry[5]."Remaining Amount")
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(CurrSpecificationCptn; CurrSpecificationCptnLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number = 1 THEN BEGIN
                        IF NOT TempCurrency2.FINDSET(FALSE, FALSE) THEN
                            CurrReport.BREAK;
                    END ELSE
                        IF TempCurrency2.NEXT = 0 THEN
                            CurrReport.BREAK;

                    CLEAR(AgedCustLedgEntry);
                    TempCurrencyAmount.SETRANGE("Currency Code", TempCurrency2.Code);
                    IF TempCurrencyAmount.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            IF TempCurrencyAmount.Date <> DMY2DATE(31, 12, 9999) THEN
                                AgedCustLedgEntry[GetPeriodIndex(TempCurrencyAmount.Date)]."Remaining Amount" :=
                                  TempCurrencyAmount.Amount
                            ELSE
                                AgedCustLedgEntry[6]."Remaining Amount" := TempCurrencyAmount.Amount;
                        UNTIL TempCurrencyAmount.NEXT = 0;
                end;
            }
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
                    field(AgedAsOf; EndingDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged As Of';
                        ToolTip = 'Specifies the date that you want the aging calculated for.';
                    }
                    field(Agingby; AgingBy)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aging by';
                        OptionCaption = 'Due Date,Posting Date,Document Date';
                        ToolTip = 'Specifies if the aging will be calculated from the due date, the posting date, or the document date.';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period Length';
                        ToolTip = 'Specifies the period for which data is shown in the report. For example, enter "1M" for one month, "30D" for thirty days, "3Q" for three quarters, or "5Y" for five years.';
                    }
                    field(AmountsinLCY; PrintAmountInLCY)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Amounts in LCY';
                        ToolTip = 'Specifies if you want the report to specify the aging per customer ledger entry.';
                    }
                    field(PrintDetails; PrintDetails)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Details';
                        ToolTip = 'Specifies if you want the report to show the detailed entries that add up the total balance for each customer.';
                    }
                    field(HeadingType; HeadingType)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Heading Type';
                        OptionCaption = 'Date Interval,Number of Days';
                        ToolTip = 'Specifies if the column heading for the three periods will indicate a date interval or the number of days overdue.';
                    }
                    field(perCustomer; NewPagePercustomer)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Page per Customer';
                        ToolTip = 'Specifies if each customer''s information is printed on a new page if you have chosen two or more customers to be included in the report.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF EndingDate = 0D THEN
                EndingDate := WORKDATE;
            IF FORMAT(PeriodLength) = '' THEN
                EVALUATE(PeriodLength, '<1M>');
        end;
    }

    labels
    {
        BalanceCaption = 'Balance';
    }

    trigger OnPreReport()
    var
        FormatDocument: Codeunit 368;
    begin
        CustFilter := FormatDocument.GetRecordFiltersWithCaptions(Customer);
        RecCompanyInfo.GET;
        RecCompanyInfo.CalcFields(Picture);
        GLSetup.GET;

        CalcDates;
        CreateHeadings;

        PageGroupNo := 1;
        NextPageGroupNo := 1;
        CustFilterCheck := (CustFilter <> 'No.');

        TodayFormatted := TypeHelper.GetFormattedCurrentDateTimeInUserTimeZone('f');
        CompanyDisplayName := COMPANYPROPERTY.DISPLAYNAME;
    end;

    var
        //Levtech
        SalesInvHeader: Record "Sales Invoice Header";
        OpportunityNo: Text;
        SalesPerson: Text;
        ProjectName: Text;
        ProjectReference: Text;
        CustomersWithLedgerEntriesListL: List of [Text];
        //Lebtech-End;
        GLSetup: Record 98;
        CustLedgEntryAll: Record 21;
        TempCustLedgEntry: Record 21 temporary;
        CustLedgEntryEndingDate: Record 21;
        TotalCustLedgEntry: array[5] of Record 21;
        GrandTotalCustLedgEntry: array[5] of Record 21;
        AgedCustLedgEntry: array[6] of Record 21;
        TempCurrency: Record 4 temporary;
        TempCurrency2: Record 4 temporary;
        TempCurrencyAmount: Record 264 temporary;
        DetailedCustomerLedgerEntry: Record 379;
        TypeHelper: Codeunit 10;
        //CustomersWithLedgerEntriesList: DotNet List_Of_T;
        CustFilter: Text;
        PrintAmountInLCY: Boolean;
        EndingDate: Date;
        AgingBy: Option "Due Date","Posting Date","Document Date";
        PeriodLength: DateFormula;
        PrintDetails: Boolean;
        HeadingType: Option "Date Interval","Number of Days";
        NewPagePercustomer: Boolean;
        PeriodStartDate: array[5] of Date;
        PeriodEndDate: array[5] of Date;
        HeaderText: array[5] of Text[30];
        Text000: Label 'Not Due';
        Text001: Label 'Before';
        CurrencyCode: Code[10];
        Text002: Label 'days';
        Text003: Label 'More than';
        Text004: Label 'Aged by %1';
        Text005: Label 'Total for %1';
        Text006: Label 'Aged as of %1';
        Text007: Label 'Aged by %1';
        NumberOfCurrencies: Integer;
        Text009: Label 'Due Date,Posting Date,Document Date';
        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.';
        PageGroupNo: Integer;
        NextPageGroupNo: Integer;
        CustFilterCheck: Boolean;
        Text032Txt: Label '-%1', Comment = 'Negating the period length: %1 is the period length';
        AgedAccReceivableCptnLbl: Label 'Aged Accounts Receivable';
        CurrReportPageNoCptnLbl: Label 'Page';
        AllAmtinLCYCptnLbl: Label 'All Amounts in LCY';
        AgedOverdueAmtCptnLbl: Label 'Aged Overdue Amounts';
        CLEEndDateAmtLCYCptnLbl: Label 'Original Amount ';
        CLEEndDateDueDateCptnLbl: Label 'Due Date';
        CLEEndDateDocNoCptnLbl: Label 'Document No.';
        CLEEndDatePstngDateCptnLbl: Label 'Posting Date';
        CLEEndDateDocTypeCptnLbl: Label 'Document Type';
        OriginalAmtCptnLbl: Label 'Currency Code';
        TotalLCYCptnLbl: Label 'Total (LCY)';
        CurrSpecificationCptnLbl: Label 'Currency Specification';
        EnterDateFormulaErr: Label 'Enter a date formula in the Period Length field.';
        TodayFormatted: Text;
        CompanyDisplayName: Text;
        RecCompanyInfo: Record "Company Information";

    local procedure CalcDates()
    var
        i: Integer;
        PeriodLength2: DateFormula;
    begin
        IF NOT EVALUATE(PeriodLength2, STRSUBSTNO(Text032Txt, PeriodLength)) THEN
            ERROR(EnterDateFormulaErr);
        IF AgingBy = AgingBy::"Due Date" THEN BEGIN
            PeriodEndDate[1] := DMY2DATE(31, 12, 9999);
            PeriodStartDate[1] := EndingDate + 1;
        END ELSE BEGIN
            PeriodEndDate[1] := EndingDate;
            PeriodStartDate[1] := CALCDATE(PeriodLength2, EndingDate + 1);
        END;
        FOR i := 2 TO ARRAYLEN(PeriodEndDate) DO BEGIN
            PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
            PeriodStartDate[i] := CALCDATE(PeriodLength2, PeriodEndDate[i] + 1);
        END;
        PeriodStartDate[i] := 0D;

        FOR i := 1 TO ARRAYLEN(PeriodEndDate) DO
            IF PeriodEndDate[i] < PeriodStartDate[i] THEN
                ERROR(Text010, PeriodLength);
    end;

    local procedure CreateHeadings()
    var
        i: Integer;
    begin
        IF AgingBy = AgingBy::"Due Date" THEN BEGIN
            HeaderText[1] := Text000;
            i := 2;
        END ELSE
            i := 1;
        WHILE i < ARRAYLEN(PeriodEndDate) DO BEGIN
            IF HeadingType = HeadingType::"Date Interval" THEN
                HeaderText[i] := STRSUBSTNO('%1\..%2', PeriodStartDate[i], PeriodEndDate[i])
            ELSE
                HeaderText[i] :=
                  STRSUBSTNO('%1 - %2 %3', EndingDate - PeriodEndDate[i] + 1, EndingDate - PeriodStartDate[i] + 1, Text002);
            i := i + 1;
        END;
        IF HeadingType = HeadingType::"Date Interval" THEN
            HeaderText[i] := STRSUBSTNO('%1 %2', Text001, PeriodStartDate[i - 1])
        ELSE
            HeaderText[i] := STRSUBSTNO('%1 \%2 %3', Text003, EndingDate - PeriodStartDate[i - 1] + 1, Text002);
    end;

    local procedure InsertTemp(var CustLedgEntry: Record 21)
    var
        Currency: Record 4;
    begin
        WITH TempCustLedgEntry DO BEGIN
            IF GET(CustLedgEntry."Entry No.") THEN
                EXIT;
            TempCustLedgEntry := CustLedgEntry;
            INSERT;
            IF PrintAmountInLCY THEN BEGIN
                CLEAR(TempCurrency);
                TempCurrency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
                IF TempCurrency.INSERT THEN;
                EXIT;
            END;
            IF TempCurrency.GET("Currency Code") THEN
                EXIT;
            IF TempCurrency.GET('') AND ("Currency Code" = GLSetup."LCY Code") THEN
                EXIT;
            IF TempCurrency.GET(GLSetup."LCY Code") AND ("Currency Code" = '') THEN
                EXIT;
            IF "Currency Code" <> '' THEN
                Currency.GET("Currency Code")
            ELSE BEGIN
                CLEAR(Currency);
                Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
            END;
            TempCurrency := Currency;
            TempCurrency.INSERT;
        END;
    end;

    local procedure GetPeriodIndex(Date: Date): Integer
    var
        i: Integer;
    begin
        FOR i := 1 TO ARRAYLEN(PeriodEndDate) DO
            IF Date IN [PeriodStartDate[i] .. PeriodEndDate[i]] THEN
                EXIT(i);
    end;

    local procedure Pct(a: Decimal; b: Decimal): Text[30]
    begin
        IF b <> 0 THEN
            EXIT(FORMAT(ROUND(100 * a / b, 0.1), 0, '<Sign><Integer><Decimals,2>') + '%');
    end;

    local procedure UpdateCurrencyTotals()
    var
        i: Integer;
    begin
        TempCurrency2.Code := CurrencyCode;
        IF TempCurrency2.INSERT THEN;
        WITH TempCurrencyAmount DO BEGIN
            FOR i := 1 TO ARRAYLEN(TotalCustLedgEntry) DO BEGIN
                "Currency Code" := CurrencyCode;
                Date := PeriodStartDate[i];
                IF FIND THEN BEGIN
                    Amount := Amount + TotalCustLedgEntry[i]."Remaining Amount";
                    MODIFY;
                END ELSE BEGIN
                    "Currency Code" := CurrencyCode;
                    Date := PeriodStartDate[i];
                    Amount := TotalCustLedgEntry[i]."Remaining Amount";
                    INSERT;
                END;
            END;
            "Currency Code" := CurrencyCode;
            Date := DMY2DATE(31, 12, 9999);
            IF FIND THEN BEGIN
                Amount := Amount + TotalCustLedgEntry[1].Amount;
                MODIFY;
            END ELSE BEGIN
                "Currency Code" := CurrencyCode;
                Date := DMY2DATE(31, 12, 9999);
                Amount := TotalCustLedgEntry[1].Amount;
                INSERT;
            END;
        END;
    end;


    procedure InitializeRequest(NewEndingDate: Date; NewAgingBy: Option; NewPeriodLength: DateFormula; NewPrintAmountInLCY: Boolean; NewPrintDetails: Boolean; NewHeadingType: Option; NewPagePercust: Boolean)
    begin
        EndingDate := NewEndingDate;
        AgingBy := NewAgingBy;
        PeriodLength := NewPeriodLength;
        PrintAmountInLCY := NewPrintAmountInLCY;
        PrintDetails := NewPrintDetails;
        HeadingType := NewHeadingType;
        NewPagePercustomer := NewPagePercust;
    end;

    local procedure CopyDimFiltersFromCustomer(var CustLedgerEntry: Record 21)
    begin
        IF Customer.GETFILTER("Global Dimension 1 Filter") <> '' THEN
            CustLedgerEntry.SETFILTER("Global Dimension 1 Code", Customer.GETFILTER("Global Dimension 1 Filter"));
        IF Customer.GETFILTER("Global Dimension 2 Filter") <> '' THEN
            CustLedgerEntry.SETFILTER("Global Dimension 2 Code", Customer.GETFILTER("Global Dimension 2 Filter"));
    end;
}

