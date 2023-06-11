page 50143 "Store Return2"
{
    AutoSplitKey = true;
    Caption = 'Item Journal';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = Card;
    SaveValues = true;
    SourceTable = "Item Journal Line";


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
                    //CurrentJnlBatchNameOnAfterValidate;
                    CurrentJnlBatchNameOnAfterVali
                end;
            }
            repeater(group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ItemJnlMgt.GetItem(Rec."Item No.", ItemDescription);
                        Rec.ShowShortcutDimCode(ShortcutDimCode);

                        //TRI S.R
                        IF (Rec."Entry Type" = Rec."Entry Type"::Purchase) OR (Rec."Entry Type" = Rec."Entry Type"::"Positive Adjmt.") THEN BEGIN
                            IF COPYSTR(Rec."Item No.", 19, 1) = 'M' THEN BEGIN
                                IF RecItem.GET(Rec."Item No.") THEN BEGIN
                                    Rec."Production Plant Code" := RecItem."Default Prod. Plant Code";
                                END;
                            END;
                        END;
                        //TRI S.R
                    end;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                /* field("Product Group Code"; "Product Group Code")
                 {
                     ApplicationArea = All;
                 }*/
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Production Plant Code"; Rec."Production Plant Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Location Code"; Rec."Location Code")
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
                field("Bin Code"; Rec."Bin Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Discount Amount"; Rec."Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                /*  field("Other Usage"; "Other Usage")
                  {
                      Editable = "Other UsageEditable";
                      Visible = false;
                      ApplicationArea = All;

                      trigger OnValidate()
                      begin
                          MakeFieldNonEditable;
                      end;
                  }
                  field("Excise Entry"; "Excise Entry")
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }
                  field("Nature of Disposal"; "Nature of Disposal")
                  {
                      Editable = "Nature of DisposalEditable";
                      Visible = false;
                      ApplicationArea = All;
                  }*/
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Entry"; Rec."Applies-to Entry")
                {
                    ApplicationArea = All;
                }
                field("Applies-from Entry"; Rec."Applies-from Entry")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(gernal)
            {
                label(control)
                {
                    CaptionClass = Text19009191;
                    ApplicationArea = All;
                }
                field(ItemDescription; ItemDescription)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
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
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Dim. Values per Account";
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.OpenItemTrackingLines(FALSE);
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
                separator("-")
                {
                    Caption = '-';
                }
                action("&Recalculate Unit Amount")
                {
                    Caption = '&Recalculate Unit Amount';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.RecalculateUnitAmount;
                        CurrPage.SAVERECORD;
                    end;
                }
            }
            group("&Item")
            {
                Caption = '&Item';
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
                    RunObject = Page "Item Ledger Entries";
                    RunPageLink = "Item No." = FIELD("Item No.");
                    RunPageView = SORTING("Item No.");
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = All;
                }
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    action(Period)
                    {
                        Caption = 'Period';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //ItemAvailability(0);
                            //Not available
                            //Code blocked for upgrade
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //ItemAvailability(1);
                            //Not available
                            //Code blocked for upgrade
                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //ItemAvailability(2);
                            //Not available
                            //Code blocked for upgrade
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
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    RunObject = Codeunit "Item Jnl.-Explode BOM";
                    ApplicationArea = All;
                }
                action("&Calculate Whse. Adjustment")
                {
                    Caption = '&Calculate Whse. Adjustment';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CalcWhseAdjmt.SetItemJnlLine(Rec);
                        CalcWhseAdjmt.RUNMODAL;
                        CLEAR(CalcWhseAdjmt);
                    end;
                }
                separator(" ")
                {
                    Caption = '-';
                }
                action("&Get Standard Journals")
                {
                    Caption = '&Get Standard Journals';
                    Ellipsis = true;
                    Image = GetStandardJournal;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        StdItemJnl: Record "Standard Item Journal";
                    begin
                        StdItemJnl.FILTERGROUP := 2;
                        StdItemJnl.SETRANGE("Journal Template Name", Rec."Journal Template Name");
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
                        ItemJnlLines.SETFILTER("Journal Template Name", Rec."Journal Template Name");
                        ItemJnlLines.SETFILTER("Journal Batch Name", CurrentJnlBatchName);
                        CurrPage.SETSELECTIONFILTER(ItemJnlLines);
                        ItemJnlLines.COPYFILTERS(Rec);

                        ItemJnlBatch.GET(Rec."Journal Template Name", CurrentJnlBatchName);
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
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //TRI S.R
                        RecItemJournal.RESET;
                        RecItemJournal.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                        RecItemJournal.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                        IF RecItemJournal.FIND('-') THEN
                            REPEAT
                                IF (Rec."Entry Type" = Rec."Entry Type"::Purchase) OR (Rec."Entry Type" = Rec."Entry Type"::"Positive Adjmt.") THEN BEGIN
                                    IF COPYSTR(Rec."Item No.", 19, 1) = 'M' THEN BEGIN
                                        IF Rec."Production Plant Code" = '' THEN
                                            ERROR(Text003, RecItemJournal."Item No.", RecItemJournal."Line No.");
                                    END;
                                END;
                            UNTIL RecItemJournal.NEXT = 0;
                        //TRI S.R

                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", Rec);
                        CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
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
                        CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action("Store Return SliP")
                {
                    Caption = 'Store Return SliP';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        RecItemJournal.RESET;
                        RecItemJournal.SETFILTER(RecItemJournal."Document No.", '%1', Rec."Document No.");
                        //recitemjournal.SETFILTER("No.","No.");
                        Storereturn.SETTABLEVIEW(RecItemJournal);
                        Storereturn.RUN;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        UpdateNatureOfDisposal;
        MakeFieldNonEditable;
        AvlInventatPostingdatePlant := 0;
        //TRI V.D 03.07.10 START
        tgInventatPostingdate := 0;
        tgAvlInventatPostingdate := 0;  //TRI DG
        tgILE.RESET;
        tgILE.SETCURRENTKEY(tgILE."Item No.", tgILE."Posting Date");
        tgILE.SETRANGE(tgILE."Item No.", Rec."Item No.");
        tgILE.SETRANGE(tgILE."Posting Date", 0D, Rec."Posting Date");
        IF Rec."Variant Code" <> '' THEN
            tgILE.SETRANGE(tgILE."Variant Code", Rec."Variant Code");
        IF Rec."Location Code" <> '' THEN
            tgILE.SETRANGE(tgILE."Location Code", Rec."Location Code");
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
        OnAfterGetCurrRecord;

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
        IF Rec."Entry Type".AsInteger() > Rec."Entry Type"::"Positive Adjmt.".AsInteger() THEN
            ERROR(Text000, Rec."Entry Type");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetUpNewLine(xRec);
        CLEAR(ShortcutDimCode);
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
    begin
        OpenedFromBatch := (Rec."Journal Batch Name" <> '') AND (Rec."Journal Template Name" = '');
        IF OpenedFromBatch THEN BEGIN
            CurrentJnlBatchName := Rec."Journal Batch Name";
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
        CalcWhseAdjmt: Report "Calculate Whse. Adjustment";
        CurrentJnlBatchName: Code[10];
        ItemDescription: Text[50];
        ShortcutDimCode: array[8] of Code[20];
        Text001: Label 'Item Journal lines have been successfully inserted from Standard Item Journal %1.';
        Text002: Label 'Standard Item Journal %1 has been successfully created.';
        OpenedFromBatch: Boolean;
        RecItem: Record Item;
        RecItemJournal: Record "Item Journal Line";
        Text003: Label 'Please define Production Plant code in Item No. %1 Line No. %2.';
        tgInventatPostingdate: Decimal;
        tgILE: Record "Item Ledger Entry";
        tgAvlInventatPostingdate: Decimal;
        tgItem: Record Item;
        AvlInventatPostingdatePlant: Decimal;
        Storereturn: Report "Order Confirmation1";
        [InDataSet]

        "Other UsageEditable": Boolean;
        [InDataSet]
        "Nature of DisposalEditable": Boolean;
        Text19009191: Label 'Item Description';


    procedure UpdateNatureOfDisposal()
    begin
        /*  IF Rec."Entry Type" <> Rec."Entry Type"::"Positive Adjmt." THEN BEGIN
              "Other UsageEditable" := FALSE;
              "Nature of DisposalEditable" := FALSE;
              "Other Usage" := 0;
              "Nature of Disposal" := '';
          END ELSE BEGIN
              "Other UsageEditable" := TRUE;
              "Nature of DisposalEditable" := TRUE;
          END;
          IF "Other Usage" <> "Other Usage"::"Wasted/Destroyed" THEN
              "Nature of DisposalEditable" := FALSE;*/
    end;

    procedure MakeFieldNonEditable()
    begin
        /* IF ("Other Usage" = "Other Usage"::"Wasted/Destroyed") OR ("Other Usage" = "Other Usage"::" ") THEN BEGIN
             "Nature of DisposalEditable" := FALSE;
             "Nature of Disposal" := '';
         END ELSE
             "Nature of DisposalEditable" := TRUE;*/ // 15578
    end;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD;
        ItemJnlMgt.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        ItemJnlMgt.GetItem(Rec."Item No.", ItemDescription);
        UpdateNatureOfDisposal;
        MakeFieldNonEditable;
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

