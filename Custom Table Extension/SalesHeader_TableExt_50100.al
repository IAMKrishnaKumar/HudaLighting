tableextension 50100 SalesHeader extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Project Reference"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Project Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Bank Guarantee No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Security ChecK No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Check Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Bank Guarantee Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Check Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Bank Guarantee Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Date of Installation"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Hourly Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "End Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Total Time"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Installation Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Estimated Order Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50016; "Project Handover"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "LC No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "LC Exp Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "LC Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "LC Payment Terms"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms".Code;
        }
        field(50021; "Amount (In Arabic)"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Retail Location"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup (Location."Retail Location" where(Code = field("Location Code")));
        }
        field(50023; "Advance Payment"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "PO Reference"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Check Collected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Priority"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Delivery Time"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Sales Person Share"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Non Stock Invoiced"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Sales Invoice Line"."Amount" where(Type = const(Item), "Item Type" = filter('<>Inventory'), "Sales Order No." = field("No.")));
        }
        field(50031; "G/L Invoiced"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Sales Invoice Line"."Amount" where(Type = const("G/L Account"), "Sales Order No." = field("No."), "No." = filter('<>201610&<>103350&<>201950')));
        }
        field(50032; "UE Sales"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Sales Line"."UE Sales" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
        field(50033; "UE GP"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Sales Line"."UE GP" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
        field(50034; "UE Sales ACY"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Sales Line"."ACY UE Sales" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
        field(50035; "UE GP ACY"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Sales Line"."ACY UE GP" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
        field(50036; "Share %"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup ("Sales Person Main"."Share %" where("Opportunity No" = field("Shortcut Dimension 1 Code"), Salesperson = field("Salesperson Code")));
        }
        field(50037; "G/L Invoiced (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Non Stock Invoiced (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "Withholding Tax (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Sales Line"."UE Sales" where("Document Type" = field("Document Type"), "Document No." = field("No."), Type = const("G/L Account"), "No." = filter('201950')));
        }
        field(50040; "Withholding Tax (ACY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Sales Line"."ACY UE Sales" where("Document Type" = field("Document Type"), "Document No." = field("No."), Type = const("G/L Account"), "No." = filter('201950')));
        }
        field(50041; "Amount Shipped Not Inv. (ACY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Sales Line"."Amount Shipped Not Inv. (ACY)" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
        field(50042; "G/L Invoiced (ACY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "Non Stock Invoiced (ACY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        //***********************************PDC************************
        field(60000; "Applies-to ID for PDC"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Applies-to ID for PDC';
        }
        field(60001; "Remaining Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Remaining Amount';
        }
        field(60002; "Order Amount LCPDC"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Order Amount LCPDC';
        }
        field(60003; "PDC Applied Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Applied Amount';
        }
        field(60004; "Export L.C. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Export L.C. No.';
        }
        field(60005; "Discount Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60006; "Approved On"; Date)
        {
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
        }
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            var
                RecSalesPersonShare: Record "Sales Person Main";
            begin
                if "Shortcut Dimension 1 Code" <> '' then begin
                    Clear(RecSalesPersonShare);
                    RecSalesPersonShare.SetRange("Opportunity No", "Shortcut Dimension 1 Code");
                    if RecSalesPersonShare.FindFirst() then
                        "Sales Person Share" := true
                    else
                        "Sales Person Share" := false;
                end else
                    "Sales Person Share" := false;
            end;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                RecCust: Record Customer;
                RecPM: Record "Payment Milestone";
            begin
                if "Document Type" = "Document Type"::Order then begin
                    Clear(RecCust);
                    if RecCust.GET("Sell-to Customer No.") then begin
                        RecCust.TestField("Customer Posting Group");
                        RecCust.TestField("Gen. Bus. Posting Group");
                        RecCust.TestField("VAT Bus. Posting Group");
                    end;
                end;
                if ("Document Type" = "Document Type"::Invoice) OR ("Document Type" = "Document Type"::Order) then begin
                    if Rec."Sell-to Customer No." <> xRec."Sell-to Customer No." then begin
                        Clear(RecPM);
                        RecPM.SetRange("Document Type", Rec."Document Type");
                        RecPM.SetRange("Document No.", "No.");
                        if RecPM.FindSet() then
                            RecPM.DeleteAll();
                    end;
                end;
            end;
        }
    }



    trigger OnAfterDelete()
    var
        RecPM: Record "Payment Milestone";
    begin
        if ("Document Type" = "Document Type"::Invoice) OR ("Document Type" = "Document Type"::Order) then begin
            Clear(RecPM);
            RecPM.SetRange("Document Type", Rec."Document Type");
            RecPM.SetRange("Document No.", "No.");
            if RecPM.FindSet() then
                RecPM.DeleteAll();
        end;
    end;

    trigger OnAfterModify()
    var
        RecPaymentMileStone: Record "Payment Milestone";
        RecSheader: Record "Sales Header";
    begin
        if ("Document Type" <> "Document Type"::Order) OR ("Document Type" <> "Document Type"::Invoice) then
            exit;
        Clear(RecPaymentMileStone);
        Clear(RecSheader);
        RecSheader.SetRange("Document Type", "Document Type");
        RecSheader.SetRange("No.", "No.");
        if RecSheader.FindFirst() then;
        RecSheader.CalcFields(Amount);
        RecPaymentMileStone.SetRange("Document Type", "Document Type");
        RecPaymentMileStone.SetRange("Document No.", "No.");
        if RecPaymentMileStone.FindSet() then begin
            repeat
                RecPaymentMileStone.Validate("Currency Factor", RecSheader."Currency Factor");
                RecPaymentMileStone.Validate("Total Value", RecSheader.Amount);
                RecPaymentMileStone.Validate(Amount, (RecSheader.Amount * RecPaymentMileStone."Milestone %") / 100);
                RecPaymentMileStone.Modify();
            until RecPaymentMileStone.Next() = 0;
        end;
        if "Document Type" = "Document Type"::Order then begin
            if Status = Status::"Pending Prepayment" then begin
                "Advance Payment" := true;
                Rec.Modify();
            end;
        end;


    end;

    procedure CheckAndCreateDim(DimValL: Text[20]; DimSetId: Integer): Integer
    var

        DimensionSetEntryRecL: Record "Dimension Set Entry" temporary;
        DimensionManagementCU: Codeunit DimensionManagement;
        Dim: Record Dimension;
        DimValue: Record "Dimension Value";
        Dim2: Record Dimension;
        DimValue2: Record "Dimension Value";
        GenLedgSetup: Record "General Ledger Setup";
    begin
        GenLedgSetup.GET;
        Clear(DimValue);
        DimValue.SetRange("Dimension Code", GenLedgSetup."Global Dimension 1 Code");
        DimValue.SetRange(Code, DimValL);
        If not DimValue.FindFirst() then begin
            DimValue.Init();
            DimValue.Validate("Dimension Code", GenLedgSetup."Global Dimension 1 Code");
            DimValue.Validate(Code, DimValL);
            DimValue.Validate("Global Dimension No.", 1);
            DimValue.Validate(Name, DimValL);
            DimValue.Validate("Dimension Value Type", DimValue."Dimension Value Type"::Standard);
            DimValue.Insert;
        end;
        Clear(DimensionSetEntryRecL);
        DimensionSetEntryRecL.SetRange("Dimension Code", GenLedgSetup."Global Dimension 1 Code");
        DimensionSetEntryRecL.SetRange("Dimension Set ID", DimSetId);
        if DimensionSetEntryRecL.FindFirst() then begin
            DimensionSetEntryRecL.Validate("Dimension Value Code", DimValL);
            DimensionSetEntryRecL.Modify(true);
        end else begin
            DimensionSetEntryRecL.Init();
            DimensionSetEntryRecL.Validate("Dimension Code", GenLedgSetup."Global Dimension 1 Code");
            DimensionSetEntryRecL.Validate("Dimension Value Code", DimValL);
            if DimSetId <> 0 then begin
                DimensionSetEntryRecL.Validate("Dimension Set ID", DimSetId);
                DimensionSetEntryRecL.Insert();
                exit(DimSetId);
            end else begin
                DimensionSetEntryRecL.Insert();
                exit(DimensionManagementCU.GetDimensionSetID(DimensionSetEntryRecL));
            end;
        end;
    end;

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        "Created By" := UserId;
    end;


    var
        myInt: Integer;
}