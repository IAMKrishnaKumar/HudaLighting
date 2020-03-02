pageextension 50157 CashReceupt extends "Cash Receipt Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("External Document No.")
        {
            field("Payment Method Code"; "Payment Method Code")
            {
                ApplicationArea = All;
            }
            field("Payee Name"; "Payee Name")
            {
                ApplicationArea = All;
                Caption = 'Received From';
            }
            field(Narration; Narration)
            {
                ApplicationArea = All;
            }
            field("Check No."; "Check No.")
            {
                ApplicationArea = All;
            }
            field("Check Date"; "Check Date")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        /*  modify(Post)
          {
              trigger OnBeforeAction()
              begin
                  if ("Bal. Account Type" = "Bal. Account Type"::Customer) OR ("Bal. Account Type" = "Bal. Account Type"::Vendor) then
                      Rec.TestField("Currency Code");
                  Rec.TestField("Document Type");
              end;
          }
          modify("Post and &Print")
          {
              trigger OnBeforeAction()
              begin
                  if ("Bal. Account Type" = "Bal. Account Type"::Customer) OR ("Bal. Account Type" = "Bal. Account Type"::Vendor) then
                      Rec.TestField("Currency Code");
                  Rec.TestField("Document Type");
              end;
          }
          */
    }

    var
        myInt: Integer;
}