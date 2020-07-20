report 60120 "Preview Posting Fix"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = TableData 17 = RIMD, Tabledata 110 = RIMD, Tabledata 111 = RIMD, Tabledata 112 = RIMD, Tabledata 113 = RIMD, Tabledata 254 = RIMD, Tabledata 21 = RIMD, Tabledata 379 = RIMD, Tabledata 32 = RIMD, Tabledata 5802 = RIMD;
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
                    field(SalesInvoiceNo; SalesInvoiceNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Invoice No.';

                    }
                    field(SalesShipmentNo; SalesShipmentNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Shipment No.';
                    }
                    field(CustNo; CustNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer No.';
                    }
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Posting Date';
                    }
                }
            }
        }
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var
            RecGLEntry: Record "G/L Entry";
            RecSalesInvHeader: Record "Sales Invoice Header";
            RecsalesInvLine: Record "Sales Invoice Line";
            RecSalesShipmentHdr: Record "Sales Shipment Header";
            RecSalesShipmentLine: Record "Sales Shipment Line";
            RecVATEntry: Record "VAT Entry";
            RecCustLedger: Record "Cust. Ledger Entry";
            RecDetailedCust: Record "Detailed Cust. Ledg. Entry";
            RecItemLedgerEntry: Record "Item Ledger Entry";
            RecValueEntry: Record "Value Entry";
        begin
            If CloseAction IN [ACTION::OK, ACTION::LookupOK] then begin
                if (SalesInvoiceNo <> '') AND (SalesShipmentNo <> '') AND (PostingDate <> 0D) AND (CustNo <> '') then begin

                    Clear(RecSalesInvHeader);
                    RecSalesInvHeader.SetFilter("No.", '=%1', '***');
                    RecSalesInvHeader.SetFilter("Sell-to Customer No.", '=%1', CustNo);
                    RecSalesInvHeader.SetFilter("Posting Date", '=%1', PostingDate);
                    if RecSalesInvHeader.FindFirst() then begin
                        RecSalesInvHeader.Rename(SalesInvoiceNo);
                    end;
                    Clear(RecsalesInvLine);
                    RecsalesInvLine.SetFilter("Document No.", '=%1', '***');
                    RecsalesInvLine.SetFilter("Sell-to Customer No.", '=%1', CustNo);
                    RecsalesInvLine.SetFilter("Posting Date", '=%1', PostingDate);
                    if RecsalesInvLine.FindSet() then begin
                        repeat
                            RecsalesInvLine.Rename(SalesInvoiceNo, RecsalesInvLine."Line No.");
                        until RecsalesInvLine.Next() = 0;
                    end;
                    Clear(RecSalesShipmentHdr);
                    RecSalesShipmentHdr.SetFilter("No.", '=%1', '***');
                    RecSalesShipmentHdr.SetFilter("Sell-to Customer No.", '=%1', CustNo);
                    RecSalesShipmentHdr.SetFilter("Posting Date", '=%1', PostingDate);
                    if RecSalesShipmentHdr.FindFirst() then
                        RecSalesShipmentHdr.Rename(SalesShipmentNo);

                    Clear(RecSalesShipmentLine);
                    RecSalesShipmentLine.SetFilter("Document No.", '=%1', '***');
                    RecSalesShipmentLine.SetFilter("Sell-to Customer No.", '=%1', CustNo);
                    RecSalesShipmentLine.SetFilter("Posting Date", '=%1', PostingDate);
                    if RecSalesShipmentLine.FindSet() then begin
                        repeat
                            RecSalesShipmentLine.Rename(SalesShipmentNo, RecSalesShipmentLine."Line No.");
                        until RecSalesShipmentLine.Next() = 0;
                    end;

                    Clear(RecGLEntry);
                    RecGLEntry.SetFilter("Document No.", '=%1', '***');
                    RecGLEntry.SetFilter("Posting Date", '=%1', PostingDate);
                    if RecGLEntry.FindSet() then begin
                        RecGLEntry.ModifyAll("Document No.", SalesInvoiceNo);
                    end;

                    Clear(RecVATEntry);
                    RecVATEntry.SetFilter("Document No.", '=%1', '***');
                    RecVATEntry.SetFilter("Posting Date", '=%1', PostingDate);
                    if RecVATEntry.FindSet() then begin
                        RecVATEntry.ModifyAll("Document No.", SalesInvoiceNo);
                    end;

                    Clear(RecCustLedger);
                    RecCustLedger.SetFilter("Document No.", '=%1', '***');
                    RecCustLedger.SetFilter("Posting Date", '=%1', PostingDate);
                    if RecCustLedger.FindSet() then begin
                        RecCustLedger.ModifyAll("Document No.", SalesInvoiceNo);
                    end;

                    Clear(RecDetailedCust);
                    RecDetailedCust.SetFilter("Document No.", '=%1', '***');
                    RecDetailedCust.SetFilter("Posting Date", '=%1', PostingDate);
                    if RecDetailedCust.FindSet() then begin
                        RecDetailedCust.ModifyAll("Document No.", SalesInvoiceNo);
                    end;
                    Clear(RecItemLedgerEntry);
                    RecItemLedgerEntry.SetFilter("Document No.", '=%1', '***');
                    RecItemLedgerEntry.SetFilter("Posting Date", '=%1', PostingDate);
                    if RecItemLedgerEntry.FindSet() then begin
                        RecItemLedgerEntry.ModifyAll("Document No.", SalesInvoiceNo);
                    end;

                    Clear(RecValueEntry);
                    RecValueEntry.SetFilter("Document No.", '=%1', '***');
                    RecValueEntry.SetFilter("Posting Date", '=%1', PostingDate);
                    if RecValueEntry.FindSet() then begin
                        RecValueEntry.ModifyAll("Document No.", SalesInvoiceNo);
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
        SalesInvoiceNo: Code[20];
        SalesShipmentNo: Code[20];
        PostingDate: Date;
        CustNo: Code[20];
}



///


