report 60006 "Print Lable"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'PDC Objects\Report\60006_Print Lable.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(CopyLoop; "Integer")
        {
            DataItemTableView = SORTING(Number) ORDER(Ascending);
            column(TgCopies; TgCopies)
            {
            }
            dataitem("PDC Issue"; "PDC Issue")
            {
                RequestFilterFields = "Code";
                column(UserDetails; UpperCase(Users."Full Name") + '  ' + '/' + '  ' + Format(Today))
                {
                }
                column(Bank; "PDC Issue".Bank)
                {
                }
                column(DocNo; "PDC Issue".Code)
                {
                }
                column(ChequeNo; "PDC Issue"."Cheque No.")
                {
                }
                column(ChequeDate; Format("PDC Issue"."Cheque Date"))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Users.Reset;
                    Users.SetRange("User Name", UserId);
                    if Users.FindFirst then;
                end;
            }

            trigger OnPreDataItem()
            begin
                CopyLoop.SetRange(Number, 1, TgCopies);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("No Of Copies"; TgCopies)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        TgCopies: Integer;
        Users: Record User;

    procedure InitialiseCopies(Copy: Integer)
    begin
        TgCopies := Copy;
        if TgCopies = 0 then
            TgCopies := 1;
    end;
}

