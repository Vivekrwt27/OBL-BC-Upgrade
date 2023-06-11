report 50001 "Pending Intran"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\PendingIntran.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Ledger Entry"; 32)
        {
            DataItemTableView = SORTING("Entry No.")
                                WHERE("Location Code" = FILTER('INTRAN'),
                                      "Remaining Quantity" = FILTER(<> 0),
                                      "Entry Type" = FILTER(Transfer));
            RequestFilterFields = "Posting Date", "Item No.";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(ItemNo; "Item Ledger Entry"."Item No.")
            {
            }
            column(UOM; "Item Ledger Entry"."Unit of Measure Code")
            {
            }
            column(PosDate; FORMAT("Item Ledger Entry"."Posting Date"))
            {
            }
            column(DocNo; "Item Ledger Entry"."Document No.")
            {
            }
            column(DocDate; FORMAT("Item Ledger Entry"."Document Date"))
            {
            }
            column(FromLocationCode; FromLocationCode)
            {
            }
            column(ToLocationCode; ToLocationCode)
            {
            }
            column(ItemDescription; ItemDescription)
            {
            }
            column(RemQty; "Item Ledger Entry"."Remaining Quantity")
            {
            }

            trigger OnAfterGetRecord()
            begin

                FromLocationCode := '';
                ToLocationCode := '';
                IF "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Transfer Shipment" THEN BEGIN
                    TransferShipmentHeader.RESET;
                    TransferShipmentHeader.SETRANGE("No.", "Document No.");
                    TransferShipmentHeader.SETRANGE("In-Transit Code", "Location Code");
                    IF TransferShipmentHeader.FINDFIRST THEN BEGIN
                        FromLocationCode := TransferShipmentHeader."Transfer-from Code";
                        ToLocationCode := TransferShipmentHeader."Transfer-to Code";
                    END;
                END ELSE BEGIN
                    TransferReceiptHeader.RESET;
                    TransferReceiptHeader.SETRANGE("No.", "Document No.");
                    TransferReceiptHeader.SETRANGE("In-Transit Code", "Location Code");
                    IF TransferReceiptHeader.FINDFIRST THEN BEGIN
                        FromLocationCode := TransferReceiptHeader."Transfer-from Code";
                        ToLocationCode := TransferReceiptHeader."Transfer-to Code";
                    END;
                END;

                IF Item.GET("Item No.") THEN
                    ItemDescription := Item.Description
                ELSE
                    ItemDescription := '';
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
        /*//Comment on 24062016 //6823
        IF ExportToExcel THEN BEGIN
         ExcelBuff.CreateBook;
         ExcelBuff.CreateSheet('In and Out Flow','',COMPANYNAME,USERID);
         ExcelBuff.GiveUserControl;
        END;
        */

    end;

    trigger OnPreReport()
    begin

        IF ExportToExcel THEN BEGIN
            ExcelBuff.DELETEALL;
            CLEAR(ExcelBuff);
            EnterCell(1, 1, 'Item No.', TRUE, FALSE);
            EnterCell(1, 2, 'Item Description', TRUE, FALSE);
            EnterCell(1, 3, 'UOM', TRUE, FALSE);
            EnterCell(1, 4, 'Posting Date', TRUE, FALSE);
            EnterCell(1, 5, 'Document No.', TRUE, FALSE);
            EnterCell(1, 6, 'Document Date', TRUE, FALSE);
            EnterCell(1, 7, 'Transfer From', TRUE, FALSE);
            EnterCell(1, 8, 'Transfer To', TRUE, FALSE);
            EnterCell(1, 9, 'Remaining Quantity', TRUE, FALSE);
            k := 2;
        END;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TransferReceiptHeader: Record "Transfer Receipt Header";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        FromLocationCode: Code[20];
        ToLocationCode: Code[20];
        Item: Record Item;
        ItemDescription: Text[100];
        ExportToExcel: Boolean;
        ExcelBuff: Record "Excel Buffer" temporary;
        k: Integer;

    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean)
    begin

        //MSAK.BEGIN 060515
        ExcelBuff.INIT;
        ExcelBuff.VALIDATE("Row No.", RowNo);
        ExcelBuff.VALIDATE("Column No.", ColumnNo);
        ExcelBuff."Cell Value as Text" := CellValue;
        ExcelBuff.Bold := Bold;
        ExcelBuff.Underline := UnderLine;
        ExcelBuff.INSERT;
        //MSAK.END 060515
    end;
}

