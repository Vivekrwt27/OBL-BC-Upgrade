pageextension 50445 pageextension50445 extends "Revaluation Journal"
{
    layout
    {
        /* modify("Control 2")
         {
             Visible = false;
         }*/
        addfirst(Control1)

        {
            /*16225  field("Posting Date"; Rec."Posting Date")
              {
                  Editable = true;
              }*/
            field("Entry Type"; Rec."Entry Type")
            {
                ApplicationArea = All;
            }
            field("Source Code"; Rec."Source Code")
            {
                ApplicationArea = All;
            }
            field("Value Entry Type"; Rec."Value Entry Type")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document No.")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        addafter("External Document No.")
        {
            field("Inventory Posting Group"; Rec."Inventory Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Calculate Inventory Value")
        {
            action("Insert ILE")
            {
                Caption = 'Insert ILE';
                ApplicationArea = All;
                //  RunObject = Report 66001;
            }
            action("Insert Entries to Reval")
            {
                Caption = 'Insert Entry to Reval';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
            }
            action(Update)
            {
                Caption = 'Update';
                ApplicationArea = All;

                trigger OnAction()
                var
                    WeightedAvg: Record "LC Detail for Export";
                    AvgCost: Decimal;
                begin
                    /*
                    LineNo:=1000;
                    tgWin.OPEN(tgText001);
                    WeightedAvg.RESET;
                    WeightedAvg.SETFILTER(Posted,'%1',FALSE);
                    IF WeightedAvg.FINDFIRST THEN BEGIN
                      REPEAT
                        tgItemJournlLine.INIT;
                        tgItemJournlLine."Journal Template Name" := "Journal Template Name";
                        tgItemJournlLine."Journal Batch Name" := "Journal Batch Name";
                        tgItemJournlLine."Document No." := 'REV01092019-001';
                        tgItemJournlLine."Line No." := LineNo;
                        tgItemJournlLine."Item No." := WeightedAvg."Entry No";
                        tgItemJournlLine."Location Code" := WeightedAvg."Location Code";
                       // tgItemJournlLine.Quantity := WeightedAvg."Remaining Quantity";
                        tgItemJournlLine.SetUpNewLine(tgItemJournlLine);
                    //    tgItemJournlLine."Value Entry Type" := tgItemJournlLine."Value Entry Type"::Revaluation;
                    //    tgItemJournlLine."Entry Type" := tgItemJournlLine."Entry Type"::"Positive Adjmt.";
                    
                        tgItemJournlLine.INSERT(TRUE);
                        tgItemJournlLine.VALIDATE("Applies-to Entry",WeightedAvg."Entry No.");
                        tgItemJournlLine.VALIDATE(Quantity,WeightedAvg.Quantity);
                        tgItemJournlLine."Posting Date" := TODAY;
                        tgItemJournlLine.MODIFY;
                        LineNo +=1000;
                        tgWin.UPDATE(1,tgItemJournlLine."Line No.");
                      UNTIL WeightedAvg.NEXT=0;
                    END;
                    tgWin.CLOSE;
                    tgWin.OPEN(tgText001);
                      tgItemJournlLine.RESET;
                      tgItemJournlLine.SETRANGE(tgItemJournlLine."Journal Template Name","Journal Template Name");
                      tgItemJournlLine.SETRANGE(tgItemJournlLine."Journal Batch Name","Journal Batch Name");
                      //tgItemJournlLine.SETRANGE(tgItemJournlLine."Inventory Value (Revalued)",0);
                      IF tgItemJournlLine.FIND('-') THEN
                        REPEAT
                          AvgCost := CalculateAvgCost(tgItemJournlLine."Item No.",tgItemJournlLine."Location Code");
                          tgItemJournlLine.VALIDATE(tgItemJournlLine."Unit Cost (Revalued)",AvgCost);
                          tgItemJournlLine.MODIFY(TRUE);
                        tgWin.UPDATE(1,tgItemJournlLine."Line No.");
                        UNTIL tgItemJournlLine.NEXT = 0;
                    
                      tgWin.CLOSE;
                    
                    CurrPage.UPDATE;
                    CurrPage.SAVERECORD;
                    */

                end;
            }
        }
        addafter("Post and &Print")
        {
            action("Update Rate")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    TempUpdate: Record "LC Detail for Export";
                    ItemJournalLine: Record "Item Journal Line";
                begin
                    ItemJournalLine.RESET;
                    ItemJournalLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    ItemJournalLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    IF ItemJournalLine.FINDFIRST THEN
                        REPEAT
                            IF TempUpdate.GET(ItemJournalLine."Applies-to Entry") THEN BEGIN
                                //16225 ItemJournalLine.VALIDATE("Unit Cost (Revalued)", TempUpdate."LC Date");
                                ItemJournalLine.MODIFY;
                            END ELSE BEGIN
                                ItemJournalLine.DELETE;
                            END;
                        UNTIL ItemJournalLine.NEXT = 0;
                end;
            }
        }
    }

    var
        tgItemJournlLine: Record "Item Journal Line";
        tgWin: Dialog;
        tgText001: Label 'Line No #1##############';
        LineNo: Integer;

    local procedure CalculateAvgCost(ItemNo: Code[20]; Location: Code[20]): Decimal
    var
        // InventoryValuation: Query "Avg Rate Calc";
        ValueCost: Decimal;
        Qty: Decimal;
    begin
        /*
        CLEAR(InventoryValuation);
        InventoryValuation.SETFILTER(InventoryValuation.Item_No,ItemNo);
        //InventoryValuation.SETFILTER(InventoryValuation.Variant_Code,VariantNo);
        InventoryValuation.SETFILTER(InventoryValuation.Location_Code,Location);
        InventoryValuation.OPEN;
        WHILE InventoryValuation.READ DO BEGIN
          ValueCost+= (InventoryValuation.Sum_Cost_Amount_Actual+InventoryValuation.Sum_Cost_Amount_Expected);
          Qty += InventoryValuation.Sum_Quantity;
        END;
        
        IF ROUND(Qty,0.01,'=')<>0 THEN
          EXIT(ValueCost/ROUND(Qty,0.01,'='));
          */

    end;
}

