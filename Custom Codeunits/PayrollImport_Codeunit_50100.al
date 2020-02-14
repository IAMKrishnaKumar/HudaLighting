codeunit 50100 "Import Payroll"
{
    trigger OnRun()
    begin
    end;

    procedure ImportPayroll(RequestData: XmlPort "Payroll Import"): Text
    begin
        If RequestData.Import() then
            exit('Success')
        else
            exit(GetLastErrorText());
    end;





}