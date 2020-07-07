report 50172 "Update VAT Prod. Group For PI"
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
            RecPurchaseline: Record "Purchase Line";
            RecItem: Record Item;
        begin
            If CloseAction IN [ACTION::OK, ACTION::LookupOK] then begin
                if VatProdPostingGroup <> '' then begin
                    Clear(RecPurchaseline);
                    RecPurchaseline.SetRange("Document Type", RecPurchaseline."Document Type"::Invoice);
                    RecPurchaseline.SetFilter("Document No.", '=%1', DocNo);
                    if RecPurchaseline.FindSet(true, false) then begin
                        if not Confirm('Do you want to update VAT Prod. Posting Group of Non Inventory Items?', false) then
                            exit;
                        repeat
                            RecPurchaseline.SuspendStatusCheck(true);
                            RecPurchaseline.Validate("VAT Prod. Posting Group", VatProdPostingGroup);
                            RecPurchaseline.Modify(true);
                        until RecPurchaseline.Next() = 0;
                        Message('Process completed.');
                    end;
                end;
            end;
        end;
    }
    procedure SetDocumentNo(InvoiceNoL: Code[20])
    begin
        Clear(DocNo);
        DocNo := InvoiceNoL;
    end;

    var
        VatProdPostingGroup: Code[20];
        DocNo: Code[20];
}