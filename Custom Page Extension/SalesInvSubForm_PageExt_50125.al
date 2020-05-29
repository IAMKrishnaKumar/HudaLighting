pageextension 50125 SaleInvSubForm extends "Sales Invoice Subform"
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
        modify(ShortcutDimCode5)
        {
            Visible = false;
        }
        modify(ShortcutDimCode6)
        {
            Visible = false;
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
            field("Sales Order No."; "Sales Order No.")
            {
                ApplicationArea = All;
                Enabled = true;
            }

            field("Purchase Order No"; "HL_Purchase Order No.")
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
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        addafter("Qty. Assigned")
        {
            field("Warranty Date"; "Warranty Date")
            {
                ApplicationArea = All;
                Enabled = false;
            }
        }
        addafter("Line Amount")
        {
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
        modify("Invoice Disc. Pct.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                UpdatePaymentMilestone();
            end;
        }
        modify("Invoice Discount Amount")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                UpdatePaymentMilestone();
            end;
        }
    }

    actions
    {
        // Shifted this code in Event codeunit.
        //
        modify(GetShipmentLines)
        {
            //  trigger OnBeforeAction()
            trigger OnAfterAction()
            var
                Sheader: Record "Sales Header";
                Sline: Record "Sales Line";
                SalesOrderHeader: Record "Sales Header";
            begin
                Clear(Sline);
                Sline.SetRange("Document Type", "Document Type"::Invoice);
                Sline.SetRange("Document No.", "Document No.");
                Sline.SetFilter("Sales Order No.", '<>%1', '');
                if Sline.FindFirst() then begin
                    Clear(SalesOrderHeader);
                    SalesOrderHeader.SetRange("Document Type", "Document Type"::Order);
                    SalesOrderHeader.SetRange("No.", Sline."Sales Order No.");
                    if SalesOrderHeader.FindFirst() then begin
                        Clear(Sheader);
                        Sheader.SetRange("Document Type", "Document Type"::Invoice);
                        Sheader.SetRange("No.", Rec."Document No.");
                        if Sheader.FindFirst() then begin
                            Sheader.SetHideValidationDialog(true);
                            Sheader.Validate("Shortcut Dimension 1 Code", SalesOrderHeader."Shortcut Dimension 1 Code");
                            Sheader.Validate("Dimension Set ID", SalesOrderHeader."Dimension Set ID");
                            Sheader.Modify();
                            // if Sheader.Ship then
                            //      Error('Shipment lines are already exists.');

                        end;
                    end;

                end;

            end;
        }
    }

    var
        myInt: Integer;
}
