table 50017 "Indent Line"
{
    // 
    // 
    // TRI A.S 28.05.08 Code Added for Indent Item to Block.
    // 1.TRI S.R 220310 - New field Added for Group code.


    fields
    {
        field(1; "Document No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; Type; Option)
        {
            OptionMembers = " ",Item,"Non Stock Item";

            trigger OnValidate()
            begin
                IF Type <> xRec.Type THEN
                    VALIDATE("No.", '');

                IF Type <> Type::" " THEN
                    VALIDATE("New Item", FALSE);
            end;
        }
        field(4; "No."; Code[20])
        {
            TableRelation = IF (Type = FILTER(Item)) Item
            ELSE
            IF (Type = FILTER("Non Stock Item")) "Non-Stock Item";

            trigger OnValidate()
            var
                rInvenPostingGrp: Record "Inventory Posting Setup";
                rNoSeries: Record "No. Series";
                rIndentHeader: Record "Indent Header";
                rItem: Record Item;
                txtItemSerApp: Text;
            begin
                IF IndentHeader.GET("Document No.") THEN //MSBS.Rao 290914
                    IndentHeader.TESTFIELD(IndentHeader.Status, IndentHeader.Status::Open);

                IF "No." <> '' THEN BEGIN
                    IF Type = Type::Item THEN BEGIN
                        Item.RESET;
                        Item.SETFILTER(Item."No.", "No.");
                        IF Item.FIND('-') THEN BEGIN

                            //TRI A.S 28.05.08 Start
                            IF Item."Indent Blocked" THEN BEGIN
                                ERROR(Text0001)
                            END ELSE
                                //TRI A.S 28.05.08 End
                                //IF IndentHeader.GET("Document No.") THEN //MSBS.Rao 290914
                                /* IF IndentHeader."Group Code" = '' THEN
                                  ERROR(Text002);*/
                                IF IndentHeader."Group Code" <> Item."Group Code" THEN
                                    ERROR(Text003, IndentHeader."Group Code");

                            VALIDATE("Group Code", Item."Group Code");
                            VALIDATE("Unit of Measurement", Item."Purch. Unit of Measure");
                            VALIDATE("Item Category Code", Item."Item Category Code");
                            // VALIDATE("Product Group Code", Item."Product Group Code");//16225 ITEM TABLE REMOVED PRODUCT GROUP CODE
                            Description := Item.Description;
                            "Description 2" := Item."Description 2";

                            // TRI SC
                            // VALIDATE(Rate,Item."Unit Cost");
                            IF Item."Last Direct Cost" <> 0 THEN
                                VALIDATE(Rate, Item."Last Direct Cost")
                            ELSE
                                VALIDATE(Rate, Item."Unit Cost");
                            //TRI SC
                            VALIDATE("Vendor No.", Item."Vendor No.");
                        END;

                        //ravi tri1.0 Start
                        PurchRcptLine.RESET;
                        PurchRcptLine.SETRANGE(PurchRcptLine.Type, PurchRcptLine.Type::Item);
                        PurchRcptLine.SETFILTER(PurchRcptLine."No.", "No.");
                        IF PurchRcptLine.FIND('+') THEN BEGIN
                            PurchRcptHeader.SETFILTER(PurchRcptHeader."No.", PurchRcptLine."Document No.");
                            IF PurchRcptHeader.FIND('-') THEN BEGIN
                                VALIDATE("Last Order No.", PurchRcptHeader."Order No.");
                                VALIDATE("Last Order Date", PurchRcptHeader."Order Date");
                            END
                        END ELSE BEGIN
                            VALIDATE("Last Order No.", '');
                            VALIDATE("Last Order Date", 0D);
                        END;
                        //ravi tri1.0 end
                    END;

                    IF Type = Type::"Non Stock Item" THEN BEGIN
                        NonStockItem.RESET;
                        //NonStockItem.SETFILTER(NonStockItem."No.","No.");
                        Item.SETFILTER(Item."No.", "No.");
                        IF NonStockItem.FIND('-') THEN BEGIN
                            IF NonStockItem.Blocked THEN
                                ERROR('The Item is Blocked for Indent');
                            VALIDATE(Description, NonStockItem.Description);
                            //VALIDATE("G/L Account",NonStockItem."G/L Account");
                            //VALIDATE("Unit of Measurement",NonStockItem."Unit of Measurement");
                        END;
                    END;
                END;

                IF "No." = '' THEN BEGIN
                    VALIDATE("Unit of Measurement", '');
                    VALIDATE("Item Category Code", '');
                    VALIDATE("Product Group Code", '');
                    VALIDATE(Description, '');
                    VALIDATE(Rate, 0);
                    VALIDATE("Vendor No.", '');
                    VALIDATE(Quantity, 0);
                END;

                IndentHeader.RESET;
                IF IndentHeader.GET("Document No.") THEN
                    "Location Code" := IndentHeader."Location Code";

                //Kulbhushan Indent

                //MSVC.BEGIN 31-01-13
                IF NOT IndentHeader."Auto Indent" THEN BEGIN
                    IndentLine1.RESET;
                    IndentLine1.SETRANGE("No.", "No.");
                    IndentLine1.SETRANGE("Location Code", "Location Code");
                    IndentLine1.SETRANGE(IndentLine1.Type, Type::Item);
                    IndentLine1.SETFILTER(IndentLine1.Status, '<>%1', IndentLine1.Status::Closed);
                    IndentLine1.SETFILTER(IndentLine1.Status, '<>%1', IndentLine1.Status::Open);
                    IF IndentLine1.FINDLAST THEN
                        MESSAGE('%1  %2', 'The Indent of This Item Already Exits', IndentLine1."Document No.");
                END;
                //MSVC.END 31-01-13


                //Keshav08042020
                rIndentHeader.RESET;
                rIndentHeader.SETRANGE("No.", "Document No.");
                IF rIndentHeader.FIND('-') THEN BEGIN
                    rNoSeries.RESET;
                    rNoSeries.SETRANGE(Code, rIndentHeader."No. Series");
                    IF rNoSeries.FIND('-') THEN BEGIN
                        txtItemSerApp := '';
                        IF rNoSeries.Domestic = TRUE THEN
                            txtItemSerApp := 'DOMESTIC';

                        IF rNoSeries.Imported = TRUE THEN BEGIN
                            IF txtItemSerApp = '' THEN
                                txtItemSerApp := 'IMPORTED' ELSE
                                txtItemSerApp := txtItemSerApp + ', IMPORTED';
                        END;
                        IF rNoSeries."U Series" = TRUE THEN BEGIN
                            IF txtItemSerApp = '' THEN
                                txtItemSerApp := 'U Series' ELSE
                                txtItemSerApp := txtItemSerApp + ', U Series';
                        END;
                        IF rNoSeries."SRV Service" = TRUE THEN BEGIN
                            IF txtItemSerApp = '' THEN
                                txtItemSerApp := 'SRV Service' ELSE
                                txtItemSerApp := txtItemSerApp + ', SRV Service';
                        END;
                        rItem.RESET;
                        rItem.SETRANGE("No.", "No.");
                        IF rItem.FIND('-') THEN BEGIN
                            //16225 Table Field N/f Start
                            /*  rInvenPostingGrp.RESET;
                              rInvenPostingGrp.SETRANGE("Code", rItem."Inventory Posting Group");
                              IF rInvenPostingGrp.FIND('-') THEN BEGIN
                                  rInvenPostingGrp.TESTFIELD("Item Code Service App");
                                  IF rNoSeries.Domestic = FALSE THEN
                                      IF rInvenPostingGrp."Item Code Service App" = rInvenPostingGrp."Item Code Service App"::Domestic THEN
                                          ERROR('You can select only those item which have Item Code Services Applicable : ' + txtItemSerApp);
                                  IF rNoSeries.Imported = FALSE THEN
                                      IF rInvenPostingGrp."Item Code Service App" = rInvenPostingGrp."Item Code Service App"::Imported THEN
                                          ERROR('You can select only those item which have Item Code Services Applicable : ' + txtItemSerApp);
                                  IF rNoSeries."U Series" = FALSE THEN
                                      IF rInvenPostingGrp."Item Code Service App" = rInvenPostingGrp."Item Code Service App"::"U Series" THEN
                                          ERROR('You can select only those item which have Item Code Services Applicable : ' + txtItemSerApp);
                                  IF rNoSeries."SRV Service" = FALSE THEN
                                      IF rInvenPostingGrp."Item Code Service App" = rInvenPostingGrp."Item Code Service App"::"SRV Service" THEN
                                          ERROR('You can select only those item which have Item Code Services Applicable : ' + txtItemSerApp);

                              END;*///16225 Table Field N/f End
                        END;
                    END;
                END;
                //Keshav08042020

            end;
        }
        field(5; "Unit of Measurement"; Code[20])
        {
            TableRelation = "Unit of Measure";

            trigger OnLookup()
            begin
                ItemUnitofMeasure.RESET;
                ItemUnitofMeasure.SETFILTER(ItemUnitofMeasure."Item No.", "No.");
                IF Type = Type::Item THEN BEGIN
                    IF PAGE.RUNMODAL(Page::"Item Units of Measure", ItemUnitofMeasure) = ACTION::LookupOK THEN
                        VALIDATE("Unit of Measurement", ItemUnitofMeasure.Code);
                END;

                UnitofMeasure.RESET;
                IF Type = Type::"Non Stock Item" THEN BEGIN
                    IF PAGE.RUNMODAL(Page::"Units of Measure", UnitofMeasure) = ACTION::LookupOK THEN
                        VALIDATE("Unit of Measurement", UnitofMeasure.Code);
                END;
            end;

            trigger OnValidate()
            begin
                IF "Unit of Measurement" <> '' THEN;
                IF Item.GET("No.") THEN BEGIN
                    IF (Type IN [1]) AND (NOT Item."Inventory Value Zero") THEN
                        IF "Unit of Measurement" <> Item."Purch. Unit of Measure" THEN
                            IF xRec."Unit of Measurement" <> "Unit of Measurement" THEN
                                ERROR('UOM Cannot be Change for this Item')
                END;
            end;
        }
        field(6; "Item Category Code"; Code[20])
        {
            Editable = true;
            TableRelation = "Item Category".Code;
        }
        field(7; Description; Text[100])
        {

            trigger OnValidate()
            begin
                IF Type <> 1 THEN
                    EXIT;

                CheckDescription;
            end;
        }
        field(8; Quantity; Decimal)
        {
            DecimalPlaces = 2 : 5;

            trigger OnValidate()
            begin
                Amount := Quantity * Rate;
            end;
        }
        field(9; Rate; Decimal)
        {

            trigger OnValidate()
            begin
                Amount := Quantity * Rate;
            end;
        }
        field(10; Amount; Decimal)
        {
            Editable = false;
        }
        field(11; "Due Date"; Date)
        {
        }
        field(12; "G/L Account"; Code[20])
        {
            Editable = false;
            TableRelation = "G/L Account"."No.";
        }
        field(13; "Order No."; Code[20])
        {
            Editable = true;
        }
        field(14; "Order Line No."; Integer)
        {
            Editable = true;
        }
        field(15; Date; Date)
        {
        }
        field(16; Deleted; Boolean)
        {
            Caption = 'Not To Be Executed';

            trigger OnValidate()
            begin
                IF IndentHeader.Status = IndentHeader.Status::Authorized THEN
                    ERROR('Function will not work on Authorized Line');
                IndentHeader.RESET;
                IndentHeader.SETFILTER("No.", '%1', "Document No.");
                IF IndentHeader.FIND('-') THEN
                    UserSetup.RESET;
                UserSetup.SETFILTER(UserSetup."User ID", '%1', IndentHeader."User ID");
                IF UserSetup.FIND('-') THEN
                    CASE IndentHeader.Status OF
                        IndentHeader.Status::Open:
                            IF UserSetup."User ID" <> UPPERCASE(USERID) THEN
                                ERROR('You are not allowed to modify this Indent');
                        IndentHeader.Status::Authorization1:
                            IF UserSetup."Authorization 1" <> UPPERCASE(USERID) THEN
                                ERROR('You are not allowed to modify this Indent');
                    /*  IndentHeader.Status::Authorization2:
                        IF UserSetup."Authorization 2" <> UPPERCASE(USERID) THEN
                          ERROR('You are not allowed to modify this Indent');*/
                    END;

            end;
        }
        field(17; "Location Code"; Code[10])
        {
            TableRelation = Location;

            trigger OnLookup()
            begin
                UserLocation.RESET;
                UserLocation.SETFILTER(UserLocation."User ID", USERID);
                UserLocation.SETFILTER(UserLocation."Create Indent", '%1', TRUE);
                IF UserLocation.FIND('-') THEN
                    IF PAGE.RUNMODAL(Page::"User Locations", UserLocation) = ACTION::LookupOK THEN
                        VALIDATE("Location Code", UserLocation."Location Code");
            end;

            trigger OnValidate()
            begin
                /*
                IndentHeader.RESET;
                IF IndentHeader.GET("Document No.") THEN
                  IndentHeader.VALIDATE(IndentHeader."Location Code",IndentHeader."Location Code");
                */

            end;
        }
        field(18; "Vendor No."; Code[20])
        {
            NotBlank = false;
            TableRelation = Vendor."No.";
        }
        field(19; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Authorization1,Authorization2,Authorized,Closed,Authorization3';
            OptionMembers = Open,Authorization1,Authorization2,Authorized,Closed,Authorization3;
        }
        field(20; Selection; Boolean)
        {

            trigger OnValidate()
            var
                PurchaseOrder: Page "Purchase Order";
                NoSeries: Code[20];
            begin
                CALCFIELDS("Actual PO Qty");
                IF Quantity - "Actual PO Qty" < 0 THEN
                    ERROR('Balance Quantity Not available Where Indent No. : ' + "Document No." + ', Line No. : ' + FORMAT("Line No."));
            end;
        }
        field(21; "Order Date"; Date)
        {
            Editable = false;
        }
        field(22; "Description 2"; Text[100])
        {

            trigger OnValidate()
            begin
                IF Type <> 1 THEN
                    EXIT;

                CheckDescription;
            end;
        }
        field(23; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            Editable = true;
            TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(24; "Last Order No."; Code[20])
        {
            Editable = false;
        }
        field(25; "New Item"; Boolean)
        {
        }
        field(26; "Last Order Date"; Date)
        {
            Editable = true;
        }
        field(50000; "Group Code"; Code[2])
        {
            Description = 'TRI S.R 220310 - New field Add';
            Editable = false;
            TableRelation = "Item Group";
        }
        field(50001; "Planning Date"; Date)
        {
            Description = 'TRI S.R 220310 - New field Add';
            Editable = false;
        }
        field(50002; "Capex No."; Code[22])
        {
            CalcFormula = Lookup("Indent Header"."Capex No." WHERE("No." = FIELD("Document No.")));
            Description = 'Ori Ut';
            FieldClass = FlowField;
        }
        field(50003; "PO Qty"; Decimal)
        {
            CalcFormula = Sum("Purchase Line".Quantity WHERE("Indent No." = FIELD("Document No."),
                                                              "No." = FIELD("No."),
                                                              "Indent Line No." = FIELD("Line No.")));
            DecimalPlaces = 0 : 5;
            Description = 'MSBS.Rao 251114';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Received Qty"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Quantity Received" WHERE("Indent No." = FIELD("Document No."),
                                                                         "No." = FIELD("No."),
                                                                         "Indent Line No." = FIELD("Line No.")));
            Description = 'MSBS.Rao 251114';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Orginal Entry"; Boolean)
        {
            Description = 'MSBS.Rao 121214';
        }
        field(50007; "Parent Line No"; Integer)
        {
            Description = 'MSBS.Rao 181214';
        }
        field(50008; "Short Closed"; Boolean)
        {
            CalcFormula = Exist("Purchase Header" WHERE("No." = FIELD("Order No."),
                                                         "Status" = FILTER('Short Close')));
            Description = 'MSBS.Rao 181214';
            FieldClass = FlowField;
        }
        field(50009; "Old Status"; Option)
        {
            OptionCaption = 'Open,Authorization1,Authorization2,Authorized,Closed,Authorization3';
            OptionMembers = Open,Authorization1,Authorization2,Authorized,Closed,Authorization3;
        }
        field(50010; Lrate; Decimal)
        {
            CalcFormula = Lookup("Purchase Line"."Direct Unit Cost" WHERE("Document No." = FIELD("Last Order No."),
                                                                           "No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50011; "Vendor Name"; Text[100])
        {
            CalcFormula = Lookup("Purchase Header"."Buy-from Vendor Name" WHERE("No." = FIELD("Last Order No.")));
            FieldClass = FlowField;
        }
        field(50012; "Ref Code"; Code[20])
        {
            CalcFormula = Lookup(Item."Old Code" WHERE("No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50013; "Authorization Date"; Date)
        {
            CalcFormula = Lookup("Indent Header"."Authorization Date" WHERE("No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50014; HSN; Code[10])
        {
            CalcFormula = Lookup(Item."HSN/SAC Code" WHERE("No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50015; Remarks; Text[100])
        {
        }
        field(50016; "Job Indent"; Boolean)
        {
            CalcFormula = Lookup("Indent Header"."Job Indent" WHERE("No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50020; "RGP No."; Code[20])
        {
            Description = 'MSVRN 290518';
        }
        field(50021; "RGP Made"; Boolean)
        {
            Description = 'MSVRN 010618';
        }
        field(50022; "Header Status"; Option)
        {
            CalcFormula = Lookup("Indent Header".Status WHERE("No." = FIELD("Document No.")));
            Editable = true;
            FieldClass = FlowField;
            OptionCaption = 'Open,Authorization1,Authorization2,Authorized,Closed,Authorization3';
            OptionMembers = Open,Authorization1,Authorization2,Authorized,Closed,Authorization3;
        }
        field(50023; "Inventory Posting Group"; Code[10])
        {
            CalcFormula = Lookup(Item."Inventory Posting Group" WHERE("No." = FIELD("No.")));
            Description = 'Keshav';
            FieldClass = FlowField;
            TableRelation = "Inventory Posting Group";
        }
        field(50024; "Item Code Service App"; Option)
        {
            CalcFormula = Lookup("Inventory Posting Group"."Item Code Service App" WHERE("Code" = FIELD("Inventory Posting Group")));
            Description = 'Keshav';
            FieldClass = FlowField;
            OptionCaption = '  ,Domestic,Imported,U Series,SRV Service';
            OptionMembers = "  ",Domestic,Imported,"U Series","SRV Service";
        }
        field(50025; "Actual PO Qty"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Indent Original Quantity" WHERE("Indent No." = FIELD("Document No."),
                                                                                "Indent Line No." = FIELD("Line No."),
                                                                                "No." = FIELD("No.")));
            Description = 'Keshav';
            FieldClass = FlowField;
        }
        field(60028; NOE; Code[15])
        {
            Description = 'MSVRN 060918';
            TableRelation = "NOE Permission"."NOE" WHERE("Location" = FIELD("Location Code"));
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
        key(Key2; "Vendor No.")
        {
        }
        key(Key3; "Product Group Code")
        {
        }
        key(Key4; Type, "No.", "Location Code", "Due Date", Selection)
        {
            SumIndexFields = Amount, Quantity;
        }
        key(Key5; Date)
        {
        }
        key(Key6; "Order No.", Deleted, Status, "No.", Type, "Due Date")
        {
            SumIndexFields = Quantity;
        }
        key(Key7; "Order No.", Deleted, "Location Code", "No.", Type, Status)
        {
            SumIndexFields = Quantity;
        }
        key(Key8; "No.")
        {
        }
        key(Key9; "Order No.", Deleted, "Location Code", "No.", Type, "Due Date", Status)
        {
            SumIndexFields = Quantity;
        }
        key(Key10; "Document No.", "No.", "Parent Line No")
        {
            SumIndexFields = Quantity;
        }
        key(Key11; Status, "Order No.", "Order Line No.")
        {
        }
        key(Key12; Status, "Order No.", Deleted)
        {
        }
        key(Key13; Date, "Location Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IndentHeader.RESET;
        IndentHeader.SETFILTER("No.", '%1', "Document No.");
        IF IndentHeader.FIND('-') THEN BEGIN
            IF IndentHeader.Status <> IndentHeader.Status::Open THEN
                ERROR('Status must be open to delete the Lines.');
        END;
        /*
        UserSetup.RESET;
        UserSetup.SETFILTER(UserSetup."User ID",IndentHeader."User ID");
        IF UserSetup.FIND('-') THEN
          CASE IndentHeader.Status OF
          IndentHeader.Status::Open:
            IF UPPERCASE(UserSetup."User ID") <> UPPERCASE(USERID) THEN
                ERROR('You are not allowed to modify this Indent');
          IndentHeader.Status::Authorization1:
            IF UPPERCASE(UserSetup."Authorization 1") <> UPPERCASE(USERID) THEN
              ERROR('You are not allowed to modify this Indent');
          IndentHeader.Status::Authorization2:
            IF UPPERCASE(UserSetup."Authorization 2") <> UPPERCASE(USERID) THEN
              ERROR('You are not allowed to modify this Indent');
          END;
        END;
        */
        ReqLine.RESET;
        ReqLine.SETRANGE(ReqLine."Indent Header", "Document No.");
        ReqLine.SETRANGE(ReqLine."Indent Line", "Line No.");
        IF ReqLine.FIND('-') THEN
            ReqLine.DELETE(TRUE);

    end;

    trigger OnInsert()
    var
        MS0001: Label 'Modification Cannot Be Possible when the Status is Authorized';
    begin
        IF (USERID <> UPPERCASE('ADMIN')) AND (USERID <> UPPERCASE('IT005')) THEN BEGIN
            IndentHeader.RESET;
            IndentHeader.SETFILTER("No.", "Document No.");
            IF IndentHeader.FIND('-') THEN
                IF NOT IndentHeader."Auto Indent" THEN BEGIN
                    UserSetup.RESET;
                    UserSetup.SETFILTER(UserSetup."User ID", IndentHeader."User ID");
                    IF UserSetup.FIND('-') THEN
                        CASE IndentHeader.Status OF
                            IndentHeader.Status::Open:
                                IF UserSetup."User ID" <> UPPERCASE(USERID) THEN
                                    ERROR('You are not allowed to modify this Indent');
                            IndentHeader.Status::Authorization1:
                                IF UserSetup."Authorization 1" <> UPPERCASE(USERID) THEN
                                    ERROR('You are not allowed to modify this Indent');
                            IndentHeader.Status::Authorization2:
                                IF UserSetup."Authorization 2" <> UPPERCASE(USERID) THEN
                                    ERROR('You are not allowed to modify this Indent');
                        END;
                END;
            blnInserted := TRUE;

            IF IndentHeader.GET("Document No.") THEN
                IF IndentHeader.Status <> IndentHeader.Status::Open THEN
                    ERROR('Status must be open to Add Lines.');

            IndentHeader.RESET;
            IndentHeader.SETFILTER("No.", "Document No.");
            IF IndentHeader.FIND('-') THEN
                VALIDATE(Date, IndentHeader."Indent Date");

            IF (Type = Type::Item) OR (Type = Type::"Non Stock Item") THEN
                IF "No." = '' THEN
                    ERROR('Please enter %1 No.', Type);

            IF Type = Type::" " THEN BEGIN
                "Item Category Code" := xRec."Item Category Code";
                "Product Group Code" := xRec."Product Group Code";
            END;

            //SHAKTI
            /*
            IF IndentHeader.Status<>IndentHeader.Status::Open THEN
            ERROR('You are not allowed to modify this Indent');
            */
            //MSBS.Rao Begin Dt. 18-04-13
            IF IndentHeader.Status = IndentHeader.Status::Authorization1 THEN
                ERROR(MS0001);
            //MSBS.Rao End Dt. 18-04-13
            IF IndentHeader.GET("Document No.") THEN
                "Location Code" := IndentHeader."Location Code";

            IF Item."No." <> "No." THEN
                Item.GET("No.");
            IF Item."Inventory Value Zero" THEN
                EXIT;
            IndentLine1.RESET;
            IndentLine1.SETFILTER("Document No.", IndentHeader."No.");
            IndentLine1.SETRANGE(Type, Type::Item);
            IF Type = Type::Item THEN BEGIN
                IndentLine1.SETFILTER("No.", "No.");
                IF IndentLine1.FIND('-') THEN
                    ERROR('Item Already Exists in This Indent');
            END;
        END;

    end;

    trigger OnModify()
    begin
        IF (USERID <> UPPERCASE('ADMIN')) AND (USERID <> UPPERCASE('IT005')) THEN BEGIN
            IndentHeader.RESET;
            IndentHeader.SETFILTER("No.", "Document No.");
            IF IndentHeader.FIND('-') THEN
                UserSetup.RESET;
            UserSetup.SETFILTER(UserSetup."User ID", IndentHeader."User ID");
            IF UserSetup.FIND('-') THEN
                CASE IndentHeader.Status OF
                    IndentHeader.Status::Open:
                        IF UserSetup."User ID" <> UPPERCASE(USERID) THEN
                            ERROR('You are not allowed to modify this Indent');
                    IndentHeader.Status::Authorization1:
                        IF UserSetup."Authorization 1" <> UPPERCASE(USERID) THEN
                            ERROR('You are not allowed to modify this Indent');
                    IndentHeader.Status::Authorization2:
                        IF UserSetup."Authorization 2" <> UPPERCASE(USERID) THEN
                            ERROR('You are not allowed to modify this Indent');
                END;
        END;
        /*
        UserAccess := 32;
        Permissions.Type(UserAccess,"Location Code");
        */

        /*IF "Order No." <> '' THEN
           ERROR('You cannot modify the record, Purchase Order has been made for this record');*/ //oRI uT

        IF (Type = Type::Item) OR (Type = Type::"Non Stock Item") THEN
            IF "No." = '' THEN
                ERROR('Please enter %1 No.', Type);

        //SHAKTI
        /*
        IF (IndentHeader.Status<>IndentHeader.Status::Open) THEN
        ERROR('You are not allowed to modify this Indent');
        */
        /*  IF Rate <> 0 THEN
             ERROR('Change in Rate is Not Allowed')
           ELSE EXIT;
           */

    end;

    var
        IndentHeader: Record "Indent Header";
        IndentLine: Record "Indent Line";
        Item: Record Item;
        NonStockItem: Record "Non-Stock Item";
        UnitofMeasure: Record "Unit of Measure";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        UserLocation: Record "User Location";
        Permissions: Codeunit Permissions1;
        UserAccess: Integer;
        UserSetup: Record "User Setup";
        Counter: Integer;
        i: Integer;
        ItemForm: Page "Item List";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        ReqLine: Record "Requisition Line";
        IndentLine1: Record "Indent Line";
        blnInserted: Boolean;
        Text0001: Label 'Item is Blocked for Indent insertion .';
        Text002: Label 'Please Select Group Code in Header.';
        Text003: Label 'Please Select %1 Group Code Item.';

    procedure GetTotalPOQty(DocNo: Code[20]; ItemNo: Code[20]; Qty: Decimal; LineNo: Integer; ShowOnly: Boolean; OrgEntry: Boolean): Decimal
    var
        TotalPOQty: Decimal;
        RecIndentLine: Record "Indent Line";
        OrgQty: Decimal;
        TotalRecdQty: Decimal;
        NewTotalPOQty: Decimal;
        RecIH: Record "Indent Header";
        rIndentLine: Record "Indent Line";
    begin
        //MSBS.Rao Start 181214
        TotalPOQty := 0;
        TotalRecdQty := 0;
        NewTotalPOQty := 0;
        //CALCFIELDS("Linked Qty","PO Qty");
        RecIndentLine.RESET;
        RecIndentLine.SETCURRENTKEY("No.");
        RecIndentLine.SETRANGE("Document No.", DocNo);
        RecIndentLine.SETRANGE("No.", ItemNo);
        RecIndentLine.SETRANGE("Orginal Entry", TRUE);
        IF RecIndentLine.FINDFIRST THEN
            OrgQty := RecIndentLine.Quantity;

        RecIndentLine.RESET;
        RecIndentLine.SETCURRENTKEY("No.");
        RecIndentLine.SETRANGE("Document No.", DocNo);
        // IF NOT ShowOnly THEN
        // RecIndentLine.SETFILTER("Line No.",'<>%1',LineNo);
        RecIndentLine.SETRANGE("No.", ItemNo);
        RecIndentLine.SETRANGE("Short Closed", FALSE);
        IF RecIndentLine.FINDFIRST THEN BEGIN
            REPEAT
                //  RecIndentLine.CALCFIELDS("PO Qty");
                //  TotalPOQty += RecIndentLine."PO Qty";
                RecIndentLine.CALCFIELDS("Actual PO Qty");
                TotalPOQty += RecIndentLine."Actual PO Qty";
            UNTIL RecIndentLine.NEXT = 0;
        END;
        RecIndentLine.RESET;
        RecIndentLine.SETCURRENTKEY("No.");
        RecIndentLine.SETRANGE("Document No.", DocNo);
        RecIndentLine.SETRANGE("No.", ItemNo);
        RecIndentLine.SETRANGE("Short Closed", FALSE);
        IF RecIndentLine.FINDFIRST THEN BEGIN
            REPEAT
                //  RecIndentLine.CALCFIELDS("PO Qty");
                //  NewTotalPOQty += RecIndentLine."PO Qty";
                RecIndentLine.CALCFIELDS("Actual PO Qty");
                NewTotalPOQty += RecIndentLine."Actual PO Qty";
            UNTIL RecIndentLine.NEXT = 0;
        END;

        RecIndentLine.RESET;
        RecIndentLine.SETCURRENTKEY("No.");
        RecIndentLine.SETRANGE("Document No.", DocNo);
        RecIndentLine.SETRANGE("No.", ItemNo);
        IF RecIndentLine.FINDFIRST THEN BEGIN
            REPEAT
                RecIndentLine.CALCFIELDS("Received Qty");
                TotalRecdQty += RecIndentLine."Received Qty";
            UNTIL RecIndentLine.NEXT = 0;
        END;

        EXIT(OrgQty - TotalPOQty);
        /*
        //IF "Document No." = 'INTHSK\B\1415\0901' THEN
        //MESSAGE('%1=%2=%3',OrgQty,NewTotalPOQty,TotalRecdQty);
        //IF Qty > (OrgQty-(NewTotalPOQty+TotalRecdQty)) THEN
          //ERROR('hi');
        IF NOT ShowOnly THEN BEGIN
        {//IF Qty > TotalPOQty THEN
          IF OrgEntry AND (TotalPOQty = 0 )THEN BEGIN
            IF OrgQty = Qty THEN BEGIN
              EXIT(OrgQty);
            //MESSAGE('hi');
            END ELSE BEGIN
              EXIT(OrgQty-Qty);
             //MESSAGE('hi2');
            END;
        
          END ELSE BEGIN}
           // MESSAGE('hi3');
            IF (OrgQty-(TotalPOQty+TotalRecdQty+Qty))<=0 THEN
            BEGIN
              //MESSAGE('1 inside function retuns 0');
              EXIT(0)
            END ELSE
            EXIT(OrgQty-(TotalPOQty+TotalRecdQty+Qty));
          //END;
        END ELSE
          IF (OrgQty-(TotalPOQty+TotalRecdQty)) <=0 THEN
          BEGIN
            //MESSAGE('1 inside function retuns 0');
            EXIT(0)
          END ELSE
          EXIT(OrgQty-(TotalPOQty+TotalRecdQty));
        //MESSAGE('hi%1=%2=%3',TotalPOQty,TotalRecdQty,OrgQty-(TotalPOQty+TotalRecdQty));
        //ELSE
          //EXIT(OrgQty-TotalPOQty);
        //MSBS.Rao Stop 181214
        */

    end;

    procedure CheckDescription()
    begin
        IF Item.GET("No.") THEN BEGIN
            IF (Type IN [1]) AND (NOT Item."Inventory Value Zero") THEN
                IF xRec."Description 2" <> "Description 2" THEN
                    ERROR('Description2 Cannot be Change');

            IF (Type IN [1]) AND (NOT Item."Inventory Value Zero") THEN
                IF xRec.Description <> Description THEN
                    ERROR('Description Cannot be Change');

            IF (Type IN [1]) AND (NOT Item."Inventory Value Zero") THEN
                IF xRec."Unit of Measurement" <> "Unit of Measurement" THEN
                    ERROR('Description Cannot be Change')

        END;
    end;

    procedure GetTotalPOQtyKS(DocNo: Code[20]; ItemNo: Code[20]; Qty: Decimal; LineNo: Integer; ShowOnly: Boolean; OrgEntry: Boolean; PONo: Code[20]; POLnNo: Integer): Decimal
    var
        TotalPOQty: Decimal;
        RecIndentLine: Record "Indent Line";
        OrgQty: Decimal;
        TotalRecdQty: Decimal;
        NewTotalPOQty: Decimal;
        RecIH: Record "Indent Header";
        rIndentLine: Record "Indent Line";
    begin
        //MSBS.Rao Start 181214
        TotalPOQty := 0;
        TotalRecdQty := 0;
        NewTotalPOQty := 0;
        //CALCFIELDS("Linked Qty","PO Qty");
        RecIndentLine.RESET;
        RecIndentLine.SETCURRENTKEY("No.");
        RecIndentLine.SETRANGE("Document No.", DocNo);
        RecIndentLine.SETRANGE("No.", ItemNo);
        RecIndentLine.SETRANGE("Orginal Entry", TRUE);
        IF RecIndentLine.FINDFIRST THEN
            OrgQty := RecIndentLine.Quantity;

        RecIndentLine.RESET;
        RecIndentLine.SETCURRENTKEY("No.");
        RecIndentLine.SETRANGE("Document No.", DocNo);
        IF NOT ShowOnly THEN
            RecIndentLine.SETFILTER("Line No.", '<>%1', LineNo);
        RecIndentLine.SETRANGE("No.", ItemNo);
        RecIndentLine.SETRANGE("Short Closed", FALSE);
        // RecIndentLine.SETFILTER("Order No.",'<>%1',PONo);
        IF RecIndentLine.FIND('+') THEN BEGIN
            REPEAT
                IF (RecIndentLine."Order No." <> PONo) AND (RecIndentLine."Line No." <> POLnNo) THEN BEGIN
                    RecIndentLine.CALCFIELDS("PO Qty");
                    TotalPOQty += RecIndentLine."PO Qty";
                END;
            UNTIL RecIndentLine.NEXT = 0;
        END;
        RecIndentLine.RESET;
        RecIndentLine.SETCURRENTKEY("No.");
        RecIndentLine.SETRANGE("Document No.", DocNo);
        RecIndentLine.SETRANGE("No.", ItemNo);
        RecIndentLine.SETRANGE("Short Closed", FALSE);
        IF RecIndentLine.FINDFIRST THEN BEGIN
            REPEAT
                RecIndentLine.CALCFIELDS("PO Qty");
                NewTotalPOQty += RecIndentLine."PO Qty";
            UNTIL RecIndentLine.NEXT = 0;
        END;

        RecIndentLine.RESET;
        RecIndentLine.SETCURRENTKEY("No.");
        RecIndentLine.SETRANGE("Document No.", DocNo);
        RecIndentLine.SETRANGE("No.", ItemNo);
        IF RecIndentLine.FINDFIRST THEN BEGIN
            REPEAT
                RecIndentLine.CALCFIELDS("Received Qty");
                TotalRecdQty += RecIndentLine."Received Qty";
            UNTIL RecIndentLine.NEXT = 0;
        END;

        //Keshav15042020
        IF NOT ShowOnly THEN BEGIN
            rIndentLine.RESET;
            rIndentLine.SETRANGE("Document No.", DocNo);
            rIndentLine.SETRANGE("No.", ItemNo);
            rIndentLine.SETRANGE("Orginal Entry", FALSE);
            rIndentLine.SETFILTER("Parent Line No", '<>%1', 0);
            IF rIndentLine.FIND('+') THEN BEGIN
                OrgQty := rIndentLine.Quantity;
            END;
        END;
        //Keshav15042020

        IF NOT ShowOnly THEN BEGIN
            IF (OrgQty - (TotalPOQty + TotalRecdQty + Qty)) <= 0 THEN BEGIN
                EXIT(0)
            END ELSE
                EXIT(OrgQty - (TotalPOQty + TotalRecdQty + Qty));
        END ELSE
            IF (OrgQty - (TotalPOQty + TotalRecdQty)) <= 0 THEN BEGIN
                EXIT(0)
            END ELSE
                EXIT(OrgQty - (TotalPOQty + TotalRecdQty));
    end;
}

