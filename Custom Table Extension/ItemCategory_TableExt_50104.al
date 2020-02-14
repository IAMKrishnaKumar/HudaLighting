tableextension 50104 Itemcat extends "Item Category"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Warranty Days"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Arabic Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

    }

    var
        myInt: Integer;
}