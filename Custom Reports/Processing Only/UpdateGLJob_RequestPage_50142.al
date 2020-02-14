report 50142 "Update G/L"
{
    // UsageCategory = Administration;
    //ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = TableData 17 = RIMD;
    dataset
    {
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(FilterText;
                    FilterText)
                    {
                        ApplicationArea = All;
                        Caption = 'Filter Text';
                    }
                    field(GLAccNo; GLAccNo)
                    {
                        ApplicationArea = All;
                        Caption = 'G/L Account No.';
                        TableRelation = "G/L Account";
                    }
                }
            }
        }
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var
            RecGLEntry: Record "G/L Entry";
        begin
            If CloseAction IN [ACTION::OK, ACTION::LookupOK] then begin
                if (FilterText <> '') AND (GLAccNo <> '') then begin
                    Clear(RecGLEntry);
                    RecGLEntry.SetFilter("Entry No.", FilterText);
                    if RecGLEntry.FindSet() then begin
                        if not Confirm('Are you sure you want to update the G/L Entry Table?', false) then
                            exit;
                        repeat
                            RecGLEntry.Validate("G/L Account No.", GLAccNo);
                            RecGLEntry.Modify();
                        until RecGLEntry.Next() = 0;
                    end;
                end;
            end;
        end;
    }
    trigger OnPostReport()
    var

    begin

    end;

    var
        FilterText: Text;
        GLAccNo: Code[20];
}



///


