page 50144 "Sales header"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Header";
    SourceTableView = sorting("No.") where("Document Type" = const(Order));
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
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Name 2"; "Bill-to Name 2")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address"; "Bill-to Address")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; "Bill-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Bill-to City"; "Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; "Bill-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Your Reference"; "Your Reference")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Code"; "Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name 2"; "Ship-to Name 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; "Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; "Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to City"; "Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; "Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; "Order Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Description"; "Posting Description")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Discount %"; "Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; "Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
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
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Currency Factor"; "Currency Factor")
                {
                    ApplicationArea = All;
                }
                field("Customer Price Group"; "Customer Price Group")
                {
                    ApplicationArea = All;
                }
                field("Prices Including VAT"; "Prices Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Invoice Disc. Code"; "Invoice Disc. Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Disc. Group"; "Customer Disc. Group")
                {
                    ApplicationArea = All;
                }
                field("Language Code"; "Language Code")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Order Class"; "Order Class")
                {
                    ApplicationArea = All;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                }
                field("No. Printed"; "No. Printed")
                {
                    ApplicationArea = All;
                }
                field("On Hold"; "On Hold")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. Type"; "Applies-to Doc. Type")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; "Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account No."; "Bal. Account No.")
                {
                    ApplicationArea = All;
                }
                field("Recalculate Invoice Disc."; "Recalculate Invoice Disc.")
                {
                    ApplicationArea = All;
                }
                field(Ship; Ship)
                {
                    ApplicationArea = All;
                }
                field(Invoice; Invoice)
                {
                    ApplicationArea = All;
                }
                field("Print Posted Documents"; "Print Posted Documents")
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
                field("Shipping No."; "Shipping No.")
                {
                    ApplicationArea = All;
                }
                field("Posting No."; "Posting No.")
                {
                    ApplicationArea = All;
                }
                field("Last Shipping No."; "Last Shipping No.")
                {
                    ApplicationArea = All;
                }
                field("Last Posting No."; "Last Posting No.")
                {
                    ApplicationArea = All;
                }
                field("Prepayment No."; "Prepayment No.")
                {
                    ApplicationArea = All;
                }
                field("Last Prepayment No."; "Last Prepayment No.")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Cr. Memo No."; "Prepmt. Cr. Memo No.")
                {
                    ApplicationArea = All;
                }
                field("Last Prepmt. Cr. Memo No."; "Last Prepmt. Cr. Memo No.")
                {
                    ApplicationArea = All;
                }
                field("VAT Registration No."; "VAT Registration No.")
                {
                    ApplicationArea = All;
                }
                field("Combine Shipments"; "Combine Shipments")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; "Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("EU 3-Party Trade"; "EU 3-Party Trade")
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
                field("VAT Country/Region Code"; "VAT Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name 2"; "Sell-to Customer Name 2")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address"; "Sell-to Address")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address 2"; "Sell-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Sell-to City"; "Sell-to City")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; "Sell-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; "Bill-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Bill-to County"; "Bill-to County")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Country/Region Code"; "Bill-to Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; "Sell-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Sell-to County"; "Sell-to County")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Country/Region Code"; "Sell-to Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to County"; "Ship-to County")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Country/Region Code"; "Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account Type"; "Bal. Account Type")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; "Exit Point")
                {
                    ApplicationArea = All;
                }
                field(Correction; Correction)
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; "External Document No.")
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
                field("Payment Method Code"; "Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Package Tracking No."; "Package Tracking No.")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; "No. Series")
                {
                    ApplicationArea = All;
                }
                field("Posting No. Series"; "Posting No. Series")
                {
                    ApplicationArea = All;
                }
                field("Shipping No. Series"; "Shipping No. Series")
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
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Reserve; Reserve)
                {
                    ApplicationArea = All;
                }
                field("Applies-to ID"; "Applies-to ID")
                {
                    ApplicationArea = All;
                }
                field("VAT Base Discount %"; "VAT Base Discount %")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Invoice Discount Calculation"; "Invoice Discount Calculation")
                {
                    ApplicationArea = All;
                }
                field("Invoice Discount Value"; "Invoice Discount Value")
                {
                    ApplicationArea = All;
                }
                field("Send IC Document"; "Send IC Document")
                {
                    ApplicationArea = All;
                }
                field("IC Status"; "IC Status")
                {
                    ApplicationArea = All;
                }
                field("Sell-to IC Partner Code"; "Sell-to IC Partner Code")
                {
                    ApplicationArea = All;
                }
                field("Bill-to IC Partner Code"; "Bill-to IC Partner Code")
                {
                    ApplicationArea = All;
                }
                field("IC Direction"; "IC Direction")
                {
                    ApplicationArea = All;
                }
                field("Prepayment %"; "Prepayment %")
                {
                    ApplicationArea = All;
                }
                field("Prepayment No. Series"; "Prepayment No. Series")
                {
                    ApplicationArea = All;
                }
                field("Compress Prepayment"; "Compress Prepayment")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Due Date"; "Prepayment Due Date")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Cr. Memo No. Series"; "Prepmt. Cr. Memo No. Series")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Posting Description"; "Prepmt. Posting Description")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Pmt. Discount Date"; "Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Terms Code"; "Prepmt. Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Discount %"; "Prepmt. Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Quote No."; "Quote No.")
                {
                    ApplicationArea = All;
                }
                field("Quote Valid Until Date"; "Quote Valid Until Date")
                {
                    ApplicationArea = All;
                }
                field("Quote Sent to Customer"; "Quote Sent to Customer")
                {
                    ApplicationArea = All;
                }
                field("Quote Accepted"; "Quote Accepted")
                {
                    ApplicationArea = All;
                }
                field("Quote Accepted Date"; "Quote Accepted Date")
                {
                    ApplicationArea = All;
                }
                field("Job Queue Status"; "Job Queue Status")
                {
                    ApplicationArea = All;
                }
                field("Job Queue Entry ID"; "Job Queue Entry ID")
                {
                    ApplicationArea = All;
                }
                field("Incoming Document Entry No."; "Incoming Document Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Last Email Sent Time"; "Last Email Sent Time")
                {
                    ApplicationArea = All;
                }
                field("Last Email Sent Status"; "Last Email Sent Status")
                {
                    ApplicationArea = All;
                }
                field("Sent as Email"; "Sent as Email")
                {
                    ApplicationArea = All;
                }
                field("Last Email Notif Cleared"; "Last Email Notif Cleared")
                {
                    ApplicationArea = All;
                }
                field(IsTest; IsTest)
                {
                    ApplicationArea = All;
                }
                field("Sell-to Phone No."; "Sell-to Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to E-Mail"; "Sell-to E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Payment Instructions Id"; "Payment Instructions Id")
                {
                    ApplicationArea = All;
                }
                field("Work Description"; "Work Description")
                {
                    ApplicationArea = All;
                }
                field("Amt. Ship. Not Inv. (LCY) Base"; "Amt. Ship. Not Inv. (LCY) Base")
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; "Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("Payment Service Set ID"; "Payment Service Set ID")
                {
                    ApplicationArea = All;
                }
                field("Direct Debit Mandate ID"; "Direct Debit Mandate ID")
                {
                    ApplicationArea = All;
                }
                field("Invoice Discount Amount"; "Invoice Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("No. of Archived Versions"; "No. of Archived Versions")
                {
                    ApplicationArea = All;
                }
                field("Doc. No. Occurrence"; "Doc. No. Occurrence")
                {
                    ApplicationArea = All;
                }
                field("Campaign No."; "Campaign No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Template Code"; "Sell-to Customer Template Code")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Contact No."; "Sell-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Contact No."; "Bill-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer Template Code"; "Bill-to Customer Template Code")
                {
                    ApplicationArea = All;
                }
                field("Opportunity No."; "Opportunity No.")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Shipping Advice"; "Shipping Advice")
                {
                    ApplicationArea = All;
                }
                field("Shipped Not Invoiced"; "Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Completely Shipped"; "Completely Shipped")
                {
                    ApplicationArea = All;
                }
                field("Posting from Whse. Ref."; "Posting from Whse. Ref.")
                {
                    ApplicationArea = All;
                }
                field(Shipped; Shipped)
                {
                    ApplicationArea = All;
                }
                field("Last Shipment Date"; "Last Shipment Date")
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
                field("Shipping Agent Service Code"; "Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                }
                field("Late Order Shipping"; "Late Order Shipping")
                {
                    ApplicationArea = All;
                }
                field("Date Filter"; "Date Filter")
                {
                    ApplicationArea = All;
                }
                field(Receive; Receive)
                {
                    ApplicationArea = All;
                }
                field("Return Receipt No."; "Return Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Return Receipt No. Series"; "Return Receipt No. Series")
                {
                    ApplicationArea = All;
                }
                field("Last Return Receipt No."; "Last Return Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Allow Line Disc."; "Allow Line Disc.")
                {
                    ApplicationArea = All;
                }
                field("Get Shipment Used"; "Get Shipment Used")
                {
                    ApplicationArea = All;
                }
                field("Assigned User ID"; "Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field("Applies-to ID for PDC"; "Applies-to ID for PDC")
                {
                    ApplicationArea = All;
                }
                field("Remaining Amount"; "Remaining Amount")
                {
                    ApplicationArea = All;
                }
                field("Order Amount LCPDC"; "Order Amount LCPDC")
                {
                    ApplicationArea = All;
                }
                field("PDC Applied Amount"; "PDC Applied Amount")
                {
                    ApplicationArea = All;
                }
                field("Export L.C. No."; "Export L.C. No.")
                {
                    ApplicationArea = All;
                }
                field("Discount Approval"; "Discount Approval")
                {
                    ApplicationArea = All;
                }
                field("Project Name"; "Project Name")
                {
                    ApplicationArea = All;
                }
                field("Project Reference"; "Project Reference")
                {
                    ApplicationArea = All;
                }
                field("Bank Guarantee No."; "Bank Guarantee No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Guarantee Date"; "Bank Guarantee Date")
                {
                    ApplicationArea = All;
                }
                field("Bank Guarantee Amount"; "Bank Guarantee Amount")
                {
                    ApplicationArea = All;
                }
                field("Security ChecK No."; "Security ChecK No.")
                {
                    ApplicationArea = All;
                }
                field("Check Date"; "Check Date")
                {
                    ApplicationArea = All;
                }
                field("Check Amount"; "Check Amount")
                {
                    ApplicationArea = All;
                }
                field("Date of Installation"; "Date of Installation")
                {
                    ApplicationArea = All;
                }
                field("Hourly Rate"; "Hourly Rate")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; "Start Time")
                {
                    ApplicationArea = All;
                }
                field("End Time"; "End Time")
                {
                    ApplicationArea = All;
                }
                field("Total Time"; "Total Time")
                {
                    ApplicationArea = All;
                }
                field("Installation Amount"; "Installation Amount")
                {
                    ApplicationArea = All;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = All;
                }
                field("Project Handover"; "Project Handover")
                {
                    ApplicationArea = All;
                }
                field("Estimated Order Value"; "Estimated Order Value")
                {
                    ApplicationArea = All;
                }
                field("LC No."; "LC No.")
                {
                    ApplicationArea = All;
                }
                field("LC Amount"; "LC Amount")
                {
                    ApplicationArea = All;
                }
                field("LC Payment Terms"; "LC Payment Terms")
                {
                    ApplicationArea = All;
                }
                field("Amount (In Arabic)"; "Amount (In Arabic)")
                {
                    ApplicationArea = All;
                }
                field("Retail Location"; "Retail Location")
                {
                    ApplicationArea = All;
                }
                field("Advance Payment"; "Advance Payment")
                {
                    ApplicationArea = All;
                }
                field("PO Reference"; "PO Reference")
                {
                    ApplicationArea = All;
                }
                field("Check Collected"; "Check Collected")
                {
                    ApplicationArea = All;
                }
                field(Priority; Priority)
                {
                    ApplicationArea = All;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = All;
                }
                field("Delivery Time"; "Delivery Time")
                {
                    ApplicationArea = All;
                }
                field("Sales Person Share"; "Sales Person Share")
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
                field("G/L Invoiced (LCY)"; "G/L Invoiced (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Non Stock Invoiced (LCY)"; "Non Stock Invoiced (LCY)")
                {
                    ApplicationArea = All;
                }
                field("G/L Invoiced (ACY)"; "G/L Invoiced (ACY)")
                {
                    ApplicationArea = All;
                }
                field("Non Stock Invoiced (ACY)"; "Non Stock Invoiced (ACY)")
                {
                    ApplicationArea = All;
                }
                field("UE Sales"; "UE Sales")
                {
                    ApplicationArea = All;
                }
                field("UE GP"; "UE GP")
                {
                    ApplicationArea = All;
                }
                field("UE Sales ACY"; "UE Sales ACY")
                {
                    ApplicationArea = All;
                }
                field("UE GP ACY"; "UE GP ACY")
                {
                    ApplicationArea = All;
                }
                field("Share %"; "Share %")
                {
                    ApplicationArea = All;
                }
                field("Withholding Tax (LCY)"; "Withholding Tax (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Withholding Tax (ACY)"; "Withholding Tax (ACY)")
                {
                    ApplicationArea = All;
                }
                field("Amt. Ship. Not Inv. (LCY)"; "Amt. Ship. Not Inv. (LCY)")
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
    }
}

