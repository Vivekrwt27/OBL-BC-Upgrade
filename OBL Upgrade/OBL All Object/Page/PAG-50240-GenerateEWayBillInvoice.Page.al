page 50240 "Generate E Way Bill Invoice"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Sales Invoice Header" = rim;
    SourceTable = "Sales Invoice Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("E-Way Bill No."; Rec."E-Way Bill No.")
                {
                    ApplicationArea = All;
                }
                field("E-Way URL"; rec."E-Way URL")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("E-Way Bill Date"; rec."E-Way Bill Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("E-Way Bill Validity"; rec."E-Way Bill Validity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("E-Way-to generate"; rec."E-Way-to generate")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("E-Way Canceled"; rec."E-Way Canceled")
                {
                    ApplicationArea = All;
                }
                field("E-Way Transaction Type"; rec."E-Way Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("TPT Method"; rec."TPT Method")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Release DateTime"; rec."Release DateTime")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Truck No."; rec."Truck No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Mode of Transport"; Rec."Mode of Transport")
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
                field("Reason of Cancel"; rec."Reason of Cancel")
                {
                    ApplicationArea = All;
                }
                field("Transporter Id"; rec."Shipping Agent Code")
                {
                    Caption = 'Transporter Id';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // IF ShippingAgent.GET(Rec."Shipping Agent Code") THEN BEGIN
                        //  IF ShippingAgent.Blocked THEN ERROR('You Cannot Select Blocked Transporter');
                        //  IF ShippingAgent."Transporter GST No."='' THEN ERROR('Transporter GSTIN must have value in Shipping Agent Table');
                        // END;//Alle_210119
                    end;
                }
                field("Transporter Code"; rec."Transporter's Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF vendor.GET(rec."Transporter's Name") THEN
                            RCMGSTNo := vendor."GST No.";
                    end;
                }
                field("Transporte Name"; Rec."Shipping Agent Code")
                {
                    Caption = 'Transporte Name';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Transporter Mode"; Rec."Transport Method")
                {
                    Caption = 'Transporter Mode';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec."Transport Method" = 'BY ROAD' THEN
                            Trans_DocDate_No := FALSE
                        ELSE
                            Trans_DocDate_No := TRUE;
                    end;
                }
                field("Transporter Name"; rec."Transporter Name")
                {
                    ApplicationArea = All;
                }
                field("RCM GST No."; RCMGSTNo)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sales Territory"; rec."Sales Territory")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Branch Head Name"; pchname)
                {
                    Editable = false;
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
                field("Approx Distance"; Rec."Distance (Km)")
                {
                    ApplicationArea = All;
                }
                field("Distance (Km)"; Rec."Distance (Km)")
                {
                    ApplicationArea = All;
                }
                field("State name"; rec."State name")
                {
                    ApplicationArea = All;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Qty In carton"; rec."Qty In carton")
                {
                    ApplicationArea = All;
                }
                field("Sq. Meter"; rec."Sq. Meter")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship to Pin"; rec."Ship to Pin")
                {
                    ApplicationArea = All;
                }
                field("Insurance Amount"; rec."Insurance Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /* field("Amount to Customer"; "Amount to Customer") //16225 Table Field N/F
                 {
                 }*/
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
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
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Generate E-Way Bill No")
            {
                Image = Import;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    // 15578 APIConsumer: Codeunit "API Consumer E-Way Bill";
                begin
                    Rec.TESTFIELD("Truck No.");
                    gUserSetup.GET(USERID);
                    IF NOT gUserSetup."Generate E-Way Bill" THEN
                        ERROR('You are not Authorized to Generate E-Way Bill');

                    CreateJSONSalesInvoiceEvent(Rec);
                end;
            }
            action("Update Vehicle No")
            {
                Image = UpdateXML;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    // 15578 APIConsumer: Codeunit "API Consumer E-Way Bill";
                begin
                    gUserSetup.GET(USERID);
                    IF NOT gUserSetup."Update E-Way Vechile No" THEN
                        ERROR('You are not Authorized to Update E-Way Vechile No');

                    UpdateVehicleNoEvent(Rec);
                end;
            }
            action("Cancel E-way")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    gUserSetup.GET(USERID);
                    IF NOT gUserSetup."Cancel E-Way Bill" THEN
                        ERROR('You are not Authorized to Cancel E-Way Bill');

                    rec.TESTFIELD("E-Way Bill No.");
                    CancelEwaySalesInvoiceEvent(Rec);
                end;
            }
            action("Print E-Way Bill")
            {
                Promoted = true;
                PromotedCategory = Category10;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    Rec.TESTFIELD("E-Way Bill No.");
                    SalesInvoiceHeader.SETRANGE("No.", Rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN
                        HYPERLINK(SalesInvoiceHeader."E-Way URL");
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        RCMGSTNo := '';
        IF vendor.GET(rec."Transporter's Name") THEN
            RCMGSTNo := vendor."GST No.";

        IF Cust.GET(rec."Sell-to Customer No.") THEN
            pchname := Cust."PCH Name";
    end;

    trigger OnOpenPage()
    begin
        IF USERID <> 'FA010' THEN
            ERROR('Please User New E-Way Bill Option');

        Rec.SetSecurityFilterOnRespCenter;
        Trans_DocDate_No := TRUE;

        /*
        FILTERGROUP(2);
        //SETRANGE("E-Way Bill No.", '');
        SETFILTER("Posting Date", '>%1', TODAY - 5);
        FILTERGROUP(0);
        */
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."View Sales Invoice", '%1', TRUE);
        IF UserLocation.FIND('-') THEN
            REPEAT
                //IF (STRLEN(LocationFilterString)+STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                LocationFilterString += UserLocation."Location Code" + '|';
            UNTIL UserLocation.NEXT = 0;


        LocationFilterString := COPYSTR(LocationFilterString, 1, STRLEN(LocationFilterString) - 1);

        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');

        //MESSAGE(LocationFilterString);

        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Location Code", LocationFilterString);
        Rec.FILTERGROUP(0);

    end;

    var
        //15578 JSONCreater: Codeunit "API Consumer E-Way Bill";
        gUserSetup: Record "User Setup";
        Trans_DocDate_No: Boolean;
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentspage: Page "Shipping Agents";
        RCMGSTNo: Code[15];
        vendor: Record Vendor;
        LocationFilterString: Text[1000];
        UserLocation: Record "User Location";
        pchname: Text[100];
        Cust: Record Customer;

    [IntegrationEvent(false, false)]
    local procedure CreateJSONSalesInvoiceEvent(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure ConsolitedEWayBillSalesInvoiceEvent(JsonString: Text)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure UpdateVehicleNoEvent(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure CancelEwaySalesInvoiceEvent(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure CreateManualJSONInvoice(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;
}

