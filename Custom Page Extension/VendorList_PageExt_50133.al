pageextension 50133 VendorList extends "Vendor List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Balance (LCY)")
        {
            field("Vendor master Replicated"; "Vendor master Replicated")
            {
                ApplicationArea = All;
                Enabled = false;
            }
            field("Advance Paid To Vendor"; "Advance Paid To Vendor")
            {
                Caption = 'Advance Paid (LCY)';
                ApplicationArea = All;
                Editable = false;
                trigger OnDrillDown()
                begin
                    VendorLedgEntryRec.RESET;
                    VendorLedgEntryRec.SETRANGE("Vendor No.", "No.");
                    VendorLedgEntryRec.SetRange("Advance Paid To Vendor Bool", true);
                    IF GETFILTER("Date Filter") <> '' THEN
                        VendorLedgEntryRec.SETFILTER("Posting Date", '<=%1', GETRANGEMAX("Date Filter"));

                    // IF VendorLedgEntryRec.FINDSET THEN
                    //     REPEAT
                    //         GLEntryRecG.RESET;
                    //         GLEntryRecG.SETRANGE("G/L Account No.", '103370');
                    //         GLEntryRecG.SETRANGE("Document No.", VendorLedgEntryRec."Document No.");
                    //         GLEntryRecG.SETRANGE("Source Type", GLEntryRecG."Source Type"::Vendor);
                    //         GLEntryRecG.SETRANGE("Source No.", "No.");
                    //         IF GLEntryRecG.FINDFIRST THEN BEGIN
                    //             VendorLedgEntryRec.MARK(TRUE);
                    //         END;
                    //     UNTIL VendorLedgEntryRec.NEXT = 0;
                    // VendorLedgEntryRec.MARKEDONLY(TRUE);
                    PAGE.RUN(0, VendorLedgEntryRec);
                end;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
        addafter(History)
        {

            action("Replicate Vendor")
            {
                ApplicationArea = All;
                Image = RefreshPlanningLine;
                trigger OnAction()
                var
                    RecCompany: Record Company;
                    RecCompanyInfo: Record "Company Information";
                    RecVendor: Record Vendor;
                    PnPSetup: Record "Purchases & Payables Setup";
                    RecVendorSuper: Record Vendor;
                begin
                    Rec.TestField(Name);
                    Rec.TestField(Address);
                    Rec.TestField("Country/Region Code");
                    Rec.TestField("Gen. Bus. Posting Group");
                    Rec.TestField("Vendor Posting Group");
                    Rec.TestField("Currency Code");
                    Clear(RecVendorSuper);
                    CurrPage.SetSelectionFilter(RecVendorSuper);
                    if RecVendorSuper.FindSet() then begin
                        repeat
                            RecCompanyInfo.get();
                            RecCompanyInfo.TestField("Vendor Replication Master", true);
                            if RecVendorSuper."Vendor master Replicated" = false then begin
                                if not Confirm('Are you sure you want to replicate Vendor to other companies?', false) then
                                    exit;
                                Clear(RecCompany);
                                RecCompany.SetFilter(Name, '<>%1', CompanyName);
                                if RecCompany.FindSet() then begin
                                    repeat
                                        Clear(RecCompanyInfo);
                                        RecCompanyInfo.ChangeCompany(RecCompany.Name);
                                        RecCompanyInfo.GET();
                                        if RecCompanyInfo."Replicate Vendor" then begin
                                            Clear(PnPSetup);
                                            PnPSetup.ChangeCompany(RecCompany.Name);
                                            PnPSetup.Get();
                                            PnPSetup.TestField("Domestic Gen Bus Grp");
                                            PnPSetup.TestField("Domestic Vendor posting group");
                                            PnPSetup.TestField("Foreign Vendor posting Group");
                                            PnPSetup.TestField("Foreign Gen Bus Grp");
                                            Clear(RecVendor);
                                            RecVendor.ChangeCompany(RecCompany.Name);
                                            RecVendor.SetFilter("No.", '=%1', RecVendorSuper."No.");
                                            if not RecVendor.FindFirst() then begin
                                                RecVendor.Init();
                                                RecVendor.Validate("No.", RecVendorSuper."No.");
                                                RecVendor.Validate(Name, RecVendorSuper.Name);
                                                RecVendor.Validate(Address, RecVendorSuper.Address);
                                                RecVendor.Validate("Post Code", RecVendorSuper."Post Code");
                                                RecVendor.Validate("Country/Region Code", RecVendorSuper."Country/Region Code");
                                                // RecVendor.Validate("VAT Registration No.", RecVendorSuper."VAT Registration No.");
                                                RecVendor.Validate("Currency Code", RecVendorSuper."Currency Code");
                                                RecVendor.Validate("Payment Terms Code", RecVendorSuper."Payment Terms Code");
                                                if RecVendorSuper."Country/Region Code" = RecCompanyInfo."Country/Region Code" then begin
                                                    RecVendor.Validate("Gen. Bus. Posting Group", PnPSetup."Domestic Gen Bus Grp");
                                                    RecVendor.Validate("Vendor Posting Group", PnPSetup."Domestic Vendor posting group");
                                                end else begin
                                                    RecVendor.Validate("Gen. Bus. Posting Group", PnPSetup."Foreign Gen Bus Grp");
                                                    RecVendor.Validate("Vendor Posting Group", PnPSetup."Foreign Vendor posting Group");
                                                end;
                                                RecVendor.Validate("Privacy Blocked", TRUE);
                                                if RecVendor.Insert(true) then;
                                            end else begin
                                                RecVendor.Validate(Name, RecVendorSuper.Name);
                                                RecVendor.Validate(Address, RecVendorSuper.Address);
                                                RecVendor.Validate("Post Code", RecVendorSuper."Post Code");
                                                RecVendor.Validate("Country/Region Code", RecVendorSuper."Country/Region Code");
                                                RecVendor.Validate("VAT Registration No.", RecVendorSuper."VAT Registration No.");
                                                RecVendor.Validate("Currency Code", RecVendorSuper."Currency Code");
                                                RecVendor.Validate("Payment Terms Code", RecVendorSuper."Payment Terms Code");
                                                RecVendor.Validate("Payment Method Code", RecVendorSuper."Payment Method Code");
                                                if RecVendorSuper."Country/Region Code" = RecCompanyInfo."Country/Region Code" then begin
                                                    RecVendor.Validate("Gen. Bus. Posting Group", PnPSetup."Domestic Gen Bus Grp");
                                                    RecVendor.Validate("Vendor Posting Group", PnPSetup."Domestic Vendor posting group");
                                                end else begin
                                                    RecVendor.Validate("Gen. Bus. Posting Group", PnPSetup."Foreign Gen Bus Grp");
                                                    RecVendor.Validate("Vendor Posting Group", PnPSetup."Foreign Vendor posting Group");
                                                end;
                                                RecVendor.Validate("Privacy Blocked", TRUE);
                                                if RecVendor.Modify(true) then;
                                            end;
                                        end;
                                    until RecCompany.Next() = 0;
                                end;
                                Clear(PnPSetup);
                                Clear(RecCompanyInfo);
                                Clear(RecCompany);
                                Clear(RecVendor);
                                RecVendor.SetFilter("No.", RecVendorSuper."No.");
                                if RecVendor.FindFirst() then begin
                                    RecVendor."Vendor master Replicated" := true;
                                    RecVendor.Modify();
                                end;
                            end;
                        until RecVendorSuper.Next() = 0;
                    end;
                    Message('Vendor replicated successfully.');
                end;
            }

            action("Unblock Vendors")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    RecVendor: Record Vendor;
                begin
                    Clear(RecVendor);
                    RecVendor.SetFilter("No.", '<>%1', '');
                    if RecVendor.FindSet() then begin
                        if not Confirm('Are you sure you want uncheck the privacy blocked for all the vendors?', false) then
                            exit;
                        repeat
                            RecVendor.Validate("Privacy Blocked", false);
                            RecVendor.Modify();
                        until RecVendor.Next() = 0;
                    end;
                end;
            }
        }
    }



    var
        VendorLedgEntryRec: Record "Vendor Ledger Entry";
        GLEntryRecG: Record "G/L Entry";
        AdvancePaidLCYG: Decimal;


    // trigger OnAfterGetRecord()
    // begin
    //     AdvancePaidLCYG := 0;
    //     VendorLedgEntryRec.RESET;
    //     VendorLedgEntryRec.SETRANGE("Vendor No.", "No.");
    //     IF GETFILTER("Date Filter") <> '' THEN
    //         VendorLedgEntryRec.SETFILTER("Posting Date", '<=%1', GETRANGEMAX("Date Filter"));
    //     IF VendorLedgEntryRec.FINDSET THEN
    //         REPEAT
    //             GLEntryRecG.RESET;
    //             GLEntryRecG.SETRANGE("G/L Account No.", '103370');
    //             GLEntryRecG.SETRANGE("Document No.", VendorLedgEntryRec."Document No.");
    //             GLEntryRecG.SETRANGE("Source Type", GLEntryRecG."Source Type"::Vendor);
    //             GLEntryRecG.SETRANGE("Source No.", "No.");
    //             IF GLEntryRecG.FINDFIRST THEN BEGIN
    //                 VendorLedgEntryRec.CALCFIELDS("Amount (LCY)");
    //                 AdvancePaidLCYG += VendorLedgEntryRec."Amount (LCY)";
    //             END;
    //         UNTIL VendorLedgEntryRec.NEXT = 0;
    // end;

}