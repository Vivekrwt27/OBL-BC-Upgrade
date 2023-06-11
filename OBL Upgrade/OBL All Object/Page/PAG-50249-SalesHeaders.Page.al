page 50249 "Sales Headers"
{
    PageType = List;
    Permissions = TableData "Sales Header" = rimd;
    SourceTable = "Sales Header";
    UsageCategory = Lists;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Name 2"; Rec."Bill-to Name 2")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name 2"; Rec."Ship-to Name 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ApplicationArea = All;
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ApplicationArea = All;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Invoice Disc. Code"; Rec."Invoice Disc. Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    ApplicationArea = All;
                }
                field("Language Code"; Rec."Language Code")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ApplicationArea = All;
                }
                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = All;
                }
                field("Recalculate Invoice Disc."; Rec."Recalculate Invoice Disc.")
                {
                    ApplicationArea = All;
                }
                field(Ship; Rec.Ship)
                {
                    ApplicationArea = All;
                }
                field(Invoice; Rec.Invoice)
                {
                    ApplicationArea = All;
                }
                field("Print Posted Documents"; Rec."Print Posted Documents")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Shipping No."; Rec."Shipping No.")
                {
                    ApplicationArea = All;
                }
                field("Posting No."; Rec."Posting No.")
                {
                    ApplicationArea = All;
                }
                field("Last Shipping No."; Rec."Last Shipping No.")
                {
                    ApplicationArea = All;
                }
                field("Last Posting No."; Rec."Last Posting No.")
                {
                    ApplicationArea = All;
                }
                field("Prepayment No."; Rec."Prepayment No.")
                {
                    ApplicationArea = All;
                }
                field("Last Prepayment No."; Rec."Last Prepayment No.")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Cr. Memo No."; Rec."Prepmt. Cr. Memo No.")
                {
                    ApplicationArea = All;
                }
                field("Last Prepmt. Cr. Memo No."; Rec."Last Prepmt. Cr. Memo No.")
                {
                    ApplicationArea = All;
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                }
                field("Combine Shipments"; Rec."Combine Shipments")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("VAT Country/Region Code"; Rec."VAT Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Bill-to County"; Rec."Bill-to County")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Sell-to County"; Rec."Sell-to County")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to County"; Rec."Ship-to County")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = All;
                }
                field(Correction; Rec.Correction)
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field(Area1; Rec.Area)
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ApplicationArea = All;
                }
                field("Shipping No. Series"; Rec."Shipping No. Series")
                {
                    ApplicationArea = All;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Reserve; Rec.Reserve)
                {
                    ApplicationArea = All;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = All;
                }
                field("VAT Base Discount %"; Rec."VAT Base Discount %")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Invoice Discount Calculation"; Rec."Invoice Discount Calculation")
                {
                    ApplicationArea = All;
                }
                field("Invoice Discount Value"; Rec."Invoice Discount Value")
                {
                    ApplicationArea = All;
                }
                field("Send IC Document"; Rec."Send IC Document")
                {
                    ApplicationArea = All;
                }
                field("IC Status"; Rec."IC Status")
                {
                    ApplicationArea = All;
                }
                field("Sell-to IC Partner Code"; Rec."Sell-to IC Partner Code")
                {
                    ApplicationArea = All;
                }
                field("Bill-to IC Partner Code"; Rec."Bill-to IC Partner Code")
                {
                    ApplicationArea = All;
                }
                field("IC Direction"; Rec."IC Direction")
                {
                    ApplicationArea = All;
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = All;
                }
                field("Prepayment No. Series"; Rec."Prepayment No. Series")
                {
                    ApplicationArea = All;
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Due Date"; Rec."Prepayment Due Date")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Cr. Memo No. Series"; Rec."Prepmt. Cr. Memo No. Series")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Posting Description"; Rec."Prepmt. Posting Description")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = All;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                }
                field("Job Queue Entry ID"; Rec."Job Queue Entry ID")
                {
                    ApplicationArea = All;
                }
                field("Incoming Document Entry No."; Rec."Incoming Document Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                /*  field("Authorization Required"; Rec."Authorization Required")
                  {
                      ApplicationArea = All;
                  }
                  field("Credit Card No."; Rec."Credit Card No.")
                  {
                      ApplicationArea = All;
                  }*/
                field("Direct Debit Mandate ID"; Rec."Direct Debit Mandate ID")
                {
                    ApplicationArea = All;
                }
                field("Invoice Discount Amount"; Rec."Invoice Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ApplicationArea = All;
                }
                field("Doc. No. Occurrence"; Rec."Doc. No. Occurrence")
                {
                    ApplicationArea = All;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = All;
                }
                //  field("Sell-to Customer Template Code"; Rec."Sell-to Customer Template Code")
                //{
                //  ApplicationArea = All;
                //}
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    ApplicationArea = All;
                }
                //  field("Bill-to Customer Template Code"; Rec."Bill-to Customer Template Code")
                //{
                //  ApplicationArea = All;
                //}
                field("Opportunity No."; Rec."Opportunity No.")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                }
                field("Shipped Not Invoiced"; Rec."Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Completely Shipped"; Rec."Completely Shipped")
                {
                    ApplicationArea = All;
                }
                field("Posting from Whse. Ref."; Rec."Posting from Whse. Ref.")
                {
                    ApplicationArea = All;
                }
                field("Location Filter"; Rec."Location Filter")
                {
                    ApplicationArea = All;
                }
                field(Shipped; Rec.Shipped)
                {
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                }
                field("Late Order Shipping"; Rec."Late Order Shipping")
                {
                    ApplicationArea = All;
                }
                field("Date Filter"; Rec."Date Filter")
                {
                    ApplicationArea = All;
                }
                field(Receive; Rec.Receive)
                {
                    ApplicationArea = All;
                }
                field("Return Receipt No."; Rec."Return Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Return Receipt No. Series"; Rec."Return Receipt No. Series")
                {
                    ApplicationArea = All;
                }
                field("Last Return Receipt No."; Rec."Last Return Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    ApplicationArea = All;
                }
                field("Get Shipment Used"; Rec."Get Shipment Used")
                {
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field("Assessee Code"; Rec."Assessee Code")
                {
                    ApplicationArea = All;
                }
                /* field("Excise Bus. Posting Group"; Rec."Excise Bus. Posting Group")
                 {
                     ApplicationArea = All;
                 }
                 field("Amount to Customer"; Rec."Amount to Customer")
                 {
                     ApplicationArea = All;
                 }
                 field("Bill to Customer State"; Rec."Bill to Customer State")
                 {
                     ApplicationArea = All;
                 }
                 field("Form Code"; Rec."Form Code")
                 {
                     ApplicationArea = All;
                 }
                 field("Form No."; Rec."Form No.")
                 {
                     ApplicationArea = All;
                 }
                 field("Transit Document"; Rec."Transit Document")
                 {
                     ApplicationArea = All;
                 }*/
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                /* field("LC No."; Rec."LC No.")
                 {
                     ApplicationArea = All;
                 }
                 field(Structure; Rec.Structure)
                 {
                     ApplicationArea = All;
                 }
                 field("Free Supply"; Rec."Free Supply")
                 {
                     ApplicationArea = All;
                 }
                 field("Export or Deemed Export"; Rec."Export or Deemed Export")
                 {
                     ApplicationArea = All;
                 }
                 field("VAT Exempted"; Rec."VAT Exempted")
                 {
                     ApplicationArea = All;
                 }*/
                field(Trading; Rec.Trading)
                {
                    ApplicationArea = All;
                }
                /*field("Transaction No. Serv. Tax"; Rec."Transaction No. Serv. Tax")
                {
                    ApplicationArea = All;
                }
                field("Re-Dispatch"; Rec."Re-Dispatch")
                {
                    ApplicationArea = All;
                }
                field("Return Re-Dispatch Rcpt. No."; Rec."Return Re-Dispatch Rcpt. No.")
                {
                    ApplicationArea = All;
                }*/
                field("TDS Certificate Receivable"; Rec."TDS Certificate Receivable")
                {
                    ApplicationArea = All;
                }
                /*   field("Price Inclusive of Taxes"; Rec."Price Inclusive of Taxes")
                   {
                       ApplicationArea = All;
                   }
                   field("Calc. Inv. Discount (%)"; Rec."Calc. Inv. Discount (%)")
                   {
                       ApplicationArea = All;
                   }*/
                field("Time of Removal"; Rec."Time of Removal")
                {
                    ApplicationArea = All;
                }
                field("LR/RR No."; Rec."LR/RR No.")
                {
                    ApplicationArea = All;
                }
                field("LR/RR Date"; Rec."LR/RR Date")
                {
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                }
                field("Mode of Transport"; Rec."Mode of Transport")
                {
                    ApplicationArea = All;
                }
                /* field("ST Pure Agent"; Rec."ST Pure Agent")
                 {
                     ApplicationArea = All;
                 }
                 field("Nature of Services"; Rec."Nature of Services")
                 {
                     ApplicationArea = All;
                 }
                 field("Service Tax Rounding Precision"; Rec."Service Tax Rounding Precision")
                 {
                     ApplicationArea = All;
                 }
                 field("Service Tax Rounding Type"; Rec."Service Tax Rounding Type")
                 {
                     ApplicationArea = All;
                 }*/
                field("Sale Return Type"; Rec."Sale Return Type")
                {
                    ApplicationArea = All;
                }
                /* field(PoT; Rec.PoT)
                 {
                     ApplicationArea = All;
                 }*/
                field("Nature of Supply"; Rec."Nature of Supply")
                {
                    ApplicationArea = All;
                }
                field("GST Customer Type"; Rec."GST Customer Type")
                {
                    ApplicationArea = All;
                }
                field("GST Without Payment of Duty"; Rec."GST Without Payment of Duty")
                {
                    ApplicationArea = All;
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                    ApplicationArea = All;
                }
                field("Bill Of Export No."; Rec."Bill Of Export No.")
                {
                    ApplicationArea = All;
                }
                field("Bill Of Export Date"; Rec."Bill Of Export Date")
                {
                    ApplicationArea = All;
                }
                field("e-Commerce Customer"; Rec."e-Commerce Customer")
                {
                    ApplicationArea = All;
                }
                field("e-Commerce Merchant Id"; Rec."e-Commerce Merchant Id")
                {
                    ApplicationArea = All;
                }
                field("GST Bill-to State Code"; Rec."GST Bill-to State Code")
                {
                    ApplicationArea = All;
                }
                field("GST Ship-to State Code"; Rec."GST Ship-to State Code")
                {
                    ApplicationArea = All;
                }
                field("Location State Code"; Rec."Location State Code")
                {
                    ApplicationArea = All;
                }
                /*field("GST Inv. Rounding Precision"; Rec."GST Inv. Rounding Precision")
                {
                    ApplicationArea = All;
                }
                field("GST Inv. Rounding Type"; Rec."GST Inv. Rounding Type")
                {
                    ApplicationArea = All;
                }*/
                field("GST Reason Type"; Rec."GST Reason Type")
                {
                    ApplicationArea = All;
                }
                field("Location GST Reg. No."; Rec."Location GST Reg. No.")
                {
                    ApplicationArea = All;
                }
                field("Customer GST Reg. No."; Rec."Customer GST Reg. No.")
                {
                    ApplicationArea = All;
                }
                field("Ship-to GST Reg. No."; Rec."Ship-to GST Reg. No.")
                {
                    ApplicationArea = All;
                }
                field("Distance (Km)"; Rec."Distance (Km)")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                    ApplicationArea = All;
                }
                field("Reference Invoice No."; Rec."Reference Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("E-Way Bill No."; Rec."E-Way Bill No.")
                {
                    ApplicationArea = All;
                }
                field("Supply Finish Date"; Rec."Supply Finish Date")
                {
                    ApplicationArea = All;
                }
                /*field("Payment Date Base"; Rec."Payment Date Base")
                {
                    ApplicationArea = All;
                }*/
                field("Rate Change Applicable"; Rec."Rate Change Applicable")
                {
                    ApplicationArea = All;
                }
                field("POS Out Of India"; Rec."POS Out Of India")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Customer"; Rec."Ship-to Customer")
                {
                    ApplicationArea = All;
                }
                field("Ship-to GST Customer Type"; Rec."Ship-to GST Customer Type")
                {
                    ApplicationArea = All;
                }
                field(Deleted; Rec.Deleted)
                {
                    ApplicationArea = All;
                }
                field("New Status"; Rec."New Status")
                {
                    ApplicationArea = All;
                }
                field("Locked Order"; Rec."Locked Order")
                {
                    ApplicationArea = All;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = All;
                }
                field("Security Amount"; Rec."Security Amount")
                {
                    ApplicationArea = All;
                }
                field("Security Date"; Rec."Security Date")
                {
                    ApplicationArea = All;
                }
                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;
                }
                field("Transporter's Name"; Rec."Transporter's Name")
                {
                    ApplicationArea = All;
                }
                field("GR No."; Rec."GR No.")
                {
                    ApplicationArea = All;
                }
                field("Truck No."; Rec."Truck No.")
                {
                    ApplicationArea = All;
                }
                field("Loading Inspector"; Rec."Loading Inspector")
                {
                    ApplicationArea = All;
                }
                field("GR Date"; Rec."GR Date")
                {
                    ApplicationArea = All;
                }
                field("Insurance Amount"; Rec."Insurance Amount")
                {
                    ApplicationArea = All;
                }
                field("Foreign Commission Agent"; Rec."Foreign Commission Agent")
                {
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Entry Date"; Rec."Entry Date")
                {
                    ApplicationArea = All;
                }
                field("Main Location"; Rec."Main Location")
                {
                    ApplicationArea = All;
                }
                field("Shipment Status"; Rec."Shipment Status")
                {
                    ApplicationArea = All;
                }
                field("Qty in Sq. Mt."; Rec."Qty in Sq. Mt.")
                {
                    ApplicationArea = All;
                }
                field("Net Wt."; Rec."Net Wt.")
                {
                    ApplicationArea = All;
                }
                field("Gross Wt."; Rec."Gross Wt.")
                {
                    ApplicationArea = All;
                }
                field("State Desc."; Rec."State Desc.")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Description"; Rec."Salesperson Description")
                {
                    ApplicationArea = All;
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Qty. To Ship"; Rec."Qty. To Ship")
                {
                    ApplicationArea = All;
                }
                field("Ocean Freight"; Rec."Ocean Freight")
                {
                    ApplicationArea = All;
                }
                field("No. of Containers"; Rec."No. of Containers")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms"; Rec."Payment Terms")
                {
                    ApplicationArea = All;
                }
                field("LC Number"; Rec."LC Number")
                {
                    ApplicationArea = All;
                }
                field("Currency Code 1"; Rec."Currency Code 1")
                {
                    ApplicationArea = All;
                }
                field("Dealer Code"; Rec."Dealer Code")
                {
                    ApplicationArea = All;
                }
                field("Dealer's Salesperson Code"; Rec."Dealer's Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Quote Date"; Rec."Quote Date")
                {
                    ApplicationArea = All;
                }
                field("Releasing Date"; Rec."Releasing Date")
                {
                    ApplicationArea = All;
                }
                field("Releasing Time"; Rec."Releasing Time")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Abatement Required"; Rec."Abatement Required")
                {
                    ApplicationArea = All;
                }
                field("Sales Type"; Rec."Sales Type")
                {
                    ApplicationArea = All;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field("Group Code Check"; Rec."Group Code Check")
                {
                    ApplicationArea = All;
                }
                field(Pay; Rec.Pay)
                {
                    ApplicationArea = All;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("Archive Version"; Rec."Archive Version")
                {
                    ApplicationArea = All;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = All;
                }
                field("Date of Release"; Rec."Date of Release")
                {
                    ApplicationArea = All;
                }
                field("Time of Release"; Rec."Time of Release")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Releaser ID"; Rec."Releaser ID")
                {
                    ApplicationArea = All;
                }
                field("Opener ID"; Rec."Opener ID")
                {
                    ApplicationArea = All;
                }
                field("Date of Reopen"; Rec."Date of Reopen")
                {
                    ApplicationArea = All;
                }
                field("Time of Reopen"; Rec."Time of Reopen")
                {
                    ApplicationArea = All;
                }
                field("Sales Order No"; Rec."Sales Order No")
                {
                    ApplicationArea = All;
                }
                field("Discount Charges %"; Rec."Discount Charges %")
                {
                    ApplicationArea = All;
                }
                field("Canceller ID"; Rec."Canceller ID")
                {
                    ApplicationArea = All;
                }
                field("Cancellation Time"; Rec."Cancellation Time")
                {
                    ApplicationArea = All;
                }
                field("Blanket Order No. Series"; Rec."Blanket Order No. Series")
                {
                    ApplicationArea = All;
                }
                field("Tax Registration No."; Rec."Tax Registration No.")
                {
                    ApplicationArea = All;
                }
                field("Inter Company"; Rec."Inter Company")
                {
                    ApplicationArea = All;
                }
                field("Direct Open Order"; Rec."Direct Open Order")
                {
                    ApplicationArea = All;
                }
                field("Old Order for Post"; Rec."Old Order for Post")
                {
                    ApplicationArea = All;
                }
                field("State Description"; Rec."State Description")
                {
                    ApplicationArea = All;
                }
                field(COCO; Rec.COCO)
                {
                    ApplicationArea = All;
                }
                field("Elite Solution"; Rec."Elite Solution")
                {
                    ApplicationArea = All;
                }
                field("COCO Store"; Rec."COCO Store")
                {
                    ApplicationArea = All;
                }
                field("Make Order Date"; Rec."Make Order Date")
                {
                    ApplicationArea = All;
                }
                field("Order Created ID"; Rec."Order Created ID")
                {
                    ApplicationArea = All;
                }
                field("RELEASING DATETIME"; Rec."RELEASING DATETIME")
                {
                    ApplicationArea = All;
                }
                field("Order Date Time"; Rec."Order Date Time")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                    ApplicationArea = All;
                }
                field("Reserved Qty(CRT)"; Rec."Reserved Qty(CRT)")
                {
                    ApplicationArea = All;
                }
                field("Reserved Qty(SQM)"; Rec."Reserved Qty(SQM)")
                {
                    ApplicationArea = All;
                }
                field("C-Form Date"; Rec."C-Form Date")
                {
                    ApplicationArea = All;
                }
                field("TPT Method"; Rec."TPT Method")
                {
                    ApplicationArea = All;
                }
                field("Email ID"; Rec."Email ID")
                {
                    ApplicationArea = All;
                }
                field("Calculate Discount"; Rec."Calculate Discount")
                {
                    ApplicationArea = All;
                }
                field("Transporter Code"; Rec."Transporter Code")
                {
                    ApplicationArea = All;
                }
                field("ORC Terms"; Rec."ORC Terms")
                {
                    ApplicationArea = All;
                }
                field("Excise Structure"; Rec."Excise Structure")
                {
                    ApplicationArea = All;
                }
                field("Add Insu Discount"; Rec."Add Insu Discount")
                {
                    ApplicationArea = All;
                }
                field("GR Value"; Rec."GR Value")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Outstanding Qty"; Rec."Outstanding Qty")
                {
                    ApplicationArea = All;
                }
                field(Selection1; Rec.Selection1)
                {
                    ApplicationArea = All;
                }
                field("PCH Code"; Rec."PCH Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Govt./Private Sales Person"; Rec."Govt./Private Sales Person")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 8 Code"; Rec."Shortcut Dimension 8 Code")
                {
                    ApplicationArea = All;
                }
                field("Reserved Qty"; Rec."Reserved Qty")
                {
                    ApplicationArea = All;
                }
                field("Order Booked Date"; Rec."Order Booked Date")
                {
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                }
                field("Confirmed Desc"; Rec."Confirmed Desc")
                {
                    ApplicationArea = All;
                }
                field("Despatch Remarks"; Rec."Despatch Remarks")
                {
                    ApplicationArea = All;
                }
                field(Commitment; Rec.Commitment)
                {
                    ApplicationArea = All;
                }
                field("Payment Date 3"; Rec."Payment Date 3")
                {
                    ApplicationArea = All;
                }
                field("Trade Discount"; Rec."Trade Discount")
                {
                    ApplicationArea = All;
                }
                field(BD; Rec.BD)
                {
                    ApplicationArea = All;
                }
                field(GPS; Rec.GPS)
                {
                    ApplicationArea = All;
                }
                field(None; Rec.None)
                {
                    ApplicationArea = All;
                }
                field("Business Development"; Rec."Business Development")
                {
                    ApplicationArea = All;
                }
                field("Govt. Project Sales"; Rec."Govt. Project Sales")
                {
                    ApplicationArea = All;
                }
                field("Gross Wt (Ship)"; Rec."Gross Wt (Ship)")
                {
                    ApplicationArea = All;
                }
                field("Tonnage of Vehicle placed"; Rec."Tonnage of Vehicle placed")
                {
                    ApplicationArea = All;
                }
                field("Driver Phone No."; Rec."Driver Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                }
                field("Estimated Date of Arrival"; Rec."Estimated Date of Arrival")
                {
                    ApplicationArea = All;
                }
                field("Transport Punch Date"; Rec."Transport Punch Date")
                {
                    ApplicationArea = All;
                }
                field("No. of Vehicle Notification"; Rec."No. of Vehicle Notification")
                {
                    ApplicationArea = All;
                }
                field("D1 Amount"; Rec."D1 Amount")
                {
                    ApplicationArea = All;
                }
                field("D2 Amount"; Rec."D2 Amount")
                {
                    ApplicationArea = All;
                }
                field("D3 Amount"; Rec."D3 Amount")
                {
                    ApplicationArea = All;
                }
                field("D4 Amount"; Rec."D4 Amount")
                {
                    ApplicationArea = All;
                }
                field("Approval Pending At"; Rec."Approval Pending At")
                {
                    ApplicationArea = All;
                }
                field("S1 Amount"; Rec."S1 Amount")
                {
                    ApplicationArea = All;
                }
                field("D6 Amount"; Rec."D6 Amount")
                {
                    ApplicationArea = All;
                }
                field("CD Applicable"; Rec."CD Applicable")
                {
                    ApplicationArea = All;
                }
                field("Approval Required"; Rec."Approval Required")
                {
                    ApplicationArea = All;
                }
                field("Secondry Sales Person"; Rec."Secondry Sales Person")
                {
                    ApplicationArea = All;
                }
                field("CD Available for Utilisation"; Rec."CD Available for Utilisation")
                {
                    ApplicationArea = All;
                }
                field("CD Availed from Utilisation"; Rec."CD Availed from Utilisation")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                }
                field("Contribution Percentage"; Rec."Contribution Percentage")
                {
                    ApplicationArea = All;
                }
                field(CKA; Rec.CKA)
                {
                    ApplicationArea = All;
                }
                field("CKA Code"; Rec."CKA Code")
                {
                    ApplicationArea = All;
                }
                field(Retail; Rec.Retail)
                {
                    ApplicationArea = All;
                }
                field("Retail Code"; Rec."Retail Code")
                {
                    ApplicationArea = All;
                }
                field("Ship to Pin"; Rec."Ship to Pin")
                {
                    ApplicationArea = All;
                }
                field("ZH Code"; Rec."ZH Code")
                {
                    ApplicationArea = All;
                }
                field("PMT Code"; Rec."PMT Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer No."; Rec."Transfer No.")
                {
                    ApplicationArea = All;
                }
                field("Loading Copies"; Rec."Loading Copies")
                {
                    ApplicationArea = All;
                }
                field("Order Change Remarks"; Rec."Order Change Remarks")
                {
                    ApplicationArea = All;
                }
                field("TCS On Collection Entry"; Rec."TCS On Collection Entry")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

