tableextension 60007 "User Setup Ext" extends "User Setup"
{
    fields
    {
        //HUDA
        field(50000; "Receive Daily SO Report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Receive Daily PO Report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //PDC
        field(60000; "Reopen Letter of Credit"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(60001; "Confirm Payment Jnls."; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(60002; "Retail User"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }


}