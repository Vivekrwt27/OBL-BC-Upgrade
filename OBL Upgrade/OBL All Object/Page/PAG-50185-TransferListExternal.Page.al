page 50185 "Transfer List-External"
{
    AutoSplitKey = true;
    Caption = 'Transfer List';
    CardPageID = "Transfer Order External";
    DelayedInsert = true;
    Editable = false;
    PageType = List;
    SourceTable = "Transfer Header";
    /* SourceTableView = WHERE("Captive Consumption" = FILTER(false),
                             "External Transfer" = FILTER(true));*/
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Code"; rec."Transfer-from Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; rec."Transfer-to Code")
                {
                    ApplicationArea = All;
                }
                field("In-Transit Code"; rec."In-Transit Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer order Status"; rec."Transfer order Status")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(1);
                    end;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(2);
                    end;
                }
                field("Assigned User ID"; rec."Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; rec."Shipment Method Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipping Advice"; rec."Shipping Advice")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Receipt Date"; rec."Receipt Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Truck No."; rec."Truck No.")
                {
                    ApplicationArea = All;
                }
                field("Transporter Name"; rec."Transporter Name")
                {
                    ApplicationArea = All;
                }
                field("Requested By"; rec."Requested By")
                {
                    ApplicationArea = All;
                }
                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Total Weight"; rec."Total Weight")
                {
                    ApplicationArea = All;
                }
                field("Total Qty"; rec."Total Qty")
                {
                    ApplicationArea = All;
                }
                field("Last Shipment No."; rec."Last Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Qty. To Ship"; rec."Qty. To Ship")
                {
                    ApplicationArea = All;
                }
                field("Qty in Sq Mtr"; rec."Qty in Sq Mtr")
                {
                    ApplicationArea = All;
                }
                field("Releasing Date"; rec."Releasing Date")
                {
                    ApplicationArea = All;
                }
                field("Releasing Time"; rec."Releasing Time")
                {
                    ApplicationArea = All;
                }
                field("Completely Shipped"; rec."Completely Shipped")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Transfer Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Inventory Comment Sheet";
                    RunPageLink = "Document Type" = CONST("Transfer Order"),
                                  "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action("S&hipments")
                {
                    Caption = 'S&hipments';
                    Image = Shipment;
                    RunObject = Page "Posted Transfer Shipments";
                    RunPageLink = "Transfer Order No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Re&ceipts")
                {
                    Caption = 'Re&ceipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Transfer Receipts";
                    RunPageLink = "Transfer Order No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Whse. Shi&pments")
                {
                    Caption = 'Whse. Shi&pments';
                    Image = Shipment;
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type" = CONST(5741),
                                  "Source Subtype" = CONST(0),
                                  "Source No." = FIELD("No.");
                    //  RunPageView = SORTING("Source Type", "Source Subtype,Source No.", "Source Line No.");
                    ApplicationArea = All;
                }
                action("&Whse. Receipts")
                {
                    Caption = '&Whse. Receipts';
                    Image = Receipt;
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type" = CONST(5741),
                                  "Source Subtype" = CONST(1),
                                  "Source No." = FIELD("No.");
                    // RunPageView = SORTING("Source Type", "Source Subtype,Source No.", "Source Line No.");
                    ApplicationArea = All;
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = FILTER('Inbound Transfer|Outbound Transfer'),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    DocPrint: Codeunit "Document-Print";
                begin
                    DocPrint.PrintTransferHeader(Rec);
                end;
            }
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Codeunit "Release Transfer Document";
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;
                }
                action("Reo&pen")
                {
                    Caption = 'Reo&pen';
                    Image = ReOpen;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleaseTransferDoc: Codeunit "Release Transfer Document";
                    begin
                        ReleaseTransferDoc.Reopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Create Whse. S&hipment")
                {
                    Caption = 'Create Whse. S&hipment';
                    Image = NewShipment;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        GetSourceDocOutbound.CreateFromOutbndTransferOrder(Rec);
                    end;
                }
                action("Create &Whse. Receipt")
                {
                    Caption = 'Create &Whse. Receipt';
                    Image = NewReceipt;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    begin
                        GetSourceDocInbound.CreateFromInbndTransferOrder(Rec);
                    end;
                }
                action("Create Inventor&y Put-away/Pick")
                {
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreatePutawayPick;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CreateInvtPutAwayPick;
                    end;
                }
                action("Get Bin Content")
                {
                    Caption = 'Get Bin Content';
                    Ellipsis = true;
                    Image = GetBinContent;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        BinContent: Record "Bin Content";
                        GetBinContent: Report "Whse. Get Bin Content";
                    begin
                        BinContent.SETRANGE("Location Code", Rec."Transfer-from Code");
                        GetBinContent.SETTABLEVIEW(BinContent);
                        GetBinContent.InitializeTransferHeader(Rec);
                        GetBinContent.RUNMODAL;
                    end;
                }
                action("Loading Slip")
                {
                    Caption = 'Loading Slip';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        TH: Record "Transfer Header";
                    begin
                        TH.RESET;
                        TH.SETRANGE("No.", Rec."No.");
                        REPORT.RUNMODAL(Report::"Loading Slip Transfer", TRUE, FALSE, TH);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "TransferOrder-Post (Yes/No)";
                    ShortCutKey = 'F9';
                    ApplicationArea = All;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "TransferOrder-Post + Print";
                    ShortCutKey = 'Shift+F9';
                    ApplicationArea = All;
                }
            }
        }
        area(reporting)
        {
            action("Inventory - Inbound Transfer")
            {
                Caption = 'Inventory - Inbound Transfer';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Inventory - Inbound Transfer";
                ApplicationArea = All;
            }
        }
    }

    trigger OnOpenPage()
    var
        TransferHead: Record "Transfer Header";
        LocationFilterString: Text[1000];
    begin
        // Update - TCPL-7632
        //TRI V.D 23.06.10 START
        /*tgTransferHeader.RESET;
        tgTransferHeader.SETRANGE(tgTransferHeader."Filter Records",TRUE);
        IF tgTransferHeader.FINDFIRST THEN REPEAT
          tgTransferHeader."Filter Records" := FALSE;
          tgTransferHeader.MODIFY;
        UNTIL tgTransferHeader.NEXT = 0;

        tgUserLocation.RESET;
        tgUserLocation.SETRANGE(tgUserLocation."User ID",USERID);
        tgUserLocation.SETRANGE(tgUserLocation."View Transfer Order",TRUE);
        IF tgUserLocation.FIND('-') THEN REPEAT
          //tgTransferHeader.RESET;
          //tgTransferHeader.SETRANGE("Transfer-from Code",tgUserLocation."Location Code");
          IF tgTransferHeader.FIND('-') THEN REPEAT
            IF tgTransferHeader."Transfer-from Code" = tgUserLocation."Location Code" THEN
              tgTransferHeader.MARK(TRUE);
              //tgTransferHeader.MODIFY;
          UNTIL tgTransferHeader.NEXT = 0;
        UNTIL tgUserLocation.NEXT = 0;

        tgUserLocation.RESET;
        tgUserLocation.SETRANGE(tgUserLocation."User ID",USERID);
        tgUserLocation.SETRANGE(tgUserLocation."Transfer To",TRUE);
        IF tgUserLocation.FIND('-') THEN REPEAT
          //tgTransferHeader.RESET;
          //tgTransferHeader.SETRANGE("Transfer-to Code",tgUserLocation."Location Code");
          IF tgTransferHeader.FIND('-') THEN REPEAT
            IF tgTransferHeader."Transfer-to Code" = tgUserLocation."Location Code" THEN
              tgTransferHeader.MARK(TRUE);
          UNTIL tgTransferHeader.NEXT = 0;

        UNTIL tgUserLocation.NEXT = 0;

        //SETRANGE("Filter Records",TRUE);
        //FILTERGROUP(2);
        //SETFILTER("Transfer-from Code",Locationtofilter);
        //FILTERGROUP(0);
        //TRI V.D 23.06.10 STOP
     tgTransferHeader.MARKEDONLY(TRUE);
     Rec.COPY(tgTransferHeader);
         */
        // Update - TCPL-7632
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", '%1', USERID);
        UserLocation.SETFILTER(UserLocation."View Transfer Order", '%1', TRUE);
        IF UserLocation.FIND('-') THEN
            REPEAT
                // IF LocationFilterString <> '' THEN
                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code"
//ELSE
//  LocationFilterString := UserLocation."Location Code";
UNTIL UserLocation.NEXT = 0;


        LocationFilterString := COPYSTR(LocationFilterString, 2, 1024);
        //MESSAGE(LocationFilterString);
        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');

        //MESSAGE(LocationFilterString);

        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Transfer-from Code", LocationFilterString);
        //  SETFILTER("Transfer-to Code",LocationFilterString);
        Rec.FILTERGROUP(0);

    end;

    var
        DimMgt: Codeunit DimensionManagement;
        tgTransferHeader: Record "Transfer Header";
        tgTransferList: Page "Transfer Orders";
        tgUserLocation: Record "User Location";
        UserLocation: Record "User Location";
        Locationtofilter: Text[1000];


    procedure tgGetTransferOrderNo(): Code[20]
    begin
        EXIT(Rec."No.");
    end;
}

