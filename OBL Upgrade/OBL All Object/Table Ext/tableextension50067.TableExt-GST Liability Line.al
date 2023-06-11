tableextension 50067 tableextension50067 extends "GST Liability Line"
{
    fields
    {
        modify("Document No.")
        {
            Caption = 'Document No.';
        }
        modify("Document Line No.")
        {
            Caption = 'Document Line No.';
        }
        modify("Liability Document No.")
        {
            Caption = 'Liability Document No.';
        }
        modify("Liability Document Line No.")
        {
            Caption = 'Liability Document Line No.';
        }
        modify("Liability Date")
        {
            Caption = 'Liability Date';
        }
        modify("Parent Item No.")
        {
            Caption = 'Parent Item No.';
        }
        modify("Item No.")
        {
            Caption = 'Item No.';
        }
        /*  modify("Unit of Measure")
          {
              Caption = 'Unit of Measure';
          }*/ // 15578
        modify("Prod. BOM Quantity")
        {
            Caption = 'Prod. BOM Quantity';
        }
        modify("Quantity To Send")
        {
            Caption = 'Quantity To Send';
        }
        modify("Quantity (Base)")
        {
            Caption = 'Quantity (Base)';
        }
        modify("Quantity To Send (Base)")
        {
            Caption = 'Quantity To Send (Base)';
        }
        modify(Description)
        {
            Caption = 'Description';
        }
        modify(Position)
        {
            Caption = 'Position';
        }
        modify("Position 2")
        {
            Caption = 'Position 2';
        }
        modify("Position 3")
        {
            Caption = 'Position 3';
        }
        modify("Production Lead Time")
        {
            Caption = 'Production Lead Time';
        }
        modify("Routing Link Code")
        {
            Caption = 'Routing Link Code';
        }
        modify("Scrap %")
        {
            Caption = 'Scrap %';
        }
        modify("Variant Code")
        {
            Caption = 'Variant Code';
        }
        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        modify("Starting Date")
        {
            Caption = 'Starting Date';
        }
        modify("Ending Date")
        {
            Caption = 'Ending Date';
        }
        modify(Length)
        {
            Caption = 'Length';
        }
        modify(Width)
        {
            Caption = 'Width';
        }
        modify(Weight)
        {
            Caption = 'Weight';
        }
        modify(Depth)
        {
            Caption = 'Depth';
        }
        modify("Calculation Formula")
        {
            Caption = 'Calculation Formula';
            OptionCaption = ' ,Length,Length*Width,Length*Width*Depth,Weight';
        }
        modify("Quantity Per")
        {
            Caption = 'Quantity Per';
        }
        modify("Company Location")
        {
            Caption = 'Company Location';
        }
        modify("Vendor Location")
        {
            Caption = 'Vendor Location';
        }
        modify("Production Order No.")
        {
            Caption = 'Production Order No.';
        }
        modify("Production Order Line No.")
        {
            Caption = 'Production Order Line No.';
        }
        modify("Line Type")
        {
            Caption = 'Line Type';
            OptionCaption = 'Production,Purchase';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("Quantity at Vendor Location")
        {
            Caption = 'Quantity at Vendor Location';
        }
        modify("Total Scrap Quantity")
        {
            Caption = 'Total Scrap Quantity';
        }
        /* modify("Deliver Challan No.")
         {
             Caption = 'Deliver Challan No.';
         }*/ // 15578
        modify("Line No.")
        {
            Caption = 'Line No.';
        }
        modify(Quantity)
        {
            Caption = 'Quantity';
        }
        modify("Remaining Quantity")
        {
            Caption = 'Remaining Quantity';
        }
        modify("Components in Rework Qty.")
        {
            Caption = 'Components in Rework Qty.';
        }
        modify("Posting Date")
        {
            Caption = 'Posting Date';
        }
        modify("Vendor No.")
        {
            Caption = 'Vendor No.';
        }
        modify("Process Description")
        {
            Caption = 'Process Description';
        }
        modify("Prod. Order Comp. Line No.")
        {
            Caption = 'Prod. Order Comp. Line No.';
        }
        modify("Debit Note Created")
        {
            Caption = 'Debit Note Created';
        }
        modify("Return Date")
        {
            Caption = 'Return Date';
        }
        /* modify("Job Work Return Period (GST)")
         {
             Caption = 'Job Work Return Period (GST)';
         }*/ // 15578
        modify("Identification Mark")
        {
            Caption = 'Identification Mark';
        }
        modify("GST Group Code")
        {
            Caption = 'GST Group Code';
        }
        modify("HSN/SAC Code")
        {
            Caption = 'HSN/SAC Code';
        }
        modify("GST Base Amount")
        {
            Caption = 'GST Base Amount';
        }
        /* modify("GST Amount")
         {
             Caption = 'GST Amount';
         }*/ // 15578
        modify("GST Liability Created")
        {
            Caption = 'GST Liability Created';
        }
        /* modify("GST Last Date")
         {
             Caption = 'GST Last Date';
         }*/ // 15578
        modify("Dimension Set ID")
        {
            Caption = 'Dimension Set ID';
        }
    }
}

