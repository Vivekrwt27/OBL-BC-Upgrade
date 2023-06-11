codeunit 50096 "Update ILEDim"
{

    trigger OnRun()
    begin
        GenSetup.GET;
        InventorySetup.GET;

        i := 0;
        j := 0;
        k := 0;
        l := 0;
        m := 0;

        Window.OPEN('Item Ledger Entry No. ##########1#\' +
                    'ILE Location Dim      ##########2#\' +
                    'ILE State Dim         ##########3#\' +
                    'ILE Item Dim          ##########4#\\' +
                    'Value Entry No.       ##########5#\' +
                    'VE Location Dim       ##########6#\' +
                    'ILE State Dim         ##########7#\' +
                    'VE Item Dim           ##########8#', ILE."Entry No.", i, m, j, VE."Entry No.", k, n, l);


        //Item Ledger Entries
        ILE.RESET;
        IF ILE.FIND('-') THEN
            REPEAT
                a := FALSE;
                /*
                IF NOT LED.GET(DATABASE::"Item Ledger Entry",ILE."Entry No.",GenSetup."Location Dimension Code") THEN
                  IF LocationRec.GET(ILE."Relational Location Code") THEN BEGIN
                    LED."Table ID" := DATABASE::"Item Ledger Entry";
                    LED."Entry No." := ILE."Entry No.";
                    LED."Dimension Code" := GenSetup."Location Dimension Code";
                    LED."Dimension Value Code" := LocationRec."Location Dimension";
                    LED.INSERT;
                    i := i + 1;
                  END;

                IF ILE."Entry Type" = ILE."Entry Type"::Transfer THEN
                  IF NOT LED.GET(DATABASE::"Item Ledger Entry",ILE."Entry No.",GenSetup."State Dimension Code") THEN BEGIN
                    IF LocationRec.GET(ILE."Relational Location Code") THEN
                      IF StateRec.GET(LocationRec."State Code") THEN BEGIN
                        LED."Table ID" := DATABASE::"Item Ledger Entry";
                        LED."Entry No." := ILE."Entry No.";
                        LED."Dimension Code" := GenSetup."State Dimension Code";
                        LED."Dimension Value Code" := StateRec.Dimension;
                        LED.INSERT;
                        m := m + 1;
                    END;
                END ELSE BEGIN
                  ILENoTransferNoDim."Entry No." := ILE."Entry No.";
                  ILENoTransferNoDim."Item No."  := ILE."Item No.";
                  ILENoTransferNoDim."Posting Date" := ILE."Posting Date";
                  ILENoTransferNoDim."Entry Type"  := ILE."Entry Type";
                  ILENoTransferNoDim."Source No." := ILE."Source No.";
                  ILENoTransferNoDim."Document No." := ILE."Document No.";
                  ILENoTransferNoDim.Description := ILE.Description;
                  ILENoTransferNoDim."Location Code" := ILE."Location Code";
                  ILENoTransferNoDim.Quantity := ILE.Quantity;
                  ILENoTransferNoDim."Remaining Quantity" := ILE."Remaining Quantity";
                  ILENoTransferNoDim."Invoiced Quantity"  := ILE."Invoiced Quantity";
                  ILENoTransferNoDim."Applies-to Entry"  := ILE."Applies-to Entry";
                  ILENoTransferNoDim.Open := ILE.Open;
                  ILENoTransferNoDim."Source Type" := ILE."Source Type";
                  ILENoTransferNoDim.INSERT;
                END; */


                DefDim.RESET;
                DefDim.SETFILTER(DefDim."Table ID", '%1', DATABASE::Item);
                DefDim.SETFILTER(DefDim."No.", '%1', ILE."Item No.");
                IF DefDim.FIND('-') THEN
                    REPEAT
                    /*IF NOT LED.GET(DATABASE::"Item Ledger Entry",ILE."Entry No.",DefDim."Dimension Code") THEN BEGIN
                      LED."Table ID" := DATABASE::"Item Ledger Entry";
                      LED."Entry No." := ILE."Entry No.";
                      LED."Dimension Code" := DefDim."Dimension Code";
                      LED."Dimension Value Code" := DefDim."Dimension Value Code";
                      LED.INSERT;
                      a := TRUE;
                    END;        */
                    UNTIL DefDim.NEXT = 0;

                IF a THEN
                    j := j + 1;
                Window.UPDATE;

            UNTIL ILE.NEXT = 0;

        COMMIT;

        /*
        //Value Entries
        VE.RESET;
        IF VE.FIND('-') THEN
          REPEAT
        
            a := FALSE;
        
            IF ILE.GET(VE."Item Ledger Entry No.") THEN
              IF NOT LED.GET(DATABASE::"Value Entry",VE."Entry No.",GenSetup."Location Dimension Code") THEN
                IF LocationRec.GET(ILE."Relational Location Code") THEN BEGIN
                  LED."Table ID" := DATABASE::"Value Entry";
                  LED."Entry No." := VE."Entry No.";
                  LED."Dimension Code" := GenSetup."Location Dimension Code";
                  LED."Dimension Value Code" := LocationRec."Location Dimension";
                  LED.INSERT;
                  k := k + 1;
                END;
        
            IF ILE.GET(VE."Item Ledger Entry No.") THEN
              IF ILE."Entry Type" = ILE."Entry Type"::Transfer THEN
                IF NOT LED.GET(DATABASE::"Value Entry",VE."Entry No.",GenSetup."State Dimension Code") THEN begin
                  IF LocationRec.GET(ILE."Relational Location Code") THEN
                    IF StateRec.GET(LocationRec.State) THEN BEGIN
                      LED."Table ID" := DATABASE::"Item Ledger Entry";
                      LED."Entry No." := ILE."Entry No.";
                      LED."Dimension Code" := GenSetup."State Dimension Code";
                      LED."Dimension Value Code" := StateRec.Dimension;
                      LED.INSERT;
                      n := n + 1;
                    END;
            END ELSE BEGIN
              ILENoTransferNoDim."Value Entry" := TRUE;
              ILENoTransferNoDim."Entry No." := VE."Entry No.";
              ILENoTransferNoDim."Item No."  := VE."Item No.";
              ILENoTransferNoDim."Posting Date" := VE."Posting Date";
              ILENoTransferNoDim."Entry Type"  := VE."Entry Type";
              ILENoTransferNoDim."Source No." := VE."Source No.";
              ILENoTransferNoDim."Document No." := VE."Document No.";
              ILENoTransferNoDim.Description := VE.Description;
              ILENoTransferNoDim."Location Code" := VE."Location Code";
              ILENoTransferNoDim."Source Type" := VE."Source Type";
              ILENoTransferNoDim.INSERT;
            END;
        
        
            DefDim.RESET;
            DefDim.SETFILTER(DefDim."Table ID",'%1',DATABASE::Item);
            DefDim.SETFILTER(DefDim."No.",'%1',VE."Item No.");
            IF DefDim.FIND('-') THEN REPEAT
              IF NOT LED.GET(DATABASE::"Value Entry",VE."Entry No.",DefDim."Dimension Code") THEN BEGIN
                LED."Table ID" := DATABASE::"Value Entry";
                LED."Entry No." := VE."Entry No.";
                LED."Dimension Code" := DefDim."Dimension Code";
                LED."Dimension Value Code" := DefDim."Dimension Value Code";
                LED.INSERT;
                a := TRUE;
              END;
            UNTIL DefDim.NEXT = 0;
        
        IF a THEN
         l := l + 1;
        Window.UPDATE;
        
        UNTIL VE.NEXT = 0;
        COMMIT;
        */

    end;

    var
        ILE: Record "Item Ledger Entry";
        VE: Record "Value Entry";
        Item: Record Item;
        DefDim: Record "Default Dimension";
        LocationRec: Record Location;
        GenSetup: Record "General Ledger Setup";
        InventorySetup: Record "Inventory Setup";
        Window: Dialog;
        i: Integer;
        j: Integer;
        k: Integer;
        l: Integer;
        a: Boolean;
        StateRec: Record State;
        m: Integer;
        n: Integer;
        ILENoTransferNoDim: Record "Attachment Management";
}

