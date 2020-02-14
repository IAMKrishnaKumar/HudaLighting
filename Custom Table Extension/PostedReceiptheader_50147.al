tableextension 50147 PostedReceiptheader extends "Posted Whse. Receipt Header"
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