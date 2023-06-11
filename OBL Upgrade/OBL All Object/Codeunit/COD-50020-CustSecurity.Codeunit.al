codeunit 50020 "Cust Security"
{

    trigger OnRun()
    begin
        window.OPEN('#1#############################', cust."No.");
        cust.SETFILTER(cust."Security Amount", '<>%1', 0);
        cust.FIND('-');
        REPEAT
            window.UPDATE;
            cust."Security Amount" := 0;
            cust.MODIFY;
        UNTIL cust.NEXT = 0;
        window.CLOSE;
        window.OPEN('#1#####################################', security.customer);
        security.FIND('-');
        REPEAT
            window.UPDATE;
            IF cust.GET(security.customer) THEN BEGIN
                cust."Security Amount" := security.Amount;
                cust."Security Date" := security.Date;
                cust.MODIFY;
            END;
        UNTIL security.NEXT = 0;
    end;

    var
        cust: Record Customer;
        security: Record "security - cust";
        window: Dialog;
}

