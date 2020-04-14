pageextension 50202 GlBudgetEntries extends "G/L Budget Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter(Amount)
        {
            field("Amount (ACY)"; "Amount (ACY)")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("Ent&ry")
        {
            action("Update Amount (ACY)")
            {
                ApplicationArea = All;
                Image = UpdateUnitCost;
                trigger OnAction()
                VAR
                    GlBudgetReport: Report "Update G/L Budget Entries";
                begin
                    GlBudgetReport.RunModal();
                end;
            }
        }
    }

    var
        myInt: Integer;
}