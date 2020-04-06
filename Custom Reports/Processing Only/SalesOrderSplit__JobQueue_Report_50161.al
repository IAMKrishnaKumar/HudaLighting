report 50161 "Update Sales Order Split"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("No.") order(ascending) where("Document Type" = const(Order));

            trigger OnAfterGetRecord()
            var
                RecSoSplit: Record "Sales Person Main";
                RecSalesOrderSplit: Record "Sales Order Split";
                EntryNoList: List of [Integer];
                LoopCount: Integer;
                RecSalesSplit: Record "Sales Order Split";
                RecSalesLine: Record "Sales Line";
                LCY_ExchangeRateAmt: Decimal;
                ACY_ExchangeRateAmt: Decimal;
                CurrencyExchangeRate: Record "Currency Exchange Rate";
                GenLedSetup: Record "General Ledger Setup";
                RecSalesSplit3: Record "Sales Order Split";
            begin
                Clear(RecSoSplit);
                RecSoSplit.SetRange("Opportunity No", "Shortcut Dimension 1 Code");
                RecSoSplit.SetFilter(Salesperson, '<>%1', '');
                if RecSoSplit.FindSet() then begin
                    Clear(RecSalesLine);
                    RecSalesLine.SetRange("Document Type", "Document Type"::Order);
                    RecSalesLine.SetRange("Document No.", "Sales Header"."No.");
                    if RecSalesLine.FindSet() then
                        RecSalesLine.CalcFields("G/L Invoiced", "Non Stock Invoiced");
                    RecSalesLine.CalcSums("ACY UE Sales", "ACY UE GP", "UE Sales", "UE GP");
                    GenLedSetup.GET;
                    Clear(CurrencyExchangeRate);
                    Clear(LCY_ExchangeRateAmt);
                    Clear(ACY_ExchangeRateAmt);
                    LCY_ExchangeRateAmt := CurrencyExchangeRate.GetCurrentCurrencyFactor(GenLedSetup."LCY Code");
                    ACY_ExchangeRateAmt := CurrencyExchangeRate.GetCurrentCurrencyFactor('AED');
                    //Round("UE Sales" * ExchangeRateAmt, 0.01, '=');

                    Clear(RecSalesOrderSplit);
                    RecSalesOrderSplit.SetRange("Document No.", "Sales Header"."No.");
                    if RecSalesOrderSplit.FindSet() then begin
                        if RecSalesOrderSplit.Count = RecSoSplit.Count then begin
                            Clear(EntryNoList);
                            repeat
                                EntryNoList.Add(RecSalesOrderSplit."Entry No.");
                            until RecSalesOrderSplit.Next() = 0;
                            LoopCount := 1;
                            repeat
                                Clear(RecSalesSplit);
                                if RecSalesSplit.Get(EntryNoList.Get(LoopCount)) then begin
                                    RecSalesSplit."Posting Date" := "Sales Header"."Posting Date";
                                    RecSalesSplit."Document No." := "Sales Header"."No.";
                                    RecSalesSplit."LPO No." := "Sales Header"."PO Reference";
                                    RecSalesSplit."Project Name" := "Sales Header"."Project Name";
                                    RecSalesSplit."Client Name" := "Sales Header"."Sell-to Customer Name";
                                    RecSalesSplit."Shortcut Dimension 1 Code" := "Sales Header"."Shortcut Dimension 1 Code";
                                    RecSalesSplit."Sales Person" := RecSoSplit.Salesperson;
                                    RecSalesSplit."Share %" := RecSoSplit."Share %";
                                    RecSalesSplit."Invoiced GL (LCY)" := Round(RecSalesLine."G/L Invoiced" * LCY_ExchangeRateAmt, 0.01, '=');
                                    RecSalesSplit."Invoiced GL (ACY)" := Round(RecSalesLine."G/L Invoiced" * ACY_ExchangeRateAmt, 0.01, '=');
                                    RecSalesSplit."Invoiced Non Stock (LCY)" := Round(RecSalesLine."Non Stock Invoiced" * LCY_ExchangeRateAmt, 0.01, '=');
                                    RecSalesSplit."Invoiced Non Stock (ACY)" := Round(RecSalesLine."Non Stock Invoiced" * ACY_ExchangeRateAmt, 0.01, '=');
                                    RecSalesSplit."UE GP (LCY)" := Round(RecSalesLine."UE GP" * LCY_ExchangeRateAmt, 0.01, '=');
                                    RecSalesSplit."UE GP (ACY)" := Round(RecSalesLine."UE GP" * ACY_ExchangeRateAmt, 0.01, '=');
                                    RecSalesSplit."UE Sales (LCY)" := Round(RecSalesLine."UE Sales" * LCY_ExchangeRateAmt, 0.01, '=');
                                    RecSalesSplit."UE Sales (ACY)" := Round(RecSalesLine."UE Sales" * ACY_ExchangeRateAmt, 0.01, '=');
                                    RecSalesSplit."Shared UE Sales (LCY)" := Round((RecSalesLine."UE Sales" * LCY_ExchangeRateAmt) * RecSoSplit."Share %" / 100, 0.01, '=');
                                    RecSalesSplit."Shared UE GP (LCY)" := Round((RecSalesLine."UE GP" * LCY_ExchangeRateAmt) * RecSoSplit."Share %" / 100, 0.01, '=');
                                    RecSalesSplit."Shared UE Sales (ACY)" := Round((RecSalesLine."UE Sales" * ACY_ExchangeRateAmt) * RecSoSplit."Share %" / 100, 0.01, '=');
                                    RecSalesSplit."Shared UE GP (ACY)" := Round((RecSalesLine."UE GP" * ACY_ExchangeRateAmt) * RecSoSplit."Share %" / 100, 0.01, '=');
                                    RecSalesSplit.Modify();
                                end;
                                LoopCount += 1;
                            until RecSoSplit.Next() = 0;
                        end else begin
                            RecSalesOrderSplit.DeleteAll();
                            repeat
                                Clear(RecSalesSplit3);
                                if RecSalesSplit3.FindLast() then;
                                RecSalesSplit.Init();
                                RecSalesSplit."Entry No." := RecSalesSplit3."Entry No." + 1;
                                RecSalesSplit."Posting Date" := "Sales Header"."Posting Date";
                                RecSalesSplit."Document No." := "Sales Header"."No.";
                                RecSalesSplit."LPO No." := "Sales Header"."PO Reference";
                                RecSalesSplit."Project Name" := "Sales Header"."Project Name";
                                RecSalesSplit."Client Name" := "Sales Header"."Sell-to Customer Name";
                                RecSalesSplit."Shortcut Dimension 1 Code" := "Sales Header"."Shortcut Dimension 1 Code";
                                RecSalesSplit."Sales Person" := RecSoSplit.Salesperson;
                                RecSalesSplit."Share %" := RecSoSplit."Share %";
                                RecSalesSplit."Invoiced GL (LCY)" := Round(RecSalesLine."G/L Invoiced" * LCY_ExchangeRateAmt, 0.01, '=');
                                RecSalesSplit."Invoiced GL (ACY)" := Round(RecSalesLine."G/L Invoiced" * ACY_ExchangeRateAmt, 0.01, '=');
                                RecSalesSplit."Invoiced Non Stock (LCY)" := Round(RecSalesLine."Non Stock Invoiced" * LCY_ExchangeRateAmt, 0.01, '=');
                                RecSalesSplit."Invoiced Non Stock (ACY)" := Round(RecSalesLine."Non Stock Invoiced" * ACY_ExchangeRateAmt, 0.01, '=');
                                RecSalesSplit."UE GP (LCY)" := Round(RecSalesLine."UE GP" * LCY_ExchangeRateAmt, 0.01, '=');
                                RecSalesSplit."UE GP (ACY)" := Round(RecSalesLine."UE GP" * ACY_ExchangeRateAmt, 0.01, '=');
                                RecSalesSplit."UE Sales (LCY)" := Round(RecSalesLine."UE Sales" * LCY_ExchangeRateAmt, 0.01, '=');
                                RecSalesSplit."UE Sales (ACY)" := Round(RecSalesLine."UE Sales" * ACY_ExchangeRateAmt, 0.01, '=');
                                RecSalesSplit."Shared UE Sales (LCY)" := Round((RecSalesLine."UE Sales" * LCY_ExchangeRateAmt) * RecSoSplit."Share %" / 100, 0.01, '=');
                                RecSalesSplit."Shared UE GP (LCY)" := Round((RecSalesLine."UE GP" * LCY_ExchangeRateAmt) * RecSoSplit."Share %" / 100, 0.01, '=');
                                RecSalesSplit."Shared UE Sales (ACY)" := Round((RecSalesLine."UE Sales" * ACY_ExchangeRateAmt) * RecSoSplit."Share %" / 100, 0.01, '=');
                                RecSalesSplit."Shared UE GP (ACY)" := Round((RecSalesLine."UE GP" * ACY_ExchangeRateAmt) * RecSoSplit."Share %" / 100, 0.01, '=');
                                RecSalesSplit.Insert();
                            until RecSoSplit.Next() = 0;
                        end;
                    end else begin
                        repeat
                            Clear(RecSalesSplit3);
                            if RecSalesSplit3.FindLast() then;
                            RecSalesSplit.Init();
                            RecSalesSplit."Entry No." := RecSalesSplit3."Entry No." + 1;
                            RecSalesSplit."Posting Date" := "Sales Header"."Posting Date";
                            RecSalesSplit."Document No." := "Sales Header"."No.";
                            RecSalesSplit."LPO No." := "Sales Header"."PO Reference";
                            RecSalesSplit."Project Name" := "Sales Header"."Project Name";
                            RecSalesSplit."Client Name" := "Sales Header"."Sell-to Customer Name";
                            RecSalesSplit."Shortcut Dimension 1 Code" := "Sales Header"."Shortcut Dimension 1 Code";
                            RecSalesSplit."Sales Person" := RecSoSplit.Salesperson;
                            RecSalesSplit."Share %" := RecSoSplit."Share %";
                            RecSalesSplit."Invoiced GL (LCY)" := Round(RecSalesLine."G/L Invoiced" * LCY_ExchangeRateAmt, 0.01, '=');
                            RecSalesSplit."Invoiced GL (ACY)" := Round(RecSalesLine."G/L Invoiced" * ACY_ExchangeRateAmt, 0.01, '=');
                            RecSalesSplit."Invoiced Non Stock (LCY)" := Round(RecSalesLine."Non Stock Invoiced" * LCY_ExchangeRateAmt, 0.01, '=');
                            RecSalesSplit."Invoiced Non Stock (ACY)" := Round(RecSalesLine."Non Stock Invoiced" * ACY_ExchangeRateAmt, 0.01, '=');
                            RecSalesSplit."UE GP (LCY)" := Round(RecSalesLine."UE GP" * LCY_ExchangeRateAmt, 0.01, '=');
                            RecSalesSplit."UE GP (ACY)" := Round(RecSalesLine."UE GP" * ACY_ExchangeRateAmt, 0.01, '=');
                            RecSalesSplit."UE Sales (LCY)" := Round(RecSalesLine."UE Sales" * LCY_ExchangeRateAmt, 0.01, '=');
                            RecSalesSplit."UE Sales (ACY)" := Round(RecSalesLine."UE Sales" * ACY_ExchangeRateAmt, 0.01, '=');
                            RecSalesSplit."Shared UE Sales (LCY)" := Round((RecSalesLine."UE Sales" * LCY_ExchangeRateAmt) * RecSoSplit."Share %" / 100, 0.01, '=');
                            RecSalesSplit."Shared UE GP (LCY)" := Round((RecSalesLine."UE GP" * LCY_ExchangeRateAmt) * RecSoSplit."Share %" / 100, 0.01, '=');
                            RecSalesSplit."Shared UE Sales (ACY)" := Round((RecSalesLine."UE Sales" * ACY_ExchangeRateAmt) * RecSoSplit."Share %" / 100, 0.01, '=');
                            RecSalesSplit."Shared UE GP (ACY)" := Round((RecSalesLine."UE GP" * ACY_ExchangeRateAmt) * RecSoSplit."Share %" / 100, 0.01, '=');
                            RecSalesSplit.Insert();
                        until RecSoSplit.Next() = 0;
                    end;
                end;
            end;



            trigger OnPreDataItem()
            begin
                SetFilter("Shortcut Dimension 1 Code", '<>%1', '');
                SetFilter("Salesperson Code", '<>%1', '');
            end;
        }
    }


    var
        myInt: Integer;
}