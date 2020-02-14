report 50145 "Update Bin Content"
{
    ProcessingOnly = true;
    Permissions = TableData 7302 = RIMD;
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
                    field(BinCode; BinCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Bin Code';
                    }
                }
            }
        }
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var
            BinContent: Record 7302;
        begin
            If CloseAction IN [ACTION::OK, ACTION::LookupOK] then begin
                if (BinCode <> '') then begin
                    Clear(BinContent);
                    BinContent.SetFilter("Bin Code", '=%1', BinCode);
                    if BinContent.FindSet() then begin
                        if not Confirm('Are you sure you want to Delete the Bin Code ' + BinCode + ' ?', false) then
                            exit;
                        BinContent.DeleteAll();
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
        BinCode: Text;
}



report 50148 "Update Whse Entry"
{
    // UsageCategory = Administration;
    //ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = TableData 7312 = RIMD;
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
                    field(BinCode; BinCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Bin Code';
                    }
                }
            }
        }
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var
            WhseEntry: Record 7312;
        begin
            If CloseAction IN [ACTION::OK, ACTION::LookupOK] then begin
                if (BinCode <> '') then begin
                    Clear(WhseEntry);
                    WhseEntry.SetFilter("Bin Code", '=%1', BinCode);
                    if WhseEntry.FindSet() then begin
                        if not Confirm('Are you sure you want to Delete the Bin Code ' + BinCode + ' ?', false) then
                            exit;
                        WhseEntry.DeleteAll();
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
        BinCode: Text;
}