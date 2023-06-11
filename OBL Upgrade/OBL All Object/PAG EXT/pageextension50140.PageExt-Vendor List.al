pageextension 50140 pageextension50140 extends "Vendor List"
{
    layout
    {
        addafter("No.")
        {
            field("CST Tin"; rec."CST Tin")
            {
                ApplicationArea = All;
            }
            field("GST Registration No."; rec."GST Registration No.")
            {
                ApplicationArea = All;
            }
            field("GST Vendor Type"; rec."GST Vendor Type")
            {
                ApplicationArea = All;
            }
            field("E-Mail"; rec."E-Mail")
            {
                ApplicationArea = All;
            }
            field("Security Amount"; rec."Security Amount")
            {
                ApplicationArea = All;
            }
            field("Security Date"; rec."Security Date")
            {
                ApplicationArea = All;
            }
            field("Net Change (LCY)"; rec."Net Change (LCY)")
            {
                ApplicationArea = All;
            }
            field("Emp Code"; rec."Emp Code")
            {
                ApplicationArea = All;
            }
            field("Vendor Classification"; rec."Vendor Classification")
            {
                ApplicationArea = All;
            }
            field("Pay-to Vendor No."; rec."Pay-to Vendor No.")
            {
                ApplicationArea = All;
            }
            field("Pin Code"; rec."Pin Code")
            {
                ApplicationArea = All;
            }
            field("Tax Registration No."; rec."Tax Registration No.")
            {
                ApplicationArea = All;
            }
            field("Bank A/c"; rec."Bank A/c")
            {
                ApplicationArea = All;
            }
            field("Bank Account Name"; rec."Bank Account Name")
            {
                ApplicationArea = All;
            }
            field("Bank Address"; rec."Bank Address")
            {
                ApplicationArea = All;
            }
            field("Bank Address 2"; rec."Bank Address 2")
            {
                ApplicationArea = All;
            }
            field("RTGS/NEFT Code"; rec."RTGS/NEFT Code")
            {
                ApplicationArea = All;
            }
        }
        addafter(Name)
        {
            field("P.A.N. Reference No."; rec."P.A.N. Reference No.")
            {
                ApplicationArea = All;
            }
            field("Tranporter RCM GST No."; rec."GST No.")
            {
                Caption = 'Tranporter RCM GST No.';
                ApplicationArea = All;
            }
            field("P.A.N. No."; rec."P.A.N. No.")
            {
                ApplicationArea = All;
            }
            field(Address; rec.Address)
            {
                ApplicationArea = All;
            }
            field("Address 2"; rec."Address 2")
            {
                ApplicationArea = All;
            }
            field(City; rec.City)
            {
                ApplicationArea = All;
            }
            field(Balance; rec.Balance)
            {
                ApplicationArea = All;
            }
            field("Debit Amount"; rec."Debit Amount")
            {
                ApplicationArea = All;
            }
            field("State Code"; rec."State Code")
            {
                ApplicationArea = All;
            }
            field(Transporter1; rec.Transporter1)
            {
                ApplicationArea = All;
            }
            field("Credit Amount"; rec."Credit Amount")
            {
                ApplicationArea = All;
            }
            field("Net Change"; rec."Net Change")
            {
                ApplicationArea = All;
            }
        }
        moveafter(Name; "Balance (LCY)", "Phone No.", "Payment Terms Code", "Gen. Bus. Posting Group", "Vendor Posting Group")


        addafter("Location Code2")
        {
            field("Msme Code"; rec."Msme Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipment Method Code")
        {
            field(Zone; rec.Zone)
            {
                Caption = 'Zone';
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Lead Time Calculation")
        {
            field("Landline No."; rec."Landline No.")
            {
                ApplicationArea = All;
            }
            field("E-Mail of Requested By Person"; rec."Requested By")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Supplier's E-Mail"; rec."E-Mail")
            {
                Caption = 'Supplier''s E-Mail';
                Editable = false;
                Importance = Promoted;
                ApplicationArea = All;
            }
            field(Grade; rec.Grade)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("A/C user E-mail"; rec."A/C user E-mail")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Creation Date"; rec."Creation Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Created By"; rec."Created By")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Bal on Balance Conf Date"; rec."Bal on Balance Conf Date")
            {
                Caption = '<Bal on Balance Conf Date>';
                ApplicationArea = All;
            }
            field("Balance Conf Date"; rec."Balance Conf Date")
            {
                ApplicationArea = All;
            }
            field("Balance confirmation"; rec."Balance confirmation")
            {
                ApplicationArea = All;
            }
            field(Image; rec.Image)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Aggregate Turnover"; rec."Aggregate Turnover")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("194Q "; rec."194Q")
            {
                Caption = '194Q';
                ApplicationArea = All;
            }
            field("Not Required"; rec."Not Required")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("194Q Recived Data"; rec."194Q Recived Data")
            {
                ApplicationArea = All;
            }
            field("Vend Ledger Balance"; rec."Vend Ledger Balance")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Co&mments")
        {
            action(Orders1)
            {
                Caption = 'Orders';
                Image = Document;
                Promoted = true;
                PromotedCategory = Category10;
                RunObject = Page "Purchase Order List";
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                RunPageView = SORTING("Buy-from Vendor No.");
                ShortCutKey = 'Ctrl+F1';
                ApplicationArea = All;
            }
        }
    }
}

