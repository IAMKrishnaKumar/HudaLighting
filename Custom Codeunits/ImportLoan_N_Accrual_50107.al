codeunit 50107 "Import Loan & Accrual"
{
    trigger OnRun()
    begin
    end;

    procedure "Import Loan And Accrual"(RequestData: XmlPort "Adv Accrual Import"): Text
    begin
        if RequestData.Import() then
            exit('Success')
        else
            exit(GetLastErrorText());
    end;

}