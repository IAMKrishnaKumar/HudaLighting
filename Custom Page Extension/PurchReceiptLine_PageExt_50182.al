pageextension 50182 PurchRecpLine extends "Purch. Receipt Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Airway Bill No."; AirwayBillNo)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetRecord()
    var
        PWSRline: Record "Posted Whse. Receipt Line";
        PWSRHeader: Record "Posted Whse. Receipt Header";
    begin
        if Rec."Order No." <> '' then begin
            Clear(AirwayBillNo);
            Clear(PWSRline);
            PWSRline.SetRange("Source Document", PWSRline."Source Document"::"Purchase Order");
            PWSRline.SetRange("Source No.", Rec."Order No.");
            if PWSRline.FindFirst() then begin
                Clear(PWSRHeader);
                PWSRHeader.SetRange("No.", PWSRline."No.");
                if PWSRHeader.FindFirst() then begin
                    AirwayBillNo := PWSRHeader."Airway Bill No.";
                end;
            end;
        end;
    end;

    var
        AirwayBillNo: Text;
}




