report 50166 "Update SO In Posted Sales Line"
{
    // UsageCategory = Administration;
    //ApplicationArea = All;
    UseRequestPage = true;
    ProcessingOnly = true;
    Permissions = TableData 113 = RIMD;
    dataset
    {
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(SalesOrderNo; SalesOrderNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Order No.';
                        TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
                    }
                }
            }
        }
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var
            PostedSalesInvLine: Record "Sales Invoice Line";
        begin
            If CloseAction IN [ACTION::OK, ACTION::LookupOK] then begin
                if (SalesOrderNo <> '') AND (PostedSalesInvNo <> '') then begin
                    Clear(PostedSalesInvLine);
                    PostedSalesInvLine.SetFilter("Document No.", PostedSalesInvNo);
                    if PostedSalesInvLine.FindSet() then begin
                        if not Confirm('Do you want to update Sales Order No. in all the Sales Invoice Line of this document?', false) then
                            exit;
                        PostedSalesInvLine.ModifyAll("Sales Order No.", SalesOrderNo);
                    end;
                end else
                    Error('Enter Sales Order No.');
            end;
        end;
    }
    procedure SetSalesInvNo(NoL: Code[20])
    begin
        Clear(PostedSalesInvNo);
        PostedSalesInvNo := NoL;
    end;

    var
        PostedSalesInvNo: Code[20];
        SalesOrderNo: Code[20];
}



///


