page 50167 "Blanket Order List"
{
    Caption = 'Sales List';
    CardPageID = "Blanket Sales Order";
    DataCaptionFields = "Document Type";
    Editable = true;
    PageType = List;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER("Blanket Order"));

    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                /*  field(Remarks; Rec.Remarks)
                  {
                  }*/
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                /*  field("Validity Date"; Rec."C-Form Date")
                  {
                  }*/
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                /*   field("Customer Type"; Rec."Customer Type")
                   {
                   }*/
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                /*    field("Blanket Order No."; Rec."Blanket Order No.")
                    {
                    }
                    field("Ship-to City"; Rec."Ship-to City")
                    {
                    }
                    field("Payment Terms Code"; Rec."Payment Terms Code")
                    {
                    }
                  /*  field("Dealer Code"; Rec."Dealer Code")
                    {
                    }
                    field("State Description"; Rec."State Description")
                    {
                    }*/
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ApplicationArea = All;
                }
                /*   field(Quantity; Rec.Quantity)
                   {
                   }
                   field("Qty in Sq. Mt."; Rec."Qty in Sq. Mt.")
                   {
                   }
                   field("Releasing Date"; Rec."Releasing Date")
                   {
                   }
                   field("Reserved Qty(CRT)"; Rec."Reserved Qty(CRT)")
                   {
                   }
                   field("Reserved Qty(SQM)"; Rec."Reserved Qty(SQM)")
                   {
                   }
                   field("Releasing Time"; Rec."Releasing Time")
                   {
                   }
                   field(Structure; Rec.Structure)
                   {
                   }
                   field("Opener ID"; Rec."Opener ID")
                   {
                   }
                   field("Date of Reopen"; Rec."Date of Reopen")
                   {
                   }
                   field("Time of Reopen"; Rec."Time of Reopen")
                   {
                   }
                   field("Amount to Customer"; Rec."Amount to Customer")
                   {
                   }
                   field("Form Code"; Rec."Form Code")
                   {
                   }
                   field("Discount Charges %"; Rec."Discount Charges %")
                   {
                   }
                   field("Make Order Date"; Rec."Make Order Date")
                   {
                   }
                   field(Pay; Rec.Pay)
                   {
                   }
                   field("Qty. To Ship"; Rec."Qty. To Ship")
                   {
                   }
                   field("Truck No."; Rec."Truck No.")
                   {
                   }
                   field("Net Wt."; Rec."Net Wt.")
                   {
                   }
                   field("Gross Wt."; Rec."Gross Wt.")
                   {
                   }
                   field("Transporter's Name"; Rec."Transporter's Name")
                   {
                   }*/
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    ApplicationArea = All;
                }
                /*  field("Releaser ID"; Rec."Releaser ID")
                  {
                  }
                  field(Amount; Rec.Amount)
                  {
                  }
                  field("TPT Method"; Rec."TPT Method")
                  {
                  }
                  field("Order Created ID"; Rec."Order Created ID")
                  {
                  }
                  field("PO No."; Rec."PO No.")
                  {
                  }
                  field("PMT Code"; Rec."PMT Code")
                  {
                  }*/
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PageID: Integer;
                    begin
                        CASE rec."Document Type" OF
                            Rec."Document Type"::Quote:
                                PageID := PAGE::"Sales Quote";
                            Rec."Document Type"::Invoice:
                                PageID := PAGE::"Sales Invoice";
                            Rec."Document Type"::"Return Order":
                                PageID := PAGE::"Sales Return Order";
                            Rec."Document Type"::"Credit Memo":
                                PageID := PAGE::"Sales Credit Memo";
                            Rec."Document Type"::"Blanket Order":
                                PageID := PAGE::"Blanket Sales Order";
                        END;

                        PageID := GetPageId(PageID);

                        IF PageID <> 0 THEN
                            PAGE.RUN(PageID, Rec);
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Sales Reservation Avail.")
            {
                Caption = 'Sales Reservation Avail.';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Sales Reservation Avail.";
                ApplicationArea = All;
            }
        }
    }

    local procedure GetPageId(PageId: Integer): Integer
    var
    //    MiniPagesMapping: Record 1305;
    begin
        /*
        IF MiniPagesMapping.READPERMISSION THEN
          IF MiniPagesMapping.GET(PageId) THEN
            EXIT(MiniPagesMapping.SubstitutePageID);
        
        EXIT(PageId);*/

    end;
}

