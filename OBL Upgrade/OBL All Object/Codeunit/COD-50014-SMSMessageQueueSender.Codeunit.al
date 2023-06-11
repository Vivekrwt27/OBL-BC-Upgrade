codeunit 50014 "SMS - Message Queue Sender"
{
    //  //1. TRI PG 20.11.2008 -- SMS Server -- NEW CODEUNIT ADDED


    trigger OnRun()
    begin
    end;

    var
        OutStr: OutStream;
    //    GQueueMessage: Automation;


    procedure SendDataToQueue(QueueMessage: Text[1024]; ReplyQName: Text[100])
    begin
        /*IF ISCLEAR(MQBus) THEN
            CREATE(MQBus);
        IF ISCLEAR(Comcom) THEN
            CREATE(Comcom);
        
        
        MQBus.OpenWriteQueue(ReplyQName,0,0);
        
        Comcom.AddBusAdapter(MQBus,0);
        
        ComOut := Comcom.CreateoutMessage('Message queue://');
        OutStr := ComOut.GetStream;
        
        OutStr.WRITE(QueueMessage);
        
        ComOut.Send(0);
        
        
        CLEAR(MQBus);
        CLEAR(Comcom);
        CLEAR(ComOut);
        CLEAR(OutStr);
        CLEAR(QueueMessage);
         */

    end;
}

