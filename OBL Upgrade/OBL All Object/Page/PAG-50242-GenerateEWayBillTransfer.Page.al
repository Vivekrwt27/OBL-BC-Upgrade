page 50242 "Generate E Way Bill Transfer"
{
    Caption = 'Generate E Way Bill Transfer Shipment';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Transfer Shipment Header" = rimd;
    SourceTable = "Transfer Shipment Header";

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
                field("LR/RR No."; Rec."LR/RR No.")
                {
                    ApplicationArea = All;
                }
                field("LR/RR Date"; Rec."LR/RR Date")
                {
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    Visible = false;
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
                    TransferShipmentHeader: Record "Transfer Shipment Header";
                    APIConsumer: Codeunit TransferOrderPostYesNo;
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
                ApplicationArea = All;

                trigger OnAction()
                var
                    APIConsumer: Codeunit TransferOrderPostYesNo;
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

                trigger OnAction()
                begin
                    gUserSetup.GET(USERID);
                    IF NOT gUserSetup."Cancel E-Way Bill" THEN
                        ERROR('You are not Authorized to Cancel E-Way Bill');

                    Rec.TESTFIELD("E-Way Bill No.");
                    CancelEwayTransferEvent(Rec);
                end;
            }
            action("Print E-Way Bill")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    TransferShipmentHeader: Record "Transfer Shipment Header";
                begin
                    Rec.TESTFIELD("E-Way Bill No.");
                    TransferShipmentHeader.SETRANGE("No.", Rec."No.");
                    IF TransferShipmentHeader.FINDFIRST THEN
                        HYPERLINK(TransferShipmentHeader."E-Way URL");
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //ERROR('Please User New E-Way Bill Option');


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
        JSONCreater: Codeunit TransferOrderPostYesNo;
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
}

