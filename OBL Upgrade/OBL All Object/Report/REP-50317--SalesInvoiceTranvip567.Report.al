report 50317 "Sales Invoice Tranvip567"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\SalesInvoiceTranvip567.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(AcknowledgementNo_TransferShipmentHeader; "Transfer Shipment Header"."Acknowledgement No.")
            {
            }
            column(IRNHash_TransferShipmentHeader; "Transfer Shipment Header"."IRN Hash")
            {
            }
            column(QRCode_TransferShipmentHeader; "Transfer Shipment Header"."QR Code")
            {
            }
            column(B2CQRCode; '')
            {
            }
            column(CarriedForCaption; CarriedForLbl)
            {
            }
            column(BroughtForCaption; BroughtForLbl)
            {
            }
            column(No_TSH; "Transfer Shipment Header"."No.")
            {
            }
            column(LOC_NAME; Location_tr.Name + Location_tr."Name 2")
            {
            }
            column(LOC_ADD12; Location_tr.Address + '  , ' + Location_tr."Address 2")
            {
            }
            column(LOC_CITY_STATE; Location_tr.City + ' , ' + Location_tr."Post Code")
            {
            }
            column(LOC_ph; 'Phone No -  ' + Location_tr."Phone No.")
            {
            }
            column(ShipmentDate_TTSH; "Transfer Shipment Header"."Shipment Date")
            {
            }
            column(Transporter_Name; RecVendors.Name)
            {
            }
            column(InvoiceName; InvoiceName)
            {
            }
            column(STATE_Des; RecState.Description)
            {
            }
            column(STATE_Code; RecState."State Code (GST Reg. No.)")
            {
            }
            column(Loc_Gstno; Location."GST Registration No.")
            {
            }
            column(E_way; "Transfer Shipment Header"."E-Way Bill No.")
            {
            }
            column(STATE_Des_TO; RecState1.Description)
            {
            }
            column(STATE_Code_TO; RecState1."State Code (GST Reg. No.)")
            {
            }
            column(Loc_Gstno_TO; Location1."GST Registration No.")
            {
            }
            column(TransferfromCode_TSH; "Transfer Shipment Header"."Transfer-from Code")
            {
            }
            column(TransferfromName_TSH; "Transfer Shipment Header"."Transfer-from Name")
            {
            }
            column(TransferfromName2_TSH; "Transfer Shipment Header"."Transfer-from Name 2")
            {
            }
            column(TransferfromAddress_TSH; "Transfer Shipment Header"."Transfer-from Address")
            {
            }
            column(TransferfromAddress2_TSH; "Transfer Shipment Header"."Transfer-from Address 2")
            {
            }
            column(TransferfromPostCode_TSH; "Transfer Shipment Header"."Transfer-from Post Code")
            {
            }
            column(TransferfromCity_TSH; "Transfer Shipment Header"."Transfer-from City")
            {
            }
            column(TransferfromCounty_TSH; "Transfer Shipment Header"."Transfer-from County")
            {
            }
            column(TrsffromCountryRegionCode_TSH; "Transfer Shipment Header"."Trsf.-from Country/Region Code")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_pan; CompanyInfo."P.A.N. No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(DocNoNew; DocNoNew)
            {
            }
            column(PosDate; FORMAT("Transfer Shipment Header"."Posting Date"))
            {
            }
            column(LRRRNo_TransferShipmentHeader; "Transfer Shipment Header"."LR/RR No.")
            {
            }
            column(TransfertoName_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Name")
            {
            }
            column(TransfertoAddress_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Address")
            {
            }
            column(TransfertoAddress2_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Address 2")
            {
            }
            column(TransfertoCity_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to City")
            {
            }
            column(TransferOrderNo_TransferShipmentHeader; "Transfer Shipment Header"."Transfer Order No.")
            {
            }
            column(TruckNo_TransferShipmentHeader; "Transfer Shipment Header"."Truck No.")
            {
            }
            column(StateName; StateRec.Description)
            {
            }
            column(DocnO; CONVERTSTR("Transfer Shipment Line"."Document No.", '\', '/'))
            {
            }
            column(vname; vname)
            {
            }
            //16225  column(LocTIN; RecLoc."T.I.N. No.")
            column(LocTIN; RecLoc."T.A.N. No.")
            {
            }
            //16225 column(LocCST; RecLoc."C.S.T No.")
            column(LocCST; RecLoc."C.S.T. No.")
            {
            }
            column(GRNo; "Transfer Shipment Header"."GR No.")
            {
            }
            column(GRDate; FORMAT("Transfer Shipment Header"."GR Date"))
            {
            }
            column(Pay_TransferShipmentHeader; "Transfer Shipment Header".Pay)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(OuputNos; OuputNos)
                {
                }
                column(copyText1; copyText1)
                {
                }
                column(NoOfLoops; NoOfLoops)
                {
                }
                column(TotalCopies; NoOfCopies)
                {
                }
                dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemLinkReference = "Transfer Shipment Header";
                    DataItemTableView = SORTING("Document No.", "Line No.")
                                        ORDER(Ascending)
                                        WHERE(Quantity = FILTER(<> 0));
                    column(TotalNoOfInvoiceLines; TotalNoOfInvoiceLines)
                    {
                    }
                    column(HideCarriedForward; HideCarriedForward)
                    {
                    }
                    column(Item_HSN_SAC; ItemRec."HSN/SAC Code")
                    {
                    }
                    column(IGSTTotal; IGSTTotal)
                    {
                    }
                    column(IRate; IRate)
                    {
                    }
                    column(IAmount; IAmount)
                    {
                    }
                    column(PageCont; PageCont)
                    {
                    }
                    column(PageBreak1; PageBreak1)
                    {
                    }
                    column(Sno; "S.No.")
                    {
                    }
                    column(ItemNo; "Transfer Shipment Line"."Item No.")
                    {
                    }
                    column(Description_TransferShipmentLine; "Transfer Shipment Line".Description)
                    {
                    }
                    column(Description2_TransferShipmentLine; "Transfer Shipment Line"."Description 2")
                    {
                    }
                    column(UnitofMeasure_TransferShipmentLine; "Transfer Shipment Line"."Unit of Measure")
                    {
                    }
                    column(QtyinSQM; QtyinSQM)
                    {
                    }
                    //16225   column(MRPPrice_TransferShipmentLine; "Transfer Shipment Line"."MRP Price")
                    column(MRPPrice_TransferShipmentLine; "Transfer Shipment Line"."Unit Price")
                    {
                    }
                    column(AsseableValue; AsseableValue)
                    {
                    }
                    column(BuyersRatePerSqMtr; ROUND(BuyersRatePerSqMtr, 0.01))
                    {
                    }
                    column(Value; Value)
                    {
                    }
                    column(TextContinue; TextContinue)
                    {
                    }
                    column(Quantity_TransferShipmentLine; "Transfer Shipment Line".Quantity)
                    {
                    }
                    column(Text13705; Text13705)
                    {
                    }
                    column(Text13706; Text13706)
                    {
                    }
                    column(wt1; ROUND(wt1, 0.01))
                    {
                    }
                    column(NetVal; NetVal)
                    {
                    }
                    column(TotalChargerAmt; TotalChargerAmt)
                    {
                    }
                    column(Policy; Policy)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        /*
                        IF (Sno -1) MOD 20 = 0 THEN                //RKS
                          PageBreak1 := (Sno -1)/20;
                        
                        PageCont := ROUND(COUNT/20,1,'<');
                        */
                        TotalNoOfInvoiceLines := "Transfer Shipment Line".COUNT;
                        DocNoNew := CONVERTSTR("Transfer Shipment Line"."Document No.", '\', '/');

                        ItemRec.RESET;
                        IF ItemRec.GET("Transfer Shipment Line"."Item No.") THEN;

                        wt1 := "Transfer Shipment Line"."Gross Weight";
                        /*
                        IF "S.No."=21 THEN
                        CurrReport.NEWPAGE;
                        "S.No."+=1;
                        */

                        IF Item.GET("Item No.") THEN BEGIN
                            DimensionValue1.SETRANGE(Code, "Size Code");
                            IF DimensionValue1.FINDFIRST THEN;
                        END;


                        Cart := Item.UomToCart("Item No.", "Unit of Measure Code", Quantity);
                        SqMt := Item.UomToSqm("Item No.", "Unit of Measure Code", Quantity);
                        Pcsqty := ROUND(Item.UomToPcs("Item No.", "Unit of Measure Code", Quantity), 1, '<');

                        //IF Cart <> 0 THEN
                        //  RateperCart := "Unit Price"*Quantity/Cart;

                        //IF Cart <> 0 THEN
                        //  DiscPerCart := "Line Discount Amount"/Cart;
                        //Value := Cart * (RateperCart - DiscPerCart);

                        //MSSS
                        //16225 table N/F start
                        /*  ExcisePostingSetup.RESET;
                          ExcisePostingSetup.SETRANGE("Excise Bus. Posting Group", "Excise Bus. Posting Group");
                          ExcisePostingSetup.SETRANGE("Excise Prod. Posting Group", "Excise Prod. Posting Group");
                          IF ("Posting Date" <> 0D) THEN
                              ExcisePostingSetup.SETRANGE("From Date", 0D, "Posting Date")
                          ELSE
                              ExcisePostingSetup.SETRANGE("From Date", 0D, WORKDATE);
                          IF ExcisePostingSetup.FIND('+') THEN BEGIN
                              "BED%" := ExcisePostingSetup."BED %";
                              "eCess%" := ExcisePostingSetup."eCess %";
                              "SHECess%" := ExcisePostingSetup."SHE Cess %";
                          END;*///16225 table N/F End


                        QuantityinSqMt := Item.UomToSqm("Item No.", "Unit of Measure Code", "Transfer Shipment Line".Quantity);
                        QuantityinCartons := ROUND(Item.UomToCart("Item No.", "Unit of Measure Code", "Transfer Shipment Line".Quantity), 1, '<');
                        //NetWeight := Item.UomToWeight("Item No.","Unit of Measure Code","Transfer Shipment Line".Quantity);
                        IF "Transfer Shipment Line".Quantity > 0 THEN BEGIN
                            NetWeight := Item.UomToGrossWeight("Item No.", "Unit of Measure Code", "Transfer Shipment Line".Quantity);
                        END;
                        Pcs := ROUND(Item.UomToPcs("Item No.", "Unit of Measure Code", "Transfer Shipment Line".Quantity), 1, '<');//-- 3. Tri30.0 PG 14112006

                        // 16225 Value := Amount + "Transfer Shipment Line"."Excise Amount";
                        Value := Amount;
                        //16225 field N/F start
                        /* IF Quantity <> 0 THEN BEGIN
                             BEDAmt := BEDAmt + "BED Amount";
                             Hecess := Hecess + "SHE Cess Amount";
                             ECessAmt := ECessAmt + "eCess Amount"
                         END;*/
                        //16225 field N/F End
                        //MSSS
                        LineStop := LineStop + 1;


                        vendor1.RESET;
                        vendor1.SETRANGE(vendor1."No.", "Transfer Shipment Header"."Transporter's Name");
                        IF vendor1.FIND('-') THEN
                            vname := vendor1.Name;

                        Sno += 1;
                        IF (Sno - 1) MOD 36 = 0 THEN
                            PageBreak1 := (Sno - 1) / 36;

                        PageCont := ROUND(COUNT / 36, 1, '<');

                        state1.RESET;
                        state1.SETRANGE(state1.Code, "Transfer Shipment Header"."Transfer-to State");
                        IF state1.FIND('-') THEN
                            stname := state1.Description;

                        IF (TotalNoOfInvoiceLines > 36) AND (Sno < TotalNoOfInvoiceLines) THEN
                            HideCarriedForward := FALSE
                        ELSE
                            HideCarriedForward := TRUE;

                        IF "S.No." = 36 THEN
                            CurrReport.NEWPAGE;
                        //ItemPartNo [1]:= GetPartNo("Transfer Shipment Line");
                        "S.No." := "S.No." + 1;

                        IF "Quantity (Base)" <> 0 THEN
                            //16225    ExAmt := "Transfer Shipment Line"."Excise Amount" / "Transfer Shipment Line"."Quantity (Base)";
                            IF "Quantity (Base)" <> 0 THEN
                                BuyersRatePerSqMtr := (Amount / "Quantity (Base)") + ExAmt;
                        //16225   AsseableValue := "Transfer Shipment Line"."Assessable Value" * Quantity;
                        AsseableValue := "Transfer Shipment Line"."GST Assessable Value" * Quantity;

                        IF "Transfer Shipment Line"."Unit of Measure Code" = 'PCS.' THEN
                            QtyinSQM := ROUND("Transfer Shipment Line"."Qty in Sq. Mt.")
                        ELSE
                            QtyinSQM := ROUND("Transfer Shipment Line"."Quantity (Base)");
                        GrossWieght := Item."Gross Weight" * QtyinSQM;

                        /*
                        IF "S.No."=21 THEN BEGIN
                        CurrReport.SHOWOUTPUT(TRUE) ;
                        TextContinue :='Continue....';
                        END ELSE BEGIN
                        CurrReport.SHOWOUTPUT(FALSE) ;
                        TextContinue :=''
                        END;
                        */


                        CheckReport.InitTextVariable;
                        //16225 CheckReport.FormatNoText(AmountinWord1, ROUND("Excise Amount", 1), '');
                        //------------------------------------
                        //CurrReport.SHOWOUTPUT("S.No.">15);//Msdr
                        NetVal := ROUND((Value + TotalChargerAmt + InsuranceAmt), 1, '=');
                        CheckReport.InitTextVariable;
                        CheckReport.FormatNoText(AmountinWord, ROUND(NetVal, 1), '');


                        //RAUSHAN GST 010117

                        CRate := 0;
                        SRate := 0;
                        IRate := 0;
                        CAmount := 0;
                        SAmount := 0;
                        IAmount := 0;


                        DetailGSTEntryBuff.RESET;
                        DetailGSTEntryBuff.SETRANGE("Document No.", "Document No.");
                        //DetailGSTEntryBuff.SETRANGE("No.", "Item No.");
                        DetailGSTEntryBuff.SETRANGE(DetailGSTEntryBuff."Document Line No.", "Line No.");
                        IF DetailGSTEntryBuff.FINDFIRST THEN
                            REPEAT
                                /*
                                IF DetailGSTEntryBuff."GST Component Code" = 'CGST' THEN BEGIN
                                    CRate := DetailGSTEntryBuff."GST %";
                                    CAmount := ABS(DetailGSTEntryBuff."GST Amount");
                               END;

                                IF DetailGSTEntryBuff."GST Component Code" = 'SGST' THEN BEGIN
                                    SRate := DetailGSTEntryBuff."GST %";
                                    SAmount := ABS(DetailGSTEntryBuff."GST Amount");
                               END;
                               */
                                IF DetailGSTEntryBuff."GST Component Code" = 'IGST' THEN BEGIN
                                    IRate := DetailGSTEntryBuff."GST %";
                                    IAmount := ABS(DetailGSTEntryBuff."GST Amount");
                                END;
                            UNTIL
DetailGSTEntryBuff.NEXT = 0;

                        CGSTTotal += CAmount;
                        SGSTTotal += SAmount;
                        IGSTTotal += IAmount;

                        CHECK.InitTextVariable();
                        CHECK.FormatNoText(CGSTinWords, CGSTTotal, '');
                        CHECK.FormatNoText(SGSTinWords, SGSTTotal, '');
                        CHECK.FormatNoText(IGSTinWords, IGSTTotal, '');
                        //GST
                        RowCount := "Transfer Shipment Line".COUNT;

                    end;

                    trigger OnPreDataItem()
                    begin
                        "S.No." := 0;
                        CLEAR(Sno);
                        CLEAR(PageCont);
                        Sno := 0;
                    end;
                }
                /*  dataitem(DataItem1000000040; Table13798)//16225 table N/F
                  {
                      DataItemLink = Invoice No.=FIELD(No.);
                      DataItemLinkReference = "Transfer Shipment Header";
                      DataItemTableView = SORTING (Tax/Charge Type, Charge Type)
                                          ORDER(Ascending)
                                          WHERE (Type = FILTER (Transfer));
                      column(OtherTaxes; OtherTaxes)
                      {
                      }
                      column(VATAmt; VATAmt)
                      {
                      }

                      trigger OnAfterGetRecord()
                      begin

                          CASE "Tax/Charge Type" OF
                              "Tax/Charge Type"::Charges:
                                  BEGIN
                                      CASE "Charge Type" OF
                                          "Charge Type"::" ", "Charge Type"::Freight, "Charge Type"::Commission:
                                              ChargeAmt := ChargeAmt + "Posted Str Order Line Details".Amount;
                                          "Charge Type"::Insurance:
                                              InsuranceAmt1 += "Posted Str Order Line Details".Amount;
                                      END;
                                      IF "Tax/Charge Group" = GenLegSetup."Discount Charge" THEN
                                          InvDisc := "Posted Str Order Line Details".Amount;
                                  END;
                              "Tax/Charge Type"::"Sales Tax":
                                  SalesTaxAmt := "Posted Str Order Line Details".Amount;
                              "Tax/Charge Type"::Excise:
                                  ExciseAmt := "Posted Str Order Line Details".Amount;
                              "Tax/Charge Type"::"Other Taxes":
                                  OtherTaxes := "Posted Str Order Line Details".Amount;
                              "Tax/Charge Type"::"Service Tax":
                                  VATAmt := "Posted Str Order Line Details".Amount;
                          END;
                      end;
                  }*/
                dataitem(InsRow; Integer)
                {
                    column(IncRowas; IncRowas)
                    {
                    }
                    column(BEDAmt; BEDAmt)
                    {
                    }
                    column(ECessAmt; ECessAmt)
                    {
                    }
                    column(Hecess; Hecess)
                    {
                    }
                    column(SalesTaxAmt; SalesTaxAmt)
                    {
                    }
                    column(ChargeAmt; ChargeAmt)
                    {
                    }
                    column(InsuranceAmt; InsuranceAmt)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IncRowas += 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETRANGE(Number, 1, 30 - RowCount);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    OuputNos += 1;
                    IF OuputNos = 1 THEN
                        copyText1 := 'Original For Buyer';
                    IF OuputNos = 2 THEN
                        copyText1 := 'Duplicate For Transporter';
                    IF OuputNos = 3 THEN
                        copyText1 := 'Triplicate For Assessee';
                end;

                trigger OnPostDataItem()
                begin

                    //IF NOT CurrReport.PREVIEW THEN
                    // SalesInvCountPrinted.RUN("Sales Invoice Header");
                end;

                trigger OnPreDataItem()
                begin

                    NoOfLoops := 1;// ABS(NoOfCopies);
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    copyText1 := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    LineStop := 0;
                    //CLEAR(OuputNos);
                    OuputNos := 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                CompanyInformation: Record "Company Information";
                amttocustomer: Decimal;
                DynamicsPAYID: Text;
            begin
                //RKS GST 010717

                Location.RESET;
                IF Location.GET("Transfer Shipment Header"."Transfer-from Code") THEN BEGIN
                    RecState.RESET;
                    IF RecState.GET(Location."State Code") THEN
                        Trans_From_state := RecState.Code;
                END;

                Location1.RESET;
                IF Location1.GET("Transfer Shipment Header"."Transfer-to Code") THEN BEGIN
                    RecState1.RESET;
                    IF RecState1.GET(Location1."State Code") THEN
                        Trans_TO_state := RecState1.Code;
                END;

                IF Trans_From_state = Trans_TO_state THEN
                    InvoiceName := 'Delivery Challan'
                ELSE
                    InvoiceName := 'Tax Invoice';

                IF RecVendors.GET("Transfer Shipment Header"."Transporter's Name") THEN;

                IF Location_tr.GET("Transfer Shipment Header"."Transfer-from Code") THEN;



                // RKS END

                IF "Posting Date" >= 20140107D THEN BEGIN//070114D
                    Policy := NewPolicy
                END ELSE
                    Policy := Text13704;

                IF Recvendor.GET("Transporter's Name") THEN;

                IF RecLoc.GET("Transfer Shipment Header"."Transfer-from Code") THEN
                    CST := RecLoc."C.S.T. No.";

                IF RecLoc.GET("Transfer Shipment Header"."Transfer-to Code") THEN
                    IF StateRec.GET(RecLoc."State Code") THEN;
                //16225 table N/F Start
                /* PostedStrOrderLineDetails.RESET;
                 PostedStrOrderLineDetails.SETRANGE(PostedStrOrderLineDetails."Invoice No.", "Transfer Shipment Header"."No.");
                 PostedStrOrderLineDetails.SETRANGE("Charge Type", PostedStrOrderLineDetails."Charge Type"::Insurance);
                 PostedStrOrderLineDetails.SETRANGE("Tax/Charge Type", PostedStrOrderLineDetails."Tax/Charge Type"::Charges);
                 IF PostedStrOrderLineDetails.FINDSET THEN BEGIN
                     REPEAT
                         InsuranceAmt += PostedStrOrderLineDetails.Amount;
                     UNTIL PostedStrOrderLineDetails.NEXT = 0;
                 END;*///16225 table N/F End

                //MESSAGE('%1',ROUND(34434.56,1));
                /*
                //QRCode
                IF Cust."GST Registration No." = '' THEN BEGIN
                  CLEAR(APIManagement);
                  "Transfer Shipment Header".CALCFIELDS("Transfer Shipment Header"."Amount to Customer");
                  amttocustomer := "Transfer Shipment Header"."Amount to Customer";
                  CompanyInformation.GET;
                  DynamicsPAYID := CompanyInformation."UPI ID"+'.'+DELCHR("Transfer Shipment Header"."No.",'=','/\-')+FORMAT("Transfer Shipment Header"."Posting Date",0,'<Day,2><Month,2><Year4>')+CompanyInformation."UPI Bank Payment Name";
                  //MESSAGE(DynamicsPAYID);
                  PaymentText := 'upi://pay?cu=INR&pa='+DynamicsPAYID+'&pn='+CompanyInformation."UPI Payment Name"+'&am='+FORMAT(amttocustomer)+'&tr='+"Sales Invoice Header"."No.";
                
                  APIManagement.CreateQRCode(PaymentText,TempBlob);
                END;
                //QRCode
                */

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
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
        //RepAuditMgt.CreateAudit(50317)
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
        //Location.RESET;
        //IF
        //IF Location.GET(CompanyInfo."Location Code") THEN BEGIN

        //END;
    end;

    var
        RowCount: Integer;
        OuputNos: Integer;
        copyText1: Text[50];
        ItemRec: Record Item;
        CHECK: Report "Check Report";
        DetailGSTEntryBuff: Record "Detailed GST Ledger Entry";
        InWords1: array[5] of Text;
        IGSTinWords: array[5] of Text;
        CGSTinWords: array[5] of Text;
        SGSTinWords: array[5] of Text;
        CRate: Decimal;
        CAmount: Decimal;
        SRate: Decimal;
        SAmount: Decimal;
        IRate: Decimal;
        IAmount: Decimal;
        CGSTTotal: Decimal;
        SGSTTotal: Decimal;
        IGSTTotal: Decimal;
        Location_tr: Record Location;
        RecVendors: Record Vendor;
        Trans_From_state: Text[50];
        Trans_TO_state: Text[50];
        InvoiceName: Text[100];
        Location1: Record Location;
        RecState1: Record State;
        RecState: Record State;
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        VATAmountLine: Record "VAT Amount Line" temporary;
        // PostedDocDim1: Record 359;
        // PostedDocDim2: Record 359;
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        CurrExchRate: Record "Currency Exchange Rate";
        Currency: Record Currency;
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        PostedShipmentDate: Date;
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        OrderNoText: Text[100];
        SalesPersonText: Text[30];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[100];
        ShowShippingAddr: Boolean;
        i: Integer;
        NextEntryNo: Integer;
        FirstValueEntryNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        CalculatedExchRate: Decimal;
        ChargesAmount: Decimal;
        OtherTaxesAmount: Decimal;
        //16225   PostedStrOrderLineDetails: Record "13798";
        "Corp-Addition------------": Integer;
        TccChargeAmount: Decimal;
        ChargePercentTCC: Decimal;
        BEDChargeAmount: Decimal;
        ChargePercentBED: Decimal;
        EcessChargeAmount: Decimal;
        ChargePercentEcess: Decimal;
        InsurenceChargeAmount: Decimal;
        ChargePercentIns: Decimal;
        CSTchargeAmount: Decimal;
        ChargePercentCST: Decimal;
        FrightChargeAmt: Decimal;
        SalesHeader: Record "Sales Header";
        BillToAddr: array[8] of Text[80];
        TempSalesLine: Record "Sales Line" temporary;
        AgentName: Text[40];
        SalesPersonRec: Record "Salesperson/Purchaser";
        CheckReport: Report "Check Report";
        NumberText: array[2] of Text[80];
        NumberText1: array[2] of Text[80];
        NumberText2: array[2] of Text[80];
        NumberText3: array[2] of Text[80];
        NumberText5: array[2] of Text[80];
        NumberText4: array[2] of Text[80];
        GenJnlLine: Record "Gen. Journal Line";
        TotalAmount: Decimal;
        Amt: Decimal;
        GTotal: Decimal;
        StateTable: Record State;
        StateDescription: Text[50];
        Location: Record Location;
        LocName: Text[50];
        LocAddress: Text[50];
        LocAddress2: Text[50];
        LocCity: Text[50];
        LocPhone: Text[30];
        "LocE-mail": Text[80];
        LocRst: Code[30];
        LocCst: Code[30];
        LocTin: Code[20];
        LocState: Text[30];
        "Cust TIN": Code[20];
        "Cust LST": Code[20];
        "Cust CST": Code[20];
        CompInfo: Record "Company Information";
        DimensionValue: Record "Dimension Value";
        Unit: Text[30];
        Hecess: Decimal;
        Hecesspercent: Decimal;
        Excisetotal: Decimal;
        Disctotal: Decimal;
        Item: Record Item;
        LotNo: Code[20];
        Bagtotal: Integer;
        salesinvoiceline: Record "Sales Invoice Line";
        Kgtotal: Decimal;
        Locpin: Code[10];
        ShippingAgent: Record "Shipping Agent";
        Shipingdes: Text[50];
        Cust1: Record Customer;
        challanno: Code[20];
        Salesshipment: Record "Sales Shipment Header";
        SalesInvoiceLine1: Record "Sales Invoice Line";
        TotalBed: Decimal;
        TotalEcess: Decimal;
        TotalShcess: Decimal;
        TotalTradeDisc: Decimal;
        TotalCashDic: Decimal;
        "AddCst/Vat": Option " ",VAT,CST;
        TaxArea: Record "Tax Area";
        TaxLineArea: Record "Tax Area Line";
        TaxJurisdiction: Record "Tax Jurisdiction";
        Location2: Record Location;
        IntRate: Decimal;
        Intdays: Text[50];
        Complaindays: Text[30];
        Juridiction: Text[30];
        InvoiceNotification: Text[200];
        Insurance: Text[100];
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        PaymentTerm: Text[50];
        ShipmentDes: Text[50];
        DueDate: Date;
        VatChargeAmount: Decimal;
        SalesInvoiceLine3: Record "Sales Invoice Line";
        A: Code[10];
        VatPercentAmount: Decimal;
        InvoiceDicount: Decimal;
        Customer: Record Customer;
        CustECCNo: Code[20];
        CustRange: Code[200];
        CustCommissionerate: Code[200];
        CustPANNo: Code[20];
        "CST%": Text[30];
        "VAT%": Text[30];
        "InvoiceDisc%": Text[30];
        "Insurance%": Text[30];
        "Cust.InvoiceDisc.": Record "Cust. Invoice Disc.";
        "TradeDic%": Text[30];
        TradePercente: Decimal;
        SalesInvoiceHeader4: Record "Sales Invoice Header";
        ShiptoAddress: Record "Ship-to Address";
        ShipEccNo: Code[20];
        ShipregNo: Code[20];
        ShipRange: Code[20];
        ShipCommissionerate: Code[20];
        ShipPanNo: Code[20];
        Customer1: Record Customer;
        BaleCharges: Decimal;
        LabourCharges: Decimal;
        OtherCharges: Decimal;
        "S.No.": Integer;
        TotalLineAmount: Decimal;
        CopyNo: Integer;
        PageTitle: Text[30];
        VAT: Code[20];
        //16225 ExcisePostingSetup: Record "13711";
        "BED%": Decimal;
        "eCess%": Decimal;
        "SHECess%": Decimal;
        SIL: Record "Sales Invoice Line";
        TraiffNo: Code[20];
        SalesOrderNo: Code[20];
        AmountinWord: array[2] of Text[100];
        GrandTotal: Decimal;
        Respcent: Record "Responsibility Center";
        RespCntrAddr: array[15] of Text[250];
        NoInText: array[10] of Text[250];
        ExInText: array[10] of Text[50];
        //16225ExcisePGP: Record "13710";
        BarCodeRequired: Boolean;
        SIH: Record "Sales Invoice Header";
        txt: Text[100];
        Range: Text[100];
        Division: Text[100];
        LineStop: Integer;
        Exessiblegoods: Decimal;
        //16225 "Excise Prod.Posting Group": Record "13710";
        Desc: Text[60];
        NOOFPKG: Decimal;
        //16225  ExciseProdPostingGroup: Record "13710";
        QTYPERPKG: Decimal;
        CLE: Record "Cust. Ledger Entry";
        VendorCode: Code[20];
        SINC: Record "Sales Invoice Line";
        Type1: Code[20];
        ItemPartNo: array[600] of Code[20];
        MSFNo: Code[20];
        SIHeader: Record "Sales Invoice Header";
        Roundoff: Decimal;
        Value: Decimal;
        Cart: Decimal;
        SqMt: Decimal;
        Wt: Decimal;
        LineDiscount: Decimal;
        DiscPerCart: Decimal;
        RateperCart: Decimal;
        Pcs: Decimal;
        BEDAmt: Decimal;
        ECess: Decimal;
        Pcsqty: Decimal;
        BuyersPrice: Decimal;
        BuyersRatePerSqMtr: Decimal;
        DiscPerSqmt: Decimal;
        Outstand: Decimal;
        QD: Decimal;
        QuantityDiscountEntry: Record "Quantity Discount Entry";
        AQD: Decimal;
        AmountinWord1: array[2] of Text[100];
        Recvendor: Record Vendor;
        DeleveryAdd: array[4] of Text[30];
        TextContinue: Text[30];
        AqdText: Text[30];
        QdText: Text[30];
        DimensionValue1: Record "Dimension Value";
        RecLoc: Record Location;
        AsseableValue: Decimal;
        QtyinSQM: Decimal;
        "------------------------------": Integer;
        SalesTaxAmt: Decimal;
        ChargeAmt: Decimal;
        InsuranceAmt: Decimal;
        OtherTaxes: Decimal;
        VATAmt: Decimal;
        TotalChargerAmt: Decimal;
        NetVal: Decimal;
        ECessAmt: Decimal;
        QuantityinSqMt: Decimal;
        QuantityinCartons: Decimal;
        NetWeight: Decimal;
        GenLegSetup: Record "General Ledger Setup";
        InvDisc: Decimal;
        ExciseAmt: Decimal;
        Taxtotal: Decimal;
        vendor1: Record Vendor;
        vname: Text[50];
        state1: Record State;
        stname: Text[50];
        GrossWieght: Decimal;
        ExAmt: Decimal;
        wt1: Decimal;
        CST: Text[50];
        Policy: Text[200];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Sales - Invoice %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        Text13700: Label 'Total %1 Incl. Taxes';
        Text13701: Label 'Total %1 Excl. Taxes';
        Text13706: Label 'Assesable Value is calculated @ 55% of MRP';
        Text13705: Label 'Freight :';
        Text13704: Label 'Since 01st May,2017 the Goods in transit are insured under Marine insurance with The New India Assurance Co. Limited, LCBO, New Delhi';
        NewPolicy: Label 'Since 01st May,2017 the Goods in transit are insured under Marine insurance with The New India Assurance Co. Limited, LCBO, New Delhi';
        DocNoNew: Code[20];
        //16225 PostStrOrdLineDet: Record "13798";
        InsuranceAmt1: Decimal;
        round: Decimal;
        Sno: Integer;
        rowstogen: Integer;
        PageBreak1: Integer;
        IncRowas: Integer;
        PageCont: Integer;
        StateRec: Record State;
        APIManagement: Codeunit "API Management -EY 2.6";
        // TempBlob: Record "Upgrade Blob Storage" temporary;
        PaymentText: Text;
        TotalNoOfInvoiceLines: Integer;
        HideCarriedForward: Boolean;
        CarriedForLbl: Label 'Carried Forward :';
        BroughtForLbl: Label 'Brought Forward :';

    procedure GetPartNo(TransferShipLine: Record "Transfer Shipment Line"): Code[20]
    var
        Item: Record Item;
        // ItemCrossRef: Record "Item Cross Reference";
        TransferShipHdr: Record "Transfer Shipment Header";
    begin
        /*
        IF Item.GET("Sales Invoice Line"."No.") THEN BEGIN
          ItemCrossRef.RESET();
          ItemCrossRef.SETRANGE("Item No.",Item."No.");
          ItemCrossRef.SETRANGE("Cross-Reference Type",ItemCrossRef."Cross-Reference Type"::Customer);
          ItemCrossRef.SETRANGE("Cross-Reference Type No.",SalesInvLine."Sell-to Customer No.");
          ItemCrossRef.SETFILTER("Cross-Reference No.",'<>%1','');
          IF ItemCrossRef.FINDFIRST THEN BEGIN
            EXIT(ItemCrossRef."Cross-Reference No.");
          END;
        END;
        */

    end;
}

