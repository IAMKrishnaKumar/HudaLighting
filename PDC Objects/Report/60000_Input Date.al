report 60000 "Input Date"
{
    // UsageCategory = Administration;
    // ApplicationArea = All;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field("Deposit Date"; InputDate)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }


    }
    trigger OnPreReport()
    begin

    end;

    procedure GetDepositDate(): Date
    var

    begin
        EXIT(InputDate);
    end;

    var
        InputDate: Date;
        DateCaption: Text[30];
}