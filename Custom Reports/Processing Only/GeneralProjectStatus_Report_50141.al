report 50141 "General Project Status"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) where("Document Type" = CONST(Order));
            RequestFilterFields = "Sell-to Customer No.", "No.", "Project Name", "Salesperson Code", "Shortcut Dimension 1 Code";
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLinkReference = "Sales Header";
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") ORDER(Ascending);

                trigger OnAfterGetRecord()
                var
                    RecSP: Record "Salesperson/Purchaser";
                    RecPT: Record "Payment Terms";
                    RecBrand: Record "Item Brands";
                    CurrencyExchangeRate: Record "Currency Exchange Rate";
                    ExchangeRateAmt: Decimal;
                    RecGLSetup: Record "General Ledger Setup";
                    CurrencyFactor: Decimal;
                    RecPurchHeader: Record "Purchase Header";
                    RecSalesShipmentLine: Record "Sales Shipment Line";
                    RecSalesInvLine: Record "Sales Invoice Line";
                    RecSalesInvHeader: Record "Sales Invoice Header";
                    RecPurchLine: Record "Purchase Line";
                    RecItemLedgerEntry: Record "Item Ledger Entry";
                    RecCustLedEntry: Record "Cust. Ledger Entry";
                    LandedCost: Decimal;
                    TotalLandedCost: Decimal;
                    RecReservEntry: Record "Reservation Entry";
                    SourceFilter: Text;
                begin
                    RecGLSetup.GET;
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn(Format("Document No."), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(FORMAT("Sales Header"."Order Date", 0, '<day,2>/<month,2>/<year4>'), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    "Sales Header".CalcFields("Amount Including VAT");
                    //OATotal += "Sales Header"."Amount Including VAT";
                    ExcelBuf.AddColumn("Sales Header"."Amount Including VAT", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    Clear(RecSP);
                    if RecSP.GET("Sales Header"."Salesperson Code") then;
                    ExcelBuf.AddColumn(RecSP.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Sales Header"."PO Reference", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Sales Header"."Sell-to Customer No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Sales Header"."Sell-to Customer Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Sales Header"."Project Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    Clear(RecPT);
                    if RecPT.GET("Sales Header"."Payment Terms Code") then;
                    ExcelBuf.AddColumn(RecPT.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("HL Line Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    Clear(RecBrand);
                    if RecBrand.GET(Brand) then;
                    ExcelBuf.AddColumn(RecBrand.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Vendor Article No", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(Quantity, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

                    CalcFields("Reserved Quantity");
                    ExcelBuf.AddColumn("Reserved Quantity", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    Clear(SourceFilter);
                    Clear(RecReservEntry);
                    RecReservEntry.SetFilter("Source Type", '=%1', Database::"Sales Line");
                    RecReservEntry.SetFilter("Source ID", '=%1', "Document No.");
                    if RecReservEntry.FindSet() then begin
                        repeat
                            SourceFilter += FORMAT(RecReservEntry."Entry No.") + '|';
                        until RecReservEntry.Next() = 0;
                    end;
                    if SourceFilter <> '' then begin
                        SourceFilter := CopyStr(SourceFilter, 1, StrLen(SourceFilter) - 1);
                        Clear(RecReservEntry);
                        RecReservEntry.SetRange("Source Type", 32);
                        RecReservEntry.SetFilter("Entry No.", SourceFilter);
                        if RecReservEntry.FindSet() then begin
                            RecReservEntry.CalcSums(Quantity);
                            ExcelBuf.AddColumn(Round(RecReservEntry.Quantity, 0.01, '='), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                        end else
                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    end else
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                    Clear(CurrencyFactor);//
                    if "Sales Header"."Currency Factor" <> 0 then
                        CurrencyFactor := "Sales Header"."Currency Factor"
                    else
                        CurrencyFactor := 1;
                    Clear(CurrencyExchangeRate);
                    ExchangeRateAmt := CurrencyExchangeRate.GetCurrentCurrencyFactor(RecGLSetup."LCY Code");
                    ExcelBuf.AddColumn(ROUND(("Unit Price" / CurrencyFactor) * ExchangeRateAmt, 0.01, '='), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(("Line Amount" / CurrencyFactor) * ExchangeRateAmt, 0.01, '='), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    Clear(RecPurchLine);
                    RecPurchLine.SetRange("Document Type", "Document Type"::Order);
                    RecPurchLine.SetRange("Document No.", "HL_Purchase Order No.");
                    RecPurchLine.SetRange("HL Sales Line No.", "Line No.");
                    RecPurchLine.SetRange("HL Sales Order No.", "Document No.");
                    if RecPurchLine.FindFirst() then
                        ExcelBuf.AddColumn(RecPurchLine."Outstanding Quantity", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
                    else
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

                    ExcelBuf.AddColumn("Outstanding Quantity", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn("HL_Purchase Order No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    Clear(RecPurchHeader);
                    RecPurchHeader.SetRange("Document Type", "Document Type"::Order);
                    RecPurchHeader.SetRange("No.", "HL_Purchase Order No.");
                    if RecPurchHeader.FindFirst() then begin
                        RecPurchHeader.CalcFields("Amount Including VAT");
                        ExcelBuf.AddColumn(RecPurchHeader."Amount Including VAT", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    end else
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    Clear(LandedCost);
                    Clear(TotalLandedCost);
                    Clear(RecSalesShipmentLine);
                    RecSalesShipmentLine.SetRange("Order No.", "Document No.");
                    RecSalesShipmentLine.SetRange("Order Line No.", "Line No.");
                    if RecSalesShipmentLine.FindFirst() then begin
                        ExcelBuf.AddColumn(RecSalesShipmentLine."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(FORMAT(RecSalesShipmentLine."Shipment Date", 0, '<day,2>/<month,2>/<year4>'), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        Clear(RecItemLedgerEntry);
                        RecItemLedgerEntry.SetRange("Document No.", RecSalesShipmentLine."Document No.");//RecSalesInvHeader."Pre-Assigned No.");
                        RecItemLedgerEntry.SetRange("Document Type", RecItemLedgerEntry."Document Type"::"Sales Shipment");
                        RecItemLedgerEntry.SetRange("Entry Type", RecItemLedgerEntry."Entry Type"::Sale);
                        RecItemLedgerEntry.SetRange("Item No.", "Sales Line"."No.");
                        if RecItemLedgerEntry.FindFirst() then begin
                            RecItemLedgerEntry.CalcFields("Cost Amount (Actual)");
                            //LandedCost := RecItemLedgerEntry."Cost per Unit";
                            if RecItemLedgerEntry.Quantity <> 0 then
                                LandedCost := RecItemLedgerEntry."Cost Amount (Actual)" / RecItemLedgerEntry.Quantity;
                            if LandedCost < 0 then
                                LandedCost := LandedCost * -1;
                            TotalLandedCost := RecItemLedgerEntry."Cost Amount (Actual)";
                            if TotalLandedCost < 0 then
                                TotalLandedCost := TotalLandedCost * -1;
                        end;
                        ExcelBuf.AddColumn(LandedCost, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn(TotalLandedCost, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                        Clear(RecSalesInvLine);
                        RecSalesInvLine.SetRange("Shipment No.", RecSalesShipmentLine."Document No.");
                        if RecSalesInvLine.FindFirst() then begin
                            Clear(RecSalesInvHeader);
                            RecSalesInvHeader.SetRange("No.", RecSalesInvLine."Document No.");
                            if RecSalesInvHeader.FindFirst() then begin
                                RecSalesInvHeader.CalcFields("Amount Including VAT");
                                ExcelBuf.AddColumn(RecSalesInvHeader."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                ExcelBuf.AddColumn(FORMAT(RecSalesInvHeader."Document Date", 0, '<day,2>/<month,2>/<year4>'), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                ExcelBuf.AddColumn(RecSalesInvHeader."Amount Including VAT", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            end else begin
                                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            end;
                        end else begin
                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        end;
                    end else begin
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    end;
                    Clear(RecCustLedEntry);
                    RecCustLedEntry.SetRange("Global Dimension 1 Code", "Sales Line"."Shortcut Dimension 1 Code");
                    RecCustLedEntry.SetRange("Document Type", RecCustLedEntry."Document Type"::Payment);
                    if RecCustLedEntry.FindFirst() then begin
                        RecCustLedEntry.CalcFields(Amount);
                        ExcelBuf.AddColumn(Abs(RecCustLedEntry.Amount), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    end else begin
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    SetFilter(Type, '<>%1', Type::"G/L Account");
                    Clear(OATotal);
                end;
            }

        }
    }
    local procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text103), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(CompanyName, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text105), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text102), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text104), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Inventory Aging", FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text106), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text107), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddInfoColumn(TIME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Time);
        ExcelBuf.NewRow;
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;



    local procedure MakeExcelDataHeader()
    var
        RecGLSetup: Record "General Ledger Setup";

    begin
        RecGLSetup.GET;
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('OA Number', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('OA Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Amount Inc. VAT', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Sales Person', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('LPO No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Customer No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Customer Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Project Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Payment Terms', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Type', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Brand', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Vendor Article No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Quantity', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('PO Reservation', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Received Qty', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Unit Price (' + RecGLSetup."LCY Code" + ')', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Total Price (' + RecGLSetup."LCY Code" + ')', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Balance Not Received', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Balance Not Delivered', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Purchase Order No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Purchase Order Amount Inc. VAT', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Delivery Note', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Delivery Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Landed Cost', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Total Landed Cost', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Sales Invoice', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice Amount Inc. VAT', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Advance', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
    END;

    trigger OnPostReport()
    begin
        CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        MakeExcelInfo();
    end;

    local procedure CreateExcelbook()
    begin
        ExcelBuf.CreateNewBook(Text101);
        ExcelBuf.WriteSheet(Text102, COMPANYNAME, USERID);
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
    end;

    VAR
        ExcelBuf: Record 370 temporary;
        Text103: Label 'Company Name';
        Text102: Label 'General Project Status';
        Text104: Label 'Report No.';
        Text101: Label 'Data';
        Text105: Label 'Report Name';
        Text106: Label 'User ID';
        Text107: Label 'Date / Time';
        OATotal: Decimal;

}