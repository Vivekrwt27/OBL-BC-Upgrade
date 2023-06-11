table 50036 "SMS - Message Queue"
{
    // //1. TRI PG 20.11.2008 -- SMS Server -- NEW TABLE ADDED

    //DrillDownPageID = 50167;//16225 PAGE N/F
    //LookupPageID = 50167; //16225 PAGE N/F

    fields
    {
        field(1; "Message ID"; Guid)
        {
        }
        field(2; "Mobile No."; Code[23])
        {
        }
        field(3; Message; Text[250])
        {
        }
        field(4; Priority; Option)
        {
            OptionMembers = High,Normal,Low;
        }
        field(5; "Application Send DateTime"; DateTime)
        {
        }
        field(6; Status; Option)
        {
            OptionCaption = 'To Be Send,Sent To Queue,Received By SMS Server,Message Sent,Error';
            OptionMembers = "To Be Send","Sent To Queue","Received By SMS Server","Message Sent",Error;
        }
        field(7; "Server Send DateTime"; DateTime)
        {
        }
        field(8; "User ID"; Code[100])
        {
        }
        field(9; HT_Retry; Integer)
        {
            BlankNumbers = BlankZero;
            BlankZero = true;
        }
        field(10; Template_ID; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Message ID")
        {
            Clustered = true;
        }
        key(Key2; "Application Send DateTime")
        {
        }
    }

    fieldgroups
    {
    }
}

