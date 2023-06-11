pageextension 50270 pageextension50270 extends "Location Card"
{
    layout
    {

        addafter(Contact)
        {
            field("Location Dimension"; Rec."Location Dimension")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("Main Location"; Rec."Main Location")
            {
                ApplicationArea = All;
            }
            field(Comment; Rec.Comment)
            {
                ApplicationArea = All;
            }
            field("Is COCO"; Rec."Is COCO")
            {
                ApplicationArea = All;
            }
            field("C.S.T. No."; Rec."C.S.T. No.")
            {
                ApplicationArea = all;
            }
            field("Detail of Contact Person"; Rec."Detail of Contact Person")
            {
                ApplicationArea = All;
            }
            field("Bank Name"; Rec."Bank Name")
            {
                ApplicationArea = all;
            }
            field("Bank Account No."; Rec."Bank Account No.")
            {
                ApplicationArea = all;
            }
            field("Bank Branch No."; Rec."Bank Branch No.")
            {
                ApplicationArea = all;
            }
            field("Excisable Location"; Rec."Excisable Location")
            {
                ApplicationArea = all;
            }

            field("Name 2"; Rec."Name 2")
            {
                ApplicationArea = All;
            }
        }
        addafter("Use As In-Transit")
        {
            field("Form Code"; Rec."Form Code")
            {
                ApplicationArea = All;
            }
            field(Structure; Rec.Structure)
            {
                ApplicationArea = All;
            }
            field("Warehouse Location"; Rec."Warehouse Location")
            {
                ShowCaption = false;
                ApplicationArea = All;
            }
            field("Customer Price Group"; Rec."Customer Price Group")
            {
                ApplicationArea = All;
            }
            field(Pay; Rec.Pay)
            {
                ApplicationArea = All;
            }
            field("Not Required"; Rec."Not Required")
            {
                ApplicationArea = all;
            }
            field("Delete Reservation Before Days"; Rec."Delete Reservation Before Days")
            {
                ApplicationArea = all;
            }

            field("Production Plant Code"; Rec."Production Plant Code")
            {
                ApplicationArea = All;
            }
            field("State Code Desc"; Rec."State Code Desc")
            {
                ApplicationArea = all;
            }
            field("COCO DEPO"; Rec."COCO DEPO")
            {
                ApplicationArea = All;
            }
            field("Production Location"; Rec."Production Location")
            {
                ApplicationArea = all;
            }
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("No. Series"; Rec."No. Series")
            {
                ApplicationArea = All;
            }
            field("Shipment No. Series"; Rec."Shipment No. Series")
            {
                ApplicationArea = All;
            }

            field("Budget No. Series (Regular)"; Rec."Budget No. Series (Regular)")
            {
                ApplicationArea = all;
            }
            field("Budget Posting No. Series"; rec."Budget Posting No. Series")
            {
                ApplicationArea = all;
            }
            field("Budget No. Series (Non-Regula)"; Rec."Budget No. Series (Non-Regula)")
            {
                ApplicationArea = all;
            }
            field("Budget No. Series(Disposal)"; Rec."Budget No. Series(Disposal)")
            {
                ApplicationArea = all;
            }
            field("Bud. No. Post Series(Disposal)"; Rec."Bud. No. Post Series(Disposal)")
            {
                ApplicationArea = all;
            }

            field("Customer Price Group(Project)"; Rec."Customer Price Group(Project)")
            {
                ApplicationArea = All;
            }
            field("Plant Code"; Rec."Plant Code")
            {
                ApplicationArea = All;
            }
            field(Depot; Rec.Depot)
            {
                ApplicationArea = all;
            }
            field("AD Applicable"; Rec."AD Applicable")
            {
                ShowCaption = false;
                ApplicationArea = All;
            }
            field("Transfer Price List"; Rec."Transfer Price List")
            {
                ApplicationArea = All;
            }
            field("Auto Indent Creation ID"; Rec."Auto Indent Creation ID")
            {
                ApplicationArea = all;
            }
            field("Last Date Modified"; Rec."Last Date Modified")
            {
                ApplicationArea = all;
            }
            field("Prod. Units"; Rec."Prod. Units")
            {
                ApplicationArea = all;
            }
            field("Sales Territory"; Rec."Sales Territory")
            {
                ApplicationArea = all;
            }
            field("Area"; Rec."Area")
            {
                ApplicationArea = all;
            }
            field(ZH; Rec.ZH)
            {
                ApplicationArea = all;
            }
            field(PCH; Rec.PCH)
            {
                ApplicationArea = all;
            }
            field(stores; Rec.stores)
            {
                ApplicationArea = all;
            }
            field("Store Location"; Rec."Store Location")
            {
                ApplicationArea = all;
            }
            field("Location Name"; Rec."Location Name")
            {
                ApplicationArea = all;
            }
            field("Pin Code"; Rec."Pin Code")
            {
                ApplicationArea = all;
            }
            field(Blocked; Rec.Blocked)
            {
                ApplicationArea = all;
            }
            field("Tableau Location"; Rec."Tableau Location")
            {
                ApplicationArea = all;
            }
            field(IEC; Rec.IEC)
            {
                ApplicationArea = all;
            }
        }
        addafter("Phone No.")
        {
            field("Contact Name"; Rec."Contact Name")
            {
                ApplicationArea = All;
            }
            field("Phone No. 2"; Rec."Phone No. 2")
            {
                ApplicationArea = All;
            }
        }
        moveafter(Pick; "GST Registration No.")
        moveafter(Pick; "GST Liability Invoice")
        moveafter(Pick; "GST Input Service Distributor")

        addafter(Pick)
        {
            field("End Use Item Issue Template"; Rec."End Use Item Issue Template")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("End Use Item Issue Batch"; Rec."End Use Item Issue Batch")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("Production Line"; Rec."Production Line")
            {
                ApplicationArea = all;
            }
            //16225 Field N/F

            /* field("Sales Inv. Nos. (Exempt)"; "Sales Inv. Nos. (Exempt)")
             {
             }
             field("Sales Cr. Memo Nos. (Exempt)"; "Sales Cr. Memo Nos. (Exempt)")
             {
             }
             field("Sales Inv. No. (Export)"; "Sales Inv. No. (Export)")
             {
             }
             field("Sales Cr. Memo No. (Export)"; "Sales Cr. Memo No. (Export)")
             {
             }
             field("Sales Inv. No. (Supp)"; "Sales Inv. No. (Supp)")
             {
             }
             field("Sales Cr. Memo No. (Supp)"; "Sales Cr. Memo No. (Supp)")
             {
             }
             field("Sales Inv. No. (Debit Note)"; "Sales Inv. No. (Debit Note)")
             {
             }
             field("Serv. Inv. Nos. (Exempt)"; "Serv. Inv. Nos. (Exempt)")
             {
             }
             field("Serv. Cr. Memo Nos. (Exempt)"; "Serv. Cr. Memo Nos. (Exempt)")
             {
             }
             field("Serv. Inv. Nos. (Export)"; "Serv. Inv. Nos. (Export)")
             {
             }
             field("Serv. Cr. Memo Nos. (Export)"; "Serv. Cr. Memo Nos. (Export)")
             {
             }
             field("Serv. Inv. Nos. (Supp)"; "Serv. Inv. Nos. (Supp)")
             {
             }
             field("Serv. Cr. Memo Nos. (Supp)"; "Serv. Cr. Memo Nos. (Supp)")
             {
             }
             field("Serv. Inv. Nos. (Debit Note)"; "Serv. Inv. Nos. (Debit Note)")
             {
             }
             field("Sales Inv. Nos. (Non-GST)"; "Sales Inv. Nos. (Non-GST)")
             {
             }
             field("Sales Cr. Memo Nos. (Non-GST)"; "Sales Cr. Memo Nos. (Non-GST)")
             {
             }
             field("Posted Serv. Trans. Shpt. Nos."; "Posted Serv. Trans. Shpt. Nos.")
             {
             }
             field("Posted Serv. Trans. Rcpt. Nos."; "Posted Serv. Trans. Rcpt. Nos.")
             {
             }*/

        }
        addafter("Composition Type")
        {
            field("U.P.T.T. No."; Rec."U.P.T.T. No.")
            {
                ApplicationArea = All;
            }
            field("Related Location Code"; Rec."Related Location Code")
            {
                ApplicationArea = all;
            }
            group("E-Invoice")
            {
                field("E-InvAuthenticateURL"; Rec."E-InvAuthenticateURL")
                {
                    ApplicationArea = All;
                }
                field("E-InvGenerateURL"; Rec."E-InvGenerateURL")
                {
                    ApplicationArea = All;
                }
                field("E-InvCancelURL"; Rec."E-InvCancelURL")
                {
                    ApplicationArea = All;
                }
                field("E-InvPrintURL"; Rec."E-InvPrintURL")
                {
                    ApplicationArea = All;
                }
                field(Username; Rec.Username)
                {
                    ApplicationArea = All;
                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                }
                field(apiaccesskey; Rec.apiaccesskey)
                {
                    ApplicationArea = All;
                }
                field("Local CP Count"; Rec."Local CP Count")
                {
                    ApplicationArea = all;
                }
                field("Pan India CP Count"; Rec."Pan India CP Count")
                {
                    ApplicationArea = all;
                }
                field("Local Sales Target"; Rec."Local Sales Target")
                {
                    ApplicationArea = all;
                }
                field("Pan India Sales Target"; Rec."Pan India Sales Target")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}

