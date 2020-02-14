tableextension 50130 PostedWhseShipmentLine extends "Posted Whse. Shipment Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Warranty Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Vendor Article No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "HL Line Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
        }
        field(50003; "Estimated Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Estimated GP"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Description 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Brand"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}