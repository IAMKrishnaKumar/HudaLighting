report 50105 "Validate Items"
{
    // UsageCategory = Administration;
    // ApplicationArea = All;
    UseRequestPage = false;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Item; Item)
        {
        }
    }
    trigger OnPreReport()
    var
        ItemL: Record Item;
    begin
        Clear(ItemL);
        ItemL.SetFilter("No.", '<>%1', '');
        ItemL.SetRange(Type, ItemL.Type::Inventory);
        ItemL.SetFilter("Vendor Article No", '<>%1', '');
        ItemL.SetFilter("Vendor No.", '<>%1', '');
        ItemL.SetFilter("Common Item No.", '=%1', '');
        if ItemL.FindSet() then begin
            repeat
                ItemL.Validate("Vendor Article No", ItemL."Vendor Article No");
                ItemL.Modify();
            until ItemL.Next() = 0;
        end;

    end;

    var
        myInt: Integer;
}