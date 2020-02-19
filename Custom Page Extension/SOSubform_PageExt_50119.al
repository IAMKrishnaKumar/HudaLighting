pageextension 50119 SoSubForm extends "Sales Order Subform"
{
    layout
    {
        // Add changes to page layout here

        modify("Qty. to Assemble to Order")
        {
            Visible = false;
        }
        addafter("VAT Prod. Posting Group")
        {
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
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
            field("Vendor Article No"; "Vendor Article No")
            {
                ApplicationArea = All;
                Enabled = false;
            }
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
        }
        modify(ShortcutDimCode5)
        {
            Visible = false;
        }
        modify(ShortcutDimCode6)
        {
            Visible = false;
        }
        addbefore("Qty. to Ship")
        {
            field("Estimated Cost"; "Estimated Cost")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Estimated GP"; "Estimated GP")
            {
                ApplicationArea = All;
                Enabled = false;
                Visible = false;
            }
            field("VAT Prod. Posting Group_"; "VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'VAT Prod. Posting Group';
            }

        }
        addlast(Control1)
        {
            field("Outstanding Quantity"; "Outstanding Quantity")
            {
                ApplicationArea = All;
            }
            field("Outstanding Amount"; "Outstanding Amount")
            {
                ApplicationArea = All;
            }
            field("Outstanding Amount (LCY)"; "Outstanding Amount (LCY)")
            {
                ApplicationArea = All;
            }
            field("Outstanding Qty. (Base)"; "Outstanding Qty. (Base)")
            {
                ApplicationArea = All;
            }
        }
        modify("Invoice Discount Amount")
        {
            trigger OnAfterValidate()
            begin
                UpdatePaymentMileStone();
            end;
        }
        modify("Invoice Disc. Pct.")
        {
            trigger OnAfterValidate()
            begin
                UpdatePaymentMileStone();
            end;
        }

    }

    actions
    {
        // Add changes to page actions here
        addafter("O&rder")
        {
            action("Refresh Item Details")
            {
                ApplicationArea = All;
                Image = RefreshLines;
                trigger OnAction()
                var
                    RecItem: Record Item;
                    Sline: Record "Sales Line";
                begin
                    Clear(RecItem);
                    Clear(Sline);
                    Sline.SetRange("Document Type", "Document Type"::Order);
                    Sline.SetRange("Document No.", Rec."Document No.");
                    Sline.SetRange(Type, Type::Item);
                    Sline.SetFilter("No.", '<>%1', '');
                    if Sline.FindSet() then
                        repeat
                            Clear(RecItem);
                            if RecItem.GET(Sline."No.") then begin
                                Sline."Vendor Article No" := RecItem."Vendor Article No";
                                Sline.Description := RecItem.Description;
                                Sline."Description 2" := RecItem."Description 2";
                                Sline."Description 3" := RecItem."Description 3";
                                Sline.Brand := RecItem.Brand;
                                Sline.Modify(true);
                            end;
                        until Sline.Next() = 0;
                end;
            }
        }
    }



    procedure UpdatePaymentMileStone()
    var
        RecPaymentMileStone: Record "Payment Milestone";
        RecSheader: Record "Sales Header";

    begin
        if ("Document Type" <> "Document Type"::Order) AND ("Document Type" <> "Document Type"::Invoice) then
            exit;
        Clear(RecPaymentMileStone);
        Clear(RecSheader);
        RecSheader.SetRange("Document Type", "Document Type");
        RecSheader.SetRange("No.", "Document No.");
        if RecSheader.FindFirst() then;
        RecSheader.CalcFields(Amount);
        RecPaymentMileStone.SetRange("Document Type", "Document Type");
        RecPaymentMileStone.SetRange("Document No.", "Document No.");
        if RecPaymentMileStone.FindSet() then begin
            repeat
                RecPaymentMileStone.Validate("Currency Factor", RecSheader."Currency Factor");
                RecPaymentMileStone.Validate("Total Value", RecSheader.Amount);
                RecPaymentMileStone.Validate(Amount, (RecSheader.Amount * RecPaymentMileStone."Milestone %") / 100);
                RecPaymentMileStone.Modify();
            until RecPaymentMileStone.Next() = 0;
        end;
    end;

    var
        myInt: Integer;
}