report 50139 "PO Backlog Report"
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
        RecPurchHeader: Record "Purchase Header";
        RecPheader: Record "Purchase Header";
        RecSnRSetup: Record "Sales & Receivables Setup";
        RecCompanies: Record Company;
        SMTPSetup: Record "SMTP Mail Setup";
        RecUserSetup: Record "User Setup";
        SMTPMail: Codeunit "SMTP Mail";
        CurrencyFactor: Decimal;
        DocUrl: Text;
        Total1: Decimal;
        GrandTotal1: Decimal;
        GrandTotal2: Decimal;
        Total2: Decimal;
        Total3: Decimal;
        EmailIDs: Text;
        LocalCurrency: Text;
        RecGenLedSetup: Record "General Ledger Setup";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        ExchangeRateAmt: Decimal;
        ExchDate: Date;
        RecSalesPerson: Record "Salesperson/Purchaser";
        Istotal: Integer;
        RecCompanyInfo: Record "Company Information";
        ExchCurrency: Decimal;
        RecAccessControl: Record "Access Control";
        EmailList: List of [Text];
        BccEmail: List of [Text];
    begin

        Clear(LocalCurrency);
        RecGenLedSetup.GET;
        LocalCurrency := RecGenLedSetup."LCY Code";
        SMTPSetup.GET();
        Clear(RecUserSetup);
        Clear(EmailIDs);
        Clear(RecAccessControl);
        RecAccessControl.SetRange("Role ID", 'POBACKLOG');
        if RecAccessControl.FindSet() then begin
            repeat
                Clear(RecUserSetup);
                RecAccessControl.CalcFields("User Name");
                RecUserSetup.SetRange("User ID", RecAccessControl."User Name");
                RecUserSetup.SetFilter("E-Mail", '<>%1', '');
                if RecUserSetup.FindFirst() then begin
                    EmailList.Add(RecUserSetup."E-Mail");
                end;
            until RecAccessControl.Next() = 0;
        end;


        if EmailList.Count = 0 then
            exit;

        SMTPMail.CreateMessage('Dynamics Notification', SMTPSetup."User ID", EmailList, '[Purchase Order Today] [Open Orders till ' + FORMAT(CalcDate('-1D', WorkDate()), 0, '<day,2>/<month,2>/<year4>') + ']', '');
        BccEmail.Add('krishnakumar.r@levtechconsulting.com');
        SMTPMail.AddBCC(BccEmail);
        SMTPMail.AppendBody('<p>Report : Purchase Orders Today</p>');
        SMTPMail.AppendBody('<p>Date : ' + FORMAT(CURRENTDATETIME, 0, '<day,2>/<month,2>/<year4> <Hours12>:<Minutes,2> <AM/PM>') + '</p>');
        SMTPMail.AppendBody('<table Border="1" Style="border-style: none; width: 100%; border-collapse: collapse; transform: scale(1); transform-origin: left top 0px;">');
        SMTPMail.AppendBody('<tr>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c" > <font color="#ffffff"> Company </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"> <font color="#ffffff"> PO Reference </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"> <font color="#ffffff"> Order Date </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"><font color="#ffffff">  Project Name </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"><font color="#ffffff">  Vendor Name </font></th>');

        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"><font color="#ffffff">  Amount </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"> <font color="#ffffff">Currency </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"><font color="#ffffff"> Amount (' + LocalCurrency + ') </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"> <font color="#ffffff">Purchaser </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"> <font color="#ffffff">Status </font></th>');
        SMTPMail.AppendBody('</tr>');

        Clear(RecCompanies);
        Clear(ExchCurrency);
        Clear(GrandTotal1);
        Clear(GrandTotal2);
        RecCompanies.SetFilter(Name, '<>%1', '');
        if RecCompanies.FindSet() then begin
            repeat
                Clear(RecCompanyInfo);
                RecCompanyInfo.ChangeCompany(RecCompanies.Name);
                RecCompanyInfo.GET;
                if RecCompanyInfo."Enable Auto Report" then begin
                    Clear(Total1);
                    Clear(Total2);
                    Clear(Istotal);
                    Clear(RecPurchHeader);
                    RecPurchHeader.ChangeCompany(RecCompanies.Name);
                    RecPurchHeader.SetRange("Document Type", RecPurchHeader."Document Type"::Order);
                    RecPurchHeader.SetRange("Order Date", Workdate());//CalcDate('-1D', Workdate()));
                    if RecPurchHeader.FindSet() then begin
                        repeat
                            RecPurchHeader.CalcFields("Amount Including VAT");
                            if RecPurchHeader."Amount Including VAT" <> 0 then begin
                                Istotal += 1;
                                DocUrl := GETURL(CLIENTTYPE::Web, RecCompanies.Name, OBJECTTYPE::Page, 50, RecPurchHeader, FALSE);
                                SMTPMail.AppendBody('<tr>');
                                SMTPMail.AppendBody('<td align="left"   > ' + RecCompanies.Name + ' </td>');
                                SMTPMail.AppendBody('<td align="left"   > <a href="' + DocUrl + '">' + RecPurchHeader."No." + ' </a></td>');
                                SMTPMail.AppendBody('<td align="left"   > ' + FORMAT(RecPurchHeader."Order Date", 0, '<day,2>/<month,2>/<year4>') + ' </td>');
                                SMTPMail.AppendBody('<td align="left"   > ' + RecPurchHeader."Project Name" + '</td>');
                                SMTPMail.AppendBody('<td align="left"   > ' + RecPurchHeader."Buy-from Vendor Name" + ' </td>');


                                Clear(CurrencyFactor);//
                                if RecPurchHeader."Currency Factor" <> 0 then
                                    CurrencyFactor := RecPurchHeader."Currency Factor"
                                else
                                    CurrencyFactor := 1;

                                RecPurchHeader.CalcFields("Amount Including VAT");

                                SMTPMail.AppendBody('<td align="right"   >  ' + FORMAT(Round(RecPurchHeader."Amount Including VAT", 0.01, '='), 0, '<Precision,2:2><Standard Format,0>') + '</th>');
                                Total1 += Round(RecPurchHeader."Amount Including VAT", 0.01, '=');
                                GrandTotal1 += Round(RecPurchHeader."Amount Including VAT" / CurrencyFactor, 0.01, '=');

                                SMTPMail.AppendBody('<td align="left"   > ' + RecPurchHeader."Currency Code" + '</td>');
                                Clear(CurrencyExchangeRate);
                                CurrencyExchangeRate.ChangeCompany(RecCompanies.Name);
                                ExchangeRateAmt := CurrencyExchangeRate.GetCurrentCurrencyFactor(LocalCurrency);

                                SMTPMail.AppendBody('<td align="right"   > ' + FORMAT(ROUND((RecPurchHeader."Amount Including VAT" / CurrencyFactor) * ExchangeRateAmt, 0.01, '='), 0, '<Precision,2:2><Standard Format,0>') + ' </td>');
                                Total2 += Round((RecPurchHeader."Amount Including VAT" / CurrencyFactor) * ExchangeRateAmt, 0.01, '=');
                                GrandTotal2 += Round((RecPurchHeader."Amount Including VAT" / CurrencyFactor) * ExchangeRateAmt, 0.01, '=');

                                Clear(RecSalesPerson);
                                RecSalesPerson.ChangeCompany(RecCompanies.Name);
                                if RecSalesPerson.GET(RecPurchHeader."Purchaser Code") THEN
                                    SMTPMail.AppendBody('<td align="left"   >  ' + RecSalesPerson.Name + ' </td>')
                                else
                                    SMTPMail.AppendBody('<td align="left"   >  ' + '' + ' </td>');

                                SMTPMail.AppendBody('<td align="left"   > ' + FORMAT(RecPurchHeader.Status) + ' </td>');
                                SMTPMail.AppendBody('</tr>');
                            end;
                        until RecPurchHeader.Next() = 0;
                    end;

                    Clear(RecPheader);
                    Clear(RecPurchHeader);
                    if Istotal <> 0 then begin
                        SMTPMail.AppendBody('<tr>');
                        SMTPMail.AppendBody('<td align="left"   >  <b>Sub Total </b> </td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('<td align="right"   > <b>' + FORMAT(Round(Total2, 0.01, '>'), 0, '<Precision,2:2><Standard Format,0>') + '</b> </td>');
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
        SMTPMail.AppendBody('<td align="left"   ></td>');
        SMTPMail.AppendBody('<td align="right"   > <b>' + FORMAT(Round(GrandTotal2, 0.01, '>'), 0, '<Precision,2:2><Standard Format,0>') + '</b> </td>');
        SMTPMail.AppendBody('<td align="left"   ></td>');
        SMTPMail.AppendBody('<td align="left"   ></td>');
        SMTPMail.AppendBody('</tr>');
        SMTPMail.AppendBody('</table>');
        SMTPMail.AppendBody('</br></br>');

        SMTPMail.AppendBody('<p>Report : All Open Orders till ' + FORMAT(CalcDate('-1D', WorkDate()), 0, '<day,2>/<month,2>/<year4>') + '</p>');
        SMTPMail.AppendBody('<p>Date : ' + FORMAT(CURRENTDATETIME, 0, '<day,2>/<month,2>/<year4> <Hours12>:<Minutes,2> <AM/PM>') + '</p>');
        SMTPMail.AppendBody('<table Border="1" Style="border-style: none; width: 100%; border-collapse: collapse; transform: scale(1); transform-origin: left top 0px;">');
        SMTPMail.AppendBody('<tr>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c" > <font color="#ffffff"> Company </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"> <font color="#ffffff"> PO Reference </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"> <font color="#ffffff"> Order Date </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"><font color="#ffffff">  Project Name </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"><font color="#ffffff">  Vendor Name </font></th>');

        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"><font color="#ffffff">  Amount </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"> <font color="#ffffff">Currency </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"><font color="#ffffff"> Amount (' + LocalCurrency + ') </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"> <font color="#ffffff">Purchaser </font></th>');
        SMTPMail.AppendBody('<th align="left" bgcolor="#4b929c"> <font color="#ffffff">Status </font></th>');
        SMTPMail.AppendBody('</tr>');

        Clear(RecCompanies);
        Clear(GrandTotal2);
        RecCompanies.SetFilter(Name, '<>%1', '');
        if RecCompanies.FindSet() then begin
            repeat
                Clear(RecCompanyInfo);
                RecCompanyInfo.ChangeCompany(RecCompanies.Name);
                RecCompanyInfo.GET;
                if RecCompanyInfo."Enable Auto Report" then begin
                    Clear(Total1);
                    Clear(Total2);
                    Clear(Istotal);
                    Clear(RecPheader);
                    RecPheader.ChangeCompany(RecCompanies.Name);
                    RecPheader.SetRange("Document Type", RecPheader."Document Type"::Order);
                    RecPheader.SetFilter("Order Date", '<%1', Workdate());//CalcDate('-1D', Workdate()));
                    RecPheader.SetFilter(status, '=%1|%2', RecPheader.Status::Open, RecPheader.Status::"Pending Approval");
                    if RecPheader.FindSet() then begin
                        repeat
                            RecPheader.CalcFields("Amount Including VAT");
                            if RecPheader."Amount Including VAT" <> 0 then begin
                                Istotal += 1;
                                DocUrl := GETURL(CLIENTTYPE::Web, RecCompanies.Name, OBJECTTYPE::Page, 50, RecPheader, FALSE);
                                SMTPMail.AppendBody('<tr>');
                                SMTPMail.AppendBody('<td align="left"   > ' + RecCompanies.Name + ' </td>');
                                SMTPMail.AppendBody('<td align="left"   > <a href="' + DocUrl + '">' + RecPheader."No." + '</a> </td>');
                                SMTPMail.AppendBody('<td align="left"   > ' + FORMAT(RecPheader."Order Date", 0, '<day,2>/<month,2>/<year4>') + ' </td>');
                                SMTPMail.AppendBody('<td align="left"   > ' + RecPheader."Project Name" + '</td>');
                                SMTPMail.AppendBody('<td align="left"   > ' + RecPheader."Buy-from Vendor Name" + ' </td>');

                                Clear(CurrencyFactor);//
                                if RecPurchHeader."Currency Factor" <> 0 then
                                    CurrencyFactor := RecPurchHeader."Currency Factor"
                                else
                                    CurrencyFactor := 1;

                                CurrencyFactor := Round(CurrencyFactor, 0.01, '=');
                                SMTPMail.AppendBody('<td align="right"   >  ' + FORMAT(ROUND(RecPheader."Amount Including VAT", 0.01, '='), 0, '<Precision,2:2><Standard Format,0>') + '</th>');
                                Total1 += Round(RecPheader."Amount Including VAT", 0.01, '=');
                                GrandTotal1 += Round(RecPheader."Amount Including VAT" / CurrencyFactor, 0.01, '=');
                                SMTPMail.AppendBody('<td align="left"   > ' + RecPheader."Currency Code" + '</td>');

                                Clear(CurrencyExchangeRate);
                                CurrencyExchangeRate.ChangeCompany(RecCompanies.Name);
                                ExchangeRateAmt := CurrencyExchangeRate.GetCurrentCurrencyFactor(LocalCurrency);//ExchCurrency
                                //ExchangeRateAmt := Round(ExchangeRateAmt, 0.01, '=');

                                SMTPMail.AppendBody('<td align="right"   > ' + FORMAT(Round((RecPheader."Amount Including VAT" / CurrencyFactor) * ExchangeRateAmt, 0.01, '='), 0, '<Precision,2:2><Standard Format,0>') + ' </td>');
                                Total2 += Round((RecPheader."Amount Including VAT" / CurrencyFactor) * ExchangeRateAmt, 0.01, '=');
                                GrandTotal2 += Round((RecPheader."Amount Including VAT" / CurrencyFactor) * ExchangeRateAmt, 0.01, '=');

                                Clear(RecSalesPerson);
                                RecSalesPerson.ChangeCompany(RecCompanies.Name);
                                if RecSalesPerson.GET(RecPurchHeader."Purchaser Code") THEN
                                    SMTPMail.AppendBody('<td align="left"   >  ' + RecSalesPerson.Name + ' </td>')
                                else
                                    SMTPMail.AppendBody('<td align="left"   >  ' + '' + ' </td>');

                                SMTPMail.AppendBody('<td align="left"   > ' + FORMAT(RecPheader.Status) + ' </td>');
                                SMTPMail.AppendBody('</tr>');
                            end;
                        until RecPheader.Next() = 0;
                    end;
                    Clear(RecPheader);
                    Clear(RecPurchHeader);
                    if Istotal <> 0 then begin
                        SMTPMail.AppendBody('<tr>');
                        SMTPMail.AppendBody('<td align="left"   >  <b>Sub Total </b> </td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('<td align="left"   ></td>');
                        SMTPMail.AppendBody('<td align="right"   > <b>' + FORMAT(Round(Total2, 0.01, '>'), 0, '<Precision,2:2><Standard Format,0>') + '</b> </td>');
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
        SMTPMail.AppendBody('<td align="left"   ></td>');
        SMTPMail.AppendBody('<td align="right"  ><b> ' + FORMAT(Round(GrandTotal2, 0.01, '>'), 0, '<Precision,2:2><Standard Format,0>') + ' </b></td>');
        SMTPMail.AppendBody('<td align="left"   ></td>');
        SMTPMail.AppendBody('<td align="left"   ></td>');
        SMTPMail.AppendBody('</tr>');
        SMTPMail.AppendBody('</table>');
        SMTPMail.AppendBody('</br></br>');
        SMTPMail.AppendBody('<p>This email is sent by Huda Lighting Business Central</p>');
        SMTPMail.Send();
    end;
}