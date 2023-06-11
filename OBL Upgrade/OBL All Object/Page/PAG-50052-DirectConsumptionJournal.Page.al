page 50052 "Direct Consumption Journal"
{
    // 1.TRI S.R 040610 - New code Added for Direct Consumption.

    AutoSplitKey = true;
    Caption = 'Direct Consumption Journal';
    DataCaptionFields = "Journal Batch Name";
    PageType = List;
    SaveValues = true;
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTable = "Item Journal Line";
    SourceTableView = WHERE("Entry Type" = FILTER("Negative Adjmt."),
                            "Direct Consumption Entries" = FILTER(true));

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
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var

                    begin
                        ItemJnlMgt.GetItem(Rec."Item No.", ItemDescription);
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        Rec."Gen. Bus. Posting Group" := Mansetup."Con. Bus. Posting Group";//TRI S.R 040610 - New code Added
                    end;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Machine Code"; Rec."Machine Code")
                {
                    Caption = 'Issue to Machine';
                    ApplicationArea = All;
                }
                field("Capex No."; Rec."Capex No.")
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    OptionCaption = ',,,Issue';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateNatureOfDisposal;
                    end;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
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
                        tgILE.SETRANGE(tgILE."Item No.", Rec."Item No.");
                        tgILE.SETRANGE(tgILE."Posting Date", 0D, Rec."Posting Date");
                        IF Rec."Variant Code" <> '' THEN
                            tgILE.SETRANGE(tgILE."Variant Code", Rec."Variant Code");
                        IF Rec."Location Code" <> '' THEN
                            tgILE.SETRANGE(tgILE."Location Code", Rec."Location Code");
                        PAGE.RUN(0, tgILE);
                        //TRI V.D 03.07.10 STOP
                    end;
                }
                field("Inventory till Date"; Rec."Inventory till Date")
                {
                    Caption = 'OBL Inventory as on Date';
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ready To Upload"; Rec."Ready To Upload")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                /*   field("Product Group Code"; Rec."Product Group Code")
                   {
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
                /* 16630 field("Other Usage"; Rec."Other Usage")
                 {
                     Editable = "Other UsageEditable";
                     Visible = false;
                     ApplicationArea = All;

                     trigger OnValidate()
                     begin
                         MakeFieldNonEditable;
                     end;
                 }
                 field("Excise Entry"; Rec."Excise Entry")
                 {
                     Visible = false;
                     ApplicationArea = All;
                 }
                 field("Nature of Disposal"; Rec."Nature of Disposal")
                 {
                     Editable = "Nature of DisposalEditable";
                     Visible = false;
                     ApplicationArea = All;
                 }*/ // 16630
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
            group(General)
            {
                label(Line)
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
                    Visible = false;
                    ApplicationArea = All;
                }

                action("&Recalculate Unit Amount")
                {
                    Caption = '&Recalculate Unit Amount';
                    Visible = false;
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
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //ItemAvailability(1);
                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //ItemAvailability(2);
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
                Visible = false;
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
                separator("-")
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
                    ItemJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    ItemJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    REPORT.RUNMODAL(REPORT::"Inventory Movement", TRUE, TRUE, ItemJnlLine);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        UpdateNatureOfDisposal;
        MakeFieldNonEditable;
        //TRI V.D 03.07.10 START
        tgInventatPostingdate := 0;
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
                tgInventatPostingdate += tgILE.Quantity;
            UNTIL tgILE.NEXT = 0;
        //TRI V.D 03.07.10 STOP
        //CurrPage."Unit of Measure Code".EDITABLE(FALSE)//MSBS.Rao Dt. 17-09-12;
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
        IF Rec."Entry Type".AsInteger() > Rec."Entry Type"::"Negative Adjmt.".AsInteger() THEN
            ERROR(Text000, Rec."Entry Type");


        Rec."Direct Consumption Entries" := TRUE;//TRI S.R 040610 - New code Added
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec."Direct Consumption Entries" := TRUE;//TRI S.R 040610 - New code Added
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetUpNewLine(xRec);
        CLEAR(ShortcutDimCode);
        Rec."Entry Type" := Rec."Entry Type"::"Negative Adjmt.";//TRI S.R 040610 - New code Added
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
    begin
        Mansetup.GET;//TRI S.R 040610 - New code Added
        Mansetup.TESTFIELD(Mansetup."Con. Bus. Posting Group");//TRI S.R 040610 - New code Added


        OpenedFromBatch := (Rec."Journal Batch Name" <> '') AND (Rec."Journal Template Name" = '');
        IF OpenedFromBatch THEN BEGIN
            CurrentJnlBatchName := Rec."Journal Batch Name";
            ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
            EXIT;
        END;
        ItemJnlMgt.TemplateSelection(PAGE::"Direct Consumption Journal", 0, FALSE, Rec, JnlSelected);
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
        Mansetup: Record "Manufacturing Setup";
        tgInventatPostingdate: Decimal;
        tgILE: Record "Item Ledger Entry";
        [InDataSet]
        "Other UsageEditable": Boolean;
        [InDataSet]
        "Nature of DisposalEditable": Boolean;
        Text19009191: Label 'Item Description';

    procedure UpdateNatureOfDisposal()
    begin
        IF Rec."Entry Type" <> Rec."Entry Type"::"Negative Adjmt." THEN BEGIN
            "Other UsageEditable" := FALSE;
            "Nature of DisposalEditable" := FALSE;
            /*    "Other Usage" := 0;
                "Nature of Disposal" := '';*/ // 16630
        END ELSE BEGIN
            "Other UsageEditable" := TRUE;
            "Nature of DisposalEditable" := TRUE;
        END;
        /*    IF "Other Usage" <> "Other Usage"::"Wasted/Destroyed" THEN
                "Nature of DisposalEditable" := FALSE;*/ // 16630
    end;

    procedure MakeFieldNonEditable()
    begin
        /*    IF ("Other Usage" = "Other Usage"::"Wasted/Destroyed") OR ("Other Usage" = "Other Usage"::" ") THEN BEGIN
                "Nature of DisposalEditable" := FALSE;
                "Nature of Disposal" := '';
            END ELSE
                "Nature of DisposalEditable" := TRUE;*/ // 16630
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

