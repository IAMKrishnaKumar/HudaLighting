page 50125 "Acc.  Payable Activities"
{
    Caption = 'Acc.  Payable Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Acc Manager Activies Cue";

    layout
    {
        area(content)
        {
            cuegroup("Due Date")
            {
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

        Clear(RecNotofication);
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

            HLCues.Insert();
        end;
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

