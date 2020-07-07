report 50171 "Update VAT Prod. Group For SI"
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
                    RecSalesLine.SetRange("Document Type", RecSalesLine."Document Type"::Invoice);
                    RecSalesLine.SetFilter("Document No.", '=%1', DocNo);
                    if RecSalesLine.FindSet(true, false) then begin
                        if not Confirm('Do you want to update VAT Prod. Posting Group of Non Inventory Items?', false) then
                            exit;
                        repeat
                            RecSalesLine.SuspendStatusCheck(true);
                            RecSalesLine.Validate("VAT Prod. Posting Group", VatProdPostingGroup);
                            RecSalesLine.Modify(true);
                        until RecSalesLine.Next() = 0;
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