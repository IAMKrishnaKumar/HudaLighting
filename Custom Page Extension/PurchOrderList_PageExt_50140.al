pageextension 50140 PurchOrderList extends "Purchase Order List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                Rec.TestField("Currency Code");
                if WorkDate() < Today() then
                    if not Confirm('Your Order Date is in the past. Please change it to the Current date.', false) then
                        exit;
                if WorkDate() > Today() then
                    if not Confirm('Your Order Date is in the future. Please change it to the Current date.', false) then
                        exit;
            end;
        }
        // Add changes to page actions here
        // modify("P&osting")
        // {
        //     Visible = false;
        // }
        // modify(PostBatch)
        // {
        //     trigger OnBeforeAction()
        //     begin
        //         Error('You are not allowed to post the Purchase Order.');
        //     end;
        //}
    }

    var
        myInt: Integer;
}