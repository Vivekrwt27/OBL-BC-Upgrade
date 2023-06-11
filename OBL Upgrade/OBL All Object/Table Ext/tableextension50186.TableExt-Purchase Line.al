tableextension 50186 tableextension50186 extends "Purchase Line"
{
    fields
    {


        /* modify("TDS Group")
         {
             OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others,Rent for Plant & Machinery,Rent for Land & Building,Banking Services,Compensation On Immovable Property,PF Accumulated,Payment For Immovable Property,Goods';
         }
         modify("Service Tax Group")
         {
             TableRelation = "Service Tax Groups".Code WHERE(Blocked = CONST(No));
         }
         modify("Excise Refund")
         {
             Caption = 'Excise Refund';
         }
         modify("CWIP G/L Type")
         {
             Caption = 'CWIP G/L Type';
             OptionCaption = ' ,Labor,Material,Overheads';
         }*/
        modify("Applies-to ID (Delivery)")
        {
            Caption = 'Applies-to ID (Delivery)';
        }
        modify("Applies-to ID (Receipt)")
        {
            Caption = 'Applies-to ID (Receipt)';
        }
        modify("Delivery Challan Date")
        {
            Caption = 'Delivery Challan Date';
        }
        modify("GST Group Code")
        {
            TableRelation = "GST Group" WHERE(Blocked = CONST(false));
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            var
                RecPurchHeader: Record 38;
            begin
                CASE Type OF
                    Type::Item:
                        BEGIN
                            RecPurchHeader.Reset;
                            RecPurchHeader.setrange("No.", rec."Document No.");
                            RecPurchHeader.SetRange("Document Type", RecPurchHeader."Document Type"::Order);
                            if RecPurchHeader.FindFirst then
                                RecPurchHeader.testfield(NOE);
                            GetItem;
                            if rec."No." <> '' then
                                item.Get(Rec."No.");
                            IF UPPERCASE(USERID) <> 'admin' THEN
                                Item.TESTFIELD(Blocked, FALSE);
                            Item.TESTFIELD("Gen. Prod. Posting Group");
                            //Upgrade(+)

                            //MSBS.Rao Begin Dt. 30-04-13
                            MfgSetup.GET;
                            IF MfgSetup."Allow Discoutinued" THEN BEGIN
                                IF "Document Type" = "Document Type"::Order THEN
                                    IF Item."Inventory Posting Group" IN ['MANUF', 'TRAD'] THEN
                                        IF NOT Item.Retained THEN
                                            ERROR(MSErr0001, Item."No.", "Line No.");
                            END;
                            //MSBS.Rao End Dt. 30-04-13

                            //TRI A.S 28.05.08 Start
                            IF UPPERCASE(USERID) <> 'admin' THEN
                                IF Item."Purchase Blocked" THEN BEGIN
                                    ERROR(Text0003)
                                END ELSE
                                    //TRI A.S 28.05.08 End

                                    //Upgrade(-)
                                    IF Item.Type = Item.Type::Inventory THEN BEGIN
                                        Item.TESTFIELD("Inventory Posting Group");
                                        "Posting Group" := Item."Inventory Posting Group";
                                    END;
                            //Upgrade (+)
                            //mo tri1.0 Customization no.10 start
                            PurchasePayablesSetup.GET;
                            "Rejection Reason Code" := PurchasePayablesSetup."Rejection Reason Code";
                            "Shortage Reason Code" := PurchasePayablesSetup."Shortage Reason Code";
                            //mo tri1.0 Customization no.10 end
                            //Upgrade(-)
                        end;
                end;
            end;


        }




        modify("Location Code")
        {
            trigger OnAfterValidate()
            begin
                IF "Line No." = 0 THEN
                    //ERROR('While making a new line you cannot change the Location Code. Please change the Location Code after Inserting the Line.');
                    GLSetup.GET;
                GeneralLedgerSetup.RESET;
                GeneralLedgerSetup.FIND('-');
                Location1.RESET;
                Location1.SETFILTER(Location1.Code, "Location Code");
                IF Location1.FIND('-') THEN BEGIN
                    VALIDATE("Shortcut Dimension 1 Code", Location1."Location Dimension"); //TEAM::3333
                                                                                           //  VALIDATE("Shortcut Dimension 8 Code",GLSetup."Location Dimension Code"); //TEAM::3333
                    IF Location1."Main Location" <> '' THEN BEGIN
                        Location1.SETFILTER(Location1.Code, Location1."Main Location");
                        Location1.FIND('-');
                    END;
                    /* IF DocumentDimensions.GET(DATABASE::"Purchase Line", "Document Type", "Document No.", "Line No.",
                       GeneralLedgerSetup."Location Dimension Code") THEN BEGIN
                         DocumentDimensions."Dimension Value Code" := Location1."Location Dimension";
                         DocumentDimensions.MODIFY;
                     END ELSE BEGIN
                         DocumentDimensions."Table ID" := DATABASE::"Purchase Line";
                         DocumentDimensions."Document Type" := "Document Type";
                         DocumentDimensions."Document No." := "Document No.";
                         DocumentDimensions."Line No." := "Line No.";
                         DocumentDimensions."Dimension Code" := GeneralLedgerSetup."Location Dimension Code";
                         DocumentDimensions."Dimension Value Code" := Location1."Location Dimension";
                         DocumentDimensions.INSERT;
                     END;*///
                END;
                //ND Tri End Cust
                //ND Tri1.0 Start
                IF Location.GET("Location Code") THEN
                    "Main Location" := Location."Main Location";
                //ND Tri1.0 End

                //vipul Tri1.0 Start
                //IF PurchHeader.GET("Document Type","Document No.") THEN
                IF NOT Location.GetLocationFilter(PurchHeader."Location Code", "Location Code") THEN
                    ERROR('Please select %1 location or its sub locations.', PurchHeader."Location Code");
                //vipul Tri1.0 end
                //TRI V.D 01.10.10 START
                IF "Document Type" = "Document Type"::Invoice THEN BEGIN
                    tgSalesPrice.RESET;
                    tgSalesPrice.SETRANGE(tgSalesPrice."Item No.", "No.");
                    tgSalesPrice.SETRANGE(tgSalesPrice."Sales Type", tgSalesPrice."Sales Type"::"Customer Price Group");
                    tgSalesPrice.SETRANGE(tgSalesPrice."Unit of Measure Code", "Unit of Measure Code");
                    IF "Location Code" = 'SKD-PLANT' THEN          //MSNK PLANT>>SKD-PLANT 190315
                        tgSalesPrice.SETRANGE(tgSalesPrice."Sales Code", '27');
                    //TRI NP 071010 ADD CODE
                    IF "Location Code" = 'MORBI' THEN
                        tgSalesPrice.SETRANGE(tgSalesPrice."Sales Code", "Capex No.");

                    IF ("Location Code" <> 'MORBI') AND ("Location Code" <> 'SKD-PLANT') THEN BEGIN //MSNK PLANT>>SKD-PLANT 190315
                        Location.GET("Location Code");
                        tgSalesPrice.SETRANGE(tgSalesPrice."Sales Code", Location."Customer Price Group");
                    END;
                    //TRI NP 071010 ADD CODE
                    tgPurchRctHeader.RESET;
                    tgPurchRctHeader.SETRANGE("Buy-from Vendor No.", "Buy-from Vendor No.");
                    tgPurchRctHeader.SETRANGE("No.", "Receipt No.");
                    IF tgPurchRctHeader.FINDFIRST THEN
                        tgSalesPrice.SETFILTER(tgSalesPrice."Starting Date", '<=%1', tgPurchRctHeader."Vendor Invoice Date");
                    //TRI NP 071010 END\ CODE

                    //tgSalesPrice.SETFILTER(tgSalesPrice."Starting Date",'<=%1',PurchHeader."Vendor Invoice Date");
                    IF tgSalesPrice.FINDLAST THEN BEGIN
                        //MODIFY;
                    END;
                END;
                //TRI V.D 01.10.10 STOP
                //Upgrade(-)

            end;
        }

        modify(Description)
        {
            trigger OnAfterValidate()
            begin
                IF Type.AsInteger() <> 2 THEN
                    EXIT;
                CheckDescription;
            end;
        }

        modify("Description 2")
        {
            trigger OnAfterValidate()
            begin
                IF Type.AsInteger() <> 2 THEN
                    EXIT;
                CheckDescription;

            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                //mo tri1.0 Customization no.10 start
                IF "Document Type" <> "Document Type"::"Credit Memo" THEN BEGIN
                    "Challan Quantity" := 0;
                    "Actual Quantity" := 0;
                    "Accepted Quantity" := 0;
                    "Shortage Quantity" := 0;
                    "Rejected Quantity" := 0;
                END;
                //mo tri1.0 Customization no.10 end


                IF "Document Type" = "Document Type"::Order THEN BEGIN //Kulbhushan Sharma
                    UserSetup.GET(USERID);
                    //IF (UserSetup."User ID" <> 'PU007') AND (UserSetup."User ID" <> 'PU008') THEN BEGIN
                    //IF (UserSetup."User ID" <> 'PU007')  THEN BEGIN
                    IF "Indent No." <> '' THEN BEGIN
                        IndentLine.RESET;
                        IndentLine.SETFILTER("Document No.", "Indent No.");
                        IndentLine.SETRANGE("Line No.", "Indent Line No.");
                        IndentLine.SETFILTER("No.", "No.");
                        IF IndentLine.FINDFIRST THEN BEGIN
                            PendQty := IndentLine.GetTotalPOQty(IndentLine."Document No.", IndentLine."No.", IndentLine.Quantity, IndentLine."Line No.", TRUE, IndentLine."Orginal Entry"); //6700
                                                                                                                                                                                            //Keshav
                            IF (Quantity > GetIndentQty(IndentLine) - CheckIndentPOQty("Indent No.", "Indent Line No.", "No.", "Document No.", "Line No.")) THEN BEGIN
                                //Keshav
                                ERROR(Text0005) //Kulbhushan qty
                            END ELSE BEGIN//MSBS.Rao 241114
                                          //Keshav16042020
                                          //InsertPartialIndent(Rec,0,Quantity);//MSBS.Rao 241114
                                VALIDATE("Indent Original Quantity", Quantity);
                                //MESSAGE('%1-%2-%3-%4',IndentLine.Quantity,"Indent Original Quantity",CheckIndentPOQtyNew("Indent No.","Indent Line No.","No.","Document No.","Line No."),"Indent No.");
                                IF IndentLine.Quantity - (CheckIndentPOQtyNew("Indent No.", "Indent Line No.", "No.", "Document No.", "Line No.") + "Indent Original Quantity") <= 0 THEN BEGIN
                                    IndentLine.Status := IndentLine.Status::Closed;
                                    IndentLine.MODIFY;
                                END ELSE BEGIN
                                    IndentLine.Status := IndentLine.Status::Authorized;
                                    IndentLine.MODIFY;
                                END;
                                //Keshav16042020
                            END;
                        END;
                    END;
                END;

            end;
        }

        modify("Direct Unit Cost")
        {
            trigger OnAfterValidate()
            begin
                //RecvQty:=0;
                PurchaseLine.RESET;
                PurchaseLine.SETRANGE("Document Type", "Document Type");
                PurchaseLine.SETRANGE("Document No.", "Document No.");
                PurchaseLine.SETFILTER("Quantity Received", '<>%1', 0);
                IF PurchaseLine.FINDSET THEN BEGIN
                    REPEAT
                        RecvQty += PurchaseLine."Quantity Received";
                    UNTIL PurchaseLine.NEXT = 0;
                END;

                //MSKS091112 Start
                ValidatePurchaseOrderRate;
                //MSKS091112 End

                //Upgrade(-)
            end;
        }
        modify("VAT Prod. Posting Group")
        {
            trigger OnAfterValidate()
            begin
                IF PurchHeader."Prices Including VAT" AND (Type = Type::Item) THEN
                    IF "Direct Unit Cost" = 0 THEN  //TRI S.R Upgrade(+-)
                        "Direct Unit Cost" :=
                          ROUND(
                            "Direct Unit Cost" * (100 + "VAT %") / (100 + xRec."VAT %"),
                            Currency."Unit-Amount Rounding Precision");
                UpdateAmounts;

            end;
        }
        modify("Depreciation Book Code")
        {
            trigger OnAfterValidate()
            begin
                IF Type = Type::"Fixed Asset" THEN
                    IF FA.GET("No.") THEN
                        "Tax Group Code" := FA."Tax Group Code";
            end;
        }



        //Unsupported feature: Code Modification on ""Amount Including Tax"(Field 13702).OnValidate".// Field N/f

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Type);
        TESTFIELD(Quantity);
        TESTFIELD("Direct Unit Cost");
        #4..18
          "Amount To Vendor" := ROUND("Amount To Vendor");
        END;
        IF "Tax Base Amount" = 0 THEN
          "Tax %" := 0;

        InitOutstandingAmount;
        UpdateUnitCost;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..21
          "Tax %" := 0
        ELSE
          "Tax %" := ROUND(100 * ("Amount Including Tax" - "Tax Base Amount") / "Tax Base Amount",
             Currency."Amount Rounding Precision");
        #23..25
        */
        //end;



        //Unsupported feature: Code Modification on ""TDS Nature of Deduction"(Field 13741).OnValidate".// Field N/F

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TDSNOD.MODIFYALL(Mark,FALSE);
        SetFilterOnNODLines("TDS Nature of Deduction",'');
        GetPurchHeader;
        IF PurchHeader."Applies-to Doc. No." <> '' THEN
          PurchHeader.TESTFIELD("Applies-to Doc. No.",'');
        IF (PurchHeader."Applies-to ID" <> '') AND ("TDS Nature of Deduction" <> xRec."TDS Nature of Deduction") THEN
        #7..23
          "Country Code" :='';
        END;
        InitTDSAmounts(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        "Assessee Code" := PurchHeader."Assessee Code";
        #4..26
        */
        //end;

        modify(Status)
        {
            trigger OnAfterValidate()
            var
                ProdOrder: Record "Production Order";
            begin
                IF Status = Status::Released THEN BEGIN //Upgrade(+-)
                end ELSE

                    IF xRec.Status = Status::Released then
                        ProdOrder.SETRANGE(Status, ProdOrder.Status::Released);
                ProdOrder.SETFILTER("No.", "Prod. Order No.");
                IF ProdOrder.ISEMPTY THEN
                    ERROR(Text16361, "Prod. Order No.");
            end;

        }

        field(50000; "Rejection Reason Code"; Code[10])
        {
            Description = 'Customization No. 10';
            TableRelation = "Reason Code";
        }
        field(50001; "Shortage Reason Code"; Code[10])
        {
            Description = 'Customization No. 10';
            TableRelation = "Reason Code";
        }
        field(50002; "Challan Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Customization No. 10';

            trigger OnValidate()
            begin
                //mo tri1.0 customization no. 10 start
                VALIDATE("Qty. to Receive", "Challan Quantity");
                //VALIDATE("Qty. to Invoice","Challan Quantity");  //TRI Dg Stop
                "Actual Quantity" := 0;
                "Accepted Quantity" := 0;
                "Shortage Quantity" := 0;
                "Rejected Quantity" := 0;
                IF "Challan Quantity" > Quantity THEN
                    ERROR(Text0001, Quantity);
                //mo tri1.0 customization no. 10 end
            end;
        }
        field(50003; "Actual Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Customization No. 10';

            trigger OnValidate()
            begin
                //mo tri1.0 customization no. 10 start
                IF "Challan Quantity" = 0 THEN
                    "Actual Quantity" := 0;
                VALIDATE("Accepted Quantity", "Actual Quantity");

                IF "Actual Quantity" > "Challan Quantity" THEN
                    ERROR('You cannot enter more than %1 units', "Challan Quantity");

                "Shortage Quantity" := "Challan Quantity" - "Actual Quantity";

                IF "Accepted Quantity" <> 0 THEN
                    //  "Rejected Quantity" := "Actual Quantity" - "Accepted Quantity";
                    "Rejected Quantity" := "Challan Quantity" - ("Challan Quantity" - "Actual Quantity") - "Accepted Quantity"
                ELSE
                    "Rejected Quantity" := "Actual Quantity" - "Accepted Quantity";

                //mo tri1.0 customization no. 10 end

                //Kulbhushan Starts check the available qty before recv in purchase order
                IF Type = Type::Item THEN BEGIN
                    ile.SETCURRENTKEY("Item No.", "Location Code");
                    ile.SETRANGE("Item No.", "No.");
                    ile.SETRANGE("Location Code", "Location Code");

                    IF ile.FIND('-') THEN
                        ile.CALCSUMS(ile.Quantity);
                    ttqty := ile.Quantity;
                    IF ttqty > 0 THEN
                        MESSAGE('You have %1 Quantity at your Location. Dou Want to Receive More.', ttqty);
                END;

                UpdateReturnQty;
                VALIDATE("Qty. to Receive", "Challan Quantity");
            end;
        }
        field(50004; "Accepted Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Customization No. 10';

            trigger OnValidate()
            begin
                //mo tri1.0 customization no. 10 start
                IF "Accepted Quantity" > "Actual Quantity" THEN
                    ERROR('You cannot enter more than %1 units', "Actual Quantity");

                //"Rejected Quantity" := "Actual Quantity" - "Accepted Quantity";
                IF "Accepted Quantity" <> 0 THEN
                    //  "Rejected Quantity" := "Actual Quantity" - "Accepted Quantity";
                    "Rejected Quantity" := "Challan Quantity" - ("Challan Quantity" - "Actual Quantity") - "Accepted Quantity"
                ELSE
                    "Rejected Quantity" := "Actual Quantity" - "Accepted Quantity";

                VALIDATE("Qty. to Receive", "Challan Quantity");
                "Qty. to Receive (Base)" := "Qty. per Unit of Measure" * "Challan Quantity";     //TRI DG 121010
                //mo tri1.0 customization no. 10 end
                UpdateReturnQty;
            end;
        }
        field(50005; "Shortage Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Customization No. 10';

            trigger OnValidate()
            begin
                UpdateReturnQty;
            end;
        }
        field(50006; "Rejected Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Customization No. 10';
        }
        field(50010; "Indent No."; Code[20])
        {
            Description = 'Customization No. 1 ND';
            Editable = true;
        }
        field(50011; "Indent Line No."; Integer)
        {
            Description = 'Customization No. 1 ND';
            Editable = true;
        }
        field(50012; Make; Text[20])
        {
        }
        field(50013; "Indent Date"; Date)
        {
            Description = 'Report 84 EXIM ravi';
        }
        field(50014; "Main Location"; Code[10])
        {
        }
        field(50015; "Starting Date"; Date)
        {

            trigger OnValidate()
            begin
                //Vipul Tri1.0
                TestStatusOpen;
                IF ("Ending Date" <> 0D) AND ("Starting Date" > "Ending Date") THEN
                    ERROR('Starting Date must not be greater then Ending Date');
            end;
        }
        field(50016; "Ending Date"; Date)
        {

            trigger OnValidate()
            begin
                //Vipul Tri1.0
                TestStatusOpen;
                IF ("Starting Date" <> 0D) AND ("Starting Date" > "Ending Date") THEN
                    ERROR('Ending Date must be greater then Starting Date');
            end;
        }
        field(50019; "Excise Amount Per Unit"; Decimal)
        {
            DecimalPlaces = 2 : 4;
            Description = 'ND';
        }
        field(50020; "Posting Date 1"; Date)
        {
            Editable = true;
        }
        field(50021; "Unit Price (FCY)"; Decimal)
        {
            Caption = 'Unit Price (FCY) Per Sq.Mt.';
            Description = 'ND';

            trigger OnValidate()
            begin
                TESTFIELD(Quantity);
                "Amount (FCY)" := Quantity * "Unit Price (FCY)";
            end;
        }
        field(50022; "Amount (FCY)"; Decimal)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50023; Currency1; Code[5])
        {
            TableRelation = Currency;
        }
        field(50024; "Receipt Date"; Date)
        {
            CalcFormula = Lookup("Purch. Rcpt. Header"."Posting Date" WHERE("No." = FIELD("Receipt No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50025; "Source Order No."; Code[20])
        {
            Description = 'TRI S.K 030610';
        }
        field(50026; "Selection."; Boolean)
        {
            Description = 'Ori Ut270710';

            trigger OnValidate()
            begin
                //VALIDATE(Selection,TRUE);
            end;
        }
        field(50031; "Shortage CRN"; Boolean)
        {
            Description = 'TRI VKG 23.09.10';
        }
        field(50038; "Orient MRP"; Decimal)
        {
            Description = 'TRI V.D New Field Added';
        }
        field(50039; "Capex No."; Code[22])
        {
            Description = 'Ori  Ut';
            Editable = true;
            TableRelation = "Budget Master"."No." WHERE(Status = CONST(Released));
        }
        field(50042; "Ref. Rate"; Decimal)
        {
        }
        field(50043; "Possible Cenvat"; Decimal)
        {
        }
        field(50044; "Old Pending Qty"; Decimal)
        {
            Description = 'MSBS.Rao 231214 Used for Indent Validation';
        }
        field(50045; "Diff Qty."; Decimal)
        {
        }
        field(50046; "Ref Code"; Code[20])
        {
            CalcFormula = Lookup(Item."Old Code" WHERE("No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50047; "Batch No."; Code[15])
        {
        }
        field(50048; "Document Date"; Date)
        {
            CalcFormula = Lookup("Purchase Header"."Document Date" WHERE("No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50049; "ITC Type"; Option)
        {
            OptionCaption = ' ,Input Goods,Input Servce,Input Capital Goods,NON GST';
            OptionMembers = " ","Input Goods","Input Servce","Input Capital Goods","NON GST";
        }
        field(50050; "PO No."; Code[25])
        {
            TableRelation = "Purchase Header"."No." WHERE("Buy-from Vendor No." = FIELD("Buy-from Vendor No."),
                                                         "Document Type" = CONST(Order));
        }
        field(50051; "Purchase Header Status"; Option)
        {
            CalcFormula = Lookup("Purchase Header".Status WHERE("No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Short Close,Authorization1,Approved,Authorization3,Authorized,Closed';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment","Short Close",Authorization1,Approved,Authorization3,Authorized,Closed;
        }
        field(50052; "Vendor Name"; Text[50])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Buy-from Vendor No.")));
            FieldClass = FlowField;
        }
        field(50053; "Indent Original Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Keshav';

            trigger OnValidate()
            var
                rIndentLine: Record "Indent Line";
                rPurchaseLine: Record "Purchase Line";
                decIndQty: Decimal;
            begin
                // IF ("Indent No."<>'') AND ("Indent Line No."<>0) THEN BEGIN
                //  decIndQty:=0;
                //  rPurchaseLine.RESET;
                //  rPurchaseLine.SETRANGE("Indent No.","Indent No.");
                //  rPurchaseLine.SETRANGE("Indent Line No.","Indent Line No.");
                //  rPurchaseLine.SETRANGE("No.","No.");
                //  IF rPurchaseLine.FIND('-') THEN BEGIN
                //    REPEAT
                //      decIndQty+=rPurchaseLine."Indent Original Quantity";
                //    UNTIL rPurchaseLine.NEXT=0;
                //
                //    rIndentLine.RESET;
                //    rIndentLine.SETRANGE("Document No.","Indent No.");
                //    rIndentLine.SETRANGE("Line No.","Indent Line No.");
                //    IF rIndentLine.FIND('-') THEN BEGIN
                //      IF decIndQty=rIndentLine.Quantity THEN
                //        rIndentLine.Status:=rIndentLine.Status::Closed
                //      ELSE
                //        rIndentLine.Status:=rIndentLine.Status::Authorized;
                //      rIndentLine.MODIFY;
                //    END;
                //  END;
                // END;
            end;
        }
        field(50054; "Original PO Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60028; NOE; Code[15])
        {
            Description = 'MSVRN 060918';
            TableRelation = "NOE Permission".NOE WHERE(Location = FIELD("Location Code"));
        }
        field(60029; "Item No "; Code[20])
        {
            Description = 'Item No ';
            TableRelation = IF (Type = CONST(Item)) Item."No." WHERE(Blocked = CONST(false));
        }


    }
    keys
    {

        //Unsupported feature: Property Modification (SumIndexFields) on ""Document Type,Document No.,Type,No."(Key)".

        //key(Key19; "Buy-from Vendor No.", "Document No.", "Order Date", Type, "No.")
        //{
        //}
        /*   key(Key20; "Document No.")
          {
              SumIndexFields = Quantity, "Quantity Received";
          } */
        /* key(Key21; "No.", "Indent No.", "Indent Line No.", Status)
         {
             SumIndexFields = Quantity, "Outstanding Quantity", "Quantity Received";
         }*/
        /*    key(Key22; "Document Type", "Document No.", Type/*, "HSN/SAC Code")
           {
           } */
        key(Key23; "Indent No.", "Indent Line No.")
        {
            //SumIndexFields = Quantity;
        }
    }
    trigger OnAfterDelete()
    begin
        //ND Tri Start Cust 38
        IF "Document Type" = "Document Type"::Quote THEN
            UserAccess := 8;
        IF PurchHeader11.GET("Document Type", "Document No.") THEN
            IF ("Document Type" = "Document Type"::Order) THEN
                UserAccess := 9;
        IF "Document Type" = "Document Type"::Invoice THEN
            UserAccess := 10;
        IF "Document Type" = "Document Type"::"Credit Memo" THEN
            UserAccess := 11;
        IF "Document Type" = "Document Type"::"Blanket Order" THEN
            UserAccess := 12;
        IF "Document Type" = "Document Type"::"Return Order" THEN
            UserAccess := 13;
        IF "Location Code" <> '' THEN BEGIN
            Permissions.Type(UserAccess, xRec."Location Code");
            Permissions.Type(UserAccess, "Location Code");
        END;
        //ND Tri End Cust 38

    end;

    trigger OnAfterInsert()// 15578
    begin
        //ravi tri1.0 start
        GetPurchHeader;
        "Posting Date 1" := PurchHeader."Posting Date";

        //ravi tri1.0 start
        //Upgrade(-)
        //Upgrade(+)
        //ND Tri Start Cust 38
        IF "Document Type" = "Document Type"::Quote THEN
            UserAccess := 8;
        IF PurchHeader11.GET("Document Type", "Document No.") THEN
            IF ("Document Type" = "Document Type"::Order) THEN
                UserAccess := 9;
        IF "Document Type" = "Document Type"::Invoice THEN
            UserAccess := 10;
        IF "Document Type" = "Document Type"::"Credit Memo" THEN
            UserAccess := 11;
        IF "Document Type" = "Document Type"::"Blanket Order" THEN
            UserAccess := 12;
        IF "Document Type" = "Document Type"::"Return Order" THEN
            UserAccess := 13;
        IF Type <> Type::" " THEN
            Permissions.Type(UserAccess, "Location Code");
        //ND Tri End Cust 38
        //Upgrade(-)
    end;

    trigger OnAfterModify()// 15578
    begin
        //ND Tri Start Cust 38
        IF "Document Type" = "Document Type"::Quote THEN
            UserAccess := 8;
        IF PurchHeader11.GET("Document Type", "Document No.") THEN
            IF ("Document Type" = "Document Type"::Order) THEN
                UserAccess := 9;
        IF "Document Type" = "Document Type"::Invoice THEN
            UserAccess := 10;
        IF "Document Type" = "Document Type"::"Credit Memo" THEN
            UserAccess := 11;
        IF "Document Type" = "Document Type"::"Blanket Order" THEN
            UserAccess := 12;
        IF "Document Type" = "Document Type"::"Return Order" THEN
            UserAccess := 13;
        IF "Location Code" <> '' THEN BEGIN
            //  Permissions.Type(UserAccess,xRec."Location Code");
            Permissions.Type(UserAccess, "Location Code");
        END;
        //ND Tri End Cust 38

    end;


    //Unsupported feature: Code Modification on "CalcBaseQty(PROCEDURE 14)".// Codeunit 50000

    //procedure CalcBaseQty();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Prod. Order No." = '' THEN
      TESTFIELD("Qty. per Unit of Measure");
    EXIT(ROUND(Qty * "Qty. per Unit of Measure",0.00001));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Prod. Order No." = '' THEN
      TESTFIELD("Qty. per Unit of Measure");
    //Upgrade(+)
    //"Qty. per Unit of Measure" := ROUND("Qty. per Unit of Measure",0.00001,'='); //TRI DEL ADD
    //EXIT(ROUND(Qty * "Qty. per Unit of Measure",0.00001)); //TRI DEL ADD
    EXIT(Qty*ROUND("Qty. per Unit of Measure",0.00001,'='));         //TRI ADD
    //Upgrade(-)
    */
    //end;

    //Unsupported feature: Code Modification on "UpdateTaxAmounts(PROCEDURE 1280007)".// FUNCTION N/F

    //procedure UpdateTaxAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TaxAreaUpdate;
    IF (Quantity = 0 ) OR ("Direct Unit Cost" = 0) THEN BEGIN
      "Amount Added to Tax Base" := 0;
    #4..78
    "Amount Including Tax" := ("Tax Base Amount" + "Tax Amount");

    IF "Tax Base Amount" = 0 THEN
      "Tax %" := 0;

    GetPurchHeader;
    IF GetServiceTaxSetup(ServiceTaxSetup) AND (NOT GSTManagement.IsGSTApplicable(PurchHeader.Structure)) THEN BEGIN
      ServiceTaxAbatement := CalculateAbatementPercentage(ServiceTaxSetup);
      CalculateServiceTaxAmounts(ServiceTaxSetup,ServiceTaxAbatement)
    END ELSE
      ClearServiceTaxAmounts;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..81
      "Tax %" := 0
    ELSE
      "Tax %" := ROUND(100 * ("Amount Including Tax" - "Tax Base Amount") / "Tax Base Amount",
         Currency."Amount Rounding Precision");

    #83..89
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateExciseAmount(PROCEDURE 1280021)".// FUNCTION N/F

    //procedure UpdateExciseAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetPurchHeader;
    IF "Amount Added to Excise Base" <> 0 THEN BEGIN
      "Excise Base Amount" := "Amount Added to Excise Base";
    #4..47
          ExcisePostingSetup."BED Calculation Type"::"Amount/Unit":
            BEGIN
              TESTFIELD("Excise Base Quantity");
              "BED Amount" := ExcisePostingSetup."BED Amount Per Unit" * "Excise Base Quantity";
            END;
          ExcisePostingSetup."BED Calculation Type"::"% of Accessable Value":
            "BED Amount" := ExcisePostingSetup."BED %" * "Assessable Value" * Quantity / 100;
    #55..498
      "NCCD Amount" + "eCess Amount" + "ADET Amount" + "AED(TTA) Amount" + "ADE Amount" + "ADC VAT Amount" +
      "SHE Cess Amount" + "Custom eCess Amount" + "Custom SHECess Amount";
    "Amount Including Excise" := "Excise Base Amount" + "Excise Amount";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..50
             // "BED Amount" := ExcisePostingSetup."BED Amount Per Unit" * "Excise Base Quantity";         //Tri Upgrade(+-)
             "BED Amount" := "Excise Amount Per Unit" * "Excise Base Quantity"; //TRI S.R Added
    #52..501
    */
    //end;


    //Unsupported feature: Code Modification on "CalculateStructures(PROCEDURE 1280003)".// FUNCTION N/F

    //procedure CalculateStructures();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH PurchHeader DO BEGIN
      Currency.Initialize("Currency Code");
      IF "Currency Code" <> '' THEN BEGIN
    #4..40
      PurchLine.SETRANGE("Document Type","Document Type");
      PurchLine.SETRANGE("Document No.","No.");
      IF PurchLine.FIND('-') THEN BEGIN
        Vendor.GET("Buy-from Vendor No.");
        REPEAT
          IF (PurchLine.Quantity <> 0) AND (PurchLine."Direct Unit Cost" <> 0) THEN BEGIN
            WITH PurchLine DO BEGIN
    #48..99
                      StrOrderLineDetails."Inc. GST in TDS Base" := StrOrderDetails."Inc. GST in TDS Base";

                    StrOrderLineDetails.CVD := StrOrderDetails.CVD;

                    IF (StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::"Sales Tax") OR
                       (StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::Excise)
                    THEN BEGIN
    #107..335
          PurchHeader."Document Type",PurchHeader."No.",CFactor,Currency."Amount Rounding Precision");
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..43
        Vendor.GET(PurchHeader."Buy-from Vendor No.");
    #45..102
                    StrOrderLineDetails."Charge Type" := StrOrderDetails."Charge Type"; //TRI S.C Upgrade(+-)
    #104..338
    */
    //end;

    //Unsupported feature: Code Modification on "CalculateTDS(PROCEDURE 1280004)".// FUNCTION N/F

    //procedure CalculateTDS();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH PurchHeader DO
      IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN BEGIN
        IF HasLineWithTDS THEN
          ERROR(Text16512);
        IF HasLineWithWorkTax THEN
          ERROR(Text16511);
      END ELSE BEGIN
        IF "Assessee Code" = '' THEN
          EXIT;
        IF "Currency Code" = '' THEN
          Currency.InitRoundingPrecision;
        Vendor.GET("Pay-to Vendor No.");
        TDSBuf[1].DELETEALL;
        CalculatedTDSAmt := 0;
        CalculatedSurchargeAmt := 0;
        SurchargeBase := 0;
        "Per Contract" := FALSE;
        PurchLine.SETRANGE("Document Type","Document Type");
        PurchLine.SETRANGE("Document No.","No.");
        PurchLine.SETFILTER("No.",'<>%1','');
        IF PurchLine.FIND('-') THEN
          REPEAT
            WITH PurchLine DO BEGIN
              IF ("TDS Nature of Deduction" <> '') AND (AccountingPeriodFilter = '') THEN
                DateFilterCalc.CreateTDSAccountingDateFilter(AccountingPeriodFilter,FiscalYear,PurchHeader."Posting Date",0);
              TDSBuf[1].DELETEALL;
              CalculatedTDSAmt := 0;
              CalculatedSurchargeAmt := 0;
              InitTDSAmounts(PurchLine);
              TDSPercentage := 0;
              SurchargePercentage := 0;
              ReverseChargePct := GetReverseChargePct(Vendor."Service Entity Type");
              CurrentPOAmount := 0;
              CurrentPOTDSAmt := 0;
              CurrentPOContractAmt := 0;
              CurrentPOContractTDSAmt := 0;
              TDSBaseLCY := 0;
              "Per Contract" := FALSE;
              GetTDSAppliedAmt(PurchHeader,PurchLine,AppliedAmountDoc,RemainingAmount,AppliedAmount);
              TDSGroup.RESET;
              IF TDSGroup.FindOnDate("TDS Group",PurchHeader."Posting Date") THEN
                IF PurchHeader."Currency Code" <> '' THEN BEGIN
                  IF NOT TDSGroup."Non Resident Payments" THEN
                    EXIT;
                END ELSE BEGIN
                  IF TDSGroup."Non Resident Payments" THEN
                    EXIT;
                END;
              IF ("TDS Nature of Deduction" <> '') AND ("Line Amount" < 0) THEN
                ERROR(Text16509,"Document Type","Document No.","Line No.");
              IF NOT GSTManagement.GetReverseCharge(PurchHeader."Pay-to Vendor No.") AND
                 GSTManagement.IsGSTApplicable(PurchHeader.Structure) AND
                 StrOrdLineDet.DoesTDSBaseIncludeGST(PurchHeader)
              THEN
                TDSBaseLCY := "Line Amount" - "Inv. Discount Amount" + "Total GST Amount"
              ELSE
                TDSBaseLCY := "Line Amount" - "Inv. Discount Amount";

              IF StrOrdLineDet.FindLinesInclInTDSBase(PurchLine) THEN
                REPEAT
                  IF ReverseChargePct > 0 THEN
                    StrOrdLineDet.Amount := ROUND(StrOrdLineDet.Amount * (100 - ReverseChargePct) / 100);
                  TDSBaseLCY := TDSBaseLCY + StrOrdLineDet.Amount;
                UNTIL StrOrdLineDet.NEXT = 0;
              IF "Currency Code" = '' THEN
                TDSBaseLCY := ABS(TDSBaseLCY)
              ELSE
                TDSBaseLCY := ROUND(
                    CurrExchRate.ExchangeAmtFCYToLCY(PurchHeader."Posting Date","Currency Code",
                    ABS(TDSBaseLCY),"Currency Factor"));
              CalcPrevTDSAmounts(PurchLine,AccountingPeriodFilter,PreviousAmount,PreviousBaseAMTWithTDS,PreviousAmount1,
                PreviousTDSAmt1,PreviousTDSAmt,PreviousSurchargeAmt,PreviousContractAmount);

              CurrPurchLine.RESET;
              CurrPurchLine.SETRANGE("Document Type","Document Type");
              CurrPurchLine.SETRANGE("Document No.","Document No.");
              CurrPurchLine.SETRANGE("TDS Group","TDS Group");
              CurrPurchLine.SETRANGE("TDS Nature of Deduction","TDS Nature of Deduction");
              CurrPurchLine.SETRANGE("Assessee Code","Assessee Code");
              CurrPurchLine.SETFILTER("Line No.",'<%1',"Line No.");
              IF CurrPurchLine.FIND('-') THEN
                REPEAT
                  IF NOT GSTManagement.GetReverseCharge(PurchHeader."Pay-to Vendor No.") AND
                     GSTManagement.IsGSTApplicable(PurchHeader.Structure) AND
                     StrOrdLineDet.DoesTDSBaseIncludeGST(PurchHeader)
                  THEN
                    CurrentPOAmount := CurrentPOAmount + CurrPurchLine."Line Amount" + CurrPurchLine."Total GST Amount" -
                      CurrPurchLine."Inv. Discount Amount"
                  ELSE
                    CurrentPOAmount := CurrentPOAmount + CurrPurchLine."Line Amount" - CurrPurchLine."Inv. Discount Amount";
                  IF StrOrdLineDet.FindLinesInclInTDSBase(CurrPurchLine) THEN
                    REPEAT
                      CurrentPOAmount += StrOrdLineDet.Amount;
                    UNTIL StrOrdLineDet.NEXT = 0;
                  CurrentPOTDSAmt := CurrentPOTDSAmt + CurrPurchLine."Total TDS Including SHE CESS";
                UNTIL CurrPurchLine.NEXT = 0;
              IF "Currency Code" <> '' THEN
                CurrentPOAmount := ROUND(
                    CurrExchRate.ExchangeAmtFCYToLCY(
                      PurchHeader."Posting Date","Currency Code",
                      CurrentPOAmount,"Currency Factor"));
              CurrPurchLine.RESET;
              CurrPurchLine.SETRANGE("Document Type","Document Type");
              CurrPurchLine.SETRANGE("Document No.","Document No.");
              CurrPurchLine.SETRANGE("TDS Group","TDS Group");
              CurrPurchLine.SETRANGE("TDS Nature of Deduction","TDS Nature of Deduction");
              CurrPurchLine.SETRANGE("Assessee Code","Assessee Code");
              CurrPurchLine.SETRANGE("Per Contract",TRUE);
              CurrPurchLine.SETFILTER("Line No.",'<%1',"Line No.");
              IF CurrPurchLine.FIND('-') THEN
                REPEAT
                  CurrentPOContractAmt := CurrentPOContractAmt + CurrPurchLine."TDS Base Amount";
                  CurrentPOContractTDSAmt := CurrentPOContractTDSAmt + CurrPurchLine."Total TDS Including SHE CESS";
                UNTIL CurrPurchLine.NEXT = 0;
              IF NODLines.FindNODLines(NODLines.Type::Vendor,"Pay-to Vendor No.","TDS Nature of Deduction") THEN
                IF NOT TDSSetup.FindOnDate("TDS Nature of Deduction","Assessee Code","TDS Group",
                     NODLines."Concessional Code",PurchHeader."Posting Date","Nature of Remittance","Act Applicable","Country Code")
                THEN BEGIN
                  "TDS %" := 0;
                  TDSSetupPercentage := 0;
                  "eCESS % on TDS" := 0;
                  "SHE Cess % On TDS" := 0;
                  "Work Tax %" := 0;
                  "Surcharge %" := 0;
                  "TDS Amount" := 0;
                  "Surcharge Amount" := 0;
                  "Work Tax Amount" := 0;
                  "Total TDS Including SHE CESS" := 0;
                  "Bal. TDS Including SHE CESS" := 0;
                END ELSE BEGIN
                  IF (Vendor."P.A.N. Status" = Vendor."P.A.N. Status"::" ") AND (Vendor."P.A.N. No." <> '') THEN
                    TDSSetupPercentage := TDSSetup."TDS %"
                  ELSE
                    TDSSetupPercentage := TDSSetup."Non PAN TDS %";
                  IF (PurchHeader."Applies-to Doc. No." = '') AND (PurchHeader."Applies-to ID" = '') THEN BEGIN
                    IF NODLines."Threshold Overlook" THEN BEGIN
                      "TDS Base Amount" := TDSBaseLCY;
                      "TDS %" := TDSSetupPercentage;
                      "eCESS % on TDS" := TDSSetup."eCESS %";
                      "SHE Cess % On TDS" := TDSSetup."SHE Cess %";
                      IF NODLines."Surcharge Overlook" THEN BEGIN
                        "Surcharge Base Amount" := TDSBaseLCY;
                        "Surcharge %" := TDSSetup."Surcharge %";
                      END ELSE BEGIN
                        TDSGroup.FindOnDate("TDS Group",PurchHeader."Posting Date");
                        IF (PreviousAmount + CurrentPOAmount) > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                          "Surcharge Base Amount" := TDSBaseLCY;
                          "Surcharge %" := TDSSetup."Surcharge %";
                          PreviousSurchargeAmt := 0;
                        END ELSE BEGIN
                          IF (PreviousAmount + CurrentPOAmount + TDSBaseLCY) > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                            "Surcharge Base Amount" := PreviousAmount + CurrentPOAmount + TDSBaseLCY;
                            "Surcharge %" := TDSSetup."Surcharge %";
                            TDSPercentage := "TDS %";
                            SurchargePercentage := "Surcharge %";
                            IF "Surcharge %" <> 0 THEN
                              CalculateSurcharge := TRUE;
                            FilterTDSEntry(PurchLine,TDSEntry,AccountingPeriodFilter);
                            IF TDSEntry.FIND('-') THEN
                              REPEAT
                                InsertTDSBuf(TDSEntry,PurchHeader."Posting Date",CalculateSurcharge,FALSE);
                              UNTIL TDSEntry.NEXT = 0;
                            IF TDSEntry.FINDFIRST THEN BEGIN
                              SurchargeBaseLCY := TDSBaseLCY + CurrentPOAmount;
                              InsertGenTDSBuf(TDSBaseLCY,TempTDSBase,SurchargeBaseLCY,TDSPercentage,SurchargePercentage,FALSE);
                            END ELSE BEGIN
                              SurchargeBaseLCY := "Surcharge Base Amount";
                              InsertGenTDSBuf(TDSBaseLCY,TempTDSBase,SurchargeBaseLCY,TDSPercentage,SurchargePercentage,FALSE);
                            END;
                          END ELSE
                            "Surcharge %" := 0;
                        END;
                      END;
                    END ELSE BEGIN
                      TDSGroup.FindOnDate("TDS Group",PurchHeader."Posting Date");
                      IF (PreviousAmount + CurrentPOAmount) > TDSGroup."TDS Threshold Amount" THEN BEGIN
                        "TDS Base Amount" := TDSBaseLCY - CurrentPOContractAmt;
                        "TDS %" := TDSSetupPercentage;
                        "eCESS % on TDS" := TDSSetup."eCESS %";
                        "SHE Cess % On TDS" := TDSSetup."SHE Cess %";
                        IF NODLines."Surcharge Overlook" THEN BEGIN
                          "Surcharge Base Amount" := TDSBaseLCY;
                          "Surcharge %" := TDSSetup."Surcharge %";
                        END ELSE
                          IF (PreviousAmount + CurrentPOAmount) > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                            "Surcharge Base Amount" := TDSBaseLCY;
                            "Surcharge %" := TDSSetup."Surcharge %";
                            PreviousSurchargeAmt := 0;
                          END ELSE BEGIN
                            IF (PreviousAmount + CurrentPOAmount + TDSBaseLCY) > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                              "Surcharge Base Amount" := PreviousAmount + CurrentPOAmount + TDSBaseLCY;
                              "Surcharge %" := TDSSetup."Surcharge %";
                              TDSPercentage := "TDS %";
                              SurchargePercentage := "Surcharge %";
                              IF "Surcharge %" <> 0 THEN
                                CalculateSurcharge := TRUE;
                              FilterTDSEntry(PurchLine,TDSEntry,AccountingPeriodFilter);
                              IF TDSEntry.FIND('-') THEN
                                REPEAT
                                  InsertTDSBuf(TDSEntry,PurchHeader."Posting Date",CalculateSurcharge,FALSE);
                                UNTIL TDSEntry.NEXT = 0;
                              IF TDSEntry.FIND('-') THEN BEGIN
                                SurchargeBaseLCY := TDSBaseLCY + CurrentPOAmount;
                                InsertGenTDSBuf(TDSBaseLCY,TempTDSBase,SurchargeBaseLCY,TDSPercentage,SurchargePercentage,FALSE);
                              END ELSE BEGIN
                                SurchargeBaseLCY := "Surcharge Base Amount";
                                InsertGenTDSBuf(TDSBaseLCY,TempTDSBase,SurchargeBaseLCY,TDSPercentage,SurchargePercentage,FALSE);
                              END;
                            END ELSE
                              "Surcharge %" := 0;
                          END;
                      END ELSE
                        IF TDSGroup."Per Contract Value" <> 0 THEN
                          IF (PreviousAmount + CurrentPOAmount + TDSBaseLCY) > TDSGroup."TDS Threshold Amount" THEN BEGIN
                            IF PreviousContractAmount <> 0 THEN
                              "TDS Base Amount" := (PreviousAmount1 + TDSBaseLCY) - PreviousContractAmount + CurrentPOAmount -
                                CurrentPOContractAmt
                            ELSE
                              "TDS Base Amount" := (PreviousAmount1 + TDSBaseLCY) - PreviousBaseAMTWithTDS + CurrentPOAmount;
                            "TDS %" := TDSSetupPercentage;
                            "eCESS % on TDS" := TDSSetup."eCESS %";
                            "SHE Cess % On TDS" := TDSSetup."SHE Cess %";
                            IF NODLines."Surcharge Overlook" THEN BEGIN
                              "Surcharge Base Amount" := ((PreviousAmount + TDSBaseLCY) - PreviousContractAmount +
                                                          CurrentPOAmount - CurrentPOContractAmt);
                              "Surcharge %" := TDSSetup."Surcharge %";
                            END ELSE BEGIN
                              TDSGroup.FindOnDate("TDS Group",PurchHeader."Posting Date");
                              IF (PreviousAmount + CurrentPOAmount) > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                "Surcharge Base Amount" := TDSBaseLCY;
                                "Surcharge %" := TDSSetup."Surcharge %";
                              END ELSE BEGIN
                                IF (PreviousAmount + CurrentPOAmount + TDSBaseLCY) > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                  "Surcharge Base Amount" := PreviousAmount + TDSBaseLCY - PreviousContractAmount + CurrentPOAmount;
                                  "Surcharge %" := TDSSetup."Surcharge %";
                                END ELSE
                                  "Surcharge %" := 0;
                              END;
                            END;
                            TDSPercentage := "TDS %";
                            SurchargePercentage := "Surcharge %";
                            IF "Surcharge %" <> 0 THEN
                              CalculateSurcharge := TRUE;
                            FilterTDSEntry(PurchLine,TDSEntry,AccountingPeriodFilter);
                            TDSEntry.SETFILTER("TDS Amount Including Surcharge",'0');
                            IF TDSEntry.FIND('-') THEN
                              REPEAT
                                InsertTDSBuf(TDSEntry,PurchHeader."Posting Date",CalculateSurcharge,TRUE);
                              UNTIL TDSEntry.NEXT = 0;
                            IF TDSEntry.FIND('-') THEN BEGIN
                              SurchargeBaseLCY := TDSBaseLCY + CurrentPOAmount;
                              TotalTDSBaseLCY := TDSBaseLCY + CurrentPOAmount;
                              InsertGenTDSBuf(TotalTDSBaseLCY,TempTDSBase,SurchargeBaseLCY,TDSPercentage,SurchargePercentage,FALSE);
                            END ELSE BEGIN
                              TDSBaseLCY := "TDS Base Amount";
                              SurchargeBaseLCY := "Surcharge Base Amount";
                              InsertGenTDSBuf(TDSBaseLCY,TempTDSBase,SurchargeBaseLCY,TDSPercentage,SurchargePercentage,FALSE);
                            END;
                          END ELSE BEGIN
                            IF (TDSBaseLCY + CurrentPOAmount) > TDSGroup."Per Contract Value" THEN BEGIN
                              "Per Contract" := TRUE;
                              "TDS Base Amount" := TDSBaseLCY + CurrentPOAmount - CurrentPOContractAmt;
                              "TDS %" := TDSSetupPercentage;
                              "eCESS % on TDS" := TDSSetup."eCESS %";
                              "SHE Cess % On TDS" := TDSSetup."SHE Cess %";
                              IF NODLines."Surcharge Overlook" THEN BEGIN
                                "Surcharge Base Amount" := ABS(TDSBaseLCY + CurrentPOAmount - CurrentPOContractAmt);
                                "Surcharge %" := TDSSetup."Surcharge %";
                              END ELSE BEGIN
                                TDSGroup.FindOnDate("TDS Group",PurchHeader."Posting Date");
                                IF TDSBaseLCY > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                  "Surcharge Base Amount" := TDSBaseLCY;
                                  "Surcharge %" := TDSSetup."Surcharge %";
                                END ELSE
                                  "Surcharge %" := 0;
                              END;
                            END ELSE BEGIN
                              "TDS Base Amount" := TDSBaseLCY;
                              "TDS %" := 0;
                              "eCESS % on TDS" := 0;
                              "SHE Cess % On TDS" := 0;
                            END;
                          END
                        ELSE // New Code Ends here
                          IF (PreviousAmount + CurrentPOAmount + TDSBaseLCY) > TDSGroup."TDS Threshold Amount" THEN BEGIN
                            IF PreviousTDSAmt = 0 THEN
                              "TDS Base Amount" := PreviousAmount1 + TDSBaseLCY + CurrentPOAmount - PreviousBaseAMTWithTDS
                            ELSE
                              "TDS Base Amount" := TDSBaseLCY;
                            IF PreviousTDSAmt1 <> 0 THEN
                              "TDS Base Amount" := PreviousAmount1 + TDSBaseLCY + CurrentPOAmount;
                            "TDS %" := TDSSetupPercentage;
                            "eCESS % on TDS" := TDSSetup."eCESS %";
                            "SHE Cess % On TDS" := TDSSetup."SHE Cess %";
                            IF NODLines."Surcharge Overlook" THEN BEGIN
                              "Surcharge Base Amount" := ABS(PreviousAmount + CurrentPOAmount +
                                  TDSBaseLCY);
                              "Surcharge %" := TDSSetup."Surcharge %";
                            END ELSE BEGIN
                              TDSGroup.FindOnDate("TDS Group",PurchHeader."Posting Date");
                              IF (PreviousAmount + CurrentPOAmount) > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                "Surcharge Base Amount" := TDSBaseLCY;
                                "Surcharge %" := TDSSetup."Surcharge %";
                                PreviousSurchargeAmt := 0;
                              END ELSE BEGIN
                                IF (PreviousAmount + CurrentPOAmount + TDSBaseLCY) > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                  "Surcharge Base Amount" := PreviousAmount + CurrentPOAmount + TDSBaseLCY;
                                  "Surcharge %" := TDSSetup."Surcharge %";
                                END ELSE
                                  "Surcharge %" := 0;
                              END;
                            END;
                            TDSPercentage := "TDS %";
                            SurchargePercentage := "Surcharge %";
                            IF "Surcharge %" <> 0 THEN
                              CalculateSurcharge := TRUE;
                            TDSEntry.RESET;
                            TDSEntry.SETCURRENTKEY(
                              "Party Type","Party Code","Posting Date","TDS Group","Assessee Code",Applied);
                            TDSEntry.SETRANGE("Party Type",TDSEntry."Party Type"::Vendor);
                            TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.");
                            TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
                            TDSEntry.SETRANGE("TDS Group","TDS Group");
                            TDSEntry.SETRANGE("Assessee Code","Assessee Code");
                            TDSEntry.SETRANGE("Bal. TDS Including SHE CESS",0);
                            TDSEntry.SETFILTER("TDS Line Amount",'>%1',0);
                            TDSEntry.SETRANGE(Applied,FALSE);
                            TDSEntry.SETRANGE("TDS Adjustment",FALSE);
                            TDSEntry.SETRANGE(Adjusted,FALSE);
                            IF TDSEntry.FIND('-') THEN
                              REPEAT
                                InsertTDSBuf(TDSEntry,PurchHeader."Posting Date",CalculateSurcharge,TRUE);
                              UNTIL TDSEntry.NEXT = 0;
                            IF TDSEntry.FIND('-') THEN BEGIN
                              TDSBaseLCY := TDSBaseLCY + CurrentPOAmount;
                              SurchargeBaseLCY := TDSBaseLCY;
                              InsertGenTDSBuf(TDSBaseLCY,TempTDSBase,SurchargeBaseLCY,TDSPercentage,SurchargePercentage,FALSE);
                            END ELSE BEGIN
                              TDSBaseLCY := "TDS Base Amount";
                              SurchargeBaseLCY := "Surcharge Base Amount";
                              InsertGenTDSBuf(TDSBaseLCY,TempTDSBase,SurchargeBaseLCY,TDSPercentage,SurchargePercentage,FALSE);
                            END;
                          END ELSE BEGIN // something to be added here..
                            "TDS Base Amount" := TDSBaseLCY;
                            "TDS %" := 0;
                            "eCESS % on TDS" := 0;
                            "SHE Cess % On TDS" := 0;
                            "Surcharge %" := 0;
                            "Surcharge Amount" := 0;
                            "TDS Amount" := 0;
                            "TDS Amount Including Surcharge" := 0;
                          END;
                    END;
                  END ELSE BEGIN
                    CalcAppliedAmtDocIncGST(AppliedAmountDoc,PurchHeader,PurchLine);
                    IF (AppliedAmountDoc = 0) AND (AppliedAmount = 0) THEN
                      CalcBlankTDSAppliedAmt(PurchLine,NODLines,AccountingPeriodFilter,
                        TDSBaseLCY,CurrentPOAmount,CurrentPOContractAmt)
                    ELSE BEGIN
                      IF PurchHeader."Applies-to Doc. No." <> '' THEN BEGIN
                        IF AppliedAmountDoc <> 0 THEN BEGIN
                          IF TDSBaseLCY + CurrentPOAmount >= AppliedAmountDoc THEN BEGIN
                            TDSGroup.FindOnDate("TDS Group",PurchHeader."Posting Date");
                            IF TDSGroup."Per Contract Value" <> 0 THEN BEGIN
                              IF PreviousTDSAmt = 0 THEN
                                "TDS Base Amount" := PreviousAmount + TDSBaseLCY - ABS(AppliedAmountDoc)
                              ELSE
                                IF CurrentPOTDSAmt = 0 THEN BEGIN
                                  IF PreviousContractAmount <> 0 THEN
                                    "TDS Base Amount" := TDSBaseLCY - ABS(AppliedAmountDoc) +
                                      (CurrentPOAmount - CurrentPOContractAmt)
                                  ELSE
                                    "TDS Base Amount" := TDSBaseLCY + (CurrentPOAmount - CurrentPOContractAmt) -
                                      ABS(AppliedAmountDoc);
                                END ELSE
                                  IF CurrentPOAmount >= ABS(AppliedAmountDoc) THEN BEGIN
                                    IF PreviousContractAmount <> 0 THEN
                                      "TDS Base Amount" := TDSBaseLCY + (PreviousAmount - PreviousContractAmount)
                                    ELSE
                                      "TDS Base Amount" := TDSBaseLCY;
                                  END ELSE BEGIN
                                    IF PreviousContractAmount <> 0 THEN
                                      "TDS Base Amount" := TDSBaseLCY - ABS(AppliedAmountDoc) +
                                        (PreviousAmount - PreviousContractAmount)
                                    ELSE
                                      "TDS Base Amount" := TDSBaseLCY - ABS(AppliedAmountDoc);
                                  END;
                              IF PreviousSurchargeAmt = 0 THEN
                                "Surcharge Base Amount" := PreviousAmount + TDSBaseLCY - ABS(AppliedAmountDoc)
                              ELSE BEGIN
                                IF PreviousContractAmount <> 0 THEN
                                  "Surcharge Base Amount" := TDSBaseLCY - ABS(AppliedAmountDoc) +
                                    (PreviousAmount - PreviousContractAmount)
                                ELSE
                                  "Surcharge Base Amount" := TDSBaseLCY
                                    - ABS(AppliedAmountDoc) + (PreviousAmount - PreviousContractAmount);
                              END;
                            END ELSE BEGIN // without contract value
                              IF PreviousTDSAmt = 0 THEN
                                CalcTDSBaseAmt(PreviousAmount,TDSBaseLCY,AppliedAmountDoc,CurrentPOAmount,"TDS Base Amount")
                              ELSE BEGIN
                                IF CurrentPOTDSAmt = 0 THEN
                                  "TDS Base Amount" := CurrentPOAmount + TDSBaseLCY - ABS(AppliedAmountDoc)
                                ELSE BEGIN
                                  IF CurrentPOAmount >= ABS(AppliedAmountDoc) THEN
                                    "TDS Base Amount" := TDSBaseLCY;
                                END;
                              END;
                              IF PreviousSurchargeAmt = 0 THEN
                                "Surcharge Base Amount" := PreviousAmount + TDSBaseLCY - ABS(AppliedAmountDoc)
                              ELSE
                                "Surcharge Base Amount" := TDSBaseLCY - ABS(AppliedAmountDoc);
                            END;
                            "Temp TDS Base" := TDSBaseLCY - ABS(AppliedAmountDoc);
                          END ELSE BEGIN
                            "TDS Base Amount" := 0;
                            "Surcharge Base Amount" := 0;
                            "Temp TDS Base" := 0;
                          END;
                        END ELSE BEGIN
                          "TDS Base Amount" := TDSBaseLCY;
                          "Surcharge Base Amount" := TDSBaseLCY;
                        END;
                      END;
                      IF PurchHeader."Applies-to ID" <> '' THEN BEGIN
                        IF AppliedAmount <> 0 THEN BEGIN
                          IF TDSBaseLCY + CurrentPOAmount >= AppliedAmount THEN BEGIN
                            TDSGroup.FindOnDate("TDS Group",PurchHeader."Posting Date");
                            IF TDSGroup."Per Contract Value" <> 0 THEN BEGIN
                              IF PreviousTDSAmt = 0 THEN
                                "TDS Base Amount" := PreviousAmount + TDSBaseLCY - ABS(AppliedAmount)
                              ELSE BEGIN
                                IF CurrentPOTDSAmt = 0 THEN BEGIN
                                  IF PreviousContractAmount <> 0 THEN
                                    "TDS Base Amount" := TDSBaseLCY - ABS(AppliedAmount) +
                                      (PreviousAmount - PreviousContractAmount) + (CurrentPOAmount - CurrentPOContractAmt)
                                  ELSE
                                    "TDS Base Amount" := TDSBaseLCY + (CurrentPOAmount - CurrentPOContractAmt) - ABS(AppliedAmount);
                                END ELSE BEGIN
                                  IF CurrentPOAmount >= ABS(AppliedAmount) THEN BEGIN
                                    IF PreviousContractAmount <> 0 THEN
                                      "TDS Base Amount" := TDSBaseLCY + (PreviousAmount - PreviousContractAmount)
                                    ELSE
                                      "TDS Base Amount" := TDSBaseLCY;
                                  END ELSE
                                    IF PreviousContractAmount <> 0 THEN
                                      "TDS Base Amount" := TDSBaseLCY - ABS(AppliedAmount) +
                                        (PreviousAmount - PreviousContractAmount)
                                    ELSE
                                      "TDS Base Amount" := TDSBaseLCY - ABS(AppliedAmount);
                                END;
                              END;
                              IF PreviousSurchargeAmt = 0 THEN
                                "Surcharge Base Amount" := PreviousAmount + TDSBaseLCY - ABS(AppliedAmount)
                              ELSE BEGIN
                                IF PreviousContractAmount <> 0 THEN
                                  "Surcharge Base Amount" := TDSBaseLCY - ABS(AppliedAmount) +
                                    (PreviousAmount - PreviousContractAmount)
                                ELSE
                                  "Surcharge Base Amount" := TDSBaseLCY
                                    - ABS(AppliedAmount) + (PreviousAmount - PreviousContractAmount);
                              END;
                            END ELSE BEGIN // without contract value
                              IF PreviousTDSAmt = 0 THEN
                                CalcTDSBaseAmt(PreviousAmount,TDSBaseLCY,AppliedAmount,CurrentPOAmount,"TDS Base Amount")
                              ELSE BEGIN
                                IF CurrentPOTDSAmt = 0 THEN
                                  "TDS Base Amount" := CurrentPOAmount + TDSBaseLCY - ABS(AppliedAmount)
                                ELSE BEGIN
                                  IF CurrentPOAmount >= ABS(AppliedAmount) THEN
                                    "TDS Base Amount" := TDSBaseLCY
                                  ELSE
                                    "TDS Base Amount" := TDSBaseLCY - ABS(AppliedAmount);
                                END;
                              END;
                              IF PreviousSurchargeAmt = 0 THEN
                                "Surcharge Base Amount" := PreviousAmount + TDSBaseLCY - ABS(AppliedAmount)
                              ELSE
                                "Surcharge Base Amount" := TDSBaseLCY - ABS(AppliedAmount);
                            END;
                            "Temp TDS Base" := TDSBaseLCY - ABS(AppliedAmount);
                          END ELSE BEGIN
                            "TDS Base Amount" := 0;
                            "Surcharge Base Amount" := 0;
                            "Temp TDS Base" := 0
                          END;
                        END ELSE BEGIN
                          "TDS Base Amount" := TDSBaseLCY;
                          "Surcharge Base Amount" := TDSBaseLCY;
                        END;
                      END;
                      IF NODLines."Threshold Overlook" THEN BEGIN
                        "TDS Base Amount" := "TDS Base Amount";
                        "TDS %" := TDSSetupPercentage;
                        "eCESS % on TDS" := TDSSetup."eCESS %";
                        "SHE Cess % On TDS" := TDSSetup."SHE Cess %";
                        IF NODLines."Surcharge Overlook" THEN BEGIN
                          "Surcharge Base Amount" := ABS("TDS Base Amount");
                          "Surcharge %" := TDSSetup."Surcharge %";
                        END ELSE BEGIN
                          TDSGroup.FindOnDate("TDS Group",PurchHeader."Posting Date");
                          IF PreviousAmount > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                            "Surcharge Base Amount" := ABS("TDS Base Amount");
                            "Surcharge %" := TDSSetup."Surcharge %";
                            PreviousSurchargeAmt := 0;
                          END ELSE BEGIN
                            IF ABS("Surcharge Base Amount") > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                              "Surcharge Base Amount" := ABS("Surcharge Base Amount");
                              "Surcharge %" := TDSSetup."Surcharge %";
                              TDSPercentage := "TDS %";
                              SurchargePercentage := "Surcharge %";
                              TempTDSBase := "Temp TDS Base";
                              InsertGenTDSBuf(TDSBaseLCY,TempTDSBase,SurchargeBaseLCY,TDSPercentage,SurchargePercentage,TRUE);
                              IF "Surcharge %" <> 0 THEN
                                CalculateSurcharge := TRUE;
                              TDSEntry.RESET;
                              TDSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TDS Group","Assessee Code",Applied);
                              TDSEntry.SETRANGE("Party Type",TDSEntry."Party Type"::Vendor);
                              TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.");
                              TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
                              TDSEntry.SETRANGE("TDS Group","TDS Group");
                              TDSEntry.SETRANGE("Assessee Code","Assessee Code");
                              TDSEntry.SETRANGE(Applied,FALSE);
                              TDSEntry.SETRANGE("TDS Adjustment",FALSE);
                              TDSEntry.SETRANGE(Adjusted,FALSE);
                              IF TDSEntry.FIND('-') THEN
                                REPEAT
                                  InsertTDSBuf(TDSEntry,PurchHeader."Posting Date",CalculateSurcharge,FALSE);
                                UNTIL TDSEntry.NEXT = 0;
                            END ELSE BEGIN
                              "Surcharge Base Amount" := ABS("Surcharge Base Amount");
                              "Surcharge %" := 0;
                              "Surcharge Amount" := 0;
                            END;
                          END;
                        END;
                      END ELSE BEGIN
                        TDSGroup.FindOnDate("TDS Group",PurchHeader."Posting Date");
                        IF PreviousAmount > TDSGroup."TDS Threshold Amount" THEN BEGIN
                          "TDS Base Amount" := "TDS Base Amount";
                          "TDS %" := TDSSetupPercentage;
                          "eCESS % on TDS" := TDSSetup."eCESS %";
                          "SHE Cess % On TDS" := TDSSetup."SHE Cess %";
                          IF NODLines."Surcharge Overlook" THEN BEGIN
                            "Surcharge Base Amount" := ABS("TDS Base Amount");
                            "Surcharge %" := TDSSetup."Surcharge %";
                          END ELSE BEGIN
                            IF PreviousAmount > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                              "Surcharge Base Amount" := ABS("TDS Base Amount");
                              "Surcharge %" := TDSSetup."Surcharge %";
                              PreviousSurchargeAmt := 0;
                            END ELSE BEGIN
                              IF ABS("Surcharge Base Amount") > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                "Surcharge Base Amount" := ABS("Surcharge Base Amount");
                                "Surcharge %" := TDSSetup."Surcharge %";
                                TDSPercentage := "TDS %";
                                SurchargePercentage := "Surcharge %";
                                TempTDSBase := "Temp TDS Base";
                                InsertGenTDSBuf(TDSBaseLCY,TempTDSBase,SurchargeBaseLCY,TDSPercentage,SurchargePercentage,TRUE);
                                IF "Surcharge %" <> 0 THEN
                                  CalculateSurcharge := TRUE;
                                TDSEntry.RESET;
                                TDSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TDS Group","Assessee Code",Applied);
                                TDSEntry.SETRANGE("Party Type",TDSEntry."Party Type"::Vendor);
                                TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.");
                                TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
                                TDSEntry.SETRANGE("TDS Group","TDS Group");
                                TDSEntry.SETRANGE("Assessee Code","Assessee Code");
                                TDSEntry.SETRANGE(Applied,FALSE);
                                TDSEntry.SETRANGE("TDS Adjustment",FALSE);
                                TDSEntry.SETRANGE(Adjusted,FALSE);
                                IF TDSEntry.FIND('-') THEN
                                  REPEAT
                                    InsertTDSBuf(TDSEntry,PurchHeader."Posting Date",CalculateSurcharge,FALSE);
                                  UNTIL TDSEntry.NEXT = 0;
                              END ELSE BEGIN
                                "Surcharge Base Amount" := ABS("Surcharge Base Amount");
                                "Surcharge %" := 0;
                                "Surcharge Amount" := 0;
                              END;
                            END;
                          END;
                        END ELSE BEGIN
                          IF TDSGroup."Per Contract Value" <> 0 THEN BEGIN
                            IF (ABS("TDS Base Amount") + PreviousContractAmount) > TDSGroup."TDS Threshold Amount" THEN BEGIN
                              "TDS %" := TDSSetupPercentage;
                              "eCESS % on TDS" := TDSSetup."eCESS %";
                              "SHE Cess % On TDS" := TDSSetup."SHE Cess %";
                              IF NODLines."Surcharge Overlook" THEN BEGIN
                                "Surcharge Base Amount" := ABS("TDS Base Amount");
                                "Surcharge %" := TDSSetup."Surcharge %";
                              END ELSE BEGIN
                                TDSGroup.FindOnDate("TDS Group",PurchHeader."Posting Date");
                                IF PreviousAmount > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                  "Surcharge Base Amount" := ABS("TDS Base Amount");
                                  "Surcharge %" := TDSSetup."Surcharge %";
                                  PreviousSurchargeAmt := 0;
                                END ELSE BEGIN
                                  IF ABS("Surcharge Base Amount") > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                    "Surcharge Base Amount" := ABS("Surcharge Base Amount");
                                    "Surcharge %" := TDSSetup."Surcharge %";
                                  END ELSE BEGIN
                                    "Surcharge Base Amount" := ABS("Surcharge Base Amount");
                                    "Surcharge %" := 0;
                                    "Surcharge Amount" := 0;
                                  END;
                                END;
                              END;
                              TDSPercentage := "TDS %";
                              SurchargePercentage := "Surcharge %";
                              TempTDSBase := "Temp TDS Base";
                              InsertGenTDSBuf(TDSBaseLCY,TempTDSBase,SurchargeBaseLCY,TDSPercentage,SurchargePercentage,TRUE);
                              IF "Surcharge %" <> 0 THEN
                                CalculateSurcharge := TRUE;
                              TDSEntry.RESET;
                              TDSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TDS Group","Assessee Code",Applied);
                              TDSEntry.SETRANGE("Party Type",TDSEntry."Party Type"::Vendor);
                              TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.");
                              TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
                              TDSEntry.SETRANGE("TDS Group","TDS Group");
                              TDSEntry.SETRANGE("Assessee Code","Assessee Code");
                              TDSEntry.SETRANGE(Applied,FALSE);
                              TDSEntry.SETRANGE("TDS Adjustment",FALSE);
                              TDSEntry.SETRANGE(Adjusted,FALSE);
                              IF TDSEntry.FIND('-') THEN
                                REPEAT
                                  InsertTDSBuf(TDSEntry,PurchHeader."Posting Date",CalculateSurcharge,TRUE);
                                UNTIL TDSEntry.NEXT = 0;
                            END ELSE BEGIN
                              IF ABS("TDS Base Amount") > TDSGroup."Per Contract Value" THEN BEGIN
                                "Per Contract" := TRUE;
                                "TDS %" := TDSSetupPercentage;
                                "eCESS % on TDS" := TDSSetup."eCESS %";
                                "SHE Cess % On TDS" := TDSSetup."SHE Cess %";
                                IF NODLines."Surcharge Overlook" THEN BEGIN
                                  "Surcharge Base Amount" := TDSBaseLCY;
                                  "Surcharge %" := TDSSetup."Surcharge %";
                                END ELSE BEGIN
                                  TDSGroup.FindOnDate("TDS Group",PurchHeader."Posting Date");
                                  IF TDSBaseLCY > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                    "Surcharge Base Amount" := TDSBaseLCY;
                                    "Surcharge %" := TDSSetup."Surcharge %";
                                  END ELSE
                                    "Surcharge %" := 0;
                                END;
                              END ELSE BEGIN
                                "TDS Base Amount" := ABS("TDS Base Amount");
                                "TDS %" := 0;
                                "eCESS % on TDS" := 0;
                                "SHE Cess % On TDS" := 0;
                                "TDS Amount" := 0;
                                "Surcharge %" := 0;
                                "Surcharge Amount" := 0;
                                "TDS Amount Including Surcharge" := 0;
                              END;
                            END;
                          END ELSE BEGIN
                            IF ABS("TDS Base Amount") > TDSGroup."TDS Threshold Amount" THEN BEGIN
                              "TDS %" := TDSSetupPercentage;
                              "eCESS % on TDS" := TDSSetup."eCESS %";
                              "SHE Cess % On TDS" := TDSSetup."SHE Cess %";
                              IF NODLines."Surcharge Overlook" THEN BEGIN
                                "Surcharge Base Amount" := ABS("TDS Base Amount");
                                "Surcharge %" := TDSSetup."Surcharge %";
                              END ELSE BEGIN
                                TDSGroup.FindOnDate("TDS Group",PurchHeader."Posting Date");
                                IF PreviousAmount > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                  "Surcharge Base Amount" := ABS("TDS Base Amount");
                                  "Surcharge %" := TDSSetup."Surcharge %";
                                  PreviousSurchargeAmt := 0;
                                END ELSE BEGIN
                                  IF ABS("Surcharge Base Amount") > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                    "Surcharge Base Amount" := ABS("Surcharge Base Amount");
                                    "Surcharge %" := TDSSetup."Surcharge %";
                                  END ELSE BEGIN
                                    "Surcharge Base Amount" := ABS("Surcharge Base Amount");
                                    "Surcharge %" := 0;
                                    "Surcharge Amount" := 0;
                                  END;
                                END;
                              END;
                              TDSPercentage := "TDS %";
                              SurchargePercentage := "Surcharge %";
                              TempTDSBase := "Temp TDS Base";
                              InsertGenTDSBuf(TDSBaseLCY,TempTDSBase,SurchargeBaseLCY,TDSPercentage,SurchargePercentage,TRUE);
                              IF "Surcharge %" <> 0 THEN
                                CalculateSurcharge := TRUE;
                              TDSEntry.RESET;
                              TDSEntry.SETCURRENTKEY(
                                "Party Type","Party Code","Posting Date","TDS Group","Assessee Code",Applied);
                              TDSEntry.SETRANGE("Party Type",TDSEntry."Party Type"::Vendor);
                              TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.");
                              TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
                              TDSEntry.SETRANGE("TDS Group","TDS Group");
                              TDSEntry.SETRANGE("Assessee Code","Assessee Code");
                              TDSEntry.SETRANGE(Applied,FALSE);
                              TDSEntry.SETRANGE("TDS Adjustment",FALSE);
                              TDSEntry.SETRANGE(Adjusted,FALSE);
                              IF TDSEntry.FIND('-') THEN
                                REPEAT
                                  InsertTDSBuf(TDSEntry,PurchHeader."Posting Date",CalculateSurcharge,TRUE);
                                UNTIL TDSEntry.NEXT = 0;
                            END ELSE BEGIN
                              "TDS Base Amount" := ABS("TDS Base Amount");
                              "Surcharge Base Amount" := ABS("Surcharge Base Amount");
                              "TDS %" := 0;
                              "eCESS % on TDS" := 0;
                              "SHE Cess % On TDS" := 0;
                              "TDS Amount" := 0;
                              "Surcharge %" := 0;
                              "Surcharge Amount" := 0;
                              "TDS Amount Including Surcharge" := 0;
                            END;
                          END;
                        END;
                      END;
                    END;
                  END;
                  IF TDSBaseLCY <> 0 THEN BEGIN
                    IF TDSBuf[1].FIND('+') THEN BEGIN
                      REPEAT
                        CalculatedTDSAmt :=
                          CalculatedTDSAmt + (TDSBuf[1]."TDS Base Amount" - TDSBuf[1]."Contract TDS Ded. Base Amount") *
                          TDSBuf[1]."TDS %" / 100;
                        SurchargeBase := SurchargeBase + (TDSBuf[1]."TDS %" *
                                                          (TDSBuf[1]."Surcharge Base Amount" -
                                                           TDSBuf[1]."Contract TDS Ded. Base Amount") / 100);
                        CalculatedSurchargeAmt := CalculatedSurchargeAmt + (TDSBuf[1]."TDS %" *
                                                                            (TDSBuf[1]."Surcharge Base Amount" -
                                                                             TDSBuf[1]."Contract TDS Ded. Base Amount") / 100)
                          * (TDSBuf[1]."Surcharge %" / 100);
                      UNTIL TDSBuf[1].NEXT(-1) = 0;
                      IF TDSBaseLCY < 0 THEN BEGIN
                        "TDS Amount" := -ROUND(CalculatedTDSAmt,Currency."Amount Rounding Precision");
                        "Surcharge Amount" := -ROUND(CalculatedSurchargeAmt,Currency."Amount Rounding Precision");
                      END ELSE BEGIN
                        "TDS Amount" := ROUND(CalculatedTDSAmt,Currency."Amount Rounding Precision");
                        "Surcharge Amount" := ROUND(CalculatedSurchargeAmt,Currency."Amount Rounding Precision");
                      END;
                      IF "TDS Base Amount" <> 0 THEN
                        "TDS %" := ABS(ROUND(CalculatedTDSAmt * 100 / "TDS Base Amount",Currency."Amount Rounding Precision"));
                      IF SurchargeBase <> 0 THEN
                        "Surcharge %" := ABS(ROUND(CalculatedSurchargeAmt * 100 / SurchargeBase,Currency."Amount Rounding Precision"))
                          ;
                    END ELSE BEGIN
                      "TDS Amount" := ROUND("TDS %" * "TDS Base Amount" / 100,Currency."Amount Rounding Precision");
                      "Surcharge Amount" := ("TDS %" * "Surcharge Base Amount" / 100) * ("Surcharge %" / 100);
                    END;
                    "TDS Amount Including Surcharge" := ("TDS Amount" + "Surcharge Amount");
                    "eCESS on TDS Amount" := ROUND("TDS Amount Including Surcharge" * "eCESS % on TDS" / 100,
                        Currency."Amount Rounding Precision") ;
                    "SHE Cess on TDS Amount" := ROUND("TDS Amount Including Surcharge" * "SHE Cess % On TDS" / 100,
                        Currency."Amount Rounding Precision") ;
                    "Total TDS Including SHE CESS" := "TDS Amount" + "Surcharge Amount" + "eCESS on TDS Amount" +
                      "SHE Cess on TDS Amount";
                    "Bal. TDS Including SHE CESS" := "Total TDS Including SHE CESS";
                    IF "Currency Code" <> '' THEN BEGIN
                      ExchangeTDSAmtLCYToFCY(PurchLine,PurchHeader,"Currency Factor");
                      "Bal. TDS Including SHE CESS" := "Total TDS Including SHE CESS";
                    END;
                  END;
                END;

              TDSSetup.RESET;
              TDSSetup.SETRANGE("TDS Nature of Deduction","Work Tax Nature Of Deduction");
              TDSSetup.SETRANGE("Assessee Code","Assessee Code");
              TDSSetup.SETRANGE("TDS Group","Work Tax Group");
              TDSSetup.SETRANGE("Effective Date",0D,PurchHeader."Posting Date");
              IF "Work Tax Nature Of Deduction" <> '' THEN BEGIN
                NODLines.RESET;
                NODLines.SETRANGE(Type,NODLines.Type::Vendor);
                NODLines.SETRANGE("No.","Pay-to Vendor No.");
                NODLines.SETRANGE("NOD/NOC","Work Tax Nature Of Deduction");
                IF NODLines.FIND('-') THEN BEGIN
                  IF NODLines."Concessional Code" <> '' THEN
                    TDSSetup.SETRANGE("Concessional Code",NODLines."Concessional Code")
                  ELSE
                    TDSSetup.SETRANGE("Concessional Code",'');
                  IF NOT TDSSetup.FINDLAST THEN BEGIN
                    "Work Tax %" := 0;
                    "Work Tax Base Amount" := 0;
                    "Work Tax Amount" := 0;
                  END ELSE BEGIN
                    "Work Tax %" := TDSSetup."TDS %";
                    "Work Tax Base Amount" := "Line Amount" - "Inv. Discount Amount";

                    IF StrOrdLineDet.FindLinesInclInTDSBase(PurchLine) THEN
                      REPEAT
                        IF ReverseChargePct > 0 THEN
                          StrOrdLineDet.Amount := ROUND(StrOrdLineDet.Amount * (100 - ReverseChargePct) / 100);
                        "Work Tax Base Amount" := "Work Tax Base Amount" + StrOrdLineDet.Amount;
                      UNTIL StrOrdLineDet.NEXT = 0;
                    IF RemainingAmount > 0 THEN
                      IF RemainingAmount >= "Work Tax Base Amount" THEN BEGIN
                        RemainingAmount := RemainingAmount - "Work Tax Base Amount";
                        "Work Tax Base Amount" := 0;
                      END ELSE BEGIN
                        "Work Tax Base Amount" := "Work Tax Base Amount" - RemainingAmount;
                        RemainingAmount := 0;
                      END;
                    "Work Tax Base Amount" := ROUND("Work Tax Base Amount",Currency."Amount Rounding Precision");
                  END;
                  "Work Tax Amount" := RoundTDSAmount("Work Tax Base Amount" * "Work Tax %" / 100);
                END;
              END;
            END;
            PurchLine.MODIFY;
          UNTIL PurchLine.NEXT = 0;
        END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..70

              TDSEntry.RESET;
              TDSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TDS Group","Assessee Code",Applied);
              TDSEntry.SETRANGE("Party Type",TDSEntry."Party Type"::Vendor);
              TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.");
              TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
              TDSEntry.SETRANGE("TDS Group","TDS Group");
              TDSEntry.SETRANGE("Assessee Code","Assessee Code");
              TDSEntry.SETRANGE(Applied,FALSE);
              IF TDSEntry.FIND('-') THEN BEGIN
                TDSEntry.CALCSUMS("Invoice Amount","Service Tax Including eCess");
                PreviousAmount := ABS(TDSEntry."Invoice Amount") + ABS(TDSEntry."Service Tax Including eCess");
              END;
              FilterTDSEntry1(TDSEntry,PurchLine,AccountingPeriodFilter);
              TDSEntry.CALCSUMS("Invoice Amount","Service Tax Including eCess");
              PreviousBaseAMTWithTDS := ABS(TDSEntry."Invoice Amount") + ABS(TDSEntry."Service Tax Including eCess");

              TDSEntry.RESET;
              TDSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TDS Group","Assessee Code","Document Type");
              TDSEntry.SETRANGE("Party Type",TDSEntry."Party Type"::Vendor);
              TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.");
              TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
              TDSEntry.SETRANGE("TDS Group","TDS Group");
              TDSEntry.SETRANGE("Assessee Code","Assessee Code");
              TDSEntry.SETRANGE("Document Type",TDSEntry."Document Type"::Invoice);
              IF TDSEntry.FIND('-') THEN BEGIN
                TDSEntry.CALCSUMS("Invoice Amount","Service Tax Including eCess");
                InvoiceAmount := ABS(TDSEntry."Invoice Amount") + ABS(TDSEntry."Service Tax Including eCess");
              END;
              TDSEntry.RESET;
              TDSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TDS Group","Assessee Code","Document Type");
              TDSEntry.SETRANGE("Party Type",TDSEntry."Party Type"::Vendor);
              TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.");
              TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
              TDSEntry.SETRANGE("TDS Group","TDS Group");
              TDSEntry.SETRANGE("Assessee Code","Assessee Code");
              TDSEntry.SETRANGE("Document Type",TDSEntry."Document Type"::Payment);
              IF TDSEntry.FIND('-') THEN BEGIN
                TDSEntry.CALCSUMS("Invoice Amount","Service Tax Including eCess");
                PaymentAmount := ABS(TDSEntry."Invoice Amount") + ABS(TDSEntry."Service Tax Including eCess");
              END;
              IF InvoiceAmount > PaymentAmount THEN
                PreviousAmount := InvoiceAmount
              ELSE
                PreviousAmount := PaymentAmount;
              UpdateTDSAdjustmentEntry(PurchLine,PreviousAmount1,InvoiceAmt1,PaymentAmt1,PreviousTDSAmt1,AccountingPeriodFilter);
              TDSEntry.RESET;
              TDSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TDS Group","Assessee Code");
              TDSEntry.SETRANGE("Party Type",TDSEntry."Party Type"::Vendor);
              TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.");
              TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
              TDSEntry.SETRANGE("TDS Group","TDS Group");
              TDSEntry.SETRANGE("Assessee Code","Assessee Code");
              IF TDSEntry.FIND('-') THEN BEGIN
                TDSEntry.CALCSUMS("TDS Amount","Surcharge Amount");
                PreviousTDSAmt := ABS(TDSEntry."TDS Amount");
                PreviousSurchargeAmt := ABS(TDSEntry."Surcharge Amount");
              END;
              TDSEntry.RESET;
              TDSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TDS Group","Assessee Code",Applied);
              TDSEntry.SETRANGE("Party Type",TDSEntry."Party Type"::Vendor);
              TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.");
              TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
              TDSEntry.SETRANGE("TDS Group","TDS Group");
              TDSEntry.SETRANGE("Assessee Code","Assessee Code");
              TDSEntry.SETRANGE(Applied,FALSE);
              TDSEntry.SETRANGE("Per Contract",TRUE);
              IF TDSEntry.FIND('-') THEN BEGIN
                TDSEntry.CALCSUMS("Invoice Amount","Service Tax Including eCess");
                PreviousContractAmount := ABS(TDSEntry."Invoice Amount") + ABS(TDSEntry."Service Tax Including eCess");
              END;
              //MSSS
                TDSBaseAmt:=0;
                RecPurchaseLn.RESET;
                RecPurchaseLn.SETRANGE(RecPurchaseLn."Document Type","Document Type");
                RecPurchaseLn.SETRANGE(RecPurchaseLn."Document No.","Document No.");
                IF RecPurchaseLn.FIND('-')THEN BEGIN
                REPEAT
                   TDSBaseAmt+=RecPurchaseLn."TDS Base Amount";
                UNTIL RecPurchaseLn.NEXT=0;
                END;
                //MSSS

              //Upgrade(-)
    #73..134

                  IF (PurchHeader."Applies-to Doc. No." = '') AND (PurchHeader."Applies-to ID" = '') THEN BEGIN
                    IF NODLines."Threshold Overlook" THEN BEGIN
                     //Upgrade(+)
                     IF (((InvoiceAmount+TDSBaseAmt) <= NODLines."TDS Credit Limit Amount")AND(NODLines."TDS Credit Limit Amount"<>0))
                     THEN BEGIN
                       //"TDS %" := NODLines."TDS Credit Limit %";
                        TDSSetupPercentage := NODLines."TDS Credit Limit %";
                        TDSCeilingAppliedPercentage := NODLines."TDS Credit Limit %";
                        TDSCeilingApplied := TRUE;
                        END ELSE BEGIN
                       "TDS %" := TDSSetupPercentage;
                       END;
                       //MESSAGE('%1--%2-%3',TDSCeilingApplied,TDSSetupPercentage,'hi');
                       "TDS %" := TDSSetupPercentage;
                      //Upgrade(-)
                      "TDS Base Amount" := TDSBaseLCY;
    #139..175
                      // >>ALLE.TDS-REGEF START
                      IF TDSSetup."Calc. Over & Above Threshold" THEN
                        OverAndAboveThresholdAmount := TDSGroup."TDS Threshold Amount";
                      // <<ALLE.TDS-REGEF STOP
    #176..216
                                CurrentPOContractAmt - OverAndAboveThresholdAmount
                            ELSE
                              "TDS Base Amount" := (PreviousAmount1 + TDSBaseLCY) - PreviousBaseAMTWithTDS + CurrentPOAmount - OverAndAboveThresholdAmount;
    #220..286
                              "TDS Base Amount" := PreviousAmount1 + TDSBaseLCY + CurrentPOAmount - PreviousBaseAMTWithTDS - OverAndAboveThresholdAmount
                            ELSE
                              "TDS Base Amount" := TDSBaseLCY - TDSGroup."TDS Threshold Amount" - OverAndAboveThresholdAmount;
                            IF PreviousTDSAmt1 <> 0 THEN
                              "TDS Base Amount" := PreviousAmount1 + TDSBaseLCY + CurrentPOAmount - OverAndAboveThresholdAmount;
    #292..329
                            // >>ALLE.TDS-REGEF START
                            TDSEntry.SETRANGE("Calc. Over & Above Threshold",FALSE);
                            // <<ALLE.TDS-REGEF STOP
    #330..354
                    IF PurchHeader."Applies-to Doc. No." <> '' THEN BEGIN
                      IF GSTManagement.IsGSTApplicable(PurchHeader.Structure) THEN BEGIN
                        AppliedAmountDoc := 0;
                        CheckTDSValidation(PurchHeader);
                        AppliedAmountDoc := GetAppliedDocAmount(PurchHeader,PurchLine);
                        IF PurchHeader."Currency Code" <> '' THEN
                          AppliedAmountDoc := ROUND(
                              CurrExchRate.ExchangeAmtFCYToLCY(PurchHeader."Posting Date","Currency Code",
                                AppliedAmountDoc,PurchHeader."Currency Factor"));
                      END;
                      IF AppliedAmountDoc <> 0 THEN BEGIN
                        IF TDSBaseLCY + CurrentPOAmount >= AppliedAmountDoc THEN BEGIN
                          TDSGroup.FindOnDate("TDS Group",PurchHeader."Posting Date");
                          IF TDSGroup."Per Contract Value" <> 0 THEN BEGIN
                            IF PreviousTDSAmt = 0 THEN
                              "TDS Base Amount" := PreviousAmount + TDSBaseLCY - ABS(AppliedAmountDoc)
                            ELSE
                              IF CurrentPOTDSAmt = 0 THEN BEGIN
                                IF PreviousContractAmount <> 0 THEN
                                  "TDS Base Amount" := TDSBaseLCY - ABS(AppliedAmountDoc) +
                                      (CurrentPOAmount - CurrentPOContractAmt)
                                ELSE
                                    "TDS Base Amount" := TDSBaseLCY + (CurrentPOAmount - CurrentPOContractAmt) -
                                      ABS(AppliedAmountDoc);
                              END ELSE
                                IF CurrentPOAmount >= ABS(AppliedAmountDoc) THEN BEGIN
                                  IF PreviousContractAmount <> 0 THEN
                                    "TDS Base Amount" := TDSBaseLCY + (PreviousAmount - PreviousContractAmount)
                                  ELSE
                                    "TDS Base Amount" := TDSBaseLCY;
                                END ELSE BEGIN
                                  IF PreviousContractAmount <> 0 THEN
                                    "TDS Base Amount" := TDSBaseLCY - ABS(AppliedAmountDoc) +
                                      (PreviousAmount - PreviousContractAmount)
                                  ELSE
                                    "TDS Base Amount" := TDSBaseLCY - ABS(AppliedAmountDoc);
                                END;
                            IF PreviousSurchargeAmt = 0 THEN
                              "Surcharge Base Amount" := PreviousAmount + TDSBaseLCY - ABS(AppliedAmountDoc)
                            ELSE BEGIN
                              IF PreviousContractAmount <> 0 THEN
                                "Surcharge Base Amount" := TDSBaseLCY - ABS(AppliedAmountDoc) +
                                  (PreviousAmount - PreviousContractAmount)
                              ELSE
                                "Surcharge Base Amount" := TDSBaseLCY
                                  - ABS(AppliedAmountDoc) + (PreviousAmount - PreviousContractAmount);
                            END;
                          END ELSE BEGIN // without contract value
                            IF PreviousTDSAmt = 0 THEN
                              CalcTDSBaseAmt(PreviousAmount,TDSBaseLCY,AppliedAmountDoc,CurrentPOAmount,"TDS Base Amount")
                            ELSE BEGIN
                              IF CurrentPOTDSAmt = 0 THEN
                                "TDS Base Amount" := CurrentPOAmount + TDSBaseLCY - ABS(AppliedAmountDoc)
                              ELSE BEGIN
                                IF CurrentPOAmount >= ABS(AppliedAmountDoc) THEN
                                  "TDS Base Amount" := TDSBaseLCY;
                              END;
                            END;
                            IF PreviousSurchargeAmt = 0 THEN
                              "Surcharge Base Amount" := PreviousAmount + TDSBaseLCY - ABS(AppliedAmountDoc)
                            ELSE
                              "Surcharge Base Amount" := TDSBaseLCY - ABS(AppliedAmountDoc);
                          END;
                          "Temp TDS Base" := TDSBaseLCY - ABS(AppliedAmountDoc);
                        END ELSE BEGIN
                          "TDS Base Amount" := 0;
                          "Surcharge Base Amount" := 0;
                          "Temp TDS Base" := 0;
                        END;
                      END ELSE BEGIN
                        "TDS Base Amount" := TDSBaseLCY;
                        "Surcharge Base Amount" := TDSBaseLCY;
                      END;
                    END;
                    IF PurchHeader."Applies-to ID" <> '' THEN BEGIN
                      IF AppliedAmount <> 0 THEN BEGIN
                        IF TDSBaseLCY + CurrentPOAmount >= AppliedAmount THEN BEGIN
                          TDSGroup.FindOnDate("TDS Group",PurchHeader."Posting Date");
                          IF TDSGroup."Per Contract Value" <> 0 THEN BEGIN
                            IF PreviousTDSAmt = 0 THEN
                              "TDS Base Amount" := PreviousAmount + TDSBaseLCY - ABS(AppliedAmount)
                            ELSE BEGIN
                              IF CurrentPOTDSAmt = 0 THEN BEGIN
                                IF PreviousContractAmount <> 0 THEN
                                  "TDS Base Amount" := TDSBaseLCY - ABS(AppliedAmount) +
                                    (PreviousAmount - PreviousContractAmount) + (CurrentPOAmount - CurrentPOContractAmt)
                                ELSE
                                  "TDS Base Amount" := TDSBaseLCY + (CurrentPOAmount - CurrentPOContractAmt) - ABS(AppliedAmount);
                              END ELSE BEGIN
                                IF CurrentPOAmount >= ABS(AppliedAmount) THEN BEGIN
                                  IF PreviousContractAmount <> 0 THEN
                                    "TDS Base Amount" := TDSBaseLCY + (PreviousAmount - PreviousContractAmount)
                                  ELSE
                                    "TDS Base Amount" := TDSBaseLCY;
                                END ELSE BEGIN
                                  IF PreviousContractAmount <> 0 THEN
                                      "TDS Base Amount" := TDSBaseLCY - ABS(AppliedAmount) +
                                        (PreviousAmount - PreviousContractAmount)
    #472..475
                            END;
                            IF PreviousSurchargeAmt = 0 THEN
                              "Surcharge Base Amount" := PreviousAmount + TDSBaseLCY - ABS(AppliedAmount)
                            ELSE BEGIN
                              IF PreviousContractAmount <> 0 THEN
                                "Surcharge Base Amount" := TDSBaseLCY - ABS(AppliedAmount) +
                                  (PreviousAmount - PreviousContractAmount)
                              ELSE
                                "Surcharge Base Amount" := TDSBaseLCY
                                  - ABS(AppliedAmount) + (PreviousAmount - PreviousContractAmount);
                            END;
                          END ELSE BEGIN // without contract value
                            IF PreviousTDSAmt = 0 THEN
                              CalcTDSBaseAmt(PreviousAmount,TDSBaseLCY,AppliedAmount,CurrentPOAmount,"TDS Base Amount")
                            ELSE BEGIN
                              IF CurrentPOTDSAmt = 0 THEN
                                "TDS Base Amount" := CurrentPOAmount + TDSBaseLCY - ABS(AppliedAmount)
                              ELSE BEGIN
                                IF CurrentPOAmount >= ABS(AppliedAmount) THEN
                                  "TDS Base Amount" := TDSBaseLCY
                                ELSE
                                  "TDS Base Amount" := TDSBaseLCY - ABS(AppliedAmount);
                              END;
                            END;
                            IF PreviousSurchargeAmt = 0 THEN
                              "Surcharge Base Amount" := PreviousAmount + TDSBaseLCY - ABS(AppliedAmount)
                            ELSE
                              "Surcharge Base Amount" := TDSBaseLCY - ABS(AppliedAmount);
                          END;
                          "Temp TDS Base" := TDSBaseLCY - ABS(AppliedAmount);
                        END ELSE BEGIN
                          "TDS Base Amount" := 0;
                          "Surcharge Base Amount" := 0;
                          "Temp TDS Base" := 0
                        END;
                      END ELSE BEGIN
                        "TDS Base Amount" := TDSBaseLCY;
                        "Surcharge Base Amount" := TDSBaseLCY;
                      END;
                    END;
                    IF NODLines."Threshold Overlook" THEN BEGIN
                      "TDS Base Amount" := "TDS Base Amount";
    #138..141
                        "Surcharge Base Amount" := ABS("TDS Base Amount");
                        "Surcharge %" := TDSSetup."Surcharge %";
                      END ELSE BEGIN
                        TDSGroup.FindOnDate("TDS Group",PurchHeader."Posting Date");
                        IF PreviousAmount > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                          "Surcharge Base Amount" := ABS("TDS Base Amount");
                          "Surcharge %" := TDSSetup."Surcharge %";
                          PreviousSurchargeAmt := 0;
                        END ELSE BEGIN
                          IF ABS("Surcharge Base Amount") > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                            "Surcharge Base Amount" := ABS("Surcharge Base Amount");
                            "Surcharge %" := TDSSetup."Surcharge %";
                            TDSPercentage := "TDS %";
                            SurchargePercentage := "Surcharge %";
                            TempTDSBase := "Temp TDS Base";
                            InsertGenTDSBuf(TDSBaseLCY,TempTDSBase,SurchargeBaseLCY,TDSPercentage,SurchargePercentage,TRUE);
                            IF "Surcharge %" <> 0 THEN
                              CalculateSurcharge := TRUE;
                            TDSEntry.RESET;
                            TDSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TDS Group","Assessee Code",Applied);
                            TDSEntry.SETRANGE("Party Type",TDSEntry."Party Type"::Vendor);
                            TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.");
                            TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
                            TDSEntry.SETRANGE("TDS Group","TDS Group");
                            TDSEntry.SETRANGE("Assessee Code","Assessee Code");
                            TDSEntry.SETRANGE(Applied,FALSE);
                            TDSEntry.SETRANGE("TDS Adjustment",FALSE);
                            TDSEntry.SETRANGE(Adjusted,FALSE);
                            IF TDSEntry.FIND('-') THEN
                              REPEAT
                                InsertTDSBuf(TDSEntry,PurchHeader."Posting Date",CalculateSurcharge,FALSE);
                              UNTIL TDSEntry.NEXT = 0;
                          END ELSE BEGIN
                            "Surcharge Base Amount" := ABS("Surcharge Base Amount");
                            "Surcharge %" := 0;
                            "Surcharge Amount" := 0;
    #714..716
                    END ELSE BEGIN
                      TDSGroup.FindOnDate("TDS Group",PurchHeader."Posting Date");
                        // >>ALLE.TDS-REGEF START
                        IF TDSSetup."Calc. Over & Above Threshold" THEN
                          OverAndAboveThresholdAmount := TDSGroup."TDS Threshold Amount";
                        // <<ALLE.TDS-REGEF STOP
                      IF PreviousAmount > TDSGroup."TDS Threshold Amount" THEN BEGIN
                          IF "TDS Base Amount" > TDSGroup."TDS Threshold Amount" THEN
                            "TDS Base Amount" := "TDS Base Amount" - OverAndAboveThresholdAmount;
    #494..500
    #502..537
                        IF TDSGroup."Per Contract Value" <> 0 THEN BEGIN
                          IF (ABS("TDS Base Amount") + PreviousContractAmount) > TDSGroup."TDS Threshold Amount" THEN BEGIN
                            "TDS %" := TDSSetupPercentage;
                            "eCESS % on TDS" := TDSSetup."eCESS %";
                            "SHE Cess % On TDS" := TDSSetup."SHE Cess %";
                            IF NODLines."Surcharge Overlook" THEN BEGIN
                              "Surcharge Base Amount" := ABS("TDS Base Amount");
                              "Surcharge %" := TDSSetup."Surcharge %";
                            END ELSE BEGIN
                              TDSGroup.FindOnDate("TDS Group",PurchHeader."Posting Date");
                              IF PreviousAmount > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                "Surcharge Base Amount" := ABS("TDS Base Amount");
                                "Surcharge %" := TDSSetup."Surcharge %";
                                PreviousSurchargeAmt := 0;
                              END ELSE BEGIN
                                IF ABS("Surcharge Base Amount") > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                  "Surcharge Base Amount" := ABS("Surcharge Base Amount");
                                  "Surcharge %" := TDSSetup."Surcharge %";
                                END ELSE BEGIN
                                  "Surcharge Base Amount" := ABS("Surcharge Base Amount");
                                  "Surcharge %" := 0;
                                  "Surcharge Amount" := 0;
                                END;
                              END;
                            END;
                            TDSPercentage := "TDS %";
                            SurchargePercentage := "Surcharge %";
                            TempTDSBase := "Temp TDS Base";
                            InsertGenTDSBuf(TDSBaseLCY,TempTDSBase,SurchargeBaseLCY,TDSPercentage,SurchargePercentage,TRUE);
                            IF "Surcharge %" <> 0 THEN
                              CalculateSurcharge := TRUE;
                            TDSEntry.RESET;
                            TDSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TDS Group","Assessee Code",Applied);
                            TDSEntry.SETRANGE("Party Type",TDSEntry."Party Type"::Vendor);
                            TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.");
                            TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
                            TDSEntry.SETRANGE("TDS Group","TDS Group");
                            TDSEntry.SETRANGE("Assessee Code","Assessee Code");
                            TDSEntry.SETRANGE(Applied,FALSE);
                            TDSEntry.SETRANGE("TDS Adjustment",FALSE);
                            TDSEntry.SETRANGE(Adjusted,FALSE);
                            IF TDSEntry.FIND('-') THEN
                              REPEAT
                                InsertTDSBuf(TDSEntry,PurchHeader."Posting Date",CalculateSurcharge,TRUE);
                              UNTIL TDSEntry.NEXT = 0;
                          END ELSE BEGIN
                            IF ABS("TDS Base Amount") > TDSGroup."Per Contract Value" THEN BEGIN
                              "Per Contract" := TRUE;
    #586..589
                                "Surcharge Base Amount" := TDSBaseLCY;
    #591..593
                                IF TDSBaseLCY > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                  "Surcharge Base Amount" := TDSBaseLCY;
                                  "Surcharge %" := TDSSetup."Surcharge %";
                                END ELSE
                                  "Surcharge %" := 0;
                              END;
                            END ELSE BEGIN
                              "TDS Base Amount" := ABS("TDS Base Amount");
    #706..714
                        END ELSE BEGIN
                          IF ABS("TDS Base Amount") > TDSGroup."TDS Threshold Amount" THEN BEGIN
                            "TDS %" := TDSSetupPercentage;
                            "eCESS % on TDS" := TDSSetup."eCESS %";
                            "SHE Cess % On TDS" := TDSSetup."SHE Cess %";
                            IF NODLines."Surcharge Overlook" THEN BEGIN
                              "Surcharge Base Amount" := ABS("TDS Base Amount");
                              "Surcharge %" := TDSSetup."Surcharge %";
                            END ELSE BEGIN
                              TDSGroup.FindOnDate("TDS Group",PurchHeader."Posting Date");
                              IF PreviousAmount > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                "Surcharge Base Amount" := ABS("TDS Base Amount");
                                "Surcharge %" := TDSSetup."Surcharge %";
                                PreviousSurchargeAmt := 0;
                              END ELSE BEGIN
                                IF ABS("Surcharge Base Amount") > TDSGroup."Surcharge Threshold Amount" THEN BEGIN
                                  "Surcharge Base Amount" := ABS("Surcharge Base Amount");
                                  "Surcharge %" := TDSSetup."Surcharge %";
                                END ELSE BEGIN
                                  "Surcharge Base Amount" := ABS("Surcharge Base Amount");
                                  "Surcharge %" := 0;
                                  "Surcharge Amount" := 0;
                                END;
                              END;
                            END;
                            TDSPercentage := "TDS %";
                            SurchargePercentage := "Surcharge %";
                            TempTDSBase := "Temp TDS Base";
                            InsertGenTDSBuf(TDSBaseLCY,TempTDSBase,SurchargeBaseLCY,TDSPercentage,SurchargePercentage,TRUE);
                            IF "Surcharge %" <> 0 THEN
                              CalculateSurcharge := TRUE;
                            TDSEntry.RESET;
                            TDSEntry.SETCURRENTKEY(
                              "Party Type","Party Code","Posting Date","TDS Group","Assessee Code",Applied);
                            TDSEntry.SETRANGE("Party Type",TDSEntry."Party Type"::Vendor);
                            TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.");
                            TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
                            TDSEntry.SETRANGE("TDS Group","TDS Group");
                            TDSEntry.SETRANGE("Assessee Code","Assessee Code");
                            TDSEntry.SETRANGE(Applied,FALSE);
                            TDSEntry.SETRANGE("TDS Adjustment",FALSE);
                            TDSEntry.SETRANGE(Adjusted,FALSE);
                            IF TDSEntry.FIND('-') THEN
                              REPEAT
                                InsertTDSBuf(TDSEntry,PurchHeader."Posting Date",CalculateSurcharge,TRUE);
                              UNTIL TDSEntry.NEXT = 0;
                          END ELSE BEGIN
                            "TDS Base Amount" := ABS("TDS Base Amount");
                            "Surcharge Base Amount" := ABS("Surcharge Base Amount");
                            "TDS %" := 0;
                            "eCESS % on TDS" := 0;
                            "SHE Cess % On TDS" := 0;
                            "TDS Amount" := 0;
                            "Surcharge %" := 0;
                            "Surcharge Amount" := 0;
                            "TDS Amount Including Surcharge" := 0;
                          END;
                        END;
                      END;
    #717..809
    */
    //end;


    //Unsupported feature: Code Modification on "InsertTDSBuf(PROCEDURE 1280010)".// Function N/F

    //procedure InsertTDSBuf();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH TDSEntry DO BEGIN
      TDSBuf[1]."TDS Nature of Deduction" := "TDS Nature of Deduction";
      TDSBuf[1]."Assessee Code" := "Assessee Code";
    #4..36
        IF "Party Type" = "Party Type"::Vendor THEN BEGIN
          Vendor.GET("Party Code");
          IF (Vendor."P.A.N. Status" = Vendor."P.A.N. Status"::" ") AND (Vendor."P.A.N. No." <> '') THEN
            TDSBuf[1]."TDS %" := TDSSetup."TDS %"
          ELSE
            TDSBuf[1]."TDS %" := TDSSetup."Non PAN TDS %";
        END ELSE
          TDSBuf[1]."TDS %" := TDSSetup."TDS %";
        IF CalculateSurcharge THEN
          TDSBuf[1]."Surcharge %" := TDSSetup."Surcharge %";
      END;
      UpdTDSBuffer;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..39
            IF (NODLines."TDS Credit Limit Amount"<>0) AND TDSCeilingApplied THEN //MSKSTDS
                TDSBuf[1]."TDS %" := NODLines."TDS Credit Limit %" //MSKSTDS
              ELSE //MSKSTDS
                TDSBuf[1]."TDS %" := TDSSetup."TDS %"
    #41..46
        MESSAGE('%1',TDSCeilingAppliedPercentage);
        IF TDSCeilingApplied THEN
          TDSBuf[1]."TDS %" := TDSCeilingAppliedPercentage;
    #47..49
    */
    //end;


    //Unsupported feature: Code Modification on "ValidateQuantity(PROCEDURE 1280012)".// FUNCTION N/F

    //procedure ValidateQuantity();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Status = Status::Closed THEN
      ERROR(Text16362);
    IF ("Qty. to Receive" + "Qty. to Reject (Rework)" + "Qty. to Reject (V.E.)" + "Qty. to Reject (C.E.)") >
       (Quantity - ("Quantity Received" + "Qty. Rejected (C.E.)" + "Qty. Rejected (V.E.)"))
    THEN
      ERROR(Text16363);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //IF Status = Status::Closed THEN
    IF Status = Status::Released THEN //Upgrade(+-)
        ERROR(Text16362);
    #3..6
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateSubConOrderLines(PROCEDURE 1280016)".// function N/F

    //procedure UpdateSubConOrderLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Status = Status::Closed THEN
      ERROR(Text16362);
    SubOrderComponents.RESET;
    SubOrderComponents.SETFILTER("Document No.","Document No.");
    #5..36
      END;
      SubOrderCompListVend.MODIFY;
    UNTIL SubOrderCompListVend.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //IF Status = Status::Closed THEN
    IF Status = Status::Released THEN //Upgrade(+-)
    #2..39
    */
    //end;


    //Unsupported feature: Code Modification on "ShowSubOrderDetailsForm(PROCEDURE 1500008)".// Function N/F

    //procedure ShowSubOrderDetailsForm();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchaseLine.RESET;
    PurchaseLine.SETRANGE("Document Type","Document Type");
    PurchaseLine.SETRANGE("Document No.","Document No.");
    PurchaseLine.SETRANGE("No.","No.");
    PurchaseLine.SETRANGE("Line No.","Line No.");
    PAGE.RUNMODAL(PAGE::"Ord. Subcon Details Delv. List",PurchaseLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    //PAGE.RUNMODAL(PAGE::"Ord. Subcon Details Delv. List",PurchaseLine);
    //Upgrade(+)

    IF NOT ISSERVICETIER THEN
      PAGE.RUNMODAL(PAGE::"Order Subcon. Details Delivery",PurchaseLine)
    ELSE
      PAGE.RUNMODAL(PAGE::"Ord. Subcon Details Delv. List",PurchaseLine);
    //Upgrade(-)
    */
    //end;


    //Unsupported feature: Code Modification on "ShowSubOrderRcptForm(PROCEDURE 1500010)".// FUNCTION N/F

    //procedure ShowSubOrderRcptForm();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchaseLine.RESET;
    PurchaseLine.SETRANGE("Document Type","Document Type");
    PurchaseLine.SETRANGE("Document No.","Document No.");
    PurchaseLine.SETRANGE("No.","No.");
    PurchaseLine.SETRANGE("Line No.","Line No.");
    PAGE.RUNMODAL(PAGE::"Ord. Subcon Details Rcpt. List",PurchaseLine)
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    //PAGE.RUNMODAL(PAGE::"Ord. Subcon Details Rcpt. List",PurchaseLine)
    //Upgrade(+)
    IF NOT ISSERVICETIER THEN
      PAGE.RUNMODAL(PAGE::"Order Subcon Details Receipt",PurchaseLine)
    ELSE
      PAGE.RUNMODAL(PAGE::"Ord. Subcon Details Rcpt. List",PurchaseLine)
    //Upgrade(-)
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateLineDiscPct(PROCEDURE 132)".

    //procedure UpdateLineDiscPct();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") <> 0 THEN BEGIN
      LineDiscountPct := ROUND(
          "Line Discount Amount" / ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") * 100,
          0.00001);
      IF NOT (LineDiscountPct IN [0..100]) THEN
        ERROR(LineDiscountPctErr);
      "Line Discount %" := LineDiscountPct;
    END ELSE
      "Line Discount %" := 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
      IF NOT (LineDiscountPct IN [-1..100]) THEN
    #6..9
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateGSTAmounts(PROCEDURE 1500025)".// Function N/F

    //procedure UpdateGSTAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Line No." = 0) OR "Non-GST Line" THEN BEGIN
      VALIDATE("GST Base Amount",0);
      EXIT;
    #4..52
       (Vendor."Aggregate Turnover" = Vendor."Aggregate Turnover"::"More than 20 lakh") AND
       ("GST Group Type" = "GST Group Type"::Service)
    THEN
      ERROR(IGSTAggTurnoverErr);
    IF (PurchHeader1."GST Vendor Type" = PurchHeader1."GST Vendor Type"::Unregistered) AND
       (GSTJurisdiction = GSTJurisdiction::Interstate) AND ("GST Group Type" = "GST Group Type"::Goods)
    THEN
      ERROR(IGSTUnregisteredErr);
    IF (PurchHeader1."GST Vendor Type" = PurchHeader1."GST Vendor Type"::Unregistered) AND ("GST Group Code" <> '') AND
       NOT "GST Reverse Charge"
    THEN
    #64..115
    "GST Base Amount" := GSTBaseAmount;
    "GST Jurisdiction Type" := GSTJurisdiction;
    GSTManagement.DeleteGSTCalculationBuffer(TransactionType::Purchase,"Document Type","Document No.","Line No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..55
      //kulbhushan
    #56..59
      IF Vendor.Transporter = FALSE THEN
       ERROR(IGSTUnregisteredErr);

    #61..118
    */
    //end;




    //Unsupported feature: Code Modification on "UpdateTDSAdjustmentEntry(PROCEDURE 1500029)".// FUNCTION N/F

    //procedure UpdateTDSAdjustmentEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH PurchaseLine DO BEGIN
      Vendor.GET("Pay-to Vendor No.");
      TDSEntry.RESET;
      TDSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TDS Group","Assessee Code",Applied);
      TDSEntry.SETRANGE("Party Type",TDSEntry."Party Type"::Vendor);
      IF (Vendor."P.A.N. No." = '') AND (Vendor."P.A.N. Status" <> Vendor."P.A.N. Status"::" ") THEN
        TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.")
      ELSE
        TDSEntry.SETRANGE("Deductee P.A.N. No.",Vendor."P.A.N. No.");
      TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
      TDSEntry.SETRANGE("TDS Group","TDS Group");
      TDSEntry.SETRANGE("Assessee Code","Assessee Code");
    #13..20
      TDSEntry.RESET;
      TDSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TDS Group","Assessee Code","Document Type");
      TDSEntry.SETRANGE("Party Type",TDSEntry."Party Type"::Vendor);
      IF (Vendor."P.A.N. No." = '') AND (Vendor."P.A.N. Status" <> Vendor."P.A.N. Status"::" ") THEN
        TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.")
      ELSE
        TDSEntry.SETRANGE("Deductee P.A.N. No.",Vendor."P.A.N. No.");
      TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
      TDSEntry.SETRANGE("TDS Group","TDS Group");
      TDSEntry.SETRANGE("Assessee Code","Assessee Code");
    #31..38
      TDSEntry.RESET;
      TDSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TDS Group","Assessee Code","Document Type");
      TDSEntry.SETRANGE("Party Type",TDSEntry."Party Type"::Vendor);
      IF (Vendor."P.A.N. No." = '') AND (Vendor."P.A.N. Status" <> Vendor."P.A.N. Status"::" ") THEN
        TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.")
      ELSE
        TDSEntry.SETRANGE("Deductee P.A.N. No.",Vendor."P.A.N. No.");
      TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
      TDSEntry.SETRANGE("TDS Group","TDS Group");
      TDSEntry.SETRANGE("Assessee Code","Assessee Code");
    #49..53
        PaymentAmt1 := ABS(TDSEntry."Invoice Amount") + ABS(TDSEntry."Service Tax Including eCess");
      END;

      PreviousAmount1 := PaymentAmt1 + InvoiceAmt1;

      TDSEntry.RESET;
      TDSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TDS Group","Assessee Code");
      TDSEntry.SETRANGE("Party Type",TDSEntry."Party Type"::Vendor);
      IF (Vendor."P.A.N. No." = '') AND (Vendor."P.A.N. Status" <> Vendor."P.A.N. Status"::" ") THEN
        TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.")
      ELSE
        TDSEntry.SETRANGE("Deductee P.A.N. No.",Vendor."P.A.N. No.");
      TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
      TDSEntry.SETRANGE("TDS Group","TDS Group");
      TDSEntry.SETRANGE("Assessee Code","Assessee Code");
    #69..71
        PreviousTDSAmt1 := ABS(TDSEntry."TDS Amount");
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    WITH PurchaseLine DO BEGIN
    #3..5
      TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.");
    #10..23
      TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.");
    #28..41
      TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.");
    #46..56
      IF InvoiceAmt1 > PaymentAmt1 THEN
        PreviousAmount1 := InvoiceAmt1
      ELSE
        PreviousAmount1 := PaymentAmt1;
    #58..61
      TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.");
    #66..74
    */
    //end;


    //Unsupported feature: Code Modification on "FilterTDSEntry(PROCEDURE 1500030)".// FUNCTION N/F

    //procedure FilterTDSEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH PurchaseLine DO BEGIN
      Vendor.GET("Pay-to Vendor No.");
      TDSEntry.RESET;
      TDSEntry.SETCURRENTKEY(
        "Party Type","Party Code","Posting Date","TDS Group","Assessee Code",Applied);
      TDSEntry.SETRANGE("Party Type",TDSEntry."Party Type"::Vendor);
      IF (Vendor."P.A.N. No." = '') AND (Vendor."P.A.N. Status" <> Vendor."P.A.N. Status"::" ") THEN
        TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.")
      ELSE
        TDSEntry.SETRANGE("Deductee P.A.N. No.",Vendor."P.A.N. No.");
      TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
      TDSEntry.SETRANGE("TDS Group","TDS Group");
      TDSEntry.SETRANGE("Assessee Code","Assessee Code");
      TDSEntry.SETRANGE("TDS Adjustment",FALSE);
      TDSEntry.SETRANGE(Adjusted,FALSE);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    WITH PurchaseLine DO BEGIN
    #3..6
      TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.");
    #11..13
      TDSEntry.SETRANGE(Applied,FALSE);
    #14..16
    */
    //end;


    //Unsupported feature: Code Modification on "FilterTDSEntry1(PROCEDURE 1500032)".// FUNCTION N/F

    //procedure FilterTDSEntry1();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH PurchaseLine DO BEGIN
      Vendor.GET("Pay-to Vendor No.");
      TDSEntry.RESET;
      TDSEntry.SETCURRENTKEY("Party Type","Party Code","Posting Date","TDS Group","Assessee Code",Applied);
      TDSEntry.SETRANGE("Party Type",TDSEntry."Party Type"::Vendor);
      IF (Vendor."P.A.N. No." = '') AND (Vendor."P.A.N. Status" <> Vendor."P.A.N. Status"::" ") THEN
        TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.")
      ELSE
        TDSEntry.SETRANGE("Deductee P.A.N. No.",Vendor."P.A.N. No.");
      TDSEntry.SETFILTER("Posting Date",AccountingPeriodFilter);
      TDSEntry.SETRANGE("TDS Group","TDS Group");
      TDSEntry.SETRANGE("Assessee Code","Assessee Code");
      TDSEntry.SETRANGE(Applied,FALSE);
      TDSEntry.SETFILTER("Bal. TDS Including SHE CESS",'<>%1',0);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    WITH PurchaseLine DO BEGIN
    #3..5
      TDSEntry.SETRANGE("Party Code","Pay-to Vendor No.");
    #10..15
    */
    //end;

    procedure ValidatePurchaseOrderRate()
    var
        RecPurchLine: Record "Purchase Line";
        RecRecpLine: Record "Purch. Rcpt. Line";
        Text0005: Label 'Amount can not be greator than PO Rate for Item %1.';
    begin
        //FA022
        //IF (UPPERCASE(USERID)<>'FA019') AND (UPPERCASE(USERID)<>'FA022') AND (UPPERCASE(USERID)<>'FA006')THEN BEGIN
        IF (Type = Type::Item) AND ("Receipt No." <> '') AND ("Gen. Bus. Posting Group" <> 'EXIM') THEN BEGIN
            RecRecpLine.RESET;
            RecRecpLine.SETRANGE("Document No.", "Receipt No.");
            RecRecpLine.SETRANGE("Line No.", "Receipt Line No.");
            RecRecpLine.SETRANGE("No.", "No.");
            IF RecRecpLine.FINDFIRST THEN BEGIN
                RecPurchLine.RESET;
                RecPurchLine.SETRANGE("Document Type", RecPurchLine."Document Type"::Order);
                RecPurchLine.SETRANGE("Document No.", RecRecpLine."Order No.");
                RecPurchLine.SETRANGE("No.", RecRecpLine."No.");
                RecPurchLine.SETRANGE("Line No.", RecRecpLine."Order Line No."); ///MSKS
                IF RecPurchLine.FINDFIRST THEN BEGIN
                    IF RecPurchLine."Direct Unit Cost" < "Direct Unit Cost" THEN
                        ERROR(Text0005, RecRecpLine."No.");
                END;
            END;
        END;
        //END;

        /*   IF (Type = Type::Item) AND ("Document Type" = "Document Type"::"Return Order") THEN BEGIN
              IF PurchHeader.GET("Document Type","Document No.") THEN BEGIN
                RecPurchLine.RESET;
                RecPurchLine.SETRANGE("Document Type",RecPurchLine."Document Type"::Order);
                RecPurchLine.SETRANGE("Document No.",PurchHeader."Return Ref. Order No.");
                RecPurchLine.SETRANGE("No.","No.");
        //        RecPurchLine.SETRANGE("Line No.",RecRecpLine."Order Line No."); ///MSKS
                IF RecPurchLine.FINDFIRST THEN BEGIN
                  IF RecPurchLine."Direct Unit Cost" > "Direct Unit Cost" THEN
                    ERROR('Amount Cannot be less then PO Rate for Item %1',RecPurchLine."No.");
        
                END;
              END;
          END;
         */

    end;

    procedure "--MSBS.Rao---"()
    begin
    end;

    local procedure InsertPartialIndent(PL: Record "Purchase Line"; Qty: Decimal; PurQty: Decimal)
    var
        IndentLine: Record "Indent Line";
        RecIL: Record "Indent Line";
        IndentHeader: Record "Indent Header";
        NewRecIL: Record "Indent Line";
        Error0002: Label 'You can''t more than Pending Qty %1 !!!';
    begin
        IF IndentHeader.GET(PL."Indent No.") THEN BEGIN
            //MSBS.Rao Start 241114
            //IF Qty <> 0 THEN BEGIN
            NewIndentLine.SETRANGE("Document No.", "Indent No.");
            NewIndentLine.SETFILTER("No.", '%1', "No.");
            NewIndentLine.SETFILTER("Line No.", '>%1', "Indent Line No.");
            IF NewIndentLine.FINDFIRST THEN BEGIN
                REPEAT
                    IF (NewIndentLine."PO Qty" = 0) THEN
                        NewIndentLine.DELETE;
                UNTIL NewIndentLine.NEXT = 0;
            END;
            //END;
            //MSBS.Rao Stop 241114

            OldStatus := IndentHeader.Status;
            IndentHeader.Status := IndentHeader.Status::Open;
            IndentHeader.MODIFY;
            IndentLine.INIT;
            IndentLine."Document No." := PL."Indent No.";
            IndentLine."Line No." := LastIndentLineNo(PL."Indent No.");
            IF PL.Type = PL.Type::Item THEN
                IndentLine.Type := IndentLine.Type::Item;
            IF PL.Type = PL.Type::"G/L Account" THEN
                IndentLine.Type := IndentLine.Type::"Non Stock Item";
            IndentLine.VALIDATE("No.", PL."No.");
            IndentLine."Unit of Measurement" := PL."Unit of Measure Code";
            IndentLine."Item Category Code" := PL."Item Category Code";
            IndentLine.Description := PL.Description;
            IndentLine.VALIDATE(Rate, PL."Direct Unit Cost");
            IndentLine."Capex No." := PL."Capex No.";
            IndentLine.Status := OldStatus;
            IndentLine.Date := IndentHeader."Indent Date";//MASK240215
            IndentLine."Parent Line No" := PL."Indent Line No.";//MSBS.Rao 181214
            RecIL.SETRANGE("Document No.", PL."Indent No.");
            RecIL.SETRANGE("No.", PL."No.");
            RecIL.SETRANGE("Order No.", PL."Document No.");
            RecIL.SETRANGE("Order Line No.", PL."Line No.");
            RecIL.SETRANGE(Status, RecIL.Status::Closed);
            IF RecIL.FINDFIRST THEN
                RecIL.CALCFIELDS("PO Qty");
            RecIL1.SETRANGE("Document No.", PL."Indent No.");
            RecIL1.SETRANGE("No.", PL."No.");
            RecIL1.SETRANGE("Order No.", PL."Document No.");
            RecIL1.SETRANGE("Order Line No.", PL."Line No.");
            RecIL1.SETRANGE(Status, RecIL.Status::Closed);
            IF RecIL1.FINDFIRST THEN;

            //MSBS.Rao Start 231214
            IF PL."Old Pending Qty" <> 0 THEN
                IF PurQty > PL."Old Pending Qty" THEN
                    ERROR(Error0002, PL."Old Pending Qty");
            //MSBS.Rao Stop 231214
            /*
            //MESSAGE('org%1=po%2=%3=%4',GetOrgQty(PL."Indent No.",PL."No."),GetPOQty(PL."Indent No.",PL."No.",PL."Line No.",PL."Document No."),
              GetRecdQty(PL."Indent No.",PL."No."),TotalPOQty(PL."Indent No.",PL."No."));
              //IF GetPOQty(PL."Indent No.",PL."No.",PL."Line No.",PL."Document No.") = 0 THEN
            //  MESSAGE('%1=%2',GetOrgQty(PL."Indent No.",PL."No."),TotalPOQty(PL."Indent No.",PL."No."));
              IF GetOrgQty(PL."Indent No.",PL."No.") = TotalPOQty(PL."Indent No.",PL."No.") THEN BEGIN
                IndentLine.VALIDATE(Quantity,GetOrgQty(PL."Indent No.",PL."No.")-
                                  GetPOQty(PL."Indent No.",PL."No.",PL."Line No.",PL."Document No.")-(RecIL."PO Qty"-PL.Quantity)-
                                   GetRecdQty(PL."Indent No.",PL."No."));
               //MESSAGE('hi');
              END ELSE
              IF GetOrgQty(PL."Indent No.",PL."No.") > TotalPOQty(PL."Indent No.",PL."No.") THEN BEGIN
                //MESSAGE('org%1=getPO%2=poqty%3=plqty%4=getrecd%5=totalpo%6',GetOrgQty(PL."Indent No.",PL."No."),
                GetPOQty(PL."Indent No.",PL."No.",PL."Line No.",PL."Document No."),RecIL."PO Qty",PL.Quantity,
                GetRecdQty(PL."Indent No.",PL."No."),TotalPOQty(PL."Indent No.",PL."No."));

                IndentLine.VALIDATE(Quantity,(GetOrgQty(PL."Indent No.",PL."No.")-TotalPOQty(PL."Indent No.",PL."No.")+
                                  ((RecIL."PO Qty"-PL.Quantity)+
                                  GetPOQty(PL."Indent No.",PL."No.",PL."Line No.",PL."Document No.")-
                                   GetRecdQty(PL."Indent No.",PL."No."))));
              //MESSAGE('hi1');
             END ELSE
              IF GetOrgQty(PL."Indent No.",PL."No.") < TotalPOQty(PL."Indent No.",PL."No.") THEN BEGIN
                IndentLine.VALIDATE(Quantity,(GetOrgQty(PL."Indent No.",PL."No.")-TotalPOQty(PL."Indent No.",PL."No."))+
                                   (RecIL."PO Qty"-PL.Quantity)+
                                   (GetPOQty(PL."Indent No.",PL."No.",PL."Line No.",PL."Document No.")-GetRecdQty(PL."Indent No.",PL."No.")));
              //MESSAGE('hi2');
              END ELSE BEGIN
                IndentLine.VALIDATE(Quantity,ABS(GetOrgQty(PL."Indent No.",PL."No.")-
                                  GetPOQty(PL."Indent No.",PL."No.",PL."Line No.",PL."Document No.")-PL.Quantity-
                                   GetRecdQty(PL."Indent No.",PL."No.")));
               //MESSAGE('hi3');
              END;   */
            NewRecIL.SETRANGE("Document No.", PL."Indent No.");
            NewRecIL.SETRANGE("No.", PL."No.");
            IF NewRecIL.FINDFIRST THEN
                IndentLine.VALIDATE(Quantity, NewRecIL.GetTotalPOQtyKS(NewRecIL."Document No.", NewRecIL."No.", PurQty, NewRecIL."Line No.",
                                    FALSE, NewRecIL."Orginal Entry", "Document No.", "Line No."));
            /*MESSAGE('%1=%2',PurQty,Quantity);
            IF PurQty > NewRecIL.GetTotalPOQty(NewRecIL."Document No.",NewRecIL."No.",PurQty,NewRecIL."Line No.",
              //                  FALSE,NewRecIL."Orginal Entry") THEN
            IF PurQty > xRec.Quantity THEN
            ERROR(Error0001,NewRecIL.GetTotalPOQty(NewRecIL."Document No.",NewRecIL."No.",PurQty,NewRecIL."Line No.",
                                FALSE,NewRecIL."Orginal Entry"),PL."Indent No.",PL."No.");
            //MESSAGE('baljit%1',IndentLine.Quantity);
             */
            IF IndentLine.Quantity > 0 THEN
                IndentLine.INSERT;//(TRUE);MSAK240215
            IndentHeader.Status := OldStatus;
            IndentHeader.MODIFY;
        END;

    end;

    procedure LastIndentLineNo(IndentNo: Code[20]): Integer
    var
        RecIndentLine: Record "Indent Line";
    begin
        RecIndentLine.SETRANGE("Document No.", IndentNo);
        IF RecIndentLine.FINDLAST THEN
            EXIT(RecIndentLine."Line No." + 10000)
        ELSE
            EXIT(10000);
    end;

    procedure GetPOQty(IndentNo: Code[20]; ItemNo: Code[20]; LineNo: Integer; PONo: Code[20]): Decimal
    var
        RecIndentLine: Record "Indent Line";
        POQty: Decimal;
    begin
        POQty := 0;
        RecIndentLine.RESET;
        RecIndentLine.SETRANGE("Document No.", IndentNo);
        RecIndentLine.SETRANGE("No.", ItemNo);
        IF LineNo <> 0 THEN
            RecIndentLine.SETFILTER("Order No.", '<>%1', PONo);
        IF RecIndentLine.FINDFIRST THEN BEGIN
            REPEAT
                RecIndentLine.CALCFIELDS("PO Qty");
                POQty += RecIndentLine."PO Qty";
            UNTIL RecIndentLine.NEXT = 0;
            EXIT(POQty);
        END;
    end;

    procedure GetRecdQty(IndentNo: Code[20]; ItemNo: Code[20]): Decimal
    var
        RecIndentLine: Record "Indent Line";
        RecdQty: Decimal;
    begin
        RecdQty := 0;
        RecIndentLine.RESET;
        RecIndentLine.SETRANGE("Document No.", IndentNo);
        RecIndentLine.SETRANGE("No.", ItemNo);
        IF RecIndentLine.FINDFIRST THEN BEGIN
            REPEAT
                RecIndentLine.CALCFIELDS("Received Qty");
                RecdQty += RecIndentLine."Received Qty";
            UNTIL RecIndentLine.NEXT = 0;
            EXIT(RecdQty);
        END;
    end;

    procedure TotalNetQty(IndentNo: Code[20]; ItemNo: Code[20]; LineNo: Integer): Decimal
    var
        RecIndentLine: Record "Indent Line";
        IndentQty: Decimal;
        POQty: Decimal;
        RecdQty: Decimal;
    begin
        IndentQty := 0;
        POQty := 0;
        RecdQty := 0;
        RecIndentLine.RESET;
        RecIndentLine.SETRANGE("Document No.", IndentNo);
        RecIndentLine.SETRANGE("No.", ItemNo);
        IF LineNo <> 0 THEN BEGIN
            RecIndentLine.SETFILTER("Order No.", '<>%1', "Document No.");
            RecIndentLine.SETFILTER("Order Line No.", '<>%1', LineNo);
        END;
        IF RecIndentLine.FINDFIRST THEN BEGIN
            REPEAT
                RecIndentLine.CALCFIELDS("PO Qty", "Received Qty");
                IndentQty += RecIndentLine.Quantity;
                POQty += RecIndentLine."PO Qty";
                RecdQty += RecIndentLine."Received Qty";
            UNTIL RecIndentLine.NEXT = 0;
            IF LineNo <> 0 THEN
                EXIT(IndentQty - RecdQty)
            ELSE
                EXIT(IndentQty - POQty - RecdQty);
        END;
    end;

    procedure GetOrgQty(IndentNo: Code[20]; ItemNo: Code[20]): Decimal
    var
        RecIndentLine: Record "Indent Line";
        POQty: Decimal;
    begin
        RecIndentLine.RESET;
        RecIndentLine.SETRANGE("Document No.", IndentNo);
        RecIndentLine.SETRANGE("No.", ItemNo);
        RecIndentLine.SETRANGE("Orginal Entry", TRUE);
        IF RecIndentLine.FINDFIRST THEN
            EXIT(RecIndentLine.Quantity);
    end;

    procedure TotalPOQty(IndentNo: Code[20]; ItemNo: Code[20]): Decimal
    var
        RecIndentLine: Record "Indent Line";
        POQty: Decimal;
    begin
        POQty := 0;
        RecIndentLine.RESET;
        RecIndentLine.SETRANGE("Document No.", IndentNo);
        RecIndentLine.SETRANGE("No.", ItemNo);
        IF RecIndentLine.FINDFIRST THEN BEGIN
            REPEAT
                RecIndentLine.CALCFIELDS("PO Qty");
                POQty += RecIndentLine."PO Qty";
            UNTIL RecIndentLine.NEXT = 0;
            EXIT(POQty);
        END;
    end;

    procedure UpdateReturnQty()
    begin
        "Diff Qty." := "Shortage Quantity" + "Rejected Quantity";
        VALIDATE("Qty. to Receive", "Challan Quantity");
        //MESSAGE('%1',"Challan Quantity");
    end;

    procedure CheckDescription()
    begin
        GetItem;
        IF (Type IN [2]) AND (NOT Item."Inventory Value Zero") THEN
            IF xRec."Description 2" <> "Description 2" THEN
                ERROR('Description2 Cannot be Change');

        IF (Type IN [2]) AND (NOT Item."Inventory Value Zero") THEN
            IF xRec.Description <> Description THEN
                ERROR('Description Cannot be Change');
    end;

    local procedure CheckIndentPOQty(var IndentNo: Code[20]; var IndentLnNo: Integer; var ItemNo: Code[20]; var PoNo: Code[20]; var PoNoLnNo: Integer) decPOQty: Decimal
    var
        rPurchaseLine: Record "Purchase Line";
        decIndentQty: Decimal;
        rIndentLine: Record "Indent Line";
    begin
        rPurchaseLine.RESET;
        rPurchaseLine.SETRANGE("Indent No.", IndentNo);
        rPurchaseLine.SETRANGE("Indent Line No.", IndentLnNo);
        rPurchaseLine.SETRANGE("No.", ItemNo);
        rPurchaseLine.SETFILTER("Document No.", '<>%1', PoNo);
        IF rPurchaseLine.FIND('-') THEN BEGIN
            REPEAT
                decPOQty += rPurchaseLine."Indent Original Quantity";
            UNTIL rPurchaseLine.NEXT = 0;
        END;
    end;

    local procedure CheckIndentPOQtyNew(var IndentNo: Code[20]; var IndentLnNo: Integer; var ItemNo: Code[20]; var PoNo: Code[20]; var PoNoLnNo: Integer) decPOQty: Decimal
    var
        rPurchaseLine: Record "Purchase Line";
        decIndentQty: Decimal;
        rIndentLine: Record "Indent Line";
    begin
        rPurchaseLine.RESET;
        rPurchaseLine.SETRANGE("Indent No.", IndentNo);
        rPurchaseLine.SETRANGE("Indent Line No.", IndentLnNo);
        rPurchaseLine.SETRANGE("No.", ItemNo);
        rPurchaseLine.SETFILTER("Document No.", '<>%1', PoNo);
        IF rPurchaseLine.FIND('-') THEN BEGIN
            REPEAT
                decPOQty += rPurchaseLine."Indent Original Quantity";
            UNTIL rPurchaseLine.NEXT = 0;
        END;
    end;

    local procedure GetIndentQty(var IndentLine: Record "Indent Line"): Decimal
    begin
        EXIT(IndentLine.Quantity + (IndentLine.Quantity * 1.9));

        //Kulbhushan Sharma
    end;

    /*  procedure UpdateTDSNatureofDed()
      var
          NODNOCLines: Record 13785;
      begin
          IF "Document Type" IN ["Document Type"::Order, "Document Type"::Invoice] THEN BEGIN
              NODNOCLines.RESET;
              NODNOCLines.SETRANGE(Type, NODNOCLines.Type::Vendor);
              NODNOCLines.SETRANGE("No.", "Buy-from Vendor No.");
              NODNOCLines.SETFILTER("NOD/NOC", '%1', '194Q');
              IF NODNOCLines.FINDFIRST THEN
                  VALIDATE("TDS Nature of Deduction", NODNOCLines."NOD/NOC");
          END;
      end;*/


    var
        "...tri1.0": Integer;
        PurchasePayablesSetup: Record "Purchases & Payables Setup";
        //  DocumentDimensions: Record "Document Dimension";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Location1: Record Location;
        UserAccess: Integer;
        Permissions: Codeunit Permissions1;
        UserLocation: Record "User Location";
        IndentLine: Record "Indent Line";
        TaxGroup: Record "Tax Group";
        PurchHeader11: Record "Purchase Header";
        tgSalesPrice: Record "Sales Price";
        tgPurchHdr: Record "Purchase Header";
        tgPurchRctHeader: Record "Purch. Rcpt. Header";
        TDSBaseAmt: Decimal;
        RecPurchaseLn: Record "Purchase Line";
        Flag: Boolean;
        PurchaseLine: Record "Purchase Line";
        RecvQty: Decimal;
        MfgSetup: Record "Manufacturing Setup";
        ile: Record "Item Ledger Entry";
        ttqty: Decimal;
        ind: Record "Indent Line";
        OldStatus: Option Open,Authorization1,Authorization2,Authorized,Closed,Authorization3;
        NewIndentLine: Record "Indent Line";
        RecIL1: Record "Indent Line";
        UserSetup: Record "User Setup";
        Text100: Label 'Quantity Per Should be greater than Zero in Excise Posting Setup.';
        Text101: Label 'You are not allowed to select this Nature of deduction.';
        Text103: Label 'Tax area is not defined for Vendor Location %1 to Receiving Location %2.';
        Txt001: Label 'You can not have %1 Defined in structure for Import Document';
        Text16360: Label 'There is still Components pending at vendor location';
        Text16361: Label 'Reopening is not allowed Production Order %1 has already been reported as Finished';
        text16321: Label 'You can not delete the purchase line as one or more ledger entries exists.';
        Text16322: Label 'You are not allowed to make this change in a Subcontracting Order';
        Text16323: Label 'The selected structure will load the sales tax component on inventory value. Do you want to proceed ?';
        Text16324: Label 'The selected structure will not load the sales tax component on inventory value. Do you want to proceed ?';
        Text0001: Label 'You can''t enter more than %1 units.';
        Text0002: Label 'Acutal Quantity must be filled in.';
        Text0003: Label 'Item is Blocked for Purchase insertion.';
        Text0004: Label 'Sorry!!!!!!!! Item %1  MRN is created, So can''t changed the Direct Cost';
        MSErr0001: Label 'Item No %1 , Line No %2 discoutinued , Please contact to Costing Department.';
        Text0005: Label 'Po Qty Cannot Be Greater Than Indent Qty.';
        Error0001: Label 'You can''t enter more than Orginal Qty %1 for Item No %2 , Indent No %3 !!!';
        RecItem: Record Item;
        CopyStr11: Code[10];
        hsn: Record "HSN/SAC";


        recIndentLine: Record "Indent Line";
        rPurchaseLine: Record "Purchase Line";
        decIndQty: Decimal;
        rPurchaseHeader: Record "Purchase Header";
        PendQty: Decimal;
        rIndentLn: Record "Indent Line";
        decIndQnty: Decimal;
        decPOQty: Decimal;
        rIndentHeader: Record "Indent Header";
        GLSetup: Record "General Ledger Setup";
        TDSCeilingApplied: Boolean;
        TDSCeilingAppliedPercentage: Decimal;
        Item: Record Item;
        Location: Record Location;
        PurchHeader: Record "Purchase Header";
        Currency: Record Currency;
        FA: Record "Fixed Asset";
}

