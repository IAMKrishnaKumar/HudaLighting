page 50105 "Payment Milestone"
{
    PageType = List;
    //ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = "Payment Milestone";

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
                    Editable = IsEditable;
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
                    Editable = IsEditable;
                }
                field("Milestone Description"; "Milestone Description")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                }
                field("Payment Terms"; "Payment Terms")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
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

    // actions
    // {
    //     area(Processing)
    //     {
    //         action("Refresh Page")
    //         {
    //             ApplicationArea = All;
    //             trigger OnAction()
    //             begin
    //                 CurrPage.Update();
    //                 ;
    //             end;
    //         }
    //     }
    // }

    procedure SetDocNumber(DocTypeL: text; DocDate: Date; TotalVal: Decimal; CurrFactor: Decimal; DocNoL: Text)
    begin
        Clear(DocumentDate);
        Clear(TotalVallue);
        Clear(CurrencyFactor);
        Clear(DocNo);
        Clear(DocType);
        DocType := DocTypeL;
        DocumentDate := DocDate;
        TotalVallue := TotalVal;
        CurrencyFactor := CurrFactor;
        DocNo := DocNoL;
        IsEditable := true;

    end;

    procedure SetEditable(Editable: Boolean)
    begin
        Clear(IsEditable);
        IsEditable := Editable;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        RecSHeader: Record "Sales Header";
    begin
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

        // if "Currency Factor" >= 1 then begin
        //     "Amount LCY" := Amount * CurrencyFactor;
        //     "Total Value(LCY)" := TotalVallue * CurrencyFactor;
        // end else begin
        //     if "Currency Factor" <> 0 then
        "Amount LCY" := Amount / "Currency Factor";
        "Total Value(LCY)" := TotalVallue / "Currency Factor";
        // end;

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

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        RecPM: Record "Payment Milestone";
        TotalPercentage: Decimal;
    begin
        If CloseAction IN [ACTION::OK, ACTION::LookupOK] then begin
            Clear(RecPM);
            Clear(TotalPercentage);
            RecPM.SetRange("Document Type", Rec."Document Type");
            RecPM.SetRange("Document No.", Rec."Document No.");
            if RecPm.FindSet() then
                repeat
                    TotalPercentage += RecPM."Milestone %";
                until RecPM.Next() = 0;

            if TotalPercentage <> 100 then begin
                if not Confirm('The Total of Milestone % is not 100. Do you still want to continue?', false) then
                    Exit(false)
                else
                    Exit(true);
            end;
        end;
    end;

    var
        DocumentDate: Date;
        TotalVallue: Decimal;
        CurrencyFactor: Decimal;
        DocType: Text;
        DocNo: Text;
        IsEditable: Boolean;
        EnableInvoiced: Boolean;
}