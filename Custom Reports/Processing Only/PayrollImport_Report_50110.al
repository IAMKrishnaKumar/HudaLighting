report 50110 "Import Payroll"
{
    // UsageCategory = Administration;
    // ApplicationArea = All;
    UseRequestPage = false;
    ProcessingOnly = true;

    dataset
    {
        dataitem(PyrollStaging; "Payroll Staging")
        {
        }
    }
    trigger OnPreReport()
    var
        PyrollStagingL: Record "Payroll Staging";
    begin
        Clear(PyrollStagingL);
        PyrollStagingL.SetFilter("Integration Status", '=%1|%2', PyrollStagingL."Integration Status"::Pending, PyrollStagingL."Integration Status"::"Wait for Re-attempt");
        if PyrollStagingL.FindSet() then begin
            repeat
                Commit();
                if not Codeunit.Run(50101, PyrollStagingL) then begin
                    if PyrollStagingL."Retry Count" > 1 then
                        PyrollStagingL."Integration Status" := PyrollStagingL."Integration Status"::Error
                    else
                        PyrollStagingL."Integration Status" := PyrollStagingL."Integration Status"::"Wait for Re-attempt";
                    PyrollStagingL."Error Remarks" := CopyStr(GetLastErrorText(), 1, 250);
                    PyrollStagingL."Retry Count" += 1;
                    PyrollStagingL."Processing Date and Time" := CurrentDateTime();
                    PyrollStagingL.Modify();
                    Commit();
                end else begin
                    PyrollStagingL."Integration Status" := PyrollStagingL."Integration Status"::Processed;
                    PyrollStagingL."Error Remarks" := '';
                    PyrollStagingL."Processing Remarks" := 'Processed Successfully';
                    PyrollStagingL."Retry Count" += 1;
                    PyrollStagingL."Processing Date and Time" := CurrentDateTime();
                    PyrollStagingL.Modify();
                    Commit();
                end;
            until PyrollStagingL.Next() = 0;
        end;

    end;

    var
        myInt: Integer;
}