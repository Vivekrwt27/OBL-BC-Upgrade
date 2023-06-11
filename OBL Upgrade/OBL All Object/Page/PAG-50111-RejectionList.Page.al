page 50111 "Rejection List"
{
    // 1. TRI V.D 30.10.10 - New Form created.

    Editable = false;
    PageType = List;
    SourceTable = "Rejection Purchase Header";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'PO No.';
                    ApplicationArea = All;
                }
                field("Rejection No."; Rec."Rejection No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("MRN No."; Rec."MRN No.")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Name 2"; Rec."Pay-to Name 2")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Address"; Rec."Pay-to Address")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
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
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
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
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
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
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Invoice Disc. Code"; Rec."Invoice Disc. Code")
                {
                    ApplicationArea = All;
                }
                field("Language Code"; Rec."Language Code")
                {
                    ApplicationArea = All;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                }
                field("Order Class"; Rec."Order Class")
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
                field(Receive; Rec.Receive)
                {
                    ApplicationArea = All;
                }
                field(Invoice; Rec.Invoice)
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
                field("Receiving No."; Rec."Receiving No.")
                {
                    ApplicationArea = All;
                }
                field("Posting No."; Rec."Posting No.")
                {
                    ApplicationArea = All;
                }
                field("Last Receiving No."; Rec."Last Receiving No.")
                {
                    ApplicationArea = All;
                }
                field("Last Posting No."; Rec."Last Posting No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
                {
                    ApplicationArea = All;
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
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
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor Name 2"; Rec."Buy-from Vendor Name 2")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    ApplicationArea = All;
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Pay-to County"; Rec."Pay-to County")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ApplicationArea = All;
                }
                field("Buy-from County"; Rec."Buy-from County")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
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
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = All;
                }
                field("Entry Point"; Rec."Entry Point")
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
                /*field(Area;Area)
        {
        }*/ // 15578
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
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
                field("Receiving No. Series"; Rec."Receiving No. Series")
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
                field("Buy-from IC Partner Code"; Rec."Buy-from IC Partner Code")
                {
                    ApplicationArea = All;
                }
                field("Pay-to IC Partner Code"; Rec."Pay-to IC Partner Code")
                {
                    ApplicationArea = All;
                }
                field("IC Direction"; Rec."IC Direction")
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
                field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Completely Received"; Rec."Completely Received")
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
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ApplicationArea = All;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                }
                field("Date Filter"; Rec."Date Filter")
                {
                    ApplicationArea = All;
                }
                field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    ApplicationArea = All;
                }
                field("Return Shipment No."; Rec."Return Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Return Shipment No. Series"; Rec."Return Shipment No. Series")
                {
                    ApplicationArea = All;
                }
                field(Ship; Rec.Ship)
                {
                    ApplicationArea = All;
                }
                field("Last Return Shipment No."; Rec."Last Return Shipment No.")
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
                field("Excise Bus. Posting Group"; Rec."Excise Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Amount to Vendor"; Rec."Amount to Vendor")
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
                }
                field("LC No."; Rec."LC No.")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field(Structure; Rec.Structure)
                {
                    ApplicationArea = All;
                }
                field(Subcontracting; Rec.Subcontracting)
                {
                    ApplicationArea = All;
                }
                field("Subcon. Order No."; Rec."Subcon. Order No.")
                {
                    ApplicationArea = All;
                }
                field("Subcon. Order Line No."; Rec."Subcon. Order Line No.")
                {
                    ApplicationArea = All;
                }
                field(SubConPostLine; Rec.SubConPostLine)
                {
                    ApplicationArea = All;
                }
                field("Vendor Shipment Date"; Rec."Vendor Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("C Form"; Rec."C Form")
                {
                    ApplicationArea = All;
                }
                field("Consignment Note No."; Rec."Consignment Note No.")
                {
                    ApplicationArea = All;
                }
                field("Declaration Form (GTA)"; Rec."Declaration Form (GTA)")
                {
                    ApplicationArea = All;
                }
                field("GTA Service Type"; Rec."GTA Service Type")
                {
                    ApplicationArea = All;
                }
                field("Manufacturer E.C.C. No."; Rec."Manufacturer E.C.C. No.")
                {
                    ApplicationArea = All;
                }
                field("Manufacturer Name"; Rec."Manufacturer Name")
                {
                    ApplicationArea = All;
                }
                field("Manufacturer Address"; Rec."Manufacturer Address")
                {
                    ApplicationArea = All;
                }
                field(Trading; Rec.Trading)
                {
                    ApplicationArea = All;
                }
                field("Transaction No. Serv. Tax"; Rec."Transaction No. Serv. Tax")
                {
                    ApplicationArea = All;
                }
                field(CVD; Rec.CVD)
                {
                    ApplicationArea = All;
                }
                field("Input Service Distribution"; Rec."Input Service Distribution")
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
                }
                field(Deleted; Rec.Deleted)
                {
                    ApplicationArea = All;
                }
                field("New Status"; Rec."New Status")
                {
                    ApplicationArea = All;
                }
                field("RFQ No."; Rec."RFQ No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Classification"; Rec."Vendor Classification")
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
                field("Value of Order"; Rec."Value of Order")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
                {
                    ApplicationArea = All;
                }
                field("Document Received from Bank"; Rec."Document Received from Bank")
                {
                    ApplicationArea = All;
                }
                field("Document Receiving Date"; Rec."Document Receiving Date")
                {
                    ApplicationArea = All;
                }
                field("Main Location"; Rec."Main Location")
                {
                    ApplicationArea = All;
                }
                field("GE No."; Rec."GE No.")
                {
                    ApplicationArea = All;
                }
                field("Transporter's Code"; Rec."Transporter's Code")
                {
                    ApplicationArea = All;
                }
                field("Quotation No."; Rec."Quotation No.")
                {
                    ApplicationArea = All;
                }
                field("State Desc."; Rec."State Desc.")
                {
                    ApplicationArea = All;
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ApplicationArea = All;
                }
                field("Delivery Period"; Rec."Delivery Period")
                {
                    ApplicationArea = All;
                }
                field("Form 31 Amount"; Rec."Form 31 Amount")
                {
                    ApplicationArea = All;
                }
                field("Currency Code 1"; Rec."Currency Code 1")
                {
                    ApplicationArea = All;
                }
                field("Terms of Delivery"; Rec."Terms of Delivery")
                {
                    ApplicationArea = All;
                }
                field("Capital PO"; Rec."Capital PO")
                {
                    ApplicationArea = All;
                }
                field("Ordered Qty"; Rec."Ordered Qty")
                {
                    ApplicationArea = All;
                }
                field("Total Recd. Quantity"; Rec."Total Recd. Quantity")
                {
                    ApplicationArea = All;
                }
                field("Locked Order"; Rec."Locked Order")
                {
                    ApplicationArea = All;
                }
                field("Delivary Date"; Rec."Delivary Date")
                {
                    ApplicationArea = All;
                }
                field("Shortage CRN"; Rec."Shortage CRN")
                {
                    ApplicationArea = All;
                }
                field(Rejected; Rec.Rejected)
                {
                    ApplicationArea = All;
                }
                field("Date Received"; Rec."Date Received")
                {
                    ApplicationArea = All;
                }
                field("Time Received"; Rec."Time Received")
                {
                    ApplicationArea = All;
                }
                field("BizTalk Purchase Quote"; Rec."BizTalk Purchase Quote")
                {
                    ApplicationArea = All;
                }
                field("BizTalk Purch. Order Cnfmn."; Rec."BizTalk Purch. Order Cnfmn.")
                {
                    ApplicationArea = All;
                }
                field("BizTalk Purchase Invoice"; Rec."BizTalk Purchase Invoice")
                {
                    ApplicationArea = All;
                }
                field("BizTalk Purchase Receipt"; Rec."BizTalk Purchase Receipt")
                {
                    ApplicationArea = All;
                }
                field("BizTalk Purchase Credit Memo"; Rec."BizTalk Purchase Credit Memo")
                {
                    ApplicationArea = All;
                }
                field("Date Sent"; Rec."Date Sent")
                {
                    ApplicationArea = All;
                }
                field("Time Sent"; Rec."Time Sent")
                {
                    ApplicationArea = All;
                }
                field("BizTalk Request for Purch. Qte"; Rec."BizTalk Request for Purch. Qte")
                {
                    ApplicationArea = All;
                }
                field("BizTalk Purchase Order"; Rec."BizTalk Purchase Order")
                {
                    ApplicationArea = All;
                }
                field("Vendor Quote No."; Rec."Vendor Quote No.")
                {
                    ApplicationArea = All;
                }
                field("BizTalk Document Sent"; Rec."BizTalk Document Sent")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Reject Card")
                {
                    Caption = 'Reject Card';
                    RunObject = Page "Reject Note";
                    RunPageLink = "Rejection No." = FIELD("Rejection No.");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
            }
        }
    }
}

