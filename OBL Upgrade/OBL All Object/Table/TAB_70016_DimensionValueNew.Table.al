table 70016 "Dimension Value New"
{
    Caption = 'Dimension Value';
    LookupPageID = "Dimension Value List";

    fields
    {
        field(1; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            NotBlank = true;
            TableRelation = Dimension;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;

            trigger OnValidate()
            begin
                ItemSetup.GET;
                IF "Dimension Code" = ItemSetup."Type Code" THEN IF STRLEN(Code) <> 2 THEN ERROR(Text008, "Dimension Code", '2');
                IF "Dimension Code" = ItemSetup."Type Catogery Code" THEN IF STRLEN(Code) <> 2 THEN ERROR(Text008, "Dimension Code", '2');
                IF "Dimension Code" = ItemSetup."Size Code" THEN IF STRLEN(Code) <> 3 THEN ERROR(Text008, "Dimension Code", '3');
                IF "Dimension Code" = ItemSetup."Design Code" THEN IF STRLEN(Code) <> 4 THEN ERROR(Text008, "Dimension Code", '4');
                IF "Dimension Code" = ItemSetup."Color Code" THEN IF STRLEN(Code) <> 4 THEN ERROR(Text008, "Dimension Code", '4');
                IF "Dimension Code" = ItemSetup."Packing Code" THEN IF STRLEN(Code) <> 2 THEN ERROR(Text008, "Dimension Code", '2');
                IF "Dimension Code" = ItemSetup."Quality Code" THEN IF STRLEN(Code) <> 1 THEN ERROR(Text008, "Dimension Code", '1');
                IF "Dimension Code" = ItemSetup."Plant Code" THEN IF STRLEN(Code) <> 1 THEN ERROR(Text008, "Dimension Code", '1');
                IF UPPERCASE(Code) = Text002 THEN
                    ERROR(Text003,
                      FIELDCAPTION(Code));

                ItemSetup.GET;
                IF "Dimension Code" = ItemSetup."Plant Code" THEN
                    "Plant Code" := Code;
            end;
        }
        field(3; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(4; "Dimension Value Type"; Option)
        {
            Caption = 'Dimension Value Type';
            OptionCaption = 'Standard,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Standard,Heading,Total,"Begin-Total","End-Total";

            trigger OnValidate()
            begin
                IF ("Dimension Value Type" <> "Dimension Value Type"::Standard) AND
                   (xRec."Dimension Value Type" = xRec."Dimension Value Type"::Standard)
                THEN
                    IF CheckIfDimValueUsed("Dimension Code", Code) THEN
                        ERROR(Text004, GetCheckDimErr);
                Totaling := '';
            end;
        }
        field(5; Totaling; Text[250])
        {
            Caption = 'Totaling';
            TableRelation = IF ("Dimension Value Type" = CONST(Total)) "Dimension Value"."Dimension Code" WHERE("Dimension Code" = FIELD("Dimension Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                IF NOT ("Dimension Value Type" IN
                  ["Dimension Value Type"::Total, "Dimension Value Type"::"End-Total"]) AND (Totaling <> '')
                THEN
                    FIELDERROR("Dimension Value Type");
            end;
        }
        field(6; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(7; "Consolidation Code"; Code[20])
        {
            Caption = 'Consolidation Code';
        }
        field(8; Indentation; Integer)
        {
            Caption = 'Indentation';
        }
        field(9; "Global Dimension No."; Integer)
        {
            Caption = 'Global Dimension No.';
        }
        field(50000; "Qty Recieved"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = FILTER(Output),
                                                                         "Plant Code" = FILTER(<> ''),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Location Code" = FIELD("Location Filter"),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(50001; "Opening Qty"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Posting Date" = FIELD("Date Filter"),
                                                                         "Plant Code" = FILTER(<> ''),
                                                                         "Location Code" = FIELD("Location Filter"),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(50002; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50003; "Depot Transfer"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = FILTER(Transfer),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Plant Code" = FILTER(<> ''),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Qty in Sq.Mt." = FILTER(> 0),
                                                                         "InTransit" = FILTER(true),
                                                                         "External Transfer" = FILTER(true),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(50004; "Location Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Location WHERE("Main Location" = FILTER(''));
        }
        field(50005; "Plant Code"; Code[10])
        {
        }
        field(50007; "Qty Sales"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = FILTER(Sale),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Plant Code" = FILTER(<> ''),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Location Code" = FIELD("Location Filter"),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            FieldClass = FlowField;
        }
        field(50008; Transfers; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = FILTER(Transfer),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Plant Code" = FILTER(<> ''),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Qty in Sq.Mt." = FILTER(< 0),
                                                                         "Location Code" = FIELD("Location Filter"),
                                                                         "InTransit" = CONST(false),
                                                                         "External Transfer" = CONST(true),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            FieldClass = FlowField;
        }
        field(50009; "Opening Qty(Main Location)"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Posting Date" = FIELD("Date Filter"),
                                                                         "Plant Code" = FILTER(<> ''),
                                                                         "Relational Location Code" = FIELD("Location Filter"),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(50010; "Qty Output(Main Location)"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = FILTER(Output),
                                                                         "Plant Code" = FILTER(<> ''),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Relational Location Code" = FIELD("Location Filter"),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(50011; "Qty Sales(Main Location)"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = FILTER(Sale),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Plant Code" = FILTER(<> ''),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Relational Location Code" = FIELD("Location Filter"),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            FieldClass = FlowField;
        }
        field(50012; "Transfers(Main Location)"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = FILTER(Transfer),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Plant Code" = FILTER(<> ''),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Qty in Sq.Mt." = FILTER(< 0),
                                                                         "InTransit" = CONST(false),
                                                                         "External Transfer" = CONST(true),
                                                                         "Relational Location Code" = FIELD("Location Filter"),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            FieldClass = FlowField;
        }
        field(50013; "Type Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Type Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    //VALIDATE("Type Filter",DimensionValue.Code);
                    "Type Filter" := DimensionValue.Code;
            end;
        }
        field(50014; "Quality Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Quality Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Quality Filter", DimensionValue.Code);
            end;
        }
        field(50015; "Category Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Type Catogery Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Category Filter", DimensionValue.Code);
            end;
        }
        field(50016; "Size Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Size Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Size Filter", DimensionValue.Code);
            end;
        }
        field(50017; "Color Filter"; Code[10])
        {
            FieldClass = FlowFilter;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Color Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Color Filter", DimensionValue.Code);
            end;
        }
        field(50018; "Packing Filter"; Code[10])
        {
            FieldClass = FlowFilter;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Packing Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Packing Filter", DimensionValue.Code);
            end;
        }
        field(50019; "Design Filter"; Code[10])
        {
            FieldClass = FlowFilter;

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Design Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Design Filter", DimensionValue.Code);
            end;
        }
        field(50020; "Transfers Rcpt(Main Location)"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = FILTER(Transfer),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Plant Code" = FILTER(<> ''),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Qty in Sq.Mt." = FILTER(> 0),
                                                                         "InTransit" = CONST(false),
                                                                         "External Transfer" = CONST(true),
                                                                         "Relational Location Code" = FIELD("Location Filter"),
                                                                         "Size Code" = FIELD("Size Filter"),
                                                                         "Category Code" = FIELD("Category Filter"),
                                                                         "Type Code" = FIELD("Type Filter")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Dimension Code", "Code")
        {
            Clustered = true;
        }
        key(Key2; "Code", "Global Dimension No.")
        {
        }
        key(Key3; Name)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF CheckIfDimValueUsed("Dimension Code", Code) THEN
            ERROR(Text000, GetCheckDimErr);

        DimValueComb.SETRANGE("Dimension 1 Code", "Dimension Code");
        DimValueComb.SETRANGE("Dimension 1 Value Code", Code);
        DimValueComb.DELETEALL(TRUE);

        DimValueComb.RESET;
        DimValueComb.SETRANGE("Dimension 2 Code", "Dimension Code");
        DimValueComb.SETRANGE("Dimension 2 Value Code", Code);
        DimValueComb.DELETEALL(TRUE);

        DefaultDim.SETRANGE("Dimension Code", "Dimension Code");
        DefaultDim.SETRANGE("Dimension Value Code", Code);
        DefaultDim.DELETEALL(TRUE);

        SelectedDim.SETRANGE("Dimension Code", "Dimension Code");
        SelectedDim.SETRANGE("New Dimension Value Code", Code);
        SelectedDim.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    begin
        GLSetup.GET;
        "Global Dimension No." := 0;
        IF GLSetup."Global Dimension 1 Code" = "Dimension Code" THEN
            "Global Dimension No." := 1;
        IF GLSetup."Global Dimension 2 Code" = "Dimension Code" THEN
            "Global Dimension No." := 2;
    end;

    trigger OnModify()
    begin
        IF "Dimension Code" <> xRec."Dimension Code" THEN BEGIN
            GLSetup.GET;
            "Global Dimension No." := 0;
            IF GLSetup."Global Dimension 1 Code" = "Dimension Code" THEN
                "Global Dimension No." := 1;
            IF GLSetup."Global Dimension 2 Code" = "Dimension Code" THEN
                "Global Dimension No." := 2;
        END;
    end;

    trigger OnRename()
    begin
        RenameBudgEntryDim;
        RenameAnalysisViewEntryDim;
    end;

    var
        Text000: Label '%1\You cannot delete it.';
        Text001: Label '%1\You cannot rename it.';
        Text002: Label '(CONFLICT)';
        Text003: Label '%1 can not be (CONFLICT). This name is used internally by the system.';
        Text004: Label '%1\You cannot change the type.';
        Text005: Label 'This dimension value is used in posted and budget entries.';
        Text006: Label 'This dimension value is used in posted entries.';
        Text007: Label 'This dimension value is used in budget entries.';
        DimValueComb: Record "Dimension Value Combination";
        DefaultDim: Record "Default Dimension";
        SelectedDim: Record "Selected Dimension";
        GLSetup: Record "General Ledger Setup";
        CheckDimErr: Text[250];
        UsedInPostedEntries: Boolean;
        UsedInBudgetEntries: Boolean;
        ItemSetup: Record "Inventory Setup";
        Text008: Label 'Length for %1 should be %2';
        InventorySetup: Record "Inventory Setup";
        DimensionValue: Record "Dimension Value";

    procedure CheckIfDimValueUsed(DimChecked: Code[20]; DimValueChecked: Code[20]): Boolean
    begin
        UsedInPostedEntries := FALSE;
        UsedInBudgetEntries := FALSE;

        /*LedgEntryDim.SETCURRENTKEY("Dimension Code","Dimension Value Code");
        LedgEntryDim.SETRANGE("Dimension Code",DimChecked);
        LedgEntryDim.SETRANGE("Dimension Value Code",DimValueChecked);
        IF LedgEntryDim.FIND('-') THEN
          UsedInPostedEntries := TRUE; */

        /*JnlLineDim.SETCURRENTKEY("Dimension Code","Dimension Value Code");
        JnlLineDim.SETRANGE("Dimension Code",DimChecked);
        JnlLineDim.SETRANGE("Dimension Value Code",DimValueChecked);
        IF JnlLineDim.FIND('-') THEN
          UsedInPostedEntries := TRUE;*/

        /*DocDim.SETCURRENTKEY("Dimension Code","Dimension Value Code");
        DocDim.SETRANGE("Dimension Code",DimChecked);
        DocDim.SETRANGE("Dimension Value Code",DimValueChecked);
        IF DocDim.FIND('-') THEN
          UsedInPostedEntries := TRUE;  */

        /*ProdDocDim.SETCURRENTKEY("Dimension Code","Dimension Value Code");
        ProdDocDim.SETRANGE("Dimension Code",DimChecked);
        ProdDocDim.SETRANGE("Dimension Value Code",DimValueChecked);
        IF ProdDocDim.FIND('-') THEN
          UsedInPostedEntries := TRUE;  */
        /*
        PostedDocDim.SETCURRENTKEY("Dimension Code","Dimension Value Code");
        PostedDocDim.SETRANGE("Dimension Code",DimChecked);
        PostedDocDim.SETRANGE("Dimension Value Code",DimValueChecked);
        IF PostedDocDim.FIND('-') THEN
          UsedInPostedEntries := TRUE;  */

        /*GLBudgetDim.SETCURRENTKEY("Dimension Code","Dimension Value Code");
        GLBudgetDim.SETRANGE("Dimension Code",DimChecked);
        GLBudgetDim.SETRANGE("Dimension Value Code",DimValueChecked);
        IF GLBudgetDim.FIND('-') THEN
          UsedInBudgetEntries := TRUE;
        IF UsedInPostedEntries OR UsedInBudgetEntries THEN BEGIN
          MakeCheckDimErr;
          EXIT(TRUE);
        END ELSE
          EXIT(FALSE);
         */

    end;

    local procedure MakeCheckDimErr()
    begin
        IF UsedInPostedEntries THEN BEGIN
            IF UsedInBudgetEntries THEN
                CheckDimErr := Text005
            ELSE
                CheckDimErr := Text006;
        END ELSE
            IF UsedInBudgetEntries THEN
                CheckDimErr := Text007;
    end;

    procedure GetCheckDimErr(): Text[250]
    begin
        EXIT(CheckDimErr);
    end;

    local procedure RenameBudgEntryDim()
    var
        GLBudget: Record "G/L Budget Name";
        GLBudgetEntry: Record "G/L Budget Entry";
        GLBudgetEntry2: Record "G/L Budget Entry";
        BudgDimNo: Integer;
    begin
        GLBudget.LOCKTABLE;
        IF RECORDLEVELLOCKING THEN
            IF GLBudget.FIND('-') THEN
                REPEAT
                UNTIL GLBudget.NEXT = 0;
        FOR BudgDimNo := 1 TO 4 DO BEGIN
            CASE TRUE OF
                BudgDimNo = 1:
                    GLBudget.SETRANGE("Budget Dimension 1 Code", "Dimension Code");
                BudgDimNo = 2:
                    GLBudget.SETRANGE("Budget Dimension 2 Code", "Dimension Code");
                BudgDimNo = 3:
                    GLBudget.SETRANGE("Budget Dimension 3 Code", "Dimension Code");
                BudgDimNo = 4:
                    GLBudget.SETRANGE("Budget Dimension 4 Code", "Dimension Code");
            END;
            IF GLBudget.FIND('-') THEN BEGIN
                GLBudgetEntry.SETCURRENTKEY("Budget Name", "G/L Account No.", "Business Unit Code", "Global Dimension 1 Code");
                REPEAT
                    GLBudgetEntry.SETRANGE("Budget Name", GLBudget.Name);
                    CASE TRUE OF
                        BudgDimNo = 1:
                            GLBudgetEntry.SETRANGE("Budget Dimension 1 Code", xRec.Code);
                        BudgDimNo = 2:
                            GLBudgetEntry.SETRANGE("Budget Dimension 2 Code", xRec.Code);
                        BudgDimNo = 3:
                            GLBudgetEntry.SETRANGE("Budget Dimension 3 Code", xRec.Code);
                        BudgDimNo = 4:
                            GLBudgetEntry.SETRANGE("Budget Dimension 4 Code", xRec.Code);
                    END;
                    IF GLBudgetEntry.FIND('-') THEN
                        REPEAT
                            GLBudgetEntry2 := GLBudgetEntry;
                            CASE TRUE OF
                                BudgDimNo = 1:
                                    GLBudgetEntry2."Budget Dimension 1 Code" := Code;
                                BudgDimNo = 2:
                                    GLBudgetEntry2."Budget Dimension 2 Code" := Code;
                                BudgDimNo = 3:
                                    GLBudgetEntry2."Budget Dimension 3 Code" := Code;
                                BudgDimNo = 4:
                                    GLBudgetEntry2."Budget Dimension 4 Code" := Code;
                            END;
                            GLBudgetEntry2.MODIFY;
                        UNTIL GLBudgetEntry.NEXT = 0;
                    GLBudgetEntry.RESET;
                UNTIL GLBudget.NEXT = 0;
            END;
            GLBudget.RESET;
        END;
    end;

    local procedure RenameAnalysisViewEntryDim()
    var
        AnalysisView: Record "Analysis View";
        AnalysisViewEntry: Record "Analysis View Entry";
        AnalysisViewEntry2: Record "Analysis View Entry";
        AnalysisViewBudgEntry: Record "Analysis View Budget Entry";
        AnalysisViewBudgEntry2: Record "Analysis View Budget Entry";
        DimensionNo: Integer;
    begin
        AnalysisView.LOCKTABLE;
        IF RECORDLEVELLOCKING THEN
            IF AnalysisView.FIND('-') THEN
                REPEAT
                UNTIL AnalysisView.NEXT = 0;

        FOR DimensionNo := 1 TO 4 DO BEGIN
            CASE TRUE OF
                DimensionNo = 1:
                    AnalysisView.SETRANGE("Dimension 1 Code", "Dimension Code");
                DimensionNo = 2:
                    AnalysisView.SETRANGE("Dimension 2 Code", "Dimension Code");
                DimensionNo = 3:
                    AnalysisView.SETRANGE("Dimension 3 Code", "Dimension Code");
                DimensionNo = 4:
                    AnalysisView.SETRANGE("Dimension 4 Code", "Dimension Code");
            END;
            IF AnalysisView.FIND('-') THEN
                REPEAT
                    AnalysisViewEntry.SETRANGE("Analysis View Code", AnalysisView.Code);
                    AnalysisViewBudgEntry.SETRANGE("Analysis View Code", AnalysisView.Code);
                    CASE TRUE OF
                        DimensionNo = 1:
                            BEGIN
                                AnalysisViewEntry.SETRANGE("Dimension 1 Value Code", xRec.Code);
                                AnalysisViewBudgEntry.SETRANGE("Dimension 1 Value Code", xRec.Code);
                            END;
                        DimensionNo = 2:
                            BEGIN
                                AnalysisViewEntry.SETRANGE("Dimension 2 Value Code", xRec.Code);
                                AnalysisViewBudgEntry.SETRANGE("Dimension 2 Value Code", xRec.Code);
                            END;
                        DimensionNo = 3:
                            BEGIN
                                AnalysisViewEntry.SETRANGE("Dimension 3 Value Code", xRec.Code);
                                AnalysisViewBudgEntry.SETRANGE("Dimension 3 Value Code", xRec.Code);
                            END;
                        DimensionNo = 4:
                            BEGIN
                                AnalysisViewEntry.SETRANGE("Dimension 4 Value Code", xRec.Code);
                                AnalysisViewBudgEntry.SETRANGE("Dimension 4 Value Code", xRec.Code);
                            END;
                    END;
                    IF AnalysisViewEntry.FIND('-') THEN
                        REPEAT
                            AnalysisViewEntry2 := AnalysisViewEntry;
                            CASE TRUE OF
                                DimensionNo = 1:
                                    AnalysisViewEntry2."Dimension 1 Value Code" := Code;
                                DimensionNo = 2:
                                    AnalysisViewEntry2."Dimension 2 Value Code" := Code;
                                DimensionNo = 3:
                                    AnalysisViewEntry2."Dimension 3 Value Code" := Code;
                                DimensionNo = 4:
                                    AnalysisViewEntry2."Dimension 4 Value Code" := Code;
                            END;
                            AnalysisViewEntry.DELETE;
                            AnalysisViewEntry2.INSERT;
                        UNTIL AnalysisViewEntry.NEXT = 0;
                    AnalysisViewEntry.RESET;
                    IF AnalysisViewBudgEntry.FIND('-') THEN
                        REPEAT
                            AnalysisViewBudgEntry2 := AnalysisViewBudgEntry;
                            CASE TRUE OF
                                DimensionNo = 1:
                                    AnalysisViewBudgEntry2."Dimension 1 Value Code" := Code;
                                DimensionNo = 2:
                                    AnalysisViewBudgEntry2."Dimension 2 Value Code" := Code;
                                DimensionNo = 3:
                                    AnalysisViewBudgEntry2."Dimension 3 Value Code" := Code;
                                DimensionNo = 4:
                                    AnalysisViewBudgEntry2."Dimension 4 Value Code" := Code;
                            END;
                            AnalysisViewBudgEntry.DELETE;
                            AnalysisViewBudgEntry2.INSERT;
                        UNTIL AnalysisViewBudgEntry.NEXT = 0;
                    AnalysisViewBudgEntry.RESET;
                UNTIL AnalysisView.NEXT = 0;
            AnalysisView.RESET;
        END;
    end;
}

