page 50082 "Item Creation Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Item Creation Line";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Code"; Rec."Item Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Type Code"; Rec."Type Code")
                {
                    Editable = TypeCodeEditBool;
                    Enabled = TypeCodeEditBool;
                    ApplicationArea = All;
                }
                field(CEO; Rec.CEO)
                {
                    Editable = false;
                    Visible = TypeCodeBool;
                    ApplicationArea = All;
                }
                field("Type Catogery Code"; Rec."Type Catogery Code")
                {
                    Editable = TypeCatCodeEditBool;
                    Visible = TypeCatCodeBool;
                    ApplicationArea = All;
                }
                field(IT; Rec.IT)
                {
                    Editable = false;
                    Visible = TypeCatCodeBool;
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Size Code"; Rec."Size Code")
                {
                    Editable = SizeCodeEditBool;
                    Visible = SizeCodeBool;
                    ApplicationArea = All;
                }
                field("Authorization 3 Approval Date"; Rec."Authorization 3 Approval Date")
                {
                    Editable = false;
                    Visible = SizeCodeBool;
                    ApplicationArea = All;
                }
                field("Packing Code"; Rec."Packing Code")
                {
                    Editable = PackingCodeEditBool;
                    Visible = PackingCodeBool;
                    ApplicationArea = All;
                }
                field("CEO Approval Time"; Rec."CEO Approval Time")
                {
                    Editable = false;
                    Visible = PackingCodeBool;
                    ApplicationArea = All;
                }
                field("Quality Code"; Rec."Quality Code")
                {
                    Editable = QualityCodeEditBool;
                    Visible = QualityCodeBool;
                    ApplicationArea = All;
                }
                field("IT Approval Date"; Rec."IT Approval Date")
                {
                    Editable = false;
                    Visible = QualityCodeBool;
                    ApplicationArea = All;
                }
                field("Plant Code"; Rec."Plant Code")
                {
                    Editable = PlantCodeEditBool;
                    Visible = PlantCodeBool;
                    ApplicationArea = All;
                }
                field("IT Approval Time"; Rec."IT Approval Time")
                {
                    Editable = false;
                    Visible = PlantCodeBool;
                    ApplicationArea = All;
                }
                field("Design Code"; Rec."Design Code")
                {
                    Editable = DesignCodeEditBool;
                    Visible = DesignCodeBool;
                    ApplicationArea = All;
                }
                field("Authorization 3 Approval Time"; Rec."Authorization 3 Approval Time")
                {
                    Editable = false;
                    Visible = DesignCodeBool;
                    ApplicationArea = All;
                }
                field("Color Code"; Rec."Color Code")
                {
                    Editable = ColorCodeEditBool;
                    Visible = ColorCodeBool;
                    ApplicationArea = All;
                }
                field("CEO Approval Date"; Rec."CEO Approval Date")
                {
                    Editable = false;
                    Visible = ColorCodeBool;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Item Classification"; Rec."Item Classification")
                {
                    Editable = ItemClassEditBool;
                    Visible = ItemClassBool;
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    Editable = GrossWeightEditBool;
                    Visible = GrossWeightBool;
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    Editable = NetWeightEditBool;
                    Visible = NetWeightBool;
                    ApplicationArea = All;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    Editable = HSNCodeEditBool;
                    Visible = HSNCodeBool;
                    ApplicationArea = All;
                }
                field("Scheme Group"; Rec."Scheme Group")
                {
                    Editable = SchemeGroupEditBool;
                    Visible = SchemeGroupBool;
                    ApplicationArea = All;
                }
                field("Discount Group"; Rec."Discount Group")
                {
                    Editable = DiscountGrpEditBool;
                    Visible = DiscountGrpBool;
                    ApplicationArea = All;
                }
                field(Originator; Rec.Originator)
                {
                    Editable = OriginatorEditBool;
                    Visible = OriginatorBool;
                    ApplicationArea = All;
                }
                field(NPD; Rec.NPD)
                {
                    Editable = NPDEditBool;
                    Visible = NPDBool;
                    ApplicationArea = All;
                }
                field("Tableau Product Group"; Rec."Tableau Product Group")
                {
                    Editable = TableauProdGrpEditBool;
                    Visible = TableauProdGrpBool;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                }
                field("Manuf. Strategy"; Rec."Manuf. Strategy")
                {
                    Editable = ManufStrategyEditBool;
                    Visible = ManufStrategyBool;
                    ApplicationArea = All;
                }
                field(COGS; Rec.COGS)
                {
                    Editable = COGSEditBool;
                    Visible = COGSBool;
                    ApplicationArea = All;
                }
                field("Variable & Semi Variable Cost"; Rec."Variable & Semi Variable Cost")
                {
                    Editable = VariableCostEditBool;
                    Visible = VariableCostBool;
                    ApplicationArea = All;
                }
                field("List Price"; Rec."List Price")
                {
                    Editable = ListPriceEditBool;
                    Visible = ListPriceBool;
                    ApplicationArea = All;
                }
                field("Net Margin"; Rec."Net Margin")
                {
                    Editable = NetMarginEditBool;
                    Visible = NetMarginBool;
                    ApplicationArea = All;
                }
                field("Net Margin %"; Rec."Net Margin %")
                {
                    Editable = NetMarginperEditBool;
                    Visible = NetMarginperBool;
                    ApplicationArea = All;
                }
                field(AD; Rec.AD)
                {
                    Editable = ADEditBool;
                    Visible = ADBool;
                    ApplicationArea = All;
                }
                field(ASP; Rec.ASP)
                {
                    Editable = ASPEditBool;
                    Visible = ASPBool;
                    ApplicationArea = All;
                }
                field("Project Name"; Rec."Project Name")
                {
                    Editable = ProjectNameEditBool;
                    Visible = ProjectNameBool;
                    ApplicationArea = All;
                }
                field(FC; Rec.FC)
                {
                    Editable = FCEditBool;
                    Visible = FCBool;
                    ApplicationArea = All;
                }
                field(SV; Rec.SV)
                {
                    Editable = SVEditbool;
                    Visible = SVBool;
                    ApplicationArea = All;
                }
                field("Gross Margin"; Rec."Gross Margin")
                {
                    Editable = GrossMarginEditBool;
                    Visible = GrossMarginBool;
                    ApplicationArea = All;
                }
                field("Gross Margin %"; Rec."Gross Margin %")
                {
                    Editable = MarginEditBool;
                    Visible = MarginBool;
                    ApplicationArea = All;
                }
                field("Default Prod. Plant Code"; Rec."Default Prod. Plant Code")
                {
                    Editable = DefaultProdPlanCodeEditBool;
                    Visible = DefaultProdPlanCodeBool;
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    Editable = BaseUnitMeasureEditBool;
                    Visible = BaseUnitMeasureBool;
                    ApplicationArea = All;
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                    Editable = SalesUnitMeasureEditBool;
                    Visible = SalesUnitMeasureBool;
                    ApplicationArea = All;
                }
                field("Purch. Unit of Measure"; Rec."Purch. Unit of Measure")
                {
                    Editable = PurchUnitMeasureEditBool;
                    Visible = PurchUnitMeasureBool;
                    ApplicationArea = All;
                }
                field("Costing Method"; Rec."Costing Method")
                {
                    Editable = CostingMathodEditBool;
                    ApplicationArea = All;
                }
                field("GST Credit"; Rec."GST Credit")
                {
                    Editable = GstCreditEditBool;
                    ApplicationArea = All;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    Editable = GstGrpCodeEditBool;
                    ApplicationArea = All;
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    Editable = TaxGrpCodeEditBool;
                    ApplicationArea = All;
                }
                field("Excise Accounting Type"; Rec."Excise Accounting Type")
                {
                    Editable = ExciseAcctTypeEditBool;
                    ApplicationArea = All;
                }
                field("Default Transaction UOM"; Rec."Default Transaction UOM")
                {
                    Editable = DefaultTranUomEditBool;
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Group Code"; Rec."Group Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Replenishment System"; Rec."Replenishment System")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Excise Prod. Posting Group"; Rec."Excise Prod. Posting Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Pircture)
            {
                Caption = 'Pircture';
                action("Insert Picture")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*AttachmentRecRef.OPEN(DATABASE::Table50089);
                        AttachmentRecRef.SETPOSITION(GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;
                        AttachmentManagment.ImportAttachment(AttachmentRecID);*/

                    end;
                }
                action("Delete Picture")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*AttachmentRecRef.OPEN(DATABASE::Table50089);
                        AttachmentRecRef.SETPOSITION(GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;
                        AttachmentManagment.DeleteAttachment(AttachmentRecID);*/

                    end;
                }
                action("Export Pircture")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*AttachmentRecRef.OPEN(DATABASE::Table50089);
                        AttachmentRecRef.SETPOSITION(GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;
                        AttachmentManagment.ExportAttachment(AttachmentRecID);*/

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        MakeUnEditableNew;
    end;

    trigger OnAfterGetRecord()
    begin
        MakeUnEditableNew;
    end;

    var
        [InDataSet]
        TypeCodeBool: Boolean;
        [InDataSet]
        TypeCatCodeBool: Boolean;
        [InDataSet]
        SizeCodeBool: Boolean;
        [InDataSet]
        PackingCodeBool: Boolean;
        [InDataSet]
        QualityCodeBool: Boolean;
        [InDataSet]
        PlantCodeBool: Boolean;
        [InDataSet]
        DesignCodeBool: Boolean;
        [InDataSet]
        ColorCodeBool: Boolean;
        [InDataSet]
        GrossWeightBool: Boolean;
        [InDataSet]
        NetWeightBool: Boolean;
        [InDataSet]
        ItemClassBool: Boolean;
        [InDataSet]
        GSTGroupCodeBool: Boolean;
        [InDataSet]
        HSNCodeBool: Boolean;
        [InDataSet]
        SchemeGroupBool: Boolean;
        [InDataSet]
        GroupCodeBool: Boolean;
        DiscountGrpBool: Boolean;
        OriginatorBool: Boolean;
        NPDBool: Boolean;
        TableauProdGrpBool: Boolean;
        ManufStrategyBool: Boolean;
        COGSBool: Boolean;
        DefaultProdPlanCodeBool: Boolean;
        AttachmentRecRef: RecordRef;
        AttachmentRecID: RecordID;
        [InDataSet]
        TypeCodeEditBool: Boolean;
        [InDataSet]
        TypeCatCodeEditBool: Boolean;
        [InDataSet]
        SizeCodeEditBool: Boolean;
        [InDataSet]
        PackingCodeEditBool: Boolean;
        [InDataSet]
        QualityCodeEditBool: Boolean;
        [InDataSet]
        PlantCodeEditBool: Boolean;
        [InDataSet]
        DesignCodeEditBool: Boolean;
        [InDataSet]
        ColorCodeEditBool: Boolean;
        [InDataSet]
        GrossWeightEditBool: Boolean;
        [InDataSet]
        NetWeightEditBool: Boolean;
        [InDataSet]
        ItemClassEditBool: Boolean;
        [InDataSet]
        HSNCodeEditBool: Boolean;
        [InDataSet]
        SchemeGroupEditBool: Boolean;
        [InDataSet]
        GroupCodeEditBool: Boolean;
        DiscountGrpEditBool: Boolean;
        OriginatorEditBool: Boolean;
        NPDEditBool: Boolean;
        TableauProdGrpEditBool: Boolean;
        ManufStrategyEditBool: Boolean;
        COGSEditBool: Boolean;
        DefaultProdPlanCodeEditBool: Boolean;
        ItemCreation: Record "Item Creation";
        BaseUnitMeasureBool: Boolean;
        SalesUnitMeasureBool: Boolean;
        PurchUnitMeasureBool: Boolean;
        BaseUnitMeasureEditBool: Boolean;
        SalesUnitMeasureEditBool: Boolean;
        PurchUnitMeasureEditBool: Boolean;
        CostingMathodEditBool: Boolean;
        GstCreditEditBool: Boolean;
        GstGrpCodeEditBool: Boolean;
        TaxGrpCodeEditBool: Boolean;
        ExciseAcctTypeEditBool: Boolean;
        DefaultTranUomEditBool: Boolean;
        RecUserSetup: Record "User Setup";
        TypCod: Boolean;
        MarginEditBool: Boolean;
        MarginBool: Boolean;
        ListPriceBool: Boolean;
        ListPriceEditBool: Boolean;
        ADBool: Boolean;
        ADEditBool: Boolean;
        ASPBool: Boolean;
        ASPEditBool: Boolean;
        GrossMarginBool: Boolean;
        GrossMarginEditBool: Boolean;
        ProjectNameBool: Boolean;
        ProjectNameEditBool: Boolean;
        VariableCostBool: Boolean;
        VariableCostEditBool: Boolean;
        FCBool: Boolean;
        FCEditBool: Boolean;
        SVBool: Boolean;
        SVEditBool: Boolean;
        NetMarginBool: Boolean;
        NetMarginEditBool: Boolean;
        NetMarginperBool: Boolean;
        NetMarginperEditBool: Boolean;

    local procedure MakeUnEditableNew()
    var
        UserIDAuth1: Code[50];
    begin

        //  For Visibility
        TypeCodeBool := FALSE;
        TypeCatCodeBool := FALSE;
        SizeCodeBool := FALSE;
        PackingCodeBool := FALSE;
        QualityCodeBool := FALSE;
        PlantCodeBool := FALSE;
        GroupCodeBool := FALSE;
        DesignCodeBool := FALSE;
        ColorCodeBool := FALSE;
        GrossWeightBool := FALSE;
        NetWeightBool := FALSE;
        ItemClassBool := FALSE;
        GSTGroupCodeBool := FALSE;
        HSNCodeBool := FALSE;
        SchemeGroupBool := FALSE;
        DiscountGrpBool := FALSE;
        OriginatorBool := FALSE;
        NPDBool := FALSE;
        TableauProdGrpBool := FALSE;
        ManufStrategyBool := FALSE;
        COGSBool := FALSE;
        DefaultProdPlanCodeBool := FALSE;
        BaseUnitMeasureBool := FALSE;
        SalesUnitMeasureBool := FALSE;
        PurchUnitMeasureBool := FALSE;
        MarginBool := FALSE;
        ListPriceBool := FALSE;
        ADBool := FALSE;
        ASPBool := FALSE;
        GrossMarginBool := FALSE;
        ProjectNameBool := FALSE;
        VariableCostBool := FALSE;
        FCBool := FALSE;
        SVBool := FALSE;
        NetMarginBool := FALSE;
        NetMarginperBool := FALSE;

        //For Editable
        GrossWeightEditBool := FALSE;
        NetWeightEditBool := FALSE;
        DesignCodeEditBool := FALSE;
        ColorCodeEditBool := FALSE;
        ItemClassEditBool := FALSE;
        HSNCodeEditBool := FALSE;
        SchemeGroupEditBool := FALSE;
        GroupCodeEditBool := FALSE;
        TypeCodeEditBool := FALSE;
        TypeCatCodeEditBool := FALSE;
        SizeCodeEditBool := FALSE;
        PackingCodeEditBool := FALSE;
        QualityCodeEditBool := FALSE;
        PlantCodeEditBool := FALSE;
        DiscountGrpEditBool := FALSE;
        OriginatorEditBool := FALSE;
        NPDEditBool := FALSE;
        TableauProdGrpEditBool := FALSE;
        ManufStrategyEditBool := FALSE;
        COGSEditBool := FALSE;
        DefaultProdPlanCodeEditBool := FALSE;
        BaseUnitMeasureEditBool := FALSE;
        SalesUnitMeasureEditBool := FALSE;
        PurchUnitMeasureEditBool := FALSE;
        CostingMathodEditBool := FALSE;
        GstCreditEditBool := FALSE;
        GstGrpCodeEditBool := FALSE;
        TaxGrpCodeEditBool := FALSE;
        ExciseAcctTypeEditBool := FALSE;
        DefaultTranUomEditBool := FALSE;
        MarginEditBool := FALSE;
        ListPriceEditBool := FALSE;
        ADEditBool := FALSE;
        ASPEditBool := FALSE;
        GrossMarginEditBool := FALSE;
        ProjectNameEditBool := FALSE;
        VariableCostEditBool := FALSE;
        SVEditBool := FALSE;
        FCEditBool := FALSE;
        NetMarginEditBool := FALSE;
        NetMarginperEditBool := FALSE;

        MakeVisible();

        // For User 1

        IF ItemCreation.GET(Rec."No.") THEN BEGIN
            RecUserSetup.GET(ItemCreation."User ID");

            //Visibility Boolean

            IF (USERID = ItemCreation."User ID") OR (USERID = RecUserSetup."Item Authorization 3") THEN BEGIN
                TypeCodeBool := TRUE;
                TypeCatCodeBool := TRUE;
                SizeCodeBool := TRUE;
                DesignCodeBool := TRUE;
                ColorCodeBool := TRUE;
                PackingCodeBool := TRUE;
                QualityCodeBool := TRUE;
                PlantCodeBool := TRUE;
                NPDBool := TRUE;
            END;

            // Editable Boolean
            IF ((ItemCreation.Status IN [ItemCreation.Status::" "]) AND (USERID = ItemCreation."User ID")) OR
                 ((ItemCreation.Status IN [ItemCreation.Status::Authorization3]) AND (USERID = RecUserSetup."Item Authorization 3")) THEN BEGIN

                TypeCodeEditBool := TRUE;
                TypeCatCodeEditBool := TRUE;
                SizeCodeEditBool := TRUE;
                DesignCodeEditBool := TRUE;
                ColorCodeEditBool := TRUE;
                PackingCodeEditBool := TRUE;
                QualityCodeEditBool := TRUE;
                PlantCodeEditBool := TRUE;
                NPDEditBool := TRUE;
            END;
        END;

        // For User 2
        ItemCreation.RESET;
        IF ItemCreation.GET(Rec."No.") THEN BEGIN
            ItemCreation.TESTFIELD("Operation unit");
            RecUserSetup.GET(ItemCreation."User ID");
            IF ItemCreation."Operation unit" = ItemCreation."Operation unit"::DRA THEN BEGIN
                RecUserSetup.TESTFIELD("Item Authorization DRA 1");
                UserIDAuth1 := RecUserSetup."Item Authorization DRA 1";
            END
            ELSE
                IF ItemCreation."Operation unit" = ItemCreation."Operation unit"::HSK THEN BEGIN
                    RecUserSetup.TESTFIELD("Item Authorization HSK 1");
                    UserIDAuth1 := RecUserSetup."Item Authorization HSK 1";
                END
                ELSE
                    IF ItemCreation."Operation unit" = ItemCreation."Operation unit"::SKD THEN BEGIN
                        RecUserSetup.TESTFIELD("Item Authorization SKD 1");
                        UserIDAuth1 := RecUserSetup."Item Authorization SKD 1";
                    END
                    ELSE
                        IF ItemCreation."Operation unit" = ItemCreation."Operation unit"::WZ THEN BEGIN
                            RecUserSetup.TESTFIELD("Item Authorization WZ 1");
                            UserIDAuth1 := RecUserSetup."Item Authorization WZ 1";
                        END;

            //Visibility Boolean
            IF (USERID = UserIDAuth1) OR (USERID = RecUserSetup."Item Authorization 3") THEN BEGIN
                GrossWeightBool := TRUE;
                NetWeightBool := TRUE;
                BaseUnitMeasureBool := TRUE;
                SalesUnitMeasureBool := TRUE;
                PurchUnitMeasureBool := TRUE;
                DefaultProdPlanCodeBool := TRUE;
                PackingCodeBool := TRUE;
                COGSBool := TRUE;
            END;

            // Editable Boolean
            IF ((ItemCreation.Status IN [ItemCreation.Status::Authorization1]) AND (USERID = UserIDAuth1)) OR
                  ((ItemCreation.Status IN [ItemCreation.Status::Authorization3]) AND (USERID = RecUserSetup."Item Authorization 3")) THEN BEGIN

                GrossWeightEditBool := TRUE;
                NetWeightEditBool := TRUE;
                BaseUnitMeasureEditBool := TRUE;
                SalesUnitMeasureEditBool := TRUE;
                PurchUnitMeasureEditBool := TRUE;
                DefaultProdPlanCodeEditBool := TRUE;
                PackingCodeEditBool := TRUE;
                COGSEditBool := TRUE;
            END;
        END;

        // For User 3
        ItemCreation.RESET;
        IF ItemCreation.GET(Rec."No.") THEN BEGIN

            //Visibility Boolean
            IF (USERID = RecUserSetup."Item Authorization 2") OR (USERID = RecUserSetup."Item Authorization 3") THEN BEGIN
                ItemClassBool := TRUE;
                COGSBool := TRUE;
                TableauProdGrpBool := TRUE;
                MarginBool := TRUE;
                ADBool := TRUE;
                ASPBool := TRUE;
                GrossMarginBool := TRUE;
                ProjectNameBool := TRUE;
                ManufStrategyBool := TRUE;
                VariableCostBool := TRUE;
                ManufStrategyBool := TRUE;
                HSNCodeBool := TRUE;
                ListPriceBool := TRUE;
                SVBool := TRUE;
                FCBool := TRUE;
                NetMarginBool := TRUE;
                NetMarginperBool := TRUE;
            END;

            // Editable Boolean
            IF ((ItemCreation.Status IN [ItemCreation.Status::Authorization2]) AND (USERID = RecUserSetup."Item Authorization 2")) OR
                  ((ItemCreation.Status IN [ItemCreation.Status::Authorization3]) AND (USERID = RecUserSetup."Item Authorization 3")) THEN BEGIN
                ItemClassEditBool := TRUE;
                TypeCodeEditBool := TRUE;
                TypeCatCodeBool := TRUE;
                TypeCatCodeEditBool := TRUE;
                COGSEditBool := TRUE;
                TableauProdGrpEditBool := TRUE;
                MarginEditBool := TRUE;
                ADEditBool := TRUE;
                ASPEditBool := TRUE;
                GrossMarginEditBool := TRUE;
                ProjectNameEditBool := TRUE;
                ManufStrategyEditBool := TRUE;
                VariableCostEditBool := TRUE;
                ManufStrategyEditBool := TRUE;
                HSNCodeEditBool := TRUE;
                SVEditBool := TRUE;
                FCEditBool := TRUE;
                NetMarginEditBool := TRUE;
                NetMarginperEditBool := TRUE;
            END;
        END;

        //MESSAGE('%1',GrossWeightEditBool);
    end;

    local procedure MakeVisible()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        IF ItemCreation.GET(Rec."No.") THEN
            EXIT;

        //Visibility Boolean
        IF UserSetup.GET(USERID) THEN BEGIN
            IF UserSetup."Allow TO Release" THEN BEGIN
                TypeCodeBool := TRUE;
                TypeCatCodeBool := TRUE;
                SizeCodeBool := TRUE;
                DesignCodeBool := TRUE;
                ColorCodeBool := TRUE;
                PackingCodeBool := TRUE;
                QualityCodeBool := TRUE;
                PlantCodeBool := TRUE;
                NPDBool := TRUE;
            END;
        END;
    end;
}

