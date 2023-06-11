codeunit 50015 "SMS - Message Queue Receiver"
{
    //  //1. TRI PG 20.11.2008 -- SMS Server -- NEW CODEUNIT ADDED

    SingleInstance = true;

    trigger OnRun()
    begin
        SMSServerSetup.GET;
        SMSServerSetup.TESTFIELD(Enable);
        SMSServerSetup.TESTFIELD("Working Mode", SMSServerSetup."Working Mode"::"Message Queue");
        SMSServerSetup.TESTFIELD("Track Send Status");
        SMSServerSetup.TESTFIELD("Message Queue Send Status");

        /*CREATE(Comcom);
        CREATE(MQBus);
        SendStatusQName := SMSServerSetup."Message Queue Send Status";
        MQBus.OpenReceiveQueue(SendStatusQName,1,1);
        Comcom.AddBusAdapter(MQBus,1);
        MESSAGE('SMS Server -- MSMQ Message Track Status Utility Listening Queue ' + SendStatusQName);
         */

    end;

    var
        SendStatusQName: Text[100];
        SMSServerSetup: Record "SMS - Server Setup";


    procedure GetTagValue(DataInQueue: Text[1024]; TagName: Text[30]) TagValue: Text[500]
    var
        mSPosition: Integer;
        mEPosition: Integer;
        mSTagName: Text[30];
        mETagName: Text[30];
    begin
        mSTagName := '<' + TagName + '>';
        mETagName := '</' + TagName + '>';

        IF STRPOS(DataInQueue, mSTagName) > 0 THEN
            mSPosition := STRPOS(DataInQueue, mSTagName) + STRLEN(mSTagName);

        IF STRPOS(DataInQueue, mETagName) > 0 THEN
            mEPosition := STRPOS(DataInQueue, mETagName) - mSPosition;

        IF (mSPosition > 0) AND (mEPosition > 0) THEN
            TagValue := COPYSTR(DataInQueue, mSPosition, mEPosition)
        ELSE
            TagValue := '';
    end;
}

