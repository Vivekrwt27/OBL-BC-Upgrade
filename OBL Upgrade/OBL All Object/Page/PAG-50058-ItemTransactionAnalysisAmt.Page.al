page 50058 "Item Transaction Analysis-Amt"
{
    // //mo tri1.0 customization no. 35
    // //item transaction analysis-Amount

    DeleteAllowed = false;
    Description = 'customization no. 35';
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SaveValues = true;
    SourceTable = "Dimension Code Buffer";
    SourceTableView = SORTING(Code)
                      ORDER(Ascending)
                      WHERE(Amount = FILTER(<> 0));
    UsageCategory = Lists;
    ApplicationArea = ALL;

    layout
    {
    }

    actions
    {
    }

    var
        Text000: Label 'Period';
        Text001: Label '<Sign><Integer Thousand><Decimals,2>';
        Text002: Label 'You have not yet defined an item analysis view.';
        Text003: Label '%1 is not a valid line definition.';
        Text004: Label '%1 is not a valid column definition.';
        Text005: Label '1,6,,Dimension 1 Filter';
        Text006: Label '1,6,,Dimension 2 Filter';
        Text007: Label '1,6,,Dimension 3 Filter';
        Text008: Label '1,6,,Dimension 4 Filter';
        GLSetup: Record "General Ledger Setup";
        Item: Record Item;
        ItemAnalysisView: Record "Item Analysis View";
        ItemAnalysisViewEntry: Record "Item Analysis View Entry";
        AVBreakdownBuffer: Record "Dimension Code Amount Buffer" temporary;
        ItemAnalysisViewCode: Code[10];
        LineDimOption: Option Item,Period,"Business Unit","Dimension 1","Dimension 2","Dimension 3","Dimension 4";
        ColumnDimOption: Option Item,Period,"Business Unit","Dimension 1","Dimension 2","Dimension 3","Dimension 4";
        LineDimCode: Text[30];
        ColumnDimCode: Text[30];
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        RoundingFactor: Option "None","1","1000","1000000";
        ShowOppositeSign: Boolean;
        ClosingEntryFilter: Option Include,Exclude;
        ShowColumnName: Boolean;
        DateFilter: Text[250];
        InternalDateFilter: Text[250];
        ExcludeClosingDateFilter: Text[250];
        ItemFilter: Code[250];
        Dim1Filter: Code[250];
        Dim2Filter: Code[250];
        Dim3Filter: Code[250];
        Dim4Filter: Code[250];
        EntryType: Option " ",Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output;
        MatrixHeader: Text[50];
        MatrixAmount: Decimal;
        PeriodInitialized: Boolean;
        CurrExchDate: Date;
        UOMFilter: Text[250];
        AmountFilter: Decimal;
        TotalAmt: Decimal;

    local procedure DimCodeToOption(DimCode: Code[20]): Integer
    var
        BusUnit: Record "Business Unit";
    begin
    end;

    local procedure FindRec(DimOption: Option Item,Period,"Business Unit","Dimension 1","Dimension 2","Dimension 3","Dimension 4"; var DimCodeBuf: Record "Dimension Code Buffer"; Which: Text[250]): Boolean
    var
        GLAcc: Record "G/L Account";
        BusUnit: Record "Business Unit";
        Period: Record Date;
        DimVal: Record "Dimension Value";
        // PeriodFormMgt: Codeunit PeriodFormManagement;
        Found: Boolean;
        Item: Record Item;
    begin
    end;

    local procedure NextRec(DimOption: Option Item,Period,"Business Unit","Dimension 1","Dimension 2","Dimension 3","Dimension 4"; var DimCodeBuf: Record "Dimension Code Buffer"; Steps: Integer): Integer
    var
        GLAcc: Record "G/L Account";
        BusUnit: Record "Business Unit";
        Period: Record Date;
        DimVal: Record "Dimension Value";
        //PeriodFormMgt: Codeunit PeriodFormManagement;
        ResultSteps: Integer;
        Item: Record Item;
    begin
    end;

    local procedure CopyItemToBuf(var TheItem: Record Item; var TheDimCodeBuf: Record "Dimension Code Buffer")
    begin
    end;

    local procedure CopyPeriodToBuf(var ThePeriod: Record Date; var TheDimCodeBuf: Record "Dimension Code Buffer")
    var
        Period2: Record Date;
    begin
    end;

    local procedure CopyDimValueToBuf(var TheDimVal: Record "Dimension Value"; var TheDimCodeBuf: Record "Dimension Code Buffer")
    begin
    end;

    local procedure FindPeriod(SearchText: Code[10])
    var
        Calendar: Record Date;
    // PeriodFormMgt: Codeunit PeriodFormManagement;
    begin
    end;

    local procedure CalculateClosingDateFilter()
    var
        AccountingPeriod: Record "Accounting Period";
        FirstRec: Boolean;
    begin
    end;

    local procedure FormatAmount(var Text: Text[250])
    var
        Amount: Decimal;
    begin
    end;

    local procedure GetDimSelection(OldDimSelCode: Text[30]): Text[30]
    begin
    end;

    local procedure LookUpCode(DimOption: Option Item,Period,"Business Unit","Dimension 1","Dimension 2","Dimension 3","Dimension 4"; DimCode: Text[30]; "Code": Text[30])
    var
        GLAcc: Record "G/L Account";
        BusUnit: Record "Business Unit";
        DimVal: Record "Dimension Value";
    begin
    end;

    local procedure LookUpDimFilter(Dim: Code[20]; var Text: Text[250]): Boolean
    var
        DimVal: Record "Dimension Value";
    begin
    end;

    local procedure SetCommonFilters(var TheItemAnalysisViewEntry: Record "Item Analysis View Entry")
    var
        DateFilter2: Text[1024];
    begin
    end;

    local procedure SetDimFilters(var TheItemAnalysisViewEntry: Record "Item Analysis View Entry"; LineOrColumn: Option Line,Column)
    var
        DimOption: Option Item,Period,"Business Unit","Dimension 1","Dimension 2","Dimension 3","Dimension 4";
        DimCodeBuf: Record "Dimension Code Buffer";
    begin
    end;

    local procedure DrillDown(SetColFilter: Boolean)
    begin
    end;

    local procedure ValidateAnalysisViewCode()
    var
        ItemAnalysisViewFilter: Record "Item Analysis View Filter";
    begin
    end;

    local procedure ValidateLineDimCode()
    var
        BusUnit: Record "Business Unit";
    begin
    end;

    local procedure ValidateColumnDimCode()
    var
        BusUnit: Record "Business Unit";
    begin
    end;

    local procedure CalcAmount(SetColFilter: Boolean): Decimal
    var
        Amount: Decimal;
        ColumnCode: Code[20];
    begin
    end;

    local procedure CalcActualAmount(SetColFilter: Boolean): Decimal
    var
        AmountVar: Decimal;
    begin
    end;

    local procedure GetCaptionClass(ItemAnalysisViewDimType: Integer): Text[250]
    begin
    end;

    local procedure CalcTotalActualAmount(SetColFilter: Boolean)
    var
        AmountVar: Decimal;
    begin
    end;
}

