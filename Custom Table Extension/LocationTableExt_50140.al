tableextension 50140 Locationtable extends Location
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Retail Location"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}