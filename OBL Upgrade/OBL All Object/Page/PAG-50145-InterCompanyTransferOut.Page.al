page 50145 "Inter Company Transfer - Out"
{
    Caption = 'Inter Company Transfer - Out';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER(Invoice),
                            "Inter Company" = FILTER(true));

    UsageCategory = Lists;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //MS-PB To Filter IC Customer BEGIN
                        Customer.FINDFIRST;
                        Customer.SETFILTER("IC Partner Code", '<>%1', '');
                        IF PAGE.RUNMODAL(Page::"Customer List", Customer) = ACTION::LookupOK THEN BEGIN
                            Rec.VALIDATE("Sell-to Customer No.", Customer."No.");
                            //CustomerList.CAPTION:='1,5,,' + 'IC Partner List';
                        END;

                        //END;
                    end;

                    trigger OnValidate()
                    begin
                        //SelltoCustomerNoOnAfterValidate;
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    Caption = 'Sell-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = All;
                }
                //16225 field N/F
                /* field(Structure; Structure)
                 {
                     ApplicationArea = All;
                 }*/
                field("Posting No."; Rec."Posting No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Other Comp. Location"; Rec."Other Comp. Location")
                {
                    Caption = 'Transfer To Other Comp. Location';
                    MultiLine = true;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //MS-PB To Filter IC Customer BEGIN
                        ICPartner.RESET;
                        ICPartner.SETRANGE("Inbox Type", ICPartner."Inbox Type"::Database);
                        ICPartner.SETRANGE(Code, Rec."Sell-to IC Partner Code");
                        IF ICPartner.FINDFIRST THEN BEGIN
                            IF Rec."Sell-to IC Partner Code" <> '' THEN BEGIN
                                OtherCompLocation.RESET;
                                OtherCompLocation.CHANGECOMPANY(ICPartner."Inbox Details");
                                OtherCompLocation.SETFILTER("User ID", '%1', USERID);
                                IF PAGE.RUNMODAL(Page::"User Locations", OtherCompLocation) = ACTION::LookupOK THEN
                                    Rec.VALIDATE("Other Comp. Location", OtherCompLocation."Location Code");
                            END ELSE
                                ERROR(Text0005);
                        END;
                        //END;
                    end;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Inter Company"; Rec."Inter Company")
                {
                    ApplicationArea = All;
                }
            }
            part(SalesLines; "Sales Invoice Subform-IC")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(CustInfoPanel)
            {
                Caption = 'Customer Information';
                label("")
                {
                    CaptionClass = Text19070588;
                    ApplicationArea = All;
                }
                //16225  field(Cont00005; STRSUBSTNO('(%1)', SalesInfoPaneMgt.CalcNoOfShipToAddr(Rec."Sell-to Customer No.")))
                field(Cont00005; STRSUBSTNO('(%1)', (Rec."Sell-to Customer No.")))
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                //16225 field(Cont00006; STRSUBSTNO('(%1)', SalesInfoPaneMgt.CalcNoOfContacts(Rec)))
                field(Cont00006; STRSUBSTNO('(%1)', (Rec)))
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                label(group)
                {
                    CaptionClass = Text19069283;
                    ApplicationArea = All;

                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //BilltoCustomerNoOnAfterValidate;
                        BilltoCustomerNoOnAfterValidat
                    end;
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    Caption = 'Bill-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //ShortcutDimension1CodeOnAfterValidate;
                        ShortcutDimension1CodeOnAfterV
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //ShortcutDimension2CodeOnAfterValidate;
                        ShortcutDimension2CodeOnAfterV
                    end;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //PricesIncludingVATOnAfterValidate;
                        PricesIncludingVATOnAfterValid
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrencyCodeOnAfterValidate;
                    end;
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = All;
                }

                field("Area"; Rec."Area")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the country or region of origin for the purpose of Intrastat reporting.';
                }
            }
            group(Application)
            {
                Caption = 'Application';
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = All;
                }
            }
            group("Tax Information")
            {
                Caption = 'Tax Information';
                field(Trading; Rec.Trading)
                {
                    ApplicationArea = All;
                }
                //16225 fIELD N/F
                /*  field("Transit Document"; "Transit Document")
                  {
                  }
                  field("TDS Certificate Receivable"; Rec."TDS Certificate Receivable")
                  {
                  }
                  field("Export or Deemed Export"; "Export or Deemed Export")
                  {
                  }
                  field("VAT Exempted"; "VAT Exempted")
                  {
                  }
                  field("Calc. Inv. Discount (%)"; "Calc. Inv. Discount (%)")
                  {
                  }
                  field("Free Supply"; "Free Supply")
                  {
                  }
                  field("ST Pure Agent"; "ST Pure Agent")
                  {
                  }
                  field("Re-Dispatch"; "Re-Dispatch")
                  {

                      trigger OnValidate()
                      begin
                          IF "Re-Dispatch" THEN
                              ReturnOrderNoEnable := TRUE
                          ELSE
                              ReturnOrderNoEnable := FALSE;
                      end;
                  }
                  field(ReturnOrderNo; "Return Re-Dispatch Rcpt. No.")
                  {
                      Caption = 'Return Receipt No.';
                      Enabled = ReturnOrderNoEnable;
                      Visible = ReturnOrderNoVisible;
                  }
                  field("LC No."; "LC No.")
                  {
                  }
                  field("Form Code"; "Form Code")
                  {
                  }
                  field("Form No."; "Form No.")
                  {
                  }
                  field("Service Tax Rounding Precision"; "Service Tax Rounding Precision")
                  {
                  }
                  field("Service Tax Rounding Type"; "Service Tax Rounding Type")
                  {
                  }*/
                field("Time of Removal"; Rec."Time of Removal")
                {
                    Caption = 'Time of Removal';
                    ApplicationArea = All;
                }
                field("Mode of Transport"; Rec."Mode of Transport")
                {
                    Caption = 'Mode of Transport';
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    Caption = 'Vehicle No.';
                    ApplicationArea = All;
                }
                field("LR/RR No."; Rec."LR/RR No.")
                {
                    Caption = 'LR/RR No.';
                    ApplicationArea = All;
                }
                field("LR/RR Date"; Rec."LR/RR Date")
                {
                    Caption = 'LR/RR Date';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        SalesSetup.GET;
                        //16225 Start
                        /* CALCFIELDS("Price Inclusive of Taxes");
                         IF SalesSetup."Calc. Inv. Discount" AND (NOT "Price Inclusive of Taxes") THEN BEGIN
                             Rec.CalcInvDiscForHeader;
                             COMMIT;
                         END;
                         IF "Price Inclusive of Taxes" THEN BEGIN
                             SalesLine.InitStrOrdDetail(Rec);
                             SalesLine.GetSalesPriceExclusiveTaxes(Rec);
                             SalesLine.UpdateSalesLinesPIT(Rec);
                             COMMIT;
                         END;*///16225 End
                               //16225 Start
                               /*IF Rec.Structure <> '' THEN BEGIN
                                   SalesLine.CalculateStructures(Rec);
                                   SalesLine.AdjustStructureAmounts(Rec);
                                   SalesLine.UpdateSalesLines(Rec);
                                   SalesLine.CalculateTCS(Rec);
                                   COMMIT;
                               END ELSE BEGIN
                                   SalesLine.CalculateTCS(Rec);
                                   COMMIT;
                               END;*///16225 end
                        PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec);
                    end;
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        //  ApprovalEntries.Setfilters(DATABASE::"Sales Header", Rec."Document Type", Rec."No.");
                        //ApprovalEntries.RUN;
                    end;
                }
                action("St&ructure")
                {
                    ApplicationArea = All;
                    //16225 Page N/F
                    /* Caption = 'St&ructure';
                     RunObject = Page 16305;
                                     RunPageLink = Type=CONST(Sale),
                                   Document Type=FIELD(Document Type),
                                   Document No.=FIELD(No.),
                                   Structure Code=FIELD(Structure),
                                   Document Line No.=FILTER(0);*/
                }
                action("Transit Documents")
                {
                    ApplicationArea = All;
                    //16225 PAGE N/F
                    /*  Caption = 'Transit Documents';
                      RunObject = Page 13705;
                      RunPageLink = Type = CONST(Sale),
                                  "PO / SO No." = FIELD("No."),
                                  "Vendor / Customer Ref." = FIELD("Sell-to Customer No.");
                      Visible = false;*/
                }
                action("Detailed &Tax")
                {
                    ApplicationArea = All;
                    //16225 PAGE N/F
                    /* Caption = 'Detailed &Tax';
                     RunObject = Page 16342;
                     RunPageLink = "Document Type" = FIELD("Document Type"),
                                   "Document No." = FIELD("No."),
                                   "Transaction Type" = CONST(Sale);*/
                }
                action("Calculate Tax On MRP")
                {
                    Caption = 'Calculate Tax On MRP';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        "--------tri-rk----------": Integer;
                        //16225 structureheader: Record 13792;
                        SalesLineRec: Record "Sales Line";
                    begin
                        //trident-rakesh-start
                        //16225 table N/F Start
                        /*  IF structureheader.GET(Structure) THEN BEGIN
                              IF structureheader."Tax Abatement" THEN BEGIN
                                  IF "Abatement Required" THEN BEGIN
                                      SalesLine.CalculateStructures(Rec);
                                      SalesLineRec.RESET;
                                      SalesLineRec.SETCURRENTKEY("Document Type", "Document No.");
                                      SalesLineRec.SETRANGE("Document Type", "Document Type");
                                      SalesLineRec.SETRANGE("Document No.", "No.");
                                      IF SalesLineRec.FIND('-') THEN
                                          REPEAT
                                              IF SalesLineRec."MRP Price" <> 0 THEN
                                                  SalesLineRec."Unit Price" := SalesLineRec."MRP Price" - (SalesLineRec."MRP Price" * SalesLineRec."Tax %") / 100;
                                              SalesLineRec.MODIFY;
                                          UNTIL SalesLineRec.NEXT = 0;
                                      SalesLine.CalculateStructures(Rec);
                                  END;
                              END;
                          END;*///16225 table N/F End
                                //16225 IF NOT (structureheader."Tax Abatement" AND "Abatement Required") THEN
                                //16225   MESSAGE('Please check the Abatement Required Field');
                                //trident-rakesh-end
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                action(Structure)
                {
                    Caption = 'Structure';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        //16225     StructureOrderDetail: Record 13794;
                        SalesLine2: Record "Sales Line";
                    begin
                        //16225    CurrPage.SalesLines.PAGE.ShowStrOrderDetailsPITForm;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //16225 Field N/F Start
                        /*  CALCFIELDS("Price Inclusive of Taxes");
                          IF NOT "Price Inclusive of Taxes" THEN
                              ApproveCalcInvDisc
                          ELSE
                              ERROR(STRSUBSTNO(Text16500, FIELDCAPTION("Price Inclusive of Taxes")));*///16225 Field N/F End
                    end;
                }
                action("Get St&d. Cust. Sales Codes")
                {
                    Caption = 'Get St&d. Cust. Sales Codes';
                    Ellipsis = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        StdCustSalesCode: Record "Standard Customer Sales Code";
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }
                action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL;
                        CLEAR(CopySalesDoc);
                    end;
                }
                action("Move Negative Lines")
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RUNMODAL;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        // 16225 IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;

                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //16225  IF ApprovalMgt.CancelSalesApprovalRequest(Rec, TRUE, TRUE) THEN;
                    end;
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                        "...tri1.0": Integer;
                        SalesLine1: Record "Sales Line";
                        DateFilter: Text[30];
                        SalesLine2: Record "Sales Line";
                        Item: Record Item;
                        AvailableQuantity: Decimal;
                    begin
                        //mo tri1.0 customization no. start
                        Rec.TESTFIELD("Sell-to Post Code");
                        SalesLine1.RESET;
                        SalesLine1.SETRANGE("Document Type", Rec."Document Type");
                        SalesLine1.SETRANGE("Document No.", Rec."No.");
                        SalesLine1.SETFILTER(Type, '>0');
                        SalesLine1.SETFILTER(Quantity, '<>0');
                        SalesLine1.SETFILTER("Unit Price", '%1', 0);
                        IF SalesLine1.FIND('-') THEN
                            ERROR(Text0004, SalesLine1.Type, SalesLine1."No.");
                        //mo tri1.0 customization no. end

                        //mo tri1.0 Customization no.45 start
                        DateFilter := '..' + FORMAT(Rec."Posting Date");
                        SalesLine2.RESET;
                        SalesLine2.SETRANGE("Document Type", Rec."Document Type");
                        SalesLine2.SETRANGE("Document No.", Rec."No.");
                        SalesLine2.SETRANGE(Type, SalesLine2.Type::Item);
                        SalesLine2.SETFILTER(Quantity, '<>0');
                        IF SalesLine2.FIND('-') THEN
                            REPEAT
                                SalesLine2.CALCFIELDS("Reserved Quantity");
                                IF (SalesLine2."Reserved Quantity" < SalesLine2.Quantity) THEN BEGIN
                                    Item.RESET;
                                    Item.SETFILTER("No.", SalesLine2."No.");
                                    Item.SETFILTER("Date Filter", DateFilter);
                                    IF Item.FIND('-') THEN BEGIN
                                        Item.CALCFIELDS("Net Change", "Reserved Qty. on Inventory");
                                        AvailableQuantity := Item."Net Change" - Item."Reserved Qty. on Inventory";
                                    END;
                                    IF (SalesLine2.Quantity > AvailableQuantity) THEN
                                        ERROR(Text0001);
                                END;
                            UNTIL SalesLine2.NEXT = 0;
                        //mo tri1.0 Customization no.45 end;

                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
                action("Calculate Str&ucture Values")
                {
                    Caption = 'Calculate Str&ucture Values';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //16225 Field & Funcation N/F Start
                        /* CALCFIELDS("Price Inclusive of Taxes");
                         IF "Price Inclusive of Taxes" THEN BEGIN
                             SalesLine.InitStrOrdDetail(Rec);
                             SalesLine.GetSalesPriceExclusiveTaxes(Rec);
                             SalesLine.UpdateSalesLinesPIT(Rec);
                         END;

                         SalesLine.CalculateStructures(Rec);
                         SalesLine.AdjustStructureAmounts(Rec);
                         SalesLine.UpdateSalesLines(Rec);*///16225 Field & Funcation N/F End
                    end;
                }
                action("Calculate TCS")
                {
                    Caption = 'Calculate TCS';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //16225 Funcation N/F start
                        /* SalesLine.CalculateStructures(Rec);
                         SalesLine.AdjustStructureAmounts(Rec);
                         SalesLine.UpdateSalesLines(Rec);
                         SalesLine.CalculateTCS(Rec);*///16225 Funcation N/F End
                    end;
                }
                action("Direct Debit To PLA / RG")
                {
                    Caption = 'Direct Debit To PLA / RG';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //16225 Funcation N/F start
                        /*  SalesLine.CalculateStructures(Rec);
                          SalesLine.AdjustStructureAmounts(Rec);
                          SalesLine.UpdateSalesLines(Rec);
                          OpenExciseCentvatClaimForm;*///16225 Funcation N/F End
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
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
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
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        // NAVIN
                        //16225 Field & Funaction N/F Start
                        /*  IF Structure <> '' THEN BEGIN
                              SalesLine.CalculateStructures(Rec);
                              SalesLine.AdjustStructureAmounts(Rec);
                              SalesLine.UpdateSalesLines(Rec);
                              COMMIT;
                          END;*///16225 Field & Funaction N/F End

                        //16225 IF ApprovalMgt.PrePostApprovalCheck(Rec, PurchaseHeader) THEN
                        IF ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) THEN
                            CODEUNIT.RUN(CODEUNIT::"Sales-Post (Yes/No)", Rec);
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
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //16225 IF ApprovalMgt.PrePostApprovalCheck(Rec, PurchaseHeader) THEN
                        IF ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) THEN
                            CODEUNIT.RUN(CODEUNIT::"Sales-Post + Print", Rec);
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Invoices", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            action(SalesHistoryBtn)
            {
                Caption = 'Sales Histo&ry';
                Promoted = true;
                PromotedCategory = Process;
                Visible = SalesHistoryBtnVisible;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //SalesInfoPaneMgt.LookupCustSalesHistory(Rec,"Bill-to Customer No.",TRUE);      //code blocked for upgrade         //function not available
                end;
            }
            action("&Avail. Credit")
            {
                Caption = '&Avail. Credit';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //16225  SalesInfoPaneMgt.LookupAvailCredit(Rec."Bill-to Customer No.");
                end;
            }
            action(SalesHistoryStn)
            {
                Caption = 'Sales Histor&y';
                Promoted = true;
                PromotedCategory = Process;
                Visible = SalesHistoryStnVisible;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //SalesInfoPaneMgt.LookupCustSalesHistory(Rec,"Sell-to Customer No.",FALSE);
                end;
            }
            action("&Contacts")
            {
                Caption = '&Contacts';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //16225   SalesInfoPaneMgt.LookupContacts(Rec);
                end;
            }
            action("Ship&-to Addresses")
            {
                Caption = 'Ship&-to Addresses';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //16225  SalesInfoPaneMgt.LookupShipToAddr(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /* IF "Re-Dispatch" THEN
             ReturnOrderNoVisible := TRUE
         ELSE
             ReturnOrderNoVisible := FALSE;*/
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(Rec.ConfirmDeletion);
    end;

    trigger OnInit()
    begin
        SalesHistoryStnVisible := TRUE;
        BillToCommentBtnVisible := TRUE;
        BillToCommentPictVisible := TRUE;
        SalesHistoryBtnVisible := TRUE;
        ReturnOrderNoEnable := TRUE;
        ReturnOrderNoVisible := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetSalesFilter;
        Rec."Inter Company" := TRUE;
    end;

    trigger OnOpenPage()
    begin

        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter);
            Rec.FILTERGROUP(0);
        END;
        //TRI S.R
        //ND Tri Start Cust 38
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."View Sales Invoice", '%1', TRUE);
        IF UserLocation.FIND('-') THEN
            REPEAT
                IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                    LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
            UNTIL UserLocation.NEXT = 0;

        LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');

        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Location Code", LocationFilterString);
        Rec.FILTERGROUP(0);
        //ND Tri End Cust 38

        //TRI S.R
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        CopySalesDoc: Report "Copy Sales Document";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        SalesLine: Record "Sales Line";
        Text16500: Label 'To calculate invoice discount, check Cal. Inv. Discount on header when Price Inclusive of Tax = Yes.\This option cannot be used to calculate invoice discount when Price Inclusive Tax = Yes.';
        //"tri1.0": ;
        Text0001: Label 'Sufficient Inventory not available.';
        Text0004: Label 'Unit Price of %1 %2 must not be zero while Release.';
        UserLocation: Record "User Location";
        LocationFilterString: Text[250];
        Customer: Record Customer;
        OtherCompLocation: Record "User Location";
        ICPartner: Record "IC Partner";
        Text0005: Label 'Not Applicable for Selected Customer';
        [InDataSet]
        ReturnOrderNoVisible: Boolean;
        [InDataSet]
        ReturnOrderNoEnable: Boolean;
        [InDataSet]
        SalesHistoryBtnVisible: Boolean;
        [InDataSet]
        BillToCommentPictVisible: Boolean;
        [InDataSet]
        BillToCommentBtnVisible: Boolean;
        [InDataSet]
        SalesHistoryStnVisible: Boolean;
        Text19070588: Label 'Sell-to Customer';
        Text19069283: Label 'Bill-to Customer';
        ChangeExchangeRate: Page "Change Exchange Rate";

    local procedure UpdateInfoPanel()
    var
        DifferSellToBillTo: Boolean;
    begin
        DifferSellToBillTo := Rec."Sell-to Customer No." <> Rec."Bill-to Customer No.";
        SalesHistoryBtnVisible := DifferSellToBillTo;
        BillToCommentPictVisible := DifferSellToBillTo;
        BillToCommentBtnVisible := DifferSellToBillTo;
        //16225 SalesHistoryStnVisible := SalesInfoPaneMgt.DocExist(Rec, "Sell-to Customer No.");

        IF DifferSellToBillTo THEN;
        //16225 SalesHistoryBtnVisible := SalesInfoPaneMgt.DocExist(Rec, "Bill-to Customer No.")
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;

    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;
}

