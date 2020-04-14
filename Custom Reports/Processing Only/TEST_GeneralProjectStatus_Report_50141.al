report 50159 "General Project Status TEST"
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
                    ReceivedQty: Decimal;
                    DNNoFilterText: Text;
                    PSINo: Text;
                    PSDate: Text;
                    PSAmount: Decimal;
                    i: Integer;
                    fromIndex: Integer;
                    ToIndex: Integer;
                    RecItem: Record Item;
                    PSILine: Record "Sales Invoice Line";
                begin
                    RecGLSetup.GET;
                    Clear(ReceivedQty);
                    Clear(DNNoFilterText);
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn(Format("Document No."), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(FORMAT("Sales Header"."Order Date", 0, '<day,2>/<month,2>/<year4>'), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    "Sales Header".CalcFields("Amount Including VAT");

                    ExcelBuf.AddColumn("Sales Header"."Amount Including VAT", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    Clear(RecSP);
                    if RecSP.GET("Sales Header"."Salesperson Code") then;
                    ExcelBuf.AddColumn(RecSP.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Sales Header"."PO Reference", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Sales Header"."Sell-to Customer No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Sales Header"."Sell-to Customer Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Sales Header"."Project Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Sales Header"."Currency Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    Clear(RecPT);
                    if RecPT.GET("Sales Header"."Payment Terms Code") then;
                    ExcelBuf.AddColumn(RecPT.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Sales Line"."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("HL Line Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    Clear(RecBrand);
                    if RecBrand.GET(Brand) then;
                    ExcelBuf.AddColumn(RecBrand.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Vendor Article No", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(Quantity, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

                    //CalcFields("Reserved Quantity");
                    //ExcelBuf.AddColumn("Reserved Quantity", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

                    //Comment to received Qty- Now get from purch line.
                    Clear(SourceFilter);
                    Clear(RecReservEntry);
                    Clear(POReservationQty);
                    //RecReservEntry.SetFilter("Source Type", '=%1', Database::"Sales Line");
                    RecReservEntry.SetFilter("Source ID", '=%1', "Document No.");
                    RecReservEntry.SetRange("Source Ref. No.", "Line No.");
                    RecReservEntry.SetFilter("Expected Receipt Date", '<>%1', 0D);
                    if RecReservEntry.FindSet() then begin
                        repeat
                            POReservationQty += Abs(RecReservEntry.Quantity);
                        until RecReservEntry.Next() = 0;
                    end;
                    /*if SourceFilter <> '' then begin
                        SourceFilter := CopyStr(SourceFilter, 1, StrLen(SourceFilter) - 1);
                        Clear(RecReservEntry);
                        RecReservEntry.SetRange("Source Type", 32);
                        RecReservEntry.SetFilter("Entry No.", SourceFilter);
                        if RecReservEntry.FindSet() then begin
                            RecReservEntry.CalcSums(Quantity);
                            ReceivedQty := Round(RecReservEntry.Quantity, 0.01, '=');
                        end;
                    end;*/

                    ExcelBuf.AddColumn(POReservationQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

                    Clear(InventoryReservation);
                    Clear(RecReservEntry);
                    RecReservEntry.SetFilter("Source ID", '=%1', "Document No.");
                    RecReservEntry.SetRange("Source Ref. No.", "Line No.");
                    RecReservEntry.SetFilter("Expected Receipt Date", '=%1', 0D);
                    if RecReservEntry.FindSet() then begin
                        repeat
                            InventoryReservation += Abs(RecReservEntry.Quantity);
                        until RecReservEntry.Next() = 0;
                    end;
                    ExcelBuf.AddColumn(InventoryReservation, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    Clear(RecItem);
                    if (Type = Type::Item) AND (RecItem.GET("Sales Line"."No.")) then begin
                        if RecItem.Type = RecItem.Type::"Non-Inventory" then begin
                            Clear(PSILine);
                            PSILine.SetRange("Sales Order No.", "Document No.");
                            PSILine.SetRange(Type, Type::Item);
                            PSILine.SetRange("No.", "Sales Line"."No.");
                            PSILine.SetRange("HL Line Type", "Sales Line"."HL Line Type");
                            if PSILine.FindSet() then begin
                                PSILine.CalcSums(Quantity);
                                ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                ExcelBuf.AddColumn(PSILine.Quantity, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            end else begin
                                ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            end;
                        end else begin
                            ExcelBuf.AddColumn(InventoryReservation + "Quantity Shipped", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            ExcelBuf.AddColumn("Quantity Shipped", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                        end;
                    end else begin
                        ExcelBuf.AddColumn(InventoryReservation + "Quantity Shipped", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn("Quantity Shipped", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    end;
                    Clear(CurrencyFactor);//
                    if "Sales Header"."Currency Factor" <> 0 then
                        CurrencyFactor := "Sales Header"."Currency Factor"
                    else
                        CurrencyFactor := 1;
                    Clear(CurrencyExchangeRate);
                    ExchangeRateAmt := CurrencyExchangeRate.GetCurrentCurrencyFactor(RecGLSetup."LCY Code");
                    ExcelBuf.AddColumn(ROUND(("Unit Price" / CurrencyFactor) * ExchangeRateAmt, 0.01, '='), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND((("Line Amount" - "Inv. Discount Amount") / CurrencyFactor) * ExchangeRateAmt, 0.01, '='), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

                    /*Clear(RecPurchLine);
                    RecPurchLine.SetRange("Document Type", "Document Type"::Order);
                    RecPurchLine.SetRange("Document No.", "HL_Purchase Order No.");
                    RecPurchLine.SetRange("HL Sales Line No.", "Line No.");
                    RecPurchLine.SetRange("HL Sales Order No.", "Document No.");
                    if RecPurchLine.FindFirst() then
                        ExcelBuf.AddColumn(RecPurchLine."Outstanding Quantity", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
                    else
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);*/
                    Clear(RecItem);
                    if RecItem.GET("No.") then begin
                        if RecItem.Type = RecItem.Type::"Non-Inventory" then begin
                            ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            ExcelBuf.AddColumn(Quantity - PSILine.Quantity, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                        end else begin
                            ExcelBuf.AddColumn((Quantity - (InventoryReservation + "Quantity Shipped")), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            ExcelBuf.AddColumn(Quantity - "Quantity Shipped", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                        end;
                    end else begin
                        ExcelBuf.AddColumn((Quantity - (InventoryReservation + "Quantity Shipped")), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn(Quantity - "Quantity Shipped", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    end;
                    //Purchase Orderss
                    Clear(RecPurchLine);
                    RecPurchLine.SetRange("Document Type", "Document Type"::Order);
                    RecPurchLine.SetRange("HL Sales Line No.", "Line No.");
                    RecPurchLine.SetRange("HL Sales Order No.", "Document No.");
                    Clear(CheckList);
                    Clear(PoNo);
                    Clear(PoValue);
                    if RecPurchLine.FindSet() then begin
                        repeat
                            if not CheckList.Contains(RecPurchLine."Document No.") then begin
                                CheckList.Add(RecPurchLine."Document No.");
                                PoNo := PoNo + RecPurchLine."Document No." + ',';
                                PoValue += RecPurchLine."Line Amount" - RecPurchLine."Inv. Discount Amount";

                                /*Clear(RecPurchHeader);
                                RecPurchHeader.SetRange("Document Type", "Document Type"::Order);
                                RecPurchHeader.SetRange("No.", RecPurchLine."Document No.");
                                RecPurchHeader.CalcFields("Amount Including VAT");
                                PoValue += RecPurchHeader."Amount Including VAT";*/
                            end;
                        until RecPurchLine.Next() = 0;
                    end;
                    if PoNo <> '' then
                        PoNo := CopyStr(PoNo, 1, StrLen(PoNo) - 1);
                    //
                    Clear(fromIndex);
                    Clear(ToIndex);
                    Clear(i);
                    fromIndex := 1;
                    ToIndex := 238;
                    if StrLen(PoNo) > 238 then begin

                        for i := 1 to ROUND(StrLen(PoNo) / 238, 1, '>') do begin
                            if i = 1 then
                                ExcelBuf.AddColumn(CopyStr(PoNo, fromIndex, ToIndex), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                            else
                                AddExtendedText('', CopyStr(PoNo, fromIndex, ToIndex), '', '', '');
                            fromIndex += 238;
                            if StrLen(PoNo) - ToIndex > 238 then begin
                                ToIndex := 238 * i + 1;
                            end else
                                ToIndex := StrLen(PoNo);
                        end;
                    end else
                        ExcelBuf.AddColumn(PoNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//
                    ExcelBuf.AddColumn(PoValue, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

                    Clear(RecSalesShipmentLine);
                    RecSalesShipmentLine.SetRange("Order No.", "Document No.");
                    RecSalesShipmentLine.SetRange("Order Line No.", "Line No.");
                    RecSalesShipmentLine.SetFilter(Quantity, '<>%1', 0);
                    Clear(CheckList);
                    Clear(DNNo);
                    Clear(DeliveryDate);
                    if RecSalesShipmentLine.FindSet() then begin
                        repeat
                            if not CheckList.Contains(RecSalesShipmentLine."Document No.") then begin
                                CheckList.Add(RecSalesShipmentLine."Document No.");
                                DNNo := DNNo + RecSalesShipmentLine."Document No." + ',';
                                DNNoFilterText := DNNoFilterText + RecSalesShipmentLine."Document No." + '|';
                                DeliveryDate := DeliveryDate + FORMAT(RecSalesShipmentLine."Shipment Date", 0, '<day,2>/<month,2>/<year4>') + ',';
                            end;
                        until RecSalesShipmentLine.Next() = 0;
                    end;
                    if DNNo <> '' then begin
                        DNNo := CopyStr(DNNo, 1, StrLen(DNNo) - 1);
                        DNNoFilterText := CopyStr(DNNoFilterText, 1, StrLen(DNNoFilterText) - 1);
                    end;

                    if DeliveryDate <> '' then
                        DeliveryDate := CopyStr(DeliveryDate, 1, StrLen(DeliveryDate) - 1);
                    Clear(fromIndex);
                    Clear(ToIndex);
                    Clear(i);
                    fromIndex := 1;
                    ToIndex := 247;
                    if StrLen(DNNo) > 247 then begin

                        for i := 1 to ROUND(StrLen(DNNo) / 247, 1, '>') do begin
                            if i = 1 then
                                ExcelBuf.AddColumn(CopyStr(DNNo, fromIndex, ToIndex), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                            else
                                AddExtendedText(CopyStr(DNNo, fromIndex, ToIndex), '', '', '', '');
                            fromIndex += 247;
                            if StrLen(DNNo) - ToIndex > 247 then
                                ToIndex := 247 * i + 1
                            else
                                ToIndex := StrLen(DNNo);
                        end;
                    end else
                        ExcelBuf.AddColumn(DNNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);


                    Clear(fromIndex);
                    Clear(ToIndex);
                    Clear(i);
                    fromIndex := 1;
                    ToIndex := 242;
                    if StrLen(DeliveryDate) > 242 then begin
                        for i := 1 to ROUND(StrLen(DeliveryDate) / 242, 1, '>') do begin
                            if i = 1 then
                                ExcelBuf.AddColumn(CopyStr(DeliveryDate, fromIndex, ToIndex), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                            else
                                AddExtendedText('', '', '', CopyStr(DeliveryDate, fromIndex, ToIndex), '');
                            fromIndex += 242;
                            if StrLen(DeliveryDate) - ToIndex > 242 then begin
                                ToIndex := 242 * i + 1;
                            end else
                                ToIndex := StrLen(DeliveryDate);
                        end;
                    end else
                        ExcelBuf.AddColumn(DeliveryDate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                    Clear(LandedCost);
                    Clear(TotalLandedCost);
                    // Clear(RecSalesShipmentLine);
                    // RecSalesShipmentLine.SetFilter("Document No.", DNNoFilterText);
                    // if RecSalesShipmentLine.FindSet() then begin
                    // repeat
                    /*Clear(RecItemLedgerEntry);
                    RecItemLedgerEntry.SetFilter("Document No.", DNNoFilterText);//RecSalesInvHeader."Pre-Assigned No.");
                    RecItemLedgerEntry.SetRange("Document Type", RecItemLedgerEntry."Document Type"::"Sales Shipment");
                    RecItemLedgerEntry.SetRange("Entry Type", RecItemLedgerEntry."Entry Type"::Sale);
                    RecItemLedgerEntry.SetRange("Item No.", "Sales Line"."No.");
                    if RecItemLedgerEntry.FindSet() then begin
                        RecItemLedgerEntry.CalcFields("Cost Amount (Actual)");
                        if RecItemLedgerEntry.Quantity <> 0 then
                            LandedCost := RecItemLedgerEntry."Cost Amount (Actual)" / RecItemLedgerEntry.Quantity;
                        if LandedCost < 0 then
                            LandedCost := LandedCost * -1;
                        TotalLandedCost := RecItemLedgerEntry."Cost Amount (Actual)";
                        if TotalLandedCost < 0 then
                            TotalLandedCost := TotalLandedCost * -1;
                    end;*/
                    // until RecSalesShipmentLine.Next() = 0;

                    //
                    Clear(RecItem);
                    If (Type = Type::Item) AND (RecItem.GET("No.")) then begin
                        LandedCost := RecItem."Unit Cost";
                    end;
                    ExcelBuf.AddColumn(LandedCost, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(LandedCost * Quantity, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    Clear(RecSalesInvLine);
                    Clear(CheckList);
                    Clear(PSINo);
                    Clear(PSDate);
                    Clear(PSAmount);
                    RecSalesInvLine.SetFilter("Shipment No.", DNNoFilterText);// RecSalesShipmentLine."Document No.");
                    RecSalesInvLine.SetRange(Type, RecSalesInvLine.Type::Item);
                    RecSalesInvLine.SetRange("No.", "Sales Line"."No.");
                    RecSalesInvLine.SetRange("HL Line Type", "Sales Line"."HL Line Type");
                    if RecSalesInvLine.FindSet() then begin
                        repeat
                            if not CheckList.Contains(RecSalesInvLine."Document No.") then begin
                                CheckList.Add(RecSalesInvLine."Document No.");
                                PSINo := PSINo + RecSalesInvLine."Document No." + ',';
                                PSDate := PSDate + FORMAT(RecSalesInvLine."Posting Date", 0, '<day,2>/<month,2>/<year4>') + ',';
                                PSAmount := PSAmount + RecSalesInvLine."Line Amount" - RecSalesInvLine."Inv. Discount Amount";
                            end;
                        until RecSalesInvLine.Next() = 0;
                    end;
                    if PSINo <> '' then
                        PSINo := CopyStr(PSINo, 1, StrLen(PSINo) - 1);
                    if PSDate <> '' then
                        PSDate := CopyStr(PSDate, 1, StrLen(PSDate) - 1);

                    Clear(fromIndex);
                    Clear(ToIndex);
                    Clear(i);
                    fromIndex := 1;
                    ToIndex := 238;
                    if StrLen(PSINo) > 238 then begin
                        for i := 1 to ROUND(StrLen(PSINo) / 238, 1, '>') do begin
                            if i = 1 then
                                ExcelBuf.AddColumn(CopyStr(PSINo, fromIndex, ToIndex), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                            else
                                AddExtendedText('', '', CopyStr(PSINo, fromIndex, ToIndex), '', '');
                            fromIndex += 238;
                            if StrLen(PSINo) - ToIndex > 238 then
                                ToIndex := 238 * i + 1
                            else
                                ToIndex := StrLen(PSINo);
                        end;
                    end else
                        ExcelBuf.AddColumn(PSINo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                    Clear(fromIndex);
                    Clear(ToIndex);
                    Clear(i);
                    fromIndex := 1;
                    ToIndex := 242;
                    if StrLen(PSDate) > 242 then begin
                        for i := 1 to ROUND(StrLen(PSDate) / 242, 1, '>') do begin
                            if i = 1 then
                                ExcelBuf.AddColumn(CopyStr(PSDate, fromIndex, ToIndex), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                            else
                                AddExtendedText('', '', '', '', CopyStr(PSDate, fromIndex, ToIndex));
                            fromIndex += 242;
                            if StrLen(PSDate) - ToIndex > 242 then
                                ToIndex := 242 * i + 1
                            else
                                ToIndex := StrLen(PSDate);
                        end;
                    end else
                        ExcelBuf.AddColumn(PSDate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(PSAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
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
        ExcelBuf.AddColumn('Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Sales Person', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('LPO No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Customer No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Customer Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Project Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Currency Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Payment Terms', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Type', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Brand', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Vendor Article No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quantity', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('PO Reservation', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Inventory Reservation', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Received Qty', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Qty Shipped', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Unit Price (' + RecGLSetup."LCY Code" + ')', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Total Price (' + RecGLSetup."LCY Code" + ')', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Balance Not Received', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Balance Not Delivered', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Purchase Order No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Purchase Order Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Delivery Note', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Delivery Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Landed Cost', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Total Landed Cost', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Sales Invoice', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
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



    local procedure AddExtendedText(DeliveryNoteNo: Text; PurchaseOrderNo: Text; SalesInvoiceNo: Text; DeliverDateL: Text; PSIDate: Text)
    begin
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//OA Number
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//OA Date
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Amount Inc. VAT
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Sales Person
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//LPO No.
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Customer No.
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Customer Name
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Project Name
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Currency Code
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Payment Terms
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);//Item No.
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Type
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Brand
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Vendor Article No.
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Quantity
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//PO Reservation
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);//Inv Reservation
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Received Qty
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Qty Shipped
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Unit Price
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Total Price
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Balance Not Received
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Balance Not Delivered
        ExcelBuf.AddColumn(PurchaseOrderNo, FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Purchase Order No.
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Purchase Order Amount Inc. VAT
        ExcelBuf.AddColumn(DeliveryNoteNo, FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Delivery Note
        ExcelBuf.AddColumn(DeliverDateL, FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Delivery Date
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Landed Cost
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Total Landed Cost
        ExcelBuf.AddColumn(SalesInvoiceNo, FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Sales Invoice
        ExcelBuf.AddColumn(PSIDate, FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Invoice Date
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Invoice Amount Inc. VAT
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);//Advance
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
        PoNo: Text;
        PoValue: Decimal;
        DNNo: Text;
        DeliveryDate: Text;
        SalesInvoiceNo: Text;
        InvoiceValue: Decimal;
        Advance: Decimal;
        CheckList: List of [Text];
        POReservationQty: Decimal;
        InventoryReservation: Decimal;
        RecItem: Record Item;
        QtyShipped: Decimal;
}