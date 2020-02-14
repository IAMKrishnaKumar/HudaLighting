pageextension 50139 SalesNReceivable extends "Sales & Receivables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Dynamics 365 Sales")
        {
            group("Payment Milestones Mapping")
            {
                field("Prepayment G/L Account"; "Prepayment G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Retention G/L Account"; "Retention G/L Account")
                {
                    ApplicationArea = All;
                }
            }
            group("Retail Advance Accounts")
            {
                field("Retail Advance Account"; "Retail Advance Account")
                {
                    ApplicationArea = All;
                }
            }

        }
        addlast(General)
        {
            field("Maximum Discount %"; "Maximum Discount %")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here

    }

    var
        myInt: Integer;
}