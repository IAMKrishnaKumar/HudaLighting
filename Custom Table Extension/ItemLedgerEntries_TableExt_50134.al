tableextension 50136 ItemLedger extends "Item Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Vendor Article No."; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup (Item."Vendor Article No" where("No." = field("Item No.")));
        }
        field(50001; "Description 2"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup (Item."Description 2" where("No." = field("Item No.")));
        }
        field(50002; "Description 3"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup (Item."Description 3" where("No." = field("Item No.")));
        }
        field(50003; "Brand"; Text[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup (Item.Brand where("No." = field("Item No.")));

        }
    }

    var
        myInt: Integer;
}