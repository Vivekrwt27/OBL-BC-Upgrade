tableextension 50220 tableextension50220 extends "Transfer Header"
{
    fields
    {
        /* modify(Structure)
         {
             TableRelation = "Structure Header" WHERE("Structure Type" = FILTER("Transfer|Others"),
                                                       "Tax Abatement" = FILTER(false));
         }*/ // 15578



        modify("Transfer-from Code")
        {
            trigger OnAfterValidate()
            begin
                VALIDATE("Shortcut Dimension 1 Code", "Transfer-from Code"); //6700 Team
                IF Location.GET("Transfer-from Code") THEN BEGIN
                    Location.TESTFIELD("GST Input Service Distributor", FALSE);
                    IF Location."Bonded warehouse" THEN
                        TESTFIELD("Load Unreal Prof Amt on Invt.", FALSE);
                    "Shipment No. Series" := Location."Shipment No. Series";//TRI A.S 31.12.08
                    IF Location."State Code" <> '' THEN
                        "Transfer-from State" := Location."State Code"
                    ELSE
                        ERROR(Text0004, "Transfer-from Code");
                    //mo tri1.0 customization no. 64 end
                    //ND Tri Start Cust 38
                    IF (xRec."Transfer-from Code" <> '') AND ("Transfer-from Code" <> '') THEN BEGIN
                        UserAccess := 6;
                        Permissions.Type(UserAccess, xRec."Transfer-from Code");
                        Permissions.Type(UserAccess, "Transfer-from Code");
                    END;
                    IF Status = Status::Open THEN BEGIN
                        GeneralLedgerSetup.RESET;
                        GeneralLedgerSetup.FIND('-');
                        Location1.RESET;
                        Location1.SETFILTER(Location1.Code, "Transfer-from Code");
                        FromLocation := Location1."Main Location";
                        Location1.RESET;
                        Location1.SETFILTER(Location1.Code, "Transfer-to Code");
                        ToLocation := Location1."Main Location";

                        IF ToLocation = FromLocation THEN BEGIN
                            Location1.RESET;
                            Location1.SETFILTER(Location1.Code, "Transfer-from Code");
                        END ELSE BEGIN
                            Location1.RESET;
                            Location1.SETFILTER(Location1.Code, ToLocation);
                        END;
                        IF Location1.FIND('-') THEN BEGIN
                            VALIDATE("Shortcut Dimension 1 Code", Location1."Location Dimension"); //TEAM::3333
                            VALIDATE("Shortcut Dimension 8 Code", "Transfer-from State"); //TEAM::3333
                        END;
                    END;
                    //ND Tri End Cust 38

                    //ND Tri1.0 Start
                    IF Location.GET("Transfer-from Code") THEN
                        "From Main Location" := Location."Main Location";
                    //ND Tri1.0 End

                    //mo tri1.0 Customization no.64 start
                    IF GeneralLedgerSetup.GET THEN
                        IF StateVar.GET("Transfer-from State") THEN BEGIN
                        END;



                end;
            end;
        }


        modify("Transfer-to Code")// 15578
        {
            trigger OnAfterValidate()
            begin
                UpdatePriceList; //MSKS
                IF Confirmed THEN BEGIN
                    IF Location.GET("Transfer-to Code") THEN BEGIN
                        Pay := Location.Pay; //TRI A.S 07.11.08 Code Added
                        "Bill To  Pin Code" := Location."Pin Code";

                        "Location Comment" := Location.Comment; //TRI A.S 31.12.08 Code Added

                        //mo tri1.0 customization no. 64 start
                        IF Location."State Code" <> '' THEN
                            "Transfer-to State" := Location."State Code"
                        ELSE
                            ERROR(Text0004, "Transfer-from Code");
                        //mo tri1.0 customization no. 64 end
                        // VALIDATE("Form Code", Location."Form Code"); //Vipul Tri1.0
                        // VALIDATE(Structure, Location.Structure);     //Vipul Tri1.0
                        //ND Tri Start Cust 38
                        IF (xRec."Transfer-to Code" <> '') AND ("Transfer-to Code" <> '') THEN BEGIN
                            UserAccess := 7;
                            Permissions.Type(UserAccess, xRec."Transfer-to Code");
                            Permissions.Type(UserAccess, "Transfer-to Code");
                        END;
                        //ND Tri End Cust 38

                        //ND Tri1.0 Start
                        IF Location.GET("Transfer-to Code") THEN
                            "To Main Location" := Location."Main Location";

                        //ND Tri1.0 End


                    end;
                end;
            end;
        }


        modify("Posting Date")
        {
            trigger OnBeforeValidate()
            begin
                //Vipul Tri1.0 start
                TransLine.RESET;
                TransLine.SETFILTER(TransLine."Document No.", '%1', "No.");
                IF TransLine.FIND('-') THEN
                    REPEAT
                        TransLine."Posting Date" := "Posting Date";
                        TransLine.MODIFY;
                    UNTIL TransLine.NEXT = 0;
                //Vipul Tri1.0 end

            end;
        }

        field(50000; Purpose; Text[50])
        {
            Description = 'New Field Added For Information Point Only';
        }
        field(50001; "Transporter's Name"; Code[20])
        {
            Description = 'report 54 - S2';
            TableRelation = Vendor WHERE(Transporter1 = FILTER(false));

            trigger OnValidate()
            var
                Vendorrec: Record Vendor;
            begin
                IF Vendorrec.GET("Transporter's Name") THEN
                    "Transporter Name" := Vendorrec.Name
                ELSE
                    "Transporter Name" := '';
            end;
        }
        field(50002; "GR No."; Code[20])
        {
            Description = 'report 54 - S2';
        }
        field(50003; "GR Date"; Date)
        {
            Description = 'report 54 - S2';
        }
        field(50004; "Truck No."; Code[20])
        {
            Description = 'report 54 - S2';
        }
        field(50005; "Insurance Amount"; Decimal)
        {
            Description = 'Report 107';
        }
        field(50006; "Transfer-from State"; Code[20])
        {
            TableRelation = State.Code;
        }
        field(50007; "Transfer-to State"; Code[20])
        {
            TableRelation = State.Code;
        }
        field(50008; "From Main Location"; Code[10])
        {
        }
        field(50009; "To Main Location"; Code[10])
        {
        }
        field(50017; "Loading Inspector"; Text[30])
        {
            Description = 'Report 113 N-10A';
        }
        field(50018; "Customer Price Group"; Code[20])
        {
            TableRelation = "Customer Price Group".Code;

            trigger OnValidate()
            begin
                IF ("Customer Price Group" <> xRec."Customer Price Group") AND (xRec."Customer Price Group" <> '') THEN
                    MESSAGE('To update price in the lines you have to validate unit of measure code again.');
            end;
        }
        field(50019; "Transit Document"; Boolean)
        {
        }
        field(50020; "Locked Order"; Boolean)
        {
        }
        field(50021; "Transfer order Status"; Option)
        {
            Editable = true;
            OptionMembers = Open,Released;
        }
        field(50022; "Transporter Name"; Text[30])
        {
            Editable = false;
        }
        field(50023; "Qty in Sq Mtr"; Decimal)
        {
            CalcFormula = Sum("Transfer Line"."Qty in Sq. Mt." WHERE("Document No." = FIELD("No."),
                                                                      "Derived From Line No." = CONST(0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50024; "Total Weight"; Decimal)
        {
            CalcFormula = Sum("Transfer Line"."Gross Weight" WHERE("Document No." = FIELD("No."),
                                                                    "Derived From Line No." = CONST(0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50025; "Total Qty"; Decimal)
        {
            CalcFormula = Sum("Transfer Line".Quantity WHERE("Document No." = FIELD("No."),
                                                              "Derived From Line No." = CONST(0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50026; "Shipment No. Series"; Code[20])
        {
            TableRelation = "No. Series";

            trigger OnLookup()
            begin
                // ND
                InvtSetup.GET;
                //ND
                TestNoSeries1;
                IF NoSeriesMgt.LookupSeries(InvtSetup."Posted Transfer Shpt. Nos.", "Shipment No. Series") THEN
                    VALIDATE("Shipment No. Series");
            end;

            trigger OnValidate()
            var
                location: Record Location;
            begin
                //TRI A.S 31.12.08 Code Start
                IF location.GET("Transfer-from Code") THEN BEGIN
                    IF ("Shipment No. Series" <> location."Shipment No. Series") AND (location."Shipment No. Series" <> '') THEN BEGIN
                        IF CONFIRM(Tritext001, TRUE, location."Shipment No. Series") THEN BEGIN
                        END
                        ELSE
                            VALIDATE("Shipment No. Series", location."Shipment No. Series")
                    END;
                END;
                //TRI A.S 31.12.08 Code End
            end;
        }
        field(50027; "SalesPerson Code"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            begin
                //mo Tri1.0 start
                IF GLSetup.GET THEN
                    IF SalesPersonPurchaser.GET("SalesPerson Code") THEN BEGIN
                        /*IF NOT DocumentDimensions.GET(DATABASE::"Transfer Header",DocumentDimensions."Document Type"::"Transfer Order",
                        "No.",0,GLSetup."Employee Dimension Code")
                          THEN BEGIN
                           DocumentDimensions.INIT;
                           DocumentDimensions."Table ID" := DATABASE::"Transfer Header";
                           DocumentDimensions."Document Type" := DocumentDimensions."Document Type"::"Transfer Order";
                           DocumentDimensions."Document No." := "No.";
                           DocumentDimensions."Line No." := 0;
                           DocumentDimensions."Dimension Code" := GLSetup."Employee Dimension Code";
                           DocumentDimensions."Dimension Value Code" := SalesPersonPurchaser.Dimension;
                           DocumentDimensions.INSERT(TRUE);
                         END
                        ELSE BEGIN
                         IF DocumentDimensions.GET(DATABASE::"Transfer Header",DocumentDimensions."Document Type"::"Transfer Order"
                          ,"No.",0,GLSetup."Employee Dimension Code")
                         THEN BEGIN
                           DocumentDimensions."Dimension Value Code" := SalesPersonPurchaser.Dimension;
                           DocumentDimensions.MODIFY;
                         END;
                        END;*/ //Code Code for upgrade
                    END;
                //mo tri1.0 end

            end;
        }
        field(50028; "Qty. To Ship"; Decimal)
        {
            CalcFormula = Sum("Transfer Line"."Qty. to Ship" WHERE("Document No." = FIELD("No."),
                                                                    "Derived From Line No." = CONST(0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50029; "External Transfer"; Boolean)
        {
        }
        field(50030; "Releasing Date"; Date)
        {
            Editable = false;
        }
        field(50031; "Releasing Time"; Time)
        {
            Editable = false;
        }
        field(50034; "Group Code"; Code[2])
        {
            TableRelation = "Item Group";

            trigger OnValidate()
            begin
                //TRI LM 100308 start
                TransLine.RESET;
                TransLine.SETRANGE("Document No.", "No.");
                IF TransLine.FIND('-') THEN
                    ERROR('You Cannot modify Group Code Because some Transfer line is associated with it');
                //TRI LM 100308 End
            end;
        }
        field(50035; "Group Code Check"; Boolean)
        {
        }
        field(50036; Pay; Option)
        {
            Description = 'TRI A.S 07.11.08';
            Editable = true;
            OptionCaption = ' ,To Pay,To be billed';
            OptionMembers = " ","To Pay","To be billed";
        }
        field(50037; "Location Comment"; Text[30])
        {
            Description = 'TRI A.S 31.12.08';
        }
        /*   field(50038; "Amount Including Excise"; Decimal)
          {
              /* CalcFormula = Sum("Transfer Line"."Amount Including Excise" WHERE("Document No." = FIELD("No."),
                                                                                  "Derived From Line No." = FILTER(0)));
              Description = 'TRI P.G 22.06.2009';
              FieldClass = FlowField;
          } */
        field(50039; "Transfer-to Address 3"; Text[50])
        {
            Description = 'TRI SC 10.03.10';
        }
        field(50055; "Direct Open Order"; Boolean)
        {
        }
        field(50056; "Shipping No."; Code[20])
        {
        }
        field(50057; "Receiving No."; Code[20])
        {
        }
        field(50058; Problem; Boolean)
        {
        }
        field(50059; ReProcess; Boolean)
        {
            Description = 'TRI S.C. 09.06.10';
        }
        field(50060; "OutPut Date"; Date)
        {
            Description = 'TRI S.K. 21.06.10';
        }
        field(50061; "Filter Records"; Boolean)
        {
            Description = 'TRI S.K. 21.06.10';
            Editable = false;
        }
        field(50062; "Shortage TO"; Boolean)
        {
            Description = 'TRI VKG 23.09.10';
        }
        field(50063; "Production Plant Code"; Code[20])
        {
            Description = 'MSKS0308';
            TableRelation = Location;
        }
        field(50064; Dept; Code[10])
        {
            TableRelation = "Dimension Value"."Dimension Code" WHERE(Code = CONST('2'));
            ValidateTableRelation = true;
        }
        field(50065; "Requested By"; Text[50])
        {
        }
        field(50066; Remarks; Text[100])
        {
        }
        field(50067; "Created ID"; Code[20])
        {
        }
        field(50068; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Description = 'TEAM::3333';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('STATE'));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(8, "Shortcut Dimension 8 Code");
            end;
        }
        field(50069; "E-way Bill No."; Code[12])
        {
        }
        field(50111; "Bill from Pin Code"; Code[7])
        {
        }
        field(50112; "Bill To  Pin Code"; Code[7])
        {
        }
    }
    keys
    {
        key(Key2; "Transfer-to Code", "No.")
        {
        }
        /*key(Key3; "Transfer-to State", "Transfer-to Code")
        {
        }*/
        key(Key4; "External Transfer", "Filter Records")
        {
        }
        key(Key5; "Shipment Date")
        {
        }
    }
    trigger OnDelete()
    begin
        IF UPPERCASE(USERID) <> 'ADMIN' THEN
            TESTFIELD(Status, Status::Open);

    end;

    trigger OnInsert()
    begin
        /*  MARK(TRUE);

         //ND Tri End Cust 38
         "Posting Date" := 0D; //ND
         "Shipment Date" := 0D; //ND
         IF "No. Series" = 'TOHOTRD' THEN
             "Shipment No. Series" := 'SIPLT';

         InitRecord;
         VALIDATE("Shipment Date", WORKDATE);


         "Created ID" := USERID;
  */
    end;

    trigger OnModify()
    begin
        //ND Tri Start Cust 38
        IF Status = Status::Open THEN
            IF (xRec."Transfer-from Code" <> '') AND ("Transfer-from Code" <> '') THEN BEGIN
                UserAccess := 6;
                Permissions.Type(UserAccess, xRec."Transfer-from Code");
                Permissions.Type(UserAccess, "Transfer-from Code");
                IF (xRec."Transfer-to Code" <> '') AND ("Transfer-to Code" <> '') THEN BEGIN
                    UserAccess := 7;
                    Permissions.Type(UserAccess, xRec."Transfer-to Code");
                    Permissions.Type(UserAccess, "Transfer-to Code");
                END;

            END;
        IF Status = Status::Released THEN
            IF (xRec."Transfer-to Code" <> '') AND ("Transfer-to Code" <> '') THEN BEGIN
                UserAccess := 7;
                Permissions.Type(UserAccess, xRec."Transfer-to Code");
                Permissions.Type(UserAccess, "Transfer-to Code");
            END;
        //ND Tri End Cust 38
        //TESTFIELD(Status,Status::Open);//Kulbhushan

    end;

    procedure FillGateEntryLines(var PostGateEntryLine: Record "Posted Gate Entry Line")
    var
        GateEntryAttachment: Record "Gate Entry Attachment";
    begin
        IF PostGateEntryLine.FINDSET THEN
            REPEAT
                GateEntryAttachment.INIT;
                GateEntryAttachment."Source Type" := PostGateEntryLine."Source Type";
                GateEntryAttachment."Source No." := PostGateEntryLine."Source No.";
                GateEntryAttachment."Entry Type" := PostGateEntryLine."Entry Type";
                GateEntryAttachment."Gate Entry No." := PostGateEntryLine."Gate Entry No.";
                GateEntryAttachment."Line No." := PostGateEntryLine."Line No.";
                GateEntryAttachment.INSERT;
            UNTIL PostGateEntryLine.NEXT = 0;
    end;

    local procedure TestNoSeries1(): Boolean
    begin
        InvtSetup.TESTFIELD("Posted Transfer Shpt. Nos.");
    end;

    procedure "--MSBS.Rao---"()
    begin
    end;

    procedure CheckExciseStructure()
    var
        MSTransferLine: Record "Transfer Line";
        MS00001: Label 'You Can Not Select Excise Structure for Document No. %1 , Item No. %2 in Line No. %3';
    // MSStHeader: Record 13792;
    begin
        //MSBS.Rao Start-0713
        // IF MSStHeader.GET(Structure) THEN
        MSTransferLine.SETRANGE("Document No.", "No.");
        //MSTransferLine.SETRANGE("Location Code","Location Code");
        MSTransferLine.SETFILTER("Item Category Code", '%1|%2|%3|%4', 'M001', 'H001', 'D001', 'T001');
        IF MSTransferLine.FINDFIRST THEN BEGIN
            REPEAT
                IF MSTransferLine."Item Category Code" = 'T001' THEN
                    //  IF MSStHeader.Excise THEN
                    ERROR(MS00001, MSTransferLine."Document No.", MSTransferLine."Item No.", MSTransferLine."Line No.");

                CASE "Transfer-from Code" OF
                    'PLANT':
                        BEGIN
                            /* IF (MSTransferLine."Transfer-from Code" = 'WAREHOUSE') THEN BEGIN
                                 IF NOT MSStHeader.Excise THEN
                                     ERROR(MS00001, MSTransferLine."Document No.", MSTransferLine."Item No.", MSTransferLine."Line No.");
                             END ELSE BEGIN
                                 IF MSStHeader.Excise THEN
                                     ERROR(MS00001, MSTransferLine."Document No.", MSTransferLine."Item No.", MSTransferLine."Line No.");
                             END;*/// 15578
                        END;
                    'PLANT-HSK':
                        BEGIN
                            /* IF MSTransferLine."Transfer-from Code" = 'WH-HOSKOTE' THEN BEGIN
                                 IF NOT MSStHeader.Excise THEN
                                     ERROR(MS00001, MSTransferLine."Document No.", MSTransferLine."Item No.", MSTransferLine."Line No.");
                             END ELSE BEGIN
                                 IF MSStHeader.Excise THEN
                                     ERROR(MS00001, MSTransferLine."Document No.", MSTransferLine."Item No.", MSTransferLine."Line No.");
                             END;*/
                        END;
                    'PLANT-DORA':
                        BEGIN
                            /*  IF MSTransferLine."Transfer-from Code" = 'WH-DORA' THEN BEGIN
                                  IF NOT MSStHeader.Excise THEN
                                      ERROR(MS00001, MSTransferLine."Document No.", MSTransferLine."Item No.", MSTransferLine."Line No.");
                              END ELSE BEGIN
                                  IF MSStHeader.Excise THEN
                                      ERROR(MS00001, MSTransferLine."Document No.", MSTransferLine."Item No.", MSTransferLine."Line No.");
                              END;*/// 15578
                        END;
                END;
            UNTIL MSTransferLine.NEXT = 0;
        END;
        //MSBS.Rao Stop-0713
    end;

    procedure UpdatePriceList()
    var
        RecLocation: Record Location;
    begin
        RecLocation.GET("Transfer-to Code");
        "Customer Price Group" := RecLocation."Transfer Price List";
    end;

    procedure CreateDim(Type1: Integer; No1: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        SourceCodeSetup.GET;
        TableID[1] := Type1;
        No[1] := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        /* "Dimension Set ID" :=
           DimMgt.GetDefaultDimID(
             TableID, No, SourceCodeSetup.Transfer,
             "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", TransHeader."Dimension Set ID", DATABASE::"Transfer Header");*/ // 15578
    end;

    procedure CheckStructureCalculated(TransferHeader: Record "Transfer Header")
    var
        TransferLine: Record "Transfer Line";
        Text50000: Label 'Kindly Press F10, To correct Tax on Order.';
    begin
        IF TransferHeader."External Transfer" THEN BEGIN
            TransferLine.RESET;
            TransferLine.SETRANGE("Document No.", TransferHeader."No.");
            TransferLine.SETRANGE("Structure Calculated", FALSE);
            IF TransferLine.FINDFIRST THEN BEGIN
                REPEAT
                    ERROR(Text50000);
                UNTIL TransferLine.NEXT = 0;
            END;
        END;
    end;

    procedure UpdateStructureCalculated1(TransferHeader: Record "Transfer Header"; Bln: Boolean)
    var
        TransferLine: Record "Transfer Line";
    begin
        TransferLine.RESET;
        TransferLine.SETRANGE("Document No.", TransferHeader."No.");
        TransferLine.SETRANGE("Structure Calculated", FALSE);
        IF TransferLine.FINDFIRST THEN BEGIN
            REPEAT
                TransferLine."Structure Calculated" := Bln;
                TransferLine.MODIFY;
            UNTIL TransferLine.NEXT = 0;
        END;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        UserAccess: Integer;
        UserLocation: Record "User Location";
        Vend: Record Vendor;
        StateVar: Record State;
        SalesPersonPurchaser: Record "Salesperson/Purchaser";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Location1: Record Location;
        FromLocation: Code[20];
        ToLocation: Code[20];
        Tritext001: Label 'Series selected has to be location series %1 still want to continue?.';
        Text0004: Label 'Please Enter State for Location %1 on Location Card.';
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        Location: Record Location;
        Confirmed: Boolean;
        Permissions: Codeunit Permissions1;
        TransLine: Record "Transfer Line";
        InvtSetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

