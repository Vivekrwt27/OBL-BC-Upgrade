report 50275 "Freight Voucher2"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\FreightVoucher2.rdl';

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
        dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
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
            column(VendName; VendName)
            {
            }
            column(PostingDate; "Purch. Inv. Line"."Posting Date")
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
            //16225 column(TotalTDSIncludingSHECess; "Purch. Inv. Line"."Total TDS Including SHE CESS")
            column(TotalTDSIncludingSHECess; "Purch. Inv. Line"."Amount Including VAT")
            {
            }
            //16225 column(RoundingOff; ((Amount - "Purch. Inv. Line"."Total TDS Including SHE CESS") - ROUND(Amount - "Purch. Inv. Line"."Total TDS Including SHE CESS", 1, '=')))
            column(RoundingOff; ((Amount - TotalIncludingAmountCESS) - ROUND(Amount - TotalIncludingAmountCESS, 1, '=')))
            {
            }
            column(BuyFromVendorName; PurchInvHeader."Buy-from Vendor Name")
            {
            }
            column(BuyFromAddress; PurchInvHeader."Buy-from Address")
            {
            }
            column(BuyFromCity; PurchInvHeader."Buy-from City")
            {
            }
            column(AmtinWords1; AmtinWords[1])
            {
            }
            column(AmtinWords2; AmtinWords[2])
            {
            }
            // 16225 column(Round; ROUND(Amount - "Purch. Inv. Line"."Total TDS Including SHE CESS", 1, '='))
            column(Round; ROUND(Amount - TotalIncludingAmountCESS, 1, '='))
            {
            }
            column(FrieghtVoucherNo; PurchInvHeader."Pre-Assigned No.")
            {
            }

            trigger OnAfterGetRecord()
            var
                TDSEntries: Record "TDS Entry";
            begin
                Clear(TotalIncludingAmountCESS);//15578
                DateFrom := 0D;
                DateTo := 0D;
                ChalanQty := 0;
                ActualQty := 0;
                ShortageQty := 0;

                TDSEntries.Reset();
                TDSEntries.SetRange("Document No.", "Document No.");
                if TDSEntries.FindSet() then begin
                    repeat
                        TotalIncludingAmountCESS += TDSEntries."Total TDS Including SHE CESS";
                    until TDSEntries.Next() = 0;

                end;


                PurchInvHeader.RESET;
                IF PurchInvHeader.GET("Document No.") THEN BEGIN
                    IF LocationTemp.GET(PurchInvHeader."Location Code") THEN;
                    PurchInvPostiongDate := PurchInvHeader."Posting Date";
                    Check.InitTextVariable;//
                    Check.FormatNoText(AmtinWords, ROUND(Amount - "Purch. Inv. Line"."Amount Including VAT", 1, '='), PurchInvHeader."Currency Code");
                    Check.FormatNoText(AmtinWords, ROUND(Amount - TotalIncludingAmountCESS, 1, '='), PurchInvHeader."Currency Code");
                END;

                ValueEntry.RESET;
                ValueEntry.SETFILTER(ValueEntry."Document No.", "Purch. Inv. Line"."Document No.");
                ValueEntry.SETRANGE(ValueEntry."Posting Date", PurchInvPostiongDate);
                IF ValueEntry.FIND('-') THEN
                    REPEAT
                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry No.", ValueEntry."Item Ledger Entry No.");
                        IF ItemLedgerEntry.FIND('-') THEN
                            REPEAT
                                Item.RESET;
                                IF Item.GET(ItemLedgerEntry."Item No.") THEN
                                    //ChalanQty += Item.UomToWeight(ItemLedgerEntry."Item No.", Item."Base Unit of Measure", ItemLedgerEntry.Quantity)/1000;
                                    IF PurchRcptHeader.GET(ItemLedgerEntry."Document No.") THEN BEGIN
                                        PurchRcptLine.RESET;
                                        PurchRcptLine.SETFILTER(PurchRcptLine."Document No.", '%1', PurchRcptHeader."No.");
                                        IF PurchRcptLine.FIND('-') THEN
                                            REPEAT
                                                ShortageQty += Item.UomToWeight(PurchRcptLine."No.",
                                                               PurchRcptLine."Unit of Measure Code",
                                                               PurchRcptLine."Shortage Quantity") / 1000;
                                                ChalanQty += Item.UomToWeight(PurchRcptLine."No.",
                                                               PurchRcptLine."Unit of Measure Code",
                                                               PurchRcptLine."Challan Quantity") / 1000;

                                            UNTIL PurchRcptLine.NEXT = 0;
                                    END;
                            UNTIL ItemLedgerEntry.NEXT = 0;
                    UNTIL ValueEntry.NEXT = 0;

                ActualQty := ChalanQty - ShortageQty;

                IF ItemCharge.GET("Purch. Inv. Line"."No.") THEN
                    FrightDescription := ItemCharge.Description;

                //Getting MRN No. & GR No.

                PostingDate := 0D;
                MRNNo := '';
                GRNo := '';
                GRDate := 0D;

                ValueEntry.RESET;
                ValueEntry.SETFILTER(ValueEntry."Document No.", "Purch. Inv. Line"."Document No.");
                ValueEntry.SETRANGE(ValueEntry."Posting Date", PurchInvPostiongDate);
                IF ValueEntry.FIND('-') THEN BEGIN
                    ItemLedgerEntry.RESET;
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry No.", ValueEntry."Item Ledger Entry No.");
                    IF ItemLedgerEntry.FIND('-') THEN BEGIN
                        IF SalesShptHeader.GET(ItemLedgerEntry."Document No.") THEN BEGIN
                            PostingDate := SalesShptHeader."Posting Date";
                            MRNNo := SalesShptHeader."No.";
                            GRNo := SalesShptHeader."GR No.";
                            GRDate := SalesShptHeader."GR Date";
                            VendName := SalesShptHeader."Sell-to Customer Name";
                        END;
                        IF PurchRcptHeader.GET(ItemLedgerEntry."Document No.") THEN BEGIN
                            PostingDate := PurchRcptHeader."Posting Date";
                            MRNNo := PurchRcptHeader."No.";
                            GRNo := PurchRcptHeader."Vendor Shipment No.";
                            //  GRDate := PurchRcptHeader."Vendor Shipment Date";//16225 table fild N/F
                            VendName := PurchRcptHeader."Buy-from Vendor Name";
                            VendINVNO := PurchRcptHeader."Vendor Invoice No.";
                            Vendinvdate := PurchRcptHeader."Vendor Invoice Date";
                            TruckNo := PurchRcptHeader."Vendor Order No.";
                            GENO := PurchRcptHeader."GE No.";



                        END;
                        Qty := 0.0;
                        PurchRcptLine.RESET;
                        PurchRcptLine.SETFILTER(PurchRcptLine."Document No.", '%1', PurchRcptHeader."No.");
                        IF PurchRcptLine.FIND('-') THEN BEGIN
                            IF (PurchRcptLine."Accepted Qunatity" - PurchRcptLine."Shortage Quantity") <= 200 THEN
                                Qty := PurchRcptLine."Accepted Qunatity"
                            ELSE
                                Qty := PurchRcptLine."Actual Quantity";

                            UOM := PurchRcptLine."Unit of Measure Code";
                            rate := (Amount / Qty);
                            ItemNAME := PurchRcptLine.Description + ' ' + PurchRcptLine."Description 2";
                        END;




                        IF TransferRcptHeader.GET(ItemLedgerEntry."Document No.") AND ItemLedgerEntry.Positive THEN BEGIN
                            PostingDate := TransferRcptHeader."Posting Date";
                            MRNNo := TransferRcptHeader."No.";
                            GRNo := TransferRcptHeader."GR No.";
                            GRDate := TransferRcptHeader."GR Date";

                        END;
                        IF TransferShptHeader.GET(ItemLedgerEntry."Document No.") AND NOT ItemLedgerEntry.Positive THEN BEGIN
                            PostingDate := TransferShptHeader."Posting Date";
                            MRNNo := TransferShptHeader."No.";
                            GRNo := TransferShptHeader."GR No.";
                            GRDate := TransferShptHeader."GR Date";

                        END;
                    END;
                END;
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
        SalesShptLine: Record "Sales Shipment Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        TransferRcptHeader: Record "Transfer Receipt Header";
        TransferRcptLine: Record "Transfer Receipt Line";
        TransferShptHeader: Record "Transfer Shipment Header";
        TransferShptLine: Record "Transfer Shipment Line";
        ItemCharge: Record "Item Charge";
        CompanyInfo: Record "Company Information";
        PurchInvHeader: Record "Purch. Inv. Header";
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        Item: Record Item;
        Check: Report Check;
        PurchInvPostiongDate: Date;
        TotalIncludingAmountCESS: Decimal;
        DateFrom: Date;
        DateTo: Date;
        ActualQty: Decimal;
        ShortageQty: Decimal;
        ChalanQty: Decimal;
        Amount: Decimal;
        AmtinWords: array[2] of Text[80];
        CompanyCity: Text[50];
        FrightDescription: Text[50];
        PostingDate: Date;
        MRNNo: Code[20];
        GRNo: Code[20];
        GRDate: Date;
        VendName: Text[100];
        VendINVNO: Code[20];
        Vendinvdate: Date;
        Qty: Decimal;
        rate: Decimal;
        TruckNo: Code[20];
        ItemNAME: Text[100];
        UOM: Code[20];
        GENO: Text[30];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        LocationTemp: Record Location;
}

