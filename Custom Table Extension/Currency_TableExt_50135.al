tableextension 50135 CurrencyExt extends Currency
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Decimal Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}