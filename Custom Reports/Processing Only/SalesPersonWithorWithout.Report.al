report 50113 "Customer Statement Details"
{
    //UsageCategory = ReportsAndAnalysis;
    //ApplicationArea = All;
    ProcessingOnly = true;
    UseRequestPage = false;
    Caption = 'Customer Statement';


    trigger OnPreReport()
    var
        myInt: Integer;
        Customer: Record Customer;
        RecRef: RecordRef;
        CustomerStReport: Report 153;
    begin

        Selected := Dialog.StrMenu(Text000, 1, Text001);
        if Selected = 1 then begin
            // Report.RunModal(Report::"Standard Statement With SP");
            InsertCustomerStatemetInReportSelection(Report::"Standard Statement With SP");
            CustomerStReport.UseRequestPage(false);
            CustomerStReport.Run();
        end else
            if Selected = 2 then begin
                // Report.RunModal(Report::"Customer Statement Without SP");
                InsertCustomerStatemetInReportSelection(Report::"Customer Statement Without SP");
                CustomerStReport.UseRequestPage(false);
                CustomerStReport.Run();
            end;
    end;

    local procedure InsertCustomerStatemetInReportSelection(ReportId: Integer)
    var
        RecReportSelection: Record "Report Selections";
    begin
        Clear(RecReportSelection);
        RecReportSelection.SetRange(Usage, RecReportSelection.Usage::"C.Statement");
        RecReportSelection.SetRange(Sequence, '1');
        if RecReportSelection.FindSet() then
            RecReportSelection.DeleteAll();

        RecReportSelection.Init();
        RecReportSelection.Usage := RecReportSelection.Usage::"C.Statement";
        RecReportSelection.Validate(Sequence, '1');
        RecReportSelection.Validate("Report ID", ReportId);
        RecReportSelection."Use for Email Attachment" := true;
        RecReportSelection.Insert(true);
    end;

    var
        Text000: Label 'With Sales Person, Without Sales Person';
        Text001: Label 'Customer Statement';
        Selected: Integer;
        ReportSelections: Record "Report Selections";
        CustomLayoutReporting: Codeunit "Custom Layout Reporting";
        StatementFileNameTxt: Label 'Statement', Comment = 'Shortened form of ''Customer Statement''';

}