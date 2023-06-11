codeunit 50100 si
{

    trigger OnRun()
    begin
        Win.OPEN('updating   #1############');

        SalesInvLine.RESET;
        IF SalesInvLine.FIND('-') THEN
            REPEAT
                IF Location.GET(SalesInvLine."Location Code") THEN
                    SalesInvLine."Related Location code" := Location."Related Location Code"
                ELSE
                    SalesInvLine."Related Location code" := SalesInvLine."Main Location";
                SalesInvLine.MODIFY;
                i := i + 1;
                Win.UPDATE(1, i);
            UNTIL SalesInvLine.NEXT = 0;
        /*
        SalesLine.RESET;
        IF SalesLine.FIND('-') THEN REPEAT
          IF Location.GET(SalesLine."Location Code") THEN
            SalesLine."Related Location code" := Location."Related Location Code"
          ELSE
            SalesLine."Related Location code" := SalesLine."Main Location";
          SalesLine.MODIFY;
          i := i+1;
          Win.UPDATE(1,i);
        UNTIL SalesLine.NEXT = 0;
        
        SalesShpLine.RESET;
        IF SalesShpLine.FIND('-') THEN REPEAT
          IF Location.GET(SalesShpLine."Location Code") THEN
            SalesShpLine."Related Location code" := Location."Related Location Code"
          ELSE
            SalesShpLine."Related Location code" := SalesShpLine."Main Location";
          SalesShpLine.MODIFY;
          i := i+1;
          Win.UPDATE(1,i);
        UNTIL SalesShpLine.NEXT = 0;
        
        SalesLineArc.RESET;
        IF SalesLineArc.FIND('-') THEN REPEAT
          IF Location.GET(SalesLineArc."Location Code") THEN
            SalesLineArc."Related Location code" := Location."Related Location Code"
          ELSE
            SalesLineArc."Related Location code" := SalesLineArc."Main Location";
          SalesLineArc.MODIFY;
          i := i+1;
          Win.UPDATE(1,i);
        UNTIL SalesLineArc.NEXT = 0;
        Win.CLOSE;
         */

    end;

    var
        SalesInvLine: Record "Sales Invoice Line";
        SalesLine: Record "Sales Line";
        SalesShpLine: Record "Sales Shipment Line";
        SalesLineArc: Record "Branch Wise focused Prod IBOT";
        Location: Record Location;
        Win: Dialog;
        "Count": Integer;
        i: Integer;
}

