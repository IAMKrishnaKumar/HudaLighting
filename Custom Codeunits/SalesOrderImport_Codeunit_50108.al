codeunit 50108 "Import Sales Order"
{
    trigger OnRun()
    begin

    end;

    procedure "Import Sales Order"(RequestData: XmlPort "Sales Order Import"): Text
    begin
        if RequestData.Import() then
            exit('Success')
        else
            exit(GetLastErrorText());
    end;

    var
        myInt: Integer;
}