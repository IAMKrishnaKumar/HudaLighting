page 50100 "Payroll Staging"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Payroll Staging";
    Caption = 'Payroll Staging';
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = true;

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
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Number"; "Document Number")
                {
                    ApplicationArea = All;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Department Code"; "Department Code")
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; "Branch Code")
                {
                    ApplicationArea = All;
                }
                field(Narration; Narration)
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
                    RecPayRoll: Record "Payroll Staging";
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

            action(CreateJournals)
            {
                ApplicationArea = All;
                Image = Process;
                trigger OnAction()
                var
                    PayrollStaging: Record "Payroll Staging";
                begin
                    Clear(PayrollStaging);
                    PayrollStaging.SetFilter("Integration Status", '=%1|%2', PayrollStaging."Integration Status"::Pending, PayrollStaging."Integration Status"::"Wait for Re-attempt");
                    if PayrollStaging.FindSet() then begin
                        if not Confirm('Are you sure you want to create journals for pending lines?', false) then
                            exit;
                        repeat
                            if not Codeunit.Run(50101, PayrollStaging) then begin
                                if PayrollStaging."Retry Count" > 1 then
                                    PayrollStaging."Integration Status" := PayrollStaging."Integration Status"::Error
                                else
                                    PayrollStaging."Integration Status" := PayrollStaging."Integration Status"::"Wait for Re-attempt";
                                PayrollStaging."Error Remarks" := CopyStr(GetLastErrorText(), 1, 250);
                                PayrollStaging."Retry Count" += 1;
                                PayrollStaging."Processing Date and Time" := CurrentDateTime();
                                PayrollStaging.Modify();
                                Commit();
                            end else begin
                                PayrollStaging."Integration Status" := PayrollStaging."Integration Status"::Processed;
                                PayrollStaging."Error Remarks" := '';
                                PayrollStaging."Processing Remarks" := 'Processed Successfully';
                                PayrollStaging."Retry Count" += 1;
                                PayrollStaging."Processing Date and Time" := CurrentDateTime();
                                PayrollStaging.Modify();
                                Commit();
                            end;
                        until PayrollStaging.Next() = 0;
                        Message('Process completed. Please check the remarks.');
                    end;

                end;
            }
        }
    }

    var
        myInt: Integer;
}