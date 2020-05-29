
pageextension 50161 MyExtension extends "Posted Sales Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Vendor Article No"; "Vendor Article No")
            {
                ApplicationArea = All;
                Enabled = false;
            }
        }

        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
            }
            field("Description 3"; "Description 3")
            {
                ApplicationArea = All;
            }
        }
        addafter(Quantity)
        {
            field("HL Type"; "HL Line Type")
            {
                ApplicationArea = All;
                Caption = 'Ref Type';
            }
            field(Brand; Brand)
            {
                ApplicationArea = All;
                Enabled = false;
            }


            field("HL_Purchase Order No."; "HL_Purchase Order No.")
            {
                ApplicationArea = All;
                Enabled = false;
                Caption = 'Purchase Order No.';
                Visible = false;
            }
            field("PO Qty"; "PO Qty")
            {
                ApplicationArea = All;
                Enabled = false;
                Caption = 'Purchase Order Quanity';
                Visible = false;
            }
            field("Sales Order No."; "Sales Order No.")
            {
                ApplicationArea = All;
            }

            field("PO Line No."; "PO Line No.")
            {
                ApplicationArea = All;
                Enabled = false;
                Caption = 'Purchase Order Line No.';
                Visible = false;
            }
            field("VAT Prod. Posting Group_"; "VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'VAT Prod. Posting Group';
            }
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        addafter(Quantity)
        {
            field("Warranty Date"; "Warranty Date")
            {
                ApplicationArea = All;
                Enabled = false;
            }
        }
        addafter("Line Amount")
        {
            field("Inv. Discount Amount"; "Inv. Discount Amount")
            {
                ApplicationArea = All;
            }
            field("Estimated Cost"; "Estimated Cost")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Estimated GP"; "Estimated GP")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Line")
        {
            action("Update Sales Order No.")
            {
                ApplicationArea = All;
                Image = UpdateDescription;
                trigger OnAction()
                var
                    updatesalesOrderNo: Report "Update SO In Posted Sales Line";
                begin
                    Clear(updatesalesOrderNo);
                    updatesalesOrderNo.SetSalesInvNo(Rec."Document No.");
                    updatesalesOrderNo.Run();
                end;
            }
        }
    }

    var
        myInt: Integer;
}
