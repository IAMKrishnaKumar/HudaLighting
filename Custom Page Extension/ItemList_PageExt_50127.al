pageextension 50127 ItemPageList extends "Item List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Cost is Adjusted")
        {
            field(Brand; Brand)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Available Items"; "Available Items")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(IsUploaded; IsUploaded)
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field("Created By"; "Created By")
            {
                ApplicationArea = All;
                Enabled = false;
            }
        }
        addafter(Description)
        {
            field("Vendor Article No"; "Vendor Article No")
            {
                ApplicationArea = All;
            }
        }


        addbefore("Power BI Report FactBox")
        {
            part(ItemPicture; "Item Picture")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                Caption = 'Item Image';
            }
        }

        addafter("Power BI Report FactBox")
        {
            part("Item Availability"; "Item Availability FactBox")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = Basic, Suite;
                Caption = 'Item Details';
                Visible = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(Resources)
        {
            group(Import)
            {
                action("Upload Items")
                {
                    ApplicationArea = All;
                    Image = Import;
                    Caption = 'Upload Items';

                    trigger OnAction()
                    var
                        InsertItem: Codeunit "Import Items";
                        RecItemBuffer: Record "Item Buffer";
                        ErrorMessage: Text;
                        dlgProgress: Dialog;
                        nRecNum: Integer;
                        ValidatingRecord: Label 'Validating Records #1';
                        InsertingRecords: Label 'Inserting Items #1';
                        ErrorMessageOnInsert: Text;
                        FaultCount: Integer;
                    begin
                        if not Confirm('Are you sure you want to import Items using CSV?', false) then
                            exit;
                        Clear(RecItemBuffer);
                        RecItemBuffer.SetFilter("Entry No.", '<>%1', 0);
                        RecItemBuffer.SetFilter(UploadedBy, '=%1', UserId);
                        if RecItemBuffer.FindSet() then
                            RecItemBuffer.DeleteAll();

                        Xmlport.Run(50107, false, true);
                        ErrorMessage := '';
                        ErrorMessageOnInsert := '';
                        Clear(RecItemBuffer);
                        RecItemBuffer.SetFilter("Entry No.", '<>%1', 0);
                        RecItemBuffer.SetFilter(UploadedBy, '=%1', UserId);
                        if RecItemBuffer.FindSet() then begin
                            dlgProgress.OPEN(ValidatingRecord);
                            nRecNum := 0;
                            InsertItem.setInsertValue(false);
                            repeat
                                nRecNum += 1;
                                dlgProgress.UPDATE(1, nRecNum);
                                // InsertItem.setInsertValue(false);
                                Commit();
                                if not InsertItem.Run(RecItemBuffer) then begin
                                    ErrorMessage := ErrorMessage + '\' + GetLastErrorText;
                                end;
                            until RecItemBuffer.Next() = 0;
                            dlgProgress.CLOSE;
                        end;
                        if ErrorMessage = '' then begin
                            Clear(RecItemBuffer);
                            RecItemBuffer.LockTable(true);
                            RecItemBuffer.SetFilter("Entry No.", '<>%1', 0);
                            RecItemBuffer.SetFilter(UploadedBy, '=%1', UserId);
                            if RecItemBuffer.FindSet() then begin
                                dlgProgress.OPEN(InsertingRecords);
                                nRecNum := 0;
                                FaultCount := 0;
                                InsertItem.setInsertValue(true);
                                repeat
                                    nRecNum += 1;
                                    dlgProgress.UPDATE(1, nRecNum);
                                    //InsertItem.setInsertValue(true);
                                    Commit();
                                    if not InsertItem.Run(RecItemBuffer) then begin
                                        ErrorMessageOnInsert := ErrorMessageOnInsert + '\' + GetLastErrorText + ' Vendor Article No: ' + RecItemBuffer."Vendor Article No." + ' Vendor No.: ' + RecItemBuffer."Vendor No.";
                                        FaultCount += 1;
                                    end;
                                //   Commit();//Later
                                until RecItemBuffer.Next() = 0;
                                dlgProgress.CLOSE;
                                if ErrorMessageOnInsert = '' then
                                    Message(Format(nRecNum) + ' Items Inserted Successfully.')
                                else
                                    Message(Format(nRecNum - FaultCount) + ' Items Inserted out of ' + format(nRecNum) + '\' + 'Error List :- ' + '\' + ErrorMessageOnInsert);
                            end;
                            Clear(RecItemBuffer);
                            RecItemBuffer.SetFilter("Entry No.", '<>%1', 0);
                            RecItemBuffer.SetFilter(UploadedBy, '=%1', UserId);
                            if RecItemBuffer.FindSet() then
                                RecItemBuffer.DeleteAll();
                        end else begin
                            Clear(RecItemBuffer);
                            RecItemBuffer.SetFilter("Entry No.", '<>%1', 0);
                            RecItemBuffer.SetFilter(UploadedBy, '=%1', UserId);
                            if RecItemBuffer.FindSet() then
                                RecItemBuffer.DeleteAll();
                            Message(ErrorMessage);
                        end;
                        Clear(RecItemBuffer);
                        RecItemBuffer.SetFilter("Entry No.", '<>%1', 0);
                        RecItemBuffer.SetFilter(UploadedBy, '=%1', UserId);
                        if RecItemBuffer.FindSet() then
                            RecItemBuffer.DeleteAll();
                    end;

                }


            }

        }
    }

    var
        myInt: Integer;
        ErrorText: Label 'Vendor Article No. must be unique.';
        DupicateVendor: Label 'Duplicate Vendor Article No. Exits in Excel Sheet.';
}
