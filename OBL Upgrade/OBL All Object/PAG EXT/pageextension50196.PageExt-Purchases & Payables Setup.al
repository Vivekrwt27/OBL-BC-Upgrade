pageextension 50196 pageextension50196 extends "Purchases & Payables Setup"
{
    layout
    {
        moveafter("Calc. Inv. Discount"; "RCM Exempt End Date (Unreg)", "RCM Exempt start Date (Unreg)")

        addafter("Posted Credit Memo Nos.")
        {
            field("<Pposted Return Shpt. Nos.>"; Rec."Posted Return Shpt. Nos.")
            {
                ApplicationArea = All;
            }

        }
        addafter("Calc. Inv. Discount")
        {
            field("Indent No. Mandatory"; Rec."Indent No. Mandatory")
            {
                ApplicationArea = all;
            }
            field("Form Code For Form 38"; Rec."Form Code For Form 38")
            {
                ApplicationArea = all;
            }
            field("Form Code For Form 31"; Rec."Form Code For Form 31")
            {
                ApplicationArea = all;
            }
            field("EY Token User Name"; Rec."EY Token User Name")
            {
                ApplicationArea = all;
            }
            field("EY Toekn Password"; Rec."EY Toekn Password")
            {
                ApplicationArea = all;
            }
            field("EY Api Access Key"; Rec."EY Api Access Key")
            {
                ApplicationArea = all;
            }
            field("EY Purchase Register URL"; Rec."EY Purchase Register URL")
            {
                ApplicationArea = all;
            }
            field("EY Reconcilation Detail URL"; Rec."EY Reconcilation Detail URL")
            {
                ApplicationArea = all;
            }
            field("EY Reconcilation Report URL"; Rec."EY Reconcilation Report URL")
            {
                ApplicationArea = all;
            }
            field("EY Token URL"; Rec."EY Token URL")
            {
                ApplicationArea = all;
            }



        }
        addafter("Posted SC Comp. Rcpt. Nos.")
        {
            field("RFQ No."; Rec."RFQ No.")
            {
                ApplicationArea = all;
            }
            field("Indent Nos."; Rec."Indent Nos.")
            {
                ApplicationArea = all;
            }
            field("Vendor Nos. 2"; Rec."Vendor Nos. 2")
            {
                ApplicationArea = all;
            }
            field("Reject No."; Rec."Reject No.")
            {
                ApplicationArea = all;
            }
            field("Store Reject No"; Rec."Store Reject No")
            {
                ApplicationArea = all;
            }
            field("RGP No. Series"; Rec."RGP No. Series")
            {
                ApplicationArea = all;
            }
            field("Auto Indent No. Series"; Rec."Auto Indent No. Series")
            {
                ApplicationArea = all;
            }
            field("Budget No. Series"; Rec."Budget No. Series")
            {
                ApplicationArea = all;
            }



        }
        addafter("Document Default Line Type")
        {
            field("Rejection Reason Code"; Rec."Rejection Reason Code")
            {
                ApplicationArea = all;
            }
            field("Shortage Reason Code"; Rec."Shortage Reason Code")
            {
                ApplicationArea = all;
            }

        }
        addafter("Multiple Subcon. Order Det Nos")
        {
            field("Transportor Nos."; Rec."Transportor Nos.")
            {
                ApplicationArea = ALL;
            }
        }
    }
}

