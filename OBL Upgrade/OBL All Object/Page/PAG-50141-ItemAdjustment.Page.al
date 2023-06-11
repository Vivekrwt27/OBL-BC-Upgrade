page 50141 "Item Adjustment"
{
    AutoSplitKey = true;
    Caption = 'Item Journal';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = List;
    SaveValues = true;
    SourceTable = "Item Journal Line";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                Caption = 'Batch Name';
                Lookup = true;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SAVERECORD;
                    ItemJnlMgt.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(FALSE);
                end;

                trigger OnValidate()
                begin
                    ItemJnlMgt.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali;
                end;
            }
            repeater(group)
            {
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; rec."Document Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Entry Type"; rec."Entry Type")
                {
                    OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateNatureOfDisposal;
                        // Upgrade(+)

                        //TRI S.R
                        IF (rec."Entry Type" = rec."Entry Type"::Sale) OR (rec."Entry Type" = rec."Entry Type"::"Negative Adjmt.") THEN
                            rec."Production Plant Code" := ''
                        ELSE BEGIN
                            IF COPYSTR(rec."Item No.", 19, 1) = 'M' THEN BEGIN
                                IF RecItem.GET(rec."Item No.") THEN BEGIN
                                    rec."Production Plant Code" := RecItem."Default Prod. Plant Code";
                                END;
                            END;
                        END;
                        //TRI S.R

                        // Upgrade(-)
                    end;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; rec."External Document No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ItemJnlMgt.GetItem(rec."Item No.", ItemDescription);
                        rec.ShowShortcutDimCode(ShortcutDimCode);
                        //Upgrade(+)
                        //TRI S.R
                        IF (rec."Entry Type" = rec."Entry Type"::Purchase) OR (rec."Entry Type" = rec."Entry Type"::"Positive Adjmt.") THEN BEGIN
                            IF COPYSTR(rec."Item No.", 19, 1) = 'M' THEN BEGIN
                                IF RecItem.GET(rec."Item No.") THEN BEGIN
                                    rec."Production Plant Code" := RecItem."Default Prod. Plant Code";
                                END;
                            END;
                        END;
                        //TRI S.R

                        //Upgrade(-)
                    end;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {

                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {

                    ApplicationArea = All;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Location Code"; rec."Location Code")
                {
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WMSManagement: Codeunit "WMS Management";
                    begin
                        WMSManagement.CheckItemJnlLineLocation(Rec, xRec);
                    end;
                }
                field("Bin Code"; rec."Bin Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Salespers./Purch. Code"; rec."Salespers./Purch. Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Amount"; rec."Unit Amount")
                {
                    ApplicationArea = All;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Discount Amount"; rec."Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Indirect Cost %"; rec."Indirect Cost %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                //16225 Table Remove Feild //start
                /*  field("Other Usage";"Other Usage")
                  {
                      Editable = "Other UsageEditable";
                      Visible = false;

                      trigger OnValidate()
                      begin
                          MakeFieldNonEditable;
                      end;
                  }
                  field("Excise Entry";"Excise Entry")
                  {
                      Visible = false;
                  }
                  field("Nature of Disposal";"Nature of Disposal")
                  {
                      Editable = true;
                      Visible = false;
                  }*/
                //16225 Table Remove Feild //end
                field("Unit Cost"; rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Entry"; rec."Applies-to Entry")
                {
                    ApplicationArea = All;
                }
                field("Applies-from Entry"; rec."Applies-from Entry")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Transaction Type"; rec."Transaction Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Transport Method"; rec."Transport Method")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Country/Region Code"; rec."Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Reason Code"; rec."Reason Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                /* field("Applies-to Entry (RG 23 D)";"Applies-to Entry (RG 23 D)")//16225 Table remove field
                 {
                 }*/
                field("Qty. (Phys. Inventory)"; rec."Qty. (Phys. Inventory)")
                {
                    ApplicationArea = All;
                }
                field("Reserved Quantity"; rec."Reserved Quantity")
                {
                    ApplicationArea = All;
                }
                field(Remarks1; rec.Remarks1)
                {
                    ApplicationArea = All;
                }
                field("Reserved Qty. (Base)"; rec."Reserved Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Inventory at Posting Date"; rec."Inventory at Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Inventory till Date"; rec."Inventory till Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks2; rec.Remarks2)
                {
                    ApplicationArea = All;
                }
                field(Remarks3; rec.Remarks3)
                {
                    ApplicationArea = All;
                }
                field(Remarks4; rec.Remarks4)
                {
                    ApplicationArea = All;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Source No."; rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Inter Company"; rec."Inter Company")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Ready To Upload"; rec."Ready To Upload")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(AvlInventatPostingdatePlant; AvlInventatPostingdatePlant)
                {
                    Caption = 'Inventory till Date at Plant ';
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        //TRI V.D 03.07.10 START
                        tgILE.RESET;
                        tgILE.SETCURRENTKEY(tgILE."Item No.", tgILE."Posting Date");
                        tgILE.SETRANGE(tgILE."Item No.", rec."Item No.");
                        tgILE.SETRANGE(tgILE."Posting Date", 0D, TODAY);
                        IF rec."Variant Code" <> '' THEN
                            tgILE.SETRANGE(tgILE."Variant Code", rec."Variant Code");
                        IF rec."Location Code" <> '' THEN
                            tgILE.SETFILTER(tgILE."Location Code", '%1|%2', 'PLANT', 'WAREHOUSE');
                        PAGE.RUN(0, tgILE);
                        //TRI V.D 03.07.10 STOP
                    end;
                }
                field(Adjustment; rec.Adjustment)
                {
                    ApplicationArea = All;
                }
                field("Applies-to Value Entry"; rec."Applies-to Value Entry")
                {
                    ApplicationArea = All;
                }
                field(tgInventatPostingdate; tgInventatPostingdate)
                {
                    Caption = 'Inventory at Posting Date';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        //TRI V.D 03.07.10 START
                        tgILE.RESET;
                        tgILE.SETCURRENTKEY(tgILE."Item No.", tgILE."Posting Date");
                        tgILE.SETRANGE(tgILE."Item No.", rec."Item No.");
                        tgILE.SETRANGE(tgILE."Posting Date", 0D, rec."Posting Date");
                        IF rec."Variant Code" <> '' THEN
                            tgILE.SETRANGE(tgILE."Variant Code", rec."Variant Code");
                        IF rec."Location Code" <> '' THEN
                            tgILE.SETRANGE(tgILE."Location Code", rec."Location Code");
                        PAGE.RUN(0, tgILE);
                        //TRI V.D 03.07.10 STOP
                    end;
                }
                field(tgAvlInventatPostingdate; tgAvlInventatPostingdate)
                {
                    Caption = 'Inventory Till Date';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        //TRI V.D 03.07.10 START
                        tgILE.RESET;
                        tgILE.SETCURRENTKEY(tgILE."Item No.", tgILE."Posting Date");
                        tgILE.SETRANGE(tgILE."Item No.", rec."Item No.");
                        tgILE.SETRANGE(tgILE."Posting Date", 0D, TODAY);
                        IF rec."Variant Code" <> '' THEN
                            tgILE.SETRANGE(tgILE."Variant Code", rec."Variant Code");
                        IF rec."Location Code" <> '' THEN
                            tgILE.SETRANGE(tgILE."Location Code", rec."Location Code");
                        PAGE.RUN(0, tgILE);
                        //TRI V.D 03.07.10 STOP
                    end;
                }
                field("Inventory Posting Group"; rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                /* field("Product Group Code";"Product Group Code")//16225 table field remove
                 {
                 }*/
                field("Production Plant Code"; rec."Production Plant Code")
                {
                    ApplicationArea = All;
                }
            }
            group(Control22)
            {
                fixed(Control1900669001)
                {
                    group("Item Description")
                    {
                        Caption = 'Item Description';
                        field(ItemDescription; ItemDescription)
                        {
                            Editable = false;
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            part("Item Replenishment FactBox"; "Item Replenishment FactBox")
            {
                SubPageLink = "No." = FIELD("Item No.");
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        rec.ShowDimensions;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(ItemTrackingLines)
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        rec.OpenItemTrackingLines(FALSE);
                    end;
                }
                action("Bin Contents")
                {
                    Caption = 'Bin Contents';
                    Image = BinContent;
                    RunObject = Page "Bin Contents List";
                    RunPageLink = "Location Code" = FIELD("Location Code"),
                                  "Item No." = FIELD("Item No."),
                                  "Variant Code" = FIELD("Variant Code");
                    RunPageView = SORTING("Location Code", "Item No.", "Variant Code");
                    ApplicationArea = All;
                }
                separator(Control00777)
                {
                    Caption = '-';
                }
                action("&Recalculate Unit Amount")
                {
                    Caption = '&Recalculate Unit Amount';
                    Image = UpdateUnitCost;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        rec.RecalculateUnitAmount;
                        CurrPage.SAVERECORD;
                    end;
                }
            }
            group("&Item")
            {
                Caption = '&Item';
                Image = Item;
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Item Card";
                    RunPageLink = "No." = FIELD("Item No.");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = ItemLedger;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Item Ledger Entries";
                    RunPageLink = "Item No." = FIELD("Item No.");
                    RunPageView = SORTING("Item No.");
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = All;
                }
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        Caption = 'Event';
                        Image = "Event";
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByEvent)
                        end;
                    }
                    action(Period)
                    {
                        Caption = 'Period';
                        Image = Period;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByPeriod)
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ShortCutKey = 'Ctrl+M';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByVariant)
                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        Image = Warehouse;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByLocation)
                        end;
                    }
                    action("BOM Level")
                    {
                        Caption = 'BOM Level';
                        Image = BOMLevel;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByBOM)
                        end;
                    }
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Codeunit "Item Jnl.-Explode BOM";
                    ApplicationArea = All;
                }
                action("&Calculate Whse. Adjustment")
                {
                    Caption = '&Calculate Whse. Adjustment';
                    Ellipsis = true;
                    Image = CalculateWarehouseAdjustment;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CalcWhseAdjmt.SetItemJnlLine(Rec);
                        CalcWhseAdjmt.RUNMODAL;
                        CLEAR(CalcWhseAdjmt);
                    end;
                }
                separator("-")
                {
                    Caption = '-';
                }
                action("&Get Standard Journals")
                {
                    Caption = '&Get Standard Journals';
                    Ellipsis = true;
                    Image = GetStandardJournal;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        StdItemJnl: Record "Standard Item Journal";
                    begin
                        StdItemJnl.FILTERGROUP := 2;
                        StdItemJnl.SETRANGE("Journal Template Name", rec."Journal Template Name");
                        StdItemJnl.FILTERGROUP := 0;
                        IF PAGE.RUNMODAL(PAGE::"Standard Item Journals", StdItemJnl) = ACTION::LookupOK THEN BEGIN
                            StdItemJnl.CreateItemJnlFromStdJnl(StdItemJnl, CurrentJnlBatchName);
                            MESSAGE(Text001, StdItemJnl.Code);
                        END
                    end;
                }
                action("&Save as Standard Journal")
                {
                    Caption = '&Save as Standard Journal';
                    Ellipsis = true;
                    Image = SaveasStandardJournal;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ItemJnlBatch: Record "Item Journal Batch";
                        ItemJnlLines: Record "Item Journal Line";
                        StdItemJnl: Record "Standard Item Journal";
                        SaveAsStdItemJnl: Report "Save as Standard Item Journal";
                    begin
                        ItemJnlLines.SETFILTER("Journal Template Name", rec."Journal Template Name");
                        ItemJnlLines.SETFILTER("Journal Batch Name", CurrentJnlBatchName);
                        CurrPage.SETSELECTIONFILTER(ItemJnlLines);
                        ItemJnlLines.COPYFILTERS(Rec);

                        ItemJnlBatch.GET(rec."Journal Template Name", CurrentJnlBatchName);
                        SaveAsStdItemJnl.Initialise(ItemJnlLines, ItemJnlBatch);
                        SaveAsStdItemJnl.RUNMODAL;
                        IF NOT SaveAsStdItemJnl.GetStdItemJournal(StdItemJnl) THEN
                            EXIT;

                        MESSAGE(Text002, StdItemJnl.Code);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintItemJnlLine(Rec);
                    end;
                }
                action(Post)
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //TRI S.R
                        rec.TESTFIELD("Shortcut Dimension 1 Code");
                        RecItemJournal.RESET;
                        RecItemJournal.SETRANGE("Journal Template Name", rec."Journal Template Name");
                        RecItemJournal.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                        IF RecItemJournal.FIND('-') THEN
                            REPEAT
                                IF (rec."Entry Type" = rec."Entry Type"::Purchase) OR (rec."Entry Type" = rec."Entry Type"::"Positive Adjmt.") THEN BEGIN
                                    IF COPYSTR(rec."Item No.", 19, 1) = 'M' THEN BEGIN
                                        IF rec."Production Plant Code" = '' THEN
                                            ERROR(Text003, RecItemJournal."Item No.", RecItemJournal."Line No.");
                                    END;
                                END;
                            UNTIL RecItemJournal.NEXT = 0;
                        //TRI S.R

                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", Rec);
                        CurrentJnlBatchName := rec.GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := rec.GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
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
                    ItemJnlLine: Record "Item Journal Line";
                begin
                    ItemJnlLine.COPY(Rec);
                    ItemJnlLine.SETRANGE("Journal Template Name", rec."Journal Template Name");
                    ItemJnlLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                    REPORT.RUNMODAL(REPORT::"Inventory Movement", TRUE, TRUE, ItemJnlLine);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ItemJnlMgt.GetItem(rec."Item No.", ItemDescription);
        UpdateNatureOfDisposal;
        MakeFieldNonEditable;
    end;

    trigger OnAfterGetRecord()
    begin
        //Upgrade(+)
        AvlInventatPostingdatePlant := 0;
        //TRI V.D 03.07.10 START
        tgInventatPostingdate := 0;
        tgAvlInventatPostingdate := 0;  //TRI DG
        tgILE.RESET;
        tgILE.SETCURRENTKEY(tgILE."Item No.", tgILE."Posting Date");
        tgILE.SETRANGE(tgILE."Item No.", rec."Item No.");
        tgILE.SETRANGE(tgILE."Posting Date", 0D, rec."Posting Date");
        IF rec."Variant Code" <> '' THEN
            tgILE.SETRANGE(tgILE."Variant Code", rec."Variant Code");
        IF rec."Location Code" <> '' THEN
            tgILE.SETRANGE(tgILE."Location Code", rec."Location Code");
        IF tgILE.FIND('-') THEN
            REPEAT
                tgILE.CALCFIELDS(tgILE."Item Base Unit of Measure");
                tgInventatPostingdate += tgILE."Remaining Quantity";
                tgAvlInventatPostingdate += tgItem.UomToCart(tgILE."Item No.", tgILE."Item Base Unit of Measure",
                tgILE."Remaining Quantity"); //TRI DG
            UNTIL tgILE.NEXT = 0;

        //TRI V.D 03.07.10 STOP
        /*
        //TRI-VKG START 080910
        tgItem.GET("Item No.");
        CALCFIELDS("Inventory till Date at Plant &");
        AvlInventatPostingdatePlant := tgItem.UomToCart(tgItem."No.",tgItem."Base Unit of Measure",
                                       "Inventory till Date at Plant &"); //TRI DG
        //TRI-VKG END 080910
         */
        IF USERID <> 'admin' THEN


            //CurrPage."Unit of Measure Code".EDITABLE(FALSE)//MSBS.Rao Dt. 17-09-12;   code blocked for upradation


            //Upgrade(-)


            Rec.ShowShortcutDimCode(ShortcutDimCode);
        UpdateNatureOfDisposal;
        MakeFieldNonEditable;

    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
    begin
        COMMIT;
        IF NOT ReserveItemJnlLine.DeleteLineConfirm(Rec) THEN
            EXIT(FALSE);
        ReserveItemJnlLine.DeleteLine(Rec);
    end;

    trigger OnInit()
    begin
        "Nature of DisposalEditable" := TRUE;
        "Other UsageEditable" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF Rec."Entry Type" > Rec."Entry Type"::"Negative Adjmt." THEN
            ERROR(Text000, rec."Entry Type");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.SetUpNewLine(xRec);
        CLEAR(ShortcutDimCode);
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
    begin
        OpenedFromBatch := (rec."Journal Batch Name" <> '') AND (rec."Journal Template Name" = '');
        IF OpenedFromBatch THEN BEGIN
            CurrentJnlBatchName := rec."Journal Batch Name";
            ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
            EXIT;
        END;
        ItemJnlMgt.TemplateSelection(PAGE::"Item Journal", 0, FALSE, Rec, JnlSelected);
        IF NOT JnlSelected THEN
            ERROR('');
        ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
        UpdateNatureOfDisposal;
        MakeFieldNonEditable;
        OnActivateForm;
    end;

    var
        Text000: Label 'You cannot use entry type %1 in this journal.';
        ItemJnlMgt: Codeunit ItemJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        CalcWhseAdjmt: Report "Calculate Whse. Adjustment";
        CurrentJnlBatchName: Code[10];
        ItemDescription: Text[50];
        ShortcutDimCode: array[8] of Code[20];
        Text001: Label 'Item Journal lines have been successfully inserted from Standard Item Journal %1.';
        Text002: Label 'Standard Item Journal %1 has been successfully created.';
        OpenedFromBatch: Boolean;
        [InDataSet]
        "Other UsageEditable": Boolean;
        [InDataSet]
        "Nature of DisposalEditable": Boolean;
        RecItem: Record Item;
        RecItemJournal: Record "Item Journal Line";
        tgInventatPostingdate: Decimal;
        tgILE: Record "Item Ledger Entry";
        tgAvlInventatPostingdate: Decimal;
        tgItem: Record Item;
        AvlInventatPostingdatePlant: Decimal;
        Text003: Label 'Please define Production Plant code in Item No. %1 Line No. %2.';

    procedure UpdateNatureOfDisposal()
    begin
        IF Rec."Entry Type" <> Rec."Entry Type"::"Negative Adjmt." THEN BEGIN
            "Other UsageEditable" := FALSE;
            "Nature of DisposalEditable" := FALSE;
            // "Other Usage" := 0;//16225 table remove field
            // "Nature of Disposal" := ''; //16225 table remove field
        END ELSE BEGIN
            "Other UsageEditable" := TRUE;
            "Nature of DisposalEditable" := TRUE;
        END;
        //16225 table field remove//
        /* IF "Other Usage" <> "Other Usage"::"Wasted/Destroyed" THEN
           "Nature of DisposalEditable" := FALSE;*/
    end;

    procedure MakeFieldNonEditable()
    begin
        //16225 table field Remove
        /* IF ("Other Usage" = "Other Usage"::"Wasted/Destroyed") OR ("Other Usage" = "Other Usage"::" ") THEN BEGIN
           "Nature of DisposalEditable" := FALSE;
           "Nature of Disposal" := '';
         END ELSE
           "Nature of DisposalEditable" := TRUE;*/
    end;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD;
        ItemJnlMgt.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure OtherUsageOnActivate()
    begin
        MakeFieldNonEditable;
    end;

    local procedure OnActivateForm()
    begin
        UpdateNatureOfDisposal;
    end;

    local procedure OtherUsageOnAfterInput(var Text: Text[1024])
    begin
        MakeFieldNonEditable;
    end;

    local procedure OtherUsageOnInputChange(var Text: Text[1024])
    begin
        MakeFieldNonEditable;
    end;
}


