page 50017 "Form C Issue"
{
    // //mo tri1.0 customization no. 20 start

    DelayedInsert = true;
    Description = 'Customization No. 20';
    PageType = Card;
    Permissions = TableData "Purch. Inv. Header" = rm;
    SourceTable = "Purch. Inv. Header";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(VendorNo; VendorNo)
                {
                    Caption = 'Vendor No.';
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        VendorList.LOOKUPMODE(TRUE);
                        IF NOT (VendorList.RUNMODAL = ACTION::LookupOK) THEN
                            EXIT(FALSE)
                        ELSE
                            Text := VendorList.GetSelectionFilter;
                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.SETFILTER("Buy-from Vendor No.", VendorNo);
                        VendorNoOnAfterValidate;
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
                        Rec.SETRANGE(Rec."Posting Date", FromDate, ToDate);
                        ToDateOnAfterValidate;
                    end;
                }
                field(FormNo; FormNo)
                {
                    Caption = 'Form No.';
                    ApplicationArea = All;

                    /*  trigger OnLookup(var Text: Text): Boolean
                      begin
                          TaxFormDetails.RESET;
                          TaxFormDetails.SETFILTER(TaxFormDetails."Form Code", FormCode1);
                          TaxFormDetails.SETRANGE(TaxFormDetails.Issued, FALSE);
                          IF VendorNo <> '' THEN BEGIN
                              Vendor.GET(VendorNo);
                              TaxFormDetails.SETFILTER(State, Vendor."State Code");
                          END;
                          IF PAGE.RUNMODAL(PAGE::"Tax Forms Details", TaxFormDetails) = ACTION::LookupOK THEN
                              FormNo := TaxFormDetails."Form No.";
                      end;*/

                    trigger OnValidate()
                    begin
                        IF FormNo <> '' THEN BEGIN
                            //   TFD.RESET;
                            //    TFD.SETFILTER("Form Code", FormCode1);
                            //   TFD.SETRANGE(Issued, FALSE);
                            IF VendorNo <> '' THEN BEGIN
                                Vendor.GET(VendorNo);
                                //      TFD.SETFILTER(State, Vendor."State Code");
                            END;
                            //   TFD.SETFILTER("Form No.", FormNo);
                            //  IF NOT TFD.FIND('-') THEN
                            ERROR('Form Code %1 does not exist', FormNo);
                        END;
                    end;
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
                        //    Rec.SETFILTER(State, StateVar);
                    end;
                }
            }
            repeater(Group)
            {
                Editable = true;
                /* field(Marked; Rec.Marked)
                 {
                     Caption = 'Mark';
                     Editable = false;
                 }*/
                field("No."; Rec."No.")
                {
                    Caption = 'Invoice No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Caption = 'Vendor No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    Caption = 'Name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /*   field("Form Code"; Rec."Form Code")
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
                /*  field(NetAmt; Rec.NetAmt)
                  {
                      Caption = 'Amount Inc. Excise Less Inv. Disc.';
                      Editable = false;
                  }*/
            }
        }
    }

    actions
    {
        area(processing)
        {
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













                    //For Manaul Selection
                    /*
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
                    Bool := FALSE;
                    bool1 := FALSE;
                    bool3 := FALSE;
                    BuyFromVendor := '';
                    /*  FormCodes.RESET;
                      FormCodes.SETFILTER(FormCodes.Code, FormCode1);
                      IF FormCodes.FIND('-') THEN
                          REPEAT
                              IF Rec.FIND('-') THEN
                                  REPEAT
                                      IF "Form Code" = FormCodes.Code THEN BEGIN
                                          IF Marked = TRUE THEN BEGIN
                                              IF bool1 = FALSE THEN
                                                  BuyFromVendor := Rec."Buy-from Vendor No.";
                                              IF Rec."Buy-from Vendor No." <> BuyFromVendor THEN
                                                  Bool := TRUE;
                                              BuyFromVendor := Rec."Buy-from Vendor No.";
                                              bool1 := TRUE;
                                          END;
                                      END;
                                  UNTIL Rec.NEXT = 0;
                          UNTIL FormCodes.NEXT = 0;*/

                    IF Bool = TRUE THEN
                        ERROR(Text001);

                    /*    FormCodes.RESET;
                        FormCodes.SETFILTER(FormCodes.Code, FormCode1);
                        IF FormCodes.FIND('-') THEN
                            REPEAT
                                IF Rec.FIND('-') THEN
                                    REPEAT
                                        IF "Form Code" = FormCodes.Code THEN BEGIN
                                            IF Marked = TRUE THEN BEGIN
                                                "Form No." := FormNo;
                                                Rec.MODIFY;
                                                bool3 := TRUE;
                                            END;
                                        END;
                                    UNTIL Rec.NEXT = 0;
                            UNTIL FormCodes.NEXT = 0;

                        IF bool3 = TRUE THEN BEGIN
                            TFD.RESET;
                            TFD.SETFILTER("Form Code", FormCode1);
                            TFD.SETFILTER("Form No.", FormNo);
                            IF TFD.FIND('-') THEN BEGIN
                                TFD.Issued := TRUE;
                                TFD."Vendor No." := BuyFromVendor;
                                TFD.MODIFY;
                            END;*/

                    FormNo := '';
                    BuyFromVendor := '';
                    VendorNo := '';

                    Rec.RESET;
                    //  Rec.SETFILTER("Form Code", FormCode1);
                    //  Rec.SETFILTER("Form No.", '%1', '');
                    IF Rec.FIND('-') THEN
                        REPEAT
                            Rec.Marked := FALSE;
                            Rec.MODIFY;
                        UNTIL Rec.NEXT = 0;
                END;

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
                //right code
                /*
                Bool := FALSE;
                bool1 := FALSE;
                bool3 := FALSE;
                BuyFromVendor := '';
                IF FIND('-') THEN BEGIN
                  REPEAT
                    IF "Form Code" = 'C' THEN BEGIN
                      IF Marked = TRUE THEN  BEGIN
                        IF bool1 = FALSE THEN
                          BuyFromVendor := "Buy-from Vendor No.";
                        IF "Buy-from Vendor No." <> BuyFromVendor THEN
                          Bool := TRUE;
                        BuyFromVendor := "Buy-from Vendor No.";
                        bool1 := TRUE;
                      END;
                    END;
                  UNTIL NEXT = 0;
                END;

                IF Bool = TRUE THEN
                  ERROR(Text001);

                IF FIND('-') THEN
                  REPEAT
                    IF "Form Code" = 'C' THEN BEGIN
                      IF Marked = TRUE THEN  BEGIN
                        "Form No." := FormNo;
                        MODIFY;
                        bool3 := TRUE;
                      END;
                    END;
                  UNTIL NEXT = 0;

                IF bool3 = TRUE THEN BEGIN
                  TFD.RESET;
                  TFD.SETRANGE("Form Code",'C');
                  TFD.SETFILTER("Form No.",FormNo);
                  IF TFD.FIND('-') THEN BEGIN
                    TFD.Issued := TRUE;
                    TFD."Vendor No." := BuyFromVendor;
                    TFD.MODIFY;
                  END;

                  FormNo := '';
                  BuyFromVendor := '';
                  VendorNo := '';
                  RESET;
                  SETFILTER("Form Code",'=%1','C');
                  SETFILTER("Form No.",'=%1','');
                  IF FIND('-') THEN REPEAT
                    Marked  := FALSE;
                    MODIFY;
                  UNTIL NEXT = 0;
                END;
                */

                //  end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS(Amount, ExciseAmt, InvDiscAmt);
        //NetAmt := Rec.Amount + Rec.ExciseAmt - Rec.InvDiscAmt;
        NetAmt := Rec.Amount + Rec.InvDiscAmt;
    end;

    trigger OnOpenPage()
    begin
        /*   FormCodes.RESET;
           FormCodes.SETRANGE(FormCodes."C Form", TRUE);
           IF FormCodes.FIND('-') THEN
               REPEAT
                   FormCode1 := FormCode1 + '|' + FormCodes.Code;
               UNTIL FormCodes.NEXT = 0;*/

        FormCode1 := COPYSTR(FormCode1, 2, 250);

        Rec.RESET;
        //  Rec.SETFILTER("Form Code", FormCode1);
        //  Rec.SETFILTER("Form No.", '%1', '');
        IF Rec.FIND('-') THEN
            REPEAT
                Rec.Marked := FALSE;
                Rec.MODIFY;
            UNTIL Rec.NEXT = 0;
        FormNo := '';
    end;

    var
        VendorNo: Code[20];
        SelectAll: Boolean;
        FormNo: Code[10];
        VendorList: Page "Vendor List";
        FromDate: Date;
        ToDate: Date;
        //  TaxFormDetails: Record 13757;
        // FormTaxFormDetails: Page 13782;
        //  TFD: Record 13757;
        BuyFromVendor: Code[10];
        Bool: Boolean;
        Text001: Label 'You cannot issue the same form to different vendors.';
        cnt: Integer;
        bool1: Boolean;
        Vendor: Record Vendor;
        bool3: Boolean;
        //  FormCodes: Record 13756;
        FormCode1: Text[250];
        Bool4: Boolean;
        StateVar: Code[10];
        EmpCode: Code[10];
        NetAmt: Decimal;

    local procedure VendorNoOnAfterValidate()
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
    end;
}

