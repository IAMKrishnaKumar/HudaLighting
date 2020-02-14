codeunit 50106 ProcessSalesPersonData
{
    TableNo = "Sales Person Staging";
    trigger OnRun()
    var
        RecSalesPerShareMain: Record "Sales Person Main";
    begin
        Clear(RecSalesPerShareMain);
        RecSalesPerShareMain.SetCurrentKey("Opportunity No", Salesperson);
        RecSalesPerShareMain.SetRange("Opportunity No", Rec."Opportunity No");
        RecSalesPerShareMain.SetRange(Salesperson, Rec.Salesperson);
        RecSalesPerShareMain.SetRange("Effective Date", Rec."Effective Date");
        RecSalesPerShareMain.SetRange("Share %", Rec."Share %");
        if RecSalesPerShareMain.FindFirst() then
            Error('Duplicate');
        Clear(RecSalesPerShareMain);
        RecSalesPerShareMain.SetCurrentKey("Opportunity No", Salesperson);
        RecSalesPerShareMain.SetRange("Opportunity No", Rec."Opportunity No");
        RecSalesPerShareMain.SetRange(Salesperson, Rec.Salesperson);
        if RecSalesPerShareMain.Find('-') then begin
            RecSalesPerShareMain."Effective Date" := Rec."Effective Date";
            RecSalesPerShareMain.Validate("Share %", Rec."Share %");
            RecSalesPerShareMain.Modify();
            Commit();
        end else begin
            RecSalesPerShareMain.Init();
            RecSalesPerShareMain."Opportunity No" := Rec."Opportunity No";
            RecSalesPerShareMain.Validate(Salesperson, Rec.Salesperson);
            RecSalesPerShareMain."Effective Date" := Rec."Effective Date";
            RecSalesPerShareMain.Validate("Share %", Rec."Share %");
            RecSalesPerShareMain.Insert(true);
            Commit();
        end;
    end;

    var
        myInt: Integer;
}
