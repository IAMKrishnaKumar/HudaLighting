report 50168 "Scheduled General Proj. Report"
{
    //ApplicationArea = All;
    //UsageCategory = ReportsAndAnalysis;//To use manually.
    ProcessingOnly = true;
    UseRequestPage = false;
    ShowPrintStatus = false;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) where("Document Type" = CONST(Order), "Salesperson Code" = filter(<> ''), Closed = filter(false));

            trigger OnAfterGetRecord()
            var
                RecSalesPerson: Record "Salesperson/Purchaser";
                SendExcelFileToSalesPerson: Codeunit "Scheduled Gen. Project Status";
                EmailAlertLog: Record "Email Alert Log";
                EntryNo: Integer;
            begin
                RecCompanyInfo.GET;
                IF NOT RecCompanyInfo."General Project Status" THEN
                    EXIT;
                if not CheckList.Contains("Salesperson Code") then begin
                    CheckList.Add("Salesperson Code");
                    Clear(RecSalesPerson);
                    RecSalesPerson.GET("Salesperson Code");
                    if (RecSalesPerson."E-Mail" = '') AND (RecSalesPerson."E-Mail 2" = '') then
                        CurrReport.Skip();

                    Clear(EmailAlertLog);
                    if EmailAlertLog.FindLast() then
                        EntryNo := EmailAlertLog."Entry No." + 1
                    else
                        EntryNo := 1;
                    EmailAlertLog.Init();
                    EmailAlertLog."Entry No." := EntryNo;
                    EmailAlertLog."Document No." := "Salesperson Code";
                    EmailAlertLog."Email For Record" := RecordId;
                    EmailAlertLog."Email Alert Type" := EmailAlertLog."Email Alert Type"::"Scheduled Gen. Proj. Status Report";
                    ClearLastError();
                    Clear(SendExcelFileToSalesPerson);
                    SendExcelFileToSalesPerson.SetSalesPersonCode("Salesperson Code");
                    Commit();
                    if SendExcelFileToSalesPerson.RUN() then
                        EmailAlertLog."Email Status" := EmailAlertLog."Email Status"::Sent
                    else
                        EmailAlertLog."Email Status" := EmailAlertLog."Email Status"::Error;
                    EmailAlertLog."Error Remarks" := CopyStr(GetLastErrorText, 1, 250);
                    EmailAlertLog.Insert(true);
                end;
            end;

        }

    }
    trigger OnPreReport()
    begin
        Clear(CheckList);
    end;

    var
        RecCompanyInfo: Record "Company Information";
        CheckList: List of [Text];
}

