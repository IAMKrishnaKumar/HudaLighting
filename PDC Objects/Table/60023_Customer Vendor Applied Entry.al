table 60023 "Customer Vendor Applied Entry"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Document Type"; Option)
        {
            OptionCaption = 'Sales,Purchases';
            OptionMembers = Sales,Purchases;
        }
        field(3; "Document No."; Code[20])
        {
        }
        field(4; "Source Type"; Option)
        {
            OptionCaption = 'Customer,Vendor';
            OptionMembers = Customer,Vendor;
        }
        field(5; "Source No."; Code[20])
        {
        }
        field(6; "Applied Amount (ICY)"; Decimal)
        {
            AutoFormatExpression = "ICY Currency Code";
            AutoFormatType = 1;
        }
        field(7; "Applied Amount (LCY)"; Decimal)
        {
            AutoFormatExpression = "LCY Currency Code";
            AutoFormatType = 1;
            DecimalPlaces = 0 : 15;
        }
        field(8; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(9; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(10; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(11; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(12; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
        field(13; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(14; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
        }
        field(15; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
        }
        field(16; "Inter Dimension Posted"; Boolean)
        {
        }
        field(17; "Source Document No."; Code[20])
        {
        }
        field(18; "Application Entry No."; Integer)
        {
        }
        field(19; "Applied Amount (FCY)"; Decimal)
        {
            AutoFormatExpression = "FCY Currency Code";
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                Validate("Applied Amount (LCY)", Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "FCY Currency Code",
                         "Applied Amount (FCY)", "FCY Currency Factor"), 0.01));
            end;
        }
        field(20; "ICY Currency Code"; Code[10])
        {
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if "ICY Currency Code" <> '' then begin
                    CurrencyCode := "ICY Currency Code";
                    if CurrencyCode = '' then begin
                        Clear(Currency);
                        Currency.InitRoundingPrecision
                    end else
                        if CurrencyCode <> Currency.Code then begin
                            Currency.Get(CurrencyCode);
                            Currency.TestField("Amount Rounding Precision");
                        end;

                    if ("ICY Currency Code" <> xRec."ICY Currency Code") or
                       ("Posting Date" <> xRec."Posting Date") or
                       (CurrFieldNo = FieldNo("ICY Currency Code")) or
                       ("ICY Currency Factor" = 0)
                    then
                        "ICY Currency Factor" :=
                          CurrExchRate.ExchangeRate("Posting Date", "ICY Currency Code");
                end else
                    "ICY Currency Factor" := 0;
                Validate("ICY Currency Factor");
            end;
        }
        field(21; "ICY Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(22; "LCY Currency Code"; Code[10])
        {
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if "LCY Currency Code" <> '' then begin
                    CurrencyCode := "LCY Currency Code";
                    if CurrencyCode = '' then begin
                        Clear(Currency);
                        Currency.InitRoundingPrecision
                    end else
                        if CurrencyCode <> Currency.Code then begin
                            Currency.Get(CurrencyCode);
                            Currency.TestField("Amount Rounding Precision");
                        end;

                    if ("LCY Currency Code" <> xRec."LCY Currency Code") or
                       ("Posting Date" <> xRec."Posting Date") or
                       (CurrFieldNo = FieldNo("LCY Currency Code")) or
                       ("LCY Currency Factor" = 0)
                    then
                        "LCY Currency Factor" :=
                          CurrExchRate.ExchangeRate("Posting Date", "LCY Currency Code");
                end else
                    "LCY Currency Factor" := 0;
                Validate("LCY Currency Factor");
            end;
        }
        field(23; "LCY Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(24; "FCY Currency Code"; Code[10])
        {
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if "FCY Currency Code" <> '' then begin
                    CurrencyCode := "FCY Currency Code";
                    if CurrencyCode = '' then begin
                        Clear(Currency);
                        Currency.InitRoundingPrecision
                    end else
                        if CurrencyCode <> Currency.Code then begin
                            Currency.Get(CurrencyCode);
                            Currency.TestField("Amount Rounding Precision");
                        end;

                    if ("FCY Currency Code" <> xRec."FCY Currency Code") or
                       ("Posting Date" <> xRec."Posting Date") or
                       (CurrFieldNo = FieldNo("FCY Currency Code")) or
                       ("FCY Currency Factor" = 0)
                    then
                        "FCY Currency Factor" :=
                          CurrExchRate.ExchangeRate("Posting Date", "FCY Currency Code");
                end else
                    "FCY Currency Factor" := 0;
                Validate("FCY Currency Factor");
            end;
        }
        field(25; "FCY Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(26; "Posting Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Document Type", "Document No.", "Source Type", "Source No.", "Inter Dimension Posted", "Source Document No.")
        {
        }
        key(Key3; "Source Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        CurrencyCode: Code[10];

    local procedure GetCurrency()
    begin
    end;
}

