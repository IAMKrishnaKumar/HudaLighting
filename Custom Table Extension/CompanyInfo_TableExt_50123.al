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
        //email Alert
        field(50009; "OA Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Materials Received by Whse."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Sales Invoice Posting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Pick Materials"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "General Project Status"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        //Teams Email Ids

        field(50014; "OA Approval Email"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Materials Rec. by Whse. Email"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Sales Invoice Posting Email"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Pick Materials Email"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "General Project Status Email"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        //**********************************Daily Activity*********************
        field(50105; "Daily Activity"; Boolean)
        {
        	DataClassification = ToBeClassified;
        }        
    }

    var
        myInt: Integer;
}