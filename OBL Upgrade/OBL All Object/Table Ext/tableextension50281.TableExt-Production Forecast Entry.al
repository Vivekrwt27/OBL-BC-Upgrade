tableextension 50281 tableextension50281 extends "Production Forecast Entry"
{
    // 
    // 
    // 1.TRI S.R 210310 - New field added

    fields
    {

        field(50000; "Variant Code1"; Code[20])
        {
            Description = 'TRI S.R 210310 - New field added';

            trigger OnLookup()
            begin
                //TRI S.R 210310 - New Code Add Start
                ItemVariant.RESET;
                ItemVariant.SETRANGE("Item No.", "Item No.");
                IF ItemVariant.FIND('-') THEN BEGIN
                    IF PAGE.RUNMODAL(Page::"Item Variants", ItemVariant) = ACTION::LookupOK THEN
                        "Variant Code" := ItemVariant.Code
                    ELSE
                        "Variant Code" := '';
                END ELSE
                    "Variant Code" := '';
                //TRI S.R 210310 - New Code Add Stop
            end;
        }

        field(50001; "Production Plant Code"; Code[20])
        {
            Description = 'TRI S.R 210310 - New field added';

            trigger OnLookup()
            begin
                //TRI S.R 210310 - New Code Add Start
                SKU.RESET;
                SKU.SETRANGE("Item No.", "Item No.");
                SKU.SETRANGE(SKU."Replenishment System", SKU."Replenishment System"::"Prod. Order");
                IF SKU.FIND('-') THEN BEGIN
                    IF PAGE.RUNMODAL(Page::"Stockkeeping Unit List", SKU) = ACTION::LookupOK THEN
                        "Production Plant Code" := SKU."Location Code"
                    ELSE
                        "Production Plant Code" := '';
                END ELSE
                    "Production Plant Code" := '';
                //TRI S.R 210310 - New Code Add Stop
            end;
        }
        field(50002; "Original Location Code"; Code[10])
        {
            Caption = 'Original Location Code';
            Description = 'TRI S.R 210310 - New field added';
            Editable = false;
            TableRelation = Location;
        }
    }


    //Unsupported feature: Code Insertion on "OnDelete".

    trigger OnDelete()// 15578
    begin
        IF ForecastName.GET("Production Forecast Name") THEN BEGIN
            IF ForecastName.Status > ForecastName.Status::Open THEN
                ERROR(Text001);
        END;
    end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("Forecast Date");
    TESTFIELD("Production Forecast Name");
    LOCKTABLE;
    IF "Entry No." = 0 THEN
      IF ForecastEntry.FINDLAST THEN
        "Entry No." := ForecastEntry."Entry No." + 1;
    PlanningAssignment.AssignOne("Item No.",'',"Location Code","Forecast Date");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
         IF ForecastName.GET("Production Forecast Name") THEN
     BEGIN
      IF ForecastName.Status > ForecastName.Status::Open THEN
       ERROR(Text001);
     END;

    #1..7
    */
    //end;
    trigger OnBeforeInsert()// 15578
    begin
        IF ForecastName.GET("Production Forecast Name") THEN BEGIN
            IF ForecastName.Status > ForecastName.Status::Open THEN
                ERROR(Text001);
        END;

    end;


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PlanningAssignment.AssignOne("Item No.",'',"Location Code","Forecast Date");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    IF ForecastName.GET("Production Forecast Name") THEN
     BEGIN
      IF ForecastName.Status > ForecastName.Status::Open THEN
       ERROR(Text001);
     END;

    PlanningAssignment.AssignOne("Item No.",'',"Location Code","Forecast Date");
    */
    //end;
    trigger OnBeforeModify()// 15578
    begin
        IF ForecastName.GET("Production Forecast Name") THEN BEGIN
            IF ForecastName.Status > ForecastName.Status::Open THEN
                ERROR(Text001);
        END;
    end;


    //Unsupported feature: Code Insertion on "OnRename".

    trigger OnRename()// 15578
    begin
        IF ForecastName.GET("Production Forecast Name") THEN BEGIN
            IF ForecastName.Status > ForecastName.Status::Open THEN
                ERROR(Text001);
        END;
    end;

    var
        ItemVariant: Record "Item Variant";
        SKU: Record "Stockkeeping Unit";
        ForecastName: Record "Production Forecast Name";
        Text001: Label 'You can not Change or Delete the Authorized Forecast.';
}

