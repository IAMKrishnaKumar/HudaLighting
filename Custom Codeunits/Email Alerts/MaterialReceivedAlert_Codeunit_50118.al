codeunit 50118 "Material Received Alert"
{
    trigger OnRun()
    var

    begin

    end;

    procedure SendEmail(): Boolean
    var
        TempBlob: Codeunit "Temp Blob";
        ReportInOutStream: OutStream;
        ReportInStream: InStream;
        TxtAttachmentName: TextConst ENG = 'MRN - %1.pdf';
        AttachmentName, PostedSourceNumber : Text;
        ReportID: Integer;
        RecPurchHeader: Record "Purchase Header";
        CheckList: List of [Text];
        Subject: Text;
    begin
        RecCompanyInfo.GET;
        IF NOT RecCompanyInfo."Materials Received by Whse." THEN
            EXIT(false);
        InitializeRecords();
        Clear(ToEmailList);
        if RecCompanyInfo."Materials Rec. by Whse. Email" <> '' then begin
            ToEmailList.Add(RecCompanyInfo."Materials Rec. by Whse. Email");
        end;

        //PurchRcptHeaderG.TestField("Purchaser Code");
        Clear(RecSalesPerson);
        if RecSalesPerson.Get(PurchRcptHeaderG."Purchaser Code") then;
        if RecSalesPerson."E-Mail" <> '' then
            ToEmailList.Add(RecSalesPerson."E-Mail");
        if RecSalesPerson."E-Mail 2" <> '' then
            ToEmailList.Add(RecSalesPerson."E-Mail 2");
        if ToEmailList.Count = 0 then
            exit(false);
        if IsSalesOrderAvailable then
            Subject := 'Material Received: ' + PurchRcptHeaderG."No." + ' - ' + PurchRcptHeaderG."Buy-from Vendor Name" + ' - ' + RecPurchHeader."No." + ' - ' + RecSalesheader."No." + ' - ' + RecSalesheader."Project Name"//RecPurchaseHeader
        else
            Subject := 'Material Received: ' + PurchRcptHeaderG."No." + ' - ' + PurchRcptHeaderG."Buy-from Vendor Name" + ' - ' + RecPurchHeader."No.";
        SMTPSetup.GET;
        SMTPMail.CreateMessage('Dynamics Notification', SMTPSetup."User ID", ToEmailList, Subject, '');

        AppendHTMLBody();
        Clear(RecReportSelection);
        Clear(ReportID);
        RecReportSelection.SetRange(Usage, RecReportSelection.Usage::"P.Receipt");
        RecReportSelection.SetRange(Sequence, '1');
        if RecReportSelection.FindFirst() then begin
            ReportID := RecReportSelection."Report ID";
        end else
            ReportID := Report::"Posted GRN Report";
        Clear(TempBlob);
        TempBlob.CreateOutStream(ReportInOutStream);
        SaveDocumentAsPDFToStream(ReportID, PurchRcptHeaderG, ReportInOutStream);
        TempBlob.CreateInStream(ReportInStream);
        Clear(AttachmentName);
        AttachmentName := StrSubstNo(TxtAttachmentName, PurchRcptHeaderG."No.");
        SMTPMail.AddAttachmentStream(ReportInStream, AttachmentName);
        exit(SMTPMail.Send());
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
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Hi <b>' + RecSalesPerson."Alias Name" + ' </b>! <o:p></o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black"><o:p>&nbsp;</o:p></span></p>');
        if IsSalesOrderAvailable then
            SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Good news! Materials against your OA <b>' + RecSalesHeader."No." + '</b> has been received at the Warehouse on ' + FORMAT(WorkDate(), 0, '<day,2>/<month,2>/<year4>') + '.<o:p></o:p></span></p>')
        else
            SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Good news! Materials against your OA <b> </b> has been received at the Warehouse on ' + FORMAT(WorkDate(), 0, '<day,2>/<month,2>/<year4>') + '.<o:p></o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black"><o:p>&nbsp;</o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black"><b>Summary of your Shipment: </b><o:p></o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Opportunity Reference: ' + RecPurchaseHeader."Shortcut Dimension 1 Code" + '<o:p></o:p></span> </p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Project Name: ' + RecPurchaseHeader."Project Name" + '<o:p></o:p></span></p>');
        RecPurchaseHeader.CalcFields("Amount Including VAT");
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Order Amount Inc. VAT (' + RecPurchaseHeader."Currency Code" + '): ' + FORMAT(ROUND(RecPurchaseHeader."Amount Including VAT", 0.01, '='), 0, '<Precision,2:2><Standard Format,0>') + '<o:p></o:p></span> </p>');
        Clear(CurrencyExchangeRate);
        Clear(ExchangeRateAmt);
        Clear(CurrencyFactor);
        GLSetup.GET;
        if RecPurchaseHeader."Currency Factor" <> 0 then
            CurrencyFactor := RecPurchaseHeader."Currency Factor"
        else
            CurrencyFactor := 1;
        ExchangeRateAmt := CurrencyExchangeRate.GetCurrentCurrencyFactor(GLSetup."LCY Code");

        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Order Amount Inc. VAT (' + GLSetup."LCY Code" + '): ' + FORMAT(ROUND((RecPurchaseHeader."Amount Including VAT" / CurrencyFactor) * ExchangeRateAmt, 0.01, '='), 0, '<Precision,2:2><Standard Format,0>') + '<o:p></o:p></span> </p>');
        if IsSalesOrderAvailable then
            SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Account Name: ' + RecSalesHeader."Sell-to Customer Name" + '<o:p></o:p></span></p>')
        else
            SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Account Name: <o:p></o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Vendor Name: ' + RecPurchaseHeader."Buy-from Vendor Name" + '<o:p></o:p></span></p>');
        Clear(RecPayTerm);
        if RecPurchaseHeader."Payment Terms Code" <> '' then begin
            IF RecPayTerm.GET(RecPurchaseHeader."Payment Terms Code") then
                SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Payment Terms: ' + RecPayTerm.Description + '<o:p></o:p></span></p>');
        end else
            SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Payment Terms: <o:p></o:p></span></p>');
        if RecPurchaseHeader."Shipment Method Code" <> '' then begin
            Clear(RecShipmentMethod);
            if RecShipmentMethod.GET(RecPurchaseHeader."Shipment Method Code") then
                SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Delivery Method: ' + RecShipmentMethod.Description + ' <o:p></o:p></span></p>');
        end else
            SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Delivery Method:  <o:p></o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black"><o:p>&nbsp;</o:p></span></p>');
        AddItemDetail();
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black"><o:p>&nbsp;</o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Please refer to the General Project Status Report for the expected delivery time and order lines details.<o:p></o:p></span></p>');
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

    procedure SetPurchRcptHeader(NoL: Code[20])
    begin
        Clear(NoG);
        NoG := NoL;
        IsSalesOrderAvailable := false;
    end;

    local procedure InitializeRecords()
    begin
        Clear(PurchRcptHeaderG);
        PurchRcptHeaderG.SetRange("No.", NoG);
        if PurchRcptHeaderG.FindFirst() then;
        Clear(RecPurchRcptLine);
        RecPurchRcptLine.SetRange("Document No.", PurchRcptHeaderG."No.");
        RecPurchRcptLine.SetFilter("HL Sales Order No.", '<>%1', '');
        if RecPurchRcptLine.FindFirst() then begin
            Clear(RecSalesheader);
            RecSalesheader.SetRange("Document Type", RecSalesheader."Document Type"::Order);
            RecSalesheader.SetRange("No.", RecPurchRcptLine."HL Sales Order No.");
            if RecSalesheader.FindFirst() then
                IsSalesOrderAvailable := true
            else
                IsSalesOrderAvailable := false;
        end else
            IsSalesOrderAvailable := false;
        Clear(RecPurchaseHeader);
        RecPurchaseHeader.SetRange("Document Type", RecPurchaseHeader."Document Type"::Order);
        RecPurchaseHeader.SetRange("No.", PurchRcptHeaderG."Order No.");
        if RecPurchaseHeader.FindFirst() then;
    end;

    local procedure AddItemDetail()
    begin
        Clear(RecPurchRcptLine);
        RecPurchRcptLine.SetRange("Document No.", PurchRcptHeaderG."No.");
        RecPurchRcptLine.SetFilter(Quantity, '<>%1', 0);
        if RecPurchRcptLine.FindSet() then begin
            SMTPMail.AppendBody('<table Border="1" Style="border-style: none; width: 100%; border-collapse: collapse; transform: scale(1); transform-origin: left top 0px;">');
            SMTPMail.AppendBody('<tr>');
            SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"> <font color="#ffffff">  Item No. </font></th>');
            SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"> <font color="#ffffff"> Vendor Article No. </font></th>');
            SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"> <font color="#ffffff"> Item Description </font></th>');
            SMTPMail.AppendBody('<th align="Right" bgcolor="#4b929c"> <font color="#ffffff"> Quantity Received </font></th>');
            SMTPMail.AppendBody('<th align="Right" bgcolor="#4b929c"> <font color="#ffffff"> Quantity Remaining </font></th>');
            SMTPMail.AppendBody('</tr>');
            repeat
                SMTPMail.AppendBody('<tr>');
                SMTPMail.AppendBody('<td align="left"> ' + RecPurchRcptLine."No." + '</td>');
                SMTPMail.AppendBody('<td align="left"> ' + RecPurchRcptLine."Vendor Article No" + '</td>');
                SMTPMail.AppendBody('<td align="left"> ' + RecPurchRcptLine.Description + '</td>');
                SMTPMail.AppendBody('<td align="Right"> ' + Format(RecPurchRcptLine.Quantity, 0, '<Precision,2:2><Standard Format,0>') + ' </td>');
                Clear(RecPurchLine);
                RecPurchLine.SetRange("Document Type", RecPurchLine."Document Type"::Order);
                RecPurchLine.SetRange("Document No.", RecPurchRcptLine."Order No.");
                RecPurchLine.SetRange("Line No.", RecPurchRcptLine."Line No.");
                if RecPurchLine.FindFirst() then
                    SMTPMail.AppendBody('<td align="Right"> ' + Format(RecPurchLine."Outstanding Quantity", 0, '<Precision,2:2><Standard Format,0>') + ' </td>')
                else
                    SMTPMail.AppendBody('<td align="Right"> 0 </td>');
                SMTPMail.AppendBody('</tr>');
            until RecPurchRcptLine.Next() = 0;
            SMTPMail.AppendBody('</table>');
        end;
    end;

    var
        RecCompanyInfo: Record "Company Information";
        PostedWhseRcptNoG: Code[20];
        NoG: Code[20];
        ToEmailList, CCEmailList, BccEmailList : List of [Text];
        RecSalesPerson: Record "Salesperson/Purchaser";
        RecReportSelection: Record "Report Selections";
        SMTPSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
        PurchRcptHeaderG: Record "Purch. Rcpt. Header";
        RecPurchRcptLine: Record "Purch. Rcpt. Line";
        RecSalesheader: Record "Sales Header";
        RecPurchaseHeader: Record "Purchase Header";
        RecPurchLine: Record "Purchase Line";
        IsSalesOrderAvailable: Boolean;


    local procedure Addstyle()
    begin
        SMTPMail.AppendBody('<style>@font-face	{font-family:Helvetica;        panose-1:2 11 6 4 2 2 2 2 2 4;}@font-face	{font-family:"Cambria Math";	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face	{font-family:Calibri;	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face	{font-family:"Segoe UI";	panose-1:2 11 5 2 4 2 4 2 2 3;} p.MsoNormal, li.MsoNormal, div.MsoNormal	{margin:0in;	margin-bottom:.0001pt;	font-size:11.0pt;	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink	{mso-style-priority:99;	color:#0563C1;	text-decoration:underline;}a:visited, span.MsoHyperlinkFollowed	{mso-style-priority:99;	color:#954F72;	text-decoration:underline;}p.msonormal0, li.msonormal0, div.msonormal00	{mso-style-name:msonormal;	mso-margin-top-alt:auto;	margin-right:0in;	mso-margin-bottom-alt:auto;	margin-left:0in;	font-size:11.0pt;	font-family:"Calibri",sans-serif;}span.EmailStyle18	{mso-style-type:personal;	font-family:"Calibri",sans-serif;	color:windowtext;}span.EmailStyle19	{mso-style-type:personal-reply;	font-family:"Calibri",sans-serif;	color:windowtext;}.MsoChpDefault	{mso-style-type:export-only;	font-size:10.0pt;} @page WordSection1{     size:8.5in 11.0in;     margin:1.0in 1.0in 1.0in 1.0in;}div.WordSection1	{page:WordSection1;}@list l0	{mso-list-id:652948990;	mso-list-template-ids:414455188;}@list l1	{mso-list-id:1383752550;	mso-list-template-ids:612022788;}@list l1:level1	{mso-level-tab-stop:.5in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level2	{mso-level-tab-stop:1.0in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level3	{mso-level-tab-stop:1.5in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level4	{mso-level-tab-stop:2.0in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level5	{mso-level-tab-stop:2.5in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level6	{mso-level-tab-stop:3.0in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level7	{mso-level-tab-stop:3.5in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level8	{mso-level-tab-stop:4.0in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level9	{mso-level-tab-stop:4.5in;	mso-level-number-position:left;	text-indent:-.25in;}ol	{margin-bottom:0in;}ul	{margin-bottom:0in;} </style>');
    end;
}

