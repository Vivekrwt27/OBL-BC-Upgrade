tableextension 50131 tableextension50131 extends Customer
{
    fields
    {
        /* modify("Fin. Charge Terms Code")
         {
             TableRelation = Indent;
         }*/ // 15578
        modify("Salesperson Code")
        {
            TableRelation = "Salesperson/Purchaser" WHERE(Status = FILTER(< Disabled),
                                                         "Sales Person" = FILTER(<> false));
            trigger OnBeforeValidate()// 15578
            begin
                IF SalespersonPurchaser.GET("Salesperson Code") THEN
                    "Salesperson Description" := SalespersonPurchaser.Name;
                GLSetup.GET;
                IF GLSetup."SMS Updatation" THEN
                    InsertSMSDetails(FIELDNO("Salesperson Code"));
            end;
        }
        modify(Blocked)
        {
            OptionCaption = ' ,Ship,Invoice,All,Order Releasing';

        }
        modify("Telex Answer Back")
        {
            Description = 'Key Range Not billed till last month OBL Executive';
        }
        modify(Reserve)
        {
            OptionCaption = 'Always,Never,Optional';
        }
        modify("Phone No.")// 15578
        {
            trigger OnBeforeValidate()
            begin
                GLSetup.GET;
                IF GLSetup."SMS Updatation" THEN
                    IF "Customer Type" IN ['DEALER', 'SUBDLR', 'DISTIBUTOR'] THEN
                        InsertSMSDetails(FIELDNO("Phone No."));

            end;
        }

        modify("Location Code")// 15578
        {
            trigger OnBeforeValidate()
            begin
                IF LocationRec.GET("Location Code") THEN BEGIN
                    GLSetUp.GET;
                    GLSetUp.TESTFIELD(GLSetUp."Location Dimension Code");
                    DefDim.INIT;
                    DefDim."Table ID" := 18;
                    DefDim."No." := "No.";
                    DefDim."Dimension Code" := GLSetUp."Location Dimension Code";
                    IF DefDim.FIND THEN BEGIN
                        DefDim."Dimension Value Code" := LocationRec.Code;
                        DefDim."Value Posting" := DefDim."Value Posting"::" ";
                        //DefDim."Table Name" := TABLENAME; code blocked for upgradation
                        DefDim.MODIFY;
                    END ELSE BEGIN
                        DefDim."Dimension Value Code" := LocationRec.Code;
                        DefDim."Value Posting" := DefDim."Value Posting"::" ";
                        //DefDim."Table Name" := TABLENAME; code blocked for upgradation
                        DefDim.INSERT;
                    END;
                END;

            end;
        }
        modify("E-Mail")// 15578
        {
            trigger OnBeforeValidate()
            begin
                IF "E-Mail" <> '' THEN
                    FOR I := 1 TO STRLEN("E-Mail") DO BEGIN
                        IF (COPYSTR("E-Mail", I, 1) IN ['"', ' ']) OR (STRPOS("E-Mail", '@') = 0) THEN
                            ERROR('Email is Invalid');
                    END;

            end;
        }
        modify("P.A.N. No.")
        {
            trigger OnBeforeValidate()
            begin
                /* IF (STRLEN("P.A.N. No.") <> 10) THEN
                    ERROR('Pan No. Cannot Greator Or Less then Ten Digit'); */
            end;
        }


        modify("State Code")// 15578
        {
            trigger OnBeforeValidate()
            begin
                IF staterec.GET("State Code") THEN BEGIN
                    GLSetup.GET;
                    GLSetup.TESTFIELD(GLSetup."State Dimension Code");
                    DefDim."Table ID" := 18;
                    DefDim."No." := "No.";
                    DefDim."Dimension Code" := GLSetup."State Dimension Code";
                    IF DefDim.FIND THEN BEGIN
                        DefDim."Dimension Value Code" := staterec.Dimension;
                        DefDim."Value Posting" := DefDim."Value Posting"::" ";
                        // DefDim."Table Name" := TABLENAME;    code blocked for upgradation
                        DefDim.MODIFY;
                    END ELSE BEGIN
                        DefDim."Dimension Value Code" := staterec.Dimension;
                        DefDim."Value Posting" := DefDim."Value Posting"::" ";
                        //DefDim."Table Name" := TABLENAME;   code blocked for upgradation
                        DefDim.INSERT;
                    END;
                    "State Desc." := staterec.Description;
                    //Zone:=staterec.Zone;//  Kulbhushan

                END;

            end;
        }
        modify("GST Registration No.")// 15578
        {
            trigger OnAfterValidate()
            begin
                IF "P.A.N. No." = '' THEN
                    "P.A.N. No." := COPYSTR("GST Registration No.", 3, 10);

            end;
        }


        modify("GST Customer Type")//
        {
            trigger OnAfterValidate()
            begin
                IF ("GST Customer Type" IN ["GST Customer Type"::Registered, "GST Customer Type"::Unregistered, "GST Customer Type"::Exempted,
                            "GST Customer Type"::"SEZ Development", "GST Customer Type"::"SEZ Unit"])
                    THEN
                    TESTFIELD("State Code")
                ELSE

                    IF "GST Customer Type" <> "GST Customer Type"::"Deemed Export" THEN
                        IF (UPPERCASE(USERID) <> 'IT005') AND (UPPERCASE(USERID) <> 'ADMIN') THEN
                            TESTFIELD("State Code", '');

            end;
        }

        /*field(16614; "Aggregate Turnover"; Option)
        {
            OptionCaption = 'Less than 10 Crore,More than 10 Crore';
            OptionMembers = "Less than 10 Crore","More than 10 Crore";
        }*/ // 15578
        field(50001; "Purchase Order Pending"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER('Order|Invoice'),
                                                      "Bill-to Customer No." = FIELD("No.")));
            Description = 'TRI DP';
            FieldClass = FlowField;
        }
        field(50003; "Customer Type"; Code[20])
        {
            Description = 'Cust 22';
            TableRelation = "Customer Type".Code WHERE(Type = FILTER(= Customer));

            trigger OnValidate()
            begin
                //CustType is Declared as Record variable to table 50010 "Customer Type"
                //Cust 22 Start Vipul

                CustType.GET(CustType.Type::Customer, "Customer Type");
                IF "Gen. Bus. Posting Group" = '' THEN
                    "Gen. Bus. Posting Group" := CustType."Gen. Bus. Posting Group";
                IF "Customer Posting Group" = '' THEN
                    "Customer Posting Group" := CustType."Customer Posting Group";
                IF "VAT Bus. Posting Group" = '' THEN
                    "VAT Bus. Posting Group" := CustType."VAT Bus. Posting Group";
                /*   IF "Excise Bus. Posting Group" = '' THEN
                       "Excise Bus. Posting Group" := CustType."Excise Bus. Posting Group";
                   IF Structure = '' THEN
                       Structure := CustType.Structure;*/ // 15578
                                                          //TRIRJ ORIENT 13-01-09:Start Comment
                                                          //       "Tax Liable" := CustType."Tax Liable";
                                                          //TRIRJ ORIENT 13-01-09:END Comment

                IF "Customer Type" = 'GET' THEN
                    "Sold By" := 'Get.'
                ELSE
                    IF "Customer Type" = 'PET' THEN
                        "Sold By" := 'Pet.'
                    ELSE
                        IF "Customer Type" = 'SET' THEN
                            "Sold By" := 'Set.'
                        ELSE
                            IF "Customer Type" = 'EXIM' THEN
                                "Sold By" := 'EXIM'
                            ELSE
                                IF (("Customer Type" <> 'GET') AND ("Customer Type" <> 'PET') AND ("Customer Type" <> 'SET') AND ("Customer Type" <> 'EXIM')) THEN
                                    "Sold By" := 'Retail.';

                //IF "Customer Type" IN ['DEALER','SUBDLR','DISTIBUTOR','EXIM'] THEN
                //    "Customer Price Group" := "State Code"
                IF "State Code" = '13' THEN
                    "Customer Price Group" := 'HSK_DK'
                ELSE
                    "Customer Price Group" := 'HSK_D';

                IF "Customer Type" <> xRec."Customer Type" THEN BEGIN
                    ;
                    IF "Customer Type" IN ['GET', 'PET', 'SET', 'DIRECTPROJ', 'HOPROJECT'] THEN
                        "Tableau Zone" := 'Enterprise'
                    ELSE
                        "Tableau Zone" := Zone;
                END;

                MODIFY;

                //Cust 22 End Vipul
            end;
        }
        field(50004; "Security Amount"; Decimal)
        {
            Description = 'Cust 22';
        }
        field(50005; "Security Date"; Date)
        {
            Description = 'Cust 22';
        }
        field(50006; "Prompt Pmt. Details"; Boolean)
        {
        }
        field(50007; "State Desc."; Text[50])
        {
        }
        field(50008; "Salesperson Description"; Text[50])
        {
        }
        field(50010; "Form Code"; Code[10])
        {
            // 15578  TableRelation = "Form Codes";
        }
        field(50011; "PPD No. of Days"; Integer)
        {
        }
        field(50012; "PPD %"; Decimal)
        {
        }
        field(50013; "Payment Terms Days"; Integer)
        {
        }
        field(50014; "PAN Ref. No."; Code[10])
        {
            Description = 'RM added for eTDS';
        }
        field(50015; "PAN Status"; Option)
        {
            Description = 'RM added for eTDS';
            OptionCaption = ',PANAPPLIED,PANINVALID,PANNOTAVBL';
            OptionMembers = ,PANAPPLIED,PANINVALID,PANNOTAVBL;
        }
        field(50016; "Quantity in Carton"; Decimal)
        {
            CalcFormula = Sum("Sales Invoice Line".Quantity WHERE("Sell-to Customer No." = FIELD("No."),
                                                                   "Posting Date" = FIELD("Date Filter"),
                                                                   "Location Code" = FIELD("Location filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50017; "Quantity in Sq. Meters"; Decimal)
        {
            CalcFormula = Sum("Sales Invoice Line".Quantity WHERE("Sell-to Customer No." = FIELD("No."),
                                                                   "Posting Date" = FIELD("Date Filter"),
                                                                   "Location Code" = FIELD("Location filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50018; "Ex-Factory Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Invoice Line".Amount WHERE("Sell-to Customer No." = FIELD("No."),
                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                 "Location Code" = FIELD("Location filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50019; "Excise Amount"; Decimal)
        {
            /*CalcFormula = Sum("Sales Invoice Line"."Excise Amount" WHERE ("Sell-to Customer No."=FIELD("No."),
                                                                          "Posting Date"=FIELD("Date Filter"),
                                                                          "Location Code"=FIELD("Location filter")));*/ // 15578
            Editable = false;
            // FieldClass = FlowField;
        }
        field(50020; "Sales Amount"; Decimal)
        {
            /* CalcFormula = Sum("Sales Invoice Line"."Amount Including Excise" WHERE (Sell-to Customer No.=FIELD(No.),
                                                                                     Posting Date=FIELD(Date Filter),
                                                                                     Location Code=FIELD(Location filter)));*/ // 15578
            Editable = false;
            // FieldClass = FlowField;
        }
        field(50021; "Location filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(50022; Pay; Option)
        {
            Description = 'TRIRJ ORIENT6.0 01-11-08';
            OptionMembers = "To Pay"," To Be Billed";
        }
        field(50023; "Pin Code"; Code[10])
        {
            Description = 'TRI';

            trigger OnValidate()
            begin
                IF (STRLEN("Pin Code") > 6) THEN
                    ERROR('Pin No. Cannot Greator then Six Digit');
            end;
        }
        field(50024; "Cust. Company Type"; Option)
        {
            Description = 'TRI A.S 21.01.09';
            OptionCaption = ' ,Proprietorship,Partnership,Pvt. Ltd,Public Ltd';
            OptionMembers = " ",Proprietorship,Partnership,"Pvt. Ltd","Public Ltd";
        }
        field(50025; "Security Chq Availability"; Boolean)
        {
            Description = 'TRI A.S 21.01.09';
        }
        field(50026; "Bank Account No."; Code[20])
        {
            Description = 'TRI A.S 21.01.09';
        }
        field(50027; "Bank Other Details"; Text[50])
        {
            Description = 'TRI A.S 21.01.09';
        }
        field(50028; "Cust Landline No."; Text[40])
        {
            Description = 'TRI A.S 21.01.09';
        }
        field(50062; "Created By"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50076; "Sales Header No."; Code[20])
        {
        }
        field(50077; "Sales Header Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(50078; "Outstanding Amount"; Decimal)
        {
            /* CalcFormula = Sum("Sales Line"."Amount To Customer" WHERE ("Document Type"=FILTER('Order|Invoice'),
                                                                        "Bill-to Customer No."=FIELD("No.")));*/ // 15578
            Editable = false;
            // FieldClass = FlowField;
        }
        field(50079; "Outstanding Blanket order"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER("Blanket Order"),
                                                      "Bill-to Customer No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50080; "Blanket Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line".Amount WHERE("Document Type" = FILTER("Blanket Order"),
                                                         "Bill-to Customer No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50081; "Blocked Old"; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Ship,Invoice,All';
            OptionMembers = " ",Ship,Invoice,All;
        }
        field(50082; "Blocked For Customer Ledger"; Boolean)
        {
        }
        field(50083; "Mobile No."; Text[30])
        {
        }
        field(50084; "Coco Customer"; Boolean)
        {
            Description = 'Ori UTT';
        }
        field(50085; "Create for Orient"; Boolean)
        {
            Description = 'MIPL,MSBS.Rao Dt. 03-10-11';
            Editable = false;
        }
        field(50086; "Create for Bell"; Boolean)
        {
            Description = 'MIPL,MSBS.Rao Dt. 03-10-11';
            Editable = false;
        }
        field(50087; "TIN Date"; Date)
        {
        }
        field(50088; "PCH Name"; Text[30])
        {
            Description = 'MIPL,MSBS.Rao Dt. 31-07-12';
        }
        field(50089; "PCH E-Maill ID"; Text[80])
        {
            Description = 'MIPL,MSBS.Rao Dt. 31-07-12';
        }
        field(50090; "Creation Date"; Date)
        {
            Description = 'MS-PB';
        }
        field(50091; "PCH Code"; Code[10])
        {
            Description = 'KBS';
            TableRelation = "Salesperson/Purchaser" WHERE(Status = FILTER(< Disabled));

            trigger OnValidate()
            begin
                //MSBS.Rao Begin Dt. 24-04-13
                GLSetup.GET;
                IF GLSetup."SMS Updatation" THEN
                    //IF "Customer Type" IN ['DEALER','SUBDLR','DISTIBUTOR'] THEN
                    InsertSMSDetails(FIELDNO("PCH Code"));
                //MSBS.Rao End Dt. 24-04-13
            end;
        }
        field(50092; "PCH Mobile No."; Code[30])
        {
            CalcFormula = Lookup("SMS - Mobile No."."Mobile No." WHERE("Link Code" = FIELD("No."),
                                                                        Type = FILTER(PCH)));
            FieldClass = FlowField;
        }
        field(50093; "Sales Per Mob"; Code[30])
        {
            CalcFormula = Lookup("SMS - Mobile No."."Mobile No." WHERE("Link Code" = FIELD("No."),
                                                                        Type = FILTER("Sales Person")));
            FieldClass = FlowField;
        }
        field(50094; "Area Code"; Code[12])
        {
            TableRelation = "Matrix Master"."Type 2" WHERE("Mapping Type" = FILTER(City));
        }
        field(50095; Longitude; Decimal)
        {
            DecimalPlaces = 2 : 7;
        }
        field(50096; Latitude; Decimal)
        {
            DecimalPlaces = 2 : 7;
        }
        field(50097; Zone; Text[11])
        {
        }
        field(50098; "Security Cheque 1"; Text[10])
        {
        }
        field(50099; "Security Cheque 2"; Text[30])
        {
        }
        field(50100; "CTS 1"; Boolean)
        {
        }
        field(50101; "CTS 2"; Boolean)
        {
        }
        field(50102; "Security Checque Max Limit 1"; Decimal)
        {
        }
        field(50103; "Security Checque Max Limit 2"; Decimal)
        {
        }
        field(50104; "Bank Account Name"; Text[50])
        {
        }
        field(50105; "Security Cheque 1 Bank Name"; Text[50])
        {
        }
        field(50106; "Security Cheque 2 Bank Name"; Text[50])
        {
        }
        field(50107; "Security Cheque 1 A/c No."; Text[30])
        {
        }
        field(50108; "Security Cheque 2 A/c No."; Text[30])
        {
        }
        field(50109; "Minmum Amt pur value"; Decimal)
        {
            Description = 'Target value';
        }
        field(50110; "Customer Classification"; Option)
        {
            OptionCaption = ' ,Privilege';
            OptionMembers = " ",Privilege;
        }
        field(50111; "Allow Auto Debit"; Boolean)
        {
            InitValue = true;
        }
        field(50112; "Govt. SP Resp."; Code[10])
        {
            TableRelation = "Salesperson/Purchaser" WHERE(Status = FILTER(< Disabled));

            trigger OnValidate()
            begin
                GLSetup.GET;
                IF GLSetup."SMS Updatation" THEN
                    //IF "Customer Type" IN ['DEALER','SUBDLR','DISTIBUTOR'] THEN
                    InsertSMSDetails(FIELDNO("Govt. SP Resp."));
            end;
        }
        field(50113; "Old TIN"; Code[13])
        {
        }
        field(50114; "Dealer File No."; Text[50])
        {
        }
        field(50115; "Private SP Resp."; Code[10])
        {
            TableRelation = "Salesperson/Purchaser" WHERE(Status = FILTER(< Disabled));

            trigger OnValidate()
            begin
                GLSetup.GET;
                IF GLSetup."SMS Updatation" THEN
                    //IF "Customer Type" IN ['DEALER','SUBDLR','DISTIBUTOR'] THEN
                    InsertSMSDetails(FIELDNO("Private SP Resp."));
            end;
        }
        field(50116; "Customer Status"; Option)
        {
            OptionMembers = Active,Closed;
        }
        field(50117; "Zonal Manager"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser" WHERE(Type = CONST("Zone Manager"));
        }
        field(50118; "C-Form Pending"; Decimal)
        {
            // 15578 CalcFormula = Sum(C-form."C-Form Pending Amt" WHERE ("Customer No."=FIELD("No.")));
            Editable = false;
            // FieldClass = FlowField;
        }
        field(50119; "Last Invoiced Date"; Date)
        {
            CalcFormula = Max("Cust. Ledger Entry"."Posting Date" WHERE("Document Type" = FILTER('Invoice'),
                                                                         "Customer No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50120; "Customer Category"; Option)
        {
            OptionCaption = ' ,Platinum,Gold,Silver,Bronze';
            OptionMembers = " ",Platinum,Gold,Silver,Bronze;
        }
        field(50121; "OverDue Amount"; Decimal)
        {
            Description = 'Spoors';
        }
        field(50122; "As on Date"; Date)
        {
            Description = 'Spoors';
        }
        field(50123; "OverDue Days"; Integer)
        {
            Description = 'Spoors';
        }
        field(50124; "Zonal Head"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser" WHERE(Type = CONST("Zone Manager"));
        }
        field(50125; "Outstanding Days"; Integer)
        {
            Description = 'Spoors';
        }
        field(50126; "Discount Group"; Option)
        {
            OptionCaption = ' ,A,B,C,D';
            OptionMembers = " ",A,B,C,D;
        }
        field(50127; "Mother Account Name"; Text[100])
        {
        }
        field(50128; "Credit Rating"; Text[2])
        {
        }
        field(50129; "Last Credit Rating Process"; Date)
        {
        }
        field(50130; "Parent Customer No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(50131; "Dealer Category"; Code[30])
        {
        }
        field(50132; "Expected Visit Per Month"; Integer)
        {
        }
        field(50133; "Stop Mail Comunication PCH SP"; Boolean)
        {
            Description = 'Mail Communication Stop for PCH and Sales Persons.';
        }
        field(50134; "Tableau Zone"; Text[10])
        {
            Editable = true;
        }
        field(50135; "Aadhaar No."; Code[12])
        {
        }
        field(50136; "SP E-Maill ID"; Text[80])
        {
            CalcFormula = Lookup("Salesperson/Purchaser"."E-Mail" WHERE(Code = FIELD("Salesperson Code")));
            FieldClass = FlowField;
        }
        field(50137; "Available Credit Limit IBOT"; Decimal)
        {
            Description = 'IBOT';
        }
        field(50138; "Qtr Target"; Decimal)
        {
        }
        field(50139; "Month Sales Plan"; Decimal)
        {
        }
        field(50140; "Month Collection Plan"; Decimal)
        {
        }
        field(50141; "CXO Tie Up"; Boolean)
        {
        }
        field(50142; "CXO Target"; Decimal)
        {
        }
        field(50143; "ACP (Last 12m)"; Code[5])
        {
            Description = 'Year 21';
        }
        field(50144; "OBTB Joining Date"; Date)
        {
        }
        field(50145; "HQ Town"; Text[30])
        {
            CalcFormula = Lookup("Salesperson/Purchaser"."HQ Town" WHERE(Code = FIELD("Salesperson Code")));
            Editable = false;
            Enabled = true;
            FieldClass = FlowField;
        }
        field(50146; "Virtual ID"; Code[20])
        {
        }
        field(50147; "OBTB Target First year"; Decimal)
        {
        }
        field(50148; "OBTB Target Start Date"; Date)
        {
        }
        field(50149; "OBTB Target End Date"; Date)
        {
        }
        field(50150; "PCH Tie Up"; Boolean)
        {
        }
        field(50151; "Sold By"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50152; Outbreaks; Text[13])
        {
            DataClassification = ToBeClassified;
            Description = 'Ashwamedh';
        }
        field(50153; "CC Team"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Keshav08052020';
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(50154; "Balance Confirmation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50155; "Balance Conf Recd Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50156; "Revival Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50157; "DSO IBOT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'IBOT';
        }
        field(50158; "MTD Collection IBOT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'IBOT';
        }
        field(50159; "Outstanding IBOT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'IBOT';
        }
        field(50160; "OverDue Amt IBOT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'IBOT';
        }
        field(50161; "As on Date IBOT"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'IBOT';
        }
        field(50162; "PYTD Sale IBOT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'IBOT';
        }
        field(50163; "YTD Sale IBOT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'IBOT';
        }
        field(50164; "MTD Sales IBOT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'IBOT';
        }
        field(50165; "QTD Sales IBOT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'IBOT';
        }
        field(50166; "Pop Tag"; Text[10])
        {
            DataClassification = ToBeClassified;
            Description = 'for Marketting Dashboard';
        }
        field(50167; Population; Text[10])
        {
            DataClassification = ToBeClassified;
            Description = 'for Marketting Dashboard';
        }
        field(50168; "Last Billing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50169; "ACP (Current Year)"; Code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'Year 2023';
        }
        field(50170; "Cibil Score"; Code[3])
        {
            DataClassification = ToBeClassified;
        }
        field(50171; "Cibil Score Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50172; "OBTB Closing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50173; "QL Joining Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50174; "OBTB Status"; Option)
        {
            OptionCaption = 'Active,In Active';
            OptionMembers = Active,"In Active";
        }
        field(50175; "TCS Charge Stop Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50176; "ACPD (Current Year)"; Code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'ACD_2023';
        }
        field(50177; "ACPD (Last 12m)"; Code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'ACD_2021';
        }
        field(50178; "TAN No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50179; "ACP (Previous Year)"; Code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'Year 2022';
        }
        field(50180; "ACD (Previous Year)"; Code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'ACD_2022';
        }
        field(85000; "Not Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(85001; "Billing FY21"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Remove after two year today is 01-04-22';
        }
        field(85002; "Billing FY22"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Remove after two year today is 01-04-22';
        }
        field(85003; "CF Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(85004; "CF Customer"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(85005; "Structure Change Item"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key23;/* "State Code",*/ "Customer Type")
        {
        }
        key(Key24; "Salesperson Code")
        {
        }
        key(Key25;/* "State Code", */City, "Customer Price Group", "No.")
        {
        }
        key(Key26; "PCH Code")
        {
        }
        /* key(Key27; "PCH Code", "Salesperson Code")
         {
         }
         key(Key28; "Zonal Head", "Zonal Manager", "PCH Code", "Salesperson Code")
         {
         }*/
        key(Key29; "Area Code")
        {
        }
        key(Key30; "Tableau Zone")
        {
        }
    }

    trigger OnAfterDelete()//  15578
    begin
        GLSetup.GET;
        IF DimValue.GET(GLSetup."Customer Dimension Code", "No.") THEN BEGIN
            DimValue.DELETE;
        END;

        IF DefDim.GET(18, "No.", GLSetup."Customer Dimension Code") THEN BEGIN
            DefDim.DELETE;
        END;

    end;


    trigger OnAfterInsert()// 15578
    begin
        "Creation Date" := TODAY;


        "Created By" := USERID;
        GLSetUp.GET;
        GLSetUp.TESTFIELD(GLSetUp."Customer Dimension Code");
        IF NOT DimValue.GET(GLSetUp."Customer Dimension Code", "No.") THEN BEGIN
            DimValue.INIT;
            DimValue.VALIDATE("Dimension Code", GLSetUp."Customer Dimension Code");
            DimValue.VALIDATE(Code, "No.");
            DimValue.VALIDATE(Name, "No.");
            DimValue.INSERT;
        END;
        IF NOT DefDim.GET(18, "No.", GLSetUp."Customer Dimension Code") THEN BEGIN
            DefDim.INIT;
            DefDim."Table ID" := 18;
            DefDim."No." := "No.";
            DefDim."Dimension Code" := GLSetUp."Customer Dimension Code";
            DefDim."Dimension Value Code" := DimValue.Code;
            DefDim."Value Posting" := DefDim."Value Posting"::"Same Code";
            //DefDim."Table Name" := TABLENAME;               code blocked for upgrdation
            DefDim.INSERT;
        END;
        //Start Kulbhushan 180416
        Cityc := COPYSTR("No.", 8, 4);
        statc := COPYSTR("No.", 6, 2);
        contc := COPYSTR("No.", 3, 2);
        //"Chain Name" := COPYSTR("No.",STRLEN("No.")-4,5);
        "Post Code" := Cityc;
        VALIDATE("Post Code");
        "State Code" := statc;
        VALIDATE("State Code");
        "Country/Region Code" := contc;
        VALIDATE("Country/Region Code");

        UpdateLogititute1("Post Code", City);

        IF contc = '02' THEN BEGIN
            "Gen. Bus. Posting Group" := 'N&B';
            VALIDATE("Gen. Bus. Posting Group");
            // "Excise Bus. Posting Group" := 'Gen';
            // VALIDATE("Excise Bus. Posting Group");
            "Customer Posting Group" := 'N&B';
            VALIDATE("Customer Posting Group")
        END ELSE
            IF contc = '01' THEN BEGIN
                "Gen. Bus. Posting Group" := 'DOMESTIC';
                VALIDATE("Gen. Bus. Posting Group");
                //   "Excise Bus. Posting Group" := 'Gen';
                //   VALIDATE("Excise Bus. Posting Group");
                "Customer Posting Group" := 'DOMESTIC';
                VALIDATE("Customer Posting Group");
            END ELSE
                IF (contc <> '01') AND (contc <> '02') THEN BEGIN
                    "Gen. Bus. Posting Group" := 'exim';
                    VALIDATE("Gen. Bus. Posting Group");
                    //  "Excise Bus. Posting Group" := 'Gen';
                    // VALIDATE("Excise Bus. Posting Group");
                    "Customer Posting Group" := 'exim';
                    VALIDATE("Customer Posting Group");
                END;
        "Tax Liable" := TRUE;
        //  Structure := 'GST+FID+TD';
        Outbreaks := 'None';
        // VALIDATE(Structure);

        //End Kulbhushan 180416
        //MSKS
        IF "Virtual ID" = '' THEN BEGIN
            "Virtual ID" := VirtualNoSeriesMgt.GetNextNo('VIRTUALID', 0D, TRUE);
        END;
    end;

    trigger OnAfterModify()// 15578
    begin
        GLSetup.GET;
        GLSetup.TESTFIELD(GLSetup."Customer Dimension Code");
        IF DimValue.GET(GLSetup."Customer Dimension Code", "No.") THEN BEGIN
            DimValue.VALIDATE(Name, Name);
            DimValue.MODIFY;
        END;

    end;

    trigger OnAfterRename()// 15578
    begin
        GLSetup.GET;
        GLSetup.TESTFIELD(GLSetup."Customer Dimension Code");
        IF DimValue.GET(GLSetup."Customer Dimension Code", xRec."No.") THEN
            DimValue.DELETE;
        DimValue.INIT;
        DimValue.VALIDATE("Dimension Code", GLSetup."Customer Dimension Code");
        DimValue.VALIDATE(Code, "No.");
        DimValue.VALIDATE(Name, "No.");
        DimValue.INSERT;

        //To add the dimension value as default dimension
        GLSetup.GET;
        GLSetup.TESTFIELD(GLSetup."Customer Dimension Code");
        IF DefDim.GET(18, xRec."No.", GLSetup."Customer Dimension Code") THEN
            DefDim.DELETE;

        DefDim.INIT;
        DefDim."Table ID" := 18;
        DefDim."No." := "No.";
        DefDim."Dimension Code" := GLSetup."Customer Dimension Code";
        DefDim."Dimension Value Code" := DimValue.Code;
        DefDim."Value Posting" := DefDim."Value Posting"::" ";
        //DefDim."Table Name" := TABLENAME;    code blocked for upgradation
        DefDim.INSERT;

    end;

    procedure CreateForBell(RecCust: Record Customer; DocumentNO: Code[20])
    var
        RecCustomer: Record Customer;
        ToCompany: Text[50];
        CustomerCode: Code[20];
        Err0001: Label 'Please contact your system administrator !!!';
        GLSetUp: Record "General Ledger Setup";
        DimValue: Record "Dimension Value";
        DefDim: Record "Default Dimension";
    begin
        WITH RecCustomer DO BEGIN
            IF COMPANYNAME = 'Orient Bell Limited' THEN BEGIN
                ToCompany := 'Orient Bell Limited';
                CustomerCode := RecCustomer."No.";
                RecCustomer.CHANGECOMPANY(ToCompany);
                IF NOT RecCustomer.GET(CustomerCode) THEN BEGIN
                    RecCustomer.TRANSFERFIELDS(Rec);
                    RecCustomer.INSERT;
                END;
                //To add the generated customer no. as dimension value.
                GLSetUp.CHANGECOMPANY(ToCompany);
                GLSetUp.GET;
                GLSetUp.TESTFIELD(GLSetUp."Customer Dimension Code");
                DimValue.CHANGECOMPANY(ToCompany);
                IF NOT DimValue.GET(GLSetUp."Customer Dimension Code", "No.") THEN BEGIN
                    DimValue.INIT;
                    DimValue.VALIDATE("Dimension Code", GLSetUp."Customer Dimension Code");
                    DimValue.VALIDATE(Code, "No.");
                    DimValue.VALIDATE(Name, "No.");
                    DimValue.INSERT;
                END;

                //To add the dimension value as default dimension
                DefDim.CHANGECOMPANY(ToCompany);
                IF NOT DefDim.GET(18, "No.", GLSetUp."Customer Dimension Code") THEN BEGIN
                    DefDim.INIT;
                    DefDim."Table ID" := 18;
                    DefDim."No." := "No.";
                    DefDim."Dimension Code" := GLSetUp."Customer Dimension Code";
                    DefDim."Dimension Value Code" := DimValue.Code;
                    DefDim."Value Posting" := DefDim."Value Posting"::"Same Code";
                    //DefDim."Table Name" := TABLENAME; code blocked for upgradation
                    DefDim.INSERT;
                END;

                RecCust.RESET;
                RecCust.SETRANGE("No.", DocumentNO);
                IF RecCust.FINDFIRST THEN BEGIN
                    RecCust."Create for Bell" := TRUE;
                    RecCust.MODIFY;
                END;
            END ELSE
                ERROR(Err0001);
        END;
    end;

    procedure CreateForOrient(RecCust: Record Customer; DocumentNO: Code[20])
    var
        RecCustomer: Record Customer;
        ToCompany: Text[50];
        CustomerCode: Code[20];
        Err0001: Label 'Please contact your system administrator !!!';
        GLSetUp: Record "General Ledger Setup";
        DimValue: Record "Dimension Value";
        DefDim: Record "Default Dimension";
    begin
        WITH RecCustomer DO BEGIN
            IF COMPANYNAME = 'Orient Bell Limited' THEN BEGIN
                ToCompany := 'Orient Bell Limited';
                CustomerCode := RecCustomer."No.";
                RecCustomer.CHANGECOMPANY(ToCompany);
                IF NOT RecCustomer.GET(CustomerCode) THEN BEGIN
                    RecCustomer.TRANSFERFIELDS(Rec);
                    RecCustomer.INSERT;
                END;

                //To add the generated customer no. as dimension value.
                GLSetUp.CHANGECOMPANY(ToCompany);
                GLSetUp.GET;
                GLSetUp.TESTFIELD(GLSetUp."Customer Dimension Code");
                DimValue.CHANGECOMPANY(ToCompany);
                IF NOT DimValue.GET(GLSetUp."Customer Dimension Code", "No.") THEN BEGIN
                    DimValue.INIT;
                    DimValue.VALIDATE("Dimension Code", GLSetUp."Customer Dimension Code");
                    DimValue.VALIDATE(Code, "No.");
                    DimValue.VALIDATE(Name, "No.");
                    DimValue.INSERT;
                END;

                //To add the dimension value as default dimension
                DefDim.CHANGECOMPANY(ToCompany);
                IF NOT DefDim.GET(18, "No.", GLSetUp."Customer Dimension Code") THEN BEGIN
                    DefDim.INIT;
                    DefDim."Table ID" := 18;
                    DefDim."No." := "No.";
                    DefDim."Dimension Code" := GLSetUp."Customer Dimension Code";
                    DefDim."Dimension Value Code" := DimValue.Code;
                    DefDim."Value Posting" := DefDim."Value Posting"::"Same Code";
                    //DefDim."Table Name" := TABLENAME; code blocked for upgradation
                    DefDim.INSERT;
                END;


                RecCust.RESET;
                RecCust.SETRANGE("No.", DocumentNO);
                IF RecCust.FINDFIRST THEN BEGIN
                    RecCust."Create for Orient" := TRUE;
                    RecCust.MODIFY;
                END;
            END ELSE
                ERROR(Err0001);
        END;
    end;

    procedure CreateForAll(RecCust: Record Customer; DocumentNO: Code[20])
    var
        RecCustomer: Record Customer;
        ToCompany: Text[50];
        RecCompany: Record Company;
        CustomerCode: Code[20];
        Err0001: Label 'Please contact your system administrator !!!';
        GLSetUp: Record "General Ledger Setup";
        DimValue: Record "Dimension Value";
        DefDim: Record "Default Dimension";
    begin
        WITH RecCustomer DO BEGIN
            IF COMPANYNAME = 'Orient Bell Limited' THEN BEGIN
                IF RecCompany.FINDFIRST THEN BEGIN
                    REPEAT
                        ToCompany := RecCompany.Name;
                        CustomerCode := RecCustomer."No.";
                        RecCustomer.CHANGECOMPANY(ToCompany);
                        IF NOT RecCustomer.GET(CustomerCode) THEN BEGIN
                            RecCustomer.TRANSFERFIELDS(Rec);
                            RecCustomer.INSERT;
                        END;
                        //To add the generated customer no. as dimension value.
                        GLSetUp.CHANGECOMPANY(ToCompany);
                        GLSetUp.GET;
                        GLSetUp.TESTFIELD(GLSetUp."Customer Dimension Code");
                        DimValue.CHANGECOMPANY(ToCompany);
                        IF NOT DimValue.GET(GLSetUp."Customer Dimension Code", "No.") THEN BEGIN
                            DimValue.INIT;
                            DimValue.VALIDATE("Dimension Code", GLSetUp."Customer Dimension Code");
                            DimValue.VALIDATE(Code, "No.");
                            DimValue.VALIDATE(Name, "No.");
                            DimValue.INSERT;
                        END;

                        //To add the dimension value as default dimension
                        DefDim.CHANGECOMPANY(ToCompany);
                        IF NOT DefDim.GET(18, "No.", GLSetUp."Customer Dimension Code") THEN BEGIN
                            DefDim.INIT;
                            DefDim."Table ID" := 18;
                            DefDim."No." := "No.";
                            DefDim."Dimension Code" := GLSetUp."Customer Dimension Code";
                            DefDim."Dimension Value Code" := DimValue.Code;
                            DefDim."Value Posting" := DefDim."Value Posting"::"Same Code";
                            //DefDim."Table Name" := TABLENAME;       code blocked for upgradation
                            DefDim.INSERT;
                        END;

                    UNTIL RecCompany.NEXT = 0;
                END;


                RecCust.RESET;
                RecCust.SETRANGE("No.", DocumentNO);
                IF RecCust.FINDFIRST THEN BEGIN
                    RecCust."Create for Orient" := TRUE;
                    RecCust."Create for Bell" := TRUE;
                    RecCust.MODIFY;
                END;
            END ELSE
                ERROR(Err0001);
        END;
    end;

    procedure InsertSMSDetails(CurrentFieldNo: Integer)
    var
        RecMobileNo: Record "SMS - Mobile No.";
        SalesPerson: Record "Salesperson/Purchaser";
    begin
        CASE CurrentFieldNo OF
            //*****************-Insert Sales Person Data-*****************

            FIELDNO("Salesperson Code"):
                BEGIN
                    IF SalespersonPurchaser.GET("Salesperson Code") THEN;
                    RecMobileNo.RESET;
                    RecMobileNo.SETRANGE("Link With", RecMobileNo."Link With"::Customer);
                    RecMobileNo.SETRANGE("Link Code", "No.");
                    RecMobileNo.SETFILTER(Type, '%1', RecMobileNo.Type::"Sales Person");
                    RecMobileNo.SETFILTER("Mobile No.", '%1', SalespersonPurchaser."Phone No.");
                    IF RecMobileNo.FINDFIRST THEN
                        RecMobileNo.DELETEALL;

                    IF ("Salesperson Code" <> '') THEN
                        RecMobileNo.RESET;
                    RecMobileNo.SETRANGE("Link With", RecMobileNo."Link With"::Customer);
                    RecMobileNo.SETRANGE("Link Code", "No.");
                    RecMobileNo.SETFILTER(Type, '%1', RecMobileNo.Type::"Sales Person");
                    IF NOT RecMobileNo.FINDFIRST THEN BEGIN
                        RecMobileNo.INIT;
                        RecMobileNo."Mobile No." := SalespersonPurchaser."Phone No.";
                        RecMobileNo."Link With" := RecMobileNo."Link With"::Customer;
                        RecMobileNo."Link Code" := "No.";
                        RecMobileNo.Name := SalespersonPurchaser.Name;
                        RecMobileNo."Send Mobile Communication" := TRUE;
                        RecMobileNo.date := TODAY;
                        RecMobileNo.Type := RecMobileNo.Type::"Sales Person";
                        IF (SalespersonPurchaser."Phone No." <> '') AND (SalespersonPurchaser.Status = SalespersonPurchaser.Status::Enable) THEN
                            RecMobileNo.INSERT;
                    END;
                END;
            //*****************-Insert PCH Person Data-*****************
            FIELDNO("PCH Code"):
                BEGIN
                    IF "PCH Code" <> '' THEN BEGIN
                        SalesPerson.GET("PCH Code");
                        "PCH Name" := SalesPerson.Name;
                        "PCH E-Maill ID" := SalesPerson."E-Mail";
                    END ELSE BEGIN
                        "PCH Name" := '';
                        "PCH E-Maill ID" := '';
                    END;
                    MODIFY;

                    RecMobileNo.RESET;
                    RecMobileNo.SETRANGE("Link With", RecMobileNo."Link With"::Customer);
                    RecMobileNo.SETRANGE("Link Code", "No.");
                    RecMobileNo.SETFILTER(Type, '%1', RecMobileNo.Type::PCH);
                    RecMobileNo.SETFILTER("Mobile No.", '%1', SalesPerson."Phone No.");
                    IF RecMobileNo.FINDFIRST THEN
                        RecMobileNo.DELETEALL;
                    IF "PCH Code" <> "Salesperson Code" THEN BEGIN
                        RecMobileNo.RESET;
                        RecMobileNo.SETRANGE("Link With", RecMobileNo."Link With"::Customer);
                        RecMobileNo.SETRANGE("Link Code", "No.");
                        RecMobileNo.SETFILTER(Type, '%1', RecMobileNo.Type::PCH);
                        IF NOT RecMobileNo.FINDFIRST THEN BEGIN
                            RecMobileNo.INIT;
                            RecMobileNo."Mobile No." := SalesPerson."Phone No.";
                            RecMobileNo."Link With" := RecMobileNo."Link With"::Customer;
                            RecMobileNo."Link Code" := "No.";
                            RecMobileNo.Name := SalesPerson.Name;
                            RecMobileNo."Send Mobile Communication" := TRUE;
                            RecMobileNo.date := TODAY;
                            RecMobileNo.Type := RecMobileNo.Type::PCH;
                            IF (SalesPerson."Phone No." <> '') AND (SalesPerson.Status = SalesPerson.Status::Enable) THEN
                                RecMobileNo.INSERT;
                        END;
                    END;
                END;
            //*****************-Insert Customer Phone No. Data-*****************
            FIELDNO("Phone No."):
                BEGIN
                    RecMobileNo.RESET;
                    RecMobileNo.SETRANGE("Link With", RecMobileNo."Link With"::Customer);
                    RecMobileNo.SETRANGE("Link Code", "No.");
                    RecMobileNo.SETFILTER(Type, '%1', RecMobileNo.Type::" ");
                    RecMobileNo.SETFILTER("Mobile No.", '%1', "Phone No.");
                    IF RecMobileNo.FINDFIRST THEN
                        RecMobileNo.DELETEALL;
                    IF "Phone No." <> '' THEN BEGIN
                        RecMobileNo.RESET;
                        RecMobileNo.SETRANGE("Link With", RecMobileNo."Link With"::Customer);
                        RecMobileNo.SETRANGE("Link Code", "No.");
                        RecMobileNo.SETFILTER(Type, '%1', RecMobileNo.Type::" ");
                        IF NOT RecMobileNo.FINDFIRST THEN BEGIN
                            RecMobileNo.INIT;
                            RecMobileNo."Mobile No." := "Phone No.";
                            RecMobileNo."Link With" := RecMobileNo."Link With"::Customer;
                            RecMobileNo."Link Code" := "No.";
                            RecMobileNo.Name := Name;
                            RecMobileNo."Send Mobile Communication" := TRUE;
                            RecMobileNo.date := TODAY;
                            RecMobileNo.Type := RecMobileNo.Type::" ";
                            RecMobileNo.INSERT;
                        END;
                    END;
                END;
            //*****************-Insert Supervisor Data-*****************
            FIELDNO("Govt. SP Resp."):
                BEGIN
                    SalesPerson.GET("Govt. SP Resp.");
                    RecMobileNo.RESET;
                    RecMobileNo.SETRANGE("Link With", RecMobileNo."Link With"::Customer);
                    RecMobileNo.SETRANGE("Link Code", "No.");
                    RecMobileNo.SETFILTER(Type, '%1', RecMobileNo.Type::"Govt.SP");
                    RecMobileNo.SETFILTER("Mobile No.", '%1', SalesPerson."Phone No.");
                    IF RecMobileNo.FINDFIRST THEN
                        RecMobileNo.DELETEALL;
                    IF "Govt. SP Resp." <> '' THEN BEGIN
                        RecMobileNo.RESET;
                        RecMobileNo.SETRANGE("Link With", RecMobileNo."Link With"::Customer);
                        RecMobileNo.SETRANGE("Link Code", "No.");
                        RecMobileNo.SETFILTER(Type, '%1', RecMobileNo.Type::"Govt.SP");
                        RecMobileNo.SETFILTER("Mobile No.", '%1', SalesPerson."Phone No.");
                        IF NOT RecMobileNo.FINDFIRST THEN BEGIN
                            RecMobileNo.INIT;
                            RecMobileNo."Mobile No." := SalesPerson."Phone No.";
                            RecMobileNo."Link With" := RecMobileNo."Link With"::Customer;
                            RecMobileNo."Link Code" := "No.";
                            RecMobileNo.Name := SalesPerson.Name;
                            RecMobileNo."Send Mobile Communication" := TRUE;
                            RecMobileNo.date := TODAY;
                            RecMobileNo.Type := RecMobileNo.Type::"Govt.SP";
                            IF (SalesPerson."Phone No." <> '') AND (SalesPerson.Status = SalesPerson.Status::Enable) THEN
                                RecMobileNo.INSERT;
                        END;
                    END;
                END;
            FIELDNO("Private SP Resp."):
                BEGIN
                    SalesPerson.GET("Private SP Resp.");
                    RecMobileNo.RESET;
                    RecMobileNo.SETRANGE("Link With", RecMobileNo."Link With"::Customer);
                    RecMobileNo.SETRANGE("Link Code", "No.");
                    RecMobileNo.SETFILTER(Type, '%1', RecMobileNo.Type::"Private SP");
                    RecMobileNo.SETFILTER("Mobile No.", '%1', SalesPerson."Phone No.");
                    IF RecMobileNo.FINDFIRST THEN
                        RecMobileNo.DELETEALL;
                    IF "Private SP Resp." <> '' THEN BEGIN
                        RecMobileNo.RESET;
                        RecMobileNo.SETRANGE("Link With", RecMobileNo."Link With"::Customer);
                        RecMobileNo.SETRANGE("Link Code", "No.");
                        RecMobileNo.SETFILTER(Type, '%1', RecMobileNo.Type::"Private SP");
                        RecMobileNo.SETFILTER("Mobile No.", '%1', SalesPerson."Phone No.");
                        IF NOT RecMobileNo.FINDFIRST THEN BEGIN
                            RecMobileNo.INIT;
                            RecMobileNo."Mobile No." := SalesPerson."Phone No.";
                            RecMobileNo."Link With" := RecMobileNo."Link With"::Customer;
                            RecMobileNo."Link Code" := "No.";
                            RecMobileNo.Name := SalesPerson.Name;
                            RecMobileNo."Send Mobile Communication" := TRUE;
                            RecMobileNo.date := TODAY;
                            RecMobileNo.Type := RecMobileNo.Type::"Private SP";
                            IF (SalesPerson."Phone No." <> '') AND (SalesPerson.Status = SalesPerson.Status::Enable) THEN
                                RecMobileNo.INSERT;
                        END;
                    END;
                END;
        END;
    end;

    procedure UpdateLogititute(PostCode: Code[10]; City: Text[30])
    var
        RecPostCode: Record "Post Code";
    begin
        RecPostCode.GET(PostCode, City);
        Longitude := RecPostCode.Longitude;
        Latitude := RecPostCode.Latitude;
        IF "Customer Type" <> '' THEN
            Zone := RecPostCode.Zone
        //Zone:='HOPROJ'
        ELSE
            Zone := RecPostCode.Zone;
        MODIFY;
    end;

    procedure UpdateLogititute1(PostCode: Code[10]; City: Text[30])
    var
        RecPostCode: Record "Post Code";
    begin
        RecPostCode.GET(PostCode, City);
        Longitude := RecPostCode.Longitude;
        Latitude := RecPostCode.Latitude;
        IF "Customer Type" <> '' THEN
            Zone := RecPostCode.Zone
        //Zone:='HOPROJ'
        ELSE
            Zone := RecPostCode.Zone;
    end;

    procedure GenerateNODNOCData()
    var
        AllowedNOC: Record "Allowed NOC";
        Customer: Record Customer;
        TCS: Record "Allowed NOC";
        Ass: Record "Assessee Code";
    begin
        // Customer.get(rec."No.");
        // IF Customer."GST Registration No." = '' THEN
        //     EXIT;
        IF Rec."P.A.N. No." = '' THEN
            Rec."P.A.N. No." := COPYSTR(Rec."GST Registration No.", 3, 10);

        if Rec."P.A.N. No." <> '' then begin
            Rec."Assessee Code" := GetAssesseeCodefromGSTNo(Rec."GST Registration No.");
            //Rec.Modify();
        end;

        IF Rec."Cust. Company Type" = 0 THEN
            CASE GetAssesseeCodefromGSTNo(Rec."GST Registration No.") OF
                'F':
                    Rec."Cust. Company Type" := Rec."Cust. Company Type"::Partnership;
                'C':
                    Rec."Cust. Company Type" := Rec."Cust. Company Type"::"Pvt. Ltd";
                'P':
                    Rec."Cust. Company Type" := Rec."Cust. Company Type"::Proprietorship;
            END;

    end;


    local procedure GetAssesseeCodefromGSTNo(GstNO: Code[20]): Code[10]
    var
        Assessee: Code[10];
    begin
        IF GstNO = '' THEN
            EXIT;
        IF STRLEN(GstNO) = 15 THEN BEGIN
            Assessee := COPYSTR("GST Registration No.", 6, 1);
            //MESSAGE(Assessee);
            CASE Assessee OF
                'C':
                    BEGIN
                        EXIT('COM');
                    END;
                'P':
                    BEGIN
                        EXIT('IND');
                    END;
                'H':
                    BEGIN
                        EXIT('HUF');
                    END;
                'F':
                    BEGIN
                        EXIT('FIRM');
                    END;
                'A':
                    BEGIN
                        EXIT('AOP');
                    END;
                'G':
                    BEGIN
                        EXIT('GOV');
                    END;
                'T':
                    BEGIN
                        EXIT('AOP');
                    END;
                ELSE
                    ERROR('Invalid GST No. %1', "No.");
            END;
        END;
    end;

    var
        staterec: Record State;
        DimValue: Record "Dimension Value";
        DefDim: Record "Default Dimension";
        GLSetup: Record "General Ledger Setup";
        ".........tri1.0": Integer;
        CustType: Record "Customer Type";
        Cityc: Text[30];
        statc: Text[30];
        contc: Text[30];
        VirtualNoSeriesMgt: Codeunit NoSeriesManagement;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        LocationRec: Record Location;
        I: Integer;

}

