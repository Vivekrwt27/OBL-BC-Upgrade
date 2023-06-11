page 50009 "SMS - Server Setup"
{
    // //1. TRI PG 20.11.2008 -- SMS Server -- NEW FORM ADDED

    PageType = Card;
    SourceTable = "SMS - Server Setup";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            group("SMS Sender Settings")
            {
                Caption = 'SMS Sender Settings';
                field(Enable; rec.Enable)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        EnableOnAfterValidate;
                    end;
                }
                field("Working Mode"; rec."Working Mode")
                {
                    Enabled = "Working ModeEnable";
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        WorkingModeOnAfterValidate;
                    end;
                }
                field("Track Send Status"; rec."Track Send Status")
                {
                    Enabled = "Track Send StatusEnable";
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        TrackSendStatusOnAfterValidate;
                    end;
                }
                field("Message Log"; rec."Message Log")
                {
                    Enabled = "Message LogEnable";
                    ApplicationArea = All;
                }
                field("NAS ID"; rec."NAS ID")
                {
                    Enabled = "NAS IDEnable";
                    ApplicationArea = All;
                }
                field("Message Queue Send Message"; rec."Message Queue Send Message")
                {
                    Enabled = MessageQueueSendMessageEnable;
                    ApplicationArea = All;
                }
                field("SMS Counter"; rec."SMS Counter")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("SMS Counter Last Reset On"; rec."SMS Counter Last Reset On")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Allow Only From Master List"; rec."Allow Only From Master List")
                {
                    ApplicationArea = All;
                }
                field("Message Queue Created Date"; rec."Message Queue Created Date")
                {
                    ApplicationArea = All;
                }
                field("Activate SMS Sending"; rec."Activate SMS Sending")
                {
                    ApplicationArea = All;
                }
                field("Send Generic Message"; rec."Send Generic Message")
                {
                    ApplicationArea = All;
                }
                field("Message Queue Send Status"; rec."Message Queue Send Status")
                {
                    Enabled = MessageQueueSendStatusEnable;
                    ApplicationArea = All;
                }
            }
            group("SMS Functionality Area Settings")
            {
                Caption = 'SMS Functionality Area Settings';
                group(gernal)
                {
                }
                field("Send Cust. Due Message On Date"; rec."Send Cust. Due Message On Date")
                {
                    ApplicationArea = All;
                }
                field("Post Customer Invoice"; rec."Post Customer Invoice")
                {
                    ApplicationArea = All;
                }
                field("Template ID Cust. Invoice"; rec."Template ID Cust. Invoice")
                {
                    ApplicationArea = All;
                }
                field("SMS Template Cust. Invoice"; rec."SMS Template Cust. Invoice")
                {
                    ApplicationArea = All;
                }
                field("Post Customer Cr. Note"; rec."Post Customer Cr. Note")
                {
                    ApplicationArea = All;
                }
                field("Template ID Cust. Cr. Note"; rec."Template ID Cust. Cr. Note")
                {
                    ApplicationArea = All;
                }
                field("SMS Template Cust. Cr. Note"; rec."SMS Template Cust. Cr. Note")
                {
                    ApplicationArea = All;
                }
                field("Post Customer Payment"; rec."Post Customer Payment")
                {
                    ApplicationArea = All;
                }
                field("Template ID Cust. Payment"; rec."Template ID Cust. Payment")
                {
                    ApplicationArea = All;
                }
                field("SMS Template Cust. Payment"; rec."SMS Template Cust. Payment")
                {
                    ApplicationArea = All;
                }
                field("Post Customer Refund"; rec."Post Customer Refund")
                {
                    ApplicationArea = All;
                }
                field("Template ID Cust. Refund"; rec."Template ID Cust. Refund")
                {
                    ApplicationArea = All;
                }
                field("SMS Template Cust. Refund"; rec."SMS Template Cust. Refund")
                {
                    ApplicationArea = All;
                }
                field("Post Customer Due Date"; rec."Post Customer Due Date")
                {
                    ApplicationArea = All;
                }
                field("Template ID Cust. Due Date"; rec."Template ID Cust. Due Date")
                {
                    ApplicationArea = All;
                }
                field("SMS Template Cust. Due Date"; rec."SMS Template Cust. Due Date")
                {
                    ApplicationArea = All;
                }
                field("Post Customer +5 Due Date"; rec."Post Customer +5 Due Date")
                {
                    ApplicationArea = All;
                }
                field("Template ID Cust.+5 Due Date"; rec."Template ID Cust.+5 Due Date")
                {
                    ApplicationArea = All;
                }
                field("SMS Template Cust.+5 Due Date"; rec."SMS Template Cust.+5 Due Date")
                {
                    ApplicationArea = All;
                }
                field("Post Customer -5 Due Date"; rec."Post Customer -5 Due Date")
                {
                    ApplicationArea = All;
                }
                field("Template ID Cust.-5 Due Date"; rec."Template ID Cust.-5 Due Date")
                {
                    ApplicationArea = All;
                }
                field("SMS Template Cust.-5 Due Date"; rec."SMS Template Cust.-5 Due Date")
                {
                    ApplicationArea = All;
                }
                field("Send Msg. on DA Release"; rec."Send Msg. on DA Release")
                {
                    ApplicationArea = All;
                }
                field("Template ID Cust. On Date"; rec."Template ID Cust. On Date")
                {
                    ApplicationArea = All;
                }
                field("SMS Template Cust. On Date"; rec."SMS Template Cust. On Date")
                {
                    ApplicationArea = All;
                }
                field("Template ID Cust. Order"; rec."Template ID Cust. Order")
                {
                    ApplicationArea = All;
                }
                field("SMS Template Cust. Order"; rec."SMS Template Cust. Order")
                {
                    ApplicationArea = All;
                }
                field("Template ID for DA Release"; rec."Template ID for DA Release")
                {
                    ApplicationArea = All;
                }
                field("SMS Template for DA Release"; rec."SMS Template for DA Release")
                {
                    ApplicationArea = All;
                }
                field("Template ID Order Booked"; rec."Template ID Order Booked")
                {
                    ApplicationArea = All;
                }
                field("SMS Template Order Booked"; rec."SMS Template Order Booked")
                {
                    ApplicationArea = All;
                }
                field("Temp. ID Order Price Approved"; rec."Temp. ID Order Price Approved")
                {
                    ApplicationArea = All;
                }
                field("SMS Temp. Order Price Approved"; rec."SMS Temp. Order Price Approved")
                {
                    ApplicationArea = All;
                }
                field("SMS Template Order Released"; rec."SMS Template Order Released")
                {
                    ApplicationArea = All;
                }
                label("----Vendor SMS ---")
                {
                    ApplicationArea = All;
                }
                field("Post Vendor Invoice"; rec."Post Vendor Invoice")
                {
                    ApplicationArea = All;
                }
                field("Template ID Vend. Invoice"; rec."Template ID Vend. Invoice")
                {
                    ApplicationArea = All;
                }
                field("SMS Template Vend. Invoice"; rec."SMS Template Vend. Invoice")
                {
                    ApplicationArea = All;
                }
                field("Post Vendor Dr. Note"; rec."Post Vendor Dr. Note")
                {
                    ApplicationArea = All;
                }
                field("Template ID Vend. Dr. Note"; rec."Template ID Vend. Dr. Note")
                {
                    ApplicationArea = All;
                }
                field("SMS Template Vend. Dr. Note"; rec."SMS Template Vend. Dr. Note")
                {
                    ApplicationArea = All;
                }
                field("Post Vendor Payment"; rec."Post Vendor Payment")
                {
                    ApplicationArea = All;
                }
                field("Template ID Vend. Payment"; rec."Template ID Vend. Payment")
                {
                    ApplicationArea = All;
                }
                field("SMS Template Vend. Payment"; rec."SMS Template Vend. Payment")
                {
                    ApplicationArea = All;
                }
                field("Post Vendor Refund"; rec."Post Vendor Refund")
                {
                    ApplicationArea = All;
                }
                field("Template ID Vend. Refund"; rec."Template ID Vend. Refund")
                {
                    ApplicationArea = All;
                }
                field("SMS Template Vend. Refund"; rec."SMS Template Vend. Refund")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Test)
            {
                Caption = 'Test';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CodeunitSMS.RUN;
                end;
            }
            action(Reset)
            {
                Caption = 'Reset';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('DO YOU WANT TO RESET THE SMS COUNTER ...!', FALSE) THEN BEGIN
                        Rec."SMS Counter" := 0;
                        Rec."SMS Counter Last Reset On" := CREATEDATETIME(TODAY, TIME);
                        Rec.MODIFY;
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        "Message LogEnable" := TRUE;
        MessageQueueSendStatusEnable := TRUE;
        MessageQueueSendMessageEnable := TRUE;
        "NAS IDEnable" := TRUE;
        "Track Send StatusEnable" := TRUE;
        "Working ModeEnable" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        CodeunitSMS: Codeunit "Email Notification1";
        [InDataSet]
        "Working ModeEnable": Boolean;
        [InDataSet]
        "Track Send StatusEnable": Boolean;
        [InDataSet]
        "NAS IDEnable": Boolean;
        [InDataSet]
        MessageQueueSendMessageEnable: Boolean;
        [InDataSet]
        MessageQueueSendStatusEnable: Boolean;
        [InDataSet]
        "Message LogEnable": Boolean;


    procedure EnableDisable()
    begin
        "Working ModeEnable" := Rec.Enable;
        "Track Send StatusEnable" := Rec.Enable;
        "NAS IDEnable" := Rec.Enable;
        MessageQueueSendMessageEnable := Rec.Enable;
        MessageQueueSendStatusEnable := Rec.Enable;
        "Message LogEnable" := Rec.Enable;

        IF Rec.Enable THEN BEGIN
            IF Rec."Working Mode" = Rec."Working Mode"::"Message Queue" THEN BEGIN
                "NAS IDEnable" := TRUE;
                MessageQueueSendMessageEnable := TRUE;
                MessageQueueSendStatusEnable := TRUE;
            END ELSE BEGIN
                "NAS IDEnable" := FALSE;
                MessageQueueSendMessageEnable := FALSE;
                MessageQueueSendStatusEnable := FALSE;
            END;
            IF Rec."Track Send Status" = FALSE THEN BEGIN
                MessageQueueSendStatusEnable := FALSE;
            END;
        END;
    end;

    local procedure EnableOnAfterValidate()
    begin
        EnableDisable;
    end;

    local procedure WorkingModeOnAfterValidate()
    begin
        EnableDisable;
    end;

    local procedure TrackSendStatusOnAfterValidate()
    begin
        EnableDisable;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        EnableDisable;
    end;
}

