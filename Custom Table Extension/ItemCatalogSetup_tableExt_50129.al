/*tableextension 50129 ItemcatalogSetup extends "Nonstock Item Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Item Identifier"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
    }

    var
        myInt: Integer;
}
*/