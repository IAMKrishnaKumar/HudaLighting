query 50103 "Sales Order by Sales Person"
{
    Caption = 'Sales Orders by Sales Person';

    elements
    {
        dataitem(Sales_Line; "Sales Line")
        {
            column(ItemNo; "No.")
            {
            }
            column(ItemDescription; Description)
            {
            }
            column(Document_No; "Document No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Line_No; "Line No.")
            {
            }
            column(Dimension_Set_ID; "Dimension Set ID")
            {
            }
            dataitem(Currency; Currency)
            {
                DataItemLink = Code = Sales_Line."Currency Code";
                column(CurrenyDescription; Description)
                {
                }
                dataitem(Sales_Header; "Sales Header")
                {
                    DataItemLink = "No." = Sales_Line."Document No.";
                    column(Currency_Code; "Currency Code")
                    {
                    }
                    column(Document_Date; "Document Date")
                    {

                    }
                    column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
                    {

                    }
                    column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
                    {

                    }
                    dataitem(Salesperson_Purchaser; "Salesperson/Purchaser")
                    {
                        DataItemLink = Code = Sales_Header."Salesperson Code";
                        column(SalesPersonCode; "Code")
                        {
                        }
                        column(SalesPersonName; Name)
                        {
                        }
                    }
                }
            }
        }
    }
}




query 50104 "Sales Person And Territory"
{
    Caption = 'Sales Person And Territory';

    elements
    {
        dataitem(Sales_Line; "Sales Line")
        {
            dataitem(Currency; Currency)
            {
                DataItemLink = Code = Sales_Line."Currency Code";

                dataitem(Sales_Header; "Sales Header")
                {
                    DataItemLink = "No." = Sales_Line."Document No.";

                    column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
                    {

                    }
                    column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
                    {

                    }
                    dataitem(Salesperson_Purchaser; "Salesperson/Purchaser")
                    {
                        DataItemLink = Code = Sales_Header."Salesperson Code";
                        column(SalesPersonCode; "Code")
                        {
                        }
                        column(SalesPersonName; Name)
                        {
                        }
                    }
                }
            }
        }
    }
}

