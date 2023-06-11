codeunit 50037 "Scheme Management"
{

    trigger OnRun()
    begin
    end;

    var
        SchemeEntries: Record "Scheme Entries";


    procedure CreateSchemeEntry(SchemeCode: Code[20]; SalesInvLine: Record "Sales Invoice Line"; ParentCode: Code[20])
    var
        RecItem: Record Item;
        Eligibleamt: Decimal;
    begin
        IF SalesInvLine.Type <> SalesInvLine.Type::Item THEN
            EXIT;
        IF SalesInvLine.Quantity = 0 THEN
            EXIT;

        SchemeEntries.INIT;
        SchemeEntries."Entry No." := GetNextEntryNo();
        IF ParentCode <> '' THEN
            SchemeEntries."Customer No." := ParentCode
        ELSE
            SchemeEntries."Customer No." := SalesInvLine."Sell-to Customer No.";
        SchemeEntries.Scheme := SchemeCode;
        SchemeEntries."Sales Invoice No." := SalesInvLine."Document No.";
        SchemeEntries."Sales Invoice Line" := SalesInvLine."Line No.";
        SchemeEntries.HVP := ISHVPProduct(SalesInvLine."No.", SalesInvLine."Posting Date");
        Eligibleamt := CalculateSchemeBaseAmount(SalesInvLine);
        SchemeEntries."Target Sales" := Eligibleamt;
        SchemeEntries."Discontinued Product" := IsDiscontinuedProduct(SalesInvLine."No.", SalesInvLine."Posting Date");
        SchemeEntries."Item Code" := SalesInvLine."No.";
        SchemeEntries."Discount Given" := SalesInvLine.D1 + SalesInvLine.D2 + SalesInvLine.D3 + SalesInvLine.D4;
        SchemeEntries."Child Customer" := SalesInvLine."Sell-to Customer No.";
        SchemeEntries."Posting Date" := SalesInvLine."Posting Date";
        IF RecItem.GET(SalesInvLine."No.") THEN;
        SchemeEntries."Eligible Discount" := GetEligibleDiscount(SchemeCode, SalesInvLine."Sell-to Customer No.", RecItem."Scheme Group", SalesInvLine."Posting Date");
        IF SchemeEntries."Discount Given" <= SchemeEntries."Eligible Discount" THEN
            SchemeEntries."Eligible Sales" := Eligibleamt
        ELSE
            SchemeEntries."Eligible Sales" := 0;
        IF NOT IsSchemeApplicable(SchemeCode, SalesInvLine."No.") THEN
            SchemeEntries."Eligible Sales" := 0;
        SchemeEntries.INSERT;
    end;


    procedure GetNextEntryNo(): Integer
    begin
        SchemeEntries.RESET;
        IF SchemeEntries.FINDLAST THEN
            EXIT(SchemeEntries."Entry No." + 1)
        ELSE
            EXIT(1);
    end;


    procedure ISHVPProduct(ItemCode: Code[20]; DtDate: Date): Boolean
    var
        HVPDiscontinuedItems: Record "HVP/Discontinued Items";
    begin
        HVPDiscontinuedItems.SETRANGE(Type, HVPDiscontinuedItems.Type::HVP);
        HVPDiscontinuedItems.SETRANGE("Item No.", ItemCode);
        HVPDiscontinuedItems.SETFILTER("Starting Date", '%1..%2', 0D, DtDate);
        IF HVPDiscontinuedItems.FINDLAST THEN
            EXIT(HVPDiscontinuedItems."HVP/Discontinued") ELSE
            EXIT(FALSE);
    end;


    procedure IsDiscontinuedProduct(ItemCode: Code[20]; DtDate: Date): Boolean
    var
        HVPDiscontinuedItems: Record "HVP/Discontinued Items";
    begin
        HVPDiscontinuedItems.SETRANGE(Type, HVPDiscontinuedItems.Type::Discontinued);
        HVPDiscontinuedItems.SETRANGE("Item No.", ItemCode);
        HVPDiscontinuedItems.SETFILTER("Starting Date", '%1..%2', 0D, DtDate);
        IF HVPDiscontinuedItems.FINDLAST THEN
            EXIT(HVPDiscontinuedItems."HVP/Discontinued") ELSE
            EXIT(FALSE);
    end;


    procedure IsCustomerSchemeApplicable(SchemeCode: Code[20]; CustomerNo: Code[20]): Boolean
    var
        CustSchemeDetails: Record "Customer Scheme Details";
        Cust: Record Customer;
    begin
        CustSchemeDetails.RESET;
        CustSchemeDetails.SETFILTER("Customer No.", '%1', CustomerNo);
        CustSchemeDetails.SETFILTER("Scheme Code", '%1', SchemeCode);
        IF CustSchemeDetails.FINDFIRST THEN
            EXIT(TRUE)
        ELSE
            /*
            ELSE BEGIN
            Cust.RESET;
            Cust.SETFILTER(Cust."Parent Customer No.",'<>%1','');
            Cust.SETFILTER("No.",'%1',CustomerNo);
            IF Cust.FINDFIRST THEN
            */
            EXIT(FALSE);
        // END;

    end;


    procedure IsSchemeApplicable(SchemeCode: Code[20]; ItemCode: Code[20]): Boolean
    var
        Item: Record Item;
        SchemeProdMapping: Record "Sales Jpurnal Data";
        QualityIncluded: Boolean;
        SizeIncluded: Boolean;
    begin
        /* 15578    Item.GET(ItemCode);

            SchemeProdMapping.RESET;
            SchemeProdMapping.SETFILTER("Entry No.", '%1', SchemeCode);
            SchemeProdMapping.SETFILTER(SchemeProdMapping."Customer Name", '%1', SchemeProdMapping."Customer Name"::"2");
            SchemeProdMapping.SETFILTER(SchemeProdMapping.CRT, '%1', ItemCode);
            IF SchemeProdMapping.FINDFIRST THEN
                EXIT(SchemeProdMapping."Basic Amount" = SchemeProdMapping."Basic Amount"::"0");

            SchemeProdMapping.RESET;
            SchemeProdMapping.SETFILTER("Entry No.", '%1', SchemeCode);
            SchemeProdMapping.SETFILTER(SchemeProdMapping."Customer Name", '%1', SchemeProdMapping."Customer Name"::"0");
            SchemeProdMapping.SETFILTER(SchemeProdMapping.CRT, '%1', Item."Quality Code");
            IF SchemeProdMapping.FINDFIRST THEN
                QualityIncluded := (SchemeProdMapping."Basic Amount" = SchemeProdMapping."Basic Amount"::"0")
            ELSE BEGIN
                SchemeProdMapping.RESET;
                SchemeProdMapping.SETFILTER("Entry No.", '%1', SchemeCode);
                SchemeProdMapping.SETFILTER(SchemeProdMapping."Customer Name", '%1', SchemeProdMapping."Customer Name"::"0");
                SchemeProdMapping.SETFILTER("Excise Amount", '%1', TRUE);
                IF SchemeProdMapping.FINDFIRST THEN
                    QualityIncluded := (SchemeProdMapping."Basic Amount" = SchemeProdMapping."Basic Amount"::"0");
                //      MESSAGE('hi %1',SchemeProdMapping."Include/Exclude");
            END;
            SchemeProdMapping.RESET;
            SchemeProdMapping.SETFILTER("Entry No.", '%1', SchemeCode);
            SchemeProdMapping.SETFILTER("Customer Name", '%1', SchemeProdMapping."Customer Name"::"1");
            SchemeProdMapping.SETFILTER(CRT, '%1', Item."Size Code");
            IF SchemeProdMapping.FINDFIRST THEN
                SizeIncluded := (SchemeProdMapping."Basic Amount" = SchemeProdMapping."Basic Amount"::"0")
            ELSE BEGIN
                SchemeProdMapping.RESET;
                SchemeProdMapping.SETFILTER("Entry No.", '%1', SchemeCode);
                SchemeProdMapping.SETFILTER(SchemeProdMapping."Customer Name", '%1', SchemeProdMapping."Customer Name"::"1");
                SchemeProdMapping.SETFILTER("Excise Amount", '%1', TRUE);
                IF SchemeProdMapping.FINDFIRST THEN
                    SizeIncluded := (SchemeProdMapping."Basic Amount" = SchemeProdMapping."Basic Amount"::"0");
                //     MESSAGE('size hi %1',SchemeProdMapping."Include/Exclude");

            END;
            //MESSAGE('%1-%2',QualityIncluded,SizeIncluded );

            IF QualityIncluded AND SizeIncluded THEN
                EXIT(TRUE) ELSE
                EXIT(FALSE);*/ // 15578
    end;


    procedure GetEligibleDiscount(SchemeCode: Code[20]; CustomerNo: Code[20]; ItemSchemeGroup: Code[20]; PostingDate: Date): Decimal
    var
        SchemeDealerMap: Record "Last Year Sales Data";
    begin
        /*   SchemeDealerMap.RESET;
           SchemeDealerMap.SETFILTER("Document No.", '%1', SchemeDealerMap."Document No."::"1");
           SchemeDealerMap.SETFILTER(DocumentType, '%1', SchemeCode);
           SchemeDealerMap.SETFILTER(InvoiceNo, '%1', ItemSchemeGroup);
           SchemeDealerMap.SETFILTER(SchemeDealerMap.CustomerNo, '%1', CustomerNo);
           SchemeDealerMap.SETFILTER(SchemeDealerMap.LocationCode, '%1..%2', 0D, PostingDate);
           IF SchemeDealerMap.FINDLAST THEN
               EXIT(SchemeDealerMap."Allowed Discount") ELSE BEGIN
               SchemeDealerMap.RESET;
               SchemeDealerMap.SETFILTER(DocumentType, '%1', SchemeCode);
               SchemeDealerMap.SETFILTER(InvoiceNo, '%1', ItemSchemeGroup);
               SchemeDealerMap.SETFILTER("Document No.", '%1', SchemeDealerMap."Document No."::"0");
               SchemeDealerMap.SETFILTER(SchemeDealerMap.LocationCode, '%1..%2', 0D, PostingDate);
               IF SchemeDealerMap.FINDLAST THEN
                   EXIT(SchemeDealerMap."Allowed Discount");

           END;*/ // 15578
    end;


    procedure CalculateSchemeBaseAmount(SalesInvLine: Record "Sales Invoice Line") SaleableValue: Decimal
    var
        //  PostedStrOrderLDetails: Record "13798";
        InvDisc: Decimal;
        ExAmount: Decimal;
    begin
        /*    IF NOT SalesInvLine."Free Supply" THEN BEGIN
                IF SalesInvLine.Amount <> 0 THEN
                    ExAmount += SalesInvLine.Amount + SalesInvLine."Excise Amount"
                ELSE
                    IF SalesInvLine."Line Discount %" <> 100 THEN
                        ExAmount += ROUND((SalesInvLine."Unit Price" * SalesInvLine.Quantity) +
                         SalesInvLine."Excise Amount", 0.01, '=');
            END ELSE BEGIN
                ExAmount += SalesInvLine.Amount + SalesInvLine."Excise Amount";
            END;*/ // 15578

        InvDisc := 0;
        /*
        PostedStrOrderLDetails.RESET;
        PostedStrOrderLDetails.SETRANGE("Document Type",PostedStrOrderLDetails."Document Type"::Invoice);
        PostedStrOrderLDetails.SETRANGE("Invoice No.",SalesInvLine."Document No.");
        PostedStrOrderLDetails.SETRANGE(PostedStrOrderLDetails."Line No.",SalesInvLine."Line No.");
        PostedStrOrderLDetails.SETRANGE("Tax/Charge Group",'DISCOUNT');
        IF PostedStrOrderLDetails.FIND('-')THEN BEGIN
        REPEAT
          InvDisc+=PostedStrOrderLDetails.Amount;
        UNTIL PostedStrOrderLDetails.NEXT=0;
        END;
        */
        SaleableValue := ExAmount - ABS(InvDisc);
        EXIT(SaleableValue);

    end;


    procedure "--Sales Return"()
    begin
    end;


    procedure CreateSalesReturnSchemeEntry(SchemeCode: Code[20]; SalesInvLine: Record "Sales Cr.Memo Line"; ParentCode: Code[20])
    var
        RecItem: Record Item;
        Eligibleamt: Decimal;
    begin
        IF SalesInvLine.Type <> SalesInvLine.Type::Item THEN
            EXIT;
        SchemeEntries.INIT;
        SchemeEntries."Entry No." := GetNextEntryNo();
        IF ParentCode <> '' THEN
            SchemeEntries."Customer No." := ParentCode
        ELSE
            SchemeEntries."Customer No." := SalesInvLine."Sell-to Customer No.";

        SchemeEntries."Child Customer" := SalesInvLine."Sell-to Customer No.";
        SchemeEntries.Scheme := SchemeCode;
        SchemeEntries."Sales Invoice No." := SalesInvLine."Document No.";
        SchemeEntries."Sales Invoice Line" := SalesInvLine."Line No.";
        SchemeEntries.HVP := ISHVPProduct(SalesInvLine."No.", SalesInvLine."Posting Date");
        Eligibleamt := CalculateSalesRetSchemeBaseAmount(SalesInvLine);
        SchemeEntries."Target Sales" := -1 * Eligibleamt;
        SchemeEntries."Discontinued Product" := IsDiscontinuedProduct(SalesInvLine."No.", SalesInvLine."Posting Date");
        SchemeEntries."Item Code" := SalesInvLine."No.";
        SchemeEntries."Posting Date" := SalesInvLine."Posting Date";
        SchemeEntries."Discount Given" := SalesInvLine.D1 + SalesInvLine.D2 + SalesInvLine.D3 + SalesInvLine.D4;
        IF RecItem.GET(SalesInvLine."No.") THEN;
        SchemeEntries."Eligible Discount" := GetEligibleDiscount(SchemeCode, SalesInvLine."Sell-to Customer No.", RecItem."Scheme Group", SalesInvLine."Posting Date");
        IF SchemeEntries."Discount Given" <= SchemeEntries."Eligible Discount" THEN
            SchemeEntries."Eligible Sales" := -1 * Eligibleamt
        ELSE
            SchemeEntries."Eligible Sales" := 0;
        IF NOT IsSchemeApplicable(SchemeCode, SalesInvLine."No.") THEN
            SchemeEntries."Eligible Sales" := 0;

        SchemeEntries.INSERT;
    end;


    procedure CalculateSalesRetSchemeBaseAmount(SalesInvLine: Record "Sales Cr.Memo Line") SaleableValue: Decimal
    var
        //  PostedStrOrderLDetails: Record "13798";
        InvDisc: Decimal;
        ExAmount: Decimal;
    begin
        /*    IF NOT SalesInvLine."Free Supply" THEN BEGIN
                IF SalesInvLine.Amount <> 0 THEN
                    ExAmount += SalesInvLine.Amount + SalesInvLine."Excise Amount"
                ELSE
                    IF SalesInvLine."Line Discount %" <> 100 THEN
                        ExAmount += ROUND((SalesInvLine."Unit Price" * SalesInvLine.Quantity) +
                         SalesInvLine."Excise Amount", 0.01, '=');
            END ELSE BEGIN
                ExAmount += SalesInvLine.Amount + SalesInvLine."Excise Amount";
            END;*/ // 15578
                   /*
                   InvDisc:=0;
                   PostedStrOrderLDetails.RESET;
                   PostedStrOrderLDetails.SETRANGE("Document Type",PostedStrOrderLDetails."Document Type"::"Credit Memo");
                   PostedStrOrderLDetails.SETRANGE("Invoice No.",SalesInvLine."Document No.");
                   PostedStrOrderLDetails.SETRANGE(PostedStrOrderLDetails."Line No.",SalesInvLine."Line No.");
                   PostedStrOrderLDetails.SETRANGE("Tax/Charge Group",'DISCOUNT');
                   IF PostedStrOrderLDetails.FIND('-')THEN BEGIN
                   REPEAT
                     InvDisc+=PostedStrOrderLDetails.Amount;
                   UNTIL PostedStrOrderLDetails.NEXT=0;
                   END;
                   */
        SaleableValue := ExAmount - ABS(InvDisc);
        EXIT(SaleableValue);

    end;


    procedure CalculatePayout(DealerTarger: Record "Customer Scheme Details"; var CalculationBase: Decimal): Decimal
    var
        SchemeMaster: Record "Scheme Master";
        SchemeSlab: Record "PMT Goal Sheet Data";
        PayoutCalculationAmt: Decimal;
        EligiblePayoutCalculationAmt: Decimal;
        IncentivePercentage: Decimal;
        HVPTarget: Boolean;
    begin
        IF SchemeMaster.GET(DealerTarger."Scheme Code") THEN BEGIN
            DealerTarger.CALCFIELDS(DealerTarger."Total Turnover", DealerTarger."Target Achieved - HVP", DealerTarger."Total Target Achieved");
            IF SchemeMaster."Incentive Calculation ON" = SchemeMaster."Incentive Calculation ON"::Turnover THEN
                PayoutCalculationAmt := DealerTarger."Total Turnover";

            IF SchemeMaster."Incentive Calculation ON" = SchemeMaster."Incentive Calculation ON"::"Eligible Sales" THEN
                PayoutCalculationAmt := DealerTarger."Total Target Achieved";

            IF DealerTarger."With HVP Target" <> 0 THEN BEGIN
                EligiblePayoutCalculationAmt := DealerTarger."Target Achieved - HVP";
                IF DealerTarger."Target Achieved - HVP" > DealerTarger."With HVP Target" THEN
                    HVPTarget := TRUE;
            END ELSE BEGIN
                EligiblePayoutCalculationAmt := DealerTarger."Total Target Achieved";
            END;

            IF PayoutCalculationAmt < EligiblePayoutCalculationAmt THEN
                PayoutCalculationAmt := 0;

            /*  IF SchemeMaster."Incentive Calculation Basis" = SchemeMaster."Incentive Calculation Basis"::"Slab-Basis" THEN BEGIN
                  SchemeSlab.RESET;
                  SchemeSlab.SETRANGE(SchemeSlab."PMT ID", DealerTarger."Scheme Code");
                  SchemeSlab.SETFILTER("Lead ID", '>%1', PayoutCalculationAmt);
                  IF SchemeSlab.FINDFIRST THEN
                      IF HVPTarget THEN
                          IncentivePercentage := SchemeSlab."Tiling Date"
                      ELSE
                          IncentivePercentage := SchemeSlab."Incentive %age Without HVP";
              END;*/ // 15578

            IF SchemeMaster."Incentive Calculation Basis" = SchemeMaster."Incentive Calculation Basis"::"Non-Slab Basis" THEN BEGIN
                IncentivePercentage := SchemeMaster."Incentive %age";
            END;
        END;
        IF PayoutCalculationAmt = 0 THEN
            IncentivePercentage := 0;

        CalculationBase := PayoutCalculationAmt;
        EXIT(IncentivePercentage);
    end;


    procedure SendSchemeMessage(DealerSchemeDetails: Record "Customer Scheme Details")
    var
        TxtOption1: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";
        TxtOption2: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";
        TxtOption3: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";
        TxtOption4: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";
        TxtOption0: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";
        mLinkWith: Integer;
        mSendMessage: Boolean;
        ltxtMessage: Text;
        RecCust: Record Customer;
        mLinkCode: Code[20];
        ltxtMessage1: Text;
        ltxtMessage2: Text;
        lrecMobileNo: Record "SMS - Mobile No.";
        RecCustType: Record "Customer Type";
        SendSMS: Codeunit "SMS - Send Message";
        SchemeMaster: Record "Scheme Master";
    begin
        SchemeMaster.GET(DealerSchemeDetails."Scheme Code");
        TxtOption1 := 5; // ,PCH,Sales Person,Govt.SP,Private SP,Not to send
        TxtOption2 := 5;
        TxtOption3 := 5;
        TxtOption4 := 5;

        IF (SchemeMaster."SMS Template") <> '' THEN BEGIN
            mLinkWith := 1;
            WITH DealerSchemeDetails DO BEGIN
                RecCust.GET(DealerSchemeDetails."Customer No.");
                mSendMessage := FALSE;
                DealerSchemeDetails.CALCFIELDS(DealerSchemeDetails."Target Achieved - HVP", DealerSchemeDetails."Total Target Achieved", DealerSchemeDetails."Total Turnover");

                ltxtMessage := STRSUBSTNO(SchemeMaster."SMS Template"
                                         , RecCust.Name                 //1
                                         , RecCust.City                          //2
                                         , ROUND(DealerSchemeDetails."Total Target" / 100000, 1) //Target
                                         , ROUND(DealerSchemeDetails."Total Turnover" / 100000, 1)
                                         , ROUND(DealerSchemeDetails."Total Target Achieved" / 100000, 1)
                                         , (ROUND(DealerSchemeDetails."Total Target" / 100000, 1) - ROUND(DealerSchemeDetails."Total Turnover" / 100000, 1))
                                         , ''
                                         , ''
                                         , ''
                                         , ''                 //10
                                         , ''            //11
                                         , ''               //12
                                         );
                mLinkCode := RecCust."No.";
                mSendMessage := TRUE;
                //   END;

                IF mSendMessage THEN BEGIN
                    ltxtMessage1 := '';
                    ltxtMessage2 := '';

                    IF STRLEN(ltxtMessage) > 160 THEN BEGIN
                        ltxtMessage1 := '1/2 --' + COPYSTR(ltxtMessage, 1, 150);
                        ltxtMessage2 := '2/2 --' + COPYSTR(ltxtMessage, 151, STRLEN(ltxtMessage) - 150);
                    END
                    ELSE BEGIN
                        ltxtMessage1 := ltxtMessage;
                    END;


                    IF mLinkWith = 1 THEN
                        lrecMobileNo.SETRANGE("Link With", lrecMobileNo."Link With"::Customer)
                    ELSE
                        IF mLinkWith = 2 THEN
                            lrecMobileNo.SETRANGE("Link With", lrecMobileNo."Link With"::Vendor);

                    lrecMobileNo.SETRANGE("Link Code", mLinkCode);
                    lrecMobileNo.SETRANGE("Send Mobile Communication", TRUE);
                    IF mLinkWith = 1 THEN BEGIN
                        IF RecCust.GET(mLinkCode) THEN
                            IF RecCustType.GET(RecCustType.Type::Customer, RecCust."Customer Type") THEN BEGIN
                                //IF RecCustType."Send DA PCH SMS" THEN
                                //   TxtOption1 := 1;

                                //IF RecCustType."Send DA SP SMS" THEN
                                //   TxtOption2 := 2;

                                //IF RecCustType."Send DA Cu SMS" THEN
                                //   TxtOption3 := 3;

                                //IF RecCustType."Send Private SMS" THEN
                                //   TxtOption4 := 4;
                                IF RecCustType."Send DA Customer SMS" THEN
                                    TxtOption0 := 0;

                            END;

                    END;
                    lrecMobileNo.SETFILTER(Type, '%1|%2|%3|%4|%5', TxtOption1, TxtOption2, TxtOption3, TxtOption4, TxtOption0);
                    IF lrecMobileNo.FINDFIRST THEN BEGIN
                        /* REPEAT
                             SendSMS.SendMessage(lrecMobileNo."Mobile No.", ltxtMessage1, 0);
                             IF ltxtMessage2 <> '' THEN
                                 SendSMS.SendMessage(lrecMobileNo."Mobile No.", ltxtMessage2, 0);
                         UNTIL lrecMobileNo.NEXT = 0;*/// 15578
                    END;
                END;
            END;
        END;
    end;
}

