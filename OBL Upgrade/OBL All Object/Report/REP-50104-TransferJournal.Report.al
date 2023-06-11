report 50104 "Transfer Journal"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\TransferJournal.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Transfer Shipment Header"; 5744)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "Posting Date", "No.", "Transfer-from Code", "Transfer-to Code", "External Transfer";
            column(ShowDetails; ShowDetails)
            {
            }
            column(CompanyName1; CompanyName1)
            {
            }
            column(CompanyName2; CompanyName2)
            {
            }
            column(DateFrom; DateFrom)
            {
            }
            column(DateTo; DateTo)
            {
            }
            column(uom; uom)
            {
            }
            column(PostDate; "Transfer Shipment Header"."Posting Date")
            {
            }
            column(TranToCode; "Transfer Shipment Header"."Transfer-to Code")
            {
            }
            column(LocName; LocName)
            {
            }
            column(GrNo; "Transfer Shipment Header"."GR No.")
            {
            }
            column(vahicleNo; "Transfer Shipment Header"."Vehicle No.")
            {
            }
            column(TransporterName; VendorRec.Name)
            {
            }
            column(ExtDocNo; "Transfer Shipment Header"."External Document No.")
            {
            }
            column(TransferOrderNo_TransferShipmentHeader; "Transfer Shipment Header"."Transfer Order No.")
            {
            }
            column(to_gstno; togstno)
            {
            }
            column(fro_gstno; frogstno)
            {
            }
            dataitem("Transfer Shipment Line"; 5745)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE("Item No." = FILTER(<> ''),
                                          Quantity = FILTER(<> 0));
                RequestFilterFields = "Size Code";
                column(BaseUOM; ItemRec."Base Unit of Measure")
                {
                }
                column(ItemRec_No; ItemRec."No.")
                {
                }
                column(ItemRec_No2; ItemRec."No. 2")
                {
                }
                column(ItemRec_Description2; ItemRec."Description 2")
                {
                }
                column(ItemRec_Description; ItemRec.Description)
                {
                }
                column(ItemRec_TypeCatogeryCode; ItemRec."Type Catogery Code")
                {
                }
                column(DocNo; "Transfer Shipment Line"."Document No.")
                {
                }
                column(Quantity_TransferShipmentLine; "Transfer Shipment Line".Quantity)
                {
                }
                column(LineNo_TransferShipmentLine; "Transfer Shipment Line"."Line No.")
                {
                }
                column(ItemNo_TransfeShLi; "Transfer Shipment Line"."Item No.")
                {
                }
                column(Description_TransferShipmentLine; "Transfer Shipment Line".Description)
                {
                }
                column(ShortcutDimension1Code_TransferShipmentLine; "Transfer Shipment Line"."Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_TransferShipmentLine; "Transfer Shipment Line"."Shortcut Dimension 2 Code")
                {
                }
                column(GenProdPostingGroup_TransferShipmentLine; "Transfer Shipment Line"."Gen. Prod. Posting Group")
                {
                }
                column(InventoryPostingGroup_TransferShipmentLine; "Transfer Shipment Line"."Inventory Posting Group")
                {
                }
                column(QuantityBase_TransferShipmentLine; "Transfer Shipment Line"."Quantity (Base)")
                {
                }
                column(QtyperUnitofMeasure_TransferShipmentLine; "Transfer Shipment Line"."Qty. per Unit of Measure")
                {
                }
                column(UnitofMeasureCode_TransferShipmentLine; "Transfer Shipment Line"."Unit of Measure Code")
                {
                }
                column(GrossWeight_TransferShipmentLine; "Transfer Shipment Line"."Gross Weight")
                {
                }
                column(NetWeight_TransferShipmentLine; "Transfer Shipment Line"."Net Weight")
                {
                }
                column(UnitVolume_TransferShipmentLine; "Transfer Shipment Line"."Unit Volume")
                {
                }
                column(VariantCode_TransferShipmentLine; "Transfer Shipment Line"."Variant Code")
                {
                }
                column(UnitsperParcel_TransferShipmentLine; "Transfer Shipment Line"."Units per Parcel")
                {
                }
                column(Description2_TransferShipmentLine; "Transfer Shipment Line"."Description 2")
                {
                }
                column(TransferOrderNo_TransferShipmentLine; "Transfer Shipment Line"."Transfer Order No.")
                {
                }
                column(ShipmentDate_TransferShipmentLine; "Transfer Shipment Line"."Shipment Date")
                {
                }
                column(ShippingAgentCode_TransferShipmentLine; "Transfer Shipment Line"."Shipping Agent Code")
                {
                }
                column(ShippingAgentServiceCode_TransferShipmentLine; "Transfer Shipment Line"."Shipping Agent Service Code")
                {
                }
                column(InTransitCode_TransferShipmentLine; "Transfer Shipment Line"."In-Transit Code")
                {
                }
                column(TransferfromCode_TransferShipmentLine; "Transfer Shipment Line"."Transfer-from Code")
                {
                }
                column(TransfertoCode_TransferShipmentLine; "Transfer Shipment Line"."Transfer-to Code")
                {
                }
                column(ItemShptEntryNo_TransferShipmentLine; "Transfer Shipment Line"."Item Shpt. Entry No.")
                {
                }
                column(ShippingTime_TransferShipmentLine; "Transfer Shipment Line"."Shipping Time")
                {
                }
                column(DimensionSetID_TransferShipmentLine; "Transfer Shipment Line"."Dimension Set ID")
                {
                }
                column(ItemCategoryCode_TransferShipmentLine; "Transfer Shipment Line"."Item Category Code")
                {
                }
                column(ProductGroupCode_TransferShipmentLine; '') // 16630 blank "Transfer Shipment Line"."Product Group Code"
                {
                }
                column(TransferfromBinCode_TransferShipmentLine; "Transfer Shipment Line"."Transfer-from Bin Code")
                {
                }
                column(UnitPrice_TransferShipmentLine; "Transfer Shipment Line"."Unit Price")
                {
                }
                column(Amount_TransferShipmentLine; "Transfer Shipment Line".Amount)
                {
                }
                column(BEDAmount_TransferShipmentLine; 0) // 16630 blank "Transfer Shipment Line"."BED Amount"
                {
                }
                column(AEDGSIAmount_TransferShipmentLine; 0) // 16630 blank "Transfer Shipment Line"."AED(GSI) Amount"
                {
                }
                column(SEDAmount_TransferShipmentLine; 0) // 16630 blank "Transfer Shipment Line"."SED Amount"
                {
                }
                column(SAEDAmount_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."SAED Amount"
                {
                }
                column(CESSAmount_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."CESS Amount"
                {
                }
                column(NCCDAmount_TransferShipmentLine; 0)// 16630 blank  "Transfer Shipment Line"."NCCD Amount"
                {
                }
                column(eCessAmount_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."eCess Amount"
                {
                }
                column(AmountIncludingExcise_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."Amount Including Excise"
                {
                }
                column(ExciseAccountingType_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."Excise Accounting Type"
                {
                }
                column(ExciseProdPostingGroup_TransferShipmentLine; '')// 16630 blank "Transfer Shipment Line"."Excise Prod. Posting Group"
                {
                }
                column(ExciseBusPostingGroup_TransferShipmentLine; '')// 16630 blank "Transfer Shipment Line"."Excise Bus. Posting Group"
                {
                }
                column(CapitalItem_TransferShipmentLine; '')// 16630 blank "Transfer Shipment Line"."Capital Item"
                {
                }
                column(ExciseBaseQuantity_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."Excise Base Quantity"
                {
                }
                column(ExciseBaseAmount_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."Excise Base Amount"
                {
                }
                column(AmountAddedtoExciseBase_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."Amount Added to Excise Base"
                {
                }
                column(AmountAddedtoInventory_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."Amount Added to Inventory"
                {
                }
                column(ChargestoTransfer_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."Charges to Transfer"
                {
                }
                column(TotalAmounttoTransfer_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."Total Amount to Transfer"
                {
                }
                column(ClaimDeferredExcise_TransferShipmentLine; '')// 16630 blank "Transfer Shipment Line"."Claim Deferred Excise"
                {
                }
                column(UnitCost_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."Unit Cost"
                {
                }
                column(ADETAmount_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."ADET Amount"
                {
                }
                column(AEDTTAAmount_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."AED(TTA) Amount"
                {
                }
                column(ADEAmount_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."ADE Amount"
                {
                }
                column(AssessableValue_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."Assessable Value"
                {
                }
                column(SHECessAmount_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."SHE Cess Amount"
                {
                }
                column(ADCVATAmount_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."ADC VAT Amount"
                {
                }
                column(CIFAmount_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."CIF Amount"
                {
                }
                column(BCDAmount_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."BCD Amount"
                {
                }
                column(CVD_TransferShipmentLine; '')// 16630 blank "Transfer Shipment Line".CVD
                {
                }
                column(ExciseLoadingonInventory_TransferShipmentLine; '')// 16630 blank "Transfer Shipment Line"."Excise Loading on Inventory"
                {
                }
                column(CaptiveConsumption_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."Captive Consumption %"
                {
                }
                column(AdminCost_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."Admin. Cost %"
                {
                }
                column(MRPPrice_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."MRP Price"
                {
                }
                column(MRP_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line".MRP
                {
                }
                column(Abatement_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."Abatement %"
                {
                }
                column(AppliestoEntryRG23D_TransferShipmentLine; '')// 16630 blank "Transfer Shipment Line"."Applies-to Entry (RG 23 D)"
                {
                }
                column(CostofProduction_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."Cost of Production"
                {
                }
                column(CostOfProdInclAdminCost_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."Cost Of Prod. Incl. Admin Cost"
                {
                }
                column(CustomeCessAmount_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."Custom eCess Amount"
                {
                }
                column(CustomSHECessAmount_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."Custom SHECess Amount"
                {
                }
                column(ExciseEffectiveRate_TransferShipmentLine; 0)// 16630 blank "Transfer Shipment Line"."Excise Effective Rate"
                {
                }
                column(FromMainLocation_TransferShipmentLine; "Transfer Shipment Line"."From Main Location")
                {
                }
                column(ToMainLocation_TransferShipmentLine; "Transfer Shipment Line"."To Main Location")
                {
                }
                column(SizeCode_TransferShipmentLine; "Transfer Shipment Line"."Size Code")
                {
                }
                column(PostingDate_TransferShipmentLine; "Transfer Shipment Line"."Posting Date")
                {
                }
                column(ExternalTransfer_TransferShipmentLine; "Transfer Shipment Line"."External Transfer")
                {
                }
                column(PlantCode_TransferShipmentLine; "Transfer Shipment Line"."Plant Code")
                {
                }
                column(SalesPersonCode_TransferShipmentLine; "Transfer Shipment Line"."SalesPerson Code")
                {
                }
                column(TypeCode_TransferShipmentLine; "Transfer Shipment Line"."Type Code")
                {
                }
                column(QtyinSqMt_TransferShipmentLine; "Transfer Shipment Line"."Qty in Sq. Mt.")
                {
                }
                column(QtyinCarton_TransferShipmentLine; "Transfer Shipment Line"."Qty in Carton.")
                {
                }
                column(TransfertoState_TransferShipmentLine; "Transfer Shipment Line"."Transfer-to State")
                {
                }
                column(QualityCode_TransferShipmentLine; "Transfer Shipment Line"."Quality Code")
                {
                }
                column(PackingCode_TransferShipmentLine; "Transfer Shipment Line"."Packing Code")
                {
                }
                column(ColorCode_TransferShipmentLine; "Transfer Shipment Line"."Color Code")
                {
                }
                column(DesignCode_TransferShipmentLine; "Transfer Shipment Line"."Design Code")
                {
                }
                column(OK_TransferShipmentLine; "Transfer Shipment Line".OK)
                {
                }
                column(GroupCode_TransferShipmentLine; "Transfer Shipment Line"."Group Code")
                {
                }
                column(TypeCatogeryCode_TransferShipmentLine; "Transfer Shipment Line"."Type Catogery Code")
                {
                }
                column(ShortQuantity_TransferShipmentLine; "Transfer Shipment Line"."Short Quantity")
                {
                }
                column(ReasonCode_TransferShipmentLine; "Transfer Shipment Line"."Reason Code")
                {
                }
                column(ReProcess_TransferShipmentLine; "Transfer Shipment Line".ReProcess)
                {
                }
                column(ShoratgeTransferRcptNo_TransferShipmentLine; "Transfer Shipment Line"."Shoratge Transfer Rcpt No.")
                {
                }
                column(CustomerPriceGroup_TransferShipmentLine; "Transfer Shipment Line"."Customer Price Group")
                {
                }
                column(EndUseItem_TransferShipmentLine; "Transfer Shipment Line"."End Use Item")
                {
                }
                column(IssuetoMachine_TransferShipmentLine; "Transfer Shipment Line"."Issue to Machine")
                {
                }
                column(ShelfNo_TransferShipmentLine; "Transfer Shipment Line"."Shelf No.")
                {
                }
                column(CapexNo_TransferShipmentLine; "Transfer Shipment Line"."Capex No.")
                {
                }
                column(CreationDate_TransferShipmentLine; "Transfer Shipment Line"."Creation Date")
                {
                }
                column(ShipDate_TransferShipmentLine; "Transfer Shipment Line"."Ship Date")
                {
                }
                column(SqrMtr; SqrMtr)
                {
                }
                column(ExAmount; ExAmount)
                {
                }
                column(SalesValue1; SalesValue)
                {
                    IncludeCaption = false;
                }
                column(Insurance1; Insurance1)
                {
                }
                column(TotalValue; TotalValue)
                {
                }
                column(Roundoff; Roundoff)
                {
                }
                column(NetValue; NetValue)
                {
                }
                column(ExciseAmount_TransferShipmentLine; 0) // 16630 blank "Transfer Shipment Line"."Excise Amount"
                {
                }
                column(TotalValue1; TotalValue1)
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

                trigger OnAfterGetRecord()
                begin
                    IF ItemRec.GET("Transfer Shipment Line"."Item No.") THEN;
                    SqrMtr := 0;
                    SqrMtr := Item.UomToSqm("Item No.", "Unit of Measure Code", Quantity);
                    SqrMtr1 := Item.UomToSqm("Item No.", "Unit of Measure Code", Quantity);
                    Insurance1 := 0;
                    InvDisc := 0;
                    //GenLegSetup.GET;

                    /* 16630    PostedStrOrderLineDetails.RESET;
                        PostedStrOrderLineDetails.SETRANGE(Type, PostedStrOrderLineDetails.Type::Transfer);
                        //PostedStrOrderLineDetails.SETRANGE("Document Type",PostedStrOrderLineDetails."Document Type"::Invoice);
                        PostedStrOrderLineDetails.SETRANGE("Invoice No.", "Transfer Shipment Line"."Document No.");
                        PostedStrOrderLineDetails.SETRANGE("Line No.", "Transfer Shipment Line"."Line No.");
                        IF PostedStrOrderLineDetails.FIND('-') THEN
                            REPEAT
                                CASE PostedStrOrderLineDetails."Tax/Charge Type" OF
                                    PostedStrOrderLineDetails."Tax/Charge Type"::Charges:
                                        BEGIN
                                            CASE PostedStrOrderLineDetails."Charge Type" OF
                                                PostedStrOrderLineDetails."Charge Type"::Insurance:
                                                    Insurance1 := Insurance1 + PostedStrOrderLineDetails.Amount;
                                            END;
                                            IF PostedStrOrderLineDetails."Tax/Charge Group" = GenLegSetup."Discount Charge" THEN
                                                InvDisc := InvDisc + ABS(PostedStrOrderLineDetails.Amount);
                                        END;
                                END;
                            UNTIL PostedStrOrderLineDetails.NEXT = 0;*/ // 16630

                    ExAmount := Amount;
                    //Value := ExAmount - InvDisc;
                    // 16630     SalesValue := ExAmount + "Excise Amount";

                    TotalValue := SalesValue + Insurance1;
                    TotalValue1 := ROUND(TotalValue, 1, '=');

                    /*
                    IF "Sales Invoice Header"."Export Document" = "Sales Invoice Header"."Export Document"::"1" THEN
                       Export := '*'
                    ELSE
                       Export := '';
                    */


                    NetValue := ROUND(TotalValue, 1, '=');
                    Roundoff := ROUND(TotalValue, 1, '=') - TotalValue;


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
                    DetailedGSTLedgerEntry.SETRANGE("No.", "Item No.");
                    DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                    IF DetailedGSTLedgerEntry.FINDFIRST THEN
                        REPEAT
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                //CRate := DetailedGSTLedgerEntry."GST %";
                                CAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                CAmount1 += CAmount;
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                //SRate := DetailedGSTLedgerEntry."GST %";
                                sAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                sAmount1 += sAmount
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                //IRate := DetailedGSTLedgerEntry."GST %";
                                IAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                IAmount1 += IAmount;
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'UTGST' THEN BEGIN
                                //URate := DetailedGSTLedgerEntry."GST %";
                                UAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                                UAmount1 += UAmount;
                            END;

                        UNTIL DetailedGSTLedgerEntry.NEXT = 0;


                end;

                trigger OnPreDataItem()
                begin

                    IF uom <> '' THEN
                        SETFILTER("Unit of Measure Code", uom);

                    CurrReport.CREATETOTALS(SqrMtr, SqrMtr1, ExAmount, Value, SalesValue, Insurance1, TotalValue, Roundoff, NetValue, InvDisc);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                LocName := '';
                Loc.RESET;
                IF Loc.GET("Transfer-to Code") THEN
                    LocName := Loc.Name;
                togstno := Loc."GST Registration No.";

                IF Loc.GET("Transfer-from Code") THEN
                    frogstno := Loc."GST Registration No.";


                IF VendorRec.GET("Transfer Shipment Header"."Transporter's Name") THEN;
                /*
                IF printtoexcel THEN BEGIN
                   ExcelBuf.AddColumn('Invoice No.',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Date.',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Depot.',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Quantity.',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Qty. In Sq.mt.',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Ex. Amount.',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Excise Amount.',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Trf. Value',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Ins. Charges',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Total Value',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Round Off',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Net VAlue',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('GR No.',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Transport Name',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Vehicle No.',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('External Document No.',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.NewRow;
                END;
                */

            end;

            trigger OnPreDataItem()
            begin

                CurrReport.CREATETOTALS("Transfer Shipment Line".Quantity, SqrMtr, ExAmount, Value,
                                        // 16630          "Transfer Shipment Line"."Excise Amount", SalesValue, Insurance1,
                                        TotalValue);
                CurrReport.CREATETOTALS(Roundoff, NetValue, InvDisc);

                CompanyInfo.GET;
                CompanyName1 := CompanyInfo.Name;
                CompanyName2 := CompanyInfo."Name 2";
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
                    field("Unit Of Measure"; uom)
                    {
                        ApplicationArea = All;
                    }
                    field("Show Details"; ShowDetails)
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

    trigger OnPostReport()
    begin

        IF printtoexcel THEN
            CreateExcelbook;
        //RepAuditMgt.CreateAudit(50104)
    end;

    trigger OnPreReport()
    begin

        //IF uom = '' THEN
        //ERROR('Please enter the Unit of Measure');

        IF STRPOS(FORMAT("Transfer Shipment Header".GETFILTER("Transfer Shipment Header"."Posting Date")), '.') <> 1 THEN
            DateFrom := FORMAT("Transfer Shipment Header".GETRANGEMIN("Transfer Shipment Header"."Posting Date"));

        IF STRPOS(FORMAT("Transfer Shipment Header".GETFILTER("Transfer Shipment Header"."Posting Date")), '.')
          <> STRLEN(FORMAT("Transfer Shipment Header".GETFILTER("Transfer Shipment Header"."Posting Date"))) - 1 THEN
            DateTo := FORMAT("Transfer Shipment Header".GETRANGEMAX("Transfer Shipment Header"."Posting Date"));
    end;

    var
        ShowDetails: Boolean;
        // 16630  PostedStrOrderLineDetails: Record 13798;
        Insurance1: Decimal;
        ExAmount: Decimal;
        Value: Decimal;
        SalesValue: Decimal;
        TotalValue: Decimal;
        TotalValue1: Decimal;
        NetValue: Decimal;
        Roundoff: Decimal;
        SqrMtr: Decimal;
        SqrMtr1: Decimal;
        DateFrom: Text[30];
        DateTo: Text[30];
        Item: Record Item;
        Export: Text[30];
        uom: Code[10];
        UnitofMeasure: Record "Unit of Measure";
        JudText: array[3] of Code[50];
        PerJud: array[3] of Decimal;
        TaxAreaLine: Record "Tax Area Line";
        TaxDetails: Record "Tax Detail";
        i: Integer;
        SalesInvLine1: Record "Sales Invoice Line";
        TaxBaseAmt: Decimal;
        InvDisc: Decimal;
        GenLegSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        CompanyName1: Text[100];
        Loc: Record Location;
        LocName: Text[50];
        CompanyName2: Text[100];
        ExcelBuf: Record "Excel Buffer" temporary;
        printtoexcel: Boolean;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Text001: Label 'State Cust. Wise Sales Journal';
        Text002: Label 'Data';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Print Date';
        Text011: Label 'Filters';
        ItemRec: Record Item;
        VendorRec: Record Vendor;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CAmount: Decimal;
        sAmount: Decimal;
        IAmount: Decimal;
        UAmount: Decimal;
        CAmount1: Decimal;
        sAmount1: Decimal;
        IAmount1: Decimal;
        UAmount1: Decimal;
        togstno: Code[15];
        frogstno: Code[15];

    procedure MakeExcelInfo()
    begin
        /*
        ExcelBuf.SetUseInfoSheed;
        ExcelBuf.AddInfoColumn(FORMAT(Text005),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn('Transfer Journal1',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(REPORT::"Dispatch Plan1",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text011),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn("Transfer Shipment Line".GETFILTERS,FALSE,'',FALSE,FALSE,FALSE,'');
        
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader
         */

    end;

    local procedure MakeExcelDataHeader()
    begin
    end;

    procedure CreateExcelbook()
    begin
        /*
        ExcelBuf.CreateBook;
        ExcelBuf.CreateSheet(Text002,Text001,COMPANYNAME,USERID);
        ExcelBuf.GiveUserControl;
        ERROR('');
        */

    end;
}

