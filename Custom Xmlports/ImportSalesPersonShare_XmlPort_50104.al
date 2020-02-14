xmlport 50104 ImportSalesPersonShare
{
    Direction = Import;
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(Root)
        {
            tableelement(SalesPerserShare; "Sales Person Staging")
            {
                fieldelement(OpportunityNo; SalesPerserShare."Opportunity No")
                {

                }
                fieldelement(Salesperson; SalesPerserShare.Salesperson)
                {

                }
                fieldelement(EffectiveDate; SalesPerserShare."Effective Date")
                {

                }
                fieldelement(SharePercentage; SalesPerserShare."Share %")
                {

                }
                trigger OnBeforeInsertRecord()
                begin
                    SalesPerserShare."Entry Date and Time" := CurrentDateTime;
                    SalesPerserShare."Integration Status" := SalesPerserShare."Integration Status"::Pending;
                end;
            }
        }
    }

    /*  requestpage
      {
          layout
          {
              area(content)
              {
                  group(GroupName)
                  {
                      field(Name; SourceExpression)
                      {

                      }
                  }
              }
          }

          actions
          {
              area(processing)
              {
                  action(ActionName)
                  {

                  }
              }
          }
      }*/

    var
        myInt: Integer;
}