codeunit 90909 "Validate Fields"
{

    trigger OnRun()
    begin
        MTableNo := 18;
        recRef.OPEN(MTableNo);
        IF recRef.FINDFIRST THEN BEGIN
            REPEAT
                FieldTable.RESET;
                FieldTable.SETRANGE(TableNo, MTableNo);
                IF FieldTable.FINDFIRST THEN
                    REPEAT
                        fRef := recRef.FIELD(FieldTable."No.");
                        IF FORMAT(fRef.CLASS) = 'Normal' THEN
                            fRef.VALIDATE;
                    UNTIL FieldTable.NEXT = 0;
            UNTIL recRef.NEXT = 0;
        END;
    end;

    var
        recRef: RecordRef;
        MTableNo: Integer;
        mCount: Integer;
        fRef: FieldRef;
        FieldTable: Record Field;
}

