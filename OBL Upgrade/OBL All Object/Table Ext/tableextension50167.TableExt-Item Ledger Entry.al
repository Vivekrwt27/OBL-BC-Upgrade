tableextension 50167 tableextension50167 extends "Item Ledger Entry"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on "Description(Field 7)".

        field(50000; "Type Code"; Code[2])
        {
            Description = 'report s-16(68)';
        }
        field(50002; "Size Code"; Code[3])
        {
            Description = 'report s-16(68)';
        }
        field(50003; "Design Code"; Code[4])
        {
            Description = 'report closing stock valuation';
        }
        field(50004; "Color Code"; Code[4])
        {
            Description = 'report closing stock valuation';
        }
        field(50005; "Packing Code"; Code[2])
        {
        }
        field(50006; "Quality Code"; Code[1])
        {
            Description = 'report closing stock valuation';
        }
        field(50007; "Plant Code"; Code[10])
        {
            Description = 'report s-16(68)';
        }
        field(50008; "Main Location"; Code[20])
        {
            TableRelation = Location;
        }
        field(50009; InTransit; Boolean)
        {
        }
        field(50010; "Relational Location Code"; Code[20])
        {
            TableRelation = Location.Code WHERE("Main Location" = FILTER(''));
        }
        field(50011; "External Transfer"; Boolean)
        {
        }
        field(50012; "Qty in Sq.Mt."; Decimal)
        {
        }
        field(50013; "Qty In Carton"; Decimal)
        {
        }
        field(50014; "Category Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('CATG'));
        }
        field(50015; OK; Boolean)
        {
        }
        field(50016; "Production Plant Code"; Code[20])
        {
            TableRelation = Location.Code WHERE("Use As In-Transit" = FILTER(false));
        }
        field(50017; caa; Decimal)
        {
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual)" WHERE("Item Ledger Entry No." = FIELD("Entry No."),
                                                                          "Source Code" = FILTER(<> 'INVTADJMT')));
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
        }
        field(50060; "Output Date"; Date)
        {
            Description = 'TRI S.K. 21.06.10';
            Editable = true;
        }
        field(50061; "Group Code"; Code[2])
        {
            Description = 'TRI N.K 20.02.08';
            TableRelation = "Item Group";

            trigger OnValidate()
            begin
                /*//TRI LM 100308 start
                SalesLine1.RESET;
                SalesLine1.SETRANGE("Document Type","Document Type");
                SalesLine1.SETRANGE("Document No.","No.");
                IF SalesLine1.FIND('-') THEN
                 ERROR('You Cannot modify Group Code Because some sales line is associated with it');
                //TRI LM 100308 End
                */

            end;
        }
        field(50062; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
            Editable = true;
            MinValue = 0;
        }
        field(50063; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            Editable = true;
            MinValue = 0;
        }
        field(50064; "ILE Entry No. 3.7"; Integer)
        {
            Editable = false;
        }
        field(50065; "Old Variant Code"; Code[10])
        {
            Editable = false;
        }
        field(50067; "Capex No."; Code[20])
        {
            TableRelation = "Budget Master"."No.";
        }
        field(50068; "Inter Company"; Boolean)
        {
            Description = 'MS-PB';
        }
        field(50069; "IC Line No."; Integer)
        {
        }
        field(50070; "Prod. BOM No."; Code[20])
        {
        }
        field(60001; "Invoice No."; Code[20])
        {
            CalcFormula = Lookup("Value Entry"."Document No." WHERE("Item Ledger Entry No." = FIELD("Entry No."),
                                                                     "Invoiced Quantity" = FILTER(<> 0)));
            Description = 'TRI DG 280709';
            FieldClass = FlowField;
        }
        field(60002; "Qty in PCS."; Decimal)
        {
            Description = 'TRI DG 010510';
            Editable = false;
        }
        field(60010; "Direct Consumption Entries"; Boolean)
        {
            Description = 'TRI P.G 03.06.2010';
        }
        field(60011; "Depot. Prod Order"; Boolean)
        {
            Description = 'TRI S.R';
            Editable = false;
        }
        field(60012; ReProcess; Boolean)
        {
            Description = 'TRI S.C. 09.06.10';
        }
        field(60013; "Re Process Production Order"; Boolean)
        {
            Description = 'TRI S.K 21.06.10 Add New Field';
        }
        field(60014; "Work Shift Code"; Code[20])
        {
            Description = 'TRI S.K 21.06.10 Add New Field';
        }
        field(60015; "Original Prod. No"; Code[20])
        {
            Description = 'TRI S.K 21.06.10 Add New Field';
        }
        field(60016; "Inventory Posting Group"; Code[100])
        {
            CalcFormula = Lookup(Item."Inventory Posting Group" WHERE("No." = FIELD("Item No.")));
            Description = 'TRI S.K 21.06.10 Add New Field';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60017; "General Prod. Posting Group"; Code[10])
        {
            CalcFormula = Lookup(Item."Gen. Prod. Posting Group" WHERE("No." = FIELD("Item No.")));
            Description = 'TRI S.K 21.06.10 Add New Field';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60018; "Item Description"; Text[40])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Description = 'TRI S.K 21.06.10 Add New Field';
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
        }
        field(60019; "Item Description 2"; Text[40])
        {
            CalcFormula = Lookup(Item."Description 2" WHERE("No." = FIELD("Item No.")));
            Description = 'TRI S.K 21.06.10 Add New Field';
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
        }
        field(60020; "Import Document"; Boolean)
        {
            Description = 'TRI DG 010710';
        }
        field(60021; "Item Base Unit of Measure"; Code[10])
        {
            CalcFormula = Lookup(Item."Base Unit of Measure" WHERE("No." = FIELD("Item No.")));
            Description = 'TRI S.R';
            Editable = true;
            FieldClass = FlowField;
        }
        field(60022; "Routing Link Code"; Code[10])
        {
            Description = 'TRI VKG 27.09.10';
            TableRelation = "Routing Link";
        }
        field(60023; "Machine Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('MACHINE'));
        }
        field(60040; "End Use Item"; Boolean)
        {
        }
        field(60041; "Ref Code"; Code[20])
        {
            CalcFormula = Lookup(Item."Old Code" WHERE("No." = FIELD("Item No.")));
            Enabled = false;
            FieldClass = FlowField;
        }
        field(60042; "Temp Entry to Adjust"; Boolean)
        {
        }
        field(70000; "Mfg. Batch No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(90021; "Physical Journal Entry"; Boolean)
        {
        }
        field(90022; "Physical Journal Key"; Code[10])
        {
        }
        field(90023; "Morbi Batch No."; Code[10])
        {
        }
        field(90024; "Posting Datetime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {


        key(Key22; "Document No.", "Posting Date", "Document Type", "Document Line No.")
        {
        }
        key(Key23; "Item No.", Positive, "Variant Code", Open, "Location Code", "Posting Date")
        {
        }
        key(Key24; "Item No.", Open, "Variant Code", Positive, "Expiration Date", "Lot No.", "Serial No.", "Posting Date")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
        }
        key(Key25; "Item No.", "Posting Date", "Entry Type", "Location Code")
        {
            SumIndexFields = Quantity;
        }
        key(Key26; "Item No.", /* "Nature of Disposal", */ "Unit of Measure Code", "Entry Type")
        {
        }
        /* key(Key27; "Item No.", "Entry Type", "Plant Code", "Size Code")
        {
            SumIndexFields = "Qty in Sq.Mt.", "Qty In Carton";
        }
        key(Key28; "Item No.", "External Transfer", InTransit, "Entry Type", "Qty in Sq.Mt.", "Plant Code", "Size Code")
        {
            SumIndexFields = "Qty in Sq.Mt.", "Qty In Carton";
        } */
        key(Key29; "Entry Type", "Posting Date", "Item No.", Quantity, "Location Code")
        {
            SumIndexFields = Quantity;
        }
        key(Key30; "Source Type", "Source No.", "Entry Type", "Item No.", "Variant Code", "Posting Date")
        {
        }
        key(Key31; "Source No.", "Item No.", "Entry Type", "Source Type")
        {
        }
        /* key(Key32; "Production Plant Code", "Plant Code", "Type Code", "Size Code", "Packing Code", "Unit of Measure Code")
        {
        }
        key(Key33; "Production Plant Code", "Variant Code", "Item No.", "Location Code")
        {
            SumIndexFields = Quantity, "Qty in Sq.Mt.", "Qty In Carton";
        } */
        key(Key34; "Posting Date", "Item No.", "Entry Type")
        {
        }
        /* key(Key35; "Plant Code", "Size Code", "Packing Code", "Posting Date")
        {
        }
        key(Key36; "External Transfer", InTransit, "Plant Code", "Entry Type", "Posting Date", "Qty in Sq.Mt.", "Document Type", "Relational Location Code", "Category Code")
        {
            SumIndexFields = "Qty in Sq.Mt.", "Qty In Carton", Quantity;
        } */
        key(Key37; "Type Code", "Category Code", "Size Code", "Design Code", "Color Code", "Packing Code", "Plant Code")
        {
        }
        /* key(Key38; "Production Plant Code", "Size Code", "Packing Code", "Posting Date", "Plant Code", "Location Code", "Entry Type", ReProcess, "Re Process Production Order", "External Transfer")
        {
            SumIndexFields = "Qty In Carton", "Qty in Sq.Mt.", Quantity;
        } */
        key(Key39; "Location Code", "Item No.", "Variant Code", Open, Positive, "Posting Date")
        {
            //SumIndexFields = "Qty in Sq.Mt.", "Qty In Carton";
        }
        key(Key40; "Prod. Order Comp. Line No.", "Entry Type")
        {
        }
        /* key(Key41; InTransit, "Item No.")
        {
            SumIndexFields = Quantity;
        } */
        /* key(Key42; "Production Plant Code", "Posting Date", "Item No.")
        {
        } */
    }

    var
        Loc: Record Location;
}

