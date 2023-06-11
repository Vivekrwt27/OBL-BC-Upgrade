codeunit 50003 "SMS Sender - Due Date"
{

    trigger OnRun()
    begin
        lrecSMSServerSetup.GET;
        mSendMessage := FALSE;
        SendPastDueMsg := FALSE;
        SendCurrDueMsg := FALSE;
        SendDueMsg := FALSE;
        IF lrecSMSServerSetup."Activate SMS Sending" THEN BEGIN

            SendPastDueMsg := lrecSMSServerSetup."Post Customer -5 Due Date";
            SendCurrDueMsg := lrecSMSServerSetup."Post Customer Due Date";
            SendDueMsg := lrecSMSServerSetup."Post Customer +5 Due Date";

            IF SendPastDueMsg OR SendCurrDueMsg OR SendDueMsg THEN BEGIN
                mLinkWith := 1;
                RecCustLedger.RESET;
                RecCustLedger.SETCURRENTKEY("Customer No.", Open, Positive, "Due Date", "Currency Code");
                RecCustLedger.SETRANGE("Document Type", RecCustLedger."Document Type"::Invoice);
                RecCustLedger.SETRANGE(Open, TRUE);
                RecCustLedger.SETRANGE("Due Date", TODAY - 5, TODAY + 5);
                IF RecCustLedger.FINDFIRST THEN BEGIN
                    REPEAT
                        mSendMessage := FALSE;
                        ltxtMessage := ''; //MSKS2311
                        mLinkCode := ''; //MSKS2311


                        IF (RecCustLedger."Document Type" = RecCustLedger."Document Type"::Invoice) AND
                            lrecSMSServerSetup."Post Customer Invoice" THEN BEGIN
                            RecCustLedger.CALCFIELDS("Remaining Amount");
                            RecCustLedger.CALCFIELDS(Amount);

                            lrecCust.GET(RecCustLedger."Customer No.");
                            //lrecCust.CALCFIELDS(Balance);

                            lTotalOutStanding := RecCustLedger."Remaining Amount";

                            IF SendPastDueMsg AND (RecCustLedger."Due Date" = (TODAY - 5)) THEN BEGIN
                                SMSTemplateID := lrecSMSServerSetup."Template ID Cust.-5 Due Date"; //MSKS
                                ltxtMessage := STRSUBSTNO(lrecSMSServerSetup."SMS Template Cust.-5 Due Date"
                                                         , lrecCust.Name
                                                         , RecCustLedger."Document No."
                                                         , FORMAT(RecCustLedger.Amount)
                                                         , FORMAT(RecCustLedger."Posting Date")
                                                         , FORMAT(RecCustLedger."Due Date")
                                                         , ''
                                                         , FORMAT(RecCustLedger."Cheque No.")
                                                         , ''
                                                         , ''
                                                         , lTotalOutStanding
                                                         , "lExtDocNo."
                                                         );
                            END;
                            IF SendCurrDueMsg AND (RecCustLedger."Due Date" = (TODAY)) THEN BEGIN
                                SMSTemplateID := lrecSMSServerSetup."Template ID Cust. Due Date"; //MSKS
                                ltxtMessage := STRSUBSTNO(lrecSMSServerSetup."SMS Template Cust. Due Date"
                                                         , lrecCust.Name
                                                         , RecCustLedger."Document No."
                                                         , FORMAT(RecCustLedger.Amount)
                                                         , FORMAT(RecCustLedger."Posting Date")
                                                         , FORMAT(RecCustLedger."Due Date")
                                                         , ''
                                                         , FORMAT(RecCustLedger."Cheque No.")
                                                         , ''
                                                         , ''
                                                         , lTotalOutStanding
                                                         , "lExtDocNo."
                                                         );

                            END;
                            IF SendDueMsg AND (RecCustLedger."Due Date" = (TODAY + 5)) THEN BEGIN
                                SMSTemplateID := lrecSMSServerSetup."Template ID Cust.+5 Due Date"; //MSKS
                                ltxtMessage := STRSUBSTNO(lrecSMSServerSetup."SMS Template Cust.+5 Due Date"
                                                         , lrecCust.Name
                                                         , RecCustLedger."Document No."
                                                         , FORMAT(RecCustLedger.Amount)
                                                         , FORMAT(RecCustLedger."Posting Date")
                                                         , FORMAT(RecCustLedger."Due Date")
                                                         , ''
                                                         , FORMAT(RecCustLedger."Cheque No.")
                                                         , ''
                                                         , ''
                                                         , lTotalOutStanding
                                                         , "lExtDocNo."
                                                         );
                            END;
                            IF (RecCustLedger."Remaining Amount" > 1000) AND (ltxtMessage <> '') THEN
                                mSendMessage := TRUE;
                            IF mSendMessage = TRUE THEN //MSKS2311
                                mLinkCode := RecCustLedger."Customer No.";
                        END;



                        IF mSendMessage THEN BEGIN
                            ltxtMessage1 := '';
                            ltxtMessage2 := '';

                            IF STRLEN(ltxtMessage) > 250 THEN BEGIN
                                ltxtMessage1 := '1/2 --' + COPYSTR(ltxtMessage, 1, 250);
                                ltxtMessage2 := '2/2 --' + COPYSTR(ltxtMessage, 251, STRLEN(ltxtMessage) - 250);
                            END
                            ELSE BEGIN
                                ltxtMessage1 := ltxtMessage;
                            END;

                            lrecMobileNo.RESET;

                            IF mLinkWith = 1 THEN
                                lrecMobileNo.SETRANGE("Link With", lrecMobileNo."Link With"::Customer);

                            lrecMobileNo.SETRANGE("Link Code", mLinkCode);
                            lrecMobileNo.SETRANGE(Type, 0);
                            lrecMobileNo.SETRANGE("Send Mobile Communication", TRUE);
                            IF lrecMobileNo.FINDFIRST THEN BEGIN
                                REPEAT
                                    SendSMS.SendMessage(lrecMobileNo."Mobile No.", ltxtMessage1, 0, SMSTemplateID);
                                    IF ltxtMessage2 <> '' THEN
                                        SendSMS.SendMessage(lrecMobileNo."Mobile No.", ltxtMessage2, 0, SMSTemplateID);
                                UNTIL lrecMobileNo.NEXT = 0;
                            END;
                        END;

                    UNTIL RecCustLedger.NEXT = 0;
                END;
            END;
        END;

        CreateTotalDueBalanceQueue;

        lrecSMSServerSetup."Message Queue Created Date" := TODAY;
        lrecSMSServerSetup.MODIFY;
    end;

    var
        RecCustLedger: Record "Cust. Ledger Entry";
        lrecSMSServerSetup: Record "SMS - Server Setup";
        mSendMessage: Boolean;
        lrecMobileNo: Record "SMS - Mobile No.";
        SendSMS: Codeunit "SMS - Send Message";
        ltxtMessage: Text[1024];
        mLinkWith: Integer;
        mLinkCode: Code[20];
        lrecCust: Record Customer;
        lrecVend: Record Vendor;
        lTotalOutStanding: Decimal;
        "lExtDocNo.": Text[20];
        lrecVendLedger: Record "Vendor Ledger Entry";
        lrecCustLedger: Record "Cust. Ledger Entry";
        ltxtMessage1: Text[250];
        ltxtMessage2: Text[250];
        SendPastDueMsg: Boolean;
        SendCurrDueMsg: Boolean;
        SendDueMsg: Boolean;
        RecCustomer: Record Customer;
        RecSP: Record "Salesperson/Purchaser";
        RecCust: Record Customer;
        RecCustType: Record "Customer Type";
        SMSTemplateID: Text;


    procedure CreateTotalDueBalanceQueue()
    begin
        lrecSMSServerSetup.GET;
        IF DATE2DMY(TODAY, 1) = lrecSMSServerSetup."Send Cust. Due Message On Date" THEN BEGIN
            mLinkWith := 1;
            RecCustomer.RESET;
            IF RecCustomer.FINDFIRST THEN BEGIN
                REPEAT
                    RecCustomer.CALCFIELDS(Balance);

                    mSendMessage := FALSE;

                    lTotalOutStanding := RecCustomer.Balance;
                    SMSTemplateID := lrecSMSServerSetup."Template ID Cust. On Date"; //MSKS
                                                                                     //IF lTotalOutStanding<>0 THEN BEGIN
                    IF lTotalOutStanding > 1000 THEN BEGIN //MSKS2311 Amount greater then 0
                        ltxtMessage := STRSUBSTNO(lrecSMSServerSetup."SMS Template Cust. On Date"
                                                 , RecCustomer.Name
                                                 , ''
                                                 , ''
                                                 , ''
                                                 , ''
                                                 , ''
                                                 , ''
                                                 , ''
                                                 , ''
                                                 , lTotalOutStanding
                                                 , ''
                                                 );

                        mLinkCode := RecCustomer."No.";
                        mSendMessage := TRUE;
                    END;

                    IF mSendMessage THEN BEGIN
                        ltxtMessage1 := '';
                        ltxtMessage2 := '';

                        IF STRLEN(ltxtMessage) > 250 THEN BEGIN
                            ltxtMessage1 := '1/2 --' + COPYSTR(ltxtMessage, 1, 250);
                            ltxtMessage2 := '2/2 --' + COPYSTR(ltxtMessage, 251, STRLEN(ltxtMessage) - 250);
                        END
                        ELSE BEGIN
                            ltxtMessage1 := ltxtMessage;
                        END;

                        lrecMobileNo.RESET;

                        IF mLinkWith = 1 THEN
                            lrecMobileNo.SETRANGE("Link With", lrecMobileNo."Link With"::Customer);

                        lrecMobileNo.SETRANGE("Link Code", mLinkCode);
                        lrecMobileNo.SETRANGE("Send Mobile Communication", TRUE);
                        IF lrecMobileNo.FINDFIRST THEN BEGIN
                            REPEAT
                                SendSMS.SendMessage(lrecMobileNo."Mobile No.", ltxtMessage1, 0, SMSTemplateID);
                                IF ltxtMessage2 <> '' THEN
                                    SendSMS.SendMessage(lrecMobileNo."Mobile No.", ltxtMessage2, 0, SMSTemplateID);
                            UNTIL lrecMobileNo.NEXT = 0;
                        END;
                    END;

                UNTIL RecCustomer.NEXT = 0;
            END;
        END;
    end;


    procedure CreateMsgOnDARealease(RecSalesHeader: Record "Sales Header")
    var
        TxtOption1: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";
        TxtOption2: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";
        TxtOption3: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";
        TxtOption4: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";
        TxtOption0: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";
        RecLocation: Record Location;

        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        sgstTOTAL: Decimal;
        GSTLbl: Label 'GST';
        IGSTLbl: Label 'IGST';
        CGSTLbl: Label 'CGST';
        GSTCESSLbl: Label 'GST CESS';
        CESSLbl: Label 'CESS';
        igst: Decimal;
        igstTotal: Decimal;
        sgst: Decimal;
        GSTper3: Decimal;
        cgst: Decimal;
        GSTper1: Decimal;
        GSTper2: Decimal;
        cgstTOTAL: Decimal;
        ReccSalesLine: Record "Sales Line";
        ComponentName: Code[20];
        TotalAmt: Decimal;
    begin
        UpdateSMSSetupForCustomer(RecSalesHeader."Sell-to Customer No.");
        //lrecSMSServerSetup.GET;
        TxtOption1 := 5;
        TxtOption2 := 5;
        TxtOption3 := 5;
        TxtOption4 := 5;
        Clear(sgst);
        Clear(igst);
        Clear(cgst);
        Clear(TotalAmt);
        ReccSalesLine.Reset();
        ReccSalesLine.SetRange("Document Type", RecSalesHeader."Document Type");
        ReccSalesLine.SetRange("Document No.", RecSalesHeader."No.");
        if ReccSalesLine.FindSet() then
            repeat
                TotalAmt += ReccSalesLine."Line Amount";
                GSTSetup.Get();
                if GSTSetup."GST Tax Type" = GSTLbl then
                    if ReccSalesLine."GST Jurisdiction Type" = ReccSalesLine."GST Jurisdiction Type"::Interstate then
                        ComponentName := IGSTLbl
                    else
                        ComponentName := CGSTLbl
                else
                    if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                        ComponentName := CESSLbl;

                if ReccSalesLine.Type <> ReccSalesLine.Type::" " then begin
                    TaxTransactionValue.Reset();
                    TaxTransactionValue.SetRange("Tax Record ID", ReccSalesLine.RecordId);
                    TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                    if TaxTransactionValue.FindSet() then
                        repeat
                            case TaxTransactionValue."Value ID" of
                                6:
                                    begin
                                        sgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                        GSTper3 := TaxTransactionValue.Percent;
                                    end;
                                2:
                                    begin
                                        cgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                        GSTper2 := TaxTransactionValue.Percent;
                                    end;
                                3:
                                    begin
                                        igst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                        GSTper1 := TaxTransactionValue.Percent;
                                    end;
                            end;
                        until TaxTransactionValue.Next() = 0;
                    cgstTOTAL += cgst;
                    sgstTOTAL += sgst;
                    igstTotal += igst;
                end;
            until ReccSalesLine.Next() = 0;
        //15578 text


        IF lrecSMSServerSetup."Send Msg. on DA Release" THEN BEGIN
            mLinkWith := 1;
            WITH RecSalesHeader DO BEGIN
                mSendMessage := FALSE;
                // 15578 RecSalesHeader.CALCFIELDS("Amount to Customer", RecSalesHeader.Quantity);
                lTotalOutStanding := TotalAmt + igst + cgst + sgst;
                IF RecLocation.GET(RecSalesHeader."Location Code") THEN;
                //IF lTotalOutStanding<>0 THEN BEGIN
                IF lTotalOutStanding > 0 THEN BEGIN //MSKS2311 Amount greater then 0
                    SMSTemplateID := lrecSMSServerSetup."Template ID for DA Release"; //MSKS
                    ltxtMessage := STRSUBSTNO(lrecSMSServerSetup."SMS Template for DA Release"
                                             , RecSalesHeader."Bill-to Name"
                                             , RecSalesHeader."No."
                                            // 15578 RecSalesHeader."Amount to Customer"
                                            , TotalAmt + igst + sgst + cgst // 15578

                                             , FORMAT(RecSalesHeader."Promised Delivery Date")
                                             , ''
                                             , ''
                                             , ''
                                             , ''
                                             , ''
                                             , RecSalesHeader."Ship-to City"
                                             , RecSalesHeader."State Description"
                                             , RecSalesHeader."Qty in Sq. Mt."
                                             );
                    RecCustomer.GET(RecSalesHeader."Sell-to Customer No.");
                    mLinkCode := RecCustomer."No.";
                    mSendMessage := TRUE;
                END;

                IF mSendMessage THEN BEGIN
                    ltxtMessage1 := '';
                    ltxtMessage2 := '';

                    IF STRLEN(ltxtMessage) > 250 THEN BEGIN
                        ltxtMessage1 := '1/2 --' + COPYSTR(ltxtMessage, 1, 250);
                        ltxtMessage2 := '2/2 --' + COPYSTR(ltxtMessage, 251, STRLEN(ltxtMessage) - 250);
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
                                IF RecCustType."Send PCH SMS" THEN
                                    TxtOption1 := 1;

                                IF RecCustType."Send Retail SMS" THEN
                                    TxtOption2 := 2;

                                IF RecCustType."Send Govt. SMS" THEN
                                    TxtOption3 := 3;

                                IF RecCustType."Send Private SMS" THEN
                                    TxtOption4 := 4;

                                IF RecCustType."Send DA Customer SMS" THEN
                                    TxtOption0 := 0;

                            END;
                    END;
                    lrecMobileNo.SETFILTER(Type, '%1|%2|%3|%4|%5', TxtOption0, TxtOption1, TxtOption2, TxtOption3, TxtOption4);
                    IF lrecMobileNo.FINDFIRST THEN BEGIN
                        REPEAT
                            SendSMS.SendMessage(lrecMobileNo."Mobile No.", ltxtMessage1, 0, SMSTemplateID);
                            IF ltxtMessage2 <> '' THEN
                                SendSMS.SendMessage(lrecMobileNo."Mobile No.", ltxtMessage2, 0, SMSTemplateID);
                        UNTIL lrecMobileNo.NEXT = 0;
                    END;
                    //  END;

                    //MSAK 220218
                    //Send SP Message
                    IF RecCustomer."Salesperson Code" <> '' THEN BEGIN
                        IF RecSP.GET(RecCustomer."Salesperson Code") THEN
                            SendSMS.SendMessage(RecSP."Phone No.", ltxtMessage1, 0, SMSTemplateID);
                        IF ltxtMessage2 <> '' THEN
                            SendSMS.SendMessage(RecSP."Phone No.", ltxtMessage2, 0, SMSTemplateID);
                    END;
                    //MSAK 220218
                    /*
                   //Send PCH Message
                   IF RecCustomer."PCH Code" <>'' THEN BEGIN
                   IF  RecSP.GET(RecCustomer."PCH Code") THEN
                     SendSMS.SendMessage(RecSP."Phone No.",ltxtMessage1,0);
                     IF ltxtMessage2 <> '' THEN
                         SendSMS.SendMessage(RecSP."Phone No.",ltxtMessage2,0);
                   END;
                   */
                    //Send Customer block not required kulbhushan Sharma
                    /*  IF RecCustomer."Phone No." <>'' THEN BEGIN
                        SendSMS.SendMessage(RecCustomer."Phone No.",ltxtMessage1,0);
                        IF ltxtMessage2 <> '' THEN
                            SendSMS.SendMessage(RecCustomer."Phone No.",ltxtMessage2,0);
                      END;
                     */
                    /*
                       lrecMobileNo.RESET;
                       IF mLinkWith = 1 THEN
                         lrecMobileNo.SETRANGE("Link With",lrecMobileNo."Link With"::Customer);

                       lrecMobileNo.SETRANGE("Link Code",mLinkCode);
                       lrecMobileNo.SETRANGE("Send Mobile Communication",TRUE);
                       IF lrecMobileNo.FINDFIRST THEN
                       BEGIN
                         REPEAT
                             SendSMS.SendMessage(lrecMobileNo."Mobile No.",ltxtMessage1,0);
                             IF ltxtMessage2 <> '' THEN
                                 SendSMS.SendMessage(lrecMobileNo."Mobile No.",ltxtMessage2,0);
                         UNTIL lrecMobileNo.NEXT = 0;
                       END;
                       */
                END;
            END;

        END;

    end;


    procedure UpdateSMSSetupForCustomer(CustCode: Code[20])
    var
        RecCust: Record Customer;
        RecCustType: Record "Customer Type";
    begin
        lrecSMSServerSetup.GET;
        IF RecCust.GET(CustCode) THEN BEGIN
            IF RecCustType.GET(RecCustType.Type::Customer, RecCust."Customer Type") THEN BEGIN
                lrecSMSServerSetup."Post Customer Invoice" := RecCustType."Post Customer Invoice";
                lrecSMSServerSetup."Post Customer Cr. Note" := RecCustType."Post Customer Cr. Note";
                lrecSMSServerSetup."Post Customer Payment" := RecCustType."Post Customer Payment";
                lrecSMSServerSetup."Post Customer Refund" := RecCustType."Post Customer Refund";
                lrecSMSServerSetup."Post Customer Due Date" := RecCustType."Post Customer Due Date";
                lrecSMSServerSetup."Post Customer +5 Due Date" := RecCustType."Post Customer +5 Due Date";
                lrecSMSServerSetup."Post Customer -5 Due Date" := RecCustType."Post Customer -5 Due Date";
                lrecSMSServerSetup."Send Msg. on DA Release" := RecCustType."Send Msg. on DA Release";
            END;
        END;
    end;


    procedure CreateMsgOnDABooked(RecSalesHeader: Record "Sales Header")
    var
        TxtOption1: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";
        TxtOption2: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";
        TxtOption3: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";
        TxtOption4: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";
        TxtOption0: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";

        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        sgstTOTAL: Decimal;
        GSTLbl: Label 'GST';
        IGSTLbl: Label 'IGST';
        CGSTLbl: Label 'CGST';
        GSTCESSLbl: Label 'GST CESS';
        CESSLbl: Label 'CESS';
        igst: Decimal;
        igstTotal: Decimal;
        sgst: Decimal;
        GSTper3: Decimal;
        cgst: Decimal;
        GSTper1: Decimal;
        GSTper2: Decimal;
        cgstTOTAL: Decimal;
        ReccSalesLine: Record "Sales Line";
        ComponentName: Code[20];
        TotalAmt: Decimal;

    begin
        //UpdateSMSSetupForCustomer(RecSalesHeader."Sell-to Customer No.");


        EXIT;  //Stock SMS SMS Template Order Booked
        lrecSMSServerSetup.GET;
        TxtOption1 := 5; // ,PCH,Sales Person,Govt.SP,Private SP,Not to send
        TxtOption2 := 5;
        TxtOption3 := 5;
        TxtOption4 := 5;

        Clear(sgst);// 15578
        Clear(igst);
        Clear(cgst);
        Clear(TotalAmt);
        ReccSalesLine.Reset();
        ReccSalesLine.SetRange("Document Type", RecSalesHeader."Document Type");
        ReccSalesLine.SetRange("Document No.", RecSalesHeader."No.");
        if ReccSalesLine.FindSet() then
            repeat
                TotalAmt += ReccSalesLine."Line Amount";
                GSTSetup.Get();
                if GSTSetup."GST Tax Type" = GSTLbl then
                    if ReccSalesLine."GST Jurisdiction Type" = ReccSalesLine."GST Jurisdiction Type"::Interstate then
                        ComponentName := IGSTLbl
                    else
                        ComponentName := CGSTLbl
                else
                    if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                        ComponentName := CESSLbl;

                if ReccSalesLine.Type <> ReccSalesLine.Type::" " then begin
                    TaxTransactionValue.Reset();
                    TaxTransactionValue.SetRange("Tax Record ID", ReccSalesLine.RecordId);
                    TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                    if TaxTransactionValue.FindSet() then
                        repeat
                            case TaxTransactionValue."Value ID" of
                                6:
                                    begin
                                        sgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                        GSTper3 := TaxTransactionValue.Percent;
                                    end;
                                2:
                                    begin
                                        cgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                        GSTper2 := TaxTransactionValue.Percent;
                                    end;
                                3:
                                    begin
                                        igst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                        GSTper1 := TaxTransactionValue.Percent;
                                    end;
                            end;
                        until TaxTransactionValue.Next() = 0;
                    cgstTOTAL += cgst;
                    sgstTOTAL += sgst;
                    igstTotal += igst;
                end;
            until ReccSalesLine.Next() = 0;
        //15578 text


        IF (lrecSMSServerSetup."SMS Template Order Booked") <> '' THEN BEGIN
            mLinkWith := 1;
            WITH RecSalesHeader DO BEGIN
                mSendMessage := FALSE;
                // 15578  RecSalesHeader.CALCFIELDS("Amount to Customer", RecSalesHeader.Quantity);
                lTotalOutStanding := TotalAmt + igst + cgst + sgst;
                SMSTemplateID := lrecSMSServerSetup."Template ID Order Booked"; //MSKS
                                                                                //     IF lTotalOutStanding > 0 THEN BEGIN //MSKS2311 Amount greater then 0
                ltxtMessage := STRSUBSTNO(lrecSMSServerSetup."SMS Template Order Booked"
                                         , RecSalesHeader."Bill-to Name"                 //1
                                         , RecSalesHeader."No."                          //2
                                                                                         // 15578, RecSalesHeader."Amount to Customer"           //3
                                         , TotalAmt + igst + sgst + cgst // 15578
                                         , ''
                                         , ''
                                         , ''
                                         , ''
                                         , ''
                                         , ''
                                         , RecSalesHeader."Ship-to City"                 //10
                                         , RecSalesHeader."State Description"            //11
                                         , RecSalesHeader."Qty in Sq. Mt."               //12
                                         );
                RecCustomer.GET(RecSalesHeader."Sell-to Customer No.");
                mLinkCode := RecCustomer."No.";
                mSendMessage := TRUE;
                //   END;

                IF mSendMessage THEN BEGIN
                    ltxtMessage1 := '';
                    ltxtMessage2 := '';

                    IF STRLEN(ltxtMessage) > 250 THEN BEGIN
                        ltxtMessage1 := '1/2 --' + COPYSTR(ltxtMessage, 1, 250);
                        ltxtMessage2 := '2/2 --' + COPYSTR(ltxtMessage, 251, STRLEN(ltxtMessage) - 250);
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
                                IF RecCustType."Send DA PCH SMS" THEN
                                    TxtOption1 := 1;

                                IF RecCustType."Send DA SP SMS" THEN
                                    TxtOption2 := 2;

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
                        REPEAT
                            SendSMS.SendMessage(lrecMobileNo."Mobile No.", ltxtMessage1, 0, SMSTemplateID);
                            IF ltxtMessage2 <> '' THEN
                                SendSMS.SendMessage(lrecMobileNo."Mobile No.", ltxtMessage2, 0, SMSTemplateID);
                        UNTIL lrecMobileNo.NEXT = 0;
                    END;
                    //  END;
                END;
            END;
        END;
    end;


    procedure CreateMsgOnDApriceApproved(RecSalesHeader: Record "Sales Header")
    var
        TxtOption1: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";
        TxtOption2: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";
        TxtOption3: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";
        TxtOption4: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";
        TxtOption0: Option " ",PCH,"Sales Person","Govt.SP","Private SP","Not to send";

        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        sgstTOTAL: Decimal;
        GSTLbl: Label 'GST';
        IGSTLbl: Label 'IGST';
        CGSTLbl: Label 'CGST';
        GSTCESSLbl: Label 'GST CESS';
        CESSLbl: Label 'CESS';
        igst: Decimal;
        igstTotal: Decimal;
        sgst: Decimal;
        GSTper3: Decimal;
        cgst: Decimal;
        GSTper1: Decimal;
        GSTper2: Decimal;
        cgstTOTAL: Decimal;
        ReccSalesLine: Record "Sales Line";
        ComponentName: Code[20];
        TotalAmt: Decimal;

    begin
        //UpdateSMSSetupForCustomer(RecSalesHeader."Sell-to Customer No.");
        lrecSMSServerSetup.GET;
        TxtOption1 := 5; // ,PCH,Sales Person,Govt.SP,Private SP,Not to send
        TxtOption2 := 5;
        TxtOption3 := 5;
        TxtOption4 := 5;

        Clear(sgst);// 15578
        Clear(igst);
        Clear(cgst);
        Clear(TotalAmt);
        ReccSalesLine.Reset();
        ReccSalesLine.SetRange("Document Type", RecSalesHeader."Document Type");
        ReccSalesLine.SetRange("Document No.", RecSalesHeader."No.");
        if ReccSalesLine.FindSet() then
            repeat
                TotalAmt += ReccSalesLine."Line Amount";
                GSTSetup.Get();
                if GSTSetup."GST Tax Type" = GSTLbl then
                    if ReccSalesLine."GST Jurisdiction Type" = ReccSalesLine."GST Jurisdiction Type"::Interstate then
                        ComponentName := IGSTLbl
                    else
                        ComponentName := CGSTLbl
                else
                    if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                        ComponentName := CESSLbl;

                if ReccSalesLine.Type <> ReccSalesLine.Type::" " then begin
                    TaxTransactionValue.Reset();
                    TaxTransactionValue.SetRange("Tax Record ID", ReccSalesLine.RecordId);
                    TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                    if TaxTransactionValue.FindSet() then
                        repeat
                            case TaxTransactionValue."Value ID" of
                                6:
                                    begin
                                        sgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                        GSTper3 := TaxTransactionValue.Percent;
                                    end;
                                2:
                                    begin
                                        cgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                        GSTper2 := TaxTransactionValue.Percent;
                                    end;
                                3:
                                    begin
                                        igst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                        GSTper1 := TaxTransactionValue.Percent;
                                    end;
                            end;
                        until TaxTransactionValue.Next() = 0;
                    cgstTOTAL += cgst;
                    sgstTOTAL += sgst;
                    igstTotal += igst;
                end;
            until ReccSalesLine.Next() = 0;
        //15578 text


        IF (lrecSMSServerSetup."SMS Temp. Order Price Approved") <> '' THEN BEGIN
            mLinkWith := 1;
            WITH RecSalesHeader DO BEGIN
                mSendMessage := FALSE;
                SMSTemplateID := lrecSMSServerSetup."Temp. ID Order Price Approved"; //MSKS
                                                                                     // 15578  RecSalesHeader.CALCFIELDS("Amount to Customer", RecSalesHeader.Quantity);
                lTotalOutStanding := TotalAmt + igst + sgst + cgst;

                // IF lTotalOutStanding > 0 THEN BEGIN //MSKS2311 Amount greater then 0
                ltxtMessage := STRSUBSTNO(lrecSMSServerSetup."SMS Temp. Order Price Approved"
                                         , RecSalesHeader."Bill-to Name"                 //1
                                         , RecSalesHeader."No."                          //2
                                                                                         // 15578 , RecSalesHeader."Amount to Customer"           //3   
                                        , lTotalOutStanding, ''
                                         , FORMAT(RecSalesHeader."Promised Delivery Date")             //4 Promised Date
                                         , ''
                                         , ''
                                         , ''
                                         , ''
                                         , RecSalesHeader."Ship-to City"                 //10
                                         , RecSalesHeader."State Description"            //11
                                         , RecSalesHeader."Qty in Sq. Mt."               //12
                                         );
                RecCustomer.GET(RecSalesHeader."Sell-to Customer No.");
                mLinkCode := RecCustomer."No.";
                mSendMessage := TRUE;
                // END;

                IF mSendMessage THEN BEGIN
                    ltxtMessage1 := '';
                    ltxtMessage2 := '';

                    IF STRLEN(ltxtMessage) > 250 THEN BEGIN
                        ltxtMessage1 := '1/2 --' + COPYSTR(ltxtMessage, 1, 250);
                        ltxtMessage2 := '2/2 --' + COPYSTR(ltxtMessage, 251, STRLEN(ltxtMessage) - 250);
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
                                IF RecCustType."Send DA PCH SMS" THEN
                                    TxtOption1 := 1;

                                IF RecCustType."Send DA SP SMS" THEN
                                    TxtOption2 := 2;

                                //IF RecCustType."Send DA Cu SMS" THEN
                                //   TxtOption3 := 3;

                                //IF RecCustType."Send Private SMS" THEN
                                //   TxtOption4 := 4;
                                IF RecCustType."Send DA Customer SMS" THEN
                                    TxtOption0 := 0;

                            END;

                    END;
                    lrecMobileNo.SETFILTER(Type, '%1|%2|%3|%4', TxtOption1, TxtOption2, TxtOption3, TxtOption4);
                    IF lrecMobileNo.FINDFIRST THEN BEGIN
                        REPEAT
                            SendSMS.SendMessage(lrecMobileNo."Mobile No.", ltxtMessage1, 0, SMSTemplateID);
                            IF ltxtMessage2 <> '' THEN
                                SendSMS.SendMessage(lrecMobileNo."Mobile No.", ltxtMessage2, 0, SMSTemplateID);
                        UNTIL lrecMobileNo.NEXT = 0;
                    END;
                    //  END;
                END;
            END;
        END;
    end;

    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal// 15578 text
    var
        TaxComponent: Record "Tax Component";
        GSTSetup1: Record "GST Setup";
        GSTRoundingPrecision: Decimal;
    begin
        if not GSTSetup1.Get() then
            exit;
        GSTSetup1.TestField("GST Tax Type");

        TaxComponent.SetRange("Tax Type", GSTSetup1."GST Tax Type");
        TaxComponent.SetRange(Name, ComponentName);
        TaxComponent.FindFirst();
        if TaxComponent."Rounding Precision" <> 0 then
            GSTRoundingPrecision := TaxComponent."Rounding Precision"
        else
            GSTRoundingPrecision := 1;
        exit(GSTRoundingPrecision);
    end;
}

