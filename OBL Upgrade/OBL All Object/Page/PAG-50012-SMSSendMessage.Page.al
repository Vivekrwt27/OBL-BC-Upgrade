page 50012 "SMS - Send Message"
{
    PageType = Card;
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            field(txtMobileNo; mMobileNo)
            {
                Enabled = txtMobileNoEnable;
                ApplicationArea = All;
            }
            field(txtMessage; mMessage)
            {
                Enabled = txtMessageEnable;
                MultiLine = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(cmdAdd)
            {
                Caption = 'Add No To List';
                Enabled = cmdAddEnable;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF mMobileNo <> '' THEN BEGIN
                        mrecTSMSMobileNoFinal.RESET;
                        mrecTSMSMobileNoFinal.SETRANGE("Mobile No.", mMobileNo);
                        IF NOT mrecTSMSMobileNoFinal.FINDFIRST THEN BEGIN
                            mrecTSMSMobileNoFinal.INIT;
                            mrecTSMSMobileNoFinal."Mobile No." := mMobileNo;
                            mrecTSMSMobileNoFinal."Send Generic Message" := TRUE;
                            mrecTSMSMobileNoFinal.Name := 'UNKNOWN';
                            mrecTSMSMobileNoFinal.Description := 'UNKNOWN';
                            mrecTSMSMobileNoFinal.Selected := TRUE;
                            mrecTSMSMobileNoFinal.INSERT;
                        END;
                        mMobileNo := '';
                    END;
                end;
            }
            action(cmdLoadList)
            {
                Caption = 'Load List';
                Enabled = cmdLoadListEnable;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    mrecTSMSMobileNo.RESET;
                    mrecTSMSMobileNo.DELETEALL;
                    mrecTSMSMobileNoFinal.RESET;
                    mrecTSMSMobileNoFinal.SETRANGE(Name, 'UNKNOWN');
                    mrecTSMSMobileNoFinal.SETRANGE(Description, 'UNKNOWN');
                    IF mrecTSMSMobileNoFinal.FINDFIRST THEN BEGIN
                        REPEAT
                            mrecTSMSMobileNo.INIT;
                            mrecTSMSMobileNo.TRANSFERFIELDS(mrecTSMSMobileNoFinal);
                            mrecTSMSMobileNo.INSERT;
                        UNTIL mrecTSMSMobileNoFinal.NEXT = 0;
                    END;

                    mTMobileNo := '';
                    mrecSMSMoblieNo.RESET;
                    mrecSMSMoblieNo.SETCURRENTKEY("Mobile No.", "Send Generic Message");
                    mrecSMSMoblieNo.SETRANGE("Send Generic Message", TRUE);
                    IF mrecSMSMoblieNo.FINDFIRST THEN BEGIN
                        REPEAT
                            IF mTMobileNo <> mrecSMSMoblieNo."Mobile No." THEN BEGIN
                                mTMobileNo := mrecSMSMoblieNo."Mobile No.";
                                mrecTSMSMobileNo.INIT;
                                mrecTSMSMobileNo.TRANSFERFIELDS(mrecSMSMoblieNo);
                                mrecTSMSMobileNoFinal.RESET;
                                mrecTSMSMobileNoFinal.SETRANGE("Mobile No.", mrecSMSMoblieNo."Mobile No.");
                                IF mrecTSMSMobileNoFinal.FINDFIRST THEN BEGIN
                                    mrecTSMSMobileNo.Selected := mrecTSMSMobileNoFinal.Selected;
                                END;
                                mrecTSMSMobileNo.INSERT;
                            END;
                        UNTIL mrecSMSMoblieNo.NEXT = 0;
                        IF mrecTSMSMobileNo.FINDFIRST THEN BEGIN
                            IF PAGE.RUNMODAL(Page::"SMS - Mobile No. Selection", mrecTSMSMobileNo) = ACTION::LookupOK THEN BEGIN
                                mrecTSMSMobileNoFinal.RESET;
                                mrecTSMSMobileNoFinal.DELETEALL;
                                mrecTSMSMobileNo.RESET;
                                mrecTSMSMobileNo.SETRANGE(Selected, TRUE);
                                IF mrecTSMSMobileNo.FINDFIRST THEN BEGIN
                                    REPEAT
                                        mrecTSMSMobileNoFinal.INIT;
                                        mrecTSMSMobileNoFinal.TRANSFERFIELDS(mrecTSMSMobileNo);
                                        mrecTSMSMobileNoFinal.INSERT;
                                    UNTIL mrecTSMSMobileNo.NEXT = 0;
                                END;
                            END;
                        END;
                    END;
                end;
            }
            action(cmdSendMessage)
            {
                Caption = 'Send';
                Enabled = cmdSendMessageEnable;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF mMessage = '' THEN ERROR('PLEASE ENTER THE MESSAGE');

                    mrecTSMSMobileNoFinal.RESET;

                    cmdSendMessageEnable := FALSE;
                    cmdLoadListEnable := FALSE;
                    cmdAddEnable := FALSE;
                    txtMessageEnable := FALSE;

                    IF mrecTSMSMobileNoFinal.FINDFIRST THEN
                        REPEAT
                        ///   SMSSendMessage.SendMessage(mrecTSMSMobileNoFinal."Mobile No.", mMessage, 1)
                        UNTIL mrecTSMSMobileNoFinal.NEXT = 0;

                    IF mMobileNo <> '' THEN
                        ///   SMSSendMessage.SendMessage(mMobileNo, mMessage, 1);

                        cmdSendMessageEnable := TRUE;
                    cmdLoadListEnable := TRUE;
                    cmdAddEnable := TRUE;
                    txtMessageEnable := TRUE;

                    mMessage := '';
                end;
            }
        }
    }

    trigger OnInit()
    begin
        txtMessageEnable := TRUE;
        cmdAddEnable := TRUE;
        cmdLoadListEnable := TRUE;
        cmdSendMessageEnable := TRUE;
        txtMobileNoEnable := TRUE;
    end;

    trigger OnOpenPage()
    var
        recUserSetup: Record "User Setup";
    begin
        IF recUserSetup.GET(USERID) THEN BEGIN
            IF NOT recUserSetup."Allow Generic SMS" THEN ERROR('You are not authorized to send generic SMS');
        END
        ELSE
            ERROR('You are not authorized to send generic SMS');

        mrecTSMSMobileNoFinal.DELETEALL;
        mrecSMSServerSetup.GET;
        IF mrecSMSServerSetup."Activate SMS Sending" = FALSE THEN ERROR('SMS Communication not Enabled');
        IF mrecSMSServerSetup."Send Generic Message" = FALSE THEN ERROR('SMS Communication not Enabled');

        IF mrecSMSServerSetup."Allow Only From Master List" THEN
            txtMobileNoEnable := FALSE
        ELSE
            txtMobileNoEnable := TRUE;
    end;

    var
        mMessage: Text[1024];
        mMobileNo: Text[1024];
        mrecSMSServerSetup: Record "SMS - Server Setup";
        mrecSMSMoblieNo: Record "SMS - Mobile No.";
        mrecTSMSMobileNo: Record "SMS - Mobile No." temporary;
        mTMobileNo: Text[30];
        mrecTSMSMobileNoFinal: Record "SMS - Mobile No." temporary;
        SMSSendMessage: Codeunit "SMS - Send Message";
        [InDataSet]
        txtMobileNoEnable: Boolean;
        [InDataSet]
        cmdSendMessageEnable: Boolean;
        [InDataSet]
        cmdLoadListEnable: Boolean;
        [InDataSet]
        cmdAddEnable: Boolean;
        [InDataSet]
        txtMessageEnable: Boolean;
}

