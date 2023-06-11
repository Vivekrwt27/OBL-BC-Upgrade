report 50365 "Item Wise Despatch"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\ItemWiseDespatch.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.")
             WHERE("Quality Code" = filter(1));
            RequestFilterFields = "Location Filter", "Base Unit of Measure";
            column(Prem; Prem)
            {
            }
            column(Com; Com)
            {
            }
            column(Eco; Eco)
            {
            }
            column(LineTotal; Prem + Com + Eco)
            {
            }
            column(Description_Item; Item.Description + ' ' + Item."Description 2")
            {
            }
            column(FromDate; FORMAT(FromDate))
            {
            }
            column(ToDate; FORMAT(ToDate))
            {
            }

            trigger OnAfterGetRecord()
            begin

                Prem := 0;
                Com := 0;
                Eco := 0;
                Prem := GetSaleQty("No.", FromDate, ToDate);
                Com := GetSaleQty(GetOtherItem("No.", 'C'), FromDate, ToDate);
                Eco := GetSaleQty(GetOtherItem("No.", 'E'), FromDate, ToDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("From Date"; FromDate)
                {
                    ApplicationArea = All;
                }
                field(ToDate; ToDate)
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

    trigger OnPostReport()
    begin

        //RepAuditMgt.CreateAudit(50365)
    end;

    trigger OnPreReport()
    begin

        Month := DATE2DMY(FromDate, 2);
        LocFilter := Item.GETFILTER("Location Filter");//MSBS.Rao 290914
        //XYZ := FromDate +30;
        //IF ToDate > XYZ THEN
        //  ERROR('Date Should Not Exceeded One Month');
    end;

    var
        RecILE: Record "Item Ledger Entry";
        NewString: Code[20];
        Desc: Text[250];
        RecNewItem: Record "Item Amount" temporary;
        NewString2: Code[20];
        FromDate: Date;
        ToDate: Date;
        Month: Integer;
        Prem: Decimal;
        Com: Decimal;
        Eco: Decimal;
        TempILE: Record "Item Ledger Entry" temporary;
        Sno: Integer;
        TempItem: Record Item temporary;
        Total: Decimal;
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        XYZ: Date;
        LocFilter: Text[1024];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Text010: Label 'From Date';
        Text005: Label 'Company Name';
        Text007: Label 'Report Name';
        Text008: Label 'USERID';
        Text009: Label 'Date';
        Text011: Label 'To Date';

    procedure GetEffStk(ItemCd: Code[20]; ItemType: Option P,C,E,A) Stock: Decimal
    var
        RecItem: Record Item;
        ComStock: Decimal;
        PremStock: Decimal;
        EcoStock: Decimal;
    begin
        //Get Commercial Stock

        CASE ItemType OF
            ItemType::C:
                BEGIN
                    IF RecItem.GET(GetOtherItem(ItemCd, 'C')) THEN BEGIN
                        ComStock := RecItem.Inventory;
                        Stock := ComStock;
                    END;
                END;
            ItemType::P:
                BEGIN
                    IF RecItem.GET(GetOtherItem(ItemCd, 'P')) THEN BEGIN
                        RecItem.CALCFIELDS(Inventory);
                        PremStock := RecItem.Inventory;
                        Stock := PremStock;
                    END;
                END;
            ItemType::E:
                BEGIN
                    IF RecItem.GET(GetOtherItem(ItemCd, 'E')) THEN BEGIN
                        RecItem.CALCFIELDS(Inventory);
                        EcoStock := RecItem.Inventory;
                        Stock := EcoStock;
                    END;
                END;
            ItemType::A:
                BEGIN
                    IF RecItem.GET(GetOtherItem(ItemCd, 'E')) THEN BEGIN
                        RecItem.CALCFIELDS(Inventory);
                        EcoStock := RecItem.Inventory;
                        // Stock:=EcoStock;
                    END;
                    IF RecItem.GET(GetOtherItem(ItemCd, 'P')) THEN BEGIN
                        RecItem.CALCFIELDS(Inventory);
                        PremStock := RecItem.Inventory;
                        // Stock :=PremStock;
                    END;
                    IF RecItem.GET(GetOtherItem(ItemCd, 'C')) THEN BEGIN
                        RecItem.CALCFIELDS(Inventory);
                        ComStock := RecItem.Inventory;
                        // Stock :=ComStock;
                    END;
                    Stock := EcoStock + PremStock + ComStock;
                END;
        END;

        EXIT(Stock);
    end;

    procedure GetSaleQty(ItemCode: Code[20]; DateFrom: Date; DateTo: Date) DespatchQty: Decimal
    var
        RecILE: Record "Item Ledger Entry";
        QWD: Decimal;
        i: Integer;
        Qty: Decimal;
    begin
        QWD := 0;
        CLEAR(Qty);

        RecILE.RESET;
        RecILE.SETCURRENTKEY("Item No.", "Location Code", "Entry Type", "Posting Date");
        RecILE.SETRANGE("Item No.", ItemCode);
        RecILE.SETFILTER("Entry Type", '%1|%2', RecILE."Entry Type"::Sale, RecILE."Entry Type"::Transfer);
        RecILE.SETRANGE("Posting Date", DateFrom, DateTo);
        IF LocFilter <> '' THEN //MSBS.Rao 290914
            RecILE.SETFILTER("Location Code", LocFilter);//MSBS.Rao 290914
        RecILE.SETFILTER(Quantity, '<%1', 0);
        RecILE.SETRANGE(Positive, FALSE);
        IF RecILE.FINDFIRST THEN BEGIN
            REPEAT
                Qty += ABS(RecILE."Qty in Sq.Mt.");
            UNTIL RecILE.NEXT = 0;
        END;
        EXIT(Qty);
    end;

    procedure GetOtherItem(ItemCode: Code[20]; Type: Code[1]): Code[20]
    var
        RecItem1: Record Item;
        Abc: Code[20];
    begin
        IF Type = 'C' THEN BEGIN
            Abc := COPYSTR(ItemCode, 1, STRLEN(ItemCode) - 2) + '2' + COPYSTR(ItemCode, STRLEN(ItemCode), STRLEN(ItemCode));
        END;
        IF Type = 'E' THEN BEGIN
            Abc := COPYSTR(ItemCode, 1, STRLEN(ItemCode) - 2) + '2' + COPYSTR(ItemCode, STRLEN(ItemCode), STRLEN(ItemCode));
        END;
        IF Type = 'P' THEN BEGIN
            Abc := ItemCode;
        END;

        EXIT(Abc);
    end;
}

