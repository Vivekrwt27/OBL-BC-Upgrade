report 50330 "Excise Details"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\ExciseDetails.rdl';

    dataset
    {
        dataitem("Dimension Value"; "Dimension Value")
        {
            DataItemTableView = SORTING("Dimension Code", Code)
                                WHERE("Dimension Code" = FILTER('SIZE'),
                                      Code = FILTER('<>BISCUIT 250X375' & '<>BISCUIT 300X450'));
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(PageNo; CurrReport.PAGENO)
            {
            }
            column(FromAndToDate; FORMAT(FromDate) + ' .. ' + FORMAT(ToDate))
            {
            }
            column(Name_DimensionValue; "Dimension Value".Name)
            {
            }
            column(PremQuantity; PremQuantity)
            {
            }
            column(ComQuantity; ComQuantity)
            {
            }
            column(EcoQuantity; EcoQuantity)
            {
            }
            column(OtherQuantity; OtherQuantity)
            {
            }
            column(TQuantity; TQuantity)
            {
            }
            column(PremAssessableValue; PremAssessableValue)
            {
            }
            column(ComAssessableValue; ComAssessableValue)
            {
            }
            column(EcoAssessableValue; EcoAssessableValue)
            {
            }
            column(OtherAssessableValue; OtherAssessableValue)
            {
            }
            column(TAssessableValue; TAssessableValue)
            {
            }
            column(PremExciseAmount; PremExciseAmount)
            {
            }
            column(ComExciseAmount; ComExciseAmount)
            {
            }
            column(EcoExciseAmount; EcoExciseAmount)
            {
            }
            column(OtherExciseAmount; OtherExciseAmount)
            {
            }
            column(TExciseAmount; TExciseAmount)
            {
            }
            column(PremECess; PremECess)
            {
            }
            column(ComECess; ComECess)
            {
            }
            column(EcoECess; EcoECess)
            {
            }
            column(OtherECess; OtherECess)
            {
            }
            column(TECess; TECess)
            {
            }
            column(PremCess; PremCess)
            {
            }
            column(ComCess; ComCess)
            {
            }
            column(EcoCess; EcoCess)
            {
            }
            column(OtherCess; OtherCess)
            {
            }
            column(TCess; TCess)
            {
            }
            column(TotPremQuantity; TotPremQuantity)
            {
            }
            column(TotComQuantity; TotComQuantity)
            {
            }
            column(TotEcoQuantity; TotEcoQuantity)
            {
            }
            column(TotOtherQuantity; TotOtherQuantity)
            {
            }
            column(TTQuantity; TTQuantity)
            {
            }
            column(TotPremAssessableValue; TotPremAssessableValue)
            {
            }
            column(TotComAssessableValue; TotComAssessableValue)
            {
            }
            column(TotEcoAssessableValue; TotEcoAssessableValue)
            {
            }
            column(TotOtherAssessableValue; TotOtherAssessableValue)
            {
            }
            column(TTAssessableValue; ROUND(TTAssessableValue, 1))
            {
            }
            column(TotPremExciseAmount; TotPremExciseAmount)
            {
            }
            column(TotComExciseAmount; TotComExciseAmount)
            {
            }
            column(TotEcoExciseAmount; TotEcoExciseAmount)
            {
            }
            column(TotOtherExciseAmount; TotOtherExciseAmount)
            {
            }
            column(TTExciseAmount; ROUND(TTExciseAmount, 1))
            {
            }
            column(TotPremECess; TotPremECess)
            {
            }
            column(TotComECess; TotComECess)
            {
            }
            column(TotEcoECess; TotEcoECess)
            {
            }
            column(TotOtherECess; TotOtherECess)
            {
            }
            column(TTECess; ROUND(TTECess, 1))
            {
            }
            column(TotPremCess; TotPremCess)
            {
            }
            column(TotComCess; TotComCess)
            {
            }
            column(TotEcoCess; TotEcoCess)
            {
            }
            column(TotOtherCess; TotOtherCess)
            {
            }
            column(TTCess; ROUND(TTCess, 1))
            {
            }
            column(VisibleBol; VisibleBol)
            {
            }
            column(time; FORMAT(TIME))
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Header 1 +
                TotPremQuantity := 0;
                TotComQuantity := 0;
                TotEcoQuantity := 0;
                TotAssessableValue := 0;
                TotPremAssessableValue := 0;
                TotEcoAssessableValue := 0;
                TotComAssessableValue := 0;
                TotPremExciseAmount := 0;
                TotComExciseAmount := 0;
                TotEcoExciseAmount := 0;
                TotPremCess := 0;
                TotComCess := 0;
                TotEcoCess := 0;
                TotPremECess := 0;
                TotComECess := 0;
                TotEcoECess := 0;

                TTQuantity := 0;
                TTAssessableValue := 0;
                TTExciseAmount := 0;
                TTCess := 0;
                TTECess := 0;
                //Header 1 -

                //GroupHeader 3 +

                PremQuantity := 0;
                ComQuantity := 0;
                EcoQuantity := 0;
                PremAssessableValue := 0;
                EcoAssessableValue := 0;
                ComAssessableValue := 0;
                PremExciseAmount := 0;
                ComExciseAmount := 0;
                EcoExciseAmount := 0;
                PremCess := 0;
                ComCess := 0;
                EcoCess := 0;
                PremECess := 0;
                ComECess := 0;
                EcoECess := 0;
                TQuantity := 0;
                TAssessableValue := 0;
                TExciseAmount := 0;
                TCess := 0;
                TECess := 0;
                OtherQuantity := 0;
                OtherAssessableValue := 0;
                OtherExciseAmount := 0;
                OtherECess := 0;
                OtherCess := 0;
                // GroupHeader 3 -


                //GroupHeader 3 +

                SaleInvLine.RESET;
                //SaleInvLine.SETCURRENTKEY();
                SaleInvLine.SETRANGE("Size Code", Code);
                SaleInvLine.SETRANGE("Posting Date", FromDate, ToDate);
                IF LocCode1 <> '' THEN
                    SaleInvLine.SETFILTER("Location Code", '%1', LocCode1);
                IF ((LocCode1 <> '') AND (LocCode2 <> '')) THEN
                    SaleInvLine.SETFILTER("Location Code", '%1|%2', LocCode1, LocCode2);
                IF ((LocCode1 <> '') AND (LocCode2 <> '') AND (LocCode3 <> '')) THEN
                    SaleInvLine.SETFILTER("Location Code", '%1|%2|%3', LocCode1, LocCode2, LocCode3);
                IF ((LocCode1 <> '') AND (LocCode2 <> '') AND (LocCode3 <> '') AND (LocCode4 <> '')) THEN
                    SaleInvLine.SETFILTER("Location Code", '%1|%2|%3|%4', LocCode1, LocCode2, LocCode3, LocCode4);
                IF ((LocCode1 <> '') AND (LocCode2 <> '') AND (LocCode3 <> '') AND (LocCode4 <> '') AND (LocCode5 <> '')) THEN
                    SaleInvLine.SETFILTER("Location Code", '%1|%2|%3|%4%5', LocCode1, LocCode2, LocCode3, LocCode4, LocCode5);
                //SaleInvLine.SETFILTER(,'%1',SaleInvLine."Document type"::C);

                SaleInvLine.SETFILTER(Quantity, '<>%1', 0);//MSBS.Rao Dt. 29-08-12
                IF SaleInvLine.FINDFIRST THEN
                    REPEAT
                        IF SaleInvLine."Quality Code" = '1' THEN BEGIN
                            IF SaleInvLine."Unit of Measure Code" = 'PCS.' THEN BEGIN
                                PremQuantity += SaleInvLine."Quantity in Sq. Mt.";
                                TotPremQuantity += SaleInvLine."Quantity in Sq. Mt.";
                            END ELSE BEGIN
                                PremQuantity += SaleInvLine."Quantity (Base)";
                                TotPremQuantity += SaleInvLine."Quantity (Base)";
                            END;
                            //16225 field N/F Start
                            /*  PremAssessableValue += SaleInvLine.Quantity * SaleInvLine."Assessable Value";
                              TotPremAssessableValue += SaleInvLine.Quantity * SaleInvLine."Assessable Value";
                              PremExciseAmount += SaleInvLine."BED Amount";
                              //PremCess+=SaleInvLine."CESS Amount";
                              PremECess += SaleInvLine."eCess Amount";
                              TotPremExciseAmount += SaleInvLine."BED Amount";
                              //TotPremCess+=SaleInvLine."CESS Amount";
                              TotPremECess += SaleInvLine."eCess Amount";*///16225 field N/F End
                        END;
                        IF SaleInvLine."Quality Code" = '2' THEN BEGIN
                            IF SaleInvLine."Unit of Measure Code" = 'PCS.' THEN BEGIN
                                ComQuantity += SaleInvLine."Quantity in Sq. Mt.";
                                TotComQuantity += SaleInvLine."Quantity in Sq. Mt.";
                            END ELSE BEGIN
                                ComQuantity += SaleInvLine."Quantity (Base)";
                                TotComQuantity += SaleInvLine."Quantity (Base)";
                            END;
                            //16225 field N/F Start
                            /* ComAssessableValue += SaleInvLine."Assessable Value" * SaleInvLine.Quantity;
                             TotComAssessableValue += SaleInvLine."Assessable Value" * SaleInvLine.Quantity;
                             ComExciseAmount += SaleInvLine."BED Amount";
                             //ComCess+=SaleInvLine."CESS Amount";
                             ComECess += SaleInvLine."eCess Amount";
                             TotComExciseAmount += SaleInvLine."BED Amount";
                             //TotComCess+=SaleInvLine."CESS Amount";
                             TotComECess += SaleInvLine."eCess Amount";*///16225 field N/F End
                        END;
                        IF SaleInvLine."Quality Code" = '3' THEN BEGIN
                            IF SaleInvLine."Unit of Measure Code" = 'PCS.' THEN BEGIN
                                EcoQuantity += SaleInvLine."Quantity in Sq. Mt.";
                                TotEcoQuantity += SaleInvLine."Quantity in Sq. Mt.";
                            END ELSE BEGIN
                                EcoQuantity += SaleInvLine."Quantity (Base)";
                                TotEcoQuantity += SaleInvLine."Quantity (Base)";
                            END;
                            //16225 field N/F Start
                            /* EcoAssessableValue += SaleInvLine."Assessable Value" * SaleInvLine.Quantity;
                             TotEcoAssessableValue += SaleInvLine."Assessable Value" * SaleInvLine.Quantity;
                             EcoExciseAmount += SaleInvLine."BED Amount";
                             //  EcoCess+=SaleInvLine."CESS Amount";
                             EcoECess += SaleInvLine."eCess Amount";
                             TotEcoExciseAmount += SaleInvLine."BED Amount";
                             //  TotEcoCess+=SaleInvLine."CESS Amount";
                             TotEcoECess += SaleInvLine."eCess Amount";*///16225 field N/F end
                        END;
                        IF SaleInvLine."Quality Code" = '' THEN BEGIN
                            IF SaleInvLine."Unit of Measure Code" = 'PCS.' THEN BEGIN
                                OtherQuantity += SaleInvLine."Quantity in Sq. Mt.";
                                TotOtherQuantity += SaleInvLine."Quantity in Sq. Mt.";
                            END ELSE BEGIN
                                OtherQuantity += SaleInvLine."Quantity (Base)";
                                TotOtherQuantity += SaleInvLine."Quantity (Base)";
                            END;
                            //16225 field N/F Start
                            /*OtherAssessableValue += SaleInvLine.Quantity * SaleInvLine."Assessable Value";
                            TotOtherAssessableValue += SaleInvLine.Quantity * SaleInvLine."Assessable Value";
                            OtherExciseAmount += SaleInvLine."BED Amount";
                            TotOtherExciseAmount += SaleInvLine."BED Amount";
                            //PremCess+=SaleInvLine."CESS Amount";
                            OtherECess += SaleInvLine."eCess Amount";
                            TotOtherECess += SaleInvLine."eCess Amount";*///16225 field N/F End
                            //TotPremCess+=SaleInvLine."CESS Amount";
                        END;

                    UNTIL SaleInvLine.NEXT = 0;




                TransfershipLine.RESET;
                TransfershipLine.SETRANGE("Size Code", Code);
                TransfershipLine.SETRANGE("Shipment Date", FromDate, ToDate);
                IF LocCode1 <> '' THEN
                    TransfershipLine.SETFILTER("Transfer-from Code", '%1', LocCode1);
                IF ((LocCode1 <> '') AND (LocCode2 <> '')) THEN
                    TransfershipLine.SETFILTER("Transfer-from Code", '%1|%2', LocCode1, LocCode2);
                IF ((LocCode1 <> '') AND (LocCode2 <> '') AND (LocCode3 <> '')) THEN
                    TransfershipLine.SETFILTER("Transfer-from Code", '%1|%2|%3', LocCode1, LocCode2, LocCode3);
                IF ((LocCode1 <> '') AND (LocCode2 <> '') AND (LocCode3 <> '') AND (LocCode4 <> '')) THEN
                    TransfershipLine.SETFILTER("Transfer-from Code", '%1|%2|%3|%4', LocCode1, LocCode2, LocCode3, LocCode4);
                IF ((LocCode1 <> '') AND (LocCode2 <> '') AND (LocCode3 <> '') AND (LocCode4 <> '') AND (LocCode5 <> '')) THEN
                    TransfershipLine.SETFILTER("Transfer-from Code", '%1|%2|%3|%4|%5', LocCode1, LocCode2, LocCode3, LocCode4, LocCode5);
                IF TransfershipLine.FINDFIRST THEN
                    REPEAT
                        IF TransfershipLine."Quality Code" = '1' THEN BEGIN
                            IF TransfershipLine."Unit of Measure Code" = 'PCS.' THEN
                                PremQuantity += TransfershipLine."Qty in Sq. Mt."
                            ELSE
                                PremQuantity += TransfershipLine."Quantity (Base)";

                            //16225 PremAssessableValue += TransfershipLine."Assessable Value" * TransfershipLine.Quantity;

                            IF TransfershipLine."Unit of Measure Code" = 'PCS.' THEN
                                TotPremQuantity += TransfershipLine."Qty in Sq. Mt."
                            ELSE
                                TotPremQuantity += TransfershipLine."Quantity (Base)";
                            //16225 field N/F Start
                            /* TotPremAssessableValue += TransfershipLine."Assessable Value" * TransfershipLine.Quantity;
                             PremExciseAmount += TransfershipLine."BED Amount";
                             //  PremCess+=TransfershipLine."CESS Amount";
                             PremECess += TransfershipLine."eCess Amount";
                             TotPremExciseAmount += TransfershipLine."BED Amount";
                             //  TotPremCess+=TransfershipLine."CESS Amount";
                             TotPremECess += TransfershipLine."eCess Amount";*///16225 field N/F End
                        END;
                        IF TransfershipLine."Quality Code" = '2' THEN BEGIN
                            ComQuantity += TransfershipLine."Quantity (Base)";
                            //16225 field N/F Start
                            /* ComAssessableValue += TransfershipLine."Assessable Value" * TransfershipLine.Quantity;
                             TotComQuantity += TransfershipLine."Quantity (Base)";
                             TotComAssessableValue += TransfershipLine."Assessable Value" * TransfershipLine.Quantity;
                             ComExciseAmount += TransfershipLine."BED Amount";
                             // ComCess+=TransfershipLine."CESS Amount";
                             ComECess += TransfershipLine."eCess Amount";
                             TotComExciseAmount += TransfershipLine."BED Amount";
                             // TotComCess+=TransfershipLine."CESS Amount";
                             TotComECess += TransfershipLine."eCess Amount";*///16225 field N/F End
                        END;
                        IF TransfershipLine."Quality Code" = '3' THEN BEGIN
                            EcoQuantity += TransfershipLine."Quantity (Base)";
                            //16225 field N/F Start
                            /* EcoAssessableValue += TransfershipLine."Assessable Value" * TransfershipLine.Quantity;
                             TotEcoQuantity += TransfershipLine."Quantity (Base)";
                             TotEcoAssessableValue += TransfershipLine."Assessable Value" * TransfershipLine.Quantity;

                             EcoExciseAmount += TransfershipLine."BED Amount";
                             //   EcoCess+=TransfershipLine."CESS Amount";
                             EcoECess += TransfershipLine."eCess Amount";
                             TotEcoExciseAmount += TransfershipLine."BED Amount";
                             //   TotEcoCess+=TransfershipLine."CESS Amount";
                             TotEcoECess += TransfershipLine."eCess Amount";*///16225 field N/F End
                        END;
                        IF TransfershipLine."Quality Code" = '' THEN BEGIN
                            OtherQuantity += TransfershipLine."Quantity (Base)";
                            //16225 field N/F Start
                            /*   OtherAssessableValue += TransfershipLine."Assessable Value" * TransfershipLine.Quantity;
                               TotOtherQuantity += TransfershipLine."Quantity (Base)";
                               TotOtherAssessableValue += TransfershipLine."Assessable Value" * TransfershipLine.Quantity;

                               OtherExciseAmount += TransfershipLine."BED Amount";
                               //   EcoCess+=TransfershipLine."CESS Amount";
                               OtherECess += TransfershipLine."eCess Amount";
                               TotOtherExciseAmount += TransfershipLine."BED Amount";
                               //   TotEcoCess+=TransfershipLine."CESS Amount";
                               TotOtherECess += TransfershipLine."eCess Amount";*///16225 field N/F End
                        END;

                    UNTIL TransfershipLine.NEXT = 0;

                //MSVC010213
                CrMemoLine.RESET;
                CrMemoLine.SETRANGE("Size Code", Code);
                CrMemoLine.SETRANGE("Posting Date", FromDate, ToDate);
                IF LocCode1 <> '' THEN
                    CrMemoLine.SETFILTER("Location Code", '%1', LocCode1);
                IF ((LocCode1 <> '') AND (LocCode2 <> '')) THEN
                    CrMemoLine.SETFILTER("Location Code", '%1|%2', LocCode1, LocCode2);
                IF ((LocCode1 <> '') AND (LocCode2 <> '') AND (LocCode3 <> '')) THEN
                    CrMemoLine.SETFILTER("Location Code", '%1|%2|%3', LocCode1, LocCode2, LocCode3);
                IF ((LocCode1 <> '') AND (LocCode2 <> '') AND (LocCode3 <> '') AND (LocCode4 <> '')) THEN
                    CrMemoLine.SETFILTER("Location Code", '%1|%2|%3|%4', LocCode1, LocCode2, LocCode3, LocCode4);
                IF ((LocCode1 <> '') AND (LocCode2 <> '') AND (LocCode3 <> '') AND (LocCode4 <> '') AND (LocCode5 <> '')) THEN
                    CrMemoLine.SETFILTER("Location Code", '%1|%2|%3|%4%5', LocCode1, LocCode2, LocCode3, LocCode4, LocCode5);
                //SaleInvLine.SETFILTER(,'%1',SaleInvLine."Document type"::C);

                CrMemoLine.SETFILTER(Quantity, '<>%1', 0);//MSBS.Rao Dt. 29-08-12
                IF CrMemoLine.FINDFIRST THEN
                    REPEAT
                        IF CrMemoLine."Quality Code" = '1' THEN BEGIN
                            PremQuantity += -CrMemoLine."Quantity (Base)";
                            TotPremQuantity += -CrMemoLine."Quantity (Base)";
                            //16225 field N/F Start
                            /*  PremAssessableValue += -(CrMemoLine.Quantity * CrMemoLine."Assessable Value");
                              TotPremAssessableValue += -(CrMemoLine.Quantity * CrMemoLine."Assessable Value");
                              PremExciseAmount += -CrMemoLine."BED Amount";
                              //PremCess+=SaleInvLine."CESS Amount";
                              PremECess += -CrMemoLine."eCess Amount";
                              TotPremExciseAmount += -CrMemoLine."BED Amount";
                              //TotPremCess+=SaleInvLine."CESS Amount";
                              TotPremECess += -CrMemoLine."eCess Amount";*///16225 field N/F End
                        END;
                        IF CrMemoLine."Quality Code" = '2' THEN BEGIN
                            ComQuantity += -CrMemoLine."Quantity (Base)";
                            //16225 field N/F Start
                            /*  ComAssessableValue += -(CrMemoLine."Assessable Value" * CrMemoLine.Quantity);
                              TotComQuantity += -CrMemoLine."Quantity (Base)";
                              TotComAssessableValue += -(CrMemoLine."Assessable Value" * CrMemoLine.Quantity);
                              ComExciseAmount += -CrMemoLine."BED Amount";
                              //ComCess+=SaleInvLine."CESS Amount";
                              ComECess += -CrMemoLine."eCess Amount";
                              TotComExciseAmount += -CrMemoLine."BED Amount";
                              //TotComCess+=SaleInvLine."CESS Amount";
                              TotComECess += -CrMemoLine."eCess Amount";*///16225 field N/F End
                        END;
                        IF CrMemoLine."Quality Code" = '3' THEN BEGIN
                            EcoQuantity += -CrMemoLine."Quantity (Base)";
                            //16225 field N/F Start
                            /*   EcoAssessableValue += -(CrMemoLine."Assessable Value" * CrMemoLine.Quantity);
                               TotEcoQuantity += -CrMemoLine."Quantity (Base)";
                               TotEcoAssessableValue += -(CrMemoLine."Assessable Value" * CrMemoLine.Quantity);
                               EcoExciseAmount += -CrMemoLine."BED Amount";
                               //  EcoCess+=SaleInvLine."CESS Amount";
                               EcoECess += -CrMemoLine."eCess Amount";
                               TotEcoExciseAmount += -CrMemoLine."BED Amount";
                               //  TotEcoCess+=SaleInvLine."CESS Amount";
                               TotEcoECess += -CrMemoLine."eCess Amount";*///16225 field N/F End
                        END;
                        IF CrMemoLine."Quality Code" = '' THEN BEGIN
                            OtherQuantity += -CrMemoLine."Quantity (Base)";
                            //16225 field N/F Start
                            /*    OtherAssessableValue += -(CrMemoLine."Assessable Value" * CrMemoLine.Quantity);
                                TotEcoQuantity += -CrMemoLine."Quantity (Base)";
                                TotEcoAssessableValue += -(CrMemoLine."Assessable Value" * CrMemoLine.Quantity);
                                EcoExciseAmount += -CrMemoLine."BED Amount";
                                //  EcoCess+=SaleInvLine."CESS Amount";
                                EcoECess += -CrMemoLine."eCess Amount";
                                TotEcoExciseAmount += -CrMemoLine."BED Amount";
                                //  TotEcoCess+=SaleInvLine."CESS Amount";
                                TotEcoECess += -CrMemoLine."eCess Amount";*///16225 field N/F End
                        END;

                    UNTIL CrMemoLine.NEXT = 0;


                //Msvc010213
                PremCess := (PremECess / 2);
                ComCess := (ComECess / 2);
                EcoCess := (EcoECess / 2);
                OtherCess := (OtherECess / 2);

                TQuantity := PremQuantity + ComQuantity + EcoQuantity + OtherQuantity;
                TAssessableValue := PremAssessableValue + ComAssessableValue + EcoAssessableValue + OtherAssessableValue;
                TExciseAmount := PremExciseAmount + ComExciseAmount + EcoExciseAmount + OtherExciseAmount;
                TCess := PremCess + ComCess + EcoCess + OtherCess;
                TECess := PremECess + ComECess + EcoECess + OtherECess;

                TTQuantity += TQuantity;
                TTAssessableValue += TAssessableValue;
                TTExciseAmount += TExciseAmount;
                TTCess += TCess;
                TTECess += TECess;




                IF ((PremQuantity = 0) AND
                  (ComQuantity = 0) AND
                  (EcoQuantity = 0) AND
                  (AssessableValue = 0) AND
                  (PremAssessableValue = 0) AND
                  (EcoAssessableValue = 0) AND
                  (ComAssessableValue = 0) AND
                  (PremExciseAmount = 0) AND
                  (ComExciseAmount = 0) AND
                  (EcoExciseAmount = 0) AND
                  (PremECess = 0) AND
                  (ComECess = 0) AND
                  (EcoECess = 0) AND
                  (PremCess = 0) AND
                  (ComCess = 0) AND
                  (EcoCess = 0)) THEN
                    VisibleBol := TRUE;

                //CurrReport.SHOWOUTPUT(FALSE);
                /*ELSE
                  IF ExportToExcel THEN BEGIN
                    EnterCell(K,1,FORMAT("Dimension Value".Name),TRUE,FALSE);
                    K+=1;
                  END;  */
                //GroupHeader 3 -

                // Body +

                IF ((PremQuantity = 0) AND
                  (ComQuantity = 0) AND
                  (EcoQuantity = 0) AND
                  (AssessableValue = 0) AND
                  (PremAssessableValue = 0) AND
                  (EcoAssessableValue = 0) AND
                  (ComAssessableValue = 0) AND
                  (PremExciseAmount = 0) AND
                  (ComExciseAmount = 0) AND
                  (EcoExciseAmount = 0) AND

                  (PremECess = 0) AND
                  (ComECess = 0) AND
                  (EcoECess = 0) AND

                  (PremCess = 0) AND
                  (ComCess = 0) AND
                  (EcoCess = 0)) THEN
                    CurrReport.SHOWOUTPUT(FALSE)
                ELSE

                    IF ExportToExcel THEN BEGIN
                        EnterCell(K, 1, 'Quantity(m2) : ', FALSE, FALSE);
                        EnterCell(K, 2, FORMAT(PremQuantity), FALSE, FALSE);
                        EnterCell(K, 3, FORMAT(ComQuantity), FALSE, FALSE);
                        EnterCell(K, 4, FORMAT(EcoQuantity), FALSE, FALSE);
                        EnterCell(K, 5, FORMAT(OtherQuantity), FALSE, FALSE);
                        EnterCell(K, 6, FORMAT(TQuantity), FALSE, FALSE);
                        K += 1;
                        EnterCell(K, 1, 'Assessable Value : ', FALSE, FALSE);
                        EnterCell(K, 2, FORMAT(PremAssessableValue), FALSE, FALSE);
                        EnterCell(K, 3, FORMAT(ComAssessableValue), FALSE, FALSE);
                        EnterCell(K, 4, FORMAT(EcoAssessableValue), FALSE, FALSE);
                        EnterCell(K, 5, FORMAT(OtherAssessableValue), FALSE, FALSE);
                        EnterCell(K, 6, FORMAT(TAssessableValue), FALSE, FALSE);
                        K += 1;
                        EnterCell(K, 1, 'Excise Duty : ', FALSE, FALSE);
                        EnterCell(K, 2, FORMAT(PremExciseAmount), FALSE, FALSE);
                        EnterCell(K, 3, FORMAT(ComExciseAmount), FALSE, FALSE);
                        EnterCell(K, 4, FORMAT(EcoExciseAmount), FALSE, FALSE);
                        EnterCell(K, 5, FORMAT(OtherExciseAmount), FALSE, FALSE);
                        EnterCell(K, 6, FORMAT(TExciseAmount), FALSE, FALSE);
                        K += 1;
                        EnterCell(K, 1, 'E - Cess on Excise : ', FALSE, FALSE);
                        EnterCell(K, 2, FORMAT(PremECess), FALSE, FALSE);
                        EnterCell(K, 3, FORMAT(ComECess), FALSE, FALSE);
                        EnterCell(K, 4, FORMAT(EcoECess), FALSE, FALSE);
                        EnterCell(K, 5, FORMAT(OtherECess), FALSE, FALSE);
                        EnterCell(K, 6, FORMAT(TECess), FALSE, FALSE);
                        K += 1;
                        EnterCell(K, 1, 'Cess on Excise : ', FALSE, FALSE);
                        EnterCell(K, 2, FORMAT(PremCess), FALSE, FALSE);
                        EnterCell(K, 3, FORMAT(ComCess), FALSE, FALSE);
                        EnterCell(K, 4, FORMAT(EcoCess), FALSE, FALSE);
                        EnterCell(K, 5, FORMAT(OtherCess), FALSE, FALSE);
                        EnterCell(K, 6, FORMAT(TCess), FALSE, FALSE);
                        K += 1;
                    END
                // Body -

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("From Date"; FromDate)
                {
                    ApplicationArea = All;
                }
                field("To Date"; ToDate)
                {
                    ApplicationArea = All;
                }
                field("Location Code 1"; LocCode1)
                {
                    TableRelation = Location;
                    ApplicationArea = All;
                }
                field("Location Code 2"; LocCode2)
                {
                    TableRelation = Location;
                    ApplicationArea = All;
                }
                field("Location Code 3"; LocCode3)
                {
                    TableRelation = Location;
                    ApplicationArea = All;
                }
                field("Location Code 4"; LocCode4)
                {
                    TableRelation = Location;
                    ApplicationArea = All;
                }
                field("Location Code 5"; LocCode5)
                {
                    TableRelation = Location;
                    ApplicationArea = All;
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

        //RepAuditMgt.CreateAudit(50330);
        //code comment +
        /*IF ExportToExcel THEN BEGIN
          ExcelBuf.CreateBook;
          ExcelBuf.CreateSheet('Excise Details','',COMPANYNAME,USERID);
          ExcelBuf.GiveUserControl;
        END; */
        //code comment -

    end;

    trigger OnPreReport()
    begin

        IF ((FromDate = 0D) OR (ToDate = 0D)) THEN
            ERROR('Please Select the Date for Report');
        IF ExportToExcel THEN BEGIN
            ExcelBuf.DELETEALL;
            CLEAR(ExcelBuf);
            EnterCell(1, 1, 'Size', TRUE, FALSE);
            EnterCell(1, 2, 'Premium', TRUE, FALSE);
            EnterCell(1, 3, 'Commercial', TRUE, FALSE);
            EnterCell(1, 4, 'Economy', TRUE, FALSE);
            EnterCell(1, 5, 'Other', TRUE, FALSE);
            EnterCell(1, 6, 'Total', TRUE, FALSE);
            K := 2;
        END;
    end;

    var
        TransfershipLine: Record "Transfer Shipment Line";
        SaleInvLine: Record "Sales Invoice Line";
        FromDate: Date;
        ToDate: Date;
        PremQuantity: Decimal;
        ComQuantity: Decimal;
        EcoQuantity: Decimal;
        AssessableValue: Decimal;
        PremAssessableValue: Decimal;
        EcoAssessableValue: Decimal;
        ComAssessableValue: Decimal;
        PremExciseAmount: Decimal;
        ComExciseAmount: Decimal;
        EcoExciseAmount: Decimal;
        PremCess: Decimal;
        ComCess: Decimal;
        EcoCess: Decimal;
        TransShipmentLine: Record "Transfer Shipment Line";
        TotPremQuantity: Decimal;
        TotComQuantity: Decimal;
        TotEcoQuantity: Decimal;
        TotAssessableValue: Decimal;
        TotPremAssessableValue: Decimal;
        TotEcoAssessableValue: Decimal;
        TotComAssessableValue: Decimal;
        TotPremExciseAmount: Decimal;
        TotComExciseAmount: Decimal;
        TotEcoExciseAmount: Decimal;
        TotPremCess: Decimal;
        TotComCess: Decimal;
        TotEcoCess: Decimal;
        LocCode1: Code[50];
        LocCode2: Code[50];
        LocCode3: Code[50];
        LocCode4: Code[50];
        LocCode5: Code[50];
        PremECess: Decimal;
        ComECess: Decimal;
        EcoECess: Decimal;
        TotPremECess: Decimal;
        TotComECess: Decimal;
        TotEcoECess: Decimal;
        TQuantity: Decimal;
        TAssessableValue: Decimal;
        TCess: Decimal;
        TExciseAmount: Decimal;
        TECess: Decimal;
        TTQuantity: Decimal;
        TTAssessableValue: Decimal;
        TTCess: Decimal;
        TTECess: Decimal;
        TTExciseAmount: Decimal;
        CrMemoLine: Record "Sales Cr.Memo Line";
        OtherQuantity: Decimal;
        TotOtherQuantity: Decimal;
        OtherAssessableValue: Decimal;
        TotOtherAssessableValue: Decimal;
        OtherExciseAmount: Decimal;
        OtherECess: Decimal;
        TotOtherExciseAmount: Decimal;
        TotOtherECess: Decimal;
        OtherCess: Decimal;
        TotOtherCess: Decimal;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        ExcelBuf: Record "Excel Buffer";
        K: Integer;
        ExportToExcel: Boolean;
        VisibleBol: Boolean;


    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean)
    begin
        // MSDR01.begin
        ExcelBuf.INIT;
        ExcelBuf.VALIDATE("Row No.", RowNo);
        ExcelBuf.VALIDATE("Column No.", ColumnNo);
        ExcelBuf."Cell Value as Text" := CellValue;
        ExcelBuf.Formula := '';
        ExcelBuf.Bold := Bold;
        ExcelBuf.Underline := UnderLine;
        ExcelBuf.INSERT;
        //END;
        // MSDR01.end
    end;
}

