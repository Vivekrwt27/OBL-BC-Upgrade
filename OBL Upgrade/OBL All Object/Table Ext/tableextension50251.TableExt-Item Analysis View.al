tableextension 50251 tableextension50251 extends "Item Analysis View"
{
    fields
    {

        //Unsupported feature: Property Modification (Editable) on ""Last Entry No."(Field 4)".

        field(50000; "Dimension 4 Code"; Code[20])
        {
            Caption = 'Dimension 4 Code';
            Description = 'TRIRJ ADDED';
            TableRelation = Dimension;

            trigger OnValidate()
            var
                Dim: Record Dimension;
                Text000: Label '%1\You cannot use the same dimension twice in the same analysis view';
            begin
                TESTFIELD(Blocked, FALSE);
                IF Dim.CheckIfItemDimUsed("Dimension 4 Code", 4, Code) THEN
                    ERROR(Text000, Dim.GetCheckDimErr);
                ModifyDim(FIELDCAPTION("Dimension 4 Code"), "Dimension 4 Code", xRec."Dimension 4 Code");
                MODIFY;
            end;
        }
    }

    local procedure ModifyDim(DimFieldName: Text[100]; DimValue: Code[20]; xDimValue: Code[20])// 15578
    var
        ItemAnalysisViewEntry: record "Item Analysis View Entry";
    begin
        /* IF ("Last Entry No." <> 0) AND (DimValue <> xDimValue) THEN BEGIN
             IF DimValue <> '' THEN BEGIN
                 ValidateDelete(DimFieldName);
                 ItemAnalysisViewReset;
             END;
             IF DimValue = '' THEN BEGIN
                 ValidateModify(DimFieldName);
                 CASE DimFieldName OF
                     FIELDCAPTION("Dimension 1 Code"):
                         BEGIN
                             ItemAnalysisViewEntry.SETFILTER("Dimension 1 Value Code", '<>%1', '');
                             ItemAnalysisViewBudgetEntry.SETFILTER("Dimension 1 Value Code", '<>%1', '');
                         END;
                     FIELDCAPTION("Dimension 2 Code"):
                         BEGIN
                             ItemAnalysisViewEntry.SETFILTER("Dimension 2 Value Code", '<>%1', '');
                             ItemAnalysisViewBudgetEntry.SETFILTER("Dimension 2 Value Code", '<>%1', '');
                         END;
                     FIELDCAPTION("Dimension 3 Code"):
                         BEGIN
                             ItemAnalysisViewEntry.SETFILTER("Dimension 3 Value Code", '<>%1', '');
                             ItemAnalysisViewBudgetEntry.SETFILTER("Dimension 3 Value Code", '<>%1', '');
                         END;
                 END;
                 ItemAnalysisViewEntry.SETRANGE("Analysis Area", "Analysis Area");
                 ItemAnalysisViewEntry.SETRANGE("Analysis View Code", Code);
                 ItemAnalysisViewBudgetEntry.SETRANGE("Analysis Area", "Analysis Area");
                 ItemAnalysisViewBudgetEntry.SETRANGE("Analysis View Code", Code);
                 IF ItemAnalysisViewEntry.FIND('-') THEN
                     REPEAT
                         ItemAnalysisViewEntry.DELETE;
                         NewItemAnalysisViewEntry := ItemAnalysisViewEntry;
                         CASE DimFieldName OF
                             FIELDCAPTION("Dimension 1 Code"):
                                 NewItemAnalysisViewEntry."Dimension 1 Value Code" := '';
                             FIELDCAPTION("Dimension 2 Code"):
                                 NewItemAnalysisViewEntry."Dimension 2 Value Code" := '';
                             FIELDCAPTION("Dimension 3 Code"):
                                 NewItemAnalysisViewEntry."Dimension 3 Value Code" := '';
                         END;
                         InsertItemAnalysisViewEntry;
                     UNTIL ItemAnalysisViewEntry.NEXT = 0;
                 IF ItemAnalysisViewBudgetEntry.FIND('-') THEN
                     REPEAT
                         ItemAnalysisViewBudgetEntry.DELETE;
                         NewItemAnalysisViewBudgetEntry := ItemAnalysisViewBudgetEntry;
                         CASE DimFieldName OF
                             FIELDCAPTION("Dimension 1 Code"):
                                 NewItemAnalysisViewBudgetEntry."Dimension 1 Value Code" := '';
                             FIELDCAPTION("Dimension 2 Code"):
                                 NewItemAnalysisViewBudgetEntry."Dimension 2 Value Code" := '';
                             FIELDCAPTION("Dimension 3 Code"):
                                 NewItemAnalysisViewBudgetEntry."Dimension 3 Value Code" := '';
                         END;
                         InsertAnalysisViewBudgetEntry;
                     UNTIL ItemAnalysisViewBudgetEntry.NEXT = 0;
             END;
         END;*///15578

    end;

}

