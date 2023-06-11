tableextension 50128 tableextension50128 extends Job
{
    fields
    {

        //Unsupported feature: Code Modification on "Status(Field 19).OnValidate".// 15578 All code same

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec.Status <> Status THEN BEGIN
          IF (Status <> Status::Planning) AND ("Job Type" = "Job Type"::"Capital WIP") THEN
            FIELDERROR(Status);
          IF Status = Status::Completed THEN
            VALIDATE(Complete,TRUE);
          IF xRec.Status = xRec.Status::Completed THEN
            IF DIALOG.CONFIRM(Text004) THEN
              VALIDATE(Complete,FALSE)
            ELSE
              Status := xRec.Status;
          MODIFY;
          JobPlanningLine.SETCURRENTKEY("Job No.");
          JobPlanningLine.SETRANGE("Job No.","No.");
          IF JobPlanningLine.FINDSET THEN BEGIN
            IF CheckReservationEntries THEN
              REPEAT
                JobPlanningLineReserve.DeleteLine(JobPlanningLine);
              UNTIL JobPlanningLine.NEXT = 0;
            JobPlanningLine.MODIFYALL(Status,Status);
            PerformAutoReserve(JobPlanningLine);
          END;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
          IF xRec.Status = xRec.Status::Completed THEN BEGIN
        #7..10
          END;
          JobPlanningLine.SETCURRENTKEY("Job No.");
          JobPlanningLine.SETRANGE("Job No.","No.");
          JobPlanningLine.MODIFYALL(Status,Status);
          MODIFY;
        END;
        */
        //end;
    }

    procedure CurrencyCheck()
    begin
        IF ("Invoice Currency Code" <> "Currency Code") AND ("Invoice Currency Code" <> '') AND ("Currency Code" <> '') THEN
            ERROR(DifferentCurrenciesErr);
    end;

    var
        DifferentCurrenciesErr: Label 'You cannot plan and invoice a job in different currencies.';
}

