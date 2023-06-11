report 50332 "Indent Detail"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\IndentDetail.rdl';

    dataset
    {
        dataitem("Indent Header"; "Indent Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Indent Date", Status, "Location Code", "Department Code", "Plant Code", "Group Code";
            dataitem("Indent Line"; "Indent Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Deleted = FILTER(false),
                                          Type = FILTER(Item));
                RequestFilterFields = Type, "No.", "Item Category Code", "Product Group Code", "Inventory Posting Group";
                column(QtySum; QtySum)
                {
                }
                column(MRNDocNo; MRNDocNo)
                {
                }
                column(MRNPostingDate; FORMAT(MRNPostingDate))
                {
                }
                column(ActualMrnDate; FORMAT(ActualMrnDate))
                {
                }
                column(CurrentTime; FORMAT(DT2TIME(CURRENTDATETIME)))
                {
                }
                column(CurrentDate; TODAY)
                {
                }
                column(UserName; "Indent Header"."User ID")
                {
                }
                column(Status; FORMAT("Indent Line".Status))
                {
                }
                column(IndentStatus; IndentStatus)
                {
                }
                column(DocNo; "Document No.")
                {
                }
                column(IndentDate; "Indent Header"."Indent Date")
                {
                }
                column(dept_name; "Indent Header"."Dept Name")
                {
                }
                column(Created_By; "Indent Header"."Created By")
                {
                }
                column(DueDate; DueDate)
                {
                }
                column(Type; FORMAT(Type))
                {
                }
                column(ItemNo; "No.")
                {
                }
                column(DescrpTotal; Description + ' ,' + "Description 2")
                {
                }
                column(UOM; "Unit of Measurement")
                {
                }
                column(ItemCarDes; ItemCategory.Description)
                {
                }
                column(Location; "Location Code")
                {
                }
                column(OrderNo; "Order No.")
                {
                }
                column(Last_Order_no; lastorderno)
                {
                }
                column(Last_Order_dt; FORMAT(lastorderdt))
                {
                }
                column(PODT1; PODT1)
                {
                }
                column(OrderLineno; "Order Line No.")
                {
                }
                column(DOC; DOC)
                {
                }
                column(DOCDate; DOCDate)
                {
                }
                column(DOCDate1; DOCDate)
                {
                }
                column(Lcvqty; Lcvqty)
                {
                }
                column(rcvqty; rcvqty)
                {
                }
                column(Consumption; Consumption)
                {
                }
                column(CurrentYrConsum; CurrentYrConsum)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(POQty; POQty)
                {
                }
                column(POQtyMinusrcvqty; POQty - rcvqty)
                {
                }
                column(Rate; Rate)
                {
                }
                column(Amount; Amount)
                {
                }
                column(IndentHeaderAuthorizationDate; "Indent Header"."Authorization Date")
                {
                }
                column(IndentHeaderAuthorizationTime; FORMAT("Indent Header"."Authorization Time"))
                {
                }
                column(OrderDate1; "Indent Line"."Last Order No." + '  ' + FORMAT("Indent Line"."Last Order Date"))
                {
                }
                column(ValidityPeriod; "Indent Header"."Validity Period")
                {
                }
                column(VendorCode; VendorCode)
                {
                }
                column(Name; Name)
                {
                }
                column(VendorLocation; VendorLocation)
                {
                }
                column(IndentQtyMinusPoQty; "Indent Line".Quantity - POQty)
                {
                }
                column(AuthorisatonDays; AuthorisatonDays)
                {
                }
                column(AuthorisatonDays1; AuthorisatonDays1)
                {
                }
                column(AuthorisatonDays2; AuthorisatonDays2)
                {
                }
                column(AuthorisatonDays3; AuthorisatonDays3)
                {
                }
                column(IndentHeaderRemarks; "Indent Header".Remarks)
                {
                }
                column(ComText1; ComText1)
                {
                }
                column(ComText2; ComText2)
                {
                }
                column(ComText3; ComText3)
                {
                }
                column(ComText4; ComText4)
                {
                }
                column(ComText5; ComText5)
                {
                }
                column(ComText6; ComText6)
                {
                }
                column(DUEDATENEW; "Indent Line"."Due Date")
                {
                }
                column(PL_Amount; "Purchase Line".Amount)
                {
                }
                column(Lrate; "Indent Line".Lrate)
                {
                }
                column(PODT2; PODT2)
                {
                }
                column(vname; vname)
                {
                }
                column(LastMRNNo; LastMRNNo)
                {
                }
                column(LastMRNDate; FORMAT(LastMRNDate))
                {
                }
                column(ActualMRNDateNew; FORMAT(ActualMRNDateNew))
                {
                }
                column(LastRcptQty; LastRcptQty)
                {
                }
                column(Auth1; "Indent Header"."Authorization 1")
                {
                }
                column(Auth2; "Indent Header"."Authorization 1")
                {
                }
                column(Auth3; "Indent Header"."Authorization 3")
                {
                }
                column(Item_Category; itcd)
                {
                }
                dataitem("Purchase Line"; "Purchase Line")
                {
                    DataItemLink = "Document No." = FIELD("Order No."),
                                   "Line No." = FIELD("Order Line No.");
                    DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                        ORDER(Ascending);
                    dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
                    {
                        DataItemLink = "Order No." = FIELD("Document No."),
                                       "Order Line No." = FIELD("Line No.");
                        DataItemTableView = SORTING("Document No.", "Line No.")
                                            ORDER(Ascending)
                                            WHERE("Order No." = FILTER(<> ''),
                                                  Quantity = FILTER(<> 0));
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    //MSAK 080818
                    CLEAR(QtySum);
                    PurchaseLine.RESET;
                    PurchaseLine.SETCURRENTKEY("Indent No.", "No.");
                    PurchaseLine.SETRANGE("Indent No.", "Document No.");
                    PurchaseLine.SETRANGE("No.", "No.");
                    IF PurchaseLine.FINDFIRST THEN
                        REPEAT
                            QtySum += PurchaseLine.Quantity;
                        UNTIL PurchaseLine.NEXT = 0;

                    CLEAR(lastorderno);
                    CLEAR(lastorderdt);
                    PurchaseLine.RESET;
                    PurchaseLine.SETCURRENTKEY("Indent No.", "No.");
                    PurchaseLine.SETRANGE("Indent No.", "Document No.");
                    PurchaseLine.SETRANGE("No.", "No.");
                    IF PurchaseLine.FINDLAST THEN
                        REPEAT
                            lastorderno := PurchaseLine."Document No.";
                            lastorderdt := PurchaseLine."Order Date";
                        UNTIL PurchaseLine.NEXT = 0;


                    CLEAR(LastMRNDate);
                    CLEAR(LastMRNNo);
                    CLEAR(LastRcptQty);
                    CLEAR(ActualMRNDateNew);
                    PurchRcptLine.RESET;
                    PurchRcptLine.SETCURRENTKEY("Indent No.", "No.");
                    PurchRcptLine.SETRANGE("Indent No.", "Document No.");
                    PurchRcptLine.SETRANGE("No.", "No.");
                    IF PurchRcptLine.FINDLAST THEN BEGIN
                        LastMRNNo := PurchRcptLine."Document No.";
                        LastRcptQty := PurchRcptLine.Quantity;
                        LastMRNDate := PurchRcptLine."Posting Date";
                        IF PurchRcptHeader.GET(LastMRNNo) THEN
                            ActualMRNDateNew := PurchRcptHeader."Actual MRN Date";
                    END;
                    // MSAK 080818

                    //MS
                    CLEAR(MRNDocNo);
                    CLEAR(MRNPostingDate);
                    PurchRcptLineREC.RESET;
                    PurchRcptLineREC.SETRANGE(PurchRcptLineREC.Type, PurchRcptLineREC.Type::Item);
                    PurchRcptLineREC.SETRANGE(PurchRcptLineREC."Order No.", "Indent Line"."Order No.");
                    PurchRcptLineREC.SETRANGE(PurchRcptLineREC."Order Line No.", "Indent Line"."Order Line No.");
                    PurchRcptLineREC.SETRANGE(PurchRcptLineREC."No.", "Indent Line"."No.");
                    IF PurchRcptLineREC.FINDFIRST THEN
                        REPEAT
                            MRNDocNo := PurchRcptLineREC."Document No.";
                            MRNPostingDate := PurchRcptLineREC."Posting Date";
                            // MESSAGE('%1', MRNDocNo);
                            IF PurchRcptHeaderREC.GET(PurchRcptLineREC."Document No.") THEN
                                ActualMrnDate := PurchRcptHeaderREC."Actual MRN Date";

                        UNTIL PurchRcptLineREC.NEXT = 0;
                    //MS


                    ComText1 := '';
                    ComText2 := '';
                    ComText3 := '';
                    ComText4 := '';
                    ComText5 := '';
                    ComText6 := '';


                    RecComLine.RESET;
                    RecComLine.SETRANGE("Table Name", RecComLine."Table Name"::Item);
                    RecComLine.SETRANGE("No.", "No.");
                    IF RecComLine.FINDFIRST THEN
                        REPEAT
                            IF STRLEN(ComText1 + RecComLine.Comment) <= 250 THEN
                                ComText1 := ComText1 + RecComLine.Comment
                            ELSE
                                IF STRLEN(ComText2 + RecComLine.Comment) <= 250 THEN
                                    ComText2 := ComText2 + RecComLine.Comment
                                ELSE
                                    IF STRLEN(ComText3 + RecComLine.Comment) <= 250 THEN
                                        ComText3 := ComText3 + RecComLine.Comment
                                    ELSE
                                        IF STRLEN(ComText4 + RecComLine.Comment) <= 250 THEN
                                            ComText4 := ComText4 + RecComLine.Comment
                                        ELSE
                                            IF STRLEN(ComText5 + RecComLine.Comment) <= 250 THEN
                                                ComText5 := ComText5 + RecComLine.Comment
                                            ELSE
                                                IF STRLEN(ComText6 + RecComLine.Comment) <= 250 THEN
                                                    ComText6 := ComText6 + RecComLine.Comment;

                        UNTIL RecComLine.NEXT = 0;



                    POQty := 0;
                    PurchaseLine.RESET;
                    PurchaseLine.SETRANGE(PurchaseLine."Document No.", "Indent Line"."Order No.");
                    PurchaseLine.SETRANGE(PurchaseLine."Line No.", "Indent Line"."Order Line No.");
                    IF PurchaseLine.FINDSET THEN BEGIN
                        POQty := PurchaseLine.Quantity;
                        //MSAK 150914
                        RectQty := 0;
                        PurchRcptLine.RESET;
                        PurchRcptLine.SETRANGE("Order No.", PurchaseLine."Document No.");
                        PurchRcptLine.SETRANGE("Order Line No.", PurchaseLine."Line No.");
                        PurchRcptLine.SETFILTER(Quantity, '<>%1', 0);
                        IF PurchRcptLine.FINDFIRST THEN BEGIN
                            RectQty := PurchRcptLine.Quantity;
                            RectNo := PurchRcptLine."Document No.";
                            ReceivedDate := 0D;
                            PurchRcptHeader.RESET;
                            PurchRcptHeader.SETRANGE("No.", PurchRcptLine."Document No.");
                            IF PurchRcptHeader.FINDFIRST THEN BEGIN
                            END;
                        END;
                        //MSAK 150914
                    END;

                    Name := '';
                    VendorCode := '';
                    VendorLocation := '';
                    PoDate := 0D;
                    IF ItemCategory.GET("Indent Line"."Item Category Code") THEN
                        PurchHrd.RESET;
                    PurchHrd.SETRANGE(PurchHrd."No.", "Indent Line"."Order No.");
                    IF PurchHrd.FIND('-') THEN BEGIN
                        PoDate := PurchHrd."Document Date";
                        IF RecVen.GET(PurchHrd."Buy-from Vendor No.") THEN BEGIN
                            Name := RecVen.Name + ' ' + RecVen."Phone No.";
                            //MSAK 150914
                            VendorCode := RecVen."No.";
                            VendorLocation := RecVen."Vendor Location";
                            //MSAK 150914
                        END;
                    END;

                    IF "No." <> '' THEN BEGIN
                        Item.RESET;
                        Item.SETRANGE(Item."No.", "No.");
                        IF Item.FIND('-') THEN BEGIN
                            Item.CALCFIELDS(Item."Net Change");
                            Inventory := ABS(Item."Net Change");
                            Item.CALCFIELDS("Item Category Desc.");
                            itcd := Item."Item Category Desc."
                        END;

                        Consumption := 0;
                        ILE.RESET;
                        ILE.SETRANGE(ILE."Item No.", "No.");
                        ILE.SETFILTER(ILE."Entry Type", '%1', ILE."Entry Type"::Consumption);
                        ILE.SETRANGE(ILE."Posting Date", CALCDATE('-4M', "Indent Header".GETRANGEMIN("Indent Header"."Indent Date"))
                        , "Indent Header".GETRANGEMIN("Indent Header"."Indent Date"));

                        IF ILE.FIND('-') THEN
                            REPEAT
                                Consumption += ABS(ROUND(ILE.Quantity, 0.001, '='));
                            UNTIL ILE.NEXT = 0;
                    END;
                    //END;
                    //16225 table N/F Start
                    /*  IncomeTaxAccountPeriod.SETFILTER("Starting Date",'<%1',WORKDATE);
                      IncomeTaxAccountPeriod.SETFILTER("Ending Date",'>%1',WORKDATE);
                      IF IncomeTaxAccountPeriod.FINDLAST THEN BEGIN
                        StartDate:=IncomeTaxAccountPeriod."Starting Date";
                        EndDate:=IncomeTaxAccountPeriod."Ending Date";
                      END;*/////16225 table N/F End

                    CurrentYrConsum := 0;
                    ILE.RESET;
                    ILE.SETRANGE(ILE."Item No.", "No.");
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Consumption);
                    IF "Indent Line".Date <> 0D THEN BEGIN
                        ILE.SETRANGE(ILE."Posting Date", StartDate, EndDate);

                        IF ILE.FIND('-') THEN
                            REPEAT
                                CurrentYrConsum += ABS(ROUND(ILE.Quantity, 0.001, '='));
                            UNTIL ILE.NEXT = 0;
                    END;

                    rcvqty := 0;
                    Lcvqty := 0;
                    PurchRcptLine2.RESET;
                    PurchRcptLine2.SETRANGE("No.", "No.");
                    PurchRcptLine2.SETRANGE("Order No.", "Order No.");
                    PurchRcptLine2.SETFILTER(Quantity, '<>%1', 0);
                    IF PurchRcptLine2.FINDLAST THEN
                        Lcvqty := PurchRcptLine2.Quantity;

                    PurchRcptLine2.RESET;
                    PurchRcptLine2.SETRANGE("No.", "No.");
                    PurchRcptLine2.SETRANGE("Order No.", "Order No.");
                    PurchRcptLine2.SETFILTER(Quantity, '<>%1', 0);
                    IF PurchRcptLine2.FINDFIRST THEN BEGIN
                        REPEAT
                            rcvqty += PurchRcptLine2.Quantity;
                            PODT := PurchRcptLine2."Order Date";
                        UNTIL PurchRcptLine2.NEXT = 0;
                    END;

                    IF rcvqty <> 0 THEN BEGIN
                        DOC := PurchRcptLine2."Document No.";
                        DOCDate := PurchRcptLine2."Posting Date";
                    END;

                    PODT1 := 0D;
                    PODT2 := 0D;
                    PurchHrd.RESET;
                    PurchHrd.SETRANGE("No.", "Order No.");
                    IF PurchHrd.FIND('-') THEN BEGIN
                        PODT1 := PurchHrd."Order Date";
                        PODT2 := PurchHrd."Releasing Date";
                    END;

                    rrate := 0;
                    PurchaseLine.RESET;
                    PurchaseLine.SETRANGE("No.", "No.");
                    IF PurchaseLine.FINDLAST THEN
                        Lrate := PurchaseLine."Direct Unit Cost";
                    IF vendor.GET(PurchaseLine."Buy-from Vendor No.") THEN
                        vname := vendor.Name;

                    IF (Quantity <> 0) AND (POQty = 0) THEN
                        IndentStatus := 'Pending for PO Execution'
                    ELSE
                        IF (POQty <> "Indent Line".Quantity) AND (rcvqty = 0) THEN
                            IndentStatus := 'Partly Converted - Pending Execution'
                        ELSE
                            IF (POQty <> "Indent Line".Quantity) AND (rcvqty <> 0) THEN
                                IndentStatus := 'Partly Converted - Partly Executed'
                            ELSE
                                IF (POQty = "Indent Line".Quantity) AND (rcvqty = 0) THEN
                                    IndentStatus := 'Fully Converted - Pending Execution'
                                ELSE
                                    IF (POQty = "Indent Line".Quantity) AND (rcvqty <> POQty) THEN
                                        IndentStatus := 'Fully Converted - Partly Executed'
                                    ELSE
                                        IF (POQty = "Indent Line".Quantity) AND (rcvqty = POQty) THEN
                                            IndentStatus := 'Executed'
                                        ELSE
                                            IndentStatus := '';

                    IF ("Indent Header"."Authorization Date" <> 0D) AND ("Indent Header"."Indent Date" <> 0D) THEN BEGIN
                        AuthorisatonDays := "Indent Header"."Authorization Date" - "Indent Header"."Indent Date";
                    END;

                    AuthorisatonDays1 := 0;
                    IF (DOCDate <> 0D) AND ("Indent Header"."Authorization Date" <> 0D) THEN BEGIN
                        AuthorisatonDays1 := DOCDate - "Indent Header"."Authorization Date";
                    END;

                    IF DOCDate = 0D THEN
                        AuthorisatonDays2 := 0
                    ELSE
                        AuthorisatonDays2 := DOCDate - PODT;

                    IF "Indent Header"."Authorization Date" <> 0D THEN BEGIN
                        DueDate := CALCDATE("Indent Header"."Validity Period", "Indent Header"."Authorization Date");
                    END;

                    AuthorisatonDays3 := 0;
                    IF (DOCDate <> 0D) AND (DueDate <> 0D) THEN BEGIN
                        AuthorisatonDays3 := DOCDate - DueDate;
                    END;
                end;
            }

            trigger OnPreDataItem()
            begin

                RecUser.RESET;
                IF RecUser.GET(USERID) THEN;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        PurchaseLine: Record "Purchase Line";
        POQty: Decimal;
        ItemCategory: Record "Item Category";
        RecVen: Record Vendor;
        PurchHrd: Record "Purchase Header";
        k: Integer;
        PrintToExcel: Boolean;
        ExcelBuf: Record "Excel Buffer" temporary;
        Inventory: Decimal;
        Item: Record Item;
        ILE: Record "Item Ledger Entry";
        Consumption: Decimal;
        Date: Date;
        Name: Text[100];
        Date1: Date;
        CurrentYrConsum: Decimal;
        //16225 IncomeTaxAccountPeriod: Record 13724;
        StartDate: Date;
        EndDate: Date;
        AccountingPeriod: Record "Accounting Period";
        VendorCode: Code[20];
        VendorLocation: Code[20];
        IndentStatus: Text[50];
        PurchRcptLine: Record "Purch. Rcpt. Line";
        RectQty: Decimal;
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        ReceivedDate: Date;
        PoDate: Date;
        AuthorisatonDays: Integer;
        AuthorisatonDays1: Integer;
        AuthorisatonDays2: Integer;
        AuthorisatonDays3: Integer;
        DueDate: Date;
        RectNo: Code[20];
        rcvqty: Decimal;
        RecIndentLine: Record "Indent Line";
        PurchRcptLine2: Record "Purch. Rcpt. Line";
        DOC: Text[30];
        Lcvqty: Decimal;
        DOCDate: Date;
        PODT: Date;
        PODT1: Date;
        RecComLine: Record "Comment Line";
        ComText1: Text[250];
        ComText2: Text[250];
        ComText3: Text[250];
        ComText4: Text[250];
        ComText5: Text[250];
        ComText6: Text[250];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        DOCDate1: Date;
        RecUser: Record "User Setup";
        PODT2: Date;
        vname: Text[100];
        rrate: Decimal;
        vendor: Record Vendor;
        PurchRcptLineREC: Record "Purch. Rcpt. Line";
        MRNDocNo: Code[30];
        MRNPostingDate: Date;
        PurchRcptHeaderREC: Record "Purch. Rcpt. Header";
        ActualMrnDate: Date;
        QtySum: Decimal;
        LastMRNNo: Code[20];
        LastMRNDate: Date;
        ActualMRNDateNew: Date;
        LastRcptQty: Decimal;
        lastorderno: Code[20];
        lastorderdt: Date;
        itcd: Text[100];
}

