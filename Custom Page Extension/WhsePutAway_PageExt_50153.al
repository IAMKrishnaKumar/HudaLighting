pageextension 50153 WhsePutAway extends "Warehouse Put-away"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        modify("&Register Put-away")
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                Rec.TestField("Assigned User ID");
            end;
        }
    }

    var
        myInt: Integer;
}