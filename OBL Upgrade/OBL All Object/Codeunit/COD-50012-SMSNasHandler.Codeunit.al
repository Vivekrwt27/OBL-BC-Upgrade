codeunit 50012 "SMS - Nas Handler"
{
    //  //1. TRI PG 20.11.2008 -- SMS Server -- NEW CODEUNIT ADDED

    SingleInstance = true;

    trigger OnRun()
    begin
        /*SMSServerSetup.GET;
        SMSServerSetup.TESTFIELD(Enable);
        SMSServerSetup.TESTFIELD("Working Mode",SMSServerSetup."Working Mode"::"Message Queue");
        SMSServerSetup.TESTFIELD("Message Queue Send Message");
         */
        SendMessageQName := SMSServerSetup."Message Queue Send Message";
        /*
        IF ISCLEAR(NavisionTimer) THEN
          CREATE(NavisionTimer);
         */
        IF SMSServerSetup."Track Send Status" THEN BEGIN
            CODEUNIT.RUN(Codeunit::"SMS - Message Queue Receiver");
        END;


        /*NavisionTimer.Interval := 100;
        NavisionTimer.Enabled := TRUE;
        MESSAGE('SMS Server -- MSMQ Message Send Utility Started');
         */

    end;

    var
        IsWorking: Boolean;
        SMSServerSetup: Record "SMS - Server Setup";
        Dt1: DateTime;
        Dt2: DateTime;
        SendMessageQName: Text[100];
        xmlTest: Label '<Mobile>%1</Mobile><Message>%2</Message>';
        SendMessageToMSMQ: Codeunit "SMS - Message Queue Sender";
        TempFile: File;
        MSMQMessageText: Text[1024];


    procedure ProcessMessages()
    var
        MessageQueue: Record "SMS - Message Queue";
    begin
        IsWorking := TRUE;
        Dt2 := CURRENTDATETIME;
        MessageQueue.RESET;
        MessageQueue.SETRANGE(Status, MessageQueue.Status::"To Be Send");
        IF MessageQueue.FINDFIRST THEN BEGIN
            REPEAT
                MSMQMessageText := '<MessageID>' + FORMAT(MessageQueue."Message ID") + '</MessageID>';
                MSMQMessageText := MSMQMessageText + '<MobileNo>' + MessageQueue."Mobile No." + '</MobileNo>';
                MSMQMessageText := MSMQMessageText + '<Message>' + MessageQueue.Message + '</Message>';
                MSMQMessageText := MSMQMessageText + '<Priority>' + FORMAT(MessageQueue.Priority) + '</Priority>';
                MSMQMessageText := MSMQMessageText + '<SendDateTime>' + FORMAT(MessageQueue."Application Send DateTime") + '</SendDateTime>';
                MSMQMessageText := MSMQMessageText + '<UserID>' + MessageQueue."User ID" + '</UserID>';
                MSMQMessageText := MSMQMessageText + '<TrackStatus>' + FORMAT(SMSServerSetup."Track Send Status") + '</TrackStatus>';
                MSMQMessageText := MSMQMessageText + '<Application>' + 'Navision' + '</Application>';
                SendMessageToMSMQ.SendDataToQueue(MSMQMessageText, SendMessageQName);
                MessageQueue.Status := MessageQueue.Status::"Sent To Queue";
                MessageQueue.MODIFY;
                SMSServerSetup."SMS Counter" := SMSServerSetup."SMS Counter" + 1;
                SMSServerSetup.MODIFY;
            UNTIL MessageQueue.NEXT = 0;
        END;

        IsWorking := FALSE;
    end;
}

