page 50311 transshipment
{
    PageType = List;
    Permissions = TableData "Transfer Shipment Header" = rimd;
    SourceTable = "Transfer Shipment Header";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Code"; rec."Transfer-from Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Name"; rec."Transfer-from Name")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Name 2"; rec."Transfer-from Name 2")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Address"; rec."Transfer-from Address")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Address 2"; rec."Transfer-from Address 2")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Post Code"; rec."Transfer-from Post Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from City"; rec."Transfer-from City")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from County"; rec."Transfer-from County")
                {
                    ApplicationArea = All;
                }
                field("Trsf.-from Country/Region Code"; rec."Trsf.-from Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; rec."Transfer-to Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Name"; rec."Transfer-to Name")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Name 2"; rec."Transfer-to Name 2")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Address"; rec."Transfer-to Address")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Address 2"; rec."Transfer-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Post Code"; rec."Transfer-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to City"; rec."Transfer-to City")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to County"; rec."Transfer-to County")
                {
                    ApplicationArea = All;
                }
                field("Trsf.-to Country/Region Code"; rec."Trsf.-to Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer Order Date"; rec."Transfer Order Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Comment; rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer Order No."; rec."Transfer Order No.")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Receipt Date"; rec."Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("In-Transit Code"; rec."In-Transit Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Contact"; rec."Transfer-from Contact")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Contact"; rec."Transfer-to Contact")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Service Code"; rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Entry/Exit Point"; rec."Entry/Exit Point")
                {
                    ApplicationArea = All;
                }
                field(Area1; rec.Area)
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                /*  field("Excise Bus. Posting Group"; rec."Excise Bus. Posting Group")
                  {
                      ApplicationArea = All;
                  }
                  field("Form Code"; rec."Form Code")
                  {
                      ApplicationArea = All;
                  }
                  field("Form No."; rec."Form No.")
                  {
                      ApplicationArea = All;
                  }
                  field(Structure; rec.Structure)
                  {
                      ApplicationArea = All;
                  }
                  field("S. No. for RM"; rec."S. No. for RM")
                  {
                      ApplicationArea = All;
                  }
                  field("S. No. for IM"; rec."S. No. for IM")
                  {
                      ApplicationArea = All;
                  }
                  field("E.C.C. No."; rec."E.C.C. No.")
                  {
                      ApplicationArea = All;
                  }
                  field("Captive Consumption"; rec."Captive Consumption")
                  {
                      ApplicationArea = All;
                  }*/
                field("Time of Removal"; rec."Time of Removal")
                {
                    ApplicationArea = All;
                }
                field("LR/RR No."; rec."LR/RR No.")
                {
                    ApplicationArea = All;
                }
                field("LR/RR Date"; rec."LR/RR Date")
                {
                    ApplicationArea = All;
                }
                field("Vehicle No."; rec."Vehicle No.")
                {
                    ApplicationArea = All;
                }
                field("Mode of Transport"; rec."Mode of Transport")
                {
                    ApplicationArea = All;
                }
                field("Bill of Entry No."; rec."Bill of Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Bill of Entry Date"; rec."Bill of Entry Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Distance (Km)"; rec."Distance (Km)")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Type"; rec."Vehicle Type")
                {
                    ApplicationArea = All;
                }
                field(Purpose; rec.Purpose)
                {
                    ApplicationArea = All;
                }
                field("Transporter's Name"; rec."Transporter's Name")
                {
                    ApplicationArea = All;
                }
                field("GR No."; rec."GR No.")
                {
                    ApplicationArea = All;
                }
                field("GR Date"; rec."GR Date")
                {
                    ApplicationArea = All;
                }
                field("Truck No."; rec."Truck No.")
                {
                    ApplicationArea = All;
                }
                field("Insurance Amount"; rec."Insurance Amount")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from State"; rec."Transfer-from State")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to State"; rec."Transfer-to State")
                {
                    ApplicationArea = All;
                }
                field("From Main Location"; rec."From Main Location")
                {
                    ApplicationArea = All;
                }
                field("To Main Location"; rec."To Main Location")
                {
                    ApplicationArea = All;
                }
                field("Loading Inspector"; rec."Loading Inspector")
                {
                    ApplicationArea = All;
                }
                field("Locked Order"; rec."Locked Order")
                {
                    ApplicationArea = All;
                }
                field("External Transfer"; rec."External Transfer")
                {
                    ApplicationArea = All;
                }
                field("SalesPerson Code"; rec."SalesPerson Code")
                {
                    ApplicationArea = All;
                }
                field("Releasing Date"; rec."Releasing Date")
                {
                    ApplicationArea = All;
                }
                field("Releasing Time"; rec."Releasing Time")
                {
                    ApplicationArea = All;
                }
                field("Batch Executed"; rec."Batch Executed")
                {
                    ApplicationArea = All;
                }
                field("Transfer Receipt No."; rec."Transfer Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Group Code"; rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field(Pay; rec.Pay)
                {
                    ApplicationArea = All;
                }
                field("Location Comment"; rec."Location Comment")
                {
                    ApplicationArea = All;
                }
                field(ReProcess; rec.ReProcess)
                {
                    ApplicationArea = All;
                }
                field("OutPut Date"; rec."OutPut Date")
                {
                    ApplicationArea = All;
                }
                field("Shortage TO"; rec."Shortage TO")
                {
                    ApplicationArea = All;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Created ID"; rec."Created ID")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; rec."Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field("E-Way No."; rec."E-Way No.")
                {
                    ApplicationArea = All;
                }
                field("E-Way Bill No."; rec."E-Way Bill No.")
                {
                    ApplicationArea = All;
                }
                field("E-Way Bill Date"; rec."E-Way Bill Date")
                {
                    ApplicationArea = All;
                }
                field("E-Way Bill Validity"; rec."E-Way Bill Validity")
                {
                    ApplicationArea = All;
                }
                field("E-Way-to generate"; rec."E-Way-to generate")
                {
                    ApplicationArea = All;
                }
                field("E-Way Generated"; rec."E-Way Generated")
                {
                    ApplicationArea = All;
                }
                field("New Vechile No."; rec."New Vechile No.")
                {
                    ApplicationArea = All;
                }
                field("Vechile No. Update Remark"; rec."Vechile No. Update Remark")
                {
                    ApplicationArea = All;
                }
                field("E-Way Canceled"; rec."E-Way Canceled")
                {
                    ApplicationArea = All;
                }
                field("Transportation Distance"; rec."Transportation Distance")
                {
                    ApplicationArea = All;
                }
                field("E-Way URL"; rec."E-Way URL")
                {
                    ApplicationArea = All;
                }
                field("Reason of Cancel"; rec."Reason of Cancel")
                {
                    ApplicationArea = All;
                }
                field("Bill From Pin Code"; rec."Bill From Pin Code")
                {
                    ApplicationArea = All;
                }
                field("Bill To  Pin Code"; rec."Bill To  Pin Code")
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

