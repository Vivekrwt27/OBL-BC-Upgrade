codeunit 50027 "Item Data Import"
{

    trigger OnRun()
    begin
        Window.OPEN('#1######################', "Temp Item"."No.");
        IF "Temp Item".FIND('-') THEN
            REPEAT
                Window.UPDATE;
                IF NOT Item.GET("Temp Item"."No.") THEN BEGIN
                    Item.INIT;
                    Item.VALIDATE(Item."No.", "Temp Item"."No.");
                    Item.INSERT(TRUE);
                    IUOM.INIT;
                    IUOM.VALIDATE(IUOM."Item No.", "Temp Item"."No.");
                    IUOM.VALIDATE(IUOM.Code, "Temp Item"."Base Unit of Measure");
                    IUOM.VALIDATE(IUOM."Qty. per Unit of Measure", 1);
                    IUOM.INSERT(TRUE);

                    Item.VALIDATE(Item.Description, "Temp Item".Description);
                    Item.VALIDATE(Item."Description 2", "Temp Item"."Description 2");
                    Item.VALIDATE(Item."Base Unit of Measure", "Temp Item"."Base Unit of Measure");
                    Item.VALIDATE(Item."Base Unit Of Measure New", "Temp Item"."Base Unit of Measure");//15578
                    item.Validate(item."Base Unit Of Measure New", Item."Base Unit of Measure");
                    Item.VALIDATE(Item."Inventory Posting Group", "Temp Item"."Inventory Posting Group");
                    Item.VALIDATE(Item."Costing Method", Item."Costing Method"::Average);
                    Item.VALIDATE(Item."Unit Cost", "Temp Item"."Unit Cost");
                    Item.VALIDATE(Item."Last Direct Cost", "Temp Item"."Unit Cost");
                    Item.VALIDATE(Item."Gross Weight", "Temp Item"."Gross Weight");
                    Item.VALIDATE(Item."Net Weight", "Temp Item"."Net Weight");
                    Item.VALIDATE(Item."Gen. Prod. Posting Group", "Temp Item"."Gen. Prod. Posting Group");
                    Item.VALIDATE(Item."Item Category Code", "Temp Item"."Item Category Code");
                    // 15578    Item.VALIDATE(Item."Excise Prod. Posting Group", "Temp Item"."Excise Prod. Posting Group");
                    Item.VALIDATE(Item."Type Code", "Temp Item"."Type Code");
                    Item.VALIDATE(Item."Type Catogery Code", "Temp Item"."Type Catogery Code");
                    Item.VALIDATE(Item."Size Code", "Temp Item"."Size Code");
                    Item.VALIDATE(Item."Design Code", "Temp Item"."Design Code");
                    Item.VALIDATE(Item."Color Code", "Temp Item"."Color Code");
                    Item.VALIDATE(Item."Packing Code", "Temp Item"."Packing Code");
                    Item.VALIDATE(Item."Quality Code", "Temp Item"."Quality Code");
                    Item.VALIDATE(Item."Plant Code", "Temp Item"."Plant Code");
                    Item.VALIDATE(Item."Item Classification", "Temp Item"."Item Classification");
                    Item.VALIDATE(Item."Default Prod. Plant Code", "Temp Item"."Default Prod. Plant Code");
                    Item.VALIDATE(Item."Group Code", "Temp Item"."Group Code");
                    Item.VALIDATE(Item."Replenishment System", "Temp Item"."Replenishment System");

                    //   Item.VALIDATE(Item."VAT Product Posting Group","Temp Item"."VAT Product Posting Group");
                    Item.VALIDATE(Item."Tax Group Code", "Temp Item"."Tax Group Code");
                    // 15578    Item.VALIDATE(Item."Product Group Code", "Temp Item"."Product Group Code");
                    Item.VALIDATE(COGS, "Temp Item".COGS); //MSKS3107712
                    Item.VALIDATE("Manuf. Strategy", "Temp Item"."Manuf. Strategy");
                    Item.VALIDATE("Discount Group", "Temp Item"."Discount Group");
                    // 15578    Item."Excise Accounting Type" := Item."Excise Accounting Type"::"Without CENVAT";
                    Item.VALIDATE("Scheme Group", "Temp Item"."Scheme Group");
                    Item.VALIDATE("GST Group Code", "Temp Item"."GST Group Code");
                    Item.VALIDATE("HSN/SAC Code", "Temp Item"."HSN/SAC Code");
                    Item.VALIDATE(NPD, "Temp Item".NPD);
                    //Item.VALIDATE("NPD Sub","Temp Item".Originator);
                    Item.VALIDATE("Tableau Product Group", "Temp Item"."Tableau Product Group");
                    Item.VALIDATE("Production Group", "Temp Item"."Production Group");

                    IF "Temp Item".NPD = '' THEN
                        Item.NPD := ''
                    ELSE
                        Item.NPD := "Temp Item".NPD;

                    //  Item.Retained := Item.Retained::"1";
                    Item.MODIFY(TRUE);
                END
                ELSE
                    MESSAGE('Item No. %1 already exist', "Temp Item"."No.");
            UNTIL "Temp Item".NEXT = 0;
        "Temp Item".DELETEALL;
    end;

    var
        Item: Record Item;
        "Temp Item": Record Item_temp1;
        Window: Dialog;
        IUOM: Record "Item Unit of Measure";
}

