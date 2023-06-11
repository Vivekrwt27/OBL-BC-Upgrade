pageextension 50465 "EXTCustomer Lookup" extends "Customer Lookup"
{
    layout
    {
        movebefore(Name; City, Address, "Responsibility Center", "Customer Price Group", "Gen. Bus. Posting Group", "Last Date Modified", "Post Code", Reserve, "Salesperson Code", "Customer Posting Group")
        addafter(Name)
        {

            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = all;
            }
            field("GST Registration No."; Rec."GST Registration No.")
            {
                ApplicationArea = all;
            }
            field("PCH Name"; Rec."PCH Name")
            {
                ApplicationArea = all;
            }
            field("Salesperson Description"; Rec."Salesperson Description")
            {
                ApplicationArea = all;
            }
            field("Pin Code"; Rec."Pin Code")
            {
                ApplicationArea = all;
            }
            field("Customer Status"; Rec."Customer Status")
            {
                ApplicationArea = all;
            }
            field("Credit Rating"; Rec."Credit Rating")
            {
                ApplicationArea = all;
            }
            field("Parent Customer No."; Rec."Parent Customer No.")
            {
                ApplicationArea = all;
            }
            field("Sales Per Mob"; Rec."Sales Per Mob")
            {
                ApplicationArea = all;
            }

            field("CF Limit"; Rec."CF Limit")
            {
                ApplicationArea = all;
            }
            field("Coco Customer"; Rec."Coco Customer")
            {
                ApplicationArea = all;
            }
            field("Created By"; Rec."Created By")
            {
                ApplicationArea = all;
            }
            field("Security Cheque 1 A/c No."; Rec."Security Cheque 1 A/c No.")
            {
                ApplicationArea = all;
            }
            field("Dealer File No."; Rec."Dealer File No.")
            {
                ApplicationArea = all;
            }
            field("Private SP Resp."; Rec."Private SP Resp.")
            {
                ApplicationArea = all;
            }
            field("Govt. SP Resp."; Rec."Govt. SP Resp.")
            {
                ApplicationArea = all;
            }
            field("Old TIN"; Rec."Old TIN")
            {
                ApplicationArea = all;
            }
            field("Security Cheque 2 A/c No."; Rec."Security Cheque 2 A/c No.")
            {
                ApplicationArea = all;
            }

            field("Security Cheque 2 Bank Name"; Rec."Security Cheque 2 Bank Name")
            {
                ApplicationArea = all;
            }
            field(Zone; Rec.Zone)
            {
                ApplicationArea = all;
            }
            field("Security Cheque 2"; Rec."Security Cheque 2")
            {
                ApplicationArea = all;
            }

            field("CTS 1"; Rec."CTS 1")
            {
                ApplicationArea = all;
            }
            field("CTS 2"; Rec."CTS 2")
            {
                ApplicationArea = all;
            }

            field("Security Checque Max Limit 1"; Rec."Security Checque Max Limit 1")
            {
                ApplicationArea = all;
            }

            field("Security Checque Max Limit 2"; Rec."Security Checque Max Limit 2")
            {
                ApplicationArea = all;
            }

            field("Bank Account Name"; Rec."Bank Account Name")
            {
                ApplicationArea = all;
            }

            field("Security Cheque 1"; Rec."Security Cheque 1")
            {
                ApplicationArea = all;
            }


            field("Security Chq Availability"; Rec."Security Chq Availability")
            {
                ApplicationArea = all;
            }
            field(Longitude; Rec.Longitude)
            {
                ApplicationArea = all;
            }

            field(Latitude; Rec.Latitude)
            {
                ApplicationArea = all;
            }

            field("SP E-Maill ID"; Rec."SP E-Maill ID")
            {
                ApplicationArea = all;
            }

            field("Sales (LCY)"; Rec."Sales (LCY)")
            {
                ApplicationArea = all;
            }

            field("State Code"; Rec."State Code")
            {
                ApplicationArea = all;
            }
            field("Creation Date"; Rec."Creation Date")
            {
                ApplicationArea = all;
            }

            field("Customer Type"; Rec."Customer Type")
            {
                ApplicationArea = all;
            }

            field("Outstanding Amount"; Rec."Outstanding Amount")
            {
                ApplicationArea = all;
            }

            field("Name 2"; Rec."Name 2")
            {
                ApplicationArea = all;
            }



            field("State Desc."; Rec."State Desc.")
            {
                ApplicationArea = all;
            }

            field("Debit Amount"; Rec."Debit Amount")
            {
                ApplicationArea = all;
            }

            field(Balance; Rec.Balance)
            {
                ApplicationArea = all;
            }

            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = all;
            }

            field("P.A.N. No."; Rec."P.A.N. No.")
            {
                ApplicationArea = all;
            }

            field("P.A.N. Reference No."; Rec."P.A.N. Reference No.")
            {
                ApplicationArea = all;
            }

            field("Security Date"; Rec."Security Date")
            {
                ApplicationArea = all;
            }
            field("Security Amount"; Rec."Security Amount")
            {
                ApplicationArea = all;
            }
            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = all;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = all;
            }
            field("Zonal Head"; Rec."Zonal Head")
            {
                ApplicationArea = all;
            }
            field("Zonal Manager"; Rec."Zonal Manager")
            {
                ApplicationArea = all;
            }
            field("Tableau Zone"; Rec."Tableau Zone")
            {
                ApplicationArea = all;
            }
            field("CXO Target"; Rec."CXO Target")
            {
                ApplicationArea = all;
            }
            field("Aadhaar No."; Rec."Aadhaar No.")
            {
                ApplicationArea = all;
            }
            field("Mother Account Name"; Rec."Mother Account Name")
            {
                ApplicationArea = all;
            }
            field("Virtual ID"; Rec."Virtual ID")
            {
                ApplicationArea = all;
            }
            field("Net Change (LCY)"; Rec."Net Change (LCY)")
            {
                ApplicationArea = all;
            }
            field("Balance (LCY)"; Rec."Balance (LCY)")
            {
                ApplicationArea = all;
            }
            field("Balance Confirmation"; Rec."Balance Confirmation")
            {
                ApplicationArea = all;
            }







        }
    }


    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}