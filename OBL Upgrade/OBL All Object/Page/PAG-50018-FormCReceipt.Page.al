page 50018 "Form C Receipt"
{
    // //mo tri1.0 customization no. 20 start

    DelayedInsert = true;
    Description = 'Customization No. 20';
    PageType = Card;
    Permissions = TableData "Sales Invoice Header" = rm;
    SourceTable = "Sales Invoice Header";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CustNo; CustNo)
                {
                    Caption = 'Customer No.';
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CustList: Page "Customer List";
                    begin
                        CustList.LOOKUPMODE(TRUE);
                        IF NOT (CustList.RUNMODAL = ACTION::LookupOK) THEN
                            EXIT(FALSE)
                        ELSE
                            Text := CustList.GetSelectionFilter;
                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.SETFILTER("Sell-to Customer No.", CustNo);
                        CustNoOnAfterValidate;
                    end;
                }
                field(FromDate; FromDate)
                {
                    Caption = 'From Date';
                    ApplicationArea = All;
                }
                field(ToDate; ToDate)
                {
                    Caption = 'To Date';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.SETRANGE("Posting Date", FromDate, ToDate);
                        ToDateOnAfterValidate;
                    end;
                }
                field(FormNo; FormNo)
                {
                    Caption = 'Form No.';
                    ApplicationArea = All;
                }
                field(SelectAll; SelectAll)
                {
                    Caption = 'Select All';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SelectAllOnPush;
                    end;
                }
                field(StateVar; StateVar)
                {
                    Caption = 'State';
                    TableRelation = State;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.SETFILTER(State, StateVar);
                    end;
                }
                field(SalesPerCode; SalesPerCode)
                {
                    Caption = 'Employee Code';
                    TableRelation = "Salesperson/Purchaser";
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.SETFILTER("Salesperson Code", SalesPerCode);
                    end;
                }
            }
            repeater(Group)
            {
                Editable = false;
                field(Marked; Rec.Marked)
                {
                    Caption = 'Mark';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Caption = 'Invoice No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Caption = 'Customer No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    Caption = 'City Name';
                    ApplicationArea = All;
                }
                /* field("Excise Amount 1"; "Excise Amount 1")
                 {
                 }
                 field("Amount Including Excise"; Rec."Amount Including Excise")
                 {
                 }*/
                field("Invoice Discount Amount"; Rec."Invoice Discount Amount")
                {
                    ApplicationArea = All;
                }
                /*  field("Sales Tax Amount"; Rec."Sales Tax Amount")
                  {
                  }*/
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    Caption = 'Name';
                    Editable = false;
                    ApplicationArea = All;
                }
                /*   field("State Desc."; "State Desc.")
                   {
                       Caption = 'State';
                   }*/
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /*  field("Form Code"; Rec."Form Code")
                  {
                      Editable = false;
                  }
                  field("Form No."; Rec."Form No.")
                  {
                      Editable = false;
                  }*/
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(NetAmt; NetAmt)
                {
                    Caption = 'Amount Including Excise Less Inv. Disc';
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
            action("&Print")
            {
                Caption = '&Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    SIH.RESET;
                    SIH.COPYFILTERS(Rec);
                    REPORT.RUN(Report::"Bad Inventory Report", TRUE, FALSE, SIH);
                end;
            }
            action("&Mark/Unmark")
            {
                Caption = '&Mark/Unmark';
                Ellipsis = false;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    TourEmployee: Record "Production Planing";
                    TourEmployeeForm: Page "Tour Employee";
                begin
                    IF Rec.Marked = TRUE THEN
                        Rec.Marked := FALSE
                    ELSE
                        Rec.Marked := TRUE;
                    Rec.MODIFY;

                    /*
                    //For Manaul Selection
                    SalesInvHeader.COPYFILTERS(Rec);
                    CurrForm.SETSELECTIONFILTER(SalesInvHeader);
                    SalesInvHeader.MARKEDONLY(TRUE);
                    IF SalesInvHeader.FIND('-') THEN
                      REPEAT
                        IF FIND('-') THEN
                          REPEAT
                            IF "No." = SalesInvHeader."No." THEN
                              IF SalesInvHeader.MARK(TRUE) THEN
                                MARK(TRUE);
                           UNTIL NEXT = 0;
                      UNTIL SalesInvHeader.NEXT = 0;
                    */

                    /*
                    IF MARK(TRUE)  THEN
                      MARK(FALSE)
                    ELSE
                      MARK(TRUE);
                    */

                    //For field having mark in sales inv header
                    /*
                    IF FIND('-') THEN
                    REPEAT
                      IF Marked = TRUE THEN
                        MARK(TRUE);
                      IF Marked = FALSE THEN
                        MARK(FALSE);
                        IF SalesInvHeader.FIND('-') THEN
                          REPEAT
                            IF SalesInvHeader."No." = "No." THEN BEGIN
                              IF Marked = TRUE THEN
                                SalesInvHeader.MARK(TRUE);
                              IF Marked = FALSE THEN
                                SalesInvHeader.MARK(FALSE);
                            END;
                          UNTIL SalesInvHeader.NEXT = 0;
                    UNTIL NEXT = 0;
                    */

                end;
            }
            action("&Update")
            {
                Caption = '&Update';
                Ellipsis = false;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    TourEmployee: Record "Production Planing";
                    TourEmployeeForm: Page "Tour Employee";
                begin
                    /*   FormCodes.RESET;
                       FormCodes.SETFILTER(FormCodes.Code, FormCode1);
                       IF FormCodes.FIND('-') THEN
                           REPEAT
                               IF Rec.FIND('-') THEN
                                   REPEAT
                                       IF "Form Code" = FormCodes.Code THEN BEGIN
                                           IF Rec.Marked = TRUE THEN BEGIN
                                               "Form No." := FormNo;
                                               Rec.MODIFY;
                                           END;
                                       END;
                                   UNTIL Rec.NEXT = 0;
                           UNTIL FormCodes.NEXT = 0;

                       Rec.RESET;
                       Rec.SETFILTER("Form Code", FormCode1);
                       Rec.SETFILTER("Form No.", '=%1', '');
                       IF Rec.FIND('-') THEN
                           REPEAT
                               Rec.Marked := FALSE;
                               Rec.MODIFY;
                           UNTIL Rec.NEXT = 0;

                       FormNo := '';
                       CustNo := '';*/ // 16630



                    /*
                    IF FIND('-') THEN
                      REPEAT
                        IF "Form Code" = 'C' THEN BEGIN
                          IF Marked = TRUE THEN  BEGIN
                            "Form No." := FormNo;
                            MODIFY;
                          END;
                        END;
                      UNTIL NEXT = 0;
                    */
                    /*
                    SalesInvHeader.MARKEDONLY(TRUE);
                    IF SalesInvHeader.FIND('-') THEN
                      REPEAT
                        IF FIND('-') THEN
                          REPEAT
                            IF "No." = SalesInvHeader."No." THEN BEGIN
                              "Form No." := FormNo;
                               MODIFY;
                            END;
                           UNTIL NEXT = 0;
                      UNTIL SalesInvHeader.NEXT = 0;
                    */
                    /*
                    MARKEDONLY(TRUE);
                    IF FIND('-') THEN
                    REPEAT
                              "Form No." := FormNo;
                               MODIFY;
                    UNTIL NEXT = 0;
                    */

                    //For field having mark in sales inv header
                    /*
                    IF SalesInvHeader.FIND('-') THEN
                    SalesInvHeader.MARKEDONLY(TRUE);
                    REPEAT
                      IF FIND('-') THEN
                      REPEAT
                        IF "No." = SalesInvHeader."No." THEN BEGIN
                          "Form No." := FormNo;
                          MODIFY;
                        END;
                      UNTIL NEXT = 0;
                    UNTIL SalesInvHeader.NEXT = 0;
                    */

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS(Amount, "Excise Amount 1", "Invoice Discount Amount", "Amount Including Excise");
        NetAmt := Rec.Amount + Rec."Excise Amount 1" + Rec."Invoice Discount Amount";       //anurag
        // NetAmt := Amount + "Excise Amount 1" - "Invoice Discount Amount";       //anurag
    end;

    trigger OnOpenPage()
    begin
        /*   FormCodes.RESET;
           FormCodes.SETRANGE(FormCodes."C Form", TRUE);
           IF FormCodes.FIND('-') THEN
               REPEAT
                   FormCode1 := FormCode1 + '|' + FormCodes.Code;
               UNTIL FormCodes.NEXT = 0;

           FormCode1 := COPYSTR(FormCode1, 2, 250);

           Rec.RESET;
           Rec.SETFILTER("Form Code", FormCode1);
           Rec.SETFILTER("Form No.", '=%1', '');
           IF Rec.FIND('-') THEN
               REPEAT
                   Rec.Marked := FALSE;
                   Rec.MODIFY;
               UNTIL Rec.NEXT = 0;

           FormNo := '';*/ // 16630
    end;

    var
        CustNo: Code[20];
        DateFilter: Date;
        StartDate: Date;
        EndDate: Date;
        FormNo: Code[10];
        SelectAll: Boolean;
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvHeader1: Record "Sales Invoice Header";
        Marked: Boolean;
        FromDate: Date;
        ToDate: Date;
        // 16630    FormCodes: Record 13756;
        FormCode: Code[10];
        FormCode1: Text[250];
        StateVar: Code[10];
        SalesPerCode: Code[10];
        StateList: Page States;
        State: Record State;
        FormCReport: Report "Bad Inventory Report";
        SIH: Record "Sales Invoice Header";
        NetAmt: Decimal;

    local procedure CustNoOnAfterValidate()
    begin
        CurrPage.UPDATE(TRUE);
    end;

    local procedure ToDateOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SelectAllOnPush()
    begin
        IF SelectAll = TRUE THEN BEGIN
            IF Rec.FIND('-') THEN BEGIN
                REPEAT
                    Rec.Marked := TRUE;
                    Rec.MODIFY;
                UNTIL Rec.NEXT = 0;
            END;
        END;
        IF SelectAll = FALSE THEN BEGIN
            IF Rec.FIND('-') THEN BEGIN
                REPEAT
                    Rec.Marked := FALSE;
                    Rec.MODIFY;
                UNTIL Rec.NEXT = 0;
            END;
        END;
        /*
        IF SelectAll = TRUE THEN BEGIN
          IF FIND('-') THEN BEGIN
            REPEAT
              MARK(TRUE);
            UNTIL NEXT = 0;
          END;
        END;
        IF SelectAll = FALSE THEN BEGIN
          IF FIND('-') THEN BEGIN
            REPEAT
              MARK(FALSE);
            UNTIL NEXT = 0;
          END;
        END;
        */

    end;
}

