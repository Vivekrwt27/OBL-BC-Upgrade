pageextension 50434 pageextension50434 extends "Blanket Sales Order"
{
    layout
    {
        /*   modify("No.")
          {
              trigger OnAssistEdit()
              begin
                  //  Rec."Posting Date" := TODAY;
              end;
          }
          
   */
        addafter("No.")
        {
            field("Sales Type"; Rec."Sales Type")
            {
                ApplicationArea = all;
            }

        }
        moveafter("Sales Type"; "Sell-to Customer No.", "Sell-to Customer Name", "Sell-to Contact No.", "Sell-to Address", "Sell-to Address 2", "Sell-to Post Code", "Sell-to City", "Sell-to Contact")

        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            begin
                IF Rec."Customer Type" = 'COCO' THEN;
                //"Check Credit Limit":=FALSE; Needs attention
                //SelltoCustomerNoOnAfterValidate;
                //16630  SelltoCustomerNoOnAfterValidat
            end;

            trigger OnAfterAfterLookup(Selected: RecordRef)
            begin
                IF ((Rec."Location Code" = 'SKD-PLANT') OR (Rec."Location Code" = 'HSK-PLANT') OR (Rec."Location Code" = 'DRA-PLANT')) THEN BEGIN
                    IF Location.GET(Rec."Location Code") THEN BEGIN
                        IF State1.GET(Location."State Code") THEN BEGIN
                            Customer.RESET;
                            IF Customer.FINDFIRST THEN BEGIN
                                IF PAGE.RUNMODAL(Page::"Customer List", Customer) = ACTION::LookupOK THEN
                                    Rec.VALIDATE("Sell-to Customer No.", Customer."No.");
                            END;
                        END;
                    END;
                END ELSE
                    IF Location.GET(Rec."Location Code") THEN BEGIN
                        IF State1.GET(Location."State Code") THEN BEGIN
                            Customer.RESET;
                            Customer.SETFILTER("State Code", State1.Code);
                            IF Customer.FINDFIRST THEN BEGIN
                                IF PAGE.RUNMODAL(Page::"Customer List", Customer) = ACTION::LookupOK THEN
                                    Rec.VALIDATE("Sell-to Customer No.", Customer."No.");
                            END;
                        END;
                    END;

            end;
        }


        addafter("Sell-to Contact")
        {
            field(State; Rec.State)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("State Desc."; Rec."State Desc.")
            {
                ApplicationArea = all;
            }
            field("Customer Type"; Rec."Customer Type")
            {
                ApplicationArea = all;
            }
        }




        addafter("Order Date")
        {
            field("Customer Price Group"; Rec."Customer Price Group")
            {
                Editable = "Customer Price GroupEditable";
                ApplicationArea = All;
            }
            field("TPT Method"; Rec."TPT Method")
            {
                ApplicationArea = all;
            }
            field("ORC Terms"; Rec."ORC Terms")
            {
                ApplicationArea = all;
            }
            field("Order Booked Date"; Rec."Order Booked Date")
            {
                Caption = 'Order Received Date Time';
                ApplicationArea = all;
            }
            field("C-Form Date"; Rec."C-Form Date")
            {
                Caption = 'Validity Date';
                ApplicationArea = all;
            }

            field("Dealer Code"; Rec."Dealer Code")
            {
                Caption = 'ORC Code';
                ApplicationArea = all;
            }

            field("PO No."; Rec."PO No.")
            {
                ApplicationArea = all;
            }

            field("Salesperson Description"; Rec."Salesperson Description")
            {
                ApplicationArea = all;
            }
            field("Group Code"; Rec."Group Code")
            {
                ApplicationArea = all;
            }
            field(Pay; Rec.Pay)
            {
                ApplicationArea = all;
            }
            field("PCH Code"; Rec."PCH Code")
            {
                ApplicationArea = all;
            }
            field("Ship to Pin"; Rec."Ship to Pin")
            {
                ApplicationArea = all;
            }
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    Rec."Posting Date" := TODAY;
                end;
            }
        }
        moveafter("Customer Price Group"; "Shipping Agent Code", "External Document No.", "Salesperson Code")
        modify("Shipping Agent Code")
        {
            Caption = 'TPT Method';
        }
        addafter("Document Date")
        {
            field("Requested Delivery Date"; Rec."Requested Delivery Date")
            {
                ApplicationArea = All;
            }
            field("PMT Code"; Rec."PMT Code")
            {
                ApplicationArea = all;
            }
            field("Promised Delivery Date"; Rec."Promised Delivery Date")
            {
                ApplicationArea = All;
            }
            field("Posting No."; Rec."Posting No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = All;
            }
            label("S u p p o r t e d  B y :-")
            {
                Style = StrongAccent;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field(BD; Rec.BD)
            {
                Caption = 'SET:';
                ApplicationArea = all;
            }
            field("Business Development"; Rec."Business Development")
            {
                Caption = 'Specified Enterprices Team:';
                ApplicationArea = all;
            }
            field(GPS; Rec.GPS)
            {
                Caption = 'GET:';
                ApplicationArea = all;
            }
            field("Govt. Project Sales"; Rec."Govt. Project Sales")
            {
                ApplicationArea = all;
            }
            field(CKA; Rec.CKA)
            {
                Caption = 'PET:';
                ApplicationArea = all;
            }
            field("CKA Code"; Rec."CKA Code")
            {
                Caption = 'Private Enterprises Team:';
                ApplicationArea = all;
            }
            field(Retail; Rec.Retail)
            {
                Caption = 'Retail:';
                ApplicationArea = all;
            }
            field("Retail Code"; Rec."Retail Code")
            {
                Caption = 'Retail Code:';
                ApplicationArea = all;
            }
            field("Contribution Percentage"; Rec."Contribution Percentage")
            {
                Caption = 'Contribution Percentage:';
                ApplicationArea = all;
            }
            field(None; Rec.None)
            {
                Caption = 'None:';
                ApplicationArea = all;
            }
            field(Commitment; Rec.Commitment)
            {
                Caption = 'Reason To Hold:';
                ApplicationArea = all;
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name 2"; Rec."Ship-to Name 2")
                {
                    Editable = "Ship-to Name 2Editable";
                    ApplicationArea = All;
                }
                field("Ship-to State Code"; Rec."GST Ship-to State Code")
                {
                    Caption = 'Ship-to State Code';
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF State1.GET(Rec."GST Ship-to State Code") THEN
                            gststatedesc := State1.Description;
                    end;
                }
                field("Ship To State Desc"; gststatedesc)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("PhoneNo."; "PhoneNo.")
                {
                    Caption = 'Phone No.';
                    ApplicationArea = All;
                }
                field("Completely Shipped"; Rec."Completely Shipped")
                {
                    ApplicationArea = All;
                }
                field("Shipping No. Series"; Rec."Shipping No. Series")
                {
                    ApplicationArea = All;
                }
                field("Late Order Shipping"; Rec."Late Order Shipping")
                {
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                }
            }
        }
        moveafter("Outbound Whse. Handling Time"; "Shipping Agent Service Code")
        moveafter("Shipping Time"; "Package Tracking No.")
        moveafter("Promised Delivery Date"; "Due Date", "Payment Terms Code", Status)
        modify(Status)
        {
            Editable = false;
            Importance = Promoted;
        }
        moveafter(Shipping; "Ship-to Code", "Ship-to Name")
        modify("Ship-to Code")
        {
            Editable = true;
        }
        modify("Ship-to Name")
        {
            Editable = true;
        }
        moveafter("Ship-to Name 2"; "Ship-to Address", "Ship-to Address 2", "Ship-to Post Code", "Ship-to City")
        modify("Ship-to Address")
        {
            Editable = true;
        }
        modify("Ship-to Address 2")
        {
            Editable = true;
        }
        modify("Ship-to Post Code")
        {
            Editable = true;
        }
        modify("Ship-to City")
        {
            Editable = true;
        }
        moveafter("Ship To State Desc"; "Ship-to Contact", "Shipment Method Code", "Shipment Date")
        modify("Ship-to Contact")
        {
            Editable = true;
        }

        addafter(SalesLines)
        {
            group(invoicing)
            {
                Caption = 'Invoicing';
            }

            field("Bill-to Customer No."; Rec."Bill-to Customer No.")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    //BilltoCustomerNoOnAfterValidate;
                    //16630 BilltoCustomerNoOnAfterValidate
                end;
            }
            field("Invoice Disc. Code"; Rec."Invoice Disc. Code")
            {
                ApplicationArea = All;
            }

            field("Shipping No."; Rec."Shipping No.")
            {
                Editable = "Shipping No.Editable";
                ApplicationArea = All;
            }

        }
        movebefore("Bill-to Customer No."; "Location Code")
        moveafter("Bill-to Customer No."; "Bill-to Contact No.", "Bill-to Name", "Bill-to Address", "Bill-to Address 2", "Bill-to Post Code", "Bill-to City", "Bill-to Contact")
        moveafter("Invoice Disc. Code"; "Shortcut Dimension 2 Code", "Prices Including VAT", "Shortcut Dimension 1 Code")
        modify("Bill-to Name")
        {
            Editable = false;
            Enabled = false;
        }
        modify("Bill-to Address")
        {
            Editable = false;
            Enabled = false;
        }
        modify("Bill-to Address 2")
        {
            Editable = false;
            Enabled = false;
        }
        modify("Bill-to Post Code")
        {
            Editable = false;
            Enabled = false;
        }
        modify("Bill-to City")
        {
            Editable = false;
            Enabled = false;
        }
        modify("Bill-to Contact")
        {
            Editable = false;
            Enabled = false;
        }
        moveafter("Invoice Disc. Code"; "Shortcut Dimension 2 Code", "Payment Discount %", "Pmt. Discount Date", "Payment Method Code", "VAT Bus. Posting Group")
        moveafter("VAT Bus. Posting Group"; "Prices Including VAT", "Shortcut Dimension 1 Code")

        addafter("Tax Information")
        {
            group(Test)
            {
                Caption = 'Test';
                Visible = false;
                label(Control1000000112)
                {
                    CaptionClass = Text19030171;
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(QtyGrwt; QtyGrwt)
                {
                    Caption = 'T.BO Wgt';
                    Editable = false;
                    ToolTip = 'Click Refresh to update';
                    ApplicationArea = All;
                }
                field(QtySqt; QtySqt)
                {
                    Caption = 'T.BOSqm';
                    Editable = false;
                    ToolTip = 'Click Refresh to update';
                    ApplicationArea = All;
                }
                field(ShipGrwt; ShipGrwt)
                {
                    Caption = 'T. Sh Wgt';
                    Editable = false;
                    ToolTip = 'Click Refresh to update';
                    ApplicationArea = All;
                }
                field(ShipSqt; ShipSqt)
                {
                    Caption = 'T.ShSqm';
                    Editable = false;
                    ToolTip = 'Click Refresh to update';
                    ApplicationArea = All;
                }

            }
            group(CustInfoPanel)
            {
                Caption = 'Customer Information';
                Visible = false;
                label(Control1000000101)
                {
                    CaptionClass = Text19070588;
                    ApplicationArea = All;
                }
                //16630 field(control91; STRSUBSTNO('(%1)', SalesInfoPaneMgt.CalcNoOfShipToAddr(Rec."Sell-to Customer No.")))
                field(control91; STRSUBSTNO('(%1)', (Rec."Sell-to Customer No.")))
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                //16630   field(control92; STRSUBSTNO('(%1)', SalesInfoPaneMgt.CalcNoOfContacts(Rec)))
                field(control92; STRSUBSTNO('(%1)', (Rec)))
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
        movebefore(Control1000000112; "Tax Area Code")
        moveafter(Control1000000112; "Campaign No.", "Responsibility Center")
        modify("Tax Area Code")
        {
            Editable = false;
        }
    }
    actions
    {

        modify(Release)
        {
            trigger OnBeforeAction()
            begin
                //Upgrade(+)
                Rec.CheckExciseStructure;//MSBS.Rao 0713
                                         // MIJS.begin
                Customer.RESET;
                Customer.GET(Rec."Sell-to Customer No.");
                IF Customer.Blocked = Customer.Blocked::All THEN
                    Customer.FIELDERROR(Blocked);
                // MIJS.end
                //TRI DG 020810 Add Start
                IF RecNoSeries.GET(Rec."No. Series") THEN BEGIN
                    IF RecNoSeries.Trading THEN BEGIN
                        /*StrDetails.RESET;//16630 Table N/F
                        StrDetails.SETRANGE(Code, Structure);
                        StrDetails.SETRANGE(StrDetails.Type, StrDetails.Type::Excise);
                        IF StrDetails.FINDFIRST THEN
                            ERROR('This is a trading Order and you cannot choose excise');*/
                    END;
                END;
                //TRI DG 020810 Add Stop

                IF Rec."Sell-to Customer No." <> REC."Bill-to Customer No." THEN
                    ERROR(Text009, Rec."Sell-to Customer No.", Rec."Sell-to Customer Name")
                ELSE begin
                    // ReleaseSalesDoc.PerformManualRelease(Rec);
                    //"Releasing Date" := WORKDATE;  //MSKS2905
                    //"Releasing Time" := TIME;   //MSKS2905
                    // Msdr.begin
                    Rec."Releasing Date" := WORKDATE;
                    Rec."Releasing Time" := TIME;
                    CurrPage.update;
                END;

            end;
        }
        modify(MakeOrder)
        {
            trigger OnBeforeAction()
            begin
                Rec.TESTFIELD("Order Booked Date");

                recSalesLine.InventoryUpdate(Rec);

                TestBool := FALSE;
                lrecSalesLine.RESET;
                lrecSalesLine.SETRANGE("Document Type", Rec."Document Type");
                lrecSalesLine.SETRANGE("Document No.", Rec."No.");
                lrecSalesLine.SETRANGE(Type, lrecSalesLine.Type::Item);
                lrecSalesLine.SETFILTER("No.", '<>%1', '');
                IF lrecSalesLine.FIND('-') THEN
                    REPEAT
                        lrecSalesLine.CALCFIELDS("Remaining Inventory", "Total Reserved Quantity");
                        IF (lrecSalesLine."Remaining Inventory" - lrecSalesLine."Total Reserved Quantity") < lrecSalesLine."Qty. to Ship" THEN
                            TestBool := TRUE;
                    UNTIL lrecSalesLine.NEXT = 0;
                IF TestBool THEN
                    IF NOT CONFIRM(lText5000, TRUE) THEN
                        EXIT;

                IF NOT CONFIRM(STRSUBSTNO(Text50000), TRUE) THEN
                    EXIT;
                Rec.TESTFIELD(Status, Rec.Status::Released);
                IF Rec."Shortcut Dimension 1 Code" = '' THEN
                    ERROR('Please enter Branch Code');

            end;
        }

        addafter(Approval)
        {
            action("&View Credit Allocation Info")
            {
                Caption = '&View Credit Allocation Info';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //TRI
                    CustCheckCreditLimit.SalesHeaderCheck(Rec);
                    //TRI
                end;
            }
        }
        addafter(Action138)
        {
            action("Refresh Quantity in Hand")
            {
                Caption = 'Refresh Quantity in Hand';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //TRI
                    CLEAR(ShipSqt);
                    CLEAR(QtyGrwt);
                    CLEAR(QtySqt);
                    CLEAR(ShipGrwt);
                    TgSalesLine.RESET;
                    TgSalesLine.SETRANGE("Document Type", Rec."Document Type"::"Blanket Order");
                    TgSalesLine.SETRANGE("Document No.", Rec."No.");
                    IF TgSalesLine.FIND('-') THEN
                        REPEAT
                            TgSalesLine.CALCFIELDS("Remaining Inventory", "Total Reserved Quantity", "Quantity in Blanket Order");
                            TgSalesLine."Quantity in Hand SQM" := (TgSalesLine."Remaining Inventory" - (
                                                              TgSalesLine."Total Reserved Quantity"));
                            TgSalesLine."Quantity in Hand CRT" := (TgSalesLine."Remaining Inventory" / TgSalesLine."Qty. per Unit of Measure") - (
                                                              TgSalesLine."Total Reserved Quantity" / TgSalesLine."Qty. per Unit of Measure");

                            ShipGrwt += TgSalesLine."Gross Weight (Ship)";
                            ShipSqt += TgSalesLine."Quantity in Sq. Mt.(Ship)";
                            QtyGrwt += TgSalesLine."Gross Weight";
                            QtySqt += TgSalesLine."Quantity in Sq. Mt.";
                            TgSalesLine.MODIFY;
                        UNTIL TgSalesLine.NEXT = 0;
                    //TRI
                end;
            }
            action("Blanket Order Close")
            {
                Caption = 'Blanket Order Close';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    recuserSetup.GET(USERID);
                    IF NOT recuserSetup."Allow BO Close" THEN
                        ERROR(Text008);

                    Rec.TESTFIELD(Status, Rec.Status::Released);
                    TgSalesHeader.RESET;
                    TgSalesHeader.SETRANGE("Document Type", Rec."Document Type");
                    TgSalesHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(Report::"Generate Purchase Invoices", TRUE, FALSE, TgSalesHeader);
                end;
            }
        }
        addafter(Print)
        {
            action("Order Quantity")
            {
                Caption = 'Order Quantity';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    DocPrint.PrintSalesHeader(Rec);
                end;
            }
            action("Qty To Ship")
            {
                Caption = 'Qty To Ship';
                ApplicationArea = All;

                trigger OnAction()
                var
                    lrecSaleHeader: Record "Sales Header";
                begin
                    lrecSaleHeader.RESET;
                    lrecSaleHeader.SETRANGE(lrecSaleHeader."Document Type", Rec."Document Type");
                    lrecSaleHeader.SETRANGE(lrecSaleHeader."No.", Rec."No.");
                    REPORT.RUNMODAL(Report::"Blanket Order Confirmation2", TRUE, FALSE, lrecSaleHeader);
                end;
            }
            action(SalesHistoryBtn)
            {
                Caption = 'Sales H&istory';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //SalesInfoPaneMgt.LookupCustSalesHistory(Rec,"Bill-to Customer No.",TRUE);         // code blocked for upgradation
                end;
            }
            action("&Avail. Credit")
            {
                Caption = '&Avail. Credit';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //SalesInfoPaneMgt.LookupAvailCredit("Bill-to Customer No.");                       // code blocked for upgradation
                end;
            }
            action(SalesHistoryStn)
            {
                Caption = 'Sales Histor&y';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //SalesInfoPaneMgt.LookupCustSalesHistory(Rec,"Sell-to Customer No.",FALSE);        // code blocked for upgradation
                end;
            }
            action("&Contacts")
            {
                Caption = '&Contacts';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //16630   SalesInfoPaneMgt.LookupContacts(Rec);
                end;
            }
            action("Ship&-to Addresses")
            {
                Caption = 'Ship&-to Addresses';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //16630  SalesInfoPaneMgt.LookupShipToAddr(Rec);
                end;
            }
        }
    }

    var
        PurchaseHeader: Record "Purchase Header";
        ApprovalMgt: Codeunit "Approvals Mgmt.";//439 Rep "Approvals Mgmt."
        lrecSalesLine: Record "Sales Line";
        TestBool: Boolean;
        lText5000: Label 'You dont have Inventory, Still wan to continue';

    var
        "--TRI": Integer;
        recSalesLine: Record "Sales Line";
        DocPrint: Codeunit "Document-Print";
        "BlnktSalesOrdtoOrd(Y/N)": Codeunit "Blnkt Sales Ord. to Ord. (Y/N)";
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        TgSalesHeader: Record "Sales Header";
        TgSalesLine: Record "Sales Line";
        ShipGrwt: Decimal;
        ShipSqt: Decimal;
        QtyGrwt: Decimal;
        QtySqt: Decimal;
        recuserSetup: Record "User Setup";
        RecNoSeries: Record "No. Series";
        UserSetup: Record "User Setup";
        CompInfo: Record "Company Information";
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        LocationFilterString: Text[1024];
        UserLocation: Record "User Location";
        SalesHeader: Record "Sales Header";
        Cust: Record Customer;
        "-MIJS--": Integer;
        Customer: Record Customer;
        //StrDetails: Record 13793; //16630 table N/F
        State1: Record State;
        Location: Record Location;
        "PhoneNo.": Text[30];
        Cust1: Record Customer;
        [InDataSet]
        PayEditable: Boolean;
        [InDataSet]
        "Customer TypeEditable": Boolean;
        [InDataSet]
        "Customer Price GroupEditable": Boolean;
        [InDataSet]
        "Tax Registration No.Editable": Boolean;
        [InDataSet]
        StructureEditable: Boolean;
        [InDataSet]
        "Discount Charges %Editable": Boolean;
        [InDataSet]
        "Group CodeEditable": Boolean;
        [InDataSet]
        "Salesperson CodeEditable": Boolean;
        [InDataSet]
        "Shipping No.Editable": Boolean;
        [InDataSet]
        "Ship-to CodeEditable": Boolean;
        [InDataSet]
        "Ship-to NameEditable": Boolean;
        [InDataSet]
        "Ship-to AddressEditable": Boolean;
        [InDataSet]
        "Ship-to Address 2Editable": Boolean;
        [InDataSet]
        "Ship-to CityEditable": Boolean;
        [InDataSet]
        "Ship-to ContactEditable": Boolean;
        [InDataSet]
        "Ship-to Name 2Editable": Boolean;
        [InDataSet]
        "Ship-to Post CodeEditable": Boolean;
        [InDataSet]
        "Free SupplyEditable": Boolean;
        [InDataSet]
        "Make OrderEnable": Boolean;
        [InDataSet]
        "Form CodeEnable": Boolean;
        Text16500: Label 'To calculate invoice discount, check Cal. Inv. Discount on header when Price Inclusive of Tax = Yes.\This option cannot be used to calculate invoice discount when Price Inclusive Tax = Yes.';
        Text50000: Label 'Do you want to Make Order';
        Text008: Label 'You are not authorized to Close BO';
        TriText: Label 'Wrong No. Series chosen.';
        Text009: Label 'You must fill the same Customer %1 ,%2 in Bill to Customer ';
        Text19030171: Label 'Tax Registeration No.';
        Text19070588: Label 'Sell-to Customer';
        Text19069283: Label 'Bill-to Customer';
        gststatedesc: Text[50];
        reas: Record "Reason Code";
        Noneditable: Boolean;

    trigger OnAfterGetRecord()
    begin
        //Upgrade(+)
        //TRI
        /* IF Rec.Status = Rec.Status::Released THEN BEGIN
             Editable;
              END ELSE
             Noneditable;*/
        IF Rec.Status = Rec.Status::Released THEN BEGIN
            PayEditable := FALSE;
            "Customer TypeEditable" := FALSE;
            "Customer Price GroupEditable" := FALSE;
            "Tax Registration No.Editable" := FALSE;
            StructureEditable := FALSE;
            "Discount Charges %Editable" := FALSE;
            "Group CodeEditable" := FALSE;
            "Salesperson CodeEditable" := FALSE;
            "Shipping No.Editable" := FALSE;
            "Ship-to CodeEditable" := FALSE;
            "Ship-to NameEditable" := FALSE;
            "Ship-to AddressEditable" := FALSE;
            "Ship-to Address 2Editable" := FALSE;
            "Ship-to CityEditable" := FALSE;
            "Ship-to ContactEditable" := FALSE;
            "Ship-to Name 2Editable" := FALSE;
            "Ship-to Post CodeEditable" := FALSE;
            "Free SupplyEditable" := FALSE;
        END ELSE BEGIN
            PayEditable := TRUE;
            //CurrForm."Customer Type".EDITABLE(TRUE);
            //  CurrForm."Customer Price Group".EDITABLE(TRUE);
            "Tax Registration No.Editable" := TRUE;
            StructureEditable := TRUE;
            "Discount Charges %Editable" := TRUE;
            "Group CodeEditable" := TRUE;
            "Salesperson CodeEditable" := TRUE;
            "Shipping No.Editable" := TRUE;
            "Ship-to CodeEditable" := TRUE;
            "Ship-to NameEditable" := TRUE;
            "Ship-to AddressEditable" := TRUE;
            "Ship-to Address 2Editable" := TRUE;
            "Ship-to CityEditable" := TRUE;
            "Ship-to ContactEditable" := TRUE;
            "Ship-to Name 2Editable" := TRUE;
            "Ship-to Post CodeEditable" := TRUE;
            "Free SupplyEditable" := TRUE;
        END;
        //TRI
        //Msvc
        IF Cust1.GET(Rec."Sell-to Customer No.") THEN BEGIN
            "PhoneNo." := Cust1."Phone No.";
        END;
        //Upgrade(-)

    end;

    trigger OnOpenPage()
    begin
        //Upgrade(+)//oninit code//
        "Form CodeEnable" := TRUE;
        "Make OrderEnable" := TRUE;
        "Free SupplyEditable" := TRUE;
        "Ship-to Post CodeEditable" := TRUE;
        "Ship-to Name 2Editable" := TRUE;
        "Ship-to ContactEditable" := TRUE;
        "Ship-to CityEditable" := TRUE;
        "Ship-to Address 2Editable" := TRUE;
        "Ship-to AddressEditable" := TRUE;
        "Ship-to NameEditable" := TRUE;
        "Ship-to CodeEditable" := TRUE;
        "Group CodeEditable" := TRUE;
        "Discount Charges %Editable" := TRUE;
        StructureEditable := TRUE;
        "Customer Price GroupEditable" := TRUE;
        "Customer TypeEditable" := TRUE;
        PayEditable := TRUE;
        //Upgrade(-)
        //oninit code// end
        //on open start

        //Upgrade(+)
        CompInfo.GET;
        //TRI
        IF UserSetup.GET(USERID) THEN BEGIN
            IF UserSetup."Make Order" = TRUE THEN
                "Make OrderEnable" := TRUE
            ELSE
                "Make OrderEnable" := FALSE;

            IF UserSetup."Allow Form" = TRUE THEN
                "Form CodeEnable" := TRUE
            ELSE
                "Form CodeEnable" := FALSE;

            IF UPPERCASE(USERID) = 'DE012' THEN
                "Customer Price GroupEditable" := TRUE
            ELSE
                "Customer Price GroupEditable" := FALSE;


        END;

        //Upgrade(-)

        /* IF UserMgt.GetSalesFilter <> '' THEN BEGIN//16630 base code//
          rec.FILTERGROUP(2);
          rec.SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
          rec.FILTERGROUP(0);
        END; */
        //Upgrade(+)
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."View Sales Blanket Order", '%1', TRUE);
        IF UserLocation.FIND('-') THEN
            REPEAT
                IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                    LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
            UNTIL UserLocation.NEXT = 0;

        LocationFilterString := COPYSTR(LocationFilterString, 2, 1024);

        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');

        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Location Code", LocationFilterString);
        Rec.FILTERGROUP(0);
        //TRI
        IF Rec.Status = Rec.Status::Released THEN
            Editable;
        //Upgrade(-)

    end;

    //16630 Page N/F This Funcation//
    //Unsupported feature: Code Modification on "SelltoCustomerNoOnAfterValidat(PROCEDURE 19034782)".

    //procedure SelltoCustomerNoOnAfterValidat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." THEN
      IF "Sell-to Customer No." <> xRec."Sell-to Customer No." THEN
        SETRANGE("Sell-to Customer No.");
    CurrPage.UPDATE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
      //Update(+)

    IF USERID='DE025'THEN
      PAGE.RUN(50142);

    //Update(-)
    CurrPage.UPDATE;
    */
    //end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Posting Date" := TODAY;
    end;




}

