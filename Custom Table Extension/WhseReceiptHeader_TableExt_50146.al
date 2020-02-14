tableextension 50146 WhseReceiptHeader extends "Warehouse Receipt Header"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Airway Bill No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}