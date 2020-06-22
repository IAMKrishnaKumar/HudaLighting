tableextension 50119 CutsomerExt extends Customer
{
    fields
    {
        // Add changes to table fields here
        modify("E-Mail")
        {
            trigger OnBeforeValidate()
            var
                RecCust: Record Customer;
            begin
                if "E-Mail" <> '' then begin
                    Clear(RecCust);
                    RecCust.SetRange("E-Mail", "E-Mail");
                    If RecCust.FindFirst() then
                        Error('Customer with same E-mail Id is already exists.');
                end;
            end;
        }
        field(50000; "Legal Registration Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "GP Reference"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Name - Arabic"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Address-Arabic"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Address 2 - Arabic"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        modify("Phone No.")
        {
            trigger OnBeforeValidate()
            var
                RecCust: Record Customer;
            begin
                if "Phone No." <> '' then begin
                    Clear(RecCust);
                    RecCust.SetRange("Phone No.", "Phone No.");
                    If RecCust.FindFirst() then
                        Error('Customer with same Phone No. is already exists.');
                end;
            end;
        }
        field(50901; "Advance Paid To Customer"; Decimal)
        {
            Caption = 'Advance received (LCY)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum ("G/L Entry".Amount WHERE("Posting Date" = FIELD("Date Filter"), "Source Type" = filter(Customer), "Source No." = field("No."), "G/L Account No." = filter('201610')));
        }
    }

    var
        myInt: Integer;

}