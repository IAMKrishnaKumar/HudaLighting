tableextension 50125 bankLedgerEntry extends "Bank Account Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; Narration; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Check No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Check Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        //****************PDC*************
        field(60000; Payee; Text[75])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payee';
        }
    }

    var
        myInt: Integer;
}