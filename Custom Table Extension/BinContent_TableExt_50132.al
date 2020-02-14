tableextension 50131 BinContentExt extends "Bin Content"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Vendor Article No."; Text[50])
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup (Item."Vendor Article No" where("No." = field("Item No.")));
        }
        field(50001; "Description"; Text[100])
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup (Item.Description where("No." = field("Item No.")));
        }
        field(50002; "Description 2"; Text[50])
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup (Item."Description 2" where("No." = field("Item No.")));
        }
        field(50003; "Description 3"; Text[250])
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup (Item."Description 3" where("No." = field("Item No.")));
        }

    }
    trigger OnBeforeModify()
    var
        RecItem: Record Item;
    begin
        /* if "Item No." <> '' then begin
             Clear(RecItem);
             IF RecItem.GET("Item No.") then begin
                 "Vendor Article No." := RecItem."Vendor Article No";
                 Description := RecItem.Description;
                 "Description 2" := RecItem."Description 2";
                 "Description 3" := RecItem."Description 3";
             end;
         end;*/
    end;

    trigger OnAfterInsert()
    var
        RecItem: Record Item;
    begin
        /*  if "Item No." <> '' then begin
              Clear(RecItem);
              IF RecItem.GET("Item No.") then begin
                  "Vendor Article No." := RecItem."Vendor Article No";
                  Description := RecItem.Description;
                  "Description 2" := RecItem."Description 2";
                  "Description 3" := RecItem."Description 3";
              end;
          end;*/
    end;

    var
        myInt: Integer;
}