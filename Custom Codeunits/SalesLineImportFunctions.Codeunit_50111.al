codeunit 50111 "Import Functions"
{
    TableNo = "Sales Line Buffer";
    trigger OnRun()
    var
        SalesLine2: Record "Sales Line";
        RecItemL: Record Item;
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
        SalesLine: Record "Sales Line";
    begin
        if IsInsert then begin
            SalesLine.Init();
            SalesLine.LockTable(true);
        end;

        SalesLine.SetHideValidationDialog(true);
        SalesLine.SetHasBeenShown();
        Clear(SalesLine2);
        SalesLine2.SetRange("Document Type", SalesLine2."Document Type"::Order);
        SalesLine2.SetRange("Document No.", Rec."Sales Order No.");
        if SalesLine2.FindLast() then;
        SalesLine.Validate("Document Type", SalesLine."Document Type"::Order);
        SalesLine.Validate("Document No.", Rec."Sales Order No.");
        SalesLine.Validate("Line No.", SalesLine2."Line No." + 10000);
        SalesLine.Validate(Type, SalesLine.Type::Item);
        Clear(RecItemL);
        RecItemL.SetRange("Vendor Article No", Rec."Vendor Article No.");
        RecItemL.SetRange("Vendor No.", Rec."vendor No.");
        RecItemL.FindFirst();// if not....it will show error bydefault
        SalesLine.Validate("No.", RecItemL."No.");
        SalesLine."HL Line Type" := Rec."Line Type";

        if Rec.Quantity = '' then
            SalesLine.Validate(Quantity, 0)
        else begin
            Evaluate(EvalDecimal, Rec.Quantity);
            SalesLine.Validate(Quantity, EvalDecimal);
        end;

        if Rec."Unit Price" = '' then
            SalesLine.Validate("Unit Price", 0)
        else begin
            Evaluate(EvalDecimal, Rec."Unit Price");
            SalesLine.Validate("Unit Price", EvalDecimal);
        end;

        if Rec."Line Discount %" = '' then
            SalesLine.Validate("Line Discount %", 0)
        else begin
            Evaluate(EvalDecimal, Rec."Line Discount %");
            SalesLine.Validate("Line Discount %", EvalDecimal);
        end;

        if Rec."Estimated Cost" = '' then
            SalesLine.Validate("Estimated Cost", 0)
        else begin
            Evaluate(EvalDecimal, Rec."Estimated Cost");
            SalesLine.Validate("Estimated Cost", EvalDecimal);
        end;
        SalesLine.Validate(Reserve, SalesLine.Reserve::Always);

        if IsInsert then begin
            SalesLine.Insert(true);
            SalesOrderLineReserve(SalesLine);
            SalesLine.Modify(true);
            Commit();
        end;
    end;

    procedure SetInsertfalg(IsInsertL: Boolean)
    begin
        Clear(IsInsert);
        IsInsert := IsInsertL;
    end;

    PROCEDURE SalesOrderLineReserve(VAR pioSalesLine: Record 37)//piItem: Record 27);
    VAR
        lReservationEntry: Record "Reservation Entry";
        lReservEntryILE: Record "Reservation Entry";
        lReservEntryEdit: Record "Reservation Entry";
        lSalesLine: Record "Sales Line";
        lcuReservationManagement: Codeunit "Reservation Management";
        DoFullReserve: Boolean;
        lcuSalesLineReserve: Codeunit "Sales Line-Reserve";
    BEGIN
        lcuReservationManagement.SetSalesLine(pioSalesLine);
        lcuReservationManagement.AutoReserve(DoFullReserve, pioSalesLine.Description, WORKDATE, pioSalesLine."Outstanding Quantity", pioSalesLine."Outstanding Qty. (Base)");
        lcuSalesLineReserve.FilterReservFor(lReservationEntry, pioSalesLine);

        IF lReservationEntry.FINDSET THEN
            REPEAT
                lReservEntryILE.GET(lReservationEntry."Entry No.", NOT lReservationEntry.Positive);
                lReservEntryEdit.GET(lReservationEntry."Entry No.", lReservationEntry.Positive);
                lReservEntryEdit."Lot No." := lReservEntryILE."Lot No.";
                lReservEntryEdit.MODIFY;
            UNTIL lReservationEntry.NEXT = 0;
    END;

    var
        myInt: Integer;
        EvalDecimal: Decimal;
        IsInsert: Boolean;
}