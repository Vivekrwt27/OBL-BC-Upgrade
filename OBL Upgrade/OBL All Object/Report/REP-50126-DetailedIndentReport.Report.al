report 50126 "Detailed Indent Report"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Indent Line"; 50017)
        {
            RequestFilterFields = "Location Code", Date, Status, "Document No.";

            trigger OnAfterGetRecord()
            begin
                IF "Indent Line"."No." = '' THEN
                    CurrReport.SKIP;

                rLocation.RESET;
                rLocation.GET("Indent Line"."Location Code");
                txtLocation := rLocation.Code;
                txtstatus := FORMAT("Indent Line".Status);

                txtOrdinglvl := '';
                txtOrdExeclvl := '';
                txtItemTyp := '';
                txtUserName := '';
                cdUOM := '';
                decIndentQty := 0;
                dtDueDt := 0D;


                IF "Indent Line".Status <> "Indent Line".Status::Open THEN BEGIN
                    "Indent Line".CALCFIELDS("PO Qty", "Received Qty");
                    IF "Indent Line"."PO Qty" <> 0 THEN BEGIN
                        IF "Indent Line"."Received Qty" = 0 THEN
                            txtOrdExeclvl := ''
                        ELSE
                            IF "Indent Line"."Received Qty" <> 0 THEN
                                IF "Indent Line".Quantity = "Indent Line"."Received Qty" THEN
                                    txtOrdExeclvl := 'Fully Executed'
                                ELSE
                                    txtOrdExeclvl := 'Partially Executed';
                    END;

                    "Indent Line".CALCFIELDS("PO Qty");
                    IF ("Indent Line"."PO Qty" <> 0) AND ("Indent Line".Quantity <> "Indent Line"."PO Qty") THEN BEGIN
                        txtOrdinglvl := 'Partial Ordered';
                    END ELSE
                        IF "Indent Line"."PO Qty" = 0 THEN BEGIN
                            txtOrdinglvl := 'Pending for Ordering';
                        END ELSE
                            IF "Indent Line".Quantity = "Indent Line"."PO Qty" THEN BEGIN
                                txtOrdinglvl := 'Fully Ordered';
                            END;
                END;

                rItem.RESET;
                rItem.GET("Indent Line"."No.");
                IF rItem."Inventory Value Zero" = TRUE THEN BEGIN
                    txtItemTyp := 'Non Stock Item';
                END ELSE BEGIN
                    txtItemTyp := 'Stock Item';
                END;

                rIndentHdr.RESET;
                rIndentHdr.SETRANGE("No.", "Indent Line"."Document No.");
                IF rIndentHdr.FIND('-') THEN BEGIN
                    rUsers.RESET;
                    rUsers.SETRANGE("User Name", rIndentHdr."User ID");
                    IF rUsers.FIND('-') THEN
                        txtUserName := rUsers."Full Name";
                END;

                cdIndentNo := "Indent Line"."Document No.";
                dtIndentDt := "Indent Line".Date;
                IF ("Indent Line".Status = "Indent Line".Status::Authorization1) THEN BEGIN
                    dtAuthDt := rIndentHdr."Authorization 1 Date";
                END ELSE
                    IF ("Indent Line".Status = "Indent Line".Status::Authorization2) THEN BEGIN
                        dtAuthDt := rIndentHdr."Authorization 2 Date";
                    END ELSE
                        IF ("Indent Line".Status = "Indent Line".Status::Authorization3) THEN BEGIN
                            dtAuthDt := rIndentHdr."Authorization 3 Date";
                        END ELSE
                            IF ("Indent Line".Status = "Indent Line".Status::Authorized) THEN BEGIN
                                dtAuthDt := rIndentHdr."Authorization Date";
                            END ELSE
                                IF ("Indent Line".Status = "Indent Line".Status::Closed) THEN BEGIN
                                    dtAuthDt := rIndentHdr."Authorization Date";
                                END ELSE BEGIN
                                    dtAuthDt := 0D;
                                END;

                cdItem := "Indent Line"."No.";
                txtItemDes1 := "Indent Line".Description;
                txtItemDes2 := "Indent Line"."Description 2";
                cdUOM := "Indent Line"."Unit of Measurement";
                decIndentQty := "Indent Line".Quantity;
                dtLeadDt := rIndentHdr."Validity Period";

                IF dtAuthDt <> 0D THEN
                    dtDueDt := CALCDATE(rIndentHdr."Validity Period", dtAuthDt)
                ELSE
                    dtDueDt := 0D;

                recPurchLn.RESET;
                recPurchLn.SETRANGE("Indent No.", "Indent Line"."Document No.");
                recPurchLn.SETFILTER("Document Type", '%1', recPurchLn."Document Type"::Order);  //Rk08062021
                recPurchLn.SETRANGE("Indent Line No.", "Indent Line"."Line No.");
                recPurchLn.SETRANGE("Location Code", "Indent Line"."Location Code");
                recPurchLn.SETRANGE("No.", "Indent Line"."No.");
                IF recPurchLn.FIND('+') THEN BEGIN
                    recPurchHdr.RESET;
                    recPurchHdr.SETRANGE("No.", recPurchLn."Document No.");
                    recPurchHdr.FIND('+');

                    dtLstPurchOrdReleaseDt := recPurchHdr."Releasing Date";
                    cdLstPurchOrdVndCd := recPurchHdr."Buy-from Vendor No.";
                    txtLstPurchOrdVndNm := recPurchHdr."Buy-from Vendor Name";

                    cdLstPurchOrdNo := recPurchLn."Document No.";
                    dtLstPurchOrddt := recPurchLn."Order Date";
                    decLstPurchOrdQty := recPurchLn.Quantity;
                    decLstPurchOrdRate := recPurchLn."Unit Cost";
                    decLstPurchOrdTotVal := recPurchLn."Line Amount";
                END ELSE BEGIN
                    cdLstPurchOrdNo := '';
                    dtLstPurchOrddt := 0D;
                    dtLstPurchOrdReleaseDt := 0D;
                    decLstPurchOrdQty := 0;
                    decLstPurchOrdRate := 0;
                    decLstPurchOrdTotVal := 0;
                    cdLstPurchOrdVndCd := '';
                    txtLstPurchOrdVndNm := '';
                END;

                recPurchLn.RESET;
                recPurchLn.SETRANGE("Indent No.", "Indent Line"."Document No.");
                recPurchLn.SETRANGE("Indent Line No.", "Indent Line"."Line No.");
                recPurchLn.SETRANGE("No.", "Indent Line"."No.");
                recPurchLn.SETRANGE("Location Code", "Indent Line"."Location Code");
                IF recPurchLn.FIND('-') THEN BEGIN
                    intNoOfPurchOrd := recPurchLn.COUNT;
                END ELSE BEGIN
                    intNoOfPurchOrd := 0;
                END;

                decTotPurchQnty := 0;
                recPurchLn.RESET;
                recPurchLn.SETRANGE("Indent No.", "Indent Line"."Document No.");
                recPurchLn.SETRANGE("Indent Line No.", "Indent Line"."Line No.");
                recPurchLn.SETRANGE("Location Code", "Indent Line"."Location Code");
                recPurchLn.SETRANGE("No.", "Indent Line"."No.");
                IF recPurchLn.FIND('-') THEN BEGIN
                    REPEAT
                        recPurchHdr.RESET;
                        recPurchHdr.SETRANGE("No.", recPurchLn."Document No.");
                        recPurchHdr.FIND('-');

                        decTotPurchQnty += recPurchLn.Quantity;
                    UNTIL recPurchLn.NEXT = 0;
                END ELSE BEGIN
                    decTotPurchQnty := 0;
                END;

                CLEAR(dtLstGateEntrDt);
                CLEAR(dtLstMRNDt);
                recPurchRcptLn.RESET;
                recPurchRcptLn.SETFILTER("Indent No.", '<>%1', '');
                recPurchRcptLn.SETRANGE("Indent No.", "Indent Line"."Document No.");
                recPurchRcptLn.SETRANGE("Indent Line No.", "Indent Line"."Line No.");
                recPurchRcptLn.SETRANGE("No.", "Indent Line"."No.");
                recPurchRcptLn.SETRANGE("Location Code", "Indent Line"."Location Code");
                IF recPurchRcptLn.FIND('+') THEN BEGIN
                    cdLstMRNNo := recPurchRcptLn."Document No.";  //2302
                    decLstMRNQty := recPurchRcptLn.Quantity;  //2302

                    recPurchRcptHdr.RESET;
                    recPurchRcptHdr.SETRANGE("No.", recPurchRcptLn."Document No.");
                    IF recPurchRcptHdr.FINDFIRST THEN BEGIN
                        //recPurchRcptLn.FIND('+');
                        cdLstGateEntrNo := recPurchRcptHdr."GE No.";
                        dtLstGateEntrDt := recPurchRcptHdr."GE Date";
                        dtLstMRNDt := recPurchRcptHdr."Posting Date";
                    END;
                    //cdLstMRNNo := recPurchRcptLn."Document No.";
                    //decLstMRNQty := recPurchRcptLn.Quantity;

                END ELSE BEGIN
                    cdLstMRNNo := '';
                    cdLstGateEntrNo := '';
                    dtLstGateEntrDt := 0D;
                    dtLstMRNDt := 0D;
                    decLstMRNQty := 0;
                END;

                intNoOfMRN := 0;
                recPurchRcptLn.RESET;
                recPurchRcptLn.SETRANGE("Indent No.", "Indent Line"."Document No.");
                recPurchRcptLn.SETRANGE("Indent Line No.", "Indent Line"."Line No.");
                recPurchRcptLn.SETRANGE("No.", "Indent Line"."No.");
                recPurchRcptLn.SETRANGE("Location Code", "Indent Line"."Location Code");
                IF recPurchRcptLn.FIND('-') THEN BEGIN
                    recPurchRcptHdr.RESET;
                    recPurchRcptHdr.SETRANGE("No.", recPurchRcptLn."Document No.");
                    recPurchRcptLn.FIND('-');

                    intNoOfMRN := recPurchRcptLn.COUNT;

                END ELSE BEGIN
                    intNoOfMRN := 0;
                END;

                decTotMRNQty := 0;
                recPurchRcptLn.RESET;
                recPurchRcptLn.SETRANGE("Indent No.", "Indent Line"."Document No.");
                recPurchRcptLn.SETRANGE("Indent Line No.", "Indent Line"."Line No.");
                recPurchRcptLn.SETRANGE("No.", "Indent Line"."No.");
                recPurchRcptLn.SETRANGE("Location Code", "Indent Line"."Location Code");
                IF recPurchRcptLn.FIND('-') THEN BEGIN
                    REPEAT
                        recPurchRcptHdr.RESET;
                        recPurchRcptHdr.SETRANGE("No.", recPurchRcptLn."Document No.");
                        recPurchRcptHdr.FIND('-');
                        decTotMRNQty += recPurchRcptLn.Quantity;
                    UNTIL recPurchRcptLn.NEXT = 0;
                END ELSE BEGIN
                    decTotMRNQty := 0;
                END;

                //Rk0903>>>>
                CLEAR(SkdPrice1);
                CLEAR(DRAPrice1);
                CLEAR(HSKPrice1);
                PurchInvLine.RESET;
                PurchInvLine.SETCURRENTKEY("No.", "Posting Date");
                PurchInvLine.SETRANGE(Type, PurchInvLine.Type::Item);
                //PurchInvLine.SETFILTER("Location Code",'%1','SKD-STORE');
                //PurchInvLine.SETFILTER("Location Code",'%1','DRA-STORE');
                //PurchInvLine.SETFILTER("Location Code",'%1','HSK-STORE');
                PurchInvLine.SETFILTER("No.", "Indent Line"."No.");
                IF PurchInvLine.FINDLAST THEN BEGIN
                    IF PurchInvLine."Location Code" = 'SKD-STORE' THEN
                        SkdPrice1 := PurchInvLine."Direct Unit Cost"
                    ELSE
                        SkdPrice1 := 0;

                    IF PurchInvLine."Location Code" = 'DRA-STORE' THEN
                        DRAPrice1 := PurchInvLine."Direct Unit Cost"
                    ELSE
                        DRAPrice1 := 0;

                    IF PurchInvLine."Location Code" = 'HSK-STORE' THEN
                        HSKPrice1 := PurchInvLine."Direct Unit Cost"
                    ELSE
                        HSKPrice1 := 0;
                END;
                //Rk0903<<<>

                "Indent Line".CALCFIELDS("PO Qty");
                decPendingIndntQty := "Indent Line".Quantity - "Indent Line"."PO Qty";

                decPendingOrdQty := decTotPurchQnty - decTotMRNQty;

                IF (dtAuthDt <> 0D) AND (dtIndentDt <> 0D) THEN
                    intTimeToAuth := dtAuthDt - dtIndentDt
                ELSE
                    intTimeToAuth := 0;

                IF (dtLstPurchOrddt <> 0D) AND (dtAuthDt <> 0D) THEN
                    intPORaseTime := dtLstPurchOrddt - dtAuthDt
                //intPORaseTime := dtAuthDt - dtLstPurchOrddt
                ELSE
                    intPORaseTime := 0;

                IF (dtLstMRNDt <> 0D) AND (dtAuthDt <> 0D) THEN
                    intMRNnAuthdt := dtLstMRNDt - dtAuthDt
                ELSE
                    intMRNnAuthdt := 0;

                // IF (dtLstMRNDt <> 0D) AND (dtLstPurchOrddt <> 0D) THEN
                //  intMRNnPOdt := dtLstMRNDt - dtLstPurchOrddt
                // ELSE
                //  intMRNnPOdt := 0;

                IF (dtAuthDt <> 0D) AND (dtLstPurchOrddt <> 0D) THEN
                    intMRNnPOdt := dtAuthDt - dtLstPurchOrddt
                ELSE
                    intMRNnPOdt := 0;

                IF (dtLstMRNDt <> 0D) AND (dtLstPurchOrdReleaseDt <> 0D) THEN
                    //intIndntDuedtMRNDt := dtLstMRNDt - dtDueDt
                    intIndntDuedtMRNDt := dtLstMRNDt - dtLstPurchOrdReleaseDt
                ELSE
                    intIndntDuedtMRNDt := 0;

                ExcelLine;
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

    trigger OnPostReport()
    begin
        //ExcelBuffer.OpenExcel();
        // ExcelBuffer.CreateBookAndOpenExcel('Indent Details', 'Details', 'Indent Details Report', COMPANYNAME, USERID);

        ExcelBuffer.CreateNewBook('Detailed Indent Report');
        ExcelBuffer.WriteSheet('Detailed Indent Report', CompanyName, UserId);
        ExcelBuffer.CloseBook;
        ExcelBuffer.SetFriendlyFilename(StrSubstNo('Detailed Indent Report', CurrentDateTime, UserId));
        ExcelBuffer.OpenExcel;
    end;

    trigger OnPreReport()
    begin

        ExcelHeader;
    end;

    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        rLocation: Record Location;
        txtLocation: Text;
        txtstatus: Text;
        txtOrdinglvl: Text;
        txtOrdExeclvl: Text;
        decIndPoQty: Decimal;
        rItem: Record Item;
        txtItemTyp: Text;
        txtUserName: Text;
        cdUserID: Code[50];
        rUsers: Record User;
        rIndentHdr: Record "Indent Header";
        cdIndentNo: Code[20];
        dtIndentDt: Date;
        dtAuthDt: Date;
        cdItem: Code[20];
        txtItemDes1: Text;
        txtItemDes2: Text;
        txtItemDesComm: Text;
        cdUOM: Code[20];
        decIndentQty: Decimal;
        dtLeadDt: DateFormula;
        dtDueDt: Date;
        recPurchHdr: Record "Purchase Header";
        recPurchLn: Record "Purchase Line";
        cdLstPurchOrdNo: Code[20];
        dtLstPurchOrddt: Date;
        dtLstPurchOrdReleaseDt: Date;
        decLstPurchOrdQty: Decimal;
        cdLstPurchOrdVndCd: Code[20];
        txtLstPurchOrdVndNm: Text;
        decLstPurchOrdRate: Decimal;
        decLstPurchOrdTotVal: Decimal;
        intNoOfPurchOrd: Integer;
        decTotPurchQnty: Decimal;
        recPurchRcptHdr: Record "Purch. Rcpt. Header";
        recPurchRcptLn: Record "Purch. Rcpt. Line";
        cdLstMRNNo: Code[20];
        cdLstGateEntrNo: Code[20];
        dtLstGateEntrDt: Date;
        dtLstMRNDt: Date;
        decLstMRNQty: Decimal;
        intNoOfMRN: Integer;
        decTotMRNQty: Decimal;
        decPendingIndntQty: Decimal;
        decPendingOrdQty: Decimal;
        intTimeToAuth: Integer;
        intPORaseTime: Integer;
        intMRNnAuthdt: Integer;
        intIndntDuedtMRNDt: Integer;
        intMRNnPOdt: Integer;
        IndentHeader: Record "Indent Header";
        skdlpdate: Date;
        hsklpdate: Date;
        dralpdate: Date;
        PurchInvLine: Record "Purch. Inv. Line";
        HSKPrice1: Decimal;
        DRAPrice1: Decimal;
        SkdPrice1: Decimal;

    local procedure ExcelHeader()
    begin
        ExcelBuffer.AddColumn(' Indent Details Report ', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Plant Location', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Indent Authorization Level', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Indent Ordering Level', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Order Execution Level', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Item Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('User Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn('User ID',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Indent No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Indent Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Authorisation Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Item Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Item Description 1', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Item Description 2', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn('Item Description Comments',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('UoM', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Indent Quantity', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Lead Time', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Due Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Last Purchase Order No for this Indent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Last Purchase Order Creation Date for This Indent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Last Purchase Order Release Date for This Indent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Last Purchase Order Qty for This Indent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Supplier Code of the Last Purchase Order for This Indent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Supplier Name of the Last Purchase Order for This Indent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Last Purchase Order Unit Rate for This Indent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Last Purchase Order Total Value for This Indent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total No. of Purchase Orders for This Indent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total Purchase Order Qty for This Indent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Last MRN No. for This Indent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Last MRN Gate Entry No. for This Indent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Last MRN Gate Entry Date for This Indent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Last MRN Date for This Indent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Last MRN Qty for This Indent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total No. of MRN for This Indent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total MRN Qty for This Indent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Quantity Pending for Convertion to Purchase Order', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Ordered Qty Pending for Execution', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Time Taken for Indent Authorisation', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Time Taken for Ordering w.r.t Indent Authorisation Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Time Taken for Execution w.r.t. Indent Authorisation Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Time Taken for Execution w.r.t. Purchase Order Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Time Taken for Execution w.r.t. Due Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('SKD Last Price', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('DRA Last Price', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('HSK Last Price', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    end;

    local procedure ExcelLine()
    begin
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn(txtLocation, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(txtstatus, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(txtOrdinglvl, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(txtOrdExeclvl, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(txtItemTyp, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(txtUserName, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn(cdUserID,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(cdIndentNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(dtIndentDt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn(dtAuthDt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn(cdItem, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(txtItemDes1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(txtItemDes2, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn(txtItemDesComm,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(cdUOM, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(decIndentQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(dtLeadDt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(dtDueDt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(cdLstPurchOrdNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(dtLstPurchOrddt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn(dtLstPurchOrdReleaseDt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn(decLstPurchOrdQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(cdLstPurchOrdVndCd, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(txtLstPurchOrdVndNm, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(decLstPurchOrdRate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(decLstPurchOrdTotVal, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(intNoOfPurchOrd, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(decTotPurchQnty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(cdLstMRNNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(cdLstGateEntrNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(dtLstGateEntrDt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);  //2302
        ExcelBuffer.AddColumn(dtLstMRNDt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);  //2302
        ExcelBuffer.AddColumn(decLstMRNQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(intNoOfMRN, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(decTotMRNQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(decPendingIndntQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(decPendingOrdQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(intTimeToAuth, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(intPORaseTime, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(intMRNnAuthdt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(intIndntDuedtMRNDt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(intMRNnPOdt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(SkdPrice1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DRAPrice1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(HSKPrice1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);

        //  ExcelBuffer.AddColumn(intPORaseTime,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
    end;
}