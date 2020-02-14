report 50115 GeneralVoucher_LT
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Custom Reports\REPOSITORY\GeneralVoucher_LT\GeneralVoucher_LT.rdlc';
    Caption = 'GeneralVoucher_LT';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.");
            RequestFilterFields = "Document No.";
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Name2; CompanyInfo."Name 2")
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Country; CompanyInfo."Country/Region Code")
            {
            }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo."Header Image")
            {
            }
            column(FooterImage; CompanyInfo."Footer Image")
            {

            }
            column(UserName; UserName)
            {
            }
            column(CompanyInfo_vatRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfo_PhoneNol; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            {
            }
            column(DocumentNo_GenJournalLine; "Gen. Journal Line"."Document No.")
            {
            }
            column(DocumentNo2_GenJournalLine; 'DocumentNO2')
            {
            }
            column(PostingDate_GenJournalLine; "Gen. Journal Line"."Posting Date")
            {
            }
            column(AccountNo_GenJournalLine; "Gen. Journal Line"."Account No.")
            {
            }
            column(Description_GenJournalLine; "Gen. Journal Line".Description)
            {
            }
            column(Amount_GenJournalLine; "Gen. Journal Line".Amount)
            {
            }
            column(DebitAmount; DebitAmount)
            {
            }
            column(InvoiceNo; InvoiceNo)
            {
            }
            column(PostingDate; PostingDate)
            {
            }
            column(OrgAmount; OrgAmount)
            {
            }
            column(Narration_GenJournalLine; "Gen. Journal Line".Narration)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "Gen. Journal Line".Amount > 0 THEN
                    DebitAmount := 'Debit'
                ELSE
                    DebitAmount := 'Credit';
                //<LT>
            end;

            trigger OnPreDataItem()
            begin
                "Gen. Journal Line".SETFILTER("Gen. Journal Line"."Source Code", '%1', 'GENJNL');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS("Header Image");
        CompanyInfo.CalcFields("Footer Image");
        Clear(Users);
        Clear(UserName);
        Users.SetCurrentKey("User Name");
        Users.SetRange("User Name", UserId);
        IF Users.FindFirst() then begin
            if Users."Full Name" <> '' then
                UserName := Users."Full Name"
            else
                UserName := UserId;
        end;
    end;

    var
        CompanyInfo: Record 79;
        CreditAmount: Text;
        DebitAmount: Text;
        CustLedEntry_Rec: Record 21;
        VendorLedEntry: Record 25;
        InvoiceNo: Code[20];
        PostingDate: Date;
        OrgAmount: Decimal;
        Users: Record User;
        UserName: Text;
}

