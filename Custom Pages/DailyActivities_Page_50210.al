page 50210 "Daily Activities"
{
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Daily Activities";
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = sorting("Business Unit");
    layout
    {
        area(Content)
        {
            group(Filters)
            {
                field(FromDate; FromDate)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        IF (FromDate <> 0D) AND (FromDate > ToDate) then
                            Error('From Date cannot be after To Date');
                        IF (FromDate <> 0D) AND (ToDate <> 0D) THEN
                            SETRANGE("Creation Date", FromDate, ToDate);
                    end;
                }
                field(ToDate; ToDate)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        IF (FromDate <> 0D) AND (ToDate <> 0D) AND (FromDate > ToDate) then
                            Error('From Date cannot be after To Date');
                        IF (FromDate <> 0D) AND (ToDate <> 0D) THEN
                            SETRANGE("Creation Date", FromDate, ToDate);
                    end;
                }
            }
            repeater(Group)
            {
                Editable = false;
                field("Business Unit"; "Business Unit")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Posted Document Type"; "Posted Document Type")
                {
                    ApplicationArea = All;
                }
                field("Unposted Document Type"; "Unposted Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }
                field("Source Code"; "Source Code")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; "Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Creation Time"; "Creation Time")
                {
                    ApplicationArea = All;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Load Data")
            {
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                VAR
                    CompanyInfo: Record "Company Information";
                begin
                    IF FromDate = 0D THEN
                        Error('From Date cannot be blank');

                    IF ToDate = 0D THEN
                        Error('To Date cannot be blank');
                    IF NOT CONFIRM('Do you want to load the posted and unposted data ?', TRUE) THEN EXIT;

                    DailyActivities.RESET;
                    DailyActivities.DELETEALL;

                    Companies.RESET;
                    IF Companies.FINDFIRST THEN
                        REPEAT
                            CompanyInfo.ChangeCompany(Companies.Name);
                            CompanyInfo.Get();
                            IF CompanyInfo."Daily Activity" THEN BEGIN


                                //DailyActivities.CHANGECOMPANY(Companies.Name);
                                Clear(CurrentRecord);
                                Clear(TotalRecords);
                                GLRegister.CHANGECOMPANY(Companies.Name);
                                GLEntry.CHANGECOMPANY(Companies.Name);
                                GLRegister.RESET;
                                GLRegister.SETRANGE("Creation Date", FromDate, ToDate);
                                IF GLRegister.FINDFIRST THEN BEGIN
                                    TotalRecords := GLRegister.Count;
                                    Window.OPEN('Processing Posted Data.... @1@@@@@@@@@@@@@');
                                    REPEAT
                                        CurrentRecord += 1;
                                        IF TotalRecords <> 0 THEN
                                            Window.Update(1, ROUND(CurrentRecord / TotalRecords * 10000, 1));
                                        GLEntry.RESET;
                                        GLEntry.SETRANGE("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
                                        IF GLEntry.FINDFIRST THEN BEGIN
                                            REPEAT
                                                IF NOT DailyActivities.GET(DailyActivities.Status::Posted, GLEntry."Document No.", Companies.Name) THEN BEGIN
                                                    DailyActivities.INIT;
                                                    DailyActivities.Status := DailyActivities.Status::Posted;
                                                    DailyActivities."Document No." := GLEntry."Document No.";
                                                    DailyActivities."Business Unit" := Companies.Name;
                                                    DailyActivities.INSERT;
                                                    DailyActivities."Posted Document Type" := GLEntry."Document Type".AsInteger();
                                                    DailyActivities."Posting Date" := GLEntry."Posting Date";
                                                    DailyActivities."User ID" := USERID;
                                                    DailyActivities."Source Code" := GLRegister."Source Code";
                                                    DailyActivities."Creation Date" := GLRegister."Creation Date";
                                                    DailyActivities."Created By" := GLRegister."User ID";
                                                    DailyActivities."Creation Time" := GLRegister."Creation Time";
                                                    DailyActivities.MODIFY;
                                                END;
                                            UNTIL GLEntry.NEXT = 0;
                                        END;
                                    UNTIL GLRegister.NEXT = 0;
                                    Window.Close();
                                END;
                                GenJournalLine.CHANGECOMPANY(Companies.Name);
                                GenJournalTemplate.CHANGECOMPANY(Companies.Name);

                                Clear(CurrentRecord);
                                Clear(TotalRecords);
                                GenJournalLine.RESET;
                                GenJournalLine.SETRANGE("Creation Date", FromDate, ToDate);
                                GenJournalLine.SETFILTER(Amount, '<>%1', 0);
                                IF GenJournalLine.FINDFIRST THEN BEGIN
                                    TotalRecords := GenJournalLine.Count;
                                    Window.OPEN('Processing UnPosted Data.... @1@@@@@@@@@@@@@');
                                    REPEAT
                                        CurrentRecord += 1;
                                        IF TotalRecords <> 0 THEN
                                            Window.Update(1, ROUND(CurrentRecord / TotalRecords * 10000, 1));
                                        GenJournalTemplate.GET(GenJournalLine."Journal Template Name");
                                        IF NOT DailyActivities.GET(DailyActivities.Status::UnPosted, GenJournalLine."Document No.", Companies.Name) THEN BEGIN
                                            DailyActivities.INIT;
                                            DailyActivities.Status := DailyActivities.Status::UnPosted;
                                            DailyActivities."Document No." := GenJournalLine."Document No.";
                                            DailyActivities."Business Unit" := Companies.Name;
                                            DailyActivities.INSERT;

                                            DailyActivities."UnPosted Document Type" := GenJournalTemplate.Type.AsInteger();//Added AsInteger to convert ENum to Option
                                            DailyActivities."Posting Date" := GenJournalLine."Posting Date";
                                            DailyActivities."User ID" := USERID;
                                            DailyActivities."Source Code" := GenJournalLine."Source Code";
                                            DailyActivities."Creation Date" := GenJournalLine."Creation Date";
                                            DailyActivities."Created By" := GenJournalLine."Created User";
                                            DailyActivities."Creation Time" := GenJournalLine."Creation Time";
                                            DailyActivities.MODIFY;
                                        END;
                                    UNTIL GenJournalLine.NEXT = 0;
                                    Window.Close();
                                END;

                                Clear(CurrentRecord);
                                Clear(TotalRecords);
                                WarehouseReceiptHeader.CHANGECOMPANY(Companies.Name);
                                WarehouseReceiptHeader.RESET;
                                WarehouseReceiptHeader.SETRANGE("Creation Date", FromDate, ToDate);
                                IF WarehouseReceiptHeader.FINDFIRST THEN BEGIN
                                    TotalRecords := WarehouseReceiptHeader.Count;
                                    Window.OPEN('Processing UnPosted Data.... @1@@@@@@@@@@@@@');
                                    REPEAT
                                        CurrentRecord += 1;
                                        IF TotalRecords <> 0 THEN
                                            Window.Update(1, ROUND(CurrentRecord / TotalRecords * 10000, 1));
                                        IF NOT DailyActivities.GET(DailyActivities.Status::UnPosted, WarehouseReceiptHeader."No.", Companies.Name) THEN BEGIN
                                            DailyActivities.INIT;
                                            DailyActivities.Status := DailyActivities.Status::UnPosted;
                                            DailyActivities."Document No." := WarehouseReceiptHeader."No.";
                                            DailyActivities."Business Unit" := Companies.Name;
                                            DailyActivities.INSERT;
                                            DailyActivities."UnPosted Document Type" := DailyActivities."UnPosted Document Type"::"Whse Receipt";
                                            DailyActivities."Posting Date" := WarehouseReceiptHeader."Posting Date";
                                            DailyActivities."User ID" := USERID;
                                            DailyActivities."Source Code" := '';
                                            DailyActivities."Creation Date" := WarehouseReceiptHeader."Creation Date";
                                            DailyActivities."Created By" := WarehouseReceiptHeader."Created User";
                                            DailyActivities."Creation Time" := WarehouseReceiptHeader."Creation Time";
                                            DailyActivities.MODIFY;
                                        END;
                                    UNTIL WarehouseReceiptHeader.NEXT = 0;
                                    Window.Close();
                                END;

                                Clear(CurrentRecord);
                                Clear(TotalRecords);
                                WarehouseShipmentHeader.CHANGECOMPANY(Companies.Name);
                                WarehouseShipmentHeader.RESET;
                                WarehouseShipmentHeader.SETRANGE("Creation Date", FromDate, ToDate);
                                IF WarehouseShipmentHeader.FINDFIRST THEN BEGIN
                                    TotalRecords := WarehouseShipmentHeader.Count;
                                    Window.OPEN('Processing UnPosted Data.... @1@@@@@@@@@@@@@');
                                    REPEAT
                                        CurrentRecord += 1;
                                        IF TotalRecords <> 0 THEN
                                            Window.Update(1, ROUND(CurrentRecord / TotalRecords * 10000, 1));
                                        IF NOT DailyActivities.GET(DailyActivities.Status::UnPosted, WarehouseShipmentHeader."No.", Companies.Name) THEN BEGIN
                                            DailyActivities.INIT;
                                            DailyActivities.Status := DailyActivities.Status::UnPosted;
                                            DailyActivities."Document No." := WarehouseShipmentHeader."No.";
                                            DailyActivities."Business Unit" := Companies.Name;
                                            DailyActivities.INSERT;
                                            DailyActivities."UnPosted Document Type" := DailyActivities."UnPosted Document Type"::"Whse Shipment";
                                            DailyActivities."Posting Date" := WarehouseShipmentHeader."Posting Date";
                                            DailyActivities."User ID" := USERID;
                                            DailyActivities."Source Code" := '';
                                            DailyActivities."Creation Date" := WarehouseShipmentHeader."Creation Date";
                                            DailyActivities."Created By" := WarehouseShipmentHeader."Created User";
                                            DailyActivities."Creation Time" := WarehouseShipmentHeader."Creation Time";
                                            DailyActivities.MODIFY;
                                        END;
                                    UNTIL WarehouseShipmentHeader.NEXT = 0;
                                    Window.Close();
                                END;

                                Clear(CurrentRecord);
                                Clear(TotalRecords);
                                SalesHeader.CHANGECOMPANY(Companies.Name);
                                SalesHeader.RESET;
                                SalesHeader.SETRANGE("Creation Date", FromDate, ToDate);
                                IF SalesHeader.FINDFIRST THEN BEGIN
                                    TotalRecords := SalesHeader.Count;
                                    Window.OPEN('Processing UnPosted Data.... @1@@@@@@@@@@@@@');
                                    REPEAT
                                        CurrentRecord += 1;
                                        IF TotalRecords <> 0 THEN
                                            Window.Update(1, ROUND(CurrentRecord / TotalRecords * 10000, 1));
                                        IF NOT DailyActivities.GET(DailyActivities.Status::UnPosted, SalesHeader."No.", Companies.Name) THEN BEGIN
                                            DailyActivities.INIT;
                                            DailyActivities.Status := DailyActivities.Status::UnPosted;
                                            DailyActivities."Document No." := SalesHeader."No.";
                                            DailyActivities."Business Unit" := Companies.Name;
                                            DailyActivities.INSERT;
                                            IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN
                                                DailyActivities."UnPosted Document Type" := DailyActivities."UnPosted Document Type"::"Sales Invoice"
                                            ELSE
                                                DailyActivities."UnPosted Document Type" := DailyActivities."UnPosted Document Type"::Sales;
                                            DailyActivities."Posting Date" := SalesHeader."Posting Date";
                                            DailyActivities."User ID" := USERID;
                                            DailyActivities."Source Code" := '';
                                            DailyActivities."Creation Date" := SalesHeader."Creation Date";
                                            DailyActivities."Created By" := SalesHeader."Created User";
                                            DailyActivities."Creation Time" := SalesHeader."Creation Time";
                                            DailyActivities.MODIFY;
                                        END;
                                    UNTIL SalesHeader.NEXT = 0;
                                    Window.Close();
                                END;

                                Clear(CurrentRecord);
                                Clear(TotalRecords);
                                PurchaseHeader.CHANGECOMPANY(Companies.Name);
                                PurchaseHeader.RESET;
                                PurchaseHeader.SETRANGE("Creation Date", FromDate, ToDate);
                                IF PurchaseHeader.FINDFIRST THEN BEGIN
                                    TotalRecords := PurchaseHeader.Count;
                                    Window.OPEN('Processing UnPosted Data.... @1@@@@@@@@@@@@@');
                                    REPEAT
                                        CurrentRecord += 1;
                                        IF TotalRecords <> 0 THEN
                                            Window.Update(1, ROUND(CurrentRecord / TotalRecords * 10000, 1));
                                        IF NOT DailyActivities.GET(DailyActivities.Status::UnPosted, PurchaseHeader."No.", Companies.Name) THEN BEGIN
                                            DailyActivities.INIT;
                                            DailyActivities.Status := DailyActivities.Status::UnPosted;
                                            DailyActivities."Document No." := PurchaseHeader."No.";
                                            DailyActivities."Business Unit" := Companies.Name;
                                            DailyActivities.INSERT;
                                            IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice THEN
                                                DailyActivities."UnPosted Document Type" := DailyActivities."UnPosted Document Type"::"Purchase Invoice"
                                            ELSE
                                                DailyActivities."UnPosted Document Type" := DailyActivities."UnPosted Document Type"::Purchases;

                                            DailyActivities."Posting Date" := PurchaseHeader."Posting Date";
                                            DailyActivities."User ID" := USERID;
                                            DailyActivities."Source Code" := '';
                                            DailyActivities."Creation Date" := PurchaseHeader."Creation Date";
                                            DailyActivities."Created By" := PurchaseHeader."Created User";
                                            DailyActivities."Creation Time" := PurchaseHeader."Creation Time";
                                            DailyActivities.MODIFY;
                                        END;
                                    UNTIL PurchaseHeader.NEXT = 0;
                                    Window.Close();
                                END;
                            END;
                        UNTIL Companies.NEXT = 0;
                    CurrPage.Update();
                end;
            }
            action(Navigate)
            {
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                VAR
                    Navigate: Page Navigate;

                BEGIN

                    Navigate.SetDoc("Posting Date", "Document No.");
                    Navigate.Run();

                END;
            }
        }
    }

    var
        DailyActivities: Record "Daily Activities";
        GLRegister: Record "G/L Register";
        CreationDate: Date;
        GLEntry: Record "G/L Entry";
        GLEntry2: Record "G/L Entry";
        Companies: Record Company;
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalLine: Record "Gen. Journal Line";
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        SalesHeader: Record "Sales Header";
        PurchaseHeader: Record "Purchase Header";
        Window: Dialog;
        TotalRecords: Integer;
        Records: Integer;
        FromDate: Date;
        ToDate: Date;
        CurrentRecord: Integer;

    trigger OnOpenPage()
    VAR

    BEGIN
        FromDate := WorkDate();
        ToDate := WorkDate();
        SETRANGE("Creation Date", FromDate, ToDate);
    END;
}