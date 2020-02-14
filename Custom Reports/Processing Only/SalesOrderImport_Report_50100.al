report 50100 "Import Sales Order"
{
    // UsageCategory = Administration;
    // ApplicationArea = All;
    UseRequestPage = false;
    ProcessingOnly = true;
    dataset
    {
        dataitem(SO_Staging; "Sales Order Staging")
        {
        }
    }
    trigger OnPreReport()
    var
        RecSOStaging: Record "Sales Order Staging";
    begin
        Clear(RecSOStaging);
        RecSOStaging.SetFilter("Integration Status", '=%1|%2', RecSOStaging."Integration Status"::Pending, RecSOStaging."Integration Status"::"Wait for Re-attempt");
        if RecSOStaging.FindSet() then begin
            repeat
                if not Codeunit.Run(50110, RecSOStaging) then begin
                    if RecSOStaging."Retry Count" > 1 then
                        RecSOStaging."Integration Status" := RecSOStaging."Integration Status"::Error
                    else
                        RecSOStaging."Integration Status" := RecSOStaging."Integration Status"::"Wait for Re-attempt";
                    RecSOStaging."Error Remarks" := CopyStr(GetLastErrorText(), 1, 250);
                    if GetLastErrorText = 'Duplicate' then begin
                        RecSOStaging."Integration Status" := RecSOStaging."Integration Status"::Duplicate;
                        RecSOStaging."Error Remarks" := '';
                    end;
                    RecSOStaging."Retry Count" += 1;
                    RecSOStaging."Processing Date and Time" := CurrentDateTime();
                    RecSOStaging.Modify();
                    Commit();
                end else begin
                    RecSOStaging."Integration Status" := RecSOStaging."Integration Status"::Processed;
                    RecSOStaging."Error Remarks" := '';
                    RecSOStaging."Processing Remarks" := 'Processed Successfully';
                    RecSOStaging."Retry Count" += 1;
                    RecSOStaging."Processing Date and Time" := CurrentDateTime();
                    RecSOStaging.Modify();
                    Commit();
                end;
            until RecSOStaging.Next() = 0;
        end;

    end;

    var
        myInt: Integer;
}