tableextension 50221 tableextension50221 extends "Transfer Line"
{
    fields
    {
        modify("Item No.")
        {
            TableRelation = Item;
            trigger OnAfterValidate()
            var
                //Item: Record Item;
                MRP: Boolean;
            begin
                TransHeader.TESTFIELD(TransHeader."Locked Order", FALSE);
                TransHeader.TESTFIELD("Group Code", Item."Group Code");//MSBS.Rao 290914

                "External Transfer" := TransHeader."External Transfer";   //TRI DG 010510
                IF (UPPERCASE(USERID) <> 'SUMIT') THEN
                    Item.TESTFIELD(Blocked, FALSE);

                IF UPPERCASE(USERID) <> 'SUMIT' THEN  //Kulbhushan
                    Item.TESTFIELD("Transfer Order Blocked", FALSE);  //TRI

                IF Item."Default Transaction UOM" <> '' THEN  //TRI V.D 30.06.10 ADD
                    VALIDATE("Unit of Measure Code", Item."Default Transaction UOM")
                //TRI V.D 30.06.10 START
                ELSE
                    VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");

                //Vipul Tri1.0 Start
                VALIDATE("Plant Code", Item."Plant Code");
                VALIDATE("Type Code", Item."Type Code");
                VALIDATE("Type Catogery Code", Item."Type Catogery Code");          // TRI NM 160308
                VALIDATE("Size Code", Item."Size Code");
                VALIDATE("Color Code", Item."Color Code");
                VALIDATE("Design Code", Item."Design Code");
                VALIDATE("Packing Code", Item."Packing Code");
                VALIDATE("Quality Code", Item."Quality Code");
                //Vipul Tri1.0 End

                //TRIRJ-MC
                //ND Tri Start Cust 29
                IF TransHeader.GET("Document No.") THEN BEGIN
                    TransHeader.TESTFIELD(TransHeader."Posting Date");
                    IF TransHeader."External Transfer" THEN
                        "End Use Item" := FALSE ELSE
                        "End Use Item" := Item."End Use Item";

                    SalesPrice.RESET;
                    SalesPrice.SETFILTER(SalesPrice."Item No.", "Item No.");
                    SalesPrice.SETFILTER(SalesPrice."Sales Type", '%1', SalesPrice."Sales Type"::"Customer Price Group");
                    SalesPrice.SETFILTER(SalesPrice."Sales Code", '%1', TransHeader."Customer Price Group");
                    SalesPrice.SETFILTER(SalesPrice."Starting Date", '..%1', TransHeader."Posting Date");
                    SalesPrice.SETFILTER(SalesPrice."Ending Date", '%1|%2..', 0D, TransHeader."Posting Date");
                    SalesPrice.SETRANGE("Variant Code", "Variant Code");
                    SalesPrice.SETFILTER(SalesPrice."Unit of Measure Code", "Unit of Measure Code");
                    IF SalesPrice.FIND('+') THEN BEGIN
                        // 15578  VALIDATE("MRP Price", ROUND(SalesPrice."MRP Price", 1));
                        MRP := TRUE;

                        "Unit Price" := ROUND(SalesPrice."Unit Price", 0.01);
                        VALIDATE("Transfer Price", "Unit Price");
                    END ELSE BEGIN
                        //VALIDATE("Price Type");
                        //IF AverageCostLCY=0 THEN
                        //VALIDATE("Unit Cost",Item."Unit Cost");  code blocked for upgradation
                        MRP := FALSE;
                        //ELSE
                        //    VALIDATE("Unit Cost",AverageCostLCY);
                    END;
                END;


                IF "Item No." <> '' THEN    //kULBHUSHAN
                    "Creation Date" := TODAY;
                VALIDATE("Unit of Measure Code");
            end;
        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                //ND START
                IF TransHeader.GET("Document No.") THEN
                    TransHeader.TESTFIELD(TransHeader."Locked Order", FALSE);
                //ND END
                //ND start cust 11
                Item.GET("Item No.");
                "Gross Weight" := ROUND(Item."Gross Weight" * "Qty. per Unit of Measure" * Quantity, 0.001, '=');

                "Net Weight" := ROUND(Item."Net Weight" * "Qty. per Unit of Measure" * Quantity, 0.001, '=');

                //ND end cust 11
                "Qty in Sq. Mt." := Item.UomToSqm("Item No.", "Unit of Measure Code", Quantity);   //BLOCK
                                                                                                   //"Qty in Sq. Mt." :="Quantity (Base)";//SHAKTI
                "Qty in Carton." := Item.UomToCart("Item No.", "Unit of Measure Code", Quantity);
                // 15578  MRP := ISMRP; //MSKS03072017
            end;
        }

        modify("Unit of Measure")
        {
            trigger OnAfterValidate()
            begin
                //ND START
                IF TransHeader.GET("Document No.") THEN
                    TransHeader.TESTFIELD(TransHeader."Locked Order", FALSE);
                //ND END

            end;
        }
        modify("Qty. to Ship")// 15578
        {
            trigger OnAfterValidate()
            begin
                IF "Item Category Code" IN ['D001', 'H001', 'T001', 'M001'] THEN BEGIN
                    EXIT;
                END ELSE BEGIN
                    IF Item."End Use Item" THEN BEGIN
                        TransLine.RESET;
                        TransLine.SETFILTER("Document No.", '<>%1', "Document No.");
                        TransLine.SETRANGE("Item No.", "Item No.");
                        TransLine.SETFILTER("Qty. to Ship", '<>%1', 0);
                        TransLine.SETFILTER("Qty. to Receive", '%1', 0);
                        TransLine.SETRANGE("Transfer-to Code", "Transfer-to Code");
                        IF TransLine.FINDFIRST THEN
                            ERROR('Issue Slip No. %1 Pending for Receive, Please Recieve That First', TransLine."Document No.");
                    END;
                END;

            end;

        }
        modify("Quantity Shipped")
        {
            trigger OnAfterValidate()
            begin
                IF "Quantity Shipped" <> 0 THEN
                    "Ship Date" := TODAY;

            end;
        }
        modify("Unit of Measure Code")
        {
            trigger OnAfterValidate()
            var
                MRP: Boolean;
            begin
                //TRIRJ
                //ND Tri Start Cust 29
                IF TransHeader.GET("Document No.") THEN BEGIN
                    SalesPrice.RESET;
                    SalesPrice.SETFILTER(SalesPrice."Item No.", "Item No.");
                    SalesPrice.SETFILTER(SalesPrice."Sales Type", '%1', SalesPrice."Sales Type"::"Customer Price Group");
                    SalesPrice.SETFILTER(SalesPrice."Sales Code", '%1', TransHeader."Customer Price Group");
                    SalesPrice.SETFILTER(SalesPrice."Starting Date", '..%1', TransHeader."Posting Date");
                    SalesPrice.SETFILTER(SalesPrice."Ending Date", '%1|%2..', 0D, TransHeader."Posting Date");
                    SalesPrice.SETRANGE("Variant Code", "Variant Code");
                    SalesPrice.SETFILTER(SalesPrice."Unit of Measure Code", "Unit of Measure Code");
                    IF SalesPrice.FIND('+') THEN BEGIN
                        // 15578  VALIDATE("MRP Price", ROUND(SalesPrice."MRP Price", 1));
                        MRP := TRUE;
                        "Unit Price" := ROUND(SalesPrice."Unit Price", 0.01);
                        VALIDATE("Transfer Price", "Unit Price");
                    END ELSE BEGIN
                        VALIDATE("Price Type");
                        VALIDATE("Unit Price", 0);
                        MRP := FALSE;
                        VALIDATE("Transfer Price", "Unit Price");
                    END;
                END;
                //ND Tri End Cust 29

            end;
        }
        modify("Transfer-from Code")
        {
            trigger OnAfterValidate()
            begin
                //ND START
                IF TransHeader.GET("Document No.") THEN
                    TransHeader.TESTFIELD(TransHeader."Locked Order", FALSE);
                //ND END

                //vipul Tri1.0 Start
                IF TransferHeader.GET("Document No.") THEN
                    IF NOT Location.GetLocationFilter(TransferHeader."Transfer-from Code", "Transfer-from Code") THEN
                        ERROR('Please select %1 location or its sub locations.', TransferHeader."Transfer-from Code");
                //vipul Tri1.0 end
                //ND Tri1.0 Start
                IF Location.GET("Transfer-from Code") THEN
                    "From Main Location" := Location."Main Location";
                //ND Tri1.0 End
            end;
        }

        field(50002; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(50003; "From Main Location"; Code[10])
        {
        }
        field(50004; "To Main Location"; Code[10])
        {
        }
        field(50005; "Plant Code"; Code[1])
        {
            Editable = false;

            trigger OnLookup()
            begin
                /*
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code",InventorySetup."Plant Code");
                IF PAGE.RUNMODAL(560,DimensionValue) = ACTION::LookupOK THEN
                  VALIDATE("Plant Code",DimensionValue.Code);
                */

            end;
        }
        field(50006; "Type Code"; Code[2])
        {
            Editable = false;

            trigger OnLookup()
            begin
                /*
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code",InventorySetup."Type Code");
                IF PAGE.RUNMODAL(560,DimensionValue) = ACTION::LookupOK THEN
                  VALIDATE("Type Code",DimensionValue.Code);
                */

            end;
        }
        field(50007; "Size Code"; Code[3])
        {

            trigger OnLookup()
            begin
                /*
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code",InventorySetup."Size Code");
                IF FORM.RUNMODAL(560,DimensionValue) = ACTION::LookupOK THEN
                  VALIDATE("Size Code",DimensionValue.Code);
                */

            end;
        }
        field(50008; "Color Code"; Code[4])
        {
            Editable = false;

            trigger OnLookup()
            begin
                /*
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code",InventorySetup."Color Code");
                IF FORM.RUNMODAL(560,DimensionValue) = ACTION::LookupOK THEN
                  VALIDATE("Color Code",DimensionValue.Code);
                 */

            end;
        }
        field(50009; "Design Code"; Code[4])
        {
            Editable = false;

            trigger OnLookup()
            begin
                /*
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code",InventorySetup."Design Code");
                IF FORM.RUNMODAL(560,DimensionValue) = ACTION::LookupOK THEN
                  VALIDATE("Design Code",DimensionValue.Code);
                */

            end;
        }
        field(50010; "Packing Code"; Code[2])
        {
            Editable = false;

            trigger OnLookup()
            begin
                /*
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code",InventorySetup."Packing Code");
                IF FORM.RUNMODAL(560,DimensionValue) = ACTION::LookupOK THEN
                  VALIDATE("Packing Code",DimensionValue.Code);
                */

            end;
        }
        field(50011; "Quality Code"; Code[1])
        {

            trigger OnLookup()
            begin
                /*
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code",InventorySetup."Quality Code");
                IF FORM.RUNMODAL(560,DimensionValue) = ACTION::LookupOK THEN
                  VALIDATE("Quality Code",DimensionValue.Code);
                */

            end;
        }
        field(50012; "Qty in Sq. Mt."; Decimal)
        {
            Editable = true;
        }
        field(50013; "Qty in Carton."; Decimal)
        {
            Editable = false;
        }
        field(50014; "External Transfer"; Boolean)
        {
        }
        field(50016; "Transfer-to State"; Code[20])
        {
            CalcFormula = Lookup("Transfer Header"."Transfer-to State" WHERE("No." = FIELD("Document No.")));
            Description = 'mo';
            FieldClass = FlowField;
            TableRelation = State.Code;
        }
        field(50022; "Group Code"; Code[2])
        {
        }
        field(50023; "Type Catogery Code"; Code[2])
        {
            Description = 'TRI NM 160308';
        }
        field(50025; "Unit Price"; Decimal)
        {
            Description = 'TRI SC';

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                //TRI SC
                IF NOT "External Transfer" THEN BEGIN
                    IF Item.GET("Item No.") THEN BEGIN
                        IF "Price Type" = "Price Type"::"At Cost" THEN
                            "Unit Price" := Item."Unit Cost";
                    END;
                END;
                //TRI SC
            end;
        }
        field(50026; "Price Type"; Option)
        {
            Description = 'TRI SC';
            OptionMembers = "At Cost","At Price";
        }
        field(50027; "Short Quantity"; Decimal)
        {
        }
        field(50028; "Reason Code"; Code[10])
        {
            TableRelation = "Reason Code".Code;
        }
        field(50029; ReProcess; Boolean)
        {
            Description = 'TRI S.C. 09.06.10';
        }
        field(50030; "Shoratge Transfer Rcpt No."; Code[20])
        {
            Description = 'TRI VKG 23.09.10';

            trigger OnLookup()
            var
                TransRcptLine: Record "Transfer Receipt Line";
            // GetShortage: Page 50107;
            begin
            end;

            trigger OnValidate()
            var
                TransferLine: Record "Transfer Line";
                NextLineNo: Integer;
                TransReceLine2: Record "Transfer Receipt Line";
            begin
            end;
        }
        field(50031; "Customer Price Group"; Code[20])
        {
            Description = 'TRI VKG 23.09.10';
            TableRelation = "Customer Price Group".Code;
        }
        field(50032; "Structure Calculated"; Boolean)
        {
        }
        field(50033; Remarks; Text[150])
        {
        }
        field(50034; "Customer Code"; Code[20])
        {
            TableRelation = Customer;
        }
        field(50035; "Requested by"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(60040; "End Use Item"; Boolean)
        {
        }
        field(60041; "Issue to Machine"; Code[40])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('MACHINE'));
            ValidateTableRelation = false;
        }
        field(60042; "Shelf No."; Code[20])
        {
        }
        field(60043; Inventory; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  "Location Code" = FIELD("Transfer-from Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60044; "Capex No."; Code[20])
        {
            Description = 'Kulbhushan';
            TableRelation = "Budget Master"."No." WHERE(Status = CONST(Released),
                                                       "Location Code" = FIELD("Transfer-from Code"));
        }
        field(60045; "Creation Date"; Date)
        {
        }
        field(60046; "Ship Date"; Date)
        {
        }
        field(70000; "Mfg. Batch No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
    }
    keys
    {

        //Unsupported feature: Property Insertion (SumIndexFields) on ""Document No.,Line No."(Key)".

        key(Key7; "Document No.", "Derived From Line No.")
        {
            // SumIndexFields = Quantity, "Qty in Sq. Mt.", "Qty in Carton.", "Gross Weight", "Qty. to Ship", "Amount Including Excise";
        }
        key(Key8; "Plant Code")
        {
        }
    }
    trigger OnAfterDelete()
    begin
        //ND STAR
        IF TransHeader.GET("Document No.") THEN
            TransHeader.TESTFIELD(TransHeader."Locked Order", FALSE);
        //ND END
        IF UPPERCASE(USERID) <> 'ADMIN' THEN BEGIN
            TESTFIELD("Quantity Shipped", "Quantity Received");
            TESTFIELD("Qty. Shipped (Base)", "Qty. Received (Base)");
            CALCFIELDS("Reserved Qty. Inbnd. (Base)", "Reserved Qty. Outbnd. (Base)");
            TESTFIELD("Reserved Qty. Inbnd. (Base)", 0);
            TESTFIELD("Reserved Qty. Outbnd. (Base)", 0);
        END;
        //ND Tri Start Cust 38
        IF "Transfer-from Code" <> '' THEN BEGIN
            UserAccess := 6;
            Permissions.Type(UserAccess, xRec."Transfer-from Code");
            Permissions.Type(UserAccess, "Transfer-from Code");
        END;
        IF "Transfer-to Code" <> '' THEN BEGIN
            UserAccess := 7;
            Permissions.Type(UserAccess, xRec."Transfer-to Code");
            Permissions.Type(UserAccess, "Transfer-to Code");
        END;
        //ND Tri End Cust 38
    end;

    trigger OnAfterInsert()
    begin
        //ND Start
        IF TransHeader.GET("Document No.") THEN
            "External Transfer" := TransHeader."External Transfer";
        ReProcess := TransHeader.ReProcess;   //TRI S.C. 09.06.10
                                              //ND End
                                              //RM Starts
        IF Theader.GET("Document No.") THEN BEGIN
            IF ("Transfer-from Code" = '') THEN
                "Transfer-from Code" := Theader."Transfer-from Code";
            IF "Transfer-to Code" = '' THEN
                "Transfer-to Code" := Theader."Transfer-to Code";


            IF Theader."External Transfer" THEN
                IF "Line No." > 250000 THEN
                    // ERROR('1%','Sorry!!!!! You can select only 25 Line'); //Kulbhushan

                    IF Theader."External Transfer" THEN
                        "End Use Item" := FALSE;
        END;
        //RM Ends
        //ND Tri Start Cust 38

        UserAccess := 6;
        Permissions.Type(UserAccess, "Transfer-from Code");
        UserAccess := 7;
        Permissions.Type(UserAccess, "Transfer-to Code");
        //ND Tri End Cust 38

        //vipul Tri1.0
        IF TransHeader.GET("Document No.") THEN
            Rec."Posting Date" := TransHeader."Posting Date";
        //vipul Tri1.0

        //ravi Tri Start
        IF TransHeader.GET("Document No.") THEN BEGIN
            Location.RESET;
            Location1.RESET;
            IF (TransHeader."Transfer-from Code" <> '') AND (TransHeader."Transfer-to Code" <> '') THEN
                IF Location.GET(TransHeader."Transfer-from Code") AND Location1.GET(TransHeader."Transfer-to Code") THEN
                    IF Location."Main Location" <> Location1."Main Location" THEN
                        // 15578   IF TransHeader."External Transfer" = TransHeader."External Transfer"::"1" then
                        TransHeader.TESTFIELD(TransHeader."Customer Price Group")
                    ELSE
                        EXIT;
        END;
        //ravi Tri End


    end;

    trigger OnAfterModify()
    begin
        //ND Tri Start Cust 38
        UserAccess := 6;
        Permissions.Type(UserAccess, xRec."Transfer-from Code");
        Permissions.Type(UserAccess, "Transfer-from Code");
        UserAccess := 7;
        Permissions.Type(UserAccess, xRec."Transfer-to Code");
        Permissions.Type(UserAccess, "Transfer-to Code");
        //ND Tri End Cust 38
        //ND Start
        IF TransHeader.GET("Document No.") THEN begin
            "External Transfer" := TransHeader."External Transfer";
            Rec."Posting Date" := TransHeader."Posting Date";
        end;
        //MSKS2309
        IF "External Transfer" THEN
            IF "Structure Calculated" = TRUE THEN BEGIN
                "Structure Calculated" := FALSE;
                MODIFY;
            END;

    end;



    //Unsupported feature: Code Modification on "CalcBaseQty(PROCEDURE 14)".Event N/F

    //procedure CalcBaseQty();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("Qty. per Unit of Measure");
    EXIT(ROUND(Qty * "Qty. per Unit of Measure",0.00001));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TESTFIELD("Qty. per Unit of Measure");
    //"Qty. per Unit of Measure" := ROUND("Qty. per Unit of Measure",0.00001,'=');//TRI
    //EXIT(ROUND(Qty * "Qty. per Unit of Measure",0.00001));  //TRI DEL ADD
    EXIT(Qty*ROUND("Qty. per Unit of Measure",0.00001,'='));         //TRI ADD
    */
    //end;




    //Unsupported feature: Code Modification on "GetItem(PROCEDURE 9)".Event N/F

    //procedure GetItem();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("Item No.");
    IF "Item No." <> Item."No." THEN
      Item.GET("Item No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3


     IF "External Transfer"=TRUE THEN
     IF CheckGroupCode(Item."No.",TransHeader."Group Code") THEN
       ERROR(Text0002);
    */
    //end;



    //Unsupported feature: Code Modification on "UpdateExciseAmount(PROCEDURE 1280014)".// Function N/F

    //procedure UpdateExciseAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Amount Added to Excise Base" = 0 THEN BEGIN
      InitExciseAmount;
      EXIT;
    END;
    GetTransHeader;

    IF TransHeader."Captive Consumption" THEN
      InitExciseAmount;
    #9..654
    "Excise Amount" :=
      "BED Amount" + "AED(GSI) Amount" + "SED Amount" + "SAED Amount" + "CESS Amount" + "NCCD Amount" +
      "eCess Amount" + "ADET Amount" + "AED(TTA) Amount" + "ADE Amount" + "ADC VAT Amount" + "SHE Cess Amount";
    "Amount Including Excise" := "Excise Base Amount" + "Excise Amount";

    IF Location2.GET("Transfer-from Code") THEN;
    IF Location2."Trading Location" THEN BEGIN
    #662..672
      "ADC VAT Amount" := ADCVATAmt;
      "Excise Amount" := "BED Amount" + "AED(GSI) Amount" + "SED Amount" + "SAED Amount" + "NCCD Amount" +
        "eCess Amount" + "ADET Amount" + "AED(TTA) Amount" + "ADE Amount" + "ADC VAT Amount" + "SHE Cess Amount";
      "Amount Including Excise" := "Excise Base Amount" + "Excise Amount";
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    GetTransHeader1;
    #6..657

    //"Amount Including Excise" := "Excise Base Amount" + "Excise Amount";
    "Amount Including Excise" := Amount+"Charges to Transfer" + "Excise Amount";   //TRI DG 020810
    #659..675
      "Amount Including Excise" := Amount+"Charges to Transfer" + "Excise Amount";   //TCPL::7632 190516
    END;
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateAmounts(PROCEDURE 1280002)".// Function N/F

    //procedure UpdateAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Amount := ROUND(Quantity * "Transfer Price");
    GetLocation("Transfer-from Code");
    UpdateExciseAmount;
    GSTManagement.DeleteGSTBuffer(DocTransactionType::Transfer,0,"Document No.","Line No.");
    IF GSTManagement.IsGSTApplicable(TransHeader.Structure) THEN
      UpdateGSTAmounts("GST Base Amount",GSTApplicable);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Amount := ROUND(Quantity * "Transfer Price");
    IF Location.GET("Transfer-from Code") THEN;
    VALIDATE("MRP Price");//TRI S.R
    //GetLocation("Transfer-from Code");
    #3..6
    */
    //end;


    //Unsupported feature: Code Modification on "CalculateStructures(PROCEDURE 1280004)".// Function N/F

    //procedure CalculateStructures();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH TransHeader DO BEGIN
      StrOrderLines.LOCKTABLE;
      StrOrderLines.RESET;
      StrOrderLines.SETCURRENTKEY("Document Type","Document No.",Type);
      StrOrderLines.SETRANGE(Type,StrOrderLineDetails.Type::Transfer);
      StrOrderLines.SETRANGE("Document No.","No.");
      IF StrOrderLines.FINDFIRST THEN
        StrOrderLines.DELETEALL;
      GSTApplicable := GSTManagement.GSTApplicableOnTransfer(TransHeader);
      TransLine.SETRANGE("Document No.","No.");
      TransLine.SETRANGE("Derived From Line No.",0);
    #12..14
        UNTIL TransLine.NEXT = 0;

      TransLine.RESET;
      TransLine.SETRANGE("Document No.","No.");
      TransLine.SETRANGE("Derived From Line No.",0);
      IF TransLine.FIND('-') THEN BEGIN
    #21..63
                  StrOrderLineDetails.LCY := StrOrderDetails.LCY;
                  StrOrderLineDetails."Third Party Code" := StrOrderDetails."Third Party Code";
                  StrOrderLineDetails.CVD := StrOrderDetails.CVD;
                  IF ((StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::Charges) OR
                      (StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::"Other Taxes"))
                  THEN
    #70..81
                     (StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::"Other Taxes")
                  THEN BEGIN
                    IF StrOrderDetails."Calculation Type" = StrOrderDetails."Calculation Type"::"Fixed Value" THEN BEGIN
                      IF StrOrderDetails."Charge Basis" = StrOrderDetails."Charge Basis"::Amount THEN BEGIN
                        StrOrderLineDetails."Base Amount" := Quantity * "Transfer Price";
                        StrOrderLineDetails.Amount :=
                          (StrOrderDetails."Calculation Value" * CFactor) * (Quantity * "Transfer Price") / TotalAmount;
                      END;
                      IF StrOrderDetails."Charge Basis" = StrOrderDetails."Charge Basis"::Equally THEN BEGIN
                        StrOrderLineDetails."Base Amount" := 0;
                        StrOrderLineDetails.Amount := (StrOrderDetails."Calculation Value" * CFactor) / TotalLines;
                      END;
                    END;
                    IF StrOrderDetails."Calculation Type" = StrOrderDetails."Calculation Type"::Percentage THEN BEGIN
                      StrOrderLineDetails."Base Amount" := BaseAmount;
                      StrOrderLineDetails.Amount := (StrOrderDetails."Calculation Value" * CFactor) * BaseAmount / 100;
                    END;
                    IF StrOrderDetails."Calculation Type" = StrOrderDetails."Calculation Type"::"Amount Per Qty" THEN BEGIN
                      StrOrderLineDetails."Base Amount" := 0;
                      StrOrderLineDetails.Amount := (StrOrderDetails."Calculation Value" * CFactor) * Quantity /
                        StrOrderDetails."Quantity Per";
                    END;
                  END;

                  IF StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::Excise THEN BEGIN
    #107..171
        UNTIL TransLine.NEXT = 0;
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
      TransLine.SETCURRENTKEY("Document No.","Derived From Line No."); //MSKS090512
    #9..17
      TransLine.SETCURRENTKEY("Document No.","Derived From Line No."); //MSKS090512
    #18..66
                  StrOrderLineDetails."Charge Type" := StrOrderDetails."Charge Type"; //TRI S.C
    #67..84
                      IF (StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::Charges) THEN
                        StrOrderDetails.TESTFIELD("Charge Basis");
                      IF StrOrderDetails."Charge Basis" = StrOrderDetails."Charge Basis"::Amount THEN BEGIN
                        StrOrderLineDetails."Base Amount" := Quantity * "Transfer Price";
                        {
                         StrOrderLineDetails.Amount :=
                          (StrOrderDetails."Calculation Value" * CFactor) * (Quantity * "Transfer Price") / TotalAmount;
                        }

                        StrOrderLineDetails.Amount :=
                  ROUND(((StrOrderDetails."Calculation Value" * CFactor) * (Quantity * "Transfer Price") / TotalAmount),0.01,'=');//TRI

    #89..91
                        //StrOrderLineDetails.Amount := (StrOrderDetails."Calculation Value" * CFactor) / TotalLines;
                        StrOrderLineDetails.Amount := ROUND(((StrOrderDetails."Calculation Value" * CFactor) / TotalLines),0.01,'=');//TRI
    #93..96
                     // StrOrderLineDetails.Amount := (StrOrderDetails."Calculation Value" * CFactor) * BaseAmount / 100;
                      StrOrderLineDetails.Amount := ROUND(((StrOrderDetails."Calculation Value" * CFactor) * BaseAmount / 100),0.01,'=');//TRI  TCPL::7632 190516
    #98..100
                     { StrOrderLineDetails.Amount := (StrOrderDetails."Calculation Value" * CFactor) * Quantity /
                        StrOrderDetails."Quantity Per";
                     }

           StrOrderLineDetails.Amount := ROUND(((StrOrderDetails."Calculation Value" * CFactor) * Quantity /
            StrOrderDetails."Quantity Per"),0.01,'=');//TRI

                     END;
    #104..174
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateTransLines(PROCEDURE 1280009)".// Function N/F

    //procedure UpdateTransLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH TransHeader DO BEGIN
      TransLine.SETRANGE("Document No.","No.");
      TransLine.SETRANGE("Derived From Line No.",0);
      IF TransLine.FIND('-') THEN
    #5..31
                  IF StrOrderDetails."Loading on Inventory" THEN
                    AmountToInventory :=
                      AmountToInventory + (StrOrderLineDetails."Amount (LCY)" *
                                           StrOrderLineDetails."% Loading on Inventory" / 100);
                UNTIL StrOrderLineDetails.NEXT = 0;
            UNTIL StrOrderDetails.NEXT = 0;
          TransLine."Charges to Transfer" := AmountToTransfer;
          TransLine."Total Amount to Transfer" := ROUND(Amount + "Excise Amount" + "Charges to Transfer");
          TransLine."Amount Added to Inventory" := AmountToInventory;
          TransLine.MODIFY;
        UNTIL TransLine.NEXT = 0;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    WITH TransHeader DO BEGIN
      TransLine.SETCURRENTKEY("Document No.","Derived From Line No."); //MSKS090512
    #2..34

                                                                 StrOrderLineDetails."% Loading on Inventory" / 100);
    #36..43
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateGSTAmounts(PROCEDURE 1500025)".// Function N/F

    //procedure UpdateGSTAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetTransHeader;
    IF TransferHeader1."No."='' THEN
      TransferHeader1.COPY(TransHeader);
    #4..21
        SourceType::Customer,Location."State Code",Location1."State Code",GSTJurisdiction);
    IF GSTPerStateCode = '' THEN
      EXIT;
    TotalGST := GSTManagement.CalculateGSTAmounts(
      "Document No.","Line No.",GSTJurisdiction,GSTPerStateCode,"GST Group Code",
      TransferHeader1."Posting Date",GSTBaseAmount,DocTransactionType::Transfer,0,'',1,
    #28..33
    "GST %" := "Total GST Amount" / GSTBaseAmount * 100;
    "GST Base Amount" := GSTBaseAmount;
    GSTManagement.DeleteGSTCalculationBuffer(DocTransactionType::Transfer,0,"Document No.","Line No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..24

    //MESSAGE('%1--%2--%3--%4-%5',GSTJurisdiction,GSTPerStateCode,"GST Group Code",GSTBaseAmount,"Transfer Price");
    #25..36
    */
    //end;

    local procedure GetTransHeader1()
    var
        FullAutoReservation: Boolean;
        TransferLines: Page "Transfer Order Subform";
    begin
        TESTFIELD("Document No.");
        IF ("Document No." <> TransHeader."No.") THEN
            TransHeader.GET("Document No.");

        TransHeader.TESTFIELD("Shipment Date");
        TransHeader.TESTFIELD("Receipt Date");
        TransHeader.TESTFIELD("Transfer-from Code");
        TransHeader.TESTFIELD("Transfer-to Code");
        TransHeader.TESTFIELD("In-Transit Code");
        "In-Transit Code" := TransHeader."In-Transit Code";
        //"Transfer-from Code" := TransHeader."Transfer-from Code";
        //"Transfer-to Code" := TransHeader."Transfer-to Code";
        "Shipment Date" := TransHeader."Shipment Date";
        "Receipt Date" := TransHeader."Receipt Date";
        "Shipping Agent Code" := TransHeader."Shipping Agent Code";
        "Shipping Agent Service Code" := TransHeader."Shipping Agent Service Code";
        "Shipping Time" := TransHeader."Shipping Time";
        "Outbound Whse. Handling Time" := TransHeader."Outbound Whse. Handling Time";
        "Inbound Whse. Handling Time" := TransHeader."Inbound Whse. Handling Time";
        // "Excise Bus. Posting Group" := TransHeader."Excise Bus. Posting Group";
        Status := TransHeader.Status;
    end;

    procedure CheckGroupCode(ItemCd: Code[20]; GrpCode: Code[10]): Boolean
    var
        RecItem: Record Item;
        Ret: Boolean;
    begin
        //IF Type= Type::Item THEN
        //EXIT;
        Ret := TRUE;
        IF RecItem.GET(ItemCd) THEN BEGIN
            IF (GrpCode IN ['01', '03', '04']) THEN BEGIN
                IF (RecItem."Group Code" IN ['01', '03', '04']) THEN
                    Ret := FALSE;
            END;

            IF (GrpCode IN ['02']) THEN BEGIN
                IF (RecItem."Group Code" IN ['02']) THEN
                    Ret := FALSE;
            END;
            IF (GrpCode IN ['05']) THEN BEGIN
                IF (RecItem."Group Code" IN ['05']) THEN
                    Ret := FALSE;
            END;

            IF (GrpCode IN ['06']) THEN BEGIN
                IF (RecItem."Group Code" IN ['06']) THEN
                    Ret := FALSE;
            END;
            IF (GrpCode IN ['07']) THEN BEGIN
                IF (RecItem."Group Code" IN ['07']) THEN
                    Ret := FALSE;

                IF (GrpCode IN ['08']) THEN BEGIN
                    IF (RecItem."Group Code" IN ['08']) THEN
                        Ret := FALSE;
                END;
            END;

            IF (GrpCode IN [RecItem."Group Code"]) THEN BEGIN
                Ret := FALSE;



            END;
        END;


        EXIT(Ret);
    end;

    procedure ISMRP(): Boolean
    begin
        SalesPrice.RESET;
        SalesPrice.SETFILTER(SalesPrice."Item No.", "Item No.");
        SalesPrice.SETFILTER(SalesPrice."Sales Type", '%1', SalesPrice."Sales Type"::"Customer Price Group");
        SalesPrice.SETFILTER(SalesPrice."Sales Code", '%1', TransHeader."Customer Price Group");
        SalesPrice.SETFILTER(SalesPrice."Starting Date", '..%1', TransHeader."Posting Date");
        SalesPrice.SETFILTER(SalesPrice."Ending Date", '%1|%2..', 0D, TransHeader."Posting Date");
        //  SalesPrice.SETRANGE("Variant Code","Variant Code");
        SalesPrice.SETFILTER(SalesPrice."Unit of Measure Code", "Unit of Measure Code");
        IF SalesPrice.FIND('+') THEN
            EXIT(TRUE)
    end;

    procedure CheckMfgBatchNo(TransferLine: Record "Transfer Line")
    var
        RecItem: Record Item;
    begin
        IF NOT ("Transfer-from Code" IN ['DRA-PROD', 'HSK-PROD', 'SKD-MF 1', 'SKD-MF 2', 'SKD-MF 3', 'SKD-MF 4', 'SKD-MP 1', 'SKD-MP 2', 'SKD-MP 4']) THEN EXIT;
        IF RecItem.GET(TransferLine."Item No.") THEN BEGIN
            IF (RecItem."Quality Code" = '1') THEN BEGIN
                TransferLine.TESTFIELD(TransferLine."Mfg. Batch No.");
                CheckMfgInventory;
            END;
        END;
    end;

    local procedure CheckMfgInventory()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        Qty: Decimal;
    begin
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Location Code", Open, "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.");
        ItemLedgerEntry.SETRANGE("Item No.", "Item No.");
        ItemLedgerEntry.SETRANGE("Location Code", "Transfer-from Code");
        ItemLedgerEntry.SETRANGE("Mfg. Batch No.", "Mfg. Batch No.");
        ItemLedgerEntry.SETRANGE(Open, TRUE);
        IF ItemLedgerEntry.FINDFIRST THEN
            REPEAT
                Qty += ItemLedgerEntry.Quantity;
            UNTIL ItemLedgerEntry.NEXT = 0;
        //MESSAGE('%1',Qty);
        /*
        IF Quantity > Qty THEN
          ERROR('Insufficient Inventory of Item %1',"Item No."); //Kulbhushan
        */

    end;

    local procedure IsVariantExist(ITemNo: Code[20]): Boolean
    var
        ItemVariant: Record "Item Variant";
    begin
        ItemVariant.RESET;
        ItemVariant.SETRANGE("Item No.", ITemNo);
        EXIT(ItemVariant.FINDFIRST)
    end;


    var
        TL: Record "Transfer Line";
        Theader: Record "Transfer Header";
        //  tgStrOrderDetails: Record 13794;
        UserAccess: Integer;
        Permissions: Codeunit Permissions1;
        SalesPrice: Record "Sales Price";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        ItemUnitOfMeasure1: Record "Item Unit of Measure";
        InventorySetup: Record "Inventory Setup";
        DimensionValue: Record "Dimension Value";
        Location1: Record Location;
        TransferHeader: Record "Transfer Header";
        TransHeader: Record "Transfer Header";
        UserLocation: Record "User Location";
        ReservMgt: Codeunit "Reservation Management";
        ile: Record "Item Ledger Entry";
        ttqty: Decimal;
        tshipment: Record "Transfer Shipment Line";
        DOC: Text[50];
        TransLine: Record "Transfer Line";
        Text0001: Label 'This Item already Exists in this order. Do you want to Continue?';
        Text0002: Label 'Select Same Group';
        Item: Record Item;
        Location: Record Location;
}

