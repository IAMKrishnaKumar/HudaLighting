report 60001 "Post Received PDCs"
{
    // 
    // Code           Date        Name        Desc.
    // APNT-LCPDC1.0  20.05.12    Monica      Created New.
    ApplicationArea = All;
    UsageCategory = Administration;
    ProcessingOnly = true;

    dataset
    {
        dataitem("PDC Receipt"; "PDC Receipt")
        {
            DataItemTableView = WHERE(Status = CONST(Received), Cleared = CONST(false), Bounced = CONST(false), "Returned/ Not Encashed" = CONST(false));
            RequestFilterFields = "Code", "Document Date";

            trigger OnAfterGetRecord()
            begin

                TestField(Status, Status::Received);
                if "Reference Type" = "Reference Type"::Invoice then begin
                    PDCAppliedAmt.RESET;
                    PDCAppliedAmt.SETRANGE("PDC No.", Code);
                    PDCAppliedAmt.SETRANGE("Transaction Type", PDCAppliedAmt."Transaction Type"::Sales);
                    PDCAppliedAmt.SETRANGE("Document Type", PDCAppliedAmt."Document Type"::Invoice);
                    PDCAppliedAmt.SETRANGE(Posted, false);
                    PDCAppliedAmt.SETRANGE(Bounced, false);
                    if PDCAppliedAmt.FIND('-') then
                        repeat
                            CustLedgEntry.Reset;
                            CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::Invoice);
                            CustLedgEntry.SetRange("Document No.", PDCAppliedAmt."No.");
                            if CustLedgEntry.Find('-') then begin
                                CustLedgEntry."Applies-to ID" := PDCAppliedAmt."PDC No.";
                                CustLedgEntry.Modify;
                            end;
                        until PDCAppliedAmt.NEXT = 0;

                    GenJnlLine.Init;
                    GenJnlLine.Validate("Journal Template Name", GLSetup."PDC Issue Template");
                    GenJnlLine.Validate("Journal Batch Name", GLSetup."PDC Issue Batch");
                    GenJnlLine."Posting Date" := WorkDate;
                    GenJnlLine."Document Date" := WorkDate;
                    GenJnlLine."Line No." += 10000;
                    GenJnlLine.Validate(GenJnlLine."Account Type", GenJnlLine."Account Type"::Customer);
                    GenJnlLine.Validate(GenJnlLine."Account No.", "Customer No.");
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                    GenJnlLine."Document No." := Code;
                    GenJnlLine.Validate(GenJnlLine."Bal. Account Type", GenJnlLine."Bal. Account Type"::"Bank Account");
                    GenJnlLine.Validate(GenJnlLine."Bal. Account No.", GLSetup."PDC Bank Account No.");
                    GenJnlLine.Validate(GenJnlLine."Currency Code", "Currency Code");
                    GenJnlLine."Currency Code" := "Currency Code";
                    GenJnlLine.Validate(GenJnlLine.Amount, Amount);
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                    GenJnlLine.Validate(GenJnlLine."Applies-to ID", Code);
                    GenJnlPostLine.Run(GenJnlLine);

                    PDCAppliedAmt.RESET;
                    PDCAppliedAmt.SETRANGE("PDC No.", Code);
                    PDCAppliedAmt.SETRANGE("Transaction Type", PDCAppliedAmt."Transaction Type"::Sales);
                    PDCAppliedAmt.SETRANGE("Document Type", PDCAppliedAmt."Document Type"::Invoice);
                    PDCAppliedAmt.SETRANGE(Posted, false);
                    PDCAppliedAmt.SETRANGE(Bounced, false);
                    if PDCAppliedAmt.FIND('-') then
                        repeat
                            CustLedgEntry.Reset;
                            CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::Invoice);
                            CustLedgEntry.SetRange("Document No.", PDCAppliedAmt."No.");
                            if CustLedgEntry.Find('-') then begin
                                CustLedgEntry."PDC Applied Amount" := 0;
                                CustLedgEntry.Modify;
                            end;
                            PDCAppliedAmt.Posted := true;
                            PDCAppliedAmt.MODIFY;
                        until PDCAppliedAmt.NEXT = 0;
                    Records += 1;
                    Cleared := true;
                    "Posting Date" := WorkDate;
                    Modify;
                end else
                    if ("Reference Type" = "Reference Type"::Invoice) then begin
                        TempAmt := -1 * Amount;
                        PDCAppliedAmt.RESET;
                        PDCAppliedAmt.SETRANGE("Transaction Type", PDCAppliedAmt."Transaction Type"::Sales);
                        PDCAppliedAmt.SETRANGE("Document Type", PDCAppliedAmt."Document Type"::Order);
                        PDCAppliedAmt.SETRANGE("PDC No.", Code);
                        PDCAppliedAmt.SETRANGE(Posted, false);
                        PDCAppliedAmt.SETRANGE(Bounced, false);
                        if PDCAppliedAmt.FIND('-') then
                            repeat
                                Clear(InvAmt);
                                SalesInvHeader.Reset;
                                SalesInvHeader.SetRange("Order No.", PDCAppliedAmt."No.");
                                if SalesInvHeader.Find('-') then begin
                                    repeat
                                        CustLedgEntry.Reset;
                                        CustLedgEntry.SetRange("Customer No.", "Customer No.");
                                        CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::Invoice);
                                        CustLedgEntry.SetRange("Document No.", SalesInvHeader."No.");
                                        if CustLedgEntry.Find('-') then begin
                                            CustLedgEntry.CalcFields(CustLedgEntry."Remaining Amount");
                                            CustLedgEntry."Applies-to ID" := Code;
                                            CustLedgEntry.Modify;

                                            if TempAmt <> 0 then begin
                                                GenJnlLine.Init;
                                                GenJnlLine.Validate("Journal Template Name", GLSetup."PDC Issue Template");
                                                GenJnlLine.Validate("Journal Batch Name", GLSetup."PDC Issue Batch");
                                                GenJnlLine."Posting Date" := WorkDate;
                                                GenJnlLine."Document Date" := WorkDate;
                                                GenJnlLine."Line No." += 10000;
                                                GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Customer);
                                                GenJnlLine.Validate("Account No.", "Customer No.");
                                                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                                                GenJnlLine."Document No." := Code;
                                                GenJnlLine.Validate("Bal. Account Type", GenJnlLine."Bal. Account Type"::"Bank Account");
                                                GenJnlLine.Validate("Bal. Account No.", GLSetup."PDC Bank Account No.");
                                                GenJnlLine.Validate("Currency Code", "Currency Code");
                                                if CustLedgEntry."Remaining Amount" > TempAmt then begin
                                                    GenJnlLine.Validate(GenJnlLine.Amount, -1 * TempAmt);
                                                    TempAmt := 0;
                                                    PDCAppliedAmt.Posted := true;
                                                    PDCAppliedAmt.MODIFY;
                                                end else begin
                                                    GenJnlLine.Validate(Amount, -1 * CustLedgEntry."Remaining Amount");
                                                    TempAmt := TempAmt - CustLedgEntry."Remaining Amount";
                                                    PDCAppliedAmt.Posted := true;
                                                    PDCAppliedAmt.MODIFY;
                                                end;
                                                GenJnlLine.Validate("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                                                GenJnlLine.Validate("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                                                GenJnlLine.Validate("Applies-to ID", Code);
                                                GenJnlPostLine.Run(GenJnlLine);
                                                Records += 1;
                                            end;
                                        end;
                                    until SalesInvHeader.Next = 0;
                                    if TempAmt <> 0 then begin
                                        GenJnlLine.Init;
                                        GenJnlLine.Validate("Journal Template Name", GLSetup."PDC Issue Template");
                                        GenJnlLine.Validate("Journal Batch Name", GLSetup."PDC Issue Batch");
                                        GenJnlLine."Posting Date" := WorkDate;
                                        GenJnlLine."Document Date" := WorkDate;
                                        GenJnlLine."Line No." += 10000;
                                        GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Customer);
                                        GenJnlLine.Validate("Account No.", "Customer No.");
                                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                                        GenJnlLine."Document No." := Code;
                                        GenJnlLine.Validate("Bal. Account Type", GenJnlLine."Bal. Account Type"::"Bank Account");
                                        GenJnlLine.Validate("Bal. Account No.", GLSetup."PDC Bank Account No.");
                                        GenJnlLine.Validate("Currency Code", "Currency Code");
                                        GenJnlLine.Validate(Amount, -1 * TempAmt);
                                        GenJnlLine.Validate("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                                        GenJnlLine.Validate("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                                        GenJnlLine.Validate("Applies-to ID", Code);
                                        GenJnlPostLine.Run(GenJnlLine);
                                        TempAmt := 0;
                                        PDCAppliedAmt.Posted := true;
                                        PDCAppliedAmt.MODIFY;
                                        Records += 1;
                                    end;
                                end else begin
                                    GenJnlLine.Init;
                                    GenJnlLine.Validate("Journal Template Name", GLSetup."PDC Issue Template");
                                    GenJnlLine.Validate("Journal Batch Name", GLSetup."PDC Issue Batch");
                                    GenJnlLine."Posting Date" := WorkDate;
                                    GenJnlLine."Document Date" := WorkDate;
                                    GenJnlLine."Line No." += 10000;
                                    GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Customer);
                                    GenJnlLine.Validate("Account No.", "Customer No.");
                                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                                    GenJnlLine."Document No." := Code;
                                    GenJnlLine.Validate("Bal. Account Type", GenJnlLine."Bal. Account Type"::"Bank Account");
                                    GenJnlLine.Validate("Bal. Account No.", GLSetup."PDC Bank Account No.");
                                    GenJnlLine.Validate("Currency Code", "Currency Code");
                                    GenJnlLine.Validate(Amount, Amount);
                                    GenJnlLine.Validate("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                                    GenJnlLine.Validate("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                                    GenJnlPostLine.Run(GenJnlLine);
                                    PDCAppliedAmt.Posted := true;
                                    PDCAppliedAmt.MODIFY;
                                    Records += 1;
                                end;
                            until PDCAppliedAmt.NEXT = 0;
                        Cleared := true;
                        "Posting Date" := WorkDate;
                        Modify;
                    end else
                        if "Reference Type" = "Reference Type"::" " then begin
                            PDCAppliedAmt.RESET;
                            PDCAppliedAmt.SETRANGE("Transaction Type", PDCAppliedAmt."Transaction Type"::Sales);
                            PDCAppliedAmt.SETRANGE("PDC No.", Code);
                            PDCAppliedAmt.SETRANGE(Posted, false);
                            PDCAppliedAmt.SETRANGE(Bounced, false);
                            if PDCAppliedAmt.FIND('-') then
                                repeat
                                    GenJnlLine.Init;
                                    GenJnlLine.Validate("Journal Template Name", GLSetup."PDC Issue Template");
                                    GenJnlLine.Validate("Journal Batch Name", GLSetup."PDC Issue Batch");
                                    GenJnlLine."Posting Date" := WorkDate;
                                    GenJnlLine."Document Date" := WorkDate;
                                    GenJnlLine."Line No." += 10000;
                                    GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Customer);
                                    GenJnlLine.Validate("Account No.", "Customer No.");
                                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                                    GenJnlLine."Document No." := Code;
                                    GenJnlLine.Validate("Bal. Account Type", GenJnlLine."Bal. Account Type"::"Bank Account");
                                    GenJnlLine.Validate("Bal. Account No.", GLSetup."PDC Bank Account No.");
                                    GenJnlLine.Validate("Currency Code", "Currency Code");
                                    GenJnlLine.Validate(Amount, Amount);
                                    GenJnlLine.Validate("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                                    GenJnlLine.Validate("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                                    GenJnlPostLine.Run(GenJnlLine);
                                    PDCAppliedAmt.Posted := true;
                                    PDCAppliedAmt.MODIFY;
                                until PDCAppliedAmt.NEXT = 0;
                            Cleared := true;
                            "Posting Date" := WorkDate;
                            Modify;
                            Records += 1;
                        end;
            end;

            trigger OnPostDataItem()
            begin
                Message('No. of PDCs posted successfully : %1', Records);
            end;

            trigger OnPreDataItem()
            begin

                Clear(Records);
                GLSetup.Get();
                GLSetup.TestField(GLSetup."PDC Issue Template");
                GLSetup.TestField(GLSetup."PDC Issue Batch");

                GenJnlLine.Reset;
                GenJnlLine.SetRange("Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.SetRange("Journal Batch Name", GLSetup."PDC Issue Batch");
                GenJnlLine.DeleteAll;
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

    var
        Records: Integer;
        PDCAppliedAmt: Record "PDC Applied Amount";
        CustLedgEntry: Record "Cust. Ledger Entry";
        GLSetup: Record "General Ledger Setup";
        GenJnlLine: Record "Gen. Journal Line";
        InvAmt: Decimal;
        SalesInvHeader: Record "Sales Invoice Header";
        TempAmt: Decimal;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
}

