codeunit 50017 "Quality Discount Functions"
{
    // MSKS0506:
    //    GetStartDate Function Rectified
    // MSKS2006:
    //     Tile Category included

    TableNo = "Sales Header";

    trigger OnRun()
    begin
        SH := Rec;
    end;

    var
        SH: Record "Sales Header";
        RecDisHeader: Record "Discount Header";


    procedure TestPeriodApplicable(SH: Record "Sales Header"): Boolean
    var
        RecDiscHdr: Record "Discount Header";
        RecordExists: Boolean;
    begin
        RecordExists := FALSE;
        RecDiscHdr.RESET;
        RecDiscHdr.SETFILTER(RecDiscHdr."Valid From", '<=%1', SH."Posting Date");
        IF RecDiscHdr.FINDFIRST THEN
            RecordExists := TRUE;

        RecDiscHdr.SETFILTER(RecDiscHdr."Valid To", '>=%1', SH."Posting Date");
        IF RecDiscHdr.FINDFIRST THEN
            RecordExists := TRUE
        ELSE
            RecordExists := FALSE;


        EXIT(RecordExists);
    end;


    procedure TestStateApplicable() Exists: Boolean
    var
        RecCustGrp: Record "Customer Group";
        SH: Record "Sales Header";
    begin
        Exists := FALSE;
        RecCustGrp.RESET;
        RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::State);
        RecCustGrp.SETRANGE(RecCustGrp.Code, SH.State);
        RecCustGrp.SETRANGE("Include/Exclude", RecCustGrp."Include/Exclude"::Include);
        IF RecCustGrp.FINDFIRST THEN
            Exists := TRUE;

        RecCustGrp.RESET;
        RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::State);
        RecCustGrp.SETRANGE(RecCustGrp.All, TRUE);
        RecCustGrp.SETRANGE("Include/Exclude", RecCustGrp."Include/Exclude"::Include);
        IF RecCustGrp.FINDFIRST THEN
            Exists := TRUE;
        EXIT(Exists);
    end;


    procedure TestCustTypeApplicable(SH: Record "Sales Header") Exists: Boolean
    var
        RecCustGrp: Record "Customer Group";
    begin

        Exists := FALSE;
        RecCustGrp.RESET;
        RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::"Customer Type");
        RecCustGrp.SETRANGE(RecCustGrp.Code, SH."Group Code");
        RecCustGrp.SETRANGE("Include/Exclude", RecCustGrp."Include/Exclude"::Include);
        IF RecCustGrp.FINDFIRST THEN
            Exists := TRUE;

        RecCustGrp.RESET;
        RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::"Customer Type");
        RecCustGrp.SETRANGE(RecCustGrp.All, TRUE);
        RecCustGrp.SETRANGE("Include/Exclude", RecCustGrp."Include/Exclude"::Include);
        IF RecCustGrp.FINDFIRST THEN
            Exists := TRUE;

        EXIT(Exists);
    end;


    procedure TestCustApplicable(SH: Record "Sales Header") Exists: Boolean
    var
        RecCustGrp: Record "Customer Group";
    begin
        Exists := FALSE;
        RecCustGrp.RESET;
        RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::Customer);
        RecCustGrp.SETRANGE(RecCustGrp.Code, SH."Sell-to Customer No.");
        RecCustGrp.SETRANGE("Include/Exclude", RecCustGrp."Include/Exclude"::Include);
        IF RecCustGrp.FINDFIRST THEN
            Exists := TRUE;

        RecCustGrp.RESET;
        RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::Customer);
        RecCustGrp.SETRANGE(RecCustGrp.All, TRUE);
        RecCustGrp.SETRANGE("Include/Exclude", RecCustGrp."Include/Exclude"::Include);
        IF RecCustGrp.FINDFIRST THEN
            Exists := TRUE;

        EXIT(Exists);
    end;


    procedure ReturnDiscountSchemeInclude(SH: Record "Sales Header") OfferCode: Code[20]
    var
        RecCustGrp: Record "Customer Group";
        AllInclude: Boolean;
        AllExclude: Boolean;
        SpInclude: Boolean;
        SpExclude: Boolean;
        PostDate: Date;
        ExcludeCustomer: Boolean;
        ExcludeState: Boolean;
        ExcludeCustomerType: Boolean;
        Offer: array[4] of Code[20];
    begin
        SpExclude := FALSE;
        SpInclude := FALSE;
        AllExclude := FALSE;
        AllInclude := FALSE;

        IF SH."Posting Date" = 0D THEN
            PostDate := WORKDATE
        ELSE
            PostDate := SH."Posting Date";

        ExcludeCustomer := TestCustApplicableExclude(SH);
        ExcludeState := TestStateApplicableExclude(SH);
        ExcludeCustomerType := TestCustTypeApplicableExclude(SH);

        IF ExcludeCustomer AND ExcludeState AND ExcludeCustomerType THEN BEGIN

            RecCustGrp.RESET;
            RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::State);
            RecCustGrp.SETRANGE(Code, SH.State);
            RecCustGrp.SETRANGE("Include/Exclude", RecCustGrp."Include/Exclude"::Include);
            RecCustGrp.SETRANGE(Status, RecCustGrp.Status::Enable);
            RecCustGrp.SETFILTER("Valid From", '<=%1', PostDate);
            RecCustGrp.SETFILTER("Valid To", '>=%1', PostDate);
            IF RecCustGrp.FINDFIRST THEN
                Offer[1] := RecCustGrp."No.";

            RecCustGrp.RESET;
            RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::Customer);
            RecCustGrp.SETRANGE(Code, SH."Sell-to Customer No.");
            RecCustGrp.SETRANGE("Include/Exclude", RecCustGrp."Include/Exclude"::Include);
            RecCustGrp.SETRANGE(Status, RecCustGrp.Status::Enable);
            RecCustGrp.SETFILTER("Valid From", '<=%1', PostDate);
            RecCustGrp.SETFILTER("Valid To", '>=%1', PostDate);
            IF RecCustGrp.FINDFIRST THEN
                Offer[2] := RecCustGrp."No.";

            RecCustGrp.RESET;
            RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::"Customer Type");
            RecCustGrp.SETRANGE(Code, SH."Customer Type");
            RecCustGrp.SETRANGE("Include/Exclude", RecCustGrp."Include/Exclude"::Include);
            RecCustGrp.SETRANGE(Status, RecCustGrp.Status::Enable);
            RecCustGrp.SETFILTER("Valid From", '<=%1', PostDate);
            RecCustGrp.SETFILTER("Valid To", '>=%1', PostDate);
            IF RecCustGrp.FINDFIRST THEN
                Offer[3] := RecCustGrp."No.";

            IF (Offer[3] <> '') OR (Offer[2] <> '') OR (Offer[1] <> '') THEN BEGIN
                IF Offer[3] = Offer[2] THEN
                    OfferCode := (Offer[3]);

                IF Offer[2] = Offer[1] THEN
                    OfferCode := (Offer[2]) ELSE
                    OfferCode := Offer[1];

            END;
        END;
        EXIT(OfferCode);
        /*
        IF AllInclude THEN BEGIN
          IF SpExclude THEN
            ItemExist:=FALSE
            ELSE
            ItemExist:=TRUE;
        END;
        
        IF AllExclude THEN BEGIN
          IF SpInclude THEN
          ItemExist :=TRUE
          ELSE
          ItemExist:=FALSE;
        END;
        */

        //EXIT(ItemExist);


        ////
        ///IF TestPeriodApplicable THEN BEGIN
        //   IF TestCustApplicable THEN BEGIN
        /*
        IF RecCustGrp."Group Type"=RecCustGrp."Group Type"::State THEN BEGIN
              RecCustGrp.RESET;
              RecCustGrp.SETRANGE("Group Type",RecCustGrp."Group Type"::State);
              RecCustGrp.SETRANGE(RecCustGrp.All,TRUE);
              //RecCustGrp.SETRANGE("Include/Exclude",RecCustGrp."Include/Exclude"::Include);
              //RecCustGrp.SETFILTER("Include/Exclude",'<>%1',RecCustGrp."Include/Exclude"::Exclude);
              IF RecCustGrp.FINDFIRST THEN
                OfferCode := RecCustGrp."No.";
        
        
              IF OfferCode='' THEN BEGIN
                RecCustGrp.RESET;
                RecCustGrp.SETRANGE("Group Type",RecCustGrp."Group Type"::State);
                RecCustGrp.SETRANGE(RecCustGrp.Code,SH.State);
                //RecCustGrp.SETRANGE("Include/Exclude",RecCustGrp."Include/Exclude"::Include);
                //RecCustGrp.SETFILTER(RecCustGrp."Include/Exclude",'<>%1',RecCustGrp."Include/Exclude"::Exclude);
                IF RecCustGrp.FINDFIRST THEN
                  OfferCode :=RecCustGrp."No.";
        
              END;
              EXIT(OfferCode);
           END
           ELSE
              IF RecCustGrp."Group Type"=RecCustGrp."Group Type"::Customer THEN BEGIN
              RecCustGrp.RESET;
              RecCustGrp.SETRANGE("Group Type",RecCustGrp."Group Type"::Customer);
              RecCustGrp.SETRANGE(RecCustGrp.All,TRUE);
              //RecCustGrp.SETRANGE("Include/Exclude",RecCustGrp."Include/Exclude"::Include);
              IF RecCustGrp.FINDFIRST THEN
                OfferCode := RecCustGrp."No.";
        
        
              IF OfferCode='' THEN BEGIN
                RecCustGrp.RESET;
                RecCustGrp.SETRANGE("Group Type",RecCustGrp."Group Type"::Customer);
                RecCustGrp.SETRANGE(RecCustGrp.Code,SH."Sell-to Customer No.");
               // RecCustGrp.SETRANGE("Include/Exclude",RecCustGrp."Include/Exclude"::Include);
                IF RecCustGrp.FINDFIRST THEN
                  OfferCode :=RecCustGrp."No.";
              END;
             // END;
              EXIT(OfferCode);
              END;
             // EXIT(OfferCode);
        */

        /*///IF TestPeriodApplicable THEN BEGIN
        //   IF TestCustApplicable THEN BEGIN
        
        IF RecCustGrp."Group Type"=RecCustGrp."Group Type"::State THEN BEGIN
              RecCustGrp.RESET;
              RecCustGrp.SETRANGE("Group Type",RecCustGrp."Group Type"::State);
              RecCustGrp.SETRANGE(RecCustGrp.All,TRUE);
              //RecCustGrp.SETRANGE("Include/Exclude",RecCustGrp."Include/Exclude"::Include);
              //RecCustGrp.SETFILTER("Include/Exclude",'<>%1',RecCustGrp."Include/Exclude"::Exclude);
              IF RecCustGrp.FINDFIRST THEN
                OfferCode := RecCustGrp."No.";
        
        
              IF OfferCode='' THEN BEGIN
                RecCustGrp.RESET;
                RecCustGrp.SETRANGE("Group Type",RecCustGrp."Group Type"::State);
                RecCustGrp.SETRANGE(RecCustGrp.Code,SH.State);
                //RecCustGrp.SETRANGE("Include/Exclude",RecCustGrp."Include/Exclude"::Include);
                //RecCustGrp.SETFILTER(RecCustGrp."Include/Exclude",'<>%1',RecCustGrp."Include/Exclude"::Exclude);
                IF RecCustGrp.FINDFIRST THEN
                  OfferCode :=RecCustGrp."No.";
        
              END;
              EXIT(OfferCode);
           END
           ELSE
              IF RecCustGrp."Group Type"=RecCustGrp."Group Type"::Customer THEN BEGIN
              RecCustGrp.RESET;
              RecCustGrp.SETRANGE("Group Type",RecCustGrp."Group Type"::Customer);
              RecCustGrp.SETRANGE(RecCustGrp.All,TRUE);
              //RecCustGrp.SETRANGE("Include/Exclude",RecCustGrp."Include/Exclude"::Include);
              IF RecCustGrp.FINDFIRST THEN
                OfferCode := RecCustGrp."No.";
        
        
              IF OfferCode='' THEN BEGIN
                RecCustGrp.RESET;
                RecCustGrp.SETRANGE("Group Type",RecCustGrp."Group Type"::Customer);
                RecCustGrp.SETRANGE(RecCustGrp.Code,SH."Sell-to Customer No.");
               // RecCustGrp.SETRANGE("Include/Exclude",RecCustGrp."Include/Exclude"::Include);
                IF RecCustGrp.FINDFIRST THEN
                  OfferCode :=RecCustGrp."No.";
              END;
             // END;
              EXIT(OfferCode);
              END;
             // EXIT(OfferCode);
        */

    end;


    procedure GetDiscountValue(SchemeCd: Code[20]; Qty: Decimal) DiscountValue: Decimal
    var
        Scheme: Record "Discount Header";
        Slab: Record Slabs;
    begin
        Scheme.RESET;
        Scheme.SETRANGE(Scheme."No.", SchemeCd);
        IF NOT Scheme.FINDFIRST THEN
            EXIT;

        Slab.RESET;
        Slab.SETRANGE(Slab."Slab Group", Scheme."Slab Group");
        Slab.SETFILTER(Slab."Qty (Sq Mt.)", '<=%1', Qty);
        IF Slab.FINDLAST THEN
            EXIT(Slab."Discount Amount");
    end;


    procedure CreateQDEntry(DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]; CustCode: Code[20]; InvAmt: Decimal; QDApplicable: Decimal; QDGiven: Decimal; PostDate: Date; Qty: Decimal; AccEntry: Boolean; SH: Record "Sales Header"; PostedDocNo: Code[20])
    var
        QDEntry: Record "Quantity Discount Entry";
        QuantityDG: Decimal;
        SalesLine: Record "Sales Line";
        Scheme: Code[10];
        QuantityDiscount: Decimal;
        DocQuantity: Decimal;
        QtytoInv: Decimal;
        AccQDEntry: Record "Quantity Discount Entry";
        QuantityDiscountEntry: Record "Quantity Discount Entry";
        AccredQty: Decimal;
        SlabRate: Decimal;
        NetAmount: Decimal;
        SalesInvoiceLine: Record "Sales Invoice Line";
        AccQty: Decimal;
        AccDis: Decimal;
        RecSlab: Record Slabs;
        AccuredDiscount: Decimal;
    begin
        QuantityDiscount := 0;
        DocQuantity := 0;
        NetAmount := 0;
        AccuredDiscount := 0;

        RecDisHeader.RESET;
        IF RecDisHeader.FINDFIRST THEN BEGIN
            REPEAT
                DocQuantity := 0;
                QtytoInv := 0;
                NetAmount := 0;
                QuantityDiscount := 0;
                AccuredDiscount := 0;
                SalesLine.RESET;
                SalesLine.SETRANGE(SalesLine."Document Type", DocType);
                SalesLine.SETRANGE(SalesLine."Document No.", DocNo);
                SalesLine.SETFILTER("Qty. to Invoice", '<>%1', 0);
                SalesLine.SETFILTER("Offer Code", '%1', RecDisHeader."No.");
                SalesLine.SETRANGE("Calculate Line Discount", TRUE);
                IF SalesLine.FIND('-') THEN BEGIN
                    REPEAT
                        DocQuantity += SalesLine.Quantity;
                        //QtytoInv +=SalesLine."Qty. to Invoice";
                        IF DocType = DocType::"Credit Memo" THEN BEGIN //MSKS 121212
                            QtytoInv += SalesLine."Return Qty. to Receive (Base)"; //MSKS 121212
                            QuantityDiscount += (SalesLine."Quantity Discount Amount" / SalesLine.Quantity) * SalesLine."Return Qty. to Receive (Base)"; //MSKS
                        END ELSE BEGIN //MSKS
                            QtytoInv += SalesLine."Quantity in Sq. Mt.(Ship)"; //shakti  190112
                            QuantityDiscount += (SalesLine."Quantity Discount Amount" / SalesLine.Quantity) * SalesLine."Quantity in Sq. Mt.(Ship)";
                        END;                 //MSKS 121212
                                             // 15578    NetAmount += SalesLine."Amount To Customer";
                                             //QuantityDiscount+=(SalesLine."Quantity Discount Amount"/SalesLine.Quantity)*SalesLine."Qty. to Invoice";


                        AccuredDiscount += SalesLine."Accrued Discount";

                    /*     DocQuantity+=SalesLine.Quantity;
                         //QtytoInv +=SalesLine."Qty. to Invoice";
                         QtytoInv +=SalesLine."Quantity in Sq. Mt.(Ship)"; //shakti  190112
                         NetAmount+=SalesLine."Amount To Customer";
                         //QuantityDiscount+=(SalesLine."Quantity Discount Amount"/SalesLine.Quantity)*SalesLine."Qty. to Invoice";
                         QuantityDiscount+=(SalesLine."Quantity Discount Amount"/SalesLine.Quantity)*SalesLine."Quantity in Sq. Mt.(Ship)";
                         AccuredDiscount+=SalesLine."Accrued Discount";*/
                    UNTIL SalesLine.NEXT = 0;
                END;
                Scheme := RecDisHeader."No.";

                RecSlab.RESET;
                RecSlab.SETRANGE("Slab Group", SalesLine.Slab);
                IF RecSlab.FINDFIRST THEN;
                AccQty := GetQDQuantity(CustCode, GetStartDate(SalesLine."Posting Date", RecSlab.Period),
                          GetEndDate(SalesLine."Posting Date", RecSlab.Period), Scheme);
                SlabRate := GetDiscountValue(Scheme, AccQty + QtytoInv);


                QDEntry."Entry No." := GetLastEntry;
                QDEntry."Document Type" := DocType;
                QDEntry."Document No." := DocNo;
                QDEntry."Posted Document No." := PostedDocNo;
                Scheme := SalesLine."Offer Code";
                QDEntry."Sell to Customer Code" := CustCode;
                QDEntry."Invoice Amount" := NetAmount;
                QDEntry."Applicable Quantity" := QuantityDG;
                QDEntry."Document Date" := SH."Document Date";
                QDEntry.Period := QDEntry.Period::Monthly;
                QDEntry."Scheme Code" := Scheme;
                IF DocType = DocType::"Credit Memo" THEN BEGIN
                    QDEntry."Applicable Quantity" := -(QtytoInv);
                    QDEntry."QD Given Amount" := -(QtytoInv * SlabRate);
                END
                ELSE BEGIN
                    QDEntry."Applicable Quantity" := QtytoInv;
                    QDEntry."QD Given Amount" := QtytoInv * SlabRate;

                END;
                QDEntry."Total Document Quantity" := DocQuantity;
                QDEntry."Posting Date" := SH."Posting Date";
                QDEntry."Accrued Quantity" := 0;
                QDEntry."Slab Rate" := SlabRate;
                IF QtytoInv <> 0 THEN
                    QDEntry.INSERT;
                //Accrued
                //AccQty:=0;
                /*
                AccDis:=0;

                SalesInvoiceLine.RESET;
                SalesInvoiceLine.SETRANGE("Document No.",PostedDocNo);
                IF SalesInvoiceLine.FIND('-')THEN BEGIN
                  AccQty+=SalesInvoiceLine.Quantity;
                  AccDis+=SalesInvoiceLine."Quantity Discount Amount";
                END;
                */
                AccQDEntry."Entry No." := GetLastEntry;
                AccQDEntry."Document Type" := DocType;
                AccQDEntry."Document No." := DocNo;
                Scheme := SalesLine."Offer Code";
                AccQDEntry."Sell to Customer Code" := CustCode;
                // 15578  AccQDEntry."Invoice Amount" := SalesLine."Amount To Customer";
                AccQDEntry."Applicable Quantity" := 0;
                AccQDEntry."Document Date" := SH."Document Date";
                AccQDEntry.Period := QDEntry.Period::Monthly;
                AccQDEntry."Scheme Code" := Scheme;
                AccQDEntry."Applicable Quantity" := 0;
                IF DocType = DocType::"Credit Memo" THEN
                    AccQDEntry."QD Given Amount" := -(QuantityDiscount - (QtytoInv * SlabRate))
                ELSE
                    //AccQDEntry."QD Given Amount":=QuantityDiscount-(QtytoInv*SlabRate);
                    AccQDEntry."QD Given Amount" := AccuredDiscount;

                AccQDEntry."Total Document Quantity" := DocQuantity;
                AccQDEntry."Posting Date" := SH."Posting Date";
                AccQDEntry."Accrued Entry" := TRUE;
                IF SlabRate <> 0 THEN
                    AccQDEntry."Accrued Quantity" := AccQty;//(QuantityDiscount/SlabRate)-(QtytoInv);
                QDEntry."Slab Rate" := SlabRate;
                AccQDEntry."Posted Document No." := PostedDocNo;
                IF QtytoInv <> 0 THEN
                    AccQDEntry.INSERT;
            UNTIL RecDisHeader.NEXT = 0;
        END;

    end;


    procedure GetLastEntry(): Integer
    var
        QDEntry: Record "Quantity Discount Entry";
    begin
        QDEntry.RESET;
        IF QDEntry.FINDLAST THEN
            EXIT(QDEntry."Entry No." + 1)
        ELSE
            EXIT(10000);
    end;


    procedure GetQDQuantity(CustomerCd: Code[20]; FromDate: Date; ToDate: Date; SchemeCode: Code[20]) Qty: Decimal
    var
        RecSalesInvHeader: Record "Sales Invoice Header";
        RecSalesCrHeader: Record "Sales Cr.Memo Header";
        RecQDEntry: Record "Quantity Discount Entry";
    begin
        IF CustomerCd = '' THEN
            EXIT;
        /*
        RecSalesInvHeader.RESET;
        RecSalesInvHeader.SETRANGE("Sell-to Customer No.",CustomerCd);
        RecSalesInvHeader.SETRANGE("Posting Date",FromDate,ToDate);
        IF RecSalesInvHeader.FINDFIRST THEN
        //   RecSalesInvHeader.CALCFIELDS("QD Quantity");
        
        RecSalesCrHeader.RESET;
        RecSalesCrHeader.SETRANGE("Sell-to Customer No.",CustomerCd);
        RecSalesCrHeader.SETRANGE("Posting Date",FromDate,ToDate);
        IF RecSalesCrHeader.FINDFIRST THEN
          // RecSalesCrHeader.CALCFIELDS("QD Quantity");
        */

        RecQDEntry.RESET;
        RecQDEntry.SETCURRENTKEY("Sell to Customer Code", "Posting Date", "Scheme Code");
        RecQDEntry.SETRANGE(RecQDEntry."Sell to Customer Code", CustomerCd);
        RecQDEntry.SETRANGE("Posting Date", FromDate, ToDate);
        RecQDEntry.SETRANGE("Scheme Code", SchemeCode); //MSKS
        IF RecQDEntry.FINDFIRST THEN BEGIN
            REPEAT
                Qty += RecQDEntry."Applicable Quantity";
            UNTIL RecQDEntry.NEXT = 0;
        END;
        EXIT(Qty);

        //EXIT(RecSalesInvHeader."QD Quantity"-RecSalesCrHeader."QD Quantity");

    end;


    procedure GetAlreadyQDGiven(CustomerCd: Code[20]; FromDate: Date; ToDate: Date; SchemeCode: Code[20]) QDGiven: Decimal
    var
        RecQDEntry: Record "Quantity Discount Entry";
    begin

        QDGiven := 0;
        RecQDEntry.RESET;
        RecQDEntry.SETCURRENTKEY("Sell to Customer Code", "Posting Date", "Scheme Code");
        RecQDEntry.SETRANGE("Sell to Customer Code", CustomerCd);
        RecQDEntry.SETRANGE("Posting Date", FromDate, ToDate);
        RecQDEntry.SETRANGE("Scheme Code", SchemeCode); //MSKS
        IF RecQDEntry.FINDFIRST THEN BEGIN
            REPEAT
                QDGiven += RecQDEntry."QD Given Amount";
            UNTIL RecQDEntry.NEXT = 0;
        END;
        EXIT(QDGiven);
    end;


    procedure CreateAccruedQDEntry(CustomerCd: Code[20]; FromDate: Date; ToDate: Date; var SalesHdr: Record "Sales Header")
    var
        QDQuantity: Decimal;
        RecQDEntry: Record "Quantity Discount Entry";
        QDSlab: Decimal;
    begin
        QDQuantity := GetQDQuantity(CustomerCd, FromDate, ToDate, ''); //MSKS
        QDSlab := GetDiscountValue(ReturnDiscountSchemeInclude(SalesHdr), QDQuantity);
        IF QDQuantity * QDSlab
         <> GetAlreadyQDGiven(CustomerCd, FromDate, ToDate, '') THEN BEGIN

            RecQDEntry.RESET;
            RecQDEntry.SETCURRENTKEY("Sell to Customer Code", "Posting Date");
            RecQDEntry.SETRANGE("Sell to Customer Code", CustomerCd);
            RecQDEntry.SETRANGE("Posting Date", FromDate, ToDate);
            IF RecQDEntry.FINDFIRST THEN BEGIN
                REPEAT
                    IF QDSlab <> RecQDEntry."QD Given Amount" THEN
                        CreateQDEntry(RecQDEntry."Document Type", RecQDEntry."Document No.", RecQDEntry."Sell to Customer Code",
                        RecQDEntry."Invoice Amount", QDSlab - RecQDEntry."Applicable Quantity", 0,
                        RecQDEntry."Document Date", RecQDEntry."Total Document Quantity", TRUE, SalesHdr, 'Posted Doc');
                UNTIL RecQDEntry.NEXT = 0;
            END;

        END;
    end;


    procedure GetStartDate(PostDate: Date; Calc: Option Month,Quaterly,"Half-Yearly",Annually): Date
    begin
        IF PostDate = 0D THEN
            EXIT;
        CASE Calc OF
            Calc::Month:
                BEGIN
                    //EXIT(CALCDATE('CM-1M+1D',PostDate));
                    EXIT(CALCDATE('CM+1D-1M', PostDate)); //MSKS0506
                END;
            Calc::Quaterly:
                BEGIN
                    EXIT(CALCDATE('CQ-1Q+1D', PostDate));
                END;
            Calc::"Half-Yearly":
                BEGIN
                    //   EXIT(CALCDate('CY-1M+1D',PostDate));
                END;
        END;
    end;


    procedure GetEndDate(PostDate: Date; Calc: Option Month,Quaterly,"Half-Yearly",Annually): Date
    begin
        IF PostDate = 0D THEN
            EXIT;

        CASE Calc OF
            Calc::Month:
                BEGIN
                    EXIT(CALCDATE('CM', PostDate));
                END;
            Calc::Quaterly:
                BEGIN
                    EXIT(CALCDATE('CQ', PostDate));
                END;
            Calc::"Half-Yearly":
                BEGIN
                    //   EXIT(CALCDate('CY-1M+1D',PostDate));
                END;
        END;
    end;


    procedure TestStateApplicableExclude(SH: Record "Sales Header") Exist: Boolean
    var
        RecCustGrp: Record "Customer Group";
        Include: Boolean;
        Exclude: Boolean;
        AllInclude: Boolean;
        AllExclude: Boolean;
        SpInclude: Boolean;
        SpExclude: Boolean;
        PostDate: Date;
    begin
        Exist := FALSE;

        SpExclude := FALSE;
        SpInclude := FALSE;
        AllExclude := FALSE;
        AllInclude := FALSE;

        IF SH."Posting Date" = 0D THEN
            PostDate := WORKDATE
        ELSE
            PostDate := SH."Posting Date";

        RecCustGrp.RESET;
        RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::State);
        RecCustGrp.SETRANGE(Code, SH.State);
        RecCustGrp.SETFILTER("Include/Exclude", '%1', RecCustGrp."Include/Exclude"::Exclude);
        RecCustGrp.SETRANGE(Status, RecCustGrp.Status::Enable);
        RecCustGrp.SETFILTER("Valid From", '<=%1', PostDate);
        RecCustGrp.SETFILTER("Valid To", '>=%1', PostDate);
        IF RecCustGrp.FINDFIRST THEN
            SpExclude := TRUE;

        RecCustGrp.RESET;
        RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::State);
        RecCustGrp.SETRANGE(Code, SH.State);
        RecCustGrp.SETFILTER("Include/Exclude", '%1', RecCustGrp."Include/Exclude"::Include);
        RecCustGrp.SETRANGE(Status, RecCustGrp.Status::Enable);
        RecCustGrp.SETFILTER("Valid From", '<=%1', PostDate);
        RecCustGrp.SETFILTER("Valid To", '>=%1', PostDate);
        IF RecCustGrp.FINDFIRST THEN
            SpInclude := TRUE;

        RecCustGrp.RESET;
        RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::State);
        RecCustGrp.SETRANGE(All, TRUE);
        RecCustGrp.SETFILTER("Include/Exclude", '%1', RecCustGrp."Include/Exclude"::Include);
        RecCustGrp.SETRANGE(Status, RecCustGrp.Status::Enable);
        RecCustGrp.SETFILTER("Valid From", '<=%1', PostDate);
        RecCustGrp.SETFILTER("Valid To", '>=%1', PostDate);
        IF RecCustGrp.FINDFIRST THEN
            AllInclude := TRUE;

        RecCustGrp.RESET;
        RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::State);
        RecCustGrp.SETRANGE(All, TRUE);
        RecCustGrp.SETFILTER("Include/Exclude", '%1', RecCustGrp."Include/Exclude"::Exclude);
        RecCustGrp.SETRANGE(Status, RecCustGrp.Status::Enable);
        RecCustGrp.SETFILTER("Valid From", '<=%1', PostDate);
        RecCustGrp.SETFILTER("Valid To", '>=%1', PostDate);
        IF RecCustGrp.FINDFIRST THEN
            AllExclude := TRUE;

        IF AllInclude THEN BEGIN
            IF SpExclude THEN
                Exist := FALSE
            ELSE
                Exist := TRUE;
        END;

        IF AllExclude THEN BEGIN
            IF SpInclude THEN
                Exist := TRUE
            ELSE
                Exist := FALSE;
        END;

        EXIT(Exist);
    end;


    procedure TestCustApplicableExclude(SH: Record "Sales Header") CustExist: Boolean
    var
        RecCustGrp: Record "Customer Group";
        AllInclude: Boolean;
        AllExclude: Boolean;
        SpInclude: Boolean;
        SpExclude: Boolean;
        PostDate: Date;
    begin
        CustExist := TRUE;

        SpExclude := FALSE;
        SpInclude := FALSE;
        AllExclude := FALSE;
        AllInclude := FALSE;

        IF SH."Posting Date" = 0D THEN
            PostDate := WORKDATE
        ELSE
            PostDate := SH."Posting Date";

        RecCustGrp.RESET;
        RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::Customer);
        RecCustGrp.SETRANGE(Code, SH."Sell-to Customer No.");
        RecCustGrp.SETRANGE("Include/Exclude", RecCustGrp."Include/Exclude"::Exclude);
        RecCustGrp.SETRANGE(Status, RecCustGrp.Status::Enable);
        RecCustGrp.SETFILTER("Valid From", '<=%1', PostDate);
        RecCustGrp.SETFILTER("Valid To", '>=%1', PostDate);
        IF RecCustGrp.FINDFIRST THEN
            SpExclude := TRUE;

        RecCustGrp.RESET;
        RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::Customer);
        RecCustGrp.SETRANGE(Code, SH."Sell-to Customer No.");
        RecCustGrp.SETRANGE("Include/Exclude", RecCustGrp."Include/Exclude"::Include);
        RecCustGrp.SETRANGE(Status, RecCustGrp.Status::Enable);
        RecCustGrp.SETFILTER("Valid From", '<=%1', PostDate);
        RecCustGrp.SETFILTER("Valid To", '>=%1', PostDate);
        IF RecCustGrp.FINDFIRST THEN
            SpInclude := TRUE;

        RecCustGrp.RESET;
        RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::Customer);
        RecCustGrp.SETRANGE(All, TRUE);
        RecCustGrp.SETRANGE("Include/Exclude", RecCustGrp."Include/Exclude"::Exclude);
        RecCustGrp.SETRANGE(Status, RecCustGrp.Status::Enable);
        RecCustGrp.SETFILTER("Valid From", '<=%1', PostDate);
        RecCustGrp.SETFILTER("Valid To", '>=%1', PostDate);
        IF RecCustGrp.FINDFIRST THEN
            AllExclude := TRUE;

        RecCustGrp.RESET;
        RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::Customer);
        RecCustGrp.SETRANGE(All, TRUE);
        RecCustGrp.SETRANGE("Include/Exclude", RecCustGrp."Include/Exclude"::Include);
        RecCustGrp.SETRANGE(Status, RecCustGrp.Status::Enable);
        RecCustGrp.SETFILTER("Valid From", '<=%1', PostDate);
        RecCustGrp.SETFILTER("Valid To", '>=%1', PostDate);
        IF RecCustGrp.FINDFIRST THEN
            AllInclude := TRUE;


        IF AllInclude THEN BEGIN
            IF SpExclude THEN
                CustExist := FALSE
            ELSE
                CustExist := TRUE;
        END;

        IF AllExclude THEN BEGIN
            IF SpInclude THEN
                CustExist := TRUE
            ELSE
                CustExist := FALSE;
        END;

        EXIT(CustExist);
    end;


    procedure TestCustTypeApplicableExclude(SH: Record "Sales Header") CustTypeExist: Boolean
    var
        RecCustGrp: Record "Customer Group";
        AllInclude: Boolean;
        AllExclude: Boolean;
        SpInclude: Boolean;
        SpExclude: Boolean;
        PostDate: Date;
    begin
        CustTypeExist := TRUE;
        /*
        RecCustGrp.RESET;
        RecCustGrp.SETRANGE("Group Type",RecCustGrp."Group Type"::"Customer Type");
        RecCustGrp.SETRANGE(Code,SH."Customer Type");
        RecCustGrp.SETRANGE("Include/Exclude",RecCustGrp."Include/Exclude"::Exclude);
        RecCustGrp.SETRANGE(Status,RecCustGrp.Status::Enable);
        RecCustGrp.SETFILTER("Valid From",'<=%1',SH."Posting Date");
        RecCustGrp.SETFILTER("Valid To",'>=%1',SH."Posting Date");
        IF RecCustGrp.FINDFIRST THEN
          CustTypeExist:=FALSE;
         */


        SpExclude := FALSE;
        SpInclude := FALSE;
        AllExclude := FALSE;
        AllInclude := FALSE;

        IF SH."Posting Date" = 0D THEN
            PostDate := WORKDATE
        ELSE
            PostDate := SH."Posting Date";

        RecCustGrp.RESET;
        RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::"Customer Type");
        RecCustGrp.SETRANGE(Code, SH."Customer Type");
        RecCustGrp.SETRANGE("Include/Exclude", RecCustGrp."Include/Exclude"::Exclude);
        RecCustGrp.SETRANGE(Status, RecCustGrp.Status::Enable);
        RecCustGrp.SETFILTER("Valid From", '<=%1', PostDate);
        RecCustGrp.SETFILTER("Valid To", '>=%1', PostDate);
        IF RecCustGrp.FINDFIRST THEN
            SpExclude := TRUE;

        RecCustGrp.RESET;
        RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::"Customer Type");
        RecCustGrp.SETRANGE(Code, SH."Customer Type");
        RecCustGrp.SETRANGE("Include/Exclude", RecCustGrp."Include/Exclude"::Include);
        RecCustGrp.SETRANGE(Status, RecCustGrp.Status::Enable);
        RecCustGrp.SETFILTER("Valid From", '<=%1', PostDate);
        RecCustGrp.SETFILTER("Valid To", '>=%1', PostDate);
        IF RecCustGrp.FINDFIRST THEN
            SpInclude := TRUE;

        RecCustGrp.RESET;
        RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::"Customer Type");
        RecCustGrp.SETRANGE(All, TRUE);
        RecCustGrp.SETRANGE("Include/Exclude", RecCustGrp."Include/Exclude"::Exclude);
        RecCustGrp.SETRANGE(Status, RecCustGrp.Status::Enable);
        RecCustGrp.SETFILTER("Valid From", '<=%1', PostDate);
        RecCustGrp.SETFILTER("Valid To", '>=%1', PostDate);
        IF RecCustGrp.FINDFIRST THEN
            AllExclude := TRUE;

        RecCustGrp.RESET;
        RecCustGrp.SETRANGE("Group Type", RecCustGrp."Group Type"::"Customer Type");
        RecCustGrp.SETRANGE(All, TRUE);
        RecCustGrp.SETRANGE("Include/Exclude", RecCustGrp."Include/Exclude"::Include);
        RecCustGrp.SETRANGE(Status, RecCustGrp.Status::Enable);
        RecCustGrp.SETFILTER("Valid From", '<=%1', PostDate);
        RecCustGrp.SETFILTER("Valid To", '>=%1', PostDate);
        IF RecCustGrp.FINDFIRST THEN
            AllInclude := TRUE;


        IF AllInclude THEN BEGIN
            IF SpExclude THEN
                CustTypeExist := FALSE
            ELSE
                CustTypeExist := TRUE;
        END;

        IF AllExclude THEN BEGIN
            IF SpInclude THEN
                CustTypeExist := TRUE
            ELSE
                CustTypeExist := FALSE;
        END;

        EXIT(CustTypeExist);

    end;


    procedure LineGroupItemTypeApplicable(SalesLine: Record "Sales Line"; SalesHrd: Record "Sales Header") ItemTypeExist: Boolean
    var
        DiscountLine: Record "Discount Line";
        AllInclude: Boolean;
        AllExclude: Boolean;
        SpInclude: Boolean;
        SpExclude: Boolean;
        PostDate: Date;
    begin
        ItemTypeExist := FALSE;
        /*
        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type",DiscountLine."Group Type"::"Item Type");
        DiscountLine.SETRANGE(Code,SalesLine."Item Type");
        DiscountLine.SETRANGE("Include/Exclude",DiscountLine."Include/Exclude"::Exclude);
        DiscountLine.SETRANGE(Status,DiscountLine.Status::Enable);
         DiscountLine.SETFILTER("Valid From",'<=%1',SalesHrd."Posting Date");
        DiscountLine.SETFILTER("Valid To",'>=%1',SalesHrd."Posting Date");
        IF DiscountLine.FINDFIRST THEN
          ItemTypeExist:=FALSE;
        */

        SpExclude := FALSE;
        SpInclude := FALSE;
        AllExclude := FALSE;
        AllInclude := FALSE;

        IF SalesHrd."Posting Date" = 0D THEN
            PostDate := WORKDATE
        ELSE
            PostDate := SalesHrd."Posting Date";

        ItemTypeExist := FALSE;

        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::"Item Type");
        DiscountLine.SETRANGE(Code, SalesLine."Item Type");
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Exclude);
        DiscountLine.SETRANGE(Status, DiscountLine.Status::Enable);
        DiscountLine.SETFILTER("Valid From", '<=%1', PostDate);
        DiscountLine.SETFILTER("Valid To", '>=%1', PostDate);
        IF DiscountLine.FINDFIRST THEN
            SpExclude := TRUE;

        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::"Item Type");
        DiscountLine.SETRANGE(Code, SalesLine."Item Type");
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Include);
        DiscountLine.SETRANGE(Status, DiscountLine.Status::Enable);
        DiscountLine.SETFILTER("Valid From", '<=%1', PostDate);
        DiscountLine.SETFILTER("Valid To", '>=%1', PostDate);
        IF DiscountLine.FINDFIRST THEN
            SpInclude := TRUE;

        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::"Item Type");
        DiscountLine.SETRANGE(All, TRUE);
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Exclude);
        DiscountLine.SETRANGE(Status, DiscountLine.Status::Enable);
        DiscountLine.SETFILTER("Valid From", '<=%1', PostDate);
        DiscountLine.SETFILTER("Valid To", '>=%1', PostDate);
        IF DiscountLine.FINDFIRST THEN
            AllExclude := TRUE;

        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::"Item Type");
        DiscountLine.SETRANGE(All, TRUE);
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Include);
        DiscountLine.SETRANGE(Status, DiscountLine.Status::Enable);
        DiscountLine.SETFILTER("Valid From", '<=%1', PostDate);
        DiscountLine.SETFILTER("Valid To", '>=%1', PostDate);
        IF DiscountLine.FINDFIRST THEN
            AllInclude := TRUE;

        IF AllInclude THEN BEGIN
            IF SpExclude THEN
                ItemTypeExist := FALSE
            ELSE
                ItemTypeExist := TRUE;
        END;

        IF AllExclude THEN BEGIN
            IF SpInclude THEN
                ItemTypeExist := TRUE
            ELSE
                ItemTypeExist := FALSE;
        END;

        EXIT(ItemTypeExist);

    end;


    procedure LineGroupSizeApplicable(SalesLine: Record "Sales Line"; SalesHrd: Record "Sales Header") SizeExist: Boolean
    var
        DiscountLine: Record "Discount Line";
        AllInclude: Boolean;
        AllExclude: Boolean;
        SpInclude: Boolean;
        SpExclude: Boolean;
        PostDate: Date;
    begin
        SizeExist := FALSE;
        /*
        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type",DiscountLine."Group Type"::Size);
        DiscountLine.SETRANGE(Code,SalesLine."Size Code");
        DiscountLine.SETRANGE("Include/Exclude",DiscountLine."Include/Exclude"::Exclude);
        DiscountLine.SETRANGE(Status,DiscountLine.Status::Enable);
        DiscountLine.SETFILTER("Valid From",'<=%1',SalesHrd."Posting Date");
        DiscountLine.SETFILTER("Valid To",'>=%1',SalesHrd."Posting Date");
        IF DiscountLine.FINDFIRST THEN
          SizeExist:=FALSE;
        */

        SpExclude := FALSE;
        SpInclude := FALSE;
        AllExclude := FALSE;
        AllInclude := FALSE;

        IF SalesHrd."Posting Date" = 0D THEN
            PostDate := WORKDATE
        ELSE
            PostDate := SalesHrd."Posting Date";


        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::Size);
        DiscountLine.SETRANGE(Code, SalesLine."Size Code");
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Exclude);
        DiscountLine.SETRANGE(Status, DiscountLine.Status::Enable);
        DiscountLine.SETFILTER("Valid From", '<=%1', PostDate);
        DiscountLine.SETFILTER("Valid To", '>=%1', PostDate);
        IF DiscountLine.FINDFIRST THEN
            SpExclude := TRUE;

        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::Size);
        DiscountLine.SETRANGE(Code, SalesLine."Size Code");
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Include);
        DiscountLine.SETRANGE(Status, DiscountLine.Status::Enable);
        DiscountLine.SETFILTER("Valid From", '<=%1', PostDate);
        DiscountLine.SETFILTER("Valid To", '>=%1', PostDate);
        IF DiscountLine.FINDFIRST THEN
            SpInclude := TRUE;

        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::Size);
        DiscountLine.SETRANGE(All, TRUE);
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Exclude);
        DiscountLine.SETRANGE(Status, DiscountLine.Status::Enable);
        DiscountLine.SETFILTER("Valid From", '<=%1', PostDate);
        DiscountLine.SETFILTER("Valid To", '>=%1', PostDate);
        IF DiscountLine.FINDFIRST THEN
            AllExclude := TRUE;

        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::Size);
        DiscountLine.SETRANGE(All, TRUE);
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Include);
        DiscountLine.SETRANGE(Status, DiscountLine.Status::Enable);
        DiscountLine.SETFILTER("Valid From", '<=%1', PostDate);
        DiscountLine.SETFILTER("Valid To", '>=%1', PostDate);
        IF DiscountLine.FINDFIRST THEN
            AllInclude := TRUE;

        IF AllInclude THEN BEGIN
            IF SpExclude THEN
                SizeExist := FALSE
            ELSE
                SizeExist := TRUE;
        END;

        IF AllExclude THEN BEGIN
            IF SpInclude THEN
                SizeExist := TRUE
            ELSE
                SizeExist := FALSE;
        END;


        EXIT(SizeExist);

    end;


    procedure LineGroupTitleApplicable(SalesLine: Record "Sales Line"; SalesHrd: Record "Sales Header") Exists: Boolean
    var
        DiscountLine: Record "Discount Line";
        AllInclude: Boolean;
        AllExclude: Boolean;
        SpInclude: Boolean;
        SpExclude: Boolean;
        PostDate: Date;
    begin
        Exists := FALSE;
        /*
        DiscountLine.RESET;
        //DiscountLine.SETRANGE(Code,SalesLine."Group Code");
        DiscountLine.SETRANGE("Group Type",DiscountLine."Group Type"::"Tile Group");
        DiscountLine.SETRANGE(Code,SalesLine."Type Catogery Code");  //MSKS2006
        DiscountLine.SETRANGE("Include/Exclude",DiscountLine."Include/Exclude"::Exclude);
        IF DiscountLine.FINDFIRST THEN
          Exists:=TRUE;
        
        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type",DiscountLine."Group Type"::"Tile Group");
        DiscountLine.SETRANGE(All,TRUE);
        DiscountLine.SETRANGE("Include/Exclude",DiscountLine."Include/Exclude"::Exclude);
        IF DiscountLine.FINDFIRST THEN
          Exists:=TRUE;
        
        */

        SpExclude := FALSE;
        SpInclude := FALSE;
        AllExclude := FALSE;
        AllInclude := FALSE;

        IF SalesHrd."Posting Date" = 0D THEN
            PostDate := WORKDATE
        ELSE
            PostDate := SalesHrd."Posting Date";


        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::"Tile Group");
        DiscountLine.SETRANGE(Code, SalesLine."Type Catogery Code");  //MSKS2006
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Exclude);
        DiscountLine.SETRANGE(Status, DiscountLine.Status::Enable);
        DiscountLine.SETFILTER("Valid From", '<=%1', PostDate);
        DiscountLine.SETFILTER("Valid To", '>=%1', PostDate);
        IF DiscountLine.FINDFIRST THEN
            SpExclude := TRUE;

        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::"Tile Group");
        DiscountLine.SETRANGE(Code, SalesLine."Type Catogery Code");  //MSKS2006
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Include);
        DiscountLine.SETRANGE(Status, DiscountLine.Status::Enable);
        DiscountLine.SETFILTER("Valid From", '<=%1', PostDate);
        DiscountLine.SETFILTER("Valid To", '>=%1', PostDate);
        IF DiscountLine.FINDFIRST THEN
            SpInclude := TRUE;

        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::"Tile Group");
        DiscountLine.SETRANGE(All, TRUE);
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Exclude);
        DiscountLine.SETRANGE(Status, DiscountLine.Status::Enable);
        DiscountLine.SETFILTER("Valid From", '<=%1', PostDate);
        DiscountLine.SETFILTER("Valid To", '>=%1', PostDate);
        IF DiscountLine.FINDFIRST THEN
            AllExclude := TRUE;

        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::"Tile Group");
        DiscountLine.SETRANGE(All, TRUE);
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Include);
        DiscountLine.SETRANGE(Status, DiscountLine.Status::Enable);
        DiscountLine.SETFILTER("Valid From", '<=%1', PostDate);
        DiscountLine.SETFILTER("Valid To", '>=%1', PostDate);
        IF DiscountLine.FINDFIRST THEN
            AllInclude := TRUE;

        IF AllInclude THEN BEGIN
            IF SpExclude THEN
                Exists := FALSE
            ELSE
                Exists := TRUE;
        END;

        IF AllExclude THEN BEGIN
            IF SpInclude THEN
                Exists := TRUE
            ELSE
                Exists := FALSE;
        END;

        EXIT(Exists);

    end;


    procedure LineGroupItemApplicable(SalesLine: Record "Sales Line"; SalesHrd: Record "Sales Header") ItemExist: Boolean
    var
        DiscountLine: Record "Discount Line";
        AllInclude: Boolean;
        AllExclude: Boolean;
        SpInclude: Boolean;
        SpExclude: Boolean;
        PostDate: Date;
    begin
        SpExclude := FALSE;
        SpInclude := FALSE;
        AllExclude := FALSE;
        AllInclude := FALSE;

        IF SalesHrd."Posting Date" = 0D THEN
            PostDate := WORKDATE
        ELSE
            PostDate := SalesHrd."Posting Date";


        ItemExist := FALSE;

        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::Item);
        DiscountLine.SETRANGE(Code, SalesLine."No.");
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Exclude);
        DiscountLine.SETRANGE(Status, DiscountLine.Status::Enable);
        DiscountLine.SETFILTER("Valid From", '<=%1', PostDate);
        DiscountLine.SETFILTER("Valid To", '>=%1', PostDate);
        IF DiscountLine.FINDFIRST THEN
            SpExclude := TRUE;

        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::Item);
        DiscountLine.SETRANGE(Code, SalesLine."No.");
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Include);
        DiscountLine.SETRANGE(Status, DiscountLine.Status::Enable);
        DiscountLine.SETFILTER("Valid From", '<=%1', PostDate);
        DiscountLine.SETFILTER("Valid To", '>=%1', PostDate);
        IF DiscountLine.FINDFIRST THEN
            SpInclude := TRUE;

        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::Item);
        DiscountLine.SETRANGE(All, TRUE);
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Exclude);
        DiscountLine.SETRANGE(Status, DiscountLine.Status::Enable);
        DiscountLine.SETFILTER("Valid From", '<=%1', PostDate);
        DiscountLine.SETFILTER("Valid To", '>=%1', PostDate);
        IF DiscountLine.FINDFIRST THEN
            AllExclude := TRUE;

        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::Item);
        DiscountLine.SETRANGE(All, TRUE);
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Include);
        DiscountLine.SETRANGE(Status, DiscountLine.Status::Enable);
        DiscountLine.SETFILTER("Valid From", '<=%1', PostDate);
        DiscountLine.SETFILTER("Valid To", '>=%1', PostDate);
        IF DiscountLine.FINDFIRST THEN
            AllInclude := TRUE;

        IF AllInclude THEN BEGIN
            IF SpExclude THEN
                ItemExist := FALSE
            ELSE
                ItemExist := TRUE;
        END;

        IF AllExclude THEN BEGIN
            IF SpInclude THEN
                ItemExist := TRUE
            ELSE
                ItemExist := FALSE;
        END;


        EXIT(ItemExist);
    end;


    procedure LineGroupItemTypeAppExcludeNOC(SalesLine: Record "Sales Line") Exists: Boolean
    var
        DiscountLine: Record "Discount Line";
    begin
        // Not in Use
        Exists := FALSE;

        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::"Item Type");
        DiscountLine.SETRANGE(All, TRUE);
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Exclude);
        IF DiscountLine.FINDFIRST THEN
            Exists := TRUE;


        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::"Item Type");
        DiscountLine.SETRANGE(Code, SalesLine."Item Type");
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Exclude);
        IF DiscountLine.FINDFIRST THEN
            Exists := TRUE;

        EXIT(Exists);
    end;


    procedure LineGroupSizeApplicableExcNOC(SalesLine: Record "Sales Line") Exists: Boolean
    var
        DiscountLine: Record "Discount Line";
    begin
        // Not in Use
        Exists := FALSE;
        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::Size);
        DiscountLine.SETRANGE(Code, SalesLine."Size Code");
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Exclude);
        IF DiscountLine.FINDFIRST THEN
            Exists := TRUE;

        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::Size);
        DiscountLine.SETRANGE(All, TRUE);
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Exclude);
        IF DiscountLine.FINDFIRST THEN
            Exists := TRUE;

        EXIT(Exists);
    end;


    procedure LineGroupTitleApplicablExclNOC(SalesLine: Record "Sales Line") Exists: Boolean
    var
        DiscountLine: Record "Discount Line";
    begin
        // Not in Use
        Exists := FALSE;
        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::"Tile Group");
        DiscountLine.SETRANGE(Code, SalesLine."Group Code");
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Exclude);
        IF DiscountLine.FINDFIRST THEN
            Exists := TRUE;

        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::"Tile Group");
        DiscountLine.SETRANGE(All, TRUE);
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Exclude);
        IF DiscountLine.FINDFIRST THEN
            Exists := TRUE;

        EXIT(Exists);
    end;


    procedure LineGroupItemApplicableExcNOC(SalesLine: Record "Sales Line") Exists: Boolean
    var
        DiscountLine: Record "Discount Line";
    begin
        // Not in Use
        Exists := FALSE;
        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::Item);
        DiscountLine.SETRANGE(Code, SalesLine."No.");
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Exclude);
        IF DiscountLine.FINDFIRST THEN
            Exists := TRUE;

        DiscountLine.RESET;
        DiscountLine.SETRANGE("Group Type", DiscountLine."Group Type"::Item);
        DiscountLine.SETRANGE(All, TRUE);
        DiscountLine.SETRANGE("Include/Exclude", DiscountLine."Include/Exclude"::Exclude);
        IF DiscountLine.FINDFIRST THEN
            Exists := TRUE;

        EXIT(Exists);
    end;
}

