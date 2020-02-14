tableextension 50120 POHeader extends "Purchase Header"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "LC No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "LC Exp Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "LC Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Bill Of Entry No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Bill Of Entry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Foreign Vendnor Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purch. Inv. Header"."No.";
        }
        field(50022; "Exchange Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customs Exchange Rate';
            DecimalPlaces = 2 : 4;
        }
        field(50023; "Project Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Project Reference"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Delivery Time"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        //****************************PDC****************
        field(60000; "Applies-to ID for PDC"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Applies-to ID for PDC';

        }
        field(60001; "Remaining Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Remaining Amount';
        }
        field(60002; "Order Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Order Amount';

        }
        field(60003; "PDC Applied Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Applied Amount';
        }
        field(60004; "PDC No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC No.';
        }
        field(60005; "L.C. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'L.C. No.';
        }
        field(60006; "Amount (In Arabic)"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60007; "Approved On"; Date)
        {
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
        }
        modify("Pay-to Vendor No.")
        {
            trigger OnAfterValidate()
            var
                RecVendor: Record Vendor;
            begin
                if "Document Type" = "Document Type"::Order then begin
                    Clear(RecVendor);
                    if RecVendor.GET("Sell-to Customer No.") then begin
                        RecVendor.TestField("Vendor Posting Group");
                        RecVendor.TestField("Gen. Bus. Posting Group");
                        RecVendor.TestField("VAT Bus. Posting Group");
                    end;
                end;
            end;
        }
    }

    var
        myInt: Integer;
}