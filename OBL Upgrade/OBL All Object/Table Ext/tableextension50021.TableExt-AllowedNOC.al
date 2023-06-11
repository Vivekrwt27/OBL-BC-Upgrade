tableextension 50021 "Allowed NOC" extends "Allowed NOC"
{
    fields
    {
        // Add changes to table fields here
    }
    trigger OnBeforeDelete()
    var
        Customer: Record Customer;
    begin
        IF Customer.GET(Rec."Customer No.") THEN BEGIN
            IF Rec."TCS Nature of Collection" = '206C-1H' THEN
                Customer."TCS Charge Stop Date" := CALCDATE('-CM', TODAY);
            Customer.MODIFY;
        END;

    end;

    var
        myInt: Integer;
}