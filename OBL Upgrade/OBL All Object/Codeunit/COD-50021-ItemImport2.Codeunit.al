codeunit 50021 "Item Import-2"
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

                    Item.VALIDATE(Item."Sales Unit of Measure", 'CRT');
                    Item.VALIDATE(Item."Default Transaction UOM", 'CRT');
                    Item.VALIDATE(Item."Replenishment System", Item."Replenishment System"::"Prod. Order");
                    Item.VALIDATE(Item."Purch. Unit of Measure", 'CRT');
                    // 15578    Item.VALIDATE(Item."Excise Accounting Type", Item."Excise Accounting Type"::"Without CENVAT");
                    Item.VALIDATE(Item.Reserve, Item.Reserve::Always);
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

