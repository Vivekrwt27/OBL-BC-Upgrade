codeunit 90108 "Customer Security Data Verify"
{

    trigger OnRun()
    begin
        Window.OPEN('#1################', CS."Line No.");
        CS.FIND('-');
        REPEAT
            Window.UPDATE;
            GJL.INIT;
            GJL.VALIDATE(GJL."Journal Template Name", 'sales');
            GJL.VALIDATE(GJL."Journal Batch Name", 'CN');
            GJL.VALIDATE(GJL."Line No.", CS."Line No.");
            GJL.VALIDATE(GJL."Source Code", 'salesjnl');
            GJL.VALIDATE(GJL."Account Type", GJL."Account Type"::Customer);
            GJL.VALIDATE(GJL."Account No.", CS."Customer No.");
            GJL.VALIDATE(GJL."Posting Date", CS.Date);
            GJL.VALIDATE(GJL."Document Type", GJL."Document Type"::"Credit Memo");
            GJL.VALIDATE(GJL."Document No.", CS."Document No." + FORMAT(CS."Line No."));
            //GJL.VALIDATE(GJL."External Document No.",CS."Document No."+FORMAT(CS."Line No."));
            //   GJL.VALIDATE(GJL.Narration, CS.Description);
            GJL.VALIDATE(GJL.Amount, CS.Amount);
            GJL.VALIDATE(GJL."Location Code", CS.Location);
            //  GJL.VALIDATE(GJL."Shortcut Dimension 2 Code",CS.Location);
            GJL.VALIDATE(GJL."Bal. Account No.", CS."Bal Ac");
            GJL.VALIDATE(GJL."External Document No.", CS."External Doc.");
            GJL.INSERT(TRUE);
            GJL.VALIDATE(GJL.Amount, CS.Amount);


            GJL.MODIFY(TRUE);
        UNTIL CS.NEXT = 0;
    end;

    var
        GJL: Record "Gen. Journal Line";
        CS: Record "Customer Security";
        Window: Dialog;
        Line: Integer;
}

