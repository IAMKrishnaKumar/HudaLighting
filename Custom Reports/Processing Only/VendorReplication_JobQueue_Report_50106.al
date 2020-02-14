report 50106 "Vendor Replication"
{
    // UsageCategory = Administration;
    // ApplicationArea = All;
    UseRequestPage = false;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
        }
    }


    trigger OnPreReport()
    var
        Rec: Record Vendor;
        RecCompany: Record Company;
        RecCompanyInfo: Record "Company Information";
        RecVendor: Record Vendor;
        PnPSetup: Record "Purchases & Payables Setup";
        RecVendorSuper: Record Vendor;
    begin
        /*
            
        */
        RecCompanyInfo.get();
        if not RecCompanyInfo."Vendor Replication Master" then
            exit;
        Clear(RecVendorSuper);
        RecVendorSuper.SetRange("Vendor master Replicated", false);
        RecVendorSuper.Setfilter(Name, '<>%1', '');
        RecVendorSuper.Setfilter(Address, '<>%1', '');
        RecVendorSuper.Setfilter("Country/Region Code", '<>%1', '');
        RecVendorSuper.Setfilter("Gen. Bus. Posting Group", '<>%1', '');
        RecVendorSuper.Setfilter("Vendor Posting Group", '<>%1', '');
        RecVendorSuper.Setfilter("Currency Code", '<>%1', '');
        if RecVendorSuper.FindSet() then begin
            repeat
                if RecVendorSuper."Vendor master Replicated" = false then begin
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
                                    RecVendor.Validate("Payment Method Code", Rec."Payment Method Code");
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
    end;


    var
        myInt: Integer;
}