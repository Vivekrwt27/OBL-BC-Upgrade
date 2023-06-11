page 50163 "Get SO to Merge"
{
    Caption = 'Get SO to Merge';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Sales Header";
    SourceTableView = SORTING("Document Type", "No.")
                      WHERE("Document Type" = CONST(Order));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Editable = "Sell-to Customer No.Editable";
                    Visible = true;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = "No.Editable";
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Name 2"; Rec."Ship-to Name 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Selection1; Rec.Selection1)
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    DrillDown = false;
                    Editable = false;
                    Lookup = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = QuantityEditable;
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        "Sell-to Customer No.Editable" := FALSE;
        "No.Editable" := FALSE;
        QuantityEditable := FALSE;
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        Rec.MODIFYALL(Selection1, FALSE);
        "Sell-to Customer No.Editable" := FALSE;
        "No.Editable" := FALSE;
        QuantityEditable := FALSE;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN
            OKOnPush;
    end;

    var
        SalesShptHeader: Record "Sales Shipment Header";
        SalesHeader: Record "Sales Header";
        TempSalesShptLine: Record "Sales Shipment Line" temporary;
        SalesGetShpt: Codeunit "Sales-Get SO To Merge";
        CloseActionOk: Boolean;
        [InDataSet]
        "Sell-to Customer No.Editable": Boolean;
        [InDataSet]
        "No.Editable": Boolean;
        [InDataSet]
        QuantityEditable: Boolean;

    procedure SetSalesHeader(var SalesHeader2: Record "Sales Header")
    begin
        SalesHeader.GET(SalesHeader2."Document Type", SalesHeader2."No.");
        SalesHeader.TESTFIELD("Document Type", SalesHeader."Document Type"::Order);
    end;

    procedure CreateLines()
    begin
        //CurrForm.SETSELECTIONFILTER(Rec);
        SalesHeader.RESET;
        SalesHeader.SETRANGE(Selection1, TRUE);
        IF SalesHeader.FINDSET THEN BEGIN
            REPEAT
                CLEAR(SalesGetShpt);
                //  SalesGetShpt.SetSalesHeader(Rec);
                SalesGetShpt.CreateInvLines(SalesHeader, Rec);
            UNTIL SalesHeader.NEXT = 0;
        END
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        "Sell-to Customer No.Editable" := FALSE;
        "No.Editable" := FALSE;
        QuantityEditable := FALSE;
    end;

    local procedure OKOnPush()
    begin
        CloseActionOk := TRUE;
        //CreateLines;
    end;
}

