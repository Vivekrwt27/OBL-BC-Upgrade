pageextension 50463 "Posted Purchase Receipt" extends "Posted Purchase Receipt"
{
    layout
    {
        addafter("No. Printed")
        {
            field("Total Qty. Rcd. Not Invoiced"; Rec."Total Qty. Rcd. Not Invoiced")
            {
                Caption = 'Qty. Rcd. Not Invoiced';
                Editable = FALSE;
                MultiLine = true;
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = all;
            }
        }
        addafter("Vendor Shipment No.")
        {
            field("Posting Description New"; Rec."Posting Description New")
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    Rec.Validate("Posting Description", Rec."Posting Description New");
                end;
            }
            field("GE Date"; Rec."GE Date")
            {
                ApplicationArea = all;
            }

            field("GE No."; Rec."GE No.")
            {
                ApplicationArea = all;
            }
            field(RejDate; RejDate)
            {
                Caption = 'Shortage/Rejection Date';
            }
        }
        addafter("Responsibility Center")
        {
            field("Nature of Supply"; Rec."Nature of Supply")
            {
                ApplicationArea = all;
            }
        }
        addafter("Pay-to Contact")
        {
            field("Document Receiving Date"; Rec."Document Receiving Date")
            {
                ApplicationArea = all;
            }
            field("Gate Entry No."; Rec."Gate Entry No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter("Ship-to Contact")
        {
            field("Transporter's Code"; Rec."Transporter's Code")
            {
                ApplicationArea = all;
            }
            field("Transporter Name"; Rec."Transporter Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }

    actions
    {
        addafter("&Receipt")
        {
            action(Shortage)
            {
                trigger OnAction()
                var
                    Text001: TextConst ENU = 'No reject quantity found in Purchase order No. %1';
                    Text002: TextConst ENU = 'Do you want to post reject note?';
                    Text004: TextConst ENU = 'Cancelled by %1.';
                    Text008: TextConst ENU = 'Rejection successfully posted by %1.';
                    tgText002: TextConst ENU = 'Rejection Note No. %1 for Vendor Invoice No. %2 already exists.';
                    tgPurchHdr: Record 120;
                    tgPurchLine: Record 121;
                    tgRejectNo: Code[20];
                    tgNoSeriesMgt: Codeunit 396;
                    tgPurchSetup: Record 312;
                    tgRejectHdr: Record 50042;
                    tgRejectLine: Record 50043;
                    tgRecRejectHdr: Record 50042;
                    tgVendor: Record 23;
                    tg2RejectNo: Code[20];
                    tgPurchSetup2: Record 312;
                begin
                    //Ori Ut

                    IF NOT CONFIRM(Text002, FALSE) THEN
                        ERROR(Text004, UPPERCASE(USERID));

                    //TESTFIELD(Status,Status::Released);
                    rec.TESTFIELD("Vendor Invoice No.");
                    rec.TESTFIELD("Vendor Invoice Date");
                    rec.TESTFIELD("Vendor Shipment No.");
                    //15578  rec.TESTFIELD("Vendor Shipment Date");
                    //TESTFIELD("Transporter's Code");
                    rec.TESTFIELD("GE No.");
                    rec.TESTFIELD("Buy-from Vendor No.");
                    IF RejDate = 0D THEN//MSBS.Rao Dt. 04-07-12
                        rec.TESTFIELD("Store Rejection Date");

                    tgVendor.GET(rec."Buy-from Vendor No.");
                    tgVendor.TESTFIELD(tgVendor.Blocked, tgVendor.Blocked::" ");

                    /*tgRecRejectHdr.RESET;
       tgRecRejectHdr.SETCURRENTKEY("No.");
       tgRecRejectHdr.SETRANGE(tgRecRejectHdr."No.", "No.");
       IF tgRecRejectHdr.FIND('-') THEN
           //ERROR(tgText002,tgRecRejectHdr."Rejection No.","Vendor Invoice No.");*/

                    tgPurchSetup.GET;
                    tgPurchSetup.TESTFIELD(tgPurchSetup."Reject No.");

                    tgRejectNo := '';
                    //tgRejectNo := tgNoSeriesMgt.GetNextNo(tgPurchSetup."Reject No.","Store Rejection Date",TRUE); //MSBS.Rao Dt. 04-07-12
                    NoSeriesRelationship.RESET;
                    NoSeriesRelationship.SETRANGE(Code, tgPurchSetup."Reject No.");
                    NoSeriesRelationship.SETRANGE(Location, rec."Location Code");
                    IF NoSeriesRelationship.FINDFIRST THEN
                        tgRejectNo := tgNoSeriesMgt.GetNextNo(NoSeriesRelationship."Series Code", RejDate, TRUE);//MSBS.Rao Dt. 04-07-12

                    tgPurchSetup2.GET;
                    tgPurchSetup2.TESTFIELD(tgPurchSetup2."Store Reject No");

                    tg2RejectNo := '';
                    //tg2RejectNo := tgNoSeriesMgt.GetNextNo(tgPurchSetup."Store Reject No","Store Rejection Date",TRUE);//MSBS.Rao Dt. 04-07-12
                    NoSeriesRelationship.RESET;
                    NoSeriesRelationship.SETRANGE(Code, tgPurchSetup."Store Reject No");
                    NoSeriesRelationship.SETRANGE(Location, rec."Location Code");
                    IF NoSeriesRelationship.FINDFIRST THEN
                        tg2RejectNo := tgNoSeriesMgt.GetNextNo(NoSeriesRelationship."Series Code", RejDate, TRUE);//MSBS.Rao Dt. 04-07-12

                    tgRejectHdr.INIT;
                    tgRejectHdr.TRANSFERFIELDS(Rec);
                    tgRejectHdr."Document Type" := tgRejectHdr."Document Type"::Order;
                    tgRejectHdr."Rejection No." := tgRejectNo;
                    tgRejectHdr."Store Rejection No" := tg2RejectNo;//Ori Ut
                                                                    //tgRejectHdr."Posting Date":="Store Rejection Date";//MSBS.Rao Dt. 04-07-12
                    tgRejectHdr."Posting Date" := RejDate;//MSBS.Rao Dt. 04-07-12
                    tgRejectHdr."Rejection created by" := USERID;
                    tgRejectHdr."Vendor Invoice No." := rec."Vendor Invoice No.";

                    tgRejectHdr.INSERT;

                    tgPurchLine.RESET;
                    tgPurchLine.SETRANGE(tgPurchLine."Document No.", rec."No.");
                    IF tgPurchLine.FIND('-') THEN
                        REPEAT
                            tgRejectLine.INIT;
                            tgRejectLine.TRANSFERFIELDS(tgPurchLine);
                            tgRejectLine."Document Type" := tgRejectLine."Document Type"::Order;
                            tgRejectLine."Rejection No." := tgRejectNo;
                            tgRejectLine."Store Rejection No." := tg2RejectNo;
                            tgRejectLine."MRN No." := rec."No.";
                            tgRejectLine."MRN Date" := rec."Posting Date";
                            //tgRejectLine."Rejection Date":="Store Rejection Date";//MSBS.Rao Dt. 04-07-12
                            tgRejectLine."Rejection Date" := RejDate;//MSBS.Rao Dt. 04-07-12
                            tgRejectLine."Buy-from Vendor No." := rec."Buy-from Vendor No.";
                            tgRejectLine.INSERT;
                        UNTIL tgPurchLine.NEXT = 0
                    ELSE
                        //ERROR(Text001);
                        MESSAGE(Text008, UPPERCASE(USERID));
                    //Ori Ut
                END;

            }
            action("Generate Credit Memo For Rejections")
            {
                Visible = false;


                trigger OnAction()
                var
                begin
                    PH1.RESET;
                    PH1.SETRANGE("Document Type", PH1."Document Type"::Order);
                    PH1.SETFILTER("No.", rec."Order No.");
                    if PH1.FIND('-') THEN BEGIN
                        PurchRcptLine.RESET;
                        PurchRcptLine.SETFILTER("Document No.", rec."No.");
                        //PurchRcptLine.SETFILTER("Rejected Quantity",'>%1',0);
                        IF NOT PurchRcptLine.FIND('-') THEN
                            ERROR('Rejected Qty is 0');

                        if PurchRcptLine.FIND('-') then
                            REPEAT
                                //TRI DG Comment
                                IF PurchRcptLine."Quantity Invoiced" = 0 THEN
                                    ERROR('Please Invoice the MRN %1 First', rec."No.");

                            until PurchRcptLine.NEXT = 0;
                    end ELSE BEGIN
                        PHA1.RESET;
                        PHA1.SETRANGE("Document Type", PHA."Document Type"::Order);
                        PHA1.SETFILTER("No.", rec."Order No.");
                        IF NOT PHA1.FIND('-') THEN
                            ERROR('Please Invoice the MRN %1 First', rec."No.");
                    END;
                    /* 
                                        PH.RESET;
                                        PH.SETRANGE("Document Type", PH."Document Type"::Order);
                                        PH.SETFILTER("No.",rec. "Order No.");
                                        IF PH.FIND('-') THEN
                                            Struct := PH.Structure
                                        ELSE BEGIN
                                            PHA.RESET;
                                            PHA.SETRANGE("Document Type", PHA."Document Type"::Order);
                                            PHA.SETFILTER("No.",rec. "Order No.");
                                            IF PHA.FIND('-') THEN
                                                Struct := PHA.Structure;
                                        END; *///15578

                    //mo tri1.0 Customization no.10 start
                    IF CONFIRM(Text0001) THEN BEGIN
                        PurchRcptLine.RESET;
                        PurchRcptLine.SETFILTER("Document No.", rec."No.");
                        //PurchRcptLine.SETFILTER("Rejected Quantity",'>%1',0);
                        IF PurchRcptLine.FIND('-') THEN BEGIN
                            PurchaseHeader.INIT;
                            PurchaseHeader.TRANSFERFIELDS(Rec);
                            PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::"Credit Memo";
                            PurchSetup.GET;
                            TestNoSeries;
                            NextNo := NoSeriesMgt.GetNextNo(GetNoSeriesCode, rec."Posting Date", TRUE);
                            PurchaseHeader."No." := NextNo;
                            PurchaseHeader.VALIDATE("Applies-to Doc. Type", rec."Applies-to Doc. Type"::Invoice);
                            PurchaseHeader.VALIDATE("Applies-to Doc. No.", PostedInvoice."No.");
                            PurchaseHeader.VALIDATE("Pmt. Discount Date", 0D);
                            //15578 PurchaseHeader.VALIDATE(Structure, Struct);
                            //PurchaseHeader.VALIDATE("Vendor Cr. Memo No.",NextNo);
                            PurchaseHeader.INSERT(TRUE);
                            //newly added code by monika to carry the dimensions
                            /* {PostedDocDim.RESET;
                 PostedDocDim.SETRANGE("Table ID", DATABASE::"Purch. Rcpt. Header");
                 PostedDocDim.SETFILTER("Document No.", "No.");
                 DimMgt.CopyPostedDocDimToDocDim(PostedDocDim, DocDim1, PurchaseHeader);  //Code Blocked for upgrdation //Dimensions missing}
                             */                                                              ////////////////
                            PurchRcptLine.RESET;
                            PurchRcptLine.SETFILTER("Document No.", rec."No.");
                            //PurchRcptLine.SETFILTER("Rejected Quantity",'>%1',0);
                            IF PurchRcptLine.FIND('-') THEN
                                REPEAT
                                    PurchLine.INIT;
                                    PurchLine.VALIDATE("Document Type", PurchLine."Document Type"::"Credit Memo");
                                    PurchLine.VALIDATE("Document No.", PurchaseHeader."No.");
                                    PurchLine.VALIDATE("Line No.", PurchRcptLine."Line No.");
                                    PurchLine.VALIDATE("Buy-from Vendor No.", PurchRcptLine."Buy-from Vendor No.");
                                    PurchLine.VALIDATE(Type, PurchRcptLine.Type);
                                    PurchLine.VALIDATE("No.", PurchRcptLine."No.");
                                    PurchLine.VALIDATE(Quantity, PurchRcptLine."Rejected Quantity");
                                    PurchLine.VALIDATE("Unit of Measure Code", PurchRcptLine."Unit of Measure Code");
                                    PurchLine.VALIDATE("Tax Area Code", PurchRcptLine."Tax Area Code");
                                    PurchLine."Return Reason Code" := PurchRcptLine."Return Reason Code";
                                    PurchLine."Challan Quantity" := PurchRcptLine."Challan Quantity";
                                    PurchLine."Actual Quantity" := PurchRcptLine."Actual Quantity";
                                    PurchLine."Accepted Quantity" := PurchRcptLine."Accepted Qunatity";
                                    PurchLine."Shortage Quantity" := PurchRcptLine."Shortage Quantity";
                                    PurchLine."Rejected Quantity" := PurchRcptLine."Rejected Quantity";

                                    PurchLine.INSERT;
                                UNTIL PurchRcptLine.NEXT = 0;
                            MESSAGE(Text0002, PurchaseHeader."No.");
                        END ELSE
                            ERROR(Text0004);
                    END;



                end;


            }
            action("Rejection Advice")
            {
                trigger OnAction()
                begin
                    RecRejpurchline.RESET;
                    RecRejpurchline.SETRANGE(RecRejpurchline."Document No.", rec."No.");
                    //RecRejpurchline.SETFILTER(PurchRcptLine."Document No.",'%1',"No.");
                    //RecRejpurchline.SETFILTER("No.","No.");
                    /* RejectionAdvice.SETTABLEVIEW(RecRejpurchline);
                    RejectionAdvice.RUN; *///15578
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        //Upgrade(+)

        //TRI SC
        //ND Tri Start Cust 38
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."Create Purchase Order", '%1', TRUE);
        IF UserLocation.FIND('-') THEN
            REPEAT
                IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                    LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
            UNTIL UserLocation.NEXT = 0;

        LocationFilterString := COPYSTR(LocationFilterString, 2, 1024);

        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');
        /*
        FILTERGROUP(2);
SETFILTER("Location Code", LocationFilterString);
FILTERGROUP(0);
        */
        //ND Tri End Cust 38
        //TRI SC

        //Upgrade(-)
    end;

    var

        PH1: Record 38;
        PL: Record 39;
        PHA1: Record 5109;
        PurchSetup: Record 312;
        NoSeriesMgt: Codeunit 396;
        PurchLine: Record 39;
        PurchRcptLine: Record 121;
        NextNo: Code[20];
        ItemLedgerEntries: Record 32;
        valueEntry: Record 5802;
        PH: Record 38;
        Struct: Code[10];
        PHA: Record 5109;
        DimMgt: Codeunit 408;
        PostedInvoice: Record 122;
        PurchaseHeader: Record 38;
        UserLocation: Record 50007;
        LocationFilterString: Text[1024];
        RecRejpurchline: Record 121;
        //15578 RejectionAdvice: Report 50226;
        RejDate: Date;
        NoSeriesRelationship: Record 310;
        "....tri1.0": TextConst;
        Text0001: TextConst ENU = 'Are you sure you want to create a Credit Memo for Rejections.';
        Text0002: TextConst ENU = 'Credit Memo %1 has been created.';
        Text0003: TextConst ENU = 'Are you sure you want to create a Credit Memo for Shortage.';
        Text0004: TextConst ENU = 'Rejected Quantity should be greater than zero.';
        Text0005: TextConst ENU = 'Shortage Quantity should be greater than zero.';

    LOCAL PROCEDURE TestNoSeries(): Boolean;
    BEGIN
        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo" THEN
            PurchSetup.TESTFIELD("Credit Memo Nos.");
    END;

    LOCAL PROCEDURE GetNoSeriesCode(): Code[10];
    BEGIN
        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo" THEN BEGIN
            EXIT(PurchSetup."Credit Memo Nos.");
        END;
    END;

}