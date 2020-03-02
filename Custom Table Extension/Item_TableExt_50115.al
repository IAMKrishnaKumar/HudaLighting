tableextension 50115 ItemTableExt extends Item
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Vendor Article No"; Text[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                RecItem: Record Item;
            begin
                if (Type = Type::Inventory) AND ("Vendor Article No" <> '') AND ("Vendor No." <> '') then begin
                    Clear(RecItem);
                    RecItem.SetRange("Vendor Article No", "Vendor Article No");
                    RecItem.SetRange("Vendor No.", "Vendor No.");
                    if RecItem.FindFirst() then begin
                        IF RecItem."No." <> "No." then
                            Error('Vendor Article No. must be unique. Vendor Article No.: ' + Rec."Vendor Article No" + ' Vendor No.: ' + Rec."Vendor No.");
                    end;
                    CheckNinsertVendorArtcile();
                end else
                    "Common Item No." := '';
            end;
        }
        modify("Vendor No.")
        {
            trigger OnAfterValidate()
            var
                RecItem: Record Item;
            begin
                if "Vendor No." <> '' then begin
                    if (Type = Type::Inventory) AND ("Vendor Article No" <> '') AND ("Vendor No." <> '') then begin
                        Clear(RecItem);
                        RecItem.SetRange("Vendor Article No", "Vendor Article No");
                        RecItem.SetRange("Vendor No.", "Vendor No.");
                        if RecItem.FindFirst() then begin
                            IF RecItem."No." <> "No." then
                                Error('Vendor Article No. must be unique. Vendor Article No.: ' + Rec."Vendor Article No" + ' Vendor No.: ' + Rec."Vendor No.");
                        end;
                    end;
                    CheckNinsertVendorArtcile();
                end else begin
                    //  Brand := '';
                    "Common Item No." := '';
                end;
                //  if Rec."Vendor No." <> xRec."Vendor No." then begin
                //  Brand := '';
                //  end;
            end;
        }
        field(50001; "Description 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Brand"; Code[20])
        {
            // TableRelation = "Vendor Brand Master".Brands where("Vendor No." = field("Vendor No."));
            TableRelation = "Item Brands".Code;
            ValidateTableRelation = true;
            trigger OnValidate()
            begin
                AfterBrand;
            end;

        }
        field(50003; IsUploaded; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50005; "Available Items"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum ("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Location Code" = FIELD("Location Filter")));
        }
    }
    keys
    {
        key(PK2; "Vendor Article No")
        {

        }
    }
    fieldgroups
    {
        addlast(DropDown; "Vendor Article No")
        {
        }
    }
    trigger OnAfterInsert()
    var
        myInt: Integer;
    begin
        if "No." <> '' then;
        // TestField("Vendor Article No");// Mandatory field
        if "No." <> '' then
            Validate(Reserve, Reserve::Always);
    end;

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        "Created By" := UserId;
    end;

    trigger OnBeforeModify()
    var
        myInt: Integer;
    begin
        //if "No." <> '' then
        //   TestField("Vendor Article No");
    end;

    procedure CheckNinsertVendorArtcile()
    var
        RecVATList: Record "Vendor Article List";
        RecVATList2: Record "Vendor Article List";
        RecCatItemSetup: Record "Nonstock Item Setup";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
        NO: Integer;
    begin
        Clear(RecVATList);
        RecCatItemSetup.GET;
        RecVATList.SetRange("Vendor No.", Rec."Vendor No.");
        RecVATList.SetRange("Vendor Article No.", Rec."Vendor Article No");
        if RecVATList.FindFirst() then
            "Common Item No." := RecVATList."Common Item No."
        else begin
            NO := 0;
            Clear(RecVATList);
            IF not RecVATList.FindLast() then
                NO := 10000;
            RecVATList.Init();
            RecVATList."Vendor No." := Rec."Vendor No.";
            RecVATList."Vendor Article No." := Rec."Vendor Article No";
            if (NO <> 0) then
                RecVATList."Entry No." := NO;
            RecVATList.Insert(true);
            RecVATList."Common Item No." := FORMAT(RecVATList."Entry No.");
            RecVATList.Modify();
            "Common Item No." := RecVATList."Common Item No.";
        end;
        //Modify();
    end;

    procedure AfterBrand()

    var
        RecItemBrand: Record "Item Brands";
        RecDefaultDim: Record "Default Dimension";
        InvtSetup: Record "Inventory Setup";
        VendorBrands: Record "Vendor Brand Master";
    begin
        if "No." = '' then
            exit;
        InvtSetup.GET;
        if Rec.Brand <> '' then begin
            Clear(RecItemBrand);
            RecItemBrand.SetRange(Code, Rec.Brand);
            if RecItemBrand.FindFirst() then begin
                RecItemBrand.TestField("Brand Dimesnion");
                RecDefaultDim.Reset();
                RecDefaultDim.SetRange("Table ID", Database::Item);
                RecDefaultDim.SetRange("No.", Rec."No.");
                RecDefaultDim.SetRange("Dimension Code", InvtSetup."Brand Dimension");
                If not RecDefaultDim.FindFirst() then begin
                    RecDefaultDim.Init();
                    RecDefaultDim.Validate("Table ID", Database::Item);
                    RecDefaultDim.Validate("No.", Rec."No.");
                    RecDefaultDim.Validate("Dimension Code", InvtSetup."Brand Dimension");
                    RecDefaultDim.Validate("Dimension Value Code", RecItemBrand."Brand Dimesnion");
                    RecDefaultDim.Validate("Value Posting", RecDefaultDim."Value Posting"::"Same Code");
                    RecDefaultDim.Insert(true);
                end else begin
                    RecDefaultDim.Validate("Dimension Value Code", RecItemBrand."Brand Dimesnion");
                    RecDefaultDim.Validate("Value Posting", RecDefaultDim."Value Posting"::"Same Code");
                    RecDefaultDim.Modify(true);
                end;
            end;
        end else begin
            RecDefaultDim.Reset();
            RecDefaultDim.SetRange("Table ID", Database::Item);
            RecDefaultDim.SetRange("No.", "No.");
            RecDefaultDim.SetRange("Dimension Code", InvtSetup."Brand Dimension");
            if RecDefaultDim.FindFirst() then
                RecDefaultDim.Delete();
        end;
        ///  CurrPage.SaveRecord();
    end;

    procedure SetBrandFlag()
    begin
        IsBrandValidate := true;
    end;

    var
        IsBrandValidate: Boolean;
}