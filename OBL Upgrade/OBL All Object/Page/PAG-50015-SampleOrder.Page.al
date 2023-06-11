page 50015 "Sample Order"
{
    Caption = '<Sample Order1>';
    DelayedInsert = true;
    Description = 'Customization No. 15';
    PageType = Card;
    SourceTable = "Sample Order";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("Customer No."; rec."Customer No.")
                {
                    Visible = "Customer No.Visible";
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Customer.GET(Rec."Customer No.") THEN
                            Rec."Customer Name" := Customer.Name;
                    end;
                }
                field("Customer Name"; rec."Customer Name")
                {
                    Visible = "Customer NameVisible";
                    ApplicationArea = All;
                }
                field("Item No."; rec."Item No.")
                {
                    Visible = "Item No.Visible";
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Item.GET(Rec."Item No.") THEN
                            Rec."Item Description" := Item.Description;
                    end;
                }
                field("Item Description"; rec."Item Description")
                {
                    Visible = "Item DescriptionVisible";
                    ApplicationArea = All;
                }
                field(Date; rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Of Measure"; rec."Unit Of Measure")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Create Sales Order")
            {
                Caption = '&Create Sales Order';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*
                    IF CalledID = 18 THEN BEGIN
                      IF CONFIRM(Text0002) THEN BEGIN
                        CurrForm.SETSELECTIONFILTER(SampleOrder1);
                        SampleOrder1.MARKEDONLY(TRUE);
                        IF NOT SampleOrder1.FIND('-') THEN
                          ERROR('Select the records first');
                        IF SampleOrder1.FIND('-') THEN
                              CreateSampleOrder;
                      END;
                    END;
                    */
                    IF CalledID = 18 THEN BEGIN
                        IF CONFIRM(Text0002) THEN BEGIN
                            SampleOrder1.COPYFILTERS(Rec);
                            CurrPage.SETSELECTIONFILTER(SampleOrder1);
                            SampleOrder1.MARKEDONLY(TRUE);
                            IF NOT SampleOrder1.FIND('-') THEN
                                ERROR('Select the records first');
                            IF SampleOrder1.FIND('-') THEN
                                REPEAT
                                    IF Rec.FIND('-') THEN
                                        REPEAT
                                            IF Rec."Customer No." = SampleOrder1."Customer No." THEN
                                                IF Rec."Item No." = SampleOrder1."Item No." THEN
                                                    IF Rec.Date = SampleOrder1.Date THEN
                                                        IF Rec."SO Created" = FALSE THEN BEGIN
                                                            NextOrderBoolCust := FALSE;
                                                            CreateSampleOrder(Rec);
                                                        END ELSE
                                                            MESSAGE(Text0005, Rec."Customer No.", Rec."Item No.", Rec.Date);
                                        UNTIL Rec.NEXT = 0;
                                UNTIL SampleOrder1.NEXT = 0;
                        END;
                    END;

                    IF CalledID = 27 THEN BEGIN
                        IF CONFIRM(Text0002) THEN BEGIN
                            SampleOrder2.COPYFILTERS(Rec);
                            CurrPage.SETSELECTIONFILTER(SampleOrder2);
                            SampleOrder2.MARKEDONLY(TRUE);
                            IF NOT SampleOrder2.FIND('-') THEN
                                ERROR('Select the records first');
                            IF SampleOrder2.FIND('-') THEN
                                REPEAT
                                    IF Rec.FIND('-') THEN
                                        REPEAT
                                            IF Rec."Customer No." = SampleOrder2."Customer No." THEN
                                                IF Rec."Item No." = SampleOrder2."Item No." THEN
                                                    IF Rec.Date = SampleOrder2.Date THEN
                                                        IF Rec."SO Created" = FALSE THEN BEGIN
                                                            NextOrderBool := FALSE;
                                                            CreateSalesHeaderForItems(Rec);
                                                        END ELSE
                                                            MESSAGE(Text0005, Rec."Customer No.", Rec."Item No.", Rec.Date);
                                        UNTIL Rec.NEXT = 0;
                                UNTIL SampleOrder2.NEXT = 0;
                        END;
                    END;

                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        IF Rec."SO Created" = TRUE THEN
            ERROR(Text0006);
    end;

    trigger OnInit()
    begin
        "Item DescriptionVisible" := TRUE;
        "Item No.Visible" := TRUE;
        "Customer NameVisible" := TRUE;
        "Customer No.Visible" := TRUE;
    end;

    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesSetUp: Record "Sales & Receivables Setup";
        SampleOrder: Record "Sample Order";
        CalledID: Integer;
        Number: Code[20];
        ItemFilter: Code[80];
        cnt: Integer;
        i: Integer;
        NextOrderBool: Boolean;
        CustNo: Code[20];
        LineNo: Integer;
        SampleOrder2: Record "Sample Order";
        Text0002: Label 'Do you want to create Sample Order for selected line/s.';
        Text0003: Label 'Sample Order %1 has been created for Customer %2.';
        SampleOrder1: Record "Sample Order";
        Customer: Record Customer;
        Item: Record Item;
        SampleOrder3: Record "Sample Order";
        NextOrderBoolCust: Boolean;
        Text0005: Label 'Sample Order has already been created for Customer %1,Item %2,Date %3';
        CustLineNo: Integer;
        Text0006: Label 'Line/s for which "SO Created" is YES could not be deleted. ';
        [InDataSet]
        "Customer No.Visible": Boolean;
        [InDataSet]
        "Customer NameVisible": Boolean;
        [InDataSet]
        "Item No.Visible": Boolean;
        [InDataSet]
        "Item DescriptionVisible": Boolean;


    procedure CalledFrom(CallID: Integer)
    begin
        IF CallID = 18 THEN BEGIN
            "Customer No.Visible" := FALSE;
            "Customer NameVisible" := FALSE;
            "Item No.Visible" := TRUE;
            "Item DescriptionVisible" := TRUE;
            CalledID := 18;
        END;
        IF CallID = 27 THEN BEGIN
            "Item No.Visible" := FALSE;
            "Item DescriptionVisible" := FALSE;
            "Customer No.Visible" := TRUE;
            "Customer NameVisible" := TRUE;
            CalledID := 27;
        END;
    end;



    procedure CreateSampleOrder(var SampleOrder1Local: Record "Sample Order")
    var
        LineNo: Integer;
        SampleOrder1: Record "Sample Order";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SampleOrder2: Record "Sample Order";
        SampleOrder2Local: Record "Sample Order";
    begin
        //CreateSampleOrder
        //mo tri1.0 Customization no.15 start
        IF SampleOrder1Local."Customer No." <> CustNo THEN BEGIN
            SalesHeader.INIT;
            SalesHeader.VALIDATE("Document Type", SalesHeader."Document Type"::Order);
            SalesSetUp.GET;
            SalesSetUp.TESTFIELD("Posted Shipment Nos.");
            SalesSetUp.TESTFIELD("Posted Invoice Nos.");
            TestNoSeries;
            SalesHeader.VALIDATE("No.", NoSeriesMgt.GetNextNo(GetNoSeriesCode, WORKDATE, TRUE));
            Number := SalesHeader."No.";
            SalesHeader.VALIDATE("Posting Date", WORKDATE);
            SalesHeader.VALIDATE("Document Date", WORKDATE);
            SalesHeader.VALIDATE("Order Date", WORKDATE);
            //SalesHeader.VALIDATE("User ID",USERID);
            SampleOrder1Local.VALIDATE("SO Date", SalesHeader."Posting Date");
            SampleOrder1Local.VALIDATE("SO Created", TRUE);
            SampleOrder1Local.MODIFY;
            SalesHeader.VALIDATE("Sell-to Customer No.", Rec."Customer No.");
            SalesHeader.VALIDATE(SalesHeader."Shipping No. Series", SalesSetUp."Posted Shipment Nos.");
            SalesHeader.VALIDATE(SalesHeader."Posting No. Series", SalesSetUp."Posted Invoice Nos.");
            CustNo := SalesHeader."Sell-to Customer No.";
            SalesHeader.INSERT(TRUE);
            NextOrderBoolCust := TRUE;
            CustLineNo := 10000;
            MESSAGE(Text0003, SalesHeader."No.", SalesHeader."Sell-to Customer No.");
        END;

        IF NextOrderBoolCust = FALSE THEN BEGIN
            SampleOrder1Local.VALIDATE("SO Date", SalesHeader."Posting Date");
            SampleOrder1Local.VALIDATE("SO Created", TRUE);
            SampleOrder1Local.MODIFY;
            CustLineNo := CustLineNo + 10000;
        END;

        SalesLine.INIT;
        SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.VALIDATE("Document No.", Number);
        SalesLine.VALIDATE("Line No.", CustLineNo);
        SalesLine.VALIDATE("Sell-to Customer No.", SampleOrder1Local."Customer No.");
        SalesLine.VALIDATE(Type, SalesLine.Type::Item);
        SalesLine.VALIDATE("No.", SampleOrder1Local."Item No.");
        SalesLine.VALIDATE("Location Code", SampleOrder1Local."Location Code");
        SalesLine.VALIDATE(Quantity, SampleOrder1Local.Quantity);
        SalesLine."Unit of Measure Code" := SampleOrder1Local."Unit Of Measure";
        SalesLine.INSERT(TRUE);
        SampleOrder1Local.VALIDATE("SO No.", Number);
        SampleOrder1Local.MODIFY;
        Number := SalesHeader."No.";
        CustNo := SampleOrder1Local."Customer No.";
        //mo tri1.0 Customization no.15 end
    end;

    local procedure TestNoSeries(): Boolean
    begin
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
            SalesSetUp.TESTFIELD(SalesSetUp."Order Nos.");
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
            EXIT(SalesSetUp."Order Nos.");
    end;


    procedure CreateSalesHeaderForItems(var SampleOrder2Local: Record "Sample Order")
    var
        SampleOrder1: Record "Sample Order";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        //CreateSalesHeaderForItems
        //mo tri1.0 Customization no.15 start
        IF SampleOrder2Local."Customer No." <> CustNo THEN BEGIN
            SalesHeader.INIT;
            SalesHeader.VALIDATE("Document Type", SalesHeader."Document Type"::Order);
            SalesSetUp.GET;
            SalesSetUp.TESTFIELD("Posted Shipment Nos.");
            SalesSetUp.TESTFIELD("Posted Invoice Nos.");
            TestNoSeries;
            SalesHeader.VALIDATE("No.", NoSeriesMgt.GetNextNo(GetNoSeriesCode, WORKDATE, TRUE));
            Number := SalesHeader."No.";
            SalesHeader.VALIDATE("Posting Date", WORKDATE);
            SalesHeader.VALIDATE("Document Date", WORKDATE);
            SalesHeader.VALIDATE("Order Date", WORKDATE);
            //  SalesHeader.VALIDATE("User ID",USERID);
            SampleOrder2Local.VALIDATE("SO Date", SalesHeader."Posting Date");
            SampleOrder2Local.VALIDATE("SO Created", TRUE);
            SampleOrder2Local.MODIFY;
            SalesHeader.VALIDATE("Sell-to Customer No.", Rec."Customer No.");
            SalesHeader.VALIDATE(SalesHeader."Shipping No. Series", SalesSetUp."Posted Shipment Nos.");
            SalesHeader.VALIDATE(SalesHeader."Posting No. Series", SalesSetUp."Posted Invoice Nos.");
            CustNo := SalesHeader."Sell-to Customer No.";
            SalesHeader.INSERT(TRUE);
            NextOrderBool := TRUE;
            LineNo := 10000;
            MESSAGE(Text0003, SalesHeader."No.", SalesHeader."Sell-to Customer No.");
        END;

        IF NextOrderBool = FALSE THEN BEGIN
            SampleOrder2Local.VALIDATE("SO Date", SalesHeader."Posting Date");
            SampleOrder2Local.VALIDATE("SO Created", TRUE);
            SampleOrder2Local.MODIFY;
            LineNo := LineNo + 10000;
        END;

        SalesLine.INIT;
        SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.VALIDATE("Document No.", Number);
        SalesLine.VALIDATE("Line No.", LineNo);
        SalesLine.VALIDATE("Sell-to Customer No.", SampleOrder2Local."Customer No.");
        SalesLine.VALIDATE(Type, SalesLine.Type::Item);
        SalesLine.VALIDATE("No.", SampleOrder2Local."Item No.");
        SalesLine.VALIDATE("Location Code", SampleOrder2Local."Location Code");
        SalesLine.VALIDATE(Quantity, SampleOrder2Local.Quantity);
        SalesLine."Unit of Measure Code" := SampleOrder2Local."Unit Of Measure";
        SalesLine.INSERT(TRUE);
        SampleOrder2Local.VALIDATE("SO No.", Number);
        SampleOrder2Local.MODIFY;
        Number := SalesHeader."No.";
        CustNo := SampleOrder2Local."Customer No.";
        //mo tri1.0 Customization no.15 end
    end;
}

