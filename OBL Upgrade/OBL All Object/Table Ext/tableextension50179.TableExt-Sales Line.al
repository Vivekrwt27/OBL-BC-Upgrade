tableextension 50179 tableextension50179 extends "Sales Line"
{
    fields
    {

        modify("No.")
        {
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account"), "System-Created Entry" = CONST(false)) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                          Blocked = CONST(false))
            ELSE
            IF (Type = CONST("G/L Account"),
                                                                                                   "System-Created Entry" = CONST(true)) "G/L Account"
            ELSE
            IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge";

            trigger OnAfterValidate()// 15578 P
            var
                SalesPrice: Record "Sales Price";
                ChargeItem: Record 5800;
                RecsalesLine: Record 37;
                SalesLineAmount: Decimal;
                SalesHeader: Record "Sales Header";
                SalesLine: Record 37;
                RecSalesHeader: Record "Sales Header";
                SL1: Record "Sales Line";
            begin
                SL1.RESET;
                SL1.SETFILTER("Document No.", SalesHeader."No.");
                SL1.SETRANGE(Type, Type::Item);
                if SL1.FindFirst() then
                    SL1."Location Code" := rec."Location Code";
                //SL1.Modify();

                if Type = Type::Item then begin
                    SalesPrice.Reset();
                    SalesPrice.SetRange("Item No.", Rec."No.");
                    if SalesPrice.FindFirst() then begin
                        Rec.MRP := SalesPrice.MRP;
                        rec."MRP Price" := SalesPrice."MRP Price";
                        // Rec.Modify();
                    end;
                end;

                IF SalesHeader.GET("Document Type", "Document No.") THEN;
                "Sales Type" := SalesHeader."Sales Type"; //MSKS06072015
                IF Location3.GET(SalesHeader."Location Code") THEN
                    "Related Location code" := Location3."Related Location Code";
                //Vipul Tri1.0 End
                CASE Type OF
                    Type::Item:
                        BEGIN
                            GetItem;
                            if rec."No." <> '' then
                                Item.get(rec."No.");

                            //Upgrade(+)
                            if item."No." <> '' then
                                Item.TESTFIELD("HSN/SAC Code"); //MSKS

                            //Upgrade(-)
                            IF (UPPERCASE(USERID) <> 'ADMIN') AND (UPPERCASE(USERID) <> 'FA028') THEN
                                Item.TESTFIELD(Blocked, FALSE); //KULBHUSHAN
                            Item.TESTFIELD("Gen. Prod. Posting Group");
                            IF Item.Type = Item.Type::Inventory THEN BEGIN
                                Item.TESTFIELD("Inventory Posting Group");
                                "Posting Group" := Item."Inventory Posting Group";
                            END;
                            //Upgrade(+)
                            "Group Code" := Item."Group Code"; //TRI SB 220208
                            "Item Type" := Item."Type Code"; //tri lm 100308
                                                             //TRI 22.02.08 N.K Add Start
                                                             //TRIRJ
                            IF SalesHeader."Group Code Check" = FALSE THEN BEGIN
                                IF (SalesHeader."Document Type" = "Document Type"::Order) OR
                                  (SalesHeader."Document Type" = "Document Type"::"Blanket Order") THEN BEGIN
                                    //MSKS1611 Start
                                    //IF Item."Group Code" <> SalesHeader."Group Code" THEN
                                    //ERROR(Text0002);
                                    IF CheckGroupCode(Item."No.", SalesHeader."Group Code") THEN
                                        ERROR(Text0002);
                                    //MSKS1611 END
                                END;
                            END;
                            //TRI 22.02.08 N.K Add End
                            //MSBS.Rao Start-0713 Code Comented as requested by Mr. Kulbushan Sharama
                            IF (SalesHeader."Document Type" = "Document Type"::Order) THEN
                                IF SalesHeader."Order Booked Date" = 0DT THEN//MSBS.Rao 300914
                                    ERROR('Order Received Date Cannot Blank');  //MSBS.Rao 300914
                            "Scheme Group Code" := Item."Scheme Group Code";//MSBS.Rao 0713
                            IF Type = Type::Item THEN BEGIN
                                IF Item.GET("No.") THEN BEGIN
                                    "Type Code" := Item."Type Code";
                                    "Plant Code" := Item."Plant Code";
                                    "Size Code" := Item."Size Code";
                                    "Design Code" := Item."Design Code";
                                    "Packing Code" := Item."Packing Code";
                                    "Quality Code" := Item."Quality Code";
                                    "Color Code" := Item."Color Code";
                                    "Type Catogery Code" := Item."Type Catogery Code";
                                    "Default Prod. Plant Code" := Item."Default Prod. Plant Code";
                                    "Offer Code" := GetOfferCodeNew(SalesHeader, Rec);//Team15578
                                    "Complete Description" := Item."Complete Description";
                                    //        VALIDATE(D7,GetAdditionDiscount("Sell-to Customer No.","No.")); //MSKS0205
                                    // TRI NM 160308 - Code added
                                END;
                            END;

                            SL.RESET;
                            SL.SETFILTER("Document No.", SalesHeader."No.");
                            SL.SETRANGE(Type, Type::Item);
                            IF Type = Type::Item THEN BEGIN
                                SL.SETFILTER("No.", "No.");
                                IF SL.FIND('-') THEN
                                    IF NOT CONFIRM(Text0001, TRUE, "No.") THEN BEGIN
                                        "No." := '';
                                        //ERROR('Please Select Another Item');
                                    END;
                            END;
                            //mo tri.10 customization no. end

                            //TRI DG 020609 Add Start
                            IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
                                IF "Order Qty" > 0 THEN
                                    ERROR(Text0004);
                            END;
                            GetSalesPriceInLine;
                            IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
                                IF "Order Qty" > 0 THEN
                                    ERROR(Text0004);
                            END;
                            GetSalesPriceInLine;
                            "Invoice Type" := SalesHeader."Invoice Type";
                            "Assessee Code" := SalesHeader."Assessee Code";
                        end;
                end;


                if rec.Type = rec.Type::"Charge (Item)" then begin
                    ChargeItem.Reset;
                    ChargeItem.setrange("No.", rec."No.");
                    if ChargeItem.FindFirst then begin
                        clear(SalesLineAmount);
                        RecsalesLine.reset;
                        RecsalesLine.setrange("Document No.", rec."Document No.");
                        if RecsalesLine.FindSet then
                            repeat
                                SalesLineAmount += RecsalesLine."Line Amount";
                            until RecsalesLine.next = 0;
                        validate(rec.Quantity, 1);
                        Validate(rec."Unit Price", ((SalesLineAmount * ChargeItem."Insurance Percentage") / 100));
                    end;
                end;
                /*  if rec.Type = Rec.Type::"Charge (Item)" then begin
                     SalesHeader.Reset();
                     SalesHeader.SetRange("No.", "Document No.");
                     SalesHeader.SetAutoCalcFields("CD Available for Utilisation");
                     if SalesHeader.FindFirst() then begin
                         Validate("Unit Price", SalesHeader."CD Available for Utilisation");
                     end;
                 end; */

                Clear(RecSalesHeader);
                RecSalesHeader.RESET;
                RecSalesHeader.SetRange("No.", Rec."Document No.");
                if RecSalesHeader.FindFirst then begin
                    Rec."Sell-to Customer No." := RecSalesHeader."Sell-to Customer No.";
                    Rec."Bill-to Customer No." := RecSalesHeader."Bill-to Customer No.";
                end;

            end;
        }
        modify("Location Code")// 15578
        {
            trigger OnAfterValidate()
            var
                SalesHeader: Record "Sales Header";
                Location: Record Location;
                salesH: Record "Sales Header";
            begin

                /*
                salesH.Reset();
                salesH.SetRange("No.", Rec."Document No.");
                salesH.SetRange("Document Type", Rec."Document Type");
                if salesH.FindFirst() then
                    Validate("Location Code", salesH."Location Code");
                */


                //Upgrade(+)
                //vipul Tri1.0 Start
                IF SalesHeader.GET("Document Type", "Document No.") THEN
                    IF NOT Location.GetLocationFilter(SalesHeader."Location Code", "Location Code") THEN
                        ERROR('Please select %1 location or its sub locations.', SalesHeader."Location Code");
                //vipul Tri1.0 end

                //ND Tri Start cust 64
                IF "Line No." = 0 THEN
                    ERROR('While making a new line you cannot change the Location Code. Please change the Location Code after Inserting the Line.');

                UserSetup.RESET;
                UserSetup.SETFILTER("User ID", USERID);
                IF UserSetup.FIND('-') THEN
                    IF NOT UserSetup."Change Location" THEN
                        ERROR('You cannot change the location. Please contact your system administrator.');
                //ND Tri End   cust 64

                //Upgrade(+)
                //ND Tri Start Cust

                GLSetup.GET;
                GeneralLedgerSetup.RESET;
                GeneralLedgerSetup.FIND('-');
                Location1.RESET;
                Location1.SETFILTER(Location1.Code, "Location Code");
                IF Location1.FIND('-') THEN BEGIN
                    VALIDATE("Shortcut Dimension 1 Code", Location1."Location Dimension"); //TEAM::3333
                                                                                           //VALIDATE("Shortcut Dimension 8 Code",GLSetup."Location Dimension Code"); //TEAM::3333

                    IF Location1."Main Location" <> '' THEN BEGIN
                        Location1.SETFILTER(Location1.Code, Location1."Main Location");
                        Location1.FIND('-');
                    END;
                    /*  IF NOT DocumentDimensions.GET(DATABASE::"Sales Header", "Document Type", "No.", "Line No.",
                      GeneralLedgerSetup."Location Dimension Code")
                       THEN BEGIN
                          DocumentDimensions."Table ID" := DATABASE::"Sales Header";
                          DocumentDimensions."Document Type" := "Document Type";
                          DocumentDimensions."Document No." := "No.";
                          DocumentDimensions."Line No." := "Line No.";
                          DocumentDimensions."Dimension Code" := GeneralLedgerSetup."Location Dimension Code";
                          DocumentDimensions."Dimension Value Code" := Location1."Location Dimension";
                          DocumentDimensions.INSERT;
                      END;

                      IF DocumentDimensions.GET(DATABASE::"Sales Line", "Document Type", "Document No.", "Line No.",
                        GeneralLedgerSetup."Location Dimension Code") THEN BEGIN
                          COMMIT;
                          DocumentDimensions."Dimension Value Code" := Location1."Location Dimension";
                          DocumentDimensions.MODIFY;
                      END;*/
                END;

                //ND Tri End Cust

                //ND Tri1.0 Start
                IF Location.GET("Location Code") THEN BEGIN
                    VALIDATE("Main Location", Location."Main Location");
                    VALIDATE("Related Location code", Location."Related Location Code");  //Vipul Tri1.0
                END;
                //ND Tri1.0 End
                //Upgrade(-)
            end;
        }
        //Unsupported feature: Code Modification on "Quantity(Field 15).OnValidate".
        modify("Customer Price Group")
        {
            trigger OnAfterValidate()
            begin
                GetSalesPriceInLine;
            end;
        }

        modify(Quantity)// 15578
        {
            //TEAM 14763
            trigger OnBeforeValidate()
            var
                ItemChargeAssgntSales: Record "Item Charge Assignment (Sales)";
                RecSalesLine: Record "Sales Line";
            begin
                if Rec.Quantity = 0 then begin
                    Clear(RecSalesLine);
                    RecSalesLine.RESET;
                    RecSalesLine.SetRange("Document No.", Rec."Document No.");
                    RecSalesLine.Setfilter("Qty. to Assign", '<>%1', 0);
                    if RecSalesLine.FindSet then
                        RecSalesLine.ModifyAll("Qty. to Assign", 0);

                    Clear(ItemChargeAssgntSales);
                    ItemChargeAssgntSales.RESET;
                    ItemChargeAssgntSales.SetRange("Applies-to Doc. Type", "Document Type");
                    ItemChargeAssgntSales.SetRange("Applies-to Doc. No.", "Document No.");
                    ItemChargeAssgntSales.SetRange("Applies-to Doc. Line No.", "Line No.");
                    ItemChargeAssgntSales.SetRange("Document Type", "Document Type");
                    ItemChargeAssgntSales.SetRange("Document No.", "Document No.");
                    if ItemChargeAssgntSales.FindSet() then
                        ItemChargeAssgntSales.DeleteAll;
                end
            end;

            trigger OnAfterValidate()
            var
                Item: Record Item;
                ItemChargeAssgntSales: Record "Item Charge Assignment (Sales)";
            begin
                IF (Quantity = "Quantity Invoiced") AND (CurrFieldNo <> 0) THEN
                    //Upgrade(+)
                    VALIDATE("Quantity Discount %"); //SHAKTI
                                                     //Upgrade(-)

                IF Type = Type::Item THEN BEGIN
                    ReserveSalesLine.VerifyQuantity(Rec, xRec); //TEAM 14763
                    Item.GET("No.");
                    "Gross Weight" := ROUND(Item."Gross Weight" * "Qty. per Unit of Measure" * Quantity, 0.001, '=');
                    "Net Weight" := ROUND(Item."Net Weight" * "Qty. per Unit of Measure" * Quantity, 0.001, '=');
                    "Outstanding Gross Weight" := ROUND(Item."Gross Weight" * "Outstanding Qty. (Base)", 0.001, '=');
                END;
                //RA end cust 11

                //ND Tri1.0 START
                IF Type = Type::Item THEN
                    "Quantity in Sq. Mt." := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);
                IF Type = Type::Item THEN
                    "Quantity in Cartons" := Item.UomToCart("No.", "Unit of Measure Code", Quantity);
                GetSalesPriceInLine;
                //TRI DG 220410 Add Stop
                IF BaseUOM.GET("No.", "Unit of Measure Code") THEN;
                if Quantity <> 0 then begin
                    IF BaseUOM."Qty. per Unit of Measure" <> 0 THEN
                        VALIDATE("Buyer's Price /Sq.Mt", ROUND((("Line Amount") / Quantity) / BaseUOM."Qty. per Unit of Measure", 0.01));
                end;
            END;
        }


        //Unsupported feature: Code Modification on ""Qty. to Ship"(Field 18).OnValidate".


        modify("Qty. to Ship")
        {
            trigger OnBeforeValidate()
            begin
                /*
                if Rec.Quantity = 0 then begin
                    Rec."Reserved Qty. (Base)" := 0;
                    Rec."Reserved Quantity" := 0;
                    Rec."Line Amount" := 0;
                    Rec."Line Amount 1" := 0;
                    Rec."Line Amount Per Qty" := 0;
                    Rec."Line Discount %" := 0;
                    Rec."Line Discount Amount" := 0;
                    Rec."Line Discount Amount 1" := 0;
                end;
                */
            end;

            trigger OnAfterValidate()
            var
                ChargeItem: Record 5800;
                RecsalesLine: Record 37;
                SalesLineAmount: Decimal;
                RecsalesLine1: Record 37;
            begin
                refQtyinhand;
                //TRI
                //Upgrade(-)
                CALCFIELDS("Reserved Quantity");


                IF (FIELDNO("Qty. to Ship") = 18) AND ("Reserved Quantity" > 0) THEN
                    IF ("Qty. to Ship" > "Reserved Quantity") THEN
                        ERROR('You Cannot Ship More Then Reserved Quantity');

                IF Type = Type::Item THEN BEGIN
                    "Quantity in Sq. Mt.(Ship)" := Item.UomToSqm("No.", "Unit of Measure Code", "Qty. to Ship");
                    "Quantity in Cartons(Ship)" := Item.UomToCart("No.", "Unit of Measure Code", "Qty. to Ship");
                    Item.GET("No.");
                    "Gross Weight" := ROUND(Item."Gross Weight" * "Qty. per Unit of Measure" * Quantity, 0.001, '=');
                    "Net Weight" := ROUND(Item."Net Weight" * "Qty. per Unit of Measure" * Quantity, 0.001, '=');

                    //TRI
                    "Gross Weight (Ship)" := ROUND(Item."Gross Weight" * "Qty. per Unit of Measure" * "Qty. to Ship", 0.001, '=');
                    "Net Weight (Ship)" := ROUND(Item."Net Weight" * "Qty. per Unit of Measure" * "Qty. to Ship", 0.001, '=');

                END;
                //TRI DG 020609 Add Start
                IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
                    CALCFIELDS("Order Qty (CRT)");
                    IF "Qty. to Ship" > Quantity - "Order Qty (CRT)" THEN
                        ERROR(Text0005, Quantity - "Order Qty (CRT)");
                END;
                //TEAM 14763

                Clear(SalesLineAmount);

                if Rec.Quantity = 0 then
                    exit;

                Clear(RecsalesLine);
                RecsalesLine.reset;
                RecsalesLine.setrange("Document No.", rec."Document No.");
                RecsalesLine.SetRange(Type, RecsalesLine.Type::Item);
                if RecsalesLine.FindSet then
                    repeat
                        if RecsalesLine.Quantity <> 0 then begin //TEAM 14763
                            if rec."Line No." = RecsalesLine."Line No." then
                                SalesLineAmount := SalesLineAmount + ((RecsalesLine."Line Amount" / Quantity) * "Qty. to Ship")
                            else
                                SalesLineAmount := SalesLineAmount + ((RecsalesLine."Line Amount" / RecsalesLine.Quantity) * RecsalesLine."Qty. to Ship");
                        end;
                    until RecsalesLine.next = 0;


                //     if Rec.Status = Rec.Status::Open then begin

                IF CurrFieldNo = FieldNo(rec."Qty. to Ship") then begin
                    RecsalesLine1.reset;
                    RecsalesLine1.setrange("Document No.", rec."Document No.");
                    RecsalesLine1.setrange(Type, RecsalesLine1.type::"Charge (Item)");
                    if RecsalesLine1.FindFirst then
                        repeat
                            ChargeItem.reset;
                            ChargeItem.setrange("No.", RecsalesLine1."No.");
                            ChargeItem.setrange("Calculation Type", ChargeItem."Calculation Type"::Percentage);
                            if ChargeItem.FindFirst then
                                if ChargeItem."Insurance Percentage" <> 0 then begin
                                    IF SalesHeader.get(RecsalesLine1."Document Type", RecsalesLine1."Document No.") then
                                        IF SalesHeader.Status = SalesHeader.Status::Released then
                                            RecsalesLine1."Charge Item" := true;
                                    if SalesLineAmount <> 0 then //TEAM 14763
                                        RecsalesLine1.Validate("Unit Price", ((SalesLineAmount * ChargeItem."Insurance Percentage") / 100));
                                    RecsalesLine1.Modify;
                                end;
                        until RecsalesLine1.Next = 0;
                end;
            end;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Qty. to Ship"(Field 18)".

        modify("Unit Price")// 15578
        {
            trigger OnBeforeValidate()
            begin
                //Upgrade(+)
                VALIDATE("Quantity Discount %"); //SHAKTI
                                                 //Upgrade(-)

                //Upgrade(+)
                //Vipul Tri1.0 Start
                "Unit Price" := ROUND("Unit Price", 0.01, '=');
                IF BaseUOM.GET("No.", "Unit of Measure Code") THEN
                    IF BaseUOM."Qty. per Unit of Measure" <> 0 THEN
                        "Unit Price Excl. VAT/Sq.Mt" := "Unit Price" / BaseUOM."Qty. per Unit of Measure"; //6700
                                                                                                           //Vipul Tri 1.0 End
            end;
        }
        modify("Gross Weight")
        {
            trigger OnBeforeValidate()
            begin
                "Gross Weight" := ROUND("Gross Weight", 0.001, '=');
            end;
        }
        modify("Net Weight")
        {
            trigger OnBeforeValidate()
            begin
                "Net Weight" := ROUND("Net Weight", 0.001, '=');
            end;
        }

        modify("Line Amount")
        {
            trigger OnBeforeValidate()
            var
                Currency: Record Currency;
            begin
                GetSalesHeader;
                VALIDATE(
               "Quantity Discount Amount", ROUND(Quantity * "Unit Price", Currency."Amount Rounding Precision") - "Line Amount");
            end;
        }
        modify("Variant Code")
        {
            trigger OnBeforeValidate()
            begin
                IF Type = Type::Item THEN BEGIN
                    Item.GET("No.");
                    Description := Item.Description;
                    "Description 2" := Item."Description 2";
                    GetItemTranslation;
                END;

            end;
        }
        /* modify("Unit of Measure Code")
        {
            trigger OnAfterValidate()
            begin
                case type of
                Type::Item:
                begin

                end;
            end;
        } */

        /* 
                modify("Unit of Measure Code")// 15578
                {
                    trigger OnBeforeValidate()
                    begin
                        CASE Type OF
                            Type::Item:
                                BEGIN
                                    GetItem;
                                    GetUnitCost;
                                    //Vivek 16022023           //UpdateUnitPrice(FIELDNO("Unit of Measure Code"));
                                    CheckItemAvailable(FIELDNO("Unit of Measure Code"));
                                    "Gross Weight (Ship)" := ROUND(Item."Gross Weight" * "Qty. per Unit of Measure" * "Qty. to Ship", 0.001, '=');
                                    "Net Weight (Ship)" := ROUND(Item."Net Weight" * "Qty. per Unit of Measure" * "Qty. to Ship", 0.001, '=');

                                    IF Type = Type::Item THEN
                                        "Quantity in Sq. Mt." := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);
                                    //ND Tri1.0 END

                                    //ND Tri1.0 Start Cust 29
                                    IF Type = Type::Item THEN
                                        IF "Unit of Measure Code" <> xRec."Unit of Measure Code" THEN BEGIN
                                            ItemUnitOfMeasure.RESET;
                                            ItemUnitOfMeasure.SETFILTER("Item No.", "No.");
                                            ItemUnitOfMeasure.SETFILTER(Code, xRec."Unit of Measure Code");
                                            IF ItemUnitOfMeasure.FIND('-') THEN BEGIN
                                                ItemUnitofMeasure1.RESET;
                                                ItemUnitofMeasure1.SETFILTER(ItemUnitofMeasure1."Item No.", "No.");
                                                ItemUnitofMeasure1.SETFILTER(ItemUnitofMeasure1.Code, "Unit of Measure Code");
                                                IF ItemUnitofMeasure1.FIND('-') THEN BEGIN
                                                        "MRP Price" := (xRec."MRP Price" * ItemUnitofMeasure1."Qty. per Unit of Measure") /
                                                                          ItemUnitOfMeasure."Qty. per Unit of Measure";
                                                        IF "MRP Price" <> 0 THEN
                                                            MODIFY; // 15578
                                                END;
                                            END;
                                        END;
                                    // 15578 VALIDATE("MRP Price");
                                    //ND Tri1.0 End Cust 29


                                    //ND Tri1.0 START
                                    IF Type = Type::Item THEN
                                        "Quantity in Sq. Mt." := Item.UomToSqm("No.", "Unit of Measure Code", Quantity);
                                    IF Type = Type::Item THEN
                                        "Quantity in Cartons" := Item.UomToCart("No.", "Unit of Measure Code", Quantity);

                                end;
                        end;
                    end;
                }

         */
        //Unsupported feature: Code Modification on ""Amount Including Tax"(Field 13722).OnValidate".// FIELD NOT FOUND IN BC

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Type);
        TESTFIELD(Quantity);
        TESTFIELD("Unit Price");
        #4..25
        END;

        IF "Tax Base Amount" = 0 THEN
          "Tax %" := 0;
        InitOutstandingAmount;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..28
          "Tax %" := 0
        ELSE
          "Tax %" := ROUND(100 * ("Amount Including Tax" - "Tax Base Amount") / "Tax Base Amount",Currency."Amount Rounding Precision");

        InitOutstandingAmount;
        */
        //end;






        //Unsupported feature: Property Deletion (CaptionML) on ""Price Inclusive of Tax"(Field 16541)".
        modify("Unit Price Incl. of Tax")// 15578
        {
            trigger OnAfterValidate()
            begin
                TestStatusOpen;
                IF "Price Inclusive of Tax" THEN BEGIN
                    VALIDATE("Line Discount %");
                    //Upgrade(+)
                    VALIDATE("Quantity Discount %");//SHAKTI
                                                    //Upgrade(-)
                END;
            end;
        }
        field(50002; "Quantity in Cartons";
        Decimal)
        {
        }
        field(50003; "Type Code"; Code[2])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Type Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Type Code", DimensionValue.Code);
            end;
        }
        field(50004; "Plant Code"; Code[1])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Plant Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Plant Code", DimensionValue.Code);
            end;
        }
        field(50005; "Size Code"; Code[3])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Size Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Size Code", DimensionValue.Code);
            end;
        }
        field(50006; "Posting Date1"; Date)
        {
            Description = 'report  S15';
        }
        field(50007;
        Schemes;
        Code[20])
        {
            Description = 'Customization No. 47';
            TableRelation = "Item Charge";
        }
        field(50008;
        "Color Code";
        Code[4])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Color Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Color Code", DimensionValue.Code);
            end;
        }
        field(50009;
        "Design Code";
        Code[4])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Design Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Design Code", DimensionValue.Code);
            end;
        }
        field(50010;
        "Packing Code";
        Code[2])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Packing Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Packing Code", DimensionValue.Code);
            end;
        }
        field(50011;
        "Quality Code";
        Code[1])
        {

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Quality Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Quality Code", DimensionValue.Code);
            end;
        }
        field(50012;
        "Salesperson Code";
        Code[10])
        {
        }
        field(50013;
        "Quantity in Sq. Mt.";
        Decimal)
        {
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(50014;
        "Main Location";
        Code[10])
        {
        }
        field(50015; "Buyer's Price"; Decimal)
        {
            Editable = false;
            DecimalPlaces = 0 : 2;
        }
        field(50016; "Discount Per Unit"; Decimal)
        {
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                //Vipul Tri1.0
                IF xRec."Discount Per Unit" <> "Discount Per Unit" THEN
                    TestStatusOpen;
                IF "Unit Price" <> 0 THEN BEGIN
                    "Line Discount %" := (("Discount Per Unit" * 100) / "Unit Price");
                    // VALIDATE("Quantity Discount %", ("Discount Per Unit" * 100) / "Unit Price");//SHAKTI
                END;
                //Vipul Tri1.0
            end;
        }
        field(50018; "Related Location code"; Code[20])
        {
        }
        field(50019; "Unit Price (FCY)"; Decimal)
        {
            Caption = 'Unit Price (FCY) Per Sq.Mt.';
            Description = 'ND';

            trigger OnValidate()
            begin
                TESTFIELD("Quantity in Sq. Mt.");
                "Amount (FCY)" := "Quantity in Sq. Mt." * "Unit Price (FCY)";
            end;
        }
        field(50020; "Amount (FCY)"; Decimal)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50021; "Carton No. From"; Integer)
        {
            Description = 'ND';
        }
        field(50022; "Carton No. To"; Integer)
        {
            Description = 'ND';

            trigger OnValidate()
            begin
                TESTFIELD("Carton No. From");

                IF "Carton No. From" > "Carton No. To" THEN
                    ERROR('''Carton No. To'' can not be less than ''Carton No. From''');

                "Total Cartons" := "Carton No. To" - "Carton No. From" + 1;
            end;
        }
        field(50023; "Pallet No. From"; Integer)
        {
            Description = 'ND';
        }
        field(50024; "Pallet No. To"; Integer)
        {
            Description = 'ND';

            trigger OnValidate()
            begin
                TESTFIELD("Pallet No. From");

                IF "Pallet No. From" > "Pallet No. To" THEN
                    ERROR('''Pallet No. To'' can not be less than ''Pallet No. From''');

                "Total Pallets" := "Pallet No. To" - "Pallet No. From" + 1;
            end;
        }
        field(50025; "Total Pallets"; Integer)
        {
            Description = 'ND';
        }
        field(50026; "Total Cartons"; Integer)
        {
            Description = 'ND';
        }
        field(50028; "Group Code"; Code[2])
        {
            Editable = false;
        }
        field(50029; "Item Type"; Code[2])
        {
            Description = 'tri LM 100308';
        }
        field(50030; "Type Catogery Code"; Code[2])
        {
            Description = 'Tri NM 160308';

            trigger OnLookup()
            begin
                InventorySetup.GET;
                DimensionValue.RESET;
                DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Type Catogery Code");
                IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                    VALIDATE("Type Catogery Code", DimensionValue.Code);
            end;
        }
        field(50031; "Order Qty"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE("Document Type" = FILTER(Order),
                                                                            "Blanket Order No." = FIELD("Document No."),
                                                                            "Blanket Order Line No." = FIELD("Line No.")));
            Description = 'TRI DP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50032; "Remaining Inventory"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No."),
                                                                              "Location Code" = FIELD("Location Code"),
                                                                              "Variant Code" = FIELD("Variant Code"),
                                                                              Open = FILTER(true)));
            Description = 'TRI DP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50033; "Total Reserved Quantity"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Item No." = FIELD("No."),
                                                                           "Location Code" = FIELD("Location Code"),
                                                                           "Source Type" = FILTER(32),
                                                                           "Variant Code" = FIELD("Variant Code")));
            Description = 'TRI DP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50034; "Quantity in Sq. Mt.(Ship)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50035; "Quantity in Cartons(Ship)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50036; "Quantity in Hand SQM"; Decimal)
        {
            Editable = false;
        }
        field(50037; "Quantity in Blanket Order"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Quantity" WHERE("Document Type" = FILTER("Blanket Order"),
                                                                         Type = FILTER(Item),
                                                                         "No." = FIELD("No."),
                                                                         "Location Code" = FIELD("Location Code"),
                                                                         "Variant Code" = FIELD("Variant Code"),
                                                                         Status = FILTER(Released)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50038; Status; Option)
        {
            Caption = 'Status';
            Description = 'No In Use';
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Price Approved,Credit Approval Pending,Credit Approved,Not in Inventory,Approved';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment","Price Approved","Credit Approval Pending","Credit Approved","Not in Inventory",Approved;
        }
        field(50039; "Gross Weight (Ship)"; Decimal)
        {
            Caption = 'Gross Weight (Ship)';
            DecimalPlaces = 0 : 5;
            Editable = false;

            trigger OnValidate()
            begin
                //Vipul Tri1.0 Start
                "Gross Weight (Ship)" := ROUND("Gross Weight (Ship)", 0.001, '=');
                //Vipul Tri 1.0 End
            end;
        }
        field(50040; "Net Weight (Ship)"; Decimal)
        {
            Caption = 'Net Weight (Ship)';
            DecimalPlaces = 0 : 5;
            Editable = false;

            trigger OnValidate()
            begin
                //Vipul Tri1.0 Start
                "Net Weight (Ship)" := ROUND("Net Weight (Ship)", 0.001, '=');
                //Vipul Tri 1.0 End
            end;
        }
        field(50041; "Discount Per SQ.MT"; Decimal)
        {

            trigger OnValidate()
            begin
                //TRI P.G 22.04.2010 -- NEW CODE ADDED
                VALIDATE("Discount Per Unit", ("Discount Per SQ.MT" * "Qty. per Unit of Measure"));
                //TRI P.G 22.04.2010 -- NEW CODE ADDED
            end;
        }
        field(50042; "Quantity in Hand CRT"; Decimal)
        {
            Editable = false;
        }
        field(50043; "Order Qty (CRT)"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Quantity" WHERE("Document Type" = FILTER(Order),
                                                                         "Blanket Order No." = FIELD("Document No."),
                                                                         "Blanket Order Line No." = FIELD("Line No.")));
            DecimalPlaces = 0 : 2;
            Description = 'TRI DP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50044; "Default Prod. Plant Code"; Code[10])
        {
            Description = 'TRI S.K 050610';
        }
        field(50045; COCO; Boolean)
        {
            Description = 'Ori ut 05-08-10';
            Editable = true;
        }
        field(50060; "Sales Type"; Option)
        {
            Editable = true;
            OptionCaption = ' ,Retail,Govt,Private';
            OptionMembers = " ",Retail,Govt,Private;
        }
        field(50061; "AD Remarks"; Text[30])
        {
            Description = 'Remarks for Sales Line';
            TableRelation = "Reason Code" WHERE(Remarks = CONST(true));
        }
        field(50062; "Vendor Code"; Code[11])
        {
            TableRelation = "Transport Method".Code WHERE("Morbi Vendor" = FILTER(true));
        }
        field(50063; "Shipped Gross Weight"; Decimal)
        {
            CalcFormula = Lookup("Sales Shipment Line"."Gross Weight" WHERE("Order No." = FIELD("Document No."),
                                                                             "No." = FIELD("No."),
                                                                             "Line No." = FIELD("Line No.")));
            Description = 'For TMS';
            FieldClass = FlowField;
        }
        field(50064; "Outstanding Gross Weight"; Decimal)
        {
            Description = 'For TMS';
        }
        field(50065; "Despatch Periority"; Code[2])
        {
            DataClassification = ToBeClassified;
        }
        field(50066; "Morbi Batch No."; Code[8])
        {
            DataClassification = ToBeClassified;
            Description = 'Morbi Batch No.';
        }
        field(60000; "TDS Nature of Deduction"; Code[10])
        {
            Description = 'TRI TDS DG 290710';
            //TableRelation = "Customer Allowed Sections";
            TableRelation = "Customer Allowed Sections" where("Customer No" = field("Sell-to Customer No."));

            trigger OnValidate()
            var
                CustomerAllowedSection: Record "Customer Allowed Sections";
            begin
                CustomerAllowedSection.Reset;
                CustomerAllowedSection.SetRange("Customer No", Rec."Sell-to Customer No.");
                if CustomerAllowedSection.FindFirst then
                    Rec."TDS Nature of Deduction" := CustomerAllowedSection."TDS Section";

                CalculateTDS;
            end;

            /* trigger OnLookup()
             begin
                 NODLines.RESET;
                 NODLines.SETRANGE(Type, NODLines.Type::Customer);
                 NODLines.SETRANGE("No.", "Sell-to Customer No.");
                 NODLines.SETFILTER("TDS Group", '<>%1', NODLines."TDS Group"::Others);
                 IF NODLines.FIND('-') THEN
                     REPEAT
                         TDSNOD.RESET;
                         TDSNOD.SETRANGE(TDSNOD.Code, NODLines."NOD/NOC");
                         IF TDSNOD.FIND('-') THEN
                             TDSNOD.MODIFYALL(Mark, TRUE);
                         COMMIT;
                     UNTIL NODLines.NEXT = 0;

                 TDSNOD.RESET;
                 TDSNOD.SETRANGE(Mark, TRUE);
                 IF PAGE.RUNMODAL(PAGE::"TDS Nature of Deductions", TDSNOD) = ACTION::LookupOK THEN BEGIN
                     "TDS Nature of Deduction" := TDSNOD.Code;
                     //"TDS Category" := TDSNOD.Category;
                     "TDS Group" := TDSNOD."TDS Group";
                 END;
                 VALIDATE("TDS Nature of Deduction");
             end;

             trigger OnValidate()
             begin
                 TDSNOD.MODIFYALL(Mark, FALSE);
                 NODLines.RESET;
                 NODLines.SETRANGE(Type, NODLines.Type::Customer);
                 NODLines.SETRANGE("No.", "Sell-to Customer No.");
                 NODLines.SETRANGE(NODLines."NOD/NOC", "TDS Nature of Deduction");
                 NODLines.SETFILTER("TDS Group", '<>%1', NODLines."TDS Group"::Others);
                 IF NOT NODLines.FIND('-') THEN
                     ERROR(Text035);
                 CalculateTDS;
             end;*/
        }
        field(60001; "TDS Group"; Option)
        {
            Description = 'TRI TDS DG 290710';
            OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Others';
            OptionMembers = " ",Contractor,Commission,Professional,Interest,Rent,Others;
        }
        field(60002; "TDS Amount Including Surcharge"; Decimal)
        {
            Description = 'TRI TDS DG 290710';
        }
        field(60003; "Balance Surcharge Amount"; Decimal)
        {
            Description = 'TRI TDS DG 290710';
        }
        field(60004; Remarks; Text[38])
        {
            Description = 'TRI DG 290710';
        }
        field(60005; "Releasing Date"; Date)
        {
            CalcFormula = Lookup("Sales Header"."Releasing Date" WHERE("Document Type" = FIELD("Document Type"),
                                                                        "No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(60006; "Customer Name"; Text[50])
        {
            CalcFormula = Lookup("Sales Header"."Sell-to Customer Name" WHERE("Document Type" = FIELD("Document Type"),
                                                                               "No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(60007; City; Text[30])
        {
            CalcFormula = Lookup("Sales Header"."Sell-to City" WHERE("Document Type" = FIELD("Document Type"),
                                                                      "No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(60008; "State Name"; Text[50])
        {
            // CalcFormula = Lookup(State.Description WHERE(Code = FIELD(State)));
            // FieldClass = FlowField;
        }
        field(60010; "Offer Code"; Code[10])
        {
            Editable = false;
        }
        field(60011; Slab; Code[10])
        {
            Editable = false;
        }
        field(60013; "Quantity Discount %"; Decimal)
        {
            Caption = 'Quantity Discount %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin

                //Shakti-Start

                IF NOT "Price Inclusive of Tax" THEN
                    "Quantity Discount Amount" :=
                     ROUND(ROUND(Quantity * "Unit Price", Currency."Amount Rounding Precision") * "Quantity Discount %" / 100,
                     Currency."Amount Rounding Precision")
                ELSE
                    "Quantity Discount Amount" := ROUND(ROUND(Quantity * "Unit Price Incl. of Tax", Currency."Amount Rounding Precision") *
                      "Quantity Discount %" / 100, Currency."Amount Rounding Precision");
                "Inv. Discount Amount" := 0;
                "Inv. Disc. Amount to Invoice" := 0;

                UpdateAmounts;

                //SHAKTI -End
            end;
        }
        field(60014; "Quantity Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Quantity Discount Amount';
            Editable = false;

            trigger OnValidate()
            begin
                //Shakti-Start
                IF xRec."Quantity Discount Amount" <> "Quantity Discount Amount" THEN
                    TestStatusOpen;
                IF NOT "Price Inclusive of Tax" THEN
                    IF ROUND(Quantity * "Unit Price", Currency."Amount Rounding Precision") <> 0 THEN
                        "Quantity Discount %" := ROUND(
                           "Quantity Discount Amount" / ROUND(Quantity * "Unit Price", Currency."Amount Rounding Precision") * 100,
                            0.00001)
                    ELSE
                        "Quantity Discount %" := 0
                ELSE
                    IF ROUND(Quantity * "Unit Price Incl. of Tax", Currency."Amount Rounding Precision") <> 0 THEN
                        "Quantity Discount %" :=
                          ROUND(
                           "Quantity Discount Amount" / ROUND(Quantity * "Unit Price Incl. of Tax", Currency."Amount Rounding Precision") * 100,
                            0.00001)
                    ELSE
                        "Quantity Discount %" := 0;
                "Inv. Discount Amount" := 0;
                "Inv. Disc. Amount to Invoice" := 0;
                UpdateAmounts;

                //Shakti-End
            end;
        }
        field(60015; "Accrued Quantity"; Decimal)
        {
            Editable = false;
        }
        field(60016; "Calculate Line Discount"; Boolean)
        {
            Editable = true;
        }
        field(60017; "Accrued Discount"; Decimal)
        {
            Editable = false;
        }
        field(60019; "Structure Calculated"; Boolean)
        {
            Description = 'MS-PB';
        }
        field(60030; "Scheme Group Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('SCHEMECODE'));
        }
        field(60049; "PreApproved Discount"; Decimal)
        {
        }
        field(60050; D1; Decimal)
        {
            trigger OnValidate()
            begin
                GetSalesHeader;
                SalesHeader.TESTFIELD(SalesHeader.Status, SalesHeader.Status::Open);
                CheckADDiscountLimits;
                UpdateDiscountAmt;
            end;
        }
        field(60051; D2; Decimal)
        {

            trigger OnValidate()
            begin
                GetSalesHeader;
                SalesHeader.TESTFIELD(SalesHeader.Status, SalesHeader.Status::Open);

                CheckADDiscountLimits;
                UpdateDiscountAmt;
            end;
        }
        field(60052; D3; Decimal)
        {

            trigger OnValidate()
            begin
                GetSalesHeader;
                SalesHeader.TESTFIELD(SalesHeader.Status, SalesHeader.Status::Open);

                CheckADDiscountLimits;
                UpdateDiscountAmt;
            end;
        }
        field(60053; D4; Decimal)
        {

            trigger OnValidate()
            begin
                GetSalesHeader;
                SalesHeader.TESTFIELD(SalesHeader.Status, SalesHeader.Status::Open);

                CheckADDiscountLimits;
                UpdateDiscountAmt;
            end;
        }
        field(60054; S1; Decimal)
        {

            trigger OnValidate()
            begin
                IF S1 > 0 THEN
                    ERROR('Amount must be Negative');
                GetSalesHeader;
                SalesHeader.TESTFIELD(SalesHeader.Status, SalesHeader.Status::Open);

                UpdateDiscountAmt;
            end;
        }
        field(60055; "Discount Amt 1"; Decimal)
        {
            Editable = false;
        }
        field(60056; "Discount Amt 2"; Decimal)
        {
            Editable = false;
        }
        field(60057; "Discount Amt 3"; Decimal)
        {
            Editable = false;
        }
        field(60058; "Discount Amt 4"; Decimal)
        {
            Editable = false;
        }
        field(60059; "System Discount Amount"; Decimal)
        {
            Description = 'Treated as D5';
            Editable = false;
        }
        field(60060; "Unit Price Excl. VAT/Sq.Mt"; Decimal)
        {
        }
        field(60061; "Buyer's Price /Sq.Mt"; Decimal)
        {

        }
        field(60062; D6; Decimal)
        {
            Caption = 'D6';

            trigger OnValidate()
            begin
                IF D6 > 0 THEN
                    ERROR('Amount must be Negative');
                GetSalesHeader;
                SalesHeader.TESTFIELD(SalesHeader.Status, SalesHeader.Status::Open);

                UpdateDiscountAmt;
            end;
        }
        field(60063; "Discount Amt 6"; Decimal)
        {
            Caption = 'Discount Amt 6';
            Editable = false;
        }
        field(60064; D7; Decimal)
        {
            Caption = 'D7';

            trigger OnValidate()
            begin
                GetSalesHeader;
                //SalesHeader.TESTFIELD(SalesHeader.Status,SalesHeader.Status::Open);
                "Approval Required" := FALSE;
                //IF D7> GetAdditionDiscount("Sell-to Customer No.","No.") THEN //MSKS22072019
                // "Approval Required":= TRUE;

                AllocateRequestedDiscount(D7);
                //UpdateDiscountAmt;
            end;
        }
        field(60065; "Discount Amt 7"; Decimal)
        {
            Caption = 'Discount Amt 7';
            Editable = false;
        }
        field(60067; "Approval Required"; Boolean)
        {
        }
        field(60068; Batch; Code[13])
        {
        }
        field(60069; "Status Updated"; Option)
        {
            CalcFormula = Lookup("Sales Header".Status WHERE("Document Type" = FIELD("Document Type"),
                                                              "No." = FIELD("Document No.")));
            FieldClass = FlowField;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Price Approved';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment","Price Approved";
        }
        field(60070; "Make Order Date"; DateTime)
        {
            CalcFormula = Lookup("Sales Header"."Make Order Date" WHERE("Document Type" = FIELD("Document Type"),
                                                                         "No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(60072; "PreApproved Discount Amount"; Decimal)
        {
        }
        field(60080; "Transfer No."; Code[20])
        {
            Description = 'MSVRN 13012020';
        }
        field(60081; "Transfer Line No."; Integer)
        {
            Description = 'MSVRN 13012020';
        }
        field(60082; "Itemr Change Remarks"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Order Change Remarks';
            TableRelation = "Reason Code" WHERE("Item Change Remarks" = CONST(true));
        }
        field(60083; "Status Hdr"; Option)
        {
            CalcFormula = Lookup("Sales Header".Status WHERE("Document Type" = FIELD("Document Type"),
                                                              "No." = FIELD("Document No.")));
            FieldClass = FlowField;
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment","Price Approved","Credit Approval Pending","Credit Approved","Not in Inventory",Approved;
        }
        field(60301; "Trade Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60302; "Structure Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60303; "Line Discount Amount 1"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60304; "Line Amount 1"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60305; "Line Amount Per Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70000; "TCS Base Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MIPL-Rohan 270821';
        }
        field(70001; "Calculate TCS"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'MIPL-Rohan 270821';
        }
        field(70002; MRP; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70003; "MRP Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70004; "Charge Item Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70005; "No. 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account"), "System-Created Entry" = CONST(false)) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                          Blocked = CONST(false))
            ELSE
            IF (Type = CONST("G/L Account"),
                                                                                                   "System-Created Entry" = CONST(true)) "G/L Account"
            ELSE
            IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge" where("Structure Type " = const(sales));

            trigger OnValidate()
            begin
                Validate("No.", "No. 2");
            end;
        }
        field(70006; "Charge Item"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70007; "Complete Description"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(90004; "Amount Inc CD"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {


        /* key(Key1; "Document Type", "Variant Code", "Location Code", "No.", Type, Status)
         {
             SumIndexFields = "Outstanding Quantity";
         }*/
        key(Key2; "Plant Code")
        {
        }
        /*  key(Key3; "Design Code", "Color Code", "Quality Code", "Size Code", "Packing Code", "Sell-to Customer No.")
          {
          }
          key(Key4; "Sell-to Customer No.", "Document No.")
          {
          }*/
        key(Key5; "Size Code")
        {
        }
        key(Key6; "Default Prod. Plant Code")
        {
        }
        /* key(Key7; "Document No.", "No.")
         {
         }
         key(Key8; State, "Posting Date1")
         {
             SumIndexFields = Quantity;
         }*/
        key(Key9;/* State,*/ "Size Code", "Posting Date1")
        {
        }
        key(Key10; "Plant Code", "Size Code")
        {
        }
        /*  key(Key11; "Document Type", "Bill-to Customer No.", Status)
          {
              SumIndexFields = "Outstanding Amount (LCY)";
          }
          key(Key12; "Plant Code", Description)
          {
          }*/
    }



    trigger OnBeforeDelete()
    var
        RecSalesHeader: Record "Sales Header";
        RecItemCharge: Record "Item Charge";
    begin
        //TEAM 14763
        RecSalesHeader.Reset;
        RecSalesHeader.SetRange("No.", Rec."Document No.");
        if RecSalesHeader.FindFirst then begin
            RecSalesHeader."Trade Discount" := 0;
            RecSalesHeader."Calculate Structure" := false;
            RecSalesHeader.Modify;
        end;
        //TEAM 14763


        //Upgrade(+)

        //ND Tri Start Cust 38
        CALCFIELDS("Reserved Quantity");
        IF "Document Type" = "Document Type"::Quote THEN
            UserAccess := 0;
        IF SalesHeader11.GET("Document Type"::Order, "Document No.") THEN
            //TRIRJ-MC IF ("Document Type" = "Document Type"::Order) AND (NOT SalesHeader11."Export Document")THEN
            IF ("Document Type" = "Document Type"::Order) THEN//TRIRJ-MC
                UserAccess := 1;
        IF "Document Type" = "Document Type"::Invoice THEN
            UserAccess := 2;
        IF "Document Type" = "Document Type"::"Credit Memo" THEN
            UserAccess := 3;
        IF "Document Type" = "Document Type"::"Blanket Order" THEN
            UserAccess := 4;
        IF "Document Type" = "Document Type"::"Return Order" THEN
            UserAccess := 5;
        IF SalesHeader11.GET("Document Type"::Order, "Document No.") THEN
            //TRIRJ-MC IF ("Document Type" = "Document Type"::Order) AND (SalesHeader11."Export Document") THEN
            IF ("Document Type" = "Document Type"::Order) THEN//TRIRJ-MC
                UserAccess := 35;
        IF "Location Code" <> '' THEN BEGIN
            Permissions.Type(UserAccess, xRec."Location Code");
            Permissions.Type(UserAccess, "Location Code");
        END;
        //ND Tri End Cust 38

        //Upgrade(-)
        IF "Document Type" <> "Document Type"::"Blanket Order" THEN
            UpdatedForApp;
        GetSalesHeader;
        IF UPPERCASE(USERID) <> 'fa028' THEN
            IF SalesHeader.Status = Status::Released THEN
                IF SalesHeader."Reason Code" = '' THEN
                    ERROR('You cannot Delete');
    end;

    trigger OnAfterDelete()
    var
        RecSalesHeadder: Record 36;
    begin
        if rec.Type = Rec.Type::"Charge (Item)" then begin
            RecSalesHeadder.reset;
            RecSalesHeadder.SetRange("No.", Rec."Document No.");
            if RecSalesHeadder.FindFirst() then begin
                RecSalesHeadder."Calculate Structure" := false;
                RecSalesHeadder.Modify;
            end;
        end;
    end;

    trigger OnAfterInsert()// 15578
    var
        Text056: Label 'You cannot add an item line because an open inventory pick exists for the Sales Header and because Shipping Advice is %1.\\You must first post or delete the inventory pick or change Shipping Advice to Partial.';
    begin
        TestStatusOpen;
        //GetSalesHeader;
        SalesHeader.Get(Rec."Document Type", Rec."Document No.");

        IF (UPPERCASE(USERID) <> 'ADMIN') AND (UPPERCASE(USERID) <> 'FA028') AND (UPPERCASE(USERID) <> 'IT005') THEN
            IF "Line No." > 2500000 THEN
                ERROR('1%', 'Sorry!!!!! You can select only 24 Line'); //Kulbhushan

        //"Sell-to Customer No." := SalesHeader."Sell-to Customer No.";

        TestStatusOpen;

        // GetSalesHeader;  // omsh + - block 1 line
        //Upgrade(-)
        //  IF SalesHeader."Free Supply" THEN
        TESTFIELD("Price Inclusive of Tax", FALSE);
        IF "Price Inclusive of Tax" THEN BEGIN
            //  SalesHeader.TESTFIELD("VAT Exempted", FALSE);
            //  SalesHeader.TESTFIELD("Export or Deemed Export", FALSE);
        END;

        //Upgrade(+)
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
            //  SalesHeader.TESTFIELD(Structure);
            SalesHeader.TESTFIELD(Status, Status::Open); //MSKS2608s
                                                         //Upgrade(-)

        //MSRG 18.10.21 START
        IF "Document Type" = "Document Type"::Order THEN
            "Calculate TCS" := TRUE;
        //MSRG 18.10.21 END

        IF (Quantity <> 0) THEN
            ReserveSalesLine.VerifyQuantity(Rec, xRec);

        LOCKTABLE;
        SalesHeader."No." := '';
        IF Type = Type::Item THEN
            IF SalesHeader.InventoryPickConflict("Document Type", "Document No.", SalesHeader."Shipping Advice") THEN
                ERROR(Text056, SalesHeader."Shipping Advice");
        //Upgrade(+)
        //ND Tri Start Cust 38
        IF "Document Type" = "Document Type"::Quote THEN
            UserAccess := 0;
        IF SalesHeader11.GET("Document Type"::Order, "Document No.") THEN
            IF ("Document Type" = "Document Type"::Order) THEN
                UserAccess := 1;
        IF "Document Type" = "Document Type"::Invoice THEN
            UserAccess := 2;
        IF "Document Type" = "Document Type"::"Credit Memo" THEN
            UserAccess := 3;
        IF "Document Type" = "Document Type"::"Blanket Order" THEN
            UserAccess := 4;
        IF "Document Type" = "Document Type"::"Return Order" THEN
            UserAccess := 5;
        IF SalesHeader11.GET("Document Type"::Order, "Document No.") THEN
            IF ("Document Type" = "Document Type"::Order) THEN
                UserAccess := 35;
        //GetSalesHeader;
        Permissions.Type(UserAccess, SalesHeader."Location Code");

        //ND Tri End Cust 38

        //Vipul Tri1.0 Start
        IF Location3.GET("Location Code") THEN
            "Related Location code" := Location3."Related Location Code";
        //Vipul Tri1.0 End
        //Upgrade(-)
        //TEAM 14763 "Location Code" := SalesHeader."Location Code";//Oriut
        UpdatedForApp;
    end;

    trigger OnAfterModify()
    begin
        //Upgrade(+)

        //ND Tri Start Cust 38
        IF "Document Type" = "Document Type"::Quote THEN
            UserAccess := 0;
        IF SalesHeader11.GET("Document Type"::Order, "Document No.") THEN
            //TRIRJ-MC  IF ("Document Type" = "Document Type"::Order) AND (NOT SalesHeader11."Export Document")THEN
            IF ("Document Type" = "Document Type"::Order) THEN//TRIRJ-MC
                UserAccess := 1;
        IF "Document Type" = "Document Type"::Invoice THEN
            UserAccess := 2;
        IF "Document Type" = "Document Type"::"Credit Memo" THEN
            UserAccess := 3;
        IF "Document Type" = "Document Type"::"Blanket Order" THEN
            UserAccess := 4;
        IF "Document Type" = "Document Type"::"Return Order" THEN
            UserAccess := 5;
        IF SalesHeader11.GET("Document Type"::Order, "Document No.") THEN
            //TRIRJ-MC  IF ("Document Type" = "Document Type"::Order) AND (SalesHeader11."Export Document") THEN
            IF ("Document Type" = "Document Type"::Order) THEN//TRIRJ-MC
                UserAccess := 35;
        GetSalesHeader;
        IF "No." <> '' THEN BEGIN
            IF xRec."Location Code" <> '' THEN
                Permissions.Type(UserAccess, xRec."Location Code");
            Permissions.Type(UserAccess, "Location Code");
        END;
        //END;
        //TRI 22.02.08 N.K Add Start
        refQtyinhand;
        //MS-PB BEGIN 161112
        IF "Structure Calculated" = TRUE THEN BEGIN
            "Structure Calculated" := FALSE;
            MODIFY;
        END;
    end;

    trigger OnAfterRename()
    begin
        //ND Tri Start Cust 38
        UserLocation.RESET;
        IF NOT UserLocation.GET(USERID, "Location Code") THEN
            ERROR('You cannot modify this sales order because you do not have access to %1 location', "Location Code");
        //ND Tri End Cust 38

    end;


    //Unsupported feature: Code Modification on "InitQtyToShip(PROCEDURE 15)".Codeunit 50000

    //procedure InitQtyToShip();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetSalesSetup;
    IF (SalesSetup."Default Quantity to Ship" = SalesSetup."Default Quantity to Ship"::Remainder) OR
       ("Document Type" = "Document Type"::Invoice)
    THEN BEGIN
      "Qty. to Ship" := "Outstanding Quantity";
      "Qty. to Ship (Base)" := "Outstanding Qty. (Base)";
    END ELSE
      IF "Qty. to Ship" <> 0 THEN
        "Qty. to Ship (Base)" := CalcBaseQty("Qty. to Ship");

    CheckServItemCreation;

    InitQtyToInvoice;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    //  "Qty. to Ship" := "Outstanding Quantity";
    //  "Qty. to Ship (Base)" := "Outstanding Qty. (Base)";
    //Upgrade(+)
      "Qty. to Ship" := "Outstanding Quantity" - "Order Qty (CRT)";
      "Qty. to Ship (Base)" := "Outstanding Qty. (Base)" - "Order Qty";
    //Upgrade(-)

    #7..13
    */
    //end;




    procedure "--TRI"()
    begin
    end;

    procedure InventoryUpdate(SalesHeader: Record "Sales Header")
    var
        recSalesLine: Record "Sales Line";
    begin
        /*
        recSalesLine.RESET;
        recSalesLine.SETRANGE("Document Type",recSalesLine."Document Type" :: "Blanket Order");
        recSalesLine.SETRANGE("Document No.",SalesHeader."No.");
        recSalesLine.SETRANGE(Type,recSalesLine.Type :: Item);
        recSalesLine.SETFILTER("No.",'<>%1','');
        IF recSalesLine.FIND('-') THEN REPEAT
          recSalesLine."Remaining Inventory" := 0;
          recSalesLine."Total Reserved Quantity" := 0;
          recSalesLine."After Allocation Inventory" := 0;
          decRemainingQty := 0;
          decReservedQty := 0;
        
          recILE.RESET;
          recILE.SETRANGE("Item No.",recSalesLine."No.");
          recILE.SETRANGE("Location Code",recSalesLine."Location Code");
          IF recILE.FIND('-') THEN REPEAT
            recILE.CALCFIELDS("Reserved Quantity");
            decRemainingQty += recILE."Remaining Quantity";
            decReservedQty += recILE."Reserved Quantity";
          UNTIL recILE.NEXT = 0;
          recSalesLine."Remaining Inventory" := decRemainingQty;
          recSalesLine."Total Reserved Quantity" := decReservedQty;
          recSalesLine."After Allocation Inventory" := decRemainingQty - decReservedQty;
          recSalesLine.MODIFY;
        UNTIL recSalesLine.NEXT = 0;
        */

    end;

    procedure refQtyinhand()
    var
        TgSalesLine: Record "Sales Line";
    begin
        EXIT; //Kulbhushan
        //TRI
        TgSalesLine.RESET;
        TgSalesLine.SETRANGE("Document Type", "Document Type"::"Blanket Order");
        TgSalesLine.SETRANGE("Document No.", "No.");
        IF TgSalesLine.FIND('-') THEN
            REPEAT
                TgSalesLine.CALCFIELDS("Remaining Inventory", "Total Reserved Quantity");
                TgSalesLine."Quantity in Hand SQM" := (TgSalesLine."Remaining Inventory" - (
                                                  TgSalesLine."Total Reserved Quantity"));
                TgSalesLine."Quantity in Hand CRT" := ROUND((TgSalesLine."Remaining Inventory" / TgSalesLine."Qty. per Unit of Measure") - (
                                                          TgSalesLine."Total Reserved Quantity" / TgSalesLine."Qty. per Unit of Measure"), 1, '=');
                TgSalesLine.MODIFY;
            UNTIL TgSalesLine.NEXT = 0;
        //TRI
    end;

    procedure SetRec(var CustInvDiscRec: Record "Cust. Invoice Disc.")
    begin
        //mo tri1.0 start
        CustInvDisc := CustInvDiscRec;
        //mo tri1.0 end
        /*SalesLine.CalculateStructures(Rec);
        SalesLine.AdjustStructureAmounts(Rec);
        SalesLine.UpdateSalesLines(Rec);*/

    end;

    procedure GetSalesPriceInLine()
    var
        SalesPrice: Record "Sales Price";
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.GET("Document Type", "Document No.");
        SalesPrice.RESET;
        SalesPrice.SETFILTER(SalesPrice."Item No.", "No.");
        SalesPrice.SETFILTER("Sales Type", '%1|%2', SalesPrice."Sales Type"::"Customer Price Group"
        , SalesPrice."Sales Type"::Customer);
        SalesPrice.SETFILTER(SalesPrice."Sales Code", '%1|%2', "Customer Price Group", "Sell-to Customer No.");
        SalesPrice.SETFILTER(SalesPrice."Starting Date", '..%1', SalesHeader."Order Date");
        SalesPrice.SETFILTER(SalesPrice."Ending Date", '%1|%2..', 0D, SalesHeader."Posting Date");
        SalesPrice.SETFILTER(SalesPrice."Unit of Measure Code", "Unit of Measure Code");
        IF SalesPrice.FINDLAST THEN BEGIN
            VALIDATE("MRP Price", ROUND(SalesPrice."MRP Price", 1));
            MRP := TRUE;
            VALIDATE("Unit Price", ROUND(SalesPrice."Unit Price", 0.01));   //TRI DG 020810
        END ELSE BEGIN
            VALIDATE("Unit Price", 0);
            MRP := FALSE;
        END;
    end;

    procedure CalculateTDS()
    var
        // 15578 TDSGroup: Record 13731;
        DateFilterCalc: Codeunit "DateFilter-Calc";
        CurrentDate: Date;
        AccountingPeriodFilter: Text[30];
        FiscalYear: Text[30];
        PreviousTDSAmt: Decimal;
        PreviousSurchargeAmt: Decimal;
        OrderAmount: Decimal;
        CurrentJnlTDSAmt: Decimal;
        CurrentJnlAmount: Decimal;
        CurrentJnlSurChargeamt: Decimal;
        AppliedTDSAmount: Decimal;
        AppliedWorkTaxAmount: Decimal;
        AppliedSurchargeAmount: Decimal;
        CalculatedTDSAmt: Decimal;
        CalculatedSurchargeAmt: Decimal;
        CalculateSurcharge: Boolean;
        SurchargeBase: Decimal;
        RecCust: Record Customer;
        TDSDetail: Record "TDS Setup";
        TDSRates: Record "Tax Rate";
        TaxRateFilterManagement: Codeunit "Tax Rate Filter Mgmt.";

    //TDS Field


    begin
        IF ("Document Type" = "Document Type"::"Credit Memo") THEN BEGIN
            // 15578  TDSBuf[1].DELETEALL;
            CalculatedTDSAmt := 0;
            CalculatedSurchargeAmt := 0;
            SurchargeBase := 0;
            GetSalesHeader;

            DateFilterCalc.CreateFiscalYearFilter(AccountingPeriodFilter, FiscalYear, SalesHeader."Posting Date", 0);
            TDSEntry.RESET;
            // 15578  TDSEntry.SETCURRENTKEY("Party Type", "Party Code", "Posting Date", "TDS Group", "Assessee Code", Applied);
            TDSEntry.SETRANGE("Party Type", TDSEntry."Party Type"::Customer);
            TDSEntry.SETRANGE("Party Code", "Sell-to Customer No.");
            TDSEntry.SETFILTER("Posting Date", AccountingPeriodFilter);
            // 15578  TDSEntry.SETRANGE("TDS Group", "TDS Group");
            TDSEntry.SETRANGE("Assessee Code", "Assessee Code");
            TDSEntry.SETRANGE(Applied, FALSE);
            IF TDSEntry.FIND('-') THEN BEGIN
                TDSEntry.CALCSUMS("Invoice Amount");
                PreviousAmount := ABS(TDSEntry."Invoice Amount");
            END;

            // NAVIN
            TDSEntry.RESET;
            // 15578  TDSEntry.SETCURRENTKEY("Party Type", "Party Code", "Posting Date", "TDS Group", "Assessee Code");
            TDSEntry.SETRANGE("Party Type", TDSEntry."Party Type"::Customer);
            TDSEntry.SETRANGE("Party Code", "Sell-to Customer No.");
            TDSEntry.SETFILTER("Posting Date", AccountingPeriodFilter);
            // 15578  TDSEntry.SETRANGE("TDS Group", "TDS Group");
            TDSEntry.SETRANGE("Assessee Code", "Assessee Code");
            IF TDSEntry.FIND('-') THEN BEGIN
                TDSEntry.CALCSUMS("TDS Amount", "Surcharge Amount");
                PreviousTDSAmt := ABS(TDSEntry."TDS Amount");
                PreviousSurchargeAmt := ABS(TDSEntry."Surcharge Amount");
            END;

            SalesLine1.RESET;
            SalesLine1.SETRANGE("TDS Nature of Deduction", "TDS Nature of Deduction");
            SalesLine1.SETRANGE("Assessee Code", "Assessee Code");
            SalesLine1.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
            SalesLine1.SETFILTER("Line No.", '<>%1', "Line No.");
            IF SalesLine1.FIND('-') THEN
                REPEAT
                    CurrentJnlAmount := CurrentJnlAmount + ABS(SalesLine1.Amount);
                // 15578   CurrentJnlTDSAmt := CurrentJnlTDSAmt + ABS(SalesLine1."TDS/TCS Amount");
                // 15578   CurrentJnlSurChargeamt := CurrentJnlSurChargeamt + ABS(SalesLine1."Surcharge Amount");
                UNTIL SalesLine1.NEXT = 0;

            /*
            TDSDetail.RESET;
            TDSDetail.SETRANGE("TDS Nature of Deduction", "TDS Nature of Deduction");
            TDSDetail.SETRANGE("Assessee Code", "Assessee Code");
            TDSDetail.SETRANGE("TDS Group", "TDS Group");
            TDSDetail.SETRANGE("Effective Date", 0D, SalesHeader."Posting Date");
            */

            TDSRates.Reset;
            TDSRates.SetRange("Tax Type", 'TDS');
            if TDSRates.FindSet then begin
                //Clear(TaxRateFilterManagement);
                //TaxRateFilterManagement.OpenTaxRateFilter(TDSRates);
                if (StrPos(TDSRates."Tax Rate ID", 'IND') <> 0) then begin
                    if (StrPos(TDSRates."Tax Setup ID", 'CONT') <> 0) then begin
                        //CalculateTDSData;
                        //FormatLine(TDSRates.ID);
                    end;
                end;
            end;

            /*
              NODLines.RESET;
              NODLines.SETRANGE(Type, NODLines.Type::Customer);
              NODLines.SETRANGE("No.", "Sell-to Customer No.");
              NODLines.SETRANGE(NODLines."NOD/NOC", "TDS Nature of Deduction");
              IF NODLines.FIND('-') THEN BEGIN

                  IF NODLines."Concessional Rate" THEN
                      TDSDetail.SETRANGE("Concessional Rate", TRUE)
                  ELSE
                      TDSDetail.SETRANGE("Concessional Rate", FALSE);

                  TDSDetail.SETRANGE(TDSDetail."Concessional Code", NODLines."Concessional Code");
                  IF NOT TDSDetail.FIND('+') THEN BEGIN
                      "TDS/TCS %" := 0;
                      //"Work Tax %" := 0;
                      "Surcharge %" := 0;
                      "TDS/TCS Amount" := 0;
                      "Surcharge Amount" := 0;
                      //"Work Tax Amount" := 0;
                  END ELSE BEGIN
                      IF (SalesHeader."Applies-to Doc. No." = '') AND (SalesHeader."Applies-to ID" = '') THEN BEGIN
                          IF NODLines."Threshold Overlook" THEN BEGIN
                              "TDS/TCS Base Amount" := ABS("Line Amount" - "Inv. Discount Amount");
                              IF RecCust.GET("Sell-to Customer No.") THEN
                                  IF RecCust."P.A.N. No." = 'PANNOTAVBL' THEN
                                      "TDS/TCS %" := 20
                                  ELSE
                                      "TDS/TCS %" := TDSDetail."TDS %";
                              IF NODLines."Surcharge Overlook" THEN BEGIN
                                  "Surcharge Base Amount" := ABS("Line Amount" - "Inv. Discount Amount");
                                  "Surcharge %" := TDSDetail."Surcharge %";
                              END ELSE BEGIN
                                  TDSGroup.SETRANGE("TDS Group", "TDS Group");
                                  TDSGroup.SETRANGE("Effective Date", 0D, SalesHeader."Posting Date");
                                  TDSGroup.FIND('+');
                                  IF PreviousAmount > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                      "Surcharge Base Amount" := ABS("Line Amount" - "Inv. Discount Amount");
                                      "Surcharge %" := TDSDetail."Surcharge %";
                                      PreviousSurchargeAmt := 0;
                                  END ELSE BEGIN
                                      IF (PreviousAmount + ABS("Line Amount" - "Inv. Discount Amount")) > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                          "Surcharge Base Amount" := PreviousAmount + ABS("Line Amount" - "Inv. Discount Amount");
                                          "Surcharge %" := TDSDetail."Surcharge %";
                                          InsertGenTDSBuf(FALSE);  //TRI D
                                          IF "Surcharge %" <> 0 THEN
                                              CalculateSurcharge := TRUE;
                                          TDSEntry.RESET;
                                          TDSEntry.SETCURRENTKEY("Party Type", "Party Code", "Posting Date", "TDS Group", "Assessee Code", Applied);
                                          TDSEntry.SETRANGE("Party Type", TDSEntry."Party Type"::Customer);
                                          TDSEntry.SETRANGE("Party Code", "Sell-to Customer No.");
                                          TDSEntry.SETFILTER("Posting Date", AccountingPeriodFilter);
                                          TDSEntry.SETRANGE("TDS Group", "TDS Group");
                                          TDSEntry.SETRANGE("Assessee Code", "Assessee Code");
                                          TDSEntry.SETRANGE(Applied, FALSE);
                                          IF TDSEntry.FIND('-') THEN BEGIN
                                              REPEAT
                                                  InsertTDSBuf(TDSEntry, SalesHeader."Posting Date", CalculateSurcharge, FALSE);
                                              UNTIL TDSEntry.NEXT = 0;
                                          END;
                                      END ELSE BEGIN
                                          "Surcharge %" := 0;
                                      END;
                                  END;
                              END;
                          END ELSE BEGIN
                              TDSGroup.SETRANGE("TDS Group", "TDS Group");
                              TDSGroup.SETRANGE("Effective Date", 0D, SalesHeader."Posting Date");
                              TDSGroup.FIND('+');
                              IF PreviousAmount > TDSGroup."TDS Threshold Amount" THEN BEGIN
                                  "TDS/TCS Base Amount" := ABS("Line Amount" - "Inv. Discount Amount");
                                  "TDS/TCS %" := TDSDetail."TDS %";
                                  IF NODLines."Surcharge Overlook" THEN BEGIN
                                      "Surcharge Base Amount" := ABS("Line Amount" - "Inv. Discount Amount");
                                      "Surcharge %" := TDSDetail."Surcharge %";
                                  END ELSE BEGIN
                                      IF PreviousAmount > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                          "Surcharge Base Amount" := ABS("Line Amount" - "Inv. Discount Amount");
                                          "Surcharge %" := TDSDetail."Surcharge %";
                                          PreviousSurchargeAmt := 0;
                                      END ELSE BEGIN
                                          IF (PreviousAmount + ABS("Line Amount" - "Inv. Discount Amount")) > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                              "Surcharge Base Amount" := PreviousAmount + ABS("Line Amount" - "Inv. Discount Amount");
                                              "Surcharge %" := TDSDetail."Surcharge %";
                                              InsertGenTDSBuf(FALSE);
                                              IF "Surcharge %" <> 0 THEN
                                                  CalculateSurcharge := TRUE;
                                              TDSEntry.RESET;
                                              TDSEntry.SETCURRENTKEY("Party Type", "Party Code", "Posting Date", "TDS Group", "Assessee Code", Applied);
                                              TDSEntry.SETRANGE("Party Type", TDSEntry."Party Type"::Customer);
                                              TDSEntry.SETRANGE("Party Code", "Sell-to Customer No.");
                                              TDSEntry.SETFILTER("Posting Date", AccountingPeriodFilter);
                                              TDSEntry.SETRANGE("TDS Group", "TDS Group");
                                              TDSEntry.SETRANGE("Assessee Code", "Assessee Code");
                                              TDSEntry.SETRANGE(Applied, FALSE);
                                              IF TDSEntry.FIND('-') THEN BEGIN
                                                  REPEAT
                                                      InsertTDSBuf(TDSEntry, SalesHeader."Posting Date", CalculateSurcharge, FALSE);
                                                  UNTIL TDSEntry.NEXT = 0;
                                              END;
                                          END ELSE BEGIN
                                              "Surcharge %" := 0;
                                          END;
                                      END;
                                  END;
                              END ELSE BEGIN
                                  IF (PreviousAmount + ABS("Line Amount" - "Inv. Discount Amount")) > TDSGroup."TDS Threshold Amount" THEN BEGIN
                                      "TDS/TCS Base Amount" := PreviousAmount + ABS("Line Amount" - "Inv. Discount Amount");
                                      "TDS/TCS %" := TDSDetail."TDS %";
                                      IF NODLines."Surcharge Overlook" THEN BEGIN
                                          "Surcharge Base Amount" := ABS(PreviousAmount + ABS("Line Amount" - "Inv. Discount Amount"));
                                          "Surcharge %" := TDSDetail."Surcharge %";
                                      END ELSE BEGIN
                                          TDSGroup.SETRANGE("TDS Group", "TDS Group");
                                          TDSGroup.SETRANGE("Effective Date", 0D, SalesHeader."Posting Date");
                                          TDSGroup.FIND('+');
                                          IF PreviousAmount > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                              "Surcharge Base Amount" := ABS("Line Amount" - "Inv. Discount Amount");
                                              "Surcharge %" := TDSDetail."Surcharge %";
                                              PreviousSurchargeAmt := 0;
                                          END ELSE BEGIN
                                              IF (PreviousAmount + ABS("Line Amount" - "Inv. Discount Amount")) >
                                              TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                                  "Surcharge Base Amount" := PreviousAmount + ABS("Line Amount" - "Inv. Discount Amount");
                                                  "Surcharge %" := TDSDetail."Surcharge %";
                                              END ELSE BEGIN
                                                  "Surcharge %" := 0;
                                              END;
                                          END;
                                      END;
                                      InsertGenTDSBuf(FALSE);
                                      IF "Surcharge %" <> 0 THEN
                                          CalculateSurcharge := TRUE;
                                      TDSEntry.RESET;
                                      TDSEntry.SETCURRENTKEY("Party Type", "Party Code", "Posting Date", "TDS Group", "Assessee Code", Applied);
                                      TDSEntry.SETRANGE("Party Type", TDSEntry."Party Type"::Customer);
                                      TDSEntry.SETRANGE("Party Code", "Sell-to Customer No.");
                                      TDSEntry.SETFILTER("Posting Date", AccountingPeriodFilter);
                                      TDSEntry.SETRANGE("TDS Group", "TDS Group");
                                      TDSEntry.SETRANGE("Assessee Code", "Assessee Code");
                                      TDSEntry.SETRANGE(Applied, FALSE);
                                      IF TDSEntry.FIND('-') THEN BEGIN
                                          REPEAT
                                              InsertTDSBuf(TDSEntry, SalesHeader."Posting Date", CalculateSurcharge, TRUE);
                                          UNTIL TDSEntry.NEXT = 0;
                                      END;
                                  END ELSE BEGIN
                                      "TDS/TCS Base Amount" := ABS("Line Amount" - "Inv. Discount Amount");
                                      "TDS/TCS %" := 0;
                                      "Surcharge %" := 0;
                                      "Surcharge Amount" := 0;
                                      "TDS/TCS Amount" := 0;
                                      "TDS Amount Including Surcharge" := 0;
                                  END;
                              END;
                          END;

                          IF ("Line Amount" - "Inv. Discount Amount") <> 0 THEN BEGIN
                              IF TDSBuf[1].FIND('+') THEN BEGIN
                                  REPEAT
                                      CalculatedTDSAmt := CalculatedTDSAmt + TDSBuf[1]."TDS Base Amount" * TDSBuf[1]."TDS %" / 100;
                                      SurchargeBase := SurchargeBase + (TDSBuf[1]."TDS %" * TDSBuf[1]."Surcharge Base Amount" / 100);
                                      CalculatedSurchargeAmt := CalculatedSurchargeAmt + (TDSBuf[1]."TDS %" * TDSBuf[1]."Surcharge Base Amount" / 100)
                                        * (TDSBuf[1]."Surcharge %" / 100);
                                  UNTIL TDSBuf[1].NEXT(-1) = 0;
                                  IF ("Line Amount" - "Inv. Discount Amount") < 0 THEN BEGIN
                                      "TDS/TCS Amount" := -ROUND(CalculatedTDSAmt, Currency."Amount Rounding Precision");
                                      "Surcharge Amount" := -ROUND(CalculatedSurchargeAmt, Currency."Amount Rounding Precision");
                                  END ELSE BEGIN
                                      "TDS/TCS Amount" := ROUND(CalculatedTDSAmt, Currency."Amount Rounding Precision");
                                      "Surcharge Amount" := ROUND(CalculatedSurchargeAmt, Currency."Amount Rounding Precision");
                                  END;
                                  IF "TDS/TCS Base Amount" <> 0 THEN
                                      "TDS/TCS %" := ABS(ROUND(CalculatedTDSAmt * 100 / "TDS/TCS Base Amount", Currency."Amount Rounding Precision"));
                                  IF SurchargeBase <> 0 THEN
                                      "Surcharge %" := ABS(ROUND(CalculatedSurchargeAmt * 100 / SurchargeBase, Currency."Amount Rounding Precision"));
                              END ELSE BEGIN
                                  "TDS/TCS Amount" := ROUND("TDS/TCS %" * "TDS/TCS Base Amount" / 100, Currency."Amount Rounding Precision");
                                  "Surcharge Amount" := ("TDS/TCS %" * "Surcharge Base Amount" / 100) * ("Surcharge %" / 100);
                              END;
                              "TDS Amount Including Surcharge" := ROUND("TDS/TCS Amount" + "Surcharge Amount", 1, '=');
                              "Bal. TDS/TCS Including SHECESS" := "TDS Amount Including Surcharge";
                              "Balance Surcharge Amount" := "Surcharge Amount";
                          END;
                      END;
                  END;
              END;*/

            /*
            TDSDetail.RESET;
            TDSDetail.SETRANGE("TDS Nature of Deduction","Work Tax Nature Of Deduction");
            TDSDetail.SETRANGE("TDS Assessee Code","TDS Assessee Code");
            TDSDetail.SETRANGE("TDS Group","Work Tax Group");
            TDSDetail.SETRANGE("Effective Date",0D,SalesHeader."Posting Date");
            NODLines.RESET;
            NODLines.SETRANGE(Type,NODLines.Type::Customer);
            NODLines.SETRANGE("No.","Sell-to Customer No.");
            NODLines.SETRANGE("Nature of Deduction","Work Tax Nature Of Deduction");
            IF NODLines.FIND('-') THEN BEGIN
              IF NODLines."Concessional Rate" THEN
                TDSDetail.SETRANGE("Concessional Rate",TRUE)
              ELSE
                TDSDetail.SETRANGE("Concessional Rate",FALSE);
              IF NOT TDSDetail.FIND('+') THEN BEGIN
                "Work Tax %" := 0;
                "Work Tax Base Amount" := 0;
                "Work Tax Amount" := 0;
                "Balance Work Tax Amount" := 0;
              END ELSE BEGIN
                "Work Tax %" := TDSDetail."TDS %";
                "Work Tax Base Amount" := ROUND("Line Amount" - "Inv. Discount Amount",Currency."Amount Rounding Precision");
              END;
              "Work Tax Amount" := ROUND("Work Tax Base Amount" * "Work Tax %" / 100,1,'=');
              "Balance Work Tax Amount" := "Work Tax Amount";
            END;
            */
        END;

    end;

    local procedure FormatLine(ID: Guid)
    begin
        TaxSetupMatrixMgmt.FillColumnValue(ID, AttributeValue, RangeAttribute, AttributeID);
    end;

    local procedure CalculateTDSData()
    begin
        ColumnCount := 0;
        GlobalTaxType := '';
        TDSSetup.Get();
        TDSSetup.TestField(TDSSetup."Tax Type");
        GlobalTaxType := TDSSetup."Tax Type";
        TaxSetupMatrixMgmt.FillColumnArray(GlobalTaxType, AttributeCaption, AttributeValue, RangeAttribute, AttributeID, ColumnCount);
    end;

    var
        TDSSetup: Record "TDS Setup";
        TaxRatesfilterMgmt: Codeunit "Tax Rate Filter Mgmt.";
        AttributeManagement: Codeunit "Tax Attribute Management";
        RangeAttribute: array[1000] of Boolean;
        AttributeValue: array[1000] of Text;
        AttributeCaption: array[1000] of Text;
        AttributeID: array[1000] of Integer;
        GlobalTaxType: Code[20];
        ColumnCount: Integer;
        TaxSetupMatrixMgmt: Codeunit "Tax Setup Matrix Mgmt.";



    /* 15578 procedure InsertTDSBuf(TDSEntry: Record "TDS Entry"; PostingDate: Date; CalculateSurcharge: Boolean; CalculateTDS: Boolean)
     var
         RecCust: Record 18;

     begin
         WITH TDSEntry DO BEGIN
             TDSBuf[1]."TDS Nature of Deduction" := "TDS Nature of Deduction";
             TDSBuf[1]."Assessee Code" := "Assessee Code";
             TDSBuf[1]."Party Code" := "Party Code";
             TDSBuf[1]."Party Type" := "Party Type";
             IF CalculateTDS THEN
                 TDSBuf[1]."TDS Base Amount" := "Invoice Amount"
             ELSE
                 TDSBuf[1]."TDS Base Amount" := 0;
             IF CalculateSurcharge THEN
                 TDSBuf[1]."Surcharge Base Amount" := "Invoice Amount"
             ELSE
                 TDSBuf[1]."Surcharge Base Amount" := 0;
             TDSDetail.RESET;
             TDSDetail.SETRANGE("TDS Nature of Deduction", "TDS Nature of Deduction");
             TDSDetail.SETRANGE("Assessee Code", "Assessee Code");
             TDSDetail.SETRANGE("TDS Group", "TDS Group");
             TDSDetail.SETRANGE("Effective Date", 0D, PostingDate);
             NODLines.RESET;
             NODLines.SETRANGE(Type, "Party Type");
             NODLines.SETRANGE("No.", "Party Code");
             NODLines.SETRANGE(NODLines."NOD/NOC", "TDS Nature of Deduction");
             IF NODLines.FIND('-') THEN
                 /*
                 IF NODLines."Concessional Rate" THEN
                   TDSDetail.SETRANGE("Concessional Rate",TRUE)
                 ELSE
                   TDSDetail.SETRANGE("Concessional Rate",FALSE);

             TDSDetail.SETRANGE(TDSDetail."Concessional Code", NODLines."Concessional Code");

             IF TDSDetail.FIND('+') THEN BEGIN
                 IF RecCust.GET("Sell-to Customer No.") THEN
                     IF RecCust."P.A.N. No." = 'PANNOTAVBL' THEN
                         TDSBuf[1]."TDS %" := 20
                     ELSE
                         TDSBuf[1]."TDS %" := TDSDetail."TDS %";
                 TDSBuf[1]."Surcharge %" := TDSDetail."Surcharge %";
             END;
             UpdTDSBuffer;
         END;

     end;*/

    /*   procedure InsertGenTDSBuf(Applied: Boolean)
       begin
           TDSBuf[1]."TDS Nature of Deduction" := "TDS Nature of Deduction";
           TDSBuf[1]."Assessee Code" := "Assessee Code";
           TDSBuf[1]."Party Code" := "Sell-to Customer No.";
           TDSBuf[1]."Party Type" := TDSBuf[1]."Party Type"::Customer;
           IF Applied THEN BEGIN
               TDSBuf[1]."TDS Base Amount" := ABS("Temp TDS/TCS Base");
               TDSBuf[1]."Surcharge Base Amount" := ABS("Temp TDS/TCS Base");
           END ELSE BEGIN
               TDSBuf[1]."TDS Base Amount" := ABS("Line Amount" - "Inv. Discount Amount");
               TDSBuf[1]."Surcharge Base Amount" := ABS("Line Amount" - "Inv. Discount Amount");
           END;
           TDSBuf[1]."TDS %" := "TDS/TCS %";
           TDSBuf[1]."Surcharge %" := "Surcharge %";
           UpdTDSBuffer;
       end;*/ // 15578

    /* 15578  procedure UpdTDSBuffer()
      begin
          TDSBuf[2] := TDSBuf[1];
          IF TDSBuf[2].FIND THEN BEGIN
              TDSBuf[2]."TDS Base Amount" := TDSBuf[2]."TDS Base Amount" + TDSBuf[1]."TDS Base Amount";
              TDSBuf[2]."Surcharge Base Amount" := TDSBuf[2]."Surcharge Base Amount" + TDSBuf[1]."Surcharge Base Amount";
              TDSBuf[2].MODIFY;
          END ELSE
              TDSBuf[1].INSERT;
      end;*/

    procedure CheckGroupCode(ItemCd: Code[20]; GrpCode: Code[10]): Boolean
    var
        RecItem: Record Item;
        Ret: Boolean;
    begin
        IF Type <> Type::Item THEN
            EXIT;
        Ret := TRUE;
        IF RecItem.GET(ItemCd) THEN BEGIN
            IF (GrpCode IN ['01', '03', '04']) THEN BEGIN
                IF (RecItem."Group Code" IN ['01', '03', '04']) THEN
                    Ret := FALSE;
            END;

            IF (GrpCode IN ['02']) THEN BEGIN
                IF (RecItem."Group Code" IN ['02']) THEN
                    Ret := FALSE;
            END;
            IF (GrpCode IN ['05']) THEN BEGIN
                IF (RecItem."Group Code" IN ['05']) THEN
                    Ret := FALSE;
            END;

            IF (GrpCode IN ['06']) THEN BEGIN
                IF (RecItem."Group Code" IN ['06']) THEN
                    Ret := FALSE;
            END;
            IF (GrpCode IN ['07']) THEN BEGIN
                IF (RecItem."Group Code" IN ['07']) THEN
                    Ret := FALSE;

                IF (GrpCode IN ['08']) THEN BEGIN
                    IF (RecItem."Group Code" IN ['08']) THEN
                        Ret := FALSE;
                END;
            END;

            IF (GrpCode IN [RecItem."Group Code"]) THEN BEGIN
                Ret := FALSE;



            END;
        END;


        EXIT(Ret);
    end;

    procedure CheckQuantityDiscountForItem()
    begin
        //Shakti -Start
        IF SalesReceivablesSetup."QD Applicable" = TRUE THEN BEGIN
            /*
             IF SalesHeader."Calculate Discount" THEN BEGIN
                ExcludeCheckItem:=QDFunctions.LineGroupItemApplicable(Rec,SalesHeader);
                ExcludeCheckItemType:=QDFunctions.LineGroupItemTypeApplicable(Rec,SalesHeader);
                ExcludeCheckSize:=QDFunctions.LineGroupSizeApplicable(Rec,SalesHeader);
                ExcludeCheckTileGroup:=QDFunctions.LineGroupTitleApplicable(Rec,SalesHeader);

              IF (ExcludeCheckItem=TRUE)AND(ExcludeCheckItemType=TRUE)AND(ExcludeCheckSize=TRUE)AND ExcludeCheckTileGroup  THEN
                "Calculate Line Discount":=TRUE
              ELSE
              IF (ExcludeCheckItem=TRUE)AND(ExcludeCheckItemType=FALSE)AND(ExcludeCheckSize=FALSE) THEN
              "Calculate Line Discount":=FALSE;
              IF (ExcludeCheckItem=FALSE)AND(ExcludeCheckItemType=FALSE)AND(ExcludeCheckSize=FALSE) THEN
              "Calculate Line Discount":=TRUE;
              END
            */
            IF "Offer Code" <> '' THEN
                "Calculate Line Discount" := TRUE
            ELSE
                "Calculate Line Discount" := FALSE;

        END;
        //Shakti -End

    end;

    procedure GetOfferCodeNew(SalesHdr: Record "Sales Header"; SalesLine: Record "Sales Line"): Code[20]
    var
        "---------MS-PB-------------": Integer;
        DiscLine: Record "Discount Line";
        DiscPradeep2: Record "QD Buffer Table";
        BlnInsert: Boolean;
        DiscHdr: Record "Discount Header";
        DiscPradeep1: Record "QD Buffer Table";
        CustPt: Decimal;
        ItemPt: Decimal;
        OfferCode: Code[10];
        FinalOffer: Code[10];
        CustGroup: Record "Customer Group";
        TmpDiscPradeep: Record "QD Buffer Table" temporary;
        EntryNo: Integer;
        PostDate: Date;
        DiscPradeep: Record "QD Buffer Table";
        DiscLine1: Record "Discount Line";
        CustGroup1: Record "Customer Group";
        QDTest: Codeunit "QD Test, PDF Creation & Email";
    begin
        //Create HEader
        FinalOffer := TestQd.TestQD(SalesHdr, SalesLine);
        EXIT(FinalOffer);
        /*
        IF SalesHdr."Posting Date" = 0D THEN
          PostDate := WORKDATE
        ELSE
          PostDate :=SalesHdr."Posting Date";
        
        
        EntryNo:=1;
        CLEAR(TmpDiscPradeep);
        WITH SalesHdr DO BEGIN
          //MS-PB BEGIN
           {
          DiscPradeep.RESET;
          DiscPradeep.SETRANGE("Document Type","Document Type");
          DiscPradeep.SETRANGE("Document No.","No.");
          //TmpDiscPradeep.SETFILTER("Document Line No.",'%1',0);
          IF DiscPradeep.FINDFIRST THEN
             DiscPradeep.DELETEALL;
          }
          TmpDiscPradeep.INIT;
          CustGroup.RESET;
          CustGroup.SETRANGE(Status,CustGroup.Status::Enable);
          CustGroup.SETFILTER("Valid From",'<=%1',PostDate);
          CustGroup.SETFILTER("Valid To",'>=%1',PostDate);
          CustGroup.SETRANGE(All,TRUE);
          //CustGroup.SETRANGE("Include/Exclude",CustGroup."Include/Exclude"::Include);
          IF CustGroup.FINDFIRST THEN BEGIN
           REPEAT
           BlnInsert:=FALSE;
          IF (CustGroup."Include/Exclude"=CustGroup."Include/Exclude"::Exclude) THEN
           BlnInsert:=TRUE;
        
          //   GetEntryNo;
             TmpDiscPradeep."Offer Code":=CustGroup."No.";
             TmpDiscPradeep.Type:=TmpDiscPradeep.Type::Sales;
             TmpDiscPradeep."Document Type":="Document Type";
             TmpDiscPradeep."Document No.":="No.";
             TmpDiscPradeep."Document Line No.":=0;
             TmpDiscPradeep."Customer Entry":=TRUE;
             TmpDiscPradeep."Entry No":=EntryNo;
             TmpDiscPradeep."Group Code" := FORMAT(CustGroup.Code);
             CASE CustGroup."Group Type" OF
                 CustGroup."Group Type"::State:
                 BEGIN
                  TmpDiscPradeep."Group Type":= 5;
                  //MSBS.RAO BEGIN DT. 07-09-12
                  CustGroup1.RESET;
                  CustGroup1.SETRANGE(Status,CustGroup1.Status::Enable);
                  CustGroup1.SETFILTER("Valid From",'<=%1',PostDate);
                  CustGroup1.SETFILTER("Valid To",'>=%1',PostDate);
                  CustGroup1.SETRANGE("No.",CustGroup."No.");
                  CustGroup1.SETFILTER("Group Type",'%1',CustGroup1."Group Type"::State);
                  CustGroup1.SETRANGE(Code,State);
                  IF CustGroup1.FINDFIRST THEN
                  IF (CustGroup.All AND (CustGroup."Include/Exclude"=DiscLine."Include/Exclude"::Exclude)AND
                  (CustGroup1."Include/Exclude"=CustGroup1."Include/Exclude"::Include))
                  OR
                  (CustGroup.All AND (CustGroup."Include/Exclude"=CustGroup."Include/Exclude"::Include)AND
                  (CustGroup1.Code <> State)) THEN
                  IF CustGroup.All THEN
                  //MSBS.RAO BEGIN DT. 07-09-12
                  TmpDiscPradeep."Group Code" := State;
                  IF TmpDiscPradeep."Group Code" = State THEN
                    TmpDiscPradeep.Marks:=1
                  ELSE
                    TmpDiscPradeep.Marks:=0;
                 END;
                 CustGroup."Group Type"::"Customer Type":
                 BEGIN
                  TmpDiscPradeep."Group Type":= 6;
                  //MSBS.RAO BEGIN DT. 07-09-12
                  CustGroup1.RESET;
                  CustGroup1.SETRANGE(Status,CustGroup1.Status::Enable);
                  CustGroup1.SETFILTER("Valid From",'<=%1',PostDate);
                  CustGroup1.SETFILTER("Valid To",'>=%1',PostDate);
                  CustGroup1.SETRANGE("No.",CustGroup."No.");
                  CustGroup1.SETFILTER("Group Type",'%1',CustGroup1."Group Type"::"Customer Type");
                  CustGroup1.SETRANGE(Code,"Customer Type");
                  IF CustGroup1.FINDFIRST THEN;
        
                  IF (CustGroup.All AND (CustGroup."Include/Exclude"=DiscLine."Include/Exclude"::Exclude)AND
                  (CustGroup1."Include/Exclude"=CustGroup1."Include/Exclude"::Include))
                  OR
                  (CustGroup.All AND (CustGroup."Include/Exclude"=CustGroup."Include/Exclude"::Include)AND
                  (CustGroup1.Code <> "Customer Type")) THEN
                  //IF CustGroup.All THEN
                  //MSBS.RAO BEGIN DT. 07-09-12
                  TmpDiscPradeep."Group Code" := "Customer Type";
                  IF TmpDiscPradeep."Group Code" = "Customer Type" THEN
                    TmpDiscPradeep.Marks:=1
                  ELSE
                    TmpDiscPradeep.Marks:=0;
                 END;
                 CustGroup."Group Type"::Customer:
                 BEGIN
                  TmpDiscPradeep."Group Type":= 7;
                  //MSBS.RAO BEGIN DT. 07-09-12
                  CustGroup1.RESET;
                  CustGroup1.SETRANGE(Status,CustGroup1.Status::Enable);
                  CustGroup1.SETFILTER("Valid From",'<=%1',PostDate);
                  CustGroup1.SETFILTER("Valid To",'>=%1',PostDate);
                  CustGroup1.SETRANGE("No.",CustGroup."No.");
                  CustGroup1.SETFILTER("Group Type",'%1',CustGroup1."Group Type"::Customer);
                  CustGroup1.SETRANGE(Code,"Sell-to Customer No.");
                  IF CustGroup1.FINDFIRST THEN;
                  //IF CustGroup.All THEN
                  IF (CustGroup.All AND (CustGroup."Include/Exclude"=DiscLine."Include/Exclude"::Exclude)AND
                  (CustGroup1."Include/Exclude"=CustGroup1."Include/Exclude"::Include))
                  OR
                  (CustGroup.All AND (CustGroup."Include/Exclude"=CustGroup."Include/Exclude"::Include)AND
                  (CustGroup1.Code <> "Sell-to Customer No.")) THEN
        
                  //MSBS.RAO BEGIN DT. 07-09-12
                  TmpDiscPradeep."Group Code" := "Sell-to Customer No.";
                  IF TmpDiscPradeep."Group Code" = "Sell-to Customer No." THEN
                    TmpDiscPradeep.Marks:=1
                  ELSE
                    TmpDiscPradeep.Marks:=0;
                 END;
             END;
             //IF BlnInsert THEN
              //TmpDiscPradeep.Marks:=0;
             EntryNo+=1;
            IF TmpDiscPradeep.Marks<>0 THEN
               TmpDiscPradeep.INSERT;
           UNTIL CustGroup.NEXT=0;
          END;
        END;
        
        //Create Applicable Offer Line
        WITH SalesLine DO BEGIN
        
         //TmpDiscPradeep.INIT;
        //TmpDiscPradeep.RESET;
        //CLEAR(TmpDiscPradeep);
          DiscLine.RESET;
          DiscLine.SETRANGE(Status,DiscLine.Status::Enable);
          DiscLine.SETFILTER("Valid From",'<=%1',PostDate);
          DiscLine.SETFILTER("Valid To",'>=%1',PostDate);
        
          //DiscLine.SETRANGE("Include/Exclude",DiscLine."Include/Exclude"::Include);
          IF DiscLine.FINDFIRST THEN BEGIN
          REPEAT
           BlnInsert:=FALSE;
          IF (DiscLine."Include/Exclude"=DiscLine."Include/Exclude"::Exclude) THEN
           BlnInsert:=TRUE;
        
             TmpDiscPradeep."Offer Code":=DiscLine."Document No.";
             TmpDiscPradeep.Type:=TmpDiscPradeep.Type::Sales;
             TmpDiscPradeep."Document Type":="Document Type";
             TmpDiscPradeep."Document No.":="Document No.";
             TmpDiscPradeep."Document Line No.":="Line No.";
             TmpDiscPradeep."Customer Entry":=FALSE;
             TmpDiscPradeep."Entry No":=EntryNo;
             TmpDiscPradeep."Group Code" := FORMAT(DiscLine.Code);
             TmpDiscPradeep.All := DiscLine.All;
             CASE DiscLine."Group Type" OF
                 DiscLine."Group Type"::"Item Type":
                 BEGIN
                  TmpDiscPradeep."Group Type":= 1;
                  //MSBS.RAO BEGIN DT. 07-09-12
                  DiscLine1.RESET;
                  DiscLine1.SETRANGE(Status,DiscLine1.Status::Enable);
                  DiscLine1.SETFILTER("Valid From",'<=%1',PostDate);
                  DiscLine1.SETFILTER("Valid To",'>=%1',PostDate);
                  DiscLine1.SETFILTER("Group Type",'%1',DiscLine1."Group Type"::"Item Type");
                  DiscLine1.SETRANGE(Code,"Item Type");
                  IF DiscLine1.FINDFIRST THEN;
                  //IF DiscLine.All THEN
                  IF (DiscLine.All AND (DiscLine."Include/Exclude"=DiscLine."Include/Exclude"::Exclude)AND
                  (DiscLine1."Include/Exclude"=DiscLine1."Include/Exclude"::Include))
                  OR
                  (DiscLine.All AND (DiscLine."Include/Exclude"=DiscLine."Include/Exclude"::Include)AND
                  (DiscLine1.Code <> "Item Type"))
                  THEN
        
                  //MSBS.RAO END DT. 07-09-12
                  TmpDiscPradeep."Group Code" := "Item Type";
                  IF TmpDiscPradeep."Group Code" = "Item Type" THEN
                    TmpDiscPradeep.Marks:=1
                    ELSE
                    TmpDiscPradeep.Marks:=0;
                 END;
                 DiscLine."Group Type"::Size:
                 BEGIN
                  TmpDiscPradeep."Group Type":= 2;
                  //MSBS.RAO BEGIN DT. 07-09-12
                  DiscLine1.RESET;
                  DiscLine1.SETRANGE(Status,DiscLine1.Status::Enable);
                  DiscLine1.SETFILTER("Valid From",'<=%1',PostDate);
                  DiscLine1.SETFILTER("Valid To",'>=%1',PostDate);
                  DiscLine1.SETRANGE("Document No.",DiscLine."Document No.");
                  DiscLine1.SETFILTER("Group Type",'%1',DiscLine1."Group Type"::Size);
                  DiscLine1.SETRANGE(Code,"Size Code");
                  IF DiscLine1.FINDFIRST THEN;
                  //IF DiscLine.All THEN
                  IF (DiscLine.All AND (DiscLine."Include/Exclude"=DiscLine."Include/Exclude"::Exclude)AND
                  (DiscLine1."Include/Exclude"=DiscLine1."Include/Exclude"::Include))
                  OR
                  (DiscLine.All AND (DiscLine."Include/Exclude"=DiscLine."Include/Exclude"::Include)AND
                  (DiscLine1.Code <> "Size Code"))
                  THEN
        
                  //MSBS.RAO END DT. 07-09-12
                  TmpDiscPradeep."Group Code" := "Size Code";
                  IF TmpDiscPradeep."Group Code" = "Size Code" THEN
                    TmpDiscPradeep.Marks:=1
                    ELSE
                    TmpDiscPradeep.Marks:=0;
        
                 END;
                 DiscLine."Group Type"::"Tile Group":
                 BEGIN
                  TmpDiscPradeep."Group Type":= 3;
                  //MSBS.RAO BEGIN DT. 07-09-12
                  DiscLine1.RESET;
                  DiscLine1.SETRANGE(Status,DiscLine1.Status::Enable);
                  DiscLine1.SETFILTER("Valid From",'<=%1',PostDate);
                  DiscLine1.SETFILTER("Valid To",'>=%1',PostDate);
                  DiscLine1.SETFILTER("Group Type",'%1',DiscLine1."Group Type"::"Tile Group");
                  DiscLine1.SETRANGE("Document No.",DiscLine."Document No.");
                  DiscLine1.SETRANGE(Code,"Group Code");
                  IF DiscLine1.FINDFIRST THEN;
                  //IF DiscLine.All THEN
                  IF (DiscLine.All AND (DiscLine."Include/Exclude"=DiscLine."Include/Exclude"::Exclude)AND
                  (DiscLine1."Include/Exclude"=DiscLine1."Include/Exclude"::Include))
                  OR
                  (DiscLine.All AND (DiscLine."Include/Exclude"=DiscLine."Include/Exclude"::Include)AND
                  (DiscLine1.Code <> "Group Code"))
                  THEN
        
                  //MSBS.RAO END DT. 07-09-12
                  TmpDiscPradeep."Group Code" := "Group Code";
                  IF TmpDiscPradeep."Group Code" = "Group Code" THEN
                    TmpDiscPradeep.Marks:=1
                    ELSE
                    TmpDiscPradeep.Marks:=0;
                 END;
        
                 DiscLine."Group Type"::Item:
                 BEGIN
                  TmpDiscPradeep."Group Type":= 4;
                  //MSBS.RAO BEGIN DT. 07-09-12
                  DiscLine1.RESET;
                  DiscLine1.SETRANGE(Status,DiscLine1.Status::Enable);
                  DiscLine1.SETFILTER("Valid From",'<=%1',PostDate);
                  DiscLine1.SETFILTER("Valid To",'>=%1',PostDate);
                  DiscLine1.SETRANGE("Document No.",DiscLine."Document No.");
                  DiscLine1.SETFILTER("Group Type",'%1',DiscLine1."Group Type"::Item);
                  DiscLine1.SETRANGE(Code,"No.");
                  IF DiscLine1.FINDFIRST THEN;
                  IF (DiscLine.All AND (DiscLine."Include/Exclude"=DiscLine."Include/Exclude"::Exclude)AND
                  (DiscLine1."Include/Exclude"=DiscLine1."Include/Exclude"::Include))
                  OR
                  (DiscLine.All AND (DiscLine."Include/Exclude"=DiscLine."Include/Exclude"::Include)AND
                  (DiscLine1.Code <> "No."))
                  THEN
                  //IF DiscLine.All THEN
                    TmpDiscPradeep."Group Code" := "No.";
                  IF (TmpDiscPradeep."Group Code" = "No.")THEN
                    TmpDiscPradeep.Marks:=1
                    ELSE
                    TmpDiscPradeep.Marks:=0;
        
                  //MSBS.RAO END DT. 07-09-12
                 END;
             END;
             IF BlnInsert THEN
               TmpDiscPradeep.Marks:=0;
               //Pradeep Comment
               EntryNo+=1;
               IF TmpDiscPradeep.Marks<>0 THEN
               TmpDiscPradeep.INSERT;
          UNTIL DiscLine.NEXT=0;
        END;
        
          DiscHdr.RESET;
          DiscHdr.SETRANGE(Status,CustGroup.Status::Enable);
          DiscHdr.SETFILTER("Valid From",'<=%1',PostDate);
          DiscHdr.SETFILTER("Valid To",'>=%1',PostDate);
        
          IF DiscHdr.FINDFIRST THEN BEGIN
            REPEAT
              TmpDiscPradeep.RESET;
              TmpDiscPradeep.SETCURRENTKEY(Type,"Document Type","Document No.","Document Line No.","Offer Code");
              TmpDiscPradeep.SETRANGE(Type,TmpDiscPradeep.Type::Sales);
              TmpDiscPradeep.SETRANGE("Document Type", "Document Type");
              TmpDiscPradeep.SETRANGE("Document No.","Document No.");
              TmpDiscPradeep.SETRANGE("Offer Code",DiscHdr."No.");
              TmpDiscPradeep.SETRANGE("Customer Entry",TRUE);
              IF TmpDiscPradeep.FINDFIRST THEN BEGIN
               TmpDiscPradeep.CALCSUMS(Marks);
               IF TmpDiscPradeep.Marks <> 3 THEN
                 TmpDiscPradeep.RESET;
                 TmpDiscPradeep.SETRANGE("Offer Code",DiscHdr."No.");
                 TmpDiscPradeep.SETRANGE("Document No.","Document No.");
                 TmpDiscPradeep.SETRANGE("Document Line No.","Line No.");
                 TmpDiscPradeep.SETRANGE("Customer Entry",TRUE);
                 IF TmpDiscPradeep.FINDFIRST THEN
                   //Pradeep Comment
                   TmpDiscPradeep.DELETEALL;
              END;
            UNTIL DiscHdr.NEXT=0;
          END;
        
          DiscHdr.RESET;
          IF DiscHdr.FINDFIRST THEN BEGIN
            REPEAT
              TmpDiscPradeep.RESET;
              TmpDiscPradeep.SETCURRENTKEY(Type,"Document Type","Document No.","Document Line No.","Offer Code");
              TmpDiscPradeep.SETRANGE(Type,TmpDiscPradeep.Type::Sales);
              TmpDiscPradeep.SETRANGE("Document Type", "Document Type");
              TmpDiscPradeep.SETRANGE("Document No.","Document No.");
              TmpDiscPradeep.SETRANGE("Document Line No.","Line No.");
              TmpDiscPradeep.SETRANGE("Offer Code",DiscHdr."No.");
              TmpDiscPradeep.SETRANGE("Customer Entry",FALSE);
              IF TmpDiscPradeep.FINDFIRST THEN BEGIN
               TmpDiscPradeep.CALCSUMS(Marks);
               IF TmpDiscPradeep.Marks <> 4 THEN BEGIN
                 TmpDiscPradeep.RESET;
                 TmpDiscPradeep.SETRANGE("Offer Code",DiscHdr."No.");
                 TmpDiscPradeep.SETRANGE("Document No.","Document No.");
                 TmpDiscPradeep.SETRANGE("Document Line No.","Line No.");
                 TmpDiscPradeep.SETRANGE("Customer Entry",FALSE);
                 IF TmpDiscPradeep.FINDFIRST THEN ;
                   //Pradeep Comment
                   TmpDiscPradeep.DELETEALL;
               END;
              END;
            UNTIL DiscHdr.NEXT=0;
          END;
            {
          TmpDiscPradeep.RESET;
          IF TmpDiscPradeep.FINDFIRST THEN BEGIN
          REPEAT
          DiscPradeep.INIT;
          DiscPradeep.TRANSFERFIELDS(TmpDiscPradeep);
          DiscPradeep.INSERT;
          UNTIL TmpDiscPradeep.NEXT=0;
          END;
            }
          //CustPt:=0;
          //ItemPt:=0;
        
        
          TmpDiscPradeep.RESET;
          TmpDiscPradeep.SETCURRENTKEY(Type,"Document Type","Document No.","Offer Code");
          TmpDiscPradeep.SETRANGE("Document No.","Document No.");
          TmpDiscPradeep.SETFILTER("Document Line No.",'%1|%2',0,"Line No.");
          TmpDiscPradeep.SETRANGE(Marks,1);
          IF TmpDiscPradeep.FINDFIRST THEN BEGIN
            REPEAT
              IF OfferCode='' THEN
                 OfferCode := TmpDiscPradeep."Offer Code";
        
              IF OfferCode = TmpDiscPradeep."Offer Code" THEN BEGIN
                IF TmpDiscPradeep."Customer Entry" THEN
                    CustPt += TmpDiscPradeep.Marks
                 ELSE
                    ItemPt += TmpDiscPradeep.Marks;
               END  ELSE BEGIN
                 OfferCode := TmpDiscPradeep."Offer Code";
                 IF TmpDiscPradeep."Customer Entry" THEN
                  CustPt:=1
                  ELSE
                  ItemPt:=1;
                  IF OfferCode <> "Offer Code" THEN
                  ItemPt:=0;
              END;
              //MESSAGE('c%1=i%2=o%3=g%4=gt%5',CustPt,ItemPt,TmpDiscPradeep."Offer Code",
              //TmpDiscPradeep."Group Code",TmpDiscPradeep."Group Type");
                IF (CustPt + ItemPt) > 6 THEN
                  FinalOffer := TmpDiscPradeep."Offer Code"
                ELSE
                  FinalOffer :='';
        
            UNTIL (FinalOffer<>'') OR (TmpDiscPradeep.NEXT=0);
          END;
        END;
        //MESSAGE(FinalOffer);
          EXIT(FinalOffer);
        */

    end;

    procedure UpdateDiscountAmt()
    begin
        TESTFIELD("Quantity in Sq. Mt.");
        //GetSystemDiscount;
        "Discount Amt 1" := D1 * "Quantity in Sq. Mt.";
        "Discount Amt 2" := D2 * "Quantity in Sq. Mt.";
        "Discount Amt 3" := D3 * "Quantity in Sq. Mt.";
        "Discount Amt 4" := D4 * "Quantity in Sq. Mt.";
        "System Discount Amount" := (S1 * "Quantity in Sq. Mt.");
        "Discount Amt 6" := D6 * "Quantity in Sq. Mt.";
        "PreApproved Discount Amount" := "PreApproved Discount" * "Quantity in Sq. Mt."; //MSKS22072019
        //"Discount Amt 7" := D7 * "Quantity in Sq. Mt.";
        //VALIDATE("Discount Per SQ.MT",D1+D2+D3+D4);
        VALIDATE("Discount Per SQ.MT", D1 + D2 + D3 + D4 + S1 + D6 + "PreApproved Discount"); //MSKS22072019
        VALIDATE("Line Discount Amount", ("Discount Amt 1" + "Discount Amt 2" + "Discount Amt 3" + "Discount Amt 4" + "System Discount Amount" + "Discount Amt 6" + "PreApproved Discount Amount")); //MSKS22072019
    end;

    procedure GetSystemDiscount()
    var
        RecState: Record State;
    begin
        GetItem;
        //IF RecState.GET(State) THEN
        //  IF RecState."Sales Team Discount Applicable" THEN
        //  S1 := Item."System Discount";
    end;

    procedure RestrictExcisePosting()
    var
        RecLocation: Record Location;
        RecItem: Record Item;
    begin
        //Excise Check Start
        /*WITH Rec DO BEGIN
          IF Type = Type::Item THEN BEGIN
            RecLocation.GET("Location Code");
            RecItem.GET("No.");
            IF NOT RecLocation."Excisable Location" THEN
            EXIT;
        
            IF RecItem."Excise Prod. Posting Group" = '' THEN
              EXIT;
        
            SalesHRec.RESET;
            SalesHRec.SETRANGE("No.","Document No.");
            IF SalesHRec.FINDFIRST THEN
              BEGIN
                IF ("Excise Amount" = 0) AND (SalesHRec.Structure <> 'EXPORTINS') AND (SalesHRec.Structure <> 'SAMPLEEXTX')
                  AND (SalesHRec.Structure <> 'DIS+INSTX') THEN
                    ERROR('Please Check Excise Amount On Line No. %1',"Line No.");
              END
            END;
        END;
          */
        //Excise Check Stop

    end;

    procedure CheckADDiscountLimits()
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        /*
        SalesSetup.GET;
        IF SalesSetup."D1 Approval Limit" <>0 THEN
          IF D1 > SalesSetup."D1 Approval Limit" THEN
            ERROR('D1 Cannot be greater then %1',SalesSetup."D1 Approval Limit");
        
        IF SalesSetup."D1 Approval Limit"<>0 THEN //MSKS0205
        IF (D2 <>0) AND (D1 <> SalesSetup."D1 Approval Limit")  THEN
            ERROR('First utilise the D1 Limit');
        
        
          IF D2 > SalesSetup."D2 Approval Limit" THEN
            ERROR('D2 Cannot be greater then %1',SalesSetup."D2 Approval Limit");
        
        IF (SalesSetup."D1 Approval Limit"+SalesSetup."D2 Approval Limit") <>0 THEN //MSKS0205
        IF (D3 <>0) AND (D2 <> SalesSetup."D2 Approval Limit")  THEN
            ERROR('First utilise the D2 Limit');
        
        IF SalesSetup."D3 Approval Limit" <>0 THEN
          IF D3 > SalesSetup."D3 Approval Limit" THEN
            ERROR('D3 Cannot be greater then %1',SalesSetup."D3 Approval Limit");
        
        IF (SalesSetup."D1 Approval Limit"+SalesSetup."D2 Approval Limit"+SalesSetup."D3 Approval Limit") <>0 THEN //MSKS0205
        IF (D4 <>0) AND (D3 <> SalesSetup."D3 Approval Limit")  THEN
            ERROR('First utilise the D3 Limit');
        
        IF SalesSetup."D4 Approval Limit" <>0 THEN
          IF D4 > SalesSetup."D4 Approval Limit" THEN
            ERROR('D4 Cannot be greater then %1',SalesSetup."D4 Approval Limit");
         */

    end;

    procedure CheckStatusOpen()
    begin
        IF SalesHeader.GET("Document Type", "Document No.") THEN
            SalesHeader.TESTFIELD(Status, Status::Open);
    end;

    procedure GetAdditionDiscount(CustCode: Code[20]; ItemCode: Code[20]): Decimal
    var
        ItemCustGroupDiscount: Record "Item-Customer Group Discount";
        Item: Record Item;
        Customer: Record Customer;
        AddDiscountAmt: Decimal;
    begin
        IF Type <> Type::Item THEN
            EXIT;
        GetPreApprovedDiscount(AddDiscountAmt);
        /*MSKS22072019
        IF (CustCode='') OR (ItemCode='') THEN
        EXIT;
        Customer.GET(CustCode);
        Item.GET(ItemCode);
        ItemCustGroupDiscount.RESET;
        ItemCustGroupDiscount.SETRANGE("Customer Group",Customer."Discount Group");
        ItemCustGroupDiscount.SETRANGE("Item Group",Item."Discount Group");
        IF ItemCustGroupDiscount.FINDFIRST THEN
          EXIT(ItemCustGroupDiscount."Discount Percentage");
          */

    end;

    procedure CheckAdditionDiscount(CustCode: Code[20]; ItemCode: Code[20]; DiscountAmt: Decimal): Decimal
    var
        ItemCustGroupDiscount: Record "Item-Customer Group Discount";
        Item: Record Item;
        Customer: Record Customer;
    begin
        IF Type <> Type::Item THEN
            EXIT;
        IF DiscountAmt = 0 THEN
            EXIT;
        IF (CustCode = '') OR (ItemCode = '') THEN
            EXIT;
        IF Customer.GET(CustCode) THEN;
        IF Item.GET(ItemCode) THEN;
        ItemCustGroupDiscount.RESET;
        ItemCustGroupDiscount.SETRANGE("Customer Group", Customer."Discount Group");
        ItemCustGroupDiscount.SETRANGE("Item Group", Item."Discount Group");
        IF ItemCustGroupDiscount.FINDFIRST THEN
            IF DiscountAmt > ItemCustGroupDiscount."Discount Percentage" THEN
                ERROR('Max %1 Discount can be availed', ItemCustGroupDiscount."Discount Percentage");
    end;

    procedure AllocateRequestedDiscount(ReqDiscount: Decimal)
    var
        I: Integer;
        SalesSetup: Record "Sales & Receivables Setup";
        RemainingDiscount: Decimal;
        AddDiscountAmt: Decimal;
        PreAppDis: Decimal;
        EligibleDis: array[7] of Decimal;
    begin
        RemainingDiscount := ReqDiscount;
        PreAppDis := GetPreApprovedDiscount(AddDiscountAmt);
        SalesSetup.GET;
        EligibleDis[1] := SalesSetup."D1 Approval Limit";
        EligibleDis[2] := SalesSetup."D2 Approval Limit";
        EligibleDis[3] := SalesSetup."D3 Approval Limit";
        EligibleDis[4] := SalesSetup."D4 Approval Limit";
        /*
        IF AddDiscountAmt> 0 THEN BEGIN
          EligibleDis[1] := AddDiscountAmt /2;
          EligibleDis[2] := AddDiscountAmt /2;
        END;
        
        IF ReqDiscount <= (PreAppDis + AddDiscountAmt) THEN BEGIN
          IF AddDiscountAmt<=0 THEN BEGIN
            EligibleDis[1] := 0;
            EligibleDis[2] := 0;
          END;
        END;
        */

        /*
        VALIDATE("PreApproved Discount",0);
        IF ReqDiscount > (PreAppDis+AddDiscountAmt) THEN
          IF "AD Remarks"='' THEN
            ERROR('Please Select AD Remark');
            */
        FOR I := 1 TO 4 DO BEGIN
            CASE I OF
                0:
                    BEGIN
                        IF (ReqDiscount <= (PreAppDis + AddDiscountAmt)) THEN BEGIN
                            IF RemainingDiscount >= PreAppDis THEN BEGIN
                                VALIDATE("PreApproved Discount", PreAppDis);
                                RemainingDiscount -= PreAppDis;
                            END ELSE BEGIN
                                VALIDATE("PreApproved Discount", RemainingDiscount);
                                RemainingDiscount := 0;
                            END;
                        END ELSE
                            VALIDATE("PreApproved Discount", 0);
                    END;
                1:
                    BEGIN
                        //IF AddDiscountAmt >0 THEN BEGIN
                        IF RemainingDiscount >= EligibleDis[1] THEN BEGIN
                            VALIDATE(D1, EligibleDis[1]);
                            RemainingDiscount -= EligibleDis[1];
                        END ELSE BEGIN
                            VALIDATE(D1, RemainingDiscount);
                            RemainingDiscount := 0;
                        END;
                        //  END ELSE BEGIN
                        // END;
                    END;
                2:
                    BEGIN
                        //   IF AddDiscountAmt >0 THEN BEGIN
                        IF RemainingDiscount >= EligibleDis[2] THEN BEGIN
                            VALIDATE(D2, EligibleDis[2]);
                            RemainingDiscount -= EligibleDis[2];
                        END ELSE BEGIN
                            VALIDATE(D2, RemainingDiscount);
                            RemainingDiscount := 0;
                        END;
                        //    END ELSE
                        //    VALIDATE(D2,0);
                    END;
                3:
                    BEGIN
                        //IF AddDiscountAmt >0 THEN BEGIN
                        IF RemainingDiscount >= SalesSetup."D3 Approval Limit" THEN BEGIN
                            VALIDATE(D3, SalesSetup."D3 Approval Limit");
                            RemainingDiscount -= SalesSetup."D3 Approval Limit";
                        END ELSE BEGIN
                            VALIDATE(D3, RemainingDiscount);
                            RemainingDiscount := 0;
                        END;
                        //END ELSE
                        //VALIDATE(D3,0);
                    END;
                4:
                    BEGIN
                        IF RemainingDiscount >= SalesSetup."D4 Approval Limit" THEN BEGIN
                            VALIDATE(D4, SalesSetup."D4 Approval Limit");
                            RemainingDiscount -= SalesSetup."D4 Approval Limit";
                        END ELSE BEGIN
                            VALIDATE(D4, RemainingDiscount);
                            RemainingDiscount := 0;
                        END;
                    END;
            END;
        END;
        "Approval Required" := UpdateApprovalRequired(ReqDiscount, PreAppDis, AddDiscountAmt);
        //MESSAGE('%1-%2-%3',ReqDiscount,PreAppDis,AddDiscountAmt);

    end;

    procedure CalculateCNAmt(DocNo: Code[20]; CustNo: Code[20]; ChargeItem: Code[20]; ManuallyChanged: Boolean) Amt: Decimal
    var
        IssuedCreditDet: Record "Issued Credit Details";
        IssCrMgt: Codeunit "Issued Credit Mgt";
        AvailableAmtToAllocate: Decimal;
        ItemChargeAmt: Decimal;
        CDAmount: Decimal;
    begin
        IF ManuallyChanged THEN
            EXIT;
        //GetSalesHeader;
        SalesHeader.SETRANGE("No.", DocNo);
        IF SalesHeader.FINDFIRST THEN
            //   SalesHeader.CALCFIELDS("Amount to Customer");
            // IF SalesHeader."Amount to Customer" = 0 THEN
            EXIT;
        IF SalesHeader."Trade Discount" <> 0 THEN
            CDAmount := SalesHeader."Trade Discount";

        // 15578  AvailableAmtToAllocate := 0.75 * (SalesHeader."Amount to Customer") - CDAmount;
        IF AvailableAmtToAllocate <= 0 THEN
            EXIT;
        IF ManuallyChanged = FALSE THEN BEGIN
            IssuedCreditDet.RESET;
            IssuedCreditDet.SETFILTER("Cust. No.", '%1', CustNo);
            IssuedCreditDet.SETFILTER("Sales Order No.", DocNo);
            IssuedCreditDet.SETFILTER("Item Charge No.", '%1', ChargeItem);
            IF IssuedCreditDet.FINDFIRST THEN BEGIN
                IssuedCreditDet.DELETEALL;
            END;
        END;

        IssuedCreditDet.RESET;
        IssuedCreditDet.SETFILTER("Cust. No.", '%1', CustNo);
        IssuedCreditDet.SETFILTER("Sales Order No.", '<>%1', DocNo);
        IF IssuedCreditDet.FINDFIRST THEN
            REPEAT
                Amt += IssuedCreditDet.Amount;
                IF IssuedCreditDet."Item Charge No." = ChargeItem THEN
                    ItemChargeAmt += IssuedCreditDet.Amount;
            UNTIL IssuedCreditDet.NEXT = 0;
        //MESSAGE('%1-%2-%3-%4',ChargeItem,Amt,ItemChargeAmt,AvailableAmtToAllocate);
        IF AvailableAmtToAllocate <= Amt THEN
            Amt := AvailableAmtToAllocate * ItemChargeAmt / Amt
        ELSE
            //Amt := Amt * ItemChargeAmt/Amt;
            Amt := ItemChargeAmt;
        IF Amt > 0 THEN
            IssCrMgt.UtiliseCreditOnSalesOrder(SalesHeader, ChargeItem, Amt);

        EXIT(-1 * Amt);
    end;

    procedure UpdatedForApp()
    var
        SalesHeader: Record "Sales Header";
    begin
        IF SalesHeader.GET("Document Type", "Document No.") THEN BEGIN
            SalesHeader.Updated := TRUE;
            SalesHeader.MODIFY;
        END;
    end;

    local procedure CheckTCSwithGSTValidation(SalesHeader: Record "Sales Header")
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        SalesLine: Record "Sales Line";
    begin
        CustLedgerEntry.SETCURRENTKEY("Customer No.", "Applies-to ID", "Document No.");
        CustLedgerEntry.SETRANGE("Customer No.", SalesHeader."Bill-to Customer No.");
        CustLedgerEntry.SETRANGE("Document No.", SalesHeader."Applies-to Doc. No.");
        CustLedgerEntry.SETFILTER("Amount to Apply", '<>%1', 0);
        IF CustLedgerEntry.FINDFIRST THEN BEGIN
            SalesLine.RESET;
            SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.", SalesHeader."No.");
            IF CustLedgerEntry."TCS Nature of Collection" <> '' THEN
                SalesLine.SETRANGE("TCS Nature of Collection", CustLedgerEntry."TCS Nature of Collection");
            IF NOT SalesLine.FINDFIRST THEN
                SalesLine.TESTFIELD("TCS Nature of Collection");
        END;
    end;

    procedure CheckLayerMultiples(qty: Decimal)
    var
        recItem: Record Item;
        diff: Decimal;
    begin
        IF qty = 0 THEN
            EXIT;

        GetSalesHeader;
        IF SalesHeader."Order Date" <= 20210930D THEN EXIT;//093021

        IF Type = Type::Item THEN BEGIN
            IF recItem.GET("No.") THEN
                IF recItem.Layer <> 0 THEN
                    diff := qty MOD recItem.Layer;
            IF diff <> 0 THEN
                ERROR('Quantity should be in Multiple to Layer[%1]', recItem.Layer);
        END;
    end;

    local procedure GetPreApprovedDiscount(var MultipleDiscountApp: Decimal): Decimal
    var
        DiscountSetups: Record "Discount Setups";
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        TempDiscountSetups: Record "Discount Setups" temporary;
        Customer: Record Customer;
        PMTDiscount: Decimal;
    begin
        IF Item.GET("No.") THEN;
        IF Item."Item Classification" = '' THEN
            EXIT;

        SalesHeader.GET("Document Type", "Document No.");
        Customer.GET(SalesHeader."Sell-to Customer No.");
        CLEAR(TempDiscountSetups);
        DiscountSetups.RESET;
        DiscountSetups.SETFILTER("Item Classification", Item."Item Classification");
        DiscountSetups.SETFILTER("Starting Date", '<=%1', SalesHeader."Order Date");
        DiscountSetups.SETFILTER("Ending Date", '>=%1', SalesHeader."Order Date");
        DiscountSetups.SETFILTER("Manuf. Strategy", '%1', Item."Manuf. Strategy");
        DiscountSetups.SETFILTER("Customer No.", '%1', "Sell-to Customer No.");
        IF DiscountSetups.FINDLAST THEN BEGIN
            TempDiscountSetups := DiscountSetups;
        END ELSE BEGIN
            DiscountSetups.RESET;
            DiscountSetups.SETFILTER("Item Classification", Item."Item Classification");
            DiscountSetups.SETFILTER("Starting Date", '<=%1', SalesHeader."Order Date");
            DiscountSetups.SETFILTER("Ending Date", '>=%1', SalesHeader."Order Date");
            DiscountSetups.SETFILTER("Manuf. Strategy", '%1', Item."Manuf. Strategy");

            DiscountSetups.SETFILTER("Customer No.", '%1', '');
            DiscountSetups.SETFILTER(DiscountSetups."Area Code", '%1', Customer."Area Code");
            DiscountSetups.SETFILTER(DiscountSetups.State, '%1', Customer."State Code");
            IF DiscountSetups.FINDLAST THEN
                TempDiscountSetups := DiscountSetups;
            //  ELSE BEGIN
            //  DiscountSetups.SETRANGE(State);
            //  DiscountSetups.SETFILTER(DiscountSetups."Area Code",'%1',Customer."Area Code");
            //  IF DiscountSetups.FINDFIRST THEN
            //    TempDiscountSetups := DiscountSetups

            // END;

        END;

        MultipleDiscountApp := TempDiscountSetups."Discount on Approval";

        IF SalesHeader."PMT Code" <> '' THEN
            PMTDiscount := GetPMTDiscount(SalesHeader."PMT Code", SalesHeader."Sell-to Customer No.", "Location Code", "No.", SalesHeader."Order Date");
        IF PMTDiscount > MultipleDiscountApp THEN
            EXIT(PMTDiscount)
        ELSE
            EXIT(TempDiscountSetups."PreApproved Discount");

        //EXIT(TempDiscountSetups."PreApproved Discount");
    end;

    local procedure UpdateApprovalRequired(ReqDisAmt: Decimal; PreappDiscount: Decimal; AddPreAppDiscount: Decimal): Boolean
    begin
        IF ReqDisAmt > (PreappDiscount + AddPreAppDiscount) THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
        /*
          ELSE BEGIN
            IF (ReqDisAmt > PreappDiscount) AND (AddPreAppDiscount>0) THEN
              EXIT(TRUE) ELSE
              EXIT(FALSE);
          END;
          */
        /*
        IF ReqDisAmt > (PreappDiscount) THEN
          EXIT(TRUE) ELSE BEGIN
            IF (ReqDisAmt > PreappDiscount) AND (AddPreAppDiscount>0) THEN
              EXIT(TRUE) ELSE
              EXIT(FALSE);
          END;
          */

    end;

    procedure GetAssociateVendorInventory(ItemNo: Code[20]; VendorCode: Code[20]) Qty: Decimal
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemJournalLine: Record "Item Journal Line";
    begin
        IF ItemNo = '' THEN
            EXIT;
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.CHANGECOMPANY('Associate Vendors-Morbi');
        ItemLedgerEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", ItemNo);
        ItemLedgerEntry.SETRANGE(Open, TRUE);
        IF VendorCode <> '' THEN
            ItemLedgerEntry.SETFILTER("Location Code", '%1', VendorCode);
        IF ItemLedgerEntry.FINDFIRST THEN
            REPEAT
                Qty += ItemLedgerEntry."Remaining Quantity";
            UNTIL ItemLedgerEntry.NEXT = 0;

        Qty -= GetAssociateVendorReserveInventory("No.", VendorCode);
    end;

    procedure GetAssociateVendorReserveInventory(ItemNo: Code[20]; VendorCode: Code[20]) Qty: Decimal
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemJournalLine: Record "Item Journal Line";
    begin
        IF ItemNo = '' THEN
            EXIT;

        ItemJournalLine.RESET;
        ItemJournalLine.CHANGECOMPANY('Associate Vendors-Morbi');
        ItemJournalLine.SETCURRENTKEY("Item No.", "Location Code", "Unit of Measure Code");
        ItemJournalLine.SETRANGE("Item No.", "No.");
        IF VendorCode <> '' THEN
            ItemJournalLine.SETFILTER("Location Code", '%1', VendorCode);
        ItemJournalLine.SETRANGE("Journal Batch Name", 'RESERVE');
        IF ItemJournalLine.FINDFIRST THEN
            REPEAT
                Qty += ItemJournalLine."Quantity (Base)";
            UNTIL ItemJournalLine.NEXT = 0;
    end;

    local procedure LookupMorbiVendorCodeOld()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        Vendor: Record Vendor;
        TempVendor: Record Vendor temporary;
    begin
        IF "No." = '' THEN
            EXIT;
        IF Type <> Type::Item THEN
            EXIT;

        CLEAR(TempVendor);
        Vendor.RESET;
        Vendor.SETFILTER("Morbi Location Code", '<>%1', '');
        IF Vendor.FINDFIRST THEN BEGIN
            REPEAT
                TempVendor.INIT;
                TempVendor.TRANSFERFIELDS(Vendor);
                TempVendor."Morbi Inventory" := 0;
                TempVendor.INSERT;
            UNTIL Vendor.NEXT = 0;
        END;
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.CHANGECOMPANY('Associate Vendors-Morbi');
        ItemLedgerEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", "No.");
        ItemLedgerEntry.SETRANGE(Open, TRUE);
        IF ItemLedgerEntry.FINDFIRST THEN
            REPEAT
                //Vendor.CHANGECOMPANY('Associate Vendors-Morbi');
                Vendor.SETRANGE("Morbi Location Code", ItemLedgerEntry."Location Code");
                IF Vendor.FINDFIRST THEN BEGIN
                    //IF Vendor.GET(ItemLedgerEntry."Location Code") THEN BEGIN
                    IF NOT TempVendor.GET(Vendor."No.") THEN BEGIN
                        TempVendor.INIT;
                        TempVendor.TRANSFERFIELDS(Vendor);
                        TempVendor."Morbi Inventory" := ItemLedgerEntry."Remaining Quantity";
                        TempVendor.INSERT;
                    END ELSE BEGIN
                        //TempVendor.GET(ItemLedgerEntry."Location Code");
                        TempVendor."Morbi Inventory" += ItemLedgerEntry."Remaining Quantity";
                        TempVendor.MODIFY;
                    END;
                END;
            UNTIL ItemLedgerEntry.NEXT = 0;
        IF PAGE.RUNMODAL(Page::"Vendor Wise Morbi Inventory", TempVendor) = ACTION::LookupOK THEN BEGIN
            VALIDATE("Vendor Code", TempVendor."Morbi Location Code");
        END;
    end;

    procedure LookupMorbiVendorCode(BlnShowPage: Boolean)
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        Vendor: Record Vendor;
        TempVendor: Record "Transport Method";
    begin
        IF "No." = '' THEN
            EXIT;
        IF Type <> Type::Item THEN
            EXIT;

        CLEAR(TempVendor);
        Vendor.RESET;
        Vendor.SETFILTER("Morbi Location Code", '<>%1', '');
        IF Vendor.FINDFIRST THEN BEGIN
            REPEAT
                IF NOT TempVendor.GET(Vendor."Morbi Location Code") THEN BEGIN
                    //IF NOT TempVendor.FINDFIRST THEN BEGIN
                    TempVendor.INIT;
                    TempVendor.Code := Vendor."Morbi Location Code";
                    TempVendor.Description := Vendor.Name;
                    TempVendor."Morbi Vendor" := TRUE;
                    TempVendor."Morbi Location Code" := Vendor."Morbi Location Code";
                    TempVendor."Morbi Inventory" := 0;
                    TempVendor.INSERT;
                END ELSE BEGIN
                    TempVendor."Morbi Inventory" := 0;
                END;
            UNTIL Vendor.NEXT = 0;
        END;
        IF TempVendor.FINDFIRST THEN
            REPEAT
                TempVendor."Morbi Inventory" := GetAssociateVendorInventory("No.", TempVendor.Code);
                TempVendor.MODIFY;
            UNTIL TempVendor.NEXT = 0;

        /*
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.CHANGECOMPANY('Associate Vendors-Morbi');
        ItemLedgerEntry.SETCURRENTKEY("Item No.",Open,"Variant Code",Positive,"Location Code","Posting Date");
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.","No.");
        ItemLedgerEntry.SETRANGE(Open,TRUE);
        IF ItemLedgerEntry.FINDFIRST THEN
          REPEAT
            //Vendor.CHANGECOMPANY('Associate Vendors-Morbi');
            Vendor.SETRANGE("Morbi Location Code",ItemLedgerEntry."Location Code");
            IF Vendor.FINDFIRST THEN BEGIN
            //IF Vendor.GET(ItemLedgerEntry."Location Code") THEN BEGIN
              IF NOT TempVendor.GET(Vendor."Morbi Location Code") THEN BEGIN
                TempVendor.INIT;
                TempVendor.Code := Vendor."Morbi Location Code";
                TempVendor.Description := Vendor.Name;
                TempVendor."Morbi Vendor" := TRUE;
                TempVendor."Morbi Location Code" := Vendor."Morbi Location Code";
                TempVendor."Morbi Inventory" := 0;
                TempVendor.INSERT;
                TempVendor."Morbi Inventory" := ItemLedgerEntry."Remaining Quantity";
                TempVendor.INSERT;
              END ELSE BEGIN
                //TempVendor.GET(ItemLedgerEntry."Location Code");
                TempVendor."Morbi Inventory" += ItemLedgerEntry."Remaining Quantity";
                TempVendor.MODIFY;
              END;
            END;
          UNTIL ItemLedgerEntry.NEXT=0;
          */
        COMMIT;
        IF BlnShowPage THEN BEGIN
            IF PAGE.RUNMODAL(Page::"Vendor Wise Morbi Inventory", TempVendor) = ACTION::LookupOK THEN BEGIN
                VALIDATE("Vendor Code", TempVendor."Morbi Location Code");
            END;
        END;

    end;

    procedure AutoReserveModified()
    var
        QtyToReserve: Decimal;
        QtyToReserveBase: Decimal;
        ReservMgt: Codeunit "Reservation Management";
        FullAutoReservation: Boolean;
        Recref: RecordRef;
    begin
        Clear(Recref);
        Recref.Get(Rec.RecordId);
        TESTFIELD(Type, Type::Item);
        TESTFIELD("No.");

        ReserveSalesLine.ReservQuantity(Rec, QtyToReserve, QtyToReserveBase);
        IF QtyToReserveBase <> 0 THEN BEGIN
            //ReservMgt.SetSalesLine(Rec);
            ReservMgt.SetReservSource(Recref);//15578

            TESTFIELD("Shipment Date");
            ReservMgt.AutoReserve(FullAutoReservation, '', "Shipment Date", QtyToReserve, QtyToReserveBase);
            FIND;
            //IF NOT FullAutoReservation THEN BEGIN
            //  COMMIT;
            // IF CONFIRM(Text011,TRUE) THEN BEGIN
            //   ShowReservation;
            //      FIND;
            //   END;
            //END;
        END;
    end;

    local procedure ReserverLine(NewSalesLine: Record "Sales Line")
    var
        ForSalesLine: Record "Sales Line";
        CalcReservEntry, CalcReservEntry2 : Record "Reservation Entry";
        ReservMgt: Codeunit "Reservation Management";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
    begin
        ForSalesLine := NewSalesLine;

        CalcReservEntry."Source Type" := DATABASE::"Sales Line";
        CalcReservEntry."Source Subtype" := ForSalesLine."Document Type".AsInteger();
        CalcReservEntry."Source ID" := NewSalesLine."Document No.";
        CalcReservEntry."Source Ref. No." := NewSalesLine."Line No.";

        IF NewSalesLine.Type = NewSalesLine.Type::Item THEN
            CalcReservEntry."Item No." := NewSalesLine."No.";
        CalcReservEntry."Variant Code" := NewSalesLine."Variant Code";
        CalcReservEntry."Location Code" := NewSalesLine."Location Code";
        CalcReservEntry."Serial No." := '';
        CalcReservEntry."Lot No." := '';
        CalcReservEntry."Qty. per Unit of Measure" := NewSalesLine."Qty. per Unit of Measure";
        CalcReservEntry."Expected Receipt Date" := NewSalesLine."Shipment Date";
        CalcReservEntry."Shipment Date" := NewSalesLine."Shipment Date";
        CalcReservEntry.Description := NewSalesLine.Description;
        CalcReservEntry2 := CalcReservEntry;

        GetItemSetup(CalcReservEntry);

        Positive :=
          ((CreateReservEntry.SignFactor(CalcReservEntry) * ForSalesLine."Outstanding Qty. (Base)") <= 0);

        SetPointerFilter(CalcReservEntry2);

        CallCalcReservedQtyOnPick;
    end;

    local procedure SetPointerFilter(VAR ReservEntry: Record "Reservation Entry")
    begin
        ReservEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date");
        ReservEntry.SETRANGE("Source ID", ReservEntry."Source ID");
        ReservEntry.SETRANGE("Source Ref. No.", ReservEntry."Source Ref. No.");
        ReservEntry.SETRANGE("Source Type", ReservEntry."Source Type");
        ReservEntry.SETRANGE("Source Subtype", ReservEntry."Source Subtype");
        ReservEntry.SETRANGE("Source Batch Name", ReservEntry."Source Batch Name");
        ReservEntry.SETRANGE("Source Prod. Order Line", ReservEntry."Source Prod. Order Line");
    end;

    LOCAL procedure CallCalcReservedQtyOnPick()
    begin
        IF Positive AND
           (CalcReservEntry."Location Code" <> '') AND
           Location.GET(CalcReservEntry."Location Code") AND
           (Location."Bin Mandatory" OR Location."Require Pick")
        THEN
            CalcReservedQtyOnPick(TotalAvailQty, QtyAllocInWhse);
    end;

    LOCAL procedure CalcReservedQtyOnPick(VAR AvailQty: Decimal; VAR AllocQty: Decimal)
    begin
        WITH CalcReservEntry DO BEGIN
            GetItemSetup(CalcReservEntry);
            Item.SETRANGE("Location Filter", "Location Code");
            Item.SETRANGE("Variant Filter", "Variant Code");
            IF "Lot No." <> '' THEN
                Item.SETRANGE("Lot No. Filter", "Lot No.");
            IF "Serial No." <> '' THEN
                Item.SETRANGE("Serial No. Filter", "Serial No.");
            Item.CALCFIELDS(
              Inventory, "Reserved Qty. on Inventory");

            WhseActivLine.SETCURRENTKEY(
              "Item No.", "Bin Code", "Location Code", "Action Type", "Variant Code",
              "Unit of Measure Code", "Breakbulk No.", "Activity Type", "Lot No.", "Serial No.");

            WhseActivLine.SETRANGE("Item No.", "Item No.");
            IF Location."Bin Mandatory" THEN
                WhseActivLine.SETFILTER("Bin Code", '<>%1', '');
            WhseActivLine.SETRANGE("Location Code", "Location Code");
            WhseActivLine.SETFILTER(
              "Action Type", '%1|%2', WhseActivLine."Action Type"::" ", WhseActivLine."Action Type"::Take);
            WhseActivLine.SETRANGE("Variant Code", "Variant Code");
            WhseActivLine.SETRANGE("Breakbulk No.", 0);
            WhseActivLine.SETFILTER(
              "Activity Type", '%1|%2', WhseActivLine."Activity Type"::Pick, WhseActivLine."Activity Type"::"Invt. Pick");
            IF "Lot No." <> '' THEN
                WhseActivLine.SETRANGE("Lot No.", "Lot No.");
            IF "Serial No." <> '' THEN
                WhseActivLine.SETRANGE("Serial No.", "Serial No.");
            WhseActivLine.CALCSUMS("Qty. Outstanding (Base)");

            /* TEAM 14763
            IF Location."Require Pick" THEN BEGIN
                QtyOnOutboundBins :=
                  CreatePick.CalcQtyOnOutboundBins(
                    "Location Code", "Item No.", "Variant Code", "Lot No.", "Serial No.", TRUE);

                QtyReservedOnPickShip :=
                  WhseAvailMgt.CalcReservQtyOnPicksShips(
                    "Location Code", "Item No.", "Variant Code", TempWhseActivLine2);

                QtyOnInvtMovement := CalcQtyOnInvtMovement(WhseActivLine);

                QtyOnAssemblyBin :=
                  WhseAvailMgt.CalcQtyOnAssemblyBin("Location Code", "Item No.", "Variant Code", "Lot No.", "Serial No.");
            END;

            AllocQty :=
              WhseActivLine."Qty. Outstanding (Base)" + QtyOnInvtMovement + QtyOnOutboundBins + QtyOnAssemblyBin;
            PickQty := WhseActivLine."Qty. Outstanding (Base)" + QtyOnInvtMovement;

            AvailQty :=
              Item.Inventory - PickQty - QtyOnOutboundBins - QtyOnAssemblyBin -
              Item."Reserved Qty. on Inventory" + QtyReservedOnPickShip;
            */
        END;
    end;


    local procedure GetItemSetup(VAR ReservEntry: Record "Reservation Entry")
    begin

    end;

    procedure ShowMorbiInventory(AllVendors: Boolean)
    var
        TransportMethod: Record "Transport Method";
    begin
        TransportMethod.RESET;
        IF NOT AllVendors THEN
            TransportMethod.SETFILTER("Morbi Location Code", '%1', "Vendor Code");
        IF TransportMethod.FINDFIRST THEN
            REPEAT
                TransportMethod."Morbi Inventory" := GetAssociateVendorInventory("No.", TransportMethod."Morbi Location Code");
                TransportMethod."Morbi Reserve Stock" := GetAssociateVendorReserveInventory("No.", TransportMethod."Morbi Location Code");
            UNTIL TransportMethod.NEXT = 0;
        TransportMethod.SETFILTER("Morbi Inventory", '<>%1', 0);
        IF TransportMethod.FINDFIRST THEN
            PAGE.RUN(Page::"Vendor Wise Morbi Inventory", TransportMethod);
    end;

    procedure GetMorbiReservedForSalesLine(SalesLine: Record "Sales Line") Qty: Decimal
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemJournalLine: Record "Item Journal Line";
    begin
        IF SalesLine."No." = '' THEN
            EXIT;

        ItemJournalLine.RESET;
        ItemJournalLine.CHANGECOMPANY('Associate Vendors-Morbi');
        ItemJournalLine.SETCURRENTKEY("Item No.", "Location Code", "Unit of Measure Code");
        ItemJournalLine.SETRANGE("Item No.", SalesLine."No.");
        ItemJournalLine.SETRANGE("Document No.", SalesLine."Document No.");
        ItemJournalLine.SETRANGE("Document Line No.", SalesLine."Line No.");
        ItemJournalLine.SETRANGE("Journal Batch Name", 'RESERVE');
        IF ItemJournalLine.FINDFIRST THEN
            REPEAT
                Qty += ItemJournalLine.Quantity;
            UNTIL ItemJournalLine.NEXT = 0;
    end;

    local procedure GetPMTDiscount(PMTId: Code[20]; CustNo: Code[20]; LocationCode: Code[10]; ItemNo: Code[20]; Dt: Date): Decimal
    var
        PMTDiscountMaster: Record "PMT Discount Master";
    begin
        IF PMTId = '' THEN EXIT;
        PMTDiscountMaster.RESET;
        PMTDiscountMaster.SETRANGE("Lead ID", PMTId);
        //PMTDiscountMaster.SETRANGE("Customer No.",CustNo);
        PMTDiscountMaster.SETRANGE(Location, LocationCode);
        PMTDiscountMaster.SETRANGE("Item No.", ItemNo);
        PMTDiscountMaster.SETFILTER("Price Validaty", '%1..', Dt);
        IF PMTDiscountMaster.FINDFIRST THEN
            EXIT(PMTDiscountMaster."Discount Amount");
    end;

    procedure ShowOtherReservation()
    var
        ReservationEntry: Record "Reservation Entry";
    begin
        IF Type <> Type::Item THEN EXIT;
        ReservationEntry.RESET;
        ReservationEntry.SETRANGE("Location Code", "Location Code");
        ReservationEntry.SETRANGE("Item No.", "No.");
        ReservationEntry.SETFILTER("Source ID", '<>%1', "Document No.");
        //ReservationEntry.FINDFIRST THEN
        PAGE.RUN(Page::"Reservation against Other Orde", ReservationEntry);
    end;

    var
        Location: Record "Location";
        CreatePick: Codeunit "Create Pick";
        CalcReservEntry, CalcReservEntry2 : Record "Reservation Entry";
        WhseActivLine: Record "Warehouse Activity Line";
        Positive: Boolean;
        // 15578  NODNOCLines: Record "13785";
        GLSetup: Record "General Ledger Setup";
        TotalAvailQty, QtyAllocInWhse, QtyOnOutboundBins : Decimal;
        ErrText001: Label 'Please Cancel the Reservation of Line No. %1 before Delete the Order %2.';
        ItemUnitofMeasure1: Record "Item Unit of Measure";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        SalesHeader11: Record "Sales Header";
        InventorySetup: Record "Inventory Setup";
        DimensionValue: Record "Dimension Value";
        SalesLine4: Record "Sales Line";
        CustInvDisc: Record "Cust. Invoice Disc.";
        SL: Record "Sales Line";
        Location3: Record Location;
        Location1: Record Location;
        Permissions: Codeunit Permissions1;
        UserAccess: Integer;
        UserSetup: Record "User Setup";
        UserLocation: Record "User Location";
        // 15578  DocumentDimensions: Record "Document Dimension";
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        "----TRI TDS": Integer;
        TDSEntry: Record "TDS Entry";
        PreviousAmount: Decimal;
        SalesLine1: Record "Sales Line";
        // 15578  TDSDetail: Record "13728";
        RecSalesPrice: Record "Sales Price";
        "---SHAKTI--": Integer;
        QDApplicable: Boolean;
        QDFunctions: Codeunit "Quality Discount Functions";
        RecDiscountHeader: Record "Discount Header";
        RecSlabs: Record Slabs;
        RecSalesLine: Record "Sales Line";
        QDQuantity: Decimal;
        QDSlab: Decimal;
        RSalesLin: Record "Sales Line";
        DisonQty2Ship: Decimal;
        QuantityDiscountEntry: Record "Quantity Discount Entry";
        RecSlab: Record Slabs;
        Charge: Decimal;
        SalesInvLine: Record "Sales Invoice Line";
        ExcludeState: Boolean;
        ExcludeCustomer: Boolean;
        ExcludeCustomerType: Boolean;
        ExcludeCheckItemType: Boolean;
        ExcludeCheckSize: Boolean;
        ExcludeCheckTileGroup: Boolean;
        ExcludeCheckItem: Boolean;
        Exist: Boolean;
        DiscountLine: Record "Discount Line";
        ExcludeItem: Boolean;
        ExcludeSize: Boolean;
        ExcludeTileGroup: Boolean;
        ExcludeItemType: Boolean;
        CurrentStartDate: Date;
        CurrentEndDate: Date;
        A: Decimal;
        Qty2Ship: Decimal;
        AccruedQty: Decimal;
        AccuredDiscount: Decimal;
        Month: Integer;
        Year: Integer;
        StartDate: Date;
        TestQd: Codeunit "QD Test, PDF Creation & Email";
        SalesHeaderPB: Record "Sales Header";
        // 15578  StructurePB: Record "13792";
        Text111: Label 'Status of Proforma Invoice No. %1 has been set as Expired due to modifications in the Export Order';
        Text0001: Label 'Item No. %1 already exist. \Do you want to continue.';
        Text0002: Label 'Select Same Group ';
        Text0003: Label 'Quantity Cannot be less than Ordered Quantity';
        Text0004: Label 'You cannot Change Item No ';
        Text0005: Label 'Qty to Ship Cannot be Greater than %1';
        Text70000: Label 'This is Excise Paid Item. Please correct the Tax structure.';
        Text70001: Label 'This is None-Excise Paid Item. Please correct the Tax  structure.';
        Text70002: Label 'Tax Structure is not applicable for Your Location  %1. Please change Tax structure on Sales Header.';
        MS0001: Label 'Please Enter Payment Terms in Header !!!';
        // 15578  TDSBuf: array[2] of Record 13714 temporary;
        // 15578 TDSNOD: Record "13726";
        BaseUOM: Record "Item Unit of Measure";
        SalesHRec: Record "Sales Header";
        LineInsert: Boolean;
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        Currency: Record Currency;
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
}