tableextension 50127 SalesNReceivable extends "Sales & Receivables Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Prepayment G/L Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Account Type" = const(Posting), Blocked = const(false), "Direct Posting" = const(true));
        }
        field(50002; "Retention G/L Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Account Type" = const(Posting), Blocked = const(false), "Direct Posting" = const(true));
        }
        field(50003; "Maximum Discount %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            trigger OnValidate()
            var
            begin
                if "Maximum Discount %" > 100 then
                    Error('Maximum Discount must be less than 100%');
            end;
        }
        field(50004; "Retail Advance Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }

    }

    var
        myInt: Integer;
}