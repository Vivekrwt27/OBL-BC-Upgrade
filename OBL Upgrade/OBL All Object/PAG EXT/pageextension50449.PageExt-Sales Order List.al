pageextension 50449 pageextension50449 extends "Sales Order List"
{
    layout
    {
        addafter("Bill-to Name")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bill-to Post Code")
        {
            field("Ship-to City"; Rec."Ship-to City")
            {
                ApplicationArea = All;
            }
        }
        addafter("Ship-to Code")
        {
            field("Reserved Qty"; Rec."Reserved Qty")
            {
                ApplicationArea = All;
            }
            field("TPT Method"; Rec."Shipping Agent Code")
            {
                Caption = 'TPT Method';
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Ship-to Name")
        {
            field("Approval Pending At"; Rec."Approval Pending At")
            {
                ApplicationArea = All;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
        }
        moveafter("Ship-to Country/Region Code"; Amount)
        addafter("Ship-to Country/Region Code")
        {
            field("Outstanding Amount"; Rec."Outstanding Amount")
            {
                ApplicationArea = All;
            }
            field("Outstanding Qty In Sqm"; Rec."Outstanding Qty")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipment Method Code")
        {
            field("Releasing Date"; Rec."Releasing Date")
            {
                ApplicationArea = All;
            }
            field("Releaser ID"; Rec."Releaser ID")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipping Agent Code")
        {
            field("GST Registration No."; gstregistration)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Make Order Date"; Rec."Make Order Date")
            {
                ApplicationArea = All;
            }
            field("Gross Wt."; Rec."Gross Wt.")
            {
                ApplicationArea = All;
            }
            field("Discount Charges %"; Rec."Discount Charges %")
            {
                ApplicationArea = All;
            }
            field("Opener ID"; Rec."Opener ID")
            {
                ApplicationArea = All;
            }
            field("PCH Code"; Rec."PCH Code")
            {
                ApplicationArea = all;
            }
            field("Govt./Private Sales Person"; Rec."Govt./Private Sales Person")
            {
                ApplicationArea = all;
            }
            /*field("Amount to Customer"; "Amount to Customer")//16225 Table Field N/F
            {
            }*/
            field("State Description"; Rec."State Description")
            {
                ApplicationArea = All;
            }
            field("Order Created ID"; Rec."Order Created ID")
            {
                ApplicationArea = All;
            }
            field("Truck No."; Rec."Truck No.")
            {
                ApplicationArea = All;
            }
            field(Pay; Rec.Pay)
            {
                ApplicationArea = All;
            }
            field("Date of Reopen"; Rec."Date of Reopen")
            {
                ApplicationArea = All;
            }
            field("Releasing Time"; Rec."Releasing Time")
            {
                ApplicationArea = All;
            }
            field("Time of Reopen"; Rec."Time of Reopen")
            {
                ApplicationArea = All;
            }
            /* field(Structure; Structure)//16225 Field N/F
             {
             }*/
            field("Dealer Code"; Rec."Dealer Code")
            {
                ApplicationArea = All;
            }
            field("Sell-to City"; Rec."Sell-to City")
            {
                ApplicationArea = All;
            }
            field(Quantity; Rec.Quantity)
            {
                ApplicationArea = All;
            }
            field("Qty in Sq. Mt."; Rec."Qty in Sq. Mt.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipment Date")
        {
            field("Customer Type"; Rec."Customer Type")
            {
                ApplicationArea = All;
            }
            field("Bypass Auto Order Process"; Rec."Bypass Auto Order Process")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Despatch Remarks"; Rec."Despatch Remarks")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Completely Shipped")
        {
            field("Reason To Hold"; Rec.Commitment)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("CD Available for Utilisation"; Rec."CD Available for Utilisation")
            {
                ApplicationArea = All;
            }
            field("Order Processed Date"; Rec."Payment Date 3")
            {
                ApplicationArea = All;
            }
            field("Promised Delivery Date"; Rec."Promised Delivery Date")
            {
                ApplicationArea = All;
            }
            field("Pending At"; Pendingat)
            {
                ApplicationArea = All;
            }
        }
        addafter("Job Queue Status")
        {
            field("Sent Time Approval"; SentTime)
            {
                ApplicationArea = All;
            }
            field("PCH Approval Time"; PCHTime)
            {
                ApplicationArea = All;
            }
            field("PO No."; Rec."PO No.")
            {
                ApplicationArea = All;
            }
            field("PMT Code"; Rec."PMT Code")
            {
                ApplicationArea = All;
            }
            field("ZM Approval Time"; ZMTime)
            {
                ApplicationArea = All;
            }
            field("PSM Approval Time"; PSMTime)
            {
                ApplicationArea = All;
            }
            field("PAC Approval Time"; PACTime)
            {
                ApplicationArea = All;
            }
            field("ZH Code"; Rec."ZH Code")
            {
                ApplicationArea = All;
            }
            field("Order Booked Date"; Rec."Order Booked Date")
            {
                ApplicationArea = All;
            }
            field("Morbi Team"; Rec."Entry Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("No. of Vehicle Notification"; Rec."No. of Vehicle Notification")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Sales Territory"; salterr)
            {
                Caption = 'Sales Territory';
                ApplicationArea = All;
            }
            field("Ship-to Name 2"; Rec."Ship-to Name 2")
            {
                ApplicationArea = All;
            }
            field("Credit Approved"; Rec."Credit Approved")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Inventory Approved"; Rec."Inventory Approved")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Price Approved"; Rec."Price Approved")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Ship-to Address"; Rec."Ship-to Address")
            {
                ApplicationArea = All;
            }
            field("Transporter Name"; Rec."Transporter Name")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Ship-to Address 2"; Rec."Ship-to Address 2")
            {
                ApplicationArea = All;
            }
            field("Transporter Co. No"; Rec."Your Reference")
            {
                Caption = 'Transporter Co. No';
                Editable = false;
                ApplicationArea = All;
            }
            field("Trade Discount"; Rec."Trade Discount")
            {
                ApplicationArea = All;
            }
            field("Item Change Remarks"; Rec."Order Change Remarks")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(Zone; zone)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Mobile App. Order"; Rec."Transfer No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Tonnage of Vehicle placed"; Rec."Tonnage of Vehicle placed")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Estimated Date of Arrival"; Rec."Estimated Date of Arrival")
            {
                ApplicationArea = All;
            }
            field("Driver Name"; Rec."Driver Name")
            {
                ApplicationArea = All;
            }
            field("Driver Phone No."; Rec."Driver Phone No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(Dimensions)
        {
            action("Transfer to SO Creation")
            {
                Caption = 'Transfer to SO Creation';
                Promoted = true;
                RunObject = Report "Transfer to SO Creation";
                ApplicationArea = All;
            }
            action("Process Sales Orders")
            {
                Caption = 'Process Sales Orders';
                Promoted = true;
                RunObject = Codeunit "Process Sales Orders";
                ApplicationArea = All;
            }
        }
        addafter("Co&mments")
        {
            action("Sales Order Archive")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    Salesorderdataarchive: Query "Sales order data archive";
                begin
                    CLEAR(Salesorderdataarchive);
                    // Salesorderdataarchive.SAVEASCSV('c:\salesarchive.csv');
                end;
            }
            action("Sales Order Detail")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    Salesorderdata: Query "Sales order data1";
                begin
                    CLEAR(Salesorderdata);
                    // Salesorderdata.SAVEASCSV('c:\SODETAIL.csv');
                end;
            }
        }
        addafter("Pick Instruction")
        {
            action("Loading Slip")
            {
                Caption = 'Loading Slip';
                ApplicationArea = All;

                trigger OnAction()
                var
                    SIH: Record "Sales Header";
                begin
                    SIH.RESET;
                    SIH.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(Report::"Loading Slip", TRUE, FALSE, SIH);
                end;
            }
        }
        modify(Release)
        {
            trigger OnBeforeAction()
            begin
                if Rec."Ship to Pin" = '' then
                    Error('Ship to Pin must have value..');

                if Rec."GST Ship-to State Code" = '' then
                    Error('Ship to State must have value..');

                if Rec."Ship-to Post Code" = '' then
                    Error('Ship to Post Code must have value..');

            end;
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                CalculateStructure;

                Rec.CheckTradeDiscountLine;

                If not Rec."Calculate Structure" then
                    Error('Please Calculate the structure..');
            end;

            trigger OnAfterAction()
            var
                RecSalesHeader: Record "Sales Header";
            begin
                CurrPage.Update;

                RecSalesHeader.Reset;
                RecSalesHeader.SetRange("No.", Rec."No.");
                if RecSalesHeader.FindFirst then begin
                    RecSalesHeader."Structure Freight Amount" := 0;
                    RecSalesHeader.Modify;
                end;
            end;
        }
        modify("Preview Posting")
        {
            trigger OnBeforeAction()
            begin
                CalculateStructure;

                Rec.CheckTradeDiscountLine;

                If not Rec."Calculate Structure" then
                    Error('Please Calculate the structure..');
            end;
        }
        modify(PostAndSend)
        {
            trigger OnBeforeAction()
            begin
                CalculateStructure;

                Rec.CheckTradeDiscountLine;

                If not Rec."Calculate Structure" then
                    Error('Please Calculate the structure..');
            end;
        }
    }

    var
        LocationFilterString: Text;
        UserLocation: Record "User Location";
        gstregistration: Code[15];
        CUSTOMER: Record Customer;
        Pendingat: Text[50];
        ArchiveApprovalEntryREC: Record "Archive Approval Entry";
        SentTime: DateTime;
        PACTime: DateTime;
        Count1: Integer;
        PCHTime: DateTime;
        ZMTime: DateTime;
        PSMTime: DateTime;
        AppEntry: Record "Approval Entry";
        SP: Record "Salesperson/Purchaser";
        salterr: Code[15];
        pchleadtime: Time;
        zone: Text[30];


    trigger OnAfterGetRecord()
    var
        Dtt: DateTime;
    begin
        IF CUSTOMER.GET(Rec."Sell-to Customer No.") THEN
            gstregistration := CUSTOMER."GST Registration No.";
        salterr := CUSTOMER."Area Code";
        zone := CUSTOMER."Tableau Zone";

        //Upgrade

        Pendingat := '';
        IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN
            AppEntry.RESET;
            AppEntry.SETRANGE(AppEntry."Document No.", Rec."No.");
            AppEntry.SETRANGE(AppEntry.Status, AppEntry.Status::Created);
            IF AppEntry.FINDFIRST THEN
                IF SP.GET(AppEntry."Approver Code") THEN
                    Pendingat := SP.Name;
        END;
        //
        CLEAR(SentTime);
        CLEAR(PACTime);
        ArchiveApprovalEntryREC.RESET;
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", Rec."No.");

        IF ArchiveApprovalEntryREC.FINDLAST THEN
            SentTime := ArchiveApprovalEntryREC."Date-Time Sent for Approval";

        ArchiveApprovalEntryREC.RESET;
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", Rec."No.");
        ArchiveApprovalEntryREC.SETFILTER("Date-Time Sent for Approval", '%1', SentTime);
        IF ArchiveApprovalEntryREC.FINDFIRST THEN
            REPEAT
                IF (ArchiveApprovalEntryREC."Approver Code" = '1110088') OR (ArchiveApprovalEntryREC."Approver Code" = '1111058') THEN
                    PACTime := ArchiveApprovalEntryREC."Approval Date & Time";
            UNTIL ArchiveApprovalEntryREC.NEXT = 0;

        CLEAR(Count1);
        CLEAR(PCHTime);
        CLEAR(ZMTime);
        CLEAR(PSMTime);

        ArchiveApprovalEntryREC.RESET;
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", Rec."No.");
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
        IF ArchiveApprovalEntryREC.FINDLAST THEN
            Dtt := ArchiveApprovalEntryREC."Date-Time Sent for Approval";

        ArchiveApprovalEntryREC.RESET;
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", Rec."No.");
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
        ArchiveApprovalEntryREC.SETFILTER("Date-Time Sent for Approval", '%1', Dtt);
        IF ArchiveApprovalEntryREC.FINDFIRST THEN
            REPEAT
                Count1 += 1;
                IF (Count1 = 1) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                    PCHTime := ArchiveApprovalEntryREC."Approval Date & Time";
                IF (Count1 = 2) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                    ZMTime := ArchiveApprovalEntryREC."Approval Date & Time";
                IF (Count1 = 3) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                    PSMTime := ArchiveApprovalEntryREC."Approval Date & Time";
            UNTIL ArchiveApprovalEntryREC.NEXT = 0;
        //MSAK

        //Upgrade
        //IF (SentTime<>0D) AND (PCHTime <>0D) THEN
        //   pchleadtime := SentTime-PCHTime;

    end;

    //TEAM 14763
    local procedure CalculateStructure()
    var
        SalesHeader: Record "Sales Header";
        OrderStatus: Enum "Sales Document Status";
    begin
        CurrPage.update;

        Clear(SalesHeader);
        Clear(OrderStatus);

        SalesHeader.reset;
        SalesHeader.setrange("No.", Rec."No.");
        if SalesHeader.FindFirst then begin
            OrderStatus := SalesHeader.Status;
            SalesHeader.Status := SalesHeader.Status::Open;
            SalesHeader.Modify;
        end;

        CurrPage.update;

        Rec.CalculateTradeCharge;

        CurrPage.update;

        Rec.CalculateDiscountCharge;

        CurrPage.update;

        Rec.CalculateFreight;

        CurrPage.update;

        Rec.CalculateInsurance;

        CurrPage.update;

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
    //TEAM 14763
    //TEAM 14763



    trigger OnOpenPage()
    begin
        //Upgrade(+)
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
        Rec.SETFILTER("Location Code", LocationFilterString);
        Rec.FILTERGROUP(0);

        //upgrade(-)
        Rec.SETRANGE("Date Filter", 0D, WORKDATE - 1);

    end;

}

