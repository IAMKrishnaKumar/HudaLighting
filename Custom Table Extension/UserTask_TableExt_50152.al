tableextension 50152 UserTask extends "User Task"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Task Description 2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}