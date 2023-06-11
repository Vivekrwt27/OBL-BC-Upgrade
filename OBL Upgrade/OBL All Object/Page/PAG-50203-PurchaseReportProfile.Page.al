page 50203 "Purchase Report Profile"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Finance Cue";

    layout
    {
        area(content)
        {
            cuegroup("Purchase Reports")
            {
                Caption = 'Purchase Reports';

                actions
                {
                    action("Indent Detail")
                    {
                        Caption = 'Indent Detail';
                        RunObject = Report "Indent Detail";
                        ApplicationArea = All;
                    }
                    action("Indent Status Report (TAT)")
                    {
                        Caption = 'Indent Status Report (TAT)';
                        RunObject = Report "Indent Status Report (TAT)";
                        ApplicationArea = All;
                    }
                    action("Purchase Saving Report")
                    {
                        Caption = 'Purchase Saving Report';
                        RunObject = Report "Purchase Saving Report";
                        ApplicationArea = All;
                    }
                    action("Detailed Indent Report New")
                    {
                        Caption = 'Detailed Indent Report New';
                        RunObject = Report "Detailed Indent Report";
                        ApplicationArea = All;
                    }
                    action("Purchase Journal")
                    {
                        Caption = 'Purchase Journal';
                        // RunObject = Report 50196;
                        ApplicationArea = All;
                    }
                    action("Item Ageing -Store and Spares")
                    {
                        Caption = 'Item Ageing -Store and Spares';
                        RunObject = Report 50233;
                    }

                    action("Item Stock by Location")
                    {
                        Caption = 'Item Stock by Location';
                        RunObject = Report "Item Stock by Location";
                        Visible = false;
                        ApplicationArea = All;
                    }
                    action("Minimum Stock Mat-Stock Status")
                    {
                        Caption = 'Minimum Stock Mat-Stock Status';
                        ///  RunObject = Report 50081;
                        ApplicationArea = All;
                    }
                    action("MinimumStockMaterial2-SS1")
                    {
                        Caption = 'MinimumStockMaterial2-SS1';
                        ///  RunObject = Report 50323;
                        ApplicationArea = All;
                    }
                    action("Minmum stock - Mth Purch Plani")
                    {
                        Caption = 'Minmum stock - Mth Purch Plani';
                        ///   RunObject = Report 50301;
                        ApplicationArea = All;
                    }
                    action("Vendor - Top 10 List")
                    {
                        Caption = 'Vendor - Top 10 List';
                        RunObject = Report "Vendor - Top 10 List";
                        Visible = false;
                        ApplicationArea = All;
                    }
                    action("Store Inventory")
                    {
                        Caption = 'Store Inventory';
                        RunObject = Report "store inventory";
                        ApplicationArea = All;
                    }
                    action("Item Age Composition - Qty.")
                    {
                        Caption = 'Item Age Composition - Qty.';
                        RunObject = Report "Item Age Composition - Qty.";
                        ApplicationArea = All;
                    }
                    action("Indent Summary/Pending Indents")
                    {
                        Caption = 'Indent Summary/Pending Indents';
                        RunObject = Report "Indent Summary/Pending Indents";
                        ApplicationArea = All;
                    }
                    action("Item Age Composition - Value")
                    {
                        Caption = 'Item Age Composition - Value';
                        RunObject = Report "Item Age Composition - Value";
                        ApplicationArea = All;
                    }
                    action("Warehouse Receipt(Final)")
                    {
                        Caption = 'Warehouse Receipt(Final)';
                        RunObject = Report "Warehouse Receipt(Final)";
                        ApplicationArea = All;
                    }
                    action("Daybook Report")
                    {
                        Caption = 'Daybook Report';
                        RunObject = Report "Daybook Report";
                        ApplicationArea = All;
                    }
                    action("Consumption Report")
                    {
                        Caption = 'Consumption Report';
                        ///  RunObject = Report 50068;
                        Visible = true;
                        ApplicationArea = All;
                    }
                    action("Purchase Credit Memo")
                    {
                        Caption = 'Purchase Credit Memo';
                        RunObject = Report "Purchase Debit Memo";
                        Visible = true;
                        ApplicationArea = All;
                    }
                    action("Pending Purchase Orders")
                    {
                        Caption = 'Pending Purchase Orders';
                        RunObject = Report "Pending Purchase Orders";
                        ApplicationArea = All;
                    }
                    action("Outstanding RGP")
                    {
                        Caption = 'Outstanding RGP';
                        RunObject = Report "Outstanding RGP";
                        ApplicationArea = All;
                    }
                    action("Purchase - Receipt")
                    {
                        Caption = 'Purchase - Receipt';
                        RunObject = Report "Purchase - Receipt";
                        Visible = false;
                        ApplicationArea = All;
                    }
                    action("Purchase Report Excel New")
                    {
                        Caption = 'Purchase Reportexcel1new';
                        RunObject = Report "Purchase Reportexcel1new";
                        ApplicationArea = All;
                    }
                    action(WIP)
                    {
                        Caption = 'WIP';
                        RunObject = Report Stock;
                        Visible = true;
                        ApplicationArea = All;
                    }
                    action("Purch. Received not Invoiced")
                    {
                        Caption = 'Purch. Received not Invoiced';
                        RunObject = Report "Purch. Received not Invoiced";
                        ApplicationArea = All;
                    }
                    action("Item Min & Max Report")
                    {
                        Caption = 'Item Min & Max Report';
                        ///  RunObject = Report 50341;
                        ApplicationArea = All;
                    }
                    action("Vendor Ledger")
                    {
                        Caption = 'Vendor Ledger';
                        RunObject = Report "Vendor Ledger";
                        ApplicationArea = All;
                    }
                    action("Closing Stock - Store")
                    {
                        Caption = 'Closing Stock - Store';
                        RunObject = Report "Closing Stock - Store New";
                        ApplicationArea = All;
                    }
                    action("Pending Intran")
                    {
                        Caption = 'Pending Intran';
                        RunObject = Report "Pending Intran";
                        ApplicationArea = All;
                    }
                    action(" RGP Details")
                    {
                        Caption = ' RGP Details';
                        RunObject = Report "RGP Details";
                        Visible = true;
                        ApplicationArea = All;
                    }
                    action("Transfer Detail")
                    {
                        Caption = 'Transfer Detail';
                        RunObject = Report "Sales Order List";
                        ApplicationArea = All;
                    }
                    action("Vendor - Ageing (Vendor Inv Dt Wise)")
                    {
                        Caption = 'Vendor - Ageing (Vendor Inv Dt Wise)';
                        RunObject = Report "Vendor - Ageing1";
                        ApplicationArea = All;
                    }
                    action("Inventory Valuation Report (Base)")
                    {
                        Caption = 'Inventory Valuation Report (Base)';
                        RunObject = Report "Inventory Valuation Report";
                        ApplicationArea = All;
                    }
                    action(" Item Comments Report")
                    {
                        Caption = ' Item Comments Report';
                        RunObject = Report "Item Comments Report";
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.RESET;
        IF NOT Rec.GET THEN BEGIN
            Rec.INIT;
            Rec.INSERT;
        END;

        Rec.SETFILTER("Due Date Filter", '<=%1', WORKDATE);
        Rec.SETFILTER("Overdue Date Filter", '<%1', WORKDATE);
    end;
}

