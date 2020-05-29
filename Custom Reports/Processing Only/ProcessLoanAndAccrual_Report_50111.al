report 50111 "Process Loan & Accrual"
{
    // UsageCategory = Administration;
    // ApplicationArea = All;
    UseRequestPage = false;
    ProcessingOnly = true;

    dataset
    {
        dataitem(LoanAndAcc; "Loan & Adv. Accrual")
        {
        }
    }
    trigger OnPreReport()
    var
        PayrollStaging: Record "Loan & Adv. Accrual";
    begin
        Clear(PayrollStaging);
        PayrollStaging.SetFilter("Integration Status", '=%1|%2', PayrollStaging."Integration Status"::Pending, PayrollStaging."Integration Status"::"Wait for Re-attempt");
        if PayrollStaging.FindSet() then begin
            repeat
                commit();
                if not Codeunit.Run(50103, PayrollStaging) then begin
                    if PayrollStaging."Retry Count" > 1 then
                        PayrollStaging."Integration Status" := PayrollStaging."Integration Status"::Error
                    else
                        PayrollStaging."Integration Status" := PayrollStaging."Integration Status"::"Wait for Re-attempt";
                    PayrollStaging."Error Remarks" := CopyStr(GetLastErrorText(), 1, 250);
                    PayrollStaging."Retry Count" += 1;
                    PayrollStaging.Modify();
                    Commit();
                end else begin
                    PayrollStaging."Integration Status" := PayrollStaging."Integration Status"::Processed;
                    PayrollStaging."Error Remarks" := '';
                    PayrollStaging."Processing Remarks" := 'Processed Successfully';
                    PayrollStaging."Retry Count" += 1;
                    PayrollStaging.Modify();
                    Commit();
                end;
            until PayrollStaging.Next() = 0;
        end;

    end;


    var
        myInt: Integer;
}

