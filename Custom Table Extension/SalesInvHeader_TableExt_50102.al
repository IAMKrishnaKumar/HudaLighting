tableextension 50102 SalesInvHeader extends "Sales Invoice Header"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Project Reference"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Project Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Bank Guarantee No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Security ChecK No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Check Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Bank Guarantee Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Check Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Bank Guarantee Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Date of Installation"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Hourly Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "End Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Total Time"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Installation Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Estimated Order Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50017; "LC No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "LC Exp Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "LC Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "LC Payment Terms"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms".Code;
        }
        field(50021; "Amount (In Arabic)"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Retail Location"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup (Location."Retail Location" where(Code = field("Location Code")));
        }
        //**********************PDC*****************
        field(60000; "Applies-to ID for PDC"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Applies-to ID for PDC';
        }
        field(60001; "Remaining Amount1"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Remaining Amount';
        }
        field(60002; "Order Amount LCPDC"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Order Amount LCPDC';
        }
        field(60003; "PDC Applied Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Applied Amount';
        }
        field(60004; "Export L.C. No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
    }

    var
        myInt: Integer;
}