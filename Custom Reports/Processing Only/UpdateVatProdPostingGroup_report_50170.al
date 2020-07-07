report 50170 "Update VAT Prod. Post. Group"
{

    ProcessingOnly = true;
    Permissions = TableData 37 = RIMD;
    dataset
    {

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(VatProdPostingGroup; VatProdPostingGroup)
                    {
                        ApplicationArea = All;
                        Caption = 'VAT Prod. Posting Group';
                        TableRelation = "VAT Product Posting Group";
                    }

                }
            }

        }



        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var
            RecSalesLine: Record "Sales Line";
            RecItem: Record Item;
        begin
            If CloseAction IN [ACTION::OK, ACTION::LookupOK] then begin
                if VatProdPostingGroup <> '' then begin
                    Clear(RecSalesLine);
                    RecSalesLine.SetRange("Document Type", RecSalesLine."Document Type"::Order);
                    RecSalesLine.SetFilter("Document No.", '<>%1', '');
                    RecSalesLine.SetRange(Type, RecSalesLine.Type::Item);
                    if RecSalesLine.FindSet(true, false) then begin
                        if not Confirm('Do you want to update VAT Prod. Posting Group of Non Inventory Items?', false) then
                            exit;
                        repeat
                            If RecItem.GET(RecSalesLine."No.") then begin
                                if RecItem.Type = RecItem.Type::"Non-Inventory" then begin
                                    RecSalesLine.SuspendStatusCheck(true);
                                    RecSalesLine.Validate("VAT Prod. Posting Group", VatProdPostingGroup);
                                    RecSalesLine.Modify(true);
                                end;
                            end;
                        until RecSalesLine.Next() = 0;
                        Message('Process completed.');
                    end;
                end;
            end;
        end;
    }

    var
        VatProdPostingGroup: Code[20];
}