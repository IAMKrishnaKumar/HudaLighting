/*page 50119 "Item Availability FactBox"
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

   
}
*/
