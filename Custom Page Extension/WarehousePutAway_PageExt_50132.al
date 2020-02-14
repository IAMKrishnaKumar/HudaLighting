/*pageextension 50134 WarehosuePutAway extends "Whse. Put-away Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Due Date")
        {
            field("Zone Code_"; "Zone Code")
            {
                ApplicationArea = All;
                Caption = 'Zone Code';
            }
            field("Bin Code_"; "Bin Code")
            {
                ApplicationArea = All;
                Caption = 'Bin Code';
            }
            field("Action Type_"; "Action Type")
            {
                ApplicationArea = All;
                Caption = 'Action Type';
            }

        }
        modify("Zone Code")
        {
            Visible = false;
        }
        modify("Bin Code")
        {
            Visible = false;
        }
        modify("Action Type")
        {
            Visible = false;
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
*/