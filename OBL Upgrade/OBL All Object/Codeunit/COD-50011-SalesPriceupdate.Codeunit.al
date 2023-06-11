codeunit 50011 "Sales Price update"
{

    /* trigger OnRun()
     begin
         window.OPEN('#1###########################', NotificationEntryTable."Entry No.");
         IF NotificationEntryTable.FIND('-') THEN
             REPEAT
                 window.UPDATE;
                 IF STRLEN(NotificationEntryTable."Sales Code") = 1 THEN
                     CustPriceGrp := '0' + NotificationEntryTable."Sales Code" ELSE
                     CustPriceGrp := NotificationEntryTable."Sales Code";


                 IF NOT ItemSalesPrice1.GET(NotificationEntryTable."Entry No.", NotificationEntryTable."Sales Type", CustPriceGrp, NotificationEntryTable."Starting Date",
                   NotificationEntryTable."Currency Code", NotificationEntryTable."Variant Code", NotificationEntryTable."Unit of Measure Code", NotificationEntryTable."Minimum Quantity") THEN BEGIN
                     ItemSalesPrice1.INIT;
                     ItemSalesPrice1."Sales Code" := CustPriceGrp;
                     ItemSalesPrice1."Item Classification No." := NotificationEntryTable."Entry No.";
                     ItemSalesPrice1."Sales Type" := NotificationEntryTable."Sales Type";
                     ItemSalesPrice1."Starting Date" := NotificationEntryTable."Starting Date";
                     ItemSalesPrice1."Unit of Measure Code" := NotificationEntryTable."Unit of Measure Code";
                     ItemSalesPrice1."Minimum Quantity" := NotificationEntryTable."Minimum Quantity";
                     ItemSalesPrice1."Unit Price" := NotificationEntryTable."Unit Price";
                     ItemSalesPrice1.MRP := NotificationEntryTable.MRP;
                     ItemSalesPrice1.INSERT(TRUE);

                 END;


             UNTIL NotificationEntryTable.NEXT = 0;
         NotificationEntryTable.DELETEALL;
         window.CLOSE;
     end;*/ // 15578

    var
        ItemSalesPrice1: Record "Item Sales Price1";
        NotificationEntryTable: Record "Notification Entry Table";
        CustPriceGrp: Code[10];
        window: Dialog;
}

