tableextension 50161 SalesPeople extends "Salesperson/Purchaser"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Alias Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}