codeunit 50103 "Single Instance"
{
    SingleInstance = true;
    trigger OnRun()
    begin

    end;

    procedure SetPurchaseCredit(CreditDocNo: code[20])
    begin
        CreditDocNoG := CreditDocNo;
    end;

    procedure GetPurchaseCredit(var CreditDocNo: code[20])
    begin
        CreditDocNo := CreditDocNoG;
    end;

    var
        CreditDocNoG: code[20];
}