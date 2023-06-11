page 50000 "Tour Master"
{
    Caption = 'Tour Master';
    Description = '2.9';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Tour Header";
    UsageCategory = Lists;
    ApplicationArea = ALL;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Tour No."; Rec."Tour No.")
                {
                    Editable = "Tour No.Editable";
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Purpose; Rec.Purpose)
                {
                    Editable = PurposeEditable;
                    ApplicationArea = All;
                }
                field("Advance Amount"; Rec."Advance Amount")
                {
                    Editable = "Advance AmountEditable";
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    Editable = "Start DateEditable";
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    Editable = "End DateEditable";
                    ApplicationArea = All;
                }
                field("Tour Over"; Rec."Tour Over")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Release; Rec.Release)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            /*   part("Tour Lines"; "Tour Line Subform")
              {
                  Editable = "Tour LinesEditable";
                  SubPageLink = "Tour No." = FIELD("Tour No.");
                  SubPageView = SORTING("Tour No.", "Line No.")
                                ORDER(Ascending);
                  ApplicationArea = All;
              } */
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Action1000000015")
                {
                    Caption = 'Tour Over';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Rec."Tour Over" = FALSE THEN BEGIN
                            IF Rec.Release = TRUE THEN BEGIN
                                IF CONFIRM(STRSUBSTNO(Text0009, Rec."Tour No.")) THEN BEGIN
                                    Rec."Tour Over" := TRUE;
                                    "Tour No.Editable" := FALSE;
                                    PurposeEditable := FALSE;
                                    "Start DateEditable" := FALSE;
                                    "End DateEditable" := FALSE;
                                    "Advance AmountEditable" := FALSE;
                                    "Tour LinesEditable" := FALSE;
                                    CurrPage.UPDATE;
                                    MESSAGE(Text0010, Rec."Tour No.");
                                END;
                            END ELSE BEGIN
                                ERROR(Text0007);
                            END;
                        END;
                    end;
                }
                separator("-----------------")
                {
                    Caption = '-----------------';
                }
                action(Action1000000012)
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        TourEmployee: Record "Production Planing";
                    begin
                        TourEmployee.RESET;
                        TourEmployee.SETRANGE("Location Code", rec."Tour No.");
                        TourEmployee.SETFILTER("Item No", '<>%1', '');
                        IF TourEmployee.FIND('-') THEN BEGIN
                            rec.Release := TRUE;
                            "Tour No.Editable" := FALSE;
                            PurposeEditable := FALSE;
                            "Advance AmountEditable" := FALSE;
                            "Start DateEditable" := FALSE;
                            "End DateEditable" := FALSE;
                            "Tour LinesEditable" := FALSE;
                            CurrPage.UPDATE;
                        END ELSE
                            ERROR(Text0005);

                    end;
                }
                action(ReOpen)
                {
                    Caption = 'ReOpen';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Rec."Tour Over" = FALSE THEN BEGIN
                            Rec.Release := FALSE;
                            "Tour No.Editable" := TRUE;
                            PurposeEditable := TRUE;
                            "Advance AmountEditable" := TRUE;
                            "Start DateEditable" := TRUE;
                            "End DateEditable" := TRUE;
                            "Tour LinesEditable" := TRUE;
                            CurrPage.UPDATE;
                        END ELSE BEGIN
                            ERROR(Text0008);
                        END;
                    end;
                }
            }
            action("Enter List")
            {
                Caption = '&Enter List';
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    TourEmployee: Record "Production Planing";
                    TourEmployeeForm: Page "Tour Employee";
                begin
                    IF Rec.Purpose = '' THEN
                        ERROR(Text0002);
                    IF Rec."Start Date" = 0D THEN
                        ERROR(Text0003);
                    IF Rec."End Date" = 0D THEN
                        ERROR(Text0004);

                    TourEmployee.RESET;
                    TourEmployee.SETRANGE("Location Code", rec."Tour No.");
                    TourEmployeeForm.CalledFrom(rec.Release);
                    TourEmployeeForm.SETTABLEVIEW(TourEmployee);
                    IF TourEmployeeForm.RUNMODAL = ACTION::LookupOK THEN
                        TourEmployee."Location Code" := rec."Tour No.";
                    /*
                                     IF FORM.RUNMODAL(FORM::"Tour Employee",TourEmployee)= ACTION::LookupOK THEN
                                       TourEmployee."Tour No." := "Tour No.";
                                     */

                end;
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
                    TourHead: Record "Tour Header";
                begin
                    TourHead.RESET;
                    TourHead.SETFILTER("Tour No.", Rec."Tour No.");
                    /*   TourRep.SETTABLEVIEW(TourHead);
                       TourRep.RUN;*/
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Rec.Release = TRUE THEN BEGIN
            "Tour No.Editable" := FALSE;
            PurposeEditable := FALSE;
            "Start DateEditable" := FALSE;
            "End DateEditable" := FALSE;
            "Tour LinesEditable" := FALSE;
        END ELSE
            IF Rec.Release = FALSE THEN BEGIN
                "Tour No.Editable" := TRUE;
                PurposeEditable := TRUE;
                "Start DateEditable" := TRUE;
                "End DateEditable" := TRUE;
                "Tour LinesEditable" := TRUE;
            END;
    end;


    trigger OnDeleteRecord(): Boolean
    begin
        ERROR(Text0001);
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        IF Rec.FIND(Which) THEN
            EXIT(TRUE)
        ELSE BEGIN
            Rec.SETRANGE("Tour No.");
            EXIT(Rec.FIND(Which));
        END;
    end;

    trigger OnInit()
    begin
        "Advance AmountEditable" := TRUE;
        "Tour LinesEditable" := TRUE;
        "End DateEditable" := TRUE;
        "Start DateEditable" := TRUE;
        PurposeEditable := TRUE;
        "Tour No.Editable" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Tour No.Editable" := TRUE;
        PurposeEditable := TRUE;
        "Start DateEditable" := TRUE;
        "End DateEditable" := TRUE;
        "Tour LinesEditable" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Tour No.Editable" := TRUE;
        PurposeEditable := TRUE;
        "Start DateEditable" := TRUE;
        "End DateEditable" := TRUE;
        "Tour LinesEditable" := TRUE;
    end;

    var
        ///  TourRep: Report 50000;
        TourHead: Record "Tour Header";
        Text0001: Label 'The record can''t be deleted.';
        Text0002: Label 'Purpose field can''t be left blank.';
        Text0003: Label 'Start Date can''t be left blank.';
        Text0004: Label 'End Date can''t be left blank.';
        Text0005: Label 'Enter Employee List before Release.';
        TourLine: Record "Tour Line";
        Text0007: Label 'Tour must be released first.';
        Text0008: Label 'You cannot reopen the Over Tour.';
        Text0009: Label 'Do you want to close Tour %1';
        Text0010: Label 'Tour %1 is now over.';
        [InDataSet]
        "Tour No.Editable": Boolean;
        [InDataSet]
        PurposeEditable: Boolean;
        [InDataSet]
        "Start DateEditable": Boolean;
        [InDataSet]
        "End DateEditable": Boolean;
        [InDataSet]
        "Tour LinesEditable": Boolean;
        [InDataSet]
        "Advance AmountEditable": Boolean;
}

