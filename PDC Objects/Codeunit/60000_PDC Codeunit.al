codeunit 60000 "PDC Codeunit"
{
    procedure PrintPDC(VAR PDCIssue: Record "PDC Issue")
    var

        BkAcc: Record "Bank Account";
    begin
        //APNT-ChPr1.0
        IF NOT PDCIssue.FIND('-') THEN
            EXIT;

        IF NOT BkAcc.GET(PDCIssue.Bank) THEN
            ERROR('Bank Account %1 does not exist.', PDCIssue.Bank);
        PDCIssue.SETRANGE(Code, PDCIssue.Code);
        IF BkAcc."PDC Report ID" <> 0 THEN BEGIN
            REPORT.RUNMODAL(BkAcc."PDC Report ID", TRUE, FALSE, PDCIssue);
            EXIT;
        END ELSE
            ERROR('No Check Report Found!');

    end;

    procedure VoidPDC(VAR PDCIssue: Record "PDC Issue")
    var
        CheckLedgEntry3: Record "Check Ledger Entry";
    begin
        //APNT-LCPDC1.0
        IF NOT PDCIssue."Check Printed" THEN
            EXIT;

        CheckLedgEntry3.RESET;
        CheckLedgEntry3.SETCURRENTKEY("Bank Account No.", "Entry Status", CheckLedgEntry3."Check No.");
        CheckLedgEntry3.SETRANGE("Bank Account No.", PDCIssue.Bank);
        CheckLedgEntry3.SETRANGE("Entry Status", CheckLedgEntry3."Entry Status"::Printed);
        CheckLedgEntry3.SETRANGE(CheckLedgEntry3."Check No.", PDCIssue."Cheque No.");
        CheckLedgEntry3.FIND('-');

        CheckLedgEntry3."Original Entry Status" := CheckLedgEntry3."Entry Status";
        CheckLedgEntry3."Entry Status" := CheckLedgEntry3."Entry Status"::Voided;
        CheckLedgEntry3.Open := FALSE;
        CheckLedgEntry3.MODIFY;
    end;
}