report 50331 "Internal Warehouse Receipt"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\InternalWarehouseReceipt.rdl';

    dataset
    {
        dataitem("Dimension Value"; "Dimension Value")
        {
            DataItemTableView = SORTING("Dimension Code", "Code")
                                WHERE("Dimension Code" = FILTER('SIZE'));
            RequestFilterFields = "Category Filter";
            column(Name_DimensionValue; "Dimension Value".Name)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(today; TODAY)
            {
            }
            column(time; TIME)
            {
            }
            column(FromDate; FORMAT(FromDate))
            {
            }
            column(ToDate; FORMAT(ToDate))
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
            column(TQuantity; TQuantity)
            {
            }

            trigger OnAfterGetRecord()
            begin

                //Section(+) Group Header
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


                /*
                SaleInvLine.RESET;
                SaleInvLine.SETRANGE("Size Code",Code);
                SaleInvLine.SETRANGE("Posting Date",FromDate,ToDate);
                IF LocCode1<>'' THEN
                SaleInvLine.SETFILTER("Location Code",'%1',LocCode1);
                IF ((LocCode1<>'') AND (LocCode2<>'')) THEN
                SaleInvLine.SETFILTER("Location Code",'%1|%2',LocCode1,LocCode2);
                IF ((LocCode1<>'') AND (LocCode2<>'') AND (LocCode3<>''))THEN
                SaleInvLine.SETFILTER("Location Code",'%1|%2|%3',LocCode1,LocCode2,LocCode3);
                IF ((LocCode1<>'') AND (LocCode2<>'') AND (LocCode3<>'') AND (LocCode4<>''))THEN
                SaleInvLine.SETFILTER("Location Code",'%1|%2|%3|%4',LocCode1,LocCode2,LocCode3,LocCode4);
                IF ((LocCode1<>'') AND (LocCode2<>'') AND (LocCode3<>'') AND (LocCode4<>'') AND (LocCode5<>''))THEN
                SaleInvLine.SETFILTER("Location Code",'%1|%2|%3|%4%5',LocCode1,LocCode2,LocCode3,LocCode4,LocCode5);
                IF SaleInvLine.FINDFIRST THEN REPEAT
                  IF SaleInvLine."Quality Code"='1' THEN BEGIN
                    PremQuantity+=SaleInvLine."Quantity (Base)";
                    TotPremQuantity+=SaleInvLine."Quantity (Base)";
                    PremAssessableValue+=SaleInvLine.Quantity*SaleInvLine."Assessable Value";
                    TotPremAssessableValue+=SaleInvLine.Quantity*SaleInvLine."Assessable Value";
                    PremExciseAmount+=SaleInvLine."BED Amount";
                    //PremCess+=SaleInvLine."CESS Amount";
                    PremECess+=SaleInvLine."eCess Amount";
                    TotPremExciseAmount+=SaleInvLine."BED Amount";
                    //TotPremCess+=SaleInvLine."CESS Amount";
                    TotPremECess+=SaleInvLine."eCess Amount";
                  END;
                  IF SaleInvLine."Quality Code"='2' THEN BEGIN
                    ComQuantity+=SaleInvLine."Quantity (Base)";
                    ComAssessableValue+=SaleInvLine."Assessable Value"*SaleInvLine.Quantity;
                    TotComQuantity+=SaleInvLine."Quantity (Base)";
                    TotComAssessableValue+=SaleInvLine."Assessable Value"*SaleInvLine.Quantity;
                    ComExciseAmount+=SaleInvLine."BED Amount";
                    //ComCess+=SaleInvLine."CESS Amount";
                    ComECess+=SaleInvLine."eCess Amount";
                    TotComExciseAmount+=SaleInvLine."BED Amount";
                    //TotComCess+=SaleInvLine."CESS Amount";
                    TotComECess+=SaleInvLine."eCess Amount";
                  END;
                  IF SaleInvLine."Quality Code"='3' THEN BEGIN
                    EcoQuantity+=SaleInvLine."Quantity (Base)";
                    EcoAssessableValue+=SaleInvLine."Assessable Value"*SaleInvLine.Quantity;
                    TotEcoQuantity+=SaleInvLine."Quantity (Base)";
                    TotEcoAssessableValue+=SaleInvLine."Assessable Value"*SaleInvLine.Quantity;
                    EcoExciseAmount+=SaleInvLine."BED Amount";
                  //  EcoCess+=SaleInvLine."CESS Amount";
                    EcoECess+=SaleInvLine."eCess Amount";
                    TotEcoExciseAmount+=SaleInvLine."BED Amount";
                  //  TotEcoCess+=SaleInvLine."CESS Amount";
                    TotEcoECess+=SaleInvLine."eCess Amount";
                  END;
                UNTIL SaleInvLine.NEXT=0;
                */

                TransferReceptLine.RESET;
                TransferReceptLine.SETRANGE("Size Code", Code);
                TransferReceptLine.SETRANGE("Receipt Date", FromDate, ToDate);
                TransferReceptLine.SETRANGE("External Transfer", FALSE);

                IF LocCode1 <> '' THEN
                    TransferReceptLine.SETFILTER("Transfer-to Code", '%1', LocCode1);
                IF ((LocCode1 <> '') AND (LocCode2 <> '')) THEN
                    TransferReceptLine.SETFILTER("Transfer-to Code", '%1|%2', LocCode1, LocCode2);
                IF ((LocCode1 <> '') AND (LocCode2 <> '') AND (LocCode3 <> '')) THEN
                    TransferReceptLine.SETFILTER("Transfer-to Code", '%1|%2|%3', LocCode1, LocCode2, LocCode3);
                IF ((LocCode1 <> '') AND (LocCode2 <> '') AND (LocCode3 <> '') AND (LocCode4 <> '')) THEN
                    TransferReceptLine.SETFILTER("Transfer-to Code", '%1|%2|%3|%4', LocCode1, LocCode2, LocCode3, LocCode4);
                IF ((LocCode1 <> '') AND (LocCode2 <> '') AND (LocCode3 <> '') AND (LocCode4 <> '') AND (LocCode5 <> '')) THEN
                    TransferReceptLine.SETFILTER("Transfer-to Code", '%1|%2|%3|%4|%5', LocCode1, LocCode2, LocCode3, LocCode4, LocCode5);
                IF TransferReceptLine.FINDFIRST THEN
                    REPEAT
                        IF TransferReceptLine."Quality Code" = '1' THEN BEGIN
                            PremQuantity += TransferReceptLine."Quantity (Base)";
                            //16225 field N/F Start
                            /*  PremAssessableValue += TransferReceptLine."Assessable Value" * TransferReceptLine.Quantity;
                              TotPremQuantity += TransferReceptLine."Quantity (Base)";
                              TotPremAssessableValue += TransferReceptLine."Assessable Value" * TransferReceptLine.Quantity;
                              PremExciseAmount += TransferReceptLine."BED Amount";
                              //  PremCess+=TransferReceptLine."CESS Amount";
                              PremECess += TransferReceptLine."eCess Amount";
                              TotPremExciseAmount += TransferReceptLine."BED Amount";
                              //  TotPremCess+=TransferReceptLine."CESS Amount";
                              TotPremECess += TransferReceptLine."eCess Amount";*///16225 field N/F End

                        END;
                        IF TransferReceptLine."Quality Code" = '2' THEN BEGIN
                            ComQuantity += TransferReceptLine."Quantity (Base)";
                            //16225 field N/F Start
                            /*  ComAssessableValue += TransferReceptLine."Assessable Value" * TransferReceptLine.Quantity;
                              TotComQuantity += TransferReceptLine."Quantity (Base)";
                              TotComAssessableValue += TransferReceptLine."Assessable Value" * TransferReceptLine.Quantity;
                              ComExciseAmount += TransferReceptLine."BED Amount";
                              // ComCess+=TransferReceptLine."CESS Amount";
                              ComECess += TransferReceptLine."eCess Amount";
                              TotComExciseAmount += TransferReceptLine."BED Amount";
                              // TotComCess+=TransferReceptLine."CESS Amount";
                              TotComECess += TransferReceptLine."eCess Amount";*///16225 field N/F End

                        END;
                        IF TransferReceptLine."Quality Code" = '3' THEN BEGIN
                            EcoQuantity += TransferReceptLine."Quantity (Base)";
                            //16225 field N/F Start
                            /*  EcoAssessableValue += TransferReceptLine."Assessable Value" * TransferReceptLine.Quantity;
                              TotEcoQuantity += TransferReceptLine."Quantity (Base)";
                              TotEcoAssessableValue += TransferReceptLine."Assessable Value" * TransferReceptLine.Quantity;

                              EcoExciseAmount += TransferReceptLine."BED Amount";
                              //   EcoCess+=TransferReceptLine."CESS Amount";
                              EcoECess += TransferReceptLine."eCess Amount";
                              TotEcoExciseAmount += TransferReceptLine."BED Amount";
                              //   TotEcoCess+=TransferReceptLine."CESS Amount";
                              TotEcoECess += TransferReceptLine."eCess Amount";*///16225 field N/F End

                        END;
                    UNTIL TransferReceptLine.NEXT = 0;


                PremCess := (PremECess / 2);
                ComCess := (ComECess / 2);
                EcoCess := (EcoECess / 2);

                TQuantity := PremQuantity + ComQuantity + EcoQuantity;
                TAssessableValue := PremAssessableValue + ComAssessableValue + EcoAssessableValue;
                TExciseAmount := PremExciseAmount + ComExciseAmount + EcoExciseAmount;
                TCess := PremCess + ComCess + EcoCess;
                TECess := PremECess + ComECess + EcoECess;

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
                    CurrReport.SHOWOUTPUT(FALSE)
                // ELSE
                //Section(-) Group Header

            end;

            trigger OnPreDataItem()
            begin
                // Section(+) Header
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
                //Secton(-) Header
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
        //RepAuditMgt.CreateAudit(50331);
    end;

    trigger OnPreReport()
    begin

        IF ((FromDate = 0D) OR (ToDate = 0D)) THEN
            ERROR('Please Select the Date for Report');
    end;

    var
        TransferReceptLine: Record "Transfer Receipt Line";
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
        RepAuditMgt: Codeunit "Auto PDF Generate";
        ExcelBuf: Record "Excel Buffer";
        K: Integer;
        ExportToExcel: Boolean;
}

