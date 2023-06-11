report 50101 "Factory Gate Pass1"
{
    // 
    // //-- 1. Tri30.0 PG 14112006 -- Code Added In "Transfer Shipment Line - OnPreDataItem()"
    // //-- 2. Tri30.0 PG 14112006 -- Code Added In "Transfer Shipment Line - OnAfterGetRecord()"
    // //-- 3. Tri30.0 PG 14112006 -- New Labels Added In Section "Transfer Shipment Line, Header (1)"
    // //-- 4. Tri30.0 PG 14112006 -- New Fields Added In Section "Transfer Shipment Line, Body (2)"
    // //-- 5. Tri30.0 PG 14112006 -- New Fields Added In Section "Transfer Shipment Line, Footer (3)"
    // //-- 6. Tri30.0 PG 14112006 -- Changes Done In Table No. 27   (Item)
    // //-- 7. Tri30.0 PG 14112006 -- Changes Done In Table No. 313  (Inventory Setup)
    // //-- 8. Tri30.0 PG 14112006 -- Changes Done In Form No.  461  (Inventory Setup)
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\FactoryGatePass1.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Transfer Shipment Header"; 5744)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(Address_CompanyInformation; Address)
            {
            }
            column(Address2_CompanyInformation; Address1)
            {
            }
            column(City_CompanyInformation; relocation.City)
            {
            }
            column(PostCode_CompanyInformation; relocation."Post Code")
            {
            }
            column(State_CompanyInformation; relocation."State Code Desc")
            {
            }
            column(Name_CompanyInformation; "Company Information".Name)
            {
            }
            column(Name2_CompanyInformation; "Company Information"."Name 2")
            {
            }
            column(TransfertoName_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Name")
            {
            }
            column(TransfertoName2_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Name 2")
            {
            }
            column(TransfertoAddress_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Address")
            {
            }
            column(TransfertoAddress2_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Address 2")
            {
            }
            column(TransfertoPostCode_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Post Code")
            {
            }
            column(TransfertoCity_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to City")
            {
            }
            column(No_TransferShipmentHeader; "Transfer Shipment Header"."No.")
            {
            }
            column(InvoiceNoandDate; InvoiceNoandDate)
            {
            }
            column(ShipmentDate_TransferShipmentHeader; FORMAT("Transfer Shipment Header"."Shipment Date"))
            {
            }
            column(TruckNo_TransferShipmentHeader; "Transfer Shipment Header"."Truck No.")
            {
            }

            dataitem("Transfer Shipment Line"; 5745)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending);
                column(Sno; Sno)
                {
                }
                column(Description2_TransferShipmentLine; "Transfer Shipment Line"."Description 2")
                {
                }
                column(Description_TransferShipmentLine; "Transfer Shipment Line".Description)
                {
                }
                column(QtyInWeight; ROUND(QtyInWeight, 0.01))
                {
                }
                column(QtyInCartons; QtyInCartons)
                {
                }
                column(Desc; Desc)
                {
                }
                column(UOMCode; "Transfer Shipment Line"."Unit of Measure Code")
                {
                }
                column(Amt; Amt)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Sno := Sno + 1;

                    IF "Unit of Measure Code" <> 'PCS.' THEN
                        QtyInCartons := Item.UomToCart("Item No.", "Unit of Measure Code", Quantity)
                    ELSE
                        QtyInCartons := ROUND(Item.UomToPcs("Item No.", "Unit of Measure Code", Quantity), 1, '<');          //-- 2. Tri30.0 PG 14112006
                    //QtyInWeight := Item.UomToGrossWeight("Item No.","Unit of Measure Code",Quantity);   //-- 2. Tri30.0 PG 14112006
                    QtyInWeight := "Transfer Shipment Line"."Gross Weight";
                    Value := Amount;


                    /*
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETFILTER("Order No.","No.");
                    IF SalesInvoiceHeader.FIND('-') THEN BEGIN
                      InvoiceNoandDate := SalesInvoiceHeader."No." + '  ' + FORMAT(SalesInvoiceHeader."Posting Date");
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETFILTER(SalesInvoiceLine."Document No.",SalesInvoiceHeader."No.");
                        IF SalesInvoiceLine.FIND('-') THEN REPEAT
                          Amt := Amt + SalesInvoiceLine."Amount Including Tax";
                        UNTIL SalesInvoiceLine.NEXT = 0;
                    END;
                    */
                    InvoiceNoandDate := "Transfer Shipment Header"."No." + '  ' + FORMAT("Posting Date"); //Vipul Tri1.0

                    TransferShpLine.RESET;
                    TransferShpLine.SETFILTER(TransferShpLine."Document No.", "Transfer Shipment Header"."No.");
                    IF TransferShpLine.FIND('-') THEN
                        REPEAT
                            //Amt := Amt + TransferShpLine.Amount + TransferShpLine."Excise Amount";
                            Amt += TransferShpLine.Amount;
                        /* StructureOrderLineDetails.RESET;
                         StructureOrderLineDetails.SETFILTER(StructureOrderLineDetails.Type, '%1', StructureOrderLineDetails.Type::Transfer);
                         StructureOrderLineDetails.SETFILTER(StructureOrderLineDetails."Invoice No.", '%1', "Transfer Shipment Header"."No.");   //6823
                         StructureOrderLineDetails.SETFILTER(StructureOrderLineDetails."Line No.", '%1', TransferShpLine."Line No.");
                         StructureOrderLineDetails.SETFILTER(StructureOrderLineDetails."Tax/Charge Type", '%1',
                           StructureOrderLineDetails."Tax/Charge Type"::Charges);
                         IF StructureOrderLineDetails.FIND('-') THEN
                             REPEAT
                                 Amt := Amt + StructureOrderLineDetails.Amount;
                             UNTIL StructureOrderLineDetails.NEXT = 0;*/ // 16630
                        UNTIL TransferShpLine.NEXT = 0;

                end;

                trigger OnPreDataItem()
                begin

                    // CurrReport.CREATETOTALS(QtyInCartons);  //-- 1. Tri30.0 PG 14112006
                    CurrReport.CREATETOTALS(Value, QtyInCartons, QtyInPcs, QtyInWeight, Amt); //-- 1. Tri30.0 PG 14112006
                    Sno := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                IF relocation.GET("Transfer Shipment Header"."Transfer-from Code") THEN BEGIN
                    ;

                    IF "Transfer Shipment Header"."Transfer-from Code" = 'SKD-WH-MFG' THEN
                        IF ("Group Code" = '01') OR ("Group Code" = '05') THEN
                            Address := '8, A-75 to A-80, A-85 and A-22,Ind. Area, Sikandrabad - 203205. Distt. Bulandshahr (UP)';

                    IF "Transfer Shipment Header"."Transfer-from Code" = 'SKD-WH-TRD' THEN
                        IF ("Group Code" = '02') THEN
                            Address := 'A-84 Industrial Area, Sikandrabad - 203205. Distt. Bulandshahr (UP) - Trading Devision';

                    IF "Transfer Shipment Header"."Transfer-from Code" = 'HSK-WH-MFG' THEN
                        Address := 'Village-Chokkahalli, Taluka-Hoskote, Bangalore (Rural), Pin-562114';

                    IF "Transfer Shipment Header"."Transfer-from Code" = 'DRA-WH-MFG' THEN
                        Address := 'Village Dora, taluka Amod, Distt-Bharuch, Gujarat, Pin-392230';

                END;
            end;

            trigger OnPreDataItem()
            begin
                "Company Information".GET;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Description; Desc)
                {
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

    trigger OnInitReport()
    begin
        Desc := 'Ceramics Galze Tiles';
    end;

    var
        // 16630 StructureOrderLineDetails: Record 13798;
        SalesInvoiceLine: Record "Sales Invoice Line";
        Item: Record Item;
        QtyInCartons: Decimal;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InvoiceNoandDate: Text[50];
        Amt: Decimal;
        Sno: Integer;
        Desc: Text[200];
        TransferShpLine: Record "Transfer Shipment Line";
        QtyInPcs: Decimal;
        QtyInWeight: Decimal;
        Value: Decimal;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        "Company Information": Record "Company Information";
        relocation: Record Location;
        Address: Text[100];
        Address1: Text[100];
}

