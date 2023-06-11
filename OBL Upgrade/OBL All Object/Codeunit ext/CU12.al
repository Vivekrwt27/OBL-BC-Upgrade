codeunit 50110 "Extend12"
{
    [EventSubscriber(ObjectType::Codeunit, 12, 'OnCodeOnBeforeFinishPosting', '', false, false)]
    local procedure OnCodeOnBeforeFinishPosting(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    var
        lrecMobileNo: Record 50037;
        RecCustType: Record 50010;
        RecCust: Record 18;
        SMSTemplateID: Text;
        SendSMS: Codeunit 50013;
        ltxtMessage: Text[1024];
        mLinkWith: Integer;
        mLinkCode: Code[20];
        mSendMessage: Boolean;
        lrecCust: Record 18;
        lrecVend: Record 23;
        lTotalOutStanding: Decimal;
        "lExtDocNo.": Text[50];
        lrecVendLedger: Record 25;
        lrecCustLedger: Record 21;
        ltxtMessage1: Text[250];
        ltxtMessage2: Text[250];
        TxtOption1: Option " ",PCH,"Sales Person","Govt.SP","Private SP";
        TxtOption2: Option " ",PCH,"Sales Person","Govt.SP","Private SP";
        TxtOption3: Option " ",PCH,"Sales Person","Govt.SP","Private SP";
        TxtOption4: Option " ",PCH,"Sales Person","Govt.SP","Private SP";
        SalesInvHdr: Record 112;
        RecLocation: Record 14;
        lrecSMSServerSetup: Record 50035;
    begin


        //1. TRI PG 20.11.2008 -- SMS Server --  Add Start
        //IF ("System-Created Entry" = TRUE) AND
        IF ((GenJournalLine."Source Code" <> 'SALESAPPL') AND (GenJournalLine."Source Code" <> 'PURCHAPPL')) THEN BEGIN
            lrecSMSServerSetup.GET;
            mSendMessage := FALSE;
            IF lrecSMSServerSetup."Activate SMS Sending" THEN BEGIN
                IF GenJournalLine."Account Type" = GenJournalLine."Account Type"::Customer THEN BEGIN
                    mLinkWith := 1;
                    mLinkCode := GenJournalLine."Account No.";
                END
                ELSE
                    IF GenJournalLine."Bal. Account Type" = GenJournalLine."Bal. Account Type"::Customer THEN BEGIN
                        mLinkWith := 1;
                        mLinkCode := GenJournalLine."Bal. Account No.";
                    END
                    ELSE
                        IF GenJournalLine."Account Type" = GenJournalLine."Account Type"::Vendor THEN BEGIN
                            mLinkWith := 2;
                            mLinkCode := GenJournalLine."Account No.";
                        END
                        ELSE
                            IF GenJournalLine."Bal. Account Type" = GenJournalLine."Bal. Account Type"::Vendor THEN BEGIN
                                mLinkWith := 2;
                                mLinkCode := GenJournalLine."Bal. Account No.";
                            END;

                IF mLinkWith = 1 THEN BEGIN
                    UpdateSMSSetupForCustomer(mLinkCode);
                    lrecCust.GET(mLinkCode);
                    lrecCust.CALCFIELDS(Balance);
                    lTotalOutStanding := lrecCust.Balance;
                    "lExtDocNo." := '';
                    lrecCustLedger.RESET;
                    lrecCustLedger.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
                    lrecCustLedger.SETRANGE("Document No.", GenJournalLine."Applies-to Doc. No.");
                    lrecCustLedger.SETRANGE("Document Type", GenJournalLine."Applies-to Doc. Type");
                    lrecCustLedger.SETRANGE("Customer No.", mLinkCode);
                    IF lrecCustLedger.FINDFIRST THEN BEGIN
                        "lExtDocNo." := lrecCustLedger."External Document No.";
                    END;

                    IF (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Invoice) AND lrecSMSServerSetup."Post Customer Invoice" THEN BEGIN
                        mSendMessage := TRUE;
                        SMSTemplateID := lrecSMSServerSetup."Template ID Cust. Invoice"; //MSKS
                        lrecCust.GET(mLinkCode);
                        IF SalesInvHdr.GET(GenJournalLine."Document No.") THEN;
                        IF RecLocation.GET(SalesInvHdr."Location Code") THEN;
                        ltxtMessage := STRSUBSTNO(lrecSMSServerSetup."SMS Template Cust. Invoice"
                                                 , lrecCust.Name
                                                 , GenJournalLine."Document No."
                                                 , FORMAT(GenJournalLine.Amount)
                                                 , FORMAT(GenJournalLine."Posting Date")
                                                 , FORMAT(GenJournalLine."Due Date")
                                                 , SalesInvHdr."Truck No."
                                                 , FORMAT(GenJournalLine."Cheque No.")
                                                 , RecLocation."Contact Name"
                                                 , RecLocation."Phone No. 2"
                                                 , lTotalOutStanding
                                                 , "lExtDocNo."
                                                 );
                    END;
                    IF (GenJournalLine."Document Type" = GenJournalLine."Document Type"::"Credit Memo") AND lrecSMSServerSetup."Post Customer Cr. Note" THEN BEGIN
                        mSendMessage := TRUE;
                        SMSTemplateID := lrecSMSServerSetup."Template ID Cust. Cr. Note"; //MSKS
                        ltxtMessage := STRSUBSTNO(lrecSMSServerSetup."SMS Template Cust. Cr. Note"
                                                 , lrecCust.Name
                                                 , GenJournalLine."Document No."
                                                 , FORMAT(GenJournalLine.Amount)
                                                 , FORMAT(GenJournalLine."Posting Date")
                                                 , FORMAT(GenJournalLine."Due Date")
                                                 , ''
                                                 , FORMAT(GenJournalLine."Cheque No.")
                                                 , ''
                                                 , ''
                                                 , lTotalOutStanding
                                                 , "lExtDocNo."
                                                 );
                    END;
                    IF (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Payment) AND lrecSMSServerSetup."Post Customer Payment" THEN BEGIN
                        mSendMessage := TRUE;
                        SMSTemplateID := lrecSMSServerSetup."Template ID Cust. Payment"; //MSKS
                        ltxtMessage := STRSUBSTNO(lrecSMSServerSetup."SMS Template Cust. Payment"
                                                 , lrecCust.Name
                                                 , GenJournalLine."Document No."
                                                 , FORMAT(GenJournalLine.Amount)
                                                 , FORMAT(GenJournalLine."Posting Date")
                                                 , FORMAT(GenJournalLine."Due Date")
                                                 , ''
                                                 , FORMAT(GenJournalLine."Cheque No.")
                                                 , ''
                                                 , ''
                                                 , lTotalOutStanding
                                                 , "lExtDocNo."
                                                 );
                    END;
                    //Keshav14052020
                    IF GenJournalLine."Document Type" IN [GenJournalLine."Document Type"::Refund, GenJournalLine."Document Type"::Payment] THEN
                        GenerateSMSEntry(GenJournalLine, mLinkCode, SMSTemplateID);
                    //Keshav14052020

                    IF (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Refund) AND lrecSMSServerSetup."Post Customer Refund" THEN BEGIN
                        mSendMessage := TRUE;
                        SMSTemplateID := lrecSMSServerSetup."Template ID Cust. Refund"; //MSKS
                        ltxtMessage := STRSUBSTNO(lrecSMSServerSetup."SMS Template Cust. Refund"
                                                 , lrecCust.Name
                                                 , GenJournalLine."Document No."
                                                 , FORMAT(GenJournalLine.Amount)
                                                 , FORMAT(GenJournalLine."Posting Date")
                                                 , FORMAT(GenJournalLine."Due Date")
                                                 , ''
                                                 , FORMAT(GenJournalLine."Cheque No.")
                                                 , ''
                                                 , ''
                                                 , lTotalOutStanding
                                                 , "lExtDocNo."
                                                 );
                    END;
                END
                ELSE
                    IF mLinkWith = 2 THEN BEGIN
                        lrecSMSServerSetup.GET;
                        IF lrecVend.GET(mLinkCode) THEN;
                        lrecVend.CALCFIELDS(Balance);
                        lTotalOutStanding := lrecVend.Balance;
                        "lExtDocNo." := '';
                        lrecVendLedger.RESET;
                        lrecVendLedger.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
                        lrecVendLedger.SETRANGE("Document No.", GenJournalLine."Applies-to Doc. No.");
                        lrecVendLedger.SETRANGE("Document Type", GenJournalLine."Applies-to Doc. Type");
                        lrecVendLedger.SETRANGE("Vendor No.", mLinkCode);
                        IF lrecVendLedger.FINDFIRST THEN BEGIN
                            "lExtDocNo." := lrecVendLedger."External Document No.";
                        END;
                        IF (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Invoice) AND lrecSMSServerSetup."Post Vendor Invoice" THEN BEGIN
                            lrecVendLedger.CALCFIELDS("Vendor Invoice No.");
                            mSendMessage := TRUE;
                            SMSTemplateID := lrecSMSServerSetup."Template ID Vend. Invoice"; //MSKS
                            ltxtMessage := STRSUBSTNO(lrecSMSServerSetup."SMS Template Vend. Invoice"
                                                     , lrecVend.Name
                                                     , GenJournalLine."External Document No."
                                                     , FORMAT(GenJournalLine.Amount)
                                                     , FORMAT(GenJournalLine."Posting Date")
                                                     , FORMAT(GenJournalLine."Due Date")
                                                     , ''
                                                     , FORMAT(GenJournalLine."Cheque No.")
                                                     , ''
                                                     , ''
                                                     , lTotalOutStanding
                                                     , "lExtDocNo."
                                                     );
                        END;
                        IF (GenJournalLine."Document Type" = GenJournalLine."Document Type"::"Credit Memo") AND lrecSMSServerSetup."Post Vendor Dr. Note" THEN BEGIN
                            lrecVendLedger.CALCFIELDS("Vendor Invoice No.");
                            mSendMessage := TRUE;
                            SMSTemplateID := lrecSMSServerSetup."Template ID Vend. Dr. Note"; //MSKS
                            ltxtMessage := STRSUBSTNO(lrecSMSServerSetup."SMS Template Vend. Dr. Note"
                                                     , lrecVend.Name
                                                     , lrecVendLedger."Document No."
                                                     , FORMAT(GenJournalLine.Amount)
                                                     , FORMAT(GenJournalLine."Posting Date")
                                                     , FORMAT(GenJournalLine."Due Date")
                                                     , ''
                                                     , FORMAT(GenJournalLine."Cheque No.")
                                                     , ''
                                                     , ''
                                                     , lTotalOutStanding
                                                     , "lExtDocNo."
                                                     );
                        END;
                        IF (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Payment) AND lrecSMSServerSetup."Post Vendor Payment" THEN BEGIN
                            mSendMessage := TRUE;
                            lrecVendLedger.CALCFIELDS("Vendor Invoice No.");
                            SMSTemplateID := lrecSMSServerSetup."Template ID Vend. Payment"; //MSKS
                            ltxtMessage := STRSUBSTNO(lrecSMSServerSetup."SMS Template Vend. Payment"
                                                     , lrecVend.Name
                                                     , lrecVendLedger."Vendor Invoice No."
                                                     , FORMAT(GenJournalLine.Amount)
                                                     , FORMAT(GenJournalLine."Posting Date")
                                                     , FORMAT(GenJournalLine."Due Date")
                                                     , ''
                                                     , FORMAT(GenJournalLine."Cheque No.")
                                                     , ''
                                                     , ''
                                                     , lTotalOutStanding
                                                     , "lExtDocNo."
                                                     );
                        END;
                        IF (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Refund) AND lrecSMSServerSetup."Post Vendor Refund" THEN BEGIN
                            mSendMessage := TRUE;
                            lrecVendLedger.CALCFIELDS("Vendor Invoice No.");
                            SMSTemplateID := lrecSMSServerSetup."Template ID Vend. Refund"; //MSKS
                            ltxtMessage := STRSUBSTNO(lrecSMSServerSetup."SMS Template Vend. Refund"
                                                     , lrecVend.Name
                                                     , lrecVendLedger."Vendor Invoice No."
                                                     , FORMAT(GenJournalLine.Amount)
                                                     , FORMAT(GenJournalLine."Posting Date")
                                                     , FORMAT(GenJournalLine."Due Date")
                                                     , ''
                                                     , FORMAT(GenJournalLine."Cheque No.")
                                                     , ''
                                                     , ''
                                                     , lTotalOutStanding
                                                     , "lExtDocNo."
                                                     );
                        END;
                    END;

                IF mSendMessage THEN BEGIN
                    ltxtMessage1 := '';
                    ltxtMessage2 := '';

                    //MSAK increased the length from 160 to 250 as discussed with KB Sir.
                    IF STRLEN(ltxtMessage) > 250 THEN BEGIN
                        ltxtMessage1 := '1/2 --' + COPYSTR(ltxtMessage, 1, 250);
                        ltxtMessage2 := '2/2 --' + COPYSTR(ltxtMessage, 251, STRLEN(ltxtMessage) - 250);
                    END
                    ELSE BEGIN
                        ltxtMessage1 := ltxtMessage;
                    END;

                    lrecMobileNo.RESET;
                    TxtOption1 := 5;
                    TxtOption2 := 5;
                    TxtOption3 := 5;
                    TxtOption4 := 5;

                    IF mLinkWith = 1 THEN
                        lrecMobileNo.SETRANGE("Link With", lrecMobileNo."Link With"::Bank)
                    ELSE
                        IF mLinkWith = 2 THEN
                            lrecMobileNo.SETRANGE("Link With", lrecMobileNo."Link With"::Contact);

                    lrecMobileNo.SETRANGE("Link Code", mLinkCode);
                    lrecMobileNo.SETRANGE("Send Mobile Communication", TRUE);
                    IF mLinkWith = 1 THEN BEGIN
                        IF RecCust.GET(mLinkCode) THEN
                            IF RecCustType.GET(RecCustType.Type::Customer, RecCust."Customer Type") THEN BEGIN
                                IF RecCustType."Send PCH SMS" THEN
                                    TxtOption1 := 1;

                                IF (RecCustType."Send Retail SMS") OR (RecCustType."Send DA SP SMS") THEN //Sales Person //2707
                                    TxtOption2 := 2;

                                IF RecCustType."Send Govt. SMS" THEN
                                    TxtOption3 := 3;

                                IF RecCustType."Send Private SMS" THEN
                                    TxtOption4 := 4;

                            END;
                    END;
                    lrecMobileNo.SETFILTER(Type, '%1|%2|%3|%4|%5', 0, TxtOption1, TxtOption2, TxtOption3, TxtOption4);
                    IF lrecMobileNo.FINDFIRST THEN BEGIN
                        REPEAT
                            SendSMS.SendMessage(lrecMobileNo."Mobile No.", ltxtMessage1, 0, SMSTemplateID);
                            IF ltxtMessage2 <> '' THEN
                                SendSMS.SendMessage(lrecMobileNo."Mobile No.", ltxtMessage2, 0, SMSTemplateID);
                        UNTIL lrecMobileNo.NEXT = 0;
                    END;
                END;
            END;
        END;
        //1. TRI PG 20.11.2008 -- SMS Server -- Add Stop
    end;

    procedure UpdateSMSSetupForCustomer(CustCode: Code[20])
    var
        RecCust: Record 18;
        RecCustType: Record 50010;
        lrecSMSServerSetup: Record 50035;
    begin
        CLEAR(lrecSMSServerSetup);
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


    procedure GenerateSMSEntry(var rGenJournalLine: Record 81; CustCode: Code[20]; SMSTemplateID: Text)
    var
        txtMessage: Text;
        recCustomer: Record 18;
        recSalesperson: Record 13;
        rSMSMessageQueue: Record 50036;
        cdPhone: Code[20];
        recGenJournalLine: Record 81;
        txtAccountNm: Text;
    begin
        //Keshav08052020
        IF CustCode = '' THEN
            EXIT;
        recCustomer.RESET;
        IF recCustomer.GET(CustCode) THEN BEGIN
            recSalesperson.RESET;
            IF recSalesperson.GET(recCustomer."CC Team") THEN
                cdPhone := recSalesperson."Phone No.";
        END;

        IF cdPhone <> '' THEN BEGIN
            txtMessage := '';
            IF rGenJournalLine."Document Type" = rGenJournalLine."Document Type"::Payment THEN BEGIN
                txtMessage := 'Amount Received : ' + FORMAT(ABS(rGenJournalLine.Amount)) + ' from : ' + recCustomer.Name
                                  + ', Dated : ' + FORMAT(rGenJournalLine."Posting Date") + ' and Cheque No. : ' + rGenJournalLine."Cheque No.";
                SMSTemplateID := '1707161855479856792';
            END ELSE
                IF rGenJournalLine."Document Type" = rGenJournalLine."Document Type"::Refund THEN BEGIN
                    txtMessage := 'Amount Return : ' + FORMAT(ABS(rGenJournalLine.Amount)) + ' to : ' + recCustomer.Name
                                      + ', Dated : ' + FORMAT(rGenJournalLine."Posting Date") + ' and Cheque No. : ' + rGenJournalLine."Cheque No.";
                    SMSTemplateID := '1707161855468363912';
                END;

            rSMSMessageQueue.INIT;
            rSMSMessageQueue."Message ID" := CREATEGUID;
            rSMSMessageQueue.Message := txtMessage;
            rSMSMessageQueue.Status := rSMSMessageQueue.Status::Error;
            rSMSMessageQueue."Mobile No." := cdPhone;
            rSMSMessageQueue.Priority := rSMSMessageQueue.Priority::High;
            rSMSMessageQueue."User ID" := USERID;
            rSMSMessageQueue."Application Send DateTime" := CURRENTDATETIME;
            rSMSMessageQueue.Template_ID := SMSTemplateID;
            rSMSMessageQueue.INSERT;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnPostCustOnAfterInitCustLedgEntry', '', false, false)]
    local procedure OnPostCustOnAfterInitCustLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var CustLedgEntry: Record "Cust. Ledger Entry"; Cust: Record Customer; CustPostingGr: Record "Customer Posting Group")
    begin
        //-- 1. Tri18.1PG 13112006 PG -- New Code Added - Start
        CustLedgEntry.VALIDATE(Year, DATE2DMY(CustLedgEntry."Posting Date", 3));
        CustLedgEntry.VALIDATE(Month, DATE2DMY(CustLedgEntry."Posting Date", 2));
        //-- 1. Tri18.1PG 13112006 PG -- New Code Added - Stop

        //Upgrade(-)
        //CustLedgEntry.PoT := GenJournalLine.PoT;
        CustLedgEntry.Set := GenJournalLine.Set; //6700
        CustLedgEntry."Get." := GenJournalLine."Get."; //6700
        CustLedgEntry.Pet := GenJournalLine.Pet; //6700
        CustLedgEntry."TCS On Collection Entry" := GenJournalLine."TCS On Collection Entry"; //MSKS

    end;
    /* 
        [EventSubscriber(ObjectType::Codeunit, 12, 'OnPostVendOnAfterInitVendLedgEntry', '', false, false)]
        local procedure OnPostVendOnAfterInitVendLedgEntry(var GenJnlLine: Record "Gen. Journal Line"; var VendLedgEntry: Record "Vendor Ledger Entry")

        begin
            //-- 2. Tri18.1PG 13112006 PG -- New Code Added - Start
            VendLedgEntry.VALIDATE(Year, DATE2DMY(VendLedgEntry."Posting Date", 3));
            VendLedgEntry.VALIDATE(Month, DATE2DMY(VendLedgEntry."Posting Date", 2));
            //-- 2. Tri18.1PG 13112006 PG -- New Code Added - Stop


        end;
     */
}