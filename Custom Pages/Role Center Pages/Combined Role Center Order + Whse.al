page 50123 "Combined Order Processor+Whse"
{
    Caption = 'Sales Order Processor', Comment = '{Dependency=Match,"ProfileDescription_ORDERPROCESSOR"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part("Headline RC Order Processor"; "Headline RC Order Processor")
            {
                ApplicationArea = Basic, Suite;
            }
            part("SO Processor Activities"; "SO Processor Activities")
            {
                AccessByPermission = TableData 110 = R;
                ApplicationArea = Basic, Suite;
            }
            part("Logistics Activity Cues"; "Logistics Activity Cues")
            {
                ApplicationArea = Basic, Suite;
            }
            //Doucment Approval cue- SO and PO
            part("Acc. Payables Activities HL"; "Acc. Payables Activities HL")
            {
                ApplicationArea = All;
            }

            part("My Customers"; "My Customers")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part("Team Member Activities"; "Team Member Activities")
            {
                ApplicationArea = Suite;
                Visible = false;
            }
            part("Power BI Report Spinner Part"; "Power BI Report Spinner Part")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part("My Job Queue"; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part("My Items"; "My Items")
            {
                AccessByPermission = TableData 9152 = R;
                ApplicationArea = Basic, Suite;
                Visible = false;
            }

            // 9000 Role center parts
            part("WMS Ship & Receive Activities"; "WMS Ship & Receive Activities")
            {
                ApplicationArea = Warehouse;
            }
            part("Team Member Activities No Msgs"; "Team Member Activities No Msgs")
            {
                ApplicationArea = Suite;
                Visible = false;
            }
            part("Trailing Sales Orders Chart"; "Trailing Sales Orders Chart")
            {
                ApplicationArea = Warehouse;
                Visible = false;
            }
            part("Report Inbox Part"; "Report Inbox Part")
            {
                ApplicationArea = Warehouse;
            }
            systempart(MyNotes; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {

        area(reporting)
        {
            action("&Picking List")
            {
                ApplicationArea = Warehouse;
                Caption = '&Picking List';
                Image = "Report";
                RunObject = Report 5752;
                ToolTip = 'View or print a detailed list of items that must be picked.';
            }
            action("P&ut-away List")
            {
                ApplicationArea = Warehouse;
                Caption = 'P&ut-away List';
                Image = "Report";
                RunObject = Report 5751;
                ToolTip = 'View the list of ongoing put-aways.';
            }
            action("M&ovement List")
            {
                ApplicationArea = Warehouse;
                Caption = 'M&ovement List';
                Image = "Report";
                RunObject = Report 7301;
                ToolTip = 'View the list of ongoing movements between bins.';
            }
            action("Whse. &Shipment Status")
            {
                ApplicationArea = Warehouse;
                Caption = 'Whse. &Shipment Status';
                Image = "Report";
                RunObject = Report 7313;
                ToolTip = 'View warehouse shipments by status.';
            }
            action("Warehouse &Bin List")
            {
                ApplicationArea = Warehouse;
                Caption = 'Warehouse &Bin List';
                Image = "Report";
                RunObject = Report 7319;
                ToolTip = 'Get an overview of warehouse bins, their setup, and the quantity of items within the bins.';
            }
            action("Whse. &Adjustment Bin")
            {
                ApplicationArea = Warehouse;
                Caption = 'Whse. &Adjustment Bin';
                Image = "Report";
                RunObject = Report 7320;
                ToolTip = 'Adjust the quantity of an item in a particular bin or bins. For instance, you might find some items in a bin that are not registered in the system, or you might not be able to pick the quantity needed because there are fewer items in a bin than was calculated by the program. The bin is then updated to correspond to the actual quantity in the bin. In addition, it creates a balancing quantity in the adjustment bin, for synchronization with item ledger entries, which you can then post with an item journal.';
            }
            action("Warehouse Physical Inventory &List")
            {
                ApplicationArea = Warehouse;
                Caption = 'Warehouse Physical Inventory &List';
                Image = "Report";
                RunObject = Report 7307;
                ToolTip = 'View or print the list of the lines that you have calculated in the Warehouse Physical Inventory Journal window. You can use this report during the physical inventory count to mark down actual quantities on hand in the warehouse and compare them to what is recorded in the program.';
            }
            action("P&hys. Inventory List")
            {
                ApplicationArea = Warehouse;
                Caption = 'P&hys. Inventory List';
                Image = "Report";
                RunObject = Report 722;
                ToolTip = 'View a list of the lines that you have calculated in the Phys. Inventory Journal window. You can use this report during the physical inventory count to mark down actual quantities on hand in the warehouse and compare them to what is recorded in the program.';
            }
            action("&Customer - Labels")
            {
                ApplicationArea = Warehouse;
                Caption = '&Customer - Labels';
                Image = "Report";
                RunObject = Report 110;
                ToolTip = 'View, save, or print mailing labels with the customers'' names and addresses. The report can be used to send sales letters, for example.';
            }
            // action("Shipping Labels")
            // {
            //     Caption = 'Shipping Labels';
            //     Image = "Report";
            //     RunObject = Report 10078;
            //     ToolTip = 'View shipping labels for posted sales shipments. You can print labels for all or specific orders.';
            // }
        }
        area(embedding)
        {
            ToolTip = 'Manage sales processes, view KPIs, and access your favorite items and customers.';
            action(SalesOrders)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
                ToolTip = 'Record your agreements with customers to sell certain products on certain delivery and payment terms. Sales orders, unlike sales invoices, allow you to ship partially, deliver directly from your vendor to your customer, initiate warehouse handling, and print various customer-facing documents. Sales invoicing is integrated in the sales order process.';
            }
            action(SalesOrdersShptNotInv)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Shipped Not Invoiced';
                RunObject = Page "Sales Order List";
                RunPageView = WHERE("Shipped Not Invoiced" = CONST(true));
                ToolTip = 'View sales documents that are shipped but not yet invoiced.';
            }
            action(SalesOrdersComplShtNotInv)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Completely Shipped Not Invoiced';
                RunObject = Page "Sales Order List";
                RunPageView = WHERE("Completely Shipped" = CONST(true),
                                    "Shipped Not Invoiced" = CONST(true));
                ToolTip = 'View sales documents that are fully shipped but not fully invoiced.';
            }


            action("Item Journals")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Journals';
                RunObject = Page "Item Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Item),
                                    Recurring = CONST(false));
                ToolTip = 'Post item transactions directly to the item ledger to adjust inventory in connection with purchases, sales, and positive or negative adjustments without using documents. You can save sets of item journal lines as standard journals so that you can perform recurring postings quickly. A condensed version of the item journal function exists on item cards for quick adjustment of an items inventory quantity.';
            }
            action(SalesJournals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Journals';
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Sales),
                                    Recurring = CONST(false));
                ToolTip = 'Post any sales-related transaction directly to a customer, bank, or general ledger account instead of using dedicated documents. You can post all types of financial sales transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a sales journal.';
            }
            action(CashReceiptJournals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cash Receipt Journals';
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                    Recurring = CONST(false));
                ToolTip = 'Register received payments by manually applying them to the related customer, vendor, or bank ledger entries. Then, post the payments to G/L accounts and thereby close the related ledger entries.';
            }
            action("Transfer Orders")
            {
                ApplicationArea = Location;
                Caption = 'Transfer Orders';
                RunObject = Page "Transfer Orders";
                ToolTip = 'Move inventory items between company locations. With transfer orders, you ship the outbound transfer from one location and receive the inbound transfer at the other location. This allows you to manage the involved warehouse activities and provides more certainty that inventory quantities are updated correctly.';
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
            // 90000
            action(WhseShpt)
            {
                ApplicationArea = Warehouse;
                Caption = 'Warehouse Shipments';
                RunObject = Page 7339;
                ToolTip = 'View the list of ongoing warehouse shipments.';
            }
            action(WhseShptReleased)
            {
                ApplicationArea = Warehouse;
                Caption = 'Released';
                RunObject = Page 7339;
                RunPageView = SORTING("No.")
                              WHERE(Status = FILTER(Released));
                ToolTip = 'View the list of released source documents that are ready for warehouse activities.';
            }
            action(WhseShptPartPicked)
            {
                ApplicationArea = Warehouse;
                Caption = 'Partially Picked';
                RunObject = Page 7339;
                RunPageView = WHERE("Document Status" = FILTER("Partially Picked"));
                ToolTip = 'View the list of ongoing warehouse picks that are partially completed.';
            }
            action(WhseShptComplPicked)
            {
                ApplicationArea = Warehouse;
                Caption = 'Completely Picked';
                RunObject = Page 7339;
                RunPageView = WHERE("Document Status" = FILTER("Completely Picked"));
                ToolTip = 'View the list of completed warehouse picks.';
            }
            action(WhseShptPartShipped)
            {
                ApplicationArea = Warehouse;
                Caption = 'Partially Shipped';
                RunObject = Page 7339;
                RunPageView = WHERE("Document Status" = FILTER("Partially Shipped"));
                ToolTip = 'View the list of ongoing warehouse shipments that are partially completed.';
            }
            action(WhseRcpt)
            {
                ApplicationArea = Warehouse;
                Caption = 'Warehouse Receipts';
                RunObject = Page 7332;
                ToolTip = 'View the list of ongoing warehouse receipts.';
            }
            action(WhseRcptPartReceived)
            {
                ApplicationArea = Warehouse;
                Caption = 'Partially Received';
                RunObject = Page 7332;
                RunPageView = WHERE("Document Status" = FILTER("Partially Received"));
                ToolTip = 'View the list of ongoing warehouse receipts that are partially completed.';
            }
            action(TransferOrders)
            {
                ApplicationArea = Warehouse;
                Caption = 'Transfer Orders';
                Image = Document;
                RunObject = Page 5742;
                ToolTip = 'Move inventory items between company locations. With transfer orders, you ship the outbound transfer from one location and receive the inbound transfer at the other location. This allows you to manage the involved warehouse activities and provides more certainty that inventory quantities are updated correctly.';
            }
            action(PhysInvtOrders)
            {
                ApplicationArea = Warehouse;
                Caption = 'Physical Inventory Orders';
                RunObject = Page 5876;
                ToolTip = 'Plan to count inventory by calculating existing quantities and generating the recording documents.';
            }
            action(PhysInvtRecordings)
            {
                ApplicationArea = Warehouse;
                Caption = 'Physical Inventory Recordings';
                RunObject = Page 5880;
                ToolTip = 'Prepare to count inventory by creating a recording document to capture the quantities.';
            }
            action(ReleasedProductionOrders)
            {
                ApplicationArea = Manufacturing;
                Caption = 'Released Production Orders';
                RunObject = Page 9326;
                ToolTip = 'View the list of released production order that are ready for warehouse activities.';
            }
            action(AssemblyOrders)
            {
                ApplicationArea = Assembly;
                Caption = 'Assembly Orders';
                RunObject = Page "Assembly Orders";
                ToolTip = 'View ongoing assembly orders.';
            }
            action(Picks)
            {
                ApplicationArea = Warehouse;
                Caption = 'Picks';
                RunObject = Page 9313;
                ToolTip = 'View the list of ongoing warehouse picks. ';
            }
            action(PicksUnassigned)
            {
                ApplicationArea = Warehouse;
                Caption = 'Unassigned';
                RunObject = Page 9313;
                RunPageView = WHERE("Assigned User ID" = FILTER(''));
                ToolTip = 'View all unassigned warehouse activities.';
            }
            action(Putaway)
            {
                ApplicationArea = Warehouse;
                Caption = 'Put-away';
                RunObject = Page 9312;
                ToolTip = 'Create a new put-away.';
            }
            action(PutawayUnassigned)
            {
                ApplicationArea = Warehouse;
                Caption = 'Unassigned';
                RunObject = Page 9312;
                RunPageView = WHERE("Assigned User ID" = FILTER(''));
                ToolTip = 'View all unassigned warehouse activities.';
            }
            action(Movements)
            {
                ApplicationArea = Warehouse;
                Caption = 'Movements';
                RunObject = Page 9314;
                ToolTip = 'View the list of ongoing movements between bins according to an advanced warehouse configuration.';
            }
            action(MovementsUnassigned)
            {
                ApplicationArea = Warehouse;
                Caption = 'Unassigned';
                RunObject = Page 9314;
                RunPageView = WHERE("Assigned User ID" = FILTER(''));
                ToolTip = 'View all unassigned warehouse activities.';
            }
            action(BinContents)
            {
                ApplicationArea = Warehouse;
                Caption = 'Bin Contents';
                Image = BinContent;
                RunObject = Page 7305;
                ToolTip = 'View items in the bin if the selected line contains a bin code.';
            }

            // 

        }
        area(sections)
        {
            group("Sales & Group")
            {
                Caption = 'Sales';
                Image = Sales;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action("&Customers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer List";
                    ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                }
                action("Sales Quotes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Quotes';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 9300;
                    ToolTip = 'Make offers to customers to sell certain products on certain delivery and payment terms. While you negotiate with a customer, you can change and resend the sales quote as much as needed. When the customer accepts the offer, you convert the sales quote to a sales invoice or a sales order in which you process the sale.';
                }
                action("Sales Orders")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Orders';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Order List";
                    ToolTip = 'Record your agreements with customers to sell certain products on certain delivery and payment terms. Sales orders, unlike sales invoices, allow you to ship partially, deliver directly from your vendor to your customer, initiate warehouse handling, and print various customer-facing documents. Sales invoicing is integrated in the sales order process.';
                }
                action("Sales Orders - Microsoft Dynamics 365 for Sales")
                {
                    ApplicationArea = Suite;
                    Caption = 'Sales Orders - Microsoft Dynamics 365 for Sales';
                    RunObject = Page 5353;
                    RunPageView = WHERE(StateCode = FILTER(Submitted),
                                        LastBackofficeSubmit = FILTER(''));
                    ToolTip = 'View sales orders in Dynamics 365 for Sales that are coupled with sales orders in Business Central.';
                }
                action("Blanket Sales Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Sales Orders';
                    Image = Reminder;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 9303;
                    ToolTip = 'Use blanket sales orders as a framework for a long-term agreement between you and your customers to sell large quantities that are to be delivered in several smaller shipments over a certain period of time. Blanket orders often cover only one item with predetermined delivery dates. The main reason for using a blanket order rather than a sales order is that quantities entered on a blanket order do not affect item availability and thus can be used as a worksheet for monitoring, forecasting, and planning purposes..';
                }
                action("Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoices';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 9301;
                    ToolTip = 'Register your sales to customers and invite them to pay according to the delivery and payment terms by sending them a sales invoice document. Posting a sales invoice registers shipment and records an open receivable entry on the customer''s account, which will be closed when payment is received. To manage the shipment process, use sales orders, in which sales invoicing is integrated.';
                }
                action("Sales Return Orders")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Sales Return Orders';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Return Order List";
                    ToolTip = 'Compensate your customers for incorrect or damaged items that you sent to them and received payment for. Sales return orders enable you to receive items from multiple sales documents with one sales return, automatically create related sales credit memos or other return-related documents, such as a replacement sales order, and support warehouse documents for the item handling. Note: If an erroneous sale has not been paid yet, you can simply cancel the posted sales invoice to automatically revert the financial transaction.';
                }
                action("Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Credit Memos';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 9302;
                    ToolTip = 'Revert the financial transactions involved when your customers want to cancel a purchase or return incorrect or damaged items that you sent to them and received payment for. To include the correct information, you can create the sales credit memo from the related posted sales invoice or you can create a new sales credit memo with copied invoice information. If you need more control of the sales return process, such as warehouse documents for the physical handling, use sales return orders, in which sales credit memos are integrated. Note: If an erroneous sale has not been paid yet, you can simply cancel the posted sales invoice to automatically revert the financial transaction.';
                }
                action("Sales Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Sales),
                                        Recurring = CONST(false));
                    ToolTip = 'Post any sales-related transaction directly to a customer, bank, or general ledger account instead of using dedicated documents. You can post all types of financial sales transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a sales journal.';
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page 143;
                    ToolTip = 'Open the list of posted sales invoices.';
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = Page 144;
                    ToolTip = 'Open the list of posted sales credit memos.';
                }
                action("Posted Sales Return Receipts")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Posted Sales Return Receipts';
                    RunObject = Page "Posted Return Receipts";
                    ToolTip = 'Open the list of posted sales return receipts.';
                }
                action("Posted Sales Shipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Posted Return Receipts";
                    ToolTip = 'Open the list of posted sales shipments.';
                }
                action("Transfer & Orders")
                {
                    ApplicationArea = Location;
                    Caption = 'Transfer Orders';
                    Image = FinChargeMemo;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Posted Return Receipts";
                    ToolTip = 'Move inventory items between company locations. With transfer orders, you ship the outbound transfer from one location and receive the inbound transfer at the other location. This allows you to manage the involved warehouse activities and provides more certainty that inventory quantities are updated correctly.';
                }
                action(Reminders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reminders';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 436;
                    ToolTip = 'Remind customers about overdue amounts based on reminder terms and the related reminder levels. Each reminder level includes rules about when the reminder will be issued in relation to the invoice due date or the date of the previous reminder and whether interests are added. Reminders are integrated with finance charge memos, which are documents informing customers of interests or other money penalties for payment delays.';
                }
                action("Finance Charge Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Finance Charge Memos';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 448;
                    ToolTip = 'Send finance charge memos to customers with delayed payments, typically following a reminder process. Finance charges are calculated automatically and added to the overdue amounts on the customer''s account according to the specified finance charge terms and penalty/interest amounts.';
                }
                //90000

            }

            group("Sales & Purchases")
            {
                Caption = 'Sales & Purchases';

                action(SalesOrdersReleased)
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Released';
                    RunObject = Page "Sales Order List";
                    RunPageView = WHERE(Status = FILTER(Released));
                    ToolTip = 'View the list of released source documents that are ready for warehouse activities.';
                }
                action(SalesOrdersPartShipped)
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Partially Shipped';
                    RunObject = Page "Sales Order List";
                    RunPageView = WHERE(Status = FILTER(Released),
                                        "Completely Shipped" = FILTER(false));
                    ToolTip = 'View the list of ongoing warehouse shipments that are partially completed.';
                }
                action(SalesReturnOrders)
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Sales Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page 9304;
                    ToolTip = 'Compensate your customers for incorrect or damaged items that you sent to them and received payment for. Sales return orders enable you to receive items from multiple sales documents with one sales return, automatically create related sales credit memos or other return-related documents, such as a replacement sales order, and support warehouse documents for the item handling. Note: If an erroneous sale has not been paid yet, you can simply cancel the posted sales invoice to automatically revert the financial transaction.';
                }
                action(PurchaseOrders)
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Purchase Orders';
                    RunObject = Page 9307;
                    ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
                action(PurchaseOrdersReleased)
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Released';
                    RunObject = Page 9307;
                    RunPageView = WHERE(Status = FILTER(Released));
                    ToolTip = 'View the list of released source documents that are ready for warehouse activities.';
                }
                action(PurchaseOrdersPartReceived)
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Partially Received';
                    RunObject = Page 9307;
                    RunPageView = WHERE(Status = FILTER(Released),
                                        "Completely Received" = FILTER(false));
                    ToolTip = 'View the list of ongoing warehouse receipts that are partially completed.';
                }
                action(PurchaseReturnOrders)
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Purchase Return Orders';
                    RunObject = Page "Purchase Return Order List";
                    ToolTip = 'Create purchase return orders to mirror sales return documents that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. Purchase return orders enable you to ship back items from multiple purchase documents with one purchase return and support warehouse documents for the item handling. Purchase return orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
                }
            }
            group("Purchasing & Grouping")
            {
                Caption = 'Purchasing';
                Image = FiledPosted;
                ToolTip = 'View history for sales, shipments, and inventory.';
                action(Vendors)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor List";
                    ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
                action("Purchase Quotes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Quotes';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Quotes";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Purchase Orders")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Orders';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Order List";
                    ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
                action("Blanket Purchase Orders")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Blanket Purchase Orders';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Blanket Purchase Orders";
                    ToolTip = 'Use blanket purchase orders as a framework for a long-term agreement between you and your vendors to buy large quantities that are to be delivered in several smaller shipments over a certain period of time. Blanket orders often cover only one item with predetermined delivery dates. The main reason for using a blanket order rather than a purchase order is that quantities entered on a blanket order do not affect item availability and thus can be used as a worksheet for monitoring, forecasting, and planning purposes.';
                }
                action("Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoices';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Invoices";
                    ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
                action("Purchase Return Orders")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Return Orders';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Return Order List";
                    ToolTip = 'Create purchase return orders to mirror sales return documents that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. Purchase return orders enable you to ship back items from multiple purchase documents with one purchase return and support warehouse documents for the item handling. Purchase return orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
                }
                action("Purchase Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Credit Memos';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Credit Memos";
                    ToolTip = 'Create purchase credit memos to mirror sales credit memos that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. If you need more control of the purchase return process, such as warehouse documents for the physical handling, use purchase return orders, in which purchase credit memos are integrated. Purchase credit memos can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
                }
                action(PurchaseJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Purchases),
                                        Recurring = CONST(false));
                    ToolTip = 'Post any purchase-related transaction directly to a vendor, bank, or general ledger account instead of using dedicated documents. You can post all types of financial purchase transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a purchase journal.';
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Opens a list of posted purchase invoices.';
                }
                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Opens a list of posted purchase credit memos.';
                }
                action("Posted Purchase Return Shipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Return Shipments';
                    RunObject = Page "Posted Return Shipments";
                    ToolTip = 'Opens a list of posted purchase return shipments.';
                }
                action("Posted Purchase Receipts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ToolTip = 'Open the list of posted purchase receipts.';
                }
            }
            group("Inventory & Group")
            {
                Caption = 'Inventory';
                ToolTip = 'Manage physical or service-type items that you trade in by setting up item cards with rules for pricing, costing, planning, reservation, and tracking. Set up storage places or warehouses and how to transfer between such locations. Count, adjust, reclassify, or revalue inventory.';
                action("&Items")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items';
                    Image = Item;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item List";
                    ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
                }
                action("Item& Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Item),
                                        Recurring = CONST(false));
                    ToolTip = 'Post item transactions directly to the item ledger to adjust inventory in connection with purchases, sales, and positive or negative adjustments without using documents. You can save sets of item journal lines as standard journals so that you can perform recurring postings quickly. A condensed version of the item journal function exists on item cards for quick adjustment of an items inventory quantity.';
                }
                action("Item Charges")
                {
                    ApplicationArea = Suite;
                    Caption = 'Item Charges';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 5800;
                    ToolTip = 'View or edit the codes for item charges that you can assign to purchase and sales transactions to include any added costs, such as freight, physical handling, and insurance that you incur when purchasing or selling items. This is important to ensure correct inventory valuation. For purchases, the landed cost of a purchased item consists of the vendor''s purchase price and all additional direct item charges that can be assigned to individual receipts or return shipments. For sales, knowing the cost of shipping sold items can be as vital to your company as knowing the landed cost of purchased items.';
                }
                action("Item Attributes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Attributes';
                    RunObject = Page 7500;
                    ToolTip = 'Assign item attribute values to your items to enable rich searching and sorting options. When customers inquire about an item, either in correspondence or in an integrated web shop, they can then ask or search according to characteristics, such as height and model year. You can also assign item attributes to item categories, which then apply to the items that use the item categories in question.';
                }
                action("Item Tracking")
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Item Tracking';
                    RunObject = Page 6503;
                    ToolTip = 'Assign serial numbers and lot numbers to any outbound or inbound document for quality assurance, recall actions, and to control expiration dates and warranties. Use the Item Tracing window to trace items with serial or lot numbers backwards and forward in their supply chain';
                }



                action("Item Reclassification Journals")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Item Reclassification Journals';
                    RunObject = Page "Item Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Transfer),
                                        Recurring = CONST(false));
                    ToolTip = 'Change information on item ledger entries, such as dimensions, location codes, bin codes, and serial or lot numbers.';
                }
                action("Phys. Inventory Journals")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Phys. Inventory Journals';
                    RunObject = Page "Item Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST("Phys. Inventory"),
                                        Recurring = CONST(false));
                    ToolTip = 'Select how you want to maintain an up-to-date record of your inventory at different locations.';
                }
                action("Assembly Orders")
                {
                    ApplicationArea = Assembly;
                    Caption = 'Assembly Orders';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Assembly Orders";
                    ToolTip = 'Combine components in simple processes without the need of manufacturing functionality. Sell assembled items by building the item to order or by picking from stock.';
                }
                action("Drop Shipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Drop Shipments';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 516;
                    RunPageView = WHERE("Drop Shipment" = CONST(true));
                    ToolTip = 'Minimize delivery time and inventory cost by having items shipped from your vendor directly to your customer. This simply requires that you mark the sales order for drop shipment and then create a linked purchase order with the customer specified as the recipient. ';
                }
                action(Locations)
                {
                    ApplicationArea = Location;
                    Caption = 'Locations';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Location List";
                    ToolTip = 'Manage the different places or warehouses where you receive, process, or ship inventory to increase customer service and keep inventory costs low.';
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                ToolTip = 'View the posting history for sales, shipments, and inventory.';
                action("Posted Sales& Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page 143;
                    ToolTip = 'Open the list of posted sales invoices.';
                }
                action("Posted Sales& Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page 144;
                    ToolTip = 'Open the list of posted sales credit memos.';
                }

                action("Posted Sales& Shipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                    ToolTip = 'Open the list of posted sales shipments.';
                }
                action("Posted Purchase& Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Open the list of posted purchase invoices.';
                }
                action("Posted Purchase &Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Opens the list of posted purchase credit memos.';
                }
                action("Posted Purchase &Return Shipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Return Shipments';
                    RunObject = Page "Posted Return Shipments";
                    ToolTip = 'Opens the list of posted purchase return shipments.';
                }
                action("Posted Purchase &Receipts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ToolTip = 'Open the list of posted purchase receipts.';
                }


                action("Issued Reminders")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Issued Reminders';
                    RunObject = Page 440;
                    ToolTip = 'Opens the list of issued reminders.';
                }
                action("Issued Finance Charge Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Issued Finance Charge Memos';
                    RunObject = Page 452;
                    ToolTip = 'Opens the list of issued finance charge memos.';
                }

                action("Posted Whse Shipments")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Posted Whse Shipments';
                    RunObject = Page 7340;
                    ToolTip = 'Open the list of posted warehouse shipments.';
                }
                action("Posted Sales Shipment")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Posted Sales Shipment';
                    RunObject = Page 142;
                    ToolTip = 'Open the list of posted sales shipments.';
                }
                action("Posted Transfer Shipments")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Posted Transfer Shipments';
                    RunObject = Page 5752;
                    ToolTip = 'Open the list of posted transfer shipments.';
                }
                action("Posted Return Shipments")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Posted Return Shipments';
                    RunObject = Page "Posted Return Shipments";
                    ToolTip = 'Open the list of posted return shipments.';
                }
                action("Posted Whse Receipts")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Posted Whse Receipts';
                    RunObject = Page 7333;
                    ToolTip = 'Open the list of posted warehouse receipts.';
                }

                action("Posted Transfer Receipts")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Posted Transfer Receipts';
                    RunObject = Page 5753;
                    ToolTip = 'Open the list of posted transfer receipts.';
                }
                action("Posted Return Receipts")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Posted Return Receipts';
                    Image = PostedReturnReceipt;
                    RunObject = Page 6662;
                    ToolTip = 'Open the list of posted return receipts.';
                }
                action("Posted Phys. Invt. Orders")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Posted Phys. Invt. Orders';
                    RunObject = Page 5884;
                    ToolTip = 'View the list of posted inventory counts.';
                }
                action("Posted Phys. Invt. Recordings")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Posted Phys. Invt. Recordings';
                    RunObject = Page 5888;
                    ToolTip = 'View the list of finished inventory counts, ready for posting.';
                }
                action("Posted Assembly Orders")
                {
                    ApplicationArea = Assembly;
                    Caption = 'Posted Assembly Orders';
                    RunObject = Page "Posted Assembly Orders";
                    ToolTip = 'View completed assembly orders.';
                }
            }
            group(SetupAndExtensions)
            {
                Caption = 'Setup & Extensions';
                Image = Setup;
                ToolTip = 'Overview and change system and application settings, and manage extensions and services';

                // action("&Sales")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Sales';
                //     RunObject = Page 1875;
                //     RunPageView = SORTING(Name) WHERE("Area" = FILTER(Sales));
                //     ToolTip = 'Define your general policies for sales invoicing and returns, such as when to show credit and stockout warnings and how to post sales discounts. Set up your number series for creating customers and different sales documents.';
                // }
                // action("&Purchasing")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Purchasing';
                //     RunObject = Page 1875;
                //     RunPageView = SORTING(Name)
                //                   WHERE(Area = FILTER(Purchasing));
                //     ToolTip = 'Define your general policies for purchase invoicing and returns, such as whether to require vendor invoice numbers and how to post purchase discounts. Set up your number series for creating vendors and different purchase documents.';
                // }
                // action("&Jobs")
                // {
                //     ApplicationArea = Jobs;
                //     Caption = 'Jobs';
                //     RunObject = Page 1875;
                //     RunPageView = SORTING(Name)
                //                   WHERE(Area = FILTER(Jobs));
                //     ToolTip = 'Define a project activity by creating a job card with integrated job tasks and job planning lines, structured in two layers. The job task enables you to set up job planning lines and to post consumption to the job. The job planning lines specify the detailed use of resources, items, and various general ledger expenses.';
                // }


                // action("&Inventory")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Inventory';
                //     RunObject = Page 1875;
                //     RunPageView = SORTING(Name) WHERE(Area = FILTER(Inventory));
                //     ToolTip = 'Define your general inventory policies, such as whether to allow negative inventory and how to post and adjust item costs. Set up your number series for creating new inventory items or services.';
                // }
                action("Assisted Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Assisted Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page 1801;
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                }
                action("Manual Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Manual Setup';
                    RunObject = Page 1875;
                    ToolTip = 'Define your company policies for business departments and for general activities by filling setup windows manually.';
                }
                // action(General)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'General';
                //     RunObject = Page 1875;
                //     RunPageView = SORTING(Name)
                //                   WHERE(Area = FILTER(General));
                //     ToolTip = 'Fill in your official company information, and define general codes and information that is used across the business functionality, such as currencies and languages. ';
                // }
                // action(Finance)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Finance';
                //     RunObject = Page 1875;
                //     RunPageView = SORTING(Name)
                //                   WHERE(Area = FILTER(Finance));
                //     ToolTip = 'Define your general accounting policies, such as the allowed posting period and how payments are processed. Set up your default dimensions for financial analysis.';
                // }
                // action(Sales)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Sales';
                //     RunObject = Page 1875;
                //     RunPageView = SORTING(Name)
                //                   WHERE(Area = FILTER(Sales));
                //     ToolTip = 'Define your general policies for sales invoicing and returns, such as when to show credit and stockout warnings and how to post sales discounts. Set up your number series for creating customers and different sales documents.';
                // }
                // action(Purchasing)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Purchasing';
                //     RunObject = Page 1875;
                //     RunPageView = SORTING(Name)
                //                   WHERE(Area = FILTER(Purchasing));
                //     ToolTip = 'Define your general policies for purchase invoicing and returns, such as whether to require vendor invoice numbers and how to post purchase discounts. Set up your number series for creating vendors and different purchase documents.';
                // }
                // action(Jobs)
                // {
                //     ApplicationArea = Jobs;
                //     Caption = 'Jobs';
                //     RunObject = Page 1875;
                //     RunPageView = SORTING(Name)
                //                   WHERE(Area = FILTER(Jobs));
                //     ToolTip = 'Define a project activity by creating a job card with integrated job tasks and job planning lines, structured in two layers. The job task enables you to set up job planning lines and to post consumption to the job. The job planning lines specify the detailed use of resources, items, and various general ledger expenses.';
                // }
                // action("Fixed Assets")
                // {
                //     ApplicationArea = FixedAssets;
                //     Caption = 'Fixed Assets';
                //     RunObject = Page 1875;
                //     RunPageView = SORTING(Name)
                //                   WHERE(Area = FILTER("Fixed Assets"));
                //     ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
                // }
                // action(HR)
                // {
                //     ApplicationArea = BasicHR;
                //     Caption = 'HR';
                //     RunObject = Page 1875;
                //     RunPageView = SORTING(Name)
                //                   WHERE(area = FILTER(HR));
                //     ToolTip = 'Set up number series for creating new employee cards and define if employment time is measured by days or hours.';
                // }
                // action(Inventory)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Inventory';
                //     RunObject = Page 1875;
                //     RunPageView = SORTING(Name)
                //                   WHERE(Area = FILTER(Inventory));
                //     ToolTip = 'Define your general inventory policies, such as whether to allow negative inventory and how to post and adjust item costs. Set up your number series for creating new inventory items or services.';
                // }
                // action(Service)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Service';
                //     RunObject = Page 1875;
                //     RunPageView = SORTING(Name)
                //                   WHERE(Area = FILTER(Service));
                //     ToolTip = 'Configure your company policies for service management.';
                // }
                // action(System)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'System';
                //     RunObject = Page 1875;
                //     RunPageView = SORTING(Name)
                //                   WHERE(Area = FILTER(System));
                //     ToolTip = 'System';
                // }
                // action("Relationship Management")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Relationship Management';
                //     RunObject = Page 1875;
                //     RunPageView = SORTING(Name)
                //                   WHERE(Area = FILTER("Relationship Mngt"));
                //     ToolTip = 'Set up business relations, configure sales cycles, campaigns, and interactions, and define codes for various marketing communication.';
                // }
                // action(Intercompany)
                // {
                //     ApplicationArea = Intercompany;
                //     Caption = 'Intercompany';
                //     RunObject = Page 1875;
                //     RunPageView = SORTING(Name)
                //                   WHERE(Area = FILTER(Intercompany));
                //     ToolTip = 'Configure intercompany processes, such as the inbox and outbox for business documents exchanged within your group.';
                // }
                action("Service Connections")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Service Connections';
                    Image = ServiceTasks;
                    RunObject = Page 1279;
                    ToolTip = 'Enable and configure external services, such as exchange rate updates, Microsoft Social Engagement, and electronic bank integration.';
                }
                /*action(Extensions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Extensions';
                    Image = NonStockItemSetup;
                    RunObject = Page 2500;
                    ToolTip = 'Install Extensions for greater functionality of the system.';
                }
                */
                action(Workflows)
                {
                    ApplicationArea = Suite;
                    Caption = 'Workflows';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 1500;
                    ToolTip = 'Set up or enable workflows that connect business-process tasks performed by different users. System tasks, such as automatic posting, can be included as steps in workflows, preceded or followed by user tasks. Requesting and granting approval to create new records are typical workflow steps.';
                }

            }

            group("Reference Data")
            {
                Caption = 'Reference Data';
                Image = ReferenceData;
                action(Items)
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Items';
                    Image = Item;
                    RunObject = Page "Item List";
                    ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
                }
                action(Customers)
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Customers';
                    Image = Customer;
                    RunObject = Page 22;
                    ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                }
                action("Shipping Agent")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Shipping Agent';
                    RunObject = Page 428;
                    ToolTip = 'View the list of shipping companies that you use to transport goods.';
                }
            }
            group(Journals)
            {
                Caption = 'Journals';
                Image = Journals;
                action(WhseItemJournals)
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Warehouse Item Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 7329;
                    RunPageView = WHERE("Template Type" = CONST(Item));
                    ToolTip = 'Adjust the quantity of an item in a particular bin or bins. For instance, you might find some items in a bin that are not registered in the system, or you might not be able to pick the quantity needed because there are fewer items in a bin than was calculated by the program. The bin is then updated to correspond to the actual quantity in the bin. In addition, it creates a balancing quantity in the adjustment bin, for synchronization with item ledger entries, which you can then post with an item journal.';
                }
                action(WhseReclassJournals)
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Warehouse Reclassification Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 7329;
                    RunPageView = WHERE("Template Type" = CONST(Reclassification));
                    ToolTip = 'Change information on warehouse entries, such as zone codes and bin codes.';
                }
                action(WhsePhysInvtJournals)
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Warehouse Physical Inventory Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 7329;
                    RunPageView = WHERE("Template Type" = CONST("Physical Inventory"));
                    ToolTip = 'Prepare to count inventories by preparing the documents that warehouse employees use when they perform a physical inventory of selected items or of all the inventory. When the physical count has been made, you enter the number of items that are in the bins in this window, and then you register the physical inventory.';
                }
                action(ItemJournals)
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Item Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Item),
                                        Recurring = CONST(false));
                    ToolTip = 'Post item transactions directly to the item ledger to adjust inventory in connection with purchases, sales, and positive or negative adjustments without using documents. You can save sets of item journal lines as standard journals so that you can perform recurring postings quickly. A condensed version of the item journal function exists on item cards for quick adjustment of an items inventory quantity.';
                }
                action(ItemReclassJournals)
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Item Reclass. Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Transfer),
                                        Recurring = CONST(false));
                    ToolTip = 'Change information recorded on item ledger entries. Typical inventory information to reclassify includes dimensions and sales campaign codes, but you can also perform basic inventory transfers by reclassifying location and bin codes. Serial or lot numbers and their expiration dates must be reclassified with the Item Tracking Reclassification journal.';
                }
                action(PhysInventoryJournals)
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Phys. Inventory Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST("Phys. Inventory"),
                                        Recurring = CONST(false));
                    ToolTip = 'Prepare to count the actual items in inventory to check if the quantity registered in the system is the same as the physical quantity. If there are differences, post them to the item ledger with the physical inventory journal before you do the inventory valuation.';
                }
            }
            group(Worksheet)
            {
                Caption = 'Worksheet';
                Image = Worksheets;
                action(PutawayWorksheets)
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Put-away Worksheets';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 7346;
                    RunPageView = WHERE("Template Type" = CONST("Put-away"));
                    ToolTip = 'Plan and initialize item put-aways.';
                }
                action(PickWorksheets)
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Pick Worksheets';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 7346;
                    RunPageView = WHERE("Template Type" = CONST(Pick));
                    ToolTip = 'Plan and initialize picks of items. ';
                }
                action(MovementWorksheets)
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Movement Worksheets';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 7346;
                    RunPageView = WHERE("Template Type" = CONST(Movement));
                    ToolTip = 'Plan and initiate movements of items between bins according to an advanced warehouse configuration.';
                }
                action("Internal Put-aways")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Internal Put-aways';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 7356;
                    ToolTip = 'View the list of ongoing put-aways for internal activities, such as production.';
                }
                action("Internal Picks")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Internal Picks';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 7359;
                    ToolTip = 'View the list of ongoing picks for internal activities, such as production.';
                }
            }

            group("Registered Documents")
            {
                Caption = 'Registered Documents';
                Image = RegisteredDocs;
                action("Registered Picks")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Registered Picks';
                    Image = RegisteredDocs;
                    RunObject = Page 9344;
                    ToolTip = 'View warehouse picks that have been performed.';
                }
                action("Registered Put-aways")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Registered Put-aways';
                    Image = RegisteredDocs;
                    RunObject = Page 9343;
                    ToolTip = 'View the list of completed put-away activities.';
                }
                action("Registered Movements")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Registered Movements';
                    Image = RegisteredDocs;
                    RunObject = Page 9345;
                    ToolTip = 'View the list of completed warehouse movements.';
                }
            }

        }
        area(creation)
        {
            action("Sales &Quote")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Quote';
                Image = NewSalesQuote;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 41;
                RunPageMode = Create;
                ToolTip = 'Create a new sales quote to offer items or services to a customer.';
            }
            action("Sales &Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Invoice';
                Image = NewSalesInvoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 43;
                RunPageMode = Create;
                ToolTip = 'Create a new invoice for the sales of items or services. Invoice quantities cannot be posted partially.';
            }
            action("Sales &Order")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 42;
                RunPageMode = Create;
                ToolTip = 'Create a new sales order for items or services.';
            }
            action("Sales &Return Order")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Return Order';
                Image = ReturnOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 6630;
                RunPageMode = Create;
                ToolTip = 'Compensate your customers for incorrect or damaged items that you sent to them and received payment for. Sales return orders enable you to receive items from multiple sales documents with one sales return, automatically create related sales credit memos or other return-related documents, such as a replacement sales order, and support warehouse documents for the item handling. Note: If an erroneous sale has not been paid yet, you can simply cancel the posted sales invoice to automatically revert the financial transaction.';
            }
            action("Sales &Credit Memo")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 44;
                RunPageMode = Create;
                ToolTip = 'Create a new sales credit memo to revert a posted sales invoice.';
            }

            //90000
            action("Whse. &Shipment")
            {
                ApplicationArea = Warehouse;
                Caption = 'Whse. &Shipment';
                Image = Shipment;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 7335;
                RunPageMode = Create;
                ToolTip = 'Create a new warehouse shipment.';
            }
            action("T&ransfer Order")
            {
                ApplicationArea = Warehouse;
                Caption = 'T&ransfer Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 5740;
                RunPageMode = Create;
                ToolTip = 'Move items from one warehouse location to another.';
            }
            action("&Purchase Order")
            {
                ApplicationArea = Warehouse;
                Caption = '&Purchase Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Order";
                RunPageMode = Create;
                ToolTip = 'Purchase goods or services from a vendor.';
            }
            action("&Whse. Receipt")
            {
                ApplicationArea = Warehouse;
                Caption = '&Whse. Receipt';
                Image = Receipt;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 5768;
                RunPageMode = Create;
                ToolTip = 'Record the receipt of items according to an advanced warehouse configuration. ';
            }
            action("Phys. Inv. Order")
            {
                ApplicationArea = Warehouse;
                Caption = 'Phys. Inv. Order';
                RunObject = Page 5875;
                ToolTip = 'Plan to count inventory by calculating existing quantities and generating the recording documents.';
            }
            action("Phys. Inv. Recording")
            {
                ApplicationArea = Warehouse;
                Caption = 'Phys. Inv. Recording';
                RunObject = Page 5879;
                ToolTip = 'Prepare to count inventory by creating a recording document to capture the quantities.';
            }
        }
        area(processing)
        {
            group(Tasks)
            {
                Caption = 'Tasks';
                action("Sales &Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales &Journal';
                    Image = Journals;
                    RunObject = Page 253;
                    ToolTip = 'Open a sales journal where you can batch post sales transactions to G/L, bank, customer, vendor and fixed assets accounts.';
                }
                action("Sales Price &Worksheet")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Price &Worksheet';
                    Image = PriceWorksheet;
                    RunObject = Page 7023;
                    ToolTip = 'Manage sales prices for individual customers, for a group of customers, for all customers, or for a campaign.';
                }
            }
            group("SalesGroup")
            {
                Caption = 'Sales';
                action("&Prices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Prices';
                    Image = SalesPrices;
                    RunObject = Page 7002;
                    ToolTip = 'Set up different prices for items that you sell to the customer. An item price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
                }
                action("&Line Discounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Line Discounts';
                    Image = SalesLineDisc;
                    RunObject = Page 7004;
                    ToolTip = 'Set up different discounts for items that you sell to the customer. An item discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
                }
                // action("Credit Management")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Credit Management';
                //     Image = CustomerRating;
                //     RunObject = Page "Customer List - Credit Mgmt.";
                //     ToolTip = 'Add comments to customer credit information or hold and block customers with bad credit before shipping or invoicing occurs.';
                // }
                // action("Order Status")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Order Status';
                //     Image = CustomerList;
                //     RunObject = Page "Customer List - Order Status";
                //     ToolTip = 'View the status of the order.';
                // }
            }
            group(Reports)
            {
                Caption = 'Reports';
                group(Customer)
                {
                    Caption = 'Customer';
                    Image = Customer;
                    action("Customer - &Order Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - &Order Summary';
                        Image = "Report";
                        RunObject = Report 107;
                        ToolTip = 'View the quantity not yet shipped for each customer in three periods of 30 days each, starting from a selected date. There are also columns with orders to be shipped before and after the three periods and a column with the total order detail for each customer. The report can be used to analyze a company''s expected sales volume.';
                    }
                    action("Customer - &Top 10 List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - &Top 10 List';
                        Image = "Report";
                        RunObject = Report 111;
                        ToolTip = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    // action("Customer/Item Statistics")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Customer/Item Statistics';
                    //     Image = "Report";
                    //     RunObject = Report 10048;
                    //     ToolTip = 'View a list of item sales for each customer during a selected time period. The report contains information on quantity, sales amount, profit, and possible discounts. It can be used, for example, to analyze a company''s customer groups.';
                    // }
                }
                group("Sales&Group")
                {
                    Caption = 'Sales';
                    Image = Sales;
                    // action("Cust./Item Stat. by Salespers.")
                    // {
                    //     ApplicationArea = Suite;
                    //     Caption = 'Cust./Item Stat. by Salespers.';
                    //     Image = "Report";
                    //     RunObject = Report 10049;
                    //     ToolTip = 'View amounts for sales, profit, invoice discount, and payment discount, as well as profit percentage, for each salesperson for a selected period. The report also shows the adjusted profit and adjusted profit percentage, which reflect any changes to the original costs of the items in the sales.';
                    // }
                    // action("List Price Sheet")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'List Price Sheet';
                    //     Image = "Report";
                    //     RunObject = Report 10148;
                    //     ToolTip = 'View a list of your items and their prices, for example, to send to customers. You can create the list for specific customers, campaigns, currencies, or other criteria.';
                    // }
                    action("Inventory - Sales &Back Orders")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Sales &Back Orders';
                        Image = "Report";
                        RunObject = Report 718;
                        ToolTip = 'View a list with the order lines whose shipment date has been exceeded. The following information is shown for the individual orders for each item: number, customer name, customer''s telephone number, shipment date, order quantity and quantity on back order. The report also shows whether there are other items for the customer on back order.';
                    }
                    // action("Sales Order Status")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Sales Order Status';
                    //     Image = "Report";
                    //     RunObject = Report 10158;
                    //     ToolTip = 'View the status of partially filled or unfilled orders so you can determine what effect filling these orders may have on your inventory. NOTE: The Amount Remaining column may include sales taxes and therefore may not match the result of multiplying the remaining amount times the unit price and subtracting the discounts.';
                    // }
                }
            }
            group(History)
            {
                Caption = 'History';
                action("Navi&gate")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Navi&gate';
                    Image = Navigate;
                    RunObject = Page Navigate;
                    ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
                }
            }

            action("P&ut-away Worksheet")
            {
                ApplicationArea = Warehouse;
                Caption = 'P&ut-away Worksheet';
                Image = PutAwayWorksheet;
                RunObject = Page 7352;
                ToolTip = 'Prepare and initialize item put-aways.';
            }
            action("Pi&ck Worksheet")
            {
                ApplicationArea = Warehouse;
                Caption = 'Pi&ck Worksheet';
                Image = PickWorksheet;
                RunObject = Page 7345;
                ToolTip = 'Plan and initialize picks of items. ';
            }
            action("M&ovement Worksheet")
            {
                ApplicationArea = Warehouse;
                Caption = 'M&ovement Worksheet';
                Image = MovementWorksheet;
                RunObject = Page 7351;
                ToolTip = 'Prepare to move items between bins within the warehouse.';
            }
            action("W&hse. Item Journal")
            {
                ApplicationArea = Warehouse;
                Caption = 'W&hse. Item Journal';
                Image = BinJournal;
                RunObject = Page 7324;
                ToolTip = 'Adjust the quantity of an item in a particular bin or bins. For instance, you might find some items in a bin that are not registered in the system, or you might not be able to pick the quantity needed because there are fewer items in a bin than was calculated by the program. The bin is then updated to correspond to the actual quantity in the bin. In addition, it creates a balancing quantity in the adjustment bin, for synchronization with item ledger entries, which you can then post with an item journal.';
            }
            action("Whse. Phys. &Invt. Journal")
            {
                ApplicationArea = Warehouse;
                Caption = 'Whse. Phys. &Invt. Journal';
                Image = InventoryJournal;
                RunObject = Page 7326;
                ToolTip = 'Prepare to count inventories by preparing the documents that warehouse employees use when they perform a physical inventory of selected items or of all the inventory. When the physical count has been made, you enter the number of items that are in the bins in this window, and then you register the physical inventory.';
            }
            action("Item &Tracing")
            {
                ApplicationArea = Warehouse;
                Caption = 'Item &Tracing';
                Image = ItemTracing;
                RunObject = Page 6520;
                ToolTip = 'Trace where a lot or serial number assigned to the item was used, for example, to find which lot a defective component came from or to find all the customers that have received items containing the defective component.';
            }
            separator("Customer&")
            {
                Caption = 'Customer';
                IsHeader = true;
            }

            // action("Sales Order Shipping")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Sales Order Shipping';
            //     Image = SalesShipment;
            //     RunObject = Page 36626;
            //     ToolTip = 'View the sales order shipping list.';
            // }
        }
    }
}

