report 50107 "OA Daily Report"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    dataset
    {
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }
    }

    trigger OnPostReport()
    var
        RecSalesheader: Record "Sales Header";
        RecSheader: Record "Sales Header";
        RecUserSetup: Record "User Setup";
        RecCompanies: Record Company;
        SMTPSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
        CurrencyFactor: Decimal;
        DocUrl: Text;
        Total1: Decimal;
        Total2: Decimal;
        GrandTotal1: Decimal;
        GrandTotal2: Decimal;
        EmailIDs: Text;
        BaseCurrencyFactor: Decimal;
        LocalCurrency: Text;
        RecGenLedSetup: Record "General Ledger Setup";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        ExchangeRateAmt: Decimal;
        ExchDate: Date;
        RecSalesPerson: Record "Salesperson/Purchaser";
        Istotal: Integer;
        RecCompanyInfo: Record "Company Information";
        ExchCurrency: Decimal;
        EmailList: List of [Text];
        BccEmail: List of [Text];
    begin
        SMTPSetup.GET();
        Clear(RecUserSetup);
        Clear(LocalCurrency);
        Clear(ExchCurrency);
        Clear(EmailIDs);
        RecGenLedSetup.GET;
        LocalCurrency := RecGenLedSetup."LCY Code";
        RecUserSetup.SetRange("Receive Daily SO Report", true);
        RecUserSetup.SetFilter("E-Mail", '<>%1', '');
        if RecUserSetup.FindSet() then begin
            repeat
                //EmailIDs += RecUserSetup."E-Mail" + ';';
                EmailList.Add(RecUserSetup."E-Mail");
            until RecUserSetup.Next() = 0;
        end;
        // if EmailIDs = '' then
        //     exit;
        if EmailList.Count = 0 then
            exit;
        //EmailIDs := CopyStr(EmailIDs, 1, StrLen(EmailIDs) - 1);
        // SMTPMail.CreateMessage('Dynamics Notification', SMTPSetup."User ID", EmailIDs, 'Order Acknowledgements Today ' + FORMAT(WorkDate(), 0, '<day,2>/<month,2>/<year4>'), '', true);
        SMTPMail.CreateMessage('Dynamics Notification', SMTPSetup."User ID", EmailList, 'Order Acknowledgements Today ' + FORMAT(WorkDate(), 0, '<day,2>/<month,2>/<year4>'), '');
        //SMTPMail.CreateMessage('Dynamics Notification', SMTPSetup."User ID", EmailList, 'Order Acknowledgements From ' + FORMAT(CALCDATE('-1W', WorkDate()), 0, '<day,2>/<month,2>/<year4>') + ' To ' + Format(WorkDate(), 0, '<day,2>/<month,2>/<year4>'), '');
        //FORMAT(WorkDate(), 0, '<day,2>/<month,2>/<year4>')
        BccEmail.Add('krishnakumar.r@levtechconsulting.com');
        //SMTPMail.AddBCC(BccEmail);
        SMTPMail.AppendBody('</br>');
        SMTPMail.AppendBody('<p>Report : Order Acknowledgements Today</p>');
        SMTPMail.AppendBody('<p>Date : ' + FORMAT(CURRENTDATETIME, 0, '<day,2>/<month,2>/<year4> <Hours12>:<Minutes,2> <AM/PM>') + '</p>');
        SMTPMail.AppendBody('<table Border="1" Style="border-style: none; width: 100%; border-collapse: collapse; transform: scale(1); transform-origin: left top 0px;">');
        SMTPMail.AppendBody('<tr>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#b2e8ed"> <font color="#000000"> Company </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#b2e8ed"> <font color="#000000">OA Reference </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#b2e8ed"><font color="#000000"> Order Date </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#b2e8ed"> <font color="#000000">Project Name </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#b2e8ed"> <font color="#000000">Customer Name </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#b2e8ed"> <font color="#000000"> Amount </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#b2e8ed"><font color="#000000"> Currency </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#b2e8ed"><font color="#000000"> Amount (' + LocalCurrency + ')</font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#b2e8ed"> <font color="#000000"> Salesperson </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#b2e8ed"> <font color="#000000">Status </font></th>');
        SMTPMail.AppendBody('</tr>');
        Clear(RecCompanies);
        Clear(GrandTotal1);
        Clear(GrandTotal2);
        RecCompanies.SetFilter(Name, '<>%1', '');
        if RecCompanies.FindSet() then begin
            repeat
                Clear(RecCompanyInfo);
                RecCompanyInfo.ChangeCompany(RecCompanies.Name);
                RecCompanyInfo.GET;
                if RecCompanyInfo."Enable Auto Report" then begin
                    Clear(RecSalesheader);
                    Clear(Total1);
                    Clear(Total2);
                    Clear(Istotal);
                    RecSalesheader.ChangeCompany(RecCompanies.Name);
                    RecSalesheader.SetRange("Document Type", RecSalesheader."Document Type"::Order);
                    RecSalesheader.SetRange("Order Date", Workdate());//CalcDate('-1D', Workdate()));
                    //RecSalesheader.SetFilter("Order Date", FORMAT(CALCDATE('-1W', WorkDate())) + '..' + Format(WorkDate()));//CalcDate('-1D', Workdate()));
                    if RecSalesheader.FindSet() then begin
                        repeat
                            RecSalesheader.CalcFields("Amount Including VAT");
                            if RecSalesheader."Amount Including VAT" <> 0 then begin
                                Istotal += 1;
                                DocUrl := GETURL(CLIENTTYPE::Web, RecCompanies.Name, OBJECTTYPE::Page, 42, RecSalesheader, FALSE);
                                SMTPMail.AppendBody('<tr>');
                                SMTPMail.AppendBody('<td align="left"   > ' + RecCompanies.Name + ' </td>');
                                SMTPMail.AppendBody('<td align="left"   > <a href="' + DocUrl + '">' + RecSalesheader."No." + ' </a></td>');
                                SMTPMail.AppendBody('<td align="left"   > ' + FORMAT(RecSalesheader."Order Date", 0, '<day,2>/<month,2>/<year4>') + ' </td>');
                                SMTPMail.AppendBody('<td align="left"   > ' + RecSalesheader."Project Name" + '</td>');
                                SMTPMail.AppendBody('<td align="left"   > ' + RecSalesheader."Sell-to Customer Name" + ' </td>');

                                Clear(CurrencyFactor);//

                                if RecSalesheader."Currency Factor" <> 0 then
                                    CurrencyFactor := RecSalesheader."Currency Factor"
                                else
                                    CurrencyFactor := 1;

                                //SMTPMail.AppendBody('<td align="right"   >  ' + FORMAT(Round(RecSalesheader."Amount Including VAT" / CurrencyFactor, 0.01, '>'), 0, '<Precision,2:2><Standard Format,0>') + '</th>');
                                //As per changes we need to display the same amount as it is mentioned in the order with currency
                                SMTPMail.AppendBody('<td align="right"   >  ' + FORMAT(Round(RecSalesheader."Amount Including VAT", 0.01, '>'), 0, '<Precision,2:2><Standard Format,0>') + '</th>');
                                Total1 += (Round(RecSalesheader."Amount Including VAT" / CurrencyFactor, 0.01, '>'));//Round(RecSalesheader."Amount Including VAT" * CurrencyFactor, 0.01, '=');
                                GrandTotal1 += (Round(RecSalesheader."Amount Including VAT" / CurrencyFactor, 0.01, '>'));//Round(RecSalesheader."Amount Including VAT" * CurrencyFactor, 0.01, '=');
                                SMTPMail.AppendBody('<td align="left"   > ' + RecSalesheader."Currency Code" + '</td>');
                                Clear(CurrencyExchangeRate);
                                CurrencyExchangeRate.ChangeCompany(RecCompanies.Name);
                                ExchangeRateAmt := CurrencyExchangeRate.GetCurrentCurrencyFactor(LocalCurrency);

                                SMTPMail.AppendBody('<td align="right"   > ' + FORMAT(Round((RecSalesheader."Amount Including VAT" / CurrencyFactor) * ExchangeRateAmt, 0.01, '>'), 0, '<Precision,2:2><Standard Format,0>') + ' </td>');
                                Total2 += Round(RecSalesheader."Amount Including VAT" / CurrencyFactor, 0.01, '>') * ExchangeRateAmt;//Round(RecSalesheader."Amount Including VAT" * ExchCurrency, 0.01, '=');
                                GrandTotal2 += Round(RecSalesheader."Amount Including VAT" / CurrencyFactor, 0.01, '>') * ExchangeRateAmt;//Round(RecSalesheader."Amount Including VAT" * ExchCurrency, 0.01, '=');
                                Clear(RecSalesPerson);
                                RecSalesPerson.ChangeCompany(RecCompanies.Name);
                                if RecSalesPerson.GET(RecSalesheader."Salesperson Code") THEN
                                    SMTPMail.AppendBody('<td align="left"   >  ' + RecSalesPerson.Name + ' </td>')
                                else
                                    SMTPMail.AppendBody('<td align="left"   >  ' + '' + ' </td>');
                                SMTPMail.AppendBody('<td align="left"   > ' + FORMAT(RecSalesheader.Status) + ' </td>');
                                SMTPMail.AppendBody('</tr>');
                            end;
                        until RecSalesheader.Next() = 0;
                    end;
                    Clear(RecSalesheader);
                    Clear(RecSheader);
                    if Istotal <> 0 then begin
                        SMTPMail.AppendBody('<tr>');
                        SMTPMail.AppendBody('<td align="left"   >  <b>Sub Total </b></td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('<td align="right"  > <b>  ' + FORMAT(Round(Total2, 0.01, '>'), 0, '<Precision,2:2><Standard Format,0>') + ' </b></td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('</tr>');
                    end;
                end;
            until RecCompanies.Next() = 0;
        end;
        SMTPMail.AppendBody('<tr>');
        SMTPMail.AppendBody('<td align="left"   > <b>Total </b> </td>');
        SMTPMail.AppendBody('<td align="left"   ></td>');
        SMTPMail.AppendBody('<td align="left"   ></td>');
        SMTPMail.AppendBody('<td align="left"   ></td>');
        SMTPMail.AppendBody('<td align="left"   ></td>');
        SMTPMail.AppendBody('<td align="left"   ></td>');
        //SMTPMail.AppendBody('<td align="left"   >  ' + FORMAT(Round(GrandTotal1, 0.01, '>'), 0, '<Precision,2:2><Standard Format,0>') + '</th>');
        SMTPMail.AppendBody('<td align="left"   ></td>');
        SMTPMail.AppendBody('<td align="right"  > <b>' + FORMAT(Round(GrandTotal2, 0.01, '>'), 0, '<Precision,2:2><Standard Format,0>') + '</b> </td>');
        SMTPMail.AppendBody('<td align="left"   ></td>');
        SMTPMail.AppendBody('<td align="left"   ></td>');
        SMTPMail.AppendBody('</tr>');

        SMTPMail.AppendBody('</table>');
        SMTPMail.AppendBody('</br></br>');

        SMTPMail.AppendBody('<p>This email is sent by Huda Lighting Business Central</p>');
        if GrandTotal2 <> 0 then
            SMTPMail.Send();
    end;
}