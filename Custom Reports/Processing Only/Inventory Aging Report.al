report 50137 "Inventory Aging"
{
    DefaultLayout = RDLC;
    //RDLCLayout = './Item Age Composition - Value.rdlc';
    ApplicationArea = All;
    Caption = 'Inventory Aging';
    UsageCategory = ReportsAndAnalysis;
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
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(ItemTableCaptItemFilter; TABLECAPTION + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(PeriodStartDate21; FORMAT(PeriodStartDate[2] + 1))
            {
            }
            column(PeriodStartDate3; FORMAT(PeriodStartDate[3]))
            {
            }
            column(PeriodStartDate31; FORMAT(PeriodStartDate[3] + 1))
            {
            }
            column(PeriodStartDate4; FORMAT(PeriodStartDate[4]))
            {
            }
            column(PeriodStartDate41; FORMAT(PeriodStartDate[4] + 1))
            {
            }
            column(PeriodStartDate5; FORMAT(PeriodStartDate[5]))
            {
            }
            //QTY - fields 
            column(InvtQty1_ItemLedgEntry; InvtQty[1])
            {
                DecimalPlaces = 0 : 2;
            }
            column(InvtQty2_ItemLedgEntry; InvtQty[2])
            {
                DecimalPlaces = 0 : 2;
            }
            column(InvtQty3_ItemLedgEntry; InvtQty[3])
            {
                DecimalPlaces = 0 : 2;
            }
            column(InvtQty4_ItemLedgEntry; InvtQty[4])
            {
                DecimalPlaces = 0 : 2;
            }
            column(InvtQty5_ItemLedgEntry; InvtQty[5])
            {
                DecimalPlaces = 0 : 2;
            }
            column(TotalInTotalInvtQty; TotalInvtQty)
            {
                DecimalPlaces = 0 : 2;
            }

            //QTY-fields - END
            column(PrintLine; PrintLine)
            {
            }
            column(InvtValueRTC1; InvtValueRTC[1])
            {
            }
            column(InvtValueRTC2; InvtValueRTC[2])
            {
            }
            column(InvtValueRTC5; InvtValueRTC[5])
            {
            }
            column(InvtValueRTC4; InvtValueRTC[4])
            {
            }
            column(InvtValueRTC3; InvtValueRTC[3])
            {
            }
            column(TotalInvtValueRTC; TotalInvtValueRTC)
            {
            }
            column(InvtValue1_Item; InvtValue[1])
            {
                AutoFormatType = 1;
            }
            column(InvtValue2_Item; InvtValue[2])
            {
                AutoFormatType = 1;
            }
            column(InvtValue3_Item; InvtValue[3])
            {
                AutoFormatType = 1;
            }
            column(InvtValue4_Item; InvtValue[4])
            {
                AutoFormatType = 1;
            }
            column(InvtValue5_Item; InvtValue[5])
            {
                AutoFormatType = 1;
            }
            column(TotalInvtValue_Item; TotalInvtValue_Item)
            {
                AutoFormatType = 1;
            }
            column(ItemAgeCompositionValueCaption; ItemAgeCompositionValueCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(AfterCaption; AfterCaptionLbl)
            {
            }
            column(BeforeCaption; BeforeCaptionLbl)
            {
            }
            column(InventoryValueCaption; InventoryValueCaptionLbl)
            {
            }
            column(ItemDescriptionCaption; ItemDescriptionCaptionLbl)
            {
            }
            column(ItemNoCaption; ItemNoCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No."),
                               "Location Code" = FIELD("Location Filter"),
                               "Variant Code" = FIELD("Variant Filter"),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Item No.", Open) where(Open = const(true));

                trigger OnAfterGetRecord()
                begin
                    IF "Remaining Quantity" = 0 THEN
                        CurrReport.SKIP;
                    PrintLine := TRUE;
                    CalcRemainingQty;
                    RemainingQty += TotalInvtQty;

                    IF Item."Costing Method" = Item."Costing Method"::Average THEN BEGIN
                        InvtValue[i] += AverageCost[i] * InvtQty[i];
                        InvtValueRTC[i] += AverageCost[i] * InvtQty[i];
                    END ELSE BEGIN
                        CalcUnitCost;
                        TotalInvtValue_Item += UnitCost * ABS(TotalInvtQty);
                        InvtValue[i] += UnitCost * ABS(InvtQty[i]);

                        TotalInvtValueRTC += UnitCost * ABS(TotalInvtQty);
                        InvtValueRTC[i] += UnitCost * ABS(InvtQty[i]);
                    END;

                    // MakeExcelDataBody;//------------------------
                end;

                trigger OnPostDataItem()
                var
                    AvgCostCurr: Decimal;
                    AvgCostCurrLCY: Decimal;
                begin
                    IF Item."Costing Method" = Item."Costing Method"::Average THEN BEGIN
                        Item.SETRANGE("Date Filter");
                        ItemCostMgt.CalculateAverageCost(Item, AvgCostCurr, AvgCostCurrLCY);
                        TotalInvtValue_Item := AvgCostCurr * RemainingQty;
                        TotalInvtValueRTC += TotalInvtValue_Item;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    TotalInvtValue_Item := 0;
                    FOR i := 1 TO 5 DO
                        InvtValue[i] := 0;
                    RemainingQty := 0;
                end;
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(TotalInvtValue_ItemLedgEntry; TotalInvtValue_Item)
                {
                    AutoFormatType = 1;
                }
                column(InvtValue5_ItemLedgEntry; InvtValue[5])
                {
                    AutoFormatType = 1;
                }
                column(InvtValue4_ItemLedgEntry; InvtValue[4])
                {
                    AutoFormatType = 1;
                }
                column(InvtValue3_ItemLedgEntry; InvtValue[3])
                {
                    AutoFormatType = 1;
                }
                column(InvtValue2_ItemLedgEntry; InvtValue[2])
                {
                    AutoFormatType = 1;
                }
                column(InvtValue1_ItemLedgEntry; InvtValue[1])
                {
                    AutoFormatType = 1;
                }
                column(Description_Item; Item.Description + Item."Description 2" + Item."Description 3")
                {
                }
                column(No_Item; Item."No.")
                {
                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    MakeExcelDataBody();
                end;
            }

            trigger OnAfterGetRecord()
            var
                ItemLedgEntry: Record 32;
                RecILE: Record 32;
            begin
                IF "Costing Method" = "Costing Method"::Average THEN BEGIN
                    FOR i := 2 TO 5 DO BEGIN
                        SETRANGE("Date Filter", PeriodStartDate[i] + 1, PeriodStartDate[i + 1]);
                        ItemCostMgt.CalculateAverageCost(Item, AverageCost[i], AverageCostACY[i]);
                    END;

                    SETRANGE("Date Filter", 0D, PeriodStartDate[2]);
                    ItemCostMgt.CalculateAverageCost(Item, AverageCost[1], AverageCostACY[1]);
                END;

                PrintLine := FALSE;
                TotalInvtQty := 0;
                FOR i := 1 TO 5 DO
                    InvtQtyForQ[i] := 0;

                ItemLedgEntry.FilterLinesWithItemToPlan(Item, FALSE);
                IF ItemLedgEntry.FINDSET THEN
                    REPEAT
                        PrintLine := TRUE;
                        TotalInvtQty := TotalInvtQty + ItemLedgEntry."Remaining Quantity";
                        FOR i := 1 TO 5 DO
                            IF (ItemLedgEntry."Posting Date" > PeriodStartDate[i]) AND (ItemLedgEntry."Posting Date" <= PeriodStartDate[i + 1]) THEN
                                InvtQtyForQ[i] := InvtQtyForQ[i] + ItemLedgEntry."Remaining Quantity";
                    UNTIL ItemLedgEntry.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                CLEAR(InvtValue);
                CLEAR(TotalInvtValue_Item);
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


        //Creating Excel
        MakeExcelInfo;
    end;

    var
        Text002: Label 'Enter the ending date';
        ItemCostMgt: Codeunit 5804;
        ItemFilter: Text;
        InvtValue: array[6] of Decimal;

        InvtValueRTC: array[6] of Decimal;

        InvtQty: array[6] of Decimal;

        InvtQtyForQ: array[6] of Decimal;
        UnitCost: Decimal;
        ExcelBuf: Record 370 temporary;
        PeriodStartDate: array[6] of Date;
        PeriodLength: DateFormula;
        i: Integer;
        TotalInvtValue_Item: Decimal;
        TotalInvtValueRTC: Decimal;
        TotalInvtQty: Decimal;

        PrintLine: Boolean;
        AverageCost: array[5] of Decimal;
        AverageCostACY: array[5] of Decimal;
        ItemAgeCompositionValueCaptionLbl: Label 'Item Age Composition - Value';
        CurrReportPageNoCaptionLbl: Label 'Page';
        AfterCaptionLbl: Label 'After...';
        Text101: Label 'Data';
        BeforeCaptionLbl: Label '...Before';
        InventoryValueCaptionLbl: Label 'Inventory Value';
        ItemDescriptionCaptionLbl: Label 'Description';
        ItemNoCaptionLbl: Label 'Item No.';
        TotalCaptionLbl: Label 'Total';
        RemainingQty: Decimal;

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
        BStr: Text;

    local procedure CalcRemainingQty()
    begin
        WITH "Item Ledger Entry" DO BEGIN
            FOR i := 1 TO 5 DO
                InvtQty[i] := 0;

            TotalInvtQty := "Remaining Quantity";
            FOR i := 1 TO 5 DO
                IF ("Posting Date" > PeriodStartDate[i]) AND
                   ("Posting Date" <= PeriodStartDate[i + 1])
                THEN
                    IF "Remaining Quantity" <> 0 THEN BEGIN
                        InvtQty[i] := "Remaining Quantity";
                        EXIT;
                    END;
        END;
    end;

    local procedure CalcUnitCost()
    var
        ValueEntry: Record 5802;
    begin
        WITH ValueEntry DO BEGIN
            SETRANGE("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
            UnitCost := 0;

            IF FIND('-') THEN
                REPEAT
                    IF "Partial Revaluation" THEN
                        SumUnitCost(UnitCost, "Cost Amount (Actual)" + "Cost Amount (Expected)", "Valued Quantity")
                    ELSE
                        SumUnitCost(UnitCost, "Cost Amount (Actual)" + "Cost Amount (Expected)", "Item Ledger Entry".Quantity);
                UNTIL NEXT = 0;
        END;
    end;

    local procedure CalcUnitCost_L(Rec: Record "Item Ledger Entry")
    var
        ValueEntry: Record 5802;
    begin
        WITH ValueEntry DO BEGIN
            SETRANGE("Item Ledger Entry No.", Rec."Entry No.");
            UnitCost := 0;

            IF FIND('-') THEN
                REPEAT
                    IF "Partial Revaluation" THEN
                        SumUnitCost(UnitCost, "Cost Amount (Actual)" + "Cost Amount (Expected)", "Valued Quantity")
                    ELSE
                        SumUnitCost(UnitCost, "Cost Amount (Actual)" + "Cost Amount (Expected)", Rec.Quantity);
                UNTIL NEXT = 0;
        END;
    end;

    local procedure SumUnitCost(var UnitCost: Decimal; CostAmount: Decimal; Quantity: Decimal)
    begin
        UnitCost := UnitCost + CostAmount / ABS(Quantity);
    end;


    procedure InitializeRequest(NewEndingDate: Date; NewPeriodLength: DateFormula)
    begin
        PeriodStartDate[5] := NewEndingDate;
        PeriodLength := NewPeriodLength;
    end;

    trigger OnPostReport()
    begin
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
    begin
        Item.CalcFields(Inventory);
        if Item.Inventory <> 0 then begin
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
            ExcelBuf.AddColumn(Item.Inventory, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(Item."Reserved Qty. on Inventory", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(Item.Inventory - Item."Reserved Qty. on Inventory", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(Item."Unit Cost", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn((Item.Inventory * Item."Unit Cost"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
            /*
               if Item.Picture.Count > 0 then begin
                   IF TenantMedia.GET(Item.Picture.Item(1)) THEN BEGIN
                       TenantMedia.CALCFIELDS(Content);
                       TenantMedia.Content.CREATEOUTSTREAM(OutStr);
                       OutStr.WRITE(BStr);
                   END;

               end;
               ExcelBuf.AddColumn(BStr, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
       */
            ExcelBuf.AddColumn(InvtQtyForQ[1], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(InvtValue[1], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(InvtQtyForQ[2], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(InvtValue[2], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(InvtQtyForQ[3], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(InvtValue[3], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(InvtQtyForQ[4], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(InvtValue[4], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(InvtQtyForQ[5], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(InvtValue[5], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

            if (StrLen(DescText) > 249) then begin
                ExcelBuf.NewRow();
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(CopyStr(DescText, 250, StrLen(DescText) - 1), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
            end;
        end;
    END;



    local procedure CreateExcelbook()
    begin
        ExcelBuf.CreateNewBook(Text101);
        ExcelBuf.WriteSheet(Text102, COMPANYNAME, USERID);
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
        // ExcelBuf.CreateBookAndOpenExcel('', Text101, Text102, COMPANYNAME, USERID);
    end;
}

