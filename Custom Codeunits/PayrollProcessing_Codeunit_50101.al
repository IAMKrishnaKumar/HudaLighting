codeunit 50101 PayrollProcessing
{
    TableNo = "Payroll Staging";
    trigger OnRun()
    var
        GenJln: Record "Gen. Journal Template";
        DimMgt: Codeunit 408;
    begin
        GenLegSetup.Get();
        GenLegSetup.TestField("Payroll Journal Template");
        GenLegSetup.TestField("Payroll Journal Batch");
        GenLegSetup.TestField("Department Dimension Code");
        GenLegSetup.TestField("Payroll Journal Batch");
        Clear(RecGenjline);
        Clear(RecGenJln2);
        Clear(GenJln);
        GenJln.SetCurrentKey(Name);
        GenJln.Get(GenLegSetup."Payroll Journal Template");
        RecGenJln2.SetRange("Journal Template Name", GenLegSetup."Payroll Journal Template");
        RecGenJln2.SetRange("Journal Batch Name", GenLegSetup."Payroll Journal Batch");
        if RecGenJln2.FindLast() then;
        RecGenjline.Init();
        RecGenjline."Journal Template Name" := GenLegSetup."Payroll Journal Template";
        RecGenjline."Journal Batch Name" := GenLegSetup."Payroll Journal Batch";
        RecGenjline."Line No." := RecGenJln2."Line No." + 10000;
        RecGenjline.Insert();
        RecGenjline.Validate("Posting Date", Rec."Posting Date");
        RecGenjline.Validate("Document No.", Rec."Document Number");
        RecGenjline.Validate("Account Type", RecGenjline."Account Type"::"G/L Account");
        RecGenjline.Validate("Account No.", Rec."Account No");
        RecGenjline.Validate(Amount, Rec.Amount);
        RecGenjline.Validate("Source Code", GenJln."Source Code");
        RecGenjline.Narration := Rec.Narration;
        RecGenjline."Shortcut Dimension 1 Code" := Rec."Department Code";
        RecGenjline."Shortcut Dimension 2 Code" := Rec."Branch Code";
        RecGenjline."Dimension Set ID" := CheckAndCreateDim(Rec."Department Code", Rec."Branch Code");
        // RecGenjline.Validate("Bal. Account Type", RecGenjline."Bal. Account Type"::"G/L Account");
        // RecGenjline.Validate("Bal. Account No.", Rec."Account No");
        RecGenjline.Modify(true);
        Commit();
    end;

    procedure CheckAndCreateDim(DimValL: Text[20]; DimValL2: Text[20]): Integer
    var

        DimensionSetEntryRecL: Record "Dimension Set Entry" temporary;
        DimensionManagementCU: Codeunit DimensionManagement;
        Dim: Record Dimension;
        DimValue: Record "Dimension Value";
        Dim2: Record Dimension;
        DimValue2: Record "Dimension Value";
    begin
        Clear(Dim);
        Clear(DimValue);
        DimValue.SetRange("Dimension Code", GenLegSetup."Department Dimension Code");
        DimValue.SetRange(Code, DimValL);
        If not DimValue.FindFirst() then begin
            DimValue.Init();
            DimValue.Validate("Dimension Code", GenLegSetup."Department Dimension Code");
            DimValue.Validate(Code, DimValL);
            DimValue.Validate("Global Dimension No.", 1);
            DimValue.Validate(Name, DimValL);
            DimValue.Validate("Dimension Value Type", DimValue."Dimension Value Type"::Standard);
            DimValue.Insert;
        end;
        Clear(Dim2);
        Clear(DimValue2);
        DimValue2.SetRange("Dimension Code", GenLegSetup."Branch Dimension Code");
        DimValue2.SetRange(Code, DimValL2);
        If not DimValue2.FindFirst() then begin
            DimValue2.Init();
            DimValue2.Validate("Dimension Code", GenLegSetup."Branch Dimension Code");
            DimValue2.Validate(Code, DimValL2);
            DimValue2.Validate("Global Dimension No.", 2);
            DimValue2.Validate(Name, DimValL2);
            DimValue2.Validate("Dimension Value Type", DimValue2."Dimension Value Type"::Standard);
            DimValue2.Insert;
        end;

        DimensionSetEntryRecL.Init();
        DimensionSetEntryRecL.Validate("Dimension Code", GenLegSetup."Department Dimension Code");
        DimensionSetEntryRecL.Validate("Dimension Value Code", DimValL);
        DimensionSetEntryRecL.Insert();
        DimensionSetEntryRecL.Init();
        DimensionSetEntryRecL.Validate("Dimension Code", GenLegSetup."Branch Dimension Code");
        DimensionSetEntryRecL.Validate("Dimension Value Code", DimValL2);
        DimensionSetEntryRecL.Insert();
        exit(DimensionManagementCU.GetDimensionSetID(DimensionSetEntryRecL));

    end;

    var
        GenLegSetup: Record "General Ledger Setup";
        RecGenjline: Record "Gen. Journal Line";
        RecGenJln2: Record "Gen. Journal Line";

}