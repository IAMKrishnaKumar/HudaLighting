table 60013 "PDC Applied Amount"
{
    // Code           Date        Name        Desc.
    // APNT-LCPDC1.0  20.05.12    Monica      Created New.


    fields
    {
        field(1; "PDC No."; Code[20])
        {
        }
        field(2; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Sales,Purchase';
            OptionMembers = " ",Sales,Purchase;
        }
        field(3; "Document Type"; Option)
        {
            OptionCaption = ' ,Order,Invoice';
            OptionMembers = " ","Order",Invoice;
        }
        field(4; "No."; Code[20])
        {
            TableRelation = IF ("Transaction Type" = CONST(Sales),
                                "Document Type" = CONST(Order)) "Sales Header"."No." WHERE("Document Type" = CONST(Order))
            ELSE
            IF ("Transaction Type" = CONST(Sales),
                                         "Document Type" = CONST(Invoice)) "Sales Invoice Header"."No."
            ELSE
            IF ("Transaction Type" = CONST(Purchase),
                                                  "Document Type" = CONST(Order)) "Purchase Header"."No." WHERE("Document Type" = CONST(Order))
            ELSE
            IF ("Transaction Type" = CONST(Purchase),
                                                           "Document Type" = CONST(Invoice)) "Purch. Inv. Header"."No.";
        }
        field(5; "Amount (LCY)"; Decimal)
        {
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; Bounced; Boolean)
        {
        }
        field(8; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(9; "Foreign Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(10; Amount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "PDC No.", "Transaction Type", "Document Type", "No.")
        {
            SumIndexFields = "Amount (LCY)", Amount;
        }
    }

    fieldgroups
    {
    }
}

