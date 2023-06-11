table 99991 "Opening Validate"
{

    fields
    {
        field(1; "Table"; Integer)
        {
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Table));
        }
        field(2; "Table Name"; Text[100])
        {
            /*  CalcFormula = Lookup(Object.Name WHERE(Type = CONST(Table),
                                                     ID = FIELD(Table)));
             FieldClass = FlowField; */
        }
        field(3; Validate; Boolean)
        {

            trigger OnValidate()
            begin
                IF Validate = TRUE THEN BEGIN
                    CALCFIELDS("Table Name");
                    windows.OPEN('#1###################################\#2##############################', "Table Name", Code);
                    windows.UPDATE;
                    Check("Table Name");
                    windows.CLOSE;
                END;
            end;
        }
    }

    keys
    {
        key(Key1; "Table")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        windows: Dialog;
        "Code": Code[20];

    procedure Check(Text: Text[100])
    begin
        CASE Text OF
            'Gen. Journal Line':
                "Gen. Journal Line";
            'Item Journal Line':
                "Item Journal Line";
        END;
    end;

    procedure "Gen. Journal Line"()
    var
        GenJralLine: Record "Gen. Journal Line";
    begin
        GenJralLine.FIND('-');
        REPEAT
            Code := GenJralLine."Account No.";
            windows.UPDATE;
            GenJralLine.VALIDATE(GenJralLine."Account No.");
            GenJralLine.VALIDATE(GenJralLine."Location Code");
            GenJralLine.VALIDATE(Amount);
            GenJralLine.MODIFY;

        UNTIL GenJralLine.NEXT = 0;
    end;

    procedure "Item Journal Line"()
    var
        ijl: Record "Item Journal Line";
        ijl_temp: Record "Item Journal Line open";
        cogs: Record cogs;
        location: Record Location;
        user_loc: Record "User Location";
        bin: Record Bin;
        loc: Code[10];
        item: Record Item;
    begin
        //ijl_temp.SETFILTER(ijl_temp."Bin Code",'<>%1','');
        ijl_temp.FIND('-');
        //ijl_temp.NEXT;
        REPEAT
            Code := ijl_temp."Item No.";
            windows.UPDATE;
            IF item.GET(ijl_temp."Item No.") THEN BEGIN

                ijl.INIT;

                ijl.VALIDATE(ijl."Journal Template Name", ijl_temp."Journal Template Name");
                ijl.VALIDATE(ijl."Journal Batch Name", ijl_temp."Journal Batch Name");
                ijl.VALIDATE(ijl."Line No.", ijl_temp."Line No.");
                /*
                IF NOT location.GET(ijl_temp."Location Code") THEN BEGIN
                   location.INIT;
                   location.VALIDATE(location.Code,ijl_temp."Location Code");
                   location.VALIDATE(location.Name,ijl_temp."Location Code");
                   location.VALIDATE(location."Main Location",'PLANT');
                   location.INSERT(TRUE);
                   user_loc.INIT;
                   user_loc.VALIDATE(user_loc."User ID",'RAHUL');
                   user_loc.VALIDATE(user_loc."Location Code",ijl_temp."Location Code");
                   user_loc.VALIDATE(user_loc."IJT Item",TRUE);
                   user_loc.INSERT(TRUE);
                END;
                */
                ijl.VALIDATE(ijl."Item No.", ijl_temp."Item No.");

                loc := ijl_temp."Location Code";
                //  IF ijl_temp."Location Code"='' THEN BEGIN
                //     bin.SETRANGE(bin.Code,ijl_temp."Bin Code");
                //     bin.FIND('-');
                //     loc:=bin."Location Code";

                // END;
                //  MESSAGE(loc);
                ijl.VALIDATE(ijl."Location Code", loc);
                ijl.VALIDATE(ijl."Posting Date", ijl_temp."Posting Date");
                ijl.VALIDATE(ijl."Variant Code", ijl_temp."Variant Code");
                //  ijl.VALIDATE(ijl."Bin Code",bin.Code);
                ijl.VALIDATE(ijl."Entry Type", ijl_temp."Entry Type");
                ijl.VALIDATE(ijl."Document No.", ijl_temp."Document No.");
                ijl.VALIDATE(ijl.Quantity, ijl_temp.Quantity);
                ijl.VALIDATE(ijl."Location Code", loc);

                ijl.INSERT(TRUE);

                //    Journal Template Name,Journal Batch Name,Line No.
                //ijl.GET('item','DEFAULT',ijl_temp."Line No.");
                ijl.VALIDATE(ijl."Location Code", loc);
                //  ijl.VALIDATE(ijl."Bin Code",bin.Code);

                IF cogs.GET(ijl."Item No.") THEN BEGIN
                    ijl.VALIDATE(ijl."Unit Amount", cogs."Rate Carton");
                END;

                ijl.MODIFY;
                //   EXIT;
            END;
        UNTIL ijl_temp.NEXT = 0;

    end;
}

