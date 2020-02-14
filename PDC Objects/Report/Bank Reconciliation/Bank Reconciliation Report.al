report 60008 "Bank Reconciliation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'PDC Objects\Report\Bank Reconciliation\Bank Reconciliation Report.rdlc';
    Caption = 'Bank Reconciliation Report';
    // UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            DataItemTableView = SORTING("No.");
            column(Bank_Account___No__________Bank_Account__Name___Bank_Reconciliation_as_on___FORMAT_AsOnDate_; "Bank Account"."No." + ' : ' + "Bank Account".Name + ' Bank Reconciliation as on ' + FORMAT(AsOnDate))
            {
            }
            column(AsOnDate; AsOnDate)
            {
            }
            column(AsOnDate_Control1000000071; AsOnDate)
            {
            }
            column(CompanyImage; CompanyInfo.Picture)
            {
            }
            column(AmtAsPerBank; AmtAsPerBank)
            {
            }
            column(UserName; UserName)
            {
            }
            column(DifferenceAmt; DifferenceAmt)
            {
            }
            column(AmtDebitedByUs; AmtDebitedByUs)
            {
            }
            column(AmtCreditedByUs; AmtCreditedByUs)
            {
            }
            column(AmtDebitedByBank; AmtDebitedByBank)
            {
            }
            column(AmtCreditedByBank; AmtCreditedByBank)
            {
            }
            column(AmtAsPerBook; AmtAsPerBook)
            {
            }
            column(V1Caption; V1CaptionLbl)
            {
            }
            column(BALANCE_IN_OUR_BOOK_AS_ON_Caption; BALANCE_IN_OUR_BOOK_AS_ON_CaptionLbl)
            {
            }
            column(A_Caption; A_CaptionLbl)
            {
            }
            column(B_Caption; B_CaptionLbl)
            {
            }
            column(C_Caption; C_CaptionLbl)
            {
            }
            column(D_Caption; D_CaptionLbl)
            {
            }
            column(E_Caption; E_CaptionLbl)
            {
            }
            column(Add_Caption; Add_CaptionLbl)
            {
            }
            column(Less_Caption; Less_CaptionLbl)
            {
            }
            column(Add_Caption_Control1000000047; Add_Caption_Control1000000047Lbl)
            {
            }
            column(Less_Caption_Control1000000048; Less_Caption_Control1000000048Lbl)
            {
            }
            column(Less_Caption_Control1000000049; Less_Caption_Control1000000049Lbl)
            {
            }
            column(AMOUNT_CREDITED_BY_BANK_NOT_ENTERED_IN_BOOKSCaption; AMOUNT_CREDITED_BY_BANK_NOT_ENTERED_IN_BOOKSCaptionLbl)
            {
            }
            column(AMOUNT_DEBITED_BY_BANK_NOT_ENTERED_IN_BOOKSCaption; AMOUNT_DEBITED_BY_BANK_NOT_ENTERED_IN_BOOKSCaptionLbl)
            {
            }
            column(AMOUNT_CREDITED_IN_BOOKS_NOT_FOUND_IN_BANKCaption; AMOUNT_CREDITED_IN_BOOKS_NOT_FOUND_IN_BANKCaptionLbl)
            {
            }
            column(AMOUNT_DEBITED_IN_BOOKS_NOT_FOUND_IN_BANK_STATEMENTCaption; AMOUNT_DEBITED_IN_BOOKS_NOT_FOUND_IN_BANK_STATEMENTCaptionLbl)
            {
            }
            column(DIFFRENCECaption; DIFFRENCECaptionLbl)
            {
            }
            column(V2Caption; V2CaptionLbl)
            {
            }
            column(BALANCE_AS_PER_BANK_STATEMENT_AS_ON_Caption; BALANCE_AS_PER_BANK_STATEMENT_AS_ON_CaptionLbl)
            {
            }
            column(SUMMARYCaption; SUMMARYCaptionLbl)
            {
            }
            column(Bank_Account_No_; "No.")
            {
            }
            column(PrintSummary; PrintSummary)
            {
            }
            dataitem("Summary 1"; 274)
            {
                DataItemLink = "Bank Account No." = FIELD("No.");
                DataItemTableView = SORTING("Bank Account No.", "Statement No.", "Statement Line No.")
                                    WHERE("Statement Amount" = FILTER(> 0),
                                          "Applied Amount" = FILTER(0));
                column(Summary_1__Summary_1__Description; "Summary 1".Description)
                {
                }
                column(Summary_1__Summary_1___Statement_Amount_; "Summary 1"."Statement Amount")
                {
                }
                column(Summary_1__Summary_1___Transaction_Date_; "Summary 1"."Transaction Date")
                {
                }
                column(Summary_1__Summary_1___Check_No__; "Summary 1"."Check No.")
                {
                }
                column(ABS__Summary_1___Statement_Amount__; ABS("Summary 1"."Statement Amount"))
                {
                }
                column(Summary_1_Bank_Account_No_; "Bank Account No.")
                {
                }
                column(Summary_1_Statement_No_; "Statement No.")
                {
                }
                column(Summary_1_Statement_Line_No_; "Statement Line No.")
                {
                }
                column(ExternalRefNo; "Additional Transaction Info")
                {
                }

                trigger OnPreDataItem()
                begin
                    //SETRANGE("Bank Account No.",StatementHeader."Bank Account No.");
                    SETFILTER("Statement No.", StatementHeader."Statement No.");
                end;
            }
            dataitem("Summary 2"; 274)
            {
                DataItemLink = "Bank Account No." = FIELD("No.");
                DataItemTableView = SORTING("Bank Account No.", "Statement No.", "Statement Line No.")
                                    WHERE("Statement Amount" = FILTER(< 0),
                                          "Applied Amount" = FILTER(0));
                column(Summary_2__Summary_2__Description; "Summary 2".Description)
                {
                }
                column(Summary_2__Summary_2___Statement_Amount_; "Summary 2"."Statement Amount")
                {
                }
                column(Summary_2__Summary_2___Transaction_Date_; "Summary 2"."Transaction Date")
                {
                }
                column(Summary_2__Summary_2___Check_No__; "Summary 2"."Check No.")
                {
                }
                column(ABS__Summary_2___Statement_Amount__; ABS("Summary 2"."Statement Amount"))
                {
                }
                column(Summary_2_Bank_Account_No_; "Bank Account No.")
                {
                }
                column(Summary_2_Statement_No_; "Statement No.")
                {
                }
                column(Summary_2_Statement_Line_No_; "Statement Line No.")
                {
                }
                column(ExternalRefNo2; "Additional Transaction Info")
                {
                }

                trigger OnPreDataItem()
                begin
                    //SETRANGE("Bank Account No.",BankRecoHeader1."Bank Account No.");
                    SETFILTER("Statement No.", StatementHeader."Statement No.");
                end;
            }
            dataitem("Summary 3"; 271)
            {
                DataItemLink = "Bank Account No." = FIELD("No.");
                DataItemTableView = SORTING("Bank Account No.", "Posting Date")
                                    ORDER(Ascending)
                                    WHERE("Credit Amount (LCY)" = FILTER(<> 0));
                column(Summary_3__Summary_3___Credit_Amount__LCY__; "Summary 3"."Credit Amount (LCY)")
                {
                }
                column(Summary_3__Summary_3___Posting_Date_; "Summary 3"."Posting Date")
                {
                }
                column(Summary_3__Summary_3__Description; "Summary 3".Description)
                {
                }
                column(Summary_3__Summary_3___Credit_Amount__LCY___Control1000000023; "Summary 3"."Credit Amount (LCY)")
                {
                }
                column(Summary_3_Entry_No_; "Entry No.")
                {
                }
                column(ExternalDocNo; "External Document No.")
                {
                }
                column(DocumentNo; "Document No.")
                {
                }

                trigger OnPreDataItem()
                begin
                    SETFILTER("Posting Date", '<=%1', AsOnDate);
                    SETRANGE("Statement Status", "Statement Status"::Open);
                    //SETFILTER("Credit Amount (LCY)",'<>%1',0);
                end;
            }
            dataitem("Summary 4"; 271)
            {
                DataItemLink = "Bank Account No." = FIELD("No.");
                DataItemTableView = SORTING("Bank Account No.", "Posting Date")
                                    ORDER(Ascending)
                                    WHERE("Debit Amount (LCY)" = FILTER(<> 0));
                column(Summary_4__Summary_4__Description; "Summary 4".Description)
                {
                }
                column(Summary_4__Summary_4___Debit_Amount__LCY__; "Summary 4"."Debit Amount (LCY)")
                {
                }
                column(Summary_4__Summary_4___Posting_Date_; "Summary 4"."Posting Date")
                {
                }
                column(Summary_4__Summary_4___Debit_Amount__LCY___Control1000000062; "Summary 4"."Debit Amount")
                {
                }
                column(Summary_4_Entry_No_; "Entry No.")
                {
                }
                column(ExternalDocNo2; "External Document No.")
                {
                }
                column(DocumentNo2; "Document No.")
                {
                }

                trigger OnPreDataItem()
                begin
                    SETFILTER("Posting Date", '<=%1', AsOnDate);
                    SETRANGE("Statement Status", "Statement Status"::Open);
                    //SETFILTER("Debit Amount (LCY)",'<>%1',0);
                end;
            }
            dataitem("Summary 5"; 274)
            {
                DataItemLink = "Bank Account No." = FIELD("No.");
                DataItemTableView = SORTING("Bank Account No.", "Statement No.", "Statement Line No.")
                                    WHERE("Applied Amount" = FILTER(<> 0));
                column(Summary_5__Summary_5__Description; "Summary 5".Description)
                {
                }
                column(Summary_5__Summary_5___Statement_Amount_; "Summary 5"."Statement Amount")
                {
                }
                column(Summary_5__Summary_5___Transaction_Date_; "Summary 5"."Transaction Date")
                {
                }
                column(ABS__Summary_5___Statement_Amount__; "Summary 5".Difference)
                {
                }
                column(Summary_5_Bank_Account_No_; "Bank Account No.")
                {
                }
                column(Summary_5_Statement_No_; "Statement No.")
                {
                }
                column(Summary_5_Statement_Line_No_; "Statement Line No.")
                {
                }
                column(ExternalRefNo3; "Additional Transaction Info")
                {
                }

                trigger OnPreDataItem()
                begin
                    //SETRANGE("Bank Account No.",BankRecoHeader1."Bank Account No.");
                    SETFILTER("Statement No.", StatementHeader."Statement No.");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                BankLedger.RESET;
                BankLedger.SETCURRENTKEY("Bank Account No.", "Posting Date");
                BankLedger.SETRANGE("Bank Account No.", "No.");
                BankLedger.SETFILTER("Posting Date", '<=%1', AsOnDate);
                BankLedger.CALCSUMS("Amount (LCY)");

                AmtAsPerBook := BankLedger."Amount (LCY)";

                IF AmtAsPerBook = 0 THEN
                    CurrReport.SKIP;

                AmtAsPerBank := 0;
                AmtDebitedByUs := 0;
                AmtCreditedByUs := 0;
                AmtCreditedByBank := 0;
                AmtDebitedByBank := 0;
                DifferenceAmt := 0;
                CLEAR(StatementHeader);

                StatementHeader.RESET;
                StatementHeader.SETRANGE("Bank Account No.", "No.");
                StatementHeader.SETFILTER("Statement Date", '%1', AsOnDate);
                IF StatementHeader.FINDLAST THEN BEGIN
                    AmtAsPerBank := StatementHeader."Statement Ending Balance";

                    BankLedger.RESET;
                    //BankLedger.SETCURRENTKEY("Bank Account No.","Statement Status","Posting Date",Reversed);
                    BankLedger.SETRANGE("Bank Account No.", "No.");
                    BankLedger.SETRANGE("Statement Status", BankLedger."Statement Status"::Open);
                    BankLedger.SETFILTER("Posting Date", '<=%1', AsOnDate);
                    IF BankLedger.FINDSET THEN BEGIN
                        REPEAT
                            AmtCreditedByUs += BankLedger."Credit Amount (LCY)";
                            AmtDebitedByUs += BankLedger."Debit Amount (LCY)";
                        UNTIL BankLedger.NEXT = 0;
                    END;

                    CLEAR(StatementLines);

                    StatementLines.RESET;
                    StatementLines.SETRANGE("Bank Account No.", "No.");
                    StatementLines.SETRANGE("Statement No.", StatementHeader."Statement No.");
                    StatementLines.SETRANGE("Applied Amount", 0);
                    IF StatementLines.FINDSET THEN
                        REPEAT
                            IF StatementLines."Statement Amount" > 0 THEN
                                AmtCreditedByBank += StatementLines.Difference;
                            IF StatementLines."Statement Amount" < 0 THEN
                                AmtDebitedByBank += StatementLines.Difference;
                        UNTIL StatementLines.NEXT = 0;

                    StatementLines.SETFILTER("Applied Amount", '<>%1', 0);
                    IF StatementLines.FINDSET THEN
                        REPEAT
                            DifferenceAmt += StatementLines.Difference;
                        UNTIL StatementLines.NEXT = 0;
                END;

                AmtAsPerBook := ABS(AmtAsPerBook);
                AmtAsPerBank := ABS(AmtAsPerBank);
                AmtCreditedByUs := ABS(AmtCreditedByUs);
                AmtDebitedByUs := ABS(AmtDebitedByUs);
                AmtCreditedByBank := ABS(AmtCreditedByBank);
                AmtDebitedByBank := ABS(AmtDebitedByBank);
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("No.", BankAccount);
                CompanyInfo.CalcFields(Picture);
                Clear(Users);
                Clear(UserName);
                Users.SetCurrentKey("User Name");
                Users.SetRange("User Name", UserId);
                IF Users.FindFirst() then begin
                    if Users."Full Name" <> '' then
                        UserName := Users."Full Name"
                    else
                        UserName := UserId;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("As on Date"; AsOnDate)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Print Summary"; PrintSummary)
                {
                    ApplicationArea = All;
                    Caption = 'Print Details';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        AsOnDate: Date;
        BankLedger: Record 271;
        AmtCreditedByBank: Decimal;
        AmtDebitedByBank: Decimal;
        AmtAsPerBook: Decimal;
        AmtAsPerBank: Decimal;
        AmtCreditedByUs: Decimal;
        AmtDebitedByUs: Decimal;
        StatementHeader: Record 273;
        StatementLines: Record 274;
        DifferenceAmt: Decimal;
        Exporttoexcel: Boolean;
        Tempexcelbuffer1: Record 370 temporary;
        rowno: Integer;
        BankRecoHeader1: Record 273;
        NewLine: Text[30];
        Tab: Text[30];
        Filerec: File;
        Fileoutstream: OutStream;
        storepath: Option C,D,E,F,G,H,I;
        ExportTthrhfilestream: Boolean;
        FileName: Text[250];
        Text001: Label 'Import File';
        Text002: Label 'Kindly specify File path.';
        V1CaptionLbl: Label '1';
        BALANCE_IN_OUR_BOOK_AS_ON_CaptionLbl: Label 'BALANCE IN OUR BOOK AS ON ';
        A_CaptionLbl: Label 'A)';
        B_CaptionLbl: Label 'B)';
        C_CaptionLbl: Label 'C)';
        D_CaptionLbl: Label 'D)';
        E_CaptionLbl: Label 'E)';
        Add_CaptionLbl: Label 'Add:';
        Less_CaptionLbl: Label 'Less:';
        Add_Caption_Control1000000047Lbl: Label 'Add:';
        Less_Caption_Control1000000048Lbl: Label 'Less:';
        Less_Caption_Control1000000049Lbl: Label 'Less:';
        AMOUNT_CREDITED_BY_BANK_NOT_ENTERED_IN_BOOKSCaptionLbl: Label 'AMOUNT CREDITED BY BANK NOT ENTERED IN BOOKS';
        AMOUNT_DEBITED_BY_BANK_NOT_ENTERED_IN_BOOKSCaptionLbl: Label 'AMOUNT DEBITED BY BANK NOT ENTERED IN BOOKS';
        AMOUNT_CREDITED_IN_BOOKS_NOT_FOUND_IN_BANKCaptionLbl: Label 'AMOUNT CREDITED IN BOOKS NOT FOUND IN BANK';
        AMOUNT_DEBITED_IN_BOOKS_NOT_FOUND_IN_BANK_STATEMENTCaptionLbl: Label 'AMOUNT DEBITED IN BOOKS NOT FOUND IN BANK';
        DIFFRENCECaptionLbl: Label 'AMOUNT DEBITED or CREDITED BY BANK, BUT PARTIALLY APPLIED';
        V2CaptionLbl: Label '2';
        BALANCE_AS_PER_BANK_STATEMENT_AS_ON_CaptionLbl: Label 'BALANCE AS PER BANK STATEMENT AS ON ';
        SUMMARYCaptionLbl: Label 'SUMMARY';
        A_Caption_Control1000000002Lbl: Label 'A)';
        ADD__CaptionLbl: Label 'ADD :';
        AMOUNT_CREDITED_BY_BANK_NOT_ENTERED_IN_BOOKSCaption_Control1000000004Lbl: Label 'AMOUNT CREDITED BY BANK NOT ENTERED IN BOOKS';
        AMOUNT_CREDITED_BY_BANK_NOT_ENTERED_IN_BOOKSCaption_Control1000000092Lbl: Label 'AMOUNT CREDITED BY BANK NOT ENTERED IN BOOKS';
        ADD__Caption_Control1000000093Lbl: Label 'ADD :';
        A1_CaptionLbl: Label 'A1)';
        B_Caption_Control1000000000Lbl: Label 'B)';
        LESS_Caption_Control1000000001Lbl: Label 'LESS:';
        AMOUNT_DEBITED_BY_BANK_NOT_ENTERED_BY_US_IN_BOOKSCaptionLbl: Label 'AMOUNT DEBITED BY BANK NOT ENTERED BY US IN BOOKS';
        B1_CaptionLbl: Label 'B1)';
        LESS_Caption_Control1000000101Lbl: Label 'LESS:';
        AMOUNT_DEBITED_BY_BANK_NOT_ENTERED_BY_US_IN_BOOKSCaption_Control1000000102Lbl: Label 'AMOUNT DEBITED BY BANK NOT ENTERED BY US IN BOOKS';
        C_Caption_Control1000000016Lbl: Label 'C)';
        ADD__Caption_Control1000000017Lbl: Label 'ADD :';
        AMOUNT_CREDITED_IN_BOOKS_NOT_FOUND_IN_BANKCaption_Control1000000018Lbl: Label 'AMOUNT CREDITED IN BOOKS NOT FOUND IN BANK';
        C1_CaptionLbl: Label 'C1)';
        ADD__Caption_Control1000000083Lbl: Label 'ADD :';
        AMOUNT_CREDITED_IN_BOOKS_NOT_FOUND_IN_BANKCaption_Control1000000084Lbl: Label 'AMOUNT CREDITED IN BOOKS NOT FOUND IN BANK';
        D_Caption_Control1000000024Lbl: Label 'D)';
        LESS_Caption_Control1000000025Lbl: Label 'LESS:';
        AMOUNT_DEBITED_IN_BOOKS_NOT_FOUND_IN_BANK_STATEMENTCaption_Control1000000026Lbl: Label 'AMOUNT DEBITED IN BOOKS NOT FOUND IN BANK STATEMENT';
        AMOUNT_DEBITED_IN_BOOKS_NOT_FOUND_IN_BANK_STATEMENTCaption_Control1000000085Lbl: Label 'AMOUNT DEBITED IN BOOKS NOT FOUND IN BANK STATEMENT';
        LESS_Caption_Control1000000086Lbl: Label 'LESS:';
        D1_CaptionLbl: Label 'D1)';
        PrintSummary: Boolean;
        BankAccount: Code[30];

        Users: Record User;
        UserName: Text;
        CompanyInfo: Record "Company Information";

    procedure SetValues(BankRecoHeader: Record 273; BankAccountNo: Code[30])
    begin
        BankRecoHeader1.COPY(BankRecoHeader);
        AsOnDate := BankRecoHeader."Statement Date";
        BankAccount := BankAccountNo;
    end;
}

