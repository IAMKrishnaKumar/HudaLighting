report 50162 "Update GL Split"
{
    //UsageCategory = Administration;
    //ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = sorting("Document No.") order(ascending);

            trigger OnAfterGetRecord()
            var
                RecSoSplit: Record "Sales Person Main";
                RecGLSplit: Record "GL Entry Split";
                EntryNoList: List of [Integer];
                LoopCount: Integer;
                RecGLSplit2: Record "GL Entry Split";
                RecGLSplit3: Record "GL Entry Split";

            begin
                Clear(RecSoSplit);
                RecSoSplit.SetRange("Opportunity No", "Global Dimension 1 Code");
                if RecSoSplit.FindSet() then begin
                    /*
                                        if not CheckList.Contains("G/L Entry"."Document No." + "G/L Entry"."G/L Account No.") then
                                            CheckList.Add("G/L Entry"."Document No." + "G/L Entry"."G/L Account No.")
                                        else
                                            CurrReport.Skip();
                    */
                    CalcFields("Sales Person");
                    Clear(RecGLSplit);
                    RecGLSplit.SetRange("G/L Entry No.", "Entry No.");
                    //RecGLSplit.SetRange("Document No.", "G/L Entry"."Document No.");
                    //RecGLSplit.SetRange("G/L Account No.", "G/L Entry"."G/L Account No.");
                    if RecGLSplit.FindSet() then begin
                        if RecGLSplit.Count = RecSoSplit.Count then begin
                            Clear(EntryNoList);
                            repeat
                                EntryNoList.Add(RecGLSplit."Entry No.");
                            until RecGLSplit.Next() = 0;
                            LoopCount := 1;
                            repeat
                                Clear(RecGLSplit2);
                                if RecGLSplit2.Get(EntryNoList.Get(LoopCount)) then begin
                                    RecGLSplit2."Posting Date" := "Posting Date";
                                    RecGLSplit2."Document No." := "Document No.";
                                    RecGLSplit2."G/L Account No." := "G/L Account No.";
                                    RecGLSplit2."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                                    RecGLSplit2."Sales Person" := RecSoSplit.Salesperson;
                                    RecGLSplit2."Share %" := RecSoSplit."Share %";
                                    RecGLSplit2.Amount := Amount;
                                    RecGLSplit2."Add. Currency Amount" := "Additional-Currency Amount";
                                    RecGLSplit2."Shared Amount" := Amount * RecSoSplit."Share %" / 100;
                                    RecGLSplit2."Shared Add. Currency Amount" := "Additional-Currency Amount" * RecSoSplit."Share %" / 100;
                                    RecGLSplit2."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                                    RecGLSplit2."G/L Entry No." := "Entry No.";
                                    RecGLSplit2.Modify();
                                end;
                                LoopCount += 1;
                            until RecSoSplit.Next() = 0;
                        end else begin
                            RecGLSplit.DeleteAll();
                            repeat
                                Clear(RecGLSplit3);
                                if RecGLSplit3.FindLast() then;
                                RecGLSplit2.Init();
                                RecGLSplit2."Entry No." := RecGLSplit3."Entry No." + 1;
                                RecGLSplit2."Posting Date" := "Posting Date";
                                RecGLSplit2."Document No." := "Document No.";
                                RecGLSplit2."G/L Account No." := "G/L Account No.";
                                RecGLSplit2."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                                RecGLSplit2."Sales Person" := RecSoSplit.Salesperson;
                                RecGLSplit2."Share %" := RecSoSplit."Share %";
                                RecGLSplit2.Amount := Amount;
                                RecGLSplit2."Add. Currency Amount" := "Additional-Currency Amount";
                                RecGLSplit2."Shared Amount" := Amount * RecSoSplit."Share %" / 100;
                                RecGLSplit2."Shared Add. Currency Amount" := "Additional-Currency Amount" * RecSoSplit."Share %" / 100;
                                RecGLSplit2."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                                RecGLSplit2."G/L Entry No." := "Entry No.";
                                RecGLSplit2.Insert();
                            until RecSoSplit.Next() = 0;
                        end;
                    end else begin
                        repeat
                            Clear(RecGLSplit3);
                            if RecGLSplit3.FindLast() then;
                            RecGLSplit2.Init();
                            RecGLSplit2."Entry No." := RecGLSplit3."Entry No." + 1;
                            RecGLSplit2."Posting Date" := "Posting Date";
                            RecGLSplit2."Document No." := "Document No.";
                            RecGLSplit2."G/L Account No." := "G/L Account No.";
                            RecGLSplit2."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                            RecGLSplit2."Sales Person" := RecSoSplit.Salesperson;
                            RecGLSplit2."Share %" := RecSoSplit."Share %";
                            RecGLSplit2.Amount := Amount;
                            RecGLSplit2."Add. Currency Amount" := "Additional-Currency Amount";
                            RecGLSplit2."Shared Amount" := Amount * RecSoSplit."Share %" / 100;
                            RecGLSplit2."Shared Add. Currency Amount" := "Additional-Currency Amount" * RecSoSplit."Share %" / 100;
                            RecGLSplit2."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                            RecGLSplit2."G/L Entry No." := "Entry No.";
                            RecGLSplit2.Insert();
                        until RecSoSplit.Next() = 0;
                    end;
                end;
            end;


            trigger OnPreDataItem()
            begin
                SetFilter("Global Dimension 1 Code", '<>%1', '');
                Clear(CheckList);

            end;
        }
    }


    var
        CheckList: List of [Text];
}