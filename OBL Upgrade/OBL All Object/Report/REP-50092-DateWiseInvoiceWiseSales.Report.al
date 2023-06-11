report 50092 "Date Wise Invoice Wise Sales"
{
    // TRI-N.M. 06/11/07 Code commented in Sales Invoice Line - OnAfterGetRecord().
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\DateWiseInvoiceWiseSales.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    PreviewMode = PrintLayout;


    dataset
    {
        dataitem("Sales Invoice Header"; 112)
        {
            // CalcFields = "Excise Amount 1";
            DataItemTableView = SORTING("Posting Date")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Location Code";
            column(CompanyName1; CompanyName1)
            {
            }
            column(CompanyName2; CompanyName2)
            {
            }
            column(FilterString1; FilterString1)
            {
            }
            column(PostingDate_SalesInvoiceHeader; FORMAT("Sales Invoice Header"."Posting Date"))
            {
            }
            column(SelltoCustomerName_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(ShiptoCity_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to City")
            {
            }
            column(OrderNo; "Sales Invoice Header"."Order No.")
            {
            }
            column(ReleasDate; FORMAT("Sales Invoice Header"."Releasing Date"))
            {
            }
            column(Statename; Statename)
            {
            }
            column(TransportersName_SalesInvoiceHeader; "Sales Invoice Header"."Transporter Name")
            {
            }
            column(TruckNo_SalesInvoiceHeader; "Sales Invoice Header"."Truck No.")
            {
            }
            column(GRNo_SalesInvoiceHeader; "Sales Invoice Header"."GR No.")
            {
            }
            column(PaySIH; "Sales Invoice Header".Pay)
            {
            }
            column(Cust_Type; "Sales Invoice Header"."Customer Type")
            {
            }
            column(ExciseAmt; ExAmt)
            {
            }
            column(ShiptoCity1_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to City")
            {
            }
            column(Release_time; FORMAT("Sales Invoice Header"."Releasing Time"))
            {
            }
            dataitem("Sales Invoice Line"; 113)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Type = CONST(Item),
                                          Quantity = FILTER(<> 0));
                RequestFilterFields = "Type Code";
                column(cusmail; cusmail)
                {
                }
                column(pchmail; pchmail)
                {
                }
                column(MRPCRT; ((Avalue * 100) / 55))
                {
                }
                column(PostingDate_SalesInvoiceLine; FORMAT("Sales Invoice Line"."Posting Date"))
                {
                }
                column(DocumentNo_SalesInvoiceLine; "Sales Invoice Line"."Document No.")
                {
                }
                column(Sqm; Sqm)
                {
                }
                column(Cart; Cart)
                {
                }
                column(Wt; Wt)
                {
                }
                column(GrossWt; GrossWt)
                {
                }
                column(Avalue; Avalue)
                {
                }
                column(InvoiceValue; InvoiceValue)
                {
                }
                column(PostingDtSIL; FORMAT("Sales Invoice Line"."Posting Date1"))
                {
                }
                column(GGrossWt; GGrossWt)
                {
                }
                column(WtNew; WtNew)
                {
                }
                column(GrossWtNew; GrossWtNew)
                {
                }
                column(cgst; CAmount1)
                {
                }
                column(sgst; sAmount1)
                {
                }
                column(igst; IAmount1)
                {
                }
                column(ugst; UAmount1)
                {
                }
                column(gst_base; gstbaseamtSIL) // 16630 "Sales Invoice Line"."GST Base Amount"
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Clear(gstbaseamtSIL);
                    Sno += 1;
                    IF Sno > 1 THEN
                        CLEAR(ExAmt);

                    dis := 0;
                    Sqm := 0;
                    Cart := 0;
                    Wt := 0;
                    WtNew := 0;
                    GrossWtNew := 0;
                    //MSAK
                    IF RecItem.GET("No.") THEN BEGIN
                        IF RecItem."Inventory Posting Group" IN ['MANUF', 'TRAD', 'TRAD-IMP', 'SAMPLE'] THEN BEGIN
                            Sqm := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);
                            Cart := Item.UomToCart("No.", "Unit of Measure Code", Quantity);
                        END ELSE BEGIN
                            Sqm := "Sales Invoice Line".Quantity;
                            Cart := Item.UomToCart("No.", "Unit of Measure Code", Quantity);
                        END;
                    END;
                    //MSAK
                    //Wt := Item.UomToWeight("No.","Unit of Measure Code",Quantity); //MSAK

                    dis := "Sales Invoice Line"."Line Discount Amount";
                    //MSBS.Rao Begin Dt. 29-08-12
                    IF Type = Type::Item THEN
                        IF RecItem.GET("No.") THEN BEGIN
                            GrossWt := ROUND(RecItem."Gross Weight" * "Qty. per Unit of Measure" * Quantity, 0.001, '='); //MSAK
                            Wt := ROUND(RecItem."Net Weight" * "Qty. per Unit of Measure" * Quantity, 0.001, '='); //MSAK
                        END ELSE
                            GrossWt := 0;

                    GGrossWt += GrossWt;
                    //MSBS.Rao End Dt. 29-08-12
                    Gdis += dis;
                    GSqm += Sqm;
                    GCart += Cart;
                    GWt += Wt;
                    WtNew := (Wt / 1000);
                    GrossWtNew := (GrossWt / 1000);

                    gstbaseamtSIL := GetGSTBaseAmtPostedLine("Document No.", "Line No.");

                    IF "Sales Invoice Header"."Sales Type" = "Sales Invoice Header"."Sales Type"::Retail THEN //ANURAG
                        Avalue := "GST Assessable Value (LCY)" * Quantity
                    ELSE
                        Avalue := "GST Assessable Value (LCY)" * Quantity;
                    InvoiceValue := GetAmttoCustomerPostedLine("Document No.", "Line No."); // 16630 (InvoiceValue := "Sales Invoice Line"."Amount To Customer";)


                    GAvalue += Avalue;
                    GInvoiceValue += InvoiceValue;


                    Statename := '';
                    IF StateRec.GET("Sales Invoice Header".State) THEN
                        Statename := StateRec.Description;

                    CAmount := 0;
                    sAmount := 0;
                    IAmount := 0;
                    UAmount := 0;
                    CAmount1 := 0;
                    sAmount1 := 0;
                    IAmount1 := 0;
                    UAmount1 := 0;

                    DetailedGSTLedgerEntry.RESET;
                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                    DetailedGSTLedgerEntry.SETRANGE("No.", "No.");
                    DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                    IF DetailedGSTLedgerEntry.FINDFIRST THEN
                        REPEAT
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                CAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                CAmount1 += CAmount;
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                sAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                sAmount1 += sAmount
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                IAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                IAmount1 += IAmount;
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'UTGST' THEN BEGIN
                                UAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                UAmount1 += UAmount;
                            END;

                        UNTIL
DetailedGSTLedgerEntry.NEXT = 0;
                end;

                trigger OnPreDataItem()
                begin
                    CLEAR(Sno);
                end;
            }

            trigger OnAfterGetRecord()
            begin

                IF cust.GET("Sell-to Customer No.") THEN BEGIN
                    cusmail := cust."E-Mail";
                    pchmail := cust."PCH E-Maill ID";
                END;
                CLEAR(TransporterName1);
                ExAmt := "Sales Invoice Header"."Excise Amount 1";
                IF Vendorrec.GET("Sales Invoice Header"."Transporter's Name") THEN
                    TransporterName1 := Vendorrec.Name;
                TransporterName1 += ' ' + "Sales Invoice Header"."Transporter Name";
            end;

            trigger OnPreDataItem()
            begin
                "Sales Invoice Header".SETFILTER("Sales Invoice Header"."Posting Date", '%1..%2', StartDate, EndDate);
            end;
        }
        dataitem("Transfer Shipment Header"; 5744)
        {
            DataItemTableView = SORTING("Posting Date")
                                ORDER(Ascending);
            RequestFilterFields = "External Transfer", "No.", "Transfer-from Code";
            column(PostingDate_TransferShipmentHeader; FORMAT("Transfer Shipment Header"."Posting Date"))
            {
            }
            column(TransporterName; TransporterName)
            {
            }
            column(FilterString2; FilterString2)
            {
            }
            column(TransfertoCity_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to City")
            {
            }
            column(TransfertoName_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Name")
            {
            }
            column(TruckNo_TransferShipmentHeader; "Transfer Shipment Header"."Truck No.")
            {
            }
            column(Pay_TransferShipmentHeader; "Transfer Shipment Header".Pay)
            {
            }
            column(ShipmentDate_TransferShipmentHeader; FORMAT("Transfer Shipment Header"."Shipment Date"))
            {
            }
            column(GRNo_TransferShipmentHeader; "Transfer Shipment Header"."GR No.")
            {
            }
            column(OrderNoTL; "Transfer Shipment Header"."Transfer Order No.")
            {
            }
            column(OrderDate; FORMAT("Transfer Shipment Header"."Releasing Date"))
            {
            }
            column(Transfertostate; "Transfer Shipment Header"."Transfer-to State")
            {
            }
            column(Trftostate; Statename)
            {
            }
            dataitem("Transfer Shipment Line"; 5745)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Quantity = FILTER(<> 0));
                RequestFilterFields = "Type Code";
                column(MRPCRTTL; ((Avalue * 100) / 55))
                {
                }
                column(DocumentNo_TransferShipmentLine; "Transfer Shipment Line"."Document No.")
                {
                }
                column(Sqm1; Sqm)
                {
                }
                column(Cart1; Cart)
                {
                }
                column(Wt1; Wt)
                {
                }
                column(GrossWt1; GrossWt / 1000)
                {
                }
                column(Avalue1; Avalue)
                {
                }
                column(InvoiceValue1; InvoiceValue)
                {
                }
                column(PostingDate_TransferShipmentLine; FORMAT("Transfer Shipment Line"."Posting Date"))
                {
                }
                column(Gdis1; Gdis)
                {
                }
                column(GSqm1; GSqm)
                {
                }
                column(GCart1; GCart)
                {
                }
                column(GWt1; GWt)
                {
                }
                column(GAvalue1; GAvalue)
                {
                }
                column(GInvoiceValue1; GInvoiceValue)
                {
                }
                column(GGrossWt1; GGrossWt)
                {
                }
                column(WtNew1; WtNew)
                {
                }
                column(GrossWtNew1; GrossWtNew)
                {
                }
                column(EXVALUE1; EXVALUE1)
                {
                }
                column(tcgst; TCAmount1)
                {
                }
                column(tsgst; TsAmount1)
                {
                }
                column(tigst; TIAmount1)
                {
                }
                column(tugst; TUAmount1)
                {
                }

                column(tragst_bas; gstbaseamtTSL) // 16630 "Transfer Shipment Line"."GST Base Amount" 
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Clear(gstbaseamtTSL);

                    IF "Sales Invoice Line".GETFILTER("Sales Invoice Line"."Plant Code") <> '' THEN
                        IF Item.GET("Item No.") THEN
                            IF Item."Plant Code" <> "Sales Invoice Line".GETFILTER("Sales Invoice Line"."Plant Code") THEN
                                CurrReport.SKIP;

                    gstbaseamtTSL := GetGSTBaseAmtPostedLineTSL("Document No.", "Line No.");

                    Sqm := 0;
                    Cart := 0;
                    Wt := 0;
                    WtNew := 0;
                    GrossWtNew := 0;
                    CLEAR(Avalue);
                    //MSAK
                    IF RecItem.GET("Item No.") THEN BEGIN
                        IF RecItem."Inventory Posting Group" IN ['MANUF', 'TRAD', 'TRAD-IMP', 'SAMPLE'] THEN BEGIN
                            Sqm := Item.UomToSqm("Item No.", "Unit of Measure Code", Quantity);
                            Cart := Item.UomToCart("Item No.", "Unit of Measure Code", Quantity);
                        END ELSE BEGIN
                            Sqm := "Transfer Shipment Line".Quantity;
                            Cart := Item.UomToCart("Item No.", "Unit of Measure Code", Quantity);
                        END;
                    END;
                    //MSAK
                    //Wt := Item.UomToWeight("Item No.","Unit of Measure Code",Quantity); //MSAK
                    Avalue := "GST Assessable Value" * Quantity; // 16630 Assessable value change here 
                    // EXVALUE1 := "Transfer Shipment Line"."Excise Amount"; // 16630
                    IF RecItem1.GET("Item No.") THEN BEGIN
                        //GrossWt:=RecItem1."Gross Weight"*"Quantity (Base)" //MSAK
                        GrossWt := ROUND(RecItem."Gross Weight" * "Qty. per Unit of Measure" * Quantity, 0.001, '='); //MSAK
                        Wt := ROUND(RecItem."Net Weight" * "Qty. per Unit of Measure" * Quantity, 0.001, '='); //MSAK
                    END ELSE
                        GrossWt := 0;
                    GGrossWt += GrossWt;
                    //MSBS.Rao End Dt. 29-08-12

                    Gdis += dis;
                    GSqm += Sqm;
                    GCart += Cart;
                    GWt += Wt;
                    GAvalue += Avalue;
                    WtNew := (Wt / 1000);
                    GrossWtNew := (GrossWt / 1000);

                    CLEAR(InvoiceValue);
                    /* PostedStrlineDtl.RESET;
                     PostedStrlineDtl.SETFILTER(PostedStrlineDtl.Type, '%1', PostedStrlineDtl.Type::Transfer);
                     PostedStrlineDtl.SETFILTER(PostedStrlineDtl."Invoice No.", '%1', "Document No.");
                     PostedStrlineDtl.SETFILTER(PostedStrlineDtl."Line No.", '%1', "Line No.");
                     IF PostedStrlineDtl.FIND('-') THEN
                         REPEAT
                             InvoiceValue := InvoiceValue + PostedStrlineDtl.Amount;
                         UNTIL PostedStrlineDtl.NEXT = 0;*/ // 16630

                    InvoiceValue := InvoiceValue + Amount;
                    GInvoiceValue += InvoiceValue;



                    TransporterName := '';
                    Statename := '';
                    IF StateRec.GET("Transfer Shipment Header"."Transfer-to State") THEN
                        Statename := StateRec.Description;

                    IF Vendorrec.GET("Transfer Shipment Header"."Transporter's Name") THEN
                        TransporterName := Vendorrec.Name;

                    TCAmount := 0;
                    TsAmount := 0;
                    TIAmount := 0;
                    TUAmount := 0;
                    TCAmount1 := 0;
                    TsAmount1 := 0;
                    TIAmount1 := 0;
                    TUAmount1 := 0;


                    DetailedGSTLedgerEntry.RESET;
                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                    DetailedGSTLedgerEntry.SETRANGE("No.", "Item No.");
                    DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                    IF DetailedGSTLedgerEntry.FINDFIRST THEN
                        REPEAT
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                TCAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                TCAmount1 += TCAmount;
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                TsAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                TsAmount1 += TsAmount
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                TIAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                TIAmount1 += TIAmount;
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'UTGST' THEN BEGIN
                                TUAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                TUAmount1 += TUAmount;
                            END;

                        UNTIL
DetailedGSTLedgerEntry.NEXT = 0;
                end;
            }

            trigger OnPreDataItem()
            begin
                "Transfer Shipment Header".SETFILTER("Transfer Shipment Header"."Posting Date", '%1..%2', StartDate, EndDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Start Date:"; StartDate)
                    {
                        ApplicationArea = All;
                    }
                    field("End Date:"; EndDate)
                    {
                        ApplicationArea = All;
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

    trigger OnInitReport()
    begin

        Gdis := 0;
        GSqm := 0;
        GCart := 0;
        GWt := 0;

        CompanyInfo.GET;
        CompanyName1 := CompanyInfo.Name;
        CompanyName2 := CompanyInfo."Name 2";
    end;

    trigger OnPreReport()
    begin

        //FilterString1 := "Sales Invoice Header".GETFILTERS + ' ' + "Sales Invoice Line".GETFILTERS;
        //FilterString2 := "Transfer Shipment Header".GETFILTERS + ' ' + "Transfer Shipment Line".GETFILTERS;
        IF StartDate = 0D THEN
            ERROR('Please Enter Start Date');
        IF EndDate = 0D THEN
            ERROR('Please enter End Date');
    end;

    var
        // 16630  PostedStrlineDtl: Record 13798;
        Item: Record Item;
        Sqm: Decimal;
        Cart: Decimal;
        Wt: Decimal;
        PNO: Integer;
        a: Boolean;
        b: Boolean;
        Avalue: Decimal;
        StateRec: Record State;
        Statename: Text[100];
        InvoiceValue: Decimal;
        Vendorrec: Record Vendor;
        TransporterName: Text[250];
        FilterString1: Text[250];
        FilterString2: Text[250];
        CompanyInfo: Record "Company Information";
        CompanyName1: Text[100];
        exvalue: Decimal;
        dis: Decimal;
        fs: Text[30];
        ExcelBuf: Record "Excel Buffer" temporary;
        k: Integer;
        PrintToExcel: Boolean;
        CompanyName2: Text[100];
        Gdis: Decimal;
        GSqm: Decimal;
        GCart: Decimal;
        GWt: Decimal;
        GAvalue: Decimal;
        GInvoiceValue: Decimal;
        GrossWt: Decimal;
        RecItem: Record Item;
        GGrossWt: Decimal;
        RecItem1: Record Item;
        evalue: Decimal;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        EXVALUE1: Decimal;
        cust: Record Customer;
        cusmail: Text[100];
        pchmail: Text[100];
        WtNew: Decimal;
        GrossWtNew: Decimal;
        ExAmt: Decimal;
        Sno: Integer;
        TransporterName1: Text[100];
        loc: Record Location;
        CAmount: Decimal;
        sAmount: Decimal;
        IAmount: Decimal;
        UAmount: Decimal;
        CAmount1: Decimal;
        sAmount1: Decimal;
        IAmount1: Decimal;
        UAmount1: Decimal;
        gstn: Code[15];
        gsttyp: Option;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        TCAmount: Decimal;
        TsAmount: Decimal;
        TIAmount: Decimal;
        TUAmount: Decimal;
        TCAmount1: Decimal;
        TsAmount1: Decimal;
        TIAmount1: Decimal;
        TUAmount1: Decimal;
        StartDate: Date;
        EndDate: Date;
        gstbaseamtSIL: Decimal;
        gstbaseamtTSL: Decimal;

    procedure GetGSTBaseAmtPostedLine(DocumentNo: Code[20]; DocLineNo: Integer): Decimal
    var
        PstdPurchInv: Record "Sales Invoice Line";
        TotalAmt: Decimal;
        DetGstLedEntry: Record "Detailed GST Ledger Entry";
        GSTBaseAmt: Decimal;
        GSTBaseIgst1: Decimal;
        GSTBaseCgst2: Decimal;
        GSTBaseSgst3: Decimal;
    begin
        Clear(GSTBaseAmt);
        Clear(GSTBaseIgst1);
        Clear(GSTBaseCgst2);
        Clear(GSTBaseSgst3);

        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'IGST');
        IF DetGstLedEntry.FINDFIRST THEN
            repeat
                GSTBaseIgst1 += Abs(DetGstLedEntry."GST Base Amount");
            until DetGstLedEntry.Next() = 0;


        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetGstLedEntry.FINDFIRST THEN
            IF DetGstLedEntry.FINDFIRST THEN
                repeat
                    GSTBaseCgst2 += Abs(DetGstLedEntry."GST Base Amount");
                until DetGstLedEntry.Next() = 0;

        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'SGST');
        IF DetGstLedEntry.FINDFIRST THEN
            IF DetGstLedEntry.FINDFIRST THEN
                repeat
                    GSTBaseSgst3 += Abs(DetGstLedEntry."GST Base Amount");
                until DetGstLedEntry.Next() = 0;

        GSTBaseAmt := GSTBaseIgst1 + GSTBaseCgst2 + GSTBaseSgst3;
        EXIT(GSTBaseAmt);
    end;

    procedure GetGSTBaseAmtPostedLineTSL(DocumentNo: Code[20]; DocLineNo: Integer): Decimal
    var
        PstdPurchInv: Record "Transfer Shipment Line";
        TotalAmt: Decimal;
        DetGstLedEntry: Record "Detailed GST Ledger Entry";
        GSTBaseAmt: Decimal;
        GSTBaseIgst: Decimal;
        GSTBaseCgst: Decimal;
        GSTBaseSgst: Decimal;
    begin
        Clear(GSTBaseAmt);
        Clear(GSTBaseIgst);
        Clear(GSTBaseCgst);
        Clear(GSTBaseSgst);

        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'IGST');
        IF DetGstLedEntry.FINDFIRST THEN
            repeat
                GSTBaseIgst += Abs(DetGstLedEntry."GST Base Amount");
            until DetGstLedEntry.Next() = 0;


        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetGstLedEntry.FINDFIRST THEN
            IF DetGstLedEntry.FINDFIRST THEN
                repeat
                    GstBaseCgst += Abs(DetGstLedEntry."GST Base Amount");
                until DetGstLedEntry.Next() = 0;

        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'SGST');
        IF DetGstLedEntry.FINDFIRST THEN
            IF DetGstLedEntry.FINDFIRST THEN
                repeat
                    GSTBaseSgst += Abs(DetGstLedEntry."GST Base Amount");
                until DetGstLedEntry.Next() = 0;

        GSTBaseAmt := GSTBaseSgst + GSTBaseCgst + GSTBaseIgst;
        EXIT(GSTBaseAmt);
    end;


    procedure GetAmttoCustomerPostedLine(DocumentNo: Code[20]; DocLineNo: Integer): Decimal
    var
        PstdSalesInv: Record 113;
        PstdSalesCrMemoLine: Record 115;
        TotalAmt: Decimal;
        DetGstLedEntry: Record "Detailed GST Ledger Entry";
        IGSTAmt: Decimal;
        GSTBaseAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTAmt: Decimal;
        LineAmt: Decimal;
        TaxTransactionValue: Record "Tax Transaction Value";
        TDSSetup: Record "TDS Setup";
        TDSAmt: Decimal;
    begin
        Clear(IGSTAmt);
        Clear(LineAmt);
        Clear(SGSTAmt);
        Clear(CGSTAmt);
        Clear(TDSAmt);
        TDSSetup.Get();
        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'IGST');
        IF DetGstLedEntry.FINDFIRST THEN
            repeat
                IGSTAmt += abs(DetGstLedEntry."GST Amount");
            Until DetGstLedEntry.Next() = 0;



        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'SGST');
        IF DetGstLedEntry.FINDFIRST THEN
            repeat
                SGSTAmt += abs(DetGstLedEntry."GST Amount");
            Until DetGstLedEntry.Next() = 0;

        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetGstLedEntry.FINDFIRST THEN
            repeat
                CGSTAmt += abs(DetGstLedEntry."GST Amount");
            Until DetGstLedEntry.Next() = 0;

        if PstdSalesCrMemoLine.Get(DocumentNo, DocLineNo) then begin
            if PstdSalesCrMemoLine.Type <> PstdSalesCrMemoLine.Type::" " then
                LineAmt := PstdSalesCrMemoLine."Line Amount";
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PstdSalesCrMemoLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetRange("Value ID", 7);
            //TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindFirst() then
                TDSAmt := TaxTransactionValue.Amount;
        end;

        if PstdSalesInv.Get(DocumentNo, DocLineNo) then begin
            if PstdSalesInv.Type <> PstdSalesInv.Type::" " then
                LineAmt := PstdSalesInv."Line Amount";
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PstdSalesInv.RecordId);
            TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetRange("Value ID", 7);
            //TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindFirst() then
                TDSAmt := TaxTransactionValue.Amount;
        end;

        Clear(TotalAmt);
        TotalAmt := (LineAmt + IGSTAmt + SGSTAmt + CGSTAmt) - TDSAmt;
        EXIT(ABS(TotalAmt));
    end;


}

