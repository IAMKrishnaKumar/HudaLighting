pageextension 50136 SOPRocessor extends "SO Processor Activities"
{
    layout
    {
        // Add changes to page layout here
        modify("UserTaskManagement.GetMyPendingUserTasksCount")
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