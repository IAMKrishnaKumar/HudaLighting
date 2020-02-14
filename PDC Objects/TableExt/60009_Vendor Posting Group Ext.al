tableextension 60009 "Vendor Posting Group Ext" extends "Vendor Posting Group"
{
    fields
    {
        field(60000; "PDC Issue Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Payment Account';
            TableRelation = "G/L Account";
        }
    }


}