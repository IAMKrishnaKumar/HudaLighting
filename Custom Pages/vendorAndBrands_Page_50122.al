page 50122 "Vendor Brand Master"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Vendor Brand Master";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = All;
                }
                field(Brands; Brands)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
        }
    }

    var
        myInt: Integer;
}