pageextension 50166 CustCard extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here

        addbefore("Salesperson Code")
        {
            field("Legal Registration Expiry Date"; "Legal Registration Expiry Date")
            {
                ApplicationArea = All;
            }
            field("GP Reference"; "GP Reference")
            {
                ApplicationArea = All;
            }
        }
        addafter("Gen. Bus. Posting Group")
        {
            field("VAT Bus. Posting Group_"; "VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'VAT Bus. Posting Group';
            }

        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        addafter("Privacy Blocked")
        {
            field("VAT Registration No._"; "VAT Registration No.")
            {
                ApplicationArea = ALl;
                Caption = 'VAT Registration No.';
            }
            field("Payment Terms Code_"; "Payment Terms Code")
            {
                ApplicationArea = ALl;
                Caption = 'Payment Terms Code';
            }
        }
        modify("VAT Registration No.")
        {
            Visible = false;
        }
        modify("Payment Terms Code")
        {
            Visible = false;
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Document Sending Profile")
        {
            Visible = false;
        }
        addafter(Name)
        {
            field("Name - Arabic"; "Name - Arabic")
            {
                ApplicationArea = All;
            }
        }
        addafter(Address)
        {
            field("Address-Arabic"; "Address-Arabic")
            {
                ApplicationArea = All;
            }
        }
        addafter("Address 2")
        {
            field("Address 2 - Arabic"; "Address 2 - Arabic")
            {
                ApplicationArea = All;
            }
        }
        //Avinash
        addafter("Balance (LCY)")
        {
            field("Advance Paid To Customer"; "Advance Paid To Customer")
            {
                Caption = 'Advance received (LCY)';
                Editable = false;
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    CustomerLedgEntryRec.RESET;
                    CustomerLedgEntryRec.SETRANGE("Customer No.", "No.");
                    CustomerLedgEntryRec.SetRange("Advance Paid To Customer Bool", true);
                    IF GETFILTER("Date Filter") <> '' THEN
                        CustomerLedgEntryRec.SETFILTER("Posting Date", '<=%1', GETRANGEMAX("Date Filter"));
                    // IF CustomerLedgEntryRec.FINDSET THEN
                    //     REPEAT
                    //         GLEntryRecG.RESET;
                    //         GLEntryRecG.SETRANGE("G/L Account No.", '201610');
                    //         GLEntryRecG.SETRANGE("Document No.", CustomerLedgEntryRec."Document No.");
                    //         GLEntryRecG.SETRANGE("Source Type", GLEntryRecG."Source Type"::Customer);
                    //         GLEntryRecG.SETRANGE("Source No.", "No.");
                    //         IF GLEntryRecG.FINDFIRST THEN BEGIN
                    //             CustomerLedgEntryRec.MARK(TRUE);
                    //         END;
                    //     UNTIL CustomerLedgEntryRec.NEXT = 0;
                    // CustomerLedgEntryRec.MARKEDONLY(TRUE);
                    PAGE.RUN(0, CustomerLedgEntryRec);
                end;

            }
        }
    }


    actions
    {
        // Add changes to page actions here
    }

    var
        CustomerLedgEntryRec: Record "Cust. Ledger Entry";
        GLEntryRecG: Record "G/L Entry";
        AdvancereceivedLCYG: Decimal;


    // trigger OnAfterGetRecord()
    // begin
    //     AdvancereceivedLCYG := 0;
    //     CustomerLedgEntryRec.RESET;
    //     CustomerLedgEntryRec.SETRANGE("Customer No.", "No.");
    //     IF GETFILTER("Date Filter") <> '' THEN
    //         CustomerLedgEntryRec.SETFILTER("Posting Date", '<=%1', GETRANGEMAX("Date Filter"));
    //     IF CustomerLedgEntryRec.FINDSET THEN
    //         REPEAT
    //             GLEntryRecG.RESET;
    //             GLEntryRecG.SETRANGE("G/L Account No.", '201610');
    //             GLEntryRecG.SETRANGE("Document No.", CustomerLedgEntryRec."Document No.");
    //             GLEntryRecG.SETRANGE("Source Type", GLEntryRecG."Source Type"::Customer);
    //             GLEntryRecG.SETRANGE("Source No.", "No.");
    //             IF GLEntryRecG.FINDFIRST THEN BEGIN
    //                 CustomerLedgEntryRec.CALCFIELDS("Amount (LCY)");
    //                 AdvancereceivedLCYG += CustomerLedgEntryRec."Amount (LCY)";
    //             END;
    //         UNTIL CustomerLedgEntryRec.NEXT = 0;
    // end;
}