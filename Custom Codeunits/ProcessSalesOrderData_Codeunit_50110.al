codeunit 50110 "Process Sales Person Data"
{
    TableNo = "Sales Order Staging";
    trigger OnRun()
    var
        SHeader: Record "Sales Header";
        DimSetId: Integer;
    begin

        //Mandatory Fields as per Req.
        Rec.TestField("Sales Person");
        Rec.TestField("Order Date");
        Rec.TestField("Currency Code");
        Rec.TestField("Opportunity No.");
        Rec.TestField("PO Reference");
        //..................

        CheckDuplicate(Rec);
        Clear(SHeader);
        Clear(DimSetId);
        SHeader.SetRange("Document Type", SHeader."Document Type"::Order);
        SHeader.SetRange("Shortcut Dimension 1 Code", Rec."Opportunity No.");
        if SHeader.FindFirst() then begin
            SHeader.SetHideValidationDialog(true);
            SHeader.Validate("Sell-to Customer No.", Rec."Customer No.");
            SHeader."Project Name" := Rec."Project Name";
            SHeader."Project Reference" := Rec."Project Reference No.";
            SHeader.Validate("Salesperson Code", Rec."Sales Person");
            SHeader.Validate("Order Date", Rec."Order Date");
            SHeader.Validate("Promised Delivery Date", Rec."Promised Delivery Date");
            SHeader.Validate("Currency Code", Rec."Currency Code");
            SHeader.Validate("Payment Terms Code", Rec."Payment Terms ");
            SHeader."Estimated Order Value" := Rec."Estimated Order Value";
            SHeader.Validate("PO Reference", Rec."PO Reference");
            // SHeader.Validate("Opportunity No.", Rec."Opportunity No.");
            if SHeader."Dimension Set ID" <> 0 then begin
                DimSetId := SHeader.CheckAndCreateDim(Rec."Opportunity No.", SHeader."Dimension Set ID");
                SHeader.Validate("Dimension Set ID", DimSetId);
            end else begin
                DimSetId := SHeader.CheckAndCreateDim(Rec."Opportunity No.", 0);
                SHeader.Validate("Dimension Set ID", DimSetId);
            end;
            SHeader.Validate("Shortcut Dimension 1 Code", "Opportunity No.");
            Rec."Sales Order No." := SHeader."No.";
            SHeader.Modify(true);
            Commit();

        end else begin

            SHeader.Init();
            SHeader.Validate("Document Type", SHeader."Document Type"::Order);
            SHeader.Validate("Sell-to Customer No.", Rec."Customer No.");
            SHeader."Project Name" := Rec."Project Name";
            SHeader."Project Reference" := Rec."Project Reference No.";
            SHeader.Validate("Salesperson Code", Rec."Sales Person");
            SHeader.Validate("Order Date", Rec."Order Date");
            SHeader.Validate("Promised Delivery Date", Rec."Promised Delivery Date");
            SHeader.Validate("Currency Code", Rec."Currency Code");
            SHeader.Validate("Payment Terms Code", Rec."Payment Terms ");
            SHeader."Estimated Order Value" := Rec."Estimated Order Value";
            SHeader.Validate("PO Reference", Rec."PO Reference");
            // SHeader.Validate("Opportunity No.", Rec."Opportunity No.");
            IF Rec."Opportunity No." <> '' THEN BEGIN
                if SHeader."Dimension Set ID" <> 0 then begin
                    DimSetId := SHeader.CheckAndCreateDim(Rec."Opportunity No.", SHeader."Dimension Set ID");
                    SHeader.Validate("Dimension Set ID", DimSetId);
                end else begin
                    DimSetId := SHeader.CheckAndCreateDim(Rec."Opportunity No.", 0);
                    SHeader.Validate("Dimension Set ID", DimSetId);
                end;
                SHeader.Insert(true);
                SHeader.Validate("Shortcut Dimension 1 Code", "Opportunity No.");
            END else
                SHeader.Insert(true);
            Rec."Sales Order No." := SHeader."No.";
            SHeader.Modify(true);
            Commit();
        end;
    end;

    local procedure CheckDuplicate(VAR SalesOrder: Record "Sales Order Staging")
    var
        SalesHeader: Record "Sales Header";
    begin
        Clear(SalesHeader);
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("Sell-to Customer No.", SalesOrder."Customer No.");
        SalesHeader.SetRange("Project Reference", SalesOrder."Project Reference No.");
        SalesHeader.SetRange("Project Name", SalesOrder."Project Name");
        SalesHeader.SetRange("Salesperson Code", SalesOrder."Sales Person");
        SalesHeader.SetRange("Estimated Order Value", SalesOrder."Estimated Order Value");
        SalesHeader.SetRange("Order Date", SalesOrder."Order Date");
        SalesHeader.SetRange("Requested Delivery Date", SalesOrder."Requested Delivery Date");
        SalesHeader.SetRange("Promised Delivery Date", SalesOrder."Promised Delivery Date");
        SalesHeader.SetRange("Currency Code", SalesOrder."Currency Code");
        SalesHeader.SetRange("Payment Terms Code", SalesOrder."Payment Terms ");
        SalesHeader.SetRange("Opportunity No.", SalesOrder."Opportunity No.");
        SalesHeader.SetRange("PO Reference", SalesOrder."PO Reference");
        if SalesHeader.FindFirst() then
            Error('Duplicate');
    end;

    var
        myInt: Integer;
}