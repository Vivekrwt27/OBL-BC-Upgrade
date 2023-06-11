tableextension 50211 tableextension50211 extends "Prod. Order Component"
{
    fields
    {

        field(50000; "Original Component"; Boolean)
        {
            Description = 'TRI S.R 190310 - New field Add';
            Editable = false;
        }
        field(50001; "Scrap Item"; Boolean)
        {
            Description = 'TRI V.D 210610 - New field Add';
            Editable = false;
        }
        field(50002; "Scrap Qty From BOM"; Decimal)
        {
            Description = 'TRI V.D 210610 - New field Add';
            Editable = false;
        }
        field(50004; "Item Description 2"; Text[30])
        {
            CalcFormula = Lookup(Item."Description 2" WHERE("No." = FIELD("Item No.")));
            Description = 'TRI V.D 210610 - New field Add';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Old Quantity"; Decimal)
        {
            Description = 'TRI-VKG ADD 100910';
        }
        field(50009; "Prod. Reporting No."; Code[20])
        {
        }
        field(50010; "Prod. Reporting Line No."; Integer)
        {
        }
        field(50050; "Morbi Batch No."; Code[20])
        {
        }
        field(50051; "Original Quantity  Per"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(90000; "Actual Cost"; Decimal)
        {
            Description = 'MSKS0911 Ramesh Sir';
            Editable = false;
        }
        field(90001; "Source No."; Code[20])
        {
        }
        field(90002; Blocked; Boolean)
        {
        }
        field(90003; "Creation Date"; Date)
        {
        }
        field(90004; Inventory; Decimal)
        {
            AccessByPermission = TableData "Production Order" = R;
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("Item No."),
                                                                              "Location Code" = FIELD("Location Code"),
                                                                              Open = CONST(true)));
            Caption = 'Inventory';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(90005; "Reserve Qty"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry"."Quantity (Base)" WHERE("Reservation Status" = CONST(Reservation),
                                                                            "Item No." = FIELD("Item No."),
                                                                            "Location Code" = FIELD("Location Code"),
                                                                            Positive = CONST(true),
                                                                            "Source Type" = CONST(32)));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    trigger OnInsert()
    begin
        "Original Quantity  Per" := "Quantity per";
    end;

    trigger OnModify()
    begin
        IF "Original Quantity  Per" = 0 THEN
            "Original Quantity  Per" := "Quantity per";
    end;

    trigger OnRename()
    var
        Text99000001: Label 'You cannot rename a %1.';
    begin
        IF USERID <> UPPERCASE('ADMIN') THEN
            ERROR(Text99000001, TABLECAPTION);
    end;

    var
        TempMark: Boolean;
}

