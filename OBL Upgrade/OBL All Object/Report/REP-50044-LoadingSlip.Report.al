report 50044 "Loading Slip"
{
    // //-- 1. Tri PG 21112006 - New Data Item Sales Comment Line Added
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\LoadingSlip.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Sales Header"; 36)
        {
            CalcFields = "State Description";
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(TransporterName; TransporterName)
            {
            }
            column(ShowDetails; ShowDetails)
            {

            }
            column(Today; FORMAT(TODAY))
            {
            }
            column(Time; TIME)
            {
            }
            column(TruckNo; "Sales Header"."Truck No.")
            {
            }
            column(Name_CompanyInformation; CompInfo.Name)
            {
            }
            column(Name2_CompanyInformation; CompInfo."Name 2")
            {
            }
            column(Address_CompanyInformation; CompInfo.Address)
            {
            }
            column(Address2_CompanyInformation; CompInfo."Address 2")
            {
            }
            column(City_CompanyInformation; CompInfo.City)
            {
            }
            column(PostCode_CompanyInformation; CompInfo."Post Code")
            {
            }
            column(State_CompanyInformation; CompInfo."State Code") // 16630 replace here State
            {
            }
            column(Pay_SalesHeader; "Sales Header".Pay)
            {
            }
            column(No_SalesHeader; "Sales Header"."No.")
            {
            }
            column(ReleasingDate_SalesHeader; FORMAT("Sales Header"."Releasing Date"))
            {
            }
            column(OrderDate; FORMAT("Sales Header"."Order Date"))
            {
            }
            column(ReleasingTime_SalesHeader; "Sales Header"."Releasing Time")
            {
            }
            column(TPTMethod_SalesHeader; "Sales Header"."TPT Method")
            {
            }
            column(ShiptoName_SalesHeader; "Sales Header"."Ship-to Name")
            {
            }
            column(ShiptoContact_SalesHeader; "Sales Header"."Ship-to Contact")
            {
            }
            column(PromisedDeliveryDate_SalesHeader; FORMAT("Sales Header"."Promised Delivery Date"))
            {
            }
            column(ShiptoCity_SalesHeader; "Sales Header"."Ship-to City")
            {
            }
            column(ShiptoAddress_SalesHeader; "Sales Header"."Ship-to Address")
            {
            }
            column(ShiptoAddress2_SalesHeader; "Sales Header"."Ship-to Address 2")
            {
            }
            column(StateDesc_SalesHeader; sstate)
            {
            }
            column(CustomerType_SalesHeader; "Sales Header"."Customer Type")
            {
            }
            column(PONo_SalesHeader; "Sales Header"."PO No.")
            {
            }
            column(ShiptoName2_SalesHeader; "Sales Header"."Ship-to Name 2")
            {
            }
            column(TruckNo_SalesHeader; "Sales Header"."Truck No.")
            {
            }
            column(GroupCodeDesc; GroupCode.Description)
            {
            }
            column(GroupCodeDesc2; GroupCode.Description2)
            {
            }
            column(PoNum; "Sales Header"."PO No.")
            {
            }
            column(tptmth; tptmth)
            {
            }
            column(LST; LST)
            {
            }
            column(CST; CST)
            {
            }
            column(SP_Phone; spphone)
            {
            }
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                column(CopiesPrinted; CopiesPrinted)
                {
                }
                dataitem(PageLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(CopyText; CopyText)
                    {
                    }
                    dataitem("Sales Line"; 37)
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Plant Code", Description)
                                            ORDER(Ascending)
                                            WHERE("Document Type" = FILTER(Order),
                                                  Type = FILTER(Item));
                        RequestFilterFields = "Plant Code";
                        column(DocNoSL; "Sales Line"."Document No.")
                        {
                        }
                        column(ItemNo; "Sales Line"."No.")
                        {

                        }
                        column(SNo; SNo)
                        {
                        }
                        column(PlantName; PlantName)
                        {
                        }
                        column(Wt; Wt)
                        {
                        }
                        column(ResWt; ResWt)
                        {
                        }
                        column(QtySqmt; "Sales Line"."Reserved Qty. (Base)")
                        {

                        }
                        column(SUMQtySqmt; SUMQtySqmt)
                        {

                        }
                        column(OutstandingQuantity_SalesLine; "Sales Line"."Outstanding Quantity")
                        {
                        }
                        column(Quantity_SalesLine; "Sales Line".Quantity)
                        {
                        }
                        column(SUMQtySL; SUMQtySL)
                        {

                        }
                        column(Crt_wt; Wt / "Sales Line".Quantity)
                        {
                        }
                        column(MRPPrice_SalesLine; "Sales Line"."MRP Price")
                        {
                        }
                        column(UnitPrice_SalesLine; "Sales Line"."Unit Price")
                        {
                        }
                        column(VariantCode_SalesLine; "Sales Line"."Variant Code")
                        {
                        }
                        column(UnitofMeasureCode_SalesLine; "Sales Line"."Unit of Measure Code")
                        {
                        }

                        column(BinCode_SalesLine; "Sales Line"."Bin Code")
                        {
                        }
                        column(Var_code; "Sales Line"."Variant Code")
                        {
                        }
                        column(Description_SalesLine; "Sales Line".Description)
                        {
                        }
                        column(Description2_SalesLine; "Sales Line"."Description 2")
                        {
                        }
                        column(Reserved; "Sales Line"."Reserved Quantity")
                        {
                        }
                        column(loca_mfg; Location)
                        {

                        }
                        column(BatchCode; BatchCode)
                        {

                        }
                        column(InvLocCode; InvLocCode)
                        {

                        }
                        column(InvQty; InvQty)
                        {

                        }
                        column(InvRemQty; InvRemQty)
                        {

                        }
                        column(InvUtilize; InvUtilize)
                        {

                        }
                        dataitem("Warehouse Inv Manement"; 50093)
                        {
                            DataItemLink = "item Code" = FIELD("No."),
                                           Location = FIELD("Location Code");
                            DataItemTableView = SORTING("item Code", Location, "Batch No.", Inv_Location, Qty, Utilize)
                                                WHERE("Loading Qty" = FILTER(<> 0));
                            column(WHItemcode; "Warehouse Inv Manement"."item Code")
                            {
                            }
                            column(BatchNo; "Warehouse Inv Manement"."Batch No.")
                            {
                            }
                            column(InvLocation; "Warehouse Inv Manement".Inv_Location)
                            {
                            }
                            column(Qty; "Warehouse Inv Manement".Qty)
                            {
                            }
                            column(Utilize; "Warehouse Inv Manement"."Loading Qty")
                            {
                            }
                            column(Remaiing; "Warehouse Inv Manement".Remaining)
                            {
                            }
                            column(MFG_Date; FORMAT("Warehouse Inv Manement"."MFG Date"))
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF I > 0 THEN BEGIN
                                    QtySqmt := 0;
                                    QtyCart := 0;
                                    ResWt := 0;
                                    SalesQty := 0;
                                END;
                                ;
                                ;
                                I += 1;
                            end;

                            trigger OnPreDataItem()
                            begin
                                //"Warehouse Inv Manement".SETRANGE("item Code","Sales Line"."No.");
                                //SETRANGE("Warehouse Inv Manement".Location,"Sales Line"."Location Code");
                            end;
                        }
                        trigger OnAfterGetRecord()
                        begin
                            CLEAR(Wt2);
                            CLEAR(ResWt);
                            Clear(SUMQtySL);
                            Clear(SUMQtySqmt);
                            SUMQtySL := "Sales Line".Quantity;
                            SUMQtySqmt := "Sales Line"."Reserved Qty. (Base)";
                            QtyCart := Item.UomToCart("No.", "Unit of Measure Code", Quantity);
                            //Wt := Item.UomToWeight("No.","Unit of Measure Code",Quantity);
                            Wt := "Sales Line"."Gross Weight";
                            //RK171121>>>
                            Wt2 := "Sales Line"."Gross Weight";
                            IF (Wt2 > 0) AND ("Sales Line".Quantity > 0) THEN BEGIN
                                ResWt := ("Sales Line"."Gross Weight" / "Sales Line".Quantity) * "Sales Line"."Outstanding Quantity";
                            END;
                            //RK171121<<<
                            //MSAK
                            Item2.RESET;
                            IF Item2.GET("Sales Line"."No.") THEN
                                IF Item2."Group Code" = '05' THEN
                                    //QtySqmt := ROUND(Item.UomToSqm("No.","Unit of Measure Code","Sales Line"."Quantity in Sq. Mt."),1,'=')
                                    QtySqmt := "Sales Line"."Quantity in Sq. Mt."
                                ELSE
                                    //MSAK
                                    QtySqmt := ROUND(Item.UomToSqm("No.", "Unit of Measure Code", Quantity), 1, '=');

                            CLEAR(InvQty);
                            CLEAR(InvRemQty);
                            CLEAR(InvUtilize);
                            CLEAR(BatchCode);
                            CLEAR(InvLocCode);


                            Counter := Counter + 1;
                            InventorySetup.GET;
                            IF DimValue.GET(InventorySetup."Plant Code", "Plant Code") THEN
                                PlantName := DimValue.Name;


                            SNo := SNo + 1;

                            IF Counter = 35 THEN
                                CurrReport.NEWPAGE;

                            Counter := Counter + 1;
                            //Ori Utt
                            "Sales Header".RESET;
                            "Sales Header".SETRANGE("Sales Header"."No.", "Sales Line"."Document No.");
                            IF "Sales Header".FIND('-') THEN BEGIN
                                IF ("Sales Header"."Group Code" = '03') OR ("Sales Header"."Group Code" = '04') THEN
                                    "Variant Code" := ' ';
                            END;
                            //Ori Utt
                            SalesLine.SETFILTER("Location Code", '%1', 'DRA-WH-MFG');
                            IF Item.GET("Sales Line"."No.") THEN
                                Location := Item."Shelf Location Dra";

                            /* SalesLine.SETFILTER("Location Code",'%1','SKD-WH-MFG');
                              IF Item.GET("Sales Line"."No.") THEN 
                                  Location := Item."Shelf No.";

                            SalesLine.SETFILTER("Location Code",'%1','HSK-WH-MFG');
                              IF Item.GET("Sales Line"."No.") THEN 
                                  Location := Item."Shelf Location HSK"; */



                            FirstLine := TRUE;
                            I := 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CREATETOTALS(QtySqmt, QtyCart, Wt, "Sales Line".Quantity);
                            SNo := 0;
                        end;
                    }

                    dataitem(SalesLine; 37)
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = WHERE(Type = FILTER(' '));
                        PrintOnlyIfDetail = true;
                        RequestFilterFields = "Plant Code";
                        column(Description_SalesLine1; SalesLine.Description)
                        {
                        }
                        column(Description2_SalesLine1; SalesLine."Description 2")
                        {
                        }
                    }
                    dataitem("Sales Comment Line"; 44)
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "No.", "Line No.")
                                            ORDER(Ascending);
                        column(Comment_SalesCommentLine; "Sales Comment Line".Comment)
                        {
                        }
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF NoOfLoops > 0 THEN BEGIN
                        OutputNo += 1;
                    END;

                    IF OutputNo = 1 THEN
                        CopyText := 'ORIGINAL FOR RECIPIENT';
                    IF OutputNo = 2 THEN
                        CopyText := 'DUPLICATE FOR TRANSPORTER';
                    IF OutputNo = 3 THEN
                        CopyText := 'TRIPLICATE FOR ASSESSEE';
                    IF OutputNo >= 4 THEN
                        CopyText := 'EXTRA COPY';
                    CopiesPrinted := LastPrints + Number;
                end;

                trigger OnPostDataItem()
                begin
                    CLEAR(LoadingPrinted);
                    IF NOT CurrReport.PREVIEW THEN BEGIN
                        LoadingPrinted.NoOfCopies(NoofCopies);
                        LoadingPrinted.RUN("Sales Header");
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoofCopies);
                    //NoOfLoops := ABS(2);
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //RelTime:=DT2TIME("Sales Header"."Releasing Time");
                IF StateRec.GET("Sales Header".State) THEN;
                IF Customer.GET("Sell-to Customer No.") THEN BEGIN
                    // 16630  CST := Customer."C.S.T. No.";
                    //LST := Customer."L.S.T. No.";
                    LST := Customer."GST Registration No.";
                    Customer.CALCFIELDS("Sales Per Mob");
                    spphone := Customer."Salesperson Description" + '-' + Customer."Sales Per Mob";
                    IF Customer.Blocked <> 0 THEN
                        ERROR('This Customer is Blocked');
                END;

                LastPrints := "Sales Header"."Loading Copies";

                IF TransporterRec.GET("Sales Header"."Transporter's Name") THEN
                    TransporterName := TransporterRec.Name;
                Counter := 15;
                //TRI N.K 22.02.08 Add Start
                GroupCode.SETRANGE(GroupCode."Group Code", "Sales Header"."Group Code");
                IF GroupCode.FIND('-') THEN
                    //TRI N.K 22.02.08 Add Stop

                    IF StateRec.GET("GST Ship-to State Code") THEN
                        sstate := StateRec.Description;

                IF ShipAgent.GET("Shipping Agent Code") THEN
                    tptmth := ShipAgent.Name;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("No. of Copies"; NoofCopies)
                {
                    ApplicationArea = All;
                }
                field(ShowDetails; ShowDetails)
                {
                    ApplicationArea = all;
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

    trigger OnInitReport()
    begin
        NoofCopies := 1;
    end;

    trigger OnPostReport()
    begin
        //RepAuditMgt.CreateAudit(50044)
    end;

    trigger OnPreReport()
    begin
        CompInfo.GET();
    end;

    var
        SNo: Integer;
        QtyCart: Decimal;
        Item: Record Item;
        Wt: Decimal;
        SUMQtySL: Decimal;
        SUMQtySqmt: Decimal;
        Customer: Record Customer;
        CST: Code[50];
        LST: Code[50];
        CodeDesc: Text[30];
        // 16630 TaxChargeGroup: Record 13791;
        InventorySetup: Record "Inventory Setup";
        DimValue: Record "Dimension Value";
        PlantName: Text[50];
        TransporterRec: Record Vendor;
        TransporterName: Text[50];
        Counter: Integer;
        QtySqmt: Decimal;
        GroupCode: Record "Item Group";
        GrpCode: Code[10];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        CompInfo: Record "Company Information";
        RelTime: DateTime;
        StateRec: Record State;
        sstate: Text[50];
        Item2: Record Item;
        ShipAgent: Record "Shipping Agent";
        tptmth: Text[100];
        NoofCopies: Integer;
        LoadingPrinted: Codeunit "Loading-Printed";
        "--------------": Integer;
        NoOfLoops: Integer;
        CopyText: Text;
        OutputNo: Integer;
        CopiesPrinted: Integer;
        LastPrints: Integer;
        spphone: Text[150];
        ResWt: Decimal;
        Wt2: Decimal;
        ShowDetails: Boolean;
        SalesQty: Decimal;
        Location: Text[20];
        WarehouseInvManement: Record 50093;
        BatchCode: Code[10];
        InvLocCode: Code[10];
        InvQty: Decimal;
        InvRemQty: Decimal;
        InvUtilize: Decimal;
        FirstLine: Boolean;
        I: Integer;

}

