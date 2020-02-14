pageextension 50154 WhsePickLine extends "Warehouse Pick"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        modify(RegisterPick)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Assigned User ID");
            end;
        }
    }

    var
        myInt: Integer;
}