tableextension 50146 WhseReceiptHeader extends "Warehouse Receipt Header"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Airway Bill No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        //**********************************Daily Activity*********************
        field(50101; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "Creation Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
    }

    var
        myInt: Integer;
}