report 50173 "Update VAT Prod. Group PL"
{

    ProcessingOnly = true;
    Permissions = TableData 39 = RIMD;
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
            RecPurchaseLine: Record "Purchase Line";
            RecItem: Record Item;
        begin
            If CloseAction IN [ACTION::OK, ACTION::LookupOK] then begin
                if VatProdPostingGroup <> '' then begin
                    Clear(RecPurchaseLine);
                    RecPurchaseLine.SetRange("Document Type", RecPurchaseLine."Document Type"::Order);
                    RecPurchaseLine.SetFilter("Document No.", '<>%1', '');
                    RecPurchaseLine.SetRange(Type, RecPurchaseLine.Type::Item);
                    if RecPurchaseLine.FindSet(true, false) then begin
                        if not Confirm('Do you want to update VAT Prod. Posting Group of Non Inventory Items?', false) then
                            exit;
                        repeat
                            If RecItem.GET(RecPurchaseLine."No.") then begin
                                if RecItem.Type = RecItem.Type::"Non-Inventory" then begin
                                    RecPurchaseLine.SuspendStatusCheck(true);
                                    RecPurchaseLine.Validate("VAT Prod. Posting Group", VatProdPostingGroup);
                                    RecPurchaseLine.Modify(true);
                                end;
                            end;
                        until RecPurchaseLine.Next() = 0;
                        Message('Process completed.');
                    end;
                end;
            end;
        end;
    }

    var
        VatProdPostingGroup: Code[20];
}