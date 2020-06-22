pageextension 50117 VendorCradExt extends "Vendor Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Search Name")
        {
            field("Vendor Insurance company"; "Vendor Insurance company")
            {
                ApplicationArea = All;
            }
            field("GP Reference"; "GP Reference")
            {
                ApplicationArea = All;
                Caption = 'GP Reference No.';
            }
            field("Payment Terms Code_"; "Payment Terms Code")
            {
                ApplicationArea = All;
                Caption = 'Payment Terms Code';
            }
            field("Payment Method Code_"; "Payment Method Code")
            {
                ApplicationArea = All;
                Caption = 'Payment Method Code';
            }
        }
        modify("Payment Terms Code")
        {
            Visible = false;
        }
        modify("Payment Method Code")
        {
            Visible = false;
        }
        modify("Document Sending Profile")
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
        addafter("Balance Due (LCY)")
        {
            field("Credit Limit"; "Credit Limit")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Maximum Amount allowed to Purchase from Vendor.';
            }
            field("Available Credit Limit"; "Available Credit Limit")
            {
                ApplicationArea = All;
                Enabled = false;
                ToolTip = 'Indicates the Available Credit Limit to Purchase from Vendor. (Credit Limit - Balance - Outstanding Orders - Amt. Rcd. Not Invoiced)';
            }
            field("Vendor master Replicated"; "Vendor master Replicated")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        modify(Control82)
        {
            Visible = false;
            //Vendor picture card- Disabled
        }
        addafter("Balance (LCY)")
        {
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
        addbefore(Templates)
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
                begin
                    RecCompanyInfo.get();
                    RecCompanyInfo.TestField("Vendor Replication Master", true);

                    if Rec."Vendor master Replicated" = false then begin
                        if not Confirm('Are you sure you want to replicate Vendor to other companies?', false) then
                            exit;
                        Rec.TestField(Name);
                        Rec.TestField(Address);
                        Rec.TestField("Country/Region Code");
                        Rec.TestField("Gen. Bus. Posting Group");
                        Rec.TestField("Vendor Posting Group");
                        Rec.TestField("Currency Code");
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
                                    RecVendor.SetFilter("No.", '=%1', Rec."No.");
                                    if not RecVendor.FindFirst() then begin
                                        RecVendor.Init();
                                        RecVendor.Validate("No.", Rec."No.");
                                        RecVendor.Validate(Name, Rec.Name);
                                        RecVendor.Validate(Address, Rec.Address);
                                        RecVendor.Validate("Post Code", Rec."Post Code");
                                        RecVendor.Validate("Country/Region Code", Rec."Country/Region Code");
                                        //  RecVendor.Validate("VAT Registration No.", Rec."VAT Registration No.");
                                        RecVendor.Validate("Currency Code", Rec."Currency Code");
                                        RecVendor.Validate("Payment Terms Code", Rec."Payment Terms Code");
                                        RecVendor.Validate("Payment Method Code", Rec."Payment Method Code");
                                        if Rec."Country/Region Code" = RecCompanyInfo."Country/Region Code" then begin
                                            RecVendor.Validate("Gen. Bus. Posting Group", PnPSetup."Domestic Gen Bus Grp");
                                            RecVendor.Validate("Vendor Posting Group", PnPSetup."Domestic Vendor posting group");
                                        end else begin
                                            RecVendor.Validate("Gen. Bus. Posting Group", PnPSetup."Foreign Gen Bus Grp");
                                            RecVendor.Validate("Vendor Posting Group", PnPSetup."Foreign Vendor posting Group");
                                        end;
                                        RecVendor.Validate("Privacy Blocked", true);
                                        if RecVendor.Insert(true) then;
                                    end else begin
                                        RecVendor.Validate(Name, Rec.Name);
                                        RecVendor.Validate(Address, Rec.Address);
                                        RecVendor.Validate("Post Code", Rec."Post Code");
                                        RecVendor.Validate("Country/Region Code", Rec."Country/Region Code");
                                        RecVendor.Validate("VAT Registration No.", Rec."VAT Registration No.");
                                        RecVendor.Validate("Currency Code", Rec."Currency Code");
                                        RecVendor.Validate("Payment Terms Code", Rec."Payment Terms Code");
                                        if Rec."Country/Region Code" = RecCompanyInfo."Country/Region Code" then begin
                                            RecVendor.Validate("Gen. Bus. Posting Group", PnPSetup."Domestic Gen Bus Grp");
                                            RecVendor.Validate("Vendor Posting Group", PnPSetup."Domestic Vendor posting group");
                                        end else begin
                                            RecVendor.Validate("Gen. Bus. Posting Group", PnPSetup."Foreign Gen Bus Grp");
                                            RecVendor.Validate("Vendor Posting Group", PnPSetup."Foreign Vendor posting Group");
                                        end;
                                        RecVendor.Validate("Privacy Blocked", true);
                                        if RecVendor.Modify(true) then;
                                    end;
                                end;
                            until RecCompany.Next() = 0;
                        end;
                        Clear(PnPSetup);
                        Clear(RecCompanyInfo);
                        Clear(RecCompany);
                        Clear(RecVendor);
                        RecVendor.SetFilter("No.", Rec."No.");
                        if RecVendor.FindFirst() then begin
                            RecVendor."Vendor master Replicated" := true;
                            RecVendor.Modify();
                        end;

                        Message('Vendor replicated successfully.');
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