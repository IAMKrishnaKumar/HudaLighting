tableextension 60016 "Bank Account Ext" extends "Bank Account"
{
    fields
    {
        field(60000; "Facility Amount (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Facility Amount (LCY)';
        }
        field(60001; "PDC Report Name"; Text[80])
        {

            FieldClass = FlowField;
            CalcFormula = Lookup (AllObjWithCaption."Object Name" WHERE("Object Type" = CONST(Report), "Object ID" = FIELD("PDC Report ID")));
            Editable = false;
        }
        field(60002; "PDC Report ID"; Integer)
        {
            DataClassification = ToBeClassified;
            //TableRelation=Object.ID where (Type=const(Report));
        }
    }


}