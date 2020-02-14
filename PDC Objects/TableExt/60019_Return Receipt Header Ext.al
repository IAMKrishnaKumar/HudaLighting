tableextension 60019 "Return Receipt Ext" extends "Return Receipt Header"
{
    fields
    {
        field(60000; "Applies-to ID for PDC"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Applies-to ID for PDC';
        }
        field(60001; "Remaining Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Remaining Amount';
        }
        field(60002; "Order Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Order Amount';
        }
        field(60003; "PDC Applied Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Applied Amount';
        }
        field(60004; "Export L.C. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Export L.C. No.';
        }
    }


}
