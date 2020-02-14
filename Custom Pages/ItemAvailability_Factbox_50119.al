page 50119 "Item Availability FactBox"
{
    Caption = 'Item Availability Details';
    PageType = CardPart;
    SourceTable = 27;

    layout
    {
        area(content)
        {

            group(Availability)
            {
                Caption = 'Availability';

                field("Item Availability"; SalesInfoPaneMgt.CalcAvailability(Rec."No."))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Availability';
                    DecimalPlaces = 0 : 5;
                    DrillDown = true;
                    ToolTip = 'Specifies how may units of the item on the sales line are available, in inventory or incoming before the shipment date.';

                    trigger OnDrillDown()
                    begin
                        // ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByEvent);
                        //CurrPage.UPDATE(TRUE);
                    end;
                }
                field("Available Inventory"; SalesInfoPaneMgt.CalcAvailableInventory(Rec."No."))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Available Inventory';
                    DecimalPlaces = 0 : 5;
                    ToolTip = 'Specifies the quantity of the item that is currently in inventory and not reserved for other demand.';
                }
                field("Scheduled Receipt"; SalesInfoPaneMgt.CalcScheduledReceipt(Rec."No."))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Scheduled Receipt';
                    DecimalPlaces = 0 : 5;
                    ToolTip = 'Specifies how many units of the assembly component are inbound on purchase orders, transfer orders, assembly orders, firm planned production orders, and released production orders.';
                }
                field("Reserved Receipt"; SalesInfoPaneMgt.CalcReservedRequirements(Rec."No."))
                {
                    ApplicationArea = Reservation;
                    Caption = 'Reserved Receipt';
                    DecimalPlaces = 0 : 5;
                    ToolTip = 'Specifies how many units of the item on the sales line are reserved on incoming receipts.';
                }
                field("Gross Requirements"; SalesInfoPaneMgt.CalcGrossRequirements(Rec."No."))
                {
                    ApplicationArea = Service;
                    Caption = 'Gross Requirements';
                    DecimalPlaces = 0 : 5;
                    ToolTip = 'Specifies, for the item on the sales line, dependent demand plus independent demand. Dependent demand comes production order components of all statuses, assembly order components, and planning lines. Independent demand comes from sales orders, transfer orders, service orders, job tasks, and demand forecasts.';
                }
                field("Reserved Requirements"; SalesInfoPaneMgt.CalcReservedDemand(Rec."No."))
                {
                    ApplicationArea = Reservation;
                    Caption = 'Reserved Requirements';
                    DecimalPlaces = 0 : 5;
                    ToolTip = 'Specifies, for the item on the sales line, how many are reserved on demand records.';
                }
            }
            /*
            group(Item)
            {
                Caption = 'Item';
                field(UnitofMeasureCode; "Unit of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Unit of Measure Code';
                    ToolTip = 'Specifies the unit of measure that is used to determine the value in the Unit Price field on the sales line.';
                }
                field("Qty. per Unit of Measure"; "Qty. per Unit of Measure")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Qty. per Unit of Measure';
                    ToolTip = 'Specifies an auto-filled number if you have included Sales Unit of Measure on the item card and a quantity in the Qty. per Unit of Measure field.';
                }
                field(Substitutions; SalesInfoPaneMgt.CalcNoOfSubstitutions(Rec))
                {
                    ApplicationArea = Suite;
                    Caption = 'Substitutions';
                    DrillDown = true;
                    ToolTip = 'Specifies other items that are set up to be traded instead of the item in case it is not available.';

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD;
                        ShowItemSub;
                        CurrPage.UPDATE(TRUE);
                        AutoReserve;
                    end;
                }
                field(SalesPrices; SalesInfoPaneMgt.CalcNoOfSalesPrices(Rec))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Prices';
                    DrillDown = true;
                    ToolTip = 'Specifies special sales prices that you grant when certain conditions are met, such as customer, quantity, or ending date. The price agreements can be for individual customers, for a group of customers, for all customers or for a campaign.';

                    trigger OnDrillDown()
                    begin
                        ShowPrices;
                        CurrPage.UPDATE;
                    end;
                }
                field(SalesLineDiscounts; SalesInfoPaneMgt.CalcNoOfSalesLineDisc(Rec))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Line Discounts';
                    DrillDown = true;
                    ToolTip = 'Specifies how many special discounts you grant for the sales line. Choose the value to see the sales line discounts.';

                    trigger OnDrillDown()
                    begin
                        ShowLineDisc;
                        CurrPage.UPDATE;
                    end;
                }
            }
            */
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        //  ClearSalesHeader;
    end;

    trigger OnAfterGetRecord()
    begin
        // CALCFIELDS("Reserved Quantity", "Attached Doc Count");
    end;

    var
        SalesHeader: Record 36;
        SalesPriceCalcMgt: Codeunit 7000;
        SalesInfoPaneMgt: Codeunit 50113;
        ItemAvailFormsMgt: Codeunit 353;

    /* local procedure ShowPrices()
     begin
         SalesHeader.GET("Document Type", "Document No.");
         CLEAR(SalesPriceCalcMgt);
         SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
     end;

     local procedure ShowLineDisc()
     begin
         SalesHeader.GET("Document Type", "Document No.");
         CLEAR(SalesPriceCalcMgt);
         SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
     end;

     local procedure ShowNo(): Code[20]
     begin
         IF Type <> Type::Item THEN
             EXIT('');
         EXIT("No.");
     end;*/
}

