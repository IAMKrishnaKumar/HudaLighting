pageextension 50151 CustList extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Contact)
        {
            field("Legal Registration Expiry Date"; "Legal Registration Expiry Date")
            {
                ApplicationArea = All;
                Enabled = false;
            }
        }
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