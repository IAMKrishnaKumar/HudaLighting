pageextension 50180 BankRecon extends 379
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("P&osting")
        {
            action(Print)
            {
                ApplicationArea = All;
                Image = PrintReport;
                trigger OnAction()
                var
                    bankReport: Report 60008;
                    BankRecon: Record 273;
                begin
                    Clear(BankRecon);
                    BankRecon.SetRange("Bank Account No.", Rec."Bank Account No.");
                    BankRecon.SetRange("Statement Type", Rec."Statement Type");
                    BankRecon.SetRange("Statement No.", Rec."Statement No.");
                    if BankRecon.FindFirst() then begin
                        // bankReport.UseRequestPage := true;
                        bankReport.SetValues(BankRecon, Rec."Bank Account No.");
                        bankReport.Run();
                    end;
                end;
            }
        }
    }

    var
        myInt: Integer;
}