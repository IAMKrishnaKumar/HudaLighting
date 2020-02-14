table 50113 "Vendor Brand Master"
{
    DataClassification = ToBeClassified;
    LookupPageId = 50122;
    DrillDownPageId = 50122;

    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(2; "Brands"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Brands".Code;
        }
    }

    keys
    {
        key(PK; "Vendor No.", Brands)
        {
            Clustered = true;
        }
        /* key(PK2; Brands)
         {

         }*/
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Vendor No.", Brands)
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

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}