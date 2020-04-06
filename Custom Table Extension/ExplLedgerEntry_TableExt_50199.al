tableextension 50199 EmplLedgEntry extends "Employee Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; Narration; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup ("G/L Entry".Narration where("Document No." = field("Document No."), "Posting Date" = field("Posting Date")));
        }
        field(50001; "Check No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup ("G/L Entry"."Check No." where("Document No." = field("Document No."), "Posting Date" = field("Posting Date")));
        }
        field(50002; "Check Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup ("G/L Entry"."Check Date" where("Document No." = field("Document No."), "Posting Date" = field("Posting Date")));
        }
    }

    var
        myInt: Integer;
}