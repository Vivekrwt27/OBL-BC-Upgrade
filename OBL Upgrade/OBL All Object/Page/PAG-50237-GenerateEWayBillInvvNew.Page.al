page 50237 "Generate E Way Bill Invv New"
{
    Caption = 'Generate E Way Bill Sales Invoice';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Sales Invoice Header" = rim;
    SourceTable = "Sales Invoice Header";
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("E-Way Bill No."; Rec."E-Way Bill No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("E-Way URL"; Rec."E-Way URL")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("E-Way Bill Date"; Rec."E-Way Bill Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("E-Way Bill Validity"; Rec."E-Way Bill Validity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("E-Way-to generate"; Rec."E-Way-to generate")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("E-Way Canceled"; Rec."E-Way Canceled")
                {
                    ApplicationArea = All;
                }
                field("E-Way Transaction Type"; Rec."E-Way Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle No.")
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
                field("Truck No."; Rec."Truck No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec."Vehicle No." := Rec."Truck No.";
                    end;
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
                field("New Vechile No."; Rec."New Vechile No.")
                {
                    ApplicationArea = All;
                }
                field("Vechile No. Update Remark"; Rec."Vechile No. Update Remark")
                {
                    ApplicationArea = All;
                }
                field("Reason of Cancel"; Rec."Reason of Cancel")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Type"; Rec."Shipping Agent Code")
                {
                    Caption = 'Vehicle Type';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // IF ShippingAgent.GET(Rec."Shipping Agent Code") THEN BEGIN
                        //  IF ShippingAgent.Blocked THEN ERROR('You Cannot Select Blocked Transporter');
                        //  IF ShippingAgent."Transporter GST No."='' THEN ERROR('Transporter GSTIN must have value in Shipping Agent Table');
                        // END;//Alle_210119
                    end;
                }
                field("Transporter Code"; Rec."Transporter's Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF vendor.GET(Rec."Transporter's Name") THEN
                            RCMGSTNo := vendor."GST No.";
                    end;
                }
                field("Transport Method"; Rec."Transport Method")
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
                field("Transporter Name"; Rec."Transporter Name")
                {
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec."Transporter's Name" <> '' THEN
                            ERROR('Name Cannot Be Changed');
                    end;
                }
                field("Transporter ID"; RCMGSTNo)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Branch Head Name"; pchname)
                {
                    Editable = false;
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
                field("Ship to Pin"; Rec."Ship to Pin")
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
                Visible = false;
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
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                var
                    //15578 APIConsumer: Codeunit "API Consumer E-Way Bill";
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
                Visible = false;

                trigger OnAction()
                begin
                    gUserSetup.GET(USERID);
                    IF NOT gUserSetup."Cancel E-Way Bill" THEN
                        ERROR('You are not Authorized to Cancel E-Way Bill');

                    Rec.TESTFIELD("E-Way Bill No.");
                    CancelEwaySalesInvoiceEvent(Rec);
                end;
            }
            action("Download E-Way Bill")
            {
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    Rec.TESTFIELD("E-Way Bill No.");
                    SalesInvoiceHeader.SETRANGE("No.", Rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN
                        DownloadEWBSalesInv(Rec);
                end;
            }
            action("Generate E-Way Bill No Via IRN")
            {
                Promoted = true;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    Rec.TESTFIELD("IRN Hash");
                    gUserSetup.GET(USERID);
                    IF NOT gUserSetup."Generate E-Way Bill" THEN
                        ERROR('You are not Authorized to Generate E-Way Bill');

                    CreateJSONSalesInvEventViaIRN(Rec);
                end;
            }
            action("Generate E-Way BillNew")
            {
                Caption = '<Generate E-Way Bill>';
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                var
                    APIManagementEY: Codeunit "API Management -EY 2.6";
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    IF Rec."Posting Date" <= 20200930D THEN
                        ERROR('You cannot create EWB Before than 1st Oct 2020');

                    Rec.TESTFIELD("E-Way Bill No.", '');
                    Rec.TESTFIELD("E-Way Generated", FALSE);
                    CLEAR(APIManagementEY);
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETFILTER("No.", '%1', Rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                        APIManagementEY.SetSalesInvHeader(SalesInvoiceHeader);
                        APIManagementEY.GenerateSalesInvJSONSchemaEWB(SalesInvoiceHeader);
                    END;
                end;
            }
            action("TroubleShoot Generation")
            {
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                var
                    APIManagementEY: Codeunit "API Management -EY 2.6";
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    //TroubleShootJSON(Rec);
                    CLEAR(APIManagementEY);
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETFILTER("No.", '%1', Rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                        APIManagementEY.SetSalesInvHeader(SalesInvoiceHeader);
                        APIManagementEY.TroubleshootSalesInvJSONSchemaEWB(SalesInvoiceHeader);
                    END;
                end;
            }
            action("TroubleShoot Cancel")
            {
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                var
                    MIPLAPIConsumerEWayBillEY: Codeunit "MIPL-API Consumer E-Way BillEY";
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    CLEAR(MIPLAPIConsumerEWayBillEY);
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETFILTER("No.", '%1', Rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                        MIPLAPIConsumerEWayBillEY.TroublenshootCancelEWaySalesInvoice(SalesInvoiceHeader);
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        RCMGSTNo := '';
        IF vendor.GET(Rec."Transporter's Name") THEN
            RCMGSTNo := vendor."GST Registration No.";

        // IF Cust.GET("Sell-to Customer No.") THEN
        //  pchname := Cust."PCH Name";
        IF Rec."Vehicle No." = '' THEN
            Rec."Vehicle No." := Rec."Truck No.";

        IF Rec."Transport Method" = '' THEN
            Rec.VALIDATE("Transport Method", 'ROAD');

        IF Rec."Mode of Transport" = '' THEN
            Rec.VALIDATE("Mode of Transport", 'ROAD');
    end;

    trigger OnOpenPage()
    begin


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
        pchname: Text[100];
        Cust: Record Customer;
        UserLocation: Record "User Location";

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

    [IntegrationEvent(false, false)]
    local procedure CreateJSONSalesInvEventViaIRN(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure DownloadEWBSalesInv(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure TroubleShootJSON(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;
}

