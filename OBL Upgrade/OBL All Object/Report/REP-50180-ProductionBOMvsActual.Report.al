report 50180 "Production BOM vs Actual"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\ProductionBOMvsActual.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Production Order"; 5405)
        {
            DataItemTableView = SORTING(Status, "No.");
            RequestFilterFields = Status, "No.", "Source Type", "Source No.";
            column(Description_ProductionOrder; "Production Order".Description)
            {
            }
            column(Status_ProductionOrder; "Production Order".Status)
            {
            }
            column(No_ProductionOrder; "Production Order"."No.")
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(totalqnt; summry."Total Available Quantity")
            {
            }
            column(ProdOrderFilter; ProdOrderFilter)
            {
            }
            column(BaseUOM_ProductionOrder; "Production Order"."Base UOM")
            {
            }
            column(LocationCode_ProductionOrder; "Production Order"."Location Code")
            {
            }
            column(EndingDate_ProductionOrder; "Production Order"."Ending Date")
            {
            }
            column(StartingDate_ProductionOrder; "Production Order"."Starting Date")
            {
            }
            column(ProductionOrderSourcNo; "Production Order"."Source No.")
            {
            }
            column(Description2_ProductionOrder; "Production Order"."Description 2")
            {
            }
            column(Quantity_ProductionOrder; "Production Order".Quantity)
            {
            }
            column(Description_ProductionOrder1; "Production Order".Description)
            {
            }
            column(GenProdPostingGroup_ProductionOrder; items."Inventory Posting Group")
            {
            }
            dataitem("Prod. Order Line"; 5406)
            {
                DataItemLink = Status = FIELD(Status),
                               "Prod. Order No." = FIELD("No.");
                DataItemTableView = SORTING(Status, "Prod. Order No.", "Line No.")
                                    WHERE("Planning Level Code" = CONST(0));
                column(ItemNoProdOrderLine; "Prod. Order Line"."Item No.")
                {
                }
                column(s; "Prod. Order Line"."Cost Amount")
                {
                }
                column(ProdOrderNo_ProdOrderLine; "Prod. Order Line"."Prod. Order No.")
                {
                }
                column(discription; "Prod. Order Line".Description)
                {
                }
                column(finish_qnty; "Prod. Order Line"."Finished Quantity")
                {
                }
                column(reaminig_qnty; "Prod. Order Line"."Remaining Qty. (Base)")
                {
                }
                column(LineNo_ProdOrderLine; "Prod. Order Line"."Line No.")
                {
                }
                column(Quantity_ProdOrderLine; "Prod. Order Line"."Finished Quantity")
                {
                }
                column(UnitofMeasureCode_ProdOrderLine; "Prod. Order Line"."Unit of Measure Code")
                {
                }
                dataitem("Prod. Order Component"; 5407)
                {
                    DataItemLink = Status = FIELD(Status),
                                   "Prod. Order No." = FIELD("Prod. Order No."),
                                   "Prod. Order Line No." = FIELD("Line No.");
                    DataItemTableView = SORTING(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.");
                    column(UnitCost_ProdOrderComponent; "Prod. Order Component"."Unit Cost")
                    {
                    }
                    column(CostAmount_ProdOrderComponent; "Prod. Order Component"."Cost Amount")
                    {
                    }
                    column(Quantity_ProdOrderComponent; "Prod. Order Component".Quantity)
                    {
                    }
                    column(ExpectedQuantity_ProdOrderComponent; "Prod. Order Component"."Expected Quantity")
                    {
                    }
                    column(Scrap; "Prod. Order Component"."Scrap %")
                    {
                    }
                    column(Description_ProdOrderComponent; "Prod. Order Component".Description)
                    {
                    }
                    column(ItemNo_ProdOrderComponent; "Prod. Order Component"."Item No.")
                    {
                    }
                    column(RoutingLinkCode_ProdOrderComponent; "Prod. Order Component"."Routing Link Code")
                    {
                    }
                    column(ProdOrderNo_ProdOrderComponent; "Prod. Order Component"."Prod. Order No.")
                    {
                    }
                    column(ActConsumptionQty_ProdOrderComponent; "Prod. Order Component"."Act. Consumption (Qty)")
                    {
                    }
                    column(LineType; LineType)
                    {
                    }
                    column(BOMQty; BOMQty)
                    {
                    }
                    column(BOMNo; BOMNo)
                    {
                    }
                    column(ParentBOM; ParentBOM)
                    {
                    }
                    column(ActualConsumptionQty; ActualConsumptionQty)
                    {
                    }
                    column(ExpectedcostatActualQty; ExpectedcostatActualQty)
                    {
                    }
                    column(ILECostAmountActual; ILE2."Cost Amount (Actual)")
                    {
                    }
                    column(ILEQuantity; ILE2.Quantity)
                    {
                    }
                    column(LineNo_ProdOrderComponent; "Prod. Order Component"."Line No.")
                    {
                    }
                    dataitem("Prod. Order Routing Line"; 5409)
                    {
                        DataItemLink = Status = FIELD(Status),
                                       "Prod. Order No." = FIELD("Prod. Order No."),
                                       "Routing Reference No." = FIELD("Line No.");
                        DataItemTableView = SORTING(Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Operation No.");
                        column(Type_ProdOrderRoutingLine; "Prod. Order Routing Line".Type)
                        {
                        }
                        column(OperationNo_ProdOrderRoutingLine; "Prod. Order Routing Line"."Operation No.")
                        {
                        }
                        column(No_ProdOrderRoutingLine; "Prod. Order Routing Line"."No.")
                        {
                        }
                        column(Description_ProdOrderRoutingLine; "Prod. Order Routing Line".Description)
                        {
                        }
                        column(InputQuantity_ProdOrderRoutingLine; "Prod. Order Routing Line"."Input Quantity")
                        {
                        }
                        column(ExpectedOperationCostAmt_ProdOrderRoutingLine; "Prod. Order Routing Line"."Expected Operation Cost Amt.")
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CREATETOTALS("Expected Operation Cost Amt.");
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        ILE.RESET;
                        ILE.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.", "Entry Type", "Prod. Order Comp. Line No.");
                        ILE.SETRANGE("Order Type", ILE."Order Type"::Production);
                        ILE.SETRANGE("Order No.", "Prod. Order No.");
                        ILE.SETRANGE("Order Line No.", "Prod. Order Line No.");
                        ILE.SETRANGE("Entry Type", ILE."Entry Type"::Consumption);
                        ILE.SETRANGE("Item No.", "Item No.");
                        //ILE2.SETRANGE("Prod. Order Comp. Line No.","Line No.");
                        ILE.SETFILTER(ILE."Item Category Code", '%1|%2|%3|%4', 'M001', 'D001', 'H001', 'T001');
                        IF ILE.FINDFIRST THEN
                            CurrReport.SKIP;

                        BOMQty := "Prod. Order Component"."Original Quantity  Per";
                        /*
                        // Parent BOM
                        ProdOrderLine.GET(Status,"Prod. Order No.","Prod. Order Line No.");
                        ProductionBOMLine.RESET;
                        ProductionBOMLine.SETRANGE("Production BOM No.",ProdOrderLine."Item No.");
                        ProductionBOMLine.SETRANGE("Version Code",'');
                        ProductionBOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
                        ProductionBOMLine.SETRANGE("No.","Item No.");
                        IF ProductionBOMLine.FINDFIRST THEN BEGIN
                          ParentBOM := ProductionBOMLine."Production BOM No.";
                          LineType := 'In-BOM Items';
                        END ELSE BEGIN
                          CLEAR(ParentBOM);
                          CLEAR(LineType);
                          BOMNo := '';
                          BOMQty := 0;
                          LineType := '';
                        END;
                        
                        // Child BOM
                        ProductionBOMLine.RESET;
                        ProductionBOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
                        ProductionBOMLine.SETRANGE("No.","Item No.");
                        ProductionBOMLine.SETRANGE("Version Code",'');
                        IF ProductionBOMLine.FINDSET THEN REPEAT
                          ProductionBOMLine2.RESET;
                          ProductionBOMLine2.SETRANGE("Production BOM No.",ProdOrderLine."Item No.");
                          ProductionBOMLine2.SETRANGE("Version Code",'');
                          ProductionBOMLine2.SETRANGE(Type, ProductionBOMLine2.Type::"Production BOM");
                          ProductionBOMLine2.SETRANGE("No.",ProductionBOMLine."Production BOM No.");
                          IF ProductionBOMLine2.FINDFIRST THEN BEGIN
                            BOMNo := ProductionBOMLine2."No.";
                            BOMQty := ProductionBOMLine2.Quantity;
                            LineType := 'In-BOM Items';
                          END;
                        UNTIL ProductionBOMLine.NEXT=0;
                        */
                        items.RESET;
                        items.GET("Prod. Order Component"."Item No.");
                        //IF

                        ActualConsumptionQty := 0;
                        ExpectedcostatActualQty := 0;

                        ILE2.RESET;
                        ILE2.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.", "Entry Type", "Prod. Order Comp. Line No.");
                        ILE2.SETRANGE("Order Type", ILE2."Order Type"::Production);
                        ILE2.SETRANGE("Order No.", "Prod. Order No.");
                        ILE2.SETRANGE("Order Line No.", "Prod. Order Line No.");
                        ILE2.SETRANGE("Entry Type", ILE2."Entry Type"::Consumption);
                        ILE2.SETRANGE("Item No.", "Item No.");
                        //ILE2.SETRANGE("Location Code","Location Code");
                        ILE2.SETRANGE("Prod. Order Comp. Line No.", "Line No.");
                        IF ILE2.FINDFIRST THEN BEGIN
                            // ILE2.CALCSUMS(Quantity);
                            REPEAT
                                ILE2.CALCFIELDS("Cost Amount (Actual)");
                                ActualConsumptionQty += ABS(ILE2.Quantity);
                                ExpectedcostatActualQty += ABS(ILE2."Cost Amount (Actual)");
                            UNTIL ILE2.NEXT = 0;
                            ExpectedcostatActualQty := ExpectedcostatActualQty / ILE2.Quantity;
                        END;

                    end;

                    trigger OnPreDataItem()
                    begin
                        CurrReport.CREATETOTALS("Cost Amount");
                    end;
                }

                trigger OnPostDataItem()
                begin
                    //prodordline.SETRANGE("Prod. Order No.",PO."No.");
                    //prodordline.SETRANGE("Item No.",PO."Source No.");

                    TotalQty += prodordline."Cost Amount";
                end;
            }

            trigger OnAfterGetRecord()
            var
                FGItem: Record Item;
            begin
                FGItem.GET("Production Order"."Source No.");
                ParentBOM := FGItem."Production BOM No.";
            end;

            trigger OnPreDataItem()
            begin
                //ProdOrderFilter := GETFILTERS;
                //totalQyt :="Production Order".Quantity+1;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ProdOrderFilter: Text;
        itm: Record "Prod. Order Component";
        totalQyt: Integer;
        cost: Code[10];
        PO: Record "Production Order";
        TotalQty: Decimal;
        prodordline: Record "Prod. Order Line";
        summry: Record "Entry Summary";
        items: Record Item;
        unitcost: Decimal;
        ProductionBOMLine: Record "Production BOM Line";
        ProductionBOMLine2: Record "Production BOM Line";
        ProdOrderLine: Record "Prod. Order Line";
        BOMNo: Code[20];
        BOMQty: Decimal;
        ParentBOM: Code[20];
        LineType: Text[20];
        ILE: Record "Item Ledger Entry";
        ILE2: Record "Item Ledger Entry";
        ActualConsumptionQty: Decimal;
        ExpectedcostatActualQty: Decimal;

    local procedure CalculateConsumptionValue(): Decimal
    var
        ValueEntry: Record "Value Entry";
    begin
        ValueEntry.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.", "Item Ledger Entry Type", "Location Code", "Order Type", "Order No.", "Order Line No.", "Source Type", "Source No.", "Item No.");
        ValueEntry.SETRANGE("Order Type", ValueEntry."Order Type"::Production);
        ValueEntry.SETRANGE("Order No.", "Prod. Order Component"."Prod. Order No.");
        ValueEntry.SETRANGE("Order Line No.", "Prod. Order Component"."Prod. Order Line No.");
        ValueEntry.SETRANGE("Item No.", "Prod. Order Component"."Item No.");
        ValueEntry.CALCSUMS("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)");
        EXIT((ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)") / ValueEntry."Item Ledger Entry Quantity");
    end;
}

