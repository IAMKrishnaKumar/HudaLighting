pageextension 50181 POFromSo extends "Purch. Order From Sales Order"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Vendor Article No."; "Vendor Article No.")
            {
                ApplicationArea = All;
            }
            field(Type; Type)
            {
                ApplicationArea = All;
            }
            field(Brand; Brand)
            {
                ApplicationArea = All;
            }
            field("Ref Type"; "Ref Type")
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        // Add changes to page actions here
        addlast(Processing)
        {
            action("Remove Quantity to Purchase")
            {
                ApplicationArea = All;
                Image = RemoveLine;
                trigger OnAction()
                begin
                    if Rec.FindSet() then begin
                        IF NOT Confirm('Are you sure you want to remove Quantity To Purchase from all lines?', FALSE) then
                            exit;
                        repeat
                            Rec.Quantity := 0;
                            Rec.Modify();
                        until Rec.Next() = 0;
                    end;
                end;
            }
        }
    }

    var
        myInt: Integer;
}