page 50241 "Generate EWay Bill Purch. Ret."
{
    Caption = 'Generate EWay Bill Purch. Return';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Purch. Cr. Memo Hdr." = rimd;
    SourceTable = "Purch. Cr. Memo Hdr.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("E-Way Bill No."; Rec."E-Way Bill No.1")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("E-Way Bill Date"; Rec."E-Way Bill Date1")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("E-Way Bill Validity"; Rec."E-Way Bill Validity")
                {
                    Editable = false;
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
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("GR No."; Rec."GR No.")
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
                field("Invoice Type"; Rec."Invoice Type")
                {
                    Editable = false;
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
                field("Transporte Name"; Rec."Shipping Agent Code")
                {
                    Caption = 'Transporte Name';
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
                field("Transporter Document No."; Rec."Applies-to Doc. No.")
                {
                    Caption = 'Transporter Document No.';
                    Editable = Trans_DocDate_No;
                    ApplicationArea = All;
                }
                field("Transporter Document Date"; Rec."Document Date")
                {
                    Caption = 'Transporter Document Date';
                    Editable = Trans_DocDate_No;
                    ApplicationArea = All;
                }
                field("Transportation Distance"; Rec."Transportation Distance")
                {
                    ApplicationArea = All;
                }
                field("E-Way URL"; Rec."E-Way URL")
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
                    PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
                    //15578 APIConsumer: Codeunit "API Consumer E-Way Bill";
                begin
                    Rec.TESTFIELD("Truck No.");
                    gUserSetup.GET(USERID);
                    IF NOT gUserSetup."Generate E-Way Bill" THEN
                        ERROR('You are not Authorized to Generate E-Way Bill');

                    CreateJSONPurchaseReturnEvent(Rec);
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
                    //15578 APIConsumer: Codeunit "API Consumer E-Way Bill";
                begin
                    gUserSetup.GET(USERID);
                    IF NOT gUserSetup."Update E-Way Vechile No" THEN
                        ERROR('You are not Authorized to Update E-Way Vechile No');

                    UpdateVehicleNo_Purchase_ReturnEvent(Rec)
                end;
            }
            action("Cancel E-Way")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    gUserSetup.GET(USERID);
                    IF NOT gUserSetup."Cancel E-Way Bill" THEN
                        ERROR('You are not Authorized to Cancel E-Way Bill');

                    Rec.TESTFIELD("E-Way Bill No.");
                    CancelEwayReturnEvent(Rec);
                end;
            }
            action("Print E-Way Bill")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
                begin
                    Rec.TESTFIELD("E-Way Bill No.");
                    PurchCrMemoHdr.SETRANGE("No.", Rec."No.");
                    IF PurchCrMemoHdr.FINDFIRST THEN
                        HYPERLINK(PurchCrMemoHdr."E-Way URL");
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //ERROR('Please User New E-Way Bill Option');

        Rec.SetSecurityFilterOnRespCenter;
        Trans_DocDate_No := TRUE;
    end;

    var
        //15578 JSONCreater: Codeunit "API Consumer E-Way Bill";
        gUserSetup: Record "User Setup";
        UserMgt: Record "User Setup";
        Trans_DocDate_No: Boolean;
        ShippingAgent: Record "Shipping Agent";

    [IntegrationEvent(false, false)]
    local procedure CreateJSONPurchReturnEvent(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure ConsolitedEWayBilPurchReturnEvent(JsonString: Text)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure UpdateVehicleNo_Purchase_ReturnEvent(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure CancelEwayReturnEvent(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure CreateReturnMan(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure CreateJSONPurchaseReturnEvent(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    begin
    end;
}

