report 50189 "Commercial Invoice"
{
    // 
    // //TRI H.B 12.04.06 - new report Created.
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\CommercialInvoice.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(CurrCode; CurrCode)
            {
            }
            column(Outstand; Outstand)
            {
            }
            column(Phone; 'Phone No : 28521206,11')
            {
            }
            column(Fax; 'Fax : 28521273')
            {
            }
            column(Company_Name; CompanyName1)
            {
            }
            column(Address; 'Sales Depot : ' + Address)
            {
            }
            column(Invoice_No; "No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(CommercialInvoice; 'Retail/Sale/Commercial Invoice')
            {
            }
            column(GroupCodeDescription2; GroupCode.Description + ' ' + GroupCode.Description2)
            {
            }
            column(SelltoCustomerName; "Sell-to Customer Name")
            {
            }
            column(SellToCustomerName2; "Sell-to Customer Name 2")
            {
            }
            column(SelltoAddress; "Sell-to Address")
            {
            }
            column(SelltoAddress2; "Sell-to Address 2")
            {
            }
            column(SellToCity; "Sell-to City" + ' - ' + "State name")
            {
            }
            column(OrderNo; "Order No.")
            {
            }
            column(TruckNo; "Truck No.")
            {
            }
            column(OrderDate; "Order Date")
            {
            }
            column(Sell; "Sell-to City")
            {
            }
            column(CINNo; 'CIN No. L14101UP1977PLC021546')
            {
            }
            column(GRNo; "GR No.")
            {
            }
            column(GRDate; "GR Date")
            {
            }
            column(LST_No; LST)
            {
            }
            column(CST_No; CST)
            {
            }
            column(TransporterName; "Transporter Name")
            {
            }
            column(ShipToName2; "Sales Invoice Header"."Ship-to Name 2")
            {
            }
            column(ShipToAddress; "Sales Invoice Header"."Ship-to Address")
            {
            }
            column(ShipToAddress2; "Sales Invoice Header"."Ship-to Address 2")
            {
            }
            column(ShiptoCity; "Ship-to City" + ' - ' + "Ship-to Post Code")
            {
            }
            column(Statename; "State name")
            {
            }
            column(TINNo; "TINNo.")
            {
            }
            column(Location_CSTNo; Location."C.S.T. No.")
            {
            }
            column(Customer_PANNo; Customer."P.A.N. No.")
            {
            }
            //16225 column(Customer_TINNo; Customer."T.I.N. No.")
            column(Customer_TINNo; Customer."Old TIN")
            {
            }
            column(GR_No; "GR No.")
            {
            }
            column(GR_Date; "GR Date")
            {
            }
            column(NoText11; NoText[1])
            {
            }
            column(NoText22; NoText[2])
            {
            }
            column(Rs1; 'Rs' + ' ' + FORMAT(Outstand) + ' ' + '(' + 'Including this Invoice' + ')')
            {
            }
            column(policy11; policy)
            {
            }
            //16225column(SubTotal11; SubTotal + Taxtotal - InvDisc - InsDisc - ROUND("Sales Invoice Line"."Excise Amount", 1, '='))
            column(SubTotal11; SubTotal + Taxtotal - InvDisc - InsDisc - ROUND("Sales Invoice Line"."Amount", 1, '='))
            {
            }
            column(A; 0.0)
            {
            }
            //16225 column(SubTotal111; ROUND((SubTotal + Taxtotal - InvDisc - InsDisc), 1, '=') - ROUND("Sales Invoice Line"."Excise Amount", 1, '='))
            column(SubTotal111; ROUND((SubTotal + Taxtotal - InvDisc - InsDisc), 1, '=') - ROUND("Sales Invoice Line"."Amount", 1, '='))
            {
            }
            dataitem("Sales Invoice Line"; 113)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Quantity = FILTER(<> 0));
                column(SubTotalNew1; SubTotalNew1)
                {
                }
                column(sno1; sno)
                {
                }
                column(Description; Description + ' ' + "Description 2")
                {
                }
                column(TypeDesc1; TypeDesc)
                {
                }
                column(Quantity1; Quantity)
                {
                }
                column(UnitofMeasureCode; "Unit of Measure Code")
                {
                }
                column(Sqmt1; Sqmt)
                {
                }
                column(DiscPerSqmt1; DiscPerSqmt)
                {
                }
                column(BuyersRatePerSqMtr1; BuyersRatePerSqMtr)
                {
                }
                //16225 column(SaleInvoiceLineMRPPrice; "Sales Invoice Line"."MRP Price")
                column(SaleInvoiceLineMRPPrice; "Sales Invoice Line"."Unit Price")
                {
                }
                column(Value; Value)
                {
                }
                column(Cart1; Cart)
                {
                }
                column(Pcsqty; Pcsqty)
                {
                }
                column(GrossWeight; "Sales Invoice Line"."Gross Weight")
                {
                }
                column(PhoneNo; 'E-Mail:customercare@orientbell.com, Website:www.orientbell.com')
                {
                }

                trigger OnAfterGetRecord()
                begin

                    Cart := Item.UomToCart("No.", "Unit of Measure Code", Quantity);
                    Sqmt := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);
                    Pcsqty := ROUND(Item.UomToPcs("No.", "Unit of Measure Code", Quantity), 1, '<');
                    Wt := "Sales Invoice Line"."Gross Weight";

                    //IF Cart <> 0 THEN
                    //  RateperCart := "Unit Price"*Quantity/Cart;

                    //IF Cart <> 0 THEN
                    //  DiscPerCart := "Line Discount Amount"/Cart;
                    //Value := Cart * (RateperCart - DiscPerCart);

                    IF Quantity <> 0 THEN;
                    //16225 BuyersPrice := (Amount + "Excise Amount") / Quantity;

                    //MS-PB BEGIN 09.10.2012
                    //Remove QD Line wise, Discussed with Mr. Ravindra 09/10/2012

                    IF Sqmt <> 0 THEN BEGIN
                        BuyersRatePerSqMtr := BuyersPrice * Quantity / Sqmt;
                        DiscPerSqmt := "Line Discount Amount" / Sqmt;
                    END;
                    IF "Quantity in Sq. Mt." <> 0 THEN BEGIN
                        DecRate := ("Quantity Discount Amount" / "Quantity in Sq. Mt.");
                        LineDis := ("Line Discount Amount" / "Quantity in Sq. Mt.");
                    END;
                    BuyersRatePerSqMtr += DecRate;
                    /*IF Sqmt <> 0 THEN BEGIN
                      BuyersRatePerSqMtr := (BuyersPrice * Quantity / Sqmt)+LineDis;
                      DiscPerSqmt := "Line Discount Amount"/Sqmt;
                    END;
                    //  Message(Format(LineDis)) ;
                    */
                    //Value := Amount + "Excise Amount";/
                    Value := (BuyersRatePerSqMtr * "Quantity in Sq. Mt.");

                    SubTotalNew1 += Value - "Inv. Discount Amount";
                    //MS-PB END 09.10.2012

                    QD += "Quantity Discount Amount" - "Accrued Discount";
                    IF QD <> 0 THEN
                        QdText := 'QD DISCOUNT';
                    AQD += "Accrued Discount";
                    IF AQD <> 0 THEN
                        AqdText := 'AQD DISCOUNT';

                    TypeName := '';
                    SizeName := '';

                    InventorySetup.GET;
                    IF DimensionValue.GET(InventorySetup."Size Code", "Size Code") THEN
                        SizeName := DimensionValue.Name;
                    IF DimensionValue.GET(InventorySetup."Type Code", "Type Code") THEN
                        TypeName := DimensionValue.Name;
                    IF DimensionValue.GET(InventorySetup."Packing Code", "Packing Code") THEN
                        PackingName := DimensionValue.Name;

                    sno := sno + 1;

                    TypeDesc := '';
                    //TRI NM 170308 Add Start
                    DimensionValue.RESET;
                    DimensionValue.SETFILTER(DimensionValue."Dimension Code", '=%1', 'CATG');
                    DimensionValue.SETRANGE(DimensionValue.Code, "Type Catogery Code");
                    IF DimensionValue.FINDFIRST THEN
                        TypeDesc := DimensionValue.Name;
                    //TRI NM 170308 Add Stop



                    SubTotal := Value - "Inv. Discount Amount";
                    //SubTotal := Value-InvDisc;                     // anurag
                    //16225 Start
                    /*ExciseAmt := "Sales Invoice Line"."Excise Amount";
                     BEDAmt := "Sales Invoice Line"."BED Amount";
                     ECessAmt := "Sales Invoice Line"."eCess Amount";
                     ///MESSAGE('%1',SubTotalNew1);
                     ExAmt += "Sales Invoice Line"."Excise Amount";*///16225 end

                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(Value, Cart, Sqmt, Wt, Pcsqty);
                end;
            }
            /* dataitem(DataItem1000000002; 13798)
             {
                 DataItemLink = Invoice No.=FIELD(No.);
                 DataItemTableView = SORTING(Tax/Charge Type, Tax/Charge Code)
                                     ORDER(Ascending)
                                     WHERE(Type = FILTER(Sale),
                                           Document Type=FILTER(Invoice));
                 column(OtherTaxes1;OtherTaxes)
                 {
                 }
                 column(VATAmt1;VATAmt)
                 {
                 }
                 column(FormCode1;FormCode)
                 {
                 }
                 column(JudText1;JudText[1])
                 {
                 }
                 column(FORMAT;FORMAT(PerJud[1])+' %')
                 {
                 }
                 column(QdText1;QdText)
                 {
                 }
                 column(AqdText1;AqdText)
                 {
                 }
                 column(QcText1;QcText)
                 {
                 }
                 column(QD1;QD)
                 {
                 }
                 column(AQD1;AQD)
                 {
                 }
                 column(InsDisc;ABS(InsDisc))
                 {
                 }
                 column(InvDisc;ABS(InvDisc))
                 {
                 }
                 column(SubTotal2;SubTotal)
                 {
                 }
                 column(SalesTaxAmt1;SalesTaxAmt)
                 {
                 }
                 column(ChargeAmt1;ChargeAmt)
                 {
                 }
                 column(InsuranceAmt1;InsuranceAmt)
                 {
                 }
                 column(FormNo1;FormNo)
                 {
                 }
                 column(GrandTotal;GrandTotal)
                 {
                 }
                 column(AmountInWords;NoText[1])
                 {
                 }
                 column(Perjud;FORMAT(PerJud[1])+' %')
                 {
                 }

                 trigger OnAfterGetRecord()
                 begin
                     TempCount += 1;

                     GenLegSetup.GET;
                      CASE "Tax/Charge Type" OF
                         "Tax/Charge Type"::Charges:
                            BEGIN
                              CASE "Charge Type" OF
                                "Charge Type"::" ","Charge Type"::Freight,"Charge Type"::Commission:
                               /*  IF "Tax/Charge Group" <> GenLegSetup."Discount Charge" THEN
                                   ChargeAmt := ChargeAmt + "Posted Str Order Line Details".Amount; */

            /* IF ("Tax/Charge Group" <> GenLegSetup."Discount Charge") AND
              ("Tax/Charge Group" <> GenLegSetup.AddInsuranceDisc) THEN
               ChargeAmt := ChargeAmt + "Posted Str Order Line Details".Amount;


            "Charge Type"::Insurance:

               InsuranceAmt += "Posted Str Order Line Details".Amount;
          END;
          IF "Tax/Charge Group" = GenLegSetup."Discount Charge" THEN
            InvDisc += "Posted Str Order Line Details".Amount;
           IF "Tax/Charge Group" = GenLegSetup.AddInsuranceDisc THEN
            InsDisc += "Posted Str Order Line Details".Amount;

        END;
     "Tax/Charge Type"::"Sales Tax":
        SalesTaxAmt += "Posted Str Order Line Details".Amount;
     "Tax/Charge Type"::"Other Taxes":
       OtherTaxes += "Posted Str Order Line Details".Amount;
     "Tax/Charge Type"::"Service Tax":
       VATAmt += "Posted Str Order Line Details".Amount;
     "Tax/Charge Type"::Excise:
       OtherTaxes += "Posted Str Order Line Details".Amount;
  END;

 //sash
     IF InsDisc=0  THEN
     QcText := ''
     ELSE
     QcText := 'Qc Discount';


 IF "Sales Invoice Header"."Free Supply" = FALSE THEN BEGIN
    ExciseText[1] := ExciseAmt;
    ExciseLabel[1] := 'Excise';
    Taxtotal := Amount;
    ExciseText[2] := 0;
    ExciseLabel[2] := '';
 END ELSE BEGIN
    ExciseText[2] := ExciseAmt;
    ExciseLabel[2] := 'Excise';
    Taxtotal := Amount - ExciseAmt;
    ExciseText[1] := 0;
    ExciseLabel[1] := '';
 END;

 FOR i := 1 TO 3 DO BEGIN
   JudText[i] := '';
   PerJud[i] := 0;
 END;
 i := 0;
 SalesInvLine1.RESET;
 SalesInvLine1.SETFILTER(SalesInvLine1."Document No.",'%1',"Sales Invoice Header"."No.");
 SalesInvLine1.SETFILTER(SalesInvLine1."Tax Liable",'%1',TRUE);
 IF SalesInvLine1.FIND('-') THEN BEGIN
   TaxAreaLine.RESET;
   TaxAreaLine.SETFILTER(TaxAreaLine."Tax Area",'%1',SalesInvLine1."Tax Area Code");
   IF TaxAreaLine.FIND('-') THEN REPEAT
     i := i + 1;
     TaxDetails.RESET;
     TaxDetails.SETFILTER(TaxDetails."Tax Jurisdiction Code",'%1',TaxAreaLine."Tax Jurisdiction Code");
     TaxDetails.SETFILTER(TaxDetails."Tax Group Code",'%1',SalesInvLine1."Tax Group Code");
     TaxDetails.SETFILTER(TaxDetails."Form Code",'%1',"Sales Invoice Header"."Form Code");
     TaxDetails.SETFILTER(TaxDetails."Effective Date",'..%1',"Sales Invoice Header"."Posting Date");
     IF TaxDetails.FIND('+') THEN
       IF TaxDetails."Tax Jurisdiction Code" <> '' THEN BEGIN
         JudText[i] := TaxDetails."Tax Jurisdiction Code";
         PerJud[i] := TaxDetails."Tax Below Maximum";
       END;
   UNTIL TaxAreaLine.NEXT = 0;
 END;

 SalesInvLine1.RESET;
 SalesInvLine1.SETFILTER(SalesInvLine1."Document No.",'%1',"Sales Invoice Header"."No.");
 IF SalesInvLine1.FIND('-') THEN
    tgVat := SalesInvLine1."VAT %";
 IF TempCount = COUNT THEN BEGIN
   GrandTotal := ROUND((SubTotalNew1+Taxtotal-InvDisc-InsDisc + InsuranceAmt + ChargeAmt),1,'=')-ROUND(ExAmt,1,'=');
   CheckReport.InitTextVariable;
   CheckReport.FormatNoText(NoText,ROUND((GrandTotal),1,'='),'');

 END

end;

trigger OnPreDataItem()
begin
 CLEAR(TempCount);
end;
}

trigger OnAfterGetRecord()
begin
IF "Sales Invoice Header"."Currency Code" <> '' THEN
CurrCode := "Sales Invoice Header"."Currency Code" + ' Only'
ELSE
CurrCode := 'Rupees and Zero Paisa Only';


IF Location.GET("Location Code") THEN BEGIN
Address := Location.Address + Location."Address 2" +' '+ Location.City;
Ph := Location."Phone No." + ', ' + Location."Phone No. 2" ;
Fax := Location."Fax No.";
END;

//CurrReport.SHOWOUTPUT(FALSE);

//TRI N.K 22.02.08 Add Start
GroupCode.SETRANGE(GroupCode."Group Code","Sales Invoice Header"."Group Code");
IF GroupCode.FIND('-')THEN
//TRI N.K 22.02.08 Add Stop


//MS-PB BEGIN
Location.RESET;
Location.SETRANGE(Code,"Location Code");
IF Location.FINDFIRST THEN
HeaderTextLatest:=DocumentPrint.PrintInvoiceType("Sales Invoice Header",Location);
//MS-PB END;

IF Customer.GET("Sell-to Customer No.") THEN BEGIN
LST := Customer."L.S.T. No.";
CST := Customer."C.S.T. No.";

Customer.CALCFIELDS(Customer.Balance);
Outstand:=ROUND((Customer.Balance),1,'=');

END;


IF "Posting Date" >= 070114D THEN BEGIN
 policy := NewPolicy
END ELSE
 policy := Text13704;



SubTotal := 0;
CLEAR(ExciseText);
CLEAR(ExciseLabel);
ExciseAmt := 0;
BEDAmt := 0;
ECessAmt := 0;
FormCode := '';
FormNo := '';
ChargeAmt := 0;
SalesTaxAmt := 0;
OtherTaxes := 0;
VATAmt := 0;
InsuranceAmt := 0;

IF FormCodes.GET("Form Code") THEN BEGIN
FormCode := 'Against ' + FormCodes.Description;
FormNo := 'Form No. ' + "Form No.";
END;*/


            /*
            //MS-PB BEGIN 09.10.2012
            QD:=0;
            QuantityDiscountEntry.RESET;
            QuantityDiscountEntry.SETRANGE("Posted Document No.","No.");
            QuantityDiscountEntry.SETRANGE("Accrued Entry",FALSE);
              QuantityDiscountEntry.SETFILTER("QD Given Amount",'<>%1',0);
            IF QuantityDiscountEntry.FIND('-')THEN BEGIN
              QdText :='BR DISCOUNT';
              REPEAT  //MS-AN 09/01/13
              QD+=QuantityDiscountEntry."QD Given Amount";
              UNTIL QuantityDiscountEntry.NEXT=0; //MS-AN 09/01/13
            END ELSE
            QdText :='';

            AQD:=0;
              AqdText :='';
            QuantityDiscountEntry.RESET;
            QuantityDiscountEntry.SETRANGE("Posted Document No.","No.");
            QuantityDiscountEntry.SETFILTER("QD Given Amount",'<>%1',0);
            QuantityDiscountEntry.SETRANGE("Accrued Entry",TRUE);
            IF QuantityDiscountEntry.FIND('-')THEN BEGIN
              AqdText :='ABR DISCOUNT';
              REPEAT  //MS-AN 09/01/13
              AQD+=QuantityDiscountEntry."QD Given Amount";
              UNTIL QuantityDiscountEntry.NEXT=0; //MS-AN 09/01/13
            END ELSE BEGIN
             AqdText :=''
            END;
            */
            //MS-PB END


            /*  IF Customer.GET("Sell-to Customer No.") THEN BEGIN
                LST := Customer."L.S.T. No.";
                CST := Customer."C.S.T. No.";
                CustomerTINNo := Customer."T.I.N. No.";
              END;
              sno := 0;

              //IF CompanyInfo.GET THEN                           //Anurag
              //  "TINNo." := CompanyInfo."T.I.N. No.";           //Anurag
              IF tin_no1.GET(Location."T.I.N. No.") THEN          //Anurag
                "TINNo." := tin_no1.Description;                  //Anurag


              CheckReport.InitTextVariable;
              CheckReport.FormatNoText(NoTextExcise,ExciseAmt,'');


              CompanyInfo.GET;
              WorkAddress := 'Works    : '+ CompanyInfo.Address + ' ' + CompanyInfo."Address 2" + ' ' + CompanyInfo.City;

          end;

          trigger OnPreDataItem()
          begin
              CompanyInfo.GET;
              CompanyName1 := CompanyInfo.Name;
              CompanyName2:= CompanyInfo."Name 2";
          end;*/
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

        // RepAuditMgt.CreateAudit(50189)
    end;

    var
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
        CheckReport: Report Check;
        NoText: array[2] of Text[80];
        ExciseAmt: Decimal;
        NoTextExcise: array[2] of Text[80];
        LST: Code[100];
        CST: Code[100];
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
        //16225  FormCodes: Record "13756";
        ExciseLabel: array[2] of Text[50];
        ExciseText: array[2] of Decimal;
        sno: Integer;
        GenLegSetup: Record "General Ledger Setup";
        InvDisc: Decimal;
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
        //16225  tin_no1: Record "13701";
        i: Integer;
        TaxAreaLine: Record "Tax Area Line";
        TaxDetails: Record "Tax Detail";
        JudText: array[3] of Code[50];
        PerJud: array[3] of Decimal;
        SalesInvLine1: Record "Sales Invoice Line";
        tgVat: Decimal;
        GroupCode: Record "Item Group";
        TypeDesc: Text[30];
        Pcsqty: Decimal;
        Outstand: Decimal;
        CompanyName2: Text[50];
        HeaderTextLatest: Text[100];
        DocumentPrint: Codeunit "Document-Print";
        DecRate: Decimal;
        LineDis: Decimal;
        QD: Decimal;
        AQD: Decimal;
        QuantityDiscountEntry: Record "Quantity Discount Entry";
        QdText: Text[50];
        AqdText: Text[50];
        InsDisc: Decimal;
        QcText: Text[30];
        policy: Text[200];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Text13704: Label 'Since 01st May,2017 the Goods in transit are insured under Marine insurance with The New India Assurance Co. Limited, LCBO, New Delhi';
        NewPolicy: Label 'Since 01st May,2017 the Goods in transit are insured under Marine insurance with The New India Assurance Co. Limited, LCBO, New Delhi';
        TempCount: Integer;
        GrandTotal: Decimal;
        SubTotalNew1: Decimal;
        ExAmt: Decimal;
        CurrCode: Text[50];
}

