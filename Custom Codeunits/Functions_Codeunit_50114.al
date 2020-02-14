codeunit 50114 Functions
{
    trigger OnRun()
    begin

    end;

    procedure CreateBrandDimesnion()
    var
        ItemBrands: Record "Item Brands";
        Dimvalue: Record "Dimension Value";
        InvSetup: Record "Inventory Setup";
    begin
        InvSetup.GET;
        Clear(ItemBrands);
        ItemBrands.SetFilter(Code, '<>%1', '');
        ItemBrands.SetFilter(Description, '<>%1', '');
        ItemBrands.SetFilter("Brand Dimesnion", '=%1', '');
        if ItemBrands.FindSet() then begin
            if not Confirm('Are you sure you want to create Dimension for all the Brands having Code and Description?', FALSE) then
                Exit;
            repeat
                Clear(Dimvalue);
                Dimvalue.SetRange("Dimension Code", InvSetup."Brand Dimension");
                Dimvalue.SetRange(Code, ItemBrands.Code);
                if not Dimvalue.FindFirst() then begin
                    Dimvalue.Init();
                    Dimvalue.Validate("Dimension Code", InvSetup."Brand Dimension");
                    Dimvalue.Validate(Code, ItemBrands.Code);
                    Dimvalue.Validate(Name, ItemBrands.Description);
                    Dimvalue.Insert(true);
                end else begin
                    Dimvalue.Name := ItemBrands.Description;
                    Dimvalue.Modify();
                end;
                ItemBrands."Brand Dimesnion" := ItemBrands.Code;
                ItemBrands.Modify();
            until ItemBrands.Next() = 0;
        end;
    end;

    var
        myInt: Integer;
}