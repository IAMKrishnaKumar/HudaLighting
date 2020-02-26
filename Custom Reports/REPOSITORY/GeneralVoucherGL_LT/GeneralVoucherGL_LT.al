report 50116 GeneralVoucherGL_LT
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Custom Reports\REPOSITORY\GeneralVoucherGL_LT\GeneralVoucherGL_LT.rdlc';
    Caption = 'Journal Voucher';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("Entry No.")
                                ORDER(Ascending);
            RequestFilterFields = "Document No.";
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            /* column(Credit_Amount; "Credit Amount")
             {

             }*/
            column(CompanyTelAndFax; CompanyTelAndFax)
            {

            }
            column(CompanyAddress; CompanyAddress)
            {

            }
            column(Debit_Amount; "Debit Amount")
            {

            }
            column(CompanyInfoHomPage; CompanyInfo."Home Page")
            {

            }
            column(CompanyInfo_Name2; CompanyInfo."Name 2")
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(UserName; UserName)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(CompanyDisplayName; CompanyInfo."Name")
            { }
            column(CompanyInfo_City; CompanyInfo.City)
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
            column(CompanyInfo_vatRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfo_PhoneNol; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            {
            }
            /* column(DebitAmount; DebitAmount)
             {
             }*/
            column(Amount_GLEntry; "G/L Entry".Amount)
            {
            }
            column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
            {
            }
            column(PostingDate_GLEntry; "G/L Entry"."Posting Date")
            {
            }
            /* column(PaymentDesc; PaymentDesc)
             {
             }
             column(SourceNo; SourceNo)
             {
             }*/
            column(SourceNo; AccountNo)//"G/L Account No.")
            {

            }
            column(PaymentDesc; AccountName)//"G/L Account Name")
            {

            }
            column(Narration_GLEntry; "G/L Entry".Narration)// Removed Desc as 
            {
            }
            column(DepartmentName; DepartmentName)
            {

            }
            column(BranchName; BranchName)
            {

            }
            column(EntryNo_GLEntry; "G/L Entry"."Entry No.")
            {
            }
            column(DocumentNo2_GLEntry; "G/L Entry"."Document No2")
            {
            }
            column(Credit_Amount; "Credit Amount")
            {

            }

            // dataitem("G/L Entry_"; "G/L Entry")
            // {
            //     DataItemLink = "Entry No." = field("Entry No.");
            //     column(Credit_Amount; "Credit Amount")
            //     {

            //     }
            //     trigger OnPreDataItem()
            //     var
            //         myInt: Integer;
            //     begin
            //         //"G/L Entry_".SETFILTER("G/L Entry_"."Credit Amount", '<>1', 0);
            //     end;
            // }

            trigger OnAfterGetRecord()
            VAR
                RecGLEntry: Record "G/L Entry";
            begin
                CalcFields("G/L Account Name");
                GenLedSetup.GET;
                Clear(BranchName);
                Clear(DepartmentName);
                Clear(DimensionSetEntry);
                DimensionSetEntry.SetRange("Dimension Set ID", "G/L Entry"."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", GenLedSetup."Shortcut Dimension 1 Code");
                if DimensionSetEntry.FindFirst() then
                    BranchName := DimensionSetEntry."Dimension Value Code";


                Clear(DimensionSetEntry);
                DimensionSetEntry.SetRange("Dimension Set ID", "G/L Entry"."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", GenLedSetup."Shortcut Dimension 5 Code");
                if DimensionSetEntry.FindFirst() then
                    DepartmentName := DimensionSetEntry."Dimension Value Code";

                // Clear(IsSameSource);
                Clear(RecGLEntry);
                RecGLEntry.SetRange("Document No.", "Document No.");
                if RecGLEntry.FindSet() then begin
                    repeat
                        if ("Source Type" = RecGLEntry."Source Type") AND ("Source No." = RecGLEntry."Source No.") then
                            IsSameSource := true
                        else
                            IsSameSource := false;
                    until RecGLEntry.Next() = 0;
                end;

                // If not IsSameSource then begin

                /* Clear(AccountNo);
                 if "Source No." <> '' then begin
                     if AccountNoTest = "Source No." then
                         AccountNo := "Bal. Account No."
                     else
                         AccountNo := "Source No.";
                     AccountNoTest := "Source No.";
                 end else
                     AccountNo := "G/L Account No.";*/

                Clear(AccountName);
                if "Source Type" = "Source Type"::" " then begin
                    CalcFields("G/L Account Name");
                    AccountName := "G/L Account Name";
                    AccountNo := "G/L Account No.";
                end else begin
                    AccountNo := "Source No.";
                    if "Source Type" = "Source Type"::"Bank Account" then begin
                        Clear(RecBankAccount);
                        RecBankAccount.GET("Source No.");
                        AccountName := RecBankAccount.Name;
                    end else
                        if "Source Type" = "Source Type"::Customer then begin
                            Clear(RecCustomer);
                            RecCustomer.GET("Source No.");
                            AccountName := RecCustomer.Name;
                        end else
                            if "Source Type" = "Source Type"::Vendor then begin
                                Clear(RecVendor);
                                RecVendor.GET("Source No.");
                                AccountName := RecVendor.Name;
                            end else
                                if "Source Type" = "Source Type"::Vendor then begin
                                    Clear(RecVendor);
                                    RecVendor.GET("Source No.");
                                    AccountName := RecVendor.Name;
                                end else
                                    if "Source Type" = "Source Type"::"Fixed Asset" then begin
                                        Clear(RecFixedAsset);
                                        RecFixedAsset.GET("Source No.");
                                        AccountName := RecFixedAsset.Description;
                                    end else
                                        if "Source Type" = "Source Type"::Employee then begin
                                            Clear(RecEmployee);
                                            RecEmployee.GET("Source No.");
                                            AccountName := RecEmployee."First Name";
                                        end;
                end;
                /*end else begin
                    AccountNo := "G/L Account No.";
                    AccountName := "G/L Account Name";
                end;*/
            end;

            trigger OnPreDataItem()
            VAR

            begin
                // "G/L Entry".SETFILTER("G/L Entry"."Source Code", '%1', 'GENJNL');

                Clear(Users);
                Clear(UserName);
                Users.SetCurrentKey("User Name");
                Users.SetRange("User Name", "User ID");
                IF Users.FindFirst() then begin
                    if Users."Full Name" <> '' then
                        UserName := Users."Full Name"
                    else
                        UserName := UserId;
                end;

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


        Clear(CompanyAddress);
        Clear(CompanyTelAndFax);
        if CompanyInfo.Address <> '' then
            CompanyAddress := CompanyInfo.Address + ', ';

        if CompanyInfo."Address 2" <> '' then
            CompanyAddress += CompanyInfo."Address 2" + ', ';

        if CompanyInfo."Post Code" <> '' then
            CompanyAddress += 'P.O. Box ' + CompanyInfo."Post Code" + ', ';

        if CompanyInfo.City <> '' then
            CompanyAddress += CompanyInfo.City + ' - ';

        if CompanyInfo."Country/Region Code" <> '' then
            CompanyAddress += CompanyInfo."Country/Region Code";
        if CompanyInfo."Phone No." <> '' then
            CompanyTelAndFax := 'T. ' + CompanyInfo."Phone No." + ', ';
        if CompanyInfo."Fax No." <> '' then
            CompanyTelAndFax += 'F. ' + CompanyInfo."Fax No.";
    end;

    var
        CompanyInfo: Record 79;
        //CreditAmount: Text;
        //DebitAmount: Text;
        AccountNo: Text;
        AccountNoTest: Text;
        AccountName: Text;
        RecBankAccount: Record "Bank Account";
        RecVendor: Record Vendor;
        RecCustomer: Record Customer;
        RecFixedAsset: Record "Fixed Asset";
        RecEmployee: Record Employee;
        FixedAssetRec: Record 5600;
        GenLedSetup: Record "General Ledger Setup";
        CustomerRec: Record 18;
        CompanyAddress: Text;
        CompanyTelAndFax: Text;
        VendorRec: Record 23;
        GLAcctRec: Record 15;
        Employee: Record 5200;
        BranchName: Text;
        DepartmentName: Text;
        SourceNo: Code[20];
        PaymentDesc: Text[100];
        Custledentry_Rec: Record 21;
        Users: Record User;
        UserName: Text;
        DimensionSetEntry: Record "Dimension Set Entry";
        IsSameSource: Boolean;
}

