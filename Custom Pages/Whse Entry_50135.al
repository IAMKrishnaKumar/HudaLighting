page 50135 "Whse Entry"
{
    PageType = List;
    SourceTable = 7312;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                }
                field("Registering Date"; "Registering Date")
                {
                    ApplicationArea = All;
                }
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
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Qty. (Base)"; "Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; "Source Type")
                {
                    ApplicationArea = All;
                }
                field("Source Subtype"; "Source Subtype")
                {
                    ApplicationArea = All;
                }
                field("Source No."; "Source No.")
                {
                    ApplicationArea = All;
                }
                field("Source Line No."; "Source Line No.")
                {
                    ApplicationArea = All;
                }
                field("Source Subline No."; "Source Subline No.")
                {
                    ApplicationArea = All;
                }
                field("Source Document"; "Source Document")
                {
                    ApplicationArea = All;
                }
                field("Source Code"; "Source Code")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; "Reason Code")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; "No. Series")
                {
                    ApplicationArea = All;
                }
                field("Bin Type Code"; "Bin Type Code")
                {
                    ApplicationArea = All;
                }
                field(Cubage; Cubage)
                {
                    ApplicationArea = All;
                }
                field(Weight; Weight)
                {
                    ApplicationArea = All;
                }
                field("Journal Template Name"; "Journal Template Name")
                {
                    ApplicationArea = All;
                }
                field("Whse. Document No."; "Whse. Document No.")
                {
                    ApplicationArea = All;
                }
                field("Whse. Document Type"; "Whse. Document Type")
                {
                    ApplicationArea = All;
                }
                field("Whse. Document Line No."; "Whse. Document Line No.")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; "Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Reference Document"; "Reference Document")
                {
                    ApplicationArea = All;
                }
                field("Reference No."; "Reference No.")
                {
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
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
                field("Serial No."; "Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Warranty Date"; "Warranty Date")
                {
                    ApplicationArea = All;
                }
                field("Expiration Date"; "Expiration Date")
                {
                    ApplicationArea = All;
                }
                field("Phys Invt Counting Period Code"; "Phys Invt Counting Period Code")
                {
                    ApplicationArea = All;
                }
                field("Phys Invt Counting Period Type"; "Phys Invt Counting Period Type")
                {
                    ApplicationArea = All;
                }
                field(Dedicated; Dedicated)
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
                    DeleteBin: Report 50148;
                begin
                    DeleteBin.Run();
                end;
            }
        }
    }

}

