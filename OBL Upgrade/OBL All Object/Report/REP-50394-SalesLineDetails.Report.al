report 50394 "Sales Line Details"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\SalesLineDetails.rdl';

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                ORDER(Ascending)
                                WHERE("Document Type" = FILTER(Order),
                                      "Location Code" = FILTER('<>SKD-SAMPLE' & '<>HSK-SAMPLE' & '<>DRA-SAMPLE' & '<>HEADOFFICE'),
                                      "Quantity in Sq. Mt." = FILTER(<> 0),
                                      "Sell-to Customer No." = FILTER(<> ''),
                                      "Document No." = FILTER('<>SOHO/1920/003190' & '<>SOHO/1920/003357' & '<>DEALER\1819\00008' & '<>SOHO/1920/012327'),
                                      "Item Category Code" = FILTER('<>SAMPLE'));
            RequestFilterFields = "Posting Date";
            column(DocumentType_SalesLine; "Sales Line"."Document Type")
            {
            }
            column(BilltoCustomerNo_SalesLine; "Sales Line"."Bill-to Customer No.")
            {
            }
            column(DocumentNo_SalesLine; "Sales Line"."Document No.")
            {
            }
            column(LineNo_SalesLine; "Sales Line"."Line No.")
            {
            }
            column(Type_SalesLine; "Sales Line".Type)
            {
            }
            column(No_SalesLine; "Sales Line"."No.")
            {
            }
            column(LocationCode_SalesLine; "Sales Line"."Location Code")
            {
            }
            column(PostingGroup_SalesLine; "Sales Line"."Posting Group")
            {
            }
            column(Description_SalesLine; "Sales Line".Description)
            {
            }
            column(Description2_SalesLine; "Sales Line"."Description 2")
            {
            }
            column(QuantityinCartons_SalesLine; "Sales Line"."Quantity in Cartons")
            {
            }
            column(QuantityinSqMt_SalesLine; "Sales Line"."Quantity in Sq. Mt.")
            {
            }
            column(OutstandingQuantity_SalesLine; "Sales Line"."Outstanding Quantity")
            {
            }
            column(ReservedQuantity_SalesLine; "Sales Line"."Reserved Quantity")
            {
            }
            column(QtytoShip_SalesLine; "Sales Line"."Qty. to Ship")
            {
            }
            column(QuantityShipped_SalesLine; "Sales Line"."Quantity Shipped")
            {
            }
            column(QuantityInvoiced_SalesLine; "Sales Line"."Quantity Invoiced")
            {
            }
            column(QuantityinHandSQM_SalesLine; "Sales Line"."Quantity in Hand SQM")
            {
            }
            column(QuantityinHandCRT_SalesLine; "Sales Line"."Quantity in Hand CRT")
            {
            }
            column(RemainingInventory_SalesLine; "Sales Line"."Remaining Inventory")
            {
            }
            column(TotalReservedQuantity_SalesLine; "Sales Line"."Total Reserved Quantity")
            {
            }
            column(QuantityinBlanketOrder_SalesLine; "Sales Line"."Quantity in Blanket Order")
            {
            }
            column(UnitPriceExclVATSqMt_SalesLine; "Sales Line"."Unit Price Excl. VAT/Sq.Mt")
            {
            }
            column(CustomerPriceGroup_SalesLine; "Sales Line"."Customer Price Group")
            {
            }
            column(DiscountPerSQMT_SalesLine; "Sales Line"."Discount Per SQ.MT")
            {
            }
            column(BuyersPriceSqMt_SalesLine; "Sales Line"."Buyer's Price /Sq.Mt")
            {
            }
            column(D1_SalesLine; "Sales Line".D1)
            {
            }
            column(S1_SalesLine; "Sales Line".S1)
            {
            }
            column(D2_SalesLine; "Sales Line".D2)
            {
            }
            column(D3_SalesLine; "Sales Line".D3)
            {
            }
            column(D4_SalesLine; "Sales Line".D4)
            {
            }
            column(LineDiscount_SalesLine; "Sales Line"."Line Discount %")
            {
            }
            //16225  column(MRPPrice_SalesLine; "Sales Line"."MRP Price")
            column(MRPPrice_SalesLine; 0)
            {
            }
            column(MakeOrderDate_SalesLine; FORMAT("Sales Line"."Make Order Date"))
            {
            }
            column(ReleasingDate_SalesLine; "Sales Line"."Releasing Date")
            {
            }
            column(RequestedDeliveryDate_SalesLine; "Sales Line"."Requested Delivery Date")
            {
            }
            column(PromisedDeliveryDate_SalesLine; "Sales Line"."Promised Delivery Date")
            {
            }
            column(PlannedDeliveryDate_SalesLine; "Sales Line"."Planned Delivery Date")
            {
            }
            column(PlannedShipmentDate_SalesLine; "Sales Line"."Planned Shipment Date")
            {
            }
            column(ShipmentDate_SalesLine; "Sales Line"."Shipment Date")
            {
            }
            column(ShippingTime_SalesLine; "Sales Line"."Shipping Time")
            {
            }
            column(PostingDate_SalesLine; "Sales Line"."Posting Date")
            {
            }
            column(PostingDate1_SalesLine; "Sales Line"."Posting Date1")
            {
            }
            column(GrossWeight_SalesLine; "Sales Line"."Gross Weight")
            {
            }
            column(NetWeight_SalesLine; "Sales Line"."Net Weight")
            {
            }
            column(VariantCode_SalesLine; "Sales Line"."Variant Code")
            {
            }
            column(QualityCode_SalesLine; "Sales Line"."Quality Code")
            {
            }
            column(ItemCategoryCode_SalesLine; "Sales Line"."Item Category Code")
            {
            }
            column(BranchCode; "Sales Line"."Shortcut Dimension 1 Code")
            {
            }
            column(BlanketOrderNo_SalesLine; "Sales Line"."Blanket Order No.")
            {
            }
            //16225 column(AmountToCustomer_SalesLine; "Sales Line"."Amount To Customer")
            column(AmountToCustomer_SalesLine; TotalAmt + cgst + sgst + igst)
            {
            }
            column(Remarks_SalesLine; "Sales Line".Remarks)
            {
            }
            column(StatusUpdated_SalesLine; "Sales Line"."Status Updated")
            {
            }
            column(SalespersonCode_SalesLine; RecCust."Salesperson Description")
            {
            }
            column(ADRemarks_SalesLine; "Sales Line"."AD Remarks")
            {
            }
            column(CustName; Custname)
            {
            }
            column(CustCity; RecCust.City)
            {
            }
            column(CustStateCode; RecCust."State Code")
            {
            }
            column(StateName; RecState.Description)
            {
            }
            column(SentTime; SentTime)
            {
            }
            column(PCHTime; PCHTime)
            {
            }
            column(ZMTime; ZMTime)
            {
            }
            column(PSMTime; PSMTime)
            {
            }
            column(PACTime; PACTime)
            {
            }
            column(Pay; SalesHeaderREC.Pay)
            {
            }
            column(ManufStrategy; ItemREC."Manuf. Strategy")
            {
            }
            column(Type_Code; producgrp)
            {
            }
            column(out_amt; "Sales Line"."Outstanding Amount")
            {
            }
            column(Out_qty; "Sales Line"."Outstanding Qty. (Base)")
            {
            }
            column(Doc_date; docdate)
            {
            }
            column(Reason_Hold; Reasontohold)
            {
            }
            column(Desp_rem; Despremarks)
            {
            }
            column(item_change; itemchange)
            {
            }
            column(order_process; orderprocess)
            {
            }
            column(buyer_price; "Sales Line"."Buyer's Price")
            {
            }
            //16225 column(Order_value; "Sales Line"."GST Base Amount")
            column(Order_value; LineGSTBaseAmt("Sales Line"))
            {
            }
            column(sizedesc; sizedesc)
            {
            }
            column(itemclass; itemclass)
            {
            }
            column(Salesterritory; Salesterritory)
            {
            }
            column(Tzone; Tzone)
            {
            }
            column(Custtype; Custtype)
            {
            }
            column(pchname; pchname)
            {
            }
            column(payterms; payterms)
            {
            }
            column(pmt; pmt)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(sgst);
                Clear(igst);
                Clear(cgst);
                Clear(TotalAmt);
                ReccSalesLine.Reset();
                ReccSalesLine.SetRange("Document Type", "Sales Line"."Document Type");
                ReccSalesLine.SetRange("Document No.", "Sales Line"."No.");
                if ReccSalesLine.FindSet() then
                    repeat
                        TotalAmt += ReccSalesLine."Line Amount";
                        GSTSetup.Get();
                        if GSTSetup."GST Tax Type" = GSTLbl then
                            if ReccSalesLine."GST Jurisdiction Type" = ReccSalesLine."GST Jurisdiction Type"::Interstate then
                                ComponentName := IGSTLbl
                            else
                                ComponentName := CGSTLbl
                        else
                            if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                                ComponentName := CESSLbl;

                        if ReccSalesLine.Type <> ReccSalesLine.Type::" " then begin
                            TaxTransactionValue.Reset();
                            TaxTransactionValue.SetRange("Tax Record ID", ReccSalesLine.RecordId);
                            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
                            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                            if TaxTransactionValue.FindSet() then
                                repeat
                                    case TaxTransactionValue."Value ID" of
                                        6:
                                            begin
                                                sgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                                GSTper3 := TaxTransactionValue.Percent;
                                            end;
                                        2:
                                            begin
                                                cgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                                GSTper2 := TaxTransactionValue.Percent;
                                            end;
                                        3:
                                            begin
                                                igst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                                GSTper1 := TaxTransactionValue.Percent;
                                            end;
                                    end;
                                until TaxTransactionValue.Next() = 0;
                            cgstTOTAL += cgst;
                            sgstTOTAL += sgst;
                            igstTotal += igst;
                        end;
                    until ReccSalesLine.Next() = 0;
                //15578 text

                "Sales Line".CALCFIELDS("Sales Line"."Posting Date");
                "Sales Line".CALCFIELDS("Sales Line"."Make Order Date");
                "Sales Line".CALCFIELDS("Sales Line"."Releasing Date");
                RecCust.RESET;
                RecState.RESET;
                IF RecCust.GET("Sales Line"."Bill-to Customer No.") THEN;
                IF RecState.GET(RecCust."State Code") THEN;

                SalesHeaderREC.RESET;
                IF SalesHeaderREC.GET("Sales Line"."Document Type", "Sales Line"."Document No.") THEN;

                SalesPersonREC.RESET;
                IF SalesPersonREC.GET("Sales Line"."Salesperson Code") THEN;

                ItemREC.RESET;
                IF ItemREC.GET("Sales Line"."No.") THEN;
                //
                CLEAR(SentTime);
                CLEAR(PACTime);
                ArchiveApprovalEntryREC.RESET;
                ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
                ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", "Document No.");
                IF ArchiveApprovalEntryREC.FINDFIRST THEN
                    SentTime := ArchiveApprovalEntryREC."Date-Time Sent for Approval";

                ArchiveApprovalEntryREC.RESET;
                ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
                ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", "Document No.");
                IF ArchiveApprovalEntryREC.FINDFIRST THEN
                    REPEAT
                        IF (ArchiveApprovalEntryREC."Approver Code" = '1110088') OR (ArchiveApprovalEntryREC."Approver Code" = '1111058') THEN
                            PACTime := ArchiveApprovalEntryREC."Approval Date & Time";
                    UNTIL ArchiveApprovalEntryREC.NEXT = 0;

                CLEAR(Count1);
                CLEAR(PCHTime);
                CLEAR(ZMTime);
                CLEAR(PSMTime);
                ArchiveApprovalEntryREC.RESET;
                ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
                ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", "Document No.");
                IF ArchiveApprovalEntryREC.FINDFIRST THEN
                    REPEAT
                        Count1 += 1;
                        IF (Count1 = 1) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                            PCHTime := ArchiveApprovalEntryREC."Approval Date & Time";
                        IF (Count1 = 2) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                            ZMTime := ArchiveApprovalEntryREC."Approval Date & Time";
                        IF (Count1 = 3) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                            PSMTime := ArchiveApprovalEntryREC."Approval Date & Time";
                    UNTIL ArchiveApprovalEntryREC.NEXT = 0;
                //MSAK

                IF ItemREC.GET("Sales Line"."No.") THEN BEGIN
                    producgrp := ItemREC."Tableau Product Group";
                    sizedesc := ItemREC."Size Code Desc.";
                    itemclass := ItemREC."Item Classification";
                END;

                saleshead.RESET;
                saleshead.SETRANGE("No.", "Sales Line"."Document No.");
                IF saleshead.FINDFIRST THEN BEGIN
                    docdate := saleshead."Document Date";
                    Reasontohold := saleshead.Commitment;
                    Despremarks := saleshead."Despatch Remarks";
                    itemchange := saleshead."Order Change Remarks";
                    orderprocess := saleshead."Payment Date 3";
                    payterms := saleshead."Payment Terms Code";
                    pmt := saleshead."PMT Code";

                END;

                IF RecCust.GET("Sales Line"."Sell-to Customer No.") THEN
                    Custname := RecCust.Name;
                //RecCust.RESET;
                //IF RecCust.GET(SalesLine."Sell-to Customer No.") THEN BEGIN
                pchname := RecCust."PCH Name";
                Custtype := RecCust."Customer Type";
                Salesterritory := RecCust."Area Code";
                Tzone := RecCust."Tableau Zone";
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

    var
        RecCust: Record Customer;
        RecState: Record State;
        ArchiveApprovalEntryREC: Record "Archive Approval Entry";
        SentTime: DateTime;
        PACTime: DateTime;
        Count1: Integer;
        PCHTime: DateTime;
        ZMTime: DateTime;
        PSMTime: DateTime;
        SalesHeaderREC: Record "Sales Header";
        SalesPersonREC: Record "Salesperson/Purchaser";
        ItemREC: Record Item;
        producgrp: Text[10];
        SalesLine: Record "Sales Line";
        pchname: Text[50];
        Custtype: Text[20];
        docdate: Date;
        Despremarks: Text[100];
        Reasontohold: Text[100];
        itemchange: Text[100];
        orderprocess: Date;
        saleshead: Record "Sales Header";
        paymth: Option;
        Custname: Text[100];
        sizedesc: Text[10];
        itemclass: Text[11];
        Salesterritory: Code[20];
        Tzone: Text[10];
        payterms: Text[10];
        pmt: Code[15];

        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        sgstTOTAL: Decimal;
        GSTLbl: Label 'GST';
        IGSTLbl: Label 'IGST';
        CGSTLbl: Label 'CGST';
        GSTCESSLbl: Label 'GST CESS';
        CESSLbl: Label 'CESS';
        igst: Decimal;
        igstTotal: Decimal;
        sgst: Decimal;
        GSTper3: Decimal;
        cgst: Decimal;
        GSTper1: Decimal;
        GSTper2: Decimal;
        cgstTOTAL: Decimal;
        ReccSalesLine: Record "Sales Line";
        ComponentName: Code[20];
        TotalAmt: Decimal;

    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal// 15578 text
    var
        TaxComponent: Record "Tax Component";
        GSTSetup1: Record "GST Setup";
        GSTRoundingPrecision: Decimal;
    begin
        if not GSTSetup1.Get() then
            exit;
        GSTSetup1.TestField("GST Tax Type");

        TaxComponent.SetRange("Tax Type", GSTSetup1."GST Tax Type");
        TaxComponent.SetRange(Name, ComponentName);
        TaxComponent.FindFirst();
        if TaxComponent."Rounding Precision" <> 0 then
            GSTRoundingPrecision := TaxComponent."Rounding Precision"
        else
            GSTRoundingPrecision := 1;
        exit(GSTRoundingPrecision);
    end;

    procedure LineGSTBaseAmt(T39: Record "Sales Line"): Decimal
    var
        GSTSetup: Record "GST Setup";
        TaxTransactionValue: Record "Tax Transaction Value";

    begin
        GSTSetup.Get();

        if T39.Type <> T39.Type::" " then begin

            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", T39.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetRange("Value ID", 10);
            if TaxTransactionValue.FindFirst() then
                exit(TaxTransactionValue.Amount);
        end;
    end;

}

