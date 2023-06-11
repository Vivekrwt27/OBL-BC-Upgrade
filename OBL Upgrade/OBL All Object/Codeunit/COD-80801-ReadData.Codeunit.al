codeunit 80801 "Read Data"
{

    trigger OnRun()
    begin
        // ExcelBuf.OpenBook('E:\TestDB2009fin\Final Masters To Be Moved\stores.xls', 'Sheet2');
        ExcelBuf.ReadSheet;
    end;

    var
        ExcelBuf: Record "Excel Buffer";
}

