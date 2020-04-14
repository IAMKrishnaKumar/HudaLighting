report 50165 "Update G/L Budget Entries"
{
    // UsageCategory = Administration;
    //ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = TableData 96 = RIMD;
    dataset
    {
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'From Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'To Date';
                    }
                    field(AverageExchRate; AverageExchRate)
                    {
                        ApplicationArea = All;
                        Caption = 'Average Exchange Rate';
                    }
                }
            }
        }
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var
            RecGLBudget: Record "G/L Budget Entry";
        begin
            If CloseAction IN [ACTION::OK, ACTION::LookupOK] then begin
                if ((StartDate <> 0D) OR (EndDate <> 0D)) then begin
                    Clear(RecGLBudget);
                    RecGLBudget.SetFilter(Date, '%1..%2', StartDate, EndDate);
                    if RecGLBudget.FindSet() then begin
                        if not Confirm('Are you sure you want to update Amount (ACY)?', false) then
                            exit;
                        repeat
                            RecGLBudget.Validate("Amount (ACY)", RecGLBudget.Amount * AverageExchRate);
                            RecGLBudget.Modify();
                        until RecGLBudget.Next() = 0;
                        Message('G/L Budget Entries between date range %1 to %2 updated sucessfully.', StartDate, EndDate);
                    end;
                end else
                    Error('Please provide required input.');
            end;
        end;
    }
    trigger OnPostReport()
    var

    begin

    end;

    var
        StartDate: Date;
        EndDate: Date;
        AverageExchRate: Decimal;
}



///


