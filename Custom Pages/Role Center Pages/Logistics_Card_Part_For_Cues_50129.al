page 50129 "Logistics Activity Cues"
{
    Caption = 'Logistics';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Logistics Cues";

    layout
    {
        area(content)
        {
            cuegroup("Due Date")
            {
                field("Available EXW"; "Available EXW")
                {
                    ApplicationArea = All;
                    Caption = 'Ready EXW This Week';
                    trigger OnDrillDown()
                    var
                        LogisTics: Page Logistics;
                    begin
                        LogisTics.SetTableView(Pline);
                        LogisTics.Caption('Ready EXW This Week');
                        LogisTics.Run();
                    end;
                }
                field("Shipments Arrival"; "Shipments Arrival")
                {
                    ApplicationArea = All;
                    Caption = 'Arriving This Week';
                    trigger OnDrillDown()
                    var
                        LogisTics: Page Logistics;
                    begin
                        LogisTics.SetTableView(Pline2);
                        LogisTics.Caption('Arriving This Week');
                        LogisTics.Run();
                    end;
                }
                field("Available EXW Retail"; "Available EXW Retail")
                {
                    ApplicationArea = All;
                    Caption = 'Ready EXW Retail This Week';
                    trigger OnDrillDown()
                    var
                        LogisTics: Page Logistics;
                    begin
                        LogisTics.SetTableView(Pline3);
                        LogisTics.Caption('Ready EXW Retail This Week ');
                        LogisTics.Run();
                    end;
                }
                field("Shipments Arrival Retail"; "Shipments Arrival Retail")
                {
                    ApplicationArea = All;
                    Caption = 'Arriving Retail This Week';
                    trigger OnDrillDown()
                    var
                        LogisTics: Page Logistics;
                    begin
                        LogisTics.SetTableView(Pline4);
                        LogisTics.Caption('Arriving Retail This Week');
                        LogisTics.Run();
                    end;
                }
                field("Late Shipments"; "Late Shipments")
                {
                    ApplicationArea = All;
                    Caption = 'Late Shipments';
                    trigger OnDrillDown()
                    var
                        LogisTics: Page Logistics;
                    begin
                        LogisTics.SetTableView(Pline5);
                        LogisTics.Caption('Late Shipments');
                        LogisTics.Run();
                    end;
                }
                field("Customer Blocked"; "Customer Blocked")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Blocked';
                    trigger OnDrillDown()
                    var
                        LogisTics: Page Logistics;
                    begin
                        LogisTics.SetTableView(Pline6);
                        LogisTics.Caption('Customer Blocked');
                        LogisTics.Run();
                    end;
                }
                field("Focused Deliveries"; "Focused Deliveries")
                {
                    ApplicationArea = All;
                    Caption = 'Focused Deliveries';
                    trigger OnDrillDown()
                    var
                        LogisTics: Page Logistics;
                    begin
                        LogisTics.SetTableView(Pline7);
                        LogisTics.Caption('Focused Deliveries');
                        LogisTics.Run();
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
        LogisticsCues: Record "Logistics Cues";
        DateFormulaL: DateFormula;
    begin
        Clear(LogisticsCues);
        LogisticsCues.SetFilter("Entry No.", '<>%1', 0);
        if LogisticsCues.FindSet() then
            LogisticsCues.DeleteAll();

        Evaluate(DateFormulaL, '+7D');

        LogisticsCues.Init();
        /// first
        Clear(Pline);
        Pline.SetFilter("Header Status", '=%1', Pline."Header Status"::Released);
        Pline.SetFilter("Document Type", '=%1', Pline."Document Type"::Order);
        Pline.SetFilter("Completely Received", '=%1', false);
        Pline.SetFilter(Type, '<>%1', Pline.Type::" ");
        Pline.SetFilter("Retail Location", '=%1', false);
        Pline.SetFilter("Expected Receipt Date", '%1..%2', WorkDate(), CalcDate(DateFormulaL, WorkDate()));
        if Pline.FindSet() then
            LogisticsCues."Available EXW" := Pline.Count();

        ///

        /// Second
        Clear(Pline2);
        // Pline2.FilterGroup(2);
        Pline2.SetFilter("Header Status", '=%1', Pline2."Header Status"::Released);
        Pline2.SetFilter("Document Type", '=%1', Pline2."Document Type"::Order);
        Pline2.SetFilter("Completely Received", '=%1', false);
        Pline2.SetFilter(Type, '<>%1', Pline2.Type::" ");
        Pline2.SetFilter("Retail Location", '=%1', false);
        Pline2.SetFilter("Promised Receipt Date", '%1..%2', WorkDate(), CalcDate(DateFormulaL, WorkDate()));
        //Pline2.FilterGroup(0);
        //Pline2.SetFilter("Promised Receipt Date", '<=%1', );
        if Pline2.FindSet() then
            LogisticsCues."Shipments Arrival" := Pline2.Count();
        ///


        /// Third
        Clear(Pline3);
        // Pline3.FilterGroup(2);
        Pline3.SetFilter("Header Status", '=%1', Pline3."Header Status"::Released);
        Pline3.SetFilter("Document Type", '=%1', Pline3."Document Type"::Order);
        Pline3.SetFilter("Completely Received", '=%1', false);
        Pline3.SetFilter(Type, '<>%1', Pline3.Type::" ");
        Pline3.SetFilter("Retail Location", '=%1', True);
        Pline3.SetFilter("Expected Receipt Date", '%1..%2', WorkDate(), CalcDate(DateFormulaL, WorkDate()));
        // Pline3.FilterGroup(0);
        //Pline3.SetFilter("Expected Receipt Date", '<=%1', CalcDate(DateFormulaL, WorkDate()));
        if Pline3.FindSet() then
            LogisticsCues."Available EXW Retail" := Pline3.Count();
        ///

        /// 4th
        Clear(Pline4);
        // Pline4.FilterGroup(2);
        Pline4.SetFilter("Header Status", '=%1', Pline4."Header Status"::Released);
        Pline4.SetFilter("Document Type", '=%1', Pline4."Document Type"::Order);
        Pline4.SetFilter("Completely Received", '=%1', false);
        Pline4.SetFilter(Type, '<>%1', Pline4.Type::" ");
        Pline4.SetFilter("Retail Location", '=%1', true);
        Pline4.SetFilter("Promised Receipt Date", '%1..%2', WorkDate(), CalcDate(DateFormulaL, WorkDate()));
        // Pline4.FilterGroup(0);
        // Pline4.SetFilter("Promised Receipt Date", '<=%1', CalcDate(DateFormulaL, WorkDate()));
        if Pline4.FindSet() then
            LogisticsCues."Shipments Arrival Retail" := Pline4.Count();
        ///


        /// 5th
        Clear(Pline5);
        // Pline5.FilterGroup(2);
        Pline5.SetFilter("Header Status", '=%1', Pline5."Header Status"::Released);
        Pline5.SetFilter("Document Type", '=%1', Pline5."Document Type"::Order);
        Pline5.SetFilter("Completely Received", '=%1', false);
        Pline5.SetFilter(Type, '<>%1', Pline5.Type::" ");
        Evaluate(DateFormulaL, '-7D');
        Pline5.SetFilter("Promised Receipt Date", '%1..%2', CalcDate(DateFormulaL, WorkDate()), WorkDate());
        // Pline5.FilterGroup(0);
        // Pline5.SetFilter("Promised Receipt Date", '<=%1', CalcDate(DateFormulaL, WorkDate()));
        if Pline5.FindSet() then
            LogisticsCues."Late Shipments" := Pline5.Count();
        ///
        /// 6th
        Clear(Pline6);
        Pline6.SetFilter("Header Status", '=%1', Pline6."Header Status"::Released);
        Pline6.SetFilter("Document Type", '=%1', Pline6."Document Type"::Order);
        Pline6.SetFilter("Completely Received", '=%1', false);
        Pline6.SetFilter(Type, '<>%1', Pline6.Type::" ");
        Pline6.SetRange(ClientPayment, Pline6.ClientPayment::All);
        if Pline6.FindSet() then
            LogisticsCues."Customer Blocked" := Pline6.Count();
        ///

        /// 6th
        Clear(Pline7);
        Pline7.SetFilter("Header Status", '=%1', Pline7."Header Status"::Released);
        Pline7.SetFilter("Document Type", '=%1', Pline7."Document Type"::Order);
        Pline7.SetFilter("Completely Received", '=%1', false);
        Pline7.SetFilter(Type, '<>%1', Pline7.Type::" ");
        Pline7.SetRange(Priority, true);
        if Pline7.FindSet() then
            LogisticsCues."Focused Deliveries" := Pline7.Count();
        ///

        LogisticsCues.Insert();

    end;



    var
        CueSetup: Codeunit 9701;
        UserTaskManagement: Codeunit 1174;
        ShowDocumentsPendingDodExchService: Boolean;
        Pline: Record "Purchase Line";
        Pline2: Record "Purchase Line";
        Pline3: Record "Purchase Line";
        Pline4: Record "Purchase Line";
        Pline5: Record "Purchase Line";
        Pline6: Record "Purchase Line";
        Pline7: Record "Purchase Line";

}

