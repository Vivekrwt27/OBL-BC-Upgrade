codeunit 50101 "User Setup Auto Date Change"
{

    trigger OnRun()
    begin
        CompanyOpen;
    end;

    var


    procedure CompanyOpen()
    var
        SERIALNUM: Code[20];
    begin

        UpdateUserSetup;

        //IF (SERIALNUM = '5378897') AND (USERID <> 'ADMINISTRATOR')THEN BEGIN
        IF (SERIALNUM <> '5239801') AND (UPPERCASE(USERID) <> 'ADMIN') THEN BEGIN
            //ERRORHANDLE; 6904
        END;

    end;

    procedure UpdateUserSetup()
    var
        GLSetup: Record "General Ledger Setup";

        RecUserSetup: Record "User Setup";
        FinanceDays: Integer;
        SalesDay: Integer;
        PurchaseDay: Integer;
        ProdDay: Integer;
        MRNUser: Integer;
    begin
        GLSetup.GET;
        IF GLSetup."Posting Date Changed On" = TODAY THEN
            EXIT;
        FinanceDays := 3;
        SalesDay := 0;
        PurchaseDay := 2;
        ProdDay := 2;
        MRNUser := 1;
        IF (FORMAT(GLSetup."Allow Posting From") <> '') AND (FORMAT(GLSetup."Allow Posting To") <> '') THEN BEGIN
            RecUserSetup.RESET;
            RecUserSetup.SETRANGE("ByPass Auto Posting Date", FALSE);
            RecUserSetup.SetRange("User ID", 'BCLD012');
            IF RecUserSetup.FINDFIRST THEN BEGIN
                RecUserSetup.MODIFYALL("Allow Posting From", TODAY);
                RecUserSetup.MODIFYALL("Allow FA Posting From", TODAY);
                RecUserSetup.MODIFYALL("Allow Posting To", TODAY);
                RecUserSetup.MODIFYALL("Allow FA Posting To", TODAY);
            END;
            RecUserSetup.SETRANGE("Purchase User", TRUE);
            IF RecUserSetup.FINDFIRST THEN BEGIN
                RecUserSetup.MODIFYALL("Allow Posting From", TODAY - PurchaseDay);
                RecUserSetup.MODIFYALL("Allow FA Posting From", TODAY - PurchaseDay);
                RecUserSetup.MODIFYALL("Allow Posting To", TODAY);
                RecUserSetup.MODIFYALL("Allow FA Posting To", TODAY);
            END;
            RecUserSetup.SETRANGE("Purchase User", FALSE);
            RecUserSetup.SETRANGE("Finance User", TRUE);
            IF RecUserSetup.FINDFIRST THEN BEGIN
                RecUserSetup.MODIFYALL("Allow Posting From", TODAY - FinanceDays);
                RecUserSetup.MODIFYALL("Allow FA Posting From", TODAY - FinanceDays);
                RecUserSetup.MODIFYALL("Allow Posting To", TODAY);
                RecUserSetup.MODIFYALL("Allow FA Posting To", TODAY);
            END;
            RecUserSetup.SETRANGE("Finance User", FALSE);
            RecUserSetup.SETRANGE(RecUserSetup."Sales User", TRUE);
            IF RecUserSetup.FINDFIRST THEN BEGIN
                RecUserSetup.MODIFYALL("Allow Posting From", TODAY - SalesDay);
                RecUserSetup.MODIFYALL("Allow Posting To", TODAY);
            END;
            RecUserSetup.SETRANGE("Sales User", FALSE);
            RecUserSetup.SETRANGE(RecUserSetup."Prod. User", TRUE);
            IF RecUserSetup.FINDFIRST THEN BEGIN
                RecUserSetup.MODIFYALL("Allow Posting From", TODAY - ProdDay);
                RecUserSetup.MODIFYALL("Allow Posting To", TODAY);
            END;

            RecUserSetup.SETRANGE("Prod. User", FALSE);
            RecUserSetup.SETRANGE(RecUserSetup."Warehouse User", TRUE);
            IF RecUserSetup.FINDFIRST THEN BEGIN
                RecUserSetup.MODIFYALL("Allow Posting From", TODAY - MRNUser);
                RecUserSetup.MODIFYALL("Allow Posting To", TODAY);
            END;
            GLSetup."Posting Date Changed On" := TODAY;
            GLSetup.MODIFY;
        END;

    end;
}

