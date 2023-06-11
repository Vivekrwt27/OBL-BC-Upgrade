report 50148 "Purchase Debit Memo"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\PurchaseDebitMemo.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; 124)
        {
            RequestFilterFields = "No.";
            column(LOC_GST_No; locationRec."GST Registration No.")
            {
            }
            column(Vend_GST_No; VendorRec."GST Registration No.")
            {
            }
            column(No_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."No.")
            {
            }
            column(PostingDate_PurchCrMemoHdr; FORMAT("Purch. Cr. Memo Hdr."."Posting Date"))
            {
            }
            column(BuyfromVendorName_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Buy-from Vendor Name")
            {
            }
            column(BuyfromVendorName2_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Buy-from Vendor Name 2")
            {
            }
            column(BuyfromAddress_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Buy-from Address")
            {
            }
            column(BuyfromAddress2_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Buy-from Address 2")
            {
            }
            column(BuyfromCity_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Buy-from City")
            {
            }
            column(PostingDescription_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Posting Description")
            {
            }
            column(Ph; Ph)
            {
            }
            column(Fax; Fax)
            {
            }
            column(CompanyName1; CompanyName1)
            {
            }
            column(Desc1; Desc1)
            {
            }
            column(KText; KText)
            {
            }
            column(Dwsc; GroupCode.Description + ' ' + GroupCode.Description2)
            {
            }
            column(Stateadesc; Stateadesc)
            {
            }
            column(TIN_CustomerTINNo; 'TIN  : ' + CustomerTINNo)
            {
            }
            column(TINNo; "TINNo.")
            {
            }
            column(Location_CST_No; Location."C.S.T. No.")
            {
            }
            column(LocAdd; Address)
            {
            }
            column(LocEcc; '') // 16630 blank ECCRec.Description
            {
            }
            column(ECCNODESC; ECCNODESC)
            {
            }
            column(CST; CST)
            {
            }
            column(ecc; ecc)
            {
            }
            column(sno; sno)
            {
            }
            column(BEDAMT1; BEDAMT1)
            {
            }
            column(Totamt; Totamt + BEDAMT1)
            {
            }
            column(OtherTaxes; OtherTaxes)
            {
            }
            column(tgcstper; tgcstper)
            {
            }
            column(CstTot; CstTot)
            {
            }
            column(tgvatper; tgvatper)
            {
            }
            column(VatTot; VatTot)
            {
            }
            column(tgaddPer; tgaddPer)
            {
            }
            column(AdditionalTot; AdditionalTot)
            {
            }
            column(Rounoff; Rounoff)
            {
            }
            column(NoText1; NoText[1])
            {
            }
            column(NoText2; NoText[2])
            {
            }
            column(Remarks; 'Remarks : -' + ' ' + "Purch. Cr. Memo Hdr."."Posting Description")
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoCity; CompanyInfo.City)
            {
            }
            column(Vencrmemo; "Purch. Cr. Memo Hdr."."Vendor Invoice No.")
            {
            }
            column(vendor_inv_date; FORMAT("Purch. Cr. Memo Hdr."."Vendor Invoice Date"))
            {
            }
            column(Truck_no; "Purch. Cr. Memo Hdr."."Truck No.")
            {
            }
            column(gr_no; "Purch. Cr. Memo Hdr."."GR No.")
            {
            }
            column(CRate; CRate)
            {
            }
            column(CAmount; CAmount1)
            {
            }
            column(SRate; SRate)
            {
            }
            column(SAmount; SAmount1)
            {
            }
            column(URate; URate)
            {
            }
            column(UAmount; UAmount1)
            {
            }
            column(IRate; IRate)
            {
            }
            column(IAmount; IAmount1)
            {
            }
            dataitem("Purch. Cr. Memo Line"; 125)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Quantity = FILTER(<> 0));
                column(TotalGSTAmt; TotalGSTAmt)
                {
                }
                column(Description_PurchCrMemoLine; "Purch. Cr. Memo Line".Description)
                {
                }
                column(Description2_PurchCrMemoLine; "Purch. Cr. Memo Line"."Description 2")
                {
                }
                column(hsn; "Purch. Cr. Memo Line"."HSN/SAC Code")
                {
                }
                column(Quantity_PurchCrMemoLine; "Purch. Cr. Memo Line".Quantity)
                {
                }
                column(UnitofMeasureCode_PurchCrMemoLine; "Purch. Cr. Memo Line"."Unit of Measure Code")
                {
                }
                column(UnitCostLCY_PurchCrMemoLine; "Purch. Cr. Memo Line"."Unit Cost (LCY)")
                {
                }
                column(Amount_PurchCrMemoLine; "Purch. Cr. Memo Line".Amount)
                {
                }
                column(BEDAmount_PurchCrMemoLine; 0)// 16630 replace BED Amount
                {
                }
                column(AmountToVendor_PurchCrMemoLine; ROUND(TotalAmount, 1)) // 16630 "Purch. Cr. Memo Line"."Amount To Vendor"
                {
                    IncludeCaption = false;
                }
                column(TaxChargeType; 0)
                {
                }
                column(TaxChargeCode; 0)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    TotalAmount := GetAmttoVendorPostedLine("Document No.", "Purch. Cr. Memo Line"."Line No.");
                    sno := sno + 1;
                end;

                trigger OnPreDataItem()
                begin
                    sno := 0;
                end;
                /* 16630 dataitem(DataItem1000000002; 13798)
                 {
                     DataItemLink = "Invoice No." = FIELD("No.");
                     DataItemTableView = SORTING("Tax/Charge Type", "Tax/Charge Code")
                                         ORDER(Ascending)
                                         WHERE(Type = FILTER(Sale));
                     column(TaxChargeType; "Posted Str Order Line Details"."Tax/Charge Type")
                     {
                     }
                     column(TaxChargeCode; "Posted Str Order Line Details"."Tax/Charge Code")
                     {
                     }
                 }

                 trigger OnAfterGetRecord()
                 begin*/

                //GST
                /*
                CRate := 0;
                SRate := 0;
                IRate := 0;
                URate :=0;
                CAmount:= 0;
                SAmount := 0;
                IAmount := 0;
                UAmount := 0;

                DetailedGSTLedgerEntry.RESET;
                DetailedGSTLedgerEntry.SETRANGE("Document No.","Document No.");
                DetailedGSTLedgerEntry.SETRANGE("No.","No.");
                DetailedGSTLedgerEntry.SETRANGE("Document Line No.","Line No.");
                IF DetailedGSTLedgerEntry.FINDFIRST THEN REPEAT
                  IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                      CRate := DetailedGSTLedgerEntry."GST %";
                      CAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                      CAmount1+=CAmount;
                 END;

                  IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                      SRate := DetailedGSTLedgerEntry."GST %";
                      SAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                      SAmount1+=SAmount
                 END;

                  IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                      IRate := DetailedGSTLedgerEntry."GST %";
                      IAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                      IAmount1+=IAmount;
                 END;

                  IF DetailedGSTLedgerEntry."GST Component Code" = 'UTGST' THEN BEGIN
                      URate := DetailedGSTLedgerEntry."GST %";
                      UAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                      //IAmount1+=IAmount;
                 END;

                   UNTIL
                      DetailedGSTLedgerEntry.NEXT = 0;



                TypeName := '';
                SizeName := '';
                TypeDesc := '';*/
                /*
               InventorySetup.GET;
               IF DimensionValue.GET(InventorySetup."Size Code","Size Code") THEN
                 SizeName := DimensionValue.Name;
               IF DimensionValue.GET(InventorySetup."Type Code","Type Code") THEN
                 TypeName := DimensionValue.Name;
               IF DimensionValue.GET(InventorySetup."Packing Code","Packing Code") THEN
                 PackingName := DimensionValue.Name;
                */
                /*    sno := sno + 1;


                    //TRI 22.02.08 N.K Add Start
                    ItemType.SETRANGE(ItemType."No.", "Purch. Cr. Memo Line"."No.");
                    IF ItemType.FIND('-') THEN*/
                //TRI 22.02.08 N.K Add Stop

                //TRI NM 170308 Add Start
                /*
                DimensionValue.RESET;
                DimensionValue.SETFILTER("Dimension Code",'=%1','CATG');
                DimensionValue.SETRANGE(Code,"Type Catogery Code");
                IF DimensionValue.FINDFIRST THEN
                  TypeDesc := DimensionValue.Name;
                //TRI NM 170308 Add Stop
                //MESSAGE('%1',("Sales Invoice Line"."Amount To Customer"));
                 */

                //SubTotal := Value-"Inv. Discount Amount";
                //SubTotal := Value-InvDisc;                     // anurag

                //MIPLRK10082021>>>
                /*      PostedStrOrderLineDetails.RESET;
                  PostedStrOrderLineDetails.SETCURRENTKEY("Invoice No.", "Item No.");
                  PostedStrOrderLineDetails.SETFILTER("Tax/Charge Type", '%1', PostedStrOrderLineDetails."Tax/Charge Type"::Charges);
                  PostedStrOrderLineDetails.SETRANGE("Invoice No.", "Purch. Cr. Memo Line"."Document No.");
                  PostedStrOrderLineDetails.SETRANGE("Item No.", "Purch. Cr. Memo Line"."No.");
                  IF PostedStrOrderLineDetails.FINDFIRST THEN BEGIN
                      IF PostedStrOrderLineDetails."Tax/Charge Group" = 'PACKING' THEN BEGIN
                          OtherTaxes := PostedStrOrderLineDetails."Calculation Value";
                      END;
                  END;
                  //MIPLRK10082021<<<
                  ExciseAmt := "Purch. Cr. Memo Line"."Excise Amount";
                  BEDAmt := "Purch. Cr. Memo Line"."BED Amount";
                  ECessAmt := "Purch. Cr. Memo Line"."eCess Amount";
                  SubTotal := Value; //tri



                  Totamt += Amount;
                  //BEDAMT1+=ABS("Purch. Cr. Memo Line"."BED Amount");
                  BEDAMT1 += ABS("Purch. Cr. Memo Line"."Excise Amount");*

              end;*/ // 16630
            }

            trigger OnAfterGetRecord()
            begin

                IF locationRec.GET("Location Code") THEN;
                IF VendorRec.GET("Pay-to Vendor No.") THEN;

                /*    IF "Purch. Cr. Memo Hdr.".State = '14' THEN
                        KText := 'The Kerala Value Added Tax Rules - 2005, TAX INVOICE FORM NO 8'
                    ELSE
                        KText := '';*/

                IF Location.GET("Location Code") THEN BEGIN
                    Location.CALCFIELDS("State Code Desc");
                    Address := Location.Address + ', ' + Location."Address 2" + ', ' + Location.City + ', ' + Location."State Code Desc";
                    Ph := Location."Phone No." + ', ' + Location."Phone No. 2";
                    Fax := Location."Fax No.";
                END;

                // 16630   IF ECCRec.GET(Location."E.C.C. No.") THEN;
                //CurrReport.SHOWOUTPUT(FALSE);

                //TRI N.K 22.02.08 Add Start
                //GroupCode.SETRANGE(GroupCode."Group Code","Purch. Cr. Memo Hdr."."Group Code");
                //IF GroupCode.FIND('-')THEN
                //TRI N.K 22.02.08 Add Stop

                /*
               //MS-PB BEGIN
               Location.RESET;
               Location.SETRANGE(Code,"Location Code");
               IF Location.FINDFIRST THEN
               HeaderTextLatest:=DocumentPrint.PrintInvoiceType("Purch. Cr. Memo Hdr.",Location);
               IF HeaderTextLatest='VAT/TAX Invoice' THEN
                  Taxstat := 'Input Tax Credit Available On this Invoice Only'

               //MS-PB END;
                */


                /*   IF Location.GET("Location Code") THEN
                       ECCNO := Location."E.C.C. No.";
                   LocationState := Location."State Code";
                   ECCNos.RESET;
                   ECCNos.SETRANGE(ECCNos.Code, ECCNO);
                   IF ECCNos.FINDFIRST THEN
                       ECCNODESC := ECCNos.Description;*/ // 16630
                IF Vendor.GET("Purch. Cr. Memo Hdr."."Buy-from Vendor No.") THEN
                    Vendorstatecode := Vendor."State Code";
                // 16630 VendorTIN := Vendor."T.I.N. No.";
                IF (LocationState = Vendorstatecode) AND (VendorTIN <> '') THEN
                    Desc1 := 'Material Return Note / Debit Note'
                ELSE
                    Desc1 := 'Material Return Note / Debit Note';
                //CurrReport.SHOWOUTPUT(FALSE); //Vipul

                /* IF Customer.GET("Sell-to Customer No.") THEN BEGIN
                     LST := Customer."L.S.T. No.";
                     CST := Customer."C.S.T. No.";
                     Customer.CALCFIELDS(Customer.Balance);
                     Outstand := ROUND((Customer.Balance), 1, '=');

                 END;
                 sno := 0;

                 IF Vendor.GET("Buy-from Vendor No.") THEN BEGIN
                     LST := Vendor."L.S.T. No.";
                     CST := Vendor."C.S.T. No.";
                     ecc := Vendor."E.C.C. No.";
                     CustomerTINNo := Vendor."T.I.N. No.";
                     RecState.RESET;
                     RecState.SETRANGE(RecState.Code, Vendor."State Code");
                     IF RecState.FINDFIRST THEN
                         Stateadesc := RecState.Description;
                 END;*/ // 16630
                        //sno := 0;

                // Start Sanjay 03/12/2015
                // END; Sanjay 03/12/2015
                //IF CompanyInfo.GET THEN                           //Anurag
                //  "TINNo." := CompanyInfo."T.I.N. No.";           //Anurag
                /*  IF tin_no1.GET(Location."T.I.N. No.") THEN          //Anurag
                      "TINNo." := tin_no1.Description;              //Anurag

                  DetailedTaxEntry.RESET;
                  DetailedTaxEntry.SETRANGE("Document No.", "Purch. Cr. Memo Hdr."."No.");
                  IF DetailedTaxEntry.FINDFIRST THEN
                      REPEAT
                          DetailedTaxEntry.CALCFIELDS("Additional Tax");
                          IF DetailedTaxEntry."Tax Type" = DetailedTaxEntry."Tax Type"::CST THEN BEGIN
                              IF NOT DetailedTaxEntry."Additional Tax" THEN BEGIN
                                  CstTot := CstTot + (-DetailedTaxEntry."Tax Amount");
                                  CstPercent := DetailedTaxEntry."Tax %";
                                  tgcstper := FORMAT(CstPercent) + '  %';
                              END ELSE BEGIN
                                  AdditionalTot := AdditionalTot + (-DetailedTaxEntry."Tax Amount");
                                  AdditionalPercent := DetailedTaxEntry."Tax %";
                                  tgaddPer := FORMAT(AdditionalPercent) + '  %';
                              END;
                          END;

                          IF DetailedTaxEntry."Tax Type" = DetailedTaxEntry."Tax Type"::VAT THEN BEGIN
                              IF NOT DetailedTaxEntry."Additional Tax" THEN BEGIN
                                  VatTot := VatTot + (-DetailedTaxEntry."Tax Amount");
                                  VatPercent := DetailedTaxEntry."Tax %";
                                  tgvatper := FORMAT(VatPercent) + '  %';
                              END ELSE BEGIN
                                  AdditionalTot := AdditionalTot + (-DetailedTaxEntry."Tax Amount");
                                  AdditionalPercent := DetailedTaxEntry."Tax %";
                                  tgaddPer := FORMAT(AdditionalPercent) + '  %';
                              END;
                          END;

                      UNTIL DetailedTaxEntry.NEXT = 0;*/ // 16630
                                                         //TRI RK 21.04.10 Add End


                //MESSAGE('%1..%2',ROUND(("Sales Invoice Line"."Amount To Customer"),1,'='),("Sales Invoice Line"."Amount To Customer"));
                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NoTextExcise, ExciseAmt, '');

                CheckReport.InitTextVariable;
                //CheckReport.FormatNoText(NoText,ROUND((SubTotal+Taxtotal-InvDisc),1,'>'),'');
                //MS-PB CheckReport.FormatNoText(NoText,ROUND((SubTotal +ChargeAmt+ CstTot +VatTot+AdditionalTot + InvDisc+InsuranceAmt),1,'>'),'');
                CheckReport.FormatNoText(NoText, ROUND((TotalAmount), 1, '='), ''); // 16630 "Purch. Cr. Memo Hdr."."Amount to Vendor" replace by totalamt

                CompanyInfo.GET;
                WorkAddress := 'Regd Office    : ' + CompanyInfo.Address + ' ' + CompanyInfo."Address 2" + ' ' + CompanyInfo.City;

                //----
                CRate := 0;
                SRate := 0;
                IRate := 0;
                URate := 0;
                CAmount1 := 0;
                SAmount1 := 0;
                IAmount1 := 0;
                UAmount1 := 0;

                DetailedGSTLedgerEntry.RESET;
                DetailedGSTLedgerEntry.SETRANGE("Document No.", "No.");
                //DetailedGSTLedgerEntry.SETRANGE("No.","No.");
                //DetailedGSTLedgerEntry.SETRANGE("Document Line No.","Line No.");
                IF DetailedGSTLedgerEntry.FINDFIRST THEN
                    REPEAT
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                            CRate := DetailedGSTLedgerEntry."GST %";
                            CAmount1 += ABS(DetailedGSTLedgerEntry."GST Amount");
                            //CAmount1+=CAmount;
                        END;

                        IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                            SRate := DetailedGSTLedgerEntry."GST %";
                            SAmount1 += ABS(DetailedGSTLedgerEntry."GST Amount");
                            //SAmount1+=SAmount
                        END;

                        IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                            IRate := DetailedGSTLedgerEntry."GST %";
                            IAmount1 += ABS(DetailedGSTLedgerEntry."GST Amount");
                            //IAmount1+=IAmount;
                        END;

                        IF DetailedGSTLedgerEntry."GST Component Code" = 'UTGST' THEN BEGIN
                            URate := DetailedGSTLedgerEntry."GST %";
                            UAmount1 += ABS(DetailedGSTLedgerEntry."GST Amount");
                            //IAmount1+=IAmount;
                        END;

                    UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                //--

            end;

            trigger OnPreDataItem()
            begin

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
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        VendorRec: Record Vendor;
        locationRec: Record Location;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CRate: Decimal;
        CAmount: Decimal;
        SRate: Decimal;
        SAmount: Decimal;
        IRate: Decimal;
        IAmount: Decimal;
        URate: Decimal;
        UAmount: Decimal;
        TotalGSTAmt: Decimal;
        GSTTotal: Decimal;
        CAmount1: Decimal;
        SAmount1: Decimal;
        IAmount1: Decimal;
        TotalGSTAmount: Decimal;
        Customer: Record Customer;
        RateperCart: Decimal;
        DiscPerCart: Decimal;
        Item: Record Item;
        Value: Decimal;
        SubTotal: Decimal;
        Taxtotal: Decimal;
        Netamt: Decimal;
        Location: Record Location;
        Address: Text[250];
        Ph: Text[100];
        Fax: Text[100];
        OurTIN: Code[50];
        CheckReport: Report "Check Report";
        NoText: array[2] of Text[80];
        ExciseAmt: Decimal;
        NoTextExcise: array[2] of Text[80];
        LST: Code[100];
        CST: Code[100];
        ecc: Code[30];
        CustomerTINNo: Text[30];
        ChargeAmt: Decimal;
        SalesTaxAmt: Decimal;
        OtherTaxes: Decimal;
        VATAmt: Decimal;
        InsuranceAmt: Decimal;
        BEDAmt: Decimal;
        ECessAmt: Decimal;
        FormCode: Text[50];
        FormNo: Text[50];
        // 16630 FormCodes: Record 13756;
        ExciseLabel: array[2] of Text[50];
        ExciseText: array[2] of Decimal;
        sno: Integer;
        GenLegSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        CompanyName1: Text[100];
        "TINNo.": Text[30];
        TypeName: Text[50];
        SizeName: Text[50];
        PackingName: Text[50];
        DimensionValue: Record "Dimension Value";
        InventorySetup: Record "Inventory Setup";
        WorkAddress: Text[250];
        PhoneNo: Integer;
        Cart: Decimal;
        Sqmt: Decimal;
        Wt: Decimal;
        DiscPerSqmt: Decimal;
        BuyersPrice: Decimal;
        BuyersRatePerSqMtr: Decimal;
        // 16630 tin_no1: Record 13701;
        i: Integer;
        TaxAreaLine: Record "Tax Area Line";
        TaxDetails: Record "Tax Detail";
        JudText: array[3] of Code[50];
        PerJud: array[3] of Decimal;
        SalesInvLine1: Record "Sales Invoice Line";
        tgVat: Decimal;
        Pcs: Decimal;
        GroupCode: Record "Item Group";
        ItemType: Record Item;
        TypeCatogeryCode: Code[10];
        TypeDesc: Text[30];
        InvDisc: Decimal;
        InsDisc: Decimal;
        DecSubtotal: Decimal;
        "---------TRI------": Integer;
        // 16630  DetailedTaxEntry: Record 16522;
        CstTot: Decimal;
        AdditionalTot: Decimal;
        VatTot: Decimal;
        VatPercent: Decimal;
        AdditionalPercent: Decimal;
        CstPercent: Decimal;
        tgvatper: Text[30];
        tgaddPer: Text[30];
        tgcstper: Text[30];
        Outstand: Decimal;
        CompanyName2: Text[100];
        QuantityDiscountEntry: Record "Quantity Discount Entry";
        QD: Decimal;
        AQD: Decimal;
        LineDis: Decimal;
        DecRate: Decimal;
        AqdText: Text[30];
        QdText: Text[30];
        KText: Text[100];
        DocumentPrint: Codeunit "Document-Print";
        HeaderTextLatest: Text[100];
        Rounoff: Decimal;
        "---------": Integer;
        FileDir: Text[100];
        FileName: Text[100];
        ReportID: Integer;
        // "Object": Record Object;
        DefaultPrinter: Text[200];
        Window: Dialog;
        WindowisOpen: Boolean;
        mycust: Record Customer;
        mymail: Codeunit Mail;
        testFile: Boolean;
        SIH: Record "Sales Invoice Header";
        Numb: Code[20];
        SaveAsPDF: Boolean;
        // 16630 SMTPMail: Codeunit 400;
        n: Integer;
        chrLineBreak: Char;
        FilNam: Text[30];
        QcText: Text[30];
        Taxstat: Text[100];
        isvat: Boolean;
        Policy: Text[500];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Totamt: Decimal;
        Vendor: Record Vendor;
        ECCNO: Code[20];
        // 16630 ECCNos: Record 13708;
        ECCNODESC: Text[30];
        RecState: Record State;
        Stateadesc: Text[30];
        BEDAMT1: Decimal;
        Vendorstatecode: Code[10];
        VendorTIN: Code[20];
        LocationState: Code[20];
        Desc1: Text[100];
        Text50000: Label 'Dear Customer, <br/> <br/> ';
        Text50001: Label 'Enclosed please find the computer generated invoice :';
        Text50002: Label ' against the order placed by you. <br/> <br/> ';
        Text50003: Label 'This is for your records. Kindly acknowledge the receipt.';
        Text50004: Label 'Regards, <br/> <br/> ';
        Text50005: Label 'Orient Bell Ltd. <br/> <br/> ';
        Text50006: Label 'Iris House, 16 Business Center, Nangal Raya <br/> <br/> ';
        Text50007: Label 'New Delhi 110046, India<br/> <br/> ';
        Text50008: Label 'Tel:   +91 11 4711 9100<br/> <br/> ';
        Text50009: Label 'Fax:  +91 11 2852 1273<br/> <br/> ';
        Text50010: Label ' <br/> <br/> ';
        NewPolicy: Label 'Since 01st July, 2015, the Goods in transit are insured under Marine insurance Policy No. 1112002115P103605333  with United India Insurance Co. Ltd., Rohtak. "';
        // 16630 ECCRec: Record 13708;
        UAmount1: Decimal;
        IGSTAmt: Decimal;
        IGSTper: Decimal;
        SGSTAmt: Decimal;
        SGSTper: Decimal;
        CGSTAmt: Decimal;
        CGSTper: Decimal;
        GSTBaseAmt: Decimal;
        TotalAmount: Decimal;
        LineAmt: Decimal;
        RecDGLE: Record "Detailed GST Ledger Entry";
    // 16630 PostedStrOrderLineDetails: Record 13798;

    procedure GetAmttoVendorPostedLine(DocumentNo: Code[20]; DocLineNo: Integer): Decimal
    var
        PstdPurchInv: Record 123;
        PstdPurchCrMemoLine: Record 125;
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
        IF DetGstLedEntry.FINDFIRST THEN begin
            IGSTAmt := abs(DetGstLedEntry."GST Amount");
            //GSTBaseAmt := abs(DetGstLedEntry."GST Base Amount");
        end;



        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'SGST');
        IF DetGstLedEntry.FINDFIRST THEN
            SGSTAmt := abs(DetGstLedEntry."GST Amount");

        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            CGSTAmt := abs(DetGstLedEntry."GST Amount");
            // GSTBaseAmt := abs(DetGstLedEntry."GST Base Amount");
        end;

        if PstdPurchCrMemoLine.Get(DocumentNo, DocLineNo) then begin
            if PstdPurchCrMemoLine.Type <> PstdPurchCrMemoLine.Type::" " then
                LineAmt := PstdPurchCrMemoLine."Line Amount";
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PstdPurchCrMemoLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetRange("Value ID", 7);
            //TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindFirst() then
                TDSAmt := TaxTransactionValue.Amount;
        end;

        if PstdPurchInv.Get(DocumentNo, DocLineNo) then begin
            if PstdPurchInv.Type <> PstdPurchInv.Type::" " then
                LineAmt := PstdPurchInv."Line Amount";
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PstdPurchInv.RecordId);
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
    end;//
}

