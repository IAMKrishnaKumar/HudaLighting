xmlport 50103 ItemMasterImport
{
    Caption = 'Item uploader';
    Direction = Import;
    Format = VariableText;
    TextEncoding = UTF8;
    FieldSeparator = ',';
    UseRequestPage = false;


    schema
    {
        textelement(Root)
        {
            tableelement(ItemL; Item)
            {
                AutoSave = false;
                textelement("Vendor_Article_No.")
                { }
                textelement("Vendor_No.")
                { }
                textelement("Description1")
                { }
                textelement("Description2")
                { }
                textelement("Description3")
                { }
                textelement("Type")
                { }
                textelement("Base_unit_of_Measure")
                { }
                textelement("Purchase_unit_of_Measure")
                { }
                textelement("Sales_Unit_of_Measure")
                { }
                textelement("Item_Category_Code")
                { }
                textelement("Brand_Dimension")
                { }
                textelement("Gen_Prod_Posting_Group")
                { }

                trigger OnAfterInitRecord()
                begin
                    if Pagecaption = true then begin
                        Pagecaption := false;
                        RowNumber += 1;
                        currXMLport.Skip();
                    end;
                end;

                trigger OnBeforeInsertRecord()
                var
                    NoSeries: Codeunit NoSeriesManagement;
                    InvtSetup: Record 313;
                    RecItem: Record Item;
                    DimVal: Record "Dimension Value";
                    RecItemBrand: Record "Item Brands";
                    RecDefaultDim: Record "Default Dimension";
                    InvPostGroup: Record "Inventory Posting Group";
                begin
                    RowNumber += 1;
                    InvtSetup.GET;
                    ItemL.Init();
                    ItemL.Validate("Vendor Article No", "Vendor_Article_No.");
                    ItemL.Validate("Vendor No.", "Vendor_No.");
                    ItemL.Insert(true);
                    ItemL.Description := Description1;
                    ItemL."Description 2" := Description2;
                    ItemL."Description 3" := Description3;
                    if Type = 'Inventory' then
                        ItemL.Validate(Type, ItemL.Type::Inventory)
                    else
                        if Type = 'Service' then
                            ItemL.Validate(Type, ItemL.Type::Service)
                        else
                            ItemL.Validate(Type, ItemL.Type::"Non-Inventory");
                    ItemL.Validate("Base Unit of Measure", Base_unit_of_Measure);
                    ItemL.Validate("Purch. Unit of Measure", Purchase_unit_of_Measure);
                    ItemL.Validate("Sales Unit of Measure", Sales_Unit_of_Measure);
                    ItemL.Validate("Item Category Code", Item_Category_Code);
                    ItemL.Validate("Gen. Prod. Posting Group", Gen_Prod_Posting_Group);
                    Clear(InvPostGroup);
                    InvPostGroup.SetFilter(Code, '<>%1', '');
                    if InvPostGroup.FindFirst() then
                        ItemL.Validate("Inventory Posting Group", InvPostGroup.Code);
                    Clear(RecItemBrand);
                    RecItemBrand.SetRange(Code, Brand_Dimension);
                    if RecItemBrand.FindFirst() then begin
                        RecDefaultDim.Reset();
                        RecDefaultDim.Init();
                        RecDefaultDim.Validate("Table ID", Database::Item);
                        RecDefaultDim.Validate("No.", ItemL."No.");
                        RecDefaultDim.Validate("Dimension Code", InvtSetup."Brand Dimension");
                        RecDefaultDim.Validate("Dimension Value Code", RecItemBrand."Brand Dimesnion");
                        RecDefaultDim.Validate("Value Posting", RecDefaultDim."Value Posting"::"Same Code");
                        RecDefaultDim.Insert(true);
                        //ItemL.Validate("Global Dimension 1 Code", RecItemBrand."Brand Dimesnion");
                    end;
                    ItemL.IsUploaded := true;
                    ItemL.Validate(Brand, Brand_Dimension);
                    ItemL.Validate(Reserve, ItemL.Reserve::Always);
                    if (ItemL."Vendor Article No" <> '') AND (ItemL."Vendor No." <> '') then
                        CheckNinsertVendorArtcile(ItemL);
                    ItemL.Modify(true);
                end;

            }
        }
    }
    trigger OnPreXmlPort()
    begin
        Pagecaption := true;
        RowNumber := 0;
    end;

    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Process completed.');
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
            NO := 0;
            Clear(RecVATList);
            IF not RecVATList.FindLast() then
                NO := 10000;
            RecVATList.Init();
            RecVATList."Vendor No." := RecItemL."Vendor No.";
            RecVATList."Vendor Article No." := RecItemL."Vendor Article No";
            if (NO <> 0) then
                RecVATList."Entry No." := NO;
            RecVATList.Insert(true);
            RecVATList."Common Item No." := FORMAT(RecVATList."Entry No.");
            RecVATList.Modify();
            RecItemL."Common Item No." := RecVATList."Common Item No.";
        end;
    end;

    var
        Pagecaption: Boolean;
        RowNumber: Integer;
        EvalDecimal: Decimal;
}