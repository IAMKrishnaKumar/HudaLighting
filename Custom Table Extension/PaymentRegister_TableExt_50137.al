tableextension 50138 PaymentRegBuffer extends "Payment Registration Buffer"
{
    fields
    {
        // Add changes to table fields here
        field(50000; Narration; Text[250])
        {
            DataClassification = SystemMetadata;
        }
        field(50001; "Check No."; Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(50002; "Check Date"; Date)
        {
            DataClassification = SystemMetadata;
        }

    }

    procedure ReloadCustom()
    var
        TempDataSavePmtRegnBuf: Record "Payment Registration Buffer";
        TempRecSavePmtRegnBuf: Record "Payment Registration Buffer";
    begin
        ///  TempRecSavePmtRegnBuf.COPY(Rec, TRUE);

        SaveUserValues(TempDataSavePmtRegnBuf);

        // PopulateTable;

        RestoreUserValues(TempDataSavePmtRegnBuf);

        //COPY(TempRecSavePmtRegnBuf);
        // IF GET("Ledger Entry No.") THEN;
    end;


    LOCAL procedure SaveUserValues(VAR TempSavePmtRegnBuf: Record "Payment Registration Buffer" TEMPORARY)
    var
        TempWorkPmtRegnBuf: Record "Payment Registration Buffer";
    begin
        TempWorkPmtRegnBuf.COPY(Rec, TRUE);
        TempWorkPmtRegnBuf.RESET;
        TempWorkPmtRegnBuf.SETRANGE("Payment Made", TRUE);
        IF TempWorkPmtRegnBuf.FINDSET THEN
            REPEAT
                TempSavePmtRegnBuf := TempWorkPmtRegnBuf;
                TempSavePmtRegnBuf.INSERT;
            UNTIL TempWorkPmtRegnBuf.NEXT = 0;
    end;

    LOCAL procedure RestoreUserValues(VAR TempSavePmtRegnBuf: Record "Payment Registration Buffer" TEMPORARY)
    begin
        IF TempSavePmtRegnBuf.FINDSET THEN
            REPEAT
                IF GET(TempSavePmtRegnBuf."Ledger Entry No.") THEN BEGIN
                    "Payment Made" := TempSavePmtRegnBuf."Payment Made";
                    "Date Received" := TempSavePmtRegnBuf."Date Received";
                    "Pmt. Discount Date" := TempSavePmtRegnBuf."Pmt. Discount Date";
                    SuggestAmountReceivedBasedOnDate;
                    "Remaining Amount" := TempSavePmtRegnBuf."Remaining Amount";
                    "Amount Received" := TempSavePmtRegnBuf."Amount Received";
                    "External Document No." := TempSavePmtRegnBuf."External Document No.";
                    "Check Date" := TempSavePmtRegnBuf."Check Date";
                    "Check No." := TempSavePmtRegnBuf."Check No.";
                    Narration := TempSavePmtRegnBuf.Narration;
                    MODIFY;
                END;
            UNTIL TempSavePmtRegnBuf.NEXT = 0;
    end;

    LOCAL procedure SuggestAmountReceivedBasedOnDate()
    begin
        "Amount Received" := GetMaximumPaymentAmountBasedOnDate;
        IF "Date Received" = 0D THEN
            EXIT;
        "Remaining Amount" := 0;
    end;

    LOCAL procedure GetMaximumPaymentAmountBasedOnDate(): Decimal
    begin
        IF "Date Received" = 0D THEN
            EXIT(0);

        IF "Date Received" <= "Pmt. Discount Date" THEN
            EXIT("Rem. Amt. after Discount");

        EXIT("Original Remaining Amount");
    end;

    var
        myInt: Integer;
}