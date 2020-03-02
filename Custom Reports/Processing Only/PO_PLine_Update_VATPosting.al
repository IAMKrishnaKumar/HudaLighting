report 50152 "Update VAT Bus Pos Grp of PI"
{
    // UsageCategory = Administration;
    // ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = TableData 38 = RIMD, TableData 39 = RIMD;
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
                    field("VAT Bus. Pos. Grp"; ToVATBusPosGrp)
                    {
                        ApplicationArea = All;
                        TableRelation = "VAT Business Posting Group";
                    }
                }
            }
        }
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var
            PurchLine: Record "Purchase Line";
        begin
            If CloseAction IN [ACTION::OK, ACTION::LookupOK] then begin
                if (ToVATBusPosGrp <> '') then begin
                    Clear(PurchLine);
                    PurchLine.SetRange("Document Type", PurchLine."Document Type"::Invoice);
                    PurchLine.SetRange("Document No.", InvoiceNO);
                    if PurchLine.FindSet() then begin
                        repeat
                            PurchLine.Validate("VAT Bus. Posting Group", ToVATBusPosGrp);
                            PurchLine.Modify();
                        until PurchLine.Next() = 0;
                    end;
                end;
            end;
        end;
    }
    trigger OnPostReport()
    var

    begin

    end;

    var
        ToVATBusPosGrp: Code[20];
        InvoiceNO: Code[50];

    procedure SetInvoiceNo(InvoiceNoL: Code[50])
    begin
        InvoiceNO := InvoiceNoL;
    end;
}



///




// report 50152 "Update Purch Header and Lines"
// {
//     UsageCategory = Administration;
//     ApplicationArea = All;
//     ProcessingOnly = true;
//     Permissions = TableData 38 = RIMD, TableData 39 = RIMD;
//     dataset
//     {
//     }

//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(General)
//                 {
//                     field("From VAT Bus. Pos. Grp"; FilterText)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Filter Text';
//                         TableRelation = "VAT Business Posting Group".Code;
//                     }
//                     field("To VAT Bus. Pos. Grp"; ToVATBusPosGrp)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'G/L Account No.';
//                         TableRelation = "VAT Business Posting Group".Code;
//                     }
//                 }
//             }
//         }
//         trigger OnQueryClosePage(CloseAction: Action): Boolean
//         var
//             PurchHeader: Record "Purchase Header";
//             PurchLine: Record "Purchase Line";
//         begin
//             If CloseAction IN [ACTION::OK, ACTION::LookupOK] then begin
//                 if (FilterText <> '') AND (ToVATBusPosGrp <> '') then begin
//                     Clear(PurchHeader);
//                     PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
//                     PurchHeader.SetFilter("VAT Bus. Posting Group", FilterText);
//                     if PurchHeader.FindSet() then begin
//                         if not Confirm('Are you sure you want to update the VAT Bus. Pos. Grp of Purchase Header and Lines?', false) then
//                             exit;
//                         repeat
//                             //PurchHeader.SuspendStatusCheck(true);
//                             //PurchHeader.SetHideValidationDialog(true);
//                             PurchHeader."VAT Bus. Posting Group" := ToVATBusPosGrp;
//                             PurchHeader.Modify();

//                             Clear(PurchLine);
//                             PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
//                             PurchLine.SetRange("Document No.", PurchHeader."No.");
//                             PurchLine.SetFilter("VAT Bus. Posting Group", FilterText);
//                             if PurchLine.FindSet() then begin
//                                 repeat
//                                     PurchLine."VAT Bus. Posting Group" := ToVATBusPosGrp;
//                                     PurchLine.Modify();
//                                 until PurchLine.Next() = 0;
//                             end;
//                         until PurchHeader.Next() = 0;
//                     end;


//                 end;
//             end;
//         end;
//     }
//     trigger OnPostReport()
//     var

//     begin

//     end;

//     var
//         FilterText: Text;
//         ToVATBusPosGrp: Code[20];
// }



// ///


