report 50158 "Daybook Report"
{
    // 
    // CHANGES DONE IN ANOTHER OBJECTS
    // //-- 1. TRI55.9PG 24112006 PG - NEW KEY ("No.") CREATED IN TABLE "Purch. Rcpt. Line"
    // //-- 2. TRI55.9PG 24112006 PG - NEW FIELD ("Posting Date Head") CREATED IN TABLE "Purch. Rcpt. Line".
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\DaybookReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem(Item; 27)
        {
            DataItemTableView = SORTING("Item Category Code")
                                ORDER(Ascending);
            //RB 16630 PrintOnlyIfDetail = true;
            RequestFilterFields = "Item Category Code", "No.", "Inventory Posting Group";
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(CompName1; CompName1)
            {
            }
            column(CompName2; CompName2)
            {
            }
            column(Filters1; Filters1)
            {
            }
            column(Filters2; Filters2)
            {
            }
            column(Item_ItemCategoryCode; Item."Item Category Code")
            {
            }
            column(Item_ItemCategoryDesc; Item."Item Category Desc.")
            {
            }
            column(Item_No; Item."No.")
            {
            }
            column(Item_Description; Item.Description)
            {
            }
            column(Item_BaseUnitofMeasure; Item."Base Unit of Measure")
            {
            }
            column(Item_Description2; Item."Description 2")
            {
            }
            dataitem("Purch. Rcpt. Line"; 121)
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.")
                                    WHERE(Quantity = FILTER(> 0));
                RequestFilterFields = "Posting Date", "Location Code";
                column(MrnDate; MrnDate)
                {
                }
                column(VendorShipNo; VendorShipNo)
                {
                }
                column(PurchRcptLine_DocumentNo; "Purch. Rcpt. Line"."Document No.")
                {
                }
                column(VendorName; VendorName)
                {
                }
                column(PurchRcptLine_UnitofMeasureCode; "Purch. Rcpt. Line"."Unit of Measure Code")
                {
                }
                column(recVendor_No; recVendor."No.")
                {
                }
                column(PurchRcptLine_ChallanQuantity; "Purch. Rcpt. Line"."Challan Quantity")
                {
                }
                column(PurchRcptLine_AcceptedQunatity; "Purch. Rcpt. Line"."Accepted Qunatity")
                {
                }
                column(VehicleNo; "VehicleNo.")
                {
                }
                column(GRNo; GRNo)
                {
                }
                column(FreightVchNo; FreightVchNo)
                {
                }
                column(FreightAmount; FreightAmount)
                {
                }
                column(PurchRcptLine_PostingDate2; "Purch. Rcpt. Line"."Posting Date2")
                {
                }
                column(VendorShipDate; VendorShipDate)
                {
                }
                column(GeNo; GeNo)
                {
                }
                column(GRDate; GRDate)
                {
                }
                column(FreightVchDate; FreightVchDate)
                {
                }
                column(VendorInvoiceNo; "Purch. Rcpt. Line"."Vendor Invoice No.")
                {
                }
                column(DocumentNo; "Purch. Rcpt. Line"."Document No.")
                {
                }
                column(No; "Purch. Rcpt. Line"."No.")
                {
                }
                column(UMCCode; "Purch. Rcpt. Line"."Unit of Measure Code")
                {
                }
                column(QuaantityBase; "Purch. Rcpt. Line"."Quantity (Base)")
                {
                }
                column(ItemChargeBaseAmount; "Purch. Rcpt. Line"."Item Charge Base Amount")
                {
                }
                column(IndentNo; "Purch. Rcpt. Line"."Indent No.")
                {
                }
                column(IndentDate; "Purch. Rcpt. Line"."Indent Date")
                {
                }
                column(amrndate; amrndate)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    IF recVendor.GET("Buy-from Vendor No.") THEN VendorName := recVendor.Name ELSE VendorName := '';

                    recPurRecH.RESET;
                    recPurRecH.SetRange("No.", "Document No.");
                    IF recPurRecH.FIND('-') THEN BEGIN
                        GeNo := recPurRecH."GE No.";
                        GeDate := recPurRecH.Date;
                        VendorShipNo := recPurRecH."Vendor Shipment No.";
                        VendorShipDate := recPurRecH."Vendor Invoice Date";
                        "VehicleNo." := recPurRecH."Vendor Order No.";
                        MrnDate := recPurRecH."Posting Date";
                    END;

                    recILE.RESET;
                    // recILE.SETCURRENTKEY("Document No.","Posting Date","Item No.");
                    recILE.SetRange("Document No.", "Document No.");
                    recILE.SetRange("Item No.", "No.");
                    recILE.SETRANGE("Entry Type", recILE."Entry Type"::Purchase);
                    IF recILE.FIND('-') THEN BEGIN
                        recVE.RESET;
                        recVE.SETCURRENTKEY("Item Ledger Entry No.", "Expected Cost", "Valuation Date");
                        recVE.SETRANGE("Item Ledger Entry No.", recILE."Entry No.");
                        recVE.SETFILTER("Item Charge No.", '%1', 'FREIGHT');

                        FreightVchNo := '';
                        FreightVchDate := 0D;
                        FreightAmount := 0;
                        GRNo := '';

                        IF recVE.FIND('-') THEN BEGIN
                            FreightVchNo := recVE."Document No.";
                            FreightVchDate := recVE."Posting Date";
                            FreightAmount := recVE."Cost Amount (Actual)";
                            GRNo := recVE."External Document No.";
                            //            GRDate :=
                        END;
                    END;
                End;

                //Comment On NAV 16630 IF recPurRecH.GET("Purch. Rcpt. Line"."Document No.") THEN
                // amrndate := recPurRecH."Date Received";
                // amrndate := recPurRecH."Document Date";


                trigger OnPreDataItem()
                begin

                    CurrReport.CREATETOTALS("Purch. Rcpt. Line".Quantity, "Purch. Rcpt. Line"."Challan Quantity", "Purch. Rcpt. Line"."Actual Quantity",
                  "Purch. Rcpt. Line"."Accepted Qunatity", "Purch. Rcpt. Line"."Shortage Quantity", "Purch. Rcpt. Line"."Rejected Quantity")
                end;
            }

            trigger OnAfterGetRecord()
            begin

                CompanyInfo.GET;
                CompName1 := CompanyInfo.Name;
                CompName2 := CompanyInfo."Name 2";
            end;

            trigger OnPreDataItem()
            begin

                CurrReport.CREATETOTALS("Purch. Rcpt. Line".Quantity, "Purch. Rcpt. Line"."Challan Quantity", "Purch. Rcpt. Line"."Actual Quantity",
                "Purch. Rcpt. Line"."Accepted Qunatity", "Purch. Rcpt. Line"."Shortage Quantity", "Purch. Rcpt. Line"."Rejected Quantity")
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

        Filters1 := Item.GETFILTERS;
        //Filters := Filters + 'From Date :' + FORMAT(FromDate) + ' To Date :' + FORMAT(ToDate) + "Item Ledger Entry".GETFILTERS;
        Filters1 := Filters1 + Item."Item Category Code" + '' + Item."No.";
        Filters2 := "Purch. Rcpt. Line".GETFILTERS;
        Filters2 := Filters2 + "Purch. Rcpt. Line"."Location Code" + '' + FORMAT("Purch. Rcpt. Line"."Posting Date2");
    end;

    var
        GeNo: Code[50];
        GeDate: Date;
        VendorShipNo: Code[50];
        VendorShipDate: Date;
        VendorName: Text[50];
        ItemDesc: Text[50];
        "VehicleNo.": Text[50];
        FreightVchNo: Code[50];
        FreightVchDate: Date;
        FreightAmount: Decimal;
        recPurRecH: Record "Purch. Rcpt. Header";
        recVendor: Record Vendor;
        MrnDate: Date;
        GRNo: Code[50];
        GRDate: Date;
        recILE: Record "Item Ledger Entry";
        recVE: Record "Value Entry";
        Filters1: Text[250];
        Filters2: Text[250];
        CompanyInfo: Record "Company Information";
        CompName1: Text[100];
        CompName2: Text[100];
        printtoexcel: Boolean;
        ExcelBuf: Record "Excel Buffer" temporary;
        value: Decimal;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        ind: Record "Indent Header";
        indname: Text[200];
        amrndate: Date;
        Text001: Label 'Day Book Report';
        Text002: Label 'Data';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Print Date';
        Text011: Label 'Filters';
}

