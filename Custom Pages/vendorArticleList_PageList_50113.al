page 50113 "Internal Common Items"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Vendor Article List";
    // Editable = false;
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
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Article No."; "Vendor Article No.")
                {
                    ApplicationArea = All;
                }
                field("Common Item No."; "Common Item No.")
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
            action("Generate Common Items")
            {
                ApplicationArea = All;
                Image = AddAction;
                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to Generate common Item No. for all the Items?', FALSE) then
                        Exit;
                    Report.Run(50105, false, false);
                    Message('Process completed.');
                end;
            }

            action("Delete Common Items")
            {
                ApplicationArea = All;
                Image = RemoveLine;
                trigger OnAction()
                var
                    RecItem: Record Item;
                begin
                    if not Confirm('Are you sure you want to delete common Item No. from all the Items?', FALSE) then
                        Exit;
                    Clear(RecItem);
                    RecItem.SetFilter("No.", '<>%1', '');
                    RecItem.SetRange(Type, RecItem.Type::Inventory);
                    if RecItem.FindSet() then begin
                        repeat
                            RecItem."Common Item No." := '';
                            RecItem.Modify();
                        until RecItem.Next() = 0;
                    end;
                    Message('Process Completed.');
                end;
            }
        }
    }

    var
        myInt: Integer;
}