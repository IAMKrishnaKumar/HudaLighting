page 50104 "Sales Person Share Main"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Person Main";
    Caption = 'Sales Person Share Main';
    // ModifyAllowed = false;
    // InsertAllowed = false;
    // DeleteAllowed = true;

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
                field(Sales; Sales)
                {
                    Caption = 'Sales';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(COGS; COGS)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shared Sales"; "Shared Sales")
                {
                    Caption = 'Shared Sales';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shared COGS"; "Shared COGS")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                var
                    RecSalesShare: Record "Sales Person Main";
                begin
                    Clear(RecSalesShare);
                    RecSalesShare.SetFilter("Entry No.", '<>%1', 0);
                    if RecSalesShare.FindSet() then begin
                        repeat
                            RecSalesShare.CalcFields(COGS, Sales);
                            RecSalesShare."Shared Sales" := (RecSalesShare.Sales * RecSalesShare."Share %") / 100;
                            RecSalesShare."Shared COGS" := (RecSalesShare.COGS * RecSalesShare."Share %") / 100;
                            RecSalesShare.Modify();
                        until RecSalesShare.Next() = 0;
                        Message('Records updated.');
                    end;
                end;
            }
        }
    }
}