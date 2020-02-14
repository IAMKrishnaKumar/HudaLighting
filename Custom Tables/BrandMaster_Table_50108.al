table 50108 "Item Brands"
{
    LookupPageId = "Item Brand";
    DrillDownPageId = "Item Brand";
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; SetupCode; Text[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup ("Inventory Setup"."Brand Dimension");
        }
        field(4; "Brand Dimesnion"; code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = field(SetupCode));
            NotBlank = true;
        }

    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
        key(PK2; "Brand Dimesnion", Code)
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; code, Description, "Brand Dimesnion")
        {

        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
    end;

    trigger OnModify()
    begin
        //TestField("Brand Dimesnion");
    end;

    trigger OnDelete()
    var
        RecItem: Record Item;
    begin
        Clear(RecItem);
        RecItem.SetRange(Brand, Rec.Code);
        if RecItem.FindFirst() then begin
            Error('Selected Brand is linked with Item No. ' + RecItem."No.");
        end;
    end;

    trigger OnRename()
    begin

    end;

}