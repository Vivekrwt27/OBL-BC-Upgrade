tableextension 50258 tableextension50258 extends "Gen. Journal Line"
{
    fields
    {


        /* modify("TDS Group")
         {
             OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others,Rent for Plant & Machinery,Rent for Land & Building,Banking Services,Compensation On Immovable Property,PF Accumulated,Payment For Immovable Property,Goods';
         }
         modify("Service Tax Group Code")
         {
             TableRelation = "Service Tax Groups".Code WHERE(Blocked = CONST(false));
         }

         modify("ST Pure Agent")
         {
             Caption = 'ST Pure Agent';
         }
         modify("Nature of Services")
         {
             Caption = 'Nature of Services';
             OptionCaption = ' ,Exempted,Export';
         }
         modify("Work Tax % Applied")
         {
             Caption = 'Work Tax % Applied';
         }
         modify("W.T Amount")
         {
             Caption = 'W.T Amount';
         }
         modify("Works Tax")
         {
             Caption = 'Work Tax';
         }
         modify("Reverse Work Tax")
         {
             Caption = 'Reverse Work Tax';
         }
         modify("CWIP G/L Type")
         {
             Caption = 'CWIP G/L Type';
             OptionCaption = ' ,Labor,Material,Overheads';
         }
         modify(CWIP)
         {
             Caption = 'CWIP';
         }*/ // 15578
        modify("Shift Type")
        {
            Caption = 'Shift Type';
            OptionCaption = 'Single,Double,Triple';
        }
        modify("Industry Type")
        {
            Caption = 'Industry Type';
            OptionCaption = 'Normal,Non Seasonal,Seasonal';
        }
        modify("No. of Days for Shift")
        {
            Caption = 'No. of Days for Shift';
        }
        /*  modify("RG/Service Tax Set Off Date")
          {
              Caption = 'RG/Service Tax Set Off Date';
          }
          modify("PLA Set Off Date")
          {
              Caption = 'PLA Set Off Date';
          }
          modify("Insert S.T Recoverable")
          {
              Caption = 'Insert S.T Recoverable';
          }*/ // 15578
        modify("Offline Application")
        {
            Caption = 'Offline Application';
        }
        /*  modify("S.T From Order")
          {
              Caption = 'S.T From Order';
          }
          modify("Un Application Entry")
          {
              Caption = 'Un Application Entry';
          }
          modify("Include Serv. Tax in TDS Base")
          {
              Caption = 'Include Serv. Tax in TDS Base';
          }
          modify(Posting)
          {
              Caption = 'Posting';
          }
          modify("Applied TDS Base Amount")
          {
              Caption = 'Applied TDS Base Amount';
          }*/ // 15578

        modify("Account Type")
        {
            trigger OnAfterValidate()
            begin
                // 15578  VALIDATE(Narration, '');
            end;
        }
        modify(Amount)
        {
            trigger OnAfterValidate()
            begin
                if "Pay TDS" or "Pay TCS" then begin
                    if xRec.Amount <> rec.Amount then
                        Error('Amount Can not be changed');
                end;
            end;
        }
        modify("Credit Amount")
        {
            trigger OnAfterValidate()
            begin
                if "Pay TDS" or "Pay TCS" then begin
                    if xRec.Amount <> rec.Amount then
                        Error('Amount Can not be changed');
                end;

            end;
        }
        modify("Debit Amount")
        {
            trigger OnAfterValidate()
            begin
                if "Pay TDS" or "Pay TCS" then begin
                    if xRec.Amount <> rec.Amount then
                        Error('Amount Can not be changed');
                end;

            end;
        }
        modify("Account No.")
        {
            trigger OnAfterValidate()
            var
                Vend: Record 23;
                r: Record "Tax Transaction Value";
            begin
                //Upgrade(+)
                //ND End

                GeneralLedgerSetup.RESET;
                IF GeneralLedgerSetup.FIND('-') THEN
                    Location1.RESET;
                Location1.SETFILTER(Location1.Code, "Location Code");
                IF Location1.FIND('-') THEN BEGIN
                    IF Location1."Main Location" <> '' THEN BEGIN
                        Location1.SETFILTER(Location1.Code, Location1."Main Location");
                        Location1.FIND('-');
                    END;
                    if "Account Type" = "Account Type"::Vendor then
                        if Vend.get("Account No.") then begin //TEAM 14763
                            "Account Name" := Vend.Name;  //TRI V.D 25.06.10 ADD
                            Description2 := Vend.Name; //Kulbhushan
                            Narration := Vend.Name;
                            Description := Vend.Name;
                            "Beneficiary Account No." := Vend."Bank A/c";
                            "Beneficiary Account Type" := Vend."Beneficiary Account Type";
                            "Beneficiary IFSC Code" := Vend."RTGS/NEFT Code";
                            //"Beneficiary Account Type" := Vend."Bank Account Type";
                            //"Online Bank Transfer" := Vend."Bank Online Transfer";
                            IF Vend."Bank Beneficiary Name" <> '' THEN BEGIN
                                "Beneficiary Name" := Vend."Bank Beneficiary Name";
                            END ELSE BEGIN
                                "Beneficiary Name" := Vend.Name;
                            END;
                        end; //TEAM 14763



                    /*  IF JournalLineDimension.GET(DATABASE::"Gen. Journal Line", "Journal Template Name", "Journal Batch Name",
                      "Line No.", 0, GeneralLedgerSetup."Location Dimension Code") THEN BEGIN

                          JournalLineDimension."Dimension Value Code" := Location1."Location Dimension";
                          JournalLineDimension.MODIFY;
                      END ELSE BEGIN
                          JournalLineDimension."Table ID" := DATABASE::"Gen. Journal Line";
                          //15578  JournalLineDimension."Journal Template Name" := "Journal Template Name";
                          //  JournalLineDimension."Journal Batch Name" := "Journal Batch Name";
                          //  JournalLineDimension."Journal Line No." := "Line No.";
                          //15578  JournalLineDimension."Allocation Line No." := 0;
                          JournalLineDimension."Dimension Code" := GeneralLedgerSetup."Location Dimension Code";
                          JournalLineDimension."Dimension Value Code" := Location1."Location Dimension";
                          JournalLineDimension.INSERT;

                      END;*/  // 15578
                END;
                VALIDATE("Shortcut Dimension 1 Code", "Location Code");  //TRI DG
                                                                         //Upgrade(-)


            end;
        }
        modify("Bal. Account No.")// 15578
        {
            trigger OnAfterValidate()
            var
                GLAcc: Record "G/L Account";
                Narration: Text[30];
                Cust: Record Customer;
                Vend: Record Vendor;
                BankAcc: Record "Bank Account";
                ICPartner: Record "IC Partner";
            begin
                IF "Account No." = '' THEN BEGIN
                    Narration := GLAcc.Name;
                    if "Bal. Account Type" = "Bal. Account Type"::Customer then begin
                        Narration := Cust.Name;
                        "Bal. Account Name" := Cust.Name;  //TRI V.D 25.06.10 ADD
                    end;
                    if "Bal. Account Type" = "Bal. Account Type"::Vendor then begin
                        Narration := Vend.Name;
                        "Bal. Account Name" := Vend.Name;  //TRI V.D 25.06.10 ADD
                    end;
                    if "Bal. Account Type" = "Bal. Account Type"::"Bank Account" then begin
                        "Bal. Account Name" := Vend.Name;  //TRI V.D 25.06.10 ADD
                        "Bal. Account Name" := BankAcc.Name;  //TRI V.D 25.06.10 ADD
                    end;
                    if "Bal. Account Type" = "Bal. Account Type"::"Fixed Asset" then
                        Narration := ICPartner.Name;

                    GeneralLedgerSetup.RESET;
                    IF GeneralLedgerSetup.FIND('-') THEN
                        Location1.RESET;
                    Location1.SETFILTER(Location1.Code, "Location Code");
                    IF Location1.FIND('-') THEN BEGIN
                        IF Location1."Main Location" <> '' THEN BEGIN
                            Location1.SETFILTER(Location1.Code, Location1."Main Location");
                            Location1.FIND('-');
                        END;
                        /*  IF JournalLineDimension.GET(DATABASE::"Gen. Journal Line", "Journal Template Name", "Journal Batch Name",
                          "Line No.", 0, GeneralLedgerSetup."Location Dimension Code") THEN BEGIN
                              JournalLineDimension."Dimension Value Code" := Location1."Location Dimension";
                              JournalLineDimension.MODIFY;
                          END ELSE BEGIN
                              JournalLineDimension."Table ID" := DATABASE::"Gen. Journal Line";
                              JournalLineDimension."Journal Template Name" := "Journal Template Name";
                              JournalLineDimension."Journal Batch Name" := "Journal Batch Name";
                              JournalLineDimension."Journal Line No." := "Line No.";
                              JournalLineDimension."Allocation Line No." := 0;
                              JournalLineDimension."Dimension Code" := GeneralLedgerSetup."Location Dimension Code";
                              JournalLineDimension."Dimension Value Code" := Location1."Location Dimension";
                              JournalLineDimension.INSERT;

                          END;
                      END;
                      VALIDATE("Shortcut Dimension 1 Code", "Location Code");  //TRI DG*/

                    end;
                end;
            end;

        }


        modify("Incoming Document Entry No.")
        {
            trigger OnAfterValidate()
            var
                Narration: Text[50];
                IncomingDocument: Record "Incoming Document";
            begin
                IF Narration = '' THEN
                    Narration := COPYSTR(IncomingDocument.Description, 1, MAXSTRLEN(Narration));

            end;
        }
        modify("Location Code")// 15578
        {
            trigger OnBeforeValidate()
            begin

                GenJnlTemplate1.RESET;
                GenJnlTemplate1.SETFILTER(GenJnlTemplate1.Name, "Journal Template Name");
                IF GenJnlTemplate1.FIND('-') THEN
                    IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::General THEN
                        UserAccess := 14;
                IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::Sales THEN
                    UserAccess := 15;
                IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::Purchases THEN
                    UserAccess := 16;
                IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::"Cash Receipts" THEN
                    UserAccess := 17;
                IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::Payments THEN
                    UserAccess := 18;
                IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::Assets THEN
                    UserAccess := 19;
                IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::"TDS Adjustments" THEN
                    UserAccess := 20;
                IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::LC THEN
                    UserAccess := 21;
                IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::Receipts THEN
                    UserAccess := 22;
                IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::JV THEN
                    UserAccess := 23;
                IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::StdPayments THEN
                    UserAccess := 24;
                Permissions.Type(UserAccess, "Location Code");

                GeneralLedgerSetup.RESET;
                IF GeneralLedgerSetup.FIND('-') THEN
                    Location1.RESET;
                Location1.SETFILTER(Location1.Code, "Location Code");
                IF Location1.FIND('-') THEN BEGIN
                    IF Location1."Main Location" <> '' THEN BEGIN
                        Location1.SETFILTER(Location1.Code, Location1."Main Location");
                        Location1.FIND('-');
                    END;
                    /*  IF JournalLineDimension.GET(DATABASE::"Gen. Journal Line", "Journal Template Name", "Journal Batch Name",
                      "Line No.", 0, GeneralLedgerSetup."Location Dimension Code") THEN BEGIN
                          //JournalLineDimension."Table ID" := DATABASE::"Gen. Journal Line";
                          //JournalLineDimension."Journal Template Name" := "Journal Template Name";
                          //JournalLineDimension."Journal Batch Name" := "Journal Batch Name";
                          //JournalLineDimension."Journal Line No." := "Line No.";
                          //JournalLineDimension."Allocation Line No." := 0;
                          //JournalLineDimension."Dimension Code" := GeneralLedgerSetup."Location Dimension Code";
                          JournalLineDimension."Dimension Value Code" := Location1."Location Dimension";
                          JournalLineDimension.MODIFY;
                      END ELSE BEGIN
                          JournalLineDimension."Table ID" := DATABASE::"Gen. Journal Line";
                          JournalLineDimension."Journal Template Name" := "Journal Template Name";
                          JournalLineDimension."Journal Batch Name" := "Journal Batch Name";
                          JournalLineDimension."Journal Line No." := "Line No.";
                          JournalLineDimension."Allocation Line No." := 0;
                          JournalLineDimension."Dimension Code" := GeneralLedgerSetup."Location Dimension Code";
                          JournalLineDimension."Dimension Value Code" := Location1."Location Dimension";
                          JournalLineDimension.INSERT;

                      END;
                  END;
                   //TRI DG*/
                end;
                VALIDATE("Shortcut Dimension 1 Code", "Location Code");
            end;
        }


        field(50000; Description2; Text[150])
        {
            Description = 'Tri PG 29.11.2006 Field Length Change From 200 -> 50';
        }
        field(50002; "Charges Amount"; Decimal)
        {
        }
        field(50003; abedment; Boolean)
        {
        }
        field(50004; MRP; Decimal)
        {
        }
        field(50043; "Dealer Code"; Code[20])
        {
            Description = 'ND';
            TableRelation = "Salesperson/Purchaser".Code WHERE("Customer No." = FILTER(<> ''));
        }
        field(50044; "Dealer's Salesperson Code"; Code[20])
        {
            Description = 'ND';
            TableRelation = "Salesperson/Purchaser".Code WHERE("Customer No." = FILTER(= ''));
        }
        field(50045; "BSR Code"; Code[7])
        {
            Description = 'Rakesh-to post in TDS entry table';
        }
        field(50046; "Balance OK"; Boolean)
        {
            Description = 'TriPG 10112006 -- For Batch -- Test Gen. Line Balance';
        }
        field(50047; Reversal; Boolean)
        {
            Description = 'TRI VS';
        }
        field(50048; "Entry No. 3.7"; Integer)
        {
        }
        field(50049; "Closed By Entry No. 3.7"; Integer)
        {
        }
        field(50050; "Closed By Amount 3.7"; Decimal)
        {
        }
        field(50051; "Issuing Bank"; Text[70])
        {
        }
        field(50052; "Account Name"; Text[200])
        {
            Editable = false;
        }
        field(50053; "Bal. Account Name"; Text[150])
        {
            Editable = false;
        }
        field(50054; "Export Reference No."; Text[30])
        {
            Description = 'Oriut';
        }
        field(50055; "Manual TDS"; Boolean)
        {
        }
        field(50056; "Manual TDS Base Amount"; Decimal)
        {
        }
        field(50080; Set; Boolean)
        {
        }
        field(50081; Pet; Boolean)
        {
        }
        field(50082; "Get."; Boolean)
        {
        }
        field(50083; "TCS On Collection Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50084; "PO No."; Code[25])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." WHERE("Pay-to Vendor No." = FIELD("Account No."));
        }
        field(60000; "Beneficiary Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Saving,Current,Cash Credit';
            OptionMembers = " ",Saving,Current,"Cash Credit";
        }
        field(60001; "Beneficiary Account No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60002; "Beneficiary Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60003; "Beneficiary IFSC Code"; Code[11])
        {
            DataClassification = ToBeClassified;
        }
        field(60004; "Payment Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,NEFT,RTGS,IMPS';
            OptionMembers = " ",NEFT,RTGS,IMPS;
        }
        field(60005; "Online Bank Transfer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60006; Narration; Text[200])
        {
            Description = 'Narration';
        }
    }
    keys
    {
        key(Key1; "Entry No. 3.7")
        {
        }
        key(Key11; "Journal Template Name", "Journal Batch Name", "Posting Date" /*"Cheque No."*/)
        {
        }
    }


    trigger OnInsert()
    var

    begin
        GenJnlTemplate.GET("Journal Template Name");
        GenJnlBatch.GET("Journal Template Name", "Journal Batch Name");
        IF GenJnlBatch."Posting No. Series" <> '' THEN
            IF NoSeries.GET(GenJnlBatch."Posting No. Series") THEN
                "TCS On Collection Entry" := NoSeries."TCS On Collection Entry";

        IF NOT "TCS On Collection Entry" THEN
            IF GenJnlBatch."No. Series" <> '' THEN
                IF NoSeries.GET(GenJnlBatch."No. Series") THEN
                    "TCS On Collection Entry" := NoSeries."TCS On Collection Entry";
        //ND End
        GenJnlTemplate1.RESET;
        GenJnlTemplate1.SETFILTER(GenJnlTemplate1.Name, "Journal Template Name");
        IF GenJnlTemplate1.FIND('-') THEN
            IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::General THEN
                UserAccess := 14;
        IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::Sales THEN
            UserAccess := 15;
        IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::Purchases THEN
            UserAccess := 16;
        IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::"Cash Receipts" THEN
            UserAccess := 17;
        IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::Payments THEN
            UserAccess := 18;
        IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::Assets THEN
            UserAccess := 19;
        /* IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::"TDS Adjustments" THEN
             UserAccess := 20;
         IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::LC THEN
             UserAccess := 21;
         IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::Receipts THEN
             UserAccess := 22;
         IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::JV THEN
             UserAccess := 23;
         IF GenJnlTemplate1.Type = GenJnlTemplate1.Type::StdPayments THEN
             UserAccess := 24;

        Permissions.Type(UserAccess, "Location Code");*/ // 15578


        GeneralLedgerSetup.RESET;
        IF GeneralLedgerSetup.FIND('-') THEN
            Location1.RESET;
        Location1.SETFILTER(Location1.Code, "Location Code");
        IF Location1.FIND('-') THEN BEGIN
            IF Location1."Main Location" <> '' THEN BEGIN
                Location1.SETFILTER(Location1.Code, Location1."Main Location");
                Location1.FIND('-');
            END;
            /*  IF JournalLineDimension.GET(DATABASE::"Gen. Journal Line", "Journal Template Name", "Journal Batch Name",
              "Line No.", 0, GeneralLedgerSetup."Location Dimension Code") THEN BEGIN
                  JournalLineDimension."Dimension Value Code" := Location1."Location Dimension";
                  JournalLineDimension.MODIFY;
              END ELSE BEGIN
                  JournalLineDimension."Table ID" := DATABASE::"Gen. Journal Line";
                  JournalLineDimension."Journal Template Name" := "Journal Template Name";
                  JournalLineDimension."Journal Batch Name" := "Journal Batch Name";
                  JournalLineDimension."Journal Line No." := "Line No.";
                  JournalLineDimension."Allocation Line No." := 0;
                  JournalLineDimension."Dimension Code" := GeneralLedgerSetup."Location Dimension Code";
                  JournalLineDimension."Dimension Value Code" := Location1."Location Dimension";
                  JournalLineDimension.INSERT;
                  "Shortcut Dimension 1 Code" := "Location Code";
              END;
          END;*/ // 15578
                 //TRI
        end;
    end;

    //Unsupported feature: Code Modification on "SetUpNewLine(PROCEDURE 9)".

    //procedure SetUpNewLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GenJnlTemplate.GET("Journal Template Name");
    GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
    GenJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
    #4..37
    THEN
      "Account Type" := "Account Type"::"G/L Account";
    VALIDATE("Bal. Account No.",GenJnlBatch."Bal. Account No.");
    Description := '';
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..40
    //Description := '';
    //upgrade(+)
      Narration := '';
    //Upgrade(-)
    */
    //end;


    //Unsupported feature: Code Modification on "InsertGenTDSBuf(PROCEDURE 1280005)".// Function N/F in  BC

    //procedure InsertGenTDSBuf();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CLEAR(TDSBuf[1]);
    TDSBuf[1]."TDS Nature of Deduction" := "TDS Nature of Deduction";
    TDSBuf[1]."Assessee Code" := "Assessee Code";
    #4..6
      TDSBuf[1]."TDS Base Amount" := ABS("Temp TDS/TCS Base");
      TDSBuf[1]."Surcharge Base Amount" := ABS("Temp TDS/TCS Base");
    END ELSE BEGIN
      TDSBuf[1]."TDS Base Amount" := TDSBaseLCY;
      TDSBuf[1]."Surcharge Base Amount" := TDSBaseLCY;
    END;
    TDSBuf[1]."TDS %" := "TDS/TCS %";
    TDSBuf[1]."Surcharge %" := "Surcharge %";
    UpdTDSBuffer;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
      // >>ALLE.TDS-REGEF START
      IF TDSGroup.FindOnDate("TDS Group","Posting Date") THEN
        IF TDSSetup."Calc. Over & Above Threshold" THEN
          OverAndAboveThresholdAmount := TDSGroup."TDS Threshold Amount";
      // <<ALLE.TDS-REGEF STOP
      TDSBuf[1]."TDS Base Amount" := TDSBaseLCY - OverAndAboveThresholdAmount;
      TDSBuf[1]."Surcharge Base Amount" := TDSBaseLCY - OverAndAboveThresholdAmount;
    #12..15
    */
    //end;





    //Unsupported feature: Code Modification on "UpdateDescription(PROCEDURE 43)".//Event N/F

    //procedure UpdateDescription();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT IsAdHocDescription THEN
      Description := Name;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT IsAdHocDescription THEN
      //Description := Name;
      Narration := Name
    */
    //end;






    //Unsupported feature: Code Modification on "UpdateAccNoCustomer(PROCEDURE 1500059)".// FUNCTION N/F

    //procedure UpdateAccNoCustomer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Cust.GET("Account No.");
    Cust.CheckBlockedCustOnJnls(Cust,"Document Type",FALSE);
    IF Cust."IC Partner Code" <> '' THEN BEGIN
    #4..17
    VALIDATE("Bill-to/Pay-to No.","Account No.");
    VALIDATE("Sell-to/Buy-from No.","Account No.");
    "GST Customer Type" := Cust."GST Customer Type";
    "Post GST to Customer" := Cust."Post GST to Customer";
    IF ("Document Type" IN ["Document Type"::Invoice,"Document Type"::"Credit Memo"]) AND "GST in Journal" THEN
      GSTManagement.GetJournalInvoiceTypeNoSeries(Rec,TransactionType1::Sales);
    IF "GST Customer Type" = "GST Customer Type"::Unregistered THEN
    #25..39
    UpdatePoT;
    UpdateGSTfromPartyVendCust("Account No.",TRUE,FALSE);
    "Journal Entry" := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..20
    #22..42
    //Upgrade(+)
      "Account Name" := Cust.Name;  //TRI V.D 25.06.10 ADD
    //Upgrade(-)

    //Upgrade(+)
    Description2 := Cust.Name; //Kulbhushan
    //Upgrade(-)
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateAccNoVendor(PROCEDURE 1500062)".// FUNCTION N/F

    //procedure UpdateAccNoVendor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //var
    /*   Vend: Record 23;
  begin

      Vend.GET("Account No.");
      Vend.CheckBlockedVendOnJnls(Vend, "Document Type", FALSE);
      IF Vend."IC Partner Code" <> '' THEN BEGIN

      END;
  END;




    "Account Name" := Vend.Name;  //TRI V.D 25.06.10 ADD



  Description2 := Vend.Name; //Kulbhushan




  "Beneficiary Account No." := Vend."Bank A/c";
  "Beneficiary Account Type" := Vend."Beneficiary Account Type";
  "Beneficiary IFSC Code" := Vend."RTGS/NEFT Code";
  //"Beneficiary Account Type" := Vend."Bank Account Type";
  //"Online Bank Transfer" := Vend."Bank Online Transfer";
  IF Vend."Bank Beneficiary Name"<>'' THEN BEGIN
    "Beneficiary Name" := Vend."Bank Beneficiary Name";
  END ELSE BEGIN
    "Beneficiary Name" := Vend.Name;
  END;
  //
*/



    //end;


    //Unsupported feature: Code Modification on "UpdateAccNoGLAccount(PROCEDURE 1500065)".// FUNCTION N/F

    //procedure UpdateAccNoGLAccount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GLAcc.GET("Account No.");
    CheckGLAcc;
    ReadGLSetup;
    #4..6
      UpdateDescription(GLAcc.Name)
    ELSE
      IF GLAcc."Omit Default Descr. in Jnl." THEN
        Description := '';
    IF ("Bal. Account No." = '') OR ("Bal. Account Type" IN ["Bal. Account Type"::"G/L Account",
                                                             "Bal. Account Type"::"Bank Account"])
    THEN BEGIN
    #14..26
    "Tax Area Code" := GLAcc."Tax Area Code";
    "Tax Liable" := GLAcc."Tax Liable";
    "Tax Group Code" := GLAcc."Tax Group Code";
    IF "Posting Date" <> 0D THEN
      IF "Posting Date" = CLOSINGDATE("Posting Date") THEN
        ClearPostingGroups;
    #33..43
    END;
    VALIDATE("Deferral Code",GLAcc."Default Deferral Template Code");
    PopulateGSTInvoiceCrMemo(TRUE,FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
        Narration := '';
    #11..29
    "Account Name" := GLAcc.Name; //OT++
    #30..46
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateBalAccNoFA(PROCEDURE 1500061)".// FUNCTION N/F

    //procedure UpdateBalAccNoFA();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FA.GET("Bal. Account No.");
    FA.TESTFIELD(Blocked,FALSE);
    FA.TESTFIELD(Inactive,FALSE);
    FA.TESTFIELD("Budgeted Asset",FALSE);
    IF "Account No." = '' THEN
      Description := FA.Description;

    IF "Depreciation Book Code" = '' THEN BEGIN
      FASetup.GET;
    #10..16
    END;
    GetFAVATSetup;
    GetFAAddCurrExchRate;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
      Narration := FA.Description;
    #7..19
    */
    //end;


    //Unsupported feature: Code Modification on "GetInvoiceAmtTDS(PROCEDURE 1500063)".// FUNCTION N/F

    //procedure GetInvoiceAmtTDS();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Party Type" = "Party Type"::Vendor THEN
      Vend.GET("Party Code");
    TDSEntry.RESET;
    TDSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TDS Group","Assessee Code","Document Type");
    TDSEntry.SETRANGE("Party Type","Party Type");
    IF ("Party Type" = "Party Type"::Vendor) AND (Vend."P.A.N. Status" = Vend."P.A.N. Status"::" ") THEN
      TDSEntry.SETRANGE("Deductee P.A.N. No.",Vend."P.A.N. No.")
    ELSE
      TDSEntry.SETRANGE("Party Code","Party Code");

    TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
    TDSEntry.SETRANGE("TDS Group","TDS Group");
    TDSEntry.SETRANGE("Assessee Code","Assessee Code");
    #14..16
      InvoiceAmount := ABS(TDSEntry."Invoice Amount");
    END;
    EXIT(InvoiceAmount);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #3..5
    TDSEntry.SETRANGE("Party Code","Party Code");
    #11..19
    */
    //end;


    //Unsupported feature: Code Modification on "GetPaymentAmtTDS(PROCEDURE 1500067)".// FUNCTION N/F

    //procedure GetPaymentAmtTDS();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Party Type" = "Party Type"::Vendor THEN
      Vendor.GET("Party Code");
    TDSEntry.RESET;
    TDSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TDS Group","Assessee Code","Document Type");
    TDSEntry.SETRANGE("Party Type","Party Type");
    IF ("Party Type" = "Party Type"::Vendor) AND (Vendor."P.A.N. Status" = Vendor."P.A.N. Status"::" ") THEN
      TDSEntry.SETRANGE("Deductee P.A.N. No.",Vendor."P.A.N. No.")
    ELSE
      TDSEntry.SETRANGE("Party Code","Party Code");
    TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
    TDSEntry.SETRANGE("TDS Group","TDS Group");
    TDSEntry.SETRANGE("Assessee Code","Assessee Code");
    #13..15
      PaymentAmount := ABS(TDSEntry."Invoice Amount");
    END;
    EXIT(PaymentAmount);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #3..5
    TDSEntry.SETRANGE("Party Code","Party Code");
    #10..18
    */
    //end;


    //Unsupported feature: Code Modification on "CalculateTDSVendorAppliesToDoc(PROCEDURE 1500570)".// FUNCTION N/F

    //procedure CalculateTDSVendorAppliesToDoc();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CheckSameTDS;
    VendorLedgerEntry.SETCURRENTKEY("Vendor No.","Document No.",Open);
    IF "Account Type" = "Account Type"::Vendor THEN
    #4..20
            "TDS/TCS Base Amount" := PreviousAmount + TDSBaseLCY - AppliedAmountDoc
          ELSE BEGIN
            IF PreviousContractAmount <> 0 THEN
              "TDS/TCS Base Amount" := TDSBaseLCY - AppliedAmountDoc
            ELSE
              "TDS/TCS Base Amount" := TDSBaseLCY - AppliedAmountDoc;
          END;
    #28..51
        "Temp TDS/TCS Base" := 0;
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..23
              "TDS/TCS Base Amount" := TDSBaseLCY - AppliedAmountDoc +
                (PreviousAmount - PreviousContractAmount)
    #25..54
    */
    //end;


    //Unsupported feature: Code Modification on "CalculateTDSThresholdOverlookWOApp(PROCEDURE 1500583)".// FUNCTION N/F

    //procedure CalculateTDSThresholdOverlookWOApp();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "TDS/TCS Base Amount" := TDSBaseLCY;
    "TDS/TCS %" := TDSSetupPercentage;
    "eCESS %" := TDSSetup."eCESS %";
    "SHE Cess % on TDS/TCS" := TDSSetup."SHE Cess %";
    IF NODLines."Surcharge Overlook" THEN BEGIN
      "Surcharge Base Amount" := TDSBaseLCY;
      "Surcharge %" := TDSSetup."Surcharge %";
    #8..19
          "Surcharge %" := 0;
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4

    BlnCeiling:=FALSE;
    IF (((PreviousAmount+TDSBaseLCY) >= NODLines."TDS Credit Limit Amount")AND(NODLines."TDS Credit Limit Amount"<>0)) THEN BEGIN
      VALIDATE("TDS/TCS %",NODLines."TDS Credit Limit %");
      BlnCeiling :=TRUE;
      END ELSE BEGIN
      BlnCeiling :=FALSE;
      VALIDATE("TDS/TCS %",TDSSetup."TDS %");
    END;
    //MSSS
    //Team 7739 Upgrade 140616 End-

    "TDS/TCS Base Amount" := TDSBaseLCY;

    #5..22
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: OverAndAboveThresholdAmount) (VariableCollection) on "CalcTDSWoThresholdOverlookWOApp(PROCEDURE 1505105)".



    //Unsupported feature: Code Modification on "CalcTDSWoThresholdOverlookWOApp(PROCEDURE 1505105)".// FUNCTION N/F

    //procedure CalcTDSWoThresholdOverlookWOApp();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF (PreviousJnlAmt > TDSGroup."TDS Threshold Amount") AND NOT Posting THEN BEGIN
      "TDS/TCS Base Amount" := TDSBaseLCY;
      "TDS/TCS %" := TDSSetup."TDS %";
      "eCESS %" := TDSSetup."eCESS %";
      "SHE Cess % on TDS/TCS" := TDSSetup."SHE Cess %";
      IF NODLines."Surcharge Overlook" THEN BEGIN
    #7..70
      ELSE
        IF Posting THEN
          IF (PreviousAmount + TDSBaseLCY) > TDSGroup."TDS Threshold Amount" THEN BEGIN
            "TDS/TCS Base Amount" := PreviousAmount + TDSBaseLCY;
            "TDS/TCS %" := TDSSetupPercentage;
            "eCESS %" := TDSSetup."eCESS %";
            "SHE Cess % on TDS/TCS" := TDSSetup."SHE Cess %";
    #78..103
        ELSE
          IF NOT Posting THEN
            IF (PreviousAmount + TDSBaseLCY + PreviousJnlAmt) > TDSGroup."TDS Threshold Amount" THEN BEGIN
              "TDS/TCS Base Amount" := PreviousAmount + TDSBaseLCY + PreviousJnlAmt - PreviousJnlTDSCalculated;
              "TDS/TCS %" := TDSSetup."TDS %";
              "eCESS %" := TDSSetup."eCESS %";
              "SHE Cess % on TDS/TCS" := TDSSetup."SHE Cess %";
              IF NODLines."Surcharge Overlook" THEN BEGIN
    #112..123
                    "Surcharge %" := 0;
                END;
              END;
              InsertJnlTDSBuf(PreviousJnlAmt + TDSBaseLCY - PreviousJnlTDSCalculated);
              InsertEntriesToTDSBuffer(AccountingPeriodFilter,TRUE);
            END ELSE BEGIN
              "TDS/TCS Base Amount" := TDSBaseLCY;
              "TDS/TCS %" := 0;
              "eCESS %" := 0;
              "SHE Cess % on TDS/TCS" := 0;
            END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF (PreviousJnlAmt > TDSGroup."TDS Threshold Amount") AND NOT Posting THEN BEGIN
      // >>ALLE.TDS-REGEF START
      IF TDSSetup."Calc. Over & Above Threshold" THEN
        OverAndAboveThresholdAmount := TDSGroup."TDS Threshold Amount";
      // <<ALLE.TDS-REGEF STOP
      "TDS/TCS Base Amount" := TDSBaseLCY - OverAndAboveThresholdAmount;
      //"TDS/TCS %" := TDSSetup."TDS %"; // >>ALLE.TDS-REGEF
      "TDS/TCS %" := TDSSetupPercentage; // >>ALLE.TDS-REGEF
    #4..73
            // >>ALLE.TDS-REGEF START
            IF TDSSetup."Calc. Over & Above Threshold" THEN
              OverAndAboveThresholdAmount := TDSGroup."TDS Threshold Amount";
            // <<ALLE.TDS-REGEF STOP
            "TDS/TCS Base Amount" := PreviousAmount + TDSBaseLCY - OverAndAboveThresholdAmount;
    #75..106
              // >>ALLE.TDS-REGEF START
              IF TDSSetup."Calc. Over & Above Threshold" THEN
                OverAndAboveThresholdAmount := TDSGroup."TDS Threshold Amount";
              // <<ALLE.TDS-REGEF STOP
              "TDS/TCS Base Amount" := PreviousAmount + TDSBaseLCY + PreviousJnlAmt - PreviousJnlTDSCalculated - OverAndAboveThresholdAmount;
              //"TDS/TCS %" := TDSSetup."TDS %"; // >>ALLE.TDS-REGEF
              "TDS/TCS %" := TDSSetupPercentage; // >>ALLE.TDS-REGEF
    #109..126
              InsertJnlTDSBuf(PreviousJnlAmt + TDSBaseLCY - PreviousJnlTDSCalculated - OverAndAboveThresholdAmount);
    #128..134
    */
    //end;


    //Unsupported feature: Code Modification on "CalculateTDSBaseLCY(PROCEDURE 1505109)".// FUNCTION N/F

    //procedure CalculateTDSBaseLCY();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Inc. GST in TDS Base" AND (("Document Type" = "Document Type"::Invoice) AND NOT "GST Reverse Charge") THEN BEGIN
      CheckValidationforGSTinTDSTCSBase;
      GSTAmountTDSTCS := GSTManagement.GetTotalGSTAmountTDSTCS(Rec,TransactionType1::Purchase);
    #4..54
              TDSBaseLCY :=
                ROUND(
                  CurrExchRate.ExchangeAmtFCYToLCY("Posting Date","Currency Code",ABS(Amount),"Currency Factor"));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Manual TDS" AND ("Manual TDS Base Amount"<>0) THEN BEGIN//MSKS
      TDSBaseLCY := "Manual TDS Base Amount";
      EXIT;
    END;
    #1..57
    */
    //end;


    //Unsupported feature: Code Modification on "PopulateTCSonThresholdOverlook(PROCEDURE 1500080)".// FUNCTION N/F

    //procedure PopulateTCSonThresholdOverlook();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "TDS/TCS Base Amount" := TCSBaseLCY;
    "Surcharge %" := TCSSetup."Surcharge %";
    "eCESS %" := TCSSetup."eCESS %";
    "SHE Cess % on TDS/TCS" := TCSSetup."SHE Cess %";
    #5..27
            UNTIL TCSEntry.NEXT = 0;
        END ELSE
          "Surcharge %" := 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "TDS/TCS Base Amount" := TCSBaseLCY;
    "Sales Amount" := "TDS/TCS Base Amount";
    #2..30
    */
    //end;


    //Unsupported feature: Code Modification on "PopulateTCSonPrevAmounterGreaterThreshold(PROCEDURE 1500079)".// FUNCTION N/F

    //procedure PopulateTCSonPrevAmounterGreaterThreshold();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "TDS/TCS Base Amount" := TCSBaseLCY;
    "Surcharge %" := TCSSetup."Surcharge %";
    "eCESS %" := TCSSetup."eCESS %";
    "SHE Cess % on TDS/TCS" := TCSSetup."SHE Cess %";
    #5..27
            UNTIL TCSEntry.NEXT = 0;
        END ELSE
          "Surcharge %" := 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "TDS/TCS Base Amount" := TCSBaseLCY;
    "Sales Amount" := TCSBaseLCY;
    #2..30
    */
    //end;


    //Unsupported feature: Code Modification on "PopulateTCSonPrevAmountAndTCSBaseGreaterThreshold(PROCEDURE 1500078)".// FUNCTION N/F

    //procedure PopulateTCSonPrevAmountAndTCSBaseGreaterThreshold();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "TDS/TCS Base Amount" := PrevInvAmount + TCSBaseLCY - PrevContractAmount;
    "Surcharge %" := TCSSetup."Surcharge %";
    "eCESS %" := TCSSetup."eCESS %";
    "SHE Cess % on TDS/TCS" := TCSSetup."SHE Cess %";
    #5..27
      REPEAT
        InsertTCSBuffer(TCSEntry,"Posting Date","Surcharge %" <> 0,TRUE);
      UNTIL TCSEntry.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "TDS/TCS Base Amount" := PrevInvAmount + TCSBaseLCY - PrevContractAmount;
    "Sales Amount" := "TDS/TCS Base Amount";
    #2..30
    */
    //end;


    //Unsupported feature: Code Modification on "InitiateTCSCalculation(PROCEDURE 1500077)".// FUNCTION N/F

    //procedure InitiateTCSCalculation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Serv. Tax on Advance Payment" THEN
      TCSBaseLCY := ABS(Amount)
    ELSE BEGIN
      IF NOT "Exclude GST in TCS Base" THEN
        IF "TCS on Recpt. Of Pmt. Amount" = 0 THEN
          TCSBaseLCY :=
            ABS(Amount) + ABS("Service Tax Amount" + "Service Tax eCess Amount" +
              "Service Tax SHE Cess Amount" + "Service Tax SBC Amount" + "KK Cess Amount") +
            ABS(GSTManagement.GetTotalGSTAmountTDSTCS(Rec,TransactionType1::Sales))
        ELSE
          TCSBaseLCY :=
            ABS("TCS on Recpt. Of Pmt. Amount")
      ELSE
        IF "TCS on Recpt. Of Pmt. Amount" = 0 THEN
          TCSBaseLCY :=
            ABS(Amount) + ABS("Service Tax Amount" + "Service Tax eCess Amount" +
              "Service Tax SHE Cess Amount" + "Service Tax SBC Amount" + "KK Cess Amount")
        ELSE
          TCSBaseLCY :=
            ABS("TCS on Recpt. Of Pmt. Amount");
    END;
    IF "Currency Code" <> '' THEN BEGIN
      IF NOT "Exclude GST in TCS Base" THEN
        TCSBaseLCY := TCSBaseLCY - ABS(GSTManagement.GetTotalGSTAmountTDSTCS(Rec,TransactionType1::Sales));
      TCSBaseLCY := ROUND(
          CurrExchRate.ExchangeAmtFCYToLCY(
            "Posting Date","Currency Code",
            TCSBaseLCY,"Currency Factor"));
      IF NOT "Exclude GST in TCS Base" THEN
        TCSBaseLCY := TCSBaseLCY + ABS(GSTManagement.GetTotalGSTAmountTDSTCS(Rec,TransactionType1::Sales));
    END;

    DateFilterCalc.CreateTCSAccountingDateFilter(AccPeriodFilter,FiscalYear,"Posting Date",0);

    Customer.GET("Party Code");
    IF (Customer."P.A.N. No." = '') AND (Customer."P.A.N. Status" = Customer."P.A.N. Status"::" ") THEN
      ERROR(PANErr,Customer."No.");

    TCSEntry.RESET;
    TCSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TCS Type","Assessee Code","Document Type");
    TCSEntry.SETRANGE("Party Type","Party Type");
    IF Customer."P.A.N. Status" <> Customer."P.A.N. Status"::" " THEN
      TCSEntry.SETRANGE("Party Code","Party Code")
    ELSE
      TCSEntry.SETRANGE("Party P.A.N. No.",Customer."P.A.N. No.");
    TCSEntry.SETFILTER("Posting Date",AccPeriodFilter);
    TCSEntry.SETRANGE("TCS Type","TCS Type");
    TCSEntry.SETRANGE("Assessee Code","Assessee Code");
    TCSEntry.SETFILTER("Document Type",'%1|%2',TCSEntry."Document Type"::Invoice,TCSEntry."Document Type"::Payment);
    TCSEntry.CALCSUMS("Sales Amount","Service Tax Including eCess");
    InvoiceAmount := ABS(TCSEntry."Sales Amount") + ABS(TCSEntry."Service Tax Including eCess");
    PrevInvAmount := InvoiceAmount;

    TCSEntry.SETRANGE("Document Type");
    TCSEntry.CALCSUMS("TCS Amount","Surcharge Amount");

    PrevTCSAmount := ABS(TCSEntry."TCS Amount");
    PrevSurchargeAmount := ABS(TCSEntry."Surcharge Amount");

    TCSEntry.RESET;
    TCSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TCS Type","Assessee Code",Applied);
    TCSEntry.SETRANGE("Party Type","Party Type");
    IF Customer."P.A.N. Status" <> Customer."P.A.N. Status"::" " THEN
      TCSEntry.SETRANGE("Party Code","Party Code")
    ELSE
      TCSEntry.SETRANGE("Party P.A.N. No.",Customer."P.A.N. No.");
    TCSEntry.SETFILTER("Posting Date",AccPeriodFilter);
    TCSEntry.SETRANGE("TCS Type","TCS Type");
    TCSEntry.SETRANGE("Assessee Code","Assessee Code");
    TCSEntry.SETRANGE(Applied,FALSE);
    TCSEntry.SETRANGE("Per Contract",TRUE);
    TCSEntry.CALCSUMS("Sales Amount","Service Tax Including eCess");
    PrevContractAmount := ABS(TCSEntry."Sales Amount") + ABS(TCSEntry."Service Tax Including eCess");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
        TCSBaseLCY :=
          ABS(Amount) + ABS("Service Tax Amount" + "Service Tax eCess Amount" +
            "Service Tax SHE Cess Amount" + "Service Tax SBC Amount" + "KK Cess Amount") +
          ABS(GSTManagement.GetTotalGSTAmountTDSTCS(Rec,TransactionType1::Sales))
      ELSE
        TCSBaseLCY :=
          ABS(Amount) + ABS("Service Tax Amount" + "Service Tax eCess Amount" +
            "Service Tax SHE Cess Amount" + "Service Tax SBC Amount" + "KK Cess Amount");
    #21..34
    #39..41
    TCSEntry.SETRANGE("Party Code","Party Code");
    #46..49
    TCSEntry.CALCSUMS("Invoice Amount","Service Tax Including eCess","Payment Amount","Sales Amount");
    IF NOT TCSSetup."Calc. Over & Above Threshold" THEN
      InvoiceAmount := ABS(TCSEntry."Invoice Amount") + ABS(TCSEntry."Service Tax Including eCess") + ABS(TCSEntry."Payment Amount")
    ELSE
      InvoiceAmount := ABS(TCSEntry."Sales Amount") + ABS(TCSEntry."Service Tax Including eCess");
    #52..62
    TCSEntry.SETRANGE("Party Code","Party Code");
    #67..71
    TCSEntry.CALCSUMS("Invoice Amount","Service Tax Including eCess");
    PrevContractAmount := ABS(TCSEntry."Invoice Amount") + ABS(TCSEntry."Service Tax Including eCess");
    */
    //end;


    //Unsupported feature: Code Modification on "PopulateTCSNonContract(PROCEDURE 1500076)".// FUNCTION N/F

    //procedure PopulateTCSNonContract();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF TCSSetup."Calc. Over & Above Threshold" THEN
      "TDS/TCS Base Amount" := PrevInvAmount + TCSBaseLCY - TCSSetup."TCS Threshold Amount"
    ELSE
      "TDS/TCS Base Amount" := PrevInvAmount + TCSBaseLCY;
    "Surcharge Base Amount" := TCSBaseLCY;
    "Surcharge %" := TCSSetup."Surcharge %";
    "eCESS %" := TCSSetup."eCESS %";
    #8..26
      REPEAT
        InsertTCSBuffer(TCSEntry,"Posting Date","Surcharge %" <> 0,FALSE);
      UNTIL TCSEntry.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF TCSSetup."Calc. Over & Above Threshold" THEN BEGIN
      "TDS/TCS Base Amount" := PrevInvAmount + TCSBaseLCY - TCSSetup."TCS Threshold Amount";
      "Sales Amount" := PrevInvAmount + TCSBaseLCY;
    END ELSE BEGIN
      "TDS/TCS Base Amount" := PrevInvAmount + TCSBaseLCY;
      "Sales Amount" := "TDS/TCS Base Amount";
    END;
    #5..29
    */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: PrevTCSAmount) (ParameterCollection) on "PopulateTCSonPartyCustAppliesToDoc(PROCEDURE 1500075)".


    //Unsupported feature: Variable Insertion (Variable: AppliedAmountDoc) (VariableCollection) on "PopulateTCSonPartyCustAppliesToDoc(PROCEDURE 1500075)".

    //Unsupported feature: Code Modification on "PopulateTCSonPartyCustAppliesToDoc(PROCEDURE 1500075)".// FUNCTION N/F

    //procedure PopulateTCSonPartyCustAppliesToDoc();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Applies-to Doc. No." <> '' THEN BEGIN
      CustLedgEntry.RESET;
      CustLedgEntry.SETCURRENTKEY("Customer No.","Document No.",Open);
      IF "Account Type" = "Account Type"::Customer THEN
        CustLedgEntry.SETRANGE("Customer No.","Account No.")
      ELSE
        CustLedgEntry.SETRANGE("Customer No.","Bal. Account No.");
      CustLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
      CustLedgEntry.SETRANGE(Open,TRUE);
      IF "Document Type" = "Document Type"::Invoice THEN
        CustLedgEntry.SETRANGE("TCS Nature of Collection","TCS Nature of Collection");
      IF CustLedgEntry.FINDSET THEN BEGIN
        REPEAT
          AppliedAmountDoc += CalcCustAppliedAmountLCY(CustLedgEntry);
        UNTIL CustLedgEntry.NEXT = 0;
        IF TCSBaseLCY >= ABS(AppliedAmountDoc) THEN BEGIN
          IF NodNocLines."Threshold Overlook" THEN BEGIN
            "TDS/TCS Base Amount" := TCSBaseLCY - ABS(AppliedAmountDoc);
            IF NOCLine."Surcharge Overlook" THEN
              "Surcharge Base Amount" := ABS("TDS/TCS Base Amount")
            ELSE
              IF PrevInvAmount > TCSSetup."Surcharge Threshold Amount" THEN
                "Surcharge Base Amount" := ABS("TDS/TCS Base Amount")
              ELSE
                "Surcharge Base Amount" := ABS("TDS/TCS Base Amount");
          END ELSE
            IF (PrevInvAmount > TCSSetup."TCS Threshold Amount") AND (TCSSetup."Contract Amount" = 0)THEN BEGIN
              "TDS/TCS Base Amount" := TCSBaseLCY - ABS(AppliedAmountDoc);
              IF PrevInvAmount + TCSBaseLCY - ABS(AppliedAmountDoc) < TCSSetup."TCS Threshold Amount" THEN
                "TDS/TCS %" := 0;
              IF NOCLine."Surcharge Overlook" THEN
                "Surcharge Base Amount" := ABS("TDS/TCS Base Amount")
              ELSE
                IF PrevInvAmount > TCSSetup."Surcharge Threshold Amount" THEN
                  "Surcharge Base Amount" := ABS("TDS/TCS Base Amount")
                ELSE
                  "Surcharge Base Amount" := ABS("TDS/TCS Base Amount");
            END ELSE
              IF TCSSetup."Contract Amount" <> 0 THEN BEGIN
                IF (PrevInvAmount + TCSBaseLCY - ABS(AppliedAmountDoc)) > TCSSetup."TCS Threshold Amount" THEN BEGIN
                  IF TCSSetup."Calc. Over & Above Threshold" THEN
                    "TDS/TCS Base Amount" := (PrevInvAmount + TCSBaseLCY) - PrevContractAmount - ABS(AppliedAmountDoc) -
                      TCSSetup."TCS Threshold Amount"
                  ELSE
                    "TDS/TCS Base Amount" := (PrevInvAmount + TCSBaseLCY) - PrevContractAmount - ABS(AppliedAmountDoc);
                END ELSE
                  IF (TCSBaseLCY - ABS(AppliedAmountDoc)) > TCSSetup."Contract Amount" THEN BEGIN
                    "Per Contract" := TRUE;
                    "TDS/TCS Base Amount" := TCSBaseLCY - ABS(AppliedAmountDoc);
                  END ELSE BEGIN
                    "TDS/TCS Base Amount" := TCSBaseLCY - ABS(AppliedAmountDoc);
                    "TDS/TCS %" := 0;
                  END;

                IF PrevSurchargeAmount = 0 THEN
                  "Surcharge Base Amount" := PrevInvAmount + TCSBaseLCY -
                    ABS(AppliedAmountDoc)
                ELSE
                  IF PrevContractAmount <> 0 THEN
                    "Surcharge Base Amount" := TCSBaseLCY -
                      ABS(AppliedAmountDoc) +
                      (PrevInvAmount - PrevContractAmount)
                  ELSE
                    "Surcharge Base Amount" := TCSBaseLCY -
                      ABS(AppliedAmountDoc);
              END ELSE BEGIN
                IF (PrevInvAmount + TCSBaseLCY - ABS(AppliedAmountDoc)) > TCSSetup."TCS Threshold Amount" THEN BEGIN
                  IF TCSSetup."Calc. Over & Above Threshold" THEN
                    "TDS/TCS Base Amount" := PrevInvAmount + TCSBaseLCY - ABS(AppliedAmountDoc) - TCSSetup."TCS Threshold Amount"
                  ELSE
                    "TDS/TCS Base Amount" := PrevInvAmount + TCSBaseLCY - ABS(AppliedAmountDoc);
                END ELSE BEGIN
                  "TDS/TCS Base Amount" := TCSBaseLCY - ABS(AppliedAmountDoc);
                  "TDS/TCS %" := 0;
                END;
                IF PrevSurchargeAmount = 0 THEN
                  "Surcharge Base Amount" := PrevInvAmount + TCSBaseLCY -
                    ABS(AppliedAmountDoc)
                ELSE
                  "Surcharge Base Amount" := TCSBaseLCY -
                    ABS(AppliedAmountDoc);
              END;
          "Temp TDS/TCS Base" :=
            TCSBaseLCY - ABS(AppliedAmountDoc);
        END ELSE BEGIN
          "TDS/TCS Base Amount" := 0;
          "Surcharge Base Amount" := 0;
          "Temp TDS/TCS Base" := 0;
          "TDS/TCS %" := 0;
        END;
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..16
          IF TCSSetup."Contract Amount" <> 0 THEN BEGIN
            IF PrevTCSAmount = 0 THEN
              "TDS/TCS Base Amount" := PrevInvAmount + TCSBaseLCY -
                ABS(AppliedAmountDoc)
            ELSE
              IF PrevContractAmount <> 0 THEN
                "TDS/TCS Base Amount" := TCSBaseLCY -
                  ABS(AppliedAmountDoc) +
                  (PrevInvAmount - PrevContractAmount)
              ELSE
                "TDS/TCS Base Amount" := TCSBaseLCY -
                  ABS(AppliedAmountDoc);

            IF PrevSurchargeAmount = 0 THEN
              "Surcharge Base Amount" := PrevInvAmount + TCSBaseLCY -
                ABS(AppliedAmountDoc)
            ELSE
              IF PrevContractAmount <> 0 THEN
                "Surcharge Base Amount" := TCSBaseLCY -
                  ABS(AppliedAmountDoc) +
                  (PrevInvAmount - PrevContractAmount)
              ELSE
                "Surcharge Base Amount" := TCSBaseLCY -
                  ABS(AppliedAmountDoc);
          END ELSE BEGIN
            IF PrevTCSAmount = 0 THEN
              "TDS/TCS Base Amount" := PrevInvAmount + TCSBaseLCY -
                ABS(AppliedAmountDoc)
            ELSE
              "TDS/TCS Base Amount" := TCSBaseLCY - ABS(AppliedAmountDoc);
            IF PrevSurchargeAmount = 0 THEN
              "Surcharge Base Amount" := PrevInvAmount + TCSBaseLCY -
                ABS(AppliedAmountDoc)
            ELSE
              "Surcharge Base Amount" := TCSBaseLCY -
                ABS(AppliedAmountDoc);
          END;
    #83..92
    */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: PrevTCSAmount) (ParameterCollection) on "PopulateTCSonPartyCustAppliesToID(PROCEDURE 1500074)".



    //Unsupported feature: Code Modification on "PopulateTCSonPartyCustAppliesToID(PROCEDURE 1500074)".// FUNCTION N/F

    //procedure PopulateTCSonPartyCustAppliesToID();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Applies-to ID" <> '' THEN BEGIN
      CheckSameTCSPayment;
      CheckSameTCS;
      IF "GST Group Code" <> '' THEN
        GSTApplicationManagement.CheckSalesJournalOnlineValidation(Rec);
      CustLedgEntry.RESET;
      CustLedgEntry.SETRANGE("Applies-to ID","Applies-to ID");
      IF CustLedgEntry.FIND('-') THEN BEGIN
        REPEAT
          IF IsTCSEntryWithNOD(CustLedgEntry) THEN
            AppliedAmount += CalcCustAppliedAmountLCY(CustLedgEntry);
        UNTIL CustLedgEntry.NEXT = 0;
        IF ABS(Amount) >= AppliedAmount THEN BEGIN
          IF NodNocLines."Threshold Overlook" THEN BEGIN
            "TDS/TCS Base Amount" := TCSBaseLCY - ABS(AppliedAmount);
            IF NOCLine."Surcharge Overlook" THEN
              "Surcharge Base Amount" := ABS("TDS/TCS Base Amount")
            ELSE
              IF PrevInvAmount > TCSSetup."Surcharge Threshold Amount" THEN
                "Surcharge Base Amount" := ABS("TDS/TCS Base Amount")
              ELSE
                "Surcharge Base Amount" := ABS("TDS/TCS Base Amount");
          END ELSE
            IF (PrevInvAmount > TCSSetup."TCS Threshold Amount") AND (TCSSetup."Contract Amount" = 0) THEN BEGIN
              "TDS/TCS Base Amount" := TCSBaseLCY - ABS(AppliedAmount);
              IF PrevInvAmount + TCSBaseLCY - ABS(AppliedAmount) < TCSSetup."TCS Threshold Amount" THEN
                "TDS/TCS %" := 0;
              IF NOCLine."Surcharge Overlook" THEN
                "Surcharge Base Amount" := ABS("TDS/TCS Base Amount")
              ELSE
                IF PrevInvAmount > TCSSetup."Surcharge Threshold Amount" THEN
                  "Surcharge Base Amount" := ABS("TDS/TCS Base Amount")
                ELSE
                  "Surcharge Base Amount" := ABS("TDS/TCS Base Amount");
            END ELSE
              IF TCSSetup."Contract Amount" <> 0 THEN BEGIN
                IF (PrevInvAmount + TCSBaseLCY - ABS(AppliedAmount)) > TCSSetup."TCS Threshold Amount" THEN BEGIN
                  IF TCSSetup."Calc. Over & Above Threshold" THEN
                    "TDS/TCS Base Amount" := (PrevInvAmount + TCSBaseLCY) - PrevContractAmount - ABS(AppliedAmount) -
                      TCSSetup."TCS Threshold Amount"
                  ELSE
                    "TDS/TCS Base Amount" := (PrevInvAmount + TCSBaseLCY) - PrevContractAmount - ABS(AppliedAmount);
                END ELSE
                  IF (TCSBaseLCY - ABS(AppliedAmount)) > TCSSetup."Contract Amount" THEN BEGIN
                    "Per Contract" := TRUE;
                    "TDS/TCS Base Amount" := TCSBaseLCY - ABS(AppliedAmount);
                  END ELSE BEGIN
                    "TDS/TCS Base Amount" := TCSBaseLCY - ABS(AppliedAmount);
                    "TDS/TCS %" := 0;
                  END;
                IF PrevSurchargeAmount = 0 THEN
                  "Surcharge Base Amount" := PrevInvAmount + TCSBaseLCY - AppliedAmount
                ELSE
                  IF PrevContractAmount <> 0 THEN
                    "Surcharge Base Amount" := TCSBaseLCY - AppliedAmount + (PrevInvAmount - PrevContractAmount)
                  ELSE
                    "Surcharge Base Amount" := TCSBaseLCY - AppliedAmount;
              END ELSE BEGIN
                IF (PrevInvAmount + TCSBaseLCY - ABS(AppliedAmount)) > TCSSetup."TCS Threshold Amount" THEN BEGIN
                  IF TCSSetup."Calc. Over & Above Threshold" THEN
                    "TDS/TCS Base Amount" := PrevInvAmount + TCSBaseLCY - ABS(AppliedAmount) - TCSSetup."TCS Threshold Amount"
                  ELSE
                    "TDS/TCS Base Amount" := PrevInvAmount + TCSBaseLCY - ABS(AppliedAmount);
                END ELSE BEGIN
                  "TDS/TCS Base Amount" := TCSBaseLCY - ABS(AppliedAmount);
                  "TDS/TCS %" := 0;
                END;
                IF PrevSurchargeAmount = 0 THEN
                  "Surcharge Base Amount" := PrevInvAmount + TCSBaseLCY - AppliedAmount
                ELSE
                  "Surcharge Base Amount" := TCSBaseLCY - AppliedAmount;
              END;
          "Temp TDS/TCS Base" := TCSBaseLCY - AppliedAmount;
        END ELSE BEGIN
          "TDS/TCS Base Amount" := 0;
          "Surcharge Base Amount" := 0;
          "Temp TDS/TCS Base" := 0;
          "TDS/TCS %" := 0;
        END;
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..13
          IF TCSSetup."Contract Amount" <> 0 THEN BEGIN
            IF PrevTCSAmount = 0 THEN
              "TDS/TCS Base Amount" := PrevInvAmount + TCSBaseLCY - AppliedAmount
            ELSE
              IF PrevContractAmount <> 0 THEN
                "TDS/TCS Base Amount" := TCSBaseLCY - AppliedAmount + (PrevInvAmount - PrevContractAmount)
              ELSE
                "TDS/TCS Base Amount" := TCSBaseLCY - AppliedAmount;
            IF PrevSurchargeAmount = 0 THEN
              "Surcharge Base Amount" := PrevInvAmount + TCSBaseLCY - AppliedAmount
            ELSE
              IF PrevContractAmount <> 0 THEN
                "Surcharge Base Amount" := TCSBaseLCY - AppliedAmount + (PrevInvAmount - PrevContractAmount)
              ELSE
                "Surcharge Base Amount" := TCSBaseLCY - AppliedAmount;
          END ELSE BEGIN
            IF PrevTCSAmount = 0 THEN
              "TDS/TCS Base Amount" := PrevInvAmount + TCSBaseLCY - AppliedAmount
            ELSE
              "TDS/TCS Base Amount" := TCSBaseLCY - AppliedAmount ;
            IF PrevSurchargeAmount = 0 THEN
              "Surcharge Base Amount" := PrevInvAmount + TCSBaseLCY - AppliedAmount
            ELSE
              "Surcharge Base Amount" := TCSBaseLCY - AppliedAmount;
          END;
    #73..81
    */
    //end;


    //Unsupported feature: Code Modification on "PopulateTCSBaseGreaterThresholdApplied(PROCEDURE 1500069)".// FUNCTION N/F

    //procedure PopulateTCSBaseGreaterThresholdApplied();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TCSBaseLCY := "TDS/TCS Base Amount";
    "Surcharge %" := TCSSetup."Surcharge %";
    "eCESS %" := TCSSetup."eCESS %";
    "SHE Cess % on TDS/TCS" := TCSSetup."SHE Cess %";
    #5..15
          "Surcharge %" := 0;
          "Surcharge Amount" := 0;
        END;
    InsertGenTCSBuffer(FALSE);
    TCSEntry.RESET;
    TCSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TCS Type","Assessee Code",Applied);
    TCSEntry.SETRANGE("Party Type","Party Type");
    #23..26
    TCSEntry.SETRANGE(Applied,FALSE);
    IF TCSEntry.FIND('-') THEN
      REPEAT
        InsertTCSBuffer(TCSEntry,"Posting Date","Surcharge %" <> 0,FALSE);
      UNTIL TCSEntry.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #2..18
    InsertGenTCSBuffer(TRUE);
    #20..29
        InsertTCSBuffer(TCSEntry,"Posting Date","Surcharge %" <> 0,TRUE);
      UNTIL TCSEntry.NEXT = 0;
    */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: SurchargeBaseAmount) (ParameterCollection) on "PopulateTCSAmountNotZero(PROCEDURE 1500068)".


    //Unsupported feature: Parameter Insertion (Parameter: SurchargeAmount) (ParameterCollection) on "PopulateTCSAmountNotZero(PROCEDURE 1500068)".



    //Unsupported feature: Code Modification on "PopulateTCSAmountNotZero(PROCEDURE 1500068)".// FUNCTION N/F

    //procedure PopulateTCSAmountNotZero();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Amount < 0 THEN BEGIN
      "TDS/TCS Base Amount" := -"TDS/TCS Base Amount";
      "Surcharge Base Amount" := -"Surcharge Base Amount";
    #4..7
      REPEAT
        TCSAmount += ((TCSBuffer[1]."TCS Base Amount" - TCSBuffer[1]."Contract TCS Ded. Base Amount") *
                      TCSBuffer[1]."TCS %" / 100);
      UNTIL TCSBuffer[1].NEXT(-1) = 0;

      IF Amount < 0 THEN
        "TDS/TCS Amount" := -RoundTCSAmount(TCSAmount)
      ELSE
        "TDS/TCS Amount" := RoundTCSAmount(TCSAmount);

      IF "TDS/TCS Base Amount" <> 0 THEN
        "TDS/TCS %" := ABS(ROUND(TCSAmount * 100 / "TDS/TCS Base Amount",0.001));
    END ELSE
      "TDS/TCS Amount" := RoundTCSAmount("TDS/TCS %" * "TDS/TCS Base Amount" / 100);

    IF ("Document Type" = "Document Type"::Payment) AND ("Applies-to Doc. No." = '') AND
       ("Applies-to ID" = '') AND ("TCS on Recpt. Of Pmt. Amount" = 0)
    THEN
      TCSGrossingup("TDS/TCS Base Amount","Surcharge Base Amount",
        "TDS/TCS %","Surcharge %","eCESS %","TDS/TCS Amount","Surcharge Amount","eCESS on TDS/TCS Amount",
        "SHE Cess % on TDS/TCS","SHE Cess on TDS/TCS Amount");

    "eCESS on TDS/TCS Amount" := RoundTCSAmount("TDS/TCS Amount" * "eCESS %" / 100);
    "SHE Cess on TDS/TCS Amount" := RoundTCSAmount("TDS/TCS Amount" * "SHE Cess % on TDS/TCS" / 100);
    "Surcharge Amount" :=
      RoundTCSAmount(("TDS/TCS Amount" + "eCESS on TDS/TCS Amount" + "SHE Cess on TDS/TCS Amount") * "Surcharge %" / 100);
    "TDS/TCS Amt Incl Surcharge" := "TDS/TCS Amount" + "Surcharge Amount";
    "Total TDS/TCS Incl. SHE CESS" := "TDS/TCS Amount" + "Surcharge Amount" + "eCESS on TDS/TCS Amount" +
      "SHE Cess on TDS/TCS Amount";

    IF "Currency Code" <> '' THEN BEGIN
      "TDS/TCS Base Amount" := ExchangeAmtLCYToFCY("TDS/TCS Base Amount",TRUE);
      "Surcharge Base Amount" := ExchangeAmtLCYToFCY("Surcharge Base Amount",TRUE);
      "Sales Amount" := ExchangeAmtLCYToFCY("Sales Amount",TRUE);
      "TDS/TCS Amount" := ExchangeAmtLCYToFCY("TDS/TCS Amount",TRUE);
      "Surcharge Amount" := ExchangeAmtLCYToFCY("Surcharge Amount",TRUE);
      "TDS/TCS Amt Incl Surcharge" := ExchangeAmtLCYToFCY("TDS/TCS Amt Incl Surcharge",TRUE);
    #45..47
      "Bal. TDS/TCS Including SHECESS" := "Total TDS/TCS Incl. SHE CESS";
      "Balance Surcharge Amount" := "Surcharge Amount";
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
        SurchargeBaseAmount += (TCSBuffer[1]."TCS %" *
                                (TCSBuffer[1]."Surcharge Base Amount" - TCSBuffer[1]."Contract TCS Ded. Base Amount") / 100);
        SurchargeAmount +=
          (TCSBuffer[1]."TCS %" *
           (TCSBuffer[1]."Surcharge Base Amount" - TCSBuffer[1]."Contract TCS Ded. Base Amount") / 100) *
          (TCSBuffer[1]."Surcharge %" / 100);
      UNTIL TCSBuffer[1].NEXT(-1) = 0;

      IF Amount < 0 THEN BEGIN
        "TDS/TCS Amount" := -RoundTCSAmount(TCSAmount);
        "Surcharge Amount" := -RoundTCSAmount(SurchargeAmount);
      END ELSE BEGIN
        "TDS/TCS Amount" := RoundTCSAmount(TCSAmount);
        "Surcharge Amount" := RoundTCSAmount(SurchargeAmount);
      END;
    #17..19
      IF SurchargeBaseAmount <> 0 THEN
        "Surcharge %" := ABS(ROUND(SurchargeAmount * 100 / SurchargeBaseAmount));
    END ELSE BEGIN
      "TDS/TCS Amount" := RoundTCSAmount("TDS/TCS %" * "TDS/TCS Base Amount" / 100);
      "Surcharge Amount" := RoundTCSAmount(("TDS/TCS %" * "Surcharge Base Amount" / 100) * ("Surcharge %" / 100));
    END;

    IF ("Document Type" = "Document Type"::Payment) AND ("Applies-to Doc. No." = '') AND
       ("Applies-to ID" = '')
    #25..29
    "TDS/TCS Amt Incl Surcharge" := "TDS/TCS Amount" + "Surcharge Amount";
    "eCESS on TDS/TCS Amount" := RoundTCSAmount("TDS/TCS Amt Incl Surcharge" * "eCESS %" / 100);
    "SHE Cess on TDS/TCS Amount" := RoundTCSAmount("TDS/TCS Amt Incl Surcharge" * "SHE Cess % on TDS/TCS" / 100);
    #35..38
    #42..50
    */
    //end;


    //Unsupported feature: Code Modification on "CalculateTDSBaseLCYOnAmtExclGST(PROCEDURE 1500081)".// FUNCTION N/F

    //procedure CalculateTDSBaseLCYOnAmtExclGST();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Document Type" = "Document Type"::Payment) AND NOT "GST on Advance Payment" THEN BEGIN
      IF "Currency Code" = '' THEN BEGIN
        IF TryGetSrvTaxReverseChargeSetup(SrvTaxReverseChrgSetup) AND NOT
    #4..46
                ROUND(
                  CurrExchRate.ExchangeAmtFCYToLCY("Posting Date","Currency Code",ABS("Amount Excl. GST"),"Currency Factor"));
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Manual TDS" AND ("Manual TDS Base Amount"<>0) THEN BEGIN//MSKS
      TDSBaseLCY := "Manual TDS Base Amount";
      EXIT;
    END;

    #1..49
    */
    //end;
    var
        GenJnlTemplate1: Record "Gen. Journal Template";
        NoSeries: Record "No. Series";
        UserAccess: Integer;
        Permissions: Codeunit Permissions1;
        UserLocation: Record "User Location";
        //  JournalLineDimension: Record "Journal Line Dimension";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Location1: Record Location;
        DefaultDim: Record "Default Dimension";
        GenJournalLineRec: Record "Gen. Journal Line";
        GenJnalLineRec: Record "Gen. Journal Line";
        RecParty: Record Party;
        JnlBankCharges: Record "Journal Bank Charges";
        TDSBaseAmt: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        BlnCeiling: Boolean;
        TCSThrldErr: Label 'Advance Payment with TCS Calculation on Over & Above Threshold Amount is not allowed.';
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlBatch: Record "Gen. Journal Batch";
}

