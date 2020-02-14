tableextension 60013 "Purch Receipt Header Ext" extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50000; "LC No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "LC Exp Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "LC Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Bill Of Entry No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Bill Of Entry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Foreign Vendnor Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purch. Inv. Header"."No.";
        }
        field(50022; "Exchange Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customs Exchange Rate';
        }
        field(50023; "Project Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        //********************PDC*****************
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
        field(60004; "PDC No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC No.';
        }
        field(60005; "L.C. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'L.C. No.';
        }
    }


}