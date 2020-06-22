table 50105 "Payment Milestone"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Payment Milestone";
    LookupPageId = "Payment Application";
    fields
    {
        field(1; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Order,Invoice;
            Editable = false;
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Posting Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Advance,Running,Retention;

            trigger OnValidate()
            var
                RecPM: Record "Payment Milestone";
            begin
                if "Posting Type" <> "Posting Type"::Running then begin
                    Clear(RecPM);
                    RecPM.SetRange("Document No.", "Document No.");
                    RecPM.SetRange("Document Type", "Document Type");
                    RecPM.SetRange("Posting Type", "Posting Type");
                    if RecPM.FindFirst() then begin
                        if "Line No." <> RecPM."Line No." then
                            Error('You cannot enter Posting Type ' + FORMAT("Posting Type") + ' more than once.');
                    end;

                end;
            end;
        }
        field(6; "Milestone %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            var
                RecPM: Record "Payment Milestone";
                TotalPer: Decimal;
            begin
                if "Milestone %" > 100 then
                    Error('Milestone % should not exceed 100.');
                Clear(RecPM);
                Clear(TotalPer);
                TotalPer := "Milestone %";
                RecPM.SetRange("Document Type", "Document Type");
                RecPM.SetRange("Document No.", "Document No.");
                RecPM.SetFilter("Line No.", '<>%1', "Line No.");
                if RecPM.FindSet() then begin
                    repeat
                        TotalPer += RecPM."Milestone %";
                    until RecPM.Next() = 0;
                end;
                if TotalPer > 100 then
                    Error('Sum of Milestone % must be 100.');
                Validate(Amount, ("Total Value" * "Milestone %") / 100);
                if "Currency Factor" = 0 then
                    "Total Value(LCY)" := "Total Value"
                else
                    "Total Value(LCY)" := "Total Value" / "Currency Factor"

            end;

        }
        field(7; "Milestone Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Payment Terms"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms".Code;

            trigger OnValidate()
            var
                PT: Record "Payment Terms";
            begin
                if "Payment Terms" <> '' then begin
                    Clear(PT);
                    IF PT.GET("Payment Terms") then
                        "Due Date" := CALCDATE(PT."Due Date Calculation", "Document Date");
                end else
                    "Due Date" := 0D;
            end;
        }
        field(9; "Total Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Validate(Amount, ("Total Value" * "Milestone %") / 100);
                if "Currency Factor" = 0 then
                    "Total Value(LCY)" := "Total Value"
                else
                    "Total Value(LCY)" := "Total Value" / "Currency Factor";
            end;
        }
        field(10; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Currency Factor" = 0 then
                    "Amount LCY" := Amount
                else
                    "Amount LCY" := Amount / "Currency Factor";
            end;
        }
        field(12; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Amount LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Currency Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Currency Factor" = 0 then
                    "Currency Factor" := 1;
            end;
        }
        field(15; "Total Value(LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                RecCust: Record Customer;
            begin
                if "Customer No." <> '' then begin
                    Clear(RecCust);
                    If RecCust.GET("Customer No.") then begin
                        "Customer Name" := RecCust.Name;
                    end;
                end;

            end;
        }
        field(17; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; IsPosted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Invoiced"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Document No.", "Document Type", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        PaymentML: Record "Payment Milestone";
        SHeader: Record "Sales Header";
        RecPT: Record "Payment Terms";
        RecPM: Record "Payment Milestone";
    begin
        Clear(PaymentML);
        PaymentML.SetRange("Document Type", "Document Type");
        PaymentML.SetRange("Document No.", "Document No.");
        if PaymentML.FindLast() then
            "Line No." := PaymentML."Line No." + 10000
        else
            "Line No." := 10000;

        if "Milestone %" > 100 then
            Error('Milestone % should not exceed 100.');
        Clear(SHeader);
        SHeader.SetRange("Document Type", "Document Type");
        SHeader.SetRange("No.", "Document No.");
        IF SHeader.FindFirst() then begin
            SHeader.TestField("Currency Code");
            Clear(RecPT);
            IF RecPT.GET(SHeader."Payment Terms Code") then begin
                if not RecPT."Payment Milestone Mandatory" then
                    Error('Payment Milestone is not allowed for selected Payment Terms Code.');
            end;
            VALIDATE("Currency Factor", SHeader."Currency Factor");
            Validate("Customer No.", SHeader."Sell-to Customer No.");
        end;

        if "Posting Type" <> "Posting Type"::Running then begin
            Clear(RecPM);
            RecPM.SetRange("Document No.", "Document No.");
            RecPM.SetRange("Document Type", "Document Type");
            RecPM.SetRange("Posting Type", "Posting Type");
            if RecPM.FindFirst() then begin
                if "Line No." <> RecPM."Line No." then
                    Error('You cannot enter Posting Type ' + FORMAT("Posting Type") + ' more than once.');
            end;
        end;
    end;

    trigger OnModify()
    var
        RecSheader: Record "Sales Header";
    begin
        Clear(RecSheader);
        RecSheader.SetRange("Document Type", "Document Type"::Order);
        RecSheader.SetRange("No.", "Document No.");
        if RecSheader.FindFirst() then begin
            RecSheader.TestField(Status, RecSheader.Status::Open);
        end;
    end;

    trigger OnDelete()
    var
        RecSheader: Record "Sales Header";
    begin
        Clear(RecSheader);
        RecSheader.SetRange("Document Type", "Document Type"::Order);
        RecSheader.SetRange("No.", "Document No.");
        if RecSheader.FindFirst() then begin
            RecSheader.TestField(Status, RecSheader.Status::Open);
        end;
    end;

    trigger OnRename()
    begin

    end;

}