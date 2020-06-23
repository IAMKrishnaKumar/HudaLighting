codeunit 50119 "Sales Invoice Posting Alert"
{//Completed
    trigger OnRun()
    var
        TempBlob: Codeunit "Temp Blob";
        ReportInOutStream: OutStream;
        ReportInStream: InStream;
        TxtAttachmentName: TextConst ENG = 'PSI - %1.pdf';
        AttachmentName: Text;
        ReportID: Integer;
        Subject: Text;
    begin
        RecCompanyInfo.GET;
        IF NOT RecCompanyInfo."Sales Invoice Posting" THEN
            EXIT;
        RecSalesHeader.FindFirst();//if it will throw error then error will be saved in log.
        RecSalesInvHeader.FindFirst();///////////////For posted sales invoice
        RecSalesHeader.TestField("Salesperson Code");
        Clear(RecSalesPerson);
        RecSalesPerson.GET(RecSalesHeader."Salesperson Code");
        if (RecSalesPerson."E-Mail" = '') AND (RecSalesPerson."E-Mail 2" = '') THEN
            RecSalesPerson.TestField("E-Mail");
        Clear(ToEmailList);
        if RecSalesPerson."E-Mail" <> '' then
            ToEmailList.Add(RecSalesPerson."E-Mail");
        if RecSalesPerson."E-Mail 2" <> '' then
            ToEmailList.Add(RecSalesPerson."E-Mail 2");
        if RecCompanyInfo."Sales Invoice Posting Email" <> '' then begin
            ToEmailList.Add(RecCompanyInfo."Sales Invoice Posting Email");
        end;
        Subject := 'Posted Sales Invoice: IN - ' + RecSalesHeader."No." + ' - ' + RecSalesHeader."Sell-to Customer Name" + ' - ' + RecSalesHeader."Project Name" + ' - ' + RecSalesHeader."PO Reference";
        SMTPSetup.GET;
        SMTPMail.CreateMessage('Dynamics Notification', SMTPSetup."User ID", ToEmailList, Subject, '');
        AppendHTMLBody();
        Clear(RecReportSelection);
        Clear(ReportID);
        RecReportSelection.SetRange(Usage, RecReportSelection.Usage::"S.Invoice");
        RecReportSelection.SetRange(Sequence, '1');
        if RecReportSelection.FindFirst() then begin
            ReportID := RecReportSelection."Report ID";
        end else
            ReportID := Report::"Sales Invoice Report";

        Clear(TempBlob);
        TempBlob.CreateOutStream(ReportInOutStream);
        SaveDocumentAsPDFToStream(ReportID, RecSalesInvHeader, ReportInOutStream);
        TempBlob.CreateInStream(ReportInStream);
        Clear(AttachmentName);
        AttachmentName := StrSubstNo(TxtAttachmentName, RecSalesInvHeader."No.");
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
        RecSalesLine: Record "Sales Line";
        RecOAheader: Record "Sales Header";
        RecPaymentMethod: Record "Payment Method";
    begin
        Addstyle();
        Clear(RecSalesLine);
        RecSalesLine.SetRange("Document Type", RecSalesLine."Document Type"::Invoice);
        RecSalesLine.SetRange("Document No.", RecSalesHeader."No.");
        RecSalesLine.SetFilter("Sales Order No.", '<>%1', '');
        if RecSalesLine.FindFirst() then begin
            Clear(RecOAheader);
            RecOAheader.SetRange("Document Type", RecOAheader."Document Type"::Order);
            RecOAheader.SetRange("No.", RecSalesLine."Sales Order No.");
            if RecOAheader.FindFirst() then;
        end;
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Hi <b>' + RecSalesPerson."Alias Name" + '</b>! Invoice <b>' + RecSalesHeader."No." + '</b> against your OA <b>' + RecOAheader."No." + '</b> has been posted on ' + FORMAT(WorkDate(), 0, '<day,2>/<month,2>/<year4>') + '.<o:p></o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black"><o:p>&nbsp;</o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Summary of your Invoice <o:p></o:p></span></p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Opportunity Reference: ' + RecSalesHeader."Shortcut Dimension 1 Code" + '<o:p></o:p></span> </p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Project Name: ' + RecSalesHeader."Project Name" + '<o:p></o:p></span></p>');
        RecOAheader.CalcFields("Amount Including VAT");
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Order Amount Inc. VAT(' + RecSalesHeader."Currency Code" + '): ' + FORMAT(ROUND((RecOAheader."Amount Including VAT"), 0.01, '='), 0, '<Precision,2:2><Standard Format,0>') + '<o:p></o:p></span> </p>');
        Clear(CurrencyExchangeRate);
        Clear(ExchangeRateAmt);
        Clear(CurrencyFactor);
        GLSetup.GET;
        if RecOAheader."Currency Factor" <> 0 then
            CurrencyFactor := RecOAheader."Currency Factor"
        else
            CurrencyFactor := 1;
        //ExchangeRateAmt := CurrencyExchangeRate.GetCurrentCurrencyFactor(GLSetup."LCY Code");
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Order Amount Inc. VAT (' + GLSetup."LCY Code" + '): ' + FORMAT(ROUND((RecOAheader."Amount Including VAT" / CurrencyFactor), 0.01, '='), 0, '<Precision,2:2><Standard Format,0>') + '<o:p></o:p></span> </p>');
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Account Name: ' + RecSalesHeader."Sell-to Customer Name" + '<o:p></o:p></span></p>');
        Clear(RecPayTerm);
        if RecSalesHeader."Payment Terms Code" <> '' then begin
            IF RecPayTerm.GET(RecSalesHeader."Payment Terms Code") then
                SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Payment Terms: ' + RecPayTerm.Description + '<o:p></o:p></span></p>');
        end;
        if RecSalesHeader."Payment Method Code" <> '' then begin
            Clear(RecPaymentMethod);
            if RecPaymentMethod.GET(RecSalesHeader."Payment Method Code") then
                SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Invoice Settled in: ' + RecPaymentMethod.Description + ' <o:p></o:p></span></p>');
        end;
        RecSalesHeader.CalcFields("Amount Including VAT");
        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Invoiced Amount Inc. VAT(' + RecSalesHeader."Currency Code" + '): ' + FORMAT(ROUND((RecSalesHeader."Amount Including VAT"), 0.01, '='), 0, '<Precision,2:2><Standard Format,0>') + ' <o:p></o:p></span></p>');

        if RecSalesHeader."Currency Factor" <> 0 then
            CurrencyFactor := RecSalesHeader."Currency Factor"
        else
            CurrencyFactor := 1;

        SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Invoiced Amount Inc. VAT(' + GLSetup."LCY Code" + '): ' + FORMAT(ROUND((RecSalesHeader."Amount Including VAT" / CurrencyFactor), 0.01, '='), 0, '<Precision,2:2><Standard Format,0>') + ' <o:p></o:p></span></p>');
        Clear(RecCustLedger);
        RecCustLedger.SetRange("Document No.", RecSalesInvHeader."No.");
        if RecCustLedger.FindSet() then begin
            RecCustLedger.CalcFields("Remaining Amount");
            SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Outstanding Amount(' + RecCustLedger."Currency Code" + '): ' + FORMAT(ROUND(ABS(RecCustLedger."Remaining Amount"), 0.01, '='), 0, '<Precision,2:2><Standard Format,0>') + ' <o:p></o:p></span></p>');
            SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Outstanding Amount(' + GLSetup."LCY Code" + '): ' + FORMAT(ROUND(ABS(RecCustLedger."Remaining Amt. (LCY)"), 0.01, '='), 0, '<Precision,2:2><Standard Format,0>') + ' <o:p></o:p></span></p>');
        end else begin
            SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Outstanding Amount: <o:p></o:p></span></p>');
            SMTPMail.AppendBody('<p class=MsoNormal><span style="font-size:12.0pt;font-family:"Times New Roman",serif;color:black">Outstanding Amount: <o:p></o:p></span></p>');
        end;

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
        //DataTypeMgt.GetRecordRef(DocumentVariant, DocumentRef);
        if Report.SaveAs(ReportID, '', ReportFormat::Pdf, VarOutStream, DocumentRef) then
            exit(true);
    end;

    procedure SetSalesOrderNumber(NoL: Code[20])
    begin
        Clear(RecSalesHeader);
        RecSalesHeader.SetRange("Document Type", RecSalesHeader."Document Type"::Invoice);
        RecSalesHeader.SetRange("No.", NoL);
    end;

    procedure SetPostedSalesInvoiceNo(NoL: Code[20])
    begin
        Clear(RecSalesInvHeader);
        RecSalesInvHeader.SetRange("No.", NoL);
    end;

    var
        RecCompanyInfo: Record "Company Information";
        ToEmailList: List of [Text];
        RecSalesInvHeader: Record "Sales Invoice Header";
        CCEmailList: List of [Text];
        BccEmailList: List of [Text];
        RecSalesPerson: Record "Salesperson/Purchaser";
        RecReportSelection: Record "Report Selections";
        SMTPSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
        RecSalesHeader: Record "Sales Header";
        RecCustLedger: Record "Cust. Ledger Entry";


    local procedure Addstyle()
    begin
        SMTPMail.AppendBody('<style>@font-face	{font-family:Helvetica;        panose-1:2 11 6 4 2 2 2 2 2 4;}@font-face	{font-family:"Cambria Math";	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face	{font-family:Calibri;	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face	{font-family:"Segoe UI";	panose-1:2 11 5 2 4 2 4 2 2 3;} p.MsoNormal, li.MsoNormal, div.MsoNormal	{margin:0in;	margin-bottom:.0001pt;	font-size:11.0pt;	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink	{mso-style-priority:99;	color:#0563C1;	text-decoration:underline;}a:visited, span.MsoHyperlinkFollowed	{mso-style-priority:99;	color:#954F72;	text-decoration:underline;}p.msonormal0, li.msonormal0, div.msonormal00	{mso-style-name:msonormal;	mso-margin-top-alt:auto;	margin-right:0in;	mso-margin-bottom-alt:auto;	margin-left:0in;	font-size:11.0pt;	font-family:"Calibri",sans-serif;}span.EmailStyle18	{mso-style-type:personal;	font-family:"Calibri",sans-serif;	color:windowtext;}span.EmailStyle19	{mso-style-type:personal-reply;	font-family:"Calibri",sans-serif;	color:windowtext;}.MsoChpDefault	{mso-style-type:export-only;	font-size:10.0pt;} @page WordSection1{     size:8.5in 11.0in;     margin:1.0in 1.0in 1.0in 1.0in;}div.WordSection1	{page:WordSection1;}@list l0	{mso-list-id:652948990;	mso-list-template-ids:414455188;}@list l1	{mso-list-id:1383752550;	mso-list-template-ids:612022788;}@list l1:level1	{mso-level-tab-stop:.5in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level2	{mso-level-tab-stop:1.0in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level3	{mso-level-tab-stop:1.5in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level4	{mso-level-tab-stop:2.0in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level5	{mso-level-tab-stop:2.5in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level6	{mso-level-tab-stop:3.0in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level7	{mso-level-tab-stop:3.5in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level8	{mso-level-tab-stop:4.0in;	mso-level-number-position:left;	text-indent:-.25in;}@list l1:level9	{mso-level-tab-stop:4.5in;	mso-level-number-position:left;	text-indent:-.25in;}ol	{margin-bottom:0in;}ul	{margin-bottom:0in;} </style>');
    end;
}

