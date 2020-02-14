page 50128 "Logistics Activities"
{
    Caption = 'Logistics Activities', Comment = '{Dependency=Match,"ProfileDescription_PURCHASINGAGENT"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                part("Logistics Activity Cues"; "Logistics Activity Cues")
                {
                    ApplicationArea = Basic, Suite;

                }
                part("Purchase Agent Activities"; "Purchase Agent Activities")
                {
                    ApplicationArea = Basic, Suite;
                }
                part("My Vendors"; "My Vendors")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
            }
            group(Control1900724708)
            {

                part("Inventory Performance"; "Inventory Performance")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                part("Report Inbox Part"; "Report Inbox Part")
                {
                    ApplicationArea = Basic, Suite;
                }
                part("My Job Queue"; "My Job Queue")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                part("My Items"; "My Items")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                systempart(MyNotes; MyNotes)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(embedding)
        {
            action(PurchaseOrders)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Orders';
                RunObject = Page 9307;
                ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action(PurchaseOrdersPendConf)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pending Confirmation';
                RunObject = Page 9307;
                RunPageView = WHERE(Status = FILTER(Open));
                ToolTip = 'View the list of purchase orders that await the vendor''s confirmation. ';
            }
            action(PurchaseOrdersPartDeliv)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Partially Delivered';
                RunObject = Page 9307;
                RunPageView = WHERE(Status = FILTER(Released),
                                    Receive = FILTER(true),
                                    "Completely Received" = FILTER(false));
                ToolTip = 'View the list of purchases that are partially received.';
            }
            action("Purchase Quotes")
            {
                ApplicationArea = Suite;
                Caption = 'Purchase Quotes';
                RunObject = Page 9306;
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            }
            action("Blanket Purchase Orders")
            {
                ApplicationArea = Suite;
                Caption = 'Blanket Purchase Orders';
                RunObject = Page 9310;
                ToolTip = 'Use blanket purchase orders as a framework for a long-term agreement between you and your vendors to buy large quantities that are to be delivered in several smaller shipments over a certain period of time. Blanket orders often cover only one item with predetermined delivery dates. The main reason for using a blanket order rather than a purchase order is that quantities entered on a blanket order do not affect item availability and thus can be used as a worksheet for monitoring, forecasting, and planning purposes..';
            }
            action("Purchase Invoices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Invoices';
                RunObject = Page 9308;
                ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action("Purchase Return Orders")
            {
                ApplicationArea = PurchReturnOrder;
                Caption = 'Purchase Return Orders';
                RunObject = Page 9311;
                ToolTip = 'Create purchase return orders to mirror sales return documents that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. Purchase return orders enable you to ship back items from multiple purchase documents with one purchase return and support warehouse documents for the item handling. Purchase return orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
            }
            action("Purchase Credit Memos")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Credit Memos';
                RunObject = Page 9309;
                ToolTip = 'Create purchase credit memos to mirror sales credit memos that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. If you need more control of the purchase return process, such as warehouse documents for the physical handling, use purchase return orders, in which purchase credit memos are integrated. Purchase credit memos can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
            }
            action("Assembly Orders")
            {
                ApplicationArea = Assembly;
                Caption = 'Assembly Orders';
                RunObject = Page 902;
                ToolTip = 'View ongoing assembly orders.';
            }
            action("Sales Orders")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page 9305;
                ToolTip = 'Record your agreements with customers to sell certain products on certain delivery and payment terms. Sales orders, unlike sales invoices, allow you to ship partially, deliver directly from your vendor to your customer, initiate warehouse handling, and print various customer-facing documents. Sales invoicing is integrated in the sales order process.';
            }
            action(Vendors)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page 27;
                ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
            }
            action(Items)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Items';
                Image = Item;
                RunObject = Page 31;
                ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
            }
            action("Catalog Items")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Catalog Items';
                Image = NonStockItem;
                RunObject = Page 5726;
                ToolTip = 'View the list of items that you do not carry in inventory. ';
            }
            action("Stockkeeping Units")
            {
                ApplicationArea = Warehouse;
                Caption = 'Stockkeeping Units';
                Image = SKU;
                RunObject = Page 5701;
                ToolTip = 'Open the list of item SKUs to view or edit instances of item at different locations or with different variants. ';
            }
            action("Purchase Analysis Reports")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Analysis Reports';
                RunObject = Page 9375;
                RunPageView = WHERE("Analysis Area" = FILTER(Purchase));
                ToolTip = 'Analyze the dynamics of your purchase volumes. You can also use the report to analyze your vendors'' performance and purchase prices.';
            }
            action("Inventory Analysis Reports")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Inventory Analysis Reports';
                RunObject = Page 9377;
                RunPageView = WHERE("Analysis Area" = FILTER(Inventory));
                ToolTip = 'Analyze the dynamics of your inventory according to key performance indicators that you select, for example inventory turnover. You can also use the report to analyze your inventory costs, in terms of direct and indirect costs, as well as the value and quantities of your different types of inventory.';
            }
            action("Item Journals")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Journals';
                RunObject = Page 262;
                RunPageView = WHERE("Template Type" = CONST(Item),
                                    Recurring = CONST(false));
                ToolTip = 'Post item transactions directly to the item ledger to adjust inventory in connection with purchases, sales, and positive or negative adjustments without using documents. You can save sets of item journal lines as standard journals so that you can perform recurring postings quickly. A condensed version of the item journal function exists on item cards for quick adjustment of an items inventory quantity.';
            }
            action("Purchase Journals")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Journals';
                RunObject = Page 251;
                RunPageView = WHERE("Template Type" = CONST(Purchases),
                                    Recurring = CONST(false));
                ToolTip = 'Post any purchase-related transaction directly to a vendor, bank, or general ledger account instead of using dedicated documents. You can post all types of financial purchase transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a purchase journal.';
            }
            action(RequisitionWorksheets)
            {
                ApplicationArea = Planning;
                Caption = 'Requisition Worksheets';
                RunObject = Page 295;
                RunPageView = WHERE("Template Type" = CONST("Req."),
                                    Recurring = CONST(false));
                ToolTip = 'Calculate a supply plan to fulfill item demand with purchases or transfers.';
            }
            action(SubcontractingWorksheets)
            {
                ApplicationArea = Planning;
                Caption = 'Subcontracting Worksheets';
                RunObject = Page 295;
                RunPageView = WHERE("Template Type" = CONST("For. Labor"),
                                    Recurring = CONST(false));
                ToolTip = 'Calculate the needed production supply, find the production orders that have material ready to send to a subcontractor, and automatically create purchase orders for subcontracted operations from production order routings.';
            }
            action("Standard Cost Worksheets")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Standard Cost Worksheets';
                RunObject = Page 5840;
                ToolTip = 'Review or update standard costs. Purchasers, production or assembly managers can use the worksheet to simulate the effect on the cost of the manufactured or assembled item if the standard cost for consumption, production capacity usage, or assembly resource usage is changed. You can set a cost change to take effect on a specified date.';
            }
            action("Logistics")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Logistics';
                RunObject = Page 50101;
                // ToolTip = 'Assign serial numbers and lot numbers to any outbound or inbound document for quality assurance, recall actions, and to control expiration dates and warranties. Use the Item Tracing window to trace items with serial or lot numbers backwards and forward in their supply chain';
            }
            action("Logistics History")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Logistics History';
                RunObject = Page 50115;
                // ToolTip = 'Assign serial numbers and lot numbers to any outbound or inbound document for quality assurance, recall actions, and to control expiration dates and warranties. Use the Item Tracing window to trace items with serial or lot numbers backwards and forward in their supply chain';
            }
        }
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Purchase Receipts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page 145;
                    ToolTip = 'Open the list of posted purchase receipts.';
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page 146;
                    ToolTip = 'Open the list of posted purchase invoices.';
                }
                action("Posted Return Shipments")
                {
                    ApplicationArea = PurchReturnOrder;
                    Caption = 'Posted Return Shipments';
                    RunObject = Page 6652;
                    ToolTip = 'Open the list of posted return shipments.';
                }
                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page 147;
                    ToolTip = 'Open the list of posted purchase credit memos.';
                }
                action("Posted Assembly Orders")
                {
                    ApplicationArea = Assembly;
                    Caption = 'Posted Assembly Orders';
                    RunObject = Page 922;
                    ToolTip = 'View completed assembly orders.';
                }
            }
        }
        area(creation)
        {
            action("Purchase &Quote")
            {
                ApplicationArea = Suite;
                Caption = 'Purchase &Quote';
                Image = Quote;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 49;
                RunPageMode = Create;
                ToolTip = 'Create a new purchase quote, for example to reflect a request for quote.';
            }
            action("Purchase &Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase &Invoice';
                Image = NewPurchaseInvoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 51;
                RunPageMode = Create;
                ToolTip = 'Create a new purchase invoice.';
            }
            action("Purchase &Order")
            {
                ApplicationArea = Suite;
                Caption = 'Purchase &Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 50;
                RunPageMode = Create;
                ToolTip = 'Create a new purchase order.';
            }
            action("Purchase &Return Order")
            {
                ApplicationArea = PurchReturnOrder;
                Caption = 'Purchase &Return Order';
                Image = ReturnOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 6640;
                RunPageMode = Create;
                ToolTip = 'Create a new purchase return order to return received items.';
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("&Purchase Journal")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Purchase Journal';
                Image = Journals;
                RunObject = Page 254;
                ToolTip = 'Post purchase transactions directly to the general ledger. The purchase journal may already contain journal lines that are created as a result of related functions.';
            }
            action("Item &Journal")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item &Journal';
                Image = Journals;
                RunObject = Page 40;
                ToolTip = 'Adjust the physical quantity of items on inventory.';
            }
            action("Order Plan&ning")
            {
                ApplicationArea = Planning;
                Caption = 'Order Plan&ning';
                Image = Planning;
                RunObject = Page 5522;
                ToolTip = 'Plan supply orders order by order to fulfill new demand.';
            }

            action("Requisition &Worksheet")
            {
                ApplicationArea = Planning;
                Caption = 'Requisition &Worksheet';
                Image = Worksheet;
                RunObject = Page 295;
                RunPageView = WHERE("Template Type" = CONST("Req."),
                                    Recurring = CONST(false));
                ToolTip = 'Calculate a supply plan to fulfill item demand with purchases or transfers.';
            }
            action("Pur&chase Prices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pur&chase Prices';
                Image = Price;
                RunObject = Page 7012;
                ToolTip = 'View or set up different prices for items that you buy from the vendor. An item price is automatically granted on invoice lines when the specified criteria are met, such as vendor, quantity, or ending date.';
            }
            action("Purchase &Line Discounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase &Line Discounts';
                Image = LineDiscount;
                RunObject = Page 7014;
                ToolTip = 'View or set up different discounts for items that you buy from the vendor. An item discount is automatically granted on invoice lines when the specified criteria are met, such as vendor, quantity, or ending date.';
            }
            separator(History)
            {
                Caption = 'History';
                IsHeader = true;
            }
            action("Navi&gate")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Navi&gate';
                Image = Navigate;
                RunObject = Page 344;
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
            }
        }
    }
}

