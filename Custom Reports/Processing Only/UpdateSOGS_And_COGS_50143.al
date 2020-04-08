report 50160 "Update Shared SOGS/COGS"
{
    //UsageCategory = Administration;
    //ApplicationArea = All;
    UseRequestPage = false;
    ProcessingOnly = true;
    Permissions = TableData 50103 = RIMD;
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
            repeat
                SHeader.CalcFields("G/L Invoiced", "Non Stock Invoiced");
                if SHeader."G/L Invoiced" <> 0 then begin
                    if SHeader."Currency Factor" <> 0 then
                        SHeader."G/L Invoiced (LCY)" := SHeader."G/L Invoiced" / SHeader."Currency Factor"
                    else
                        SHeader."G/L Invoiced (LCY)" := SHeader."G/L Invoiced";
                end else
                    SHeader."G/L Invoiced (LCY)" := 0;
                if SHeader."Non Stock Invoiced" <> 0 then begin
                    if SHeader."Currency Factor" <> 0 then
                        SHeader."Non Stock Invoiced (LCY)" := SHeader."Non Stock Invoiced" / SHeader."Currency Factor"
                    else
                        SHeader."Non Stock Invoiced (LCY)" := SHeader."Non Stock Invoiced";
                end else
                    SHeader."Non Stock Invoiced (LCY)" := 0;
                SHeader.Modify();
            until SHeader.Next() = 0;
        end;
    end;

    var
        myInt: Integer;
}