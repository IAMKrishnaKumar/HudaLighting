report 60004 "PDC Issue Maturity Register"
{
    // 
    // Code           Date        Name        Desc.
    // APNT-LCPDC1.0  22.05.12    Monica      Created New.
    DefaultLayout = RDLC;
    RDLCLayout = 'PDC Objects\Report\60004_PDC Issue Maturity Register.rdl';
    ApplicationArea = All;
    UsageCategory = Administration;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("PDC Issue"; "PDC Issue")
        {
            DataItemTableView = SORTING(Bank, "Cheque Date", Code) ORDER(Ascending) WHERE(Status = FILTER(Issued));
            RequestFilterFields = Bank, "Shortcut Dimension 1 Code", "Vendor No.";
            column(DocumentDate_PDCIssue; Format("PDC Issue"."Document Date"))
            {
            }
            column(Code_PDCIssue; "PDC Issue".Code)
            {
            }
            column(ShortcutDimension1Code_PDCIssue; "PDC Issue"."Shortcut Dimension 1 Code")
            {
            }
            column(ChequeDate_PDCIssue; Format("PDC Issue"."Cheque Date"))
            {
            }
            column(ChequeNo_PDCIssue; "PDC Issue"."Cheque No.")
            {
            }
            column(Remarks_PDCIssue; "PDC Issue".Remarks)
            {
            }
            column(Amount_PDCIssue; "PDC Issue".Amount)
            {
            }
            column(Bank_PDCIssue; "PDC Issue".Bank)
            {
            }
            column(BankName_PDCIssue; "PDC Issue"."Bank Name")
            {
            }
            column(Date; Format(Today, 0, 4))
            {
            }
            column("Page"; 'CurrReport.PageNo')
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(Date1; Format(Date1))
            {
            }
            column(VendorName; VendorName)
            {
            }
            column(BankName; BankName)
            {
            }
            column(AsOfDate; AsOfDate)
            {
            }
            column(date2; date)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if CurrBank = 'Cronus ban' then begin
                    CurrBank := "PDC Issue".Bank;
                    i := 0;
                    recBank1 := EntryCount(CurrBank);
                end;

                i += 1;
                if i = 1 then
                    MakeExcelDataBody(true, false);

                if (i > 1) and (i <> recBank1) then
                    MakeExcelDataBody(true, true);

                if i = recBank1 then begin
                    MakeExcelDataBody(false, true);
                    CurrBank := 'Cronus ban';
                end;


                recBank.Reset;
                if recBank.Get(Bank) then
                    BankName := recBank.Name
                else
                    BankName := '';


                if "PDC Issue".Cleared = true then
                    if "PDC Issue"."Deposit Date" <= AsOfDate then
                        CurrReport.Skip;

                if recVendor.Get("Vendor No.") then
                    VendorName := recVendor.Name
                else
                    VendorName := '';

                //IF (ExportToExcel = TRUE) THEN
                //  BEGIN
                /*  IF CurrBank <> "PDC Issue".Bank THEN BEGIN
                    TempExcelBuffer.NewRow;
                   TempExcelBuffer.AddColumn("PDC Issue".Bank,FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                   TempExcelBuffer.NewRow;
                   END;
                 //IF CurrBank = "PDC Issue".Bank THEN
                  //TempExcelBuffer.NewRow;
                    TempExcelBuffer.AddColumn("PDC Issue"."Document Date",FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("PDC Issue".Code,FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("PDC Issue"."Shortcut Dimension 1 Code",FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("PDC Issue"."Cheque Date",FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("PDC Issue"."Cheque No.",FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("PDC Issue".Amount,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn("PDC Issue".Remarks,FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(VendorName,FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);*/
                // Amount1 +="PDC Issue".Amount;

                // END;

                //Amount1 +="PDC Issue".Amount;

            end;

            trigger OnPostDataItem()
            begin

                if ExportToExcel = true then begin
                    //TempExcelBuffer.CreateBook;
                    //TempExcelBuffer.CreateBookAndOpenExcel('', 'PDC Issue Maturity Register', 'PDC Issue Maturity Register', CompanyName, UserId);

                    //TempExcelBuffer.UpdateBookStream;   //commented
                end;
            end;

            trigger OnPreDataItem()
            begin

                "PDC Issue".SetRange("Document Date", 0D, AsOfDate);
                date := "PDC Issue".GetFilters;

                if ExportToExcel = true then begin
                    //if CurrReport.PageNo = 1 then begin
                    TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('PDC Issue Maturity Register', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.NewRow;
                    TempExcelBuffer.AddColumn('As Off Date :' + Format(AsOfDate), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.NewRow;
                    TempExcelBuffer.AddColumn(GetFilters, false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    //end;
                end;


                if ExportToExcel = true then begin
                    //if CurrReport.PageNo = 1 then begin
                    TempExcelBuffer.NewRow;
                    TempExcelBuffer.AddColumn('Document Date', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Document No.', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Profit Centre', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Cheque Date', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Cheque No.', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Amount', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Remarks', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Vendor Name', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    //end;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control10014501)
                {
                    ShowCaption = false;
                    field(AsOfDate; AsOfDate)
                    {
                        Caption = 'AsOfDate';
                        ApplicationArea = All;
                    }
                    field(ExportToExcel; ExportToExcel)
                    {
                        Caption = 'ExportToExcel';
                        ApplicationArea = All;
                    }
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

    trigger OnInitReport()
    begin
        CompanyInfo.Get;
        //CurrBank :='cronus ban';
    end;

    var
        Date1: Date;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        Window: Dialog;
        Row: Integer;
        TotalRecNo: Integer;
        RecNo: Integer;
        ExportToExcel: Boolean;
        recVendor: Record Vendor;
        VendorName: Text[100];
        recBank: Record "Bank Account";
        BankName: Text[100];
        CompanyInfo: Record "Company Information";
        Amount: Decimal;
        AsOfDate: Date;
        date: Text;
        "Document Date": Text;
        i: Integer;
        Amount1: Decimal;
        CurrBank: Code[10];
        recBank1: Integer;
        j: Integer;

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean)
    begin
        TempExcelBuffer.Init;
        TempExcelBuffer.Validate("Row No.", RowNo);
        TempExcelBuffer.Validate("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        //TempExcelBuffer.NumberFormat := text;
        TempExcelBuffer.Insert;
    end;

    local procedure MakeExcelDataBody(IsHeader: Boolean; IfFooter: Boolean)
    begin

        if IsHeader then begin
            TempExcelBuffer.NewRow;
            TempExcelBuffer.AddColumn("PDC Issue".Bank, false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        end;
        TempExcelBuffer.NewRow;
        TempExcelBuffer.AddColumn("PDC Issue"."Document Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("PDC Issue".Code, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("PDC Issue"."Shortcut Dimension 1 Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("PDC Issue"."Cheque Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("PDC Issue"."Cheque No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("PDC Issue".Amount, false, '', false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn("PDC Issue".Remarks, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(VendorName, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        // Amount1 +="PDC Issue".Amount;
        //  END;
        if IfFooter then begin
            TempExcelBuffer.NewRow;
            TempExcelBuffer.AddColumn('Total', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        end;
    end;

    local procedure MakeExcelFooter()
    begin

        TempExcelBuffer.NewRow;
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Amount1, false, '', true, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
    end;

    local procedure EntryCount(bank: Code[10]): Integer
    begin
        "PDC Issue".SetRange("PDC Issue".Bank, bank);
        //"PDC Issue".SETRANGE("PDC Issue"."Bank Name",BankName);
        if "PDC Issue".FindSet then
            exit("PDC Issue".Count);
    end;
}

