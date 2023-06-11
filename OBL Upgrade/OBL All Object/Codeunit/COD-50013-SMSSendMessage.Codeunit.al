codeunit 50013 "SMS - Send Message"
{
    //  //1. TRI PG 20.11.2008 -- SMS Server -- NEW CODEUNIT ADDED


    trigger OnRun()
    begin
        SendMessage('+919818555115', 'Hello This is a test message 2', 1, '');
    end;

    var
        GPriority: Option High,Normal,Low;
        GRecMessageQueue: Record "SMS - Message Queue";


    procedure SendMessage(LParMobileNo: Code[20]; LParMessage: Text[250]; LParPriority: Option High,Normal,Low; SMSTemplateID: Text)
    begin
        GRecMessageQueue.INIT;
        GRecMessageQueue."Message ID" := CREATEGUID;
        GRecMessageQueue."Mobile No." := LParMobileNo;
        GRecMessageQueue.Message := LParMessage;
        GRecMessageQueue.Priority := LParPriority;
        GRecMessageQueue."Application Send DateTime" := CURRENTDATETIME;
        GRecMessageQueue.Status := GRecMessageQueue.Status::"To Be Send";
        GRecMessageQueue."User ID" := USERID;
        GRecMessageQueue.Template_ID := SMSTemplateID;
        GRecMessageQueue.INSERT;
    end;
}

