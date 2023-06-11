tableextension 50249 tableextension50249 extends "Sales Price"
{
    fields
    {
        modify("Sales Code")
        {
            TableRelation = IF ("Sales Type" = CONST(Customer)) Customer
            ELSE
            IF ("Sales Type" = CONST(Campaign)) Campaign
            ELSE
            IF ("Sales Type" = CONST("Customer Price Group")) "Customer Price Group";
            Caption = 'Sales Code';
        }
        modify("Unit of Measure Code")
        {
            Caption = 'Unit of Measure Code';
            trigger OnBeforeValidate()// 15578
            begin
                //UPDATE - TCPL - 7632
                //ND Tri1.0 Start
                IF "Unit of Measure Code" = '' THEN
                    IF Item1.GET("Item No.") THEN
                        VALIDATE("Unit of Measure Code", Item1."Base Unit of Measure");

                IF "Unit of Measure Code" <> xRec."Unit of Measure Code" THEN BEGIN
                    ItemUnitOfMeasure.RESET;
                    ItemUnitOfMeasure.SETFILTER("Item No.", "Item No.");
                    ItemUnitOfMeasure.SETFILTER(Code, xRec."Unit of Measure Code");
                    IF ItemUnitOfMeasure.FIND('-') THEN BEGIN
                        QtyPerxRec := ItemUnitOfMeasure."Qty. per Unit of Measure";
                        ItemUnitOfMeasure1.RESET;
                        ItemUnitOfMeasure1.SETFILTER(ItemUnitOfMeasure1."Item No.", "Item No.");
                        ItemUnitOfMeasure1.SETFILTER(ItemUnitOfMeasure1.Code, "Unit of Measure Code");
                        IF ItemUnitOfMeasure1.FIND('-') THEN BEGIN
                            QtyPerRec := ItemUnitOfMeasure1."Qty. per Unit of Measure";
                            // 15578  "MRP Price" := ("MRP Price" * QtyPerRec) / QtyPerxRec;//TRIRJ
                            "Unit Price" := ("Unit Price" * QtyPerRec) / QtyPerxRec;
                            "Nepal Price" := ("Nepal Price" * QtyPerRec) / QtyPerxRec;
                        END;
                    END;
                END;
            end;
            //ND Tri1.0 End
            //UPDATE - TCPL - 7632


        }

        //Unsupported feature: Code Modification on ""Sales Code"(Field 2).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Sales Code" <> '' THEN
          CASE "Sales Type" OF
            "Sales Type"::"All Customers":
              ERROR(Text001,FIELDCAPTION("Sales Code"));
        #5..14
                Cust.GET("Sales Code");
                "Currency Code" := Cust."Currency Code";
                "Price Includes VAT" := Cust."Prices Including VAT";
                "VAT Bus. Posting Gr. (Price)" := Cust."VAT Bus. Posting Group";
                "Allow Line Disc." := Cust."Allow Line Disc.";
              END;
            "Sales Type"::Campaign:
        #22..24
                "Ending Date" := Campaign."Ending Date";
              END;
          END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Sales Code" <> '' THEN BEGIN
        #2..17
        #19..27
        END;
        */
        //end;


        //Unsupported feature: Code Modification on ""Starting Date"(Field 4).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Starting Date" > "Ending Date") AND ("Ending Date" <> 0D) THEN
          ERROR(Text000,FIELDCAPTION("Starting Date"),FIELDCAPTION("Ending Date"));

        #4..6
        IF "Starting Date" <> 0D THEN
          IF "Sales Type" = "Sales Type"::Campaign THEN
            ERROR(Text002,"Sales Type");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..9

          "Created ID" := USERID;
           Modifydate := TODAY;
        */
        //end;
        modify("Starting Date")// 15578
        {
            trigger OnAfterValidate()
            begin
                "Created ID" := USERID;
                Modifydate := TODAY;

            end;
        }


        //Unsupported feature: Code Modification on ""Sales Type"(Field 13).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Sales Type" <> xRec."Sales Type" THEN BEGIN
          VALIDATE("Sales Code",'');
          UpdateValuesFromItem;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Sales Type" <> xRec."Sales Type" THEN BEGIN
          VALIDATE("Sales Code",'');
          "Created ID" := USERID;
           Modifydate := TODAY;
          UpdateValuesFromItem;
        END;
        */
        //end;
        modify("Sales Type")// 15578
        {
            trigger OnBeforeValidate()
            begin
                IF "Sales Type" <> xRec."Sales Type" THEN BEGIN
                    VALIDATE("Sales Code", '');
                    "Created ID" := USERID;
                    Modifydate := TODAY;

                end;
            end;
        }


        //Unsupported feature: Code Insertion on ""Unit of Measure Code"(Field 5400)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        //UPDATE - TCPL - 7632
        //ND Tri1.0 Start
        IF "Unit of Measure Code" = '' THEN
          IF Item1.GET("Item No.") THEN
            VALIDATE("Unit of Measure Code",Item1."Base Unit of Measure");

        IF "Unit of Measure Code" <> xRec."Unit of Measure Code" THEN BEGIN
          ItemUnitOfMeasure.RESET;
          ItemUnitOfMeasure.SETFILTER("Item No.","Item No.");
          ItemUnitOfMeasure.SETFILTER(Code,xRec."Unit of Measure Code");
          IF ItemUnitOfMeasure.FIND('-') THEN BEGIN
            QtyPerxRec := ItemUnitOfMeasure."Qty. per Unit of Measure";
            ItemUnitOfMeasure1.RESET;
            ItemUnitOfMeasure1.SETFILTER(ItemUnitOfMeasure1."Item No.","Item No.");
            ItemUnitOfMeasure1.SETFILTER(ItemUnitOfMeasure1.Code,"Unit of Measure Code");
            IF ItemUnitOfMeasure1.FIND('-') THEN BEGIN
              QtyPerRec := ItemUnitOfMeasure1."Qty. per Unit of Measure";
              "MRP Price" := ("MRP Price" * QtyPerRec )/QtyPerxRec;//TRIRJ
              "Unit Price":= ("Unit Price" * QtyPerRec )/QtyPerxRec;
              "Nepal Price":= ("Nepal Price" * QtyPerRec )/QtyPerxRec;
            END;
          END;
        END;
        //ND Tri1.0 End
        //UPDATE - TCPL - 7632
        */
        //end;
        field(50001; State; Code[10])
        {
            Description = 'report rate diff';
            TableRelation = State;
        }
        field(50002; "Can Delete"; Boolean)
        {
            Editable = false;
        }
        field(50003; "count"; Integer)
        {
            CalcFormula = Count("Sales Price");
            Enabled = false;
            FieldClass = FlowField;
        }
        field(50004; "Created ID"; Code[20])
        {
        }
        field(50005; Modifydate; Date)
        {
        }
        field(50006; "Nepal Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70002; MRP; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70003; "MRP Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key5; "Sales Type", "Item No.", "Starting Date")
        {
        }
        key(Key6; "Item No.", "Sales Code")
        {
        }
    }


    trigger OnInsert()
    begin
        //UPDATE - TCPL - 7632
        //ND Tri1.0 START
        UOM := "Unit of Measure Code";
        UnitPrice := "Unit Price";
        NepalPrice := "Nepal Price";

        ItemUnitOfMeasure.RESET;
        ItemUnitOfMeasure.SETFILTER(ItemUnitOfMeasure."Item No.", "Item No.");
        ItemUnitOfMeasure.SETFILTER(ItemUnitOfMeasure.Code, '<>%1', "Unit of Measure Code");
        IF ItemUnitOfMeasure.FIND('-') THEN
            REPEAT
                IF NOT SalesPrice.GET("Item No.", "Sales Type", "Sales Code", "Starting Date", "Currency Code", "Variant Code", ItemUnitOfMeasure.Code,
                  "Minimum Quantity") THEN BEGIN
                    SalesPrice."Item No." := "Item No.";
                    SalesPrice."Sales Type" := "Sales Type";
                    SalesPrice."Sales Code" := "Sales Code";
                    SalesPrice."Starting Date" := "Starting Date";
                    SalesPrice."Currency Code" := "Currency Code";
                    SalesPrice."Variant Code" := "Variant Code";
                    SalesPrice."Unit of Measure Code" := UOM;
                    SalesPrice."Minimum Quantity" := "Minimum Quantity";
                    //15578  SalesPrice.MRP := MRP;
                    //15578  SalesPrice."MRP Price" := "MRP Price";//TRIRJ
                    SalesPrice."Unit Price" := UnitPrice;
                    SalesPrice."Nepal Price" := NepalPrice;
                    SalesPrice."Price Includes VAT" := "Price Includes VAT";
                    SalesPrice."Allow Invoice Disc." := "Allow Invoice Disc.";
                    SalesPrice."VAT Bus. Posting Gr. (Price)" := "VAT Bus. Posting Gr. (Price)";
                    SalesPrice."Ending Date" := "Ending Date";
                    SalesPrice."Allow Line Disc." := "Allow Line Disc.";
                    SalesPrice.State := State;

                    SalesPrice.VALIDATE(SalesPrice."Unit of Measure Code", ItemUnitOfMeasure.Code);
                    SalesPrice.INSERT;
                END;
            UNTIL ItemUnitOfMeasure.NEXT = 0;
        //ND Tri1.0 END
        //UPDATE - TCPL - 7632

    end;


    trigger OnModify()// 15578
    begin
        //UPDATE - TCPL - 7632
        ItemUnitOfMeasure.RESET;
        ItemUnitOfMeasure.SETFILTER(ItemUnitOfMeasure."Item No.", "Item No.");
        ItemUnitOfMeasure.SETFILTER(ItemUnitOfMeasure.Code, '<>%1', "Unit of Measure Code");
        IF ItemUnitOfMeasure.FIND('-') THEN
            REPEAT
                IF NOT SalesPrice.GET("Item No.", "Sales Type", "Sales Code", "Starting Date", "Currency Code", "Variant Code", ItemUnitOfMeasure.Code,
                  "Minimum Quantity") THEN BEGIN
                    SalesPrice."Unit of Measure Code" := "Unit of Measure Code";
                    SalesPrice."Unit Price" := "Unit Price";
                    SalesPrice."Nepal Price" := "Nepal Price";
                    SalesPrice.VALIDATE(SalesPrice."Unit of Measure Code", ItemUnitOfMeasure.Code);
                    SalesPrice.MODIFY;
                END;
            UNTIL ItemUnitOfMeasure.NEXT = 0;
        //ND Tri1.0 END
        //UPDATE - TCPL - 7632

    end;

    var
        UOM: Code[20];
        MRP1: Decimal;
        UnitPrice: Decimal;
        QtyPerxRec: Decimal;
        QtyPerRec: Decimal;
        SalesPrice: Record "Sales Price";
        Item1: Record Item;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        ItemUnitOfMeasure1: Record "Item Unit of Measure";
        Text0003: Label 'Unit Price of Item %1 cannot be greater than its MRP.';
        NepalPrice: Decimal;
}

