pageextension 50160 PaymentReg extends "Payment Registration"
{
    layout
    {
        // Add changes to page layout here
        addafter(ExternalDocumentNo)
        {
            field("Check No."; "Check No.")
            {
                ApplicationArea = All;
            }
            field("Check Date"; "Check Date")
            {
                ApplicationArea = All;
            }
            field(Narration; Narration)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify(PostPayments)
        {
            //  Visible = false;
            trigger OnBeforeAction()
            var
                PaymentRegistrationMgt: Codeunit 50115;
            begin
                //  PaymentRegistrationMgt.ConfirmPost(Rec);
                //Exit(true);
                //  Error('Process completed sucessfully.');
            end;
        }
        modify(PostAsLump)
        {
            Visible = false;
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                // Error('You are now allowed to post the transaction.');
            end;
        }
        addafter(Post)
        {
            action(POST_)
            {
                ApplicationArea = All;
                Caption = 'POST';
                Image = Post;
                trigger OnAction()
                var
                    PaymentRegistrationMgt: Codeunit 50115;
                begin
                    PaymentRegistrationMgt.ConfirmPost(Rec);
                end;
            }
        }
    }
    trigger OnModifyRecord(): Boolean
    var
        myInt: Integer;
    begin
        // ReloadCustom();

    end;

    var
        myInt: Integer;
}

