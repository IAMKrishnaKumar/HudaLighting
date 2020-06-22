page 50141 "Update Sales Invoice"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Invoice Header";
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTableTemporary = True;
    Permissions = tabledata 112 = RIMD;
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

            }
            group(Project)
            {
                field("Project Name"; "Project Name")
                {
                    ApplicationArea = All;
                }
                field("Project Reference"; "Project Reference")
                {
                    ApplicationArea = All;
                }
                field("Amount (In Arabic)"; "Amount (In Arabic)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (CloseAction = ACTION::LookupOK) then begin
            if RecordChanged() then
                SaveRecord();
        end;
    end;

    local procedure RecordChanged(): Boolean
    var
        xPostedSalesInv: Record "Sales Invoice Header";
    begin
        xPostedSalesInv.GET(Rec."No.");
        exit((Rec."Project Name" <> xPostedSalesInv."Project Name") OR
        (Rec."Project Reference" <> xPostedSalesInv."Project Reference") OR
        (Rec."Amount (In Arabic)" <> xPostedSalesInv."Amount (In Arabic)"));
    end;

    procedure SetRec(SalesInvHeader: Record "Sales Invoice Header")
    begin
        Rec := SalesInvHeader;
        Insert;
    end;

    local procedure SaveRecord()
    var
        RecSalesInvHeader: Record "Sales Invoice Header";
    begin
        RecSalesInvHeader.GET(Rec."No.");
        RecSalesInvHeader."Project Name" := Rec."Project Name";
        RecSalesInvHeader."Project Reference" := Rec."Project Reference";
        RecSalesInvHeader."Amount (In Arabic)" := Rec."Amount (In Arabic)";
        RecSalesInvHeader.Modify();
    end;

    var
        myInt: Integer;
}