codeunit 50026 conversion
{

    trigger OnRun()
    begin
        window.OPEN('#1#########################################', item."No.");
        conversion.FIND('-');
        REPEAT
            item.RESET;
            CASE STRLEN(conversion.Size) OF
                3:
                    size := conversion.Size;
                2:
                    size := '0' + conversion.Size;
                1:
                    size := '00' + conversion.Size;

            END;
            item.SETRANGE(item."Size Code", size);
            item.SETRANGE(item."Packing Code", conversion.Packing);
            IF item.FIND('-') THEN
                REPEAT
                    IF (item."Item Category Code" <> 'SAMPLE') AND (item."Plant Code" <> 'T') AND (item."Plant Code" <> 'S') THEN BEGIN
                        ctr := ctr + 1;
                        window.UPDATE;
                        IF NOT itemUOM.GET(item."No.", 'CRT') THEN BEGIN
                            itemUOM.INIT;
                            itemUOM.VALIDATE(itemUOM."Item No.", item."No.");
                            itemUOM.VALIDATE(itemUOM.Code, 'CRT');
                            itemUOM.VALIDATE(itemUOM."Qty. per Unit of Measure", conversion.CRT);
                            itemUOM.INSERT(TRUE);
                        END
                        ELSE BEGIN
                            itemUOM.VALIDATE(itemUOM."Qty. per Unit of Measure", conversion.CRT);
                            itemUOM.MODIFY(TRUE);
                        END;

                        /*  IF NOT itemUOM.GET(item."No.",'pcs.') THEN BEGIN
                          itemUOM.INIT;
                          itemUOM.VALIDATE(itemUOM."Item No.",item."No.");
                          itemUOM.VALIDATE(itemUOM.Code,'Pcs.');
                          itemUOM.VALIDATE(itemUOM."Qty. per Unit of Measure",conversion.Pcs);
                          itemUOM.INSERT(TRUE);
                          END ELSE BEGIN
                          itemUOM.VALIDATE(itemUOM."Qty. per Unit of Measure",conversion.Pcs);
                          itemUOM.MODIFY(TRUE);
                          END;*/

                        IF NOT itemUOM.GET(item."No.", 'SQ.MT') THEN BEGIN
                            itemUOM.INIT;
                            itemUOM.VALIDATE(itemUOM."Item No.", item."No.");
                            itemUOM.VALIDATE(itemUOM.Code, 'SQ.MT');
                            itemUOM.VALIDATE(itemUOM."Qty. per Unit of Measure", 1);
                            itemUOM.INSERT(TRUE);
                        END ELSE BEGIN
                            itemUOM.VALIDATE(itemUOM."Qty. per Unit of Measure", 1);
                            itemUOM.MODIFY(TRUE);


                        END;
                    END;
                    //    item.VALIDATE(item."Design Code");
                    //    item.MODIFY;
                    item."Complete Description" := item.Description + ' ' + item."Description 2";
                    item.MODIFY;
                    IF (item."Plant Code" <> '') AND (item."Base Unit of Measure" = 'SQ.MT') THEN BEGIN
                        item."Default Transaction UOM" := 'CRT';
                        item."Purch. Unit of Measure" := 'CRT';
                        item."Sales Unit of Measure" := 'CRT';
                        item.MODIFY;
                    END;

                /*  IF (item."Plant Code" <> '') AND (item."Base Unit of Measure" = 'PCS.') THEN
                  BEGIN
                      item."Default Transaction UOM" := 'PCS.';
                      item."Purch. Unit of Measure" := 'PCS.';
                      item."Sales Unit of Measure" := 'PCS.';
                      item.MODIFY;
                  END;
                  */
                UNTIL item.NEXT = 0;


        UNTIL conversion.NEXT = 0;
        MESSAGE('Successfully Done');

    end;

    var
        window: Dialog;
        conversion: Record conversion;
        item: Record Item;
        itemUOM: Record "Item Unit of Measure";
        size: Code[10];
        ctr: Integer;
}

