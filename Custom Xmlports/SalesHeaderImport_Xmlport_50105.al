xmlport 50105 "Sales Order Import"
{

    Direction = Import;
    UseDefaultNamespace = true;
    schema
    {
        textelement(Root)
        {
            tableelement("SalesOrder"; "Sales Order Staging")
            {
                fieldelement(CustomerNo; SalesOrder."Customer No.")
                {
                }
                fieldelement(ProjectReferenceNo; SalesOrder."Project Reference No.")
                {
                }
                fieldelement(ProjectName; SalesOrder."Project Name")
                {
                }
                fieldelement(SalesPerson; SalesOrder."Sales Person")
                { }
                fieldelement(EstimatedOrderValue; SalesOrder."Estimated Order Value")
                { }
                fieldelement(OrderDate; SalesOrder."Order Date")
                { }
                fieldelement(RequestedDeliveryDate; SalesOrder."Requested Delivery Date")
                { }
                fieldelement(PromisedDeliveryDate; SalesOrder."Promised Delivery Date")
                { }
                fieldelement(CurrencyCode; SalesOrder."Currency Code")
                { }
                fieldelement(PaymentTerms; SalesOrder."Payment Terms ")
                { }
                fieldelement(OpportunityNo; SalesOrder."Opportunity No.")
                { }
                fieldelement(PO_Reference; SalesOrder."PO Reference")
                { }
                trigger OnBeforeInsertRecord()
                var
                    SOStaging: Record "Sales Order Staging";
                begin
                    SalesOrder."Entry Date and Time" := CurrentDateTime();
                    SalesOrder."Integration Status" := SalesOrder."Integration Status"::Pending;
                end;

            }
        }
    }

    var
        myInt: Integer;
}