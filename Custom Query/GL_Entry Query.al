query 50100 "G/L Entry"
{
    Caption = 'G/L Entries';

    elements
    {
        dataitem(QueryElement1; 17)
        {
            column(Entry_No; "Entry No.")
            {
            }
            column(Transaction_No; "Transaction No.")
            {
            }
            column(G_L_Account_No; "G/L Account No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Document_Date; "Document Date")
            {
            }
            column(Document_Type; "Document Type")
            {
            }
            column(Document_No; "Document No.")
            {
            }
            column(Source_Code; "Source Code")
            {
            }
            column(Job_No; "Job No.")
            {
            }
            column(Business_Unit_Code; "Business Unit Code")
            {
            }
            column(Reason_Code; "Reason Code")
            {
            }
            column(Gen_Posting_Type; "Gen. Posting Type")
            {
            }
            column(Gen_Bus_Posting_Group; "Gen. Bus. Posting Group")
            {
            }
            column(Gen_Prod_Posting_Group; "Gen. Prod. Posting Group")
            {
            }
            column(Tax_Area_Code; "Tax Area Code")
            {
            }
            column(Tax_Liable; "Tax Liable")
            {
            }
            column(Tax_Group_Code; "Tax Group Code")
            {
            }
            column(Use_Tax; "Use Tax")
            {
            }
            column(VAT_Bus_Posting_Group; "VAT Bus. Posting Group")
            {
            }
            column(VAT_Prod_Posting_Group; "VAT Prod. Posting Group")
            {
            }
            column(IC_Partner_Code; "IC Partner Code")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Debit_Amount; "Debit Amount")
            {
            }
            column(Credit_Amount; "Credit Amount")
            {
            }
            column(VAT_Amount; "VAT Amount")
            {
            }
            column(Additional_Currency_Amount; "Additional-Currency Amount")
            {
            }
            column(Add_Currency_Debit_Amount; "Add.-Currency Debit Amount")
            {
            }
            column(Add_Currency_Credit_Amount; "Add.-Currency Credit Amount")
            {
            }
            column(Dimension_Set_ID; "Dimension Set ID")
            {
            }
            column(G_L_Account_Name; "G/L Account Name")
            {
            }
            column(Sales_Person; "Sales Person")
            {

            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {

            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {

            }
            column(Project_Name; "Project Name")
            {

            }
            column(Shared__; "Shared %")
            {

            }
            column(Customer_Name; "Customer Name")
            {

            }
            column(G_L_Account_Category_; "G/L Account Category ")
            {

            }
        }
    }
}




query 50102 "Purchase Line Table"
{
    Caption = 'Purchase Line Table';

    elements
    {
        dataitem(Purchase_Line; "Purchase Line")
        {
            column(Document_Type; "Document Type")
            {

            }
            column(Document_No_; "Document No.")
            {

            }
            column(Line_No_; "Line No.")
            {

            }
            column(No_; "No.")
            {

            }
            column(Description; Description)
            {

            }
            column(Location_Code; "Location Code")
            {

            }
            column(Expected_Receipt_Date; "Expected Receipt Date")
            {

            }
            column(Unit_of_Measure; "Unit of Measure")
            {

            }
            column(Quantity; Quantity)
            {

            }
            column(Outstanding_Amount; "Outstanding Amount")
            {

            }

            column(Outstanding_Quantity; "Outstanding Quantity")
            {

            }
            column(Qty__to_Invoice; "Qty. to Invoice")
            {

            }
            column(Qty__to_Receive; "Qty. to Receive")
            {

            }
            column(Unit_Cost; "Unit Cost")
            {

            }
            column(Unit_Cost__LCY_; "Unit Cost (LCY)")
            {

            }
            column(Unit_Price__LCY_; "Unit Price (LCY)")
            {

            }
            column(Amount; Amount)
            {

            }
            column(Amount_Including_VAT; "Amount Including VAT")
            {

            }
            column(Qty__Rcd__Not_Invoiced; "Qty. Rcd. Not Invoiced")
            {

            }
            column(Amt__Rcd__Not_Invoiced; "Amt. Rcd. Not Invoiced")
            {

            }
            column(Quantity_Received; "Quantity Received")
            {

            }
            column(Quantity_Invoiced; "Quantity Invoiced")
            {

            }
            column(Outstanding_Amount__LCY_; "Outstanding Amount (LCY)")
            {

            }
        }
    }


}
