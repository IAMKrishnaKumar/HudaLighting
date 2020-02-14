pageextension 50134 WarehosuePutAway extends "Whse. Put-away Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Item No.")
        {
            field("Vendor Article No."; "Vendor Article No.")
            {
                ApplicationArea = All;
            }
            field(Description_; Description)
            {
                ApplicationArea = All;
                Caption = 'Description';
            }
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
            }
            field("Description 3"; "Description 3")
            {
                ApplicationArea = All;
            }

        }
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
        modify(Description)
        {
            Visible = false;
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