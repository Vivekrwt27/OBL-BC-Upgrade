report 50245 "Freight Voucher1"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\FreightVoucher1.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = SORTING("Primary Key");
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompName2; CompanyInfo."Name 2")
            {
            }
            column(CompCity; CompanyInfo.City)
            {
            }
        }
        dataitem("Purchase Line"; "Purchase Line")
        {
            DataItemTableView = SORTING("Buy-from Vendor No.")
                                ORDER(Ascending)
                                WHERE(Type = CONST("Charge (Item)"));
            RequestFilterFields = "Document No.", "Buy-from Vendor No.";
            column(CityLocation; LocationTemp.City)
            {
            }
            column(PurchInvPostiongDate; PurchInvPostiongDate)
            {
            }
            column(FrightDescription; FrightDescription)
            {
            }
            column(ItemNAME; ItemNAME)
            {
            }
            column(VendCode; VendCode)
            {
            }
            column(VendName; VendName)
            {
            }
            column(MRNDate; MRNDate)
            {
            }
            column(MRNNo; MRNNo)
            {
            }
            column(GRNo; GRNo)
            {
            }
            column(GRDate; GRDate)
            {
            }
            column(VendINVNO; VendINVNO)
            {
            }
            column(Vendinvdate; Vendinvdate)
            {
            }
            column(FromCity; FromCity)
            {
            }
            column(Qty; Qty)
            {
            }
            column(UOM; UOM)
            {
            }
            column(rate; rate)
            {
            }
            column(TruckNo; TruckNo)
            {
            }
            column(Amount; Amount)
            {
            }
            column(GENO; GENO)
            {
            }
            column(GEDate; GEDate)
            {
            }
            //16225 column(TotalTDSIncludingSHECess; "Total TDS Including SHE CESS")
            column(TotalTDSIncludingSHECess; TotalIncludingAmountCESS)
            {
            }
            //16225  column(RoundingOff; ((Amount - "Total TDS Including SHE CESS") - ROUND(Amount - "Total TDS Including SHE CESS", 1, '=')))
            column(RoundingOff; ((Amount - TotalIncludingAmountCESS) - ROUND(Amount - TotalIncludingAmountCESS, 1, '=')))
            {
            }
            column(TPTNo; "Buy-from Vendor No.")
            {
            }
            column(TPTName; RecVendor.Name)
            {
            }
            column(TPTAddredd; PurchaseHeader."Buy-from Address")
            {
            }
            column(TPTCity; PurchaseHeader."Buy-from City")
            {
            }
            column(AmtinWords1; AmtinWords[1])
            {
            }
            column(AmtinWords2; AmtinWords[2])
            {
            }
            column(Round; ROUND(Amount - "Purchase Line"."Amount (FCY)", 1, '='))
            {
            }
            column(FrieghtVoucherNo; VoucherNo)
            {
            }

            trigger OnAfterGetRecord()
            var
                TDSEntries: Record "TDS Entry";
            begin
                Clear(TotalIncludingAmountCESS);//15578
                TDSEntries.Reset();
                TDSEntries.SetRange("Document No.", "Document No.");
                if TDSEntries.FindSet() then begin
                    repeat
                        TotalIncludingAmountCESS += TDSEntries."Total TDS Including SHE CESS";
                    until TDSEntries.Next() = 0;

                end;
                IF RecVendor.GET("Purchase Line"."Buy-from Vendor No.") THEN;

                DateFrom := 0D;
                DateTo := 0D;
                ChalanQty := 0;
                ActualQty := 0;
                ShortageQty := 0;

                CLEAR(VoucherNo);
                PurchaseHeader.RESET;
                PurchaseHeader.SETCURRENTKEY("No.");
                PurchaseHeader.SETRANGE("No.", "Purchase Line"."Document No.");
                IF PurchaseHeader.FINDFIRST THEN BEGIN
                    VoucherNo := PurchaseHeader."No.";
                    IF LocationTemp.GET(PurchaseHeader."Location Code") THEN;
                    PurchInvPostiongDate := PurchaseHeader."Posting Date";
                    Check.InitTextVariable;
                    Check.FormatNoText(AmtinWords, ROUND(Amount - "Purchase Line"."Amount (FCY)", 1, '='), PurchaseHeader."Currency Code");
                    Check.FormatNoText(AmtinWords, ROUND(Amount - TotalIncludingAmountCESS, 1, '='), PurchaseHeader."Currency Code");
                END;
                /*
                ValueEntry.RESET;
                ValueEntry.SETFILTER(ValueEntry."Document No.","Document No.");
                ValueEntry.SETRANGE(ValueEntry."Posting Date",PurchInvPostiongDate);
                IF ValueEntry.FIND('-') THEN
                REPEAT
                  ItemLedgerEntry.RESET;
                  ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry No.",ValueEntry."Item Ledger Entry No.");
                  IF ItemLedgerEntry.FIND('-') THEN REPEAT
                    Item.RESET;
                    IF Item.GET(ItemLedgerEntry."Item No.") THEN
                      //ChalanQty += Item.UomToWeight(ItemLedgerEntry."Item No.", Item."Base Unit of Measure", ItemLedgerEntry.Quantity)/1000;
                    IF PurchRcptHeader.GET(ItemLedgerEntry."Document No.") THEN BEGIN
                      PurchRcptLine.RESET;
                      PurchRcptLine.SETFILTER(PurchRcptLine."Document No.", '%1', PurchRcptHeader."No.");
                      IF PurchRcptLine.FIND('-') THEN REPEAT
                         ShortageQty += Item.UomToWeight(PurchRcptLine."No.",
                                        PurchRcptLine."Unit of Measure Code",
                                        PurchRcptLine."Shortage Quantity")/1000;
                         ChalanQty +=   Item.UomToWeight(PurchRcptLine."No.",
                                        PurchRcptLine."Unit of Measure Code",
                                        PurchRcptLine."Challan Quantity")/1000;
                
                      UNTIL PurchRcptLine.NEXT = 0;
                    END;
                  UNTIL ItemLedgerEntry.NEXT = 0;
                UNTIL ValueEntry.NEXT = 0;
                
                ActualQty := ChalanQty - ShortageQty;
                */
                IF ItemCharge.GET("No.") THEN
                    FrightDescription := ItemCharge.Description;

                //Getting MRN No. & GR No.

                MRNDate := 0D;
                MRNNo := '';
                GRNo := '';
                GRDate := 0D;
                GENO := '';
                GEDate := 0D;
                TruckNo := '';
                ItemChargeAssignmentPurch.RESET;
                ItemChargeAssignmentPurch.SETRANGE("Document No.", "Document No.");
                IF ItemChargeAssignmentPurch.FIND('-') THEN BEGIN
                    IF PurchRcptHeader.GET(ItemChargeAssignmentPurch."Applies-to Doc. No.") THEN BEGIN
                        MRNDate := PurchRcptHeader."Posting Date";
                        MRNNo := PurchRcptHeader."No.";
                        GRNo := PurchRcptHeader."Vendor Shipment No.";
                        //GRDate := PurchRcptHeader."Vendor Shipment Date";//16225 field N/F
                        VendName := PurchRcptHeader."Buy-from Vendor Name";
                        VendCode := PurchRcptHeader."Buy-from Vendor No.";
                        FromCity := PurchRcptHeader."Buy-from City";
                        VendINVNO := PurchRcptHeader."Vendor Invoice No.";
                        Vendinvdate := PurchRcptHeader."Vendor Invoice Date";
                        TruckNo := PurchRcptHeader."Vendor Order No.";
                        GENO := PurchRcptHeader."GE No.";
                        GEDate := PurchRcptHeader."GE Date";
                    END;
                    //END;
                    Qty := 0.0;
                    PurchRcptLine.RESET;
                    PurchRcptLine.SETFILTER(PurchRcptLine."Document No.", '%1', PurchRcptHeader."No.");
                    PurchRcptLine.SETRANGE("Line No.", ItemChargeAssignmentPurch."Applies-to Doc. Line No.");  //Rk280122
                    IF PurchRcptLine.FIND('-') THEN BEGIN
                        /*Rk280122
                        IF (PurchRcptLine."Accepted Qunatity"-PurchRcptLine."Shortage Quantity")<=200 THEN
                          Qty:=PurchRcptLine."Accepted Qunatity"
                        ELSE
                          Qty:=PurchRcptLine."Actual Quantity";
                        */
                        Qty := PurchRcptLine."Quantity (Base)";  //Rk280122
                        UOM := PurchRcptLine."Unit of Measure Code";
                        rate := (Amount / Qty);
                        ItemNAME := PurchRcptLine.Description + ' ' + PurchRcptLine."Description 2";
                    END;
                END;

                /*
                
                        IF TransferRcptHeader.GET(ItemLedgerEntry."Document No.") AND ItemLedgerEntry.Positive THEN BEGIN
                            MRNDate := TransferRcptHeader."Posting Date";
                            MRNNo       := TransferRcptHeader."No.";
                            GRNo        := TransferRcptHeader."GR No.";
                            GRDate      := TransferRcptHeader."GR Date";
                
                        END;
                        IF TransferShptHeader.GET(ItemLedgerEntry."Document No.") AND NOT ItemLedgerEntry.Positive THEN BEGIN
                            MRNDate := TransferShptHeader."Posting Date";
                            MRNNo       := TransferShptHeader."No.";
                            GRNo        := TransferShptHeader."GR No.";
                            GRDate      := TransferShptHeader."GR Date";
                
                        END;
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

    trigger OnPostReport()
    begin
        //   RepAuditMgt.CreateAudit(50275)
    end;

    trigger OnPreReport()
    begin

        IF CompanyInfo.GET THEN
            CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
        CompanyCity := CompanyInfo.City;
    end;

    var
        SalesShptHeader: Record "Sales Shipment Header";
        TotalIncludingAmountCESS: Decimal;
        SalesShptLine: Record "Sales Shipment Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        TransferRcptHeader: Record "Transfer Receipt Header";
        TransferRcptLine: Record "Transfer Receipt Line";
        TransferShptHeader: Record "Transfer Shipment Header";
        TransferShptLine: Record "Transfer Shipment Line";
        ItemCharge: Record "Item Charge";
        CompanyInfo: Record "Company Information";
        PurchaseHeader: Record "Purchase Header";
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        Item: Record Item;
        Check: Report "Check Report";
        PurchInvPostiongDate: Date;
        DateFrom: Date;
        DateTo: Date;
        ActualQty: Decimal;
        ShortageQty: Decimal;
        ChalanQty: Decimal;
        Amount: Decimal;
        AmtinWords: array[2] of Text[80];
        CompanyCity: Text[50];
        FrightDescription: Text[50];
        MRNDate: Date;
        MRNNo: Code[20];
        GRNo: Code[20];
        GRDate: Date;
        VendCode: Code[20];
        VendName: Text[100];
        VendINVNO: Code[20];
        Vendinvdate: Date;
        TPTNo: Code[20];
        TPTName: Text[100];
        FromCity: Text[80];
        Qty: Decimal;
        rate: Decimal;
        TruckNo: Code[20];
        ItemNAME: Text[100];
        UOM: Code[20];
        GENO: Text[30];
        GEDate: Date;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        LocationTemp: Record Location;
        ItemChargeAssignmentPurch: Record "Item Charge Assignment (Purch)";
        RecVendor: Record Vendor;
        VoucherNo: Code[20];
}

