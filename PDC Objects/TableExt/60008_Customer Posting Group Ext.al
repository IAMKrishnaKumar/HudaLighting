tableextension 60008 "Customer Posting Group Ext" extends "Customer Posting Group"
{
    fields
    {
        field(60000; "PDC Receipt Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Receipt Account';
            TableRelation = "G/L Account";
        }
    }


}