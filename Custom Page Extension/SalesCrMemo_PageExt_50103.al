pageextension 50103 SalesCrMemo extends "Sales Credit Memo"
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

        addlast("Credit Memo Details")
        {
            field("Amount (In Arabic)"; "Amount (In Arabic)")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
        }
        addafter("Due Date")
        {
            field("Project Reference"; "Project Reference")
            {
                ApplicationArea = All;
            }
            field("Project Name"; "Project Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Credit Memo Details")
        {
            group("Security Details")
            {
                field("Security ChecK No."; "Security ChecK No.")
                {
                    ApplicationArea = All;
                }
                field("Check Amount"; "Check Amount")
                {
                    ApplicationArea = All;
                }
                field("Check Date"; "Check Date")
                {
                    ApplicationArea = All;
                }
            }
            group("Bank Guarantee Details")
            {
                field("Bank Guarantee No."; "Bank Guarantee No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Guarantee Date"; "Bank Guarantee Date")
                {
                    ApplicationArea = All;
                }
                field("Bank Guarantee Amount"; "Bank Guarantee Amount")
                {
                    ApplicationArea = All;
                }
            }
            group("Installation Details")
            {
                field("Date of Installation"; "Date of Installation")
                {
                    ApplicationArea = All;
                }
                field("Hourly Rate"; "Hourly Rate")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; "Start Time")
                {
                    ApplicationArea = all;
                }
                field("End Time"; "End Time")
                {
                    ApplicationArea = All;
                }
                field("Total Time"; "Total Time")
                {
                    ApplicationArea = All;
                }
                field("Installation Amount"; "Installation Amount")
                {
                    ApplicationArea = All;
                }
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
        modify(PostAndSend)
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