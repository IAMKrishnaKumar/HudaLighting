xmlport 50102 SalesLineImport
{
    Caption = 'Sales Order uploader';
    Direction = Import;
    Format = VariableText;
    TextEncoding = UTF8;
    FieldSeparator = ',';
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(SalesLine; "Sales Line")
            {
                AutoSave = false;
                textelement("Sales_Order_No.")
                { }
                textelement("HL_Line_Type")
                { }
                textelement("Vendor_Article_No.")
                { }
                textelement("Line_Quantity")
                { }
                textelement("Unit_Price_Excl_VAT")
                { }
                textelement("Line_Discount_Percentage")
                { }
                textelement("Estimated_Cost")
                { }
                trigger OnAfterInitRecord()
                begin
                    if Pagecaption = true then begin
                        Pagecaption := false;
                        RowNumber += 1;
                        currXMLport.Skip();
                    end;
                end;

                trigger OnBeforeInsertRecord()
                var
                    SalesLine2: Record "Sales Line";
                    RecItemL: Record Item;
                    ReserveSalesLine: Codeunit "Sales Line-Reserve";
                begin
                    SalesLine.SetHideValidationDialog(true);
                    SalesLine.SetHasBeenShown();
                    RowNumber += 1;
                    Clear(SalesLine2);
                    SalesLine2.SetRange("Document Type", SalesLine2."Document Type"::Order);
                    SalesLine2.SetRange("Document No.", "Sales_Order_No.");
                    if SalesLine2.FindLast() then;
                    SalesLine.Validate("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.Validate("Document No.", "Sales_Order_No.");
                    SalesLine.Validate("Line No.", SalesLine2."Line No." + 10000);
                    SalesLine.Validate(Type, SalesLine.Type::Item);
                    Clear(RecItemL);
                    RecItemL.SetRange("Vendor Article No", "Vendor_Article_No.");
                    RecItemL.FindFirst();// if not it will show error bedefault
                    SalesLine.Validate("No.", RecItemL."No.");
                    SalesLine."HL Line Type" := HL_Line_Type;
                    //SalesLine."Line Type" := HL_Line_Type;
                    if Unit_Price_Excl_VAT = '' then
                        SalesLine.Validate("Unit Price", 0)
                    else begin
                        Evaluate(EvalDecimal, Unit_Price_Excl_VAT);
                        SalesLine.Validate("Unit Price", EvalDecimal);
                    end;

                    if Line_Discount_Percentage = '' then
                        SalesLine.Validate("Line Discount %", 0)
                    else begin
                        Evaluate(EvalDecimal, Line_Discount_Percentage);
                        SalesLine.Validate("Line Discount %", EvalDecimal);
                    end;

                    if Estimated_Cost = '' then
                        SalesLine.Validate("Estimated Cost", 0)
                    else begin
                        Evaluate(EvalDecimal, Estimated_Cost);
                        SalesLine.Validate("Estimated Cost", EvalDecimal);
                    end;
                    SalesLine.Validate(Reserve, SalesLine.Reserve::Always);
                    if Line_Quantity = '' then
                        SalesLine.Validate(Quantity, 0)
                    else begin
                        Evaluate(EvalDecimal, Line_Quantity);
                        SalesLine.Validate(Quantity, EvalDecimal);
                    end;
                    SalesLine.Insert(true);
                    SalesOrderLineReserve(SalesLine);
                    SalesLine.Modify(true);
                end;

            }
        }
    }
    trigger OnPreXmlPort()
    begin
        Pagecaption := true;
        RowNumber := 0;
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

    trigger OnPostXmlPort()
    begin
        Message('Process completed.');
    end;

    var
        Pagecaption: Boolean;
        RowNumber: Integer;
        EvalDecimal: Decimal;
}