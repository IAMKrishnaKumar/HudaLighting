codeunit 50112 "Import Items"
{
    TableNo = "Item Buffer";
    trigger OnRun()
    var
        NoSeries: Codeunit NoSeriesManagement;
        InvtSetup: Record 313;
        ItemL: Record Item;
        DimVal: Record "Dimension Value";
        RecItemBrand: Record "Item Brands";
        RecDefaultDim: Record "Default Dimension";
        InvPostGroup: Record "Inventory Posting Group";
    begin
        InvtSetup.GET;
        if IsInsert then begin
            ItemL.Init();
            ItemL.LockTable(true);
        end;

        ItemL.Validate("Vendor Article No", Rec."Vendor Article No.");
        ItemL.Validate("Vendor No.", Rec."Vendor No.");
        if IsInsert then begin
            ItemL.Insert(true);
            Commit();
        end;
        ItemL.Description := Rec.Description1;
        ItemL."Description 2" := Rec.Description2;
        ItemL."Description 3" := Rec.Description3;
        IF IsInsert THEN BEGIN
            if Rec.Type = 'INVENTORY' then
                ItemL.Validate(Type, ItemL.Type::Inventory)
            else
                if Rec.Type = 'SERVICE' then
                    ItemL.Validate(Type, ItemL.Type::Service)
                else
                    ItemL.Validate(Type, ItemL.Type::"Non-Inventory");
        END;

        ItemL.Validate("Base Unit of Measure", Rec."Base Unit Of Measure");
        ItemL.Validate("Purch. Unit of Measure", Rec."Purchase Unit Of Measure");
        ItemL.Validate("Sales Unit of Measure", Rec."Sales Unit Of Measure");
        ItemL.Validate("Item Category Code", Rec."Item Category Code");
        ItemL.Validate("Gen. Prod. Posting Group", Rec."Gen. Prod. Posting group");
        Clear(InvPostGroup);
        InvPostGroup.SetFilter(Code, '<>%1', '');
        if InvPostGroup.FindFirst() then
            ItemL.Validate("Inventory Posting Group", InvPostGroup.Code);
        ItemL.IsUploaded := true;
        ItemL."Created By" := UserId;
        ItemL.Validate(Brand, Rec."Brand Dimension");
        ItemL.Validate(Reserve, ItemL.Reserve::Always);
        //if (ItemL."Vendor Article No" <> '') AND (ItemL."Vendor No." <> '') AND IsInsert then
        //   CheckNinsertVendorArtcile(ItemL);
        if IsInsert then
            ItemL.Modify(true);
        Commit();
    end;

    procedure setInsertValue(IsInserL: Boolean)
    begin
        Clear(IsInsert);
        IsInsert := IsInserL;
    end;

    procedure CheckNinsertVendorArtcile(Var RecItemL: Record Item)
    var
        RecVATList: Record "Vendor Article List";
        RecCatItemSetup: Record "Nonstock Item Setup";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
        NO: Integer;
    begin
        Clear(RecVATList);
        RecCatItemSetup.GET;
        RecVATList.SetRange("Vendor No.", RecItemL."Vendor No.");
        RecVATList.SetRange("Vendor Article No.", RecItemL."Vendor Article No");
        if RecVATList.FindFirst() then
            RecItemL."Common Item No." := RecVATList."Common Item No."
        else begin
            NO := RecVATList.Next();
            Clear(RecVATList);
            RecVATList.Init();
            if (NO < 10000) then
                RecVATList."Entry No." := 10000;
            RecVATList."Vendor No." := RecItemL."Vendor No.";
            RecVATList."Vendor Article No." := RecItemL."Vendor Article No";
            RecVATList.Insert(true);
            RecVATList."Common Item No." := FORMAT(RecVATList."Entry No.");
            RecVATList.Modify();
            RecItemL."Common Item No." := RecVATList."Common Item No.";
        end;
    end;

    var
        IsInsert: Boolean;
}