tableextension 50233 tableextension50233 extends "Capacity Ledger Entry"
{
    // 
    // 1.TRI S.R 04.03.10 -New field Added for Manufacturing
    fields
    {
        field(50000; "Commercial Quantity"; Decimal)
        {
            Description = 'TRI S.R 04.03.10 -New field Added for Manufacturing';

            trigger OnValidate()
            var
                Text001: Label 'Quantity can not be more than Output Quantity.';
            begin
            end;
        }
        field(50001; "Economic Quantity"; Decimal)
        {
            Description = 'TRI S.R 04.03.10 -New field Added for Manufacturing';

            trigger OnValidate()
            var
                Text001: Label 'Quantity can not be more than Output Quantity.';
            begin
            end;
        }
        field(50002; "Broken Tiles Quantity"; Decimal)
        {
            Description = 'TRI S.R 04.03.10 -New field Added for Manufacturing';

            trigger OnValidate()
            var
                Text001: Label 'Quantity can not be more than Output Quantity.';
            begin
            end;
        }
        field(50003; Commercial; Code[20])
        {
            Description = 'TRI S.R 04.03.10 -New field Added for Manufacturing';
            TableRelation = Item."No.";
        }
        field(50004; Economic; Code[20])
        {
            Description = 'TRI S.R 04.03.10 -New field Added for Manufacturing';
            TableRelation = Item."No.";
        }
        field(50005; "Broken Tiles"; Code[20])
        {
            Description = 'TRI S.R 04.03.10 -New field Added for Manufacturing';
            TableRelation = Item."No.";
        }
        field(50006; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
            Description = 'TRI S.R 04.03.10 -New field Added for Manufacturing';
            Editable = false;
            MinValue = 0;
        }
        field(50007; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            Description = 'TRI S.R 04.03.10 -New field Added for Manufacturing';
            Editable = false;
            MinValue = 0;
        }
        field(50008; "Production Order Comp Line No."; Integer)
        {
            Description = 'TRI DG 040910';
        }
        field(50009; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            TableRelation = "Production Order"."No." WHERE(Status = FILTER(Released ..));
        }
        field(50010; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
            TableRelation = "Prod. Order Line"."Line No." WHERE(Status = FILTER(Released ..),
                                                                 "Prod. Order No." = FIELD("Prod. Order No."));
        }
    }
    keys
    {
        key(Key6; "Work Center No.", "Posting Date")
        {
        }
        key(Key7; "Operation No.")
        {
        }
        key(Key8; "Prod. Order No.", "Prod. Order Line No.")
        {
        }
        /* key(Key9; "Prod. Order No.", "Operation No.")
         {
         }*/
    }
}

