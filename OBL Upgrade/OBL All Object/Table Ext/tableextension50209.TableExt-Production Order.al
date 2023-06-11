tableextension 50209 tableextension50209 extends "Production Order"
{
    // 
    // 1.TRI S.R 170210 - New field Added for Manufacturing.
    // //TRI P.G  09.03.2010 -- NEW CODE ADDED -START
    fields
    {
        modify("Source No.")
        {
            trigger OnAfterValidate()
            begin
                CASE "Source Type" OF
                    "Source Type"::Item:
                        BEGIN
                            Item.GET("Source No.");
                            IF (UPPERCASE(USERID) <> 'SUMIT') THEN
                                Item.TESTFIELD(Blocked, FALSE);

                            //MSBS.Rao Begin Dt. 11-04-13
                            MfgSetup.GET;
                            IF MfgSetup."Allow Discoutinued" THEN BEGIN
                                IF Item."Inventory Posting Group" IN ['MANUF', 'TRAD'] THEN
                                    IF NOT Item.Retained THEN
                                        ERROR(MSErr0001, Item."No.");
                            END;
                            //MSBS.Rao End Dt. 11-04-13
                            Description := Item.Description;
                            "Description 2" := Item."Description 2";
                            "Routing No." := Item."Routing No.";

                            "Base UOM" := Item."Base Unit of Measure";
                            //Ori Ut 270611
                            IF UnitofMeasure.GET("Base UOM") THEN
                                IUB.RESET;
                            IUB.SETRANGE(IUB."Item No.", "Source No.");
                            IUB.SETFILTER(IUB.Code, '<>1', "Base UOM");
                            IF IUB.FIND('-') THEN BEGIN

                                "Qty .Base" := IUB."Qty. per Unit of Measure";
                                Conversion := IUB.Code;
                                IF ConversionQty <> 0 THEN
                                    Quantity := ConversionQty * "Qty .Base";
                            END
                            ELSE
                                "Qty .Base" := 1;
                            //Ori UT 270611
                            //TRI P.G  09.03.2010 -- NEW CODE ADDED -START
                            IF "Location Code" <> '' THEN BEGIN
                                StockKeepingUnit.RESET;
                                StockKeepingUnit.SETRANGE("Location Code", "Location Code");
                                StockKeepingUnit.SETRANGE("Item No.", "Source No.");
                                StockKeepingUnit.SETRANGE("Variant Code", '');
                                StockKeepingUnit.SETRANGE("Replenishment System", StockKeepingUnit."Replenishment System"::"Prod. Order");
                                StockKeepingUnit.SETRANGE("Default Production SKU", TRUE);
                                IF StockKeepingUnit.FINDFIRST THEN BEGIN
                                    "Routing No." := StockKeepingUnit."Routing No."
                                END;
                            END;
                            //TRI P.G  09.03.2010 -- NEW CODE ADDED -STOP
                        end;
                end;
            end;
        }
        modify("Due Date")
        {
            trigger OnBeforeValidate()
            begin
                //TSPL SA START
                MfgSetup.GET;
                EVALUATE(DateLength, '-' + FORMAT(MfgSetup."Post Output (Days)"));
                RPODate := CALCDATE(DateLength, TODAY);
                IF "Due Date" < RPODate THEN
                    ERROR(Text50001, RPODate);
                //TSPL SA START

            end;
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            begin
                //TRI P.G  09.03.2010 -- NEW CODE ADDED -START
                IF "Location Code" <> '' THEN BEGIN
                    StockKeepingUnit.RESET;
                    StockKeepingUnit.SETRANGE("Location Code", "Location Code");
                    StockKeepingUnit.SETRANGE("Item No.", "Source No.");
                    StockKeepingUnit.SETRANGE("Variant Code", '');
                    StockKeepingUnit.SETRANGE("Replenishment System", StockKeepingUnit."Replenishment System"::"Prod. Order");
                    StockKeepingUnit.SETRANGE("Default Production SKU", TRUE);
                    IF StockKeepingUnit.FINDFIRST THEN BEGIN
                        "Routing No." := StockKeepingUnit."Routing No."
                    END;
                END;

                //VALIDATE("Shortcut Dimension 1 Code","Location Code"); //MSKS2707

                IF UserLocation.GET(USERID, "Location Code") THEN
                    DIM.SETFILTER(DIM."Dimension Code", '%1', 'BRANCH');
                DIM.SETRANGE(DIM.Code, UserLocation."Location Code");
                IF DIM.FIND('-') THEN
                    "Shortcut Dimension 1 Code" := DIM.Code;

                IF UserLocation."Create Production Order" = FALSE THEN
                    ERROR(Text010, "Location Code");
                //TRI P.G  09.03.2010 -- NEW CODE ADDED -STOP

            end;
        }


        //Unsupported feature: Property Deletion (TableRelation) on ""Location Code"(Field 32)".

        field(50000;
        "Original Prod. No";
        Code[20])
        {
            Description = 'TRI S.R 170210 - New field Add //"Production Order".No.';
        }
        field(50001;
        "Depot. Prod Order";
        Boolean)
        {
            Editable = false;
        }
        field(50002;
        "Re Process Production Order";
        Boolean)
        {
            Description = 'TRI S.R 23.06.10 New field Add';
        }
        field(50003;
        "Base UOM";
        Code[20])
        {
            Description = 'ORI UT 01-09-10 New Field Add';
        }
        field(50004;
        ConversionQty;
        Decimal)
        {
            Description = 'Ori UT 270611 New Field Add';

            trigger OnValidate()
            begin
                VALIDATE(Quantity, ROUND((ConversionQty * "Qty .Base"), 0.001, '='));//Ori Ut 270611
            end;
        }
        field(50005; "Qty .Base"; Decimal)
        {
            DecimalPlaces = 0 : 4;
            Description = 'Ori UT 270611 New Field Add';
        }
        field(50006; Conversion; Code[20])
        {
            Description = 'Ori UT 270611 New Field Add';
        }
        field(50007; Finished; Boolean)
        {
        }
        field(50008; "Finished By"; Code[50])
        {
        }
        field(50009; "Prod. Reporting No."; Code[20])
        {
        }
        field(50010; "Prod. Reporting Line No."; Integer)
        {
        }
    }
    keys
    {
        key(Key9; "Location Code")
        {
        }
    }
    //Unsupported feature: Code Modification on "GetNoSeriesCode(PROCEDURE 6)".

    //procedure GetNoSeriesCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    MfgSetup.GET;

    CASE Status OF
    #4..7
      Status::"Firm Planned":
        EXIT(MfgSetup."Firm Planned Order Nos.");
      Status::Released:
        EXIT(MfgSetup."Released Order Nos.");
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
       //TRI S.R
       IF "Depot. Prod Order" THEN
        EXIT(MfgSetup."Sampling No. Series")
       ELSE
        EXIT(MfgSetup."Released Order Nos.");

        //EXIT(MfgSetup."Released Order Nos."); //6700
    END;
    */
    //end;

    procedure FinishOrder(var ProductionOrder: Record "Production Order")
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.", "Prod. Order Comp. Line No.", "Entry Type", "Location Code");
        ItemLedgerEntry.SETRANGE("Order No.", ProductionOrder."No.");
        ItemLedgerEntry.SETFILTER("Entry Type", '%1', ItemLedgerEntry."Entry Type"::Output);
        IF ItemLedgerEntry.ISEMPTY THEN
            ERROR('No Output Entries has been posted cannot be finished.');

        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.", "Prod. Order Comp. Line No.", "Entry Type", "Location Code");
        ItemLedgerEntry.SETRANGE("Order No.", ProductionOrder."No.");
        ItemLedgerEntry.SETFILTER("Entry Type", '%1', ItemLedgerEntry."Entry Type"::Consumption);
        IF ItemLedgerEntry.ISEMPTY THEN
            ERROR('No Consumption Entries has been posted cannot be finished.');

        ProductionOrder.TESTFIELD(Finished, FALSE);
        IF CONFIRM('Once Finished cannot be reopened, Are you sure to Finish the Prod. Order', FALSE) THEN BEGIN
            ProductionOrder.Finished := TRUE;
            ProductionOrder."Finished By" := USERID;
            ProductionOrder."Finished Date" := TODAY;
        END;
    end;

    var
        StockKeepingUnit: Record "Stockkeeping Unit";
        UserLocation: Record "User Location";
        DIM: Record "Dimension Value";
        DateLength: DateFormula;
        RPODate: Date;
        "----Ori UT-------": Integer;
        IUB: Record "Item Unit of Measure";
        UMQty: Decimal;
        UnitofMeasure: Record "Unit of Measure";
        Text50001: Label 'RPO cannot be Created as Allowed Creation Date is from %1';
        MSErr0001: Label 'Item No %1 discoutinued , Please contact to Costing Department.';
        Item: Record Item;
        MfgSetup: Record "Manufacturing Setup";

        Text010: Label 'You may have changed a dimension.\\Do you want to update the lines?';
}

