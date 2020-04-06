page 50109 "Sales Order Holistic View"
{
    PageType = List;
    Caption = 'Holistic View';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Line";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Sales Order No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Article No"; "Vendor Article No")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Sales Order Quantity"; Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order Qty.';
                }
                field("Reserved Quantity"; "Reserved Quantity")
                {
                    ApplicationArea = All;
                }
                field("HL_Purchase Order No."; "HL_Purchase Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Order No.';
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        PurchHeader: Record "Purchase Header";
                        PurchLine: Record "Purchase Line";
                        PurchOrderCard: Page "Purchase Order";
                    begin
                        Clear(PurchHeader);
                        PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                        PurchHeader.SetRange("No.", "HL_Purchase Order No.");
                        if PurchHeader.FindFirst() then begin
                            PurchOrderCard.SetTableView(PurchHeader);
                            PurchOrderCard.Run();
                        end;
                    end;
                }
                field("PO Qty"; "PO Qty")
                {
                    ApplicationArea = All;
                }
                field("Pending Quantity"; (Quantity - "Reserved Quantity"))
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Order Qty.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Refresh)
            {
                ApplicationArea = All;
                Image = Refresh;
                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }


            action("Update Shipment Date")
            {
                ApplicationArea = All;
                Image = ChangeDates;

                trigger OnAction()
                var
                    ShipmentDateReport: Report "Date Selection";
                    Sline: Record "Sales Line";
                    SelectedDate: Date;
                begin
                    Clear(Sline);
                    CurrPage.SetSelectionFilter(Sline);
                    if Sline.FindSet() then begin
                        ShipmentDateReport.UseRequestPage(true);
                        ShipmentDateReport.RunModal();
                        SelectedDate := ShipmentDateReport.GetDate();
                        if SelectedDate <> 0D then begin
                            if not Confirm('Are you sure you want to update Shipment Date?', false) then
                                exit;
                            repeat
                                Sline.SuspendStatusCheck(true);
                                Sline.Validate("Shipment Date", SelectedDate);
                                Sline.Modify();
                            until Sline.Next() = 0;
                        end;
                    end;
                end;
            }



            action("Remove Shipment Date")
            {
                ApplicationArea = All;
                Image = RemoveLine;
                trigger OnAction()
                var
                    Sline: Record "Sales Line";
                begin
                    Clear(Sline);
                    CurrPage.SetSelectionFilter(Sline);
                    if Sline.FindSet() then begin
                        if not Confirm('Are you sure you want to remove Shipment Date?', false) then
                            exit;
                        repeat
                            Sline.SuspendStatusCheck(true);
                            Sline.Validate("Shipment Date", 0D);
                            Sline.Modify();
                        until Sline.Next() = 0;
                    end;
                end;
            }



        }
    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        Rec.CalcFields("Reserved Quantity");
    end;

    var
        myInt: Integer;
}