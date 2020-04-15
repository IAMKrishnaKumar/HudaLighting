pageextension 50113 PurchOrderSubForm extends "Purchase Order Subform"
{
    layout
    {
        // Add changes to page layout here

        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Pheader: Record "Purchase Header";
            begin
                Clear(Pheader);
                Pheader.SetRange("Document Type", "Document Type"::Order);
                Pheader.SetRange("No.", "Document No.");
                if Pheader.FindFirst() then begin
                    Pheader.TestField("Project Name");
                    Pheader.TestField("Purchaser Code");
                end;
            end;
        }
        addafter("No.")
        {
            field("Vendor Article No"; "Vendor Article No")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Line Amount")
        {
            field("VAT Prod. Posting Group_"; "VAT Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            field("HL Line Type"; "HL Line Type")
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
        addafter("ShortcutDimCode6")
        {
            field("HL Sales Order No."; "HL Sales Order No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("HL Sales Line No."; "HL Sales Line No.")
            {
                ApplicationArea = All;
                Editable = false;
            }

            field(Comments; Comments)
            {
                ApplicationArea = All;
            }
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }

        }
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
                //Enabled = false;
            }
            field("Description 3"; "Description 3")
            {
                ApplicationArea = All;
                //Enabled = false;
            }
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
                    Sline: Record "Purchase Line";
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


    var
        myInt: Integer;
}
