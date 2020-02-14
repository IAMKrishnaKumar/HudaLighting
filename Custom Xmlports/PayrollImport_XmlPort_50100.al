xmlport 50100 "Payroll Import"
{
    Direction = Import;
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(Root)
        {
            tableelement(Payroll; "Payroll Staging")
            {

                fieldelement(PostingDate; Payroll."Posting Date")
                {

                }
                fieldelement(DocumentNo; Payroll."Document Number")
                {

                }
                fieldelement(AccountNo; Payroll."Account No")
                {

                }
                fieldelement(Amount; Payroll.Amount)
                {

                }
                fieldelement(DepartmentCode; Payroll."Department Code")
                {

                }
                fieldelement(BranchCode; Payroll."Branch Code")
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