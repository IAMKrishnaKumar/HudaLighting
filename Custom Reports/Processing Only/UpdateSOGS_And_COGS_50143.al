report 50160 "Update Shared SOGS/COGS"
{
    //UsageCategory = Administration;
    //ApplicationArea = All;
    UseRequestPage = false;
    ProcessingOnly = true;
    Permissions = TableData 50103 = RIMD, TableData 37 = RIMD, TableData 36 = RIMD;
    dataset
    {
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
            }
        }

        actions
        {

        }
    }

    trigger OnPostReport()
    var
        RecSalesShare: Record "Sales Person Main";
        SHeader: Record "Sales Header";
        ACY_ExchangeRateAmt: Decimal;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
    begin
        Clear(RecSalesShare);
        RecSalesShare.SetFilter("Entry No.", '<>%1', 0);
        if RecSalesShare.FindSet() then begin
            repeat
                RecSalesShare.CalcFields(COGS, Sales);
                RecSalesShare."Shared Sales" := (RecSalesShare.Sales * RecSalesShare."Share %") / 100;
                RecSalesShare."Shared COGS" := (RecSalesShare.COGS * RecSalesShare."Share %") / 100;
                RecSalesShare.Modify();
            until RecSalesShare.Next() = 0;
        end;
        Clear(SHeader);
        SHeader.SetRange("Document Type", SHeader."Document Type"::Order);
        SHeader.SetFilter("No.", '<>%1', '');
        if SHeader.FindSet() then begin
            Clear(ACY_ExchangeRateAmt);
            ACY_ExchangeRateAmt := CurrencyExchangeRate.GetCurrentCurrencyFactor('AED');
            repeat
                SHeader.CalcFields("G/L Invoiced", "Non Stock Invoiced");
                if SHeader."G/L Invoiced" <> 0 then begin
                    if SHeader."Currency Factor" <> 0 then
                        SHeader."G/L Invoiced (LCY)" := SHeader."G/L Invoiced" / SHeader."Currency Factor"
                    else
                        SHeader."G/L Invoiced (LCY)" := SHeader."G/L Invoiced";
                    SHeader."G/L Invoiced (ACY)" := Round(SHeader."G/L Invoiced (LCY)" * ACY_ExchangeRateAmt, 0.01, '=');
                end else begin
                    SHeader."G/L Invoiced (LCY)" := 0;
                    SHeader."G/L Invoiced (ACY)" := 0;
                end;
                if SHeader."Non Stock Invoiced" <> 0 then begin
                    if SHeader."Currency Factor" <> 0 then
                        SHeader."Non Stock Invoiced (LCY)" := SHeader."Non Stock Invoiced" / SHeader."Currency Factor"
                    else
                        SHeader."Non Stock Invoiced (LCY)" := SHeader."Non Stock Invoiced";
                    SHeader."Non Stock Invoiced (ACY)" := Round(SHeader."Non Stock Invoiced (LCY)" * ACY_ExchangeRateAmt, 0.01, '=');
                end else begin
                    SHeader."Non Stock Invoiced (LCY)" := 0;
                    SHeader."Non Stock Invoiced (ACY)" := 0;
                end;
                SHeader.Modify();
            until SHeader.Next() = 0;
        end;
        //To update UE Sales Field
        Clear(RecSalesLine);
        RecSalesLine.SetRange("Document Type", RecSalesLine."Document Type"::Order);
        RecSalesLine.SetFilter("Document No.", '<>%1', '');
        if RecSalesLine.FindSet() then begin
            repeat
                RecSalesLine.UpdateAEDAmounts();
                RecSalesLine.Modify();
            until RecSalesLine.Next() = 0;
        end;
    end;


    var
        RecSalesLine: Record "Sales Line";
}