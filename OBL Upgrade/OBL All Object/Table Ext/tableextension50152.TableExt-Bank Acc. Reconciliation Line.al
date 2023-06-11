tableextension 50152 tableextension50152 extends "Bank Acc. Reconciliation Line"
{
    fields
    {

        modify("Value Date")// 15578
        {
            trigger OnBeforeValidate()
            begin
                IF "Value Date" = 0D THEN
                    Select := TRUE
                ELSE
                    Select := FALSE;
            end;
        }
        field(50000; Name; Text[100])
        {
            Description = 'mo tri1.0';
        }
        field(50004; Select; Boolean)
        {
            Description = 'mo tri1.0';
        }
        field(50005; "Issuing Bank"; Text[100])
        {
        }
    }
    keys
    {
        key(Key4; "Document No.")
        {
        }
    }
}

