tableextension 50110 PurchaseLine extends "Purchase Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "HL Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(50001; "HL Sales Line No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(50002; "Vendor Article No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; Comments; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        // Logistics Fields - Start
        field(50004; SalesDocDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; SalesCity; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; SalesPerson; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Sell To Customer No."; Text[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                RecCust: Record Customer;
            begin

            end;
        }
        field(50008; SalesProjectName; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; SalesLineAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; SalesPaymentTerms; Text[100])//Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; PODocDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; BuyFromVendor; Text[100])//Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; PoCurrency; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; PromisedDelDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Sell To Customer Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup (Customer.Name where("No." = field("Sell To Customer No.")));
        }
        field(50016; ClientPayment; Option)
        {
            OptionMembers = ,Ship,Invoice,All;
            FieldClass = FlowField;
            CalcFormula = lookup (Customer.Blocked where("No." = field("Sell To Customer No.")));
        }
        field(50017; "Header Status"; Option)
        {
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
            FieldClass = FlowField;
            CalcFormula = lookup ("Purchase Header".Status where("No." = field("Document No.")));
        }
        field(50018; "Description 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Advance Payment"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup ("Sales Header"."Advance Payment" where("Document Type" = const(Order), "No." = field("HL Sales Order No.")));
        }
        field(50020; "Purchase Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
        }

        field(50021; "Brand"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Brands".Code;
        }
        field(50022; "HL Line Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Retail Location"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "SO Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; Priority; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup ("Sales Header".Priority where("Document Type" = filter(Order), "No." = field("HL Sales Order No.")));
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                RecLocation: Record Location;
            begin
                if (Rec."Location Code" <> '') then begin
                    Clear(RecLocation);
                    RecLocation.SetRange(Code, Rec."Location Code");
                    if RecLocation.FindFirst() then begin
                        if RecLocation."Retail Location" then begin
                            Rec."Retail Location" := true;
                        end else begin
                            Rec."Retail Location" := false;
                        end;
                    end;
                end;
            end;
        }

        modify("Direct Unit Cost")
        {
            trigger OnAfterValidate()
            var
                RecPNP: Record "Purchases & Payables Setup";
                PHeader: Record "Purchase Header";
                SHeader: Record "Sales Header";
                CurrencyFactor: Decimal;
            begin
                if "Unit Cost" <> 0 then begin
                    Clear(CurrencyFactor);
                    RecPNP.GET;
                    if (Rec."Document Type" = "Document Type"::Order) AND (RecPNP."Purchase Price Warning Check") AND ("HL Sales Order No." <> '') AND ("HL Sales Line No." <> 0) then begin
                        Clear(PHeader);
                        PHeader.SetRange("Document Type", PHeader."Document Type"::Order);
                        PHeader.SetRange("No.", "Document No.");
                        if PHeader.FindFirst() then begin
                            if PHeader."Currency Factor" <> 0 then
                                CurrencyFactor := PHeader."Currency Factor"
                            else
                                CurrencyFactor := 1;
                            if "Direct Unit Cost" / CurrencyFactor > "SO Unit Price" then begin
                                if not Confirm('Purchase price is exceeding the sales price. Do you still want to continue?', FALSE) then
                                    Validate("Direct Unit Cost", 0);
                            end;
                        end;
                    end;
                end;
            end;
        }


        modify("No.")
        {
            trigger OnAfterValidate()
            var
                RecItem: Record Item;
            begin
                if (Type = Type::Item) AND ("No." <> '') then begin
                    Clear(RecItem);
                    IF RecItem.GET("No.") then begin
                        RecItem.TestField("Vendor Article No");
                        RecItem.TestField("Vendor No.");
                        RecItem.TestField(Brand);
                        RecItem.TestField(Description);
                        RecItem.TestField("Item Category Code");

                        Rec."Vendor Article No" := RecItem."Vendor Article No";
                        Rec.Description := RecItem.Description;
                        Rec."Description 2" := RecItem."Description 2";
                        Rec."Description 3" := RecItem."Description 3";
                        Rec.Brand := RecItem.Brand;
                    end;
                end else begin
                    Rec."Vendor Article No" := '';
                    Rec.Description := '';
                    Rec."Description 2" := '';
                    Rec."Description 3" := '';
                    Rec.Brand := '';
                end;
            end;

            trigger OnBeforeValidate()
            var
                Sheader: Record "Purchase Header";
                RecItem: Record Item;
            begin
                If (Type <> Type::Item) then
                    "Vendor Article No" := '';

                if (Type = Type::Item) then begin

                    Clear(Sheader);
                    Sheader.SetRange("Document Type", "Document Type"::Order);
                    Sheader.SetRange("No.", "Document No.");
                    Sheader.SetFilter("Buy-From IC Partner Code", '<>%1', '');
                    if Sheader.FindFirst() then begin
                        Clear(RecItem);
                        IF RecItem.GET("No.") then begin
                            Rec."Vendor Article No" := RecItem."Vendor Article No";
                            Rec.Description := RecItem.Description;
                            Rec."Description 2" := RecItem."Description 2";
                            Rec."Description 3" := RecItem."Description 3";
                            Rec.Brand := RecItem.Brand;
                        end;
                    end else begin
                        Rec."Vendor Article No" := '';
                        Rec.Description := '';
                        Rec."Description 2" := '';
                        Rec."Description 3" := '';
                        Rec.Brand := '';
                    end;
                end;
            end;

        }
        modify("Planned Receipt Date")
        {
            trigger OnBeforeValidate()
            begin
                "System-Created Entry" := true;
            end;
        }
        modify("Expected Receipt Date")
        {
            trigger OnBeforeValidate()
            begin
                "System-Created Entry" := true;
            end;
        }
        modify("Promised Receipt Date")
        {
            trigger OnBeforeValidate()
            begin
                "System-Created Entry" := true;
            end;
        }
        // Logistics Fields - End
    }

    var
        myInt: Integer;
}