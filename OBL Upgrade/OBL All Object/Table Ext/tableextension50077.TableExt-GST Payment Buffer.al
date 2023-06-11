tableextension 50077 tableextension50077 extends "GST Payment Buffer"
{
    fields
    {
        modify("GST Registration No.")
        {
            Caption = 'GST Registration No.';
        }
        modify("Document No.")
        {
            Caption = 'Document No.';
        }
        modify("Posting Date")
        {
            Caption = 'Posting Date';
        }
        modify("GST Component Code")
        {
            Caption = 'GST Component Code';
        }
        modify(Description)
        {
            Caption = 'Description';
        }
        modify("Payment Liability")
        {
            Caption = 'Payment Liability';
        }
        modify("Net Payment Liability")
        {
            Caption = 'Net Payment Liability';
        }
        modify("Credit Availed")
        {
            Caption = 'Credit Availed';
        }
        modify("Distributed Credit")
        {
            Caption = 'Distributed Credit';
        }
        modify("Total Credit Available")
        {
            Caption = 'Total Credit Available';
        }
        modify("Credit Utilized")
        {
            Caption = 'Credit Utilized';
        }
        modify("Payment Amount")
        {
            Caption = 'Payment Amount';
        }
        modify(Interest)
        {
            Caption = 'Interest';
        }
        modify("Interest Account No.")
        {
            Caption = 'Interest Account No.';
        }
        modify(Penalty)
        {
            Caption = 'Penalty';
        }
        modify("Penalty Account No.")
        {
            Caption = 'Penalty Account No.';
        }
        modify(Fees)
        {
            Caption = 'Fees';
        }
        modify("Fees Account No.")
        {
            Caption = 'Fees Account No.';
        }
        modify(Others)
        {
            Caption = 'Others';
        }
        modify("Others Account No.")
        {
            Caption = 'Others Account No.';
        }
        modify("Account Type")
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,,,Bank Account';
        }
        modify("Account No.")
        {
            Caption = 'Account No.';
        }
        modify("Location State Code")
        {
            Caption = 'Location State Code';
        }
        modify("Surplus Credit")
        {
            Caption = 'Surplus Credit';
        }
        modify("Surplus Cr. Utilized")
        {
            Caption = 'Surplus Cr. Utilized';
        }
        modify("Carry Forward")
        {
            Caption = 'Carry Forward';
        }
        modify("Period End Date")
        {
            Caption = 'Period End Date';
        }
        modify("Bank Reference No.")
        {
            Caption = 'Bank Reference No.';
        }
        modify("Bank Reference Date")
        {
            Caption = 'Bank Reference Date';
        }
        modify("GST Input Service Distribution")
        {
            Caption = 'GST Input Service Distribution';
        }
        modify("Dimension Set ID")
        {
            Caption = 'Dimension Set ID';
        }

        //Unsupported feature: Deletion on ""Account Type"(Field 24).OnValidate".

    }
}

