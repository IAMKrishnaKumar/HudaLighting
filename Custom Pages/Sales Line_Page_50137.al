page 50137 "Sales Line Subform"
{
    PageType = List;
    SourceTable = 37;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTableView = sorting("Document No.") where("Document Type" = const(Order));
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Group"; "Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; "Outstanding Quantity")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Invoice"; "Qty. to Invoice")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Ship"; "Qty. to Ship")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("VAT %"; "VAT %")
                {
                    ApplicationArea = All;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; "Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; "Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; "Net Weight")
                {
                    ApplicationArea = All;
                }
                field("Units per Parcel"; "Units per Parcel")
                {
                    ApplicationArea = All;
                }
                field("Unit Volume"; "Unit Volume")
                {
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; "Appl.-to Item Entry")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Price Group"; "Customer Price Group")
                {
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                }
                field("Work Type Code"; "Work Type Code")
                {
                    ApplicationArea = All;
                }
                field("Recalculate Invoice Disc."; "Recalculate Invoice Disc.")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount"; "Outstanding Amount")
                {
                    ApplicationArea = All;
                }
                field("Qty. Shipped Not Invoiced"; "Qty. Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Shipped Not Invoiced"; "Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; "Quantity Shipped")
                {
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; "Quantity Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Shipment No."; "Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Line No."; "Shipment Line No.")
                {
                    ApplicationArea = All;
                }
                field("Profit %"; "Profit %")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Inv. Discount Amount"; "Inv. Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order No."; "Purchase Order No.")
                {
                    ApplicationArea = All;
                }
                field("Purch. Order Line No."; "Purch. Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Drop Shipment"; "Drop Shipment")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Calculation Type"; "VAT Calculation Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; "Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Attached to Line No."; "Attached to Line No.")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; "Exit Point")
                {
                    ApplicationArea = All;
                }
                field("Area"; "Area")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; "Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Tax Category"; "Tax Category")
                {
                    ApplicationArea = All;
                }
                field("Tax Area Code"; "Tax Area Code")
                {
                    ApplicationArea = All;
                }
                field("Tax Liable"; "Tax Liable")
                {
                    ApplicationArea = All;
                }
                field("Tax Group Code"; "Tax Group Code")
                {
                    ApplicationArea = All;
                }
                field("VAT Clause Code"; "VAT Clause Code")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Shipped Not Inv. (LCY) No VAT"; "Shipped Not Inv. (LCY) No VAT")
                {
                    ApplicationArea = All;
                }
                field("Reserved Quantity"; "Reserved Quantity")
                {
                    ApplicationArea = All;
                }
                field(Reserve; Reserve)
                {
                    ApplicationArea = All;
                }
                field("Blanket Order No."; "Blanket Order No.")
                {
                    ApplicationArea = All;
                }
                field("Blanket Order Line No."; "Blanket Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("VAT Base Amount"; "VAT Base Amount")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; "Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("System-Created Entry"; "System-Created Entry")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; "Line Amount")
                {
                    ApplicationArea = All;
                }
                field("VAT Difference"; "VAT Difference")
                {
                    ApplicationArea = All;
                }
                field("Inv. Disc. Amount to Invoice"; "Inv. Disc. Amount to Invoice")
                {
                    ApplicationArea = All;
                }
                field("VAT Identifier"; "VAT Identifier")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Ref. Type"; "IC Partner Ref. Type")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Reference"; "IC Partner Reference")
                {
                    ApplicationArea = All;
                }
                field("Prepayment %"; "Prepayment %")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Line Amount"; "Prepmt. Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Amt. Inv."; "Prepmt. Amt. Inv.")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Amt. Incl. VAT"; "Prepmt. Amt. Incl. VAT")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Amount"; "Prepayment Amount")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. VAT Base Amt."; "Prepmt. VAT Base Amt.")
                {
                    ApplicationArea = All;
                }
                field("Prepayment VAT %"; "Prepayment VAT %")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. VAT Calc. Type"; "Prepmt. VAT Calc. Type")
                {
                    ApplicationArea = All;
                }
                field("Prepayment VAT Identifier"; "Prepayment VAT Identifier")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Tax Area Code"; "Prepayment Tax Area Code")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Tax Liable"; "Prepayment Tax Liable")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Tax Group Code"; "Prepayment Tax Group Code")
                {
                    ApplicationArea = All;
                }
                field("Prepmt Amt to Deduct"; "Prepmt Amt to Deduct")
                {
                    ApplicationArea = All;
                }
                field("Prepmt Amt Deducted"; "Prepmt Amt Deducted")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Line"; "Prepayment Line")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Amount Inv. Incl. VAT"; "Prepmt. Amount Inv. Incl. VAT")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Amount Inv. (LCY)"; "Prepmt. Amount Inv. (LCY)")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Code"; "IC Partner Code")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. VAT Amount Inv. (LCY)"; "Prepmt. VAT Amount Inv. (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Prepayment VAT Difference"; "Prepayment VAT Difference")
                {
                    ApplicationArea = All;
                }
                field("Prepmt VAT Diff. to Deduct"; "Prepmt VAT Diff. to Deduct")
                {
                    ApplicationArea = All;
                }
                field("Prepmt VAT Diff. Deducted"; "Prepmt VAT Diff. Deducted")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Amount"; "Pmt. Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Line Discount Calculation"; "Line Discount Calculation")
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; "Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Assemble to Order"; "Qty. to Assemble to Order")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Asm. to Order (Base)"; "Qty. to Asm. to Order (Base)")
                {
                    ApplicationArea = All;
                }
                field("ATO Whse. Outstanding Qty."; "ATO Whse. Outstanding Qty.")
                {
                    ApplicationArea = All;
                }
                field("ATO Whse. Outstd. Qty. (Base)"; "ATO Whse. Outstd. Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = All;
                }
                field("Job Contract Entry No."; "Job Contract Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Deferral Code"; "Deferral Code")
                {
                    ApplicationArea = All;
                }
                field("Returns Deferral Start Date"; "Returns Deferral Start Date")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; "Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; "Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; "Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Planned; Planned)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; "Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Qty. (Base)"; "Outstanding Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Invoice (Base)"; "Qty. to Invoice (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Ship (Base)"; "Qty. to Ship (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Shipped Not Invd. (Base)"; "Qty. Shipped Not Invd. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Shipped (Base)"; "Qty. Shipped (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Invoiced (Base)"; "Qty. Invoiced (Base)")
                {
                    ApplicationArea = All;
                }
                field("Reserved Qty. (Base)"; "Reserved Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("FA Posting Date"; "FA Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Depreciation Book Code"; "Depreciation Book Code")
                {
                    ApplicationArea = All;
                }
                field("Depr. until FA Posting Date"; "Depr. until FA Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Duplicate in Depreciation Book"; "Duplicate in Depreciation Book")
                {
                    ApplicationArea = All;
                }
                field("Use Duplication List"; "Use Duplication List")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Out-of-Stock Substitution"; "Out-of-Stock Substitution")
                {
                    ApplicationArea = All;
                }
                field("Substitution Available"; "Substitution Available")
                {
                    ApplicationArea = All;
                }
                field("Originally Ordered No."; "Originally Ordered No.")
                {
                    ApplicationArea = All;
                }
                field("Originally Ordered Var. Code"; "Originally Ordered Var. Code")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference No."; "Cross-Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure (Cross Ref.)"; "Unit of Measure (Cross Ref.)")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference Type"; "Cross-Reference Type")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference Type No."; "Cross-Reference Type No.")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; "Item Category Code")
                {
                    ApplicationArea = All;
                }
                field(Nonstock; Nonstock)
                {
                    ApplicationArea = All;
                }
                field("Purchasing Code"; "Purchasing Code")
                {
                    ApplicationArea = All;
                }
                field("Special Order"; "Special Order")
                {
                    ApplicationArea = All;
                }
                field("Special Order Purchase No."; "Special Order Purchase No.")
                {
                    ApplicationArea = All;
                }
                field("Special Order Purch. Line No."; "Special Order Purch. Line No.")
                {
                    ApplicationArea = All;
                }
                field("Whse. Outstanding Qty."; "Whse. Outstanding Qty.")
                {
                    ApplicationArea = All;
                }
                field("Whse. Outstanding Qty. (Base)"; "Whse. Outstanding Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Completely Shipped"; "Completely Shipped")
                {
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; "Requested Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Promised Delivery Date"; "Promised Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Shipping Time"; "Shipping Time")
                {
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; "Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                }
                field("Planned Delivery Date"; "Planned Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Planned Shipment Date"; "Planned Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Service Code"; "Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                }
                field("Allow Item Charge Assignment"; "Allow Item Charge Assignment")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Assign"; "Qty. to Assign")
                {
                    ApplicationArea = All;
                }
                field("Qty. Assigned"; "Qty. Assigned")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. to Receive"; "Return Qty. to Receive")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. to Receive (Base)"; "Return Qty. to Receive (Base)")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. Rcd. Not Invd."; "Return Qty. Rcd. Not Invd.")
                {
                    ApplicationArea = All;
                }
                field("Ret. Qty. Rcd. Not Invd.(Base)"; "Ret. Qty. Rcd. Not Invd.(Base)")
                {
                    ApplicationArea = All;
                }
                field("Return Rcd. Not Invd."; "Return Rcd. Not Invd.")
                {
                    ApplicationArea = All;
                }
                field("Return Rcd. Not Invd. (LCY)"; "Return Rcd. Not Invd. (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. Received"; "Return Qty. Received")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. Received (Base)"; "Return Qty. Received (Base)")
                {
                    ApplicationArea = All;
                }
                field("Appl.-from Item Entry"; "Appl.-from Item Entry")
                {
                    ApplicationArea = All;
                }
                field("BOM Item No."; "BOM Item No.")
                {
                    ApplicationArea = All;
                }
                field("Return Receipt No."; "Return Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Return Receipt Line No."; "Return Receipt Line No.")
                {
                    ApplicationArea = All;
                }
                field("Return Reason Code"; "Return Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Copied From Posted Doc."; "Copied From Posted Doc.")
                {
                    ApplicationArea = All;
                }
                field("Allow Line Disc."; "Allow Line Disc.")
                {
                    ApplicationArea = All;
                }
                field("Customer Disc. Group"; "Customer Disc. Group")
                {
                    ApplicationArea = All;
                }
                field(Subtype; Subtype)
                {
                    ApplicationArea = All;
                }
                field("Price description"; "Price description")
                {
                    ApplicationArea = All;
                }
                field("Attached Doc Count"; "Attached Doc Count")
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
                }
                field("HL Type"; "HL Line Type")
                {
                    ApplicationArea = All;
                    Caption = 'Ref Type';
                }
                field(Brand; Brand)
                {
                    ApplicationArea = All;
                }
                field("Sales Person"; "Sales Person")
                {
                    ApplicationArea = All;
                }
                field("Estimated Cost"; "Estimated Cost")
                {
                    ApplicationArea = All;
                }
                field("Estimated GP"; "Estimated GP")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group_"; "VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Caption = 'VAT Prod. Posting Group';
                }
                field("Unit Estimated Cost"; "Unit Estimated Cost")
                {
                    ApplicationArea = All;
                }
                field("Estimated Cost Of Outs. qty"; "Estimated Cost Of Outs. qty")
                {
                    ApplicationArea = All;
                }

                field("Outstanding Amount (LCY)"; "Outstanding Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("UE Sales"; "UE Sales")
                {
                    ApplicationArea = All;
                }
                field("ACY UE Sales"; "ACY UE Sales")
                {
                    ApplicationArea = All;
                }
                field("UE GP"; "UE GP")
                {
                    ApplicationArea = All;
                }
                field("ACY UE GP"; "ACY UE GP")
                {
                    ApplicationArea = All;
                }
                field("Non Stock Invoiced"; "Non Stock Invoiced")
                {
                    ApplicationArea = All;
                }
                field("G/L Invoiced"; "G/L Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Shipped Not Invoiced (LCY)"; "Shipped Not Invoiced (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Amount Shipped Not Inv. (ACY)"; "Amount Shipped Not Inv. (ACY)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Update ACY Amounts")
            {
                ApplicationArea = All;
                Image = UpdateUnitCost;
                trigger OnAction()
                VAR
                    Sline: Record "Sales Line";
                begin
                    Sline.SetRange("Document Type", Sline."Document Type"::Order);
                    Sline.SetFilter("Document No.", '<>%1', '');
                    if Sline.FindSet() then begin
                        if not Confirm('Are you sure you want to update ACY UE Sales and ACY UE GP Fields', false) then
                            exit;
                        repeat
                            Sline.UpdateAEDAmounts();
                            Sline.Modify();
                        until Sline.Next() = 0;
                    end;
                end;
            }
            action("Update SalesPerson Share Falg")
            {
                ApplicationArea = All;
                Image = Trace;
                trigger OnAction()
                VAR
                    SHeader: Record "Sales Header";
                    RecSalesPersonShare: Record "Sales Person Main";
                begin
                    if not Confirm('Are you sure you want to update Sales Person Share flag ?', false) then
                        exit;
                    Clear(SHeader);
                    SHeader.SetRange("Document Type", SHeader."Document Type"::Order);
                    SHeader.SetFilter("Shortcut Dimension 1 Code", '<>%1', '');
                    if SHeader.FindSet() then begin
                        repeat
                            Clear(RecSalesPersonShare);
                            RecSalesPersonShare.SetRange("Opportunity No", "Shortcut Dimension 1 Code");
                            if RecSalesPersonShare.FindFirst() then
                                SHeader."Sales Person Share" := true
                            else
                                SHeader."Sales Person Share" := false;
                            SHeader.Modify();
                        until SHeader.Next() = 0;
                        Message('Process Completed.');
                    end;
                end;
            }
            action("Update Order No.")
            {
                ApplicationArea = All;
                Image = UpdateDescription;
                trigger OnAction()
                var
                    RecSline: Record "Sales Line";
                    RecSline2: Record "Sales Line";
                begin
                    Clear(RecSline);
                    RecSline.SetRange("Document Type", RecSline."Document Type"::Invoice);
                    RecSline.SetFilter("Document No.", '<>%1', '');
                    RecSline.SetFilter("Sales Order No.", '=%1', '');
                    if RecSline.FindSet() then begin
                        if not Confirm('Are you sure you want to update Sales Order No.?', false) then
                            exit;
                        repeat
                            Clear(RecSline2);
                            RecSline2.SetRange("Document Type", "Document Type"::Invoice);
                            RecSline2.SetRange("Document No.", RecSline."Document No.");
                            RecSline2.SetFilter("Sales Order No.", '<>%1', '');
                            if RecSline2.FindFirst() then begin
                                RecSline."Sales Order No." := RecSline2."Sales Order No.";
                                RecSline.Modify();
                            end;
                        until RecSline.Next() = 0;
                        Message('Process Completed.');
                    end;
                end;
            }
        }

    }
}

