page 50107 "Sales Order Staging"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Order Staging";
    InsertAllowed = false;
    ModifyAllowed = false;
    //DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No"; "Entry No")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Project Reference No."; "Project Reference No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Project Name"; "Project Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Sales Person"; "Sales Person")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Estimated Order Value"; "Estimated Order Value")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Order Date"; "Order Date")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Requested Delivery Date"; "Requested Delivery Date")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Promised Delivery Date"; "Promised Delivery Date")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Payment Terms "; "Payment Terms ")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Opportunity No."; "Opportunity No.")
                {

                    ApplicationArea = All;
                    Enabled = false;
                }
                field("PO Reference"; "PO Reference")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Entry Date and Time"; "Entry Date and Time")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Integration Status"; "Integration Status")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Retry Count"; "Retry Count")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Processing Remarks"; "Processing Remarks")
                {
                    ApplicationArea = All;
                    Style = StrongAccent;
                    Enabled = false;
                }
                field("Sales Order No."; "Sales Order No.")
                {
                    ApplicationArea = All;
                    Style = StrongAccent;
                    Editable = false;
                    TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
                    DrillDown = true;
                    Lookup = true;
                    LookupPageId = "Sales Order";
                    trigger OnDrillDown()
                    var
                        SOCard: Page "Sales Order";
                        Sheader: Record "Sales Header";
                    begin
                        Clear(Sheader);
                        Sheader.SetRange("Document Type", Sheader."Document Type"::Order);
                        Sheader.SetRange("No.", Rec."Sales Order No.");
                        if Sheader.FindFirst() then begin
                            SOCard.SetTableView(Sheader);
                            SOCard.Run();
                        end;
                    end;
                }
                field("Error Remarks"; "Error Remarks")
                {
                    ApplicationArea = All;
                    Style = Attention;
                    Enabled = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Change Status")
            {
                ApplicationArea = All;
                Image = Change;

                trigger OnAction()
                var
                    RecPayRoll: Record "Sales Order Staging";
                begin
                    Clear(RecPayRoll);
                    RecPayRoll.SetFilter("Integration Status", '=%1', "Integration Status"::Error);
                    if RecPayRoll.FindSet() then begin
                        if Confirm('Are you sure you want to change the Integration Status?', false) then begin
                            repeat
                                RecPayRoll."Integration Status" := RecPayRoll."Integration Status"::Pending;
                                RecPayRoll."Error Remarks" := '';
                                RecPayRoll."Retry Count" := 0;
                                RecPayRoll.Modify();
                            until RecPayRoll.Next() = 0;
                        end;
                    end;
                end;
            }

            action("Process Order")
            {
                ApplicationArea = All;
                Image = Process;
                trigger OnAction()
                var
                    RecSOStaging: Record "Sales Order Staging";
                begin
                    Clear(RecSOStaging);
                    RecSOStaging.SetFilter("Integration Status", '=%1|%2', RecSOStaging."Integration Status"::Pending, RecSOStaging."Integration Status"::"Wait for Re-attempt");
                    if RecSOStaging.FindSet() then begin
                        if not Confirm('Are you sure, you want to process the data?', false) then
                            exit;
                        repeat
                            if not Codeunit.Run(50110, RecSOStaging) then begin
                                if RecSOStaging."Retry Count" > 1 then
                                    RecSOStaging."Integration Status" := RecSOStaging."Integration Status"::Error
                                else
                                    RecSOStaging."Integration Status" := RecSOStaging."Integration Status"::"Wait for Re-attempt";
                                RecSOStaging."Error Remarks" := CopyStr(GetLastErrorText(), 1, 250);
                                if GetLastErrorText = 'Duplicate' then begin
                                    RecSOStaging."Integration Status" := RecSOStaging."Integration Status"::Duplicate;
                                    RecSOStaging."Error Remarks" := '';
                                end;
                                RecSOStaging."Retry Count" += 1;
                                RecSOStaging."Processing Date and Time" := CurrentDateTime();
                                RecSOStaging.Modify();
                                Commit();
                            end else begin
                                RecSOStaging."Integration Status" := RecSOStaging."Integration Status"::Processed;
                                RecSOStaging."Error Remarks" := '';
                                RecSOStaging."Processing Remarks" := 'Processed Successfully';
                                RecSOStaging."Retry Count" += 1;
                                RecSOStaging."Processing Date and Time" := CurrentDateTime();
                                RecSOStaging.Modify();
                                Commit();
                            end;

                        until RecSOStaging.Next() = 0;
                        Message('Process completed. Please check the remarks.');
                    end;

                end;
            }
        }
    }


    var
        myInt: Integer;
}