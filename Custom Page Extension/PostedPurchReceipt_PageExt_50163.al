pageextension 50163 PostedPurchReceipt extends "Posted Purchase Receipt"
{
    layout
    {
        // Add changes to page layout here
        addafter(Shipping)
        {
            group("Credit Facility Details")
            {
                field("LC No."; "LC No.")
                {
                    ApplicationArea = All;
                }
                field("LC Exp Date"; "LC Exp Date")
                {
                    ApplicationArea = All;
                }
                field("LC Amount"; "LC Amount")
                {
                    ApplicationArea = All;
                }

            }
        }
        addafter("Vendor Shipment No.")
        {
            field("Project Name"; "Project Name")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

}

pageextension 50198 PostedpurchList extends "Posted Purchase Receipts"
{
    layout
    {
        // Add changes to page layout here
        addbefore("Location Code")
        {
            field(CompletelyInvoiced; CompletelyInvoiced)
            {
                ApplicationArea = All;
                Caption = 'Completely Invoiced';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Print")
        {
            action("View Load Charges")
            {
                ApplicationArea = All;
                Image = View;
                trigger OnAction()
                VAR
                    RecILE: Record "Item Ledger Entry";
                    RecVE: Record "Value Entry";
                    ILEEntyNo: Text;
                    PageVE: Page "Value Entries";
                begin
                    Clear(RecILE);
                    Clear(ILEEntyNo);
                    RecILE.SetFilter("Document No.", '=%1', Rec."No.");
                    if RecILE.FindSet() then begin
                        repeat
                            ILEEntyNo := ILEEntyNo + FORMAT(RecILE."Entry No.") + '|';
                        until RecILE.Next() = 0;
                    end;
                    if ILEEntyNo <> '' then begin
                        ILEEntyNo := CopyStr(ILEEntyNo, 1, StrLen(ILEEntyNo) - 1);
                        Clear(RecVE);
                        RecVE.SetFilter("Item Ledger Entry No.", ILEEntyNo);
                        RecVE.SetFilter("Item Charge No.", '<>%1', '');
                        if RecVE.FindSet() then begin
                            PageVE.SetTableView(RecVE);
                            PageVE.RunModal();
                        end;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        RecPurcRcpLine: Record "Purch. Rcpt. Line";
        TotalInvoiced: Decimal;
    begin
        Clear(RecPurcRcpLine);
        Clear(CompletelyInvoiced);
        Clear(TotalInvoiced);
        RecPurcRcpLine.SetRange("Document No.", Rec."No.");
        if RecPurcRcpLine.FindSet() then begin
            repeat
                TotalInvoiced += RecPurcRcpLine."Qty. Rcd. Not Invoiced";
            until RecPurcRcpLine.Next() = 0;
        end;
        if TotalInvoiced = 0 then
            CompletelyInvoiced := true
        else
            CompletelyInvoiced := false;
    end;

    var
        CompletelyInvoiced: Boolean;
}