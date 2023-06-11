tableextension 50218 tableextension50218 extends "Stockkeeping Unit"
{
    // 
    // //1. TRI P.G 09.03.2010 -- MANUFACTURING -- NEW FIELD ADDED
    fields
    {
        modify("Routing No.")
        {
            Caption = 'Routing No.';
            Description = 'TRI P.G 09.03.2010 -- MANUFACTURING';
            TableRelation = "Routing Header";

            trigger OnAfterValidate()
            begin
                //TRI P.G 09.03.2010 -- MANUFACTURING
                TESTFIELD("Replenishment System", "Replenishment System"::"Prod. Order");
                //TRI P.G 09.03.2010 -- MANUFACTURING
            end;
        }

        field(50002; "Default Production SKU"; Boolean)
        {
            Description = 'TRI P.G 09.03.2010 -- MANUFACTURING';

            trigger OnValidate()
            var
                recStockKeepingUnit: Record "Stockkeeping Unit";
            begin
                //TRI P.G 09.03.2010 -- MANUFACTURING
                IF "Default Production SKU" THEN BEGIN
                    TESTFIELD("Replenishment System", "Replenishment System"::"Prod. Order");
                    recStockKeepingUnit.RESET;
                    recStockKeepingUnit.SETRANGE("Item No.", "Item No.");
                    recStockKeepingUnit.SETRANGE("Variant Code", "Variant Code");
                    recStockKeepingUnit.SETRANGE("Replenishment System", recStockKeepingUnit."Replenishment System"::"Prod. Order");
                    recStockKeepingUnit.SETFILTER("Location Code", '<>%1', "Location Code");
                    recStockKeepingUnit.SETRANGE("Default Production SKU", FALSE);
                    IF recStockKeepingUnit.FINDFIRST THEN BEGIN
                        ERROR('You Can Have Only One Default Stock Keeping Unit With Replenishment System As Prod. Order');
                        //recStockKeepingUnit."Reordering Policy" := recStockKeepingUnit."Reordering Policy"::" ";
                        //recStockKeepingUnit."Vendor Item No." := 'MULTI';
                        //recStockKeepingUnit.MODIFY;
                    END;
                END;
                //TRI P.G 09.03.2010 -- MANUFACTURING
            end;
        }
    }
}

