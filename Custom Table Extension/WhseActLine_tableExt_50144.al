tableextension 50144 WhseActivityLine extends "Warehouse Activity Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Vendor Article No."; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup (Item."Vendor Article No" where("No." = field("Item No.")));
        }
        field(50001; "Description 3"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup (Item."Description 3" where("No." = field("Item No.")));
        }
        /* modify("Item No.")
         {
             trigger OnAfterValidate()
             var
                 RecItem: Record Item;
             begin
                 Clear(RecItem);
                 IF RecItem.GET("Item No.") then begin
                     "Vendor Article No." := RecItem."Vendor Article No";
                     "Description 3" := RecItem."Description 3";
                 end else begin
                     "Vendor Article No." := '';
                     "Description 3" := '';
                 end;
             end;
         }*/
    }

    var
        myInt: Integer;
}