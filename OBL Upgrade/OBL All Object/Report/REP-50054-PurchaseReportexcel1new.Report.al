report 50054 "Purchase Reportexcel1new"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\PurchaseReportexcel1new.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Ledger Entry"; 32)
        {
            DataItemTableView = SORTING("Entry No.")
                                WHERE("Entry Type" = FILTER(Purchase),
                                      Quantity = FILTER(> 0));
            RequestFilterFields = "Posting Date", "Item No.", "Inventory Posting Group", "Document No.", "Entry No.";
            column(Filters; Filters)
            {
            }
            column(row1; "Item Ledger Entry"."Posting Date")
            {
            }
            column(row2; RecPurchRcptHdr."Actual MRN Date")
            {
            }
            column(row3; "Item Ledger Entry"."Document No.")
            {
            }
            column(row4; "Item Ledger Entry"."Source No.")
            {
            }
            column(Row5; RecVend.Name)
            {
            }
            column(Row6; RecVend."Vendor Posting Group")
            {
            }
            column(Row7; RecValueEntry."Document No.")
            {
            }
            column(row8; RecPurchInvhead."Vendor Invoice No.")
            {
            }
            column(row9; RecPurchInvhead."Vendor Invoice Date")
            {
            }
            column(row10; RecVend."State Code")
            {
            }
            column(row11; RecPurchRcptHdr1."Order No.")
            {
            }
            column(row12; RecPurchRcptHdr."Order Date")
            {
            }
            column(row13; "Item No.")
            {
            }
            column(row14; RecItem.Description)
            {
            }
            column(row15; RecItem."Description 2")
            {
            }
            column(row16; RecItem."Item Category Code")
            {
            }
            column(row17; StockAsOnReportDate)
            {
            }
            column(row18; Avgconsumption)
            {
            }
            column(row19; "Unit of Measure Code")
            {
            }
            column(row20; Quantity)
            {
            }
            column(QtySqm; "Item Ledger Entry"."Qty in Sq.Mt.")
            {
            }
            column(row21; BasicRate)
            {
            }
            column(row22; BasicAmt)
            {
            }
            column(row23; ExciseCenv)
            {
            }
            column(row24; ExciseNonCenv)
            {
            }
            column(row25; CSTAmt)
            {
            }
            column(row26; VATAmt)
            {
            }
            column(row27; Charges)
            {
            }
            column(row28; BillAmt)
            {
            }
            column(row29; Transportvalue)
            {
            }
            column(row30; UnloadingCharges)
            {
            }
            column(row31; DebitRefNo)
            {
            }
            column(row32; DebitQty)
            {
            }
            column(row33; DebitAmt)
            {
            }
            column(row34; UnitCostOnReportDate)
            {
            }
            column(row35; AverageCostLCY)
            {
            }
            column(row36; ImportInsurance)
            {
            }
            column(row37; ImportOceanFrt)
            {
            }
            column(row38; ImportCIF)
            {
            }
            column(row39; "ImportCVD&SAD")
            {
            }
            column(row40; "ImportCVD&SADTRD")
            {
            }
            column(row41; "ImportC&F")
            {
            }
            column(row42; RecPurchRcptHdr."Pay-to Contact")
            {
            }
            column(row43; '') // 16630 blank RecPurchInvhead.Form Code
            {
            }
            column(row44; RecPurchInvhead."Posting Date")
            {
            }
            column(row45; AccQty)
            {
            }
            column(row46; RecItem."Inventory Posting Group")
            {
            }
            column(row47; ChQty)
            {
            }
            column(row48; ActQty)
            {
            }
            column(row49; RejQty)
            {
            }
            column(row50; ShtQty)
            {
            }
            column(row51; Landedcost)
            {
            }
            column(row52; Landedcostperunit)
            {
            }
            column(row53; Landedcost + Transportvalue)
            {
            }
            column(row54; Landedcostperunit1)
            {
            }
            column(row55; QtyasperUOM)
            {
            }
            column(row56; '') // 16630 blank "Item Ledger Entry".product group code
            {
            }
            column(row57; RecPurchRcptHdr."Document Date")
            {
            }
            column(row58; FORMAT(DATE2DMY("Posting Date", 2)))
            {
            }
            column(row59; FORMAT(DATE2DMY("Posting Date", 3)))
            {
            }
            column(row60; "Location Code")
            {
            }
            column(Truck_no; truckno)
            {
            }
            column(Tpt_name; TPNAME)
            {
            }
            column(gr_no; GrNo)
            {
            }
            column(gross_wt; gweight)
            {
            }
            column(GSTAmount; GSTAmount)
            {
            }
            column(GSTPer; GSTPer)
            {
            }
            column(RateDiffAmount; RateDiffAmount)
            {
            }
            column(user_id; USER_ID)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //
                "Item Ledger Entry".CALCFIELDS("Item Ledger Entry"."Invoice No.");

                "Item Ledger Entry".CALCFIELDS("Inventory Posting Group");
                IF InvPostingFilter <> '' THEN
                    IF "Item Ledger Entry"."Inventory Posting Group" <> InvPostingFilter THEN
                        CurrReport.SKIP;


                j += 1;
                AccQty := 0;
                InsuranceValue := 0;
                FreightValue := 0;
                Transportvalue := 0;
                PackingValue := 0;
                ExciseCenv := 0;
                ExciseNonCenv := 0;
                ImportFOB := 0;
                ImportInsurance := 0;
                ImportInsuranceTRD := 0;
                ImportOceanFrt := 0;
                ImportOceanFrtTRD := 0;
                ImportCIF := 0;
                ImportInland := 0;
                "ImportCVD&SAD" := 0;
                "ImportCVD&SADTRD" := 0;
                ImportAntidumping := 0;
                ImportSafeguardDuty := 0;
                ImportOthers := 0;
                "ImportC&F" := 0;
                "ImportC&FTRD" := 0;
                ImortFinance := 0;
                ImportOtherNonRecu := 0;
                UnloadingCharges := 0;
                DebitRefNo := '';
                DebitQty := 0;
                DebitAmt := 0;
                Landedcost := 0;
                Landedcostperunit := 0;
                BasicRate := 0;
                BasicAmt := 0;
                BillAmt := 0;
                TaxAmt := 0;
                Charges := 0;
                VATAmt := 0;
                CSTAmt := 0;
                decQty := 0;
                decTotQty := 0;
                ActQty := 0;
                ChQty := 0;
                RejQty := 0;
                ShtQty := 0;
                QtyasperUOM := 0;
                IGSTAmt := 0;
                IGSTper := 0;
                SGSTAmt := 0;
                SGSTper := 0;
                CGSTAmt := 0;
                CGSTper := 0;
                GSTBaseAmt := 0;
                TotalAmount := 0;

                StockAsOnReportDate := 0;
                Avgconsumption := 0;
                CLEAR(GSTAmount);
                CLEAR(GSTPer);

                //win.UPDATE(1,ROUND(j/i*10000,1));
                IF RecItem.GET("Item No.") THEN BEGIN
                    UnitCostOnReportDate := RecItem."Unit Cost";
                    ItemCostMgt.CalculateAverageCost(RecItem, AverageCostLCY, AverageCostACY);
                END;
                RecValueEntry.RESET;
                RecValueEntry.SETCURRENTKEY("Item Ledger Entry Type", "Item Ledger Entry No.", "Item Charge No.");
                RecValueEntry.SETRANGE("Item Ledger Entry Type", RecValueEntry."Item Ledger Entry Type"::Purchase);
                RecValueEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                RecValueEntry.SETRANGE("Item Charge No.", '');
                RecValueEntry.SETFILTER("Invoiced Quantity", '<>%1', 0);
                IF RecValueEntry.FIND('-') THEN BEGIN
                    RecPurchInvLine.RESET;
                    RecPurchInvLine.SETRANGE("Document No.", RecValueEntry."Document No.");
                    IF RecPurchInvLine.FIND('-') THEN BEGIN
                        REPEAT
                            //IF (AgnstRcpt =TRUE) AND (RecPurchInvLine."No."="Item Ledger Entry"."Item No.") AND (RecPurchInvLine."Line No." =(RecValueEntry."Document Line No.")) THEN BEGIN      //sash 'Last And condition introduced
                            IF (RecPurchInvLine."No." = "Item Ledger Entry"."Item No.") AND (RecPurchInvLine."Line No." = (RecValueEntry."Document Line No.")) THEN BEGIN      //sash 'Last And condition introduced //MS310718
                                                                                                                                                                               //MS030818
                                DetailedGSTLedgerEntryREC.RESET;
                                DetailedGSTLedgerEntryREC.SETRANGE(DetailedGSTLedgerEntryREC."Entry Type", DetailedGSTLedgerEntryREC."Entry Type"::"Initial Entry");
                                DetailedGSTLedgerEntryREC.SETRANGE(DetailedGSTLedgerEntryREC."Transaction Type", DetailedGSTLedgerEntryREC."Transaction Type"::Purchase);
                                DetailedGSTLedgerEntryREC.SETRANGE(DetailedGSTLedgerEntryREC.Type, DetailedGSTLedgerEntryREC.Type::Item);
                                DetailedGSTLedgerEntryREC.SETRANGE("Document No.", RecValueEntry."Document No.");
                                DetailedGSTLedgerEntryREC.SETRANGE("Document Line No.", RecValueEntry."Document Line No.");
                                IF DetailedGSTLedgerEntryREC.FINDFIRST THEN
                                    REPEAT
                                        GSTPer += DetailedGSTLedgerEntryREC."GST %";
                                        GSTAmount += DetailedGSTLedgerEntryREC."GST Amount";
                                    UNTIL DetailedGSTLedgerEntryREC.NEXT = 0;
                                //MS030818




                                decQty := RecPurchInvLine.Quantity;
                                IF RecPurchInvLine."Direct Unit Cost" >= 0 THEN
                                    BasicRate := RecPurchInvLine."Direct Unit Cost";
                                //MESSAGE('%1', BasicRate);
                                BasicAmt := RecPurchInvLine.Amount;
                                // 16630 TaxAmt := RecPurchInvLine."Tax Amount";
                                //TRI SC 17.05.10 START
                                /* 16630 DetailTaxBuffer.RESET;
                                 DetailTaxBuffer.SETRANGE("Document No.", RecPurchInvLine."Document No.");
                                 IF DetailTaxBuffer."Tax Type" = DetailTaxBuffer."Tax Type"::VAT THEN
                                     REPEAT
                                         IF NOT DetailTaxBuffer."Additional Tax" THEN
                                             VATAmt := VATAmount + (-DetailTaxBuffer."Tax Amount");
                                     UNTIL DetailTaxBuffer.NEXT = 0;*/ //16630
                                IF VATAmt = 0 THEN
                                    CSTAmt := TaxAmt
                                ELSE
                                    CSTAmt := 0;
                                //TRI SC 17.05.10 STOP
                                IF RecVend.GET(RecPurchInvLine."Buy-from Vendor No.") THEN;
                                IF RecItem.GET(RecPurchInvLine."No.") THEN BEGIN
                                    /* 16630 IF (RecItem."Excise Accounting Type" = RecItem."Excise Accounting Type"::"With CENVAT") THEN
                                         ExciseCenv := RecPurchInvLine."Excise Amount";
                                     IF (RecItem."Excise Accounting Type" = RecItem."Excise Accounting Type"::"Without CENVAT") THEN
                                         ExciseNonCenv := RecPurchInvLine."Excise Amount";*/ //16630
                                END;
                            END;
                            IF RecPurchInvLine."No." = '' THEN BEGIN
                                varlen := (STRLEN(RecPurchInvLine.Description) - 12);
                                IF varlen > 0 THEN
                                    Rcptno := COPYSTR(RecPurchInvLine.Description, 12, varlen);
                            END;
                            IF Rcptno = "Item Ledger Entry"."Document No." THEN
                                AgnstRcpt := TRUE
                            ELSE
                                AgnstRcpt := FALSE;
                            decTotQty += RecPurchInvLine.Quantity;
                        UNTIL RecPurchInvLine.NEXT = 0;
                    END;
                END
                //TRI DG Start
                ELSE BEGIN
                    RecPurchRcptLine.RESET;
                    RecPurchRcptLine.SETRANGE("Document No.", "Document No.");
                    RecPurchRcptLine.SETRANGE("No.", "Item Ledger Entry"."Item No.");
                    RecPurchRcptLine.SETFILTER("Line No.", '%1', "Item Ledger Entry"."Document Line No.");      //sash
                    IF RecPurchRcptLine.FIND('-') THEN
                        REPEAT

                            BasicRate := RecPurchRcptLine."Direct Unit Cost";
                            //MESSAGE('%1', BasicRate);
                            BasicAmt := RecPurchRcptLine.Quantity * RecPurchRcptLine."Direct Unit Cost";
                            IF RecVend.GET(RecPurchRcptLine."Buy-from Vendor No.") THEN;
                            //TRI SC 17.05.10 START
                            /* 16630 DetailTaxBuffer.RESET;
                            DetailTaxBuffer.SETRANGE("Document No.", RecPurchInvLine."Document No.");
                            IF DetailTaxBuffer."Tax Type" = DetailTaxBuffer."Tax Type"::VAT THEN
                                REPEAT
                                    IF NOT DetailTaxBuffer."Additional Tax" THEN
                                        VATAmt := VATAmount + (-DetailTaxBuffer."Tax Amount");
                                UNTIL DetailTaxBuffer.NEXT = 0;*/ // 16630
                            IF VATAmt = 0 THEN
                                CSTAmt := TaxAmt
                            ELSE
                                CSTAmt := 0;
                        //TRI SC 17.05.10 STOP
                        /* 16630 IF RecItem.GET(RecPurchRcptLine."No.") THEN BEGIN
                             IF (RecItem."Excise Accounting Type" = RecItem."Excise Accounting Type"::"With CENVAT") THEN
                                 ExciseCenv := "Item Ledger Entry"."BED Amount";
                             IF (RecItem."Excise Accounting Type" = RecItem."Excise Accounting Type"::"Without CENVAT") THEN
                                 ExciseNonCenv := "Item Ledger Entry"."BED Amount";
                         END;*/ // 16630
                        UNTIL RecPurchRcptLine.NEXT = 0;
                END;
                //TRI DG End
                RecItemLedgerEntry.RESET;
                RecItemLedgerEntry.SETCURRENTKEY("Item No.", "Posting Date");
                RecItemLedgerEntry.SETRANGE("Item No.", "Item No.");
                RecItemLedgerEntry.SETFILTER("Posting Date", '<=%1', ToDate);
                IF RecItemLedgerEntry.FIND('-') THEN
                    REPEAT
                        StockAsOnReportDate += RecItemLedgerEntry.Quantity;
                    UNTIL RecItemLedgerEntry.NEXT = 0;

                RecItemLedgerEntry.RESET;
                RecItemLedgerEntry.SETRANGE("Entry Type", RecItemLedgerEntry."Entry Type"::Consumption);
                RecItemLedgerEntry.SETRANGE("Item No.", "Item No.");
                RecItemLedgerEntry.SETRANGE("Posting Date", ConsumptionFromDate, ConsumptionToDate);
                IF RecItemLedgerEntry.FIND('-') THEN
                    REPEAT
                        Avgconsumption += RecItemLedgerEntry.Quantity;
                    UNTIL
                         RecItemLedgerEntry.NEXT = 0;
                Avgconsumption := Avgconsumption / 3;


                RecValueEntry.RESET;
                RecValueEntry.SETCURRENTKEY("Item Ledger Entry Type", "Item Ledger Entry No.", "Item Charge No.");
                RecValueEntry.SETRANGE("Item Ledger Entry Type", RecValueEntry."Item Ledger Entry Type"::Purchase);
                RecValueEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                RecValueEntry.SETFILTER("Cost Amount (Actual)", '<>%1', 0);
                RecValueEntry.SETFILTER("Item Charge No.", '=%1', '');
                RecValueEntry.SETFILTER("Invoiced Quantity", '<>%1', 0);
                IF RecValueEntry.FIND('-') THEN
                    REPEAT
                    /* 16630 StructureLineDetails.RESET;
                    StructureLineDetails.SETRANGE(StructureLineDetails.Type, StructureLineDetails.Type::Purchase);
                    StructureLineDetails.SETRANGE(StructureLineDetails."Document Type", StructureLineDetails."Document Type"::Invoice);
                    StructureLineDetails.SETRANGE(StructureLineDetails."Invoice No.", RecValueEntry."Document No.");
                    StructureLineDetails.SETRANGE(StructureLineDetails."Item No.", "Item No.");
                    IF StructureLineDetails.FIND('-') THEN
                        REPEAT

                            IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Excise THEN
                                ExciseAmount := ExciseAmount + StructureLineDetails.Amount;

                            IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Other Taxes" THEN
                                Charges := Charges + StructureLineDetails.Amount;

                            IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Charges THEN
                                Charges := Charges + StructureLineDetails.Amount;

                            LineTotAmt := LineTotAmt + StructureLineDetails.Amount;
                        UNTIL StructureLineDetails.NEXT = 0;*/ // 16630
                    UNTIL RecValueEntry.NEXT = 0;
                BillAmt := InsuranceValue + FreightValue + PackingValue + Othertaxes + VATAmt + CSTAmt
                          + BasicAmt + ExciseCenv + ExciseNonCenv + Charges;

                CLEAR(RateDiffAmount);
                recValueEntry1.RESET;
                recValueEntry1.SETCURRENTKEY(
                "Item Ledger Entry No.", "Expected Cost", "Document No.", "Partial Revaluation", "Entry Type", "Variance Type", Adjustment);
                recValueEntry1.SETRANGE("Item Ledger Entry No.", "Entry No.");
                recValueEntry1.SETFILTER("Item Charge No.", '<>%1', '');
                recValueEntry1.SETFILTER("Cost Amount (Actual)", '<>%1', 0);
                recValueEntry1.SETRANGE("Entry Type", recValueEntry1."Entry Type"::"Direct Cost");

                IF recValueEntry1.FIND('-') THEN
                    REPEAT
                        IF (recValueEntry1."Item Charge No." IN ['FREIGHT', 'Transportation']) OR (recValueEntry1."Item Charge No." IN ['FREIGHT_FW', 'Transportation']) THEN
                            Transportvalue += recValueEntry1."Cost Amount (Actual)";
                        //
                        IF recValueEntry1."Item Charge No." = 'RATE DIFF' THEN BEGIN
                            RateDiffAmount += recValueEntry1."Cost Amount (Actual)";
                            //MESSAGE('%1', RateDiffAmount);
                        END;
                        // MSAK
                        IF recValueEntry1."Item Charge No." = 'UNLOADING' THEN
                            UnloadingCharges += recValueEntry1."Cost Amount (Actual)";

                        IF "Import Document" THEN BEGIN

                            IF recValueEntry1."Item Charge No." = 'INS_IMP' THEN
                                ImportInsurance += ImportInsurance + recValueEntry1."Cost Amount (Actual)";
                            IF recValueEntry1."Item Charge No." = 'FRT_IMP' THEN
                                ImportOceanFrt += ImportOceanFrt + recValueEntry1."Cost Amount (Actual)";
                            ImportCIF := BasicAmt + ImportInsurance + ImportInsuranceTRD + ImportOceanFrt + ImportOceanFrtTRD;

                            /* 16630IF recValueEntry1."Item Charge No." IN ['CUS_IMP', 'CUS_IMP_TRD'] THEN BEGIN
                                "ImportCVD&SAD" += "ImportCVD&SAD" + recValueEntry1."BED Amount";
                                "ImportCVD&SADTRD" += "ImportCVD&SADTRD" + recValueEntry1."Cost Amount (Actual)" - recValueEntry1."BED Amount";

                            END;*/ // 16630
                            IF recValueEntry1."Item Charge No." = 'CLG_IMP' THEN
                                "ImportC&F" += "ImportC&F" + recValueEntry1."Cost Amount (Actual)";
                        END;
                    //END;

                    UNTIL recValueEntry1.NEXT = 0;

                RecValueEntry.RESET;
                RecValueEntry.SETCURRENTKEY("Item Ledger Entry Type", "Item Ledger Entry No.", "Item Charge No.");
                RecValueEntry.SETRANGE("Item Ledger Entry Type", RecValueEntry."Item Ledger Entry Type"::Purchase);
                RecValueEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                RecValueEntry.SETFILTER("Cost Amount (Actual)", '>%1', 0);
                RecValueEntry.SETFILTER("Item Charge No.", '=%1', '');

                IF RecValueEntry.FIND('-') THEN
                    REPEAT
                        RecPurchCrmemoHdr.RESET;
                        RecPurchCrmemoHdr.SETCURRENTKEY("Applies-to Doc. No.");
                        RecPurchCrmemoHdr.SETRANGE("Applies-to Doc. No.", RecValueEntry."Document No.");
                        IF RecPurchCrmemoHdr.FIND('-') THEN BEGIN
                            RecPurchCrmemoLine.RESET;
                            RecPurchCrmemoLine.SETRANGE("Document No.", RecPurchCrmemoHdr."No.");
                            RecPurchCrmemoLine.SETRANGE("No.", "Item No.");
                            IF RecPurchCrmemoLine.FINDFIRST THEN
                                REPEAT
                                    RecDGLE.RESET();
                                    RecDGLE.SETRANGE("Document No.", RecPurchCrmemoLine."Document No.");
                                    RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                    RecDGLE.SETRANGE("GST Component Code", 'IGST');
                                    IF RecDGLE.FINDFIRST THEN BEGIN
                                        REPEAT
                                            IGSTAmt += abs(RecDGLE."GST Amount");
                                        UNTIL RecDGLE.NEXT = 0;
                                    END;


                                    RecDGLE.RESET();
                                    RecDGLE.SETRANGE("Document No.", RecPurchCrmemoLine."Document No.");
                                    RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                    RecDGLE.SETRANGE("GST Component Code", 'SGST');
                                    IF RecDGLE.FINDFIRST THEN BEGIN
                                        REPEAT
                                            SGSTAmt += abs(RecDGLE."GST Amount");
                                        UNTIL RecDGLE.NEXT = 0;
                                    END;
                                    RecDGLE.RESET();
                                    RecDGLE.SETRANGE("Document No.", RecPurchCrmemoLine."Document No.");
                                    RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                    RecDGLE.SETRANGE("GST Component Code", 'CGST');
                                    IF RecDGLE.FINDFIRST THEN BEGIN
                                        REPEAT
                                            CGSTAmt += abs(RecDGLE."GST Amount");
                                        UNTIL RecDGLE.NEXT = 0;
                                    END;


                                    RecDGLE.RESET();
                                    RecDGLE.SETRANGE("Document No.", RecPurchCrmemoLine."Document No.");
                                    RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                    RecDGLE.SETRANGE("GST Component Code", 'CGST');
                                    IF RecDGLE.FINDFIRST THEN BEGIN
                                        repeat
                                            GSTBaseAmt += abs(RecDGLE."GST Base Amount");
                                        until RecDGLE.next = 0;
                                    END;
                                    RecDGLE.RESET();
                                    RecDGLE.SETRANGE("Document No.", RecPurchCrmemoLine."Document No.");
                                    RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                    RecDGLE.SETRANGE("GST Component Code", 'IGST');
                                    IF RecDGLE.FINDFIRST THEN BEGIN
                                        repeat
                                            GSTBaseAmt += abs(RecDGLE."GST Base Amount");
                                        until RecDGLE.Next() = 0;

                                    END;
                                    TotalAmount += RecPurchCrmemoLine."Line Amount" + CGSTAmt + IGSTAmt + SGSTAmt;
                                    DebitRefNo := RecPurchCrmemoLine."Document No.";
                                    DebitQty := RecPurchCrmemoLine.Quantity;
                                    DebitAmt := TotalAmount;
                                UNTIL RecPurchCrmemoLine.NEXT = 0;
                        END;
                    UNTIL RecValueEntry.NEXT = 0;
                Landedcost := (BillAmt - VATAmt - ExciseCenv) + Charges + DebitAmt + ImportInsurance + "ImportC&F" + ImportOceanFrt +
                              "ImportCVD&SADTRD"; //-----------


                IF (Quantity - DebitQty) <> 0 THEN
                    Landedcostperunit := Landedcost / (Quantity - DebitQty);
                IF (Quantity - DebitQty) <> 0 THEN
                    Landedcostperunit1 := (Landedcost + Transportvalue) / (Quantity - DebitQty); //Kulbhushan

                //TRI DG 150709 Add start
                RecPurchRcptLine.RESET;
                RecPurchRcptLine.SETRANGE("Document No.", "Document No.");
                RecPurchRcptLine.SETRANGE("No.", "Item No.");
                RecPurchRcptLine.SETFILTER("Line No.", '%1', "Item Ledger Entry"."Document Line No."); //sash
                IF RecPurchRcptLine.FIND('-') THEN BEGIN
                    AccQty := RecPurchRcptLine."Accepted Qunatity";
                    ActQty := RecPurchRcptLine."Actual Quantity";
                    ChQty := RecPurchRcptLine."Challan Quantity";
                    RejQty := RecPurchRcptLine."Rejected Quantity";
                    ShtQty := RecPurchRcptLine."Shortage Quantity";
                    QtyasperUOM := RecPurchRcptLine.Quantity;
                END;
                //TRI DG 150709 Add stop
                IF MinimumStock THEN BEGIN
                    IF Item2.GET("Item Ledger Entry"."Item No.") THEN BEGIN
                        IF Item2."Minimum Inventory" <> 0 THEN BEGIN
                            Rowno := Rowno + 1;

                            IF RecPurchRcptHdr.GET("Document No.") THEN
                                actualmandate := RecPurchRcptHdr."Actual MRN Date";//6823
                            USER_ID := RecPurchRcptHdr."User ID";

                            IF RecVend.GET("Item Ledger Entry"."Source No.") THEN;

                            RecValueEntry.RESET;
                            RecValueEntry.SETRANGE("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                            RecValueEntry.SETFILTER("Invoiced Quantity", '<>%1', 0);
                            IF RecValueEntry.FIND('-') THEN BEGIN
                                IF RecValueEntry."Document No." <> "Document No." THEN;

                                IF RecPurchInvhead.GET(RecValueEntry."Document No.") THEN;
                            END;

                            // IF RecPurchRcptHdr.GET("Document No.")THEN; //MSVRN


                        END;
                    END;
                END ELSE BEGIN

                    IF RecPurchRcptHdr.GET("Document No.") THEN
                        IF RecVend.GET("Item Ledger Entry"."Source No.") THEN;

                    RecValueEntry.RESET;
                    RecValueEntry.SETRANGE("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                    RecValueEntry.SETFILTER("Invoiced Quantity", '<>%1', 0);
                    IF RecValueEntry.FIND('-') THEN BEGIN
                        IF RecValueEntry."Document No." <> "Document No." THEN
                            IF RecPurchInvhead.GET(RecValueEntry."Document No.") THEN;
                    END;

                END;

                IF RecPurchRcptHdr.GET("Document No.") THEN BEGIN
                    truckno := RecPurchRcptHdr."Vendor Order No.";
                    TPNAME := RecPurchRcptHdr."Transporter Name";
                    GrNo := RecPurchRcptHdr."Vendor Shipment No.";
                END;

                RecPurchRcptLine.RESET;
                RecPurchRcptLine.SETRANGE("Document No.", "Item Ledger Entry"."Document No.");
                IF RecPurchRcptLine.FIND('-') THEN
                    IF RecPurchRcptLine.GET("Item No.") THEN
                        gweight := RecPurchRcptLine."Gross Weight";

                CLEAR(RecPurchRcptHdr1);
                IF RecPurchRcptHdr1.GET("Item Ledger Entry"."Document No.") THEN;
            end;

            trigger OnPreDataItem()
            begin
                AgnstRcpt := FALSE;
                i := COUNT;
                Filters := "Item Ledger Entry".GETFILTERS();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(group)
                {
                    field(PrintToExcel; PrintToExcel)
                    {
                        ApplicationArea = All;
                    }
                    field(MinimumStock; MinimumStock)
                    {
                        ApplicationArea = All;
                    }
                    field("Inventory Posting Group"; InvPostingFilter)
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            InvPostingGrp: Record "Inventory Posting Group";
                        begin
                            CLEAR(InvPostingGrp);
                            IF PAGE.RUNMODAL(PAGE::"Inventory Posting Groups", InvPostingGrp) = ACTION::LookupOK THEN
                                IF InvPostingFilter <> '' THEN
                                    InvPostingFilter := InvPostingFilter + '|' + InvPostingGrp.Code
                                ELSE
                                    InvPostingFilter := InvPostingGrp.Code;
                        end;
                    }
                }
            }
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

        //RepAuditMgt.CreateAudit(50054)
    end;

    trigger OnPreReport()
    begin

        IF "Item Ledger Entry".GETFILTER("Posting Date") <> '' THEN BEGIN
            Fromdate := "Item Ledger Entry".GETRANGEMIN("Posting Date");
            ToDate := "Item Ledger Entry".GETRANGEMAX("Posting Date");
        END ELSE
            ToDate := TODAY;

        ConsumptionFromDate := CALCDATE('-3M', ToDate);
        fromMonth := DATE2DMY(ConsumptionFromDate, 2);
        fromyear := DATE2DMY(ConsumptionFromDate, 3);
        toMonth := DATE2DMY(ToDate, 2);
        toYear := DATE2DMY(ToDate, 3);

        ConsumptionFromDate := DMY2DATE(1, fromMonth, fromyear);
        CASE toMonth OF
            1, 3, 5, 7, 8, 10, 12:
                ConsumptionToDate := DMY2DATE(31, toMonth, toYear);
            4, 6, 9, 11:
                ConsumptionToDate := DMY2DATE(30, toMonth, toYear);
            2:
                ConsumptionToDate := DMY2DATE(28, toMonth, toYear);
        END;

        i := 0;
        j := 0;

        //win.OPEN(tgText001);
    end;

    var
        PrintToExcel: Boolean;
        ExcelBuffer: Record "Excel Buffer";
        Rowno: Integer;
        RecItem: Record Item;
        RecItemLedgerEntry: Record "Item Ledger Entry";
        RecPurchRcptHdr: Record "Purch. Rcpt. Header";
        RecPurchRcptHdr1: Record "Purch. Rcpt. Header";
        // 16630 RecPostdStructure: Record 13760;
        ToDate: Date;
        StockAsOnReportDate: Decimal;
        Fromdate: Date;
        ConsumptionFromDate: Date;
        ConsumptionToDate: Date;
        fromMonth: Integer;
        toMonth: Integer;
        fromyear: Integer;
        toYear: Integer;
        Avgconsumption: Decimal;
        "MrnNo.": Code[20];
        MrnDate: Date;
        // 16630 StructureLineDetails: Record 13798;
        ExciseAmount: Decimal;
        Charges: Decimal;
        Othertaxes: Decimal;
        SalesTax: Decimal;
        VATAmount: Decimal;
        LineTotAmt: Decimal;
        InsuranceValue: Decimal;
        FreightValue: Decimal;
        PackingValue: Decimal;
        Transportvalue: Decimal;
        ExciseCenv: Decimal;
        ExciseNonCenv: Decimal;
        BasicRate: Decimal;
        BasicAmt: Decimal;
        RecValuentry: Record "Value Entry";
        ImportFOB: Decimal;
        ImportInsurance: Decimal;
        ImportInsuranceTRD: Decimal;
        ImportOceanFrt: Decimal;
        ImportOceanFrtTRD: Decimal;
        ImportCIF: Decimal;
        ImportInland: Decimal;
        "ImportCVD&SAD": Decimal;
        "ImportCVD&SADTRD": Decimal;
        ImportAntidumping: Decimal;
        ImportSafeguardDuty: Decimal;
        ImportOthers: Decimal;
        "ImportC&F": Decimal;
        "ImportC&FTRD": Decimal;
        ImortFinance: Decimal;
        ImportOtherNonRecu: Decimal;
        UnloadingCharges: Decimal;
        UnitCostOnReportDate: Decimal;
        ItemCostMgt: Codeunit ItemCostManagement;
        AverageCostLCY: Decimal;
        AverageCostACY: Decimal;
        Landedcost: Decimal;
        Landedcostperunit: Decimal;
        Landedcostperunit1: Decimal;
        RecPurchCrmemoHdr: Record "Purch. Cr. Memo Hdr.";
        RecPurchCrmemoLine: Record "Purch. Cr. Memo Line";
        DebitRefNo: Code[20];
        DebitQty: Decimal;
        DebitAmt: Decimal;
        RecValueEntry: Record "Value Entry";
        RecILE: Record "Item Ledger Entry";
        VATAmt: Decimal;
        CSTAmt: Decimal;
        PostingDate: Date;
        RecVend: Record Vendor;
        RecPurchInvLine: Record "Purch. Inv. Line";
        TaxAmt: Decimal;
        RecLoc: Record Location;
        BillAmt: Decimal;
        RecPurchinvHdr: Record "Purch. Inv. Header";
        RecPurchRcptLine: Record "Purch. Rcpt. Line";
        AgnstRcpt: Boolean;
        Rcptno: Code[250];
        varlen: Integer;
        RecPurchInvhead: Record "Purch. Inv. Header";
        decTotQty: Decimal;
        decQty: Decimal;
        recValueEntry1: Record "Value Entry";
        AccQty: Decimal;
        ActQty: Decimal;
        ChQty: Decimal;
        RejQty: Decimal;
        ShtQty: Decimal;
        QtyasperUOM: Decimal;
        tgIUOM: Record "Item Unit of Measure";
        win: Dialog;
        i: Integer;
        j: Integer;
        // 16630 DetailTaxBuffer: Record 16480;
        MinimumStock: Boolean;
        Item2: Record Item;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        date: Date;
        Landedcost1: Decimal;
        TriTxt000: Label 'Enter Posting Date.';
        tgText001: Label 'Process @1@@@@@@@@@@@@@@@@';
        Filters: Text[1000];
        InvPostingFilter: Code[1000];
        truckno: Text[40];
        TPNAME: Text[50];
        GrNo: Text[30];
        gweight: Decimal;
        PurchInvLineREC: Record "Purch. Inv. Line";
        DetailedGSTLedgerEntryREC: Record "Detailed GST Ledger Entry";
        GSTAmount: Decimal;
        GSTPer: Decimal;
        actualmandate: Date;
        RateDiffAmount: Decimal;
        USER_ID: Text[15];
        IGSTAmt: Decimal;
        IGSTper: Decimal;
        SGSTAmt: Decimal;
        SGSTper: Decimal;
        CGSTAmt: Decimal;
        CGSTper: Decimal;
        GSTBaseAmt: Decimal;
        TotalAmount: Decimal;
        RecDGLE: Record "Detailed GST Ledger Entry";
}

