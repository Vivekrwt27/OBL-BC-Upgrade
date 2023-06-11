page 50089 "Item List PG"
{
    // //-- 1. Tri56.1 PG 15112006 -- New Field Control Added "Item Category Desc." - Desc. Req. In Item List
    // //-- 2. Tri56.1 PG 15112006 -- New Field Control Added "Product Group Desc." - Desc. Req. In Item List
    // //-- 3. CalcField Property Of Form Changed To "Item Category Desc.,Product Group Desc."

    Caption = 'Item List';
    Editable = false;
    PageType = Card;
    SourceTable = Item;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("SalesQty."; Rec."SalesQty.")
                {
                    ApplicationArea = All;
                }
                field("ProductionQty."; Rec."ProductionQty.")
                {
                    ApplicationArea = All;
                }
                field(ASP; ASP)
                {
                    Caption = 'ASP';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Purchases (Qty.)"; Rec."Purchases (Qty.)")
                {
                    ApplicationArea = All;
                }
                field("Positive Adjmt. (Qty.)"; Rec."Positive Adjmt. (Qty.)")
                {
                    ApplicationArea = All;
                }
                field("Negative Adjmt. (Qty.)"; Rec."Negative Adjmt. (Qty.)")
                {
                    ApplicationArea = All;
                }
                field("Sales (Qty.)"; Rec."Sales (Qty.)")
                {
                    ApplicationArea = All;
                }
                field("Ex-Factory Amount"; Rec."Ex-Factory Amount")
                {
                    ApplicationArea = All;
                }
                field("Excise Amount"; Rec."Excise Amount")
                {
                    ApplicationArea = All;
                }
                field(MRP; MRP)
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Item Category Desc."; Rec."Item Category Desc.")
                {
                    ApplicationArea = All;
                }
                field("Product Group Desc."; Rec."Product Group Desc.")
                {
                    ApplicationArea = All;
                }
                field("Item Classification"; Rec."Item Classification")
                {
                    ApplicationArea = All;
                }
                field("Net Change"; Rec."Net Change")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                //16225 field N/F
                /*field("Product Group Code"; "Product Group Code")
                {
                    ApplicationArea = All;
                }*/
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                }
                field("Type Code Desc."; Rec."Type Code Desc.")
                {
                    ApplicationArea = All;
                }
                field("Type Category Code Desc."; Rec."Type Category Code Desc.")
                {
                    ApplicationArea = All;
                }
                field("Size Code Desc."; Rec."Size Code Desc.")
                {
                    ApplicationArea = All;
                }
                field("Design Code Desc."; Rec."Design Code Desc.")
                {
                    ApplicationArea = All;
                }
                field("Color Code Desc."; Rec."Color Code Desc.")
                {
                    ApplicationArea = All;
                }
                field("Packing Code Desc."; Rec."Packing Code Desc.")
                {
                    ApplicationArea = All;
                }
                field("Quality Code Desc."; Rec."Quality Code Desc.")
                {
                    ApplicationArea = All;
                }
                field("Plant Code Desc."; Rec."Plant Code Desc.")
                {
                    ApplicationArea = All;
                }
                field("Type Code"; Rec."Type Code")
                {
                    ApplicationArea = All;
                }
                field("Type Catogery Code"; Rec."Type Catogery Code")
                {
                    ApplicationArea = All;
                }
                field("Size Code"; Rec."Size Code")
                {
                    ApplicationArea = All;
                }
                field("Design Code"; Rec."Design Code")
                {
                    ApplicationArea = All;
                }
                field("Color Code"; Rec."Color Code")
                {
                    ApplicationArea = All;
                }
                field("Packing Code"; Rec."Packing Code")
                {
                    ApplicationArea = All;
                }
                field("Quality Code"; Rec."Quality Code")
                {
                    ApplicationArea = All;
                }
                field("Plant Code"; Rec."Plant Code")
                {
                    ApplicationArea = All;
                }
                field("Created From Nonstock Item"; Rec."Created From Nonstock Item")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                //16225 field N/F
                /*field("Capital Item"; "Capital Item")
                {
                    ApplicationArea = All;
                }*/
                field("Substitutes Exist"; Rec."Substitutes Exist")
                {
                    ApplicationArea = All;
                }
                field("Stockkeeping Unit Exists"; Rec."Stockkeeping Unit Exists")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    ApplicationArea = All;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Shelf No."; Rec."Shelf No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Costing Method"; Rec."Costing Method")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(AverageCostLCY; AverageCostLCY)
                {
                    AutoFormatType = 2;
                    Caption = 'Average Cost (LCY)';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Standard Cost"; Rec."Standard Cost")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Last Direct Cost"; Rec."Last Direct Cost")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Price/Profit Calculation"; Rec."Price/Profit Calculation")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Profit %"; Rec."Profit %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item Disc. Group"; Rec."Item Disc. Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Tariff No."; Rec."Tariff No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                }
                field("Overhead Rate"; Rec."Overhead Rate")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Item")
            {
                Caption = '&Item';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Item Card";
                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter");
                    ApplicationArea = All;

                    ShortCutKey = 'Shift+F7';
                }
                action("Stockkeepin&g Units")
                {
                    Caption = 'Stockkeepin&g Units';
                    RunObject = Page "Stockkeeping Unit List";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    action("Ledger E&ntries")
                    {
                        Caption = 'Ledger E&ntries';
                        RunObject = Page "Item Ledger Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        ShortCutKey = 'Ctrl+F7';
                        ApplicationArea = All;
                    }
                    action("&Reservation Entries")
                    {
                        Caption = '&Reservation Entries';
                        Image = ReservationLedger;
                        RunObject = Page "Reservation Entries";
                        RunPageLink = "Reservation Status" = CONST(Reservation), "Item No." = FIELD("No.");
                        RunPageView = SORTING("Reservation Status", "Item No.", "Variant Code", "Location Code");
                        ApplicationArea = All;
                    }
                    action("&Phys. Inventory Ledger Entries")
                    {
                        Caption = '&Phys. Inventory Ledger Entries';
                        Image = PhysicalInventoryLedger;
                        RunObject = Page "Phys. Inventory Ledger Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        ApplicationArea = All;
                    }
                    action("&Value Entries")
                    {
                        Caption = '&Value Entries';
                        Image = ValueLedger;
                        RunObject = Page "Value Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        ApplicationArea = All;
                    }
                    action("Item &Tracking Entries")
                    {
                        Caption = 'Item &Tracking Entries';
                        Image = ItemTrackingLedger;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            ItemTrackingMgt: Codeunit "Item Tracking Management";
                        begin
                            //16225 Funcation N/F ItemTrackingMgt.CallItemTrackingEntryForm(0, '', rec."No.", '', '', '', '');
                        end;
                    }
                }
                group(AStatistics) //16225 Statistics Replace Statistics
                {
                    Caption = 'Statistics';
                    action(Statistics)
                    {
                        Caption = 'Statistics';
                        Image = Statistics;
                        Promoted = true;
                        PromotedCategory = Process;
                        ShortCutKey = 'F7';
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            ItemStatistics: Page "Item Statistics";
                        begin
                            ItemStatistics.SetItem(Rec);
                            ItemStatistics.RUNMODAL;
                        end;
                    }
                    action("Entry Statistics")
                    {
                        Caption = 'Entry Statistics';
                        RunObject = Page "Item Entry Statistics";
                        RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                    action("T&urnover")
                    {
                        Caption = 'T&urnover';
                        RunObject = Page "Item Turnover";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                }
                action("Items b&y Location")
                {
                    Caption = 'Items b&y Location';
                    Image = ItemAvailbyLoc;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ItemsByLocation: Page "Items by Location";
                    begin
                        ItemsByLocation.SETRECORD(Rec);
                        ItemsByLocation.RUN;
                    end;
                }
                group("&Item Availability by")
                {
                    Caption = '&Item Availability by';
                    action(Period)
                    {
                        Caption = 'Period';
                        RunObject = Page "Item Availability by Periods";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        RunObject = Page "Item Availability by Variant";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        RunObject = Page "Item Availability by Location";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                }
                action("&Bin Contents")
                {
                    Caption = '&Bin Contents';
                    Image = BinContent;
                    RunObject = Page "Item Bin Contents";
                    RunPageLink = "Item No." = FIELD("No."), "Unit of Measure Code" = FIELD("Base Unit of Measure");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Item), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    action("Dimensions-Single")
                    {
                        Caption = 'Dimensions-Single';
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(27), "No." = FIELD("No.");
                        ShortCutKey = 'Shift+Ctrl+D';
                        ApplicationArea = All;
                    }
                    action("Dimensions-&Multiple")
                    {
                        Caption = 'Dimensions-&Multiple';
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            Item: Record Item;
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SETSELECTIONFILTER(Item);
                            //16225 Funcation N/F  DefaultDimMultiple.SetMultiItem(Item);
                            DefaultDimMultiple.RUNMODAL;
                        end;
                    }
                }
                action("&Picture")
                {
                    Caption = '&Picture';
                    RunObject = Page "Item Picture";
                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                    ApplicationArea = All;
                }
                separator("-")
                {
                }
                action("&Units of Measure")
                {
                    Caption = '&Units of Measure';
                    RunObject = Page "Item Units of Measure";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Va&riants")
                {
                    Caption = 'Va&riants';
                    RunObject = Page "Item Variants";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                /*   action("Cross Re&ferences") //16225 Page Remove In BC
                   {
                       Caption = 'Cross Re&ferences';
                       RunObject = Page 5721;
                                       RunPageLink = "Item No."=FIELD("No.");
                   }*/
                action("Substituti&ons")
                {
                    Caption = 'Substituti&ons';
                    RunObject = Page "Item Substitution Entry";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Nonstoc&k Items")
                {
                    Caption = 'Nonstoc&k Items';
                    RunObject = Page "Catalog Item List";
                    ApplicationArea = All;
                }
                action(Translations)
                {
                    Caption = 'Translations';
                    RunObject = Page "Item Translations";
                    RunPageLink = "Item No." = FIELD("No."), "Variant Code" = CONST();
                    ApplicationArea = All;
                }
                action("E&xtended Texts")
                {
                    Caption = 'E&xtended Texts';
                    RunObject = Page "Extended Text List";
                    RunPageLink = "Table Name" = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
                    ApplicationArea = All;
                }
                group("Assembly &List")
                {
                    Caption = 'Assembly &List';
                    action("Bill of Materials")
                    {
                        Caption = 'Bill of Materials';
                        RunObject = Page "Assembly BOM";
                        RunPageLink = "Parent Item No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action("Where-Used List")
                    {
                        Caption = 'Where-Used List';
                        RunObject = Page "Where-Used List";
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                        RunPageView = SORTING(Type, "No.");
                        ApplicationArea = All;
                    }
                    action("Calc. Stan&dard Cost")
                    {
                        Caption = 'Calc. Stan&dard Cost';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            CalculateStdCost.CalcItem(Rec."No.", TRUE);
                        end;
                    }
                }
                group("Manuf&acturing")
                {
                    Caption = 'Manuf&acturing';
                    action("Where-Used")
                    {
                        Caption = 'Where-Used';
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            ProdBOMWhereUsed: Page "Prod. BOM Where-Used";
                        begin
                            ProdBOMWhereUsed.SetItem(Rec, WORKDATE);
                            ProdBOMWhereUsed.RUNMODAL;
                        end;
                    }
                    /*action("Calc. Stan&dard Cost") //16225 Duplicate Allready This Action
                    {
                        Caption = 'Calc. Stan&dard Cost';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            CalculateStdCost.CalcItem("No.", FALSE);
                        end;
                    }*/
                }
                action("Ser&vice Items")
                {
                    Caption = 'Ser&vice Items';
                    RunObject = Page "Service Items";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                group("Troubles&hootings")
                {
                    Caption = 'Troubles&hooting';
                    action("Troubleshooting &Setup")
                    {
                        Caption = 'Troubleshooting &Setup';
                        Image = Troubleshoot;
                        RunObject = Page "Troubleshooting Setup";
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action("Troubles&hooting")
                    {
                        Caption = 'Troubles&hooting';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            TblshtgHeader.ShowForItem(Rec);
                        end;
                    }
                }
                group("R&esource")
                {
                    Caption = 'R&esource';
                    action("Resource &Skills")
                    {
                        Caption = 'Resource &Skills';
                        RunObject = Page "Resource Skills";
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action("Skilled R&esources")
                    {
                        Caption = 'Skilled R&esources';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            CLEAR(SkilledResourceList);
                            SkilledResourceList.InitializeForItem(Rec);
                            SkilledResourceList.RUNMODAL;
                        end;
                    }
                }
                action(Identifiers)
                {
                    Caption = 'Identifiers';
                    RunObject = Page "Item Identifiers";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.", "Variant Code", "Unit of Measure Code");
                    ApplicationArea = All;
                }
            }
            group("S&ales")
            {
                Caption = 'S&ales';
                action(SPrices)//16225 Prices Replace SPrices
                {
                    Caption = 'Prices';
                    Image = ResourcePrice;
                    RunObject = Page "Sales Prices";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action("SLine Discounts")//16225 "Line Discounts" Replace "SLine Discounts"
                {
                    Caption = 'Line Discounts';
                    RunObject = Page "Sales Line Discounts";
                    RunPageLink = "Type" = CONST(Item), "Code" = FIELD("No.");
                    RunPageView = SORTING(Type, Code);
                    ApplicationArea = All;
                }
                action(SOrders)
                {
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Sales Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
                action("Returns Orders")
                {
                    Caption = 'Returns Orders';
                    RunObject = Page "Sales Return Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
            }
            group("&Purchases")
            {
                Caption = '&Purchases';
                action("Ven&dors")
                {
                    Caption = 'Ven&dors';
                    RunObject = Page "Item Vendor Catalog";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action(Prices)
                {
                    Caption = 'Prices';
                    Image = ResourcePrice;
                    RunObject = Page "Purchase Prices";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action("Line Discounts")
                {
                    Caption = 'Line Discounts';
                    RunObject = Page "Purchase Line Discounts";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action(Orders)
                {
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Purchase Orders";
                    RunPageLink = "Type" = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Type", "No.");
                    ApplicationArea = All;
                }
                action("Return Orders")
                {
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Purchase Return Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Create Stockkeeping Unit")
                {
                    Caption = '&Create Stockkeeping Unit';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Item: Record Item;
                    begin
                        Item.SETRANGE("No.", Rec."No.");
                        REPORT.RUNMODAL(REPORT::"Create Stockkeeping Unit", TRUE, FALSE, Item);
                    end;
                }
                action("C&alculate Counting Period")
                {
                    Caption = 'C&alculate Counting Period';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PhysInvtCountMgt: Codeunit "Phys. Invt. Count.-Management";
                    begin
                        PhysInvtCountMgt.UpdateItemPhysInvtCount(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ItemCostMgt.CalculateAverageCost(Rec, AverageCostLCY, AverageCostACY);
        MRP := 0;
        ASP := 0;                                                                    //Anurag 050407
        SalesPrice.RESET;
        SalesPrice.SETCURRENTKEY("Sales Type", "Item No.", "Starting Date");
        SalesPrice.SETRANGE("Sales Type", SalesPrice."Sales Type"::"Customer Price Group");
        SalesPrice.SETRANGE("Item No.", Rec."No.");
        SalesPrice.SETFILTER("Sales Code", '01..99');
        SalesPrice.SETRANGE("Starting Date", 0D, TODAY);
        SalesPrice.SETRANGE("Unit of Measure Code", 'SQ.MT');
        IF SalesPrice.FIND('+') THEN
            //16225  MRP := SalesPrice."MRP Price";

            IF Rec."SalesQty." <> 0 THEN                                                     //Anurag 050407
                ASP := (Rec."Ex-Factory Amount" + Rec."Excise Amount") / ABS(Rec."SalesQty.");           //Anurag 050407
    end;

    var
        TblshtgHeader: Record "Troubleshooting Header";
        ItemCostMgt: Codeunit ItemCostManagement;
        CalculateStdCost: Codeunit "Calculate Standard Cost";
        AverageCostLCY: Decimal;
        AverageCostACY: Decimal;
        MRP: Decimal;
        SalesPrice: Record "Sales Price";
        ASP: Decimal;
        SkilledResourceList: Page "Skilled Resource List";

    procedure GetSelectionFilter(): Code[80]
    var
        Item: Record Item;
        FirstItem: Code[30];
        LastItem: Code[30];
        SelectionFilter: Code[250];
        ItemCount: Integer;
        More: Boolean;
    begin
        CurrPage.SETSELECTIONFILTER(Item);
        ItemCount := Item.COUNT;
        IF ItemCount > 0 THEN BEGIN
            Item.FIND('-');
            WHILE ItemCount > 0 DO BEGIN
                ItemCount := ItemCount - 1;
                Item.MARKEDONLY(FALSE);
                FirstItem := Item."No.";
                LastItem := FirstItem;
                More := (ItemCount > 0);
                WHILE More DO
                    IF Item.NEXT = 0 THEN
                        More := FALSE
                    ELSE
                        IF NOT Item.MARK THEN
                            More := FALSE
                        ELSE BEGIN
                            LastItem := Item."No.";
                            ItemCount := ItemCount - 1;
                            IF ItemCount = 0 THEN
                                More := FALSE;
                        END;
                IF SelectionFilter <> '' THEN
                    SelectionFilter := SelectionFilter + '|';
                IF FirstItem = LastItem THEN
                    SelectionFilter := SelectionFilter + FirstItem
                ELSE
                    SelectionFilter := SelectionFilter + FirstItem + '..' + LastItem;
                IF ItemCount > 0 THEN BEGIN
                    Item.MARKEDONLY(TRUE);
                    Item.NEXT;
                END;
            END;
        END;
        EXIT(SelectionFilter);
    end;
}

