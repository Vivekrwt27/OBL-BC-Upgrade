report 50288 "SO Creation"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(SQL2NAV1; "Item Wise Focused Prod.")
        {
            //16225  DataItemTableView = SORTING(Field6) ORDER(Ascending) WHERE(Field12 = FILTER(No));
            dataitem("Item Wise Focused Prod."; "Item Wise Focused Prod.")
            {
                /*  DataItemLink = Field5 = FIELD(Field5), Field6 = FIELD(Field6);
                  DataItemTableView = WHERE(Field12 = FILTER(No));*/

                trigger OnAfterGetRecord()
                begin
                    /* CASE CellName OF
                         'A1':
                             BEGIN
                                 SalesHeader.INIT;
                                 DocNo := NoSeriesMgt.GetNextNo(SeriesCode, TODAY, TRUE);
                                 //NoSeriesMgt.InitSeries('SOBA','',TODAY,SalesHeader."No.",SalesHeader."No. Series");
                                 SalesHeader.VALIDATE("Document Type", SalesHeader."Document Type"::Order);
                                 SalesHeader.VALIDATE("No.", DocNo);
                                 SalesHeader.VALIDATE("Order Booked Date", CURRENTDATETIME);
                                 SalesHeader.INSERT(TRUE);
                                 SalesHeader.VALIDATE("Group Code", LclGroupCode1);
                                 GetCustNo(PaymentCode, CustNo, "Item Wise Focused Prod.".MessageID);
                                 SalesHeader.VALIDATE("Sell-to Customer No.", CustNo);
                                 SalesHeader.VALIDATE("Payment Terms Code", PaymentCode);
                                 SalesHeader.MODIFY;
                             END;
                         'D4':
                             BEGIN
                                 SalesHeader.VALIDATE("Location Code", Value);
                                 LineLocCode := Value;
                                 SalesHeader.VALIDATE("Shortcut Dimension 1 Code", Value);
                                 SalesHeader.VALIDATE("No. Series", SeriesCode);
                                 //SalesHeader.VALIDATE("Posting No. Series", '');
                                 LocCode := Value;
                                 SalesHeader.MODIFY;
                             END;
                         'D5':
                             BEGIN
                                 EVALUATE(SalesHeader."Sales Type", "Item Wise Focused Prod.".Value);
                                 SalesHeader.VALIDATE("Sales Type");
                             END;
                         'D6':
                             BEGIN
                                 CASE "Item Wise Focused Prod.".Value OF
                                     'Set':
                                         SalesHeader.BD := TRUE;
                                     'Pet':
                                         SalesHeader.CKA := TRUE;
                                     'Get':
                                         SalesHeader.GPS := TRUE;
                                     'None':
                                         SalesHeader.None := TRUE;
                                 END;
                                 SalesHeader.MODIFY;
                             END;
                         'D9':
                             SalesHeader."PMT Code" := "Item Wise Focused Prod.".Value;
                         /*
                         'M40':
                           BEGIN
                             EVALUATE(SalesHeader."TPT Method", SQL2NAV.Value);
                             SalesHeader.VALIDATE("TPT Method");
                           END;

                         'I40':
                           BEGIN
                             EVALUATE(CDVal, DELSTR(SQL2NAV.Value,2,1));
                             SalesHeader.VALIDATE("Discount Charges %", CDVal);
                           END;
                          */

                    /* 'D53':
                         SalesHeader."Payment Terms Code" := "Item Wise Focused Prod.".Value;
                     'D16':
                         SalesHeader."Ship-to Address" := "Item Wise Focused Prod.".Value;
                     'D17':
                         SalesHeader."Ship-to Address 2" := "Item Wise Focused Prod.".Value;
                     'D18':
                         SalesHeader."Ship-to City" := "Item Wise Focused Prod.".Value;
                     'M18':
                         SalesHeader."Ship to Pin" := "Item Wise Focused Prod.".Value;
                     'I19':
                         SalesHeader."Ship-to Contact" := "Item Wise Focused Prod.".Value;
                 END;
                 SalesHeader.MODIFY;*/

                    /*16225  EVALUATE(ExlRNo, DELSTR(CellName, 1, 1));
                      CASE ExlRNo OF
                          RNo:
                              IF COPYSTR(CellName, 1, 1) = 'C' THEN BEGIN
                                  LineNo += 10000;
                                  SalesLine.INIT;
                                  SalesLine."Line No." := LineNo;
                                  SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::Order);
                                  SalesLine.VALIDATE("Document No.", DocNo);
                                  SalesLine.VALIDATE(Type, SalesLine.Type::Item);
                                  SalesLine.VALIDATE("No.", Value);
                                  //MESSAGE('SLine Code %1', LineLocCode);
                                  //SalesLine.VALIDATE("Location Code", LineLocCode);
                                  SalesLine.INSERT(TRUE);
                                  RNo += 1;
                              END;
                          RNo1:
                              // BEGIN
                              IF COPYSTR(CellName, 1, 1) = 'F' THEN BEGIN
                                  //RNo := 0;
                                  LineNo1 += 10000;
                                  SalesLine.RESET;
                                  SalesLine.SETRANGE("Document No.", DocNo);
                                  SalesLine.SETRANGE("Line No.", LineNo1);
                                  IF SalesLine.FINDFIRST THEN BEGIN
                                      EVALUATE(QtyInt, Value);
                                      SalesLine.Quantity := QtyInt;
                                      SalesLine.VALIDATE(Quantity);
                                      ///--
                                      SalesLine.D7 := GetRegDisc(MsgID, CellName);
                                      SalesLine.VALIDATE(D7);
                                      //--
                                      SalesLine.MODIFY;
                                  END;
                                  RNo1 += 1;
                              END;
                      END;*/
                    /*
                    recSQL2NAV.RESET;
                    recSQL2NAV.SETRANGE(MessageID,MessageID);
                    //recSQL2NAV.SETRANGE(SOCreated,FALSE);
                    recSQL2NAV.SETRANGE(CellName,CellName);
                    IF recSQL2NAV.FINDFIRST THEN BEGIN
                      //REPEAT
                        recSQL2NAV.VALIDATE(SOCreated,TRUE);
                        recSQL2NAV.MODIFY(TRUE);
                      //UNTIL recSQL2NAV.NEXT = 0;
                    END;
                    */

                end;

                trigger OnPostDataItem()
                begin
                    //16225 Start
                    /*  recSQL2NAV.RESET;
                      recSQL2NAV.SETRANGE(MessageID, MessageID);
                      recSQL2NAV.SETRANGE(SOCreated, FALSE);
                      //recSQL2NAV.SETRANGE(CellName,CellName);
                      IF recSQL2NAV.FINDFIRST THEN BEGIN
                          REPEAT
                              recSQL2NAV.VALIDATE(SOCreated, TRUE);
                              recSQL2NAV.MODIFY(TRUE);
                          UNTIL recSQL2NAV.NEXT = 0;
                      END;

                      MESSAGE('Sales Order %1 successfully created.', SalesHeader."No.");*///16225 End
                end;

                trigger OnPreDataItem()
                begin
                    RNo := 23;
                    RNo1 := 23;
                    LineNo := 0;
                    LineNo1 := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //16225 Satrt
                /*  IF SQL2NAV1.MessageID <> MsgID THEN BEGIN
                      MsgID := SQL2NAV1.MessageID;
                      MESSAGE(SQL2NAV1.MessageID);
                  END;

                  SeriesCode := GetNoSeriesCode(MsgID);
                  MESSAGE('1');
                  //--
                  recSQL2NAV.RESET;
                  recSQL2NAV.SETRANGE(MessageID, MsgID);
                  //recSQL2NAV.SETRANGE(Filename,MsgID);
                  recSQL2NAV.SETRANGE(SOCreated, FALSE);
                  //recSQL2NAV.SETFILTER(Value, '%1', 'K5');
                  IF recSQL2NAV.FINDSET THEN
                      REPEAT
                          CASE recSQL2NAV.Value OF
                              'Manuf.':
                                  LclGroupCode1 := '01';
                              'Trad':
                                  LclGroupCode1 := '02';
                              'Sample':
                                  LclGroupCode1 := '05';
                          END;
                      UNTIL recSQL2NAV.NEXT = 0;*///16225 End

                //LclGroupCode1 := GrpCode(MsgID);
            end;

            trigger OnPostDataItem()
            begin
                /*
                recSQL2NAV.RESET;
                //recSQL2NAV.SETRANGE(Filename, Filename);
                recSQL2NAV.SETRANGE(MessageID,MessageID);
                recSQL2NAV.SETRANGE(SOCreated,FALSE);
                IF recSQL2NAV.FINDSET THEN
                  REPEAT
                    recSQL2NAV.VALIDATE(SOCreated,TRUE);
                    recSQL2NAV.MODIFY;
                  UNTIL recSQL2NAV.NEXT = 0;
                  */

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        InsertDataIntoNAVT;
    end;

    var
        SOData1: Record "Branch Wise focused Prod IBOT";
        SOData12: Record "Branch Wise focused Prod IBOT";
        ExcelBuffer: Record "Excel Buffer";
        xRowNo: Integer;
        recInteger: Record Integer;
        RowNo: Integer;
        TempExcelBuffer: Record "Excel Buffer";
        SalesLine: Record "Sales Line";
        QtyInt: Integer;
        "----031019----": Integer;
        RNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        LineNo1: Integer;
        RNo1: Integer;
        "--------": Integer;
        ExlRNo: Integer;
        ExlColNo: Integer;
        DocNo: Code[20];
        "----Hdr---": Integer;
        SalesHeader: Record "Sales Header";
        NoSeries: Record "No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        recSQL2NAV: Record "Item Wise Focused Prod.";
        "--------------------": Integer;
        CustNo: Code[20];
        PaymentCode: Code[10];
        GroupCode: Code[10];
        PostingDt: DateTime;
        MsgID: Text;
        SeriesCode: Code[20];
        LocCode: Code[20];
        GroupCode1: Code[10];
        LclGroupCode1: Code[10];
        CDPer: Decimal;
        CDVal: Decimal;
        SQLData: Record "Item Wise Focused Prod.";
        RegDisc: Decimal;
        LineLocCode: Code[20];

    local procedure GetCustNo(var PayCode: Code[10]; var CustCode: Code[20]; var MsgID: Text)
    var
        recSQL2NAV: Record "Item Wise Focused Prod.";
    begin
        //16225 Start
        /* recSQL2NAV.RESET;
         recSQL2NAV.SETRANGE(MessageID, MsgID);
         //recSQL2NAV.SETRANGE(Filename,MsgID);
         recSQL2NAV.SETRANGE(SOCreated, FALSE);
         IF recSQL2NAV.FINDSET THEN
             REPEAT
                 CASE recSQL2NAV.CellName OF
                     'D11':
                         CustCode := recSQL2NAV.Value;
                     'D53':
                         BEGIN
                             PayCode := recSQL2NAV.Value;
                             // GrpCode := recSQL2NAV.Value;
                         END;
                 END;
             UNTIL recSQL2NAV.NEXT = 0;*///16225 End

        /*
        recSQL2NAV.RESET;
        recSQL2NAV.SETRANGE(MessageID, MsgID);
        recSQL2NAV.SETRANGE(CellName, 'D44');
        IF recSQL2NAV.FINDFIRST THEN
          PayCode := recSQL2NAV.Value;
        
        recSQL2NAV.RESET;
        recSQL2NAV.SETRANGE(MessageID, MsgID);
        recSQL2NAV.SETRANGE(CellName, 'D44');
        IF recSQL2NAV.FINDFIRST THEN
          GrpCode := recSQL2NAV.Value;
        
        recSQL2NAV.RESET;
        recSQL2NAV.SETRANGE(CellName, 'N2');
        IF recSQL2NAV.FINDFIRST THEN
          EVALUATE(SODate,recSQL2NAV.Value);
          */

    end;

    local procedure GetNoSeriesCode(FncMsgID: Text) NoSrCode: Code[20]
    var
        NoSeries: Record "No. Series";
        LocCode: Code[20];
        SOImpExp: Text;
    begin
        //16225 start
        /* recSQL2NAV.RESET;
         recSQL2NAV.SETRANGE(MessageID, FncMsgID);
         //recSQL2NAV.SETRANGE(Filename,FncMsgID);
         recSQL2NAV.SETRANGE(SOCreated, FALSE);
         IF recSQL2NAV.FINDSET THEN
             REPEAT
                 CASE recSQL2NAV.CellName OF
                     'D4':
                         LocCode := recSQL2NAV.Value;
                     'L4':
                         SOImpExp := recSQL2NAV.Value
                 END;
             UNTIL recSQL2NAV.NEXT = 0;*///16225 End

        NoSeries.RESET;
        NoSeries.SETFILTER("Sales Imp. or Exp.", SOImpExp);
        NoSeries.SETRANGE(Location, LocCode);
        IF NoSeries.FINDFIRST THEN
            NoSrCode := NoSeries.Code;
    end;

    local procedure InsertDataIntoNAVT()
    var
        //16225 ExecuteBat: DotNet ProcessStartInfo;
        //16225   Process: DotNet Process;
        Command: Text;
        Result: Text;
        ErrorMsg: Text;
    begin
        //Not in working---
        //16225 Start
        /*  Command := 'D:\EmailReader\EmailReaderByNAV.bat';
          ExecuteBat := ExecuteBat.ProcessStartInfo('cmd', '/c "' + Command + '"');     //Provide Details of the Process that need to be Executed.
          ExecuteBat.RedirectStandardError := TRUE;      // In Case of Error the Error Should be Redirected.
          ExecuteBat.RedirectStandardOutput := TRUE;     // In Case of Sucess the Error Should be Redirected.
          ExecuteBat.UseShellExecute := FALSE;
          ExecuteBat.CreateNoWindow := TRUE;             // In case we want to see the window set it to False.
          Process := Process.Process;                    // Constructor
          Process.StartInfo(ExecuteBat);
          Process.Start;
          ErrorMsg := Process.StandardError.ReadToEnd(); // Check Error Exist or Not
          IF ErrorMsg <> '' THEN
              ERROR('error msg')
          ELSE BEGIN
              Result := Process.StandardOutput.ReadToEnd();// Display the Query in the Batch File.
          END;*///16225 End
    end;

    local procedure GrpCode(MessageIdnt: Text) LclGroupCode: Code[10]
    begin
        //16225 Start
        /* recSQL2NAV.RESET;
         recSQL2NAV.SETRANGE(MessageID, MsgID);
         //recSQL2NAV.SETRANGE(Filename, MsgID);
         recSQL2NAV.SETRANGE(SOCreated, FALSE);
         IF recSQL2NAV.FINDSET THEN
             REPEAT
                 CASE recSQL2NAV.Value OF
                     'Manuf':
                         LclGroupCode := '01';
                     'Trad':
                         LclGroupCode := '02';
                     'Sample':
                         LclGroupCode := '05';
                 END;
             UNTIL recSQL2NAV.NEXT = 0;*///16225 End
    end;

    local procedure GetRegDisc(MsgIDNo: Text; DiscCell: Text) RegDisc: Decimal
    var
        recSalesLine: Record "Sales Line";
        DiscSQL2NAV: Record "Item Wise Focused Prod.";
        Cell: Text;
    begin
        Cell := 'N' + DELSTR(DiscCell, 1, 1);
        recSQL2NAV.RESET;
        //16225 Start
        /* recSQL2NAV.SETRANGE(MessageID, MsgIDNo);
         //recSQL2NAV.SETRANGE(Filename, MsgIDNo);
         recSQL2NAV.SETRANGE(CellName, Cell);
         recSQL2NAV.SETRANGE(SOCreated, FALSE);
         IF recSQL2NAV.FINDFIRST THEN BEGIN
             EVALUATE(RegDisc, recSQL2NAV.Value);//16225 End
         END;*/
    end;
}

