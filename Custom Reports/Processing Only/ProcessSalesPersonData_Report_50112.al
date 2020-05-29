report 50112 "Process Sales Person Data"
{
    // UsageCategory = Administration;
    // ApplicationArea = All;
    UseRequestPage = false;
    ProcessingOnly = true;

    dataset
    {
        dataitem(SalesPerson; "Sales Person Staging")
        {
        }
    }
    trigger OnPreReport()
    var
        RecStaging: Record "Sales Person Staging";
    begin
        Clear(RecStaging);
        RecStaging.SetFilter("Integration Status", '=%1|%2', RecStaging."Integration Status"::Pending, RecStaging."Integration Status"::"Wait for Re-attempt");
        if RecStaging.FindSet() then begin
            repeat
                ValidateData(RecStaging."Opportunity No");
            until RecStaging.Next() = 0;
        end;

        Clear(RecStaging);
        RecStaging.SetFilter("Integration Status", '=%1|%2', RecStaging."Integration Status"::Pending, RecStaging."Integration Status"::"Wait for Re-attempt");
        if RecStaging.FindSet() then begin
            repeat
                Commit();
                if not Codeunit.Run(50106, RecStaging) then begin
                    if GetLastErrorText = 'Duplicate' then begin
                        RecStaging."Integration Status" := RecStaging."Integration Status"::Duplicate;
                        RecStaging."Error Remarks" := '';
                        RecStaging."Processing Date and Time" := CurrentDateTime();
                        RecStaging."Retry Count" += 1;
                        RecStaging.Modify();
                        Commit();
                    end else begin
                        if RecStaging."Retry Count" > 1 then
                            RecStaging."Integration Status" := RecStaging."Integration Status"::Error
                        else
                            RecStaging."Integration Status" := RecStaging."Integration Status"::"Wait for Re-attempt";
                        RecStaging."Error Remarks" := CopyStr(GetLastErrorText(), 1, 250);
                        RecStaging."Processing Date and Time" := CurrentDateTime();
                        RecStaging."Retry Count" += 1;
                        RecStaging.Modify();
                        Commit();
                    end;
                end else begin
                    RecStaging."Integration Status" := RecStaging."Integration Status"::Processed;
                    RecStaging."Error Remarks" := '';
                    RecStaging."Processing Remarks" := 'Processed Successfully';
                    RecStaging."Retry Count" += 1;
                    RecStaging."Processing Date and Time" := CurrentDateTime();
                    RecStaging.Modify();
                    Commit();
                end;
            until RecStaging.Next() = 0;
        end;
    end;

    procedure ValidateData(OpportunityNo: Code[20])
    var
        RecStaging: Record "Sales Person Staging";
        CurrPercentage: Decimal;
    begin
        Clear(RecStaging);
        Clear(CurrPercentage);
        RecStaging.SetFilter("Integration Status", '=%1|%2', RecStaging."Integration Status"::Pending, RecStaging."Integration Status"::"Wait for Re-attempt");

        RecStaging.SetRange("Opportunity No", OpportunityNo);
        if RecStaging.FindSet() then
            repeat
                CurrPercentage += RecStaging."Share %";
            until RecStaging.Next() = 0;
        if CurrPercentage <> 100 then begin
            Clear(RecStaging);
            RecStaging.SetRange("Opportunity No", OpportunityNo);
            if RecStaging.FindSet() then begin
                repeat
                    RecStaging."Integration Status" := RecStaging."Integration Status"::Error;
                    RecStaging."Error Remarks" := 'The Sum of Share % for a particular Opportunity No must be 100';
                    RecStaging."Processing Date and Time" := CurrentDateTime();
                    RecStaging."Retry Count" += 1;
                    RecStaging.Modify();
                until RecStaging.Next() = 0;
            end;
        end;
    end;

    var
        myInt: Integer;
}



/*
   
*/
