codeunit 50121 "Scheduled Gen. Project Status"
{//Completed
    trigger OnRun()
    var
        TempBlob: Codeunit "Temp Blob";
        ReportInOutStream: OutStream;
        ReportInStream: InStream;
        TxtAttachmentName: TextConst ENG = 'GPSR - %1.xlsx';
        AttachmentName: Text;
        ReportID: Integer;
        CheckList: List of [Text];
        GeneralProjectStatusReport: Report "General Project Status";
        SalesHeader: Record "Sales Header";
    begin
        RecCompanyInfo.GET;
        IF NOT RecCompanyInfo."General Project Status" THEN
            EXIT;

        Clear(RecSalesPerson);
        RecSalesPerson.GET(SalesPersonCode);
        if (RecSalesPerson."E-Mail" = '') AND (RecSalesPerson."E-Mail 2" = '') THEN
            RecSalesPerson.TestField("E-Mail");
        Clear(ToEmailList);
        if RecSalesPerson."E-Mail" <> '' then//////////////Commented not to send on sales , just send on Teams
            ToEmailList.Add(RecSalesPerson."E-Mail");
        if RecSalesPerson."E-Mail 2" <> '' then
            ToEmailList.Add(RecSalesPerson."E-Mail 2");
        if RecCompanyInfo."General Project Status Email" <> '' then begin
            ToEmailList.Add(RecCompanyInfo."General Project Status Email");
        end;
        SMTPSetup.GET;
        SMTPMail.CreateMessage('Dynamics Notification', SMTPSetup."User ID", ToEmailList, 'General Project Status Report', '');
        AppendHTMLBody();
        Clear(GeneralProjectStatusReport);
        Clear(SalesHeader);
        Clear(ReportInOutStream);
        Clear(ReportInStream);
        Clear(TempBlob);
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("Salesperson Code", SalesPersonCode);
        SalesHeader.FindSet();
        GeneralProjectStatusReport.UseRequestPage(false);
        GeneralProjectStatusReport.SetTableView(SalesHeader);
        GeneralProjectStatusReport.RunModal();
        TempBlob.CreateOutStream(ReportInOutStream);
        GeneralProjectStatusReport.GetExcelInToSteam(ReportInOutStream);
        TempBlob.CreateInStream(ReportInStream);
        Clear(AttachmentName);
        AttachmentName := StrSubstNo(TxtAttachmentName, RecSalesPerson.Code);
        SMTPMail.AddAttachmentStream(ReportInStream, AttachmentName);
        SMTPMail.Send();
    end;

    procedure AppendHTMLBody()
    VAR
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        ExchangeRateAmt: Decimal;
        CurrencyFactor: Decimal;
        GLSetup: Record "General Ledger Setup";
        RecPayTerm: Record "Payment Terms";
        RecShipmentMethod: Record "Shipment Method";
    begin
        Addstyle();
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Hi <b>' + RecSalesPerson."Alias Name" + '</b>!<o:p></o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black"><o:p>&nbsp;</o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">We are sharing this week’s General Project Status Report as of  ' + FORMAT(WorkDate(), 0, '<day,2>/<month,2>/<year4>') + ' with you. The report shows all the open order lines. Once the OA is closed, the lines are removed from the report. If you need help reading the report, please refer to this <a href="' + RecCompanyInfo."GPS Sharepoint Link" + '">Sharepoint Link </a>explaining the document.<o:p></o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black"><o:p>&nbsp;</o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">We look forward to receiving your feedback!<o:p></o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black"><o:p>&nbsp;</o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><i><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">This message is sent by the Huda Lighting ERP</span></i></p>');
    end;


    procedure SetSalesPersonCode(SPCodeL: Code[20])
    begin
        Clear(SalesPersonCode);
        SalesPersonCode := SPCodeL;
    end;

    var
        RecCompanyInfo: Record "Company Information";
        ToEmailList: List of [Text];
        CCEmailList: List of [Text];
        BccEmailList: List of [Text];
        RecSalesPerson: Record "Salesperson/Purchaser";
        RecReportSelection: Record "Report Selections";
        SMTPSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
        SalesPersonCode: Code[20];



    local procedure Addstyle()
    begin
        SMTPMail.AppendBody('<style>@font-face	{font-family:Helvetica;        panose-1:2 11 6 4 2 2 2 2 2 4;}@font-face	{font-family:"Cambria Math";	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face	{font-family:Calibri;	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face	{font-family:"Segoe UI";	panose-1:2 11 5 2 4 2 4 2 2 3;} p.MsoNormal, li.MsoNormal, div.MsoNormal	{margin:0in;	margin-bottom:.0001pt;	font-size:11.0pt;	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink	{mso-style-priority:99;	color:#0563C1;	text-decoration:underline;}a:visited, span.MsoHyperlinkFollowed	{mso-style-priority:99;	color:#954F72;	text-decoration:underline;}p.msonormal0, li.msonormal0, div.msonormal00	{mso-style-name:msonormal;	mso-margin-top-alt:auto;	margin-right:0in;	mso-margin-bottom-alt:auto;	margin-left:0in;	font-size:11.0pt;	font-family:"Calibri",sans-serif;}span.EmailStyle18	{mso-style-type:personal;	font-family:"Calibri",sans-serif;	color:windowtext;}span.EmailStyle19	{mso-style-type:personal-reply;	font-family:"Calibri",sans-serif;	color:windowtext;}.MsoChpDefault	{mso-style-type:export-only;	font-size:10.0pt;} @page WordSection1{     size:8.5in 11.0in;     margin:1.0in 1.0in 1.0in 1.0in;}div.WordSection1	{page:WordSection1;}@list l0	{mso-list-id:652948990;	mso-list-template-ids:414455188;}@list l1	{mso-list-id:1383752550;	mso-list-template-ids:612022788;}@list l1:level1	{mso-level-tab-stop:.5in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level2	{mso-level-tab-stop:1.0in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level3	{mso-level-tab-stop:1.5in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level4	{mso-level-tab-stop:2.0in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level5	{mso-level-tab-stop:2.5in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level6	{mso-level-tab-stop:3.0in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level7	{mso-level-tab-stop:3.5in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level8	{mso-level-tab-stop:4.0in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level9	{mso-level-tab-stop:4.5in;	mso-level-number-position:left;	text-indent:-.25in;}ol	{margin-bottom:0in;}ul	{margin-bottom:0in;} </style>');
    end;
}

