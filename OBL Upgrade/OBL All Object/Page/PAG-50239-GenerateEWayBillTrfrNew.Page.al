page 50239 "Generate EWay Bill Trfr New"
{
    Caption = 'Generate E Way Bill Transfer Shipment';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Transfer Shipment Header" = rimd;
    SourceTable = "Transfer Shipment Header";
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
                    ApplicationArea = All;
                }
                field("E-Way Generated"; Rec."E-Way Generated")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
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
                }
                field("Vehicle No."; Rec."Vehicle No.")
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
                field("E-Way Canceled"; Rec."E-Way Canceled")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transporter Id"; Rec."Shipping Agent Code")
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
                field("Transporter's Name"; Rec."Transporter's Name")
                {
                    ApplicationArea = All;
                }
                field("Transporter Name"; Rec."Shipping Agent Code")
                {
                    Caption = 'Transporter Name';
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
                field("Transporter Document No."; Rec."External Document No.")
                {
                    Caption = 'Transporter Document No.';
                    Editable = Trans_DocDate_No;
                    ApplicationArea = All;
                }
                field("Transporter Document Date"; Rec."Posting Date")
                {
                    Caption = 'Transporter Document Date';
                    Editable = Trans_DocDate_No;
                    ApplicationArea = All;
                }
                field("Transportation Distance"; Rec."Transportation Distance")
                {
                    Caption = 'Transportation Distance';
                    ApplicationArea = All;
                }
                field("E-Way URL"; Rec."E-Way URL")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Distance (Km)"; Rec."Distance (Km)")
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
                    TransferShipmentHeader: Record "Transfer Shipment Header";
                begin
                    Rec.TESTFIELD("Truck No.");
                    gUserSetup.GET(USERID);
                    IF NOT gUserSetup."Generate E-Way Bill" THEN
                        ERROR('You are not Authorized to Generate E-Way Bill');

                    CreateJSONTransferShipmentEvent(Rec);
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
                begin
                    gUserSetup.GET(USERID);
                    IF NOT gUserSetup."Update E-Way Vechile No" THEN
                        ERROR('You are not Authorized to Update E-Way Vechile No');
                    UpdateVehicleNo_TransferShipmentEvent(Rec);
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
                    CancelEwayTransferEvent(Rec);
                end;
            }
            action("Download E-Way Bill")
            {
                ApplicationArea = All;
                Visible = false;
                trigger OnAction()
                var
                    TransferShipmentHeader: Record "Transfer Shipment Header";
                begin
                    Rec.TESTFIELD("E-Way Bill No.");
                    TransferShipmentHeader.SETRANGE("No.", Rec."No.");
                    IF TransferShipmentHeader.FINDFIRST THEN
                        PrintEWBTransferShipEvent(Rec);
                end;
            }
            action("Generate E-Way Bill Via IRN")
            {
                Image = Import;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                var
                    TransferShipmentHeader: Record "Transfer Shipment Header";
                begin
                    Rec.TESTFIELD("Truck No.");
                    Rec.TESTFIELD("IRN Hash");
                    gUserSetup.GET(USERID);
                    IF NOT gUserSetup."Generate E-Way Bill" THEN
                        ERROR('You are not Authorized to Generate E-Way Bill');

                    CreateJSONTransferShipmentEventViaIRN(Rec);
                end;
            }
            action("Generate E-Way BillNew")
            {
                Caption = '<Generate E-Way Bill>';
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                Visible = false;
                trigger OnAction()
                var
                    APIManagementEY: Codeunit "API Management -EY 2.6";
                    TransShptHeader: Record "Transfer Shipment Header";
                begin
                    IF Rec."Posting Date" <= 20200930D THEN
                        ERROR('You cannot create IRN Before than 1st Oct 2020');
                    Rec.TESTFIELD("E-Way Bill No.", '');
                    Rec.TESTFIELD("E-Way Generated", FALSE);
                    CLEAR(APIManagementEY);
                    TransShptHeader.RESET;
                    TransShptHeader.SETFILTER("No.", '%1', Rec."No.");
                    IF TransShptHeader.FINDFIRST THEN BEGIN
                        APIManagementEY.SetTransferShipHeader(TransShptHeader);
                        APIManagementEY.GenerateTransferInvoiceJSONSchemaEWB(TransShptHeader);
                    END;
                end;
            }
            action("TroubleShoot JSON")
            {
                ApplicationArea = All;
                Visible = false;
                trigger OnAction()
                begin
                    TroubleshootJSON(Rec);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //>>SM_MUA01
        // IF UserMgt.GetRespCenterFilter() <> '' THEN BEGIN
        //  FILTERGROUP(2);
        //  SETRANGE("Responsibility Center",UserMgt.GetRespCenterFilter());
        //  FILTERGROUP(0);
        // END;//Alle_210119
        //<<SM_MUA01
        Trans_DocDate_No := TRUE;
    end;

    var
        gUserSetup: Record "User Setup";
        UserMgt: Codeunit "User Setup Management";
        Trans_DocDate_No: Boolean;
        ShippingAgent: Record "Shipping Agent";

    [IntegrationEvent(false, false)]
    local procedure CreateJSONTransferShipmentEvent(var TransferShipmentHeaderL: Record "Transfer Shipment Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure ConsolitedEWayBillSalesReturnEvent(JsonString: Text)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure UpdateVehicleNo_TransferShipmentEvent(var TransferShipmentHeader: Record "Transfer Shipment Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure CancelEwayTransferEvent(TransferShipmentHeader: Record "Transfer Shipment Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure CreateJSONTransferShipmentEventMan(var TransferShipmentHeaderL: Record "Transfer Shipment Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure PrintEWBTransferShipEvent(var TransferShipmentHeaderL: Record "Transfer Shipment Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure CreateJSONTransferShipmentEventViaIRN(var TransferShipmentHeaderL: Record "Transfer Shipment Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure TroubleshootJSON(var TransferShipmentHeaderL: Record "Transfer Shipment Header")
    begin
    end;
}

