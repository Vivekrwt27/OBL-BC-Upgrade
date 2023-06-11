tableextension 50135 tableextension50135 extends "Ship-to Address"
{

    trigger OnAfterInsert()
    var
        Cust: Record Customer;
    begin
        Cust.GET("Customer No.");
        "Tax Liable" := TRUE;
    end;
}

