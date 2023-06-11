tableextension 50210 tableextension50210 extends "Prod. Order Line"
{
    // 
    // 1.TRI S.R 240310 - New field Added
    fields
    {
        modify("Item No.")// 15578
        {
            trigger OnAfterValidate()
            begin
                //TRI P.G  09.03.2010 -- NEW CODE ADDED -START
                IF "Location Code" <> '' THEN BEGIN
                    StockKeepingUnit.RESET;
                    StockKeepingUnit.SETRANGE("Location Code", "Location Code");
                    StockKeepingUnit.SETRANGE("Item No.", "Item No.");
                    StockKeepingUnit.SETRANGE("Variant Code", '');
                    StockKeepingUnit.SETRANGE("Replenishment System", StockKeepingUnit."Replenishment System"::"Prod. Order");
                    StockKeepingUnit.SETRANGE("Default Production SKU", TRUE);
                    IF StockKeepingUnit.FINDFIRST THEN BEGIN
                        VALIDATE("Routing No.", StockKeepingUnit."Routing No.");
                    END;
                END;
                //TRI P.G  09.03.2010 -- NEW CODE ADDED -STOP

            end;
        }

        modify("Location Code")// 15578
        {
            trigger OnBeforeValidate()
            begin
                //TRI P.G  09.03.2010 -- NEW CODE ADDED -START
                IF "Location Code" <> '' THEN BEGIN
                    StockKeepingUnit.RESET;
                    StockKeepingUnit.SETRANGE("Location Code", "Location Code");
                    StockKeepingUnit.SETRANGE("Item No.", "Item No.");
                    StockKeepingUnit.SETRANGE("Variant Code", '');
                    StockKeepingUnit.SETRANGE("Replenishment System", StockKeepingUnit."Replenishment System"::"Prod. Order");
                    StockKeepingUnit.SETRANGE("Default Production SKU", TRUE);
                    IF StockKeepingUnit.FINDFIRST THEN BEGIN
                        VALIDATE("Routing No.", StockKeepingUnit."Routing No.");
                    END;
                END;

                IF UserLocation.GET(USERID, "Location Code") THEN
                    IF UserLocation."Create Production Order" = FALSE THEN
                        ERROR(Text010, "Location Code");
                //TRI P.G  09.03.2010 -- NEW CODE ADDED -STOP

            end;
        }
        field(50000; "Work Shift Code"; Code[10])
        {
            Caption = 'Work Shift Code';
            Description = 'TRI S.R 240310 - New field Added';
            TableRelation = "Work Shift";
        }
        field(50001; "Production Plant Code"; Code[20])
        {
            Description = 'TRI S.R 240310 - New field Added';
        }
        field(50009; "Prod. Reporting No."; Code[20])
        {
        }
        field(50010; "Prod. Reporting Line No."; Integer)
        {
        }
        field(50050; "Morbi Batch No."; Code[20])
        {
        }
        field(60000; "Creation Date"; Date)
        {
        }
        field(70000; "Mfg. Batch No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
    }




    var
        StockKeepingUnit: Record "Stockkeeping Unit";
        UserLocation: Record "User Location";
        InventorySetup: Record "Inventory Setup";

        Text99000001: Label 'You cannot rename a %1';
        Text010: Label 'You do not have permission to Create Production Order for %1 Location.';

    trigger OnRename()
    begin
        IF USERID <> UPPERCASE('ADMIN') THEN
            ERROR(Text99000001, TABLECAPTION);

    end;
}

