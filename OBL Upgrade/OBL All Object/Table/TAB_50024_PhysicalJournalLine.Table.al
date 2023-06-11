table 50024 "Physical Journal Line"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(5; "Line No."; Integer)
        {
        }
        field(7; "PICC Key"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('PICC'),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            var
                PhysicalJournalHeader: Record "Physical Journal Header";
            begin
            end;
        }
        field(10; "Voucher Type"; Option)
        {
            OptionCaption = ' ,Store Voucher,Production Voucher';
            OptionMembers = " ","Store Voucher","Production Voucher";
        }
        field(11; Plant; Option)
        {
            OptionCaption = ' ,SKD,DRA,HSK';
            OptionMembers = " ",SKD,DRA,HSK;
        }
        field(15; "Item No."; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                WhereUsedExplode(Rec);
            end;
        }
        field(20; Description; Text[100])
        {
        }
        field(25; UOM; Code[20])
        {
        }
        field(27; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(30; "System Inventory"; Decimal)
        {

            trigger OnValidate()
            begin
                UpdateShortage;
            end;
        }
        field(35; "Transfer Inventory"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                UpdateShortage;
            end;
        }
        field(40; "Physical Inventory"; Decimal)
        {

            trigger OnValidate()
            begin
                UpdateShortage;
                AllocateShortage(Rec);
            end;
        }
        field(50; "Short/Excess"; Decimal)
        {
            Editable = false;
        }
        field(60; "Item Category Code"; Code[20])
        {
        }
        field(65; "Inventory Posting Group"; Code[20])
        {
        }
        field(90; "Allocate to Plant"; Code[20])
        {
            TableRelation = IF (Plant = CONST(SKD)) "Location" WHERE(Code = FILTER('MF*' | 'MP*'))
            ELSE
            IF (Plant = CONST(DRA)) "Location" WHERE(Code = FILTER('DRA-P*'))
            ELSE
            IF (Plant = CONST(HSK)) "Location" WHERE(Code = FILTER('HSK-P*'));
        }
        field(500; "Manually Allocated Qty."; Decimal)
        {
            CalcFormula = Sum("Physical Journal Output Entrie"."Allocate Quantity" WHERE("Document No." = FIELD("Document No."),
                                                                                          "Document Line No." = FIELD("Line No."),
                                                                                          "Manually Changed" = FILTER(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(510; "Rem. Allocated Qty."; Decimal)
        {
            CalcFormula = Sum("Physical Journal Output Entrie"."Allocate Quantity" WHERE("Document No." = FIELD("Document No."),
                                                                                          "Document Line No." = FIELD("Line No."),
                                                                                          "Manually Changed" = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(600; "Manually Confirmed"; Boolean)
        {
        }
        field(605; "Pend. for Allocation"; Decimal)
        {
            CalcFormula = Sum("Location Wise Inventory"."Inventory at Location" WHERE("Physical Journal Filter" = FIELD("Document No."),
                                                                                       "No." = FIELD("Item No."),
                                                                                       "Phys.Jrnl. Output Ent. Exists" = FILTER(false),
                                                                                       Location = FIELD("Location Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(610; "Reservation Qty"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Item No." = FIELD("Item No."),
                                                                           "Source Type" = CONST(32),
                                                                           "Source Subtype" = CONST(0),
                                                                           "Reservation Status" = CONST("Reservation"),
                                                                           "Location Code" = FIELD("Location Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(620; "Allocated Qty."; Decimal)
        {
            CalcFormula = Sum("Physical Journ Inventory Lines"."Physical Inventory" WHERE("Document No." = FIELD("Document No."),
                                                                                           "Document Line No." = FIELD("Line No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        PhysicalJournalOutputEntrie: Record "Physical Journal Output Entrie";
    begin
        PhysicalJournalOutputEntrie.RESET;
        PhysicalJournalOutputEntrie.SETRANGE("Document No.", "Document No.");
        PhysicalJournalOutputEntrie.SETRANGE("Document Line No.", "Line No.");
        IF PhysicalJournalOutputEntrie.FINDFIRST THEN
            PhysicalJournalOutputEntrie.DELETEALL;
    end;

    trigger OnInsert()
    begin
        DuplicateItemCheck;
    end;

    trigger OnRename()
    begin
        ERROR('Rename not allowed');
    end;

    var
        PhysicalJournalHeader: Record "Physical Journal Header";

    local procedure UpdateShortage()
    var
        TrfPercentage: Decimal;
        PhysicalJournalHeader: Record "Physical Journal Header";
    begin
        IF PhysicalJournalHeader.GET("Document No.") THEN
            PhysicalJournalHeader.TESTFIELD(Status, PhysicalJournalHeader.Status::Open);

        IF "Voucher Type" = "Voucher Type"::"Store Voucher" THEN BEGIN
            "Short/Excess" := "System Inventory" - "Physical Inventory";

            PhysicalJournalHeader.GET("Document No.");
            TrfPercentage := PhysicalJournalHeader."Transfer Percentage";
            IF TrfPercentage = 0 THEN
                TrfPercentage := 100;

            "Transfer Inventory" := ROUND(("Short/Excess" * TrfPercentage) / 100, 0.01, '=');
        END ELSE BEGIN
            "Short/Excess" := "System Inventory" - "Physical Inventory" + "Transfer Inventory";
            AllocateShortage(Rec);
        END;
        "Manually Confirmed" := TRUE;
    end;

    local procedure DuplicateItemCheck()
    var
        PhysicalJournalLine: Record "Physical Journal Line";
    begin
        PhysicalJournalLine.RESET;
        PhysicalJournalLine.SETRANGE("Document No.", "Document No.");
        PhysicalJournalLine.SETRANGE("Item No.", "Item No.");
        PhysicalJournalLine.SETFILTER("Line No.", '<>%1', "Line No.");
        IF PhysicalJournalLine.FINDFIRST THEN
            ERROR('Item Already Exist Duplicate Item not Allowed');
    end;


    procedure WhereUsedExplode(PhysicalJournalLine: Record "Physical Journal Line")
    var
        WhereUsedManagement: Codeunit "Where-Used Management";
        Item: Record Item;
        WhereUsedLine: Record "Where-Used Line";
        PhysicalJournalOutputEntrie: Record "Physical Journal Output Entrie";
        LineNo: Integer;
        ProdOrderComponent: Record "Prod. Order Component";
        ProdOrderLine: Record "Prod. Order Line";
        ProductionOrder: Record "Production Order";
        PhysicalJournalHeader: Record "Physical Journal Header";
        LocationFilter: Text;
    begin
        IF PhysicalJournalLine."Item No." = '' THEN
            EXIT;

        PhysicalJournalOutputEntrie.RESET;
        PhysicalJournalOutputEntrie.SETRANGE("Document No.", PhysicalJournalLine."Document No.");
        PhysicalJournalOutputEntrie.SETRANGE("Document Line No.", PhysicalJournalLine."Line No.");
        IF PhysicalJournalOutputEntrie.FINDFIRST THEN
            PhysicalJournalOutputEntrie.DELETEALL;

        IF PhysicalJournalLine."Voucher Type" <> PhysicalJournalLine."Voucher Type"::"Production Voucher" THEN
            EXIT;
        PhysicalJournalHeader.GET("Document No.");
        //LocationFilter := PhysicalJournalHeader.GetLocation(PhysicalJournalHeader."Voucher Type",PhysicalJournalHeader.Plant);
        LocationFilter := PhysicalJournalLine."Location Code";
        LineNo := 10000;
        ProdOrderComponent.RESET;
        ProdOrderComponent.SETRANGE(Status, ProdOrderComponent.Status::Released);
        ProdOrderComponent.SETRANGE("Item No.", PhysicalJournalLine."Item No.");
        ProdOrderComponent.SETFILTER("Location Code", LocationFilter);
        IF ProdOrderComponent.FINDFIRST THEN BEGIN
            REPEAT
                IF ProductionOrder.GET(ProdOrderComponent.Status, ProdOrderComponent."Prod. Order No.") THEN;
                IF ProductionOrder."Creation Date" <= PhysicalJournalHeader."Posting Date" THEN BEGIN //OT03072018
                    IF ProdOrderLine.GET(ProdOrderComponent.Status, ProdOrderComponent."Prod. Order No.", ProdOrderComponent."Prod. Order Line No.") THEN;
                    PhysicalJournalOutputEntrie.RESET;
                    PhysicalJournalOutputEntrie.SETRANGE("Document No.", PhysicalJournalLine."Document No.");
                    PhysicalJournalOutputEntrie.SETRANGE("Document Line No.", PhysicalJournalLine."Line No.");
                    PhysicalJournalOutputEntrie.SETRANGE("Source No.", ProdOrderLine."Item No.");
                    PhysicalJournalOutputEntrie.SETRANGE("Location Code", ProdOrderLine."Location Code");
                    IF PhysicalJournalOutputEntrie.FINDFIRST THEN BEGIN
                        PhysicalJournalOutputEntrie."BOM Quantity" += ProdOrderComponent."Expected Qty. (Base)";
                        PhysicalJournalOutputEntrie."Total Prod. Quantity" += ProdOrderLine."Finished Quantity";
                        PhysicalJournalOutputEntrie.MODIFY;
                    END ELSE BEGIN
                        PhysicalJournalOutputEntrie.INIT;
                        PhysicalJournalOutputEntrie."Document No." := PhysicalJournalLine."Document No.";
                        PhysicalJournalOutputEntrie."Document Line No." := PhysicalJournalLine."Line No.";
                        PhysicalJournalOutputEntrie."Line No." := LineNo;
                        PhysicalJournalOutputEntrie."RM Code" := PhysicalJournalLine."Item No.";
                        PhysicalJournalOutputEntrie."Source No." := ProdOrderLine."Item No.";
                        PhysicalJournalOutputEntrie."BOM Quantity" := ProdOrderComponent."Expected Qty. (Base)";
                        PhysicalJournalOutputEntrie."Total Prod. Quantity" := ProdOrderLine."Finished Quantity";
                        PhysicalJournalOutputEntrie."Location Code" := ProdOrderLine."Location Code";
                        IF (PhysicalJournalOutputEntrie."Location Code" <> '') AND (ProdOrderLine."Finished Quantity" <> 0) THEN BEGIN //Temp commented need to uncomment for LIVE
                                                                                                                                       //IF  (PhysicalJournalOutputEntrie."Location Code"<>'') THEN BEGIN
                            PhysicalJournalOutputEntrie.INSERT;
                            LineNo += 10000;
                        END;
                    END;
                    ProdOrderComponent."Source No." := ProdOrderLine."Item No.";
                    ProdOrderComponent.Blocked := ProductionOrder.Blocked;
                END; //OT03072018
                ProdOrderComponent."Creation Date" := ProductionOrder."Creation Date";
                ProdOrderComponent.MODIFY;
            UNTIL ProdOrderComponent.NEXT = 0;

            /*
            CLEAR(WhereUsedManagement);
            IF WhereUsedLine.FINDFIRST THEN BEGIN
              REPEAT
                PhysicalJournalOutputEntrie.INIT;
                PhysicalJournalOutputEntrie."Document No." := "Document No.";
                PhysicalJournalOutputEntrie."Document Line No." := "Line No.";
                PhysicalJournalOutputEntrie."Line No." :=WhereUsedLine."Entry No.";
                PhysicalJournalOutputEntrie."RM Code" := "Item No.";
                PhysicalJournalOutputEntrie."Source No." := WhereUsedLine."Item No.";
                PhysicalJournalOutputEntrie."BOM Quantity"     := WhereUsedLine."Quantity Needed";
                PhysicalJournalOutputEntrie.INSERT;
              UNTIL WhereUsedLine.NEXT=0;

            END;
            */
        END;

    end;


    procedure ShowoutputEntries()
    var
        PhysicalJournalOutputEntrie: Record "Physical Journal Output Entrie";
    begin
        PhysicalJournalOutputEntrie.RESET;
        PhysicalJournalOutputEntrie.SETRANGE("Document No.", "Document No.");
        PhysicalJournalOutputEntrie.SETRANGE("Document Line No.", "Line No.");
        PhysicalJournalOutputEntrie.SETRANGE("Location Code", "Location Code");
        PAGE.RUN(Page::"Phy. Journal Output Entries", PhysicalJournalOutputEntrie);
    end;

    procedure AllocateShortage(PhysicalJournalLine: Record "Physical Journal Line")
    var
        PhysicalJournalOutputEntrie: Record "Physical Journal Output Entrie";
        TotalProdQty: Decimal;
        AllocatedQty: Decimal;
        TransferAllocatedQty: Decimal;
        i: Integer;
        NoOfRecords: Integer;
    begin
        IF PhysicalJournalLine."Voucher Type" <> PhysicalJournalLine."Voucher Type"::"Production Voucher" THEN
            EXIT;
        IF PhysicalJournalLine."Short/Excess" = 0 THEN
            EXIT;
        i := 1;
        PhysicalJournalOutputEntrie.RESET;
        PhysicalJournalOutputEntrie.SETRANGE("Document No.", PhysicalJournalLine."Document No.");
        PhysicalJournalOutputEntrie.SETRANGE("Document Line No.", PhysicalJournalLine."Line No.");
        IF PhysicalJournalOutputEntrie.FINDFIRST THEN
            REPEAT
                TotalProdQty += PhysicalJournalOutputEntrie."Total Prod. Quantity";
            UNTIL PhysicalJournalOutputEntrie.NEXT = 0;
        /*
      PhysicalJournalOutputEntrie.RESET;
      PhysicalJournalOutputEntrie.SETRANGE("Document No.",PhysicalJournalLine."Document No.");
      PhysicalJournalOutputEntrie.SETRANGE("Document Line No.",PhysicalJournalLine."Line No.");
      IF PhysicalJournalOutputEntrie.FINDFIRST THEN BEGIN
        //PhysicalJournalOutputEntrie.CALCSUMS("Total Prod. Quantity");

        NoOfRecords := PhysicalJournalOutputEntrie.COUNT;
        REPEAT

          IF i = NoOfRecords THEN BEGIN
            PhysicalJournalOutputEntrie."Allocate Quantity" := PhysicalJournalLine."Short/Excess"-AllocatedQty;
      //      PhysicalJournalOutputEntrie."Transfer Allocated Qty." := PhysicalJournalLine."Transfer Inventory" - TransferAllocatedQty;
          END ELSE BEGIN
            IF TotalProdQty <>0 THEN BEGIN
              PhysicalJournalOutputEntrie."Allocate Quantity" :=   (PhysicalJournalLine."Short/Excess"/TotalProdQty )* PhysicalJournalOutputEntrie."Total Prod. Quantity";
       //       PhysicalJournalOutputEntrie."Transfer Allocated Qty." :=   (PhysicalJournalLine."Transfer Inventory"/TotalProdQty )* PhysicalJournalOutputEntrie."Total Prod. Quantity";
            END;
            AllocatedQty += PhysicalJournalOutputEntrie."Allocate Quantity";
      //      TransferAllocatedQty += PhysicalJournalOutputEntrie."Transfer Allocated Qty.";
            i +=1;
          END;
          //MESSAGE('%1-%2-%3-%4',i,PhysicalJournalOutputEntrie."Total Prod. Quantity",PhysicalJournalLine."Short/Excess",TotalProdQty);
          PhysicalJournalOutputEntrie."Manually Changed":=FALSE;
          PhysicalJournalOutputEntrie.MODIFY;
        UNTIL PhysicalJournalOutputEntrie.NEXT=0;
      END;
      */

        PhysicalJournalOutputEntrie.ReAllocateQty(PhysicalJournalLine, TRUE);

    end;


    procedure ShowlocationWiseInventory()
    var
        PhysicalJournInventoryLines: Record "Physical Journ Inventory Lines";
    begin
        GenerateLocationData;
        PhysicalJournInventoryLines.RESET;
        PhysicalJournInventoryLines.SETRANGE("Document No.", "Document No.");
        PhysicalJournInventoryLines.SETRANGE("Item No.", "Item No.");
        PAGE.RUN(Page::"Physical Journal Inventory", PhysicalJournInventoryLines);
    end;


    procedure GenerateLocationData()
    var
        PhysicalJournInventoryLines: Record "Physical Journ Inventory Lines";
        Location: Record Location;
        PhysicalJournalHeader: Record "Physical Journal Header";
        LineNo: Integer;
    begin
        LineNo := 100;
        PhysicalJournInventoryLines.RESET;
        PhysicalJournInventoryLines.SETRANGE("Document No.", "Document No.");
        PhysicalJournInventoryLines.SETRANGE("Document Line No.", "Line No.");
        IF NOT PhysicalJournInventoryLines.FINDFIRST THEN BEGIN
            IF PhysicalJournalHeader.GET("Document No.") THEN;
            Location.RESET;
            CASE PhysicalJournalHeader.Plant OF
                PhysicalJournalHeader.Plant::SKD:
                    Location.SETRANGE("Prod. Units", Location."Prod. Units"::SKD);
                PhysicalJournalHeader.Plant::DRA:
                    Location.SETRANGE("Prod. Units", Location."Prod. Units"::DORA);
                PhysicalJournalHeader.Plant::HSK:
                    Location.SETRANGE("Prod. Units", Location."Prod. Units"::Hoskotte);
            END;
            IF Location.FINDFIRST THEN BEGIN
                REPEAT
                    PhysicalJournInventoryLines.INIT;
                    PhysicalJournInventoryLines."Document No." := "Document No.";
                    PhysicalJournInventoryLines."Document Line No." := "Line No.";
                    PhysicalJournInventoryLines."Item No." := "Item No.";
                    PhysicalJournInventoryLines."Line No." := LineNo;
                    PhysicalJournInventoryLines."Location Code" := Location.Code;
                    PhysicalJournInventoryLines.INSERT;
                    LineNo += 100;
                UNTIL Location.NEXT = 0;
            END;
        END;
    end;
}

