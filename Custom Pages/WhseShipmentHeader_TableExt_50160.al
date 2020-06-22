tableextension 50160 "WhseShipmentHeader" extends "Warehouse Shipment Header"
{
    fields
    {
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