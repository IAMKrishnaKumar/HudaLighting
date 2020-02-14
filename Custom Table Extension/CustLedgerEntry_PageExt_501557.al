tableextension 50157 CustLedEntry extends "Cust. Ledger Entry"
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

        //***************************PDC******************
        field(60000; "PDC Applied Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Applied Amount';
        }
        field(60001; "PDC Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Entry';
        }
        field(60002; "PDC Amt to Apply"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Amt to Apply';
        }
    }

    var
        myInt: Integer;
}