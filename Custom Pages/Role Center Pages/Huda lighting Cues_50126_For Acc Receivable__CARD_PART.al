page 50126 "Acc Receivable Activity"
{
    Caption = 'Acc Receivable Activity';
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
                        SalesOrderList.Caption('Bank Guarantee-Due');
                        SalesOrderList.SetTableView(SHeader);
                        SalesOrderList.Run();
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


        Clear(RecPmForAdvance);
        RecPmForAdvance.SetRange("Document Type", RecPm."Document Type"::Invoice);
        RecPmForAdvance.SetRange("Posting Type", RecPm."Posting Type"::Advance);
        RecPmForAdvance.SetRange(Invoiced, false);
        if RecPmForAdvance.FindSet() then
            HLCues."Advance-Pending Invoice" := RecPmForAdvance.Count();

        HLCues.Insert();
    end;



    var
        CueSetup: Codeunit 9701;
        UserTaskManagement: Codeunit 1174;
        ShowDocumentsPendingDodExchService: Boolean;
        SHeader: Record "Sales Header";
        RecNotofication: Record "Notification Details";
        DocType: Record "Notification Document Type";
        BlankDate: Date;
        SHeader2: Record "Sales Header";
        PHeader: Record "Purchase Header";
        RecCust: Record Customer;
        RecPm: Record "Payment Milestone";
        RecPmForAdvance: Record "Payment Milestone";

}

