tableextension 50046 tableextension50046 extends Location
{
    fields
    {
        field(50000; "Main Location"; Code[10])
        {
            Description = 'Customization No. 64';

            trigger OnValidate()
            begin
                //Vipul Tri1.0
                IF "Main Location" <> '' THEN
                    "Related Location Code" := "Main Location"
                ELSE
                    "Related Location Code" := Code;
                //Vipul Tri1.0
            end;
        }
        field(50001; "Location Dimension"; Code[20])
        {
            Description = 'Customization No. 64';

            trigger OnLookup()
            var
                "....tri1.0": Integer;
                GLSetup: Record "General Ledger Setup";
                DimValue: Record "Dimension Value";
            begin
                //mo tri1.0 Customization no.64 start
                GLSetup.GET;
                DimValue.SETFILTER("Dimension Code", GLSetup."Location Dimension Code");
                IF DimValue.FIND('-') THEN
                    IF PAGE.RUNMODAL(PAGE::"Dimension Value List", DimValue) = ACTION::LookupOK THEN;
                //mo tri1.0 Customization no.64 end
            end;
        }
        field(50002; "C.S.T. No."; Code[20])
        {
            Description = 'report I5';
        }
        field(50003; "U.P.T.T. No."; Code[20])
        {
            Description = 'report I5';
        }
        field(50005; "Related Location Code"; Code[20])
        {
        }
        field(50006; "Form Code"; Code[10])
        {
            // 15578 TableRelation = "Form Codes";
        }
        field(50007; Structure; Code[10])
        {
            // 15578 TableRelation = "Structure Header";

            trigger OnValidate()
            var
                /*StrDetails: Record "13793";
                StrOrderDetails: Record "13794";
                StrOrderLines: Record "13795";*/
                SaleLines: Record "Sales Line";
            begin
            end;
        }
        field(50008; "Warehouse Location"; Boolean)
        {
            Description = 'report 50010';
        }
        field(50009; "Customer Price Group"; Code[10])
        {
            Description = 'ND';
            TableRelation = "Customer Price Group";
        }
        field(50010; Pay; Option)
        {
            Description = 'TRI A.S 07.11.08';
            OptionMembers = " ","To Pay","To be billed";
        }
        field(50011; Comment; Text[30])
        {
            Description = 'TRI A.S 31.12.08';
        }
        field(50012; "Shipment No. Series"; Code[20])
        {
            Description = 'TRI A.S 31.12.08';
            TableRelation = "No. Series";

            trigger OnLookup()
            begin
                InvtSetup.GET;
                TestNoSeries1;
                IF NoSeriesMgt.LookupSeries(InvtSetup."Posted Transfer Shpt. Nos.", "Shipment No. Series") THEN
                    VALIDATE("Shipment No. Series");
            end;
        }
        field(50013; "Production Plant Code"; Code[2])
        {
            Description = 'TRI S.R 230310 - New field Add';

            trigger OnLookup()
            begin
                InvtSetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InvtSetup."Plant Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Production Plant Code", DimensionValue.Code);
            end;
        }
        field(50014; "COCO DEPO"; Code[20])
        {
            Description = '//Ori Uttar 050810';
            TableRelation = Location;
        }
        field(50015; "Gen. Bus. Posting Group"; Code[20])
        {
            Description = 'Ori Uttar 130710';
            TableRelation = "Gen. Business Posting Group";
        }
        field(50016; "Production Location"; Boolean)
        {
            Description = 'TRI DG 040910';
        }
        field(50017; "No. Series"; Code[10])
        {
            Description = 'TRI NP 151110- New Field Add';
            TableRelation = "No. Series";
        }
        field(50018; "Is COCO"; Boolean)
        {
            Description = 'Ori Ut';
        }
        field(50019; "Detail of Contact Person"; Text[70])
        {
            Description = 'Kulbhushan Sharma';
        }
        field(50020; "Bank Name"; Text[50])
        {
            Caption = 'Bank Name';
        }
        field(50021; "Bank Branch No."; Text[20])
        {
            Caption = 'Bank Branch No.';
        }
        field(50022; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
        }
        field(50023; "Excisable Location"; Boolean)
        {
        }
        field(50024; "Customer Price Group(Project)"; Code[10])
        {
            Description = 'MSBS.Rao //For Porject';
            TableRelation = "Customer Price Group";
        }
        field(50025; Plant; Boolean)
        {
            Description = 'kbs 151112 for SFS software';
        }
        field(50026; Depot; Boolean)
        {
            Description = 'kbs 151112 for SFS software';
        }
        field(50027; "Plant Code"; Code[2])
        {
            Description = 'MS-PB';
        }
        field(50028; "State Code Desc"; Text[30])
        {
            CalcFormula = Lookup(State.Description WHERE(Code = FIELD("State Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50029; "Contact Name"; Text[20])
        {
        }
        field(50030; "Location Name"; Text[30])
        {
            Description = 'Field is for Mobile Obly';
        }
        field(50031; "Pin Code"; Code[7])
        {
        }
        field(50032; Blocked; Boolean)
        {
        }
        field(50033; "Tableau Location"; Boolean)
        {
        }
        field(50034; IEC; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(60060; "End Use Item Issue Template"; Code[18])
        {
            Editable = false;
            TableRelation = "Item Journal Template".Name;
        }
        field(60061; "End Use Item Issue Batch"; Code[18])
        {
            Editable = false;
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("End Use Item Issue Template"),
                                                             "Template Type" = CONST(Item));
        }
        field(60062; "Production Line"; Boolean)
        {
        }
        field(60063; "AD Applicable"; Boolean)
        {
            Description = 'MSNK 110415';
        }
        field(60064; "Transfer Price List"; Code[20])
        {
            TableRelation = "Customer Price Group" WHERE("Transfer Price List" = CONST(true));
        }
        field(60065; "Auto Indent Creation ID"; Code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(60066; "Last Date Modified"; Date)
        {
        }
        field(60067; "Prod. Units"; Option)
        {
            OptionCaption = ' ,SKD,DORA,Hoskotte';
            OptionMembers = " ",SKD,DORA,Hoskotte;
        }
        field(60068; "Sales Territory"; Text[20])
        {
        }
        field(60069; "Area"; Decimal)
        {
        }
        field(60070; ZH; Code[10])
        {
        }
        field(60071; PCH; Code[10])
        {
        }
        field(60072; stores; Boolean)
        {
        }
        field(60073; "Store Location"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,SKD,DRA,HSK';
            OptionMembers = " ",SKD,DRA,HSK;
        }
        field(70000; "E-InvGenerateURL"; Text[200])
        {
            DataClassification = ToBeClassified;
            Description = 'Keshav30Sep2020';
        }
        field(70001; "E-InvCancelURL"; Text[200])
        {
            DataClassification = ToBeClassified;
            Description = 'Keshav30Sep2020';
        }
        field(70002; "E-InvPrintURL"; Text[200])
        {
            DataClassification = ToBeClassified;
            Description = 'Keshav30Sep2020';
        }
        field(70003; Username; Text[40])
        {
            DataClassification = ToBeClassified;
            Description = 'Keshav30Sep2020';
        }
        field(70004; Password; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Keshav30Sep2020';
        }
        field(70005; "E-InvAuthenticateURL"; Text[200])
        {
            DataClassification = ToBeClassified;
            Description = 'Keshav30Sep2020';
        }
        field(70006; apiaccesskey; Text[200])
        {
            DataClassification = ToBeClassified;
            Description = 'Keshav30Sep2020';
        }
        field(70007; "Local CP Count"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70008; "Pan India CP Count"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70009; "Local Sales Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70010; "Pan India Sales Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70020; "Budget No. Series (Regular)"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(70021; "Budget Posting No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(70030; "Budget No. Series (Non-Regula)"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(70031; "Bud. No. Post Series(Non-Reg.)"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(70040; "Budget No. Series(Disposal)"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(70045; "Bud. No. Post Series(Disposal)"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(85000; "Not Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(85001; "Delete Reservation Before Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        /* key(Key4; "Related Location Code", "Code")
         {
         }*/
        key(Key5; City, "Code")
        {
        }
        /*key(Key6; "State Code")
        {
        }*/
        key(Key7; ZH, PCH)
        {
        }
    }


    trigger OnAfterDelete()// 15578
    begin
        //mo tri1.0 Customization no.64 start
        GLSetUp.GET;
        IF DimValue.GET(GLSetUp."Location Dimension Code", Code) THEN BEGIN
            DimValue.DELETE;
        END;
        //mo tri1.0 Customization no.64 end

        //end;

    end;


    trigger OnBeforeInsert()// 15578
    begin
        //mo tri1.0 Customization no.64 start
        //To add the generated location code as dimension value.
        GLSetUp.GET;
        GLSetUp.TESTFIELD(GLSetUp."Location Dimension Code");
        IF NOT DimValue.GET(GLSetUp."Location Dimension Code", Code) THEN BEGIN
            DimValue.INIT;
            DimValue.VALIDATE("Dimension Code", GLSetUp."Location Dimension Code");
            DimValue.VALIDATE(Code, Code);
            DimValue.VALIDATE(Name, Code);
            DimValue.INSERT;
            "Location Dimension" := DimValue.Code;
        END;
        //mo tri1.0 Customization no.64 end

        //Vipul Tri1.0
        IF "Main Location" <> '' THEN
            "Related Location Code" := "Main Location"
        ELSE
            "Related Location Code" := Code;
        //Vipul Tri1.0

    end;

    trigger OnBeforeModify()// 15578
    begin
        "Last Date Modified" := TODAY;

        //mo tri1.0 customization no. 64 start
        GLSetUp.GET;
        GLSetUp.TESTFIELD(GLSetUp."Location Dimension Code");
        IF DimValue.GET(GLSetUp."Location Dimension Code", Code) THEN BEGIN
            DimValue.VALIDATE(Name, Name);
            DimValue.MODIFY;
        END;
        //mo tri1.0 Customization no.64 end

    end;

    trigger OnBeforeRename()// 15578    
    begin
        //mo tri1.0 Customization no.64 start
        GLSetUp.GET;
        GLSetUp.TESTFIELD(GLSetUp."Location Dimension Code");
        IF DimValue.GET(GLSetUp."Location Dimension Code", xRec.Code) THEN
            DimValue.DELETE;
        DimValue.INIT;
        DimValue.VALIDATE("Dimension Code", GLSetUp."Location Dimension Code");
        DimValue.VALIDATE(Code, Code);
        DimValue.VALIDATE(Name, Code);
        DimValue.INSERT;
        "Location Dimension" := DimValue.Code;
        //mo tri1.0 Customization no.64 end

    end;

    procedure GetLocationFilter(var LocationFilter: Code[10]; var LocationToCompare: Code[10]): Boolean
    var
        Location1: Record Location;
        Exists: Boolean;
    begin
        //MESSAGE('%1--%2',LocationFilter,LocationToCompare);
        Location1.RESET;
        IF Location1.FIND('-') THEN
            REPEAT
                IF Location1."Main Location" = LocationFilter THEN
                    Location1.MARK(TRUE);
            UNTIL Location1.NEXT = 0;

        IF Location1.GET(LocationFilter) THEN BEGIN
            Location1.MARK(TRUE);
            //MESSAGE('MARK(TRUE)');
        END;
        Location1.MARKEDONLY(TRUE);

        IF Location1.FIND('-') THEN
            REPEAT
                IF Location1.Code = LocationToCompare THEN BEGIN
                    EXIT(TRUE);
                END;
            UNTIL Location1.NEXT = 0;
        //EXIT(FALSE);
    end;

    local procedure TestNoSeries1(): Boolean
    begin
        InvtSetup.TESTFIELD("Posted Transfer Shpt. Nos.");
    end;

    procedure GetLocationFilter1(var LocationToCompare: Code[10]): Boolean
    var
        Location1: Record Location;
        Exists: Boolean;
    begin
        Location1.RESET;

        IF Location1.FIND('-') THEN
            REPEAT
                IF Location1."Use As In-Transit" = FALSE THEN
                    Location1.MARK(TRUE);
            UNTIL Location1.NEXT = 0;

        Location1.MARKEDONLY(TRUE);

        IF Location1.FIND('-') THEN
            REPEAT
                IF Location1.Code = LocationToCompare THEN
                    EXIT(TRUE);
            UNTIL Location1.NEXT = 0;
    end;

    var
        "......tri1.0": Integer;
        GLSetUp: Record "General Ledger Setup";
        DimValue: Record "Dimension Value";
        DefDim: Record "Default Dimension";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimensionValue: Record "Dimension Value";
        InvtSetup: Record "Inventory Setup";
}

