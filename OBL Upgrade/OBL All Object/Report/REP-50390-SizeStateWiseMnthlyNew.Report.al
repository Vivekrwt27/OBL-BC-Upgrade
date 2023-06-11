report 50390 "Size/StateWise Mnthly New"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\SizeStateWiseMnthlyNew.rdl';

    dataset
    {
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            DataItemTableView = SORTING("Size Code", "Packing Code")//16225  State, 
                                ORDER(Ascending)
                                WHERE(Type = FILTER(Item));
            RequestFilterFields = "Location Code", "Size Code";//16225  State, 
            column(CompanyName1; CompanyName1)
            {
            }
            column(CompanyName2; CompanyName2)
            {
            }
            column(Filters; Filters)
            {
            }
            column(FinYear; FinYear)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(SizeName; SizeName)
            {
            }
            column(Qty1; Qty[1])
            {
            }
            column(Qty2; Qty[2])
            {
            }
            column(Qty3; Qty[3])
            {
            }
            column(Qty4; Qty[4])
            {
            }
            column(Qty5; Qty[5])
            {
            }
            column(Qty6; Qty[6])
            {
            }
            column(Qty7; Qty[7])
            {
            }
            column(Qty8; Qty[8])
            {
            }
            column(Qty9; Qty[9])
            {
            }
            column(Qty10; Qty[10])
            {
            }
            column(Qty11; Qty[11])
            {
            }
            column(Qty12; Qty[12])
            {
            }
            column(Qty13; Qty[13])
            {
            }
            column(Sqm1; Sqm[1])
            {
            }
            column(Sqm2; Sqm[2])
            {
            }
            column(Sqm3; Sqm[3])
            {
            }
            column(Sqm4; Sqm[4])
            {
            }
            column(Sqm5; Sqm[5])
            {
            }
            column(Sqm6; Sqm[6])
            {
            }
            column(Sqm7; Sqm[7])
            {
            }
            column(Sqm8; Sqm[8])
            {
            }
            column(Sqm9; Sqm[9])
            {
            }
            column(Sqm10; Sqm[10])
            {
            }
            column(Sqm11; Sqm[11])
            {
            }
            column(Sqm12; Sqm[12])
            {
            }
            column(Sqm13; Sqm[13])
            {
            }
            column(ExValue1; ExValue[1])
            {
            }
            column(ExValue2; ExValue[2])
            {
            }
            column(ExValue3; ExValue[3])
            {
            }
            column(ExValue4; ExValue[4])
            {
            }
            column(ExValue5; ExValue[5])
            {
            }
            column(ExValue6; ExValue[6])
            {
            }
            column(ExValue7; ExValue[7])
            {
            }
            column(ExValue8; ExValue[8])
            {
            }
            column(ExValue9; ExValue[9])
            {
            }
            column(ExValue10; ExValue[10])
            {
            }
            column(ExValue11; ExValue[11])
            {
            }
            column(ExValue12; ExValue[12])
            {
            }
            column(ExValue13; ExValue[13])
            {
            }
            column(RelperSqm1; RelperSqm[1])
            {
            }
            column(RelperSqm2; RelperSqm[2])
            {
            }
            column(RelperSqm3; RelperSqm[3])
            {
            }
            column(RelperSqm4; RelperSqm[4])
            {
            }
            column(RelperSqm5; RelperSqm[5])
            {
            }
            column(RelperSqm6; RelperSqm[6])
            {
            }
            column(RelperSqm7; RelperSqm[7])
            {
            }
            column(RelperSqm8; RelperSqm[8])
            {
            }
            column(RelperSqm9; RelperSqm[9])
            {
            }
            column(RelperSqm10; RelperSqm[10])
            {
            }
            column(RelperSqm11; RelperSqm[11])
            {
            }
            column(RelperSqm12; RelperSqm[12])
            {
            }
            column(RelperSqm13; RelperSqm[13])
            {
            }
            column(StateName; StateName)
            {
            }
            column(SizeCode; "Sales Invoice Line"."Size Code")
            {
            }
            //16225  column(State; "Sales Invoice Line".State)
            column(State; "Sales Invoice Line"."Size Code")
            {
            }
            column(RelSqtMtr1; RelSqtMtr[1])
            {
            }
            column(RelSqtMtr2; RelSqtMtr[2])
            {
            }
            column(RelSqtMtr3; RelSqtMtr[3])
            {
            }
            column(RelSqtMtr4; RelSqtMtr[4])
            {
            }

            trigger OnAfterGetRecord()
            var
                SIL: Record "Sales Invoice Line";
            begin
                //16225 Table N/F Start
                //TRI H.B 10.04.06 - add start
                /*  Structure.SETRANGE(Structure.Type, Structure.Type::Sale);
                  Structure.SETRANGE(Structure."Document Type", Structure."Document Type"::Invoice);
                  Structure.SETRANGE(Structure."Invoice No.", "Sales Invoice Line"."Document No.");
                  Structure.SETRANGE(Structure."Item No.", "Sales Invoice Line"."No.");
                  Structure.SETRANGE(Structure."Line No.", "Sales Invoice Line"."Line No.");
                  Structure.SETRANGE(Structure."Tax/Charge Type", Structure."Tax/Charge Type"::Charges);
                  Structure.SETRANGE(Structure."Tax/Charge Group", 'DISCOUNT');
                  IF Structure.FIND('-') THEN
                      cash := Structure."Amount (LCY)";*///16225 Table N/F End
                                                         //TRI H.B 10.04.06 - add stop
                CLEAR(Qty);
                CLEAR(Sqm);
                CLEAR(ExValue);
                CLEAR(RelperSqm);
                CLEAR(RelSqtMtr);
                IF DATE2DMY("Posting Date", 2) >= 4 THEN
                    Month := DATE2DMY("Posting Date", 2) - 3
                ELSE
                    Month := DATE2DMY("Posting Date", 2) + 9;

                Qty[Month] := "Sales Invoice Line".Quantity;

                Sqm[Month] := ROUND(item.UomToSqm("No.", "Unit of Measure Code", Quantity), 0.01, '=');
                //16225 Field N/F Start
                /*  IF ExValueType = ExValueType::"After Sales Tax" THEN
                      ExValue[Month] := "Amount Including Tax"
                  ELSE
                      IF ExValueType = ExValueType::"Before Sales Tax" THEN
                          ExValue[Month] := "Amount Including Tax" - "Tax Amount"
                      ELSE
                          IF ExValueType = ExValueType::"After Line Discount" THEN
                              ExValue[Month] := "Amount Including Tax" - "Line Discount Amount"

                          //TRI H.B 10.04.06 - add start
                          ELSE
                              IF ExValueType = ExValueType::"Before Excise" THEN
                         //ExValue[month] := "Amount Including Tax" - "Tax Amount"-"Excise Amount"
                         BEGIN
                                  IF "Location Code" = Plant THEN BEGIN
                                      ExValue[Month] := "Amount Including Tax" - "Tax Amount" - "Excise Amount"           //anurag
                                  END
                                  //TRI H.B 25.04.06 - code Add start
                                  ELSE BEGIN
                                      "Sales&ReceSetup".GET();
                                      ExciseNotForPlant := ("Sales Invoice Line"."Assessable Value") * (("Sales&ReceSetup"."Excise %") / 100);
                                      ExValue[Month] := "Amount Including Tax" - "Tax Amount" - ExciseNotForPlant
                                  END;
                              END
                              //TRI H.B 25.04.06 - code Add stop

                              ELSE
                                  IF ExValueType = ExValueType::"After Excise" THEN
                                      ExValue[Month] := "Amount Including Tax" - "Tax Amount";*/ //16225 Field N/F End
                                                                                                 //TRI H.B 10.04.06 - add stop






                //Section Code(+)
                SizeName := '';
                DimensionValue.RESET;
                InventorySetup.GET;
                IF DimensionValue.GET(InventorySetup."Size Code", "Sales Invoice Line"."Size Code") THEN
                    SizeName := DimensionValue.Name;
                //Section Code(-)

                CompanyInfo.GET;
                CompanyName1 := CompanyInfo.Name;
                CompanyName2 := CompanyInfo."Name 2";
                /*
                ***********************VISIBILITY********************
                   */
                IF CurrReport.TOTALSCAUSEDBY = FIELDNO("Size Code") THEN BEGIN
                    SizeName := '';
                    DimensionValue.RESET;
                    InventorySetup.GET;
                    IF DimensionValue.GET(InventorySetup."Size Code", "Sales Invoice Line"."Size Code") THEN
                        SizeName := DimensionValue.Name;
                END;


                /*
                ***********************VISIBILITY********************
                */
                FOR j := 1 TO 12 DO
                    RelperSqm[j] := 0;

                IF Sqm[Month] <> 0 THEN
                    RelperSqm[Month] := ExValue[Month] / Sqm[Month];

                //CurrReport.SKIP;


                /*
                *********************VISIBILITY**********************
                IF CurrReport.TOTALSCAUSEDBY = FIELDNO("Sales Invoice Line".State) THEN BEGIN
                 */
                //16225 table field N/F start
                /* IF StateGlob <> "Sales Invoice Line".State THEN BEGIN
                      StateName := '';
                      State1.RESET;
                      IF State1.GET("Sales Invoice Line".State) THEN
                          StateName := State1.Description;

                      Qty[13] := 0;
                      Sqm[13] := 0;
                      ExValue[13] := 0;
                      RelperSqm[13] := 0;

                      FOR j := 1 TO 12 DO BEGIN
                          RelperSqm[j] := 0;
                          IF Sqm[j] <> 0 THEN
                              RelperSqm[j] := ExValue[j] / Sqm[j];

                          Qty[13] := Qty[13] + Qty[j];
                          Sqm[13] := Sqm[13] + Sqm[j];
                          ExValue[13] := ExValue[13] + ExValue[j];
                      END;

                      IF Sqm[13] <> 0 THEN
                          RelperSqm[13] := ExValue[13] / Sqm[13];
                  END;*///16225 table field N/F End

                /*
              CurrReport.SHOWOUTPUT(TRUE);

           END
           ELSE
              CurrReport.SHOWOUTPUT := FALSE;
           *************************VISIBILITY********************
           */

                /*
                ************************VISIBILITY**********************
                
                IF CurrReport.TOTALSCAUSEDBY = FIELDNO("Size Code") THEN BEGIN
                */
                //TRI H.B 25.04.06 - code Add Start.

                IF SizeGlobal <> "Size Code" THEN BEGIN
                    Qty[13] := 0;
                    Sqm[13] := 0;
                    ExValue[13] := 0;
                    RelperSqm[13] := 0;

                    FOR j := 1 TO 12 DO BEGIN
                        RelperSqm[j] := 0;
                        IF Sqm[j] <> 0 THEN
                            RelperSqm[j] := ExValue[j] / Sqm[j];

                        Qty[13] := Qty[13] + Qty[j];
                        Sqm[13] := Sqm[13] + Sqm[j];
                        ExValue[13] := ExValue[13] + ExValue[j];
                    END;

                    IF Sqm[13] <> 0 THEN
                        RelperSqm[13] := ExValue[13] / Sqm[13];

                    //TRI H.B 25.04.06 - code Add Stop.
                    //TRI H.B 25.04.06 - Code Comment Start
                    Qty[13] := 0;
                    Sqm[13] := 0;
                    ExValue[13] := 0;

                    FOR j := 1 TO 12 DO BEGIN
                        Qty[13] := Qty[13] + Qty[j];
                        Sqm[13] := Sqm[13] + Sqm[j];
                        ExValue[13] := ExValue[13] + ExValue[j];
                    END;
                END;
                /*                                   // TRI H.B 25.04.06 - Code Comment Stop
                  CurrReport.SHOWOUTPUT := TRUE;

               END
               ELSE
                  CurrReport.SHOWOUTPUT := FALSE;
               ****************************VISIBILITY***********************************
               */


                //***************************VISIBILITY*******************************

                //TRI H.B 25.04.06 - code Add Start.
                Qty[13] := 0;
                Sqm[13] := 0;
                ExValue[13] := 0;
                RelperSqm[13] := 0;

                FOR j := 1 TO 12 DO BEGIN
                    RelperSqm[j] := 0;
                    IF Sqm[j] <> 0 THEN
                        RelperSqm[j] := ExValue[j] / Sqm[j];

                    Qty[13] := Qty[13] + Qty[j];
                    Sqm[13] := Sqm[13] + Sqm[j];
                    ExValue[13] := ExValue[13] + ExValue[j];
                END;

                IF Sqm[13] <> 0 THEN
                    RelperSqm[13] := ExValue[13] / Sqm[13];
                //TRI H.B 25.04.06 - code Add Stop
                //**************************VISIBILITY********************

                EXTotal[Month] += ExValue[Month];
                SqmTotal[Month] += Sqm[Month];

                FOR j := 1 TO 12 DO
                    RelperSqm[j] := 0;

                IF Sqm[Month] <> 0 THEN
                    RelperSqm[Month] := ExValue[Month] / Sqm[Month];


                SIL.RESET;
                SIL.COPY("Sales Invoice Line");
                IF SIL.NEXT <> 0 THEN BEGIN
                    //16225 Table Field N/F Start
                    /* IF (SIL.State <> "Sales Invoice Line".State) OR ("Sales Invoice Line"."Size Code" <> SIL."Size Code") THEN BEGIN
                         FOR j := 1 TO 12 DO BEGIN
                             IF SqmTotal[j] <> 0 THEN
                                 RelperSqm[j] := EXTotal[j] / SqmTotal[j]
                         END;
                         CLEAR(EXTotal);
                         CLEAR(SqmTotal);
                     END;
                 END ELSE BEGIN
                     FOR j := 1 TO 12 DO BEGIN
                         IF SqmTotal[j] <> 0 THEN
                             RelperSqm[j] := EXTotal[j] / SqmTotal[j]
                     END;
                     CLEAR(EXTotal);
                     CLEAR(SqmTotal);
                 END;

                 EXTotal1[Month] += ExValue[Month];
                 SqmTotal1[Month] += Sqm[Month];


                 SIL.RESET;
                 SIL.COPY("Sales Invoice Line");
                 IF SIL.NEXT <> 0 THEN BEGIN
                     IF ("Sales Invoice Line"."Size Code" <> SIL."Size Code") THEN BEGIN
                         FOR j := 1 TO 12 DO BEGIN
                             IF SqmTotal[j] <> 0 THEN
                                 RelperSqm[j] := EXTotal1[j] / SqmTotal1[j]
                         END;
                         CLEAR(EXTotal1);
                         CLEAR(SqmTotal1);
                     END;
                 END ELSE BEGIN
                     FOR j := 1 TO 12 DO BEGIN
                         IF SqmTotal1[j] <> 0 THEN
                             RelperSqm[j] := EXTotal1[j] / SqmTotal1[j]
                     END;
                     CLEAR(EXTotal1);
                     CLEAR(SqmTotal1);
                 END;


                 EXTotal2[Month] += ExValue[Month];
                 SqmTotal2[Month] += Sqm[Month];


                 SIL.RESET;
                 SIL.COPY("Sales Invoice Line");
                 IF SIL.NEXT = 0 THEN BEGIN
                     FOR j := 1 TO 12 DO BEGIN
                         IF SqmTotal2[j] <> 0 THEN
                             RelperSqm[j] := EXTotal2[j] / SqmTotal2[j]
                     END;*/ //16225 Table Field N/F End
                END;

            end;

            trigger OnPreDataItem()
            begin

                IF Plant <> '' THEN
                    SETFILTER("Plant Code", Plant);

                SETRANGE("Posting Date", DMY2DATE(1, 4, FinYear), DMY2DATE(31, 3, FinYear + 1));

                /*FOR i := 1 TO 12 DO
                   CurrReport.CREATETOTALS(Qty[i],Sqm[i],ExValue[i]);
                 */
                //MESSAGE('%1',COUNT)
                //"Sales Invoice Line".SETFILTER("Size Code",'045'

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1000000001)
                {
                    field("Financial Year"; FinYear)
                    {
                        ApplicationArea = All;
                    }
                    field("Plant Code"; Plant)
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            InventorySetup.GET;
                            DimensionValue.RESET;
                            DimensionValue.SETFILTER(DimensionValue."Dimension Code", '%1', InventorySetup."Plant Code");
                            IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                                Plant := DimensionValue.Code;
                        end;

                        trigger OnValidate()
                        begin
                            IF Plant <> '' THEN BEGIN
                                DimensionValue.RESET;
                                InventorySetup.GET;
                                IF NOT DimensionValue.GET(InventorySetup."Plant Code", Plant) THEN
                                    ERROR('Plant Code not exist');
                            END;
                        end;
                    }
                    field("Ex Value"; ExValueType)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        //RepAuditMgt.CreateAudit(50167)
    end;

    trigger OnPreReport()
    begin

        IF FinYear = 0 THEN
            ERROR('Please enter Financial Year');

        Filters := "Sales Invoice Line".GETFILTERS;
        Filters := Filters + ' ExValue Type : ' + FORMAT(ExValueType);

        InventorySetup.GET;
        IF Plant <> '' THEN BEGIN
            DimensionValue.RESET;
            IF DimensionValue.GET(InventorySetup."Plant Code", Plant) THEN
                Filters := Filters + ' Plant : ' + DimensionValue.Name;
        END;
    end;

    var
        InventorySetup: Record "Inventory Setup";
        DimensionValue: Record "Dimension Value";
        Plant: Code[1];
        PlantName: Text[30];
        SizeName: Text[30];
        FinYear: Integer;
        month: Integer;
        Qty: array[20] of Decimal;
        Sqm: array[20] of Decimal;
        ExValue: array[20] of Decimal;
        RelperSqm: array[20] of Decimal;
        i: Integer;
        Customer: Record Customer;
        CustName: Text[30];
        State1: Record State;
        StateName: Text[50];
        j: Integer;
        item: Record Item;
        ExValueType: Option "After Sales Tax","Before Sales Tax","After Line Discount","Before Excise","After Excise";
        CompanyInfo: Record "Company Information";
        CompanyName1: Text[100];
        Filters: Text[250];
        //16225Structure: Record "13798";
        cash: Decimal;
        "Sales&ReceSetup": Record "Sales & Receivables Setup";
        ExciseNotForPlant: Decimal;
        CompanyName2: Text[100];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        StateGlob: Code[20];
        SizeGlobal: Code[20];
        RelSqtMtr: array[20] of Decimal;
        StateCodeGl: Code[10];
        EXTotal: array[20] of Decimal;
        SqmTotal: array[20] of Decimal;
        MonthPrev: Integer;
        M: Integer;
        EXTotal1: array[20] of Decimal;
        SqmTotal1: array[20] of Decimal;
        EXTotal2: array[20] of Decimal;
        SqmTotal2: array[20] of Decimal;
}

