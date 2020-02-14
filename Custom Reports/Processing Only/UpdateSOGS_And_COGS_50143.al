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
    end;

    var
        myInt: Integer;
}