//pageextension 50452 pageextension50452 extends "Production Forecast Names"
//{
/* layout
 {
     addafter("Control 4")
     {
         field("Forecast Type"; "Forecast Type")
         {
             Editable = "Forecast TypeEditable";
         }
         field(Status; Status)
         {
             Editable = false;
         }
     }
 }
 actions
 {
     addafter("Action 9")
     {
         group("F&unction")
         {
             Caption = 'F&unction';
             action(Release)
             {
                 Caption = 'Release';
                 Image = ReleaseDoc;

                 trigger OnAction()
                 begin
                     //TRI S.R 220310 - New code Add Start
                     IF UserSetup.GET THEN BEGIN
                         IF USERID = '' THEN
                             EXIT;
                         IF (Status = Status::Closed) OR (Status = Status::Authorized) THEN
                             EXIT;
                         IF (UPPERCASE(USERID) = UPPERCASE(UserSetup."Forecast Authorization 1")) OR
                            (UPPERCASE(USERID) = UPPERCASE(UserSetup."Forecast Authorization 2")) THEN BEGIN
                             IF CONFIRM(ErrText004, FALSE) THEN BEGIN
                                 IF UPPERCASE(UserSetup."Forecast Authorization 1") = UPPERCASE(UserSetup."Forecast Authorization 2") THEN BEGIN
                                     Status := Status::Authorized;
                                     MODIFY;
                                     EXIT;
                                 END ELSE BEGIN
                                     IF ((UPPERCASE(UserSetup."Forecast Authorization 1")) = '') OR ((UPPERCASE(UserSetup."Forecast Authorization 2")) = '')
                                      THEN BEGIN
                                         Status := Status::Authorized;
                                         MODIFY;
                                         EXIT;
                                     END;
                                 END;
                                 IF (UPPERCASE(USERID) = UPPERCASE(UserSetup."Forecast Authorization 1")) THEN BEGIN
                                     IF Status = Status::Authorization2 THEN BEGIN
                                         Status := Status::Authorized;
                                         MODIFY;
                                     END ELSE BEGIN
                                         Status := Status::Authorization1;
                                         MODIFY;
                                     END;
                                 END ELSE BEGIN
                                     IF (UPPERCASE(USERID) = UPPERCASE(UserSetup."Forecast Authorization 2")) THEN BEGIN
                                         IF Status = Status::Authorization1 THEN BEGIN
                                             Status := Status::Authorized;
                                             MODIFY;
                                         END ELSE BEGIN
                                             Status := Status::Authorization2;
                                             MODIFY;
                                         END;
                                     END;
                                 END;
                             END ELSE
                                 ERROR(ErrText001);
                         END;
                     END;
                     //TRI S.R 220310 - New code Add Stop
                 end;
             }
             action(Closed)
             {
                 Caption = 'Closed';

                 trigger OnAction()
                 begin
                     //TRI S.R 220310 - New code Add Start
                     IF UserSetup.GET THEN BEGIN
                         IF USERID = '' THEN
                             EXIT;
                         IF (Status = Status::Open) OR (Status = Status::Closed) OR (Status = Status::Authorized) THEN
                             EXIT;
                         IF (UPPERCASE(USERID) = UPPERCASE(UserSetup."Forecast Authorization 1")) OR
                            (UPPERCASE(USERID) = UPPERCASE(UserSetup."Forecast Authorization 2")) THEN BEGIN
                             IF CONFIRM(ErrText005, FALSE) THEN BEGIN
                                 IF UPPERCASE(UserSetup."Forecast Authorization 1") = UPPERCASE(UserSetup."Forecast Authorization 2") THEN BEGIN
                                     Status := Status::Closed;
                                     MODIFY;
                                     EXIT;
                                 END ELSE BEGIN
                                     IF ((UPPERCASE(UserSetup."Forecast Authorization 1")) = '') OR ((UPPERCASE(UserSetup."Forecast Authorization 2")) = '')
                                      THEN BEGIN
                                         Status := Status::Closed;
                                         MODIFY;
                                         EXIT;
                                     END;
                                 END;
                                 IF (UPPERCASE(USERID) = UPPERCASE(UserSetup."Forecast Authorization 1")) THEN BEGIN
                                     IF Status = Status::Authorization1 THEN BEGIN
                                         Status := Status::Closed;
                                         MODIFY;
                                     END ELSE
                                         ERROR(ErrText006, UPPERCASE(UserSetup."Forecast Authorization 1"));
                                 END ELSE BEGIN
                                     IF (UPPERCASE(USERID) = UPPERCASE(UserSetup."Forecast Authorization 2")) THEN BEGIN
                                         IF Status = Status::Authorization2 THEN BEGIN
                                             Status := Status::Closed;
                                             MODIFY;
                                         END ELSE
                                             ERROR(ErrText006, UPPERCASE(UserSetup."Forecast Authorization 2"));
                                     END;
                                 END;
                             END ELSE
                                 ERROR(ErrText001);
                         END;
                     END;
                     //TRI S.R 220310 - New code Add Stop
                 end;
             }
             action(Reopen)
             {
                 Caption = 'Reopen';
                 Image = ReOpen;

                 trigger OnAction()
                 begin
                     //TRI S.R 220310 - New code Add Start
                     IF UserSetup.GET THEN BEGIN
                         IF (Status = Status::Authorized) OR (Status = Status::Open) THEN
                             EXIT;
                         IF (UPPERCASE(USERID) = UPPERCASE(UserSetup."Forecast Authorization 1")) OR
                            (UPPERCASE(USERID) = UPPERCASE(UserSetup."Forecast Authorization 2")) THEN BEGIN
                             IF CONFIRM(ErrText003, FALSE) THEN BEGIN
                                 IF UPPERCASE(UserSetup."Forecast Authorization 1") = UPPERCASE(UserSetup."Forecast Authorization 2") THEN BEGIN
                                     Status := Status::Open;
                                     MODIFY;
                                     EXIT;
                                 END ELSE BEGIN
                                     IF ((UPPERCASE(UserSetup."Forecast Authorization 1")) = '') OR ((UPPERCASE(UserSetup."Forecast Authorization 2")) = '')
                                      THEN BEGIN
                                         Status := Status::Open;
                                         MODIFY;
                                         EXIT;
                                     END;
                                 END;

                                 IF (UPPERCASE(USERID) = UPPERCASE(UserSetup."Forecast Authorization 1")) THEN BEGIN
                                     IF (Status = Status::Authorization1) OR (Status = Status::Closed) THEN BEGIN
                                         Status := Status::Open;
                                         MODIFY;
                                     END ELSE
                                         ERROR(ErrText002, UPPERCASE(UserSetup."Forecast Authorization 1"));
                                 END ELSE BEGIN
                                     IF (UPPERCASE(USERID) = UPPERCASE(UserSetup."Forecast Authorization 2")) THEN BEGIN
                                         IF (Status = Status::Authorization2) OR (Status = Status::Closed) THEN BEGIN
                                             Status := Status::Open;
                                             MODIFY;
                                         END ELSE
                                             ERROR(ErrText002, UPPERCASE(UserSetup."Forecast Authorization 2"));
                                     END;
                                 END;
                             END ELSE
                                 ERROR(ErrText001);
                         END;
                     END;
                     //TRI S.R 220310 - New code Add Stop
                 end;
             }
         }
     }
 }

 var
     UserSetup: Record 99000765;
     [InDataSet]
     NameEditable: Boolean;
     [InDataSet]
     DescriptionEditable: Boolean;
     [InDataSet]
     "Forecast TypeEditable": Boolean;
     ErrText001: Label 'You have no permission to Release the Forecast.';
     ErrText002: Label 'Authrizer %1 can Open the Forecast.';
     ErrText003: Label 'Do you want to Reopen the Forecast ? ';
     ErrText004: Label 'Do you want to Release the Forecast ? ';
     ErrText005: Label 'Do you want to Close the Forecast ? ';
     ErrText006: Label 'Authrizer %1 can Close the Forecast ?';*/


//Unsupported feature: Code Insertion on "OnAfterGetRecord".

//trigger OnAfterGetRecord()
//begin
/*
//Upgrade(+)
NameOnFormat;
//upgrade(-)
*/
//end;


//Unsupported feature: Code Insertion on "OnInit".

//trigger OnInit()
//Parameters and return type have not been exported.
//begin
/*
//Upgrade(+)
"Forecast TypeEditable" := TRUE;
DescriptionEditable := TRUE;
NameEditable := TRUE;
//Upgrade(-)
*/
//end;

/*  procedure SetControl(CheckSta: Boolean)
  begin
      NameEditable := CheckSta;
      DescriptionEditable := CheckSta;
      "Forecast TypeEditable" := CheckSta;
  end;

  local procedure NameOnFormat()
  begin
      //TRI S.R 220310 - New code Add Start
      IF Status = Status::Open THEN
          SetControl(TRUE)
      ELSE
          SetControl(FALSE);
      //TRI S.R 220310 - New code Add Stop
  end;
}*/

