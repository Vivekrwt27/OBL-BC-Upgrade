page 50074 "Manufacturing Menu PLANT"
{
    Caption = 'Inventory Menu';
    PageType = Card;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            label(Contect)
            {
                CaptionClass = Text19072489;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Transaction Matrix")
            {
                Caption = 'Transaction Matrix';
                action("Item Transaction Analysis-Qty")
                {
                    Caption = 'Item Transaction Analysis-Qty';
                    RunObject = Page "Direct Consumption Journal";
                    ApplicationArea = All;
                }
                action("Item BOM Analysis")
                {
                    Caption = 'Item BOM Analysis';
                    RunObject = Page "Purchase Line additional";
                    ApplicationArea = All;
                }
            }
            group("Periodic Activities")
            {
                Caption = 'Periodic Activities';
                action("Recurring Item &Journals")
                {
                    Caption = 'Recurring Item &Journals';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ///   ItemJnlManagement.TemplateSelection(0, TRUE);
                    end;
                }
                action("Recurring &BOM Journals")
                {
                    Caption = 'Recurring &BOM Journals';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ///    BOMJnlManagement.TemplateSelection(TRUE);
                    end;
                }
                separator(Action56)
                {
                    Caption = '';
                }
                action("Adjust Cost - &Item Entries")
                {
                    Caption = 'Adjust Cost - &Item Entries';
                    Ellipsis = true;
                    Image = AdjustEntries;
                    RunObject = Report "Adjust Cost - Item Entries";
                    ApplicationArea = All;
                }
                action("P&ost Inventory Cost to G/L")
                {
                    Caption = 'P&ost Inventory Cost to G/L';
                    Ellipsis = true;
                    RunObject = Report "Post Inventory Cost to G/L";
                    ApplicationArea = All;
                }
                separator(Action46)
                {
                }
                action("Adjust Item Costs/Prices")
                {
                    Caption = 'Adjust Item Costs/Prices';
                    Ellipsis = true;
                    Image = AdjustItemCost;
                    RunObject = Report "Adjust Item Costs/Prices";
                    ApplicationArea = All;
                }
                action("Standard Cost &Worksheet")
                {
                    Caption = 'Standard Cost &Worksheet';
                    RunObject = Page "Standard Cost Worksheet";
                    ApplicationArea = All;
                }
                separator(Action36)
                {
                }
                action("Create Invt. &Put-away / Pick")
                {
                    Caption = 'Create Invt. &Put-away / Pick';
                    Ellipsis = true;
                    RunObject = Report "Create Invt Put-away/Pick/Mvmt";
                    ApplicationArea = All;
                }
                separator(Action26)
                {
                }
                group("Bi&zTalk Inbound Product Catalogs")
                {
                    Caption = 'Bi&zTalk Inbound Product Catalogs';
                    action("&Pending")
                    {
                        Caption = '&Pending';
                        // RunObject = Page 9360; //16225 PAGE N/F
                        ApplicationArea = All;
                    }
                    action("&Accepted")
                    {
                        Caption = '&Accepted';
                        //  RunObject = Page 9362;//16225 PAGE N/F
                        ApplicationArea = All;
                    }
                    action("&Rejected")
                    {
                        Caption = '&Rejected';
                        // RunObject = Page 9361; //16225 PAGE N/F
                        ApplicationArea = All;
                    }
                }
                group("Biz&Talk Outbound Product Catalogs")
                {
                    Caption = 'Biz&Talk Outbound Product Catalogs';
                    action("&Unsent")
                    {
                        Caption = '&Unsent';
                        // RunObject = Page 9363; //16225 PAGE N/F
                        ApplicationArea = All;
                    }
                    action("&Sent")
                    {
                        Caption = '&Sent';
                        //  RunObject = Page 9364;//16225 PAGE N/F
                        ApplicationArea = All;
                    }
                }
                action("&Send BizTalk Product Catalog...")
                {
                    Caption = '&Send BizTalk Product Catalog...';
                    // RunObject = Report 99008500; //16225 PAGE N/F
                    ApplicationArea = All;
                }
                separator(Action001)
                {
                }
                group("Date &Compression")
                {
                    Caption = 'Date &Compression';
                    action("Item Ledger")
                    {
                        Caption = 'Item Ledger';
                        Ellipsis = true;
                        Image = ItemLedger;
                        // RunObject = Report 798; //16225 REPORT N/F
                        ApplicationArea = All;
                    }
                    action("BOM Ledger")
                    {
                        Caption = 'BOM Ledger';
                        Ellipsis = true;
                        // RunObject = Report 898; //16225 REPORT N/F
                        ApplicationArea = All;
                    }
                    action("Delete Phys. In&ventory Ledger")
                    {
                        Caption = 'Delete Phys. In&ventory Ledger';
                        Ellipsis = true;
                        RunObject = Report "Delete Phys. Inventory Ledger";
                        ApplicationArea = All;
                    }
                    separator(Action16)
                    {
                    }
                    action("Delete Empty Item Registers")
                    {
                        Caption = 'Delete Empty Item Registers';
                        Ellipsis = true;
                        RunObject = Report "Delete Empty Item Registers";
                        ApplicationArea = All;
                    }
                    action("D&elete Empty BOM Registers")
                    {
                        Caption = 'D&elete Empty BOM Registers';
                        Ellipsis = true;
                        // RunObject = Report 899; //16225 REPORT N/F
                        ApplicationArea = All;
                    }
                    separator(Action57)
                    {
                    }
                    action("Date &Compression Registers")
                    {
                        Caption = 'Date &Compression Registers';
                        Ellipsis = true;
                        RunObject = Page "Date Compr. Registers";
                        ApplicationArea = All;
                    }
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                action("Inventory &Setup")
                {
                    Caption = 'Inventory &Setup';
                    RunObject = Page "Inventory Setup";
                    ApplicationArea = All;
                }
                group("Inventory P&osting")
                {
                    Caption = 'Inventory P&osting';
                    action("&Inventory Posting Groups")
                    {
                        Caption = '&Inventory Posting Groups';
                        RunObject = Page "Inventory Posting Groups";
                        ApplicationArea = All;
                    }
                    action("Inventory &Posting Setup")
                    {
                        Caption = 'Inventory &Posting Setup';
                        RunObject = Page "Inventory Posting Setup";
                        ApplicationArea = All;
                    }
                }
                action("Ord&er Promising Setup")
                {
                    Caption = 'Ord&er Promising Setup';
                    RunObject = Page "Order Promising Setup";
                    ApplicationArea = All;
                }
                separator(Action58)
                {
                }
                action("&Units of Measure")
                {
                    Caption = '&Units of Measure';
                    RunObject = Page "Units of Measure";
                    ApplicationArea = All;
                }
                action("&Manufacturers")
                {
                    Caption = '&Manufacturers';
                    RunObject = Page Manufacturers;
                    ApplicationArea = All;
                }
                action("Item &Categories")
                {
                    Caption = 'Item &Categories';
                    RunObject = Page "Item Categories";
                    ApplicationArea = All;
                }
                action(Classes)
                {
                    Caption = 'Classes';
                    //   RunObject = Page 6231; //16225 PAGE N/F
                    ApplicationArea = All;
                }
                action("Product &Groups")
                {
                    Caption = 'Product &Groups';
                    // RunObject = Page 5731; //16225 PAGE N/F
                    ApplicationArea = All;
                }
                action("Item Tracki&ng Codes")
                {
                    Caption = 'Item Tracki&ng Codes';
                    RunObject = Page "Item Tracking Codes";
                    ApplicationArea = All;
                }
                separator(Action59)
                {
                }
                action("&Locations")
                {
                    Caption = '&Locations';
                    RunObject = Page "Location List";
                    ApplicationArea = All;
                }
                action("&Transfer Routes")
                {
                    Caption = '&Transfer Routes';
                    RunObject = Page "Transfer Routes";
                    ApplicationArea = All;
                }
                action("Rounding Met&hods")
                {
                    Caption = 'Rounding Met&hods';
                    RunObject = Page "Rounding Methods";
                    ApplicationArea = All;
                }
                action("Item &Discount Groups")
                {
                    Caption = 'Item &Discount Groups';
                    RunObject = Page "Item Disc. Groups";
                    ApplicationArea = All;
                }
                action("Item Classification")
                {
                    Caption = 'Item Classification';
                    RunObject = Page "Item Classification";
                    ApplicationArea = All;
                }
                separator(Action60)
                {
                }
                action("Report Selections")
                {
                    Caption = 'Report Selections';
                    RunObject = Page "Report Selection - Inventory";
                    ApplicationArea = All;
                }
                action("&Item Journal Templates")
                {
                    Caption = '&Item Journal Templates';
                    RunObject = Page "Item Journal Templates";
                    ApplicationArea = All;
                }
                action("&BOM Journal Templates")
                {
                    Caption = '&BOM Journal Templates';
                    // RunObject = Page 108;//16225 PAGE N/F
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            action(Items)
            {
                Caption = 'Items';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Item Card";
                ApplicationArea = All;
            }
            action("Stockkeeping Units")
            {
                Caption = 'Stockkeeping Units';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Stockkeeping Unit Card";
                ApplicationArea = All;
            }
            action("Nonstock Items")
            {
                Caption = 'Nonstock Items';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Non-Stock Item List";
                ApplicationArea = All;
            }
            action("Item Journals")
            {
                Caption = 'Item Journals';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ///   ItemJnlManagement.TemplateSelection(0, FALSE);
                end;
            }
            action("Item Reclass. Journals")
            {
                Caption = 'Item Reclass. Journals';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ///    ItemJnlManagement.TemplateSelection(1, FALSE);
                end;
            }
            action("Phys. Inventory Journals")
            {
                Caption = 'Phys. Inventory Journals';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ///   ItemJnlManagement.TemplateSelection(2, FALSE);
                end;
            }
            action("BOM Journals")
            {
                Caption = 'BOM Journals';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ///    BOMJnlManagement.TemplateSelection(FALSE);
                end;
            }
            action("Revaluation Journals")
            {
                Caption = 'Revaluation Journals';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ///    ItemJnlManagement.TemplateSelection(3, FALSE);
                end;
            }
            action("Consumption Journals")
            {
                Caption = 'Consumption Journals';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ItemJnlMgt: Codeunit ItemJnlManagement;
                begin
                    ///    ItemJnlMgt.TemplateSelection(4, FALSE);
                end;
            }
            action("Output Journals")
            {
                Caption = 'Output Journals';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ItemJnlMgt: Codeunit ItemJnlManagement;
                begin
                    ///    ItemJnlMgt.TemplateSelection(5, FALSE);
                end;
            }
            action("Transfer OrdersS") //16225 "Transfer Orders" Replace "Transfer OrdersS
            {
                Caption = 'Transfer Orders External';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38

                    TransferHeader.RESET;
                    IF TransferHeader.FIND('-') THEN
                        REPEAT
                            UserLocation.RESET;
                            UserLocation.SETFILTER("User ID", UPPERCASE(USERID));
                            UserLocation.SETFILTER("Location Code", TransferHeader."Transfer-from Code");
                            UserLocation.SETFILTER("Transfer From", '%1', TRUE);
                            UserLocation1.RESET;
                            UserLocation1.SETFILTER("User ID", UPPERCASE(USERID));
                            UserLocation1.SETFILTER("Location Code", TransferHeader."Transfer-to Code");
                            UserLocation1.SETFILTER("Transfer To", '%1', TRUE);
                            IF (UserLocation1.FIND('-')) OR (UserLocation.FIND('-')) THEN
                                TransferHeader.MARK(TRUE);
                        UNTIL TransferHeader.NEXT = 0;

                    TransferHeader.MARKEDONLY(TRUE);
                    ///    TransferOrder1.SETTABLEVIEW(TransferHeader);
                    ///    TransferOrder1.RUN;

                    //ND Tri End Cust 38
                end;
            }
            action("Transfer Orders")
            {
                Caption = 'Transfer Orders Internal';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38

                    TransferHeader.RESET;
                    IF TransferHeader.FIND('-') THEN
                        REPEAT
                            UserLocation.RESET;
                            UserLocation.SETFILTER("User ID", UPPERCASE(USERID));
                            UserLocation.SETFILTER("Location Code", TransferHeader."Transfer-from Code");
                            UserLocation.SETFILTER("Transfer From", '%1', TRUE);
                            UserLocation1.RESET;
                            UserLocation1.SETFILTER("User ID", UPPERCASE(USERID));
                            UserLocation1.SETFILTER("Location Code", TransferHeader."Transfer-to Code");
                            UserLocation1.SETFILTER("Transfer To", '%1', TRUE);
                            IF (UserLocation1.FIND('-')) OR (UserLocation.FIND('-')) THEN
                                TransferHeader.MARK(TRUE);
                        UNTIL TransferHeader.NEXT = 0;

                    TransferHeader.MARKEDONLY(TRUE);
                    ///    TransferOrder.SETTABLEVIEW(TransferHeader);
                    ///   TransferOrder.RUN;

                    //ND Tri End Cust 38
                end;
            }
            action("Inventory Put-away")
            {
                Caption = 'Inventory Put-aways';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Inventory Put-away";
                ApplicationArea = All;
            }
            action("Inventory Pick")
            {
                Caption = 'Inventory Picks';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Inventory Pick";
                ApplicationArea = All;
            }
            action("RGP Out")
            {
                Caption = 'RGP Out';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "RGP Out Header";
                ApplicationArea = All;
            }
            action("Inventory PickS")
            {
                Caption = 'RGP In';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "RGP In Header";
                ApplicationArea = All;
            }
            action(Indent)
            {
                Caption = 'Indents';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38

                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Indent", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    IndentHeader.SETFILTER("Location Code", LocationFilterString);

                    IF IndentHeader.FIND('-') THEN
                        REPEAT
                            CASE IndentHeader.Status OF

                                IndentHeader.Status::Open:
                                    IF IndentHeader."User ID" = UPPERCASE(USERID) THEN
                                        IndentHeader.MARK(TRUE);

                                IndentHeader.Status::Authorization1:
                                    IF IndentHeader."User ID" = UPPERCASE(USERID) THEN
                                        IndentHeader.MARK(TRUE)
                                    ELSE
                                        IF IndentHeader."Authorization 1" = UPPERCASE(USERID) THEN
                                            IndentHeader.MARK(TRUE);

                                IndentHeader.Status::Authorization2:
                                    IF IndentHeader."User ID" = UPPERCASE(USERID) THEN
                                        IndentHeader.MARK(TRUE)
                                    ELSE
                                        IF IndentHeader."Authorization 1" = UPPERCASE(USERID) THEN
                                            IndentHeader.MARK(TRUE)
                                        ELSE
                                            IF IndentHeader."Authorization 2" = UPPERCASE(USERID) THEN
                                                IndentHeader.MARK(TRUE);

                                IndentHeader.Status::Authorized:
                                    IF IndentHeader."User ID" = UPPERCASE(USERID) THEN
                                        IndentHeader.MARK(TRUE)
                                    ELSE
                                        IF IndentHeader."Authorization 1" = UPPERCASE(USERID) THEN
                                            IndentHeader.MARK(TRUE)
                                        ELSE
                                            IF IndentHeader."Authorization 2" = UPPERCASE(USERID) THEN
                                                IndentHeader.MARK(TRUE);
                            END;

                            IF IndentHeader.Status = IndentHeader.Status::Authorized THEN BEGIN
                                UserLocation.RESET;
                                UserLocation.SETFILTER(UserLocation."User ID", UPPERCASE(USERID));
                                UserLocation.SETFILTER(UserLocation."Location Code", IndentHeader."Location Code");
                                UserLocation.SETFILTER(UserLocation.Purchaser, '%1', TRUE);
                                IF UserLocation.FIND('-') THEN
                                    IndentHeader.MARK(TRUE);
                            END;

                        UNTIL IndentHeader.NEXT = 0;

                    IndentHeader.MARKEDONLY(TRUE);
                    ///    IndentHeaderForm.SETTABLEVIEW(IndentHeader);
                    ///    IndentHeaderForm.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action("Item Reports")
            {
                Caption = 'Reports';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                //  ReportList: Record 243;//16225 TABLE N/F
                begin
                    /*WITH ReportList DO//16225 TABLE N/F
                         ShowList(FIELDNO("Manufacturing Plant Reports"));*/
                end;
            }
            action("Posted Transfer Shipments")
            {
                Caption = 'Posted Transfer Shipments';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Posted Transfer Shipment";
                ApplicationArea = All;
            }
            action("Posted Transfer Receipts")
            {
                Caption = 'Posted Transfer Receipts';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Posted Transfer Receipt";
                ApplicationArea = All;
            }
            action("Posted RGP Out")
            {
                Caption = 'Posted RGP Out';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Posted RGP Out Header";
                ApplicationArea = All;
            }
            action("Posted RGP In")
            {
                Caption = 'Posted RGP In';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Posted RGP In Header";
                ApplicationArea = All;
            }
            action("Closed Indents")
            {
                Caption = 'Closed Indents';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Closed Indent Header";
                ApplicationArea = All;
            }
            action("Closed Indent")
            {
                Caption = 'Deleted Indents';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Deleted Indent Header";
                ApplicationArea = All;
            }
            action("Posted Invt. Put-away")
            {
                Caption = 'Posted Invt. Put-aways';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Posted Invt. Put-away";
                ApplicationArea = All;
            }
            action("Posted Invt. Pick")
            {
                Caption = 'Posted Invt. Picks';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Posted Invt. Pick";
                ApplicationArea = All;
            }
            action("Item Registers")
            {
                Caption = 'Item Registers';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Item Registers";
                ApplicationArea = All;
            }
            action("BOM Registers")
            {
                Caption = 'BOM Registers';
                Promoted = true;
                PromotedCategory = Process;
                //RunObject = Page 267;//16225 PAGE N/F
                ApplicationArea = All;
            }
            action("Warehouse Registers")
            {
                Caption = 'Warehouse Registers';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Warehouse Registers";
                ApplicationArea = All;
            }
            action(Navigate)
            {
                Caption = 'Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page Navigate;
                ApplicationArea = All;
            }
        }
    }

    var
        ItemJnlManagement: Codeunit ItemJnlManagement;
        BOMJnlManagement: Codeunit "Gen. Jnl.-Post via Job Queue";
        TransferHeader: Record "Transfer Header";
        LocationFilterString: Text[250];
        UserLocation: Record "User Location";
        LocationFilterString1: Text[250];
        UserLocation1: Record "User Location";
        IndentHeader: Record "Indent Header";
        Text19072489: Label 'Manufacturing';
}

