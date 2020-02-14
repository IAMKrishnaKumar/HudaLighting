tableextension 50159 PaymentTerms extends "Payment Terms"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Payment Milestone Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}