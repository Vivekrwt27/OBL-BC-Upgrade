page 50186 "Purchase order Released list"
{
    Caption = 'Released Purchase Order';
    CardPageID = "Released Purchase Order";
    DataCaptionFields = "Document Type";
    Editable = false;
    PageType = List;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order),
                            "Subcontracting" = FILTER(false),
                            "Status" = FILTER("Released" | 'Short Close'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
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

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(1);
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(2);
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
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
                field(ShipmentNo; ShipmentNo)
                {
                    Caption = 'Return Shipment No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Receiving No."; Rec."Receiving No.")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = All;
                }
                field(Invoice; Rec.Invoice)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("GE No."; Rec."GE No.")
                {
                    ApplicationArea = All;
                }
                field("Ordered Qty"; Rec."Ordered Qty")
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Total Recd. Quantity"; Rec."Total Recd. Quantity")
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
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
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CASE Rec."Document Type" OF
                            Rec."Document Type"::Quote:
                                PAGE.RUN(PAGE::"Purchase Quote", Rec);
                            Rec."Document Type"::"Blanket Order":
                                PAGE.RUN(PAGE::"Blanket Purchase Order", Rec);
                            Rec."Document Type"::Order:
                                BEGIN
                                    IF NOT Rec.Subcontracting THEN
                                        //Upgrade(+)
                                        //PAGE.RUN(PAGE::"Purchase Order",Rec)
                                        PAGE.RUN(PAGE::"Purchase Order Subform", Rec)
                                    //Upgrade(-)
                                    ELSE
                                        PAGE.RUN(PAGE::"Subcontracting Order", Rec);
                                END;
                            Rec."Document Type"::Invoice:
                                PAGE.RUN(PAGE::"Purchase Invoice", Rec);
                            Rec."Document Type"::"Return Order":
                                PAGE.RUN(PAGE::"Purchase Return Order", Rec);
                            Rec."Document Type"::"Credit Memo":
                                PAGE.RUN(PAGE::"Purchase Credit Memo", Rec);
                        END;

                        /*
                       CASE "Document Type" OF
                         "Document Type"::Quote:
                           FORM.RUN(FORM::"Purchase Quote",Rec);
                         "Document Type"::"Blanket Order":
                           FORM.RUN(FORM::"Blanket Purchase Order",Rec);
                         "Document Type"::Order:
                           IF "Import Document" THEN
                             FORM.RUN(FORM::"Import Order",Rec)
                           ELSE
                             FORM.RUN(FORM::"Purchase Order",Rec);
                         "Document Type"::Invoice:
                             FORM.RUN(FORM::"Purchase Invoice",Rec);
                         "Document Type"::"Return Order":
                           FORM.RUN(FORM::"Purchase Return Order",Rec);
                         "Document Type"::"Credit Memo":
                           FORM.RUN(FORM::"Purchase Credit Memo",Rec);
                       END;
                       */ //TRIRJ-MC

                    end;
                }
            }
        }
        area(reporting)
        {
            action("Purchase Reservation Avail.")
            {
                Caption = 'Purchase Reservation Avail.';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Purchase Reservation Avail.";
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Rec."Document Type" = Rec."Document Type"::"Return Order" THEN BEGIN
            ShipmentNo := '';
            RecShipmentNo.RESET;
            RecShipmentNo.SETRANGE(RecShipmentNo."Return Order No.", Rec."No.");
            IF RecShipmentNo.FINDFIRST THEN BEGIN
                ShipmentNo := RecShipmentNo."No.";
            END;
        END;
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        RecShipmentNo: Record "Return Shipment Header";
        ShipmentNo: Code[20];
}

