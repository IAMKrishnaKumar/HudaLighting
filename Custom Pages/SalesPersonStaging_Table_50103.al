page 50103 "Sales Person Share Staging"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Person Staging";
    Caption = 'Sales Person Share Staging';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Effective Date"; "Effective Date")
                {
                    ApplicationArea = All;
                }

                field("Opportunity No"; "Opportunity No")
                {
                    ApplicationArea = All;
                }
                field(Salesperson; Salesperson)
                {
                    ApplicationArea = All;
                }
                field("Share %"; "Share %")
                {
                    ApplicationArea = All;
                }

                field("Entry Date and Time"; "Entry Date and Time")
                {
                    ApplicationArea = All;
                }
                field("Processing Date and Time"; "Processing Date and Time")
                {
                    ApplicationArea = All;
                }
                field("Integration Status"; "Integration Status")
                {
                    ApplicationArea = All;
                }
                field("Processing Remarks"; "Processing Remarks")
                {
                    ApplicationArea = All;
                    Style = StrongAccent;
                }
                field("Error Remarks"; "Error Remarks")
                {
                    ApplicationArea = All;
                    Style = Attention;

                }
                field("Retry Count"; "Retry Count")
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
            action("Change Status")
            {
                ApplicationArea = All;
                Image = Change;

                trigger OnAction()
                var
                    ReStaging: Record "Sales Person Staging";
                begin
                    Clear(ReStaging);
                    ReStaging.SetFilter("Integration Status", '=%1', "Integration Status"::Error);
                    if ReStaging.FindSet() then begin
                        if Confirm('Are you sure you want to change the Integration Status?', false) then begin
                            repeat
                                ReStaging."Integration Status" := ReStaging."Integration Status"::Pending;
                                ReStaging."Error Remarks" := '';
                                ReStaging."Retry Count" := 0;
                                ReStaging.Modify();
                            until ReStaging.Next() = 0;
                        end;
                    end;
                end;
            }
            action("Process Data")
            {
                ApplicationArea = All;
                Image = Process;
                trigger OnAction()
                var
                    RecStaging: Record "Sales Person Staging";
                begin
                    if not Confirm('Are you sure you want to process data to the Main table?', false) then
                        exit;
                    Clear(RecStaging);
                    RecStaging.SetFilter("Integration Status", '=%1|%2', RecStaging."Integration Status"::Pending, RecStaging."Integration Status"::"Wait for Re-attempt");
                    if RecStaging.FindSet() then begin
                        repeat
                            ValidateData(RecStaging."Opportunity No");
                        until RecStaging.Next() = 0;
                    end;
                    Clear(RecStaging);
                    RecStaging.SetFilter("Integration Status", '=%1|%2', RecStaging."Integration Status"::Pending, RecStaging."Integration Status"::"Wait for Re-attempt");
                    if RecStaging.FindSet() then begin
                        repeat
                            if not Codeunit.Run(50106, RecStaging) then begin
                                if GetLastErrorText = 'Duplicate' then begin
                                    RecStaging."Integration Status" := RecStaging."Integration Status"::Duplicate;
                                    RecStaging."Error Remarks" := '';
                                    RecStaging."Processing Date and Time" := CurrentDateTime();
                                    RecStaging."Retry Count" += 1;
                                    RecStaging.Modify();
                                    Commit();
                                end else begin
                                    if RecStaging."Retry Count" > 1 then
                                        RecStaging."Integration Status" := RecStaging."Integration Status"::Error
                                    else
                                        RecStaging."Integration Status" := RecStaging."Integration Status"::"Wait for Re-attempt";
                                    RecStaging."Error Remarks" := CopyStr(GetLastErrorText(), 1, 250);
                                    RecStaging."Processing Date and Time" := CurrentDateTime();
                                    RecStaging."Retry Count" += 1;
                                    RecStaging.Modify();
                                    Commit();
                                end;
                            end else begin
                                RecStaging."Integration Status" := RecStaging."Integration Status"::Processed;
                                RecStaging."Error Remarks" := '';
                                RecStaging."Processing Remarks" := 'Processed Successfully';
                                RecStaging."Retry Count" += 1;
                                RecStaging."Processing Date and Time" := CurrentDateTime();
                                RecStaging.Modify();
                                Commit();
                            end;
                        until RecStaging.Next() = 0;
                    end;
                    Message('Process comepleted. Please check the remarks.');
                end;
            }
        }
    }
    procedure ValidateData(OpportunityNo: Code[20])
    var
        RecStaging: Record "Sales Person Staging";
        CurrPercentage: Decimal;
    begin
        Clear(RecStaging);
        Clear(CurrPercentage);
        RecStaging.SetFilter("Integration Status", '=%1|%2', RecStaging."Integration Status"::Pending, RecStaging."Integration Status"::"Wait for Re-attempt");
        RecStaging.SetRange("Opportunity No", OpportunityNo);
        if RecStaging.FindSet() then
            repeat
                CurrPercentage += RecStaging."Share %";
            until RecStaging.Next() = 0;
        if CurrPercentage <> 100 then begin
            Clear(RecStaging);
            RecStaging.SetRange("Opportunity No", OpportunityNo);
            if RecStaging.FindSet() then begin
                repeat
                    RecStaging."Integration Status" := RecStaging."Integration Status"::Error;
                    RecStaging."Error Remarks" := 'The Sum of Share % for a particular Opportunity No must be 100';
                    RecStaging."Processing Date and Time" := CurrentDateTime();
                    RecStaging."Retry Count" += 1;
                    RecStaging.Modify();
                until RecStaging.Next() = 0;
            end;
        end;

    end;
}