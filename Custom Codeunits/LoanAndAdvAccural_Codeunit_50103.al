codeunit 50103 "Loan& Adv. Accural"
{
    TableNo = "Loan & Adv. Accrual";
    trigger OnRun()
    var
        GenJln: Record "Gen. Journal Template";
        DimMgt: Codeunit 408;
        RecEmp: Record Employee;
    begin
        GenLegSetup.Get();
        GenLegSetup.TestField("Loan & Adv Adj Jln Template");
        GenLegSetup.TestField("Loan & Adv Adj Jln Batch");
        Clear(RecGenjline);
        Clear(RecGenJln2);
        Clear(GenJln);
        GenJln.SetCurrentKey(Name);
        GenJln.Get(GenLegSetup."Loan & Adv Adj Jln Template");
        RecGenJln2.SetRange("Journal Template Name", GenLegSetup."Loan & Adv Adj Jln Template");
        RecGenJln2.SetRange("Journal Batch Name", GenLegSetup."Loan & Adv Adj Jln Batch");
        if RecGenJln2.FindLast() then;
        RecGenjline.Init();
        RecGenjline."Journal Template Name" := GenLegSetup."Loan & Adv Adj Jln Template";
        RecGenjline."Journal Batch Name" := GenLegSetup."Loan & Adv Adj Jln Batch";
        RecGenjline."Line No." := RecGenJln2."Line No." + 10000;
        RecGenjline.Insert();
        RecGenjline.Validate("Posting Date", Rec."Posting Date");
        RecGenjline.Validate("Document No.", Rec."Document Number");
        RecGenjline.Validate(Amount, Rec.Amount);
        RecGenjline.Validate("Source Code", GenJln."Source Code");
        RecGenjline.Narration := Rec.Narration;
        if Rec."Account Type" = Rec."Account Type"::"G/L Account" then begin
            RecGenjline.Validate("Account Type", RecGenjline."Account Type"::"G/L Account");
            // RecGenjline.Validate("Bal. Account Type", RecGenjline."Bal. Account Type"::"G/L Account");
        end else
            if rec."Account Type" = Rec."Account Type"::Employee then begin
                RecGenjline.Validate("Account Type", RecGenjline."Account Type"::Employee);
                //   RecGenjline.Validate("Bal. Account Type", RecGenjline."Bal. Account Type"::Employee);
                Clear(RecEmp);
                if RecEmp.GET(Rec."Account No") then;
                RecGenjline."Dimension Set ID" := CopyFromJobDimensionToReleaseProductionOrder(Rec."Account No");
            end;

        RecGenjline.Validate("Account No.", Rec."Account No");
        RecGenjline.Modify(true);
        Commit();
    end;

    procedure CopyFromJobDimensionToReleaseProductionOrder(EmpNo: Code[20]): Integer
    var
        DefaultDimensionRecL: Record "Default Dimension";
        DimensionSetEntryRecL: Record "Dimension Set Entry" temporary;
        DimensionValueRecL: Record "Dimension Value";
        DimensionManagementCU: Codeunit DimensionManagement;
    begin
        DefaultDimensionRecL.Reset();
        DefaultDimensionRecL.SetCurrentKey("Table ID", "No.", "Dimension Code");
        DefaultDimensionRecL.SetRange("Table ID", Database::Employee);
        DefaultDimensionRecL.SetRange("No.", EmpNo);
        if DefaultDimensionRecL.FindSet() then begin
            repeat
                DimensionSetEntryRecL.Init();
                DimensionSetEntryRecL.Validate("Dimension Code", DefaultDimensionRecL."Dimension Code");
                DimensionSetEntryRecL.Validate("Dimension Value Code", DefaultDimensionRecL."Dimension Value Code");

                DimensionValueRecL.Reset();
                DimensionValueRecL.SetRange("Dimension Code", DefaultDimensionRecL."Dimension Code");
                DimensionValueRecL.SetRange(Code, DefaultDimensionRecL."Dimension Value Code");
                if DimensionValueRecL.FindFirst() then
                    DimensionSetEntryRecL.Validate("Dimension Value ID", DimensionValueRecL."Dimension Value ID");

                if DimensionSetEntryRecL.Insert() then;
            until DefaultDimensionRecL.Next() = 0;
        end;

        exit(DimensionManagementCU.GetDimensionSetID(DimensionSetEntryRecL));

    end;


    var
        GenLegSetup: Record "General Ledger Setup";
        RecGenjline: Record "Gen. Journal Line";
        RecGenJln2: Record "Gen. Journal Line";


}


