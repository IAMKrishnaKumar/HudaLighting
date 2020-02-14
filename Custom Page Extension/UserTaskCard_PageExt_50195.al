pageextension 50195 UserTasCardkExt extends "User Task Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(MultiLineTextControl)
        {
            field("Task Description 2"; "Task Description 2")
            {
                ApplicationArea = All;
            }
        }
        modify(MultiLineTextControl)
        {
            Width = 80000;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}