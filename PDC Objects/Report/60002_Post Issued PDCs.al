report 60002 "Post Issued PDCs"
{
    // 
    // Code           Date        Name        Desc.
    // APNT-LCPDC1.0  20.05.12    Monica      Created New.
    ApplicationArea = All;
    UsageCategory = Administration;
    ProcessingOnly = true;

    dataset
    {
        dataitem("PDC Issue"; "PDC Issue")
        {
            DataItemTableView = WHERE(Status = FILTER(Issued), Cleared = CONST(false), Bounced = CONST(false), Returned = CONST(false));
            RequestFilterFields = "Code", "Document Date";

            trigger OnAfterGetRecord()
            begin

                TestField(Status, Status::Issued);

                if ("Reference Type" = "Reference Type"::Invoice) then begin
                    PDCAppliedAmt.RESET;
                    PDCAppliedAmt.SETRANGE("Transaction Type", PDCAppliedAmt."Transaction Type"::Purchase);
                    PDCAppliedAmt.SETRANGE("Document Type", PDCAppliedAmt."Document Type"::Invoice);
                    PDCAppliedAmt.SETRANGE("PDC No.", Code);
                    if PDCAppliedAmt.FIND('-') then
                        repeat
                            VendLedgEntry.Reset;
                            VendLedgEntry.SetRange("Document Type", VendLedgEntry."Document Type"::Invoice);
                            VendLedgEntry.SetRange("Document No.", PDCAppliedAmt."No.");
                            if VendLedgEntry.Find('-') then begin
                                VendLedgEntry."Applies-to ID" := PDCAppliedAmt."PDC No.";
                                VendLedgEntry.Modify;
                            end;
                        until PDCAppliedAmt.NEXT = 0;


                    GenJnlLine.Init;
                    GenJnlLine.Validate("Journal Template Name", GLSetup."PDC Issue Template");
                    GenJnlLine.Validate("Journal Batch Name", GLSetup."PDC Issue Batch");
                    GenJnlLine."Posting Date" := WorkDate;
                    GenJnlLine."Document Date" := WorkDate;
                    GenJnlLine."Line No." += 10000;
                    GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Vendor);
                    GenJnlLine.Validate("Account No.", "Vendor No.");
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                    GenJnlLine."Document No." := Code;
                    GenJnlLine.Validate("Bal. Account Type", GenJnlLine."Bal. Account Type"::"Bank Account");
                    GenJnlLine.Validate("Bal. Account No.", Bank); //APNT AS Company's Bank Account
                                                                   //GenJnlLine.VALIDATE("Bal. Account No.",GLSetup."PDC Bank Account No.");
                    GenJnlLine.Validate("Currency Code", "Currency Code");
                    //GenJnlLine."Currency Code" := "Currency Code";
                    GenJnlLine.Validate(Amount, Amount);
                    GenJnlLine.Validate("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                    GenJnlLine.Validate("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                    GenJnlLine.Validate("Applies-to ID", Code);
                    GenJnlPostLine.Run(GenJnlLine);

                    PDCAppliedAmt.RESET;
                    PDCAppliedAmt.SETRANGE("PDC No.", Code);
                    if PDCAppliedAmt.FIND('-') then
                        repeat
                            VendLedgEntry.Reset;
                            VendLedgEntry.SetRange("Document Type", VendLedgEntry."Document Type"::Invoice);
                            VendLedgEntry.SetRange("Document No.", PDCAppliedAmt."No.");
                            if VendLedgEntry.Find('-') then begin
                                VendLedgEntry."PDC Applied Amount" := 0;
                                VendLedgEntry.Modify;
                            end;
                            Records += 1;
                            PDCAppliedAmt.Posted := true;
                            PDCAppliedAmt.MODIFY;

                        until PDCAppliedAmt.NEXT = 0;
                end else
                    if ("Reference Type" = "Reference Type"::Invoice) then begin
                        TempAmt := Amount;

                        PDCAppliedAmt.RESET;
                        PDCAppliedAmt.SETRANGE("Transaction Type", PDCAppliedAmt."Transaction Type"::Purchase);
                        PDCAppliedAmt.SETRANGE("Document Type", PDCAppliedAmt."Document Type"::Order);
                        PDCAppliedAmt.SETRANGE("PDC No.", Code);
                        PDCAppliedAmt.SETRANGE(Posted, false);
                        PDCAppliedAmt.SETRANGE(Bounced, false);
                        if PDCAppliedAmt.FIND('-') then
                            repeat
                                Clear(InvAmt);
                                PurchaseInvHeader.Reset;
                                PurchaseInvHeader.SetRange("Order No.", PDCAppliedAmt."No.");
                                if PurchaseInvHeader.Find('-') then begin
                                    repeat
                                        VendLedgEntry.Reset;
                                        VendLedgEntry.SetRange("Vendor No.", "Vendor No.");
                                        VendLedgEntry.SetRange("Document Type", VendLedgEntry."Document Type"::Invoice);
                                        VendLedgEntry.SetRange("Document No.", PurchaseInvHeader."No.");
                                        if VendLedgEntry.Find('-') then begin
                                            VendLedgEntry.CalcFields(VendLedgEntry."Remaining Amount");
                                            VendLedgEntry."Applies-to ID" := Code;
                                            VendLedgEntry.Modify;

                                            if TempAmt <> 0 then begin
                                                GenJnlLine.Init;
                                                GenJnlLine.Validate("Journal Template Name", GLSetup."PDC Issue Template");
                                                GenJnlLine.Validate("Journal Batch Name", GLSetup."PDC Issue Batch");
                                                GenJnlLine."Posting Date" := WorkDate;
                                                GenJnlLine."Document Date" := WorkDate;
                                                GenJnlLine."Line No." += 10000;
                                                GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Vendor);
                                                GenJnlLine.Validate("Account No.", "Vendor No.");
                                                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                                                GenJnlLine."Document No." := Code;
                                                GenJnlLine.Validate("Bal. Account Type", GenJnlLine."Bal. Account Type"::"Bank Account");
                                                GenJnlLine.Validate("Bal. Account No.", Bank);
                                                //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.",GLSetup."PDC Bank Account No.");
                                                GenJnlLine.Validate("Currency Code", "Currency Code");
                                                if VendLedgEntry."Remaining Amount" > (TempAmt) then begin
                                                    GenJnlLine.Validate(Amount, -1 * TempAmt);
                                                    TempAmt := 0;
                                                    Records += 1;
                                                    PDCAppliedAmt.Posted := true;
                                                    PDCAppliedAmt.MODIFY;
                                                end else begin
                                                    GenJnlLine.Validate(Amount, -1 * VendLedgEntry."Remaining Amount");
                                                    TempAmt := TempAmt - VendLedgEntry."Remaining Amount";
                                                    Records += 1;
                                                    PDCAppliedAmt.Posted := true;
                                                    PDCAppliedAmt.MODIFY;
                                                end;
                                                GenJnlLine.Validate("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                                                GenJnlLine.Validate("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                                                GenJnlLine.Validate("Applies-to ID", Code);
                                                GenJnlPostLine.Run(GenJnlLine);
                                            end;
                                        end;
                                    until PurchaseInvHeader.Next = 0;

                                    if TempAmt <> 0 then begin
                                        GenJnlLine.Init;
                                        GenJnlLine.Validate("Journal Template Name", GLSetup."PDC Issue Template");
                                        GenJnlLine.Validate("Journal Batch Name", GLSetup."PDC Issue Batch");
                                        GenJnlLine."Posting Date" := WorkDate;
                                        GenJnlLine."Document Date" := WorkDate;
                                        GenJnlLine."Line No." += 10000;
                                        GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Vendor);
                                        GenJnlLine.Validate("Account No.", "Vendor No.");
                                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                                        GenJnlLine."Document No." := Code;
                                        GenJnlLine.Validate("Bal. Account Type", GenJnlLine."Bal. Account Type"::"Bank Account");
                                        GenJnlLine.Validate("Bal. Account No.", Bank);
                                        //GenJnlLine.VALIDATE("Bal. Account No.",GLSetup."PDC Bank Account No.");
                                        GenJnlLine.Validate("Currency Code", "Currency Code");
                                        GenJnlLine.Validate(Amount, -1 * TempAmt);
                                        GenJnlLine.Validate("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                                        GenJnlLine.Validate("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                                        GenJnlLine.Validate("Applies-to ID", Code);
                                        GenJnlPostLine.Run(GenJnlLine);
                                        TempAmt := 0;
                                        Records += 1;
                                        PDCAppliedAmt.Posted := true;
                                        PDCAppliedAmt.MODIFY;
                                    end
                                end else begin
                                    GenJnlLine.Init;
                                    GenJnlLine.Validate("Journal Template Name", GLSetup."PDC Issue Template");
                                    GenJnlLine.Validate("Journal Batch Name", GLSetup."PDC Issue Batch");
                                    GenJnlLine."Posting Date" := WorkDate;
                                    GenJnlLine."Document Date" := WorkDate;
                                    GenJnlLine."Line No." += 10000;
                                    GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Vendor);
                                    GenJnlLine.Validate("Account No.", "Vendor No.");
                                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                                    GenJnlLine."Document No." := Code;
                                    GenJnlLine.Validate("Bal. Account Type", GenJnlLine."Bal. Account Type"::"Bank Account");
                                    GenJnlLine.Validate("Bal. Account No.", Bank);
                                    //GenJnlLine.VALIDATE("Bal. Account No.",GLSetup."PDC Bank Account No.");
                                    GenJnlLine.Validate("Currency Code", "Currency Code");
                                    GenJnlLine.Validate(Amount, -1 * TempAmt);
                                    GenJnlLine.Validate("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                                    GenJnlLine.Validate("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                                    GenJnlLine.Validate("Applies-to ID", Code);
                                    GenJnlPostLine.Run(GenJnlLine);
                                    Records += 1;
                                    PDCAppliedAmt.Posted := true;
                                    PDCAppliedAmt.MODIFY;
                                end;
                            until PDCAppliedAmt.NEXT = 0;
                    end else
                        if "PDC Issue"."Reference Type" = "PDC Issue"."Reference Type"::" " then begin
                            GenJnlLine.Init;
                            GenJnlLine.Validate("Journal Template Name", GLSetup."PDC Issue Template");
                            GenJnlLine.Validate("Journal Batch Name", GLSetup."PDC Issue Batch");
                            GenJnlLine."Posting Date" := WorkDate;
                            GenJnlLine."Document Date" := WorkDate;
                            GenJnlLine."Line No." += 10000;
                            GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Vendor);
                            GenJnlLine.Validate("Account No.", "Vendor No.");
                            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                            GenJnlLine."Document No." := Code;
                            GenJnlLine.Validate("Bal. Account Type", GenJnlLine."Bal. Account Type"::"Bank Account");
                            GenJnlLine.Validate("Bal. Account No.", Bank);
                            //GenJnlLine.VALIDATE("Bal. Account No.",GLSetup."PDC Bank Account No.");
                            GenJnlLine.Validate("Currency Code", "Currency Code");
                            GenJnlLine.Validate(Amount, Amount);
                            GenJnlLine.Validate("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                            GenJnlLine.Validate("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                            GenJnlLine.Validate("Applies-to ID", Code);
                            GenJnlPostLine.Run(GenJnlLine);
                            Records += 1;
                            PDCAppliedAmt.Posted := true;
                            PDCAppliedAmt.MODIFY;
                        end;
                "Posting Date" := WorkDate;
                Cleared := true;
                Modify;
            end;

            trigger OnPostDataItem()
            begin
                Message('PDCs have been succesfully posted');
            end;

            trigger OnPreDataItem()
            begin

                GLSetup.Get();
                GLSetup.TestField("PDC Issue Template");
                GLSetup.TestField("PDC Issue Batch");

                GenJnlLine.Reset;
                GenJnlLine.SetRange(GenJnlLine."Journal Template Name", GLSetup."PDC Issue Template");
                GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", GLSetup."PDC Issue Batch");
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
        PDCAppliedAmt: Record "PDC Applied Amount";
        VendLedgEntry: Record "Vendor Ledger Entry";
        GLSetup: Record "General Ledger Setup";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        TempAmt: Decimal;
        InvAmt: Decimal;
        PurchaseInvHeader: Record "Purch. Inv. Header";
        Records: Integer;
}

