pageextension 50442 pageextension50442 extends "Transfer Order Subform"
{
    layout
    {
        moveafter("Transfer-To Bin Code"; Quantity)
        moveafter("Unit of Measure"; "Qty. to Ship")

        modify("Qty. to Ship")
        {
            trigger OnAfterValidate()
            begin
                //UPDATE TCPL - 7632
                TrfHeader.SETRANGE("No.", Rec."Document No.");
                TrfHeader.SETFILTER("External Transfer", '%1', TRUE);
                IF TrfHeader.FINDFIRST THEN BEGIN
                    TrfHeader.TESTFIELD("GR No.");
                    TrfHeader.TESTFIELD("GR Date");
                    TrfHeader.TESTFIELD("Truck No.");
                END
                //UPDATE TCPL - 7632
            end;
        }


        addafter("Inbound Whse. Handling Time")
        {
            field("Capex No."; Rec."Capex No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("ShortcutDimCode[5]")
        {
            field("Mfg. Batch No."; Rec."Mfg. Batch No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Appl.-to Item Entry")
        {
            /* field("BED Amount"; "BED Amount")//16225 Field N/F
             {
             }*/
            field(Inventory; Rec.Inventory)
            {
                ApplicationArea = All;
            }
            field("Inventory Posting Group"; Rec."Inventory Posting Group")
            {
                ApplicationArea = All;
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
            field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
            {
                ApplicationArea = All;
            }
            /* field("Excise Accounting Type"; "Excise Accounting Type")//16225 Field N/F
             {
             }*/
            field(ItemClasification; ItemClasification)
            {
                Editable = false;
                ApplicationArea = All;
            }
            /*field("Excise Effective Rate"; "Excise Effective Rate")//16225 Field N/F
            {
                Editable = false;
            }*/
            field("Customer Price Group"; Rec."Customer Price Group")
            {
                ApplicationArea = All;
            }
            /* field("Excise Bus. Posting Group"; "Excise Bus. Posting Group")//16225 Field N/F
             {
             }
             field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")//16225 Field N/F
             {
             }*/
            field("Transfer-from Code"; Rec."Transfer-from Code")
            {
                ApplicationArea = All;
            }
            field("Transfer-to Code"; Rec."Transfer-to Code")
            {
                ApplicationArea = All;
            }
            field("Gross Weight"; Rec."Gross Weight")
            {
                Editable = false;
                Importance = Promoted;
                ApplicationArea = All;
            }
            field("Net Weight"; Rec."Net Weight")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Description 2"; Rec."Description 2")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Unit Price"; Rec."Unit Price")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Qty in Sq. Mt."; Rec."Qty in Sq. Mt.")
            {
                Editable = false;
                Importance = Promoted;
                ApplicationArea = All;
            }
            field("Short Quantity"; Rec."Short Quantity")
            {
                ApplicationArea = All;
            }
            field("Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = All;
            }
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            field("Group Code"; Rec."Group Code")
            {
                ShowCaption = false;
                ApplicationArea = All;
            }
            /* field("GST %"; "GST %")//16225 Field N/F
             {
             }*/
            field("End Use Item"; Rec."End Use Item")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
            field("Customer Code"; Rec."Customer Code")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    IF Reccust.GET(Rec."Customer Code") THEN
                        Custname := Reccust.Name;
                end;
            }
            field("Requested by"; Rec."Requested by")
            {
                ApplicationArea = All;
            }
            field("Customer Name"; Custname)
            {
                Enabled = false;
                ApplicationArea = All;
            }
        }
    }

    var
        // CustAttach: Record "Orient Attachments1";
        RecItem: Record Item;
        TrfHeader: Record "Transfer Header";
        ItemClasification: Code[20];
        Custname: Text[100];
        Reccust: Record Customer;

    trigger OnAfterGetRecord()
    begin
        //MSBS.Rao Start-0713
        IF RecItem.GET(Rec."Item No.") THEN
            ItemClasification := RecItem."Item Classification";
        //MSBS.Rao Stop-0713
    end;

    procedure _ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;

    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;

    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location)
    begin
        //Rec.ItemAvailability(AvailabilityType); //Code blocked for upgradation
    end;

    procedure _ShowReservation()
    begin
        Rec.FIND;
        Rec.ShowReservation;
    end;

    procedure ShowReservation()
    begin
        Rec.FIND;
        Rec.ShowReservation;
    end;

    procedure _OpenItemTrackingLines(Direction: Option Outbound,Inbound)
    begin
        Rec.OpenItemTrackingLines(Direction);
    end;

    procedure OpenItemTrackingLines(Direction: Option Outbound,Inbound)
    begin
        Rec.OpenItemTrackingLines(Direction);
    end;

    /*  procedure CustAttachments()
     begin
         CustAttach.RESET;
         CustAttach.SETRANGE("Table ID", DATABASE::"Transfer Header");
         CustAttach.SETRANGE("Document No.", Rec."Document No.");
         //CustAttach.SETRANGE("Document Type","Document Type");
         PAGE.RUN(PAGE::"Orient Attachments", CustAttach);
     end;
  */
    procedure GetShortageLine()
    var
        TransRcptLine: Record "Transfer Receipt Line";
        TransHeader: Record "Transfer Header";
        GetShortage: Page "Get Shortage Line";
    begin
        TransHeader.GET(Rec."Document No.");
        TransHeader.TESTFIELD(Status, TransHeader.Status::Open);

        TransRcptLine.SETCURRENTKEY("Transfer-to Code");
        TransRcptLine.FILTERGROUP(2);
        TransRcptLine.SETRANGE("Transfer-to Code", TransHeader."Transfer-from Code");
        TransRcptLine.SETFILTER("Short Quantity", '<>0');
        TransRcptLine.SETRANGE("Shoratge Quantity Shipped", FALSE);
        TransRcptLine.FILTERGROUP(0);
        GetShortage.SETTABLEVIEW(TransRcptLine);
        GetShortage.LOOKUPMODE := TRUE;
        GetShortage.SetTransHeader(TransHeader);
        GetShortage.RUNMODAL;
    end;
}