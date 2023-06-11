page 50007 "Item Sales Prices"
{
    Caption = 'Sales Prices';
    DataCaptionExpression = GetCaption;
    DelayedInsert = true;
    Editable = false;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Item Sales Price1";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field(SalesTypeFilter; SalesTypeFilter)
                {
                    Caption = 'Sales Type Filter';
                    OptionCaption = 'Customer,Customer Price Group,All Customers,Campaign,None';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SalesTypeFilterOnAfterValidate;
                    end;
                }
                field(SalesCodeFilterCtrl; SalesCodeFilter)
                {
                    Caption = 'Sales Code Filter';
                    Enabled = SalesCodeFilterCtrlEnable;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CustList: Page "Customer List";
                        CustPriceGrList: Page "Customer Price Groups";
                        CampaignList: Page "Campaign List";
                    begin
                        IF SalesTypeFilter = SalesTypeFilter::"All Customers" THEN EXIT;

                        CASE SalesTypeFilter OF
                            SalesTypeFilter::Customer:
                                BEGIN
                                    CustList.LOOKUPMODE := TRUE;
                                    IF CustList.RUNMODAL = ACTION::LookupOK THEN
                                        Text := CustList.GetSelectionFilter
                                    ELSE
                                        EXIT(FALSE);
                                END;
                            SalesTypeFilter::"Customer Price Group":
                                BEGIN
                                    CustPriceGrList.LOOKUPMODE := TRUE;
                                    IF CustPriceGrList.RUNMODAL = ACTION::LookupOK THEN
                                        Text := CustPriceGrList.GetSelectionFilter
                                    ELSE
                                        EXIT(FALSE);
                                END;
                            SalesTypeFilter::Campaign:
                                BEGIN
                                    CampaignList.LOOKUPMODE := TRUE;
                                    IF CampaignList.RUNMODAL = ACTION::LookupOK THEN
                                        Text := CampaignList.GetSelectionFilter
                                    ELSE
                                        EXIT(FALSE);
                                END;
                        END;

                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        SalesCodeFilterOnAfterValidate;
                    end;
                }
                field(StartingDateFilter; StartingDateFilter)
                {
                    Caption = 'Starting Date Filter';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //StartingDateFilterOnAfterValidate;            code blocked for upgradation
                    end;
                }
            }
            repeater(Group)
            {
                field("Sales Type"; Rec."Sales Type")
                {
                    ApplicationArea = All;
                }
                field("Sales Code"; Rec."Sales Code")
                {
                    Editable = "Sales CodeEditable";
                    ApplicationArea = All;
                }
                field("Item Classification No."; Rec."Item Classification No.")
                {
                    Caption = 'Item Classification No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(MRP; Rec.MRP)
                {
                    ApplicationArea = All;
                }
                field("Minimum Quantity"; Rec."Minimum Quantity")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(Options)
            {
                Caption = 'Options';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Update Item Price")
            {
                Caption = '&Update Item Price';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Update Sales Price";
                ApplicationArea = All;
            }

        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        SalesCodeFilterCtrlEnable := TRUE;
        "Sales CodeEditable" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin

        IF usersetup.GET(USERID) THEN
            IF usersetup."Price Update" = TRUE THEN
                CurrPage.EDITABLE(TRUE)
            ELSE
                CurrPage.EDITABLE(FALSE);


        GetRecFilters;
        SetRecFilters;
    end;

    var
        Cust: Record Customer;
        CustPriceGr: Record "Customer Price Group";
        Campaign: Record Campaign;
        Item: Record "Item Classification";
        SalesTypeFilter: Option Customer,"Customer Price Group","All Customers",Campaign,"None";
        SalesCodeFilter: Text[250];
        ItemNoFilter: Code[20];
        StartingDateFilter: Text[30];
        CurrencyCodeFilter: Text[250];
        Text000: Label 'All Customers';
        [InDataSet]
        "Sales CodeEditable": Boolean;
        [InDataSet]
        SalesCodeFilterCtrlEnable: Boolean;
        usersetup: Record "User Setup";

    procedure GetRecFilters()
    begin
        IF Rec.GETFILTERS <> '' THEN BEGIN
            IF Rec.GETFILTER("Sales Type") <> '' THEN
                SalesTypeFilter := Rec."Sales Type"
            ELSE
                SalesTypeFilter := SalesTypeFilter::None;

            SalesCodeFilter := Rec.GETFILTER("Sales Code");
            //  ItemNoFilter := GETFILTER("Item Classification No.");
            CurrencyCodeFilter := Rec.GETFILTER("Currency Code");
        END;

        EVALUATE(StartingDateFilter, Rec.GETFILTER("Starting Date"));
    end;

    procedure SetRecFilters()
    begin
        SalesCodeFilterCtrlEnable := TRUE;

        IF SalesTypeFilter <> SalesTypeFilter::None THEN
            Rec.SETRANGE("Sales Type", SalesTypeFilter)
        ELSE
            Rec.SETRANGE("Sales Type");

        IF SalesTypeFilter IN [SalesTypeFilter::"All Customers", SalesTypeFilter::None] THEN BEGIN
            SalesCodeFilterCtrlEnable := FALSE;
            SalesCodeFilter := '';
        END;

        IF SalesCodeFilter <> '' THEN
            Rec.SETFILTER("Sales Code", SalesCodeFilter)
        ELSE
            Rec.SETRANGE("Sales Code");

        IF StartingDateFilter <> '' THEN
            Rec.SETFILTER("Starting Date", StartingDateFilter)
        ELSE
            Rec.SETRANGE("Starting Date");
        IF ItemNoFilter <> '' THEN BEGIN
            Rec.SETFILTER("Item Classification No.", ItemNoFilter);
        END ELSE
            Rec.SETRANGE("Item Classification No.");

        IF CurrencyCodeFilter <> '' THEN BEGIN
            Rec.SETFILTER("Currency Code", CurrencyCodeFilter);
        END ELSE
            Rec.SETRANGE("Currency Code");

        CurrPage.UPDATE(FALSE);
    end;

    procedure GetCaption(): Text[250]
    var
        ObjTransl: Record "Object Translation";
        SourceTableName: Text[100];
        SalesSrcTableName: Text[100];
        Description: Text[250];
    begin
        GetRecFilters;
        //CurrForm.ItemNoFilterCtrl.UPDATE;
        "Sales CodeEditable" := Rec."Sales Type" <> Rec."Sales Type"::"All Customers";

        SourceTableName := '';
        IF ItemNoFilter <> '' THEN
            SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 50008);

        SalesSrcTableName := '';
        CASE SalesTypeFilter OF
            SalesTypeFilter::Customer:
                BEGIN
                    SalesSrcTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 18);
                    Cust."No." := SalesCodeFilter;
                    IF Cust.FIND THEN
                        Description := Cust.Name;
                END;
            SalesTypeFilter::"Customer Price Group":
                BEGIN
                    SalesSrcTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 6);
                    CustPriceGr.Code := SalesCodeFilter;
                    IF CustPriceGr.FIND THEN
                        Description := CustPriceGr.Description;
                END;
            SalesTypeFilter::Campaign:
                BEGIN
                    SalesSrcTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 5071);
                    Campaign."No." := SalesCodeFilter;
                    IF Campaign.FIND THEN
                        Description := Campaign.Description;
                END;
            SalesTypeFilter::"All Customers":
                BEGIN
                    SalesSrcTableName := Text000;
                    Description := '';
                END;
        END;

        IF SalesSrcTableName = Text000 THEN
            EXIT(STRSUBSTNO('%1 %2 %3', SalesSrcTableName, SourceTableName, ItemNoFilter));
        EXIT(STRSUBSTNO('%1 %2 %3 %4 %5', SalesSrcTableName, SalesCodeFilter, Description, SourceTableName, ItemNoFilter));
    end;

    local procedure SalesCodeFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;
    end;

    local procedure SalesTypeFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        SalesCodeFilter := '';
        SetRecFilters;
    end;

    local procedure StartingDateFilterOnAfterValid()
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;
    end;

    local procedure CurrencyCodeFilterOnAfterValid()
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        "Sales CodeEditable" := Rec."Sales Type" <> Rec."Sales Type"::"All Customers"
    end;
}

