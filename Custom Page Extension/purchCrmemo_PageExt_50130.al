pageextension 50130 PurchCrMemo extends "Purchase Credit Memo"
{
    layout
    {
        // Add changes to page layout here
        addafter("VAT Bus. Posting Group")
        {
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        addafter("Foreign Trade")
        {
            group("LC Details")
            {
                field("LC No."; "LC No.")
                {
                    ApplicationArea = All;
                }
                field("LC Exp Date"; "LC Exp Date")
                {
                    ApplicationArea = All;
                }
                field("LC Amount"; "LC Amount")
                {
                    ApplicationArea = All;
                }

            }
        }
        addlast("Invoice Details")
        {
            field("Amount (In Arabic)"; "Amount (In Arabic)")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        // Add changes to page actions here
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Currency Code");
            end;
        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Currency Code");
            end;
        }
    }

    var
        myInt: Integer;
}