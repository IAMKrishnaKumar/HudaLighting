codeunit 50109 "Import Sales Person Share"
{
    trigger OnRun()
    begin

    end;

    procedure "Import Sales Person Share"(RequestData: XmlPort ImportSalesPersonShare): Text
    begin
        if RequestData.Import() then
            exit('Success')
        else
            exit(GetLastErrorText());
    end;

    var
        myInt: Integer;
}