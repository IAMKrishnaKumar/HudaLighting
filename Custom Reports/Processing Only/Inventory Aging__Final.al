report 50128 "Inventory Aging Report"
{
    DefaultLayout = RDLC;
    //RDLCLayout = './Item Age Composition - Value.rdlc';
    //ApplicationArea = All;
    Caption = 'Inventory Aging';//Final One 
    //UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.")
                                WHERE(Type = CONST(Inventory));
            RequestFilterFields = "No.", "Inventory Posting Group", "Statistics Group", "Location Filter";

            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            trigger OnAfterGetRecord()
            var
                ValueEntry: Record "Value Entry";
                RecCust: Record Customer;
                RecReservEntry: Record "Reservation Entry";
                RecReservEntry2: Record "Reservation Entry";
                RecSalesHeader: Record "Sales Header";
                CliencheckList: List of [Text];
                OpportunityNoCheckList: List of [Text];
                salesOrderNochecklist: List of [Text];
            //RecItem: Record Item;
            begin
                FOR i := 1 TO 5 DO begin
                    InvtQtyForQ[i] := 0;
                    InvtValue[i] := 0;
                end;
                Clear(TotalInvtValue_Item);
                Clear(TotalInvtQty_Item);
                Clear(ValueEntry);
                ClientName.Clear();
                OpportunityNo.Clear();
                SalesOrderNo.Clear();
                Clear(CliencheckList);
                Clear(salesOrderNochecklist);
                Clear(OpportunityNoCheckList);
                ValueEntry.SetCurrentKey("Item No.");
                ValueEntry.SETRANGE("Item No.", "No.");
                ValueEntry.SETFILTER("Variant Code", GETFILTER("Variant Filter"));
                ValueEntry.SETFILTER("Location Code", GETFILTER("Location Filter"));
                ValueEntry.SETFILTER("Global Dimension 1 Code", GETFILTER("Global Dimension 1 Filter"));
                ValueEntry.SETFILTER("Global Dimension 2 Code", GETFILTER("Global Dimension 2 Filter"));
                ValueEntry.SetFilter("Posting Date", '..%1', PeriodStartDate[5]);
                if ValueEntry.FindSet() then begin
                    repeat
                        FOR i := 1 TO 5 DO begin
                            IF (ValueEntry."Posting Date" > PeriodStartDate[i]) AND (ValueEntry."Posting Date" <= PeriodStartDate[i + 1]) THEN begin
                                InvtQtyForQ[i] += ValueEntry."Item Ledger Entry Quantity";
                                TotalInvtQtyForQ[i] += ValueEntry."Item Ledger Entry Quantity";//To calculate Total Qty
                                InvtValue[i] += ValueEntry."Cost Posted to G/L" + ValueEntry."Cost Amount (Expected)";
                                InvtValueRTC[i] += ValueEntry."Cost Posted to G/L" + ValueEntry."Cost Amount (Expected)";
                            end;
                        end;
                        TotalInvtValue_Item += ValueEntry."Cost Posted to G/L" + ValueEntry."Cost Amount (Expected)";
                        GrandTotalInvtValue_Item += ValueEntry."Cost Posted to G/L" + ValueEntry."Cost Amount (Expected)";
                        TotalInvtQty_Item += ValueEntry."Item Ledger Entry Quantity";
                        GrandTotalInvtQty_Item += ValueEntry."Item Ledger Entry Quantity";
                    until ValueEntry.Next() = 0;

                    Item.CalcFields("Reserved Qty. on Inventory");
                    if Item."Reserved Qty. on Inventory" > 0 then begin
                        Clear(RecReservEntry);
                        RecReservEntry.SetRange("Item No.", Item."No.");
                        RecReservEntry.SetRange("Source Type", Database::"Item Ledger Entry");
                        RecReservEntry.SetRange("Source Subtype", 0);
                        RecReservEntry.SetRange("Reservation Status", RecReservEntry."Reservation Status"::Reservation);
                        RecReservEntry.SetFilter("Serial No.", GetFilter("Serial No. Filter"));
                        RecReservEntry.SetFilter("Lot No.", GetFilter("Lot No. Filter"));
                        RecReservEntry.SetFilter("Variant Code", GetFilter("Variant Filter"));
                        RecReservEntry.SetFilter("Location Code", GetFilter("Location Filter"));
                        if RecReservEntry.FindSet() then begin
                            repeat
                                Clear(RecReservEntry2);
                                if RecReservEntry2.GET(RecReservEntry."Entry No.", false) then begin
                                    if RecReservEntry2."Source Type" = Database::"Sales Line" then begin
                                        if not salesOrderNochecklist.Contains(RecReservEntry2."Source ID") then begin
                                            SalesOrderNo.Append(RecReservEntry2."Source ID" + '  ');
                                            salesOrderNochecklist.Add(RecReservEntry2."Source ID");
                                        end;
                                        Clear(RecSalesHeader);
                                        if RecSalesHeader.GET(RecSalesHeader."Document Type"::Order, RecReservEntry2."Source ID") then begin
                                            if not CliencheckList.Contains(RecSalesHeader."Sell-to Customer Name") then begin
                                                ClientName.Append(RecSalesHeader."Sell-to Customer Name" + '  ');
                                                CliencheckList.Add(RecSalesHeader."Sell-to Customer Name");
                                            end;
                                            if not OpportunityNoCheckList.Contains(RecSalesHeader."Shortcut Dimension 1 Code") then begin
                                                OpportunityNo.Append(RecSalesHeader."Shortcut Dimension 1 Code" + '  ');
                                                OpportunityNoCheckList.Add(RecSalesHeader."Shortcut Dimension 1 Code");
                                            end;
                                        end;
                                    end;
                                end;
                            until RecReservEntry.Next() = 0;
                        end;
                    end;
                end else
                    CurrReport.Skip();
                MakeExcelDataBody();
            end;

            trigger OnPreDataItem()
            begin
                CLEAR(InvtValue);
                CLEAR(TotalInvtValue_Item);
                Clear(GrandTotalInvtQty_Item);
                Clear(GrandTotalInvtValue_Item);
                Clear(TotalInvtQtyForQ);
                Clear(GrandTotlInventory);
                Clear(GrandTotalReserveQtyOnInventory);
                Clear(GrandTotalAvailableQty);
                Clear(ClientName);
                Clear(SalesOrderNo);
                Clear(OpportunityNo);
                FOR i := 1 TO 5 DO begin
                    TotalInvtQtyForQ[i] := 0;
                    InvtValueRTC[i] := 0;
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(EndingDate; PeriodStartDate[5])
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Ending Date';
                        ToolTip = 'Specifies the end date of the report. The report calculates backwards from this date and sets up three periods of the length specified in the Period Length field.';

                        trigger OnValidate()
                        begin
                            IF PeriodStartDate[5] = 0D THEN
                                ERROR(Text002);
                        end;
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period Length';
                        ToolTip = 'Specifies the length of the three periods in the report.';

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength) = '' THEN
                                EVALUATE(PeriodLength, '<0D>');
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF PeriodStartDate[5] = 0D THEN
                PeriodStartDate[5] := CALCDATE('<CM>', WORKDATE);
            IF FORMAT(PeriodLength) = '' THEN
                EVALUATE(PeriodLength, '<1M>');
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        NegPeriodLength: DateFormula;
    begin
        ItemFilter := Item.GETFILTERS;

        PeriodStartDate[6] := DMY2DATE(31, 12, 9999);
        EVALUATE(NegPeriodLength, STRSUBSTNO('-%1', FORMAT(PeriodLength)));
        FOR i := 1 TO 3 DO
            PeriodStartDate[5 - i] := CALCDATE(NegPeriodLength, PeriodStartDate[6 - i]);

        MakeExcelInfo;
    end;

    trigger OnInitReport()
    var
        myInt: Integer;
    begin

    end;

    var
        Text002: Label 'Enter the ending date';
        ItemFilter: Text;
        InvtValue: array[6] of Decimal;

        InvtValueRTC: array[6] of Decimal;

        TotalInvtQtyForQ: array[6] of Decimal;
        InvtQtyForQ: array[6] of Decimal;

        ExcelBuf: Record "Excel Buffer" Temporary;
        PeriodStartDate: array[6] of Date;
        PeriodLength: DateFormula;
        i: Integer;
        TotalInvtValue_Item: Decimal;
        TotalInvtQty_Item: Decimal;
        GrandTotalInvtValue_Item: Decimal;
        GrandTotalInvtQty_Item: Decimal;
        TotalInvtValueRTC: Decimal;
        ItemAgeCompositionValueCaptionLbl: Label 'Item Age Composition - Value';
        CurrReportPageNoCaptionLbl: Label 'Page';
        AfterCaptionLbl: Label 'After...';
        Text101: Label 'Data';
        BeforeCaptionLbl: Label '...Before';
        InventoryValueCaptionLbl: Label 'Inventory Value';
        ItemDescriptionCaptionLbl: Label 'Description';
        ItemNoCaptionLbl: Label 'Item No.';
        TotalCaptionLbl: Label 'Total';


        //Excel Data - Variables
        TenantMedia: Record "Tenant Media";
        OutStr: OutStream;
        Text103: Label 'Company Name';
        Text102: Label 'Inventory Aging';
        Text104: Label 'Report No.';
        Text105: Label 'Report Name';
        Text106: Label 'User ID';
        Text107: Label 'Date / Time';
        Itemcat: Record "Item Category";
        DescText: Text;
        GrandTotal: Array[11] of Decimal;
        GrandTotlInventory: Decimal;
        GrandTotalReserveQtyOnInventory: Decimal;
        GrandTotalAvailableQty: Decimal;
        ClientName: TextBuilder;
        SalesOrderNo: TextBuilder;
        OpportunityNo: TextBuilder;



    procedure InitializeRequest(NewEndingDate: Date; NewPeriodLength: DateFormula)
    begin
        PeriodStartDate[5] := NewEndingDate;
        PeriodLength := NewPeriodLength;
    end;

    trigger OnPostReport()
    begin
        AddTotalRow();
        CreateExcelbook;
    end;

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
        ExcelBuf.AddInfoColumn(REPORT::"Inventory Aging Report", FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
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


    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Item No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Vendor Article No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Brand', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item Category Level 1', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item Category Level 2', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item Description', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quantity', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Reserve Qty on Inventory', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Available Inventory', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Unit Cost', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Total Cost (Reserve)', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Client Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Sales Order No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Opportunity No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Total Cost', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);


        //for picture
        //  ExcelBuf.AddColumn('Item Picture', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('   Before ..', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('...', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[2] + 1) + ' To ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[3]), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[3] + 1) + ' To ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[4]), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[4] + 1) + ' To ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(PeriodStartDate[5]), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(' ' + AfterCaptionLbl, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('...', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);


        ExcelBuf.AddColumn('Qty', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Qty', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Qty', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Qty', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Qty', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
    END;

    procedure MakeExcelDataBody()
    var
        CurrencyCodeToPrint: Code[20];
        RecItem: Record Item;
    begin
        Clear(RecItem);
        RecItem.SetRange("No.", Item."No.");
        RecItem.SetFilter("Date Filter", '..%1', PeriodStartDate[5]);
        if RecItem.FindFirst() then;
        RecItem.CalcFields(Inventory);
        Item.CalcFields(Inventory);
        //if Item.Inventory <> 0 then begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Item."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item."Vendor Article No", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item.Brand, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        Clear(Itemcat);
        Itemcat.SetRange(Code, Item."Item Category Code");
        if Itemcat.FindFirst() then begin
            if Itemcat."Parent Category" = '' then begin
                ExcelBuf.AddColumn(Itemcat.Code, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            end else begin
                ExcelBuf.AddColumn(Itemcat."Parent Category", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Itemcat.Code, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            end;
        end else begin
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        end;
        Clear(DescText);
        DescText := Item.Description + Item."Description 2" + Item."Description 3";
        ExcelBuf.AddColumn(CopyStr(DescText, 1, 249), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        Item.CalcFields(Inventory, "Reserved Qty. on Inventory");
        RecItem.CalcFields(Inventory, "Reserved Qty. on Inventory");
        GrandTotlInventory += RecItem.Inventory;
        GrandTotalReserveQtyOnInventory += RecItem."Reserved Qty. on Inventory";
        GrandTotalAvailableQty += RecItem.Inventory - RecItem."Reserved Qty. on Inventory";
        ExcelBuf.AddColumn(RecItem.Inventory, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(RecItem."Reserved Qty. on Inventory", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(RecItem.Inventory - RecItem."Reserved Qty. on Inventory", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        if TotalInvtQty_Item <> 0 then begin
            ExcelBuf.AddColumn(Round((TotalInvtValue_Item / TotalInvtQty_Item), 0.01, '='), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(Round(RecItem."Reserved Qty. on Inventory" * (TotalInvtValue_Item / TotalInvtQty_Item), 0.01, '='), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        end else begin
            ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        end;
        AddExtendedTextInExcel(ClientName.ToText(), SalesOrderNo.ToText(), OpportunityNo.ToText(), 11);

        //ExcelBuf.AddColumn(Copystr(, 1, 249), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//cliemt name
        //ExcelBuf.AddColumn(copystr(SalesOrderNo.ToText(), 1, 249), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//sales order no
        //ExcelBuf.AddColumn(copystr(OpportunityNo.ToText(), 1, 249), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//opportunity no



        //AddExtendedDesc();
    END;

    local procedure AddRowsAfterExtendedText()
    begin
        ExcelBuf.AddColumn(Round((TotalInvtValue_Item), 0.01, '='), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(InvtQtyForQ[1], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Round(InvtValue[1], 0.01, '='), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(InvtQtyForQ[2], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Round(InvtValue[2], 0.01, '='), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(InvtQtyForQ[3], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Round(InvtValue[3], 0.01, '='), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(InvtQtyForQ[4], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Round(InvtValue[4], 0.01, '='), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(InvtQtyForQ[5], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Round(InvtValue[5], 0.01, '='), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
    end;

    local procedure CreateExcelbook()
    begin
        ExcelBuf.CreateNewBook(Text101);
        ExcelBuf.WriteSheet(Text102, COMPANYNAME, USERID);
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
        // ExcelBuf.CreateBookAndOpenExcel('', Text101, Text102, COMPANYNAME, USERID);
    end;


    local procedure AddTotalRow()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('TOTAL', FALSE, '', true, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(GrandTotlInventory, FALSE, '', true, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(GrandTotalReserveQtyOnInventory, FALSE, '', true, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(GrandTotalAvailableQty, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(Round(GrandTotalInvtValue_Item, 0.01, '='), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

        ExcelBuf.AddColumn(TotalInvtQtyForQ[1], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Round(InvtValueRTC[1], 0.01, '='), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(TotalInvtQtyForQ[2], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Round(InvtValueRTC[2], 0.01, '='), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(TotalInvtQtyForQ[3], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Round(InvtValueRTC[3], 0.01, '='), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(TotalInvtQtyForQ[4], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Round(InvtValueRTC[4], 0.01, '='), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(TotalInvtQtyForQ[5], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Round(InvtValueRTC[5], 0.01, '='), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

    end;

    local procedure AddExtendedTextInExcel(ExtendedText: Text; ExtendedText2: Text; ExtendedText3: Text; RowCountBefore: Integer)
    Var
        fromIndex, ToIndex, i : Integer;
    begin
        if ExtendedText = '' then begin
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            AddRowsAfterExtendedText;
            exit;
        end;
        //
        Clear(fromIndex);
        Clear(ToIndex);
        Clear(i);
        fromIndex := 1;
        ToIndex := 250;
        if StrLen(ExtendedText) > 250 then begin

            for i := 1 to ROUND(StrLen(ExtendedText) / 250, 1, '>') do begin
                if i = 1 then begin
                    ExcelBuf.AddColumn(CopyStr(ExtendedText, fromIndex, ToIndex), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    if Strlen(ExtendedText2) > 250 then
                        ExcelBuf.AddColumn(CopyStr(ExtendedText2, fromIndex, ToIndex), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                    else
                        ExcelBuf.AddColumn(ExtendedText2, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    if StrLen(ExtendedText3) > 250 then
                        ExcelBuf.AddColumn(CopyStr(ExtendedText3, fromIndex, ToIndex), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                    else
                        ExcelBuf.AddColumn(ExtendedText3, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    AddRowsAfterExtendedText();
                end else begin
                    AddEmptyRowBefore(RowCountBefore);
                    ExcelBuf.AddColumn(CopyStr(ExtendedText, fromIndex, ToIndex), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    if strlen(ExtendedText2) > ToIndex then
                        ExcelBuf.AddColumn(CopyStr(ExtendedText2, fromIndex, ToIndex), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                    else
                        ExcelBuf.AddColumn(CopyStr(ExtendedText2, fromIndex, StrLen(ExtendedText2)), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    if Strlen(ExtendedText3) > ToIndex then
                        ExcelBuf.AddColumn(CopyStr(ExtendedText3, fromIndex, ToIndex), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                    else
                        ExcelBuf.AddColumn(CopyStr(ExtendedText3, fromIndex, StrLen(ExtendedText3)), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                end;
                fromIndex += 250;
                if StrLen(ExtendedText) - ToIndex > 238 then begin
                    ToIndex := 250 * i + 1;
                end else
                    ToIndex := StrLen(ExtendedText);
            end;
        end else begin
            ExcelBuf.AddColumn(ExtendedText, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(ExtendedText2, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(ExtendedText3, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            AddRowsAfterExtendedText;
        end;
        //

    end;

    local procedure AddEmptyRowBefore(RowCount: Integer)
    var
        i: Integer;
    begin
        ExcelBuf.NewRow();
        for i := 1 to RowCount do begin
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        end;
    end;
}

