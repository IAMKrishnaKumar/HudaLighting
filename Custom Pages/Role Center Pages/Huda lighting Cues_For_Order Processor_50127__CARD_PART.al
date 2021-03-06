page 50124 "Account Manager Activity"
{
    Caption = 'Account Manager Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Acc Manager Activies Cue";

    layout
    {
        area(content)
        {
            cuegroup("Due Date")
            {
                field("BG Sales Order - Due"; "BG Sales Order - Due")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Guarantee-Due';
                    ToolTip = 'Bank Guarantee-Due';
                    trigger OnDrillDown()
                    var
                        SalesOrderList: Page "Sales Orders List";
                    begin
                        SalesOrderList.SetBGStyle();
                        SalesOrderList.SetTableView(SHeader);
                        SalesOrderList.Caption('Bank Guarantee-Due');
                        SalesOrderList.Run();
                    end;
                }
                field("LC Purchase Order - Due"; "LC Purchase Order - Due")
                {
                    ApplicationArea = All;
                    Caption = 'PO-LC-Due';

                    trigger OnDrillDown()
                    var
                        PurchOrderList: Page "Purchase Orders List";
                    begin
                        PurchOrderList.Editable(false);
                        PurchOrderList.SetTableView(PHeader);
                        PurchOrderList.Caption('PO-LC-Due');
                        PurchOrderList.Run();
                    end;
                }
                field("Customer Legal Reg Exp - Due"; "Customer Legal Reg Exp - Due")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Legal Registration Expiry-Due';
                    trigger OnDrillDown()
                    var
                        CustPage: Page "Customer List";
                    begin
                        CustPage.SetTableView(RecCust);
                        CustPage.Caption('Customer Legal Registration Expiry-Due');
                        CustPage.Run();
                    end;
                }
                field("LC Sales Order - Due"; "LC Sales Order - Due")
                {
                    ApplicationArea = All;
                    Caption = 'SO-LC-Due';
                    trigger OnDrillDown()
                    var
                        SalesOrderList: Page "Sales Orders List";
                    begin
                        SalesOrderList.SetLCStyle();
                        SalesOrderList.SetTableView(SHeader2);
                        SalesOrderList.Caption('SO-LC-Due');
                        SalesOrderList.Run();
                    end;
                }
                field("Retention-Pending Invoicing"; "Retention-Pending Invoicing")
                {
                    ApplicationArea = All;
                    Caption = 'Retention-Due';
                    trigger OnDrillDown()
                    var
                        PaymentMileStone: Page "Payment Milestone";
                    begin
                        PaymentMileStone.SetTableView(RecPm);
                        PaymentMileStone.Caption('Retention-Due');
                        PaymentMileStone.Run();
                    end;
                }
                field("Advance-Pending Invoice"; "Advance-Pending Invoice")
                {
                    ApplicationArea = All;
                    Caption = 'Advance-Pending Invoice';
                    //  Image = Info;
                    trigger OnDrillDown()
                    var
                        PaymentMileStone: Page "Payment Milestone";
                    begin
                        PaymentMileStone.SetTableView(RecPmForAdvance);
                        PaymentMileStone.Caption('Advance-Pending Invoice');
                        PaymentMileStone.Run();
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Set Up Cues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Set up the cues (status tiles) related to the role.';

                trigger OnAction()
                var
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GETTABLE(Rec);
                    CueSetup.OpenCustomizePageForCurrentUser(CueRecordRef.NUMBER);
                end;
            }
        }
    }

    trigger OnInit()
    var
        HLCues: Record "Acc Manager Activies Cue";
    begin
        Clear(HLCues);
        HLCues.SetFilter("Entry No", '<>%1', 0);
        if HLCues.FindSet() then
            HLCues.DeleteAll();

        HLCues.Init();
        Clear(BGCount);
        Clear(RecNotofication);
        Clear(DocType);
        DocType.SetRange("Entry No.", 1);
        if DocType.FindFirst() then begin
            RecNotofication.SetRange("Document Type", DocType."Document Type");
            if RecNotofication.FindFirst() then begin

                Clear(SHeader);
                SHeader.FilterGroup(2);
                SHeader.SetRange("Document Type", SHeader."Document Type"::Order);
                SHeader.SetFilter("Bank Guarantee Date", '>=%1', WorkDate());//'<>%1', BlankDate);
                SHeader.FilterGroup(0);
                SHeader.SetFilter("Bank Guarantee Date", '<=%1', CalcDate(RecNotofication."Due Date Formula", Today()));
                if SHeader.FindSet() then
                    HLCues."BG Sales Order - Due" := SHeader.Count();
            end;
        end;
        Clear(RecNotofication);
        Clear(LCCount);
        Clear(DocType);
        DocType.SetRange("Entry No.", 1);
        if DocType.FindFirst() then begin
            RecNotofication.SetRange("Document Type", DocType."Document Type");
            If RecNotofication.FindFirst() then begin
                Clear(PHeader);
                PHeader.FilterGroup(2);
                PHeader.SetRange("Document Type", PHeader."Document Type"::Order);
                PHeader.SetFilter("LC Exp Date", '>=%1', WorkDate());//'<>%1', BlankDate);
                PHeader.FilterGroup(0);
                PHeader.SetFilter("LC Exp Date", '<=%1', CalcDate(RecNotofication."Due Date Formula", Today()));
                if PHeader.FindSet() then
                    HLCues."LC Purchase Order - Due" := PHeader.Count();
            end;
        end;
        Clear(RecNotofication);
        Clear(LREDCount);
        Clear(DocType);
        DocType.SetRange("Entry No.", 3);
        if DocType.FindFirst() then begin
            RecNotofication.SetRange("Document Type", DocType."Document Type");
            If RecNotofication.FindFirst() then begin
                Clear(RecCust);
                RecCust.FilterGroup(2);
                RecCust.SetFilter("Legal Registration Expiry Date", '>=%1', WorkDate());//'<>%1', BlankDate);
                RecCust.FilterGroup(0);
                RecCust.SetFilter("Legal Registration Expiry Date", '<=%1', CalcDate(RecNotofication."Due Date Formula", Today()));
                if RecCust.FindSet() then
                    HLCues."Customer Legal Reg Exp - Due" := RecCust.Count();
            end;
        end;

        Clear(SOLCCount);
        Clear(RecNotofication);
        Clear(DocType);
        DocType.SetRange("Entry No.", 4);
        if DocType.FindFirst() then begin
            RecNotofication.SetRange("Document Type", DocType."Document Type");
            if RecNotofication.FindFirst() then begin
                Clear(SHeader2);
                SHeader2.FilterGroup(2);
                SHeader2.SetRange("Document Type", SHeader2."Document Type"::Order);
                SHeader2.SetFilter("LC Exp Date", '>=%1', WorkDate());//'<>%1', BlankDate);
                SHeader2.FilterGroup(0);
                SHeader2.SetFilter("LC Exp Date", '<=%1', CalcDate(RecNotofication."Due Date Formula", Today()));
                if SHeader2.FindSet() then
                    HLCues."LC Sales Order - Due" := SHeader2.Count();
            end;
        end;



        Clear(RetentionCount);
        Clear(RecNotofication);
        Clear(DocType);
        DocType.SetRange("Entry No.", 5);
        if DocType.FindFirst() then begin
            RecNotofication.SetRange("Document Type", DocType."Document Type");
            if RecNotofication.FindFirst() then begin
                Clear(RecPm);
                RecPm.FilterGroup(2);
                RecPm.SetRange("Document Type", RecPm."Document Type"::Invoice);
                RecPm.SetRange("Posting Type", RecPm."Posting Type"::Retention);
                RecPm.SetRange(IsPosted, true);
                RecPm.SetFilter("Due Date", '>=%1', WorkDate());//'<>%1', BlankDate);
                RecPm.FilterGroup(0);
                RecPm.SetFilter("Due Date", '<=%1', CalcDate(RecNotofication."Due Date Formula", Today()));
                if RecPm.FindSet() then
                    HLCues."Retention-Pending Invoicing" := RecPm.Count();
            end;
        end;


        Clear(InvoivedAdvance);
        Clear(RecPmForAdvance);
        RecPmForAdvance.SetRange("Document Type", RecPm."Document Type"::Invoice);
        RecPmForAdvance.SetRange("Posting Type", RecPm."Posting Type"::Advance);
        RecPmForAdvance.SetRange(Invoiced, false);
        if RecPmForAdvance.FindSet() then
            HLCues."Advance-Pending Invoice" := RecPmForAdvance.Count();

        HLCues.Insert();
    end;


    trigger OnOpenPage()
    var

    begin
        Clear(BGCount);
        Clear(RecNotofication);
        Clear(DocType);
        DocType.SetRange("Entry No.", 1);
        if DocType.FindFirst() then begin
            RecNotofication.SetRange("Document Type", DocType."Document Type");
            if RecNotofication.FindFirst() then begin

                Clear(SHeader);
                SHeader.FilterGroup(2);
                SHeader.SetRange("Document Type", SHeader."Document Type"::Order);
                SHeader.SetFilter("Bank Guarantee Date", '>=%1', WorkDate());//'<>%1', BlankDate);
                SHeader.FilterGroup(0);
                SHeader.SetFilter("Bank Guarantee Date", '<=%1', CalcDate(RecNotofication."Due Date Formula", Today()));
                if SHeader.FindSet() then
                    BGCount := SHeader.Count();
            end;
        end;
        Clear(RecNotofication);
        Clear(LCCount);
        Clear(DocType);
        DocType.SetRange("Entry No.", 1);
        if DocType.FindFirst() then begin
            RecNotofication.SetRange("Document Type", DocType."Document Type");
            If RecNotofication.FindFirst() then begin
                Clear(PHeader);
                PHeader.FilterGroup(2);
                PHeader.SetRange("Document Type", PHeader."Document Type"::Order);
                PHeader.SetFilter("LC Exp Date", '>=%1', WorkDate());//'<>%1', BlankDate);
                PHeader.FilterGroup(0);
                PHeader.SetFilter("LC Exp Date", '<=%1', CalcDate(RecNotofication."Due Date Formula", Today()));
                if PHeader.FindSet() then
                    LCCount := PHeader.Count();
            end;
        end;
        Clear(RecNotofication);
        Clear(LREDCount);
        Clear(DocType);
        DocType.SetRange("Entry No.", 3);
        if DocType.FindFirst() then begin
            RecNotofication.SetRange("Document Type", DocType."Document Type");
            If RecNotofication.FindFirst() then begin
                Clear(RecCust);
                RecCust.FilterGroup(2);
                RecCust.SetFilter("Legal Registration Expiry Date", '>=%1', WorkDate());//'<>%1', BlankDate);
                RecCust.FilterGroup(0);
                RecCust.SetFilter("Legal Registration Expiry Date", '<=%1', CalcDate(RecNotofication."Due Date Formula", Today()));
                if RecCust.FindSet() then
                    LREDCount := RecCust.Count();
            end;
        end;

        Clear(SOLCCount);
        Clear(RecNotofication);
        Clear(DocType);
        DocType.SetRange("Entry No.", 4);
        if DocType.FindFirst() then begin
            RecNotofication.SetRange("Document Type", DocType."Document Type");
            if RecNotofication.FindFirst() then begin
                Clear(SHeader2);
                SHeader2.FilterGroup(2);
                SHeader2.SetRange("Document Type", SHeader2."Document Type"::Order);
                SHeader2.SetFilter("LC Exp Date", '>=%1', WorkDate());//'<>%1', BlankDate);
                SHeader2.FilterGroup(0);
                SHeader2.SetFilter("LC Exp Date", '<=%1', CalcDate(RecNotofication."Due Date Formula", Today()));
                if SHeader2.FindSet() then
                    SOLCCount := SHeader2.Count();
            end;
        end;



        Clear(RetentionCount);
        Clear(RecNotofication);
        Clear(DocType);
        DocType.SetRange("Entry No.", 5);
        if DocType.FindFirst() then begin
            RecNotofication.SetRange("Document Type", DocType."Document Type");
            if RecNotofication.FindFirst() then begin
                Clear(RecPm);
                RecPm.FilterGroup(2);
                RecPm.SetRange("Document Type", RecPm."Document Type"::Invoice);
                RecPm.SetRange("Posting Type", RecPm."Posting Type"::Retention);
                RecPm.SetRange(IsPosted, true);
                RecPm.SetFilter("Due Date", '>=%1', WorkDate());//'<>%1', BlankDate);
                RecPm.FilterGroup(0);
                RecPm.SetFilter("Due Date", '<=%1', CalcDate(RecNotofication."Due Date Formula", Today()));
                if RecPm.FindSet() then
                    RetentionCount := RecPm.Count();
            end;
        end;


        Clear(InvoivedAdvance);
        Clear(RecPmForAdvance);
        RecPmForAdvance.SetRange("Document Type", RecPm."Document Type"::Invoice);
        RecPmForAdvance.SetRange("Posting Type", RecPm."Posting Type"::Advance);
        RecPmForAdvance.SetRange(Invoiced, false);
        if RecPmForAdvance.FindSet() then
            InvoivedAdvance := RecPmForAdvance.Count();
    end;


    var
        CueSetup: Codeunit 9701;
        UserTaskManagement: Codeunit 1174;
        ShowDocumentsPendingDodExchService: Boolean;

        BGCount: Integer;
        SHeader: Record "Sales Header";
        RecNotofication: Record "Notification Details";
        DocType: Record "Notification Document Type";
        BlankDate: Date;
        SHeader2: Record "Sales Header";
        LCCount: Integer;
        PHeader: Record "Purchase Header";
        LREDCount: Integer;
        RecCust: Record Customer;
        SOLCCount: Integer;
        RetentionCount: Integer;
        RecPm: Record "Payment Milestone";
        RecPmForAdvance: Record "Payment Milestone";
        InvoivedAdvance: Integer;



}

