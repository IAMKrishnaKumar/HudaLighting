page 50136 "Bin Content List"
{
    PageType = List;
    SourceTable = 7302;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Zone Code"; "Zone Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; "Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field("Bin Type Code"; "Bin Type Code")
                {
                    ApplicationArea = All;
                }
                field("Warehouse Class Code"; "Warehouse Class Code")
                {
                    ApplicationArea = All;
                }
                field("Block Movement"; "Block Movement")
                {
                    ApplicationArea = All;
                }
                field("Min. Qty."; "Min. Qty.")
                {
                    ApplicationArea = All;
                }
                field("Max. Qty."; "Max. Qty.")
                {
                    ApplicationArea = All;
                }
                field("Bin Ranking"; "Bin Ranking")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Pick Qty."; "Pick Qty.")
                {
                    ApplicationArea = All;
                }
                field("Neg. Adjmt. Qty."; "Neg. Adjmt. Qty.")
                {
                    ApplicationArea = All;
                }
                field("Put-away Qty."; "Put-away Qty.")
                {
                    ApplicationArea = All;
                }
                field("Pos. Adjmt. Qty."; "Pos. Adjmt. Qty.")
                {
                    ApplicationArea = All;
                }
                field("Fixed"; "Fixed")
                {
                    ApplicationArea = All;
                }
                field("Cross-Dock Bin"; "Cross-Dock Bin")
                {
                    ApplicationArea = All;
                }
                field(Default; Default)
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; "Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("Pick Quantity (Base)"; "Pick Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("Negative Adjmt. Qty. (Base)"; "Negative Adjmt. Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Put-away Quantity (Base)"; "Put-away Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("Positive Adjmt. Qty. (Base)"; "Positive Adjmt. Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("ATO Components Pick Qty."; "ATO Components Pick Qty.")
                {
                    ApplicationArea = All;
                }
                field("ATO Components Pick Qty (Base)"; "ATO Components Pick Qty (Base)")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; "Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; "Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Lot No. Filter"; "Lot No. Filter")
                {
                    ApplicationArea = All;
                }
                field("Serial No. Filter"; "Serial No. Filter")
                {
                    ApplicationArea = All;
                }
                field(Dedicated; Dedicated)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Filter"; "Unit of Measure Filter")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action("Delete Bin")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    DeleteBin: Report 50145;
                begin
                    DeleteBin.Run();
                end;
            }
        }
    }
}

