report 50016 "Import from Excel"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("No. of Rows to Skip"; NoofRowToSkip)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            IF CloseAction = ACTION::OK THEN BEGIN
                IF ServerFileName = '' THEN
                    // ServerFileName := FileManagement.UploadFile(Text001, ExcelFileExtensionTok);
                IF ServerFileName = '' THEN
                        EXIT(FALSE);
                // SheetName := ExcelBuffer.SelectSheetsName(ServerFileName);
                IF SheetName = '' THEN
                    EXIT(TRUE);
            END;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        NoofRowToSkip := 1;
    end;

    trigger OnPreReport()
    begin
        GlbTemplateCode := 'JOURNAL VO';
        GLBBatchName := 'BANKPAY';
        ExcelBuffer.LOCKTABLE;
        // 16630    ExcelBuffer.OpenBookNew(ServerFileName, SheetName);

        ExcelBuffer.ReadSheet();
        TotalRows := GetLastRowandColumn(FALSE);

        FOR i := 1 + NoofRowToSkip TO TotalRows DO BEGIN
            InsertData(i);
        END;

        ExcelBuffer.DELETEALL;
        IF TmpItemAmount.FINDFIRST THEN BEGIN
            PAGE.RUN(Page::"Prod. BOM Explode", TmpItemAmount);
        END;
        //MESSAGE('Import is Completed');
    end;

    var
        FileManagement: Codeunit "File Management";
        ServerFileName: Text;
        SheetName: Text;
        ExcelBuffer: Record "Excel Buffer";
        i: Integer;
        TotalRows: Integer;
        Text001: Label 'Import Excel File';
        ExcelFileExtensionTok: Label '.xlsx';
        Description: Text;
        TmpGenJournalLine: Record "User Location" temporary;
        NoofRowToSkip: Integer;
        GlbTemplateCode: Code[20];
        GLBBatchName: Code[20];
        TmpItemAmount: Record "Item Amount" temporary;

    local procedure InsertData(RowNo: Integer)
    begin
        TmpItemAmount.INIT;
        TmpItemAmount.Amount := RowNo;
        EVALUATE(TmpItemAmount."RM Item No.", GetValueAtCell(RowNo, 1));
        EVALUATE(TmpItemAmount.Description, GetValueAtCell(RowNo, 2));
        EVALUATE(TmpItemAmount."Location Code", GetValueAtCell(RowNo, 3));
        EVALUATE(TmpItemAmount.Quantity, GetValueAtCell(RowNo, 4));
        TmpItemAmount.INSERT(TRUE);
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    var
        ExcelBuff1: Record "Excel Buffer";
    begin
        IF ExcelBuff1.GET(RowNo, ColNo) THEN
            EXIT(ExcelBuff1."Cell Value as Text");
    end;

    local procedure GetLastRowandColumn(BlnColumn: Boolean): Integer
    var
        ExcelBuffer1: Record "Excel Buffer";
    begin
        IF NOT BlnColumn THEN BEGIN
            ExcelBuffer1.RESET;
            IF ExcelBuffer1.FINDLAST THEN
                EXIT(ExcelBuffer1."Row No.");
        END ELSE BEGIN
            ExcelBuffer1.RESET;
            ExcelBuffer1.SETFILTER("Row No.", '%1', 1);
            IF ExcelBuffer1.FINDLAST THEN
                EXIT(ExcelBuffer1."Column No.");
        END;
    end;

    procedure SetTableData(var TmpGenJournalLine: Record "Gen. Journal Line")
    begin
    end;

    procedure GetTableData(var TmpGenJournalLine: Record "Gen. Journal Line")
    begin
    end;

    procedure SetTemplateCode(TemplateCode: Code[20]; BatchName: Code[10])
    begin
        GlbTemplateCode := TemplateCode;
        GLBBatchName := BatchName;
    end;

    local procedure PageConverttoDate(DtText: Text) dt: Date
    var
        DD: Integer;
        MM: Integer;
        YY: Integer;
    begin
        EVALUATE(MM, COPYSTR(DtText, 1, 2));
        EVALUATE(DD, COPYSTR(DtText, 4, 5));
        EVALUATE(YY, COPYSTR(DtText, 7, 8));
        dt := DMY2DATE(DD, MM, YY);
    end;
}

