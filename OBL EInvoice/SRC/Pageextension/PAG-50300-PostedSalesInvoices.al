pageextension 50300 Mypageextension50300Extension extends "Posted Sales Invoices"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Invoice")
        {
            group("Run Page")
            {

                action("Run Generate E Way Bill Sales Invoice")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    RunObject = page 50237;
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Run Generate PCM Page")
                {
                    ApplicationArea = All;
                    RunObject = page 50238;

                    trigger OnAction()
                    begin

                    end;
                }

            }
        }
        modify(GenerateIRN)
        {
            Visible = false;
        }
        modify("Check IRN")
        {
            Visible = false;
        }
        modify("Cancel IRN")
        {
            Visible = false;
        }
        addafter("&Invoice")
        {
            action(GenerateIRN1)
            {
                Caption = 'GenerateIRN';
                ApplicationArea = All;
                Promoted = true;

                trigger OnAction()
                var
                    EInvoice: Codeunit 50200;
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    IF rec."Posting Date" <= 20200930D THEN
                        ERROR('You cannot create IRN Before than 1st Oct 2020');
                    rec.TESTFIELD("Acknowledgement No.", '');
                    Rec.TESTFIELD("Acknowledgement Date", 0DT);
                    CLEAR(EInvoice);
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETFILTER("No.", '%1', rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                        EInvoice.SetSalesInvHeader(SalesInvoiceHeader);
                        EInvoice.GenerateSalesInvJSONSchema(SalesInvoiceHeader);
                    END;
                end;
            }
            action("CheckIRN")
            {
                Caption = 'Check IRN';
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    EInvoice: Codeunit 50200;
                    SalesInvoiceHeader: Record "Sales Invoice Header";

                begin
                    CLEAR(EInvoice);
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETFILTER("No.", '%1', rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                        EInvoice.SetSalesInvHeader(SalesInvoiceHeader);
                        EInvoice.GenerateSalesInvJSONSchemaforChecking(SalesInvoiceHeader);
                    END;

                end;
            }
            action(UpdateIRN)
            {
                ApplicationArea = All;
                Promoted = true;
                Visible = false;
                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    QRText: Text;
                    RecRef: RecordRef;
                    QRGenerator: Codeunit "QR Generator";
                    TempBlob: Codeunit "Temp Blob";
                    FldRef: FieldRef;
                    YearCode: Integer;
                    MonthCode: Integer;
                    DayCode: Integer;
                    AckDateText: Text;
                    AckDate: DateTime;
                begin
                    QRText := 'eyJhbGciOiJSUzI1NiIsImtpZCI6IkI4RDYzRUNCNThFQTVFNkY0QUFDM0Q1MjQ1NDNCMjI0NjY2OUIwRjgiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJ1TlkteTFqcVhtOUtyRDFTUlVPeUpHWnBzUGcifQ.eyJkYXRhIjoie1wiU2VsbGVyR3N0aW5cIjpcIjA3QUFBQ08wMzA1UDFaSlwiLFwiQnV5ZXJHc3RpblwiOlwiMDlBQUZDQjAxNDNGMVo0XCIsXCJEb2NOb1wiOlwiRE5ERUwvMjIyMy8wMDAwN1wiLFwiRG9jVHlwXCI6XCJJTlZcIixcIkRvY0R0XCI6XCIxMy8wNC8yMDIzXCIsXCJUb3RJbnZWYWxcIjo2MDc2OS4wLFwiSXRlbUNudFwiOjEsXCJNYWluSHNuQ29kZVwiOlwiOTQwNVwiLFwiSXJuXCI6XCJiMjE2NGI1MDI0ODc1YTkyN2Y5ZTMwMmFiMjU1YjRkYTVlYmM5NmNhOWNjMmJjZjFiMzc4NzMwODM4ZGNjYjg2XCIsXCJJcm5EdFwiOlwiMjAyMy0wNC0xNCAwOTowNDowMFwifSIsImlzcyI6Ik5JQyJ9.iIQOONsyLEziofY2J6I8vhjk9MbDe9KtJJYOKYTXIApuUuS2FUXd4nHaU8C2QYWbbyLLthV_tE5EzcfvihYvzU3bFPiLa-pP6zj6dV6SjftPeu1A-a35RcDSiZu3nlOLG1TEVaktc8zQ00JGhB12YpljBvBNL5Ya4gBtaeSzPU2fsr08DMgk7l0JVvnmv3FvV_YMWCuw28h7OxAXTU7ymUnBwFHelQXxIMZIjdX2vzrkF5_0CEF4vGxdC-J6IiIaohKsTRWn5Vh5IkkwgpwEJoRrYFBqBhC35Exg06JC_dGYIOlY0y95Qw836jOw9R_uBPezeyX4uFi5OuaQ0HSXmw';
                    AckDateText := '2023-04-14 09:04:00';
                    Evaluate(YearCode, CopyStr(AckDateText, 1, 4));
                    Evaluate(MonthCode, CopyStr(AckDateText, 6, 2));
                    Evaluate(DayCode, CopyStr(AckDateText, 9, 2));
                    Evaluate(AckDate, Format(DMY2Date(DayCode, MonthCode, YearCode)) + ' ' + Copystr(AckDateText, 12, 8));
                    SalesInvoiceHeader.Reset();
                    SalesInvoiceHeader.SetRange("No.", 'DNDEL/2223/00007');
                    if SalesInvoiceHeader.FindFirst() then begin
                        Clear(RecRef);
                        RecRef.Get(SalesInvoiceHeader.RecordId);
                        if QRGenerator.GenerateQRCodeImage(QRText, TempBlob) then begin
                            if TempBlob.HasValue() then begin
                                FldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("QR Code"));
                                TempBlob.ToRecordRef(RecRef, SalesInvoiceHeader.FieldNo("QR Code"));
                                RecRef.Field(SalesInvoiceHeader.FieldNo("IRN Hash")).Value := 'b2164b5024875a927f9e302ab255b4da5ebc96ca9cc2bcf1b378730838dccb86';
                                RecRef.Field(SalesInvoiceHeader.FieldNo("Acknowledgement No.")).Value := '172312637312945';
                                RecRef.Field(SalesInvoiceHeader.FieldNo("Acknowledgement Date")).Value := AckDate;
                                RecRef.Modify();
                                Message('E-Invoice Generated Successfully!!');
                            end;

                        end;
                    end;
                end;

            }
            action("Update Location Field")
            {
                ApplicationArea = All;
                Promoted = true;
                Visible = false;
                trigger OnAction()
                var
                    Location: Record 14;
                    Counter: Integer;
                begin
                    if UserId <> 'OBLTILES\D' then
                        Error('You are Not Authorize');
                    Clear(Counter);
                    Location.Reset();
                    Location.SetRange(Code, 'DRA-STORE');
                    if Location.FindSet() then
                        repeat
                            Counter += 1;
                            Location."Pin Code" := '392230';
                            /* Location.Username := 'manmohan.khare@orientbell.eyasp.com';
                            Location."E-InvAuthenticateURL" := 'https://eapi.eyasp.com/eapi/v2.0/authenticate';
                            Location."E-InvCancelURL" := 'https://eapi.eyasp.com/eapi/v2.0/cancelIRN';
                            Location."E-InvGenerateURL" := 'https://eapi.eyasp.com/eapi/v2.0/generateIRN';
                            Location.Password := 'T0JMQDIwMjA=';
                            Location.apiaccesskey := 'l7xx1521cf8bc25c4e18a0e8f3abba019451';
                             */
                            Location.Modify();
                        until Location.Next() = 0;
                    Message('Total Record Modify  %1', Counter);
                end;
            }
            action(CancelIRN)
            {
                Caption = 'Cancel IRN';
                ApplicationArea = All;
                Promoted = true;
                trigger OnAction()
                var
                    EInvoice: Codeunit 50200;
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    IF Rec."Posting Date" <= 20200930D THEN
                        ERROR('You cannot create IRN Before than 1st Oct 2020');
                    Rec.TESTFIELD("Acknowledgement No.");
                    Rec.TESTFIELD("Acknowledgement Date");
                    Rec.TESTFIELD("IRN Hash");
                    IF CONFIRM('Do you want to cancel the generated IRN?', FALSE) THEN BEGIN
                        CLEAR(EInvoice);
                        SalesInvoiceHeader.RESET;
                        SalesInvoiceHeader.SETFILTER("No.", '%1', Rec."No.");
                        IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                            EInvoice.SetSalesInvHeader(SalesInvoiceHeader);
                            EInvoice.CancelSalesIRNNo(SalesInvoiceHeader);
                        END;
                    END;

                end;
            }
            action(Test)
            {
                ApplicationArea = All;
                Promoted = true;

                Visible = false;
                trigger OnAction()
                var
                    JOutputObject: JsonObject;
                    JOutputToken: JsonToken;
                    JResultToken: JsonToken;
                    JResultObject: JsonObject;
                    OutputMessage: Text;
                    ResultMessage: Text;
                    EWayBillNo: Text[30];
                    EWayBillDateTime: Variant;
                    EWayExpiryDateTime: Variant;
                    TestJson: JsonObject;
                    TestArray: JsonArray;
                    TestJson2: JsonObject;
                    TestJson3: JsonObject;
                    JResultArray: JsonArray;
                    JItemArray: JsonArray;
                    JItemObject: JsonObject;

                begin
                    TestJson.Add('statusCd', '1');
                    TestJson.Add('refId', '');
                    TestJson.Add('data', TestJson2);

                    TestJson3.Add('sGstin', '09AAACO0305P1ZF');
                    TestJson3.Add('ewb', '461330207505');
                    TestJson3.Add('ewbDate', 'Apr 18, 2023 11:48:00 AM');
                    TestJson3.Add('validUpTo', 'Apr 19, 2023 11:59:00 PM');
                    TestArray.Add(TestJson3);
                    TestJson2.Add('success', TestArray);
                    //JItemObject.Add('test', '1');
                    //JItemArray.Add(JItemObject);
                    TestJson2.Add('error', JItemArray);
                    TestJson.WriteTo(ResultMessage);

                    JResultObject.ReadFrom(ResultMessage);

                    Message(ResultMessage);
                    if JResultObject.Get('data', JResultToken) then
                        if JResultToken.IsObject then begin
                            JResultToken.WriteTo(OutputMessage);
                            JOutputObject.ReadFrom(OutputMessage);
                        end;
                    if JOutputObject.Get('error', JOutputToken) then
                        if JOutputToken.IsArray then begin
                            JOutputToken.WriteTo(OutputMessage);
                            if OutputMessage = '[]' then begin
                                //JResultArray.ReadFrom(OutputMessage);
                                if JOutputObject.Get('success', JOutputToken) then
                                    if JOutputToken.IsArray then begin
                                        JOutputToken.WriteTo(OutputMessage);
                                        JResultArray.ReadFrom(OutputMessage);
                                        if JResultArray.Get(0, JOutputToken) then begin
                                            if JOutputToken.IsObject then begin
                                                JOutputToken.WriteTo(OutputMessage);
                                                JOutputObject.ReadFrom(OutputMessage);
                                            end;
                                        end;
                                    end;
                                if JOutputObject.Get('ewb', JOutputToken) then
                                    EWayBillNo := JOutputToken.AsValue().AsText();
                                if JOutputObject.Get('ewbDate', JOutputToken) then
                                    EWayBillDateTime := JOutputToken.AsValue().AsText();
                                if JOutputObject.Get('ewb', JOutputToken) then
                                    EWayBillNo := JOutputToken.AsValue().AsText();
                                if JOutputObject.Get('validUpTo', JOutputToken) then
                                    EWayExpiryDateTime := JOutputToken.AsValue().AsText();
                            end;
                        end;
                end;
            }
        }

    }

    var
        myInt: Integer;
}