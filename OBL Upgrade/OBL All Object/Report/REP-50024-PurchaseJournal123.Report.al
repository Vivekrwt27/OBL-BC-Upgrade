report 50024 "Purchase Journal 123"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\PurchaseJournal123.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purch. Inv. Header"; 122)
        {
            column(tgShowSummary; tgShowSummary)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyName2; CompanyInfo."Name 2")
            {
            }
            column(Date; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
            column(Filters; FilterString)
            {
            }
            column(PihFilters; "Purch. Inv. Header".GETFILTERS)
            {
            }
            column(PihNo; "Purch. Inv. Header"."No.")
            {
            }
            column(PostingDate; "Purch. Inv. Header"."Posting Date")
            {
            }
            column(PihBuyFromVendorName; "Purch. Inv. Header"."Buy-from Vendor Name")
            {
            }
            dataitem("Purch. Inv. Line"; 123)
            {
                column(Import; Import)
                {
                }
                column(DocumentNo_PurchInvLine; "Purch. Inv. Line"."Document No.")
                {
                }
                column(Quantity_PurchInvLine; "Purch. Inv. Line".Quantity)
                {
                }
                column(Description_PurchInvLine; "Purch. Inv. Line".Description)
                {
                }
                column(Description2_PurchInvLine; "Purch. Inv. Line"."Description 2")
                {
                }
                column(UnitofMeasureCode_PurchInvLine; "Purch. Inv. Line"."Unit of Measure Code")
                {
                }
                column(SqrMtr; SqrMtr)
                {
                }
                column(ExAmount; ExAmount)
                {
                }
                column(LineDiscountAmount_PurchInvLine; "Purch. Inv. Line"."Line Discount Amount")
                {
                }
                column(Value; Value)
                {
                }
                column(ExciseAmount_PurchInvLine; 0) // 16630 blank "Purch. Inv. Line".Excise Amount
                {
                }
                column(SalesValue; SalesValue)
                {
                }
                column(TaxAmount; TaxAmount)
                {
                }
                column(VatAmount; VatAmount)
                {
                }
                column(Insurance1; Insurance1)
                {
                }
                column(TotalValue; TotalValue)
                {
                }
                column(Roundoff; Roundoff)
                {
                }
                column(NetValue; NetValue)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Section
                    Import := '';
                    //Section
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.CREATETOTALS(Quantity, ExAmount, Value, SalesValue, TotalValue, NetValue, TaxAmount, VatAmount);
                //CurrReport.CREATETOTALS(Quantity,ExAmount,"Line Discount Amount",Value,"Excise Amount",SalesValue,TotalValue,NetValue)
            end;

            trigger OnPreDataItem()
            begin

                //CurrReport.CREATETOTALS(Quantity,ExAmount,"Line Discount Amount",Value,"Excise Amount",SalesValue,TotalValue,NetValue);
                CurrReport.CREATETOTALS(Quantity, ExAmount, Value, SalesValue, TotalValue, NetValue, TaxAmount, VatAmount);// TRI C.A. 01.11.07 Add
                //CurrReport.CREATETOTALS("Purch. Inv. Line"."VAT Amount")
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Show details"; tgShowDetail)
                {
                    Caption = 'Show details';
                    ApplicationArea = All;
                }
                field("Show Summary"; tgShowSummary)
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
        ERROR('This report ID 50024 cannot be executed');
        //Section(+)
        CompanyInfo.GET;
        //Section(-)
    end;

    trigger OnPostReport()
    begin
        //TRI LM 150208 start
        IF PrintToExcel THEN
            CreateExcelbook;
        //TRI LM 150208 End
        //RepAuditMgt.CreateAudit(50024)
    end;

    trigger OnPreReport()
    begin
        //FilterString := "Purch. Inv. Header".GETFILTERS;
        FilterString := "Purch. Inv. Line".GETFILTERS;

        //TRI LM 150208 start
        IF PrintToExcel THEN
            MakeExcelInfo;
        //TRI LM 150208 End
    end;

    var
        // 16630 PostedStrOrderLineDetails: Record 13798;
        Insurance1: Decimal;
        ExAmount: Decimal;
        Value: Decimal;
        SalesValue: Decimal;
        TotalValue: Decimal;
        NetValue: Decimal;
        Roundoff: Decimal;
        SqrMtr: Decimal;
        InventorySetup: Record "Inventory Setup";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        QtyPerC: Decimal;
        QtyPerU: Decimal;
        ItemUnitofMeasure1: Record "Item Unit of Measure";
        DateFrom: Text[30];
        DateTo: Text[30];
        FilterString: Text[100];
        Import: Text[30];
        CompanyInfo: Record "Company Information";
        CompanyName1: Text[100];
        "Line Discount Amount": Decimal;
        "Tax Amount": Decimal;
        Quantity: Decimal;
        tgShowDetail: Boolean;
        tgShowSummary: Boolean;
        tgGrandDiscount: Decimal;
        tgGrandVat: Decimal;
        tgGrandTax: Decimal;
        "-----TRI": Integer;
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        ReportTitle: Text[30];
        CustNo: Text[30];
        TaxAmount: Decimal;
        VatAmount: Decimal;
        TaxArea: Record "Tax Area";
        TaxAreaLine: Record "Tax Area Line";
        TaxJurisdiction: Record "Tax Jurisdiction";
        RecItem: Record Item;
        CompanyName2: Text[100];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        "------TRI": Label 'a';
        Text001: Label 'As of %1';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Print Date';
        Text011: Label 'Filters';
        Text012: Label 'Filters 2';
        Text01: Label 'Purchase Journal 123';
        Text002: Label 'Data';

    procedure "---TRI"()
    begin
    end;

    procedure MakeExcelInfo()
    begin
        /*
        ExcelBuf.SetUseInfoSheed;
        ExcelBuf.AddInfoColumn(FORMAT(Text005),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn('Purchase Journal',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(REPORT::"Purchase Journal 123",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text011),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn("Purch. Inv. Header".GETFILTERS,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text012),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn("Purch. Inv. Line".GETFILTERS,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.ClearNewRow;
        IF tgShowSummary THEN
         MakeExcelDataHeader
        ELSE
         MakeExcelDataHeader2;
         */

    end;

    procedure MakeExcelDataHeader()
    begin
        /*
        ExcelBuf.AddColumn('Invoice No.',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Date',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Vendor Name',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Ex. Amount',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Discount',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Value',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Excise Duty',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Purchase Value',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Tax',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('VAT',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Insurance Charges',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Total Value',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Rnd Off',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Net Value',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
         */

    end;

    procedure CreateExcelbook()
    begin
        /*
        ExcelBuf.CreateBook;
        ExcelBuf.CreateSheet(Text002,Text01,COMPANYNAME,USERID);
        ExcelBuf.GiveUserControl;
        ERROR('');
         */

    end;

    procedure MakeExcelDataHeader2()
    begin
        /*
        ExcelBuf.AddColumn('Invoice No.',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Date',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Vendor Name',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Item No.',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Item Description',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Quantity',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('UOM',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Sq. Mt.',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Ex. Amount',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Discount',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Value',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Excise Duty',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Purchase Value',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Tax',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('VAT',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Insurance Charges',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Total Value',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Rnd Off',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Net Value',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
         */

    end;
}

