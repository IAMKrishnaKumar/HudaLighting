tableextension 50128 InventorySetup extends "Inventory Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Brand Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension.Code;
        }
    }

    var
        myInt: Integer;
}