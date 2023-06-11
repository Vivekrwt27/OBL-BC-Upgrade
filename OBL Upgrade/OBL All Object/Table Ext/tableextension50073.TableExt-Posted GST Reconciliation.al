tableextension 50073 tableextension50073 extends "Posted GST Reconciliation"
{
    fields
    {
        modify("GSTIN No.")
        {
            Caption = 'GSTIN No.';
        }
        modify("State Code")
        {
            Caption = 'State Code';
        }
        modify("Reconciliation Month")
        {
            Caption = 'Reconciliation Month';
        }
        modify("Reconciliation Year")
        {
            Caption = 'Reconciliation Year';
        }
        modify("GST Component")
        {
            Caption = 'GST Component';
        }
        modify("GST Amount")
        {
            Caption = 'GST Amount';
        }
        modify("GST Prev. Period B/F Amount")
        {
            Caption = 'GST Prev. Period B/F Amount';
        }
        modify("GST Amount Utilized")
        {
            Caption = 'GST Amount Utilized';
        }
        modify("GST Prev. Period C/F Amount")
        {
            Caption = 'GST Prev. Period C/F Amount';
        }
        modify("Source Type")
        {
            Caption = 'Source Type';
            OptionCaption = 'Reconciliation,Credit - Adjustment,Settlement,ISD';
        }
        modify("Payment Posted (Sales)")
        {
            Caption = 'Payment Posted (Sales)';
        }
        modify("Payment Posted (Sales Export)")
        {
            Caption = 'Payment Posted (Sales Export)';
        }
        modify("Payment Posted (Adv-Rev)")
        {
            Caption = 'Payment Posted (Adv-Rev)';
        }
        modify("Payment Posted (Invoice-Rev)")
        {
            Caption = 'Payment Posted (Invoice-Rev)';
        }
    }
}

