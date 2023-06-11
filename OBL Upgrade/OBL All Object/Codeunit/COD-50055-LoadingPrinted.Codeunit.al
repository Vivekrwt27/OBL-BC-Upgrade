codeunit 50055 "Loading-Printed"
{
    TableNo = "Sales Header";

    trigger OnRun()
    begin
        rec.FIND;
        Rec."Loading Copies" := rec."Loading Copies" + GlbIntCopies;
        Rec.MODIFY;
        COMMIT;
    end;

    var
        GlbIntCopies: Integer;


    procedure NoOfCopies(var IntCopies: Integer)
    begin
        GlbIntCopies := IntCopies;
    end;
}

