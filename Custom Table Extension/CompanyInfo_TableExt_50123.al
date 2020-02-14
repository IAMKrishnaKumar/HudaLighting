tableextension 50123 CompanyInfo extends "Company Information"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Vendor Replication Master"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "With Holding Tax Applicable"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Replicate Vendor"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Footer Image"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Bitmap;
        }
        field(50004; "Header Image"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Bitmap;
        }
        field(50005; "Remark Text 1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Remark Text 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Enable Auto Report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Tax Type"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}