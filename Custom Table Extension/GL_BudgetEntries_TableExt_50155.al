tableextension 50155 GlBudgetEntry extends "G/L Budget Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Amount (ACY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}