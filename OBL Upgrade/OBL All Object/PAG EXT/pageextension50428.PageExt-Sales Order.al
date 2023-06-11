pageextension 50428 pageextension50428 extends 42
{
    layout
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                IF (rec."Location Code" = 'SKD-SAMPLE') AND (rec."Location Code" = 'DRA-SAMPLE') AND (rec."Location Code" = 'HSK-SAMPLE') THEN BEGIN
                    // Rec.VALIDATE(Structure, 'SAMPLEGST'); 16630 Table field N/f
                    Rec.VALIDATE("Payment Terms Code", '30 DAYS');
                    Rec.VALIDATE("Shipping Agent Code", 'TPT09');
                    Rec.VALIDATE(None, TRUE);
                    Rec.VALIDATE("Order Change Remarks", 'ICR00001');
                    Rec.MODIFY;
                END;
            end;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnBeforeValidate()
            begin
                //mo tri1.0 Customization no.15 start
                SampleOrder.RESET;
                SampleOrder.SETFILTER("Customer No.", Rec."Sell-to Customer No.");
                SampleOrder.SETFILTER("SO No.", '=%1', '');
                IF SampleOrder.FIND('-') THEN BEGIN
                    IF Rec."PO No." = '' THEN
                        IF SampleOrder."SO Created" = FALSE THEN
                            IF CONFIRM(STRSUBSTNO(Text0002, Rec."Sell-to Customer No.")) THEN
                                Rec.CreateSampleOrder(SampleOrder);
                END;
                //mo tri1.0 Customization no.15 end
                //SelltoCustomerNoOnAfterV;  //Standard
                // SelltoCustomerNoOnAfterValidat;//16630 Base Funcation

                IF Rec."Location Code" = 'SKD-SAMPLE' THEN BEGIN
                    // Rec.VALIDATE(Structure, 'SAMPLEGST');16630 Table field N/f
                    Rec.VALIDATE("Payment Terms Code", '0');
                    Rec.VALIDATE("Shipping Agent Code", 'TPT09');
                    Rec.VALIDATE(None, TRUE);
                    Rec.VALIDATE("Order Change Remarks", 'ICR00001');
                    Rec.MODIFY;
                END;

                IF chanel.GET(Rec."No.") THEN
                    CFLimit := chanel."CF Limit";

                rec."Order Booked Date" := CURRENTDATETIME;
                rec.MODIFY;
            end;
        }

        modify("Sell-to Contact No.")
        {
            trigger OnBeforeValidate()
            begin
                rec."Order Booked Date" := CURRENTDATETIME;
                rec.MODIFY
            end;

        }

        modify("Currency Code")
        {
            trigger OnAfterValidate()
            begin
                CurrencyCodeOnAfterValidate;
            end;
        }

        modify("Vehicle No.")
        {
            trigger OnAfterValidate()
            begin
                Rec."Truck No." := Rec."Vehicle No.";
                Rec.MODIFY;

            end;
        }
        addafter("No.")
        {
            field("Sales Type"; Rec."Sales Type")
            {
                Importance = Standard;
                ApplicationArea = All;
            }
        }
        moveafter("Sell-to Customer No."; "Sell-to Contact No.")
        addbefore("Ship-to City")
        {
        }
        addafter("Sell-to City")
        {
            field("Sell-to Address1"; Rec."Sell-to Address")
            {
                Caption = 'Sell-to Address';
                ApplicationArea = All;
            }
            field("Sell-to Customer Name1"; Rec."Sell-to Customer Name")
            {
                Caption = 'Sell-to Customer Name';
                ApplicationArea = All;
            }
            field("State Description"; Rec."State Description")
            {
                ApplicationArea = All;
            }
            field("Customer Type"; Rec."Customer Type")
            {
                //Editable = "Customer TypeEditable";
                ApplicationArea = All;
                Editable = false;
            }
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Calculate Insurance"; Rec."Calculate Insurance")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    SalesRecsetup: Record "Sales & Receivables Setup";
                    chargeItemRec: Record "Item Charge";
                    recSalesLine1: Record "Sales Line";
                begin
                    if not Rec."Calculate Insurance" then begin
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
            }
            field("CD Available for Utilisation"; Rec."CD Available for Utilisation")
            {
                ApplicationArea = All;
            }
            field("Discount Charges %"; Rec."Discount Charges %")
            {
                Caption = 'Discount Charge %';
                Editable = "Discount Charges %Editable";
                Importance = Promoted;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    if Rec."Discount Charges %" = 0 then begin
                        Rec."Discount Amount" := 0;
                        CurrPage.Update;
                    end;
                end;
            }
            field("Discount Amount"; Rec."Discount Amount")
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("Structure Freight Amount"; Rec."Structure Freight Amount")
            {
                ApplicationArea = All;
            }
            field("Trade Discount"; Rec."Trade Discount")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Insurance Amount"; Rec."Insurance Amount")
            {
                ApplicationArea = all;
                Editable = false;

            }
            field("CD Applicable"; Rec."CD Applicable")
            {
                ApplicationArea = All;
                //Editable = false;

                trigger OnValidate()
                var
                    RecSalesLine: Record "Sales Line";
                begin
                    if not Rec."CD Applicable" then begin
                        Clear(RecSalesLine);
                        RecSalesLine.RESET;
                        RecSalesLine.SetRange("Document No.", Rec."No.");
                        if RecSalesLine.findset then begin
                            repeat
                                RecSalesLine."Trade Discount Amount" := 0;
                                RecSalesLine.Modify;
                            until RecSalesLine.next = 0;
                        end;

                        Rec."Trade Discount" := 0;

                        CalculateStructure();

                    end;
                end;
            }
            field("CF Limit"; CFLimit)
            {
                Editable = false;
                Style = StandardAccent;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("Bypass Auto Order Process"; Rec."Bypass Auto Order Process")
            {
                Importance = Standard;
                ApplicationArea = All;
            }

            field("GST Registration No."; Rec."Customer GST Reg. No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Approval Pending At"; Rec."Approval Pending At")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Qty. To Ship"; Rec."Qty. To Ship")
            {
                ApplicationArea = All;
            }
        }
        addafter("Customer Posting Group")
        {
            field("Invoice Discount Amount"; Rec."Invoice Discount Amount")
            {
                ApplicationArea = all;
            }
        }
        movebefore("Customer GST Reg. No."; "GST Customer Type", Status)
        modify("GST Customer Type")
        {
            Editable = true;
        }
        modify("Ship-to GST Customer Type")
        {
            Editable = true;
        }
        moveafter("External Document No."; "Salesperson Code", "Payment Terms Code", "Shipping Agent Code")
        modify("Shipping Agent Code")
        {
            Caption = 'TPT Method';
            Editable = true;
            trigger OnAfterValidate()
            begin
                IF ShipAgent.GET(Rec."Shipping Agent Code") THEN
                    tptmth := ShipAgent.Name;
            end;
        }
        modify("Payment Terms Code")
        {
            Editable = "Payment Terms CodeEditable";
            Importance = Promoted;

            trigger OnAfterValidate()
            begin
                IF Rec.Status = Rec.Status::"Price Approved" THEN
                    ERROR('Payment Term Cannot be changed');

            end;
        }
        addafter("External Document No.")
        {
            field(Quantity; Rec.Quantity)
            {
                ApplicationArea = All;
            }
            field("Qty in Sq. Mt."; Rec."Qty in Sq. Mt.")
            {
                Importance = Standard;
                ApplicationArea = All;
            }
            field("Dealer Code"; Rec."Dealer Code")
            {
                Caption = 'ORC Code';
                Editable = "Dealer CodeEditable";
                ApplicationArea = All;
            }
            field("ORC Terms"; Rec."ORC Terms")
            {
                Editable = "ORC TermsEditable";
                ApplicationArea = All;
            }
            field("Location Code "; Rec."Location Code")
            {
                ApplicationArea = all;
            }
            field("Status "; Rec.Status)
            {
                ApplicationArea = all;
            }

            /* field("Posting No. Series"; Rec."Posting No. Series")
             {
                 Editable = true;
                 Enabled = true;
                 ApplicationArea = All;
             }
              field("Posting No."; Rec."Posting No.")
             {
                 Editable = false;
                 Enabled = false;
                 ApplicationArea = All;
             } */

            field("Salesperson Description"; Rec."Salesperson Description")
            {
                ApplicationArea = All;
            }
            field("BH Code"; Rec."PCH Code")
            {
                Editable = false;
                Importance = Standard;
                ApplicationArea = All;
            }

            field("Order Received Date Time"; Rec."Order Booked Date")
            {
                Caption = 'Order Received Date Time';
                Visible = true;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    IF rec."Document Date" < DT2DATE(rec."Order Booked Date") THEN
                        ERROR('Order Booked Date cannot be Greater than Order Date');

                end;
            }
            field("Group Code"; Rec."Group Code")
            {
                Editable = "Group CodeEditable";
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    IF Rec."Discount Charges %" <> 0 THEN
                        ERROR('You Cannot Change the Group while the Discount Not = 0');
                end;
            }

            field(Pay; Rec.Pay)
            {
                Editable = PayEditable;
                Enabled = true;
                Importance = Standard;
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }

            field("Transport Method Desc."; tptmth)
            {
                Caption = 'Transport Method Desc.';
                Editable = false;
                Enabled = false;
                ApplicationArea = All;
            }
            field("PMT Code"; Rec."PMT Code")
            {
                Editable = true;
                Importance = Promoted;
                ApplicationArea = All;

                trigger OnValidate()
                var
                    Customer: Record Customer;
                    Location: Record Location;
                begin
                    /*IF RecLocation.GET("Location Code") THEN
                       IF RecLocation.Depot = FALSE THEN
                          ERROR('You Cannot Enter the PMT Code')
                      // ELSE;*/
                    IF Customer.GET(Rec."Sell-to Customer No.") THEN
                        IF (Customer."Tableau Zone" <> 'Enterprise') AND (Customer."Tableau Zone" <> 'Exim') THEN
                            ERROR('You Cannot Enter the PMT Code')


                end;
            }
            field("Reason to Cancell"; Rec."Reason Code")
            {
                Caption = 'Reason to Cancell';
                ApplicationArea = All;
            }
            label("S u p p o r t e d  B y :-")
            {
                Style = StrongAccent;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field(SET; Rec.BD)
            {
                ApplicationArea = All;
            }
            field("Specify Enterprise Team"; Rec."Business Development")
            {
                ApplicationArea = All;
            }
            field(GET; Rec.GPS)
            {
                ApplicationArea = All;
            }
            field("Govt. Enterprise Team"; Rec."Govt. Project Sales")
            {
                ApplicationArea = All;
            }
            field(PET; Rec.CKA)
            {
                ApplicationArea = All;
            }
            field("Private Enterprise Team"; Rec."CKA Code")
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
            field(None; Rec."None")
            {
                ApplicationArea = All;
            }
            field("PO No."; Rec."PO No.")
            {
                Description = 'Customization No. 15';
                Editable = "PO No.Editable";
                ApplicationArea = All;
            }
            field(Remarks; Rec.Remarks)
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("Reason To Hold"; Rec.Commitment)
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    IF reas.GET(Rec.Commitment) THEN
                        Rec.Commitment := reas.Description;
                end;
            }
            field("Morbi Team"; Rec."Entry Date")
            {
                ApplicationArea = All;
            }
            field("Order Processed Date"; Rec."Payment Date 3")
            {
                Caption = 'Order Processed Date';
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    IF (UPPERCASE(USERID) <> 'FA028') AND (UPPERCASE(USERID) <> 'MA023') AND (UPPERCASE(USERID) <> 'MA030') THEN
                        ERROR('You are not authorized to change the Date');
                end;
            }
            field("Item Change Remarks"; Rec."Order Change Remarks")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    IF reas1.GET(Rec."Order Change Remarks") THEN
                        Rec."Order Change Remarks" := reas1.Description;
                end;
            }
            field("Despatch Remarks"; Rec."Despatch Remarks")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    //IF reas.GET("Despatch Remarks") THEN
                    //"Despatch Remarks" := reas.Description;
                end;
            }
        }
        addafter(SalesLines)
        {
            group("Payment Confirmation")
            {
                Caption = 'Payment Confirmation';
                Visible = true;
                field("Bank Info"; Rec."Approved By")
                {
                    ApplicationArea = All;
                }
                field("LC Number"; Rec."LC Number")
                {
                    ApplicationArea = All;
                }
                /*  field("Amount to Customer"; "Amount to Customer")//16630 table field N/F
                  {
                      Importance = Promoted;
                  }*/
            }
            group(Test)
            {
                Caption = 'Test';
                Visible = false;
                field("Tax Registration No."; Rec."Tax Registration No.")
                {
                    Editable = "Tax Registration No.Editable";
                    Enabled = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Add Insu Discount"; Rec."Add Insu Discount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(COCO; Rec.COCO)
                {
                    Editable = COCOEditable;
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("COCO Store"; Rec."COCO Store")
                {
                    Editable = "COCO StoreEditable";
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Abatement Required"; Rec."Abatement Required")
                {
                    Editable = false;
                    MultiLine = true;
                    ApplicationArea = All;
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                Visible = false;
                field("Insurance Amount1"; Rec."Insurance Amount")
                {
                    Caption = 'Insurance Amount';
                    ApplicationArea = All;
                }
                field("Invoice Disc. Code"; Rec."Invoice Disc. Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Releasing Date"; Rec."Releasing Date")
                {
                    Caption = 'Releasing Date  Time';
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Releasing Time"; Rec."Releasing Time")
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = All;

                }

                /* 16630  field("Credit Card No."; "Credit Card No.")
                   {
                   }
                   field(GetCreditcardNumber; GetCreditcardNumber)
                   {
                       Caption = 'Cr. Card Number (Last 4 Digits)';
                   }*/
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name 2"; Rec."Ship-to Name 2")
                {
                    Editable = "Ship-to Name 2Editable";
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec."Ship-to Name" <> xRec."Ship-to Name" THEN
                            Rec."Ship to Pin" := '';
                    end;
                }
                field("Ship-to State Code"; Rec."GST Ship-to State Code")
                {
                    Caption = 'Ship-to State Code';
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF state1.GET(Rec."GST Ship-to State Code") THEN
                            gststatedesc := state1.Description;
                    end;
                }
                field("Ship To State Desc"; gststatedesc)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship to Pin"; Rec."Ship to Pin")
                {
                    ApplicationArea = All;
                }
                field("<Sell-to Contact No..>"; Rec."Sell-to Contact No.")
                {
                    Caption = 'Sell-to Contact No..';
                    Editable = true;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                /* 16630  field("Transit Document"; "Transit Document")
                   {
                       Editable = false;
                   }*/
                field("Phone No."; "Phone No.")
                {
                    Caption = 'Phone No.';
                    Editable = true;
                    ApplicationArea = All;
                }

                /*   field("Completely Shipped"; Rec."Completely Shipped")
                  {
                      Editable = false;
                      ApplicationArea = All;
                  } */
                field("Shipping No. Series"; Rec."Shipping No. Series")
                {
                    ApplicationArea = All;
                }
                field("Shipping No."; Rec."Shipping No.")
                {
                    ApplicationArea = All;
                }
                field("Ship to Phone No."; Rec."Ship to Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Road Permit"; Rec."Road Permit")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Editable = false;
                    Importance = Standard;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //BilltoCustomerNoOnAfterValidate;
                        //16630  BilltoCustomerNoOnAfterValidat
                    end;
                }
                field("Bill-to Name 2"; Rec."Bill-to Name 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Make Order Date"; Rec."Make Order Date")
                {
                    Editable = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Locked Order"; Rec."Locked Order")
                {
                    Caption = 'Locked';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transporter's Name"; Rec."Transporter's Name")
                {
                    Caption = 'Transporter Code';
                    ApplicationArea = All;
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ApplicationArea = All;
                }
                field("Truck No."; Rec."Truck No.")
                {
                    ApplicationArea = All;
                }
                field("Driver No."; Rec."Your Reference")
                {
                    Caption = 'Driver No.';
                    ApplicationArea = All;
                }
                field("Container No."; Rec."Vehicle No.")
                {
                    Caption = 'Container No.';
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Loading Inspector"; Rec."Loading Inspector")
                {
                    ApplicationArea = All;
                }
                field("GR No."; Rec."GR No.")
                {
                    ApplicationArea = All;
                }
                field("GR Date"; Rec."GR Date")
                {
                    ApplicationArea = All;
                }
                field("Freight / MT"; Rec."GR Value")
                {
                    ApplicationArea = All;
                }
                field("Net Wt."; Rec."Net Wt.")
                {
                    ApplicationArea = All;
                }
                field("Qty In Sqmt"; Rec."Qty in Sq. Mt.")
                {
                    Caption = 'Qty In Sqmt';
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Gross Wt."; Rec."Gross Wt.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Gross Wt (Ship)"; Rec."Gross Wt (Ship)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Cust Type"; Rec."Customer Type")
                {
                    Caption = 'Cust Type';
                    Editable = "Customer TypeEditable";
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("State Name"; Rec."State Description")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Pay."; Rec.Pay)
                {
                    Caption = 'Pay.';
                    Editable = PayEditable;
                    Enabled = true;
                    Importance = Promoted;
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
        }

        movebefore("Transaction Specification"; "Job Queue Status", "Assigned User ID", "Responsibility Center", "Opportunity No.", "Campaign No.")
        movebefore("Transporter Name"; "Transport Method", "Shipping Advice", "Shipment Date", "Package Tracking No.", "Late Order Shipping", "Shipping Time", "Shipping Agent Service Code"
        , "Bill-to Contact", "Bill-to City", "Bill-to Post Code", "Bill-to Address 2", "Bill-to Address")
        movebefore("Bill-to Name 2"; "Bill-to Name", "Bill-to Contact No.", "Shortcut Dimension 1 Code", "Shipment Method Code", "Outbound Whse. Handling Time")
        movebefore("Sell-to Contact No."; "Ship-to Contact")
        movebefore("Ship-to State Code"; "Ship-to City", "Ship-to Post Code", "Ship-to Address 2", "Ship-to Address")
        movebefore("Ship-to Name 2"; "Ship-to Name", "Ship-to Code", "Location Code")
        movebefore(Shipping; "Applies-to Doc. No.", "Applies-to Doc. Type", "Direct Debit Mandate ID")
        movebefore("Releasing Date"; "Prices Including VAT", "VAT Bus. Posting Group", "Payment Method Code", "Payment Discount %", "Pmt. Discount Date", "Shortcut Dimension 2 Code")

        modify("Location Code")
        {
            Editable = "Location CodeEditable";
        }
        modify("Ship-to Address 2")
        {
            Editable = true;
        }
        modify("Ship-to Code")
        {
            Editable = "Ship-to CodeEditable";
            Importance = Standard;
        }
        modify("Ship-to Name")
        {
            Editable = "Ship-to NameEditable";
            trigger OnAfterValidate()
            begin
                IF Rec."Ship-to Name" <> xRec."Ship-to Name" THEN
                    Rec."Ship to Pin" := '';
            end;
        }
        modify("Ship-to City")
        {
            Editable = "Ship-to CityEditable";
            Enabled = true;
        }
        modify("Ship-to Post Code")
        {
            Editable = "Ship-to Post CodeEditable";
            Importance = Standard;
        }
        modify("Ship-to Address")
        {
            Editable = true;
            trigger OnAfterValidate()
            begin
                IF Rec."Ship-to Name" <> xRec."Ship-to Name" THEN
                    Rec."Ship to Pin" := '';
            end;
        }
        addafter("Transaction Specification")
        {
            field("Blanket Order No."; Rec."Blanket Order No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        movebefore("Area"; "No. of Archived Versions")
        addafter("Area")
        {
            /* field(compinfo."T.I.N. No.";//16630
                 compinfo."T.I.N. No.")
             {
                 Caption = 'Tax Registration No.';
                 Editable = false;
             }*/
            field("TPT Method"; Rec."TPT Method")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("RELEASING DATETIME"; Rec."RELEASING DATETIME")
            {
                Caption = 'Releasing Date Time';
                Editable = false;
                ApplicationArea = All;
            }

            field(State; Rec.State)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Calculate Discount"; Rec."Calculate Discount")
            {
                Editable = false;
                ApplicationArea = All;
            }

            field(Updated; Rec.Updated)
            {
                ApplicationArea = All;
            }
            /* 16630   field("Nature of Services"; "Nature of Services")
                {
                }
                field(PoT; PoT)
                {
                }
                field("Form Code"; "Form Code")
                {
                    Importance = Promoted;
                }
                field("Form No."; "Form No.")
                {
                }*/
            field("Posting Date2"; Rec."Posting Date")
            {
                Caption = 'Date of Removal';
                ApplicationArea = All;
            }
        }
        //  moveafter("Control 1500023"; "Control 155")//16630
    }
    actions
    {

        addafter("&Print")
        {
            action("order report test")
            {
                ApplicationArea = All;
                Promoted = true;

                trigger OnAction()
                var
                    RS: Record "Report Selections";
                begin
                    if RS.get(RS.Usage::"S.Order", 1) then begin
                        RS."Report ID" := 50713;
                        RS.Modify();
                    end;
                end;
            }

        }

        modify(Release)
        {
            trigger OnBeforeAction()
            begin
                rec.TESTFIELD(Status, Rec.status::Approved);
                rec.TESTFIELD("Shortcut Dimension 1 Code");

                if Rec."Ship to Pin" = '' then
                    Error('Ship to Pin must have value..');

                if Rec."GST Ship-to State Code" = '' then
                    Error('Ship to State must have value..');

                if Rec."Ship-to Post Code" = '' then
                    Error('Ship to Post Code must have value..');


                IF Customer.GET(rec."Sell-to Customer No.") THEN
                    IF Customer.Blocked = Customer.Blocked::"Order Releasing" THEN
                        ERROR('Customer is Blocked for Order Releasing');

                //Upgrade(+)
                /* SalesLine1.RESET;
                SalesLine1.SETRANGE("Document Type", rec."Document Type");
                SalesLine1.SETRANGE("Document No.", rec."No.");
                SalesLine1.SETRANGE("Structure Calculated", FALSE);
                IF SalesLine1.FINDFIRST THEN
                    ERROR('Please Press F10 Before Releasing');
 */
                rec.TESTFIELD("Sales Type");

                //Commented by Deepak Start
                IF Customer.GET(rec."Sell-to Customer No.") THEN
                    IF Customer."IC Partner Code" <> '' THEN
                        ERROR(Text0010);

                //MS-PB END;


                //TRI
                IF UserSetup.GET(USERID) THEN BEGIN
                    IF UserSetup."Allow SO Release" = FALSE THEN
                        ERROR('%1 has no permission to Release the Sales Order', UserSetup."User ID");
                END;
                //TRI
                //TRI DG 020810 Add Start
                SalesLine1.RESET;
                SalesLine1.SETRANGE("Document Type", rec."Document Type");
                SalesLine1.SETRANGE("Document No.", rec."No.");
                IF SalesLine1.FIND('-') THEN
                    REPEAT
                        SalesLine1.TESTFIELD(SalesLine1."Quantity (Base)");
                    UNTIL SalesLine1.NEXT = 0;
                //TRI A.S 07.11.08 Code End

                //mo tri1.0 Customization no.44 start
                rec.TESTFIELD("Sell-to Post Code");
                rec.TESTFIELD("Payment Terms Code"); //TRI A.S 30.12.08

                Clear(SalesLine1);
                SalesLine1.RESET;
                SalesLine1.SETRANGE("Document Type", rec."Document Type");
                SalesLine1.SETRANGE("Document No.", rec."No.");
                SalesLine1.SETFILTER(Type, '%1', SalesLine1.Type::Item); //ND
                SalesLine1.SETFILTER(Quantity, '<>%1', 0);
                IF SalesLine1.FIND('-') THEN
                    REPEAT
                        // SalesLine1.TESTFIELD(SalesLine1."Form Code", "Form Code");
                        SalesLine1.VALIDATE("Qty. to Ship", 0);
                        SalesLine1.VALIDATE("Qty. to Invoice", 0);
                        SalesLine1.MODIFY;
                    UNTIL SalesLine1.NEXT = 0;

                //mo tri1.0 Customization no.44 end

                //mo tri1.0 customization no. start
                SalesLine1.RESET;
                SalesLine1.SETRANGE("Document Type", rec."Document Type");
                SalesLine1.SETRANGE("Document No.", rec."No.");
                SalesLine1.SETFILTER(Type, '>0');
                SalesLine1.SETFILTER(Quantity, '<>0');
                SalesLine1.SETFILTER("Unit Price", '%1', 0);
                SalesLine1.SETFILTER(Type, '%1', SalesLine1.Type::Item); //ND
                IF SalesLine1.FIND('-') THEN BEGIN
                    ERROR(Text0004, SalesLine1.Type, SalesLine1."No.");
                END;
                //mo tri1.0 customization no. end
                //ND  Start
                /* SalesLine1.RESET;
                SalesLine1.SETRANGE("Document Type", rec."Document Type");
                SalesLine1.SETRANGE("Document No.", rec."No.");
                SalesLine1.SETFILTER(Type, '%1', SalesLine1.Type::Item);
                SalesLine1.SETFILTER(Quantity, '<>0');
                SalesLine1.SETFILTER("MRP Price", '%1', 0);
                IF SalesLine1.FIND('-') THEN BEGIN
                    ERROR(Text0005, SalesLine1.Type, SalesLine1."No.");
                END; *///T
                //ND End
                //mo tri1.0 Customization no.45 start
                DateFilter := '..' + FORMAT(rec."Order Date");
                SalesLine2.RESET;
                SalesLine2.SETRANGE("Document Type", rec."Document Type");
                SalesLine2.SETRANGE("Document No.", rec."No.");
                SalesLine2.SETRANGE(Type, SalesLine2.Type::Item);
                SalesLine2.SETFILTER(Quantity, '<>0');
                IF SalesLine2.FIND('-') THEN
                    REPEAT
                        SalesLine2.CALCFIELDS("Reserved Qty. (Base)");
                        IF (SalesLine2."Reserved Qty. (Base)" < SalesLine2."Quantity (Base)") AND (USERID <> 'FA028') AND (USERID <> 'DE002') AND (USERID <> 'DE018') AND (USERID <> 'DE011')
                            AND (USERID <> 'DE014') AND (USERID <> 'DE016') AND (USERID <> 'DE012') AND (USERID <> 'DE011') AND (USERID <> 'DE023') THEN BEGIN
                            ERROR(Text0001, SalesLine2."Line No.");
                            Item.RESET;
                            //Item.SETFILTER("No.",SalesLine2."No."); //MSKS3012
                            Item.GET(SalesLine2."No."); //MSKS3012
                            Item.SETFILTER("Date Filter", DateFilter);
                            Item.SETFILTER("Location Filter", SalesLine2."Location Code");
                            Item.SETFILTER("Variant Filter", '%1', SalesLine2."Variant Code");
                            IF Item.FIND('-') THEN BEGIN
                                Item.CALCFIELDS("Net Change", "Reserved Qty. on Inventory");
                                //AvailableQuantity := ROUND(Item."Net Change")  - ROUND(Item."Reserved Qty. on Inventory");//TRI-VKG COMMENT
                                AvailableQuantity := Item."Net Change" - Item."Reserved Qty. on Inventory"; //TRI-VKG ADD
                            END;
                            IF (SalesLine2.Quantity) > (AvailableQuantity) THEN
                                ERROR(Text0001, SalesLine2."Line No.");
                        END;
                        //    Bin.SETRANGE(Bin."Location Code",SalesLine2."Location Code");
                        //    IF Bin.FIND('-') THEN BEGIN
                        IF SalesLine2.COCO = FALSE THEN
                            IF SalesLine2."Bin Code" <> '' THEN BEGIN
                                BinContent.GET(SalesLine2."Location Code", SalesLine2."Bin Code", SalesLine2."No.",
                                SalesLine2."Variant Code", SalesLine2."Unit of Measure Code");
                                BinContent.CALCFIELDS(BinContent.Quantity);
                                IF BinContent.Quantity < SalesLine2.Quantity THEN
                                    ERROR('Insufficient Bin Quantity for line no %1', SalesLine2."Line No.");
                            END;

                    UNTIL SalesLine2.NEXT = 0;
                //mo tri1.0 Customization no.45 end;
                rec."Posting Date" := 0D;
                rec."Shipment Date" := 0D;
                rec.MODIFY;

                //ND  Start
                SalesLine1.RESET;
                SalesLine1.SETRANGE("Document Type", rec."Document Type");
                SalesLine1.SETFILTER(Type, '%1', SalesLine1.Type::Item); //ND
                SalesLine1.SETRANGE("Document No.", rec."No.");
                IF SalesLine1.FIND('-') THEN
                    REPEAT
                        SalesLine1.VALIDATE(SalesLine1."Discount Per Unit", SalesLine1."Discount Per Unit");
                        SalesLine1.MODIFY;
                    UNTIL SalesLine1.NEXT = 0;
                IF rec."Document Type" = rec."Document Type"::Order THEN BEGIN    //TRI A.S 04.08.09 Code Added
                    rec."Locked Order" := TRUE;
                    rec.MODIFY;
                    COMMIT;
                    //Trident-Rakesh-End 260906


                    rec."Releasing Date" := WORKDATE;  //ravi
                    rec."Releasing Time" := TIME;   //ravi
                END;  //TRI A.S 04.08.09 Code Added
                      // MIJS.begin
                Customer.RESET;
                Customer.GET(rec."Sell-to Customer No.");
                IF Customer.Blocked = Customer.Blocked::All THEN
                    Customer.FIELDERROR(Blocked);
                // MIJS.end
                IF rec."Sell-to Customer No." <> rec."Bill-to Customer No." THEN
                    ERROR(Text009, rec."Sell-to Customer No.", rec."Sell-to Customer Name")
                ELSE
                    ReleaseSalesDoc.PerformManualRelease(Rec);
                //FreezeCNDetails(Rec);

                //MSKS
                //MSKS


                CLEAR(CreateSO);
                CreateSO.InsertTMSData(rec."No."); //MSKS


            end;
        }



        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            begin
                SalesSetup.GET;
                IF SalesSetup."Credit Warnings" IN [SalesSetup."Credit Warnings"::"Both Warnings",
                                                SalesSetup."Credit Warnings"::"Credit Limit"] THEN
                    IF Rec."Document Type" IN [Rec."Document Type"::Order] THEN
                        CustCheckCreditLimit.SalesHeaderCheck(Rec);

                IF Customer.GET(Rec."Sell-to Customer No.") THEN
                    IF Customer.Blocked = Customer.Blocked::"Order Releasing" THEN
                        ERROR('Customer is Blocked for Order Processing');

                /*
                CLEAR(GSTNManagement);
                                IF GSTNManagement.CheckUpdateGSTN(2, "Sell-to Customer No.", Customer."GST Registration No.", GSTNMsg) THEN
                                    ERROR('GSTN Invalid -  %1', GSTNMsg);
                 */

                IF NOT ((Rec.BD = TRUE) OR (Rec.GPS = TRUE) OR (Rec.None = TRUE) OR (Rec.Retail = TRUE) OR (Rec.CKA = TRUE)) THEN
                    ERROR('Please Mark The Sales Support');

                IF Rec.BD = TRUE THEN
                    Rec.TESTFIELD("Business Development");

                IF Rec.GPS = TRUE THEN
                    Rec.TESTFIELD("Govt. Project Sales");

                IF Rec.CKA = TRUE THEN
                    Rec.TESTFIELD("CKA Code");

                IF Rec.Retail = TRUE THEN
                    Rec.TESTFIELD("Retail Code");

                IF Rec."Ship to Pin" = '' THEN
                    ERROR('Ship To Pin Cannot Blank');

                IF Rec."Payment Terms Code" = '' THEN
                    ERROR('Please Enter Payment Terms in Header !!!');

                IF Rec."Order Change Remarks" = '' THEN
                    ERROR('Item Change Remarks Cannot Blank');


                Rec.TESTFIELD("GST Ship-to State Code");
                Rec.TESTFIELD("Ship-to Post Code");


                //16630 TESTFIELD(Structure); //MSKS2509
                //IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN; 
                /* 
                SalesLine1.RESET;
                SalesLine1.SETRANGE("Document Type", Rec."Document Type");
                SalesLine1.SETRANGE("Document No.", Rec."No.");
                SalesLine1.SETRANGE("Structure Calculated", FALSE);
                IF SalesLine1.FINDFIRST THEN
                    ERROR('Please Press F10 Before Releasing');
 */
                SalesLine1.RESET;
                SalesLine1.SETRANGE("Document Type", Rec."Document Type");
                SalesLine1.SETRANGE("Document No.", Rec."No.");

                IF SalesLine1.FINDFIRST THEN BEGIN
                    REPEAT
                        IF SalesLine1.D7 <> 0 THEN IF SalesLine1."Line Discount %" = 0 THEN ERROR('Please Re-enter Requested Discount');

                        IF SalesLine1."Approval Required" THEN
                            IF SalesLine1."AD Remarks" = '' THEN
                                ERROR('Please select AD Reason for Higher Discount in Line No. %1', SalesLine1."Line No.");
                    UNTIL SalesLine1.NEXT = 0;
                END;

                Rec.SendForApproval;
                Rec."Approval Pending At" := Rec."Approval Pending At"::PCH;
                Rec.MODIFY;

            end;
        }
        modify("Print Confirmation")
        {
            Caption = 'Order Confirmation';
            ApplicationArea = All;
        }

        modify(Reopen)
        {

            trigger OnBeforeAction()
            begin
                SalesLine1.RESET;
                SalesLine1.SETRANGE(SalesLine1."Document Type", Rec."Document Type");
                SalesLine1.SETRANGE("Document No.", Rec."No.");
                SalesLine1.SETRANGE("Structure Calculated", TRUE);
                SalesLine1.MODIFYALL("Structure Calculated", FALSE);

                SL.RESET;        //6700
                SL.SETRANGE("Document Type", Rec."Document Type");
                SL.SETRANGE("Document No.", Rec."No.");
                SL.SETFILTER("Quantity Shipped", '<>%1', 0);
                IF SL.FINDFIRST THEN
                    ERROR('You can not Reopen the SO As it has been partially shipped');

                //TRI
                IF UserSetup.GET(USERID) THEN BEGIN
                    IF UserSetup."Allow SO Reopen" = FALSE THEN
                        ERROR('%1 has no permission to Reopen the Sales Order', UserSetup."User ID");
                END;
                //TRI
                //Upgrade(-)

                ReleaseSalesDoc.PerformManualReopen(Rec);
                CLEAR(CreateSO);
                CreateSO.InsertTMSData(Rec."No."); //MSKS


                Rec."Credit Approved" := FALSE;
                // Rec."Inventory Approved" := FALSE;
                Rec."Price Approved" := FALSE;
                Rec."Direct Not Approved" := FALSE;
                Rec.MODIFY;


                SL.RESET;        //6700
                SL.SETRANGE("Document Type", rec."Document Type");
                SL.SETRANGE("Document No.", rec."No.");
                SL.SETFILTER("Quantity Shipped", '<>%1', 0);
                IF SL.FINDFIRST THEN
                    ERROR('You can not Reopen the SO As it has been partially shipped');

                //TRI
                IF UserSetup.GET(USERID) THEN BEGIN
                    IF UserSetup."Allow SO Reopen" = FALSE THEN
                        ERROR('%1 has no permission to Reopen the Sales Order', UserSetup."User ID");
                END;
                rec."Credit Approved" := FALSE;
                //"Inventory Approved" := FALSE;
                rec."Price Approved" := FALSE;
                rec."Direct Not Approved" := FALSE;
                rec.MODIFY;
            end;
        }

        modify(CancelApprovalRequest)
        {
            Visible = false;
            /*  trigger OnBeforeAction()
             begin
                 IF Rec.Status = Rec.Status::Released THEN
                     ERROR('Order is Already Released');

                 Rec.ReopenOrder;
             end; */
        }


        //Unsupported feature: Code Modification on "Action 1500034.OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SalesLine.CalculateStructures(Rec);
        SalesLine.AdjustStructureAmounts(Rec);
        SalesLine.UpdateSalesLines(Rec);
        OpenExciseCentvatClaimForm;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SalesLine.CalculateStructures(Rec);
        SalesLine.AdjustStructureAmounts(Rec);
         SalesLine.CalculateTCS(Rec);
        SalesLine.UpdateSalesLines(Rec);
        SalesLine.CalculateTCS(Rec);
        OpenExciseCentvatClaimForm;
        */
        //end;

        //Unsupported feature: Code Modification on "Action 76.OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Post(CODEUNIT::"Sales-Post + Print");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
         //upgrade(+)
                                             //mo tri1.0 Customization no. start
                                          TESTFIELD(Status,Status::Released); //MSKS
                                          TESTFIELD("Shortcut Dimension 1 Code");
                                             //ksrv add on 171012 for stop the value in Negative.
                                             CALCFIELDS("Amount to Customer");
                                             IF "Amount to Customer" < 0 THEN
                                               ERROR(Err001,"Amount to Customer");

                                             IF "Old Order for Post" THEN
                                              BEGIN
                                               TESTFIELD("Shipping No.");
                                               TESTFIELD("Posting No.");
                                              END;

                                             IF Status = Status::Open THEN
                                               ERROR(Text0003);
                                             //mo tri1.0 Customization no. end

                                             // NAVIN
                                             IF Structure <> '' THEN BEGIN
                                               SalesLine.CalculateStructures(Rec);
                                               SalesLine.AdjustStructureAmounts(Rec);
                                                SalesLine.CalculateTCS(Rec);
                                               SalesLine.UpdateSalesLines(Rec);
                                               SalesLine.CalculateTCS(Rec);
                                               COMMIT;
                                             END;
                                             //Vipul Tri1.0 Start
                                             SalesLine1.RESET;
                                             SalesLine1.SETRANGE("Document Type","Document Type");
                                             SalesLine1.SETRANGE("Document No.","No.");
                                             IF SalesLine1.FIND('-') THEN REPEAT
                                               StrOrdLineDetail.RESET;
                                               StrOrdLineDetail.SETFILTER(StrOrdLineDetail.Type, '%1', StrOrdLineDetail.Type::Sale);
                                               StrOrdLineDetail.SETFILTER(StrOrdLineDetail."Document Type", '%1', StrOrdLineDetail."Document Type"::Order);
                                               StrOrdLineDetail.SETFILTER(StrOrdLineDetail."Document No.", '%1', SalesLine1."Document No.");
                                               StrOrdLineDetail.SETFILTER(StrOrdLineDetail."Item No.", '%1', SalesLine1."No.");
                                               StrOrdLineDetail.SETFILTER(StrOrdLineDetail."Line No.", '%1', SalesLine1."Line No.");
                                               IF StrOrdLineDetail.FIND('-') THEN REPEAT
                                                 IF StrOrdLineDetail."Tax/Charge Type" = StrOrdLineDetail."Tax/Charge Type"::"Sales Tax" THEN
                                                   IF SalesLine1."Tax Amount" = 0 THEN
                                                     SalesLine1.TESTFIELD(SalesLine1."Tax Amount");
                                                 IF StrOrdLineDetail."Tax/Charge Type" = StrOrdLineDetail."Tax/Charge Type"::Excise THEN
                                                   IF SalesLine1."Excise Amount" = 0 THEN
                                                     SalesLine1.TESTFIELD(SalesLine1."Excise Amount");
                                               UNTIL StrOrdLineDetail.NEXT = 0;
                                             UNTIL SalesLine1.NEXT = 0;
                                             //Vipul Tri1.0 end
                                         //upgrade(-)

                                         Post(CODEUNIT::"Sales-Post + Print");

                                         //Upgrade(-)
                                             //mo tri1.0 Customization no.44 start
                                             SalesLine1.RESET;
                                             SalesLine1.SETRANGE("Document Type","Document Type");
                                             SalesLine1.SETRANGE("Document No.","No.");
                                             SalesLine1.SETFILTER(Type,'>0');
                                             SalesLine1.SETFILTER(Quantity,'<>0');
                                             IF SalesLine1.FIND('-') THEN
                                               REPEAT
                                                 IF SalesLine1.Quantity > SalesLine1."Qty. to Ship" THEN BEGIN
                                                   SalesLine1.VALIDATE("Qty. to Ship",0);
                                                   SalesLine1.VALIDATE("Qty. to Invoice",0);
                                                   SalesLine1.MODIFY;
                                                 END;
                                               UNTIL SalesLine1.NEXT = 0;
                                             //mo tri1.0 Customization no.44 end

                                         //upgrade(+)
        */
        //end;

        //Unsupported feature: Code Modification on "Action 77.OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders",TRUE,TRUE,Rec);
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Released); //MSKS
        REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders",TRUE,TRUE,Rec);
        CurrPage.UPDATE(FALSE);
        */
        //end;

        addafter("Archive Document")
        {
            action("Archive Approval Entry")
            {
                Caption = 'Archive Approval Entry';
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "Archive Approval Entry";
                Visible = false;
                ApplicationArea = All;
            }

        }
        addafter(Dimensions)
        {
            action("Send For Approval Request")
            {
                ApplicationArea = Basic, Suite;
                trigger OnAction()
                begin
                    if not rec."Calculate Structure" then
                        Error('Please Calculate Structure First');
                    Rec.SendForApproval();
                    rec."Approval Pending At" := rec."Approval Pending At"::PCH;
                    rec.Modify();
                end;
            }
            action("Cancel Approval Request")
            {
                trigger OnAction()
                begin
                    IF Rec.Status = Rec.Status::Released THEN
                        ERROR('Order is Already Released');

                    Rec.ReopenOrder;
                end;

            }
            action("Calculate Structure")
            {
                ShortcutKey = 'F11';
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    SalesLine: Record "Sales Line";
                    OrderStatus: Enum "Sales Document Status";
                begin
                    Rec.TestField("Payment Terms Code");

                    //CurrPage.update;

                    Clear(SalesHeader);
                    Clear(SalesLine);
                    Clear(OrderStatus);

                    SalesHeader.reset;
                    SalesHeader.setrange("No.", Rec."No.");
                    if SalesHeader.FindFirst then begin
                        OrderStatus := SalesHeader.Status;
                        SalesHeader.Status := SalesHeader.Status::Open;
                        if SalesHeader."CD Available for Utilisation" = 0 then begin
                            SalesHeader."Trade Discount" := 0;
                            SalesHeader.Modify;

                            Clear(SalesLine);
                            SalesLine.RESET;
                            SalesLine.SETRANGE("Document No.", Rec."No.");
                            SalesLine.SetRange(Type, SalesLine.Type::Item);
                            if SalesLine.FindSet then
                                SalesLine.ModifyAll("Trade Discount Amount", 0);
                        end;
                    end;

                    //CurrPage.update;

                    Clear(SalesLine);
                    SalesLine.RESET;
                    SalesLine.SETRANGE("Document No.", Rec."No.");
                    if SalesLine.FindSet then begin
                        repeat
                            if SalesLine."Qty. to Ship" <> 0 then
                                SalesLine."Amount Inc CD" := ((SalesLine.Amount + SalesLine."Inv. Discount Amount") / SalesLine.Quantity) * SalesLine."Qty. to Ship"
                            else
                                SalesLine."Amount Inc CD" := SalesLine.Amount + SalesLine."Inv. Discount Amount";
                            SalesLine.Modify;
                        until SalesLine.Next = 0;
                    end;

                    CurrPage.update;

                    Rec.CalculateTradeCharge;

                    //CurrPage.update;
                    Rec.CalculateDiscountCharge;

                    //CurrPage.update;
                    Rec.CalculateFreight;

                    //CurrPage.update;
                    Rec.CalculateInsurance;

                    //CurrPage.update;

                    Clear(SalesHeader);
                    SalesHeader.reset;
                    SalesHeader.setrange("No.", Rec."No.");
                    if SalesHeader.FindFirst then begin
                        SalesHeader.Status := OrderStatus;
                        SalesHeader."Calculate Structure" := true;
                        SalesHeader.Modify;
                    end;

                    CurrPage.update;

                    Message('Structure Calulated Successfully..');
                end;
            }
            action("Run Sales Order Codeunit")
            {
                trigger OnAction()
                var
                    ProcessSalesOrders: Codeunit 50070;
                begin
                    ProcessSalesOrders.run;
                end;
            }
        }

        modify(Statistics)
        {
            trigger OnBeforeAction()
            var
                SalesHeader: Record "Sales Header";
                SalesLine: Record "Sales Line";
                OrderStatus: Enum "Sales Document Status";
            begin
                Rec.TestField("Payment Terms Code");

                //CurrPage.update;

                Clear(SalesHeader);
                Clear(SalesLine);
                Clear(OrderStatus);

                SalesHeader.reset;
                SalesHeader.setrange("No.", Rec."No.");
                if SalesHeader.FindFirst then begin
                    OrderStatus := SalesHeader.Status;
                    SalesHeader.Status := SalesHeader.Status::Open;
                    if SalesHeader."CD Available for Utilisation" = 0 then begin
                        SalesHeader."Trade Discount" := 0;
                        SalesHeader.Modify;

                        SalesLine.RESET;
                        SalesLine.SETRANGE("Document No.", Rec."No.");
                        SalesLine.SetRange(Type, SalesLine.Type::Item);
                        if SalesLine.FindSet then
                            SalesLine.ModifyAll("Trade Discount Amount", 0);
                    end;
                end;

                //CurrPage.update;

                Clear(SalesLine);
                SalesLine.RESET;
                SalesLine.SETRANGE("Document No.", Rec."No.");
                if SalesLine.FindSet then begin
                    repeat
                        if SalesLine."Qty. to Ship" <> 0 then
                            SalesLine."Amount Inc CD" := ((SalesLine.Amount + SalesLine."Inv. Discount Amount") / SalesLine.Quantity) * SalesLine."Qty. to Ship"
                        else
                            SalesLine."Amount Inc CD" := SalesLine.Amount + SalesLine."Inv. Discount Amount";
                        SalesLine.Modify;
                    until SalesLine.Next = 0;
                end;

                //CurrPage.update;

                Rec.CalculateTradeCharge;

                //CurrPage.update;
                Rec.CalculateDiscountCharge;

                //CurrPage.update;
                Rec.CalculateFreight;

                CurrPage.update;
                Rec.CalculateInsurance;

                //CurrPage.update;

                Clear(SalesHeader);
                SalesHeader.reset;
                SalesHeader.setrange("No.", Rec."No.");
                if SalesHeader.FindFirst then begin
                    SalesHeader.Status := OrderStatus;
                    SalesHeader."Calculate Structure" := true;
                    SalesHeader.Modify;
                end;

                CurrPage.update;

            end;
        }

        addafter("Archive Approval Entry")
        {
            group("Dr&op Shipment")
            {
                Caption = 'Dr&op Shipment';
                Visible = false;
                action("Purchase &Order")
                {
                    Caption = 'Purchase &Order';
                    Enabled = false;
                    Image = Document;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.OpenPurchOrderForm;
                    end;
                }
            }
            group("Speci&al Order")
            {
                Caption = 'Speci&al Order';
            }
        }
        addafter(AssemblyOrders)
        {
            action("Accrued Discount Details")
            {
                Caption = 'Accrued Discount Details';
                RunObject = Page "Accrued Discount Form";
                RunPageLink = "Document No." = FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            group("&Line")
            {
                Caption = '&Line';
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Visible = false;
                    action(Period)
                    {
                        Caption = 'Period';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //CurrPage.SalesLines.PAGE.ItemAvailability(0);
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        ShortCutKey = 'Ctrl+M';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //CurrPage.SalesLines.PAGE.ItemAvailability(1);
                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //CurrPage.SalesLines.PAGE.ItemAvailability(2);
                        end;
                    }
                }
                action("Reservation Entries")
                {
                    Caption = 'Reservation Entries';
                    Image = ReservationLedger;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //CurrPage.SalesLines.PAGE.ShowReservationEntries;
                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //CurrPage.SalesLines.PAGE.OpenItemTrackingLines;
                    end;
                }

                action("Select Item Substitution")
                {
                    Caption = 'Select Item Substitution';
                    Image = SelectItemSubstitution;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //CurrPage.SalesLines.PAGE.ShowItemSub;
                    end;
                }
                /* 16630   action("Co&mments")
                    {
                        Caption = 'Co&mments';
                        Image = ViewComments;
                        Visible = false;

                        trigger OnAction()
                        begin
                            //CurrPage.SalesLines.PAGE.ShowLineComments;
                        end;
                    }*/
                action("Item Charge &Assignment")
                {
                    Caption = 'Item Charge &Assignment';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ItemChargeAssgnt;
                    end;
                }
                action("Order &Promising")
                {
                    Caption = 'Order &Promising';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.OrderPromisingLine;
                    end;
                }
                action("Excise Detail")
                {
                    Caption = 'Excise Detail';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //16630  CurrPage.SalesLines.PAGE.ShowExcisePostingSetup;
                    end;
                }
                action("Detailed Tax")
                {
                    Caption = 'Detailed Tax';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //16630  CurrPage.SalesLines.PAGE.ShowDetailedTaxEntryBuffer;
                    end;
                }
                action("Calculate Tax On MRP")
                {
                    Caption = 'Calculate Tax On MRP';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        SalesLineRec: Record "Sales Line";
                        "--------tri-rk-------------": Integer;
                    // structureheader: Record "13792";//16630
                    begin//16630
                         //trident-rakesh-start
                         /* IF structureheader.GET(Structure) THEN BEGIN
                              IF structureheader."Tax Abatement" THEN BEGIN
                                  IF "Abatement Required" THEN BEGIN
                                      SalesLine.CalculateStructures(Rec);
                                      SalesLineRec.RESET;
                                      SalesLineRec.SETCURRENTKEY("Document Type", "Document No.");
                                      SalesLineRec.SETRANGE("Document Type", "Document Type");
                                      SalesLineRec.SETRANGE("Document No.", "No.");
                                      IF SalesLineRec.FIND('-') THEN
                                          REPEAT
                                              IF SalesLineRec."MRP Price" <> 0 THEN
                                                  SalesLineRec."Unit Price" := SalesLineRec."MRP Price" - (SalesLineRec."MRP Price" * SalesLineRec."Tax %") / 100;
                                              SalesLineRec.MODIFY;
                                          UNTIL SalesLineRec.NEXT = 0;
                                      SalesLine.CalculateStructures(Rec);
                                  END;
                              END;
                          END;
                          IF NOT (structureheader."Tax Abatement" AND "Abatement Required") THEN
                              MESSAGE('Please check the Abatement Required Field');*/
                         //trident-rakesh-end
                    end;
                }
            }
        }
        movebefore("Item Charge &Assignment"; Dimensions)
        moveafter(Action21; Post)
        modify(Post)
        {
            trigger OnBeforeAction()

            var
                GSTamtcheck: Codeunit CalcAmttoVendor;
                AmtGST: Decimal;
            begin
                Rec.TESTFIELD(Rec.Status, Rec.Status::Released); //MSKS
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
                rec.CheckInvoiceDiscountAmountValidation();
                CalculateStructure;
                CurrPage.update;
                Rec.CheckTradeDiscountLine;
                CurrPage.update;
                If not Rec."Calculate Structure" then
                    Error('Please Calculate the structure..');




                if rec."GST Customer Type" <> Rec."GST Customer Type"::Export then begin

                    AmtGST := GSTamtcheck.AmttoCustomer(Rec);

                    if AmtGST = 0 then
                        Error('Please Calculate GST Amount First');


                end;
            end;

            trigger Onafteraction()
            var
                Err002: Label 'Tax Amount is not Correct!!!!!';
                RecSalesHeader: Record "Sales Header";
            begin
                Rec.TESTFIELD(Rec.Status, Rec.Status::Released); //MSKS
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
                //upgrade(+)
                // NAVIN
                //KSRV add on 171012 for validate the negative value in invoice.
                //CALCFIELDS("Amount to Customer");
                //IF "Amount to Customer" < 0 THEN
                //ERROR(Err001,"Amount to Customer");
                //sash
                IF Rec."Document Type" = Rec."Document Type"::Order THEN
                    CalculateQcDiscount1;
                //sash


                IF Rec."Old Order for Post" THEN BEGIN
                    Rec.TESTFIELD("Shipping No.");
                    Rec.TESTFIELD("Posting No.");
                END;
                /*  IF Structure <> '' THEN BEGIN//16630
                      SalesLine.CalculateStructures(Rec);
                      SalesLine.AdjustStructureAmounts(Rec);
                      SalesLine.CalculateTCS(Rec);
                      SalesLine.UpdateSalesLines(Rec);
                      SalesLine.CalculateTCS(Rec);
                      COMMIT;
                  END;*/



                //MS-PB Check for Tax Amount calculation BEGIN 15111
                ///  SalesTaxCalculate.CheckStructureCalculated(Rec);
                //MESSAGE('Base..%1',ROUND(SalesTaxCalculate.GetTaxAmount(Rec),1,'>'));
                //MESSAGE('Check..%1',ROUND(SalesTaxCalculate.TaxAmountCalcCheck(Rec),1,'>'));
                //IF ROUND(SalesTaxCalculate.GetTaxAmount(Rec),1,'>')<>ROUND(SalesTaxCalculate.TaxAmountCalcCheck(Rec),1,'>') THEN
                //  ERROR(Err002);
                //MS-PB Check for Tax Amount calculation END 151112
                //Upgrade(-)

                // Post(CODEUNIT::"Sales-Post (Yes/No)");

                //Upgrad(+)
                ///  SalesTaxCalculate.UpdateStructureCalculated2(Rec);//MSAK291014
                /*//sash
                IF "Add Insu Discount"<>0 THEN  BEGIN
                   "Add Insu Discount":=0;
                   MODIFY;
                END;
                      //sash ends
                */

                //Vipul Tri1.0 Start
                /* Kulbhushan Sharma code optimize 221220
                SalesLine1.RESET;
                SalesLine1.SETRANGE("Document Type","Document Type");
                SalesLine1.SETRANGE("Document No.","No.");
                IF SalesLine1.FIND('-') THEN REPEAT
                  StrOrdLineDetail.RESET;
                  StrOrdLineDetail.SETFILTER(StrOrdLineDetail.Type, '%1', StrOrdLineDetail.Type::Sale);
                  StrOrdLineDetail.SETFILTER(StrOrdLineDetail."Document Type", '%1', StrOrdLineDetail."Document Type"::Order);
                  StrOrdLineDetail.SETFILTER(StrOrdLineDetail."Document No.", '%1', SalesLine1."Document No.");
                  StrOrdLineDetail.SETFILTER(StrOrdLineDetail."Item No.", '%1', SalesLine1."No.");
                  StrOrdLineDetail.SETFILTER(StrOrdLineDetail."Line No.", '%1', SalesLine1."Line No.");
                  IF StrOrdLineDetail.FIND('-') THEN REPEAT
                    IF StrOrdLineDetail."Tax/Charge Type" = StrOrdLineDetail."Tax/Charge Type"::"Sales Tax" THEN
                      IF SalesLine1."Tax Amount" = 0 THEN
                        SalesLine1.TESTFIELD(SalesLine1."Tax Amount");
                    IF StrOrdLineDetail."Tax/Charge Type" = StrOrdLineDetail."Tax/Charge Type"::Excise THEN
                      IF SalesLine1."Excise Amount" = 0 THEN
                        SalesLine1.TESTFIELD(SalesLine1."Excise Amount");
                  UNTIL StrOrdLineDetail.NEXT = 0;
                UNTIL SalesLine1.NEXT = 0;*/
                //Vipul Tri1.0 end

                //mo tri1.0 Customization no.44 start
                SalesLine1.RESET;
                SalesLine1.SETRANGE("Document Type", Rec."Document Type");
                SalesLine1.SETRANGE("Document No.", Rec."No.");
                SalesLine1.SETFILTER(Type, '>0');
                SalesLine1.SETFILTER(Quantity, '<>0');
                IF SalesLine1.FIND('-') THEN
                    REPEAT
                        IF SalesLine1.Quantity > SalesLine1."Qty. to Ship" THEN BEGIN
                            //SalesLine1.VALIDATE("Qty. to Ship", 0); //TEAM 14763 previous code
                            //SalesLine1.VALIDATE("Qty. to Invoice", 0); //TEAM 14763 previous code

                            SalesLine1."Qty. to Ship" := 0; //TEAM 14763 VALIDATE code has been replaced due to error
                            SalesLine1."Qty. to Invoice" := 0; //TEAM 14763 VALIDATE code has been replaced due to error

                            //SalesLine1."Structure Discount Amount" := 0;
                            //SalesLine1."Trade Discount Amount" := 0;
                            SalesLine1.MODIFY;
                        END;
                    UNTIL SalesLine1.NEXT = 0;

                CurrPage.Update;

                /*
                RecSalesHeader.Reset;
                RecSalesHeader.SetRange("No.", Rec."No.");
                if RecSalesHeader.FindFirst then begin
                    RecSalesHeader."Structure Freight Amount" := 0;
                    RecSalesHeader.Modify;
                end;
                */

                //mo tri1.0 Customization no.44 end
                /*
                //TRI SC
                IF SalesLine1.Quantity <> SalesLine1."Reserved Quantity"  THEN
                    ERROR(Text0006)

                //TRI SC
                */
                //Upgrade(-)
            end;
        }
        modify(PostAndSend)
        {
            trigger OnBeforeAction()

            var
                taxtransactionvalue: Record "Tax Transaction Value";
                saleslinecheck: Record 37;
                GSTamtcheck: Codeunit CalcAmttoVendor;
                AmtGST: Decimal;
            begin
                Rec.TESTFIELD(Rec.Status, Rec.Status::Released); //MSKS
                Rec.TESTFIELD("Shortcut Dimension 1 Code");

                rec.CheckInvoiceDiscountAmountValidation;


                if rec."GST Customer Type" <> Rec."GST Customer Type"::Export then begin

                    AmtGST := GSTamtcheck.AmttoCustomer(Rec);

                    if AmtGST = 0 then
                        Error('Please Calculate GST Amount First');


                end;

                CalculateStructure;

                CurrPage.update;

                Rec.CheckTradeDiscountLine;

                CurrPage.update;

                If not Rec."Calculate Structure" then
                    Error('Please Calculate the structure..');
            end;
        }

        modify(PostAndNew)
        {
            trigger OnBeforeAction()
            var
                GSTamtcheck: Codeunit CalcAmttoVendor;
                AmtGST: Decimal;
            begin
                Rec.TESTFIELD(Rec.Status, Rec.Status::Released); //MSKS
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
                rec.CheckInvoiceDiscountAmountValidation;
                CalculateStructure;

                CurrPage.update;

                Rec.CheckTradeDiscountLine;


                if rec."GST Customer Type" <> Rec."GST Customer Type"::Export then begin

                    AmtGST := GSTamtcheck.AmttoCustomer(Rec);

                    if AmtGST = 0 then
                        Error('Please Calculate GST Amount First');


                end;


                CurrPage.update;

                If not Rec."Calculate Structure" then
                    Error('Please Calculate the structure..');
            end;
        }
        addafter(CalculateInvoiceDiscount)
        {
            action("Get Price")
            {
                Caption = 'Get Price';
                Ellipsis = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SalesLines.PAGE.ShowPrices
                end;
            }
            action("Get Li&ne Discount")
            {
                Caption = 'Get Li&ne Discount';
                Ellipsis = true;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SalesLines.PAGE.ShowLineDisc
                end;
            }
            action("E&xplode BOM")
            {
                Caption = 'E&xplode BOM';
                Image = ExplodeBOM;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SalesLines.PAGE.ExplodeBOM;
                end;
            }
            action("Insert &Ext. Texts")
            {
                Caption = 'Insert &Ext. Texts';
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SalesLines.PAGE.InsertExtendedText(TRUE);
                end;
            }
            action("&Reserve")
            {
                Caption = '&Reserve';
                Ellipsis = true;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //CurrPage.SalesLines.PAGE.ShowReservation;
                end;
            }
            action("Order &Tracking")
            {
                Caption = 'Order &Tracking';
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //CurrPage.SalesLines.PAGE.ShowTracking;
                end;
            }
            action("Nonstoc&k Items")
            {
                Caption = 'Nonstoc&k Items';
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SalesLines.PAGE.ShowNonstockItems;
                end;
            }

            action("GST Detail")
            {
                Image = ServiceTax;
                RunObject = Page "Detailed GST Entry Buffer";
                RunPageLink = "Transaction Type" = FILTER(Sales),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
        movebefore("E&xplode BOM"; CopyDocument)
        modify(CopyDocument)
        {
            trigger Onafteraction()
            begin
                CopySalesDoc.SetSalesHeader(Rec);
                CopySalesDoc.RUNMODAL;
                CLEAR(CopySalesDoc);
            end;
        }
        addafter("Archive Document")
        {
            action("Get Sample Items")
            {
                Image = Sales;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Item: Record Item;
                    ItemFilters: Text;
                    ItemCatFilters: Text;
                    LineNo: Integer;
                    SL: Record "Sales Line";
                    DefQty: Decimal;
                begin
                    Rec.TESTFIELD(Rec."Sell-to Customer No.");
                    Rec.TESTFIELD(Rec."Order Date");
                    Rec.TESTFIELD(Rec."Group Code");
                    Rec.TESTFIELD(Rec."Order Booked Date");

                    SL.RESET;
                    SL.SETFILTER("Document Type", '%1', Rec."Document Type");
                    SL.SETFILTER("Document No.", '%1', Rec."No.");
                    IF SL.FINDLAST THEN
                        LineNo := SL."Line No." + 10000
                    ELSE
                        LineNo := 10000;
                    CLEAR(SampleData);
                    SampleData.RUNMODAL;
                    SampleData.GetData(ItemCatFilters, ItemFilters, DefQty);
                    IF DefQty = 0 THEN
                        DefQty := 1;
                    IF ItemFilters <> '' THEN
                        Item.SETFILTER("Sample Group", ItemFilters);
                    IF ItemCatFilters <> '' THEN
                        Item.SETFILTER("Item Category Code", ItemCatFilters);
                    Item.SETFILTER("Group Code", '%1', Rec."Group Code");
                    Item.SETFILTER(Blocked, '%1', FALSE);
                    IF Item.FINDFIRST THEN BEGIN
                        REPEAT
                            GenerateSalesLines(Item."No.", LineNo, DefQty);
                            LineNo += 10000;
                        UNTIL (Item.NEXT = 0) OR (LineNo > 2500000);
                        MESSAGE('Total No. of Item Lines will be created %1', LineNo / 10000);
                    END;
                end;
            }
        }
        addfirst("Request Approval")
        {
            action("Send Credit A&pproval Request")
            {
                Caption = 'Send Credit A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                ShortCutKey = 'F12';
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    GSTNManagement: Codeunit "GSTN Management";
                    GSTNMsg: Text;
                begin

                    SalesSetup.GET;
                    IF SalesSetup."Credit Warnings" IN [SalesSetup."Credit Warnings"::"Both Warnings",
                                                    SalesSetup."Credit Warnings"::"Credit Limit"] THEN
                        IF Rec."Document Type" IN [Rec."Document Type"::Order] THEN
                            CustCheckCreditLimit.SalesHeaderCheck(Rec);

                    IF Customer.GET(Rec."Sell-to Customer No.") THEN
                        IF Customer.Blocked = Customer.Blocked::"Order Releasing" THEN
                            ERROR('Customer is Blocked for Order Processing');

                    /*
                    CLEAR(GSTNManagement);
                    IF GSTNManagement.CheckUpdateGSTN(2,"Sell-to Customer No.",Customer."GST Registration No.",GSTNMsg) THEN
                      ERROR('GSTN Invalid -  %1',GSTNMsg);
                     */

                    IF NOT ((Rec.BD = TRUE) OR (Rec.GPS = TRUE) OR (Rec.None = TRUE) OR (Rec.Retail = TRUE) OR (Rec.CKA = TRUE)) THEN
                        ERROR('Please Mark The Sales Support');

                    IF Rec.BD = TRUE THEN
                        Rec.TESTFIELD("Business Development");

                    IF Rec.GPS = TRUE THEN
                        Rec.TESTFIELD("Govt. Project Sales");

                    IF Rec.CKA = TRUE THEN
                        Rec.TESTFIELD("CKA Code");

                    IF Rec.Retail = TRUE THEN
                        Rec.TESTFIELD("Retail Code");

                    IF Rec."Ship to Pin" = '' THEN
                        ERROR('Ship To Pin Cannot Blank');

                    IF Rec."Payment Terms Code" = '' THEN
                        ERROR('Please Enter Payment Terms in Header !!!');

                    IF Rec."Order Change Remarks" = '' THEN
                        ERROR('Item Change Remarks Cannot Blank');


                    Rec.TESTFIELD("GST Ship-to State Code");
                    Rec.TESTFIELD("Ship-to Post Code");


                    //16630 TESTFIELD(Structure); //MSKS2509
                    //IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;
                    SalesLine1.RESET;
                    SalesLine1.SETRANGE("Document Type", Rec."Document Type");
                    SalesLine1.SETRANGE("Document No.", Rec."No.");
                    SalesLine1.SETRANGE("Structure Calculated", FALSE);
                    IF SalesLine1.FINDFIRST THEN
                        ERROR('Please Press F10 Before Releasing');

                    Rec.SendForCreditApproval(Rec);
                    Rec."Approval Pending At" := Rec."Approval Pending At"::Credit;
                    Rec.MODIFY;

                end;
            }
            action("Approve Credit")
            {
                Caption = 'Approve Credit';
                Enabled = true;
                Promoted = true;
                PromotedIsBig = true;
                Visible = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    AppEntry: Record "Approval Entry";
                begin
                    SalesSetup.GET;
                    IF (UPPERCASE(USERID) <> 'ADMIN') AND (UPPERCASE(USERID) <> 'MA023') AND (UPPERCASE(USERID) <> 'FA007') AND (UPPERCASE(USERID) <> 'MA022')
                      AND (UPPERCASE(USERID) <> 'FA028') AND (UPPERCASE(USERID) <> 'FA014') AND (UPPERCASE(USERID) <> 'FA012') AND (UPPERCASE(USERID) <> 'FA017')
                      AND (UPPERCASE(USERID) <> 'FA017') AND (UPPERCASE(USERID) <> 'FA032') AND (UPPERCASE(USERID) <> 'FA015') AND (UPPERCASE(USERID) <> 'MA030')
                      AND (UPPERCASE(USERID) <> 'OBLTILES\N') AND (UPPERCASE(USERID) <> 'OBLTILES\C') THEN
                        ERROR('You are not Authorized');

                    /*IF SalesSetup."Manual Credit Approval" THEN
                      TESTFIELD(Status,Status::"Credit Approval Pending")
                    ELSE
                    TESTFIELD(Status,Status::Open);*/
                    IF CONFIRM('DO you want to approve the Credit of SO') THEN BEGIN
                        Rec.Status := Rec.Status::"Credit Approved";
                        Rec.MODIFY;
                        AppEntry.RESET;
                        AppEntry.SETRANGE(AppEntry."Table ID", 36);
                        AppEntry.SETFILTER("Document Type", '%1', AppEntry."Document Type"::"Credit Limit");
                        AppEntry.SETRANGE(AppEntry."Document No.", Rec."No.");
                        AppEntry.SETFILTER(AppEntry.Status, '%1|%2', AppEntry.Status::Open, AppEntry.Status::Created);
                        IF AppEntry.FINDFIRST THEN BEGIN
                            AppEntry.MODIFYALL(Status, AppEntry.Status::Approved);
                            AppEntry.MODIFYALL("Auto Approved", TRUE);
                            AppEntry.MODIFYALL(AppEntry."Auto Approved By", USERID);
                        END;
                        IF NOT Rec."Direct Not Approved" THEN BEGIN
                            Rec."Direct Not Approved" := TRUE;
                            Rec."Credit Approved" := TRUE;
                            CLEAR(ProcessSalesOrders);
                            ProcessSalesOrders.CreateSalesOrderLog(Rec."No.", 1, FALSE, TRUE); //Credit
                            Rec.MODIFY;
                        END;
                        /*
                        COMMITIF SalesHeader.GET("Document Type","No.") THEN BEGIN
                            SalesHeader."Direct Not Approved" := TRUE;
                            SalesHeader.MODIFY;
                          END;
                          */
                        CurrPage.UPDATE;
                    END;



                end;
            }
        }

        movebefore(CancelApprovalRequest; Release)

        addafter(CancelApprovalRequest)
        {
            action("Approve Price")
            {
                Caption = 'Approve Price';
                Enabled = true;
                Promoted = true;
                PromotedIsBig = true;
                Visible = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    AppEntry: Record "Approval Entry";
                begin
                    IF (UPPERCASE(USERID) <> 'ADMIN') AND (UPPERCASE(USERID) <> 'MA028') AND (UPPERCASE(USERID) <> 'FA007') AND (UPPERCASE(USERID) <> 'OBLTILES\C') AND (UPPERCASE(USERID) <> 'OBLTILES\N') THEN
                        ERROR('You are not Authorized');

                    IF CONFIRM('DO you want to approve the Price of SO') THEN BEGIN
                        Rec.Status := Rec.Status::Approved;
                        Rec."Price Approved" := TRUE;
                        Rec."InventoryNot Directly Approved" := TRUE;
                        CLEAR(ProcessSalesOrders);
                        ProcessSalesOrders.CreateSalesOrderLog(Rec."No.", 2, FALSE, TRUE); //Price
                        Rec.MODIFY;
                        AppEntry.RESET;
                        AppEntry.SETRANGE(AppEntry."Table ID", 36);
                        AppEntry.SETRANGE(AppEntry."Document No.", Rec."No.");
                        AppEntry.SETFILTER(AppEntry.Status, '%1|%2', AppEntry.Status::Open, AppEntry.Status::Created);
                        IF AppEntry.FINDFIRST THEN BEGIN
                            AppEntry.MODIFYALL(Status, AppEntry.Status::Approved);
                            AppEntry.MODIFYALL("Auto Approved", TRUE);
                            AppEntry.MODIFYALL(AppEntry."Auto Approved By", USERID);
                        END;
                        CurrPage.UPDATE;
                    END;
                end;
            }
            action("Resend Mail")
            {
                Caption = 'Resend Mail';
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    AppEntry.RESET;
                    AppEntry.SETRANGE("Document No.", Rec."No.");
                    AppEntry.SETRANGE(Status, AppEntry.Status::Created);
                    IF AppEntry.FINDFIRST THEN BEGIN
                        CLEAR(MailMgt);
                        MailMgt.CreateMailForPO(Rec, AppEntry."Approver Code");
                    END;
                end;
            }
            action("Vehicle Notification Mail")
            {
                Image = Mail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    cdeVehicleNotification: Codeunit "Vehicle Notification";
                begin
                    IF (Rec."Truck No." = '') AND (Rec."Location Code" = 'DP-MORBI') AND (Rec."No. of Vehicle Notification" = 0) AND (Rec."Payment Date 3" <> 0D) THEN
                        cdeVehicleNotification.SendVehicleNotification(Rec);
                end;
            }
            action("Calc&ulate Structure Values")
            {
                Caption = 'Calc&ulate Structure Values';
                Image = CalculateHierarchy;
                Promoted = true;
                PromotedIsBig = true;
                ShortCutKey = 'F10';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TempVATAmountLine0: Record "VAT Amount Line" temporary;
                    TempVATAmountLine1: Record "VAT Amount Line" temporary;
                    SalesLine2: Record "Sales Line";
                    EAmt: Decimal;
                    LineAmt: Decimal;
                    LineDisc: Decimal;
                    InvDisc: Decimal;
                    CustInvDisc: Record "Cust. Invoice Disc.";
                begin
                    //16630  VALIDATE(Structure, Structure); //TEAM::1426
                    //VALIDATE("Trade Discount",0);
                    COMMIT;
                    //16630 CALCFIELDS("Price Inclusive of Taxes");
                    //16630 CALCFIELDS("Price Inclusive of Taxes", "CD Available for Utilisation", Amount, "Amount to Customer", "Line Amount"); //MSKS
                    //16630 IF (NOT SalesHeader."Free Supply") THEN
                    IF Rec."CD Available for Utilisation" <> 0 THEN BEGIN
                        //MESSAGE('%1-%2-%3',"Line Amount" *0.5, "CD Available for Utilisation",SalesHeader."Free Supply");
                        //  IF ("Amount to Customer" *0.5) > ("CD Available for Utilisation") THEN BEGIN
                        IF (Rec."Line Amount" * 0.5) > (Rec."CD Available for Utilisation") THEN BEGIN
                            IF (ROUND(Rec."CD Available for Utilisation", 1, '<') > 0) THEN BEGIN
                                //16630 IF Structure <> 'SAMPLEGST' THEN //MS-A
                                Rec.VALIDATE("Trade Discount", ROUND(Rec."CD Available for Utilisation", 1, '<'))
                            END ELSE
                                rec.VALIDATE("Trade Discount", 0);
                        END ELSE BEGIN
                            //16630 IF Structure <> 'SAMPLEGST' THEN //MS-A
                            Rec.VALIDATE("Trade Discount", ROUND(Rec."Line Amount" * 0.5, 1, '<'));
                            //      VALIDATE("Trade Discount",ROUND("Amount to Customer" *0.5,1,'<'));
                        END;
                    END;
                    /* IF "Price Inclusive of Taxes" THEN BEGIN
                         SalesLine.InitStrOrdDetail(Rec);
                         SalesLine.GetSalesPriceExclusiveTaxes(Rec);
                         SalesLine.UpdateSalesLinesPIT(Rec);
                     END;*/
                    //16630 Start
                    /*  SalesLine.CalculateStructures(Rec);
                      SalesLine.AdjustStructureAmounts(Rec);
                      SalesLine.CalculateTCS(Rec);
                      SalesLine.UpdateSalesLines(Rec);
                      SalesLine.UpdateInvoiceType(Rec);
                      SalesLine.CalculateTCS(Rec);*///16630 End
                                                    //Upgrade(+)
                                                    //ND Start
                    COMMIT;
                    /*Kulbhushan Sharma 22122020
                    EAmt := 0;
                    LineAmt := 0;
                    LineDisc := 0;
                    InvDisc := 0;
                    SalesLine2.RESET;
                    SalesLine2.SETFILTER(SalesLine2."Document Type",'%1',"Document Type");
                    SalesLine2.SETFILTER(SalesLine2."Document No.","No.");
                    IF SalesLine2.FIND('-') THEN REPEAT
                      EAmt := EAmt + SalesLine2."Excise Amount";
                      LineAmt := LineAmt + SalesLine2."Line Amount";
                      LineDisc := LineDisc + SalesLine2. ;
                    UNTIL SalesLine2.NEXT = 0;
                    IF CustInvDisc.GET("Invoice Disc. Code") THEN
                      InvDisc := ((LineAmt + EAmt - LineDisc) * CustInvDisc."Discount %") / (LineAmt - LineDisc) ;
                    "Invoice Discount Value"  := InvDisc;
                    MODIFY;*/
                    //ND End

                    //sash
                    /*
                    IF "Document Type" = "Document Type"::Order THEN
                    CalculateQcDiscount1;
                    COMMIT;
                    */
                    //sash

                    //MS-PB Begin 161112
                    ///   SalesTaxCalculate.UpdateStructureCalculated(Rec);
                    //MS-PB END
                    //Upgrade(-)

                end;
            }
            action("Merge Sales Order")
            {
                Caption = 'Merge Sales Order';
                Enabled = true;
                Promoted = true;
                PromotedIsBig = true;
                Visible = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CODEUNIT.RUN(CODEUNIT::"Sales-Get SO To Merge", Rec);
                    SL.RESET;
                    SL.SETRANGE("Document Type", Rec."Document Type");
                    SL.SETRANGE("Document No.", Rec."No.");
                    IF SL.FINDFIRST THEN BEGIN
                        REPEAT
                            IF SL.Reserve = SL.Reserve::Always THEN
                                SL.AutoReserve;
                            SL.MODIFY;
                        UNTIL SL.NEXT = 0;
                    END;
                end;
            }
            action("Calculate TCS")
            {
                Caption = 'Calculate TCS';
                Image = CalculateCollectedTax;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //16630 Satrt
                    /* SalesLine.CalculateStructures(Rec);
                     SalesLine.AdjustStructureAmounts(Rec);
                     SalesLine.CalculateTCS(Rec);
                     SalesLine.UpdateSalesLines(Rec);
                     SalesLine.CalculateTCS(Rec);*///16630 End
                end;
            }
            action("Short Close")
            {
                Caption = 'Short Close';
                Promoted = false;
                ApplicationArea = All;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF Rec."Posting No." <> '' THEN
                        ERROR('Posting No. Series Should Be Blank');

                    ShortClose.SaleCancel(Rec, 1);
                end;
            }
            action("&View Credit Allocation Info")
            {
                Caption = '&View Credit Allocation Info';
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                ShortCutKey = 'Ctrl+I';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //TRI
                    CustCheckCreditLimit.SalesHeaderCheck(Rec);
                    //TRI
                end;
            }
            action("Lock/Unlock")
            {
                Caption = 'Lock/Unlock';
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Codeunit "Lock Sales Document";
                ShortCutKey = 'Ctrl+U';
                ApplicationArea = All;
            }
            action("Send Vendor Notification Mail")
            {
                Image = Mail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    cdeVehicleNotification: Codeunit "Vehicle Notification";
                begin
                    CLEAR(cdeVehicleNotification);
                    IF (Rec."Location Code" = 'DP-MORBI') THEN
                        cdeVehicleNotification.SendVendorNotification(Rec);
                end;
            }
            action("Str&ucture Details")
            {
                Caption = 'Str&ucture Details';
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //16630 CurrPage.SalesLines.PAGE.ShowStrDetailsForm;
                end;
            }
            action(Structure)
            {
                Caption = 'Structure';
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //16630  CurrPage.SalesLines.PAGE.ShowStrOrderDetailsPITForm;
                end;
            }
            // action("Order Confirmation")
            //  {
            /* Caption = 'Order Confirmation';
            Ellipsis = true;
            Image = Print;
            Promoted = true;
            PromotedIsBig = true;
            ShortCutKey = 'Shift+F6';
            ApplicationArea = All;

*/         //       trigger OnAction()
           //  var
           //    Customer: Record Customer;
           //begin
           /*         IF Customer.GET(Rec."Sell-to Customer No.") THEN BEGIN
                       IF Customer."Stop Mail Comunication PCH SP" THEN
                           ERROR('All Communications is stopped for this Customer ,Please contact, IT');
                   END;
                   IF UserSetup.GET(USERID) THEN BEGIN
                       IF UserSetup."Allow Order Conf" = FALSE THEN
                           ERROR('%1 has no permission to Print the Order Confirmation', UserSetup."User ID");
                   END;
*/
           //16630 start
           /*  SalesLine.CalculateStructures(Rec);
             SalesLine.AdjustStructureAmounts(Rec);
             SalesLine.CalculateTCS(Rec);
             SalesLine.UpdateSalesLines(Rec);
             SalesLine.CalculateTCS(Rec);*///16630 End
                                           //COMMIT;

            //Rec.SetRecFilter();
            //  Report.Run(50713, true, true, Rec);
            //end;
            // }
            action("Customer Card")
            {
                ShortCutKey = 'Shift+F5';
                ApplicationArea = All;

                trigger OnAction()
                var
                    CustCard: Page "Customer Card";
                    Cust: Record Customer;
                begin
                    Cust.GET(Rec."Sell-to Customer No.");
                    PAGE.RUNMODAL(PAGE::"Customer Card", Cust);
                end;
            }
            action("Performa Invoice")
            {
                Caption = 'Performa Invoice';
                ApplicationArea = All;

                trigger OnAction()
                var
                    UserName: Text;
                begin

                    IF UserSetup.GET(UPPERCASE(USERID)) THEN BEGIN
                        IF UserSetup."Allow Order Conf" = FALSE THEN
                            ERROR('%1 has no permission to Print the Order Confirmation', UserSetup."User ID");
                    END;

                    SalesHeader.RESET;
                    SalesHeader.SETRANGE("No.", Rec."No.");
                    SalesHeader.SETFILTER("Document Type", '%1', SalesHeader."Document Type"::Order);
                    REPORT.RUNMODAL(Report::"Performa Invoice", TRUE, FALSE, SalesHeader);
                end;
            }
            action("Order Contibution")
            {
                Caption = 'Order Contibution';
                ShortCutKey = 'Shift+F7';
                ApplicationArea = All;

                trigger OnAction()
                begin

                    SalesHeader.RESET;
                    SalesHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(Report::"Order Contribution", TRUE, FALSE, SalesHeader);
                end;
            }
            action("Refresh Quantity in Hand")
            {
                Caption = 'Refresh Quantity in Hand';
                ShortCutKey = 'Ctrl+Q';
                Visible = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CLEAR(ShipSqt);
                    CLEAR(QtyGrwt);
                    CLEAR(QtySqt);
                    CLEAR(ShipGrwt);
                    TgSalesLine.RESET;
                    TgSalesLine.SETRANGE("Document Type", Rec."Document Type"::Order);
                    TgSalesLine.SETRANGE("Document No.", Rec."No.");
                    IF TgSalesLine.FIND('-') THEN
                        REPEAT
                            TgSalesLine.CALCFIELDS("Remaining Inventory", "Total Reserved Quantity", "Quantity in Blanket Order");
                            TgSalesLine."Quantity in Hand SQM" := (TgSalesLine."Remaining Inventory");// - (
                                                                                                      //TgSalesLine."Total Reserved Quantity"));
                            TgSalesLine."Quantity in Hand CRT" := (TgSalesLine."Remaining Inventory" / TgSalesLine."Qty. per Unit of Measure");// - (
                                                                                                                                               //TgSalesLine."Total Reserved Quantity"/TgSalesLine."Qty. per Unit of Measure");

                            ShipGrwt += TgSalesLine."Gross Weight (Ship)";
                            ShipSqt += TgSalesLine."Quantity in Sq. Mt.(Ship)";
                            QtyGrwt += TgSalesLine."Gross Weight";
                            QtySqt += TgSalesLine."Quantity in Sq. Mt.";
                            TgSalesLine.MODIFY;
                        UNTIL TgSalesLine.NEXT = 0;
                end;
            }
        }
        movebefore("Short Close"; "Co&mments")
        movebefore(CancelApprovalRequest; Comment)
        addafter(CancelApprovalRequest)
        {

            action(Cancel)
            {
                Visible = false;
                Caption = 'Cancel';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF Rec."Posting No." <> '' THEN
                        ERROR('Posting No. Series Should Be Blank');

                    ShortClose.SaleCancel(Rec, 2);
                end;
            }
            action("Updated Customer Group")
            {
                Caption = 'Updated Customer Group';
                Enabled = false;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    RecSalesLine.RESET;
                    RecSalesLine.SETRANGE(RecSalesLine."Document Type", Rec."Document Type"::Order);
                    RecSalesLine.SETRANGE(RecSalesLine."Document No.", Rec."No.");
                    IF RecSalesLine.FINDFIRST THEN BEGIN
                        REPEAT
                            RecSalesLine.VALIDATE(RecSalesLine."Customer Price Group");
                        UNTIL RecSalesLine.NEXT = 0;
                    END;
                end;
            }
            action("Update Shipment Qty")
            {
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you want to Update Shipment Qty.', TRUE) THEN
                        Rec.UpdateShiptoQty;
                end;
            }
        }
        addfirst("&Print")
        {
            action("Performa Invoice Export")
            {
                Caption = 'Performa Invoice Export';
                ShortCutKey = 'Ctrl+F8';
                ApplicationArea = All;

                trigger OnAction()
                var
                    UserName: Text;
                begin
                    IF UserSetup.GET(UPPERCASE(USERID)) THEN
                        IF UserSetup."Allow Order Conf" = FALSE THEN
                            //IF (UPPERCASE(USERID) <> 'ADMINISTRATOR') AND (UPPERCASE(USERID) <> 'ADMIN')THEN
                            ERROR('%1 Not Allowed To Print the Sales Order', UPPERCASE(USERID)) ELSE BEGIN
                            SalesHeader.RESET;
                            SalesHeader.SETRANGE("No.", Rec."No.");
                            SalesHeader.SETFILTER("Document Type", '%1', SalesHeader."Document Type"::Order);
                            REPORT.RUNMODAL(Report::"Performa Invoice Export", TRUE, FALSE, SalesHeader);
                        END;
                end;
            }
            action("Email Confirmation")
            {
                Caption = 'Email Confirmation';
                Ellipsis = true;
                Image = Email;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+e';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    DocPrint.EmailSalesHeader(Rec);
                end;
            }
        }
        movebefore("Work Order"; "Print Confirmation")
        movebefore("Email Confirmation"; PostPrepaymentCreditMemo)
        addafter("Work Order")
        {
            action("Loading Slip")
            {
                Caption = 'Loading Slip';
                Enabled = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    SalesHeader.RESET;
                    SalesHeader.SETFILTER("Document Type", '%1', Rec."Document Type");
                    SalesHeader.SETFILTER("No.", Rec."No.");
                    LoadingSlip.SETTABLEVIEW(SalesHeader);
                    LoadingSlip.RUN;
                end;
            }
            action("Disposable Bill")
            {
                Caption = 'Disposable Bill';
                ApplicationArea = All;

                trigger OnAction()
                var
                    Scrapreport: Report "SO Line Combined Report";
                    SIHdr: Record "Sales Header";
                begin
                    CLEAR(Scrapreport);
                    SIHdr.RESET;
                    SIHdr.SETRANGE(SIHdr."No.", Rec."No.");
                    Scrapreport.SETTABLEVIEW(SIHdr);
                    Scrapreport.RUN;
                end;
            }
        }
        addafter("Pick Instruction")
        {
            group(Alphabet)
            {
                group(Reports)
                {
                    Visible = false;
                    action("Voucher Register")
                    {
                        Caption = 'Voucher Register';
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Voucher Register";
                        Visible = false;
                        ApplicationArea = All;
                    }
                    action("Day Book")
                    {
                        Caption = 'Day Book';
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Day Book";
                        Visible = false;
                        ApplicationArea = All;
                    }
                    action(Action1000000059)
                    {
                        Caption = 'Co&mments';
                        Ellipsis = true;
                        Image = ViewComments;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //CurrPage.SalesLines.PAGE.ShowLineComments;
                        end;
                    }
                    action("Open Entries")
                    {
                        ShortCutKey = 'Ctrl+F5';
                        Visible = true;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            CustLedEn: Record "Cust. Ledger Entry";
                        begin
                            CustLedEn.RESET;
                            CustLedEn.SETRANGE("Customer No.", Rec."Sell-to Customer No.");
                            CustLedEn.SETRANGE(Open, TRUE);
                            PAGE.RUNMODAL(PAGE::"Customer Ledger Entries", CustLedEn);
                        end;
                    }
                    action("Customer - Ageing Due Date")
                    {
                        Caption = 'Customer - Ageing Due Date';
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Customer - Ageing Due Date";
                        Visible = false;
                        ApplicationArea = All;
                    }
                    action("Bank Reconcilation")
                    {
                        Caption = 'Bank Reconcilation';
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Bank Reconcilation";
                        Visible = false;
                        ApplicationArea = All;
                    }
                    action(vo)
                    {
                        Caption = 'vo';
                        ApplicationArea = All;

                    }

                }
            }
        }
    }

    var
        "...tri1.0": Integer;
        SalesLine1: Record "Sales Line";
        DateFilter: Text[30];
        Item: Record Item;
        AvailableQuantity: Decimal;
        //16630 Cust1: Record 18;
        CustomerBalance: Decimal;
        SalesHeader100: Record "Sales Header";
        ReleasedOrderAmount: Decimal;
        CrLmt: Decimal;
        GrossTotalAmt: Decimal;
        SL: Record "Sales Line";
        DocPrint: Codeunit "Document-Print";
        CopySalesDoc: Report "Copy Sales Document";

    var
        Customer: Record Customer;
        GSTNManagement: Codeunit "GSTN Management";
        GSTNMsg: Text;
        "--TRI DP": Integer;
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        "-NAVIN-": Integer;
        MLTransactionType: Option Purchase,Sale;
        UserSetup: Record "User Setup";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        SampleOrder: Record "Sample Order";
        SalesHeader: Record "Sales Header";
        LoadingSlip: Report "Loading Slip";
        SalesLine2: Record "Sales Line";
        Bin: Record "Default Dimension Priority";
        BinContent: Record "Bin Content";
        //16630 StrOrdLineDetail: Record "13795";
        compinfo: Record "Company Information";
        ShortClose: Codeunit ShortClose;
        UserLocation: Record "User Location";
        LocationFilterString: Text[1024];
        "-MIJS--": Integer;
        //16630 Customer: Record 18;
        //16630  StrDetails: Record "13793";
        RecNoSeries: Record "No. Series";
        SalesSetup: Record "Sales & Receivables Setup";
        RecSalesLine: Record "Sales Line";
        ExciseStr: Boolean;
        RecLocation: Record Location;
        //16630  StructureHeader: Record "13792";
        DocumentPrint: Codeunit "Document-Print";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        Cust1: Record Customer;
        ReturnOrderNoVisible: Boolean;
        "Phone No.": Text[20];
        LineAmt: Decimal;
        EAmt: Decimal;
        LineDisc: Decimal;
        cQtyDisc: Decimal;
        cAccQtyDisc: Decimal;
        RemAmtFlag: Integer;
        cAmountBeforeTax: Decimal;
        RecInvInsDisc: Record "Additional discount Insurance";
        RecInsRef: Record "Freight Master IBOT";
        TotRemainingAmt: Decimal;
        MaxAmtToGive: Decimal;
        InvDiscRecID: array[10] of Integer;
        InsDiscRecID: array[10] of Integer;
        J: Integer;
        K: Integer;
        DiscountPercent: Decimal;
        //16630  StrOrderDetails: Record "13794";
        //16630  StrOrderLines: Record "13795";
        GLSetup: Record "General Ledger Setup";
        Selection: Integer;
        Reason1: Boolean;
        Reason2: Boolean;
        Reason3: Boolean;
        ReasonText: Text[200];
        Window: Dialog;
        TgSalesHeader: Record "Sales Header";
        TgSalesLine: Record "Sales Line";
        ShipGrwt: Decimal;
        ShipSqt: Decimal;
        QtyGrwt: Decimal;
        QtySqt: Decimal;
        SalesLine: Record "Sales Line";

    var
        [InDataSet]
        SalesHistoryBtnVisible: Boolean;
        [InDataSet]
        BillToCommentPictVisible: Boolean;
        [InDataSet]
        BillToCommentBtnVisible: Boolean;
        [InDataSet]
        SalesHistoryStnVisible: Boolean;
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
        //"Ship-to AddressEditable": Boolean;
        [InDataSet]
        //"Ship-to Address 2Editable": Boolean;
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
        "PO No.Editable": Boolean;
        [InDataSet]
        StatusEditable: Boolean;
        [InDataSet]
        "Order DateEditable": Boolean;
        [InDataSet]
        "External Document No.Editable": Boolean;
        [InDataSet]
        "CR Exception TypeEditable": Boolean;
        [InDataSet]
        "CR Approved ByEditable": Boolean;
        [InDataSet]
        "No.Editable": Boolean;
        [InDataSet]
        "Shipping Agent CodeEditable": Boolean;
        [InDataSet]
        "Sell-to Customer No.Editable": Boolean;
        [InDataSet]
        "Location CodeEditable": Boolean;
        [InDataSet]
        "Posting No. SeriesEditable": Boolean;
        [InDataSet]
        "Due DateEditable": Boolean;
        [InDataSet]
        "Form CodeEditable": Boolean;
        [InDataSet]
        "Payment Terms CodeEditable": Boolean;
        [InDataSet]
        "Sales TypeEditable": Boolean;
        [InDataSet]
        RequestedDeliveryDateEditable: Boolean;
        [InDataSet]
        "Promised Delivery DateEditable": Boolean;
        [InDataSet]
        RemarksEditable: Boolean;
        [InDataSet]
        "ORC TermsEditable": Boolean;
        [InDataSet]
        "Dealer CodeEditable": Boolean;
        [InDataSet]
        ShortcutDimension1CodeEditable: Boolean;
        [InDataSet]
        "Transport MethodEditable": Boolean;
        [InDataSet]
        COCOEditable: Boolean;
        [InDataSet]
        "COCO StoreEditable": Boolean;
        [InDataSet]
        DiscountAllowed: Boolean;
        MailMgt: Codeunit "QD Test, PDF Creation & Email";
        AppEntry: Record "Approval Entry";
        vend: Record Vendor;
        gstregistration: Code[15];
        reas: Record "Reason Code";
        "Business DevelopmentEditable": Boolean;
        state1: Record State;
        gststatedesc: Text[22];
        Text000: Label 'Unable to execute this function while in view only mode.';
        //"--NAVIN--": ;
        Text00001: Label 'Do you want to convert the Order to an Export order?';
        Text00002: Label 'Order number %1 has been converted to Export order number %2.';
        Text13000: Label 'No Setup exists for this Amount.';
        Text13001: Label 'Do you want to send the order for Authorization?';
        Text13002: Label 'The Order Is Authorized, You Cannot Resend For Authorization';
        Text13003: Label 'You Cannot Resend For Authorization';
        Text13004: Label 'This Order Has been Rejected. Please Create A New Order.';
        // "...tri1.0": ;
        Text0001: Label 'Sufficient Inventory is not available in line no. %1. ';
        Text0002: Label 'Do you want to create Sample Order for Customer %1.';
        Text0003: Label 'Status must be Released while posting.';
        Text0004: Label 'Unit Price of %1 %2 must not be zero while release.';
        Text0005: Label 'MRP of %1 %2 must not be zero while release.';
        Text0006: Label 'Quantity and Reserved Quantity must be equal';
        Text009: Label 'You must fill the same Customer %1 ,%2 in Bill to Customer ';
        Text0010: Label 'Customer You have Selected id Inter - Company, Please Select another One';
        Text50000: Label 'Sorry!!!!!! You can''t select the Excisable Structure. Please Contact System administrator.';
        Text50001: Label 'Please fill Location Code.';
        Err001: Label 'Invoice Value Cannot be in Nagetive';
        Text19076009: Label 'Tax Registration No.';
        tptmth: Text[20];
        ShipAgent: Record "Shipping Agent";
        DispDesc: Text[30];
        reas1: Record "Reason Code";
        transsoheader: Record "Transfer SO Sales Header";
        yourref: Text[100];
        SampleData: Page "Sample Creation Order";
        CreateSO: Codeunit "TMS Release Order Update";
        CFLimit: Decimal;
        chanel: Record Customer;
        ProcessSalesOrders: Codeunit "Process Sales Orders";

    trigger OnAfterGetRecord()
    begin
        IF state1.GET(Rec."GST Ship-to State Code") THEN
            gststatedesc := state1.Description;

        IF Rec."Old Order for Post" = TRUE THEN BEGIN
            IF UPPERCASE(USERID) <> 'admin' THEN
                CurrPage.EDITABLE(FALSE)
            ELSE
                CurrPage.EDITABLE(TRUE);
        END ELSE
            CurrPage.EDITABLE(TRUE);

        //TRI
        UpdateEditableFields;


        //Upgrade(-)
        IF chanel.GET(Rec."Sell-to Customer No.") THEN
            CFLimit := chanel."CF Limit";
    end;

    trigger OnOpenPage()
    begin
        //Upgrade(+)//Oninit Code//
        "COCO StoreEditable" := TRUE;
        COCOEditable := TRUE;
        "Transport MethodEditable" := TRUE;
        ShortcutDimension1CodeEditable := TRUE;
        "Dealer CodeEditable" := TRUE;
        "ORC TermsEditable" := TRUE;
        RemarksEditable := TRUE;
        //"Promised Delivery DateEditable" := TRUE;
        RequestedDeliveryDateEditable := TRUE;
        "Sales TypeEditable" := TRUE;
        "Payment Terms CodeEditable" := TRUE;
        "Form CodeEditable" := TRUE;
        "Due DateEditable" := TRUE;
        "Location CodeEditable" := TRUE;
        "Sell-to Customer No.Editable" := TRUE;
        //"Shipping Agent CodeEditable" := TRUE;
        "No.Editable" := TRUE;
        "CR Approved ByEditable" := TRUE;
        "CR Exception TypeEditable" := TRUE;
        "External Document No.Editable" := TRUE;
        "Order DateEditable" := TRUE;
        "PO No.Editable" := TRUE;
        "Free SupplyEditable" := TRUE;
        "Ship-to Post CodeEditable" := TRUE;
        "Ship-to Name 2Editable" := TRUE;
        "Ship-to ContactEditable" := TRUE;
        // "Ship-to Address 2Editable" := TRUE;
        //"Ship-to AddressEditable" := TRUE;
        "Ship-to NameEditable" := TRUE;
        "Ship-to CodeEditable" := TRUE;
        "Group CodeEditable" := TRUE;
        "Discount Charges %Editable" := TRUE;
        PayEditable := TRUE;
        ReturnOrderNoVisible := TRUE;
        //Upgrade(-)
        //OnOpen code

        //upgrade(+)
        //SETRANGE("Date Filter",0D,WORKDATE - 1); //Standard blocked
        //TRI S.R
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."View Sales Order", '%1', TRUE);
        IF UserLocation.FIND('-') THEN
            REPEAT
                IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                    LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
            UNTIL UserLocation.NEXT = 0;


        LocationFilterString := COPYSTR(LocationFilterString, 2, 1024);

        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');

        //MESSAGE(LocationFilterString);

        Rec.FILTERGROUP(2);
        Rec.SETFILTER(Rec."Location Code", LocationFilterString);
        Rec.FILTERGROUP(0);

        //TRI S.R

        UpdateEditableFields;
        //Upgrade(-)

    end;



    //16630 Funcation N/F 
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
      DiscountAllowed := CDAllowed;
    CurrPage.UPDATE;
    */
    //end;

    procedure UpdateEditableFields()
    begin
        IF Rec.Status = Rec.Status::Released THEN BEGIN
            PayEditable := TRUE;
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
            //"Ship-to AddressEditable" := TRUE;
            //"Ship-to Address 2Editable" := TRUE;
            "Ship-to CityEditable" := TRUE;
            "Ship-to ContactEditable" := TRUE;
            "Ship-to Name 2Editable" := FALSE;
            "Ship-to Post CodeEditable" := TRUE;
            //  CurrForm."Transport Method".EDITABLE(TRUE);
            "Free SupplyEditable" := FALSE;
            "PO No.Editable" := FALSE;
            StatusEditable := FALSE;
            //  CurrForm."TPT Method".EDITABLE(FALSE);
            "Order DateEditable" := FALSE;
            "External Document No.Editable" := FALSE;
            "CR Exception TypeEditable" := FALSE;
            "CR Approved ByEditable" := FALSE;

            "No.Editable" := FALSE;
            "Shipping Agent CodeEditable" := FALSE;
            "Sell-to Customer No.Editable" := FALSE;
            "Location CodeEditable" := FALSE;
            "Shipping No.Editable" := FALSE;
            "Posting No. SeriesEditable" := FALSE;
            "Due DateEditable" := FALSE;
            "Form CodeEditable" := FALSE;
            "Payment Terms CodeEditable" := TRUE;
            "Sales TypeEditable" := FALSE;

            RequestedDeliveryDateEditable := FALSE;
            "Promised Delivery DateEditable" := FALSE;
            RemarksEditable := FALSE;
            "ORC TermsEditable" := FALSE;
            "Dealer CodeEditable" := FALSE;
            "Dealer CodeEditable" := FALSE;
            //CurrForm."Dealer's Salesperson Code".EDITABLE(FALSE);
            "Payment Terms CodeEditable" := TRUE;
            ShortcutDimension1CodeEditable := FALSE;
            "Transport MethodEditable" := FALSE;
            "Form CodeEditable" := TRUE;
            COCOEditable := FALSE;
            "COCO StoreEditable" := FALSE;
            "Free SupplyEditable" := FALSE;
        END ELSE BEGIN
            PayEditable := TRUE;
            //CurrForm."Customer Type".EDITABLE(TRUE);
            //CurrForm."Customer Price Group".EDITABLE(TRUE);
            "Tax Registration No.Editable" := TRUE;
            StructureEditable := TRUE;
            "Discount Charges %Editable" := TRUE;
            "Group CodeEditable" := TRUE;
            "Salesperson CodeEditable" := TRUE;
            "Shipping No.Editable" := TRUE;
            "Ship-to CodeEditable" := TRUE;
            "Ship-to NameEditable" := TRUE;
            //"Ship-to AddressEditable" := TRUE;
            //"Ship-to Address 2Editable" := TRUE;
            "Ship-to CityEditable" := TRUE;
            "Ship-to ContactEditable" := TRUE;
            "Ship-to Name 2Editable" := TRUE;
            "Ship-to Post CodeEditable" := TRUE;
            "Free SupplyEditable" := TRUE;
            "PO No.Editable" := TRUE;
            StatusEditable := FALSE;
            //  CurrForm."TPT Method".EDITABLE(TRUE);
            "Order DateEditable" := TRUE;
            "External Document No.Editable" := TRUE;
            "CR Exception TypeEditable" := TRUE;
            "CR Approved ByEditable" := TRUE;
            "No.Editable" := TRUE;
            "Shipping Agent CodeEditable" := TRUE;
            "Sell-to Customer No.Editable" := TRUE;
            "Location CodeEditable" := TRUE;
            "Form CodeEditable" := TRUE;
            "Payment Terms CodeEditable" := TRUE;
            "Sales TypeEditable" := TRUE;

            RequestedDeliveryDateEditable := TRUE;
            //"Promised Delivery DateEditable" := TRUE;
            RemarksEditable := TRUE;
            "ORC TermsEditable" := TRUE;
            "Dealer CodeEditable" := TRUE;
            "Dealer CodeEditable" := TRUE;
            //CurrForm."Dealer's Salesperson Code".EDITABLE(TRUE);
            "Payment Terms CodeEditable" := TRUE;
            ShortcutDimension1CodeEditable := TRUE;
            "Transport MethodEditable" := TRUE;
            "Form CodeEditable" := TRUE;
            COCOEditable := TRUE;
            "COCO StoreEditable" := TRUE;
            "Free SupplyEditable" := TRUE;


        END;
    end;

    procedure CalculateQcDiscount1()
    begin
        RemAmtFlag := 0;
        DiscountPercent := 0;
        TotRemainingAmt := 0;
        MaxAmtToGive := 0;
        cAmountBeforeTax := 0;

        J := 1;

        IF Rec."Document Type" <> Rec."Document Type"::Order THEN
            EXIT;

        RecInvInsDisc.RESET;
        RecInvInsDisc.SETCURRENTKEY(CustId, cAmount, cDate);
        RecInvInsDisc.SETRANGE(RecInvInsDisc.CustId, Rec."Sell-to Customer No.");
        RecInvInsDisc.SETRANGE(RecInvInsDisc.cFlag, '%1', 'SAVED');

        RecInvInsDisc.SETRANGE(RecInvInsDisc.AmountToGive, TRUE);
        IF NOT RecInvInsDisc.FIND('-') THEN
            RemAmtFlag := 0
        ELSE BEGIN
            RecInvInsDisc.FINDFIRST;
            REPEAT
                TotRemainingAmt += RecInvInsDisc."Remaining Amount";
            UNTIL RecInvInsDisc.NEXT = 0;
            IF TotRemainingAmt > 50 THEN
                RemAmtFlag := 1;
            // MESSAGE('%1',TotRemainingAmt);
        END;

        IF RemAmtFlag = 0 THEN BEGIN
            IF Rec."Add Insu Discount" <> 0 THEN BEGIN
                Rec."Add Insu Discount" := 0;
                Rec.MODIFY;
            END;
        END;


        IF RemAmtFlag = 1 THEN BEGIN // S01 start

            EAmt := 0;
            LineAmt := 0;
            LineDisc := 0;
            //InvDisc := 0;
            cQtyDisc := 0; //sash
            cAccQtyDisc := 0;

            SalesLine2.RESET;
            SalesLine2.SETFILTER(SalesLine2."Document Type", '%1', Rec."Document Type");
            SalesLine2.SETFILTER(SalesLine2."Document No.", Rec."No.");
            IF SalesLine2.FIND('-') THEN
                REPEAT
                    IF (SalesLine2.Quantity <> 0) THEN BEGIN
                        IF (SalesLine2."Qty. to Ship" <> 0) THEN BEGIN
                            //16630 EAmt := EAmt + ((SalesLine2."Excise Amount" / SalesLine2.Quantity) * SalesLine2."Qty. to Ship");
                            LineAmt := LineAmt + (SalesLine2."Unit Price" * SalesLine2."Qty. to Ship");
                            LineDisc := LineDisc + ((SalesLine2."Line Discount Amount" / SalesLine2.Quantity) * SalesLine2."Qty. to Ship");
                            cQtyDisc := cQtyDisc + ((SalesLine2."Quantity Discount Amount" / SalesLine2.Quantity) * SalesLine2."Qty. to Ship");
                            //cAccQtyDisc:= cAccQtyDisc + ((SalesLine2."Accrued Discount"/ SalesLine2.Quantity)* SalesLine2."Qty. to Ship");
                        END;
                    END;
                UNTIL SalesLine2.NEXT = 0;

            //MESSAGE('%1',(LineAmt+EAmt-LineDisc-cQtyDisc));

            //MESSAGE('%1',cQtyDisc);
            ////MESSAGE('%1',cAccQtyDisc);

            cAmountBeforeTax := LineAmt + EAmt - LineDisc - cQtyDisc;
            IF cAmountBeforeTax > 1 THEN
                MaxAmtToGive := ROUND(cAmountBeforeTax / 2, 0.00001, '<');
            //MESSAGE('%1',MaxAmtToGive);
        END;  //S 01 Ends;

        IF RemAmtFlag = 1 THEN BEGIN

            IF TotRemainingAmt >= MaxAmtToGive THEN BEGIN
                DiscountPercent := -50;
            END;

            IF TotRemainingAmt < MaxAmtToGive THEN BEGIN
                IF MaxAmtToGive > 0 THEN
                    DiscountPercent := -ROUND(((50 * TotRemainingAmt) / MaxAmtToGive), 0.00001, '<');
                ////IF DiscountPercent< -2 THEN
                //DiscountPercent:= DiscountPercent + 1.5 ; // to adjust remaining amt
                ////IF (-2< DiscountPercent) AND (DiscountPercent< -0.75) THEN
                //// DiscountPercent:= DiscountPercent + 0.5 ; // to adjust remaining amt
                ////  IF  DiscountPercent> -0.75 THEN
                ////  DiscountPercent:=0;

            END;
            Rec."Add Insu Discount" := DiscountPercent;
            Rec.MODIFY;

        END;

        IF RemAmtFlag <> 1 THEN BEGIN
            DiscountPercent := 0;
            IF Rec."Add Insu Discount" <> 0 THEN BEGIN
                Rec."Add Insu Discount" := DiscountPercent;
                Rec.MODIFY;
            END;
        END;

        //16630 Table N/F start
        /*  StrOrderDetails.RESET;
          StrOrderDetails.SETCURRENTKEY("Document Type", "Document No.", Type);
          StrOrderDetails.SETRANGE(Type, StrOrderDetails.Type::Sale);
          StrOrderDetails.SETRANGE("Document Type", "Document Type");
          StrOrderDetails.SETRANGE("Document No.", "No.");
          StrOrderDetails.SETRANGE("Price Inclusive of Tax", FALSE);
          //StrOrderDetails.SETFILTER("Tax/Charge Code",'%1','ADDINSDISC');
          //StrOrderDetails.SETRANGE("Tax/Charge Group",'%1','ADDINSDISC');

          IF StrOrderDetails.FIND('-') THEN BEGIN
              StrOrderDetails.FINDFIRST;
              GLSetup.GET;
              REPEAT
                  IF StrOrderDetails."Tax/Charge Group" = GLSetup.AddInsuranceDisc THEN BEGIN
                      StrOrderDetails."Calculation Value" := DiscountPercent;
                      StrOrderDetails.MODIFY;
                  END;
              UNTIL StrOrderDetails.NEXT = 0;
          END;*///16630 Table N/F End
                //16630 Table N/F Start
                /* StrOrderLines.RESET;
                 StrOrderLines.SETCURRENTKEY("Document Type", "Document No.", Type);
                 StrOrderLines.SETRANGE(Type, StrOrderLines.Type::Sale);
                 StrOrderLines.SETRANGE("Document Type", "Document Type");
                 StrOrderLines.SETRANGE("Document No.", "No.");
                 StrOrderLines.SETRANGE("Price Inclusive of Tax", FALSE);
                 //StrOrderLines.SETFILTER("Tax/Charge Code",'%1','ADDINSDISC');
                 //StrOrderLines.SETRANGE("Tax/Charge Group",'%1','ADDINSDISC');
                 IF StrOrderLines.FIND('-') THEN BEGIN
                     StrOrderLines.FINDFIRST;
                     GLSetup.GET;
                     REPEAT
                         IF StrOrderLines."Tax/Charge Group" = GLSetup.AddInsuranceDisc THEN BEGIN
                             StrOrderLines."Calculation Value" := DiscountPercent;
                             // IF StrOrderLines."Base Amount" <>0 THEN
                             //StrOrderLines.Amount := (StrOrderLines."Base Amount"/100)* DiscountPercent;
                             StrOrderLines.MODIFY;
                         END;
                     UNTIL StrOrderLines.NEXT = 0;
                 END;*///16630 Table N/F End
                       //sash
    end;

    local procedure CalculateStructure()
    var
        SalesHeader: Record "Sales Header";
        OrderStatus: Enum "Sales Document Status";
    begin
        CurrPage.update;

        Clear(SalesHeader);
        SalesHeader.reset;
        SalesHeader.setrange("No.", Rec."No.");
        if SalesHeader.FindFirst then begin
            OrderStatus := SalesHeader.Status;
            SalesHeader.Status := SalesHeader.Status::Open;
            SalesHeader.Modify;
        end;

        CurrPage.update;

        Rec.CalculateTradeCharge;
        Rec.CalculateDiscountCharge;
        Rec.CalculateFreight;
        Rec.CalculateInsurance;

        Clear(SalesHeader);
        SalesHeader.reset;
        SalesHeader.setrange("No.", Rec."No.");
        if SalesHeader.FindFirst then begin
            SalesHeader.Status := OrderStatus;
            SalesHeader."Calculate Structure" := true;
            SalesHeader.Modify;
        end;

        CurrPage.update;
    end;


    local procedure CurrencyCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure GenerateSalesLines(ItemNo: Code[20]; LineNo: Integer; DefaultQty: Decimal)
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.INIT;
        SalesLine."Document Type" := Rec."Document Type";
        SalesLine."Document No." := Rec."No.";
        SalesLine."Line No." := LineNo;
        SalesLine."Sell-to Customer No." := Rec."Sell-to Customer No.";
        SalesLine."Location Code" := Rec."Location Code";
        SalesLine."GST Place of Supply" := SalesLine."GST Place of Supply"::"Bill-to Address";
        SalesLine.INSERT(TRUE);
        SalesLine.Type := SalesLine.Type::Item;
        SalesLine.VALIDATE("No.", ItemNo);
        SalesLine.VALIDATE(Quantity, DefaultQty);
        SalesLine.MODIFY(TRUE);
        SalesLine.AutoReserve;
    end;


    /*     procedure SendForApprovalReq()
        var
            SalesLines: Record "Sales Line";
            RecCustomer: Record Customer;
            SmsMgt: Codeunit "SMS Sender - Due Date";
        begin
            SalesSetup.GET;
            CLEAR(SmsMgt);
            rec.CALCFIELDS(rec."D1 Amount", rec."D2 Amount", rec."D3 Amount", rec."D4 Amount", rec."Approval Required");
            IF NOT rec."Approval Required" THEN BEGIN
                rec.Status := rec.Status::"Price Approved";
                rec.MODIFY;
                rec.SendIntimation;
                SmsMgt.CreateMsgOnDApriceApproved(Rec); //MSKS2707
                EXIT;
            END;

            //TESTFIELD(Status,Status::Open);

            //IF NOT (Status IN [Status::Open,Status::"Credit Approved",Status::"Not in Inventory"]) THEN
            //  ERROR('Status Must be Open or Credit Approved');

            SmsMgt.CreateMsgOnDABooked(Rec); //MSKS2707

            IF rec."D1 Amount" <> 0 THEN
                SalesSetup.TESTFIELD("D1 Approval Limit");
            IF rec."D2 Amount" <> 0 THEN
                SalesSetup.TESTFIELD("D2 Approval Limit");
            IF rec."D3 Amount" <> 0 THEN
                SalesSetup.TESTFIELD("D3 Approval Limit");
            IF rec."D4 Amount" <> 0 THEN
                SalesSetup.TESTFIELD("D4 Approval Limit");

            IF rec."D1 Amount" > 0 THEN BEGIN
                MakeApprovalEntries(0, rec."D1 Amount");
            END;
            IF rec."D2 Amount" <> 0 THEN
                MakeApprovalEntries(1, rec."D2 Amount");

            IF rec."D3 Amount" <> 0 THEN
                MakeApprovalEntries(2,rec. "D3 Amount");

            IF rec."D4 Amount" <> 0 THEN
                MakeApprovalEntries(3, rec."D4 Amount");

            //IF (("D1 Amount"+"D2 Amount"+"D3 Amount"+"D4 Amount") <=0) THEN
            rec.Status := rec.Status::"Pending Approval";
            //END;
            rec.MODIFY;

            IF rec."D1 Amount" > 0 THEN BEGIN
                CLEAR(MailMgt);
                IF RecCustomer.GET(rec."Sell-to Customer No.") THEN BEGIN
                    MailMgt.CreateMailForPO(Rec, RecCustomer."PCH Code");
                END;
            END;
        end; */
}

