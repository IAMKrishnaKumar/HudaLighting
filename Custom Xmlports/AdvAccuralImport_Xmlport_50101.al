xmlport 50101 "Adv Accrual Import"
{
    Direction = Import;
    UseDefaultNamespace = true;

    schema
    {
        textelement(Root)
        {
            tableelement(Payroll; "Loan & Adv. Accrual")
            {

                fieldelement(PostingDate; Payroll."Posting Date")
                {

                }
                fieldelement(DocumentNo; Payroll."Document Number")
                {

                }
                fieldelement(AccountType; Payroll."Account Type")
                {

                }
                fieldelement(AccountNo; Payroll."Account No")
                {

                }
                fieldelement(Amount; Payroll.Amount)
                {

                }
                fieldelement(Narration; Payroll.Narration)
                {

                }
                trigger OnBeforeInsertRecord()
                begin
                    Payroll."Entry Date and Time" := CurrentDateTime;
                    Payroll."Integration Status" := Payroll."Integration Status"::Pending;
                end;
            }
        }
    }
}