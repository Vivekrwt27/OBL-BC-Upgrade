tableextension 50140 tableextension50140 extends "Requisition Line"
{
    fields
    {
        modify("No.")// 15578
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
            begin
                CASE Type OF
                    Type::Item:
                        "Group Code" := Item."Group Code";//TRI S.R 220310 -  New code Added
                end;
            end;
        }
        modify("Replenishment System")// 15578
        {
            trigger OnAfterValidate()
            begin
                //TRI P.G  09.03.2010 -- NEW CODE ADDED -START
                IF ("Location Code" <> '') THEN BEGIN
                    StockKeepingUnit.RESET;
                    StockKeepingUnit.SETRANGE("Location Code", "Location Code");
                    StockKeepingUnit.SETRANGE("Item No.", Item."No.");
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

        field(50001; "Planning Line Refreshed"; Boolean)
        {
            Description = 'TRI P.G 09.03.2010 -- NEW FIELD ADDED';
        }
        field(50002; "Group Code"; Code[2])
        {
            Description = 'TRI S.R 220310 - New field Add';
            Editable = false;
            TableRelation = "Item Group";
        }
        field(50003; "Indent Header"; Code[20])
        {
            Description = 'TRI S.R 220310 - New field Add';
            Editable = false;
        }
        field(50004; "Indent Line"; Integer)
        {
            Description = 'TRI S.R 220310 - New field Add';
            Editable = false;
        }
    }
    keys
    {
        /*  key(Key14; "Location Code", "Group Code")
          {
          }*/
        key(Key15; "Worksheet Template Name", "Journal Batch Name", "Replenishment System", "Routing No.", "Ending Date-Time", Type, "No.")
        {
        }
    }

    var
        StockKeepingUnit: Record "Stockkeeping Unit";
        Item: Record Item;
}

