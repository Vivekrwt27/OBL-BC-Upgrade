tableextension 50259 tableextension50259 extends "Item Journal Line"
{
    fields
    {
        modify("Location Code")// 15578
        {
            trigger OnAfterValidate()
            begin
                IF "Entry Type" IN ["Entry Type"::Consumption, "Entry Type"::Output] THEN BEGIN//TRI S.R 240310 - New code Add
                    "Production Plant Code" := "Location Code";//TRI S.R 240310 - New code Add
                END;//TRI S.R 240310 - New code Add
                    //ND  Tri1.0 End Cust 38
                IF NOT "Physical Journal Entry" THEN BEGIN
                    ItemJnlTemplate1.RESET;
                    ItemJnlTemplate1.SETFILTER(ItemJnlTemplate1.Name, '%1', "Journal Template Name");
                    IF ItemJnlTemplate1.FIND('-') THEN BEGIN
                        IF ItemJnlTemplate1.Type = ItemJnlTemplate1.Type::Item THEN
                            UserAccess := 25;
                        IF ItemJnlTemplate1.Type = ItemJnlTemplate1.Type::Transfer THEN
                            UserAccess := 26;
                        IF ItemJnlTemplate1.Type = ItemJnlTemplate1.Type::"Phys. Inventory" THEN
                            UserAccess := 27;
                        IF ItemJnlTemplate1.Type = ItemJnlTemplate1.Type::Revaluation THEN
                            UserAccess := 28;
                        IF ItemJnlTemplate1.Type = ItemJnlTemplate1.Type::Consumption THEN
                            UserAccess := 29;
                        IF ItemJnlTemplate1.Type = ItemJnlTemplate1.Type::Output THEN
                            UserAccess := 30;
                        IF ItemJnlTemplate1.Type = ItemJnlTemplate1.Type::Capacity THEN
                            UserAccess := 31;
                        // Permissions.Type(UserAccess,"Location Code");
                    END;
                end;
            end;
        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                IF ("Value Entry Type" <> "Value Entry Type"::Revaluation)  //ND 101006
                   THEN
                    "Invoiced Quantity" := 0
                ELSE
                    "Invoiced Quantity" := Quantity;
                //rahul 010607 statr
                IF ("Entry Type" = "Entry Type"::Output) OR ("Entry Type" = "Entry Type"::Consumption) THEN
                    "Invoiced Quantity" := Quantity;
                //rahul 070607 end for output and consumption
                TGUpdateGrossWeight;//TRI S.R 220310 - New code Added
                "Qty. In Carton" := RecItem.UomToCart("Item No.", "Unit of Measure Code", Quantity);
                "Qty. In Pieces" := RecItem.UomToPcs("Item No.", "Unit of Measure Code", Quantity);
            end;
        }


        modify("Applies-to Entry")
        {
            trigger OnAfterValidate()
            var

            begin
                IF ItemLedgEntry.GET("Applies-to Entry") THEN
                    ItemLedgEntry.CALCFIELDS(ItemLedgEntry."Cost Amount (Actual)");
                Amount := ItemLedgEntry."Cost Amount (Actual)";
                IF ItemLedgEntry2.GET("Applies-to Entry") THEN
                    "Capex No." := ItemLedgEntry2."Capex No.";
                IF Quantity > ItemLedgEntry2.Quantity THEN
                    ERROR(Text16500);
            end;
        }

        modify("Qty. (Calculated)")
        {
            trigger OnAfterValidate()
            begin
                "Qty. In Carton" := RecItem.UomToCart("Item No.", "Unit of Measure Code", "Qty. (Calculated)");
                "Qty. In Pieces" := RecItem.UomToPcs("Item No.", "Unit of Measure Code", "Qty. (Calculated)");

            end;
        }
        modify("Variant Code")
        {
            trigger OnAfterValidate()
            var
                ItemVariant: Record "Item Variant";
                Item: Record Item;
            begin
                //Kulbhushan
                IF "Entry Type" IN ["Entry Type"::Output] THEN
                    IF "Variant Code" <> '' THEN BEGIN
                        ItemVariant.GET("Item No.", "Variant Code");
                        ItemVariant.TESTFIELD(Blocked, FALSE);
                        //TRI P.G 18.04.2010 -- CODE COMMENTED
                        //Description := ItemVariant.Description;
                        //TRI P.G 18.04.2010 -- CODE COMMENTED
                    END ELSE BEGIN
                        IF Item."No." <> "Item No." THEN
                            Item.GET("Item No.");
                    END;
                IF "Variant Code" <> '' THEN
                    "Mfg. Batch No." := "Variant Code";
                IF "Variant Code" = '' THEN
                    EXIT;
            end;
        }
        modify("Output Quantity")// 15578
        {
            trigger OnAfterValidate()
            begin
                TESTFIELD("Entry Type", "Entry Type"::Output);
                "Commercial Quantity" := 0;
                "Economic Quantity" := 0;
                "Broken Tiles Quantity" := 0;
                TGUpdateGrossWeight;

            end;
        }

        field(50000; "Description 2"; Text[100])
        {
        }
        field(50001; "Production Plant Code"; Code[20])
        {
            Description = 'TRI S.R 210310 - New field Added';
            Editable = true;
            TableRelation = Location.Code WHERE("Use As In-Transit" = FILTER(false));
        }
        field(50002; "Plant Code Description"; Text[100])
        {
            Editable = true;
        }
        field(50003; "External Transfer"; Boolean)
        {
        }
        field(50004; "Unit Cost (original)"; Decimal)
        {
        }
        field(50005; "Commercial Quantity"; Decimal)
        {
            Description = 'TRI S.R 170210 - New field Add';

            trigger OnValidate()
            var
                Text001: Label 'Quantity can nto be more than Output Quantity.';
            begin
                //TRI S.R 170210 - New Code Added
                TESTFIELD("Output Quantity");
                IF "Prod. Reporting No." = '' THEN;
                IF "Commercial Quantity" + "Economic Quantity" + "Broken Tiles Quantity" > "Output Quantity" THEN
                    ERROR(Text001);
                //TRI S.R 170210 - New Code Added
            end;
        }
        field(50006; "Economic Quantity"; Decimal)
        {
            Description = 'TRI S.R 170210 - New field Add';

            trigger OnValidate()
            var
                Text001: Label 'Quantity can nto be more than Output Quantity.';
            begin
                //TRI S.R 170210 - New Code Added
                TESTFIELD("Output Quantity");
                IF "Prod. Reporting No." = '' THEN
                    IF "Commercial Quantity" + "Economic Quantity" + "Broken Tiles Quantity" > "Output Quantity" THEN
                        ERROR(Text001);
                //TRI S.R 170210 - New Code Added
            end;
        }
        field(50007; "Broken Tiles Quantity"; Decimal)
        {
            Description = 'TRI S.R 170210 - New field Add';

            trigger OnValidate()
            var
                Text001: Label 'Quantity can nto be more than Output Quantity.';
            begin
                //TRI S.R 170210 - New Code Added
                TESTFIELD("Output Quantity");
                IF "Prod. Reporting No." = '' THEN
                    IF "Commercial Quantity" + "Economic Quantity" + "Broken Tiles Quantity" > "Output Quantity" THEN
                        ERROR(Text001);
                //TRI S.R 170210 - New Code Added
            end;
        }
        field(50008; "Routing Link Code"; Code[10])
        {
            Description = 'TRI V.D 21.06.10 ADD';
            Editable = false;
            TableRelation = "Routing Link";
        }
        field(50009; "Scrap Quantity in Sq. Meter"; Decimal)
        {
            Description = 'TRI V.D 21.06.10 ADD';

            trigger OnValidate()
            begin
                //TRI V.D 21.06.2010 START
                IF "Scrap Quantity in Sq. Meter" <> 0 THEN BEGIN
                    TESTFIELD("Output Quantity");
                    TESTFIELD("Routing Link Code");

                    IF "Scrap Quantity in Sq. Meter" > "Output Quantity" THEN
                        ERROR(tgText001, "Scrap Quantity in Sq. Meter", "Output Quantity");

                    tgItemJournalLine.RESET;
                    tgItemJournalLine.SETRANGE(tgItemJournalLine."Journal Template Name", "Journal Template Name");
                    tgItemJournalLine.SETRANGE(tgItemJournalLine."Journal Batch Name", "Journal Batch Name");
                    //tgItemJournalLine.SETRANGE(tgItemJournalLine."Prod. Order No.","Prod. Order No.");  Ramesh Sir
                    //tgItemJournalLine.SETRANGE(tgItemJournalLine."Prod. Order Line No.","Prod. Order Line No.");
                    tgItemJournalLine.SETRANGE(tgItemJournalLine."Entry Type", tgItemJournalLine."Entry Type"::Consumption);
                    tgItemJournalLine.SETRANGE(tgItemJournalLine."Routing Link Code", "Routing Link Code");
                    tgItemJournalLine.SETRANGE(tgItemJournalLine."Scrap Item", TRUE);
                    tgItemJournalLine.SETFILTER(tgItemJournalLine."Scrap Qty From BOM", '<>%1', 0);
                    IF tgItemJournalLine.FIND('-') THEN
                        REPEAT
                            tgItemJournalLine.VALIDATE(tgItemJournalLine.Quantity, "Scrap Quantity in Sq. Meter" * tgItemJournalLine."Scrap Qty From BOM");
                            tgItemJournalLine.MODIFY(TRUE);
                        UNTIL tgItemJournalLine.NEXT = 0;
                END;
                //TRI V.D 21.06.2010 STOP
            end;
        }
        field(50010; "Scrap Item"; Boolean)
        {
            Description = 'TRI V.D 21.06.10 ADD';
            Editable = false;
        }
        field(50011; "Scrap Qty From BOM"; Decimal)
        {
            Description = 'TRI V.D 21.06.10 ADD';
            Editable = false;
        }
        field(50060; "OutPut Date"; Date)
        {
            Description = 'TRI S.K 21.06.10';
        }
        field(50061; "Group Code"; Code[2])
        {
            Description = 'TRI N.K 20.02.08';

            trigger OnValidate()
            begin
                /*//TRI LM 100308 start
                SalesLine1.RESET;
                SalesLine1.SETRANGE("Document Type","Document Type");
                SalesLine1.SETRANGE("Document No.","No.");
                IF SalesLine1.FIND('-') THEN
                 ERROR('You Cannot modify Group Code Because some sales line is associated with it');
                //TRI LM 100308 End
                */

            end;
        }
        field(50062; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(50063; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(50064; "ILE Entry No. 3.7"; Integer)
        {
            Editable = false;
        }
        field(50065; "Old Variant Code"; Code[10])
        {
            Editable = false;
        }
        field(50066; "Return Reason"; Text[80])
        {
            Description = 'Ori Ut';
        }
        field(50067; "Capex No."; Code[20])
        {
            Description = 'Ori Ut';
        }
        field(50068; "Inter Company"; Boolean)
        {
            Description = 'MS-PB';
        }
        field(50069; "IC Line No."; Integer)
        {
            Description = 'MSKS';
        }
        field(50070; Remarks; Text[50])
        {
        }
        field(50071; Remarks1; Text[50])
        {
        }
        field(50072; Remarks2; Text[50])
        {
        }
        field(50073; Remarks3; Text[50])
        {
        }
        field(50074; Remarks4; Text[50])
        {
        }
        field(50075; "Reserved Qty. adj"; Decimal)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Source Type" = CONST(32),
                                                                           "Reservation Status" = CONST(Reservation),
                                                                           "Location Code" = FIELD("Location Code"),
                                                                           "Item No." = FIELD("Item No.")));
            Caption = 'Reserved Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Description = 'Reservation Qty KBS';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60010; "Direct Consumption Entries"; Boolean)
        {
            Description = 'TRI P.G 03.06.2010';
        }
        field(60011; "Depot. Prod Order"; Boolean)
        {
            Editable = false;
        }
        field(60040; "End Use Item"; Boolean)
        {
        }
        field(70000; "Mfg. Batch No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(90000; "Ready To Upload"; Boolean)
        {
            Description = 'Temporary Field Not to be Used';
        }
        field(90001; "Inventory at Posting Date"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("Item No."),
                                                                             "Location Code" = FIELD("Location Code"),
                                                                              "Posting Date" = FIELD("Posting Date")));
            Description = 'TRI V.D 21.06.10 ADD';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90002; "Inventory till Date"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("Item No."),
                                                                              "Location Code" = FIELD("Location Code")));
            Description = 'TRI V.D 21.06.10 ADD';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90003; "Inventory Without Variant"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("Item No."),
                                                                              "Location Code" = FIELD("Location Code")));
            Description = 'TRI V.D 21.06.10 ADD';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90004; "Item Standard Consump. Qty."; Decimal)
        {
            CalcFormula = Sum("Item Journal Line".Quantity WHERE("Posting Date" = FIELD("Posting Date"),
                                                                  "Item No." = FIELD("Item No."),
                                                                  "Shortcut Dimension 1 Code" = FIELD("Shortcut Dimension 1 Code"),
                                                                  "Variant Code" = FIELD("Variant Code"),
                                                                  "Entry Type" = CONST(Consumption)));
            Description = 'TRI V.D 21.06.10 ADD';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90005; "Item Actual Consump. Qty."; Decimal)
        {
            CalcFormula = Sum("Backlog Actual Consumption"."Consumption Qty." WHERE("Consumption Date" = FIELD("Posting Date"),
                                                                                     "Item No." = FIELD("Item No."),
                                                                                     "Location Code" = FIELD("Shortcut Dimension 1 Code"),
                                                                                     "Variant Code" = FIELD("Variant Code")));
            Description = 'TRI V.D 21.06.10 ADD';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90006; ReProcess; Boolean)
        {
            Description = 'TRI V.D 21.06.10 ADD';
        }
        field(90007; "Transferd To Item Journal"; Boolean)
        {
            Description = 'TRI V.D 21.06.10 ADD';
            Editable = false;
        }
        field(90011; "Temp Posting Date"; Date)
        {
            Description = 'TRI S.R 170210 - New field Add';
        }
        field(90012; "Commercial Varient"; Code[20])
        {
            Description = 'TRI S.R 170210 - New field Add';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(90013; "Economic Varient"; Code[20])
        {
            Description = 'TRI S.R 170210 - New field Add';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(90014; "Broken Tiles Varient"; Code[20])
        {
            Description = 'TRI S.R 170210 - New field Add';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(90015; "Qty. In Carton"; Decimal)
        {
        }
        field(90016; "Qty. In Pieces"; Decimal)
        {
        }
        field(90017; "Inventory till Date at Plant &"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("Item No."),
                                                                              "Location Code" = FILTER('PLANT|WAREHOUSE')));
            Description = 'TRI KARAN';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90018; "Machine Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('MACHINE'));
        }
        field(90019; Location1; Text[30])
        {
        }
        field(90020; Varient1; Text[30])
        {
        }
        field(90021; "Physical Journal Entry"; Boolean)
        {
        }
        field(90022; "Physical Journal Key"; Code[10])
        {
        }
        field(90023; "Prod. Reporting No."; Code[20])
        {
        }
        field(90024; "Morbi Batch No."; Code[15])
        {
        }
        field(90025; "Prod. Issue"; Boolean)
        {
        }
    }
    keys
    {
        key(Key7; "Item No.", "Location Code", "Unit of Measure Code")
        {
            SumIndexFields = Quantity;
        }
        key(Key8; "Posting Date", "Item No.", "Shortcut Dimension 1 Code", "Variant Code", "Entry Type")
        {
            SumIndexFields = Quantity;
        }
        key(Key9; "Item No.", "Location Code", "Posting Date")
        {
            SumIndexFields = "Quantity (Base)";
        }
    }




    trigger OnModify()
    begin
        //ND Tri1.0 Start Cust 38
        ItemJnlTemplate1.RESET;
        ItemJnlTemplate1.SETFILTER(ItemJnlTemplate1.Name, '%1', "Journal Template Name");
        IF ItemJnlTemplate1.FIND('-') THEN BEGIN
            IF ItemJnlTemplate1.Type = ItemJnlTemplate1.Type::Item THEN
                UserAccess := 25;
            IF ItemJnlTemplate1.Type = ItemJnlTemplate1.Type::Transfer THEN
                UserAccess := 26;
            IF ItemJnlTemplate1.Type = ItemJnlTemplate1.Type::"Phys. Inventory" THEN
                UserAccess := 27;
            IF ItemJnlTemplate1.Type = ItemJnlTemplate1.Type::Revaluation THEN
                UserAccess := 28;
            IF ItemJnlTemplate1.Type = ItemJnlTemplate1.Type::Consumption THEN
                UserAccess := 29;
            IF ItemJnlTemplate1.Type = ItemJnlTemplate1.Type::Output THEN
                UserAccess := 30;
            IF ItemJnlTemplate1.Type = ItemJnlTemplate1.Type::Capacity THEN
                UserAccess := 31;
            //Permissions.Type(UserAccess,"Location Code");
        END;

    end;







    procedure TGUpdateGrossWeight()
    var
        RecItem: Record Item;
    begin
        //TRI S.R 220310 - New code Add Start
        IF RecItem.GET("Item No.") THEN BEGIN
            "Gross Weight" := ROUND((RecItem."Gross Weight" * "Qty. per Unit of Measure") * Quantity, 0.001, '=');
            "Net Weight" := ROUND((RecItem."Net Weight" * "Qty. per Unit of Measure") * Quantity, 0.001, '=');
        END ELSE BEGIN
            "Gross Weight" := 0;
            "Net Weight" := 0;
        END;
        //TRI S.R 220310 - New code Add Stop
    end;

    procedure TGOpenItemTrackingLines(IsReclass: Boolean)
    begin
        //ReserveItemJnlLine.TGCallItemTracking(Rec,IsReclass);
    end;

    procedure TGLotNoChange(ItemJournal: Record "Item Journal Line"): Text[100]
    var
        TrackingSpecification: Record "Tracking Specification";
        Loc: Record Location;
        Day: Code[10];
        ItemVariant: Record "Item Variant";
        Variantcode: Code[10];
        MfgSet: Record "Manufacturing Setup";
        Mon: Code[10];
        RecTrackingSp: Record "Tracking Specification";
        ItemReservation: Codeunit "Item Jnl. Line-Reserve";
    begin
        /*
        WITH ItemJournal DO BEGIN
        TESTFIELD("Location Code");
        //TESTFIELD("Work Shift Code"); //TRIPGCM
        IF Loc.GET("Location Code") THEN
           Loc.TESTFIELD("Production Plant Code");
          IF (DATE2DMY("Posting Date",1) > 0 ) AND (DATE2DMY("Posting Date",1) <= 9 ) THEN
           Day := 'O'+ FORMAT((DATE2DMY("Posting Date",1)MOD 10))
          ELSE
           BEGIN
            IF (DATE2DMY("Posting Date",1) > 9 ) AND (DATE2DMY("Posting Date",1) <= 19 ) THEN
             Day := 'A'+ FORMAT((DATE2DMY("Posting Date",1)MOD 10))
            ELSE
             BEGIN
              IF (DATE2DMY("Posting Date",1) > 19 ) AND (DATE2DMY("Posting Date",1) <= 29 ) THEN
               Day := 'B'+ FORMAT((DATE2DMY("Posting Date",1)MOD 10))
              ELSE
               Day := 'C'+ FORMAT((DATE2DMY("Posting Date",1)MOD 10))
             END;
        
           END;
          IF ItemVariant.GET("Variant Code") THEN
           BEGIN
            IF ItemVariant."Batch Code" <> '' THEN
             Variantcode := ItemVariant."Batch Code"
            ELSE
             BEGIN
              MfgSet.GET;
              MfgSet.TESTFIELD("Normal Variant Code");
              Variantcode := MfgSet."Normal Variant Code";
             END;
           END ELSE
            BEGIN
              MfgSet.GET;
              MfgSet.TESTFIELD("Normal Variant Code");
              Variantcode := MfgSet."Normal Variant Code";
            END;
          IF STRLEN(FORMAT(DATE2DMY("Posting Date",2))) = 1 THEN
           Mon := '0'+FORMAT(DATE2DMY("Posting Date",2))
          ELSE
           Mon := FORMAT(DATE2DMY("Posting Date",2));
         EXIT(UPPERCASE(Loc."Production Plant Code"+COPYSTR(FORMAT(DATE2DMY("Posting Date",3)),3,4)+
          Mon+Day+"Work Shift Code"+Variantcode));
        END;
        */
        EXIT('FGOPST01042010');

    end;

    var
        PositiveSourceLine: Boolean;
        ItemJnlTemplate1: Record "Item Journal Template";
        UserAccess: Integer;
        UserLocation: Record "User Location";
        Permissions: Codeunit Permissions1;
        GeneralLedgerSetup: Record "General Ledger Setup";
        Location1: Record Location;
        InventorySetup: Record "Inventory Setup";
        DimensionValue: Record "Dimension Value";
        RecItem: Record Item;
        tgItemJournalLine: Record "Item Journal Line";
        tgText001: Label 'Scrap Quantity in Meters %1 should not be greater than Output Quantity %2.';
        Tritxt0001: Label 'Unit Amount is more then COGS Amount.Plz Contact Accounts HO/IT.';
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemLedgEntry2: Record "Item Ledger Entry";
        Text16500: Label 'Quantity must not be greater than Applies-to Entry Quantity';
}

