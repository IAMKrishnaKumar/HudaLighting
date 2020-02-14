report 50114 "Date Selection"
{
    UseRequestPage = true;
    ProcessingOnly = true;
    Caption = 'Select Date';

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
                    field("Select Date :"; SelectedDate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            If CloseAction IN [ACTION::OK, ACTION::LookupOK] then begin
                IF SelectedDate <> 0D then begin
                end else
                    Error('Select date.');
            end;
        end;
    }
    procedure GetDate(): Date
    begin
        exit(SelectedDate);
    end;

    var
        SelectedDate: Date;
}