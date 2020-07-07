codeunit 50120 "Pick Material Alert"
{//Completed
    trigger OnRun()
    var
        TempBlob: Codeunit "Temp Blob";
        ReportInOutStream: OutStream;
        ReportInStream: InStream;
        TxtAttachmentName: TextConst ENG = 'OA - %1.pdf';
        AttachmentName: Text;
        ReportID: Integer;
    begin
        RecCompanyInfo.GET;
        IF NOT RecCompanyInfo."Pick Materials" THEN
            EXIT;
        InitializeRecords();
        Clear(ToEmailList);
        if RecCompanyInfo."Pick Materials Email" <> '' then begin
            ToEmailList.Add(RecCompanyInfo."Pick Materials Email");
        end;
        SMTPSetup.GET;
        SMTPMail.CreateMessage('Dynamics Notification', SMTPSetup."User ID", ToEmailList, 'Pick Materials Alert', '');
        AppendHTMLBody();
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
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Hi!<o:p></o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black"><o:p>&nbsp;</o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">We need your help to pick and prepare the materials against Sales Invoice  <b>' + RecSalesHeader."No." + '</b> dated ' + FORMAT(RecSalesHeader."Document Date", 0, '<day,2>/<month,2>/<year4>') + '. Here is what we need.<o:p></o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black"><o:p>&nbsp;</o:p></span></p>');

        AddItemDetail();
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black"><o:p>&nbsp;</o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Thank you for your prompt actions!<o:p></o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black"><o:p>&nbsp;</o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><i><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">This message is sent by the Huda Lighting ERP</span></i></p>');
    end;

    local procedure SaveDocumentAsPDFToStream(ReportId: Integer; DocumentVariant: Variant; var VarOutStream: OutStream): Boolean;
    var
        DataTypeMgt: Codeunit "Data Type Management";

        DocumentRef: RecordRef;
    begin
        Clear(DocumentRef);
        DocumentRef.GetTable(DocumentVariant);
        if Report.SaveAs(ReportID, '', ReportFormat::Pdf, VarOutStream, DocumentRef) then
            exit(true);
    end;

    procedure SetSalesOrderNumber(NoL: Code[20])
    begin
        Clear(NoG);
        NoG := NoL;
    end;

    local procedure InitializeRecords()
    begin
        Clear(RecSalesHeader);
        RecSalesHeader.SetRange("Document Type", RecSalesHeader."Document Type"::Invoice);
        RecSalesHeader.SetRange("No.", NoG);
        RecSalesHeader.FindFirst();
    end;

    local procedure AddItemDetail()
    var
        RecSalesLine: Record "Sales Line";
    begin

        SMTPMail.AppendBody('<table Border="1" Style="border-style: none; width: 100%; border-collapse: collapse; transform: scale(1); transform-origin: left top 0px;">');
        SMTPMail.AppendBody('<tr>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"> <font color="#ffffff">  Item No. </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"> <font color="#ffffff"> Vendor Article No. </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"> <font color="#ffffff"> Item Description </font></th>');
        SMTPMail.AppendBody('<th align="Right" bgcolor="#4b929c"> <font color="#ffffff"> Quantity </font></th>');
        SMTPMail.AppendBody('</tr>');
        Clear(RecSalesLine);
        RecSalesLine.SetRange("Document Type", RecSalesLine."Document Type"::Invoice);
        RecSalesLine.SetRange("Document No.", RecSalesHeader."No.");
        RecSalesLine.SetFilter(Type, '=%1', RecSalesLine.Type::Item);
        RecSalesLine.SetFilter(Quantity, '>%1', 0);
        if RecSalesLine.FindSet() then begin
            repeat
                SMTPMail.AppendBody('<tr>');
                SMTPMail.AppendBody('<td align="left"> ' + RecSalesLine."No." + '</td>');
                SMTPMail.AppendBody('<td align="left"> ' + RecSalesLine."Vendor Article No" + '</td>');
                SMTPMail.AppendBody('<td align="left"> ' + RecSalesLine.Description + '</td>');
                SMTPMail.AppendBody('<td align="Right"> ' + Format(RecSalesLine.Quantity, 0, '<Precision,2:2><Standard Format,0>') + ' </td>');
                SMTPMail.AppendBody('</tr>');
            until RecSalesLine.Next() = 0;
        end;
        SMTPMail.AppendBody('</table>');
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
        RecSalesHeader: Record "Sales Header";
        NoG: Code[20];


    local procedure Addstyle()
    begin
        SMTPMail.AppendBody('<style>@font-face	{font-family:Helvetica;        panose-1:2 11 6 4 2 2 2 2 2 4;}@font-face	{font-family:"Cambria Math";	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face	{font-family:Calibri;	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face	{font-family:"Segoe UI";	panose-1:2 11 5 2 4 2 4 2 2 3;} p.MsoNormal, li.MsoNormal, div.MsoNormal	{margin:0in;	margin-bottom:.0001pt;	font-size:11.0pt;	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink	{mso-style-priority:99;	color:#0563C1;	text-decoration:underline;}a:visited, span.MsoHyperlinkFollowed	{mso-style-priority:99;	color:#954F72;	text-decoration:underline;}p.msonormal0, li.msonormal0, div.msonormal00	{mso-style-name:msonormal;	mso-margin-top-alt:auto;	margin-right:0in;	mso-margin-bottom-alt:auto;	margin-left:0in;	font-size:11.0pt;	font-family:"Calibri",sans-serif;}span.EmailStyle18	{mso-style-type:personal;	font-family:"Calibri",sans-serif;	color:windowtext;}span.EmailStyle19	{mso-style-type:personal-reply;	font-family:"Calibri",sans-serif;	color:windowtext;}.MsoChpDefault	{mso-style-type:export-only;	font-size:10.0pt;} @page WordSection1{     size:8.5in 11.0in;     margin:1.0in 1.0in 1.0in 1.0in;}div.WordSection1	{page:WordSection1;}@list l0	{mso-list-id:652948990;	mso-list-template-ids:414455188;}@list l1	{mso-list-id:1383752550;	mso-list-template-ids:612022788;}@list l1:level1	{mso-level-tab-stop:.5in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level2	{mso-level-tab-stop:1.0in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level3	{mso-level-tab-stop:1.5in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level4	{mso-level-tab-stop:2.0in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level5	{mso-level-tab-stop:2.5in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level6	{mso-level-tab-stop:3.0in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level7	{mso-level-tab-stop:3.5in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level8	{mso-level-tab-stop:4.0in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level9	{mso-level-tab-stop:4.5in;	mso-level-number-position:left;	text-indent:-.25in;}ol	{margin-bottom:0in;}ul	{margin-bottom:0in;} </style>');
    end;
}

