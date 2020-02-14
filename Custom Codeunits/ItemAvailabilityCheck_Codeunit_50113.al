codeunit 50113 "Item Availability"
{

    trigger OnRun()
    begin
    end;

    var
        Item: Record 27;
        SalesHeader: Record 36;
        SalesPriceCalcMgt: Codeunit 7000;
        AvailableToPromise: Codeunit 5790;

     
    procedure CalcAvailability(No: code[20]): Decimal
    var
        GrossRequirement: Decimal;
        ScheduledReceipt: Decimal;
        PeriodType: Option Day,Week,Month,Quarter,Year;
        LookaheadDateformula: DateFormula;
        RecItem: Record Item;
    begin
        IF RecItem.GET(No) THEN BEGIN
            //SetItemFilter(Item, SalesLine);
            RecItem.SETRANGE("Date Filter", 0D, WorkDate());
            RecItem.SETFILTER("Variant Filter", '<>%1', '');
            RecItem.SETFILTER("Location Filter", '<>%1', '');
            RecItem.SETRANGE("Drop Shipment Filter", FALSE);

            EVALUATE(LookaheadDateformula, '<0D>');
            EXIT(
              ConvertQty(
                AvailableToPromise.QtyAvailabletoPromise(
                  Item,
                  GrossRequirement,
                  ScheduledReceipt,
                  WorkDate(),
                  PeriodType,
                  LookaheadDateformula),
                1));//Qty per unit measure values-
        END;
    end;

     
    procedure CalcAvailabilityDate(var SalesLine: Record 37): Date
    begin
        IF SalesLine."Shipment Date" <> 0D THEN
            EXIT(SalesLine."Shipment Date");

        EXIT(WORKDATE);
    end;

     
    procedure CalcAvailableInventory(No: Code[20]): Decimal
    var
        RecItem: Record Item;
    begin
        IF RecItem.GET(No) THEN BEGIN
            EXIT(
    ConvertQty(
      AvailableToPromise.CalcAvailableInventory(RecItem),
      1));//SalesLine."Qty. per Unit of Measure"
        END;
    end;

     
    procedure CalcScheduledReceipt(No: code[20]): Decimal
    var
        RecItem: Record Item;
    begin
        IF RecItem.GET(No) THEN BEGIN
            EXIT(
              ConvertQty(
                AvailableToPromise.CalcScheduledReceipt(RecItem),
                1));//SalesLine."Qty. per Unit of Measure"
        END;
    end;

     
    procedure CalcGrossRequirements(No: Code[20]): Decimal
    var
        RecItem: Record Item;
    begin
        IF RecItem.GET(No) THEN BEGIN
            EXIT(
              ConvertQty(
                AvailableToPromise.CalcGrossRequirement(RecItem),
                1));//SalesLine."Qty. per Unit of Measure"
        END;
    end;

     
    procedure CalcReservedRequirements(No: Code[20]): Decimal
    var
        RecItem: Record Item;
    begin
        IF RecItem.GET(No) THEN BEGIN
            EXIT(
              ConvertQty(
                AvailableToPromise.CalcReservedReceipt(RecItem),
                1));//SalesLine."Qty. per Unit of Measure"
        END;
    end;

     
    procedure CalcReservedDemand(No: code[20]): Decimal
    var
        RecItem: Record Item;
    begin
        IF RecItem.GET(No) THEN BEGIN
            EXIT(
              ConvertQty(
                AvailableToPromise.CalcReservedRequirement(RecItem),
                1));//SalesLine."Qty. per Unit of Measure"
        END;
    end;

     
    procedure CalcNoOfSubstitutions(var SalesLine: Record 37): Integer
    begin
        IF GetItem(SalesLine) THEN BEGIN
            Item.CALCFIELDS("No. of Substitutes");
            EXIT(Item."No. of Substitutes");
        END;
    end;

     
    procedure CalcNoOfSalesPrices(var SalesLine: Record 37): Integer
    begin
        IF GetItem(SalesLine) THEN BEGIN
            GetSalesHeader(SalesLine);
            EXIT(SalesPriceCalcMgt.NoOfSalesLinePrice(SalesHeader, SalesLine, TRUE));
        END;
    end;

     
    procedure CalcNoOfSalesLineDisc(var SalesLine: Record 37): Integer
    begin
        IF GetItem(SalesLine) THEN BEGIN
            GetSalesHeader(SalesLine);
            EXIT(SalesPriceCalcMgt.NoOfSalesLineLineDisc(SalesHeader, SalesLine, TRUE));
        END;
    end;

    local procedure ConvertQty(Qty: Decimal; PerUoMQty: Decimal): Decimal
    begin
        IF PerUoMQty = 0 THEN
            PerUoMQty := 1;
        EXIT(ROUND(Qty / PerUoMQty, 0.00001));
    end;

     
    procedure LookupItem(var SalesLine: Record 37)
    begin
        SalesLine.TESTFIELD(Type, SalesLine.Type::Item);
        SalesLine.TESTFIELD("No.");
        GetItem(SalesLine);
        PAGE.RUNMODAL(PAGE::"Item Card", Item);
    end;

    local procedure GetItem(var SalesLine: Record 37): Boolean
    begin
        WITH Item DO BEGIN
            IF (SalesLine.Type <> SalesLine.Type::Item) OR (SalesLine."No." = '') THEN
                EXIT(FALSE);

            IF SalesLine."No." <> "No." THEN
                GET(SalesLine."No.");
            EXIT(TRUE);
        END;
    end;

    local procedure GetSalesHeader(var SalesLine: Record 37)
    begin
        IF (SalesLine."Document Type" <> SalesHeader."Document Type") OR
           (SalesLine."Document No." <> SalesHeader."No.")
        THEN
            SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
    end;

    local procedure SetItemFilter(var Item: Record 27; var SalesLine: Record 37)
    begin
        Item.RESET;
        Item.SETRANGE("Date Filter", 0D, CalcAvailabilityDate(SalesLine));
        Item.SETRANGE("Variant Filter", SalesLine."Variant Code");
        Item.SETRANGE("Location Filter", SalesLine."Location Code");
        Item.SETRANGE("Drop Shipment Filter", FALSE);
        OnAfterSetItemFilter(Item, SalesLine);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetItemFilter(var Item: Record 27; SalesLine: Record 37)
    begin
    end;
}

