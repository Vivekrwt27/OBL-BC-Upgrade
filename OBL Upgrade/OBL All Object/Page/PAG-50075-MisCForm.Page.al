page 50075 "Mis C-Form"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "C-form";
    SourceTableView = WHERE("Remove Invoice" = CONST(false));

    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("No."; Rec."No.")
                {
                    Editable = "No.Editable";
                    ApplicationArea = All;
                }
                field(Brand; Rec.Brand)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Editable = "Customer No.Editable";
                    ApplicationArea = All;
                }
                field("Invoice Amount"; Rec."Invoice Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Remove Invoice"; Rec."Remove Invoice")
                {
                    Editable = "Remove InvoiceEditable";
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ORC Dealer Code"; Rec."ORC Dealer Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell To Customer Name"; Rec."Sell To Customer Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell To City"; Rec."Sell To City")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("State Desc."; Rec."State Desc.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Tin No."; Rec."Tin No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Salesperson Description"; Rec."Salesperson Description")
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Tax Base Amount"; Rec."Tax Base Amount")
                {
                    Editable = "Tax Base AmountEditable";
                    ApplicationArea = All;
                }
                field("C Form No."; Rec."C Form No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Cst Amount"; Rec."Cst Amount")
                {
                    Editable = "Cst AmountEditable";
                    ApplicationArea = All;
                }
                field("C Form Recd Date"; Rec."C Form Recd Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No of Days"; Rec."No of Days")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Interest; Rec.Interest)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Tax Code"; Rec."Tax Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Tax %"; Rec."Tax %")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Full Tax Liability"; Rec."Full Tax Liability")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Tax Liability"; Rec."Total Tax Liability")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sent Date"; Rec."Sent Date")
                {
                    Editable = "Sent DateEditable";
                    ApplicationArea = All;
                }
                field(Zone; Rec.Zone)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("PCH Code"; Rec."PCH Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("C-Form Person"; Rec."C-Form Person")
                {
                    Editable = "C-Form PersonEditable";
                    ApplicationArea = All;
                }
                field("Followup Status"; Rec."Followup Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("C-Form Recd Amt"; Rec."C-Form Recd Amt")
                {
                    Editable = "C-Form Recd AmtEditable";
                    ApplicationArea = All;
                }
                field("C-Form Pending Amt"; Rec."C-Form Pending Amt")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Period; Rec.Period)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Differential Tax Liability"; Rec."Differential Tax Liability")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("PCH Name"; Rec."PCH Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ORC Dealer Name"; Rec."ORC Dealer Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("C Form Update")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    REPORT.RUN(Report::"c-FORM");
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Rec."C Form No." <> '' THEN BEGIN
            "No.Editable" := FALSE;
            "Customer No.Editable" := FALSE;
            "Remove InvoiceEditable" := FALSE;
            "Tax Base AmountEditable" := FALSE;
            "Cst AmountEditable" := FALSE;
            "Sent DateEditable" := FALSE;
            "C-Form PersonEditable" := FALSE;
            "C-Form Recd AmtEditable" := FALSE;
            "C-Form Recd AmtEditable" := FALSE;

        END ELSE BEGIN
            "No.Editable" := TRUE;
            "Customer No.Editable" := TRUE;
            "Remove InvoiceEditable" := TRUE;
            "Tax Base AmountEditable" := TRUE;
            "Cst AmountEditable" := TRUE;
            "Sent DateEditable" := TRUE;
            "C-Form PersonEditable" := TRUE;
            "C-Form Recd AmtEditable" := TRUE;
        END;
        NoOnFormat;
        BrandOnFormat;
        CustomerNoOnFormat;
        InvoiceAmountOnFormat;
        LocationCodeOnFormat;
        BranchCodeOnFormat;
        CustomerTypeOnFormat;
        ORCDealerCodeOnFormat;
        SellToCustomerNameOnFormat;
        SellToCityOnFormat;
        StateDescOnFormat;
        TinNoOnFormat;
        PostingDateOnFormat;
        SalespersonDescriptionOnFormat;
        TaxBaseAmountOnFormat;
        CFormNoOnFormat;
        CstAmountOnFormat;
        CFormRecdDateOnFormat;
        NoofDaysOnFormat;
        InterestOnFormat;
        TaxCodeOnFormat;
        Tax37OnFormat;
        FullTaxLiabilityOnFormat;
        TotalTaxLiabilityOnFormat;
        SentDateOnFormat;
        ZoneOnFormat;
        PCHCodeOnFormat;
        SalespersonCodeOnFormat;
        CFormPersonOnFormat;
        FollowupStatusOnFormat;
        CFormRecdAmtOnFormat;
        CFormPendingAmtOnFormat;
        PeriodOnFormat;
        //DifferentialTaxLiabilityOnFormat;
        PCHNameOnFormat;
        ORCDealerNameOnFormat;
        PostCodeOnFormat;
    end;

    trigger OnInit()
    begin
        "C-Form Recd AmtEditable" := TRUE;
        "C-Form PersonEditable" := TRUE;
        "Sent DateEditable" := TRUE;
        "Cst AmountEditable" := TRUE;
        "Tax Base AmountEditable" := TRUE;
        "Remove InvoiceEditable" := TRUE;
        "Customer No.Editable" := TRUE;
        "No.Editable" := TRUE;
    end;

    trigger OnOpenPage()
    begin
        //MSBS.Rao Start 021214
        IF GetLocations <> '' THEN
            Rec.SETFILTER("Location Code", GetLocations);
        //MSBS.Rao Stop 021214
    end;

    var
        UserLocation: Record "User Location";
        Loc: Text[30];
        CFORM: Record "C-form";
        [InDataSet]
        "No.Editable": Boolean;
        [InDataSet]
        "Customer No.Editable": Boolean;
        [InDataSet]
        "Remove InvoiceEditable": Boolean;
        [InDataSet]
        "Tax Base AmountEditable": Boolean;
        [InDataSet]
        "Cst AmountEditable": Boolean;
        [InDataSet]
        "Sent DateEditable": Boolean;
        [InDataSet]
        "C-Form PersonEditable": Boolean;
        [InDataSet]
        "C-Form Recd AmtEditable": Boolean;

    procedure GetLocations(): Text[800]
    var
        Loc: Text[800];
    begin
        //MSBS.Rao Start 021212
        UserLocation.RESET;
        UserLocation.SETRANGE("User ID", USERID);
        UserLocation.SETFILTER("View Sales Order", '%1', TRUE);
        IF UserLocation.FINDFIRST THEN BEGIN
            REPEAT
                IF Loc = '' THEN
                    Loc := UserLocation."Location Code"
                ELSE
                    Loc := Loc + '|' + UserLocation."Location Code";
            UNTIL UserLocation.NEXT = 0;
        END;
        EXIT(Loc);
        //MSBS.Rao Stop 021212
    end;

    local procedure NoOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure BrandOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure CustomerNoOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure InvoiceAmountOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure LocationCodeOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure BranchCodeOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure CustomerTypeOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure ORCDealerCodeOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure SellToCustomerNameOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure SellToCityOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure StateDescOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure TinNoOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure PostingDateOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure SalespersonDescriptionOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure TaxBaseAmountOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure CFormNoOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure CstAmountOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure CFormRecdDateOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure NoofDaysOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure InterestOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure TaxCodeOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure Tax37OnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure FullTaxLiabilityOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure TotalTaxLiabilityOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure SentDateOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure ZoneOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure PCHCodeOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure SalespersonCodeOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure CFormPersonOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure FollowupStatusOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure CFormRecdAmtOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure CFormPendingAmtOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure PeriodOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure DifferentialTaxLiabilityOnForm()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure PCHNameOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure ORCDealerNameOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;

    local procedure PostCodeOnFormat()
    begin
        IF Rec."C Form No." <> '' THEN;
    end;
}

