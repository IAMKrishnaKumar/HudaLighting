page 50138 "Payment Milestone Subform"
{
    PageType = ListPart;
    Caption = 'Payment Milestone';
    //ApplicationArea = All;
    //UsageCategory = Administration;
    SourceTable = "Payment Milestone";
    DelayedInsert = true;
    MultipleNewLines = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Customer Name"; "Customer Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Posting Type"; "Posting Type")
                {
                    ApplicationArea = All;
                    // Editable = IsEditable;
                    trigger OnValidate()
                    begin
                        if "Posting Type" = "Posting Type"::Advance then
                            EnableInvoiced := true
                        else
                            EnableInvoiced := false;
                    end;
                }
                field("Milestone %"; "Milestone %")
                {
                    ApplicationArea = All;
                    // Editable = IsEditable;
                }
                field("Milestone Description"; "Milestone Description")
                {
                    ApplicationArea = All;
                    //  Editable = IsEditable;
                }
                field("Payment Terms"; "Payment Terms")
                {
                    ApplicationArea = All;
                    //  Editable = IsEditable;
                }
                field(Invoiced; Invoiced)
                {
                    ApplicationArea = All;
                    Enabled = EnableInvoiced;
                }
                field("Total Value"; "Total Value")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Amount LCY"; "Amount LCY")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Currency Factor"; "Currency Factor")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                }
                field("Total Value(LCY)"; "Total Value(LCY)")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

            }
        }
    }

    procedure SetHeaderValues()
    VAR
        Sheader: Record "Sales Header";
        Sline: Record "Sales Line";
    begin
        //IsEditable := true;
        Clear(Sheader);
        Sheader.SetRange("Document Type", "Document Type");
        Sheader.SetRange("No.", "Document No.");
        if Sheader.FindFirst() then begin
            if Sheader."Document Type" = Sheader."Document Type"::Order then
                DocType := 'Order'
            else
                DocType := 'Invoice';
            DocumentDate := Sheader."Document Date";
            Sheader.CalcFields(Amount);
            TotalVallue := Sheader.Amount;
            CurrencyFactor := Sheader."Currency Factor";
            DocNo := Sheader."No.";
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        RecSHeader: Record "Sales Header";
    begin
        SetHeaderValues();
        //New 
        if DocType = 'Order' then
            "Document Type" := "Document Type"::Order
        else
            "Document Type" := "Document Type"::Invoice;
        "Document No." := DocNo;
        "Document Date" := DocumentDate;
        "Total Value" := TotalVallue;
        if CurrencyFactor <> 0 then
            "Currency Factor" := CurrencyFactor
        else
            "Currency Factor" := 1;

        "Amount LCY" := Amount / "Currency Factor";
        "Total Value(LCY)" := TotalVallue / "Currency Factor";

        Clear(RecSHeader);
        RecSHeader.SetRange("Document Type", "Document Type");
        RecSHeader.SetRange("No.", "Document No.");
        if RecSHeader.FindFirst() then begin
            Validate("Customer No.", RecSHeader."Sell-to Customer No.");
            Validate("Payment Terms", RecSHeader."Payment Terms Code");
        end;

        if "Posting Type" = "Posting Type"::Advance then
            EnableInvoiced := true
        else
            EnableInvoiced := false;

    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        EnableInvoiced := false;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if "Posting Type" = "Posting Type"::Advance then
            EnableInvoiced := true
        else
            EnableInvoiced := false;
    end;

    var
        DocumentDate: Date;
        TotalVallue: Decimal;
        CurrencyFactor: Decimal;
        DocType: Text;
        DocNo: Text;
        // IsEditable: Boolean;
        EnableInvoiced: Boolean;
}