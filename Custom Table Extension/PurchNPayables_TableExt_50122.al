tableextension 50122 Pnpayable extends "Purchases & Payables Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Domestic Gen Bus Grp"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Business Posting Group".Code;
        }
        field(50001; "Foreign Gen Bus Grp"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Business Posting Group".Code;
        }
        field(50002; "Domestic Vendor posting group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Posting Group".Code;
        }
        field(50003; "Foreign Vendor posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Posting Group".Code;
        }
        field(50004; "Purchase Price Warning Check"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //*********************PDC**************
        field(60000; "LC Payment Method Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method".Code;
        }
    }

    var
        myInt: Integer;
}