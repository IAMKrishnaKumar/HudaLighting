page 50108 "Item Brand"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Item Brands";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                    Enabled = IsEnabled;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Enabled = IsEnabled;
                }
                field("Brand Dimension"; "Brand Dimesnion")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = IsEnabled;
                    Caption = 'Brand Dimension';
                }
                field(SetupCode; SetupCode)
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Create Dimension")
            {
                ApplicationArea = All;
                Image = Dimensions;
                trigger OnAction()
                var
                    FunctionCodeunit: Codeunit Functions;
                begin
                    FunctionCodeunit.CreateBrandDimesnion();
                    CurrPage.Update();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if Rec."Brand Dimesnion" <> '' then
            IsEnabled := false
        else
            IsEnabled := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        IsEnabled := true;
    end;

    var
        IsEnabled: Boolean;
}