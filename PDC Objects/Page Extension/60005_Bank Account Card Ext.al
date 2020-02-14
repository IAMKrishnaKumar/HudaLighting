pageextension 60005 "Bank Account Card Ext" extends "Bank Account Card"
{
    layout
    {
        addlast(Transfer)
        {
            field("PDC Report ID"; "PDC Report ID")
            {
                ApplicationArea = All;
            }
            field("PDC Report Name"; "PDC Report Name")
            {
                ApplicationArea = All;
            }
            field("Facility Amount (LCY)"; "Facility Amount (LCY)")
            {
                ApplicationArea = All;
            }

        }
        addlast(General)
        {
            field("Check Report ID"; "Check Report ID")
            {
                ApplicationArea = All;
            }
            field("Check Report Name"; "Check Report Name")
            {
                ApplicationArea = All;
            }
        }
    }


}