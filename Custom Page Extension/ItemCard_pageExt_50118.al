pageextension 50118 ItemCard extends "Item Card"
{
    layout
    {
        // Add changes to page layout here
        addlast(Item)
        {
            field("Created By"; "Created By")
            {
                ApplicationArea = All;
                Enabled = false;
            }
        }


        addafter("No.")
        {
            field("Vendor Article No"; "Vendor Article No")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin

                    if ("No." <> '') AND ("Vendor Article No" <> '') then
                        FieldEnable := True
                    else
                        FieldEnable := false;
                end;
            }
            field(Brand; Brand)
            {
                ApplicationArea = All;
                Enabled = FieldEnable;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    // CurrPage.Update();
                    // AfterBrandValidate;
                    // Rec.SetBrandFlag();
                    //  CurrPage.Update();
                end;
            }

        }
        moveafter("Vendor Article No"; Type)
        moveafter(Type; "Vendor No.")
        modify(Reserve)
        {
            //Visible = false;
            Enabled = FieldEnable;
        }
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
                Enabled = FieldEnable;
            }
            field("Description 3"; "Description 3")
            {
                ApplicationArea = All;
                Enabled = FieldEnable;
            }
        }
        addafter("Qty. on Asm. Component")
        {
            field("Reserved Qty. on Inventory"; "Reserved Qty. on Inventory")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Reserved Qty. on Purch. Orders"; "Reserved Qty. on Purch. Orders")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Reserved Qty. on Sales Orders"; "Reserved Qty. on Sales Orders")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Available Items"; "Available Items")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }


        modify("Common Item No.")
        {
            Enabled = false;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                if ("No." <> '') AND ("Vendor Article No" <> '') then
                    FieldEnable := True
                else
                    FieldEnable := false;
            end;
        }
        modify(Description)
        {
            Enabled = FieldEnable;
        }


        modify("Use Cross-Docking")
        {
            Enabled = FieldEnable;
        }
        modify("Identifier Code")
        {
            Enabled = FieldEnable;
        }
        modify("Next Counting Start Date")
        {
            Enabled = FieldEnable;
        }
        modify("Next Counting End Date")
        {
            Enabled = FieldEnable;
        }
        modify("Last Counting Period Update")
        {
            Enabled = FieldEnable;
        }
        modify("Last Phys. Invt. Date")
        {
            Enabled = FieldEnable;
        }
        modify("Phys Invt Counting Period Code")
        {
            Enabled = FieldEnable;
        }
        modify("Put-away Unit of Measure Code")
        {
            Enabled = FieldEnable;
        }
        modify("Put-away Template Code")
        {
            Enabled = FieldEnable;
        }
        modify("Special Equipment Code")
        {
            Enabled = FieldEnable;
        }
        modify("Warehouse Class Code")
        {
            Enabled = FieldEnable;
        }
        modify("Expiration Calculation")
        {
            Enabled = FieldEnable;
        }
        modify("Lot Nos.")
        {
            Enabled = FieldEnable;
        }
        modify("Serial Nos.")
        {
            Enabled = FieldEnable;
        }
        modify("Item Tracking Code")
        {
            Enabled = FieldEnable;
        }
        modify("Order Multiple")
        {
            Enabled = FieldEnable;
        }
        modify("Minimum Order Quantity")
        {
            Enabled = FieldEnable;
        }
        modify("Time Bucket")
        {
            Enabled = FieldEnable;
        }
        modify("Overflow Level")
        {
            Enabled = FieldEnable;
        }
        modify("Maximum Inventory")
        {
            Enabled = FieldEnable;
        }
        modify("Reorder Point")
        {
            Enabled = FieldEnable;
        }
        modify("Rescheduling Period")
        {
            Enabled = FieldEnable;
        }
        modify("Lot Accumulation Period")
        {
            Enabled = FieldEnable;
        }
        modify("Include Inventory")
        {
            Enabled = FieldEnable;
        }
        modify("Safety Stock Quantity")
        {
            Enabled = FieldEnable;
        }
        modify("Safety Lead Time")
        {
            Enabled = FieldEnable;
        }
        modify(Critical)
        {
            Enabled = FieldEnable;
        }
        modify("Dampener Quantity")
        {
            Enabled = FieldEnable;
        }
        modify("Dampener Period")
        {
            Enabled = FieldEnable;
        }
        modify("Stockkeeping Unit Exists")
        {
            Enabled = FieldEnable;
        }
        modify("Order Tracking Policy")
        {
            Enabled = FieldEnable;
        }
        modify("Reordering Policy")
        {
            Enabled = FieldEnable;
        }
        modify("Assembly Policy")
        {
            Enabled = FieldEnable;
        }
        modify("AssemblyBOM")
        {
            Enabled = FieldEnable;
        }

        modify("Lot Size")
        {
            Enabled = FieldEnable;
        }
        modify("Scrap %")
        {
            Enabled = FieldEnable;
        }
        modify("Overhead Rate")
        {
            Enabled = FieldEnable;
        }
        modify("Flushing Method")
        {
            Enabled = FieldEnable;
        }
        modify("Rounding Precision")
        {
            Enabled = FieldEnable;
        }
        modify("Production BOM No.")
        {
            Enabled = FieldEnable;
        }
        modify("Routing No.")
        {
            Enabled = FieldEnable;
        }
        modify("Manufacturing Policy")
        {
            Enabled = FieldEnable;
        }
        modify("Purchasing Blocked")
        {
            Enabled = FieldEnable;
        }
        modify("Purch. Unit of Measure")
        {
            Enabled = FieldEnable;
        }
        modify("Vendor Item No.")
        {
            Enabled = FieldEnable;
        }
        modify("Vendor No.")
        {
            Enabled = FieldEnable;
            //Visible = false;
        }
        //  moveafter(Type; "Vendor No.")
        modify("Lead Time Calculation")
        {
            Enabled = FieldEnable;
        }
        modify("Replenishment System")
        {
            Enabled = FieldEnable;
        }
        modify("VAT Bus. Posting Gr. (Price)")
        {
            Enabled = FieldEnable;
        }
        modify("Application Wksh. User ID")
        {
            Enabled = FieldEnable;
        }
        modify("Sales Blocked")
        {
            Enabled = FieldEnable;
        }
        modify("Sales Unit of Measure")
        {
            Enabled = FieldEnable;
        }
        modify("Item Disc. Group")
        {
            Enabled = FieldEnable;
        }
        modify("Allow Invoice Disc.")
        {
            Enabled = FieldEnable;
        }
        modify(SpecialPurchPricesAndDiscountsTxt)
        {
            Enabled = FieldEnable;
        }
        modify("Profit %")
        {
            Enabled = FieldEnable;
        }
        modify("Price/Profit Calculation")
        {
            Enabled = FieldEnable;
        }
        modify("Price Includes VAT")
        {
            Enabled = FieldEnable;
        }
        modify(CalcUnitPriceExclVAT)
        {
            Enabled = FieldEnable;
        }
        modify("Unit Price")
        {
            Enabled = FieldEnable;
        }
        modify("Country/Region of Origin Code")
        {
            Enabled = FieldEnable;
        }
        modify("Tariff No.")
        {
            Enabled = FieldEnable;
        }
        modify("Default Deferral Template Code")
        {
            Enabled = FieldEnable;
        }
        modify("Inventory Posting Group")
        {
            Enabled = FieldEnable;
        }
        modify("VAT Prod. Posting Group")
        {
            Enabled = FieldEnable;
        }
        modify("Gen. Prod. Posting Group")
        {
            Enabled = FieldEnable;
        }
        modify(SpecialPricesAndDiscountsTxt)
        {
            Enabled = FieldEnable;
        }
        modify("Cost is Posted to G/L")
        {
            Enabled = FieldEnable;
        }
        modify("Cost is Adjusted")
        {
            Enabled = FieldEnable;
        }
        modify("Net Invoiced Qty.")
        {
            Enabled = FieldEnable;
        }
        modify("Last Direct Cost")
        {
            Enabled = FieldEnable;
        }
        modify("Indirect Cost %")
        {
            Enabled = FieldEnable;
        }
        modify("Unit Cost")
        {
            Enabled = FieldEnable;
        }
        modify("Standard Cost")
        {
            Enabled = FieldEnable;
        }
        modify("Costing Method")
        {
            Enabled = FieldEnable;
        }
        modify("Cost Details")
        {
            Enabled = FieldEnable;
        }
        modify("Costs & Posting")
        {
            Enabled = FieldEnable;
        }
        modify("Unit Volume")
        {
            Enabled = FieldEnable;
        }
        modify("Gross Weight")
        {
            Enabled = FieldEnable;
        }
        modify("Net Weight")
        {
            Enabled = FieldEnable;
        }
        modify(PreventNegInventoryDefaultNo)
        {
            Enabled = FieldEnable;
        }
        modify(PreventNegInventoryDefaultYes)
        {
            Enabled = FieldEnable;
        }
        modify(StockoutWarningDefaultYes)
        {
            Enabled = FieldEnable;
        }
        modify(StockoutWarningDefaultNo)
        {
            Enabled = FieldEnable;
        }
        modify("Qty. on Asm. Component")
        {
            Enabled = FieldEnable;
        }
        modify("Qty. on Assembly Order")
        {
            Enabled = FieldEnable;
        }
        modify("Qty. on Sales Order")
        {
            Enabled = FieldEnable;
        }
        modify("Qty. on Component Lines")
        {
            Enabled = FieldEnable;
        }
        modify("Qty. on Prod. Order")
        {
            Enabled = FieldEnable;
        }
        modify("Qty. on Purch. Order")
        {
            Enabled = FieldEnable;
        }
        modify("Qty. on Job Order")
        {
            Enabled = FieldEnable;
        }
        modify(InventoryNonFoundation)
        {
            Enabled = FieldEnable;
        }
        modify(Inventory)
        {
            Enabled = FieldEnable;
        }
        modify("Search Description")
        {
            Enabled = FieldEnable;
        }
        modify("Created From Nonstock Item")
        {
            Enabled = FieldEnable;
        }
        modify("Shelf No.")
        {
            Enabled = FieldEnable;
        }
        modify("Automatic Ext. Texts")
        {
            Enabled = FieldEnable;
            Visible = false;
        }
        modify("Service Item Group")
        {
            Enabled = FieldEnable;
        }
        modify("Item Category Code")
        {
            Enabled = FieldEnable;
        }
        modify(GTIN)
        {
            Enabled = FieldEnable;
            Visible = false;
        }
        modify("Last Date Modified")
        {
            Enabled = FieldEnable;
        }
        modify("Base Unit of Measure")
        {
            Enabled = FieldEnable;
        }
        modify(Type)
        {
            Enabled = FieldEnable;
        }
        // modify("Purchasing Code")
        // {
        //     Visible = false;
        // }
        // moveafter("Vendor Article No"; Type)
        modify(Blocked)
        {
            Enabled = FieldEnable;
        }



    }

    actions
    {
        // Add changes to page actions here
    }

    var
        FieldEnable: Boolean;



    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if ("No." <> '') AND ("Vendor Article No" <> '') then
            FieldEnable := true
        else
            FieldEnable := false;
    end;

    trigger OnModifyRecord(): Boolean
    var
        myInt: Integer;
    begin
    end;


    procedure AfterBrandValidate()
    var
        RecItemBrand: Record "Item Brands";
        RecDefaultDim: Record "Default Dimension";
        InvtSetup: Record "Inventory Setup";
        VendorBrands: Record "Vendor Brand Master";
    begin
        if "No." = '' then
            exit;
        InvtSetup.GET;
        if Rec.Brand <> '' then begin
            Clear(RecItemBrand);
            RecItemBrand.SetRange(Code, Rec.Brand);
            if RecItemBrand.FindFirst() then begin
                RecItemBrand.TestField("Brand Dimesnion");
                RecDefaultDim.Reset();
                RecDefaultDim.SetRange("Table ID", Database::Item);
                RecDefaultDim.SetRange("No.", Rec."No.");
                RecDefaultDim.SetRange("Dimension Code", InvtSetup."Brand Dimension");
                If not RecDefaultDim.FindFirst() then begin
                    RecDefaultDim.Init();
                    RecDefaultDim.Validate("Table ID", Database::Item);
                    RecDefaultDim.Validate("No.", Rec."No.");
                    RecDefaultDim.Validate("Dimension Code", InvtSetup."Brand Dimension");
                    RecDefaultDim.Validate("Dimension Value Code", RecItemBrand."Brand Dimesnion");
                    RecDefaultDim.Validate("Value Posting", RecDefaultDim."Value Posting"::"Same Code");
                    RecDefaultDim.Insert(true);
                end else begin
                    RecDefaultDim.Validate("Dimension Value Code", RecItemBrand."Brand Dimesnion");
                    RecDefaultDim.Validate("Value Posting", RecDefaultDim."Value Posting"::"Same Code");
                    RecDefaultDim.Modify(true);
                end;
            end;
        end else begin
            RecDefaultDim.Reset();
            RecDefaultDim.SetRange("Table ID", Database::Item);
            RecDefaultDim.SetRange("No.", "No.");
            RecDefaultDim.SetRange("Dimension Code", InvtSetup."Brand Dimension");
            if RecDefaultDim.FindFirst() then
                RecDefaultDim.Delete();
        end;
        ///  CurrPage.SaveRecord();
    end;
}