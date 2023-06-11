tableextension 50137 tableextension50137 extends Vendor
{
    fields
    {
        /* modify("Fin. Charge Terms Code")
         {
             TableRelation = Indent;
         }*/ // 15578
        modify(Transporter)
        {
            Caption = 'Transporter';
        }
        modify(Address)// 15578
        {
            trigger OnBeforeValidate()
            begin
                "Vendor Address" := Address;//Ori Ut
            end;
        }
        modify("Address 2")// 15578
        {
            trigger OnBeforeValidate()
            begin
                "Vendor Address 2" := "Address 2";//Ori Ut
            end;
        }

        modify(City)// 15578
        {
            trigger OnBeforeValidate()
            begin
                "Vendor City" := City; //Ori ut
            end;
        }
        modify(Contact)// 15578
        {
            trigger OnBeforeValidate()
            begin
                "Vendor Contact" := Contact;//Ori ut
            end;
        }
        modify("Phone No.")// 15578
        {
            trigger OnBeforeValidate()
            begin
                "Vendor Phone No." := "Phone No.";//ori Ut
                GLSetup.GET;
                IF GLSetup."SMS Updatation" THEN
                    InsertSMSDetails(FIELDNO("Phone No."));


            end;
        }
        modify("Telex No.")// 15578
        {
            trigger OnBeforeValidate()
            begin
                "Vendor Telex No." := "Telex No.";//Ori ut
            end;
        }
        modify("Location Code")
        {
            trigger OnBeforeValidate()
            begin
                //mo tri1.0 customization no. 64 start
                //To add the dimension value as default dimension
                IF LocationRec.GET("Location Code") THEN BEGIN
                    GLSetup.GET;
                    GLSetup.TESTFIELD(GLSetup."Location Dimension Code");
                    defdim.INIT;
                    defdim."Table ID" := 23;
                    defdim."No." := "No.";
                    defdim."Dimension Code" := GLSetup."Location Dimension Code";
                    IF defdim.FIND THEN BEGIN
                        defdim."Dimension Value Code" := LocationRec.Code;
                        defdim."Value Posting" := defdim."Value Posting"::" ";
                        //defdim."Table Name" := TABLENAME; code blocked for upgradation
                        defdim.MODIFY;
                    END ELSE BEGIN
                        defdim."Dimension Value Code" := LocationRec.Code;
                        defdim."Value Posting" := defdim."Value Posting"::" ";
                        // defdim."Table Name" := TABLENAME;      code blocked for upgradation
                        defdim.INSERT;
                    END;
                END;
                //mo tri1.0 customization no. 64 end

            end;
        }

        modify("P.A.N. No.")
        {
            trigger OnBeforeValidate()
            begin
                IF (STRLEN("P.A.N. No.") <> 10) THEN
                    ERROR(Text16501);

            end;
        }

        modify("State Code")// 15578
        {
            trigger OnAfterValidate()
            begin
                //mo tri1.0 Customization no.64 start
                //To add the state dimension as default dimensions
                IF StateRec.GET("State Code") THEN BEGIN
                    GLSetup.GET;
                    GLSetup.TESTFIELD(GLSetup."State Dimension Code");
                    DefDim."Table ID" := 23;
                    DefDim."No." := "No.";
                    DefDim."Dimension Code" := GLSetup."State Dimension Code";
                    IF DefDim.FIND THEN BEGIN
                        DefDim."Dimension Value Code" := StateRec.Dimension;
                        DefDim."Value Posting" := DefDim."Value Posting"::" ";
                        //DefDim."Table Name" := TABLENAME;    code blocked for upgradation
                        DefDim.MODIFY;
                    END ELSE BEGIN
                        DefDim."Dimension Value Code" := StateRec.Dimension;
                        DefDim."Value Posting" := DefDim."Value Posting"::" ";
                        // DefDim."Table Name" := TABLENAME; code blocked for upgradation
                        DefDim.INSERT;
                    END;
                END;
                //mo tri1.0 Customization no.64 end

            end;
        }

        field(50003; "Vendor Classification"; Code[10])
        {
            Description = 'Customization No. 22';
            TableRelation = "Customer Type".Code WHERE(Type = FILTER(= Vendor));

            trigger OnValidate()
            begin
                //VendType is Declared as Record variable to table 50010 "Customer Type"
                //Cust 22 Start Vipul
                VendType.GET(VendType.Type::Vendor, "Vendor Classification");
                IF "Gen. Bus. Posting Group" = '' THEN
                    "Gen. Bus. Posting Group" := VendType."Gen. Bus. Posting Group";
                IF "Vendor Posting Group" = '' THEN
                    "Vendor Posting Group" := VendType."Vendor Posting Group";
                IF "VAT Bus. Posting Group" = '' THEN
                    "VAT Bus. Posting Group" := VendType."VAT Bus. Posting Group";
                /*   IF "Excise Bus. Posting Group" = '' THEN
                       "Excise Bus. Posting Group" := VendType."Excise Bus. Posting Group";
                   IF Structure = '' THEN
                       Structure := VendType.Structure;*/ // 15578
                "Tax Liable" := VendType."Tax Liable";
                MODIFY

                //Cust 22 End Vipul
            end;
        }
        field(50004; "Security Amount"; Decimal)
        {
            Description = 'Customization No. 22';
        }
        field(50005; "Security Date"; Date)
        {
            Description = 'Customization No. 22';
        }
        field(50006; Transporter1; Boolean)
        {
            Description = 'Customization No. 9';
        }
        field(50008; "PAN Ref. No."; Code[10])
        {
            Description = 'RM Added for eTDS';
        }
        field(50009; "PAN Status"; Option)
        {
            Description = 'RM Added for eTDS';
            OptionCaption = ',PANAPPLIED,PANINVALID,PANNOTAVBL';
            OptionMembers = ,PANAPPLIED,PANINVALID,PANNOTAVBL;
        }
        field(50023; "Pin Code"; Code[10])
        {
            Description = 'TRI';
        }
        field(50024; "Blocked Old"; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Payment,All';
            OptionMembers = " ",Payment,All;
        }
        field(50025; "Tax Registration No."; Code[20])
        {
            Description = 'TRI Karan';
        }
        field(50026; "Bank A/c"; Code[30])
        {
            Description = 'Kulbhushan';
        }
        field(50027; "Bank Account Name"; Text[50])
        {
            Description = 'Kulbhushan';
        }
        field(50028; "Bank Address"; Text[100])
        {
            Description = 'Kulbhushan';
        }
        field(50029; "Bank Address 2"; Text[50])
        {
            Description = 'Kulbhushan';
        }
        field(50030; "RTGS/NEFT Code"; Code[11])
        {
            Description = 'Kulbhushan';

            trigger OnValidate()
            begin
                IF (STRLEN("RTGS/NEFT Code") <> 11) THEN
                    ERROR('RTGS/NEFT Shoube be 11 Digit');
            end;
        }
        field(50031; "Vendor Address"; Text[70])
        {
            Description = 'Ori Ut';
        }
        field(50032; "Vendor Address 2"; Text[70])
        {
            Description = 'Ori Ut';
        }
        field(50033; "Vendor City"; Text[50])
        {
            Description = 'Ori Ut';
        }
        field(50034; "Vendor Contact"; Text[50])
        {
            Description = 'Ori Ut';
        }
        field(50035; "Vendor Phone No."; Text[30])
        {
            Description = 'Ori Ut';
        }
        field(50036; "Vendor Telex No."; Text[30])
        {
            Description = 'Ori Ut';
        }
        field(50037; "Create for Orient"; Boolean)
        {
            Description = 'MIPL,MSBS.Rao Dt. 03-10-11';
            Editable = false;
        }
        field(50038; "Create for Bell"; Boolean)
        {
            Description = 'MIPL,MSBS.Rao Dt. 03-10-11';
            Editable = false;
        }
        field(50039; "Emp Code"; Code[10])
        {
        }
        field(50040; "CST Tin"; Code[11])
        {
        }
        field(50041; PAYVEND; Code[20])
        {
            CalcFormula = Lookup(Vendor."No." WHERE("No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50042; "Vend. Company Type"; Option)
        {
            Description = 'Kulbhushan A.S 21.01.09';
            OptionCaption = ' ,Proprietorship,Partnership,Pvt. Ltd,Public Ltd';
            OptionMembers = " ",Proprietorship,Partnership,"Pvt. Ltd","Public Ltd";
        }
        field(50043; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPT'));
        }
        field(50044; Zone; Text[7])
        {
            CalcFormula = Lookup(State.Zone WHERE(Code = FIELD("State Code")));
            Enabled = true;
            FieldClass = FlowField;
        }
        field(50045; Grade; Text[10])
        {
        }
        field(50046; Dsgn; Text[50])
        {
        }
        field(50047; Section; Text[50])
        {
        }
        field(50048; Region; Option)
        {
            OptionCaption = ' ,North,East,South,West';
            OptionMembers = " ",North,East,South,West;
        }
        field(50049; DOJ; Date)
        {
        }
        field(50050; "GST No."; Code[15])
        {
        }
        field(50051; "State Desc"; Text[30])
        {
            CalcFormula = Lookup(State.Description WHERE(Code = FIELD("State Code")));
            FieldClass = FlowField;
        }
        field(50052; "Msme Code"; Code[12])
        {
        }
        field(50053; "Requested By"; Text[30])
        {
        }
        field(50054; "Micro Enterprises"; Boolean)
        {
        }
        field(50055; "Small Enterprises"; Boolean)
        {
        }
        field(50056; "Medium Enterprises"; Boolean)
        {
        }
        field(50057; "Creation Date"; Date)
        {
        }
        field(50058; "Landline No."; Text[10])
        {
        }
        field(50059; "A/C user E-mail"; Text[30])
        {
        }
        field(50060; "Financial Transaction"; Boolean)
        {
        }
        field(50061; "Morbi Location Code"; Code[10])
        {
        }
        field(50062; "Created By"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50063; "Bal on Balance Conf Date"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Balance';
            Editable = false;
            FieldClass = Normal;
        }
        field(50064; "Balance Conf Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50065; "Balance confirmation"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Balance confirmation" THEN
                    "Balance Conf Date" := TODAY
                ELSE
                    "Balance Conf Date" := 0D;
                "Bal on Balance Conf Date" := 0;
                "Vend Ledger Balance" := 0;
            end;
        }
        field(50066; "Vend Ledger Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50067; "Bank Beneficiary Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50068; "Beneficiary Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Saving,Current,Cash Credit';
            OptionMembers = " ",Saving,Current,"Cash Credit";
        }
        field(50070; "Morbi Inventory"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Temp Calcualtion';
        }
        field(50071; "194Q"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50072; "194Q Recived Data"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "Contact Mail ID"; Text[50])
        {
            Caption = 'E-Mail';
            DataClassification = ToBeClassified;
            Description = 'Contact Mail ID for Material Despatchedc.';
            ExtendedDatatype = EMail;
        }
        field(50080; Approved; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'MSVrn';

            trigger OnValidate()
            begin
                IF Approved = TRUE THEN BEGIN
                    "Blocked Vendor" := FALSE;
                    Blocked := Blocked::" ";
                END ELSE BEGIN
                    "Blocked Vendor" := TRUE;
                    Blocked := Blocked::All;
                END;
            end;
        }
        field(50081; "Approver ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'MSVrn';
            TableRelation = "User Setup"."User ID";
        }
        field(50082; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'MSVrn';
            OptionCaption = ' ,Sent for Approval,Approved,Rejected';
            OptionMembers = " ","Sent for Approval",Approved,Rejected;
        }
        field(50083; "Blocked Vendor"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'MSVrn';
        }
        field(85000; "Not Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        /*   key(Key22; "Vendor Classification", "No.")
           {
           }*/
        key(Key23; "Purchaser Code")
        {
        }
    }
    trigger OnAfterDelete()// 15578
    begin
        //mo tri1.0 Customization no.64 start
        GLSetup.GET;
        IF DimValue.GET(GLSetup."Vendor Dimension Code", "No.") THEN BEGIN
            DimValue.DELETE;
        END;

        IF DefDim.GET(23, "No.", GLSetup."Vendor Dimension Code") THEN BEGIN
            DefDim.DELETE;
        END;
        //mo tri1.0 Customization no.64 end

    end;

    trigger OnInsert()
    begin
        "Creation Date" := TODAY;
        "Created By" := USERID;

    end;


    trigger OnAfterInsert()// 15578
    begin
        "Creation Date" := TODAY;
        "Created By" := USERID;
        //To add the generated vendor no. as dimension value.
        GLSetUp.GET;
        GLSetUp.TESTFIELD(GLSetUp."Vendor Dimension Code");
        IF NOT DimValue.GET(GLSetUp."Vendor Dimension Code", "No.") THEN BEGIN
            DimValue.INIT;
            DimValue.VALIDATE("Dimension Code", GLSetUp."Vendor Dimension Code");
            DimValue.VALIDATE(Code, "No.");
            DimValue.VALIDATE(Name, "No.");
            DimValue.INSERT;
        END;

        //To add the dimension value as default dimension
        IF NOT DefDim.GET(23, "No.", GLSetUp."Vendor Dimension Code") THEN BEGIN
            DefDim.INIT;
            DefDim."Table ID" := 23;
            DefDim."No." := "No.";
            DefDim."Dimension Code" := GLSetUp."Vendor Dimension Code";
            DefDim."Dimension Value Code" := DimValue.Code;
            DefDim."Value Posting" := DefDim."Value Posting"::"Same Code";
            //DefDim."Table Name" := TABLENAME;    code blocked for upgradation
            Vend."Pay-to Vendor No." := "No.";
            DefDim.INSERT;
        END;
        //mo tri1.0 Customization no.64 end

        IF "Invoice Disc. Code" = '' THEN
            "Invoice Disc. Code" := "No.";
        "Pay-to Vendor No." := "No.";
    end;

    trigger OnAfterModify()// 15578
    begin
        //mo tri1.0 customization no. 64 start
        GLSetup.GET;
        GLSetup.TESTFIELD(GLSetup."Vendor Dimension Code");
        IF DimValue.GET(GLSetup."Vendor Dimension Code", "No.") THEN BEGIN
            DimValue.VALIDATE(Name, Name);
            DimValue.MODIFY;
        END;
        //mo tri1.0 customization no. 64 end

    end;

    trigger OnBeforeRename()// 15578
    begin
        //To add the generated customer no. as dimension value.
        GLSetup.GET;
        GLSetup.TESTFIELD(GLSetup."Vendor Dimension Code");
        IF DimValue.GET(GLSetup."Vendor Dimension Code", xRec."No.") THEN
            DimValue.DELETE;
        DimValue.INIT;
        DimValue.VALIDATE("Dimension Code", GLSetup."Vendor Dimension Code");
        DimValue.VALIDATE(Code, "No.");
        DimValue.VALIDATE(Name, "No.");
        DimValue.INSERT;

        //To add the dimension value as default dimension
        GLSetup.GET;
        GLSetup.TESTFIELD(GLSetup."Vendor Dimension Code");
        IF DefDim.GET(23, xRec."No.", GLSetup."Vendor Dimension Code") THEN
            DefDim.DELETE;
        DefDim.INIT;
        DefDim."Table ID" := 23;
        DefDim."No." := "No.";
        DefDim."Dimension Code" := GLSetup."Vendor Dimension Code";
        DefDim."Dimension Value Code" := DimValue.Code;
        DefDim."Value Posting" := DefDim."Value Posting"::" ";
        //DefDim."Table Name" := TABLENAME;   code blocked for upgradation
        DefDim.INSERT;
        //mo tri1.0 Customization no.64 end

    end;

    //Unsupported feature: Code Modification on "VendBlockedErrorMessage(PROCEDURE 6)".// Event N/F

    //procedure VendBlockedErrorMessage();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Transaction THEN
      Action := Text005
    ELSE
      Action := Text006;
    ERROR(Text007,Action,Vend2."No.",Vend2.Blocked);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4

      IF (UPPERCASE(USERID) <> 'admin') THEN
        ERROR(Text007,Action,Vend2."No.",Vend2.Blocked);
    */
    //end;

    procedure "--MIPL,MSBS.Rao---"()
    begin
    end;

    procedure CreateForBell(RecVend: Record Vendor; DocumentNO: Code[20])
    var
        RecVendor: Record Vendor;
        ToCompany: Text[50];
        VendorCode: Code[20];
        Err0001: Label 'Please contact your system administrator !!!';
    begin
        WITH RecVendor DO BEGIN
            IF COMPANYNAME = 'Orient Bell Limited' THEN BEGIN
                ToCompany := 'Orient Bell Limited';
                VendorCode := RecVendor."No.";
                RecVendor.CHANGECOMPANY(ToCompany);
                IF NOT RecVendor.GET(VendorCode) THEN BEGIN
                    RecVendor.TRANSFERFIELDS(Rec);
                    RecVendor.INSERT;
                END;
                RecVend.RESET;
                RecVend.SETRANGE("No.", DocumentNO);
                IF RecVend.FINDFIRST THEN BEGIN
                    RecVend."Create for Bell" := TRUE;
                    RecVend.MODIFY;
                END;
            END ELSE
                ERROR(Err0001);
        END;
    end;

    procedure CreateForOrient(RecVend: Record Vendor; DocumentNO: Code[20])
    var
        RecVendor: Record Vendor;
        ToCompany: Text[50];
        VendorCode: Code[20];
        Err0001: Label 'Please contact your system administrator !!!';
    begin
        WITH RecVendor DO BEGIN
            IF COMPANYNAME = 'Orient Bell Limited' THEN BEGIN
                ToCompany := 'Orient Bell Limited';
                VendorCode := RecVendor."No.";
                RecVendor.CHANGECOMPANY(ToCompany);
                IF NOT RecVendor.GET(VendorCode) THEN BEGIN
                    RecVendor.TRANSFERFIELDS(Rec);
                    RecVendor.INSERT;
                END;
                RecVend.RESET;
                RecVend.SETRANGE("No.", DocumentNO);
                IF RecVend.FINDFIRST THEN BEGIN
                    RecVend."Create for Orient" := TRUE;
                    RecVend.MODIFY;
                END;
            END ELSE
                ERROR(Err0001);
        END;
    end;

    procedure CreateForAll(RecVend: Record Vendor; DocumentNO: Code[20])
    var
        RecVendor: Record Vendor;
        ToCompany: Text[50];
        RecCompany: Record Company;
        VendorCode: Code[20];
        Err0001: Label 'Please contact your system administrator !!!';
    begin
        WITH RecVendor DO BEGIN
            IF COMPANYNAME = 'Orient Bell Limited' THEN BEGIN
                IF RecCompany.FINDFIRST THEN BEGIN
                    REPEAT
                        ToCompany := RecCompany.Name;
                        VendorCode := RecVendor."No.";
                        RecVendor.CHANGECOMPANY(ToCompany);
                        IF NOT RecVendor.GET(VendorCode) THEN BEGIN
                            RecVendor.TRANSFERFIELDS(Rec);
                            RecVendor.INSERT;
                        END;
                    UNTIL RecCompany.NEXT = 0;
                END;
                RecVend.RESET;
                RecVend.SETRANGE("No.", DocumentNO);
                IF RecVend.FINDFIRST THEN BEGIN
                    RecVend."Create for Orient" := TRUE;
                    RecVend."Create for Bell" := TRUE;
                    RecVend.MODIFY;
                END;
            END ELSE
                ERROR(Err0001);
        END;
    end;

    local procedure GetVend(VendNo: Code[20])
    begin
        IF VendNo <> Vend."No." THEN
            Vend.GET(VendNo);
    end;

    procedure InsertSMSDetails(CurrentFieldNo: Integer)
    var
        RecMobileNo: Record "SMS - Mobile No.";
        SalesPerson: Record "Salesperson/Purchaser";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
    begin
        CASE CurrentFieldNo OF
            //*****************-Insert Sales Person Data-*****************

            FIELDNO("Purchaser Code"):
                BEGIN
                    IF SalespersonPurchaser.GET("Purchaser Code") THEN;
                    RecMobileNo.RESET;
                    RecMobileNo.SETRANGE("Link With", RecMobileNo."Link With"::Vendor);
                    RecMobileNo.SETRANGE("Link Code", "No.");
                    RecMobileNo.SETFILTER(Type, '%1', RecMobileNo.Type::"Sales Person");
                    RecMobileNo.SETFILTER("Mobile No.", '%1', SalespersonPurchaser."Phone No.");
                    IF RecMobileNo.FINDFIRST THEN
                        RecMobileNo.DELETEALL;

                    IF ("Purchaser Code" <> '') THEN
                        RecMobileNo.RESET;
                    RecMobileNo.SETRANGE("Link With", RecMobileNo."Link With"::Vendor);
                    RecMobileNo.SETRANGE("Link Code", "No.");
                    RecMobileNo.SETFILTER(Type, '%1', RecMobileNo.Type::"Sales Person");
                    IF NOT RecMobileNo.FINDFIRST THEN BEGIN
                        RecMobileNo.INIT;
                        RecMobileNo."Mobile No." := SalespersonPurchaser."Phone No.";
                        RecMobileNo."Link With" := RecMobileNo."Link With"::Vendor;
                        RecMobileNo."Link Code" := "No.";
                        RecMobileNo.Name := SalespersonPurchaser.Name;
                        RecMobileNo."Send Mobile Communication" := TRUE;
                        RecMobileNo.date := TODAY;
                        RecMobileNo.Type := RecMobileNo.Type::"Sales Person";
                        IF (SalespersonPurchaser."Phone No." <> '') AND (SalespersonPurchaser.Status = SalespersonPurchaser.Status::Enable) THEN
                            RecMobileNo.INSERT;
                    END;
                END;
            //*****************-Insert Customer Phone No. Data-*****************
            FIELDNO("Phone No."):
                BEGIN
                    RecMobileNo.RESET;
                    RecMobileNo.SETRANGE("Link With", RecMobileNo."Link With"::Vendor);
                    RecMobileNo.SETRANGE("Link Code", "No.");
                    RecMobileNo.SETFILTER(Type, '%1', RecMobileNo.Type::" ");
                    RecMobileNo.SETFILTER("Mobile No.", '%1', "Phone No.");
                    IF RecMobileNo.FINDFIRST THEN
                        RecMobileNo.DELETEALL;
                    IF "Phone No." <> '' THEN BEGIN
                        RecMobileNo.RESET;
                        RecMobileNo.SETRANGE("Link With", RecMobileNo."Link With"::Vendor);
                        RecMobileNo.SETRANGE("Link Code", "No.");
                        RecMobileNo.SETFILTER(Type, '%1', RecMobileNo.Type::" ");
                        IF NOT RecMobileNo.FINDFIRST THEN BEGIN
                            RecMobileNo.INIT;
                            RecMobileNo."Mobile No." := "Phone No.";
                            RecMobileNo."Link With" := RecMobileNo."Link With"::Vendor;
                            RecMobileNo."Link Code" := "No.";
                            RecMobileNo.Name := Name;
                            RecMobileNo."Send Mobile Communication" := TRUE;
                            RecMobileNo.date := TODAY;
                            RecMobileNo.Type := RecMobileNo.Type::" ";
                            RecMobileNo.INSERT;
                        END;
                    END;
                END;
        END;
    end;

    procedure GenerateNODNOCData()
    var
        // 15578  NODNOCHeader: Record "13786";
        AllowedSection: Record "Allowed Sections";
        gg: page "Vendor Card";
    begin
        IF Rec."GST Registration No." = '' THEN
            EXIT;
        if Rec."P.A.N. No." <> '' then
            Rec."Assessee Code" := GetAssesseeCodefromGSTNo();

        AllowedSection.Reset();
        AllowedSection.SetRange("Vendor No", Rec."No.");
        AllowedSection.SetRange("TDS Section", '194Q');
        if not AllowedSection.FindFirst() then begin
            AllowedSection.Init();
            AllowedSection."Vendor No" := "No.";
            AllowedSection."TDS Section" := '194Q';
            /* AllowedSection.Validate("Vendor No", Rec."No.");
            AllowedSection.Validate("TDS Section", '194Q'); */
            AllowedSection.Insert();

        end;


        /*  NODNOCHeader.SETFILTER(Type, '%1', NODNOCHeader.Type::Vendor);
          NODNOCHeader.SETFILTER("No.", '%1', Vendor."No.");
          IF NOT NODNOCHeader.FINDFIRST THEN BEGIN
              NODNOCHeader.INIT;
              NODNOCHeader.Type := NODNOCHeader.Type::Vendor;
              NODNOCHeader."No." := Vendor."No.";
              NODNOCHeader.Name := Vendor.Name;
              NODNOCHeader."Assesse Code" := GetAssesseeCodefromGSTNo(Vendor);
              NODNOCHeader.INSERT;
              GenerateNODNOCLines(NODNOCHeader);
          END ELSE BEGIN
              NODNOCHeader.RESET;
              NODNOCHeader.SETFILTER(Type, '%1', NODNOCHeader.Type::Vendor);
              NODNOCHeader.SETFILTER("No.", '%1', Vendor."No.");
              IF NODNOCHeader.FINDFIRST THEN
                  GenerateNODNOCLines(NODNOCHeader);
          END;*/ // 15578
    end;

    /*  local procedure GenerateNODNOCLines(NODNOCHeader: Record "13786")
      var
          NODNOCLines: Record "13785";
      begin
          NODNOCLines.SETFILTER(Type, '%1', NODNOCHeader.Type);
          NODNOCLines.SETFILTER("No.", '%1', NODNOCHeader."No.");
          NODNOCLines.SETFILTER("NOD/NOC", '%1', '194Q');
          IF NODNOCLines.FINDFIRST THEN
              NODNOCLines.DELETE;

          NODNOCLines.INIT;
          NODNOCLines.Type := NODNOCHeader.Type;
          NODNOCLines."No." := NODNOCHeader."No.";
          NODNOCLines.TDS := TRUE;
          NODNOCLines.VALIDATE("NOD/NOC", '194Q');
          //NODNOCLines.Type := NODNOCHeader.Type;
          NODNOCLines.INSERT;
      end;*/ // 15578

    local procedure GetAssesseeCodefromGSTNo(): Code[10]
    var
        Assessee: Code[10];
    begin
        IF (Rec."GST Registration No." = '') AND (rec."GST No." = '') THEN
            EXIT;
        IF STRLEN(Rec."GST Registration No.") = 15 THEN BEGIN
            Assessee := COPYSTR(Rec."GST Registration No.", 6, 1);
            //  MESSAGE(Assessee);
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
                    IF (Rec."Vendor Posting Group" = 'EMP') OR (rec."Gen. Bus. Posting Group" = 'EXIM') THEN
                        EXIT;

                    ERROR('Invalid GST No. %1', Rec."No.");
            END;
        END;
    end;

    procedure ArchiveVendor(var Vendor: Record Vendor; ArchUser: Code[50])
    var
        VendorMasterArchive: Record "Vendor Master Archive";
        VerNo: Integer;
    begin
        IF Vendor.ISEMPTY THEN EXIT;

        VendorMasterArchive.RESET;
        VendorMasterArchive.SETFILTER("No.", '%1', Vendor."No.");
        IF VendorMasterArchive.FINDLAST THEN
            VerNo := VendorMasterArchive."Version No." + 1
        ELSE
            VerNo := 1;

        CLEAR(VendorMasterArchive);
        VendorMasterArchive.INIT;
        VendorMasterArchive.TRANSFERFIELDS(Vendor);
        VendorMasterArchive."Version No." := VerNo;
        VendorMasterArchive."Archive Date Time" := CURRENTDATETIME;
        VendorMasterArchive."Archive By" := ArchUser;
        VendorMasterArchive.INSERT;
    end;


    var
        Text16502: Label 'TIN No. Should be Eleven Digit.';
        VendType: Record "Customer Type";
        Vend: Record Vendor;
        Vendserv: Record "SMS - Mobile No.";
        StateRec: Record State;
        Assessee: Code[10];
        DefDim: Record "Default Dimension";
        "...tri1.0": Integer;
        GLSetup: Record "General Ledger Setup";
        DimValue: Record "Dimension Value";
        LocationRec: Record Location;
        Text16501: Label 'PAN No. Should be Ten Digit.';

}

