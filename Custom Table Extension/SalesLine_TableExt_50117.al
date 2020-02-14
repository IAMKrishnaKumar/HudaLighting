tableextension 50117 SalesLineTableExt extends "Sales Line"
{
    fields
    {

        field(50000; "Warranty Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "HL Line Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Vendor Article No"; Text[50])
        {
            DataClassification = ToBeClassified;

        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                if (Quantity <> 0) then
                    "Estimated GP" := ROUND(("Line Amount" - "Estimated Cost") * "Outstanding Quantity" / Quantity, 0.01, '>');
            end;
        }
        modify("Line Amount")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                if (Quantity <> 0) then
                    "Estimated GP" := ROUND(("Line Amount" - "Estimated Cost") * "Outstanding Quantity" / Quantity, 0.01, '>');
            end;
        }
        modify("Outstanding Quantity")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                if (Quantity <> 0) then
                    "Estimated GP" := ROUND(("Line Amount" - "Estimated Cost") * "Outstanding Quantity" / Quantity, 0.01, '>');
            end;
        }
        field(50003; "Estimated Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin

                if (Quantity <> 0) then
                    "Estimated GP" := ROUND(("Line Amount" - "Estimated Cost") * "Outstanding Quantity" / Quantity, 0.01, '>');
            end;
        }
        field(50004; "HL_Purchase Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchase Order No.';
            TableRelation = "Purchase Header"."No." where("Document Type" = CONST(Order));
        }
        field(50005; "PO Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchase Order Quantity';
        }
        field(50006; "PO Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchase Order Line No.';
        }
        field(50007; "Estimated GP"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; "Description 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Brand"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            var
                RecItem: Record Item;
                RecIC: Record "Item Category";
            begin
                if (Type = Type::Item) AND ("No." <> '') then begin
                    Clear(RecItem);
                    IF RecItem.GET("No.") then begin

                        "Vendor Article No" := RecItem."Vendor Article No";
                        if RecItem."Item Category Code" <> '' then begin
                            IF RecIC.Get(RecItem."Item Category Code") then begin
                                "Warranty Date" := CALCDATE(RecIC."Warranty Days", "Shipment Date");
                            end;
                        end else
                            "Warranty Date" := 0D;
                        if RecItem."Description 2" <> '' then
                            "Description 2" := RecItem."Description 2"
                        else
                            "Description 2" := '';
                        if RecItem."Description 3" <> '' then
                            "Description 3" := RecItem."Description 3"
                        else
                            "Description 3" := '';
                        Brand := RecItem.Brand;
                    end;
                end else begin
                    "Warranty Date" := 0D;
                    "Description 2" := '';
                    "Description 3" := '';
                    Brand := '';
                end;
            end;

            trigger OnBeforeValidate()
            var
                Sheader: Record "Sales Header";
                RecItem: Record Item;
                SnRSetup: Record "Sales & Receivables Setup";
            begin
                If (Type <> Type::Item) then
                    "Vendor Article No" := '';

                if Type = Type::Item then begin
                    /*
                     Clear(Sheader);
                     Sheader.SetRange("Document Type", "Document Type"::Order);
                     Sheader.SetRange("No.", "Document No.");
                     Sheader.SetFilter("Bill-to IC Partner Code", '<>%1', '');
                     if Sheader.FindFirst() then begin
                         */
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
                    //  end;
                end else begin
                    Rec."Vendor Article No" := '';
                    Rec.Description := '';
                    Rec."Description 2" := '';
                    Rec."Description 3" := '';
                    Rec.Brand := '';
                end;

            end;
        }
    }
    trigger OnAfterModify()
    var
        RecPaymentMileStone: Record "Payment Milestone";
        RecSheader: Record "Sales Header";

    begin
        if ("Document Type" <> "Document Type"::Order) AND ("Document Type" <> "Document Type"::Invoice) then
            exit;
        Clear(RecPaymentMileStone);
        Clear(RecSheader);
        RecSheader.SetRange("Document Type", "Document Type");
        RecSheader.SetRange("No.", "Document No.");
        if RecSheader.FindFirst() then;
        RecSheader.CalcFields(Amount);
        RecPaymentMileStone.SetRange("Document Type", "Document Type");
        RecPaymentMileStone.SetRange("Document No.", "Document No.");
        if RecPaymentMileStone.FindSet() then begin
            repeat
                RecPaymentMileStone.Validate("Currency Factor", RecSheader."Currency Factor");
                RecPaymentMileStone.Validate("Total Value", RecSheader.Amount);
                RecPaymentMileStone.Validate(Amount, (RecSheader.Amount * RecPaymentMileStone."Milestone %") / 100);
                //RecPaymentMileStone."Amount LCY" := RecPaymentMileStone.Amount * RecPaymentMileStone."Currency Factor";
                //RecPaymentMileStone."Total Value(LCY)" := RecSheader.Amount * RecSheader."Currency Factor";
                RecPaymentMileStone.Modify();
            until RecPaymentMileStone.Next() = 0;
        end;


    end;

    trigger OnAfterDelete()
    var
        SHeader: Record "Sales Header";
        Sline: Record "Sales Line";
        RecPM: Record "Payment Milestone";
    begin
        if (Rec."Document Type" = Rec."Document Type"::Order) OR (Rec."Document Type" = Rec."Document Type"::Invoice) then begin
            Clear(Sline);
            Sline.SetRange("Document Type", "Document Type"::Invoice);
            Sline.SetRange("Document No.", Rec."Document No.");
            Sline.SetRange(Type, Type::Item);
            if not Sline.FindFirst() then begin

                if Rec."Document Type" = Rec."Document Type"::Invoice then begin
                    Clear(SHeader);
                    SHeader.SetRange("Document Type", SHeader."Document Type"::Invoice);
                    SHeader.SetRange("No.", Rec."Document No.");
                    if SHeader.FindFirst() then begin
                        SHeader.Ship := false;
                        SHeader."Discount Approval" := false;
                        SHeader.Modify();
                    end;
                end;
                //Deleting All the Payment Mileston after deletion of All the lines
                Clear(RecPM);
                RecPM.SetRange("Document Type", Rec."Document Type");
                RecPM.SetRange("Document No.", Sline."Document No.");
                if RecPM.FindSet() then
                    RecPM.DeleteAll();
            end;

        end;
    end;


    var
        myInt: Integer;
}