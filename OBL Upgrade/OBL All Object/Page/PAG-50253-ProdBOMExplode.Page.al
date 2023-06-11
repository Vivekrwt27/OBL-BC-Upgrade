page 50253 "Prod. BOM Explode"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Item Amount";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Prod. Bom No."; Rec."RM Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import from Excel")
            {
                Image = Excel;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    TmpGenJournalLine: Record "Gen. Journal Line";
                begin
                    //ImportfromExcel.SetTemplateCode(GlbTemplateCode,GLBBatchName);
                    //ImportfromExcel.SetTableData(TempItemAmount);
                    CurrPage.CLOSE;
                    ImportfromExcel.RUN;
                end;
            }
            action("Generate Detail Report")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    TempItemAmount: Record "Item Amount" temporary;
                    QuantityExplosion: Report "WIP Quantity Explosion";
                begin
                    IF CONFIRM('Do You want to Print the Detail Report', FALSE) THEN BEGIN
                        //  RESET;//16225 cHECK TO OBLDATA
                        IF Rec.FINDFIRST THEN BEGIN
                            QuantityExplosion.SetTableRecords(Rec);
                            QuantityExplosion.RUN;
                        END;
                        CurrPage.CLOSE;
                    END;
                end;
            }
        }
    }

    var
        GlbTemplateCode: Code[20];
        GLBBatchName: Code[20];
        ExcelBuffer: Record "Excel Buffer" temporary;
        ServerFileName: Text;
        SheetName: Text;
        TotalRows: Integer;
        I: Integer;
        NoofRowToSkip: Integer;
        TempItemAmount: Record "Item Amount" temporary;
        ImportfromExcel: Report "Import from Excel";

    procedure SetTemplateCode(var TemplateCode: Code[20]; var BatchName: Code[20])
    begin
        GlbTemplateCode := TemplateCode;
        GLBBatchName := BatchName;
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

    local procedure InsertData(RowNo: Integer)
    var
        ProductionBOMHeader: Record "Production BOM Header";
    begin
        TempItemAmount.INIT;
        TempItemAmount.Amount := RowNo;

        EVALUATE(TempItemAmount."RM Item No.", GetValueAtCell(RowNo, 1));
        IF ProductionBOMHeader.GET(TempItemAmount."RM Item No.") THEN
            MESSAGE('Prod. Bom %1 Does Not Exists ', TempItemAmount."RM Item No.");
        EVALUATE(TempItemAmount.Description, GetValueAtCell(RowNo, 2));

        EVALUATE(TempItemAmount."Location Code", GetValueAtCell(RowNo, 3));
        EVALUATE(TempItemAmount.Quantity, GetValueAtCell(RowNo, 4));
        TempItemAmount.INSERT(TRUE);
    end;
}

