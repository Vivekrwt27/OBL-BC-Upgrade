pageextension 50377 pageextension50377 extends "Blanket Sales Orders"
{
    layout
    {
        modify("No.")
        {
            trigger OnAssistEdit()
            begin
                rec."Posting Date" := TODAY;
            end;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            begin
                //SelltoCustomerNoOnAfterValidat;
            end;

            trigger OnLookup(var Text: Text): Boolean
            var
                Location: Record Location;

                Customer: Record Customer;
            begin
                IF ((rec."Location Code" = 'SKD-PLANT') OR (rec."Location Code" = 'HSK-PLANT') OR (rec."Location Code" = 'DRA-PLANT')) THEN BEGIN
                    IF Location.GET(rec."Location Code") THEN BEGIN
                        IF State1.GET(Location."State Code") THEN BEGIN
                            Customer.RESET;
                            IF Customer.FINDFIRST THEN BEGIN
                                IF PAGE.RUNMODAL(22, Customer) = ACTION::LookupOK THEN
                                    rec.VALIDATE("Sell-to Customer No.", Customer."No.");
                            END;
                        END;
                    END;
                END ELSE
                    IF Location.GET(rec."Location Code") THEN BEGIN
                        IF State1.GET(Location."State Code") THEN BEGIN
                            Customer.RESET;
                            Customer.SETFILTER("State Code", State1.Code);
                            IF Customer.FINDFIRST THEN BEGIN
                                IF PAGE.RUNMODAL(22, Customer) = ACTION::LookupOK THEN
                                    rec.VALIDATE("Sell-to Customer No.", Customer."No.");
                            END;
                        END;
                    END;
            end;

        }
        modify("Sell-to Contact")
        {
            Editable = false;
        }
        modify("Sell-to Customer Name")
        {
            Editable = false;
        }
        modify("Sell-to Post Code")
        {
            Editable = false;
        }
        addafter("Sell-to Contact")
        {
            field(State; rec.State)
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("State Description"; rec."State Description")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Customer Type"; rec."Customer Type")
            {
                Editable = "Customer TypeEditable";
                ApplicationArea = all;
            }
            field("Discount Charges %"; rec."Discount Charges %")
            {
                Caption = 'Disc Charges/CD %';
                Editable = "Discount Charges %Editable";
                ApplicationArea = all;
            }
        }
        addafter("Customer Type")
        {
            field("Order Received Date Time"; rec."Order Booked Date")
            {
                Caption = 'Order Received Date Time';
                Visible = true;
                ApplicationArea = all;
            }
            /*  field("Free Supply"; rec."Free Supply")
             {
                 Editable = "Free SupplyEditable";
             } */
            field("Validity Date 1"; rec."C-Form Date")
            {
                Caption = 'Validity Date';
                ApplicationArea = all;
            }
            field("Customer Price Group"; rec."Customer Price Group")
            {
                Editable = "Customer Price GroupEditable";
                ApplicationArea = all;
            }
            field("CR Exception Type"; rec."CR Exception Type")
            {
                ApplicationArea = all;
            }
            field("CR Approved By"; rec."CR Approved By")
            {
                ApplicationArea = all;
            }
            field("Shipping Agent Code"; rec."Shipping Agent Code")
            {
                Caption = 'TPT Method';
                ApplicationArea = all;
            }


        }
        addafter("External Document No.")
        {
            field("ORC Code"; rec."Dealer Code")
            {
                Caption = 'ORC Code';
                ApplicationArea = all;
            }
            field("ORC Terms"; rec."ORC Terms")
            {
                ApplicationArea = all;
            }
            field("PO No."; rec."PO No.")
            {
                Description = 'Customization No. 15';
                Editable = true;
                ApplicationArea = all;
            }
            field(Remarks; rec.Remarks)
            {
                ApplicationArea = all;
            }
            field("Salesperson Description"; rec."Salesperson Description")
            {
                ApplicationArea = all;
            }
            /* field("Posting Date"; rec."Posting Date")
            {
                ApplicationArea = all;

                trigger OnValidate()
                begin
                    rec."Posting Date" := TODAY;
                end;
            } */
            field("Validity Date"; Rec."C-Form Date")
            {
                Caption = 'Validity Date';
                ApplicationArea = All;
            }
            field("Document Date"; rec."Document Date")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Requested Delivery Date"; rec."Requested Delivery Date")
            {
                ApplicationArea = all;
            }
            field("Promised Delivery Date"; rec."Promised Delivery Date")
            {
                ApplicationArea = all;
            }
            field("Due Date"; rec."Due Date")
            {
                ApplicationArea = all;
            }
            field("Group Code"; rec."Group Code")
            {
                Caption = 'Group Code';
                Editable = "Group CodeEditable";
                ApplicationArea = all;
            }
            field("Payment Terms Code"; rec."Payment Terms Code")
            {
                ApplicationArea = all;
            }
            field(Pay; rec.Pay)
            {
                ApplicationArea = all;
            }
            field("PCH Code"; rec."PCH Code")
            {
                ApplicationArea = all;
            }
            field("Govt./Private Sales Person"; rec."Govt./Private Sales Person")
            {
                ApplicationArea = all;
            }
            /*  field(Status; rec.Status)
             {
                 Editable = false;
                 Importance = Promoted;
             } */
            field("Releasing Date"; rec."Releasing Date")
            {
                ApplicationArea = all;
            }
            field("PMT Code"; rec."PMT Code")
            {
                ApplicationArea = all;
            }
            field("Posting No."; rec."Posting No.")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Posting No. Series"; rec."Posting No. Series")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Reason Code"; rec."Reason Code")
            {
                ApplicationArea = all;
            }
            /* label("S u p p o r t e d  B y :-")
            {
                Style = StrongAccent;
                StyleExpr = TRUE;
            } */
            field(SET; rec.BD)
            {
                ApplicationArea = all;
            }
            field("Specified Enterprises Team"; rec."Business Development")
            {
                ApplicationArea = all;
            }
            field(GET; rec.GPS)
            {
                ApplicationArea = all;
            }
            field("Govt. Enterprises Team"; rec."Govt. Project Sales")
            {
                ApplicationArea = all;
            }
            field(PET; rec.CKA)
            {
                ApplicationArea = all;
            }
            field("Private Enterprises Team"; rec."CKA Code")
            {
                ApplicationArea = all;
            }
            field(Retail; rec.Retail)
            {
                ApplicationArea = all;
            }
            field("Retail Code"; rec."Retail Code")
            {
                ApplicationArea = all;
            }
            field("Contribution Percentage"; rec."Contribution Percentage")
            {
                ApplicationArea = all;
            }
            field(None; rec.None)
            {
                ApplicationArea = all;
            }
            field("Reason To Hold"; rec.Commitment)
            {
                ApplicationArea = all;

                trigger OnValidate()
                var

                    Commitment: Text[100];
                begin
                    IF reas.GET(Commitment) THEN
                        Commitment := reas.Description;
                end;
            }

        }


        moveafter(Remarks; "Salesperson Code", "Ship-to Contact")
        // moveafter("Ship To State Desc";"Ship-to Contact")
        /* modify("Ship-to Contact")
        {
            Editable = "Ship-to ContactEditable";
        } */
        addafter("No.")
        {
            field("Sales Type"; Rec."Sales Type")
            {
                ApplicationArea = all;
            }
        }
        // moveafter("Ship-to Address 2"; "Ship-to Post Code")
        modify("Ship-to Post Code")
        {
            Editable = "Ship-to Post CodeEditable";
        }

        moveafter("Ship-to Code"; "Ship-to Name")
        addafter("Ship-to Code")
        {

            /* field("Ship-to Code";"Ship-to Code")
            {
                Editable = "Ship-to CodeEditable";
            } */
            /* field("Ship-to Name"; rec."Ship-to Name")
            {
                // Editable = "Ship-to NameEditable";
            } */
            field("Ship-to Name 2"; rec."Ship-to Name 2")
            {
                Editable = "Ship-to Name 2Editable";
                ApplicationArea = all;
            }
            field("Ship-to Address"; rec."Ship-to Address")
            {
                Editable = "Ship-to AddressEditable";
                ApplicationArea = all;
            }
            field("Ship-to Address 2"; rec."Ship-to Address 2")
            {
                Editable = "Ship-to Address 2Editable";
                ApplicationArea = all;
            }

            field("Ship-to City"; rec."Ship-to City")
            {
                Editable = "Ship-to CityEditable";
                ApplicationArea = all;
            }
            field("Ship-to State Code"; rec."GST Ship-to State Code")
            {
                Caption = 'Ship-to State Code';
                Editable = true;
                ApplicationArea = all;

                trigger OnValidate()

                begin
                    IF State1.GET(rec."GST Ship-to State Code") THEN
                        gststatedesc := State1.Description;
                end;
            }
            field("Ship To State Desc"; gststatedesc)
            {
                Editable = false;
                ApplicationArea = all;
            }

            field("Ship to Pin"; rec."Ship to Pin")
            {
                ApplicationArea = all;
            }
            /*  field("Transit Document"; rec."Transit Document")
             {
             } */
            field("Shipment Method Code"; rec."Shipment Method Code")
            {
                ApplicationArea = all;
            }
            field("Shipment Date"; rec."Shipment Date")
            {
                ApplicationArea = all;
            }
            /* field("PhoneNo."; rec."PhoneNo.")
            {
                Caption = 'Phone No.';
            } */
            field("Completely Shipped"; rec."Completely Shipped")
            {
                ApplicationArea = all;
            }
            field("Shipping No. Series"; rec."Shipping No. Series")
            {
                ApplicationArea = all;
            }
            field("Truck No."; rec."Truck No.")
            {
                ApplicationArea = all;
            }
            field("Loading Inspector"; rec."Loading Inspector")
            {
                ApplicationArea = all;
            }
            field("Late Order Shipping"; rec."Late Order Shipping")
            {
                ApplicationArea = all;
            }
            field("Outbound Whse. Handling Time"; rec."Outbound Whse. Handling Time")
            {
                ApplicationArea = all;
            }
            field("Shipping Agent Service Code"; rec."Shipping Agent Service Code")
            {
                ApplicationArea = all;
            }
            field("Shipping Time"; rec."Shipping Time")
            {

            }
            field("Package Tracking No."; rec."Package Tracking No.")
            {
                ApplicationArea = all;
            }
            field("Shipping Advice"; rec."Shipping Advice")
            {
                ApplicationArea = all;
            }
            field("Transporter's Name"; rec."Transporter's Name")
            {
                ApplicationArea = all;
                Caption = 'Transporter Code';
            }
            field("Transporter Name"; rec."Transporter Name")
            {
                ApplicationArea = all;
            }
        }
    }




    actions
    {
        addafter("Co&mments")
        {
            action("&View Credit Allocation Info")
            {
                Caption = '&View Credit Allocation Info';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                var

                begin
                    //TRI
                    CustCheckCreditLimit.SalesHeaderCheck(Rec);
                    //TRI
                end;
            }
            action("Refresh Quantity in Hand")
            {
                Caption = 'Refresh Quantity in Hand';
                ApplicationArea = all;

                trigger OnAction()
                begin
                    //TRI
                    CLEAR(ShipSqt);
                    CLEAR(QtyGrwt);
                    CLEAR(QtySqt);
                    CLEAR(ShipGrwt);
                    TgSalesLine.RESET;
                    TgSalesLine.SETRANGE("Document Type", rec."Document Type"::"Blanket Order");
                    TgSalesLine.SETRANGE("Document No.", rec."No.");
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
                ApplicationArea = all;

                trigger OnAction()
                begin
                    recuserSetup.GET(USERID);
                    IF NOT recuserSetup."Allow BO Close" THEN
                        ERROR(Text008);

                    rec.TESTFIELD(Status, rec.Status::Released);
                    TgSalesHeader.RESET;
                    TgSalesHeader.SETRANGE("Document Type", rec."Document Type");
                    TgSalesHeader.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(50048, TRUE, FALSE, TgSalesHeader);
                end;
            }
            action("Order Quantity")
            {
                Caption = 'Order Quantity';
                ApplicationArea = all;

                trigger OnAction()
                var
                    DocPrint: Codeunit 229;
                begin
                    DocPrint.PrintSalesHeader(Rec);
                end;
            }
            action("Qty To Ship")
            {
                Caption = 'Qty To Ship';
                ApplicationArea = all;

                trigger OnAction()
                var
                    lrecSaleHeader: Record 36;
                begin
                    lrecSaleHeader.RESET;
                    lrecSaleHeader.SETRANGE(lrecSaleHeader."Document Type", rec."Document Type");
                    lrecSaleHeader.SETRANGE(lrecSaleHeader."No.", rec."No.");
                    REPORT.RUNMODAL(50118, TRUE, FALSE, lrecSaleHeader);
                end;
            }
            action(SalesHistoryBtn)
            {
                Caption = 'Sales H&istory';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
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
                ApplicationArea = all;

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
                ApplicationArea = all;

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
                ApplicationArea = all;

                trigger OnAction()
                begin
                    // SalesInfoPaneMgt.LookupContacts(Rec);
                end;
            }
            action("Ship&-to Addresses")
            {
                Caption = 'Ship&-to Addresses';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    // SalesInfoPaneMgt.LookupShipToAddr(Rec);
                end;
            }
        }

        modify("Re&lease")
        {
            trigger OnAfterAction()
            var
                ReleaseSalesDoc: Codeunit 414;
            begin
                //Upgrade(+)
                // CheckExciseStructure;//MSBS.Rao 0713
                // MIJS.begin
                Customer.RESET;
                Customer.GET(rec."Sell-to Customer No.");
                IF Customer.Blocked = Customer.Blocked::All THEN
                    Customer.FIELDERROR(Blocked);
                // MIJS.end
                //TRI DG 020810 Add Start
                /*  IF RecNoSeries.GET(rec."No. Series") THEN BEGIN
                     IF RecNoSeries.Trading THEN BEGIN
                         StrDetails.RESET;
                         StrDetails.SETRANGE(Code, Structure);
                         StrDetails.SETRANGE(StrDetails.Type, StrDetails.Type::Excise);
                         IF StrDetails.FINDFIRST THEN
                             ERROR('This is a trading Order and you cannot choose excise');
                     END;
                 END; */
                //TRI DG 020810 Add Stop

                IF rec."Sell-to Customer No." <> rec."Bill-to Customer No." THEN
                    ERROR(Text009, rec."Sell-to Customer No.", rec."Sell-to Customer Name")
                ELSE
                    ReleaseSalesDoc.PerformManualRelease(Rec);
                //"Releasing Date" := WORKDATE;  //MSKS2905
                //"Releasing Time" := TIME;   //MSKS2905
                // Msdr.begin
                SalesHeader.RESET;
                SalesHeader.SETRANGE("No.", rec."No.");
                IF SalesHeader.FINDFIRST THEN BEGIN
                    SalesHeader."Releasing Date" := WORKDATE;
                    SalesHeader."Releasing Time" := TIME;
                    SalesHeader.MODIFY;
                END;


                //ReleaseSalesDoc.PerformManualRelease(Rec);

                //Upgrade(-)

            end;
        }
        modify("Make &Order")
        {
            trigger OnBeforeAction()
            var
                lrecSalesLine: Record "Sales Line";
                TestBool: Boolean;
                recSalesLine: Record "Sales Line";
                lText5000: Label 'You dont Have Inventory Still Wan to Continue';
                Text50000: Label 'Do you want to Make Order';
            begin
                rec.TESTFIELD("Order Booked Date");

                recSalesLine.InventoryUpdate(Rec);

                TestBool := FALSE;
                lrecSalesLine.RESET;
                lrecSalesLine.SETRANGE("Document Type", rec."Document Type");
                lrecSalesLine.SETRANGE("Document No.", rec."No.");
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
                rec.TESTFIELD(Status, rec.Status::Released);
                IF rec."Shortcut Dimension 1 Code" = '' THEN
                    ERROR('Please enter Branch Code');

            end;
        }
    }





    trigger OnOpenPage()
    begin
        //Upgrade(+)
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

        LocationFilterString := COPYSTR(LocationFilterString, 2, 1040);

        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');

        rec.FILTERGROUP(2);
        rec.SETFILTER("Location Code", LocationFilterString);
        rec.FILTERGROUP(0);
        //Upgrade(-)

    end;

    trigger OnAfterGetRecord()
    begin
        //    SetControlAppearance;
        //Upgrade(+)
        //TRI
        IF rec.Status = rec.Status::Released THEN BEGIN
            Editable;

        END
        ELSE
            // Noneditable;
            IF rec.Status = rec.Status::Released THEN BEGIN
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
        IF Cust1.GET(rec."Sell-to Customer No.") THEN BEGIN
            "PhoneNo." := Cust1."Phone No.";
        END;
        //Upgrade(-)
    end;


    var
        State1: Record State;

        recSalesLine: Record 37;
        "BlnktSalesOrdtoOrd(Y/N)": Codeunit 84;
        CustCheckCreditLimit: Codeunit 312;
        TgSalesHeader: Record 36;
        TgSalesLine: Record 37;
        ShipGrwt: Decimal;
        ShipSqt: Decimal;
        QtyGrwt: Decimal;
        QtySqt: Decimal;
        recuserSetup: Record 91;
        RecNoSeries: Record 308;
        UserSetup: Record 91;
        CompInfo: Record 79;
        SalesInfoPaneMgt: Codeunit 7171;
        LocationFilterString: Text[1024];
        UserLocation: Record 50007;
        SalesHeader: Record 36;
        Cust: Record 18;
        "-MIJS--": Integer;
        Customer: Record 18;
        // StrDetails: Record "13793";

        Location: Record 14;
        "PhoneNo.": Text[30];
        Cust1: Record 18;
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
        reas: Record 231;

}

