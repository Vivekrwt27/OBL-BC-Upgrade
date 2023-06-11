codeunit 50029 "Update Indents"
{

    trigger OnRun()
    begin
        CloseIndent;
    end;

    var
        RecPurchLine: Record "Purchase Line";
        i: Integer;
        RecIndent: Record "Indent Line";


    procedure CloseIndent()
    begin
        RecIndent.RESET;
        //RecIndent.SETCURRENTKEY(Status,"Order No.","Order Line No.");
        RecIndent.SETFILTER(Status, '<>%1', RecIndent.Status::Closed);
        //RecIndent.SETFILTER("Document No.",'%1','INT\1415\0473');
        IF RecIndent.FINDSET THEN BEGIN
            REPEAT
                RecIndent.CALCFIELDS("PO Qty");
                IF (RecIndent."PO Qty" >= RecIndent.Quantity) THEN BEGIN //OR (RecIndent."PO Qty" > RecIndent.Quantity) THEN BEGIN
                    RecIndent.Status := RecIndent.Status::Closed;
                    i += 1;
                END;
                RecIndent.MODIFY;
            UNTIL RecIndent.NEXT = 0;
        END;
        //MESSAGE('No. of Lines updated%1',i);
        COMMIT;
    end;
}

