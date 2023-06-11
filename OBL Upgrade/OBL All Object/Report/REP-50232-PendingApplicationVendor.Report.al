report 50232 "Pending Application Vendor"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\PendingApplicationVendor.rdl';

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            CalcFields = Amount, "Remaining Amount", "Vendor Invoice Date";
            DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code")
                                WHERE(Open = FILTER(true));
            RequestFilterFields = "Vendor No.";
            column(VendNo; "Vendor Ledger Entry"."Vendor No.")
            {
            }
            column(PostingDate; FORMAT("Vendor Ledger Entry"."Posting Date"))
            {
            }
            column(DocType; "Vendor Ledger Entry"."Document Type")
            {
            }
            column(DocNo; "Vendor Ledger Entry"."Document No.")
            {
            }
            column(Desc; "Vendor Ledger Entry".Description)
            {
            }
            column(Amout; "Vendor Ledger Entry".Amount)
            {
            }
            column(RemAmt; "Vendor Ledger Entry"."Remaining Amount")
            {
            }
            column(VendPostingGrp; "Vendor Ledger Entry"."Vendor Posting Group")
            {
            }
            column(ExtDocNo; "Vendor Ledger Entry"."External Document No.")
            {
            }
            column(VendorInvNo; "Vendor Ledger Entry"."Vendor Invoice No.")
            {
            }
            column(VendorInvDate; FORMAT("Vendor Ledger Entry"."Vendor Invoice Date"))
            {
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

