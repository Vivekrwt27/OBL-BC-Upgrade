report 50338 "Internal Transfer Summry & Det"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\InternalTransferSummryDet.rdl';

    dataset
    {
        dataitem("Transfer Receipt Line"; "Transfer Receipt Line")
        {
            DataItemTableView = SORTING("Size Code", "Item No.")
                                WHERE("Quantity (Base)" = FILTER(<> 0));
            RequestFilterFields = "Size Code", "Plant Code", "Item No.", "Receipt Date", "Transfer-to Code";
            column(CompName; COMPANYNAME)
            {
            }
            column(ItemNo; "Transfer Receipt Line"."Item No.")
            {
            }
            column(DesTotal; "Transfer Receipt Line".Description + '  ' + "Transfer Receipt Line"."Description 2")
            {
            }
            column(Qty; Qty)
            {
            }
            column(Qty1; Qty1)
            {
            }
            column(Qty2; Qty2)
            {
            }
            column(QuantityTotal; Qty + Qty1 + Qty2)
            {
            }
            column(SizeCode; "Size Code")
            {
            }
            column(SizeCodeDes; RecItem."Size Code Desc.")
            {
            }
            column(SizeSummry; SizeSummry)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Today; TODAY)
            {
            }

            trigger OnAfterGetRecord()
            begin

                RecItem.RESET;
                RecItem.SETRANGE(RecItem."Size Code", "Size Code");
                IF NOT RecItem.FINDFIRST THEN
                    CurrReport.SKIP;



                Qty := 0;
                Item1 := '';
                Item2 := '';
                Item3 := '';
                TSL.RESET;
                TSL.SETRANGE(TSL."Document No.", "Document No.");
                TSL.SETRANGE(TSL."Item No.", "Item No.");
                TSL.SETRANGE(TSL."Line No.", "Line No.");
                TSL.SETRANGE(TSL."Quality Code", '1');
                IF TSL.FINDFIRST THEN BEGIN
                    Qty := TSL."Quantity (Base)";

                END;

                Qty1 := 0;
                TSL.RESET;
                TSL.SETRANGE(TSL."Document No.", "Document No.");
                TSL.SETRANGE(TSL."Item No.", "Item No.");
                TSL.SETRANGE(TSL."Line No.", "Line No.");
                TSL.SETRANGE(TSL."Quality Code", '2');
                IF TSL.FINDFIRST THEN BEGIN
                    Qty1 := TSL."Quantity (Base)";

                END;

                Qty2 := 0;
                TSL.RESET;
                TSL.SETRANGE(TSL."Document No.", "Document No.");
                TSL.SETRANGE(TSL."Item No.", "Item No.");
                TSL.SETRANGE(TSL."Line No.", "Line No.");
                TSL.SETRANGE(TSL."Quality Code", '3');
                IF TSL.FINDFIRST THEN BEGIN
                    Qty2 := TSL."Quantity (Base)";


                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Summary; SizeSummry)
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

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Qty: Decimal;
        TSL: Record "Transfer Receipt Line";
        Qty1: Decimal;
        Qty2: Decimal;
        Item1: Code[50];
        Item2: Code[50];
        Item3: Code[50];
        TotalQty: Decimal;
        PrintToExcel: Boolean;
        ExcelBuf: Record "Excel Buffer";
        SizeSummry: Boolean;
        RecItem: Record Item;
        RepAuditMgt: Codeunit "Auto PDF Generate";
}

