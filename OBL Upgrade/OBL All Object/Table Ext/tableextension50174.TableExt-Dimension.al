tableextension 50174 tableextension50174 extends Dimension
{
    procedure CheckIfItemDimUsed(DimChecked: Code[20]; DimTypeChecked: Option " ",ItemAnalysis1,ItemAnalysis2,ItemAnalysis3,ItemAnalysis4; ItemAnalysisViewChecked: Code[10]): Boolean
    var
        GLSetup: Record "General Ledger Setup";
        InventorySetup: Record "Inventory Setup";
        CheckItemAnalysisViewDim: Boolean;
        ItemAnalysisView: Record "Item Analysis View";
    begin
        //mo tri1.0 customization no. 21 start
        IF DimChecked = '' THEN
            EXIT;

        CheckItemAnalysisViewDim := DimTypeChecked IN [DimTypeChecked::ItemAnalysis1, DimTypeChecked::ItemAnalysis2,
        DimTypeChecked::ItemAnalysis3, DimTypeChecked::ItemAnalysis4];
        /// UsedAsItemAnalysisViewDim := FALSE;

        IF CheckItemAnalysisViewDim THEN BEGIN
            IF ItemAnalysisViewChecked <> '' THEN
                ItemAnalysisView.SETRANGE(Code, ItemAnalysisViewChecked);

            IF ItemAnalysisView.FIND('-') THEN BEGIN
                /* REPEAT
                     IF (DimTypeChecked <> DimTypeChecked::ItemAnalysis1) AND
                        (DimChecked = ItemAnalysisView."Dimension 1 Code")
                     THEN
                         UsedAsItemAnalysisViewDim := TRUE;
                     IF (DimTypeChecked <> DimTypeChecked::ItemAnalysis2) AND
                        (DimChecked = ItemAnalysisView."Dimension 2 Code")
                     THEN
                         UsedAsItemAnalysisViewDim := TRUE;
                     IF (DimTypeChecked <> DimTypeChecked::ItemAnalysis3) AND
                        (DimChecked = ItemAnalysisView."Dimension 3 Code")
                     THEN
                         UsedAsItemAnalysisViewDim := TRUE;
                     IF (DimTypeChecked <> DimTypeChecked::ItemAnalysis4) AND
                        (DimChecked = ItemAnalysisView."Dimension 4 Code")
                     THEN
                         UsedAsItemAnalysisViewDim := TRUE;

                 UNTIL ItemAnalysisView.NEXT = 0;*/
            END;
        END;

        /*   IF UsedAsItemAnalysisViewDim
           THEN BEGIN
               MakeCheckDimErr;
               EXIT(TRUE);
           END ELSE
               EXIT(FALSE);*/
        //mo tri1.0 customization no. 21 end
    end;
}

