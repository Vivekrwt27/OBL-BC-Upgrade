report 50151 "BAD Inventory"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\BADInventory.rdl';
    Caption = 'BAD Inventory';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; 27)
        {
            DataItemTableView = SORTING("No.")
                                WHERE(Retained = FILTER(false),
                                      "Replenishment System" = FILTER("Prod. Order"),
                                      "Production BOM No." = FILTER(<> ''));
            RequestFilterFields = "No.";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(TypeCode_Item; Item."Type Code")
            {
            }
            column(Description_Item; Item.Description)
            {
            }
            column(No_Item; Item."No.")
            {
            }
            column(Inventory_Item; Item.Inventory)
            {
            }
            column(PlantCode_Item; Item."Plant Code")
            {
            }
            column(Location_Name; DimensionValue.Name)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "Plant Code" <> '' THEN BEGIN
                    DimensionValue.RESET;
                    DimensionValue.SETRANGE("Plant Code", "Plant Code");
                    IF DimensionValue.FINDFIRST THEN;
                END;
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
        DimensionValue: Record "Dimension Value";
}

