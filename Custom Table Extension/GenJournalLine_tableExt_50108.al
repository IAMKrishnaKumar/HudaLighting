tableextension 50108 GenJournLline extends "Gen. Journal Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; Narration; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Check No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestField("Check Printed", false);
            end;
        }
        field(50002; "Check Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestField("Check Printed", false);
            end;
        }
        field(50003; "Payee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Payee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        //*************************PDC**********************
        field(60000; "Non PDC App. Entries"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Non PDC App. Entries';
        }
        field(60001; "L.C. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'L.C. No.';
            trigger OnValidate()
            begin
                //APNT-LC-PDC
                TESTFIELD("Account Type", "Account Type"::Vendor);
                TESTFIELD("Account No.");
                //APNT-LC-PDC
            end;
        }
        field(60002; "PDC Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Entry';
        }
        field(60003; "Cheque No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque No.';

        }
        field(60004; "Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque Date';
        }
        field(60005; "Document No2"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document No2';
        }
        /* field(60006; Narration; Text[250])
         {
             DataClassification = ToBeClassified;
             Caption = 'Narration';
         }*/
    }

    /*    trigger OnBeforeInsert()
        var
            RecPRB: Record "Payment Registration Buffer";
            PaymentRegistrationSetup: Record 980;
        begin
            Clear(RecPRB);
            PaymentRegistrationSetup.GET(UserId);
        end;
    */
    var
        myInt: Integer;
}