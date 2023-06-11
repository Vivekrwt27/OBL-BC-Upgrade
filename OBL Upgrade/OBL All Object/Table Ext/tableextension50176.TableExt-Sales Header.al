tableextension 50176 tableextension50176 extends "Sales Header"
{
    fields
    {
        modify("Reason Code")
        {
            TableRelation = "Reason Code" WHERE(Reason = CONST(true));
        }
        modify("Ship-to Post Code")
        {
            TableRelation = "Post Code";
        }
        modify(Status)
        {
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Price Approved,Credit Approval Pending,Credit Approved,Not in Inventory,Approved';
        }

        /* modify(Structure)
         {
             TableRelation = "Structure Header" WHERE("Structure Type" = FILTER('Sales|Others'),
                                                         "Tax Abatement" = FILTER(true));
         }*/

        modify("Sell-to Customer No.")// 15578
        {
            trigger OnAfterValidate()
            var
            begin
                IF Customer.GET("Sell-to Customer No.") THEN BEGIN
                    Rec."Customer Type" := Customer."Customer Type"; //TEAM 14763
                    "GST Ship-to State Code" := Customer."State Code"; //MSKS

                    //  if "Customer Type"<>'Misc' then
                    IF NOT (Customer."GST Customer Type" IN [Customer."GST Customer Type"::Registered, Customer."GST Customer Type"::Export]) THEN
                        //      ERROR('Please update GST Customer Type on Customer Card %1',"Sell-to Customer No.");

                        IF Customer."Customer Type" <> 'COCO' THEN BEGIN
                            IF ("Document Type" = "Document Type"::"Blanket Order") AND ("Posting Date" = 0D) THEN
                                ERROR(Text00002);

                            IF Confirmed THEN BEGIN

                                //Vipul Tri1.0 Start
                                SalesLineRec.RESET;
                                SalesLineRec.SETFILTER(SalesLineRec."Document Type", '%1', "Document Type");
                                SalesLineRec.SETFILTER(SalesLineRec."Document No.", '%1', "No.");
                                IF SalesLineRec.FIND('-') THEN
                                    ERROR('You can not change %1', FIELDCAPTION("Sell-to Customer No."));
                                //Vipul Tri1.0 End
                                UpdateSalesPerson;//MSAK
                                CLEAR(CDMgt);
                                "CD Applicable" := CDMgt.ISCDApplicable("Sell-to Customer No.");


                                //ND Tri Start Cust 38
                                GeneralLedgerSetup.RESET;
                                GeneralLedgerSetup.FIND('-');
                                Location1.RESET;
                                Location1.SETFILTER(Location1.Code, "Location Code");
                                IF Location1.FIND('-') THEN BEGIN
                                    VALIDATE("Shortcut Dimension 1 Code", Location1."Location Dimension"); //TEAM::3333
                                    VALIDATE("Shortcut Dimension 8 Code", GLSetup."Location Dimension Code"); //TEAM::3333
                                    IF Location1."Main Location" <> '' THEN BEGIN
                                        Location1.SETFILTER(Location1.Code, Location1."Main Location");
                                        Location1.FIND('-');
                                    END;
                                END;
                                //ND Tri End Cust 38

                                VALIDATE("Location Code");  //TRI Dg
                                CheckQDApplicableforCustomer;
                                VALIDATE("Discount Charges %", 0);
                            END;
                        END;
                    "CD Applicable" := CDMgt.ISCDApplicable("Sell-to Customer No.");
                end;
            end;
        }


        modify("Sell-to Customer Name")
        {
            trigger OnAfterValidate()
            begin
                "CD Applicable" := CDMgt.ISCDApplicable("Sell-to Customer No.");
            end;

        }

        modify("Bill-to Customer No.")// 15578
        {
            trigger OnAfterValidate()
            var
                Cust: Record Customer;
                CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
            begin
                // STRAT Ori-UT
                IF NOT ((Cust."Customer Type" = 'COCO') OR (Cust."Coco Customer")) THEN
                    IF "Document Type" IN ["Document Type"::"Blanket Order"] THEN
                        CustCheckCreditLimit.SalesHeaderCheck(Rec);
                //End Ori Ut

            end;
        }
        modify("Ship-to Code")// 15578
        {
            trigger OnAfterValidate()
            begin
                if "Ship-to Code" <> '' then begin
                    ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code");
                    "GST Ship-to State Code" := ShipToAddr."Post Code";
                    "Ship to Phone No." := ShipToAddr."Phone No.";
                    "Tax Area Code" := ShipToAddr."Tax Area Code"; //MS
                end;
                IF "Sell-to Customer No." <> '' THEN BEGIN
                    GetCust("Sell-to Customer No.");
                    "Ship to Pin" := Cust."Pin Code";
                end;
            end;
        }

        modify("Ship-to Name")// 15578
        {
            trigger OnBeforeValidate()
            begin
                "Ship to Pin" := '';
            end;
        }
        modify("Ship-to Name 2")// 15578
        {
            trigger OnBeforeValidate()
            begin
                "Ship to Pin" := '';
            end;
        }
        modify("Ship-to Address")// 15578
        {
            trigger OnAfterValidate()
            begin
                IF Status = Status::Released THEN
                    TESTFIELD(Status, Status::Open);
                "Ship to Pin" := '';
            end;
        }
        modify("Ship-to Address 2")// 15578
        {
            trigger OnBeforeValidate()
            begin

                IF Status = Status::Released THEN
                    TESTFIELD(Status, Status::Open);
                "Ship to Pin" := '';
            end;
        }
        modify("Ship-to City")// 15578
        {
            trigger OnBeforeValidate()
            begin
                IF Status = Status::Released THEN
                    TESTFIELD(Status, Status::Open);
                "Ship to Pin" := '';
            end;
        }
        modify("Order Date")// 15578
        {
            trigger OnBeforeValidate()
            begin

                IF ("Document Type" IN ["Document Type"::Quote, "Document Type"::Order]) AND
                  NOT ("Order Date" = xRec."Order Date")
                  THEN
                    PriceMessageIfSalesLinesExist(FIELDCAPTION("Order Date"));

                "Promised Delivery Date" := "Order Date";
            end;
        }
        modify("Posting Date")// 15578
        {
            trigger OnBeforeValidate()
            begin

                //ravi tri1.0 start
                SalesLine1.RESET;
                SalesLine1.SETFILTER(SalesLine1."Document Type", '%1', "Document Type");
                SalesLine1.SETFILTER("Document No.", "No.");
                IF SalesLine1.FIND('-') THEN
                    REPEAT
                        SalesLine1."Posting Date" := "Posting Date";
                        SalesLine1."Assessee Code" := "Assessee Code";
                        SalesLine1.MODIFY;
                    UNTIL SalesLine1.NEXT = 0;
                //ravi tri1.0 end
            end;
        }
        modify("Payment Terms Code")
        {
            trigger OnBeforeValidate()
            var
                Cust: Record Customer;
                PaymentTerms: Record "Payment Terms";
            begin
                IF ("Payment Terms Code" = '00') AND ("Discount Charges %" = 0) THEN
                    ERROR('Please Enter the Cash Discount');

                IF Cust.GET("Sell-to Customer No.") THEN BEGIN
                    IF Cust."Payment Terms Code" <> '' THEN BEGIN
                        IF PaymentTerms.GET(Cust."Payment Terms Code") THEN;
                        IF PaymentTerms2.GET("Payment Terms Code") THEN BEGIN
                            IF CALCDATE(PaymentTerms2."Due Date Calculation", WORKDATE) > CALCDATE(PaymentTerms."Due Date Calculation", WORKDATE) THEN
                                ERROR('Payment term Due date should not be more than %1', Cust."Payment Terms Code");
                        END;
                    END;
                END;

            end;
        }
        modify("Location Code")// 15578
        {
            trigger OnBeforeValidate()
            var
                SalesLine: Record "Sales Line";
            begin

                //ND Tri Start cust 38
                UserLocation.RESET;
                UserLocation.SETFILTER(UserLocation."User ID", USERID);
                UserLocation.SETFILTER(UserLocation."Location Code", "Location Code");
                IF "Document Type" = "Document Type"::Quote THEN
                    UserLocation.SETFILTER(UserLocation."Create Sales Quote", '%1', TRUE);
                IF ("Document Type" = "Document Type"::Order) THEN
                    UserLocation.SETFILTER(UserLocation."Create Sales Order", '%1', TRUE);
                IF "Document Type" = "Document Type"::Invoice THEN
                    UserLocation.SETFILTER(UserLocation."Create Sales Invoice", '%1', TRUE);
                IF "Document Type" = "Document Type"::"Credit Memo" THEN
                    UserLocation.SETFILTER(UserLocation."Create Sales Credit memo", '%1', TRUE);
                IF "Document Type" = "Document Type"::"Blanket Order" THEN
                    UserLocation.SETFILTER(UserLocation."Create Sales Blanket Order", '%1', TRUE);
                IF "Document Type" = "Document Type"::"Return Order" THEN
                    UserLocation.SETFILTER(UserLocation."Create Sales Return order", '%1', TRUE);
                IF NOT UserLocation.FIND('-') THEN BEGIN
                    IF "Location Code" <> '' THEN BEGIN
                        IF DIALOG.CONFIRM('You are not allowed to use %1 location. Do you still want to continue.',
                                           TRUE, "Location Code") THEN BEGIN
                            UserLocation.RESET;
                            UserLocation.SETFILTER(UserLocation."User ID", USERID);
                            IF "Document Type" = "Document Type"::Quote THEN
                                UserLocation.SETFILTER(UserLocation."Create Sales Quote", '%1', TRUE);
                            IF ("Document Type" = "Document Type"::Order) THEN
                                UserLocation.SETFILTER(UserLocation."Create Sales Order", '%1', TRUE);
                            IF "Document Type" = "Document Type"::Invoice THEN
                                UserLocation.SETFILTER(UserLocation."Create Sales Invoice", '%1', TRUE);
                            IF "Document Type" = "Document Type"::"Credit Memo" THEN
                                UserLocation.SETFILTER(UserLocation."Create Sales Credit memo", '%1', TRUE);
                            IF "Document Type" = "Document Type"::"Blanket Order" THEN
                                UserLocation.SETFILTER(UserLocation."Create Sales Blanket Order", '%1', TRUE);
                            IF "Document Type" = "Document Type"::"Return Order" THEN
                                UserLocation.SETFILTER(UserLocation."Create Sales Return order", '%1', TRUE);

                            IF UserLocation.FIND('-') THEN
                                REPEAT
                                    IF UserSetup1.GET(UPPERCASE(USERID)) THEN
                                        IF UserLocation.GET(UPPERCASE(USERID), UserSetup1.Location) THEN BEGIN
                                            IF Location1.GET(UserLocation."Location Code") THEN
                                                IF Location1."Main Location" = '' THEN
                                                    VALIDATE("Location Code", UserLocation."Location Code");
                                        END ELSE BEGIN
                                            IF Location1.GET(UserLocation."Location Code") THEN
                                                IF Location1."Main Location" = '' THEN
                                                    VALIDATE("Location Code", UserLocation."Location Code");
                                        END;
                                UNTIL UserLocation.NEXT = 0;
                        END ELSE BEGIN
                            ERROR('Please select another option.');
                        END;
                    END;
                END;

                IF Location.GET("Location Code") THEN
                    IF Location."Main Location" <> '' THEN BEGIN
                        IF "Location Code" <> '' THEN BEGIN
                            IF DIALOG.CONFIRM('You are not allowed to use %1 Sub location on header. Do you still want to continue.',
                                TRUE, "Location Code") THEN BEGIN
                                UserLocation.RESET;
                                UserLocation.SETFILTER(UserLocation."User ID", USERID);
                                IF "Document Type" = "Document Type"::Quote THEN
                                    UserLocation.SETFILTER(UserLocation."Create Sales Quote", '%1', TRUE);
                                IF ("Document Type" = "Document Type"::Order) THEN
                                    UserLocation.SETFILTER(UserLocation."Create Sales Order", '%1', TRUE);
                                IF "Document Type" = "Document Type"::Invoice THEN
                                    UserLocation.SETFILTER(UserLocation."Create Sales Invoice", '%1', TRUE);
                                IF "Document Type" = "Document Type"::"Credit Memo" THEN
                                    UserLocation.SETFILTER(UserLocation."Create Sales Credit memo", '%1', TRUE);
                                IF "Document Type" = "Document Type"::"Blanket Order" THEN
                                    UserLocation.SETFILTER(UserLocation."Create Sales Blanket Order", '%1', TRUE);
                                IF "Document Type" = "Document Type"::"Return Order" THEN
                                    UserLocation.SETFILTER(UserLocation."Create Sales Return order", '%1', TRUE);

                                IF UserLocation.FIND('-') THEN
                                    REPEAT
                                        IF UserSetup1.GET(UPPERCASE(USERID)) THEN
                                            IF UserLocation.GET(UPPERCASE(USERID), UserSetup1.Location) THEN BEGIN
                                                IF Location1.GET(UserLocation."Location Code") THEN
                                                    IF Location1."Main Location" = '' THEN
                                                        VALIDATE("Location Code", UserLocation."Location Code");
                                            END ELSE BEGIN
                                                IF Location1.GET(UserLocation."Location Code") THEN
                                                    IF Location1."Main Location" = '' THEN
                                                        VALIDATE("Location Code", UserLocation."Location Code");
                                            END;
                                    UNTIL UserLocation.NEXT = 0;
                            END ELSE BEGIN
                                ERROR('Please select another option.');
                            END;
                        END;
                    END;

                IF "Location Code" = '' THEN BEGIN
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    IF "Document Type" = "Document Type"::Quote THEN
                        UserLocation.SETFILTER(UserLocation."Create Sales Quote", '%1', TRUE);
                    IF ("Document Type" = "Document Type"::Order) THEN
                        UserLocation.SETFILTER(UserLocation."Create Sales Order", '%1', TRUE);
                    IF "Document Type" = "Document Type"::Invoice THEN
                        UserLocation.SETFILTER(UserLocation."Create Sales Invoice", '%1', TRUE);
                    IF "Document Type" = "Document Type"::"Credit Memo" THEN
                        UserLocation.SETFILTER(UserLocation."Create Sales Credit memo", '%1', TRUE);
                    IF "Document Type" = "Document Type"::"Blanket Order" THEN
                        UserLocation.SETFILTER(UserLocation."Create Sales Blanket Order", '%1', TRUE);
                    IF "Document Type" = "Document Type"::"Return Order" THEN
                        UserLocation.SETFILTER(UserLocation."Create Sales Return order", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF UserSetup1.GET(UPPERCASE(USERID)) THEN
                                IF UserLocation.GET(UPPERCASE(USERID), UserSetup1.Location) THEN BEGIN
                                    IF Location1.GET(UserLocation."Location Code") THEN
                                        IF Location1."Main Location" = '' THEN
                                            VALIDATE("Location Code", UserLocation."Location Code");
                                END ELSE BEGIN
                                    IF Location1.GET(UserLocation."Location Code") THEN
                                        IF Location1."Main Location" = '' THEN
                                            VALIDATE("Location Code", UserLocation."Location Code");
                                END;
                        UNTIL UserLocation.NEXT = 0;
                END;

                IF "Location Code" <> '' THEN BEGIN
                    UserSetup.RESET;
                    UserSetup.SETFILTER("User ID", USERID);
                    IF UserSetup.FIND('-') THEN
                        IF NOT UserSetup."Change Location" THEN
                            ERROR('You cannot change the location. Please contact your system administrator.');
                END;

                GLSetup.GET;
                GeneralLedgerSetup.RESET;
                GeneralLedgerSetup.FIND('-');
                Location1.RESET;
                Location1.SETFILTER(Location1.Code, "Location Code");
                IF Location1.FIND('-') THEN BEGIN
                    IF SH.GET("Document Type", "No.") THEN BEGIN
                        ValidateShortcutDimCode(1, "Location Code");
                        //    VALIDATE("Shortcut Dimension 1 Code",Location1."Location Dimension"); //TEAM::3333
                        VALIDATE("Shortcut Dimension 8 Code", GLSetup."Location Dimension Code"); //TEAM::3333
                    END;

                    IF Location1."Main Location" <> '' THEN BEGIN
                        Location1.SETFILTER(Location1.Code, Location1."Main Location");
                        Location1.FIND('-');
                    END;
                END;

                //ND Tri end cust 38

                //Vipul Tri1.0 Start
                IF "Location Code" <> '' THEN
                    IF Location.GET("Location Code") THEN
                        IF Location."Main Location" <> '' THEN
                            ERROR('You can not use Sub Locations on header.');
                //Vipul Tri1.0 End
                // NAVIN
                IF "Location Code" <> '' THEN BEGIN
                    Location.GET("Location Code");
                    /* IF Location."Sales Invoice Nos." <> '' THEN
                         "Posting No. Series" := Location."Sales Invoice Nos.";
                     IF Location."Sales Shipment Nos." <> '' THEN
                         "Shipping No. Series" := Location."Sales Shipment Nos."; */// 15578
                    SalesLine.SETRANGE("Document Type", "Document Type");
                    SalesLine.SETRANGE("Document No.", "No.");
                    IF SalesLine.FIND('-') THEN
                        REPEAT
                            SalesLine."Location Code" := "Location Code";
                            SalesLine."Related Location code" := Location."Related Location Code"; //Vipul Tri1.0
                            SalesLine.MODIFY;
                        UNTIL SalesLine.NEXT = 0;
                END;

                IF Cust.GET("Sell-to Customer No.") THEN;
                IF Cust."Customer Type" = 'DEALER' THEN BEGIN
                    IF Location1.GET("Location Code") THEN
                        IF Location1."Customer Price Group" <> '' THEN
                            "Customer Price Group" := Location1."Customer Price Group"
                        ELSE
                            "Customer Price Group" := Cust."Customer Price Group";
                END ELSE
                    IF (Cust."Customer Type" <> '') AND
                 (Cust."Customer Type" <> 'DEALER') THEN BEGIN
                        IF Location1.GET("Location Code") THEN
                            IF Location1."Customer Price Group(Project)" <> '' THEN
                                "Customer Price Group" := Location1."Customer Price Group(Project)"
                            ELSE
                                "Customer Price Group" := Cust."Customer Price Group";
                    END ELSE BEGIN
                        "Customer Price Group" := '';
                    END;
                //MSBS.Rao End Dt. 02-06-12

                "Shortcut Dimension 1 Code" := "Location Code";
                //TRI
                //MS-PB
                IF "Inter Company" = TRUE THEN
                    VALIDATE("Other Comp. Location", "Location Code");
            end;
        }

        modify("Salesperson Code")// 15578
        {
            trigger OnAfterValidate()
            begin
                SalesLine2.RESET;
                SalesLine2.SETRANGE("Document Type", "Document Type");
                SalesLine2.SETFILTER("Document No.", "No.");
                IF SalesLine2.FIND('-') THEN
                    REPEAT
                        SalesLine2."Salesperson Code" := "Salesperson Code";
                        SalesLine2.MODIFY;
                    UNTIL SalesLine2.NEXT = 0;

                IF SalespersonPurchaser.GET("Salesperson Code") THEN
                    IF SalespersonPurchaser."Customer No." <> '' THEN BEGIN
                        "Dealer Code" := SalespersonPurchaser.Code;
                        IF CustomerRec.GET(SalespersonPurchaser."Customer No.") THEN
                            IF CustomerRec."Salesperson Code" <> '' THEN
                                "Dealer's Salesperson Code" := CustomerRec."Salesperson Code";
                    END ELSE BEGIN
                        "Dealer's Salesperson Code" := SalespersonPurchaser.Code;
                    END;

                "Salesperson Description" := Cust."Salesperson Description";
                IF SalespersonPurchaser.GET("Salesperson Code") THEN
                    "Salesperson Description" := SalespersonPurchaser.Name;



            end;
        }


        modify("Sell-to Post Code")// 15578
        {
            trigger OnBeforeValidate()
            begin
                IF Status = Status::Released THEN
                    ERROR(Text0002);

            end;
        }

        modify("Bill-to Customer Templ. Code")// 15578
        {
            trigger OnBeforeValidate()
            begin
                VALIDATE("Ship-to Code", '');
                "GST Ship-to State Code" := Cust."State Code";

            end;
        }


        modify("Promised Delivery Date")// 15578
        {
            trigger OnBeforeValidate()
            begin
                IF Status = Status::Released THEN
                    IF "Promised Delivery Date" < "Releasing Date" THEN
                        ERROR('Promised Delivery Date Cannot Less the Releasing Date');

            end;
        }
        modify(State)// 15578
        {
            trigger OnBeforeValidate()
            begin
                IF RecState.GET(State) THEN
                    "State Description" := RecState.Description;

            end;
        }
        field(50000; Deleted; Boolean)
        {
            Description = 'Used for Tracking of ArchieveManagement For Deleted Sales Order';
        }
        field(50001; "New Status"; Option)
        {
            OptionCaption = ',Short Close,Cancel,Close';
            OptionMembers = ,"Short Close",Cancel,Close;
        }
        field(50002; "Locked Order"; Boolean)
        {
            Description = 'Customization No. 5.3';
        }
        field(50003; "Customer Type"; Code[10])
        {
            Description = 'Cust 22';
            TableRelation = "Customer Type".Code WHERE(Type = FILTER(= Customer));
        }
        field(50004; "Security Amount"; Decimal)
        {
            Description = 'Customization No. 22';
        }
        field(50005; "Security Date"; Date)
        {
            Description = 'Customization No. 22';
        }
        field(50006; "PO No."; Code[20])
        {
            Description = 'Customization No. 5.3.3/Ori Ut';
        }
        field(50012; "Transporter's Name"; Code[20])
        {
            Description = 'Customization No. 25';
            TableRelation = Vendor WHERE(Transporter1 = const(true));

            trigger OnValidate()
            var
                vendor: Record Vendor;
            begin
                vendor.RESET;
                IF vendor.GET("Transporter's Name") THEN
                    "Transporter Name" := vendor.Name
                ELSE
                    "Transporter Name" := '';
            end;
        }
        field(50013; "GR No."; Code[20])
        {
            Description = 'Customization No. 25';
        }
        field(50014; "Truck No."; Code[20])
        {
            Description = 'Customization No. 25';
        }
        field(50015; "Shipping Bill No."; Code[10])
        {
            Description = 'Customization No. 33';
            Enabled = false;
        }
        field(50016; "HS Code"; Code[10])
        {
            Description = 'Customization No. 33';
            Enabled = false;
        }
        field(50017; "Loading Inspector"; Text[30])
        {
            Description = 'Customization No. 25';
        }
        field(50018; "GR Date"; Date)
        {
            Description = 'Customization No. 25';
        }
        field(50019; "Packing Credit Value"; Decimal)
        {
            Enabled = false;
        }
        field(50020; "Insurance Amount"; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Sum("Sales Line"."Line Amount" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), Type = filter("Charge (Item)")));
            Description = 'Report 107';

        }
        field(50021; "Foreign Commission Agent"; Code[20])
        {
            Description = 'Report 83 EXIM';
            TableRelation = Customer;
        }
        field(50022; "Indian Commission Agent"; Code[20])
        {
            Description = 'Report 83 EXIM';
            Enabled = false;
            TableRelation = Customer;
        }
        field(50023; "Entry No."; Integer)
        {
            Description = 'Report 18 Letter';
        }
        field(50024; "Entry Date"; Date)
        {
            Description = 'Report 18 Letter';
        }
        field(50025; "Main Location"; Code[10])
        {
        }
        field(50026; "Shipment Status"; Text[30])
        {
            Description = 'Report 102 EXIM';
        }
        field(50027; "Qty in Sq. Mt."; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Quantity in Sq. Mt." WHERE("Document Type" = FIELD("Document Type"),
                                                                        "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50028; "Net Wt."; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Net Weight" WHERE("Document Type" = FIELD("Document Type"),
                                                               "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50029; "Gross Wt."; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Gross Weight" WHERE("Document Type" = FIELD("Document Type"),
                                                                 "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50030; "State Desc."; Text[50])
        {
        }
        field(50031; "Salesperson Description"; Text[50])
        {
            Editable = false;
        }
        field(50033; "Transporter Name"; Text[35])
        {
            Editable = true;
        }
        field(50034; Quantity; Decimal)
        {
            CalcFormula = Sum("Sales Line".Quantity WHERE("Document Type" = FIELD("Document Type"),
                                                           "Document No." = FIELD("No."),
                                                            Type = filter(Item)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50035; "Qty. To Ship"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Qty. to Ship" WHERE("Document Type" = FIELD("Document Type"),

                                                                 "Document No." = FIELD("No."),
                                                                 Type = filter(Item)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50037; "FOB Value"; Decimal)
        {
            Description = 'ND';
            Enabled = false;
        }
        field(50038; "Ocean Freight"; Decimal)
        {
            Description = 'ND';
        }
        field(50039; "No. of Containers"; Integer)
        {
            Description = 'ND';
        }
        field(50040; "Payment Terms"; Text[40])
        {
            Description = 'ND Reduces length from 250 to 50 due to space problem';
        }
        field(50041; "LC Number"; Code[20])
        {
            Description = 'ND Reduces length from 250 to 50 due to space problem';
        }
        field(50042; "Currency Code 1"; Code[16])
        {
            Description = 'MS-PB Reduces length from 50 to 30 due to space problem';
            TableRelation = Currency;
        }
        field(50043; "Dealer Code"; Code[20])
        {
            Description = 'ND';
            TableRelation = "Salesperson/Purchaser".Code WHERE("Customer No." = FILTER(<> ''));

            trigger OnValidate()
            var
                Cust: Record Customer;
                SP: Record "Salesperson/Purchaser";
            begin
                IF "Dealer Code" <> '' THEN BEGIN
                    SP.GET("Dealer Code");
                    Cust.GET(SP."Customer No.");
                    "Dealer's Salesperson Code" := Cust."Salesperson Code";
                    //VALIDATE("Salesperson Code","Dealer Code"); Kulbhushan Sharma
                END;
            end;
        }
        field(50044; "Dealer's Salesperson Code"; Code[20])
        {
            Description = 'ND';
            TableRelation = "Salesperson/Purchaser".Code WHERE("Customer No." = FILTER(= ''));

            trigger OnValidate()
            begin
                VALIDATE("Salesperson Code", "Dealer's Salesperson Code");  //TRI DG 020609 Commented
            end;
        }
        field(50046; "Quote Date"; Date)
        {
        }
        field(50047; "Releasing Date"; Date)
        {
            Editable = true;
        }
        field(50048; "Releasing Time"; Time)
        {
            Editable = false;
        }
        field(50055; "Abatement Required"; Boolean)
        {
            Description = 'rakesh for sales tax calculation';
        }
        field(50060; "Sales Type"; Option)
        {
            Description = 'Dilip for Tax Calculation';
            OptionCaption = ' ,Retail,Govt,Private';
            OptionMembers = " ",Retail,Govt,Private;

            trigger OnValidate()
            begin
                // TRI DP 050207 ADD START
                UpdateSalesPerson;
                SalesLine.SETRANGE("Document Type", "Document Type");
                SalesLine.SETRANGE("Document No.", "No.");
                SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                //IF SalesLine.FIND('-') THEN
                //  ERROR('Cannot change the type when lines are already there');      //Rahul 010507
                //MESSAGE('Validate each line of Type Item with Order No.  %1',"No.");
                // TRI DP 050207 ADD END
            end;
        }
        field(50061; "Group Code"; Code[2])
        {
            Description = 'TRI N.K 20.02.08';

            trigger OnLookup()
            begin
                //TRI N.K 20.02.08 Add Start
                InventorySetup.GET;
                GroupCode.RESET;
                //GroupCodee.SETFILTER(DimensionValue."Dimension Code",InventorySetup."Size Code");
                IF PAGE.RUNMODAL(Page::"Item Group 2", GroupCode) = ACTION::LookupOK THEN
                    VALIDATE("Group Code", GroupCode."Group Code");
                //TRI N.K 20.02.08 Add Stop
            end;

            trigger OnValidate()
            begin
                //TRI LM 100308 start
                SalesLine1.RESET;
                SalesLine1.SETRANGE("Document Type", "Document Type");
                SalesLine1.SETRANGE("Document No.", "No.");
                IF SalesLine1.FIND('-') THEN
                    ERROR('You Cannot modify Group Code Because some sales line is associated with it');
                //TRI LM 100308 End
            end;
        }
        field(50062; "Group Code Check"; Boolean)
        {
        }
        field(50070; Pay; Option)
        {
            Description = 'TRIRJ ORIENT6.0 01-11-08';
            OptionMembers = "To Pay"," To Be Billed"," FOB Mundra Port";
        }
        field(50072; "Sales Order No."; Code[10])
        {
            Description = 'TRI DP 140309';

            trigger OnLookup()
            begin
                SalesSetup.GET;
                CLEAR(NoSrRelationForm);
                NoSrRelation.SETRANGE(Code, SalesSetup."Order Nos.");
                NoSrRelationForm.LOOKUPMODE(TRUE);
                NoSrRelationForm.SETTABLEVIEW(NoSrRelation);
                /* IF NoSrRelationForm.RUNMODAL = ACTION::LookupOK THEN
                     "Sales Order No." := NoSrRelationForm.GetSeriesCode;*/ // 15578
            end;
        }
        field(50073; "Archive Version"; Integer)
        {
            CalcFormula = Count("Sales Header Archive" WHERE("Document Type" = FIELD("Document Type"),
                                                              "No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50074; "Blanket Order No."; Code[16])
        {
            Editable = false;
        }
        field(50075; "Date of Release"; Date)
        {
            Editable = true;
        }
        field(50076; "Time of Release"; Time)
        {
            Editable = false;
        }
        field(50077; "Releaser ID"; Code[15])
        {
            Editable = false;
        }
        field(50078; "Opener ID"; Code[15])
        {
            Editable = false;
        }
        field(50079; "Date of Reopen"; Date)
        {
            Editable = true;
        }
        field(50080; "Time of Reopen"; Time)
        {
            Editable = false;
        }
        field(50081; "Sales Order No"; Code[20])
        {
            Description = 'TRI DP';

            trigger OnLookup()
            begin
                SalesSetup.GET;
                CLEAR(NoSrRelationForm);
                NoSrRelation.SETRANGE(Code, SalesSetup."Order Nos.");
                NoSrRelationForm.LOOKUPMODE(TRUE);
                NoSrRelationForm.SETTABLEVIEW(NoSrRelation);
                /* IF NoSrRelationForm.RUNMODAL = ACTION::LookupOK THEN
                     "Sales Order No" := NoSrRelationForm.GetSeriesCode;*/ // 15578
            end;
        }
        field(50082; "Discount Charges %"; Decimal)
        {
            MaxValue = 4;
            MinValue = -4;

            trigger OnValidate()
            begin
                IF CDAllowed THEN
                    IF "Discount Charges %" <> 0 THEN
                        ERROR('CD is not Allowed for this CITY');

                //CALCFIELDS("Group Code");
                IF ("Group Code" = '01') AND ("Discount Charges %" > 4) THEN
                    ERROR('Discount Cannot be Greater Then 4 Percentage for Product Group 01');

                IF ("Group Code" = '02') AND ("Discount Charges %" > 4) THEN
                    ERROR('Discount Cannot be Greater Then 4 Percentage for Product Group 02');

                IF "Discount Charges %" > 0 THEN
                    "Discount Charges %" := "Discount Charges %" * -1;

                // 15578 VALIDATE(Structure); //TRI
            end;
        }
        field(50083; "Canceller ID"; Code[20])
        {
        }
        field(50084; "Cancellation Time"; Time)
        {
        }
        field(50086; "Blanket Order No. Series"; Code[10])
        {
            Description = 'TRI P.G 22.06.2009';
        }
        field(50087; "Tax Registration No."; Code[13])
        {
        }
        field(50088; "Inter Company"; Boolean)
        {
            Description = 'MS-PB';
        }
        field(50089; "Other Comp. Location"; Code[9])
        {
            Description = 'MS-PB';
            Enabled = false;
        }
        field(50090; "Direct Open Order"; Boolean)
        {
        }
        field(50091; "Old Order for Post"; Boolean)
        {
        }
        field(50092; "State Description"; Text[22])
        {
            CalcFormula = Lookup(State.Description WHERE(Code = FIELD(State)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50093; COCO; Boolean)
        {
            Description = 'Ori Ut 130710';
        }
        field(50094; "Elite Solution"; Boolean)
        {
            Description = 'Ori Ut 130710';
        }
        field(50095; "COCO Store"; Code[10])
        {
            Description = 'Ori Ut 130710';
            TableRelation = Location;

            trigger OnValidate()
            begin
                IF "COCO Store" <> '' THEN BEGIN
                    Location.GET("COCO Store");
                    IF Location."Is COCO" = TRUE THEN
                        "Posting No. Series" := Location."No. Series";
                END;
            end;
        }
        field(50096; "Make Order Date"; DateTime)
        {
            Description = 'Ori Ut 130710';
            Editable = false;
        }
        field(50097; "Order Created ID"; Text[50])
        {
            Description = 'Ori Ut 130710';
            Editable = false;
        }
        field(50098; "RELEASING DATETIME"; DateTime)
        {
            Description = 'Ori Ut 130710';
        }
        field(50099; "Order Date Time"; DateTime)
        {
            Description = 'Ori Ut 130710';
            Editable = false;
        }
        field(50100; "Outstanding Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                       "Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50101; "Reserved Qty(CRT)"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry".Quantity WHERE("Source ID" = FIELD("No.")));
            Description = 'Ori UT  241210';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50102; "Reserved Qty(SQM)"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry"."Quantity (Base)" WHERE("Source ID" = FIELD("No.")));
            Description = 'Ori UT  241210';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50103; "C-Form Date"; Date)
        {
            Description = 'Ori UT  280111';
        }
        field(50104; "TPT Method"; Option)
        {
            BlankNumbers = DontBlank;
            Description = 'Ori UT  280111';
            OptionCaption = ' ,Truck,Container, Party''s Vehicle,Tempo,Wagon';
            OptionMembers = " ",Truck,Container," Party's Vehicle",Tempo,Wagon;

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(50105; "Ship to Phone No."; Code[11])
        {
            Enabled = false;
        }
        field(50106; "Email ID"; Text[11])
        {
        }
        field(50107; "Calculate Discount"; Boolean)
        {
            Editable = true;
        }
        field(50108; "Transporter Code"; Code[10])
        {
        }
        field(50109; "ORC Terms"; Text[50])
        {
            Description = 'Ori Kulb 230113';
        }
        field(50110; "Excise Structure"; Boolean)
        {
            Description = 'MS-PB';
        }
        field(50111; "Road Permit"; Text[10])
        {
            Enabled = false;
        }
        field(50113; "Add Insu Discount"; Decimal)
        {

            trigger OnValidate()
            begin
                //VALIDATE(Structure); //sash
            end;
        }
        field(50114; "GR Value"; Decimal)
        {
        }
        field(50115; "CR Exception Type"; Option)
        {
            Enabled = false;
            OptionMembers = " ","No Exception",,"Dealer Undertaking","Over Due","Credit Limit","Over Due & Credit Limit";
        }
        field(50116; "CR Approved By"; Option)
        {
            Enabled = false;
            OptionMembers = " ","Approved by PSM"," Approved by Sales Head";
        }
        field(50117; Remarks; Text[100])
        {
        }
        field(50118; "Outstanding Qty"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE("Document Type" = FIELD("Document Type"),
                                                                            "Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50120; Selection1; Boolean)
        {

            trigger OnValidate()
            begin
                SalesLine.RESET;
                SalesLine.SETRANGE("Document Type", "Document Type");
                SalesLine.SETRANGE("Document No.", "No.");
                IF SalesLine.FIND('-') THEN
                    REPEAT
                        IF ((SalesLine."Quantity Shipped" = 0) AND (SalesLine."Quantity Invoiced" = 0)) THEN
                            IF (SalesLine."Quantity Shipped" <> SalesLine."Quantity Invoiced") THEN
                                ERROR('Qty Shipped must be equal to Invoiced');

                        IF (SalesLine."Quantity Shipped" <> 0) THEN
                            ERROR('Qty Already Shipped');

                    UNTIL SalesLine.NEXT = 0;
            end;
        }
        field(50125; "PCH Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Salesperson/Purchaser";
        }
        field(50126; "Govt./Private Sales Person"; Code[10])
        {
            Editable = false;
            TableRelation = "Salesperson/Purchaser";
        }
        field(50127; "Shortcut Dimension 8 Code"; Code[20])
        {
        }
        field(50128; "Reserved Qty"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry"."Quantity (Base)" WHERE("Source ID" = FIELD("No."),
                                                                            "Source Type" = CONST(37),
                                                                            "Source Subtype" = FIELD("Document Type"),
                                                                            "Reservation Status" = CONST(Reservation)));
            FieldClass = FlowField;
        }
        field(50129; "Payment Amount"; Decimal)
        {
            Enabled = false;
        }
        field(50130; "Payment Date1"; Date)
        {
            Enabled = false;
        } // 15578
        field(50131; "Order Booked Date"; DateTime)
        {
        }
        field(50132; "Approved By"; Code[10])
        {
            Description = 'Bank Account for PI';
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                IF SalespersonPurchaser.GET("Approved By") THEN
                    "Despatch Remarks" := SalespersonPurchaser.Name;
            end;
        }
        field(50133; "Confirmed Desc"; Text[30])
        {
            Description = 'Not In user';
        }
        field(50134; "Despatch Remarks"; Text[30])
        {
            TableRelation = "Reason Code" WHERE("Despatch Remarks" = CONST(true));

            trigger OnValidate()
            begin
                IF reas.GET("Despatch Remarks") THEN
                    "Despatch Remarks" := reas.Description;
            end;
        }
        field(50135; Commitment; Text[40])
        {
            TableRelation = "Reason Code" WHERE("SO Hold Reason" = CONST(true));
        }
        field(50137; "Payment Date 2"; Date)
        {
            Enabled = false;
        }
        field(50138; "Payment Amount 3"; Decimal)
        {
            Enabled = false;
        }
        field(50139; "Payment Date 3"; Date)
        {
            Description = 'Order Processing Date for Morbi';
        }
        field(50140; "Trade Discount"; Decimal)
        {

            /* trigger OnValidate()
             var
                StructureDetails: Record "13793";
                StructureOrderDetails: Record "13794";
             begin
                 IF "Trade Discount" <> xRec."Trade Discount" THEN BEGIN
                 IF "Trade Discount" > 0 THEN BEGIN
                     TESTFIELD(Structure);
                     StructureDetails.SETRANGE(Code, Structure);
                     StructureDetails.SETRANGE(StructureDetails."Tax/Charge Group", 'TRDDISC');
                     IF NOT StructureDetails.FINDFIRST THEN
                         ERROR('Please select the Trade Discount Structure');
                 END;
                 CheckCDUtilisation(Rec);
                 VALIDATE(Structure); //MSKS
                 StructureOrderDetails.RESET;
                 StructureOrderDetails.SETRANGE(StructureOrderDetails.Type, StructureOrderDetails.Type::Sale);
                 StructureOrderDetails.SETRANGE(StructureOrderDetails."Document Type", "Document Type");
                 StructureOrderDetails.SETRANGE(StructureOrderDetails."Document No.", "No.");
                 IF StructureOrderDetails.FINDFIRST THEN BEGIN
                     REPEAT
                         GLSetup.GET;
                         IF StructureOrderDetails."Tax/Charge Group" IN [GLSetup."Discount Charge"] THEN BEGIN
                             GLSetup.TESTFIELD("Discount Charge");
                             IF "Document Type" <> "Document Type"::"Credit Memo" THEN //TRI
                                 StructureOrderDetails."Calculation Value" := "Discount Charges %"
                         END ELSE
                             IF StructureOrderDetails."Tax/Charge Group" IN [GLSetup."Trade Discount Charge"] THEN BEGIN
                                 GLSetup.TESTFIELD("Trade Discount Charge");
                                 //MESSAGE(StructureOrderDetails."Tax/Charge Group");
                                 IF "Document Type" <> "Document Type"::"Credit Memo" THEN //TRI
                                     StructureOrderDetails."Calculation Value" := -1 * "Trade Discount"
                             END;

                         StructureOrderDetails.MODIFY;
                     UNTIL StructureOrderDetails.NEXT = 0;
                 END;

                 //END;
             end;*/ // 15578
        }
        field(50141; BD; Boolean)
        {
        }
        field(50142; GPS; Boolean)
        {
        }
        field(50144; "None"; Boolean)
        {
        }
        field(50145; "Business Development"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser" WHERE(Set = CONST(true));
        }
        field(50146; "Govt. Project Sales"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser" WHERE("G E T" = CONST(true));
        }
        field(50148; "Gross Wt (Ship)"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Gross Weight (Ship)" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50150; "Tonnage of Vehicle placed"; Code[2])
        {
            DataClassification = ToBeClassified;
            Description = 'OBL Executive';
        }
        field(50151; "Driver Phone No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'OBL Executive';
        }
        field(50152; "Driver Name"; Text[18])
        {
            DataClassification = ToBeClassified;
            Description = 'OBL Executive';
        }
        field(50153; "Estimated Date of Arrival"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'OBL Executive';
        }
        field(50154; "Transport Punch Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50200; "No. of Vehicle Notification"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'MIPL-Rohan 14.07.21';
        }
        field(60000; "D1 Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Discount Amt 1" WHERE("Document Type" = FIELD("Document Type"),
                                                                   "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60001; "D2 Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Discount Amt 2" WHERE("Document Type" = FIELD("Document Type"),
                                                                   "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60002; "D3 Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Discount Amt 3" WHERE("Document Type" = FIELD("Document Type"),
                                                                   "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60003; "D4 Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Discount Amt 4" WHERE("Document Type" = FIELD("Document Type"),
                                                                   "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60004; "Approval Pending At"; Option)
        {
            OptionCaption = ' ,PCH,ZM,PSM,PAC,Credit';
            OptionMembers = " ",PCH,ZM,PSM,PAC,Credit;
        }
        field(60006; "S1 Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line".S1 WHERE("Document Type" = FIELD("Document Type"),
                                                     "Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(60007; "D6 Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Discount Amt 6" WHERE("Document Type" = FIELD("Document Type"),
                                                                   "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60025; "CD Applicable"; Boolean)
        {
            InitValue = true;
        }
        field(60026; "Approval Required"; Boolean)
        {
            CalcFormula = Exist("Sales Line" WHERE("Document Type" = FIELD("Document Type"),
                                                    "Document No." = FIELD("No."),
                                                    "Approval Required" = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60028; "Secondry Sales Person"; Code[10])
        {
            Caption = 'Salesperson Code';
            Enabled = false;
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            begin
                "Secondry Sales Person" := "Salesperson Code";
            end;
        }
        field(60029; "CD Available for Utilisation"; Decimal)
        {
            CalcFormula = Sum("CD Entry"."CD Amount" WHERE("Cust. No." = FIELD("Sell-to Customer No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60030; "CD Availed from Utilisation"; Decimal)
        {
            /*  CalcFormula = Sum("Structure Order Line Details"."Amount (LCY)" WHERE(Type = CONST(Sale),
                                                                                     "Document Type" = FIELD("Document Type"),
                                                                                     "Document No." = FIELD("No."),
                                                                                     "Tax/Charge Group" = CONST(TRDDISC)));*/// 15578
            Editable = false;
            // FieldClass = FlowField;
        }
        field(60031; "Line Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Line Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60032; Updated; Boolean)
        {
        }
        field(60033; "Contribution Percentage"; Decimal)
        {
            InitValue = 100;
        }
        field(60034; CKA; Boolean)
        {
        }
        field(60035; "CKA Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser" WHERE(Pet = CONST(true));
        }
        field(60036; Retail; Boolean)
        {
        }
        field(60037; "Retail Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(60038; "Ship to Pin"; Code[6])
        {
            TableRelation = "Pin State Wise Mapping";

            trigger OnValidate()
            begin
                IF (STRLEN("Ship to Pin") > 6) THEN
                    ERROR('Pin No. Cannot Greator then Six Digit');

                IF shiptopin.GET("Ship to Pin") THEN
                    VALIDATE("GST Ship-to State Code", shiptopin."State Code");
            end;
        }
        field(60039; "ZH Code"; Code[10])
        {
            CalcFormula = Lookup(Customer."Zonal Head" WHERE("No." = FIELD("Sell-to Customer No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Salesperson/Purchaser";
        }
        field(60040; "PMT Code"; Code[15])
        {

            trigger OnValidate()
            begin
                IF (STRLEN("PMT Code") < 14) AND (STRLEN("PMT Code") > 15) THEN
                    ERROR('Please Enter Correct PMT Code');
            end;
        }
        field(60080; "Transfer No."; Code[20])
        {
            Description = 'MSVRN 13012020';
        }
        field(60081; "Loading Copies"; Integer)
        {
        }
        field(60082; "Order Change Remarks"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Order Change Remarks';
            TableRelation = "Reason Code" WHERE("Item Change Remarks" = CONST(true));
        }
        field(60090; "TCS On Collection Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60091; "Bypass Auto Order Process"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60092; "Direct Not Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60093; "InventoryNot Directly Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60094; "Credit Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60095; "Inventory Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60096; "Price Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60097; "Calculate Structure"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60302; "Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60303; "Calculate Insurance"; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(90003; "Structure Freight Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        /*  key(Key14; "LC No.")
          {
          }*/
        key(Key15;/* State,*/ "Sell-to Customer No.")
        {
        }
        key(Key16; "Sell-to Customer No.", "No.")
        {
        }
    }


    trigger OnBeforeDelete()
    var
        ArchiveManagement: Codeunit ArchiveManagement;
    begin
        //ND Tri Start Cust 38
        "Reason Code" := 'REASON9';
        //MODIFY; //MSBS.Rao 280314 Code Commited as requested by Mr. Kulbhushan Sharama
        //TRI

        ArchiveManagement.ArchiveSalesDocument(Rec); //MSKS
                                                     //TRI

        IF ("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::"Blanket Order") THEN
            TESTFIELD("Reason Code");
        IF "Document Type" = "Document Type"::Quote THEN
            UserAccess := 0;
        IF ("Document Type" = "Document Type"::Order) THEN
            UserAccess := 1;
        IF "Document Type" = "Document Type"::Invoice THEN
            UserAccess := 2;
        IF "Document Type" = "Document Type"::"Credit Memo" THEN
            UserAccess := 3;
        IF "Document Type" = "Document Type"::"Blanket Order" THEN
            UserAccess := 4;
        IF "Document Type" = "Document Type"::"Return Order" THEN
            UserAccess := 5;
        IF ("Document Type" = "Document Type"::Order) THEN
            UserAccess := 35;
        IF "Location Code" <> '' THEN BEGIN
            Permissions.Type(UserAccess, xRec."Location Code");
            Permissions.Type(UserAccess, "Location Code");
        END;
        //ND Tri End Cust 38

    end;


    trigger OnInsert()
    begin
        //ND Tri Start cust 38
        UserLocation.RESET;
        UserLocation.SETFILTER("User ID", USERID);
        IF "Document Type" = "Document Type"::Quote THEN
            UserLocation.SETFILTER(UserLocation."Create Sales Quote", '%1', TRUE);
        IF ("Document Type" = "Document Type"::Order) THEN
            UserLocation.SETFILTER(UserLocation."Create Sales Order", '%1', TRUE);
        IF "Document Type" = "Document Type"::Invoice THEN
            UserLocation.SETFILTER(UserLocation."Create Sales Invoice", '%1', TRUE);
        IF "Document Type" = "Document Type"::"Credit Memo" THEN
            UserLocation.SETFILTER(UserLocation."Create Sales Credit memo", '%1', TRUE);
        IF "Document Type" = "Document Type"::"Blanket Order" THEN
            UserLocation.SETFILTER(UserLocation."Create Sales Blanket Order", '%1', TRUE);
        IF "Document Type" = "Document Type"::"Return Order" THEN
            UserLocation.SETFILTER(UserLocation."Create Sales Return order", '%1', TRUE);

        IF UserLocation.FIND('-') THEN
            REPEAT
                IF UserSetup1.GET(UPPERCASE(USERID)) THEN;
                IF UserLocation.GET(UPPERCASE(USERID), UserSetup1.Location) THEN BEGIN
                    IF Location1.GET(UserLocation."Location Code") THEN
                        IF Location1."Main Location" = '' THEN
                            VALIDATE("Location Code", UserLocation."Location Code");
                END ELSE BEGIN
                    IF Location1.GET(UserLocation."Location Code") THEN
                        IF Location1."Main Location" = '' THEN
                            VALIDATE("Location Code", UserLocation."Location Code");
                END;
            UNTIL UserLocation.NEXT = 0;


        IF "Document Type" = "Document Type"::Quote THEN
            UserAccess := 0;
        IF ("Document Type" = "Document Type"::Order) THEN
            UserAccess := 1;
        IF "Document Type" = "Document Type"::Invoice THEN
            UserAccess := 2;
        IF "Document Type" = "Document Type"::"Credit Memo" THEN
            UserAccess := 3;
        IF "Document Type" = "Document Type"::"Blanket Order" THEN
            UserAccess := 4;
        IF "Document Type" = "Document Type"::"Return Order" THEN
            UserAccess := 5;
        IF ("Document Type" = "Document Type"::Order) THEN
            UserAccess := 35;

        Permissions.Type(UserAccess, "Location Code");

        IF Location.GET("Location Code") THEN
            IF Location."Main Location" <> '' THEN
                ERROR('You can not select Sub Locations.');

        //ND Tri End cust 38
        IF "Document Type" = "Document Type"::"Blanket Order" THEN
            "Posting Date" := TODAY
        ELSE
            "Posting Date" := 0D; //ND
        "Shipment Date" := 0D; //ND
        "Order Date" := TODAY;
        "Promised Delivery Date" := TODAY;
        "Requested Delivery Date" := TODAY;
        //"CR Exception Type" := "CR Exception Type"::"No Exception";
        //TRI
        IF "Document Type" <> "Document Type"::Order THEN
            VALIDATE("Sales Type", "Sales Type"::Govt);

        //TRI
        //MSAK
        IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
            VALIDATE("Releasing Date", TODAY);
        END;

        IF "Document Type" = "Document Type"::Order THEN BEGIN
            VALIDATE("Make Order Date", CURRENTDATETIME);
            "Order Created ID" := USERID;
        END;
        IF "Document Type" <> "Document Type"::"Blanket Order" THEN
            UpdatedforApp;

        //TRI START
        NoSeries.RESET;
        IF NoSeries.GET("No. Series") THEN BEGIN
            IF "Document Type" = "Document Type"::"Blanket Order" THEN
                NoSeries.TESTFIELD("Sales Order No. Series");
            "Sales Order No." := NoSeries."Sales Order No. Series";
            //TRI DG Start
            IF NoSeries."Posted Invoice No. Series" <> '' THEN
                "Posting No. Series" := NoSeries."Posted Invoice No. Series";
            //TRI DG End
            //MSBS.Rao Start 300914
            IF "Document Type" = "Document Type"::Order THEN
                "Group Code" := NoSeries."Group Code";
            //MSBS.Rao Stop 300914
        END;

    end;


    trigger OnModify()
    begin
        //ND Tri Start Cust 38
        IF "Document Type" = "Document Type"::Quote THEN
            UserAccess := 0;
        IF "Document Type" = "Document Type"::Order THEN
            UserAccess := 1;
        IF "Document Type" = "Document Type"::Invoice THEN
            UserAccess := 2;
        IF "Document Type" = "Document Type"::"Credit Memo" THEN
            UserAccess := 3;
        IF "Document Type" = "Document Type"::"Blanket Order" THEN
            UserAccess := 4;
        IF "Document Type" = "Document Type"::"Return Order" THEN
            UserAccess := 5;
        IF ("Document Type" = "Document Type"::Order) THEN
            UserAccess := 35;
        Permissions.Type(UserAccess, xRec."Location Code");
        Permissions.Type(UserAccess, "Location Code");
        //ND Tri End Cust 38
        UpdatedforApp;

    end;
    //Unsupported feature: Code Modification on "InitInsert(PROCEDURE 61)".Function call Page Ext sales Header

    //procedure InitInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "No." = '' THEN BEGIN
      TestNoSeries;
      NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date","No.","No. Series");
    END;
    CompanyInfo.GET;
    Trading := CompanyInfo."Trading Co.";
    InitRecord;
    GSTManagement.UpdateInvoiceType(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    //TRI START
    NoSeries.RESET;
    IF NoSeries.GET("No. Series") THEN
     BEGIN
     IF "Document Type" = "Document Type"::"Blanket Order" THEN
       NoSeries.TESTFIELD("Sales Order No. Series");
      "Sales Order No." := NoSeries."Sales Order No. Series";
      //TRI DG Start
      IF  NoSeries."Posted Invoice No. Series"<>'' THEN
        "Posting No. Series" := NoSeries."Posted Invoice No. Series";
      //TRI DG End
      //MSBS.Rao Start 300914
      IF "Document Type" = "Document Type"::Order THEN
        "Group Code" := NoSeries."Group Code";
      //MSBS.Rao Stop 300914
     END;
    "TCS On Collection Entry" := NoSeries."TCS On Collection Entry"; //MSKS
    #5..8
    */
    //end;

    //Unsupported feature: Code Modification on "CalculateGSTStructure(PROCEDURE 1500009)".// Function N/F

    //procedure CalculateGSTStructure();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesHeader.CALCFIELDS("Price Inclusive of Taxes");
    IF SalesHeader."Price Inclusive of Taxes" THEN BEGIN
      SalesLine.InitStrOrdDetail(SalesHeader);
    #4..7
    SalesLine.CalculateStructures(SalesHeader);
    SalesLine.AdjustStructureAmounts(SalesHeader);
    SalesLine.UpdateSalesLines(SalesHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SalesHeader.CALCFIELDS("Price Inclusive of Taxes",SalesHeader."CD Available for Utilisation",SalesHeader.Amount); //MSKS
    //IF SalesHeader.Amount > (SalesHeader."CD Available for Utilisation" *2) THEN
      SalesHeader.VALIDATE("Trade Discount", SalesHeader."CD Available for Utilisation");
    #1..10
    */
    //end;


    //Unsupported feature: Code Modification on "InitSellToCustFromCustomer(PROCEDURE 1500010)".// Function N/F

    //procedure InitSellToCustFromCustomer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH SalesHeader DO BEGIN
      Cust.CheckBlockedCustOnDocs(Cust,"Document Type",FALSE,FALSE);
      Cust.TESTFIELD("Gen. Bus. Posting Group");
    #4..6
      "Sell-to Address" := Cust.Address;
      "Sell-to Address 2" := Cust."Address 2";
      "Sell-to City" := Cust.City;
      "Sell-to Post Code" := Cust."Post Code";
      "Sell-to County" := Cust.County;
      "Sell-to Country/Region Code" := Cust."Country/Region Code";
      "Nature of Services" := Cust."Nature of Services";
      IF NOT SkipSellToContact THEN
        "Sell-to Contact" := Cust.Contact;
      "Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
      "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
      "Tax Liable" := Cust."Tax Liable";
      "VAT Registration No." := Cust."VAT Registration No.";
      "VAT Country/Region Code" := Cust."Country/Region Code";
      "Shipping Advice" := Cust."Shipping Advice";
      IF "GST Customer Type" IN ["GST Customer Type"::"Deemed Export","GST Customer Type"::Export,
        "GST Customer Type"::"SEZ Development","GST Customer Type"::"SEZ Unit"] THEN
        State := ''
    #25..28
        "VAT Exempted" := Cust."VAT Exempted";
      Structure := Cust.Structure;
      "Excise Bus. Posting Group" := Cust."Excise Bus. Posting Group";
      CheckShipToCustomer;
      CheckShipToCode;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
    //  "Sell-to Post Code" := Cust."Post Code";
      VALIDATE("Sell-to Post Code",Cust."Post Code");
    #11..13
      //ND START
      IF Location1.GET("Location Code") THEN
        IF Location1."Customer Price Group" <> '' THEN
          "Customer Price Group" := Location1."Customer Price Group";
    //ND END

    //TRIRJ ORIENT6.0 01-11-08:Start
      "Tax Registration No." := Cust."T.I.N. No.";
      Pay:=Cust.Pay;
    //TRIRJ ORIENT6.0 01-11-08:END


    #14..21
      //cust 22 start ravi
      "Customer Type" := Cust."Customer Type";
      "Security Amount" := Cust."Security Amount";
      "Security Date" := Cust."Security Date";
      //cust 22 end ravi
      "Form Code" := Cust."Form Code"; //Vipul Tri1.0
    #22..31
        // NAVIN
      VALIDATE(State,Cust."State Code");
      "GST Ship-to State Code" :=  Cust."State Code";
      // "Tax Area Code" := Cust."Tax Area Code";
      //"VAT Business Posting Group" := Cust."VAT Business Posting Group";

      //
      //Kulbhushan
      Structure := Cust.Structure;
      VALIDATE(Structure);
      //kulbhushan
       //NAVIN
    //Upgrade
    "Form Code" := Cust."Form Code"; //Vipul Tri1.0
    //"Sell-to Contact No.":=Cust."Phone No."; //msvc

    "Tax Liable" := Cust."Tax Liable";
    "VAT Registration No." := Cust."VAT Registration No.";
    "VAT Country/Region Code" := Cust."Country/Region Code";
    "Shipping Advice" := Cust."Shipping Advice";
    //VALIDATE(State,Cust."State Code");
    //IF "GST Customer Type" IN ["GST Customer Type"::"Deemed Export","GST Customer Type"::Export] THEN
    //  State := ''
    //ELSE
    State := Cust."State Code";
    Structure := Cust.Structure;
    "Excise Bus. Posting Group" := Cust."Excise Bus. Posting Group";
    //Upgrade
    #32..34
    */
    //end;


    //Unsupported feature: Code Modification on "InitBillToCustFromCustomer(PROCEDURE 1500011)".// Function N/F

    //procedure InitBillToCustFromCustomer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH SalesHeader DO BEGIN
      "Bill-to Customer Template Code" := '';
      "Bill-to Name" := Cust.Name;
      "Bill-to Name 2" := Cust."Name 2";
      "Bill-to Address" := Cust.Address;
      "Bill-to Address 2" := Cust."Address 2";
      "Bill-to City" := Cust.City;
      "Bill-to Post Code" := Cust."Post Code";
      "Bill-to County" := Cust.County;
      "Bill-to Country/Region Code" := Cust."Country/Region Code";
      IF NOT SkipBillToContact THEN
        "Bill-to Contact" := Cust.Contact;
      "Payment Terms Code" := Cust."Payment Terms Code";
      "Prepmt. Payment Terms Code" := Cust."Payment Terms Code";

      IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
        "Payment Method Code" := '';
        IF PaymentTerms.GET("Payment Terms Code") THEN
          IF PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" THEN
            "Payment Method Code" := Cust."Payment Method Code"
      END ELSE
        "Payment Method Code" := Cust."Payment Method Code";

      GLSetup.GET;
      IF GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Bill-to/Pay-to No." THEN BEGIN
        "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
        "VAT Country/Region Code" := Cust."Country/Region Code";
        "VAT Registration No." := Cust."VAT Registration No.";
        "Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
      END;
      "Customer Posting Group" := Cust."Customer Posting Group";
      "Currency Code" := Cust."Currency Code";
      "Customer Price Group" := Cust."Customer Price Group";
      "Prices Including VAT" := Cust."Prices Including VAT";
      "Allow Line Disc." := Cust."Allow Line Disc.";
      "Invoice Disc. Code" := Cust."Invoice Disc. Code";
      "Customer Disc. Group" := Cust."Customer Disc. Group";
      "Language Code" := Cust."Language Code";
      "Salesperson Code" := Cust."Salesperson Code";
      "Combine Shipments" := Cust."Combine Shipments";
      Reserve := Cust.Reserve;
      "GST Customer Type" := Cust."GST Customer Type";
      "Post GST to Customer" := Cust."Post GST to Customer";
      IF "GST Customer Type" = "GST Customer Type"::Unregistered THEN
        "Nature of Supply" := "Nature of Supply"::B2C
      ELSE
        "Nature of Supply" := "Nature of Supply"::B2B;
      IF "Document Type" = "Document Type"::Order THEN
        "Prepayment %" := Cust."Prepayment %";
      IF NODHeader.GET(NODHeader.Type::Customer,"Bill-to Customer No.") THEN
        VALIDATE("Assessee Code",NODHeader."Assesse Code")
      ELSE
        VALIDATE("Assessee Code",'');
      IF BilltoCustomerNoChanged THEN BEGIN
        VALIDATE("Applies-to Doc. Type","Applies-to Doc. Type"::" ");
        VALIDATE("Applies-to Doc. No.",'');
        VALIDATE("Applies-to ID",'');
      END;
      CheckShipToCustomer;
      CheckShipToCode;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..42
    #44..49
      //ND START
      IF Location1.GET("Location Code") THEN
        IF Location1."Customer Price Group" <> '' THEN
          "Customer Price Group" := Location1."Customer Price Group";
      // mo tri1.0 start
      "Salesperson Description" := Cust."Salesperson Description";
      IF SalespersonPurchaser.GET("Salesperson Code") THEN
        "Salesperson Description" := SalespersonPurchaser.Name;
      //mo tri1.0 end

      //ND END

    #59..61
    */
    //end;

    procedure "---NAVIN---"()
    begin
    end;

    procedure CheckSaleLineForOtherIncentive(CheckFor: Option "Advance License",EPCG)
    var
        ErrorText: Label 'Incentive for Item No. %1 in Sales Line Line No. %2 must be blank if Export Order is to be applied for %3';
        SL: Record "Sales Line";
    begin
        /*
SL.RESET;
SL.SETRANGE("Document Type","Document Type");
SL.SETRANGE("Document No.","No.");
SL.SETRANGE(Type,SL.Type::Item);
SL.SETFILTER("Incentive Type",'>0');

IF SL.FIND('-') THEN
ERROR(ErrorText,SL."No.",SL."Line No.",CheckFor);
         *///TRIRJ

    end;

    procedure CreateSampleOrder(var SampleOrder: Record "Sample Order")
    var
        LineNo: Integer;
        SampleOrder1: Record "Sample Order";
    begin
        //mo tri1.0 Customization no.15 start
        /*SalesSetup.GET;
        SalesSetup.TESTFIELD(SalesSetup."Posted Shipment Nos.");
        SalesSetup.TESTFIELD(SalesSetup."Posted Invoice Nos.");
        SalesHeader1.INIT;
        IF SalesHeader1."No." = '' THEN BEGIN
          TestNoSeries;
          NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date",SalesHeader1."No.",SalesHeader1."No. Series");
        END;
        SalesHeader1.VALIDATE("Document Type","Document Type"::Order);
        SalesHeader1.VALIDATE("Clubbed With SO","No.");
        SalesHeader1.VALIDATE("Posting Date","Posting Date");
        SalesHeader1.VALIDATE("Document Date","Document Date");
        SalesHeader1.VALIDATE("Order Date","Order Date");
        SalesHeader1.VALIDATE("User ID","User ID");
        SalesHeader1.VALIDATE("Sell-to Customer No.",SampleOrder."Customer No.");
        SalesHeader1.VALIDATE(SalesHeader1."Shipping No. Series",SalesSetup."Posted Shipment Nos.");
        SalesHeader1.VALIDATE(SalesHeader1."Posting No. Series",SalesSetup."Posted Invoice Nos.");
        SalesHeader1.INSERT;
        LineNo := 10000;
        IF SampleOrder.FIND('-') THEN
        REPEAT
          SalesLine1.INIT;
          SalesLine1.VALIDATE("Document Type","Document Type"::Order);
          SalesLine1.VALIDATE("Document No.",SalesHeader1."No.");
          SalesLine1.VALIDATE("Line No.",LineNo);
          SalesLine1.VALIDATE("Sell-to Customer No.",SampleOrder."Customer No.");
          SalesLine1.VALIDATE(Type,SalesLine1.Type::Item);
          SalesLine1.VALIDATE("No.",SampleOrder."Item No.");
          SalesLine1.VALIDATE(Quantity,SampleOrder.Quantity);
          SalesLine1.VALIDATE("Location Code",SampleOrder."Location Code");
          SalesLine1."Unit of Measure Code" := SampleOrder."Unit Of Measure";
          SalesLine1.INSERT;
          SampleOrder.VALIDATE("SO No.",SalesHeader1."No.");
          SampleOrder.VALIDATE("SO Date","Posting Date");
          SampleOrder.VALIDATE("SO Created",TRUE);
          SampleOrder.MODIFY;
          LineNo := LineNo + 10000;
        UNTIL SampleOrder.NEXT = 0;
        MESSAGE(Text0001,SampleOrder."SO No.","Sell-to Customer No.");
        //mo tri1.0 Customization no.15 end
         *///TRIRJ

    end;

    procedure CheckQDApplicableforCustomer()
    begin
        SalesSetup.GET;
        IF SalesSetup."QD Applicable" = TRUE THEN BEGIN

            RecCustGrp.RESET;
            RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::Customer);
            RecCustGrp.SETRANGE(Code, "Sell-to Customer No.");
            RecCustGrp.SETRANGE(Status, RecCustGrp.Status::Enable);
            RecCustGrp.SETFILTER("Valid From", '<=%1', "Posting Date");
            RecCustGrp.SETFILTER("Valid To", '>=%1', "Posting Date");
            IF RecCustGrp.FINDFIRST THEN BEGIN
                ExcludeCustomer := QDFunctions.TestCustApplicableExclude(Rec);
                /*IF ExcludeCustomer=FALSE THEN
                "Calculate Discount":=FALSE
                ELSE
                "Calculate Discount":=TRUE;
                */
            END;

            ExcludeCustomer := QDFunctions.TestCustApplicableExclude(Rec);
            ExcludeState := QDFunctions.TestStateApplicableExclude(Rec);
            ExcludeCustomerType := QDFunctions.TestCustTypeApplicableExclude(Rec);
            /*
            RecCustGrp.RESET;
            RecCustGrp.SETRANGE("Group Type",RecCustGrp."Group Type"::State);
            RecCustGrp.SETRANGE(Code,State); //MSKS0207
            RecCustGrp.SETRANGE(Status,RecCustGrp.Status::Enable);
            RecCustGrp.SETFILTER("Valid From",'<=%1',"Posting Date");
            RecCustGrp.SETFILTER("Valid To",'>=%1',"Posting Date");
            IF RecCustGrp.FINDFIRST THEN BEGIN
              ExcludeState:=QDFunctions.TestStateApplicableExclude(Rec);
              ExcludeCustomerType:=QDFunctions.TestCustTypeApplicableExclude(Rec);
            */
            IF (ExcludeState = FALSE) AND (ExcludeCustomerType = TRUE) THEN
                "Calculate Discount" := FALSE;

            IF (ExcludeState = TRUE) AND (ExcludeCustomerType = FALSE) THEN
                "Calculate Discount" := FALSE;

            IF (ExcludeState = FALSE) AND (ExcludeCustomerType = FALSE) THEN
                "Calculate Discount" := FALSE;

            IF (ExcludeState = TRUE) AND (ExcludeCustomerType = TRUE) AND ExcludeCustomer THEN
                "Calculate Discount" := TRUE;

            //  MESSAGE('State %1- Type %2- Group %3',ExcludeState,ExcludeCustomerType,ExcludeCustomer);
            //END;
        END;
        //Shakti-END;

    end;

    /* procedure CheckStructure()
     var
         RecShipAgent: Record 291;
         // 15578  RecStructureLine: Record "13793";
         Text0001: Label 'Please select the Insurance in Structure.....';
         RecLocation: Record Location;
     begin
         IF ("Customer Type" <> 'COCO') THEN
             IF ("Free Supply" = FALSE) THEN BEGIN //Kulwant Singh 11/03/13


                 IF RecLocation.GET("Location Code") THEN BEGIN
                     IF RecLocation.Plant THEN BEGIN
                         RecShipAgent.RESET;
                         IF RecShipAgent.GET("Shipping Agent Code") THEN
                             //IF RecShipAgent."Insurance Applicable" THEN BEGIN
                             RecStructureLine.RESET;
                         RecStructureLine.SETRANGE(Code, Structure);
                         RecStructureLine.SETRANGE(Type, RecStructureLine.Type::Charges);
                         RecStructureLine.SETRANGE("Charge Type", RecStructureLine."Charge Type"::Insurance);
                         IF NOT RecStructureLine.FINDFIRST THEN BEGIN
                             ERROR(Text0001);
                         END;
                         //END;
                     END ELSE BEGIN
                         RecShipAgent.RESET;
                         IF RecShipAgent.GET("Shipping Agent Code") THEN
                             IF RecShipAgent."Insurance Applicable" THEN BEGIN
                                 RecStructureLine.RESET;
                                 RecStructureLine.SETRANGE(Code, Structure);
                                 RecStructureLine.SETRANGE(Type, RecStructureLine.Type::Charges);
                                 RecStructureLine.SETRANGE("Charge Type", RecStructureLine."Charge Type"::Insurance);
                                 IF NOT RecStructureLine.FINDFIRST THEN BEGIN
                                     ERROR(Text0001);
                                 END;
                             END;
                     END;
                 END;

             END;
     end;*/ // 15578

    procedure "--MSBS.Rao---"()
    begin
    end;

    procedure CheckExciseStructure()
    var
        MSSalesLine: Record "Sales Line";
        MS00001: Label 'You Can Not Select Excise Structure for Document No. %1 , Item No. %2 in Line No. %3';
    begin
        //MSBS.Rao Start-0713
        //Kulbhushan
        IF "Document Type" IN ["Document Type"::Order, "Document Type"::"Blanket Order"] THEN
            MSSalesLine.SETFILTER("Document Type", '%1', "Document Type");
        MSSalesLine.SETRANGE("Document No.", "No.");
        //MSSalesLine.SETRANGE("Location Code","Location Code");
        MSSalesLine.SETFILTER("Item Category Code", '%1|%2|%3|%4', 'M001', 'H001', 'D001', 'T001');
        IF MSSalesLine.FINDFIRST THEN BEGIN
            REPEAT
                IF (MSSalesLine."Item Category Code" = 'T001') AND (MSSalesLine."Location Code" <> 'DP-MORBI') THEN
                    IF "Excise Structure" THEN
                        ERROR(MS00001, MSSalesLine."Document No.", MSSalesLine."No.", MSSalesLine."Line No.");

                CASE "Location Code" OF
                    'PLANT':
                        BEGIN
                            IF (MSSalesLine."Location Code" = 'WAREHOUSE') THEN BEGIN
                                IF NOT "Excise Structure" THEN
                                    ERROR(MS00001, MSSalesLine."Document No.", MSSalesLine."No.", MSSalesLine."Line No.");
                            END ELSE BEGIN
                                IF "Excise Structure" THEN
                                    ERROR(MS00001, MSSalesLine."Document No.", MSSalesLine."No.", MSSalesLine."Line No.");
                            END;
                        END;
                    'PLANT-HSK':
                        BEGIN
                            IF MSSalesLine."Location Code" = 'WH-HOSKOTE' THEN BEGIN
                                IF NOT "Excise Structure" THEN
                                    ERROR(MS00001, MSSalesLine."Document No.", MSSalesLine."No.", MSSalesLine."Line No.");
                            END ELSE BEGIN
                                IF "Excise Structure" THEN
                                    ERROR(MS00001, MSSalesLine."Document No.", MSSalesLine."No.", MSSalesLine."Line No.");
                            END;
                        END;
                    'PLANT-DORA':
                        BEGIN
                            IF MSSalesLine."Location Code" = 'WH-DORA' THEN BEGIN
                                IF NOT "Excise Structure" THEN
                                    ERROR(MS00001, MSSalesLine."Document No.", MSSalesLine."No.", MSSalesLine."Line No.");
                            END ELSE BEGIN
                                IF "Excise Structure" THEN
                                    ERROR(MS00001, MSSalesLine."Document No.", MSSalesLine."No.", MSSalesLine."Line No.");
                            END;
                        END;
                END;
            UNTIL MSSalesLine.NEXT = 0;
        END;
        //MSBS.Rao Stop-0713
    end;

    procedure UpdateSalesPerson()
    var
        RecCust: Record Customer;
    begin
        TESTFIELD(Status, Status::Open);
        IF RecCust.GET("Sell-to Customer No.") THEN;
        "Govt./Private Sales Person" := '';

        CASE "Sales Type" OF
            "Sales Type"::Govt:
                "Govt./Private Sales Person" := RecCust."Govt. SP Resp.";
            "Sales Type"::Private:
                "Govt./Private Sales Person" := RecCust."Private SP Resp.";

        /*
        IF "Sales Type"= "Sales Type"::G then
        "Govt./Private Sales Person" :=  RecCust."Govt. SP Resp.";
        IF "Sales Type"= "Sales Type"::P then
        "Govt./Private Sales Person" :=  RecCust."Private SP Resp.";
        */
        END;
        "PCH Code" := RecCust."PCH Code";
        /*
        SalesLine.SETRANGE("Document Type","Document Type");
        SalesLine.SETRANGE("Document No.","No.");
        SalesLine.SETRANGE(Type,SalesLine.Type::Item);
        IF SalesLine.FINDFIRST THEN BEGIN
          REPEAT
           SalesLine."Sales Type" := "Sales Type";
           SalesLine.MODIFY;
          UNTIL SalesLine.NEXT=0;
        END;
        */

    end;

    procedure CDAllowed() CDALLOWED: Boolean
    begin
        IF PostCode.GET("Sell-to Post Code", "Sell-to City") THEN BEGIN
            CDALLOWED := PostCode."CD Not Allowed";
        END;
        EXIT(CDALLOWED);
    end;

    procedure ReleaseOrder()
    begin
        TESTFIELD(Status, Status::"Price Approved");
        IF CONFIRM('Do you want to Release the Order', FALSE) THEN BEGIN
            Status := Status::Released;
            MODIFY;
        END;
    end;

    procedure ReopenOrder()
    begin
        IF CONFIRM('Do you want to Re-Open the Order', FALSE) THEN BEGIN
            SalesLine.RESET;
            SalesLine.SETRANGE("Document Type", "Document Type");
            SalesLine.SETRANGE("Document No.", "No.");
            SalesLine.SETFILTER("Quantity Shipped", '<>%1', 0);
            IF SalesLine.FINDFIRST THEN
                ERROR('Order already shipped not allowed');
            Status := Status::Open;
            "Approval Pending At" := 0;
            MODIFY;
            CancelApprovalEntries("No.");
        END;
    end;

    procedure SendForApproval()
    var
        SalesLines: Record "Sales Line";
        RecCustomer: Record Customer;
        SmsMgt: Codeunit "SMS Sender - Due Date";
    begin
        SalesSetup.GET;
        CLEAR(SmsMgt);
        CALCFIELDS("D1 Amount", "D2 Amount", "D3 Amount", "D4 Amount", "Approval Required");
        IF NOT "Approval Required" THEN BEGIN
            Status := Status::"Price Approved";
            MODIFY;
            SendIntimation;
            SmsMgt.CreateMsgOnDApriceApproved(Rec); //MSKS2707
            EXIT;
        END;
        IF OpenApprovalEntryExist("No.") THEN EXIT;
        //TESTFIELD(Status,Status::Open);

        //IF NOT (Status IN [Status::Open,Status::"Credit Approved",Status::"Not in Inventory"]) THEN
        //  ERROR('Status Must be Open or Credit Approved');

        SmsMgt.CreateMsgOnDABooked(Rec); //MSKS2707

        IF "D1 Amount" <> 0 THEN
            SalesSetup.TESTFIELD("D1 Approval Limit");
        IF "D2 Amount" <> 0 THEN
            SalesSetup.TESTFIELD("D2 Approval Limit");
        IF "D3 Amount" <> 0 THEN
            SalesSetup.TESTFIELD("D3 Approval Limit");
        IF "D4 Amount" <> 0 THEN
            SalesSetup.TESTFIELD("D4 Approval Limit");

        IF "D1 Amount" > 0 THEN BEGIN
            MakeApprovalEntries(0, "D1 Amount");
        END;
        IF "D2 Amount" <> 0 THEN
            MakeApprovalEntries(1, "D2 Amount");

        IF "D3 Amount" <> 0 THEN
            MakeApprovalEntries(2, "D3 Amount");

        IF "D4 Amount" <> 0 THEN
            MakeApprovalEntries(3, "D4 Amount");

        //IF (("D1 Amount"+"D2 Amount"+"D3 Amount"+"D4 Amount") <=0) THEN
        Status := Status::"Pending Approval";
        //END;
        MODIFY;

        IF "D1 Amount" > 0 THEN BEGIN
            CLEAR(MailMgt);
            IF RecCustomer.GET("Sell-to Customer No.") THEN BEGIN
                MailMgt.CreateMailForPO(Rec, RecCustomer."PCH Code");
            END;
        END;
    end;

    procedure MakeApprovalEntries(ApprovalType: Option PCH,ZM,PSM,PAC; DiscountAmt: Decimal)
    var
        RecCustomer: Record Customer;
        RecSalesPerson: Record "Salesperson/Purchaser";
    begin
        CASE ApprovalType OF
            ApprovalType::PCH:
                BEGIN
                    IF RecCustomer.GET("Sell-to Customer No.") THEN BEGIN
                        RecCustomer.TESTFIELD("PCH Code");
                        MakeApprovalEntry("Salesperson Code", RecCustomer."PCH Code", DiscountAmt);
                    END;
                END;
            ApprovalType::ZM:
                BEGIN
                    IF RecCustomer.GET("Sell-to Customer No.") THEN BEGIN
                        RecCustomer.TESTFIELD("Zonal Manager");
                        MakeApprovalEntry("Salesperson Code", RecCustomer."Zonal Manager", DiscountAmt);
                    END;
                END;
            ApprovalType::PSM:
                BEGIN
                    SalesSetup.GET;
                    SalesSetup.TESTFIELD("PSM Code");
                    RecCustomer.GET("Sell-to Customer No.");
                    IF RecCustomer."Zonal Head" <> '' THEN
                        MakeApprovalEntry("Salesperson Code", RecCustomer."Zonal Head", DiscountAmt)
                    ELSE
                        MakeApprovalEntry("Salesperson Code", SalesSetup."PSM Code", DiscountAmt);
                END;
            ApprovalType::PAC:
                BEGIN
                    RecSalesPerson.RESET;
                    RecSalesPerson.SETRANGE(Type, RecSalesPerson.Type::PAC);
                    IF RecSalesPerson.FINDFIRST THEN
                        REPEAT
                            MakeApprovalEntry("Salesperson Code", RecSalesPerson.Code, DiscountAmt);
                        UNTIL RecSalesPerson.NEXT = 0;
                END;

        END;
    end;

    procedure MakeApprovalEntry(SenderSPCode: Code[20]; ApprovalSPCode: Code[20]; DiscountAmt: Decimal)
    var
        ApprovalEntry: Record "Approval Entry";
        // 15578  ApprovalSetup: Record "Approval Setup";
        EntryNo: Integer;
        SalesHeader: Record "Sales Header";
        LastEmailID: Text;
    begin
        WITH ApprovalEntry DO BEGIN
            ApprovalEntry.RESET;
            IF ApprovalEntry.FINDLAST THEN
                EntryNo := ApprovalEntry."Entry No.";

            SETRANGE("Table ID", 36);
            SETRANGE("Document Type", "Document Type"::Order);
            SETRANGE("Document No.", "No.");
            IF FINDLAST THEN BEGIN
                NewSequenceNo := "Sequence No." + 1;
                LastEmailID := EmailID;
            END ELSE
                NewSequenceNo := 1;
            "Entry No." := EntryNo + 1;
            "Table ID" := 36;
            "Document Type" := "Document Type"::Order;
            "Document No." := "No.";
            "Salespers./Purch. Code" := SenderSPCode;
            "Sequence No." := NewSequenceNo;
            "Approval Code" := 'S-ORDER';
            "Sender ID" := USERID;
            Amount := DiscountAmt;
            "Amount (LCY)" := DiscountAmt;
            Status := Status::Created;
            "Currency Code" := "Currency Code";
            "Date-Time Sent for Approval" := CREATEDATETIME(TODAY, TIME);
            "Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
            "Last Modified By ID1" := USERID;
            // 15578    "Due Date" := CALCDATE(ApprovalSetup."Due Date Formula", TODAY);
            ApprovalSPCode := GetNextSalesPersonIFOnLeave(ApprovalSPCode); //MSKS2007
            ApprovalEntry."Approver Code" := ApprovalSPCode;
            ApprovalEntry."Comment Text" := '';
            //MSKS1705 Start
            IF SalespersonPurchaser.GET(ApprovalSPCode) THEN
                IF SalespersonPurchaser."E-Mail" <> '' THEN
                    ApprovalEntry.EmailID := SalespersonPurchaser."E-Mail";
            //MSKS1705 End

            //  "Approval Type" := ApprovalTemplates."Approval Type";
            //  "Limit Type" := ApprovalTemplates."Limit Type";
            SalesHeader.RESET;
            SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
            SalesHeader.SETRANGE("No.", "No.");
            IF SalesHeader.FINDFIRST THEN
                ApprovalEntry."Record ID to Approve" := SalesHeader.RECORDID;
            IF LastEmailID <> ApprovalEntry.EmailID THEN
                INSERT(TRUE);
        END;
    end;

    procedure CancelApprovalEntries(DocNo: Code[20])
    var
        ApprovalEntries: Record "Approval Entry";
    begin
        ApprovalEntries.RESET;
        ApprovalEntries.SETRANGE(ApprovalEntries."Table ID", 36);
        ApprovalEntries.SETRANGE(ApprovalEntries."Document Type", ApprovalEntries."Document Type"::Order);
        ApprovalEntries.SETRANGE("Document No.", DocNo);
        IF ApprovalEntries.FINDFIRST THEN BEGIN
            REPEAT
                ApprovalEntries.VALIDATE(Status, ApprovalEntries.Status::Canceled);
                ApprovalEntries.MODIFY;
            UNTIL ApprovalEntries.NEXT = 0;
        END;
    end;

    procedure SendIntimation()
    var
        SP: Record "Salesperson/Purchaser";
        RecCustomer: Record Customer;
    begin
        IF RecCustomer.GET("Sell-to Customer No.") THEN BEGIN
            CALCFIELDS("D1 Amount", "D2 Amount", "D3 Amount", "D4 Amount", "Approval Required");
            //Sales Person Mail
            IF "D1 Amount" <> 0 THEN
                IF SP.GET(RecCustomer."Salesperson Code") THEN BEGIN
                    IF SP."E-Mail" <> '' THEN
                        MailMgt.CreateMailForCreator(Rec, SP."E-Mail");
                END;
            //PCH
            IF "D1 Amount" <> 0 THEN
                IF SP.GET("PCH Code") THEN BEGIN
                    IF SP."E-Mail" <> '' THEN
                        MailMgt.CreateMailForCreator(Rec, SP."E-Mail");
                END;
            //Zonal
            IF "D2 Amount" <> 0 THEN
                IF SP.GET(RecCustomer."Zonal Manager") THEN BEGIN
                    IF SP."E-Mail" <> '' THEN
                        MailMgt.CreateMailForCreator(Rec, SP."E-Mail");
                END;
            //PSM
            IF "D3 Amount" <> 0 THEN BEGIN
                SalesSetup.GET;
                SalesSetup.TESTFIELD("PSM Code");
                RecCustomer.GET("Sell-to Customer No.");
                IF RecCustomer."Zonal Head" <> '' THEN BEGIN
                    IF SP.GET(RecCustomer."Zonal Head") THEN BEGIN
                        IF SP."E-Mail" <> '' THEN
                            MailMgt.CreateMailForCreator(Rec, SP."E-Mail");
                    END;
                END ELSE BEGIN
                    IF SP.GET(SalesSetup."PSM Code") THEN BEGIN
                        IF SP."E-Mail" <> '' THEN
                            MailMgt.CreateMailForCreator(Rec, SP."E-Mail");
                    END;
                END;
            END;
        END;
    end;

    procedure GetNextSalesPersonIFOnLeave(SPcode: Code[10]) FirstValidSPCode: Code[10]
    var
        i: Integer;
        RecSalesPerson: Record "Salesperson/Purchaser";
        SPLeave: Record "Sales Person Leave Details";
    begin
        SPLeave.RESET;
        SPLeave.SETFILTER("Sales Person Code", '%1', SPcode);
        SPLeave.SETFILTER(SPLeave.Date, '%1', TODAY);
        IF NOT SPLeave.FINDFIRST THEN
            EXIT(SPcode);

        SPLeave.RESET;
        SPLeave.SETFILTER("Sales Person Code", '%1', SPcode);
        SPLeave.SETFILTER(SPLeave.Date, '%1', TODAY);
        IF SPLeave.FINDFIRST THEN BEGIN
            IF RecSalesPerson.GET(SPcode) THEN
                IF RecSalesPerson."Sub-Ordinate (Leave)" <> '' THEN BEGIN
                    IF GetNextSalesPersonIFOnLeave(RecSalesPerson."Sub-Ordinate (Leave)") = SPcode THEN BEGIN
                        EXIT(RecSalesPerson."Sub-Ordinate (Leave)")
                    END ELSE BEGIN
                        EXIT(GetNextSalesPersonIFOnLeave(RecSalesPerson."Sub-Ordinate (Leave)"));
                    END;
                END ELSE
                    EXIT(SPcode);
        END;

        //MESSAGE('%1-%2',SPcode,RecSalesPerson."Sub-Ordinate (Leave)");
    end;

    //TEAM 14763
    procedure CheckTradeDiscountLine()
    var
        RecItemCharge: Record "Item Charge";
        RecSalesLine: Record "Sales Line";
    begin
        RecItemCharge.Reset;
        RecItemCharge.SetRange("No.", '');
        if RecItemCharge.FindFirst then begin
            RecSalesLine.RESET;
            RecSalesLine.SetRange("Document No.", Rec."No.");
            RecSalesLine.SetRange("No.", RecItemCharge."GL Account");
            if RecSalesLine.FindFirst then begin
                if RecSalesLine."Line Amount" <> Rec."CD Available for Utilisation" then
                    Error('Please Delete the Trade Discount Line..');
            end;
        end;
    end;
    //TEAM 14763

    procedure CheckCDUtilisation(SalesHeader: Record "Sales Header")
    begin
        SalesHeader.CALCFIELDS("CD Available for Utilisation", SalesHeader."CD Availed from Utilisation"); //MSKS
        IF SalesHeader."CD Available for Utilisation" < 0 THEN
            EXIT;
        IF SalesHeader."CD Available for Utilisation" < SalesHeader."CD Availed from Utilisation" THEN
            ERROR('Insufficient CD Available for Utilisation');
    end;

    /*  procedure FreezeCNDetails(SalesHeader: Record 36)
      var
       15578  StructureOrderDetails: Record 13795;
      begin
          StructureOrderDetails.RESET;
          StructureOrderDetails.SETFILTER(StructureOrderDetails.Type, '%1', StructureOrderDetails.Type::Sale);
          StructureOrderDetails.SETFILTER("Document Type", '%1', StructureOrderDetails."Document Type"::Order);
          StructureOrderDetails.SETFILTER("Document No.", '%1', SalesHeader."No.");
          StructureOrderDetails.SETFILTER("Charge Type", '%1', StructureOrderDetails."Charge Type"::CN);
          IF StructureOrderDetails.FINDFIRST THEN BEGIN
              REPEAT
                  StructureOrderDetails."Manually Changed" := TRUE;
                  StructureOrderDetails.MODIFY;
              UNTIL StructureOrderDetails.NEXT = 0;
          END;
      end;*/ // 15578

    procedure UpdatedforApp()
    begin
        Updated := TRUE;
    end;

    procedure UpdateShiptoQty()
    var
        Selection: Integer;
    begin
        Selection := STRMENU(Text000, 3);
        IF Selection = 0 THEN
            EXIT;
        SalesLine.SETCURRENTKEY("Document Type", "Document No.", "TCS Nature of Collection");
        SalesLine.SETRANGE("Document Type", "Document Type");
        SalesLine.SETRANGE("Document No.", "No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SETFILTER("Outstanding Quantity", '<>%1', 0);
        IF SalesLine.FINDSET THEN BEGIN
            REPEAT
                IF Selection = 1 THEN
                    SalesLine.VALIDATE("Qty. to Ship", SalesLine."Outstanding Quantity");
                IF Selection = 2 THEN
                    SalesLine.VALIDATE("Qty. to Ship", 0);
                IF Selection = 3 THEN
                    SalesLine.AutoReserve;
                SalesLine.MODIFY;
            UNTIL SalesLine.NEXT = 0;
        END;
    end;

    procedure SendForCreditApproval(var CrSalesHeader: Record "Sales Header")
    var
        SalesLines: Record "Sales Line";
        RecCustomer: Record Customer;
        SmsMgt: Codeunit "SMS Sender - Due Date";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        SalespersonPurchaser1: Record "Salesperson/Purchaser";
        RequiredCreditApprovalAmt: Decimal;
        AvailableCrLimit: Decimal;
        SPApprovalLimit: Decimal;
        I: Integer;
        SPCode: Code[20];
        Customer: Record Customer;

        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        sgstTOTAL: Decimal;
        GSTLbl: Label 'GST';
        IGSTLbl: Label 'IGST';
        CGSTLbl: Label 'CGST';
        GSTCESSLbl: Label 'GST CESS';
        CESSLbl: Label 'CESS';
        igst: Decimal;
        igstTotal: Decimal;
        sgst: Decimal;
        GSTper3: Decimal;
        cgst: Decimal;
        GSTper1: Decimal;
        GSTper2: Decimal;
        cgstTOTAL: Decimal;
        ReccSalesLine: Record "Sales Line";
        ComponentName: Code[20];
        TotalAmt: Decimal;
    begin
        // 15578 text
        Clear(sgst);
        Clear(igst);
        Clear(cgst);
        Clear(TotalAmt);
        ReccSalesLine.Reset();
        ReccSalesLine.SetRange("Document Type", Rec."Document Type");
        ReccSalesLine.SetRange("Document No.", Rec."No.");
        if ReccSalesLine.FindSet() then
            repeat
                TotalAmt += ReccSalesLine."Line Amount";
                GSTSetup.Get();
                if GSTSetup."GST Tax Type" = GSTLbl then
                    if ReccSalesLine."GST Jurisdiction Type" = ReccSalesLine."GST Jurisdiction Type"::Interstate then
                        ComponentName := IGSTLbl
                    else
                        ComponentName := CGSTLbl
                else
                    if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                        ComponentName := CESSLbl;

                if ReccSalesLine.Type <> ReccSalesLine.Type::" " then begin
                    TaxTransactionValue.Reset();
                    TaxTransactionValue.SetRange("Tax Record ID", ReccSalesLine.RecordId);
                    TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                    if TaxTransactionValue.FindSet() then
                        repeat
                            case TaxTransactionValue."Value ID" of
                                6:
                                    begin
                                        sgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                        GSTper3 := TaxTransactionValue.Percent;
                                    end;
                                2:
                                    begin
                                        cgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                        GSTper2 := TaxTransactionValue.Percent;
                                    end;
                                3:
                                    begin
                                        igst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                        GSTper1 := TaxTransactionValue.Percent;
                                    end;
                            end;
                        until TaxTransactionValue.Next() = 0;
                    cgstTOTAL += cgst;
                    sgstTOTAL += sgst;
                    igstTotal += igst;
                end;
            until ReccSalesLine.Next() = 0;
        //15578 text

        SalesSetup.GET;
        IF SalesSetup."Manual Credit Approval" THEN BEGIN
            CrSalesHeader.TESTFIELD(Status, CrSalesHeader.Status::Open);
            //  CrSalesHeader.CALCFIELDS("Amount to Customer", CrSalesHeader."Approval Required");

            AvailableCrLimit := CalculateAvailableCredit(CrSalesHeader."Sell-to Customer No.");

            IF (AvailableCrLimit - TotalAmt + igst + cgst + sgst) > 0 THEN BEGIN
                CrSalesHeader.Status := CrSalesHeader.Status::"Credit Approved";
                IF ISReadytoDespatch(CrSalesHeader) AND (NOT CrSalesHeader."Approval Required") THEN
                    CrSalesHeader.Status := CrSalesHeader.Status::Approved;
                CrSalesHeader.MODIFY;
                EXIT;
            END;

            RequiredCreditApprovalAmt := TotalAmt + igst + cgst + sgst - AvailableCrLimit;
            IF RequiredCreditApprovalAmt <> 0 THEN BEGIN
                CrSalesHeader.Status := CrSalesHeader.Status::"Credit Approval Pending";
                CrSalesHeader."Approval Pending At" := CrSalesHeader."Approval Pending At"::Credit;
                CrSalesHeader.MODIFY;
            END;
        END ELSE BEGIN
            CLEAR(SmsMgt);
            CrSalesHeader.TESTFIELD(Status, CrSalesHeader.Status::Open);
            CrSalesHeader.CALCFIELDS(CrSalesHeader."Approval Required");

            AvailableCrLimit := CalculateAvailableCredit(CrSalesHeader."Sell-to Customer No.");

            IF (AvailableCrLimit - TotalAmt + igst + cgst + sgst) > 0 THEN BEGIN
                CrSalesHeader.Status := CrSalesHeader.Status::"Credit Approved";
                IF ISReadytoDespatch(CrSalesHeader) AND (NOT CrSalesHeader."Approval Required") THEN
                    CrSalesHeader.Status := CrSalesHeader.Status::Approved;
                CrSalesHeader.MODIFY;
                EXIT;
            END;

            RequiredCreditApprovalAmt := TotalAmt + igst + cgst + sgst - AvailableCrLimit;

            Customer.GET(CrSalesHeader."Sell-to Customer No.");
            IF Customer."Zonal Head" <> '' THEN BEGIN
                I := 1;

                SalespersonPurchaser1.RESET;
                SalespersonPurchaser1.SETCURRENTKEY("Credit Approver Matrix");
                SalespersonPurchaser1.SETFILTER(Code, GetCreditApprovalList(Customer."Zonal Head"));

                // SalespersonPurchaser.SETFILTER("Credit Approver Matrix",'%1',SalespersonPurchaser."Credit Approver Matrix"::CA1);
                SalespersonPurchaser1.SETFILTER(Status, '%1', SalespersonPurchaser1.Status::Enable);
                IF SalespersonPurchaser1.FINDFIRST THEN BEGIN
                    SalespersonPurchaser1.ASCENDING(TRUE);
                    SPCode := SalespersonPurchaser1.Code;
                    REPEAT
                        SPApprovalLimit := GetSalesPersonApprovalLimit(Customer."No.", SalespersonPurchaser1.Code);
                        IF SPApprovalLimit > RequiredCreditApprovalAmt THEN BEGIN
                            MakeCreditApprovalEntry(CrSalesHeader."Salesperson Code", SalespersonPurchaser1.Code, RequiredCreditApprovalAmt);
                            RequiredCreditApprovalAmt := 0;
                        END ELSE BEGIN
                            MakeCreditApprovalEntry(CrSalesHeader."Salesperson Code", SalespersonPurchaser1.Code, SPApprovalLimit);
                            RequiredCreditApprovalAmt -= SPApprovalLimit;
                        END;
                        I += 1;
                    UNTIL (SalespersonPurchaser1.NEXT = 0) OR (RequiredCreditApprovalAmt <= 0);
                    CLEAR(MailMgt);
                    MailMgt.CreateMailForCreditApproval(CrSalesHeader, SPCode);
                END;
            END;
            CrSalesHeader.Status := CrSalesHeader.Status::"Credit Approval Pending";
            CrSalesHeader."Approval Pending At" := CrSalesHeader."Approval Pending At"::Credit;
            CrSalesHeader.MODIFY;
        END;
    end;

    procedure CheckCreditLimit()
    begin
    end;

    procedure CalculateAvailableCredit(CustNo: Code[20]): Decimal
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        AlreadyCreditUtiised: Decimal;
        Customer: Record Customer;
    begin
        IF Customer.GET(CustNo) THEN BEGIN
            Customer.CALCFIELDS("Balance (LCY)");
            IF Customer."Credit Limit (LCY)" = 0 THEN EXIT;
        END;

        IF ISOverdueEntryExists(CustNo) THEN EXIT(0);

        SalesHeader.RESET;
        SalesHeader.SETFILTER("Sell-to Customer No.", '%1', CustNo);
        SalesHeader.SETFILTER(Status, '%1|%2|%3|%4', SalesHeader.Status::"Credit Approved", SalesHeader.Status::Released, SalesHeader.Status::"Pending Approval", SalesHeader.Status::"Price Approved");
        IF SalesHeader.FINDFIRST THEN
            REPEAT
                SalesLine.RESET;
                SalesLine.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                IF SalesLine.FINDFIRST THEN
                    REPEAT
                        AlreadyCreditUtiised += SalesLine."Outstanding Amount (LCY)";
                    UNTIL SalesLine.NEXT = 0;
            UNTIL SalesHeader.NEXT = 0;
        IF (Customer."Credit Limit (LCY)" - (Customer."Balance (LCY)" + AlreadyCreditUtiised)) > 0 THEN //MSKS2408
            EXIT(Customer."Credit Limit (LCY)" - (Customer."Balance (LCY)" + AlreadyCreditUtiised)) ELSE
            EXIT(0);
    end;

    local procedure ISOverdueEntryExists(CustNo: Code[20]): Boolean
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE("Customer No.", CustNo);
        CustLedgerEntry.SETFILTER("Document Type", '%1', CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SETFILTER("Due Date", '..%1', TODAY);
        CustLedgerEntry.SETRANGE(Open, TRUE);
        IF CustLedgerEntry.FINDFIRST THEN
            EXIT(TRUE)
    end;

    local procedure GetSalesPersonApprovalLimit(CustNo: Code[20]; SPCode: Code[10]): Decimal
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Customer: Record Customer;
    begin
        Customer.GET(CustNo);
        SalespersonPurchaser.GET(SPCode);

        CASE Customer."Discount Group" OF
            Customer."Discount Group"::A:
                EXIT(SalespersonPurchaser."Credit Approver Limit-A");
            Customer."Discount Group"::B:
                EXIT(SalespersonPurchaser."Credit Approver Limit-B");
            Customer."Discount Group"::C:
                EXIT(SalespersonPurchaser."Credit Approver Limit-C");
            ELSE
                EXIT(SalespersonPurchaser."Credit Approver Limit-C");
        END;
    end;

    procedure MakeCreditApprovalEntries(SPCode: Code[10]; CrAppCode: Code[20]; DiscountAmt: Decimal)
    var
        RecCustomer: Record Customer;
        RecSalesPerson: Record "Salesperson/Purchaser";
    begin
        MakeCreditApprovalEntry(SPCode, CrAppCode, DiscountAmt);
    end;

    procedure MakeCreditApprovalEntry(SenderSPCode: Code[20]; ApprovalSPCode: Code[20]; DiscountAmt: Decimal)
    var
        ApprovalEntry: Record "Approval Entry";
        // 15578    ApprovalSetup: Record 452;
        EntryNo: Integer;
        SalesHeader: Record "Sales Header";
        LastEmailID: Text;
    begin
        WITH ApprovalEntry DO BEGIN
            ApprovalEntry.RESET;
            IF ApprovalEntry.FINDLAST THEN
                EntryNo := ApprovalEntry."Entry No.";

            SETRANGE("Table ID", 36);
            SETRANGE("Document Type", "Document Type"::"Credit Limit");
            SETRANGE("Document No.", "No.");
            IF FINDLAST THEN BEGIN
                NewSequenceNo := "Sequence No." + 1;
                LastEmailID := EmailID;
            END ELSE
                NewSequenceNo := 1;
            "Entry No." := EntryNo + 1;
            "Table ID" := 36;
            "Document Type" := "Document Type"::"Credit Limit";
            "Document No." := "No.";
            "Salespers./Purch. Code" := SenderSPCode;
            "Sequence No." := NewSequenceNo;
            "Approval Code" := 'S-ORDER';
            "Sender ID" := USERID;
            Amount := DiscountAmt;
            "Amount (LCY)" := DiscountAmt;
            Status := Status::Created;
            "Currency Code" := "Currency Code";
            "Date-Time Sent for Approval" := CREATEDATETIME(TODAY, TIME);
            "Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
            "Last Modified By ID1" := USERID;
            // 15578    "Due Date" := CALCDATE(ApprovalSetup."Due Date Formula", TODAY);
            ApprovalSPCode := GetNextSalesPersonIFOnLeave(ApprovalSPCode); //MSKS2007
            ApprovalEntry."Approver Code" := ApprovalSPCode;
            ApprovalEntry."Comment Text" := '';
            //MSKS1705 Start
            IF SalespersonPurchaser.GET(ApprovalSPCode) THEN
                IF SalespersonPurchaser."E-Mail" <> '' THEN
                    ApprovalEntry.EmailID := SalespersonPurchaser."E-Mail";
            //MSKS1705 End

            //  "Approval Type" := ApprovalTemplates."Approval Type";
            //  "Limit Type" := ApprovalTemplates."Limit Type";
            SalesHeader.RESET;
            SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
            SalesHeader.SETRANGE("No.", "No.");
            IF SalesHeader.FINDFIRST THEN
                ApprovalEntry."Record ID to Approve" := SalesHeader.RECORDID;
            IF LastEmailID <> ApprovalEntry.EmailID THEN
                INSERT(TRUE);
        END;
    end;

    procedure ISReadytoDespatch(var CrSalesHeader: Record "Sales Header"): Boolean
    var
        SalesLine: Record "Sales Line";
        NotInInventory: Boolean;
    begin
        IF CrSalesHeader."Location Code" IN ['DP-MORBI', 'DP-BIKANER'] THEN
            EXIT(TRUE);

        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Document No.", CrSalesHeader."No.");
        SalesLine.SETFILTER("Outstanding Quantity", '<>%1', 0);
        IF SalesLine.FINDFIRST THEN BEGIN
            REPEAT
                NotInInventory := FALSE;
                SalesLine.CALCFIELDS("Reserved Quantity");
                IF SalesLine."Outstanding Quantity" <> SalesLine."Reserved Quantity" THEN
                    NotInInventory := TRUE;
            UNTIL (SalesLine.NEXT = 0) OR NotInInventory;
        END;
        EXIT(NOT NotInInventory);
    end;

    local procedure GetCreditApprovalList(ZHCode: Code[10]) List: Text
    begin
        IF ZHCode <> '' THEN
            List := ZHCode;


        SalespersonPurchaser.RESET;
        SalespersonPurchaser.SETFILTER("Credit Approver Matrix", '>%1', 1);
        SalespersonPurchaser.SETRANGE(Status, SalespersonPurchaser.Status::Enable);
        IF SalespersonPurchaser.FINDFIRST THEN BEGIN
            REPEAT
                IF List <> '' THEN
                    List += '|' + SalespersonPurchaser.Code
                ELSE
                    List := Salesperson.Code;
            UNTIL SalespersonPurchaser.NEXT = 0;
        END;
        MESSAGE(List);
        EXIT(List);
    end;

    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal// 15578 text
    var
        TaxComponent: Record "Tax Component";
        GSTSetup1: Record "GST Setup";
        GSTRoundingPrecision: Decimal;
    begin
        if not GSTSetup1.Get() then
            exit;
        GSTSetup1.TestField("GST Tax Type");

        TaxComponent.SetRange("Tax Type", GSTSetup1."GST Tax Type");
        TaxComponent.SetRange(Name, ComponentName);
        TaxComponent.FindFirst();
        if TaxComponent."Rounding Precision" <> 0 then
            GSTRoundingPrecision := TaxComponent."Rounding Precision"
        else
            GSTRoundingPrecision := 1;
        exit(GSTRoundingPrecision);
    end;

    var
        // 15578  NODNOCLines: Record "13785";
        rSalLine: Record "Sales Line";
        SH: Record "Sales Header";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        CustomerRec: Record Customer;
        Text100: Label 'The LC which you have selected is Foreign type you cannot utilise for this order.';
        Text101: Label 'You cannot change Export Type because it has open orders that has not been posted yet.';
        Text103: Label 'You cannot change the structure.';
        Text104: Label 'Goods can be shipped from location %1 only against CT-2 No. %2';
        Text105: Label 'Location cannot be changed if CT-2 No. is defined';
        Text110: Label 'Sales Order cannot be deleted if Advance License is attached.';
        Text111: Label 'Status of Proforma Invoice No. %1 has been set as Expired due to modifications in the Export Order';
        Text0001: Label 'Sample Order %1 has been created for Customer %2.';
        Text0002: Label 'Status must be Open while changing the "Sell-to Post code".';
        TgText001: Label 'You are not able to mention C Form without Tax Registration No.';
        Text00002: Label 'Please enter the Posting Date first.';
        Text00003: Label 'You cannot change the structrue, because the items associated with it.';
        "..tri1.0": Integer;
        SalesHeader1: Record "Sales Header";
        SalesLine1: Record "Sales Line";
        ItemNo: Code[20];
        Permissions: Codeunit Permissions1;
        UserAccess: Integer;
        SalesLine2: Record "Sales Line";
        UserSetup1: Record "User Setup";
        GroupCode: Record "Item Group";
        InventorySetup: Record "Inventory Setup";
        "--TRI DP": Integer;
        NoSrRelation: Record "No. Series Relationship";
        NoSrRelationForm: Page "No. Series Relationships";
        NoSeries: Record "No. Series";
        PaymentTerms2: Record "Payment Terms";
        // 15578  Formcode: Record "13756";
        UserLocation: Record "User Location";
        UserSetup: Record "User Setup";
        // 15578  TGSTrOrdDet: Record "13794";
        SalesLineRec: Record "Sales Line";
        // 15578  StateVar: Record 13762;
        "--SHAKTI----": Integer;
        ExcludeState: Boolean;
        ExcludeCustomer: Boolean;
        ExcludeCustomerType: Boolean;
        QDFunctions: Codeunit "Quality Discount Functions";
        RecCustGrp: Record "Customer Group";
        Customer: Record Customer;
        // 15578  Struct: Record "13792";
        SalesLinePb: Record "Sales Line";
        RecState: Record State;
        Location1: Record Location;
        GeneralLedgerSetup: Record "General Ledger Setup";
        CDA: Boolean;
        NewSequenceNo: Integer;
        MailMgt: Codeunit "QD Test, PDF Creation & Email";
        CDMgt: Codeunit "CD Management";
        reas: Record "Reason Code";
        shiptopin: Record "Pin State Wise Mapping";
        Text000: Label '&Remaining,&Zero,&Reserve';
        Location: Record Location;
        GLSetup: Record "General Ledger Setup";
        SalesLine: Record "Sales Line";
        Cust: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
        Confirmed: Boolean;
        ShipToAddr: Record "Ship-to Address";
        PostCode: Record "Post Code";
        Salesperson: Record "Salesperson/Purchaser";
        Rec_Sales_Line, RecSalesLine2 : Record "Sales Line";
        Rec_Sales_Header: Record "Sales Header";
        Currency: Record Currency;
        DataCaption: Text[250];
        AssignableAmount, AssignableQty, UnitCost : Decimal;
        ItemChargeAssgntSales: Record "Item Charge Assignment (Sales)";
        AssignItemChargeSales: Codeunit "Item Charge Assgnt. (Sales)";
        ItemChargeAssgnts: Page "Item Charge Assignment (Sales)";
        ItemChargeAssgntLineAmt, TotalQtyToAssign, TotalAmountToAssign, TotalQtyToHandle, TotalAmountToHandle, RemQtyToAssign, RemAmountToAssign, RemQtyToHandle, RemAmountToHandle : Decimal;
        QtyToShipBase, QtyToRetReceiveBase, QtyShippedBase, GrossWeight, UnitVolume, QtyRetReceivedBase : Decimal;
        IsHandled: Boolean;

    procedure AutoAssignChargeItem(var SalesLine: Record "Sales Line")
    var
        Selection: Option Equally,"By Amount","By Weight","By Volume";
    begin

        Clear(Rec_Sales_Line);
        Rec_Sales_Line.Reset;
        Rec_Sales_Line.Get(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.");
        Rec_Sales_Line.TestField("No.");
        Rec_Sales_Line.TestField(Quantity);

        ItemChargeAssgntSales.Reset();
        ItemChargeAssgntSales.SetRange("Document Type", Rec_Sales_Line."Document Type");
        ItemChargeAssgntSales.SetRange("Document No.", Rec_Sales_Line."Document No.");
        //ItemChargeAssgntSales.SetRange("Document Line No.", Rec_Sales_Line."Line No.");
        //ItemChargeAssgntSales.SetRange("Line No.", Rec_Sales_Line."Line No.");
        if ItemChargeAssgntSales.FindSet then
            ItemChargeAssgntSales.DeleteAll;

        GetSalesHeader();

        Currency.Initialize(Rec_Sales_Header."Currency Code");

        if (Rec_Sales_Line."Inv. Discount Amount" = 0) and (Rec_Sales_Line."Line Discount Amount" = 0) and
           (not Rec_Sales_Header."Prices Including VAT")
        then
            ItemChargeAssgntLineAmt := "Line Amount"
        else
            if Rec_Sales_Header."Prices Including VAT" then
                ItemChargeAssgntLineAmt :=
                  Round(CalcLineAmount() / (1 + Rec_Sales_Line."VAT %" / 100), Currency."Amount Rounding Precision")
            else
                ItemChargeAssgntLineAmt := CalcLineAmount();

        Clear(ItemChargeAssgntSales);
        ItemChargeAssgntSales.Reset();
        ItemChargeAssgntSales.SetRange("Document Type", Rec_Sales_Line."Document Type");
        ItemChargeAssgntSales.SetRange("Document No.", Rec_Sales_Line."Document No.");
        ItemChargeAssgntSales.SetRange("Document Line No.", Rec_Sales_Line."Line No.");
        ItemChargeAssgntSales.SetRange("Item Charge No.", "No.");
        if not ItemChargeAssgntSales.FindLast() then begin
            ItemChargeAssgntSales."Document Type" := Rec_Sales_Line."Document Type";
            ItemChargeAssgntSales."Document No." := Rec_Sales_Line."Document No.";
            ItemChargeAssgntSales."Document Line No." := Rec_Sales_Line."Line No.";
            ItemChargeAssgntSales."Item Charge No." := Rec_Sales_Line."No.";
            ItemChargeAssgntSales."Unit Cost" :=
              Round(ItemChargeAssgntLineAmt / Quantity, Currency."Unit-Amount Rounding Precision");
        end;

        IsHandled := false;
        if not IsHandled then
            ItemChargeAssgntLineAmt :=
              Round(ItemChargeAssgntLineAmt * (Rec_Sales_Line."Qty. to Invoice" / Quantity), Currency."Amount Rounding Precision");

        if IsCreditDocType() then
            AssignItemChargeSales.CreateDocChargeAssgn(ItemChargeAssgntSales, "Return Receipt No.")
        else
            AssignItemChargeSales.CreateDocChargeAssgn(ItemChargeAssgntSales, Rec_Sales_Line."Shipment No.");
        Clear(AssignItemChargeSales);
        Commit();

        //ItemChargeAssgnts.Initialize(Rec_Sales_Line, ItemChargeAssgntLineAmt);
        //ItemChargeAssgnts.RunModal();
        //ItemChargeAssgnts.Close();

        Initialize(Rec_Sales_Line, ItemChargeAssgntLineAmt);
        UpdateQtyAssgnt;
        UpdateQty;

        Selection := Selection::"By Amount";
        //AssignItemChargeSales.SuggestAssignment(Rec_Sales_Line, AssignableQty, AssignableAmount, AssignableQty, AssignableAmount);
        AssignItemChargeSales.AssignItemCharges(Rec_Sales_Line, AssignableQty, AssignableAmount, AssignableQty, AssignableAmount, 'By Amount');
        Rec_Sales_Line.CalcFields("Qty. to Assign");
    end;


    local procedure UpdateQtyAssgnt()
    var
        ItemChargeAssgnt_Sales: Record "Item Charge Assignment (Sales)";
    begin
        RecSalesLine2.CalcFields("Qty. to Assign", "Item Charge Qty. to Handle", "Qty. Assigned");
        AssignableQty := SalesLine2."Qty. to Invoice" + SalesLine2."Quantity Invoiced" - SalesLine2."Qty. Assigned";

        if AssignableQty <> 0 then
            UnitCost := AssignableAmount / AssignableQty
        else
            UnitCost := 0;

        ItemChargeAssgnt_Sales.Reset();
        ItemChargeAssgnt_Sales.SetCurrentKey("Document Type", "Document No.", "Document Line No.");
        ItemChargeAssgnt_Sales.SetRange("Document Type", ItemChargeAssgntSales."Document Type");
        ItemChargeAssgnt_Sales.SetRange("Document No.", ItemChargeAssgntSales."Document No.");
        ItemChargeAssgnt_Sales.SetRange("Document Line No.", ItemChargeAssgntSales."Document Line No.");
        ItemChargeAssgnt_Sales.CalcSums("Qty. to Assign", "Amount to Assign", "Qty. to Handle", "Amount to Handle");
        TotalQtyToAssign := ItemChargeAssgnt_Sales."Qty. to Assign";
        TotalAmountToAssign := ItemChargeAssgnt_Sales."Amount to Assign";
        TotalQtyToHandle := ItemChargeAssgnt_Sales."Qty. to Handle";
        TotalAmountToHandle := ItemChargeAssgnt_Sales."Amount to Handle";

        RemQtyToAssign := AssignableQty - TotalQtyToAssign;
        RemAmountToAssign := AssignableAmount - TotalAmountToAssign;
        RemQtyToHandle := AssignableQty - TotalQtyToHandle;
        RemAmountToHandle := AssignableAmount - TotalAmountToHandle;
    end;

    local procedure UpdateQty()
    var
        SalesLine: Record "Sales Line";
    begin
        case ItemChargeAssgntSales."Applies-to Doc. Type" of
            "Sales Applies-to Document Type"::Order, "Sales Applies-to Document Type"::Invoice:
                begin
                    SalesLine.Get(ItemChargeAssgntSales."Applies-to Doc. Type", ItemChargeAssgntSales."Applies-to Doc. No.", ItemChargeAssgntSales."Applies-to Doc. Line No.");
                    QtyToShipBase := SalesLine."Qty. to Ship (Base)";
                    QtyShippedBase := SalesLine."Qty. Shipped (Base)";
                    QtyToRetReceiveBase := 0;
                    QtyRetReceivedBase := 0;
                    GrossWeight := SalesLine."Gross Weight";
                    UnitVolume := SalesLine."Unit Volume";
                end;
        end;
    end;


    procedure CalcLineAmount() LineAmount: Decimal
    begin
        LineAmount := Rec_Sales_Line."Line Amount" - Rec_Sales_Line."Inv. Discount Amount";
    end;

    procedure Initialize(NewSalesLine: Record "Sales Line"; NewLineAmt: Decimal)
    begin
        SalesLine2 := NewSalesLine;
        DataCaption := SalesLine2."No." + ' ' + SalesLine2.Description;
        AssignableAmount := NewLineAmt;
    end;

    procedure GetSalesHeader(): Record "Sales Header"
    begin
        GetSalesHeader(Rec_Sales_Header, Currency);
        exit(Rec_Sales_Header);
    end;

    procedure GetSalesHeader(var OutSalesHeader: Record "Sales Header"; var OutCurrency: Record Currency)
    begin
        Rec_Sales_Line.TestField("Document No.");
        if (Rec_Sales_Line."Document Type" <> Rec_Sales_Header."Document Type") or (Rec_Sales_Line."Document No." <> Rec_Sales_Header."No.") then begin
            Rec_Sales_Header.Get("Document Type", Rec_Sales_Line."Document No.");
            if Rec_Sales_Header."Currency Code" = '' then
                Currency.InitRoundingPrecision()
            else begin
                Rec_Sales_Header.TestField("Currency Factor");
                Currency.Get(Rec_Sales_Header."Currency Code");
                Currency.TestField("Amount Rounding Precision");
            end;
        end;

        //OnAfterGetSalesHeader(Rec, SalesHeader, Currency);
        OutSalesHeader := Rec_Sales_Header;
        OutCurrency := Currency;
    end;


    procedure CalculateTradeCharge()
    var
        RecsalesLine, SalesLine, recSalesLine1 : Record "Sales Line";
        chargeItemRec: Record "Item Charge";
        RecSalesHeader, SalesHeader : Record "Sales Header";
        TotalLineAmount, TotalLineAmount1 : decimal;
    begin
        Clear(TotalLineAmount);

        /*
        // Code added for Requested Discount
        Clear(SalesLine);
        SalesLine.Reset;
        SalesLine.SetRange("Document No.", rec."No.");
        SalesLine.SetRange(SalesLine.Type, SalesLine.Type::Item);
        if SalesLine.FindSet then begin
            repeat
                SalesLine.Validate(D7);
                SalesLine.Modify;
            until SalesLine.next = 0;
        end;
        // Code added for Requested Discount 
        */


        Clear(SalesLine);
        SalesLine.Reset;
        SalesLine.SetRange("Document No.", rec."No.");
        SalesLine.SetRange(SalesLine.Type, SalesLine.Type::Item);
        if SalesLine.FindSet then begin
            repeat
                SalesLine.TestField(Quantity);

                if SalesLine."Qty. to Ship" <> 0 then
                    TotalLineAmount += (SalesLine."Line Amount" / SalesLine.Quantity) * SalesLine."Qty. to Ship"
                else
                    TotalLineAmount += SalesLine."Line Amount";

                //if SalesLine."Line Discount Amount 1" = 0 then 06-06-23
                SalesLine."Line Discount Amount 1" := SalesLine."Line Discount Amount";
                SalesLine."Line Amount Per Qty" := ((SalesLine.Quantity * SalesLine."Unit Price") - SalesLine."Line Discount Amount 1") / SalesLine.Quantity;
                SalesLine.Modify;
            until SalesLine.next = 0;
        end;

        if Rec."CD Available for Utilisation" = 0 then begin
            Rec."Trade Discount" := 0;
            exit;
        end;

        if not Rec."CD Applicable" then begin
            Rec."Trade Discount" := 0;
            exit;
        end;

        chargeItemRec.Reset;
        chargeItemRec.setrange("No.", 'TRDDISC');
        if chargeItemRec.FindFirst then begin
            if (chargeItemRec."No." = 'TRDDISC') AND (chargeItemRec."Insurance Percentage" = 0) AND (chargeItemRec."Calculation Type" = chargeItemRec."Calculation Type"::"Fixed Value") then begin
                SalesHeader.Reset();
                SalesHeader.setrange(SalesHeader."No.", Rec."No.");
                SalesHeader.SetAutoCalcFields("CD Available for Utilisation");
                SalesHeader.SetFilter("CD Available for Utilisation", '>%1', 0);
                if SalesHeader.FindFirst() then begin
                    recSalesLine1.Reset;
                    recSalesLine1.SetRange("Document No.", Rec."No.");
                    recSalesLine1.SetRange("No.", chargeItemRec."GL Account");
                    if not recSalesLine1.FindFirst then begin

                        if rec."CD Available for Utilisation" < ((TotalLineAmount * 25) / 100) then begin
                            SalesHeader."Trade Discount" := rec."CD Available for Utilisation";
                            SalesHeader.Modify;
                        end else begin
                            SalesHeader."Trade Discount" := ((TotalLineAmount * 25) / 100);
                            SalesHeader.Modify;
                        end;
                    end else begin
                        if rec."CD Available for Utilisation" < ((TotalLineAmount * 25) / 100) then begin
                            SalesHeader."Trade Discount" := rec."CD Available for Utilisation";
                            SalesHeader.Modify;
                        end else begin
                            SalesHeader."Trade Discount" := ((TotalLineAmount * 25) / 100);
                            SalesHeader.Modify;
                        end;
                    end;
                end;
            end;

            Clear(TotalLineAmount1);

            Clear(RecSalesHeader);
            RecSalesHeader.RESET;
            RecSalesHeader.SETRANGE("No.", Rec."No.");
            IF RecSalesHeader.FINDFIRST THEN begin
                Clear(RecsalesLine);
                RecsalesLine.reset;
                RecsalesLine.setrange("Document No.", Rec."No.");
                RecsalesLine.SetRange(Type, RecsalesLine.Type::Item);
                if RecsalesLine.FindSet then begin
                    repeat
                        if RecsalesLine."Qty. to Ship" <> 0 then
                            TotalLineAmount1 += RecsalesLine."Line Amount Per Qty" * RecsalesLine."Qty. to Ship"
                        else
                            TotalLineAmount1 += RecsalesLine."Line Amount Per Qty" * RecsalesLine.Quantity;
                    until RecsalesLine.next = 0;
                end;
            end;


            Clear(RecSalesHeader);
            RecSalesHeader.RESET;
            RecSalesHeader.SETRANGE("No.", Rec."No.");
            IF RecSalesHeader.FINDFIRST THEN begin
                Clear(RecsalesLine);
                RecsalesLine.reset;
                RecsalesLine.setrange("Document No.", Rec."No.");
                RecsalesLine.SetRange(Type, RecsalesLine.Type::Item);
                if RecsalesLine.FindSet then begin
                    repeat
                        if RecsalesLine."Qty. to Ship" <> 0 then
                            RecsalesLine."Trade Discount Amount" := (RecsalesLine."Line Amount Per Qty" * RecsalesLine."Qty. to Ship") / TotalLineAmount1 * RecSalesHeader."Trade Discount"
                        else
                            RecsalesLine."Trade Discount Amount" := (RecsalesLine."Line Amount Per Qty" * RecsalesLine.Quantity) / TotalLineAmount1 * RecSalesHeader."Trade Discount";
                        RecsalesLine.Modify;
                    until RecsalesLine.next = 0;
                end;
            end;
        end;
    end;


    procedure CalculateDiscountCharge()
    var
        RecSalesHeader, SalesHeader1 : Record "Sales Header";
        chargeItemRec1: Record "Item Charge";
        recSalesLine3, RecSalesLine : Record "Sales Line";
        DiscountCharge, FinalAmount : Decimal;
    begin
        Clear(DiscountCharge);

        SalesHeader1.Reset;
        SalesHeader1.SetRange("No.", Rec."No.");
        SalesHeader1.SetFilter("Discount Charges %", '<>%1', 0);
        if SalesHeader1.FindFirst then begin
            chargeItemRec1.Reset;
            chargeItemRec1.SetRange("No.", 'DISCOUNT');
            if chargeItemRec1.FindFirst then begin
                recSalesLine3.Reset;
                recSalesLine3.SetRange("Document No.", Rec."No.");
                recSalesLine3.SetRange(Type, recSalesLine3.Type::Item);
                if recSalesLine3.FindSet then begin
                    repeat
                        if recSalesLine3."Qty. to Ship" <> 0 then
                            DiscountCharge += recSalesLine3."Line Amount Per Qty" * recSalesLine3."Qty. to Ship"
                        else
                            DiscountCharge += recSalesLine3."Line Amount Per Qty" * recSalesLine3.Quantity;
                    until recSalesLine3.Next = 0;
                end;

                Clear(FinalAmount);
                FinalAmount := DiscountCharge - ABS(SalesHeader1."Trade Discount");

                SalesHeader1."Discount Amount" := ABS((FinalAmount * SalesHeader1."Discount Charges %") / 100);
                SalesHeader1.Modify;
            end;

            Clear(RecSalesHeader);
            RecSalesHeader.RESET;
            RecSalesHeader.SETRANGE("No.", Rec."No.");
            IF RecSalesHeader.FINDFIRST THEN begin
                Clear(RecsalesLine);
                RecsalesLine.reset;
                RecsalesLine.setrange("Document No.", Rec."No.");
                RecsalesLine.SetRange(Type, RecsalesLine.Type::Item);
                if RecsalesLine.FindSet then begin
                    repeat
                        if RecsalesLine."Qty. to Ship" <> 0 then
                            RecsalesLine."Structure Discount Amount" := ((RecsalesLine."Line Amount Per Qty" * RecsalesLine."Qty. to Ship") / DiscountCharge) * RecSalesHeader."Discount Amount"
                        else
                            RecsalesLine."Structure Discount Amount" := ((RecsalesLine."Line Amount Per Qty" * RecsalesLine.Quantity) / DiscountCharge) * RecSalesHeader."Discount Amount";
                        RecsalesLine.Modify;
                    until RecsalesLine.next = 0;
                end;
            end;
        end;
    end;

    procedure CalculateFreight()
    var
        SalesRecsetup: Record "Sales & Receivables Setup";
        chargeItemRec: Record "Item Charge";
        SalesLine, recSalesLine1 : Record "Sales Line";
        LineNo: Integer;
    begin
        Clear(LineNo);
        Clear(SalesLine);

        SalesLine.Reset;
        SalesLine.SetRange("Document No.", rec."No.");
        if SalesLine.FindLast then
            LineNo := SalesLine."Line No.";

        SalesRecsetup.GET;
        if SalesRecsetup."Structure Frieght" <> '' then begin
            if Rec."Structure Freight Amount" <> 0 then begin
                chargeItemRec.Reset;
                chargeItemRec.setrange("No.", SalesRecsetup."Structure Frieght");
                if chargeItemRec.FindFirst then begin
                    recSalesLine1.Reset;
                    recSalesLine1.SetRange("Document No.", Rec."No.");
                    recSalesLine1.SetRange("No.", chargeItemRec."GL Account");
                    if not recSalesLine1.FindFirst then begin
                        recSalesLine1.reset;
                        recSalesLine1.Init();
                        LineNo := LineNo + 10000;
                        recSalesLine1."Document Type" := rec."Document Type";
                        recSalesLine1."Document No." := rec."No.";
                        recSalesLine1."Line No." := LineNo;
                        recSalesLine1.type := recSalesLine1.type::"G/L Account";
                        recSalesLine1.validate("No.", chargeItemRec."GL Account");
                        recSalesLine1.validate(quantity, 1);
                        recSalesLine1."Qty. to Ship" := 1;
                        recSalesLine1."Qty. to Invoice" := 1;
                        recSalesLine1.Validate("Unit Price", Rec."Structure Freight Amount");
                        recSalesLine1.VALIDATE("GST Group Code", chargeItemRec."GST Group Code");
                        recSalesLine1.VALIDATE("HSN/SAC Code", chargeItemRec."HSN/SAC Code");
                        recSalesLine1.VALIDATE("Gen. Prod. Posting Group", chargeItemRec."Gen. Prod. Posting Group");
                        recSalesLine1.Insert;
                    end else begin
                        recSalesLine1."Qty. to Ship" := 1;
                        recSalesLine1."Qty. to Invoice" := 1;
                        recSalesLine1.Validate("Unit Price", Rec."Structure Freight Amount");
                        recSalesLine1.Modify;
                    end;
                end;
            end else begin
                chargeItemRec.Reset;
                chargeItemRec.setrange("No.", SalesRecsetup."Structure Frieght");
                if chargeItemRec.FindFirst then begin
                    recSalesLine1.Reset;
                    recSalesLine1.SetRange("Document No.", Rec."No.");
                    recSalesLine1.SetRange("No.", chargeItemRec."GL Account");
                    if recSalesLine1.FindFirst then
                        recSalesLine1.DeleteAll;
                end;
            end;
        end;
    end;


    procedure CheckInvoiceDiscountAmountValidation()
    var
        Recsaleslineamtcheck: Record 37;
        InvDisAmount: Decimal;
    begin
        Clear(InvDisAmount);
        Recsaleslineamtcheck.Reset;
        Recsaleslineamtcheck.setrange("Document No.", Rec."No.");
        Recsaleslineamtcheck.setrange(Type, Recsaleslineamtcheck.Type::Item);
        if Recsaleslineamtcheck.FindFirst then
            repeat
                InvDisAmount += Recsaleslineamtcheck."Inv. Discount Amount";

            until Recsaleslineamtcheck.next = 0;

        if Round(InvDisAmount) <> Round(Rec."Invoice Discount Amount") then
            Error('Invoice Discount Amount must be Same');




    end;





    procedure CalculateInsurance()
    var
        recSalesLine1, RecsalesLine, SalesLine : Record "Sales Line";
        chargeItemRec: Record "Item Charge";
        SalesRecsetup: Record "Sales & Receivables Setup";
        LineNo: Integer;
        RecSalesHeader: Record "Sales Header";
        TotalDiscountAmount, TotalFreightAmount, TotalTradeAmount, FinalAmount, SalesLineAmount, FinalInsuranceAmount : Decimal;
    begin
        Clear(FinalInsuranceAmount);

        Clear(recSalesLine1);
        recSalesLine1.Reset;
        recSalesLine1.SetRange("Document No.", Rec."No.");
        recSalesLine1.SetRange(Type, recSalesLine1.Type::Item);
        if recSalesLine1.FindSet then begin
            repeat
                if (recSalesLine1."Trade Discount Amount" <> 0) or (recSalesLine1."Structure Discount Amount" <> 0) then begin
                    if recSalesLine1."Qty. to Ship" <> 0 then
                        recSalesLine1."Inv. Discount Amount" := (((recSalesLine1."Trade Discount Amount" + recSalesLine1."Structure Discount Amount") / recSalesLine1."Qty. to Ship") * recSalesLine1.Quantity)
                    else
                        recSalesLine1."Inv. Discount Amount" := recSalesLine1."Trade Discount Amount" + recSalesLine1."Structure Discount Amount";
                    recSalesLine1.Modify;
                end;
            until recSalesLine1.Next = 0;
        end;


        if Rec."Calculate Insurance" then begin
            clear(SalesLineAmount);
            Clear(TotalFreightAmount);
            Clear(TotalDiscountAmount);
            clear(TotalTradeAmount);
            clear(lineno);

            //Total Line Amount
            Clear(RecsalesLine);
            RecsalesLine.reset;
            RecsalesLine.setrange("Document No.", rec."No.");
            RecsalesLine.SetRange(Type, RecsalesLine.Type::Item);
            if RecsalesLine.FindSet then begin
                repeat
                    if RecsalesLine."Qty. to Ship" <> 0 then
                        SalesLineAmount += RecsalesLine."Line Amount Per Qty" * RecsalesLine."Qty. to Ship"
                    else
                        SalesLineAmount += RecsalesLine."Line Amount Per Qty" * RecsalesLine.Quantity;
                until RecsalesLine.next = 0;
            end;
            //Total Line Amount

            //Total Trade Amount

            Clear(RecSalesHeader);
            RecSalesHeader.RESET;
            RecSalesHeader.setrange("No.", Rec."No.");
            if RecSalesHeader.FindFirst then begin
                TotalTradeAmount := RecSalesHeader."Trade Discount";
                TotalDiscountAmount := RecSalesHeader."Discount Amount";
            end;

            //Discount Amount

            //Freight Amount
            Clear(chargeItemRec);
            Clear(RecsalesLine);
            SalesRecsetup.GET;
            if SalesRecsetup."Structure Frieght" <> '' then begin
                if Rec."Structure Freight Amount" <> 0 then begin
                    chargeItemRec.Reset;
                    chargeItemRec.setrange("No.", SalesRecsetup."Structure Frieght");
                    if chargeItemRec.FindFirst then begin
                        RecsalesLine.reset;
                        RecsalesLine.setrange("Document No.", rec."No.");
                        RecsalesLine.SetRange("No.", chargeItemRec."GL Account");
                        if RecsalesLine.FindSet then begin
                            RecsalesLine.CalcSums("Line Amount");
                            TotalFreightAmount := abs(RecsalesLine."Line Amount");
                        end;
                    end;
                end;
            end;

            //Freight Amount
            Clear(FinalAmount);
            FinalAmount := ABS(SalesLineAmount) - ABS(TotalTradeAmount) - ABS(TotalDiscountAmount) + ABS(TotalFreightAmount);

            SalesLine.Reset;
            SalesLine.SetRange("Document No.", rec."No.");
            if SalesLine.FindLast then
                LineNo := SalesLine."Line No.";

            if SalesRecsetup."Insurance Structure" <> '' then begin
                chargeItemRec.Reset;
                chargeItemRec.setrange("No.", SalesRecsetup."Insurance Structure");
                if chargeItemRec.FindFirst then
                    if chargeItemRec."Insurance Percentage" <> 0 then begin
                        recSalesLine1.Reset;
                        recSalesLine1.SetRange("Document No.", Rec."No.");
                        recSalesLine1.SetRange("No.", SalesRecsetup."Insurance Structure");
                        if not recSalesLine1.FindFirst then begin
                            recSalesLine1.Init();
                            LineNo := LineNo + 10000;
                            recSalesLine1."Document Type" := rec."Document Type";
                            recSalesLine1."Document No." := rec."No.";
                            recSalesLine1."Line No." := LineNo;
                            recSalesLine1.type := recSalesLine1.type::"Charge (Item)";
                            recSalesLine1.validate("No.", SalesRecsetup."Insurance Structure");
                            recSalesLine1.validate(quantity, 1);
                            recSalesLine1."Qty. to Ship" := 1;
                            recSalesLine1."Qty. to Invoice" := 1;
                            FinalInsuranceAmount := (FinalAmount * chargeItemRec."Insurance Percentage") / 100;
                            recSalesLine1.validate("Unit Price", (FinalAmount * chargeItemRec."Insurance Percentage") / 100);
                            recSalesLine1.validate("GST Group Code", chargeItemRec."GST Group Code");
                            recSalesLine1.validate("HSN/SAC Code", chargeItemRec."HSN/SAC Code");
                            recSalesLine1.validate("Gen. Prod. Posting Group", chargeItemRec."Gen. Prod. Posting Group");
                            recSalesLine1.Insert;

                            Rec.AutoAssignChargeItem(recSalesLine1);

                            Clear(RecSalesHeader);
                            RecSalesHeader.RESET;
                            RecSalesHeader.setrange("No.", Rec."No.");
                            if RecSalesHeader.FindFirst then begin
                                RecSalesHeader."Insurance Amount" := FinalInsuranceAmount;
                                RecSalesHeader.Modify;
                            end;
                        end else begin
                            recSalesLine1."Qty. to Ship" := 1;
                            recSalesLine1."Qty. to Invoice" := 1;
                            FinalInsuranceAmount := (FinalAmount * chargeItemRec."Insurance Percentage") / 100;
                            recSalesLine1.validate("Unit Price", (FinalAmount * chargeItemRec."Insurance Percentage") / 100);
                            recSalesLine1.Modify;

                            Rec.AutoAssignChargeItem(recSalesLine1);

                            Clear(RecSalesHeader);
                            RecSalesHeader.RESET;
                            RecSalesHeader.setrange("No.", Rec."No.");
                            if RecSalesHeader.FindFirst then begin
                                RecSalesHeader."Insurance Amount" := FinalInsuranceAmount;
                                RecSalesHeader.Modify;
                            end;
                        end;
                    end;
            end;
        end else begin
            SalesRecsetup.GET;
            if SalesRecsetup."Insurance Structure" <> '' then begin
                chargeItemRec.Reset;
                chargeItemRec.setrange("No.", SalesRecsetup."Insurance Structure");
                if chargeItemRec.FindFirst then
                    if chargeItemRec."Insurance Percentage" <> 0 then begin
                        Clear(recSalesLine1);
                        recSalesLine1.Reset;
                        recSalesLine1.SetRange("Document No.", Rec."No.");
                        recSalesLine1.SetRange("No.", SalesRecsetup."Insurance Structure");
                        if recSalesLine1.FindFirst then begin
                            recSalesLine1.DeleteAll;
                        end;
                    end;
            end;
        end;
    end;

    local procedure OpenApprovalEntryExist(SalesOrderNo: Code[20]): Boolean
    var
        ApprovalEntry: Record 454;
    begin
        IF SalesOrderNo = '' THEN EXIT;
        ApprovalEntry.RESET;
        ApprovalEntry.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Sequence No.", "Record ID to Approve");
        ApprovalEntry.SETRANGE("Table ID", 36);
        ApprovalEntry.SETRANGE("Document No.", SalesOrderNo);
        ApprovalEntry.SETFILTER(Status, '%1|%2', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created);
        IF NOT ApprovalEntry.ISEMPTY THEN
            EXIT(TRUE);

    end;
}