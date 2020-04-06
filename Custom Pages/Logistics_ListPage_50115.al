page 50115 "Logistics History"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Purchase Line";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                // IndentationColumn = 0;
                field("Sales Order No."; "HL Sales Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Sales Order No.';
                }
                field(Date; "Order Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Order Date';
                }
                field(City; SalesCity)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'City';
                }
                field("Sales Person"; SalesPerson)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Sales Person';
                }
                field("Customer No."; "Sell To Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Customer No.';
                }
                field("Customer Name"; "Sell To Customer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Customer Name';
                }
                field("Project Name"; SalesProjectName)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Project Name';
                }
                field("Sales Line Amount"; SalesLineAmount)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Sales Line Amount';
                    Visible = false;
                }
                field("Payment Terms"; SalesPaymentTerms)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Payment Terms';
                }
                field("Advance Payment"; Advance)//"Advance Payment")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Purchase Order No."; "Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Purchase Order No.';
                }
                field("PO Doc DATE"; PODocDate)
                {
                    ApplicationArea = All;
                    Caption = 'Order Date';
                    Editable = false;
                }
                field("Vedor No."; "Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    CaptionClass = 'Vendor No.';
                }
                field("Vendor Name"; BuyFromVendor)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Vendor Name';
                }
                field("Vendor Article No."; "Vendor Article No")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Article No.';
                    Editable = false;
                }
                field("Item Description"; Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Item Description';
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Description 3"; "Description 3")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Currency; PoCurrency)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Currency';
                    Visible = false;
                }
                field("PO Amount Value"; Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Order Amount';
                    Editable = false;
                    Visible = false;

                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Quantity Received"; "Quantity Received")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        PurchRcptHeader: Record "Purch. Rcpt. Header";
                        PurchRcptLine: Record "Purch. Rcpt. Line";
                        CheckRecvingPage: Page "Check Receiving History";
                    begin
                        Clear(PurchRcptLine);
                        PurchRcptLine.SetRange("Order No.", "Purchase Order No.");
                        if PurchRcptLine.FindFirst() then begin
                            Clear(PurchRcptHeader);
                            PurchRcptHeader.SetRange("No.", PurchRcptLine."Document No.");
                            if PurchRcptHeader.FindFirst() then begin
                                CheckRecvingPage.SetTableView(PurchRcptHeader);
                                CheckRecvingPage.Run();
                            end;
                        end;
                    end;
                }
                field("Planned Receipt Date"; "Planned Receipt Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Promised Receipt Date"; "Promised Receipt Date")
                {
                    ApplicationArea = All;
                    //  Caption = 'Estimated Arrival Date';
                    Caption = 'Ready EXW Date';
                    Editable = false;
                }
                field("Expected Receipt Date"; "Expected Receipt Date")
                {
                    ApplicationArea = All;
                    //  Editable = false;
                    Caption = 'Estimated Arrival Date';
                }

                field("Client Payment Status"; ClientPayment)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Customer Blocked Status';
                    Style = Unfavorable;
                    StyleExpr = IsRed;
                }
                field(Comments; Comments)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Refresh")
            {
                ApplicationArea = All;
                Image = Refresh;
                trigger OnAction()
                begin
                    CurrPage.Update();
                    ;
                end;
            }

            action("Update Est. Arrival Date")
            {
                ApplicationArea = All;
                Image = ChangeDates;
                trigger OnAction()
                var
                    DatePage: Report "Date Selection";
                    PLine: Record "Purchase Line";
                begin
                    Clear(PLine);
                    Clear(SelectedDate);
                    CurrPage.SetSelectionFilter(PLine);
                    if PLine.FindSet() then begin
                        DatePage.UseRequestPage(true);
                        DatePage.RunModal();
                        SelectedDate := DatePage.GetDate();
                        if SelectedDate <> 0D then begin
                            if not Confirm('Are you sure you want to update the Promised Arrival Date?', false) then
                                exit;
                            repeat
                                //PLine.Validate("Promised Receipt Date", SelectedDate);
                                PLine.Validate("Expected Receipt Date", SelectedDate);
                                PLine.Modify();
                            until PLine.Next() = 0;
                        end;
                    end;
                end;
            }



            action("Remove Est. Arrival Date")
            {
                ApplicationArea = All;
                Image = RemoveLine;
                trigger OnAction()
                var
                    DatePage: Report "Date Selection";
                    PLine: Record "Purchase Line";
                begin
                    Clear(PLine);
                    CurrPage.SetSelectionFilter(PLine);
                    if PLine.FindSet() then begin
                        if not Confirm('Are you sure you want to remove the Promised Arrival Date?', false) then
                            exit;
                        repeat
                            //PLine.Validate("Promised Receipt Date", 0D);
                            PLine.Validate("Expected Receipt Date", 0D);
                            PLine.Modify();
                        until PLine.Next() = 0;
                    end;
                end;
            }

        }

    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetFilter("Header Status", '=%1', "Header Status"::Released);
        SetFilter("Document Type", '=%1', "Document Type"::Order);
        SetFilter("Completely Received", '=%1', true);
        SetFilter(Type, '<>%1', Type::" ");
    end;

    trigger OnAfterGetRecord()  //CurrRecord()
    var
        RecGL: Record "G/L Entry";
    begin
        UpdateStyle();
        Clear(RecGL);
        if Rec."Shortcut Dimension 1 Code" <> '' then begin
            RecGL.SetRange("Document Type", RecGL."Document Type"::Payment);
            RecGL.SetRange("Global Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
            if RecGL.FindFirst() then
                Advance := true
            else
                Advance := false;
        end else
            Advance := false;
    end;

    trigger OnInit()
    var
        myInt: Integer;
    begin

    end;

    local procedure GetFilterText(): Text
    var
        FilterText: Text;
    begin
        FilterText := '';
        Clear(PurchHeader);
        PurchHeader.SetRange("Document Type", "Document Type"::Order);
        PurchHeader.SetRange(Status, PurchHeader.Status::Released);
        if PurchHeader.FindSet() then
            repeat
                FilterText := FilterText + PurchHeader."No." + '|';
            until PurchHeader.Next() = 0;
        FilterText := COPYSTR(FilterText, 1, STRLEN(FilterText) - 1);
        exit(FilterText);
    end;

    local procedure UpdateStyle()
    begin
        CalcFields(ClientPayment);
        if ClientPayment = ClientPayment::All then
            IsRed := true
        else
            IsRed := false;
    end;

    var
        PurchHeader: Record "Purchase Header";
        Sheader: Record "Sales Header";
        Sline: Record "Sales Line";
        Pheader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        SelectedDate: Date;
        IsRed: Boolean;
        Advance: Boolean;

}