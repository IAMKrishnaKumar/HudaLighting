report 50166 "Email Feasibility TEST"
{
    UsageCategory = Administration;
    // ApplicationArea = All;
    //ProcessingOnly = true;
    dataset
    {
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }
    }

    trigger OnPostReport()
    var

        SMTPSetup: Record "SMTP Mail Setup";
        ccEmail: List of [Text];
        SMTPMail: Codeunit "SMTP Mail";
        BccEmail: List of [Text];
        SOReport: Report 50127;
        Sheader: Record "Sales Header";
        ReportInOutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        ReportInStream: InStream;
        TxtAttachmentName: TextConst ENG = 'Invoice - %1.pdf';
        AttachmentName: Text;
    begin

        SMTPSetup.GET();
        //
        BccEmail.Add('3d7c8181.levtechconsulting.com@emea.teams.ms');
        //eb5ee116.levtechconsulting.com@emea.teams.ms');//krishnakumar.r@levtechconsulting.com');
        //ccEmail.Add('krishnakumar.r@levtechconsulting.com');
        SMTPMail.CreateMessage('Dynamics Notification', SMTPSetup."User ID", BccEmail, 'PDF Attachement in Teams ', '');
        //SMTPMail.AddBCC(ccEmail);
        Clear(Sheader);
        Sheader.SetRange("Document Type", Sheader."Document Type"::Order);
        Sheader.SetRange("No.", 'UAE/SO/20/00020');
        if Sheader.FindFirst() then begin
            TempBlob.CreateOutStream(ReportInOutStream);
            SaveDocumentAsPDFToStream(Report::"Sales Order report", Sheader, ReportInOutStream);
            TempBlob.CreateInStream(ReportInStream);
        end;
        AttachmentName := StrSubstNo(TxtAttachmentName, Sheader."No.");
        SMTPMail.AddAttachmentStream(ReportInStream, AttachmentName);
        SMTPMail.AppendBody('<p>Test email.</p>');
        SMTPMail.AppendBody('</br></br>');
        // SMTPMail.AppendBody('<p>Teams Notification @Raghu</p>');
        SMTPMail.AppendBody('<p>This email is sent by Huda Lighting Business Central</p>');

        SMTPMail.Send();
    end;


    local procedure SaveDocumentAsPDFToStream(ReportId: Integer; DocumentVariant: Variant; var VarOutStream: OutStream): Boolean;
    var
        DataTypeMgt: Codeunit "Data Type Management";

        DocumentRef: RecordRef;
    begin
        DataTypeMgt.GetRecordRef(DocumentVariant, DocumentRef);
        if Report.SaveAs(ReportID, '', ReportFormat::Pdf, VarOutStream, DocumentRef) then
            exit(true);
    end;
}