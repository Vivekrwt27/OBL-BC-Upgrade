tableextension 50228 tableextension50228 extends "Value Entry"
{
    fields
    {
        field(50000; ReProcess; Boolean)
        {
            Description = 'TRI S.C. 09.06.10';
        }
        field(50004; "Create Post VE Entry"; Boolean)
        {

            trigger OnValidate()
            begin
                /*
                IF "Create Post VE Entry" THEN
                PostVE.RESET;
                PostVE.SETRANGE("Value Entry No.","Entry No.");
                PostVE.SETRANGE("Item No.","Item No.");
                PostVE.SETRANGE("Posting Date","Posting Date");
                IF NOT PostVE.FINDFIRST THEN BEGIN
                  PostVE."Value Entry No.":="Entry No.";
                  PostVE."Item No.":="Item No.";
                  PostVE."Posting Date":="Posting Date";
                  PostVE.INSERT;
                  IF RecItem.GET("Item No.") THEN BEGIN
                    RecItem."Cost is Adjusted" :=FALSE;
                    RecItem.MODIFY;
                  END;
                END;
                "Cost per Unit" := "Cost Amount (Actual)"/ "Valued Quantity";
                {
                IF "Create Post VE Entry" THEN BEGIN
                
                  ItemApplnEntry.LOCKTABLE;
                  IF NOT ItemApplnEntry.FIND('+') THEN
                    EXIT;
                  ItemLedgEntry.LOCKTABLE;
                  IF NOT ItemLedgEntry.FIND('+') THEN
                    EXIT;
                  AvgCostAdjmtEntryPoint.LOCKTABLE;
                  IF AvgCostAdjmtEntryPoint.FIND('+') THEN;
                  ValueEntry.LOCKTABLE;
                  IF NOT ValueEntry.FIND('+') THEN
                    EXIT;
                
                    Item.SETFILTER("No.","Item No.");
                
                  InvtAdjmt.SetProperties(FALSE,PostToGL);
                  InvtAdjmt.SetFilterItem(Item);
                  InvtAdjmt.MakeMultiLevelAdjmt;
                
                  UpdateItemAnalysisView.UpdateAll(0,TRUE);
                END;
                }
                */

            end;
        }
        field(50060; "OutPut Date"; Date)
        {
            Description = 'TRI S.K 21.06.10';
        }
        field(60010; "Direct Consumption Entries"; Boolean)
        {
            CalcFormula = Lookup("Item Ledger Entry"."Direct Consumption Entries" WHERE("Entry No." = FIELD("Item Ledger Entry No.")));
            FieldClass = FlowField;
        }
        field(60013; "Re Process Production Order"; Boolean)
        {
            Description = 'TRI S.K 23.06.10 Add New Field';
        }
        field(60014; "Work Shift Code"; Code[20])
        {
            Description = 'TRI S.K 23.06.10 Add New Field';
        }
        field(60015; "Original Prod. No"; Code[20])
        {
            Description = 'TRI S.K 23.06.10 Add New Field';
        }
        field(60021; "Item Base Unit of Measure"; Code[10])
        {
            CalcFormula = Lookup(Item."Base Unit of Measure" WHERE("No." = FIELD("Item No.")));
            Description = 'TRI S.R';
            Editable = true;
            FieldClass = FlowField;
        }
        field(60022; "Machine Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('MACHINE'));
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Item Ledger Entry Type,Location Code,Order Type,Order No.,Order Line No.,Source Type,Source No."(Key)".

        key(Key19; "Item Ledger Entry Type", "Location Code", "Order Type", "Order No.", "Order Line No.", "Source Type", "Source No.", "Item No.")
        {
            SumIndexFields = "Cost Amount (Actual)", "Cost Amount (Actual) (ACY)";
        }
        key(Key20; "Item Ledger Entry No.", "Source Code")
        {
            SumIndexFields = "Cost Amount (Actual)";
        }
        key(Key21; "Item No.", "Inventory Posting Group", "Posting Date")
        {
        }
        key(Key22; "Item Ledger Entry No.", "Expected Cost", "Valuation Date")
        {
        }
        key(Key23; "Item Ledger Entry No.", "Expected Cost", "Document No.", "Partial Revaluation", "Entry Type", "Variance Type", Adjustment)
        {
        }
        key(Key24; "Inventory Posting Group", "Item No.", "Posting Date", "Item Ledger Entry Type", "Expected Cost", "Location Code")
        {
            SumIndexFields = "Cost Amount (Actual)";
        }
        key(Key25; "Item Ledger Entry Type", "Item Ledger Entry No.", "Item Charge No.")
        {
        }
        key(Key26; "Posting Date")
        {
        }
        key(Key27; "Item Ledger Entry Type", "Inventory Posting Group", "Posting Date", "Location Code")
        {
            SumIndexFields = "Cost Amount (Actual)", "Cost Amount (Expected)";
        }
        key(Key28; "Item No.", "Item Ledger Entry Type", "Posting Date", "Location Code")
        {
        }
    }

    var
        PostVE: Record "Post Value Entry to G/L";
        RecItem: Record Item;
        ItemApplnEntry: Record "Item Application Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        AvgCostAdjmtEntryPoint: Record "Avg. Cost Adjmt. Entry Point";
        ValueEntry: Record "Value Entry";
        Item: Record Item;
        UpdateItemAnalysisView: Codeunit "Update Item Analysis View";
        InvtAdjmt: Codeunit "Inventory Adjustment";
        PostToGL: Boolean;
        [InDataSet]
        PostEnable: Boolean;
}

