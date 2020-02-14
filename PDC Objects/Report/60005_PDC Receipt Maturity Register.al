report 60005 "PDC Receipt Maturity Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'PDC Objects\Report\60005_PDC Receipt Maturity Register.rdl';
    Caption = 'PDC Receipt Maturity Register';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("PDC Receipt"; "PDC Receipt")
        {
            DataItemTableView = SORTING("PDC Deposit Bank No.", "Cheque Date", Code) ORDER(Ascending);
            RequestFilterFields = "PDC Deposit Bank No.", "Shortcut Dimension 1 Code", "Customer No.";
            column(Code_PDCReceipt; "PDC Receipt".Code)
            {
            }
            column(ShortcutDimension1Code_PDCReceipt; "PDC Receipt"."Shortcut Dimension 1 Code")
            {
            }
            column(ChequeDate_PDCReceipt; "PDC Receipt"."Cheque Date")
            {
            }
            column(ChequeNo_PDCReceipt; "PDC Receipt"."Cheque No.")
            {
            }
            column(Amount_PDCReceipt; "PDC Receipt".Amount)
            {
            }
            column(Remarks_PDCReceipt; "PDC Receipt".Remarks)
            {
            }
            column(DocumentDate_PDCReceipt; "PDC Receipt"."Document Date")
            {
            }
            column(PDCDepositBankNo_PDCReceipt; "PDC Receipt"."PDC Deposit Bank No.")
            {
            }
            column(ComName; ComName)
            {
            }
            column(DateToday; DateToday)
            {
            }
            column(User; User)
            {
            }
            column(CustName; CustName)
            {
            }
            column(AsOfDate; AsOfDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "PDC Receipt".SetRange("Document Date", 0D, AsOfDate);
                if "PDC Receipt".FindFirst then
                    if "PDC Receipt"."Cheque Date" <= AsOfDate then
                        CurrReport.Skip;

                CompanyInfo.Get;
                ComName := CompanyInfo.Name;
                DateToday := Today;
                User := UserId;

                if CustomerRec.Get("PDC Receipt"."Customer No.") then
                    CustName := CustomerRec.Name;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("As of Date"; AsOfDate)
                {
                    Caption = 'As of Date';
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
        CompanyInfo: Record "Company Information";
        ComName: Text;
        DateToday: Date;
        User: Text;
        CustomerRec: Record Customer;
        CustName: Text;
        AsOfDate: Date;
}

