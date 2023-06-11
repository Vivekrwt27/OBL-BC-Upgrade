table 50115 "Budget Master Line"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Budget Master"."No.";
        }
        field(5; "Capex Request"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Regular,Non-Regular,Disposal';
            OptionMembers = Regular,"Non-Regular",Disposal;
        }
        field(6; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Project Budget,Spending Profile per Quarter';
            OptionMembers = " ","Project Budget","Spending Profile per Quarter";
        }
        field(8; "S. No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Expenditure Element"; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Estimation (In INR)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                UpdateExpenditurePercentage();
            end;
        }
        field(20; Percentage; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51; "Creation Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(55; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60; Year; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckQuarterINRIsZero(Year, Quarter, "Quarter Spending (In INR)");
            end;
        }
        field(65; Quarter; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Q1,Q2,Q3,Q4';
            OptionMembers = " ",Q1,Q2,Q3,Q4;

            trigger OnValidate()
            begin
                CheckQuarterINRIsZero(Year, Quarter, "Quarter Spending (In INR)");
            end;
        }
        field(70; "Quarter Spending (In INR)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckYearQuarterExist("Document No.", "Capex Request", Rec.Year, Rec.Quarter);
                UpdateProgressivePercentage();
            end;
        }
        field(75; "Cumulative Total (In INR)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(80; "Progressive (%)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Capex Request", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        "Quarter Spending (In INR)" := 0;
        UpdateQuarterCumulativeTot("Document No.", "Capex Request");
    end;

    trigger OnInsert()
    begin
        TESTFIELD(Type);
        CheckFieldsForQuarter();

        "Created By" := USERID;
        "Creation Date" := TODAY;
        "Creation Time" := TIME;
    end;

    trigger OnModify()
    begin
        TestStatusOpen();
        UpdateQuarterCumulativeTot("Document No.", "Capex Request");
    end;

    var
        BudgetMaster: Record "Budget Master";

    local procedure GetBudgetMaster()
    begin
        BudgetMaster.GET("Capex Request", "Document No.");
    end;

    local procedure TestStatusOpen()
    begin
        GetBudgetMaster();
        BudgetMaster.TESTFIELD(Status, BudgetMaster.Status::Open);
    end;

    local procedure UpdateQuarterCumulativeTot(DocNo: Code[20]; CapexRequest: Option Regular,"Non-Regular")
    var
        recBudgetMasterLine: Record "Budget Master Line";
        CumulativeTotal: Decimal;
    begin

        recBudgetMasterLine.RESET();
        recBudgetMasterLine.SETRANGE("Document No.", DocNo);
        recBudgetMasterLine.SETRANGE("Capex Request", CapexRequest);
        recBudgetMasterLine.SETRANGE(Type, recBudgetMasterLine.Type::"Spending Profile per Quarter");
        IF recBudgetMasterLine.FINDFIRST THEN BEGIN
            CumulativeTotal := 0;
            REPEAT
                IF "Line No." <> recBudgetMasterLine."Line No." THEN BEGIN
                    CumulativeTotal += recBudgetMasterLine."Quarter Spending (In INR)";
                    recBudgetMasterLine."Cumulative Total (In INR)" := CumulativeTotal;
                    recBudgetMasterLine.MODIFY();
                END
                ELSE BEGIN
                    CumulativeTotal += "Quarter Spending (In INR)";
                    "Cumulative Total (In INR)" := CumulativeTotal;
                END;
            UNTIL recBudgetMasterLine.NEXT = 0;
        END;
    end;

    local procedure CheckFieldsForQuarter()
    begin
        IF Type = Rec.Type::"Spending Profile per Quarter" THEN BEGIN
            TESTFIELD(Year);
        END;
    end;

    local procedure CheckYearQuarterExist(DocNo: Code[20]; CapexRequest: Option Regular,"Non-Regular"; Year: Integer; Quarter: Option " ",Q1,Q2,Q3,Q4)
    var
        recBudgetMasterLine: Record "Budget Master Line";
        YearQuarterExistErr: Label 'Year %1 and Quarter %2 are already Exist in Document No. %3';
    begin
        //TestField(Quarter);//16225 
        //TESTFIELD(Year);//16225
        recBudgetMasterLine.RESET();
        recBudgetMasterLine.SETRANGE("Document No.", DocNo);
        recBudgetMasterLine.SETRANGE("Capex Request", CapexRequest);
        recBudgetMasterLine.SETRANGE(Type, recBudgetMasterLine.Type::"Spending Profile per Quarter");
        recBudgetMasterLine.SETFILTER("Line No.", '<>%1', "Line No.");
        recBudgetMasterLine.SETRANGE(Year, Year);
        recBudgetMasterLine.SETRANGE(Quarter, Quarter);
        IF NOT recBudgetMasterLine.ISEMPTY THEN
            ERROR(YearQuarterExistErr, Year, Quarter, DocNo);
    end;

    local procedure CheckQuarterINRIsZero(Year: Integer; Quarter: Option " ",Q1,Q2,Q3,Q4; QuarterSpending: Decimal)
    var
        QSpendingIsZeroErr: Label 'Quarter Spending Value must be Zero !!!';
        YearErr: Label 'Year must be %1';
    begin
        IF Year < DATE2DMY(TODAY, 3) THEN
            ERROR(STRSUBSTNO(YearErr, DATE2DMY(TODAY, 3)));

        IF QuarterSpending <> 0 THEN BEGIN
            IF (Year = 0) OR (Quarter = Quarter::" ") THEN
                ERROR(QSpendingIsZeroErr);
        END;

    end;

    local procedure UpdateExpenditurePercentage()
    var
        BudgetMasterLine: Record "Budget Master Line";
    begin
        GetBudgetMaster();
        VALIDATE(Percentage, ("Estimation (In INR)" / BudgetMaster."Investment (In INR)") * 100);
        UpdateContigencyOnHdr();
    end;

    local procedure UpdateContigencyOnHdr()
    var
        BudgetMasterLine: Record "Budget Master Line";
    begin

        BudgetMasterLine.RESET();
        BudgetMasterLine.SETRANGE("Document No.", "Document No.");
        BudgetMasterLine.SETRANGE("Capex Request", "Capex Request");
        BudgetMasterLine.SETRANGE(Type, BudgetMasterLine.Type::"Project Budget");
        BudgetMasterLine.SETFILTER("Line No.", '<>%1', "Line No.");
        BudgetMasterLine.CALCSUMS("Estimation (In INR)");
        GetBudgetMaster();
        BudgetMaster.Contigency := BudgetMaster."Investment (In INR)" - BudgetMasterLine."Estimation (In INR)" - "Estimation (In INR)";
        BudgetMaster.MODIFY();
    end;

    local procedure UpdateProgressivePercentage()
    var
        BudgetMasterLine: Record "Budget Master Line";
    begin
        GetBudgetMaster();
        VALIDATE("Progressive (%)", ("Quarter Spending (In INR)" / BudgetMaster."Investment (In INR)") * 100);
    end;
}

