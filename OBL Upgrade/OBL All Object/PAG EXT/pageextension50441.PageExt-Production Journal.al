pageextension 50441 pageextension50441 extends "Production Journal"
{
    layout
    {
        modify("Unit of Measure Code")
        {
            trigger OnAfterValidate()
            begin

                // MIJS01.begin
                MachineCenterRec.RESET;
                IF Rec.Type = Rec.Type::"Machine Center" THEN
                    IF MachineCenterRec.GET(Rec."No.") THEN
                        IF MachineCenterRec."Output UOM" THEN
                            IF Rec."Unit of Measure Code" <> '' THEN
                                Rec.TESTFIELD("Unit of Measure Code", 'CRT');
                // MIJS01.end

                // UPDATE - TCPL -7632
            end;
        }

        addafter("Entry Type")
        {
            field("Work Center No."; Rec."Work Center No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Variant Code")
        {
            field("Mfg. Batch No."; Rec."Mfg. Batch No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("External Document No.")
        {
            field("Commercial Varient"; Rec."Commercial Varient")
            {
                ApplicationArea = All;
            }
            field("Economic Varient"; Rec."Economic Varient")
            {
                ApplicationArea = All;
            }
            field("Broken Tiles Varient"; Rec."Broken Tiles Varient")
            {
                ApplicationArea = All;
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
            field(ConsQty; ConsQty)
            {
                Caption = 'Exp. Cons. Qty.';
                ApplicationArea = All;
            }
            field(tgInventatPostingdate; tgInventatPostingdate)
            {
                Caption = 'Inventory at Posting Date';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    //UPDATE - TCPL - 7632

                    //TRI V.D 03.07.10 START
                    tgILE.RESET;
                    tgILE.SETCURRENTKEY(tgILE."Item No.", tgILE."Posting Date");
                    tgILE.SETRANGE(tgILE."Item No.", Rec."Item No.");
                    tgILE.SETRANGE(tgILE."Posting Date", 0D, Rec."Posting Date");
                    IF Rec."Variant Code" <> '' THEN
                        tgILE.SETRANGE(tgILE."Variant Code", Rec."Variant Code");
                    IF Rec."Location Code" <> '' THEN
                        tgILE.SETRANGE(tgILE."Location Code", Rec."Location Code");
                    tgILE.SETRANGE(tgILE.Open, TRUE);
                    PAGE.RUN(0, tgILE);
                    //TRI V.D 03.07.10 STOP


                    //UPDATE - TCPL - 7632
                end;
            }
            field("Inventory till Date"; Rec."Inventory till Date")
            {
                Caption = 'Inventory till Date';
                ApplicationArea = All;
            }
            field("Scrap Quantity in Sq. Meter"; Rec."Scrap Quantity in Sq. Meter")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    //UPDATE - TCPL - 7632

                    CurrPage.UPDATE(TRUE);  //TRI V.D 21.06.10 ADD

                    //UPDATE - TCPL - 7632
                end;
            }
            field("Commercial Quantity"; Rec."Commercial Quantity")
            {
                ApplicationArea = All;
            }
            field("Economic Quantity"; Rec."Economic Quantity")
            {
                ApplicationArea = All;
            }
            field("Broken Tiles Quantity"; Rec."Broken Tiles Quantity")
            {
                ApplicationArea = All;
            }
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {

        modify(Post)
        {
            trigger OnAfterAction()
            begin
                tgPostingDate := 0D;
                tgPostingDate := Rec."Posting Date";
                tgCloseForm := FALSE;
                tgRecAutomaticRPO.RESET;
                IF tgRecAutomaticRPO.FIND('-') THEN
                    tgRecAutomaticRPO.DELETEALL;

                tgItemJurnlLine.RESET;
                tgItemJurnlLine.SETRANGE(tgItemJurnlLine."Journal Template Name", Rec."Journal Template Name");
                tgItemJurnlLine.SETRANGE(tgItemJurnlLine."Journal Batch Name", Rec."Journal Batch Name");
                tgItemJurnlLine.SETRANGE(tgItemJurnlLine."Order No.", Rec."Order No.");   //code UnBlocked by - TCPL-7632
                tgItemJurnlLine.SETRANGE(tgItemJurnlLine."Order Line No.", Rec."Order Line No."); //code Unblocked - TCPL-7632
                tgItemJurnlLine.SETFILTER(tgItemJurnlLine."Entry Type", '%1|%2', tgItemJurnlLine."Entry Type"::Consumption,
                                          tgItemJurnlLine."Entry Type"::Output);
                IF tgItemJurnlLine.FIND('-') THEN
                    REPEAT
                        IF (tgItemJurnlLine."Entry Type" = tgItemJurnlLine."Entry Type"::Consumption) AND (tgItemJurnlLine.Quantity <> 0) THEN
                            tgItemJurnlLine.TESTFIELD(tgItemJurnlLine."Work Shift Code");
                        IF (tgItemJurnlLine."Entry Type" = tgItemJurnlLine."Entry Type"::Output) AND (tgItemJurnlLine."Output Quantity" <> 0) THEN
                            tgItemJurnlLine.TESTFIELD(tgItemJurnlLine."Work Shift Code");
                    /*IF Item.GET("Item No.") THEN BEGIN
                                              Kulbhushan Quality wise batch restrictuion of Varient
                      IF Item."Quality Code" = '1' THEN
                                                  tgItemJurnlLine.TESTFIELD("Variant Code");
                                          END;*/

                    UNTIL tgItemJurnlLine.NEXT = 0;
                //TRI V.D 01.07.10 STOP

                //UPDATE - TCPL - 7632
                CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                //UPDATE - TCPL - 7632

                ValidateWeight;


            end;

        }

        modify("Post and &Print")
        {
            trigger OnAfterAction()
            var

            begin
                //UPDATE - TCPL - 7632
                //TRI V.D 01.07.10 START
                tgItemJurnlLine.RESET;
                tgItemJurnlLine.SETRANGE(tgItemJurnlLine."Journal Template Name", Rec."Journal Template Name");
                tgItemJurnlLine.SETRANGE(tgItemJurnlLine."Journal Batch Name", Rec."Journal Batch Name");
                tgItemJurnlLine.SETRANGE(tgItemJurnlLine."Order No.", Rec."Order No.");  //TCPL - 7632
                tgItemJurnlLine.SETRANGE(tgItemJurnlLine."Order Line No.", Rec."Order Line No.");   //TCPL - 7632
                tgItemJurnlLine.SETFILTER(tgItemJurnlLine."Entry Type", '%1|%2', tgItemJurnlLine."Entry Type"::Consumption,
                                          tgItemJurnlLine."Entry Type"::Output);
                IF tgItemJurnlLine.FIND('-') THEN
                    REPEAT
                        IF (tgItemJurnlLine."Entry Type" = tgItemJurnlLine."Entry Type"::Consumption) AND (tgItemJurnlLine.Quantity <> 0) THEN
                            tgItemJurnlLine.TESTFIELD(tgItemJurnlLine."Work Shift Code");
                        IF (tgItemJurnlLine."Entry Type" = tgItemJurnlLine."Entry Type"::Output) AND (tgItemJurnlLine."Output Quantity" <> 0) THEN
                            tgItemJurnlLine.TESTFIELD(tgItemJurnlLine."Work Shift Code");
                    UNTIL tgItemJurnlLine.NEXT = 0;
                //TRI V.D 01.07.10 STOP
                //UPDATE - TCPL - 7632

            end;
        }

        modify("&Print")
        {
            trigger OnAfterAction()
            var
                ItemJnlLine: Record "Item Journal Line";
            begin
                ItemJnlLine.COPY(Rec);
                ItemJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                ItemJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                //UPDATE - TCPL - 7632
                //REPORT.RUNMODAL(REPORT::"Inventory Movement",TRUE,TRUE,ItemJnlLine);
                REPORT.RUNMODAL(Report::"Commercial Invoice Nepal1", TRUE, TRUE, ItemJnlLine);
                //UPDATE - TCPL - 7632

            end;
        }

    }

    var
        Item: Record Item;

    var
        TGRecTrack: Record "Tracking Specification";
        tgInventatPostingdate: Decimal;
        tgILE: Record "Item Ledger Entry";
        ConsQty: Decimal;
        tgItemJurnlLine: Record "Item Journal Line";
        tgRecItemJurnlLine: Record "Item Journal Line";
        vItemJnlLine: Record "Item Journal Line";
        MftgSetup: Record "Manufacturing Setup";
        tgCloseForm: Boolean;
        tgRecProdOrder: Record "Production Order";
        tgProdOrderStatusMgt: Codeunit "Prod. Order Status Management";
        tgPostingDate: Date;
        tgRecAutomaticRPO: Record "Automatic RPO";
        "-MIJS---": Integer;
        MachineCenterRec: Record "Machine Center";
        AlreadyILEExist: Record "Item Ledger Entry";
        CheckIJL: Record "Item Journal Line";
        CurrentJnlBatchName: Code[10];
        RecProdOrderComp: Record "Prod. Order Component";

    trigger OnAfterGetRecord()
    begin
        //UPDATE TCPL - 7632
        //TRI V.D 03.07.10 START
        tgInventatPostingdate := 0;
        tgILE.RESET;
        tgILE.SETCURRENTKEY(tgILE."Item No.", tgILE."Posting Date");
        tgILE.SETRANGE(tgILE."Item No.", Rec."Item No.");
        tgILE.SETRANGE(tgILE."Posting Date", 0D, Rec."Posting Date");
        IF Rec."Variant Code" <> '' THEN
            tgILE.SETRANGE(tgILE."Variant Code", Rec."Variant Code");
        IF Rec."Location Code" <> '' THEN
            tgILE.SETRANGE(tgILE."Location Code", Rec."Location Code");
        tgILE.SETRANGE(tgILE.Open, TRUE);
        IF tgILE.FIND('-') THEN
            REPEAT
                tgInventatPostingdate += tgILE."Remaining Quantity";
            UNTIL tgILE.NEXT = 0;
        //MSKS

        ConsQty := 0;
        RecProdOrderComp.RESET;
        RecProdOrderComp.SETRANGE(Status, RecProdOrderComp.Status::Released);
        RecProdOrderComp.SETRANGE("Prod. Order No.", Rec."Document No.");
        RecProdOrderComp.SETRANGE("Prod. Order Line No.", Rec."Order Line No.");
        RecProdOrderComp.SETRANGE("Item No.", Rec."Item No.");
        IF RecProdOrderComp.FINDFIRST THEN
            REPEAT
                ConsQty += RecProdOrderComp."Expected Quantity";
            UNTIL RecProdOrderComp.NEXT = 0;
        //UPDATE TCPL - 7632

    end;

    trigger OnClosePage()
    begin
        //TRI S.R 18.02.10 - New code Added
        TGRecTrack.RESET;
        TGRecTrack.DELETEALL;
        //TRI S.R 18.02.10 - New code Added

    end;

    local procedure ValidateWeight()
    var
        TotOutput: Decimal;
        TotConsumption: Decimal;
    begin
        tgRecItemJurnlLine.RESET;
        tgRecItemJurnlLine.SETRANGE("Order No.", Rec."Order No.");
        tgRecItemJurnlLine.SETRANGE("Order Line No.", Rec."Order Line No.");
        tgRecItemJurnlLine.SETFILTER("Entry Type", '%1', tgRecItemJurnlLine."Entry Type"::Output);
        IF tgRecItemJurnlLine.FINDFIRST THEN
            IF tgRecItemJurnlLine."Inventory Posting Group" = 'MANUF' THEN
                EXIT;

        tgRecItemJurnlLine.RESET;
        tgRecItemJurnlLine.SETRANGE("Order No.", Rec."Order No.");
        tgRecItemJurnlLine.SETRANGE("Order Line No.", Rec."Order Line No.");
        tgRecItemJurnlLine.SETFILTER("Entry Type", '%1|%2', tgRecItemJurnlLine."Entry Type"::Output, tgRecItemJurnlLine."Entry Type"::Consumption);
        IF tgRecItemJurnlLine.FINDFIRST THEN
            REPEAT
                IF tgRecItemJurnlLine."Entry Type" = tgRecItemJurnlLine."Entry Type"::Output THEN
                    TotOutput += tgRecItemJurnlLine."Output Quantity";
                IF tgRecItemJurnlLine."Entry Type" = tgRecItemJurnlLine."Entry Type"::Consumption THEN
                    TotConsumption += tgRecItemJurnlLine."Quantity (Base)";
            UNTIL tgRecItemJurnlLine.NEXT = 0;
        TotConsumption := TotConsumption + (TotConsumption * 0.1); //MSKS
                                                                   //IF ABS(TotOutput) < ABS(TotConsumption) THEN
                                                                   // ERROR('Total Output Weight [%1] cannot be greater than Consumption Weight [%2]',TotOutput,TotConsumption );
    end;
}

