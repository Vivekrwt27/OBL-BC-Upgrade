pageextension 50432 pageextension50432 extends "Purchase Invoice"
{
    layout
    {

        moveafter("Buy-from Vendor No."; "Location Code")
        moveafter("Buy-from Address 2"; "Buy-from Post Code")
        modify("Buy-from Post Code")
        {
            Importance = Additional;
            // TableRelation = "Post Code";
        }
        addafter("Buy-from City")
        {
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Posting No. Series"; "Bill of Entry No.", "Bill of Entry Date", "Bill of Entry Value", "GST Vendor Type", "Assigned User ID")
        addafter("Posting No. Series")
        {
            field("Vendor Classification"; Rec."Vendor Classification")
            {
                ApplicationArea = All;
            }

            field(gstregistration; gstregistration)
            {
                Caption = 'GST Registration No.';
                Editable = false;
                Importance = Promoted;
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }

        }
        moveafter("Document Date"; "Shortcut Dimension 2 Code", "Payment Terms Code", "Payment Discount %", "Vendor Invoice No.")
        modify("Vendor Invoice No.")
        {
            trigger OnAfterValidate()
            begin
                IF (STRLEN(Rec."Vendor Invoice No.") > 16) THEN
                    ERROR('Invoice No Cannot Be Greater then 16 Charactor');

            end;
        }
        addafter("Document Date")
        {
            field("GRN Date"; Rec."GRN Date")
            {
                Editable = false;
                ApplicationArea = All;
            }

            field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    IF Rec."Vendor Invoice Date" < 20180104D THEN//040118D
                        ERROR('Check Vendor Invoice Date');
                end;
            }
            field("Due Date Calc. On"; Rec."Due Date Calc. On")
            {
                ApplicationArea = All;
            }
            field("Nature of Expense"; Rec.NOE)
            {
                Editable = true;
                ApplicationArea = All;
            }
            /*field("Form Code"; "Form Code")//16225 field N/F
            {
            }*/
            field("<Pposting No. Series>"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Incoming Document Entry No."; "Purchaser Code", Status, "Buy-from Contact No.", "Due Date")
        addafter("Incoming Document Entry No.")
        {
            field(Narration; Rec."Posting Description")
            {
                Caption = 'Narration';
                Visible = false;
                ApplicationArea = All;
            }
            field("Narration 1"; Rec."Posting Description New")
            {
                Caption = 'Narration 1';
                ApplicationArea = all;
                trigger OnValidate()
                var
                begin
                    if StrLen(Rec."Posting Description New") <= 100 then
                        Rec.Validate("Posting Description", Rec."Posting Description New")
                    else
                        Rec.Validate("Posting Description", CopyStr(Rec."Posting Description New", 1, 100));
                end;
            }

        }
        addafter("Pay-to Contact")
        {
            /* field("Form No."; "Form No.")//16225 field N/F
             {
             }*/
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
            /* field(PoT; PoT)//16225 field N/F
             {
             }*/
        }
        addafter("VAT Bus. Posting Group")
        {
            field("<Vvendor Invoice No.>"; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
            }
            field("<Vvendor Invoice Date>"; Rec."Vendor Invoice Date")
            {
                Caption = '<Vendor Invoice Date>';
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    UpdateDueDate;//MSBS.Rao 290914
                end;
            }
        }
        addafter("Ship-to Contact")
        {
            field("Transporter's Code"; Rec."Transporter's Code")
            {
                ApplicationArea = All;
            }
            field("Transporter Name"; Rec."Transporter Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Expected Receipt Date")
        {
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            /* field("Vendor Shipment Date"; "Vendor Shipment Date")//16225 field N/F
             {
                 Editable = false;
             }*/
        }
        addafter("Applies-to ID")
        {
            field("<Oon Hold>"; Rec."On Hold")
            {
                ApplicationArea = All;
            }
        }
        //16225 Table Field N/F Start
        /*   addafter("Control 1500040")
           {
               field("<Cc Form>"; "C Form")
               {
               }
               field("<Fform Code>"; "Form Code")
               {
               }
               field("<Fform No.>"; "Form No.")
               {
               }
           }
           addafter("Control 1500052")
           {
               field("<PdoT>"; PoT)
               {
               }
           }*/ //16225 Table Field N/F End
    }
    actions
    {
        modify("Re&lease")
        {
            trigger OnBeforeAction()
            begin
                Rec.TESTFIELD("Due Date Calc. On");
                PurchLine.RESET;
                PurchLine.SETFILTER("Document Type", '%1', Rec."Document Type");
                PurchLine.SETFILTER("Document No.", '%1', Rec."No.");
                PurchLine.SETFILTER(Type, '%1|%2|%3|%4', PurchLine.Type::Item, PurchLine.Type::"G/L Account", PurchLine.Type::"Fixed Asset", PurchLine.Type::"Charge (Item)");
                //PurchLine.SETFILTER("ITC Type",'%1',PurchLine."ITC Type"::" ");
                IF PurchLine.FINDFIRST THEN BEGIN
                    REPEAT
                        //Kulbhushan Sharma
                        IF (PurchLine."No." = '21013000') AND (PurchLine."Capex No." = '') THEN
                            ERROR('Please Enter the Capex No.');

                        IF PurchLine."ITC Type" = 0 THEN
                            ERROR('Please Check ITC type for Line No. %1 ITC %2', PurchLine."Line No.", PurchLine."ITC Type");
                    UNTIL PurchLine.NEXT = 0;
                END;

                IF vendorrec.GET(Rec."Buy-from Vendor No.") THEN BEGIN
                    IF ((vendorrec."Micro Enterprises" = TRUE) OR (vendorrec."Small Enterprises" = TRUE) OR (vendorrec."Medium Enterprises" = TRUE)) THEN
                        IF (Rec."Vendor Invoice Date" < TODAY - 30) THEN
                            ERROR('MSME Vendor Invoice Date Cannot be Greater Then 30 Days')
                END;

                IF vendorrec.GET(Rec."Buy-from Vendor No.") THEN BEGIN
                    IF ((vendorrec."Micro Enterprises" = FALSE) OR (vendorrec."Small Enterprises" = FALSE) OR (vendorrec."Medium Enterprises" = FALSE)) THEN
                        IF (Rec."Vendor Invoice Date" < TODAY - 160) THEN
                            ERROR('Vendor Invoice Date Cannot be Greater Then 60 Days')

                END;

            end;
        }

        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                Rec.TESTFIELD(Status, Rec.Status::Released);
                // NAVIN
                /* IF Structure <> '' THEN BEGIN//16225
                     PurchLine.CalculateStructures(Rec);
                     PurchLine.AdjustStructureAmounts(Rec);
                     PurchLine.UpdatePurchLines(Rec);
                     COMMIT;
                 END;*/
                // NAVI
                IF Rec."Posting Date" > TODAY THEN
                    ERROR('You can not post the Bill with Posting Date Prior today'); //6700
                IF Rec."Vendor Invoice Date" > Rec."Posting Date" THEN
                    ERROR('You can not post the Bill with earlier Vendor Invoice Date'); //6700

            end;
        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            begin
                // NAVIN
                Rec.TESTFIELD(Status, Rec.Status::Released);
                /*IF Structure <> '' THEN BEGIN//16225
                    PurchLine.CalculateStructures(Rec);
                    PurchLine.AdjustStructureAmounts(Rec);
                    PurchLine.UpdatePurchLines(Rec);
                    COMMIT;
                END;*/
                // NAVIN

            end;
        }

        addafter(Approvals)
        {


            action(Orders)
            {
                Caption = 'Orders';
                Image = Document;
                Promoted = true;
                RunObject = Page "Purchase Order List";
                RunPageLink = "Buy-from Vendor No." = FIELD("Buy-from Vendor No.");
                RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
                ApplicationArea = All;
            }


        }
        addafter(Orders)
        {
            action("Return Order")
            {
                Caption = 'Return Order';
                RunObject = Page "Purchase List";
                RunPageLink = "Buy-from Vendor No." = FIELD("Buy-from Vendor No."),
                              "Document Type" = CONST("Return Order");
                RunPageView = SORTING("Buy-from Vendor No.");
                ApplicationArea = All;
            }
        }
        addafter("F&unctions")
        {
            action("&Get Receipt Lines")
            {
                Caption = '&Get Receipt Lines';
                Ellipsis = true;
                ShortCutKey = 'Ctrl+R';
                ApplicationArea = All;

                trigger OnAction()
                var
                    PurchaseLines: Record "Purchase Line";
                begin
                    CurrPage.PurchLines.PAGE.GetReceipt;
                    //ND Start
                    PurchaseLines.RESET;
                    PurchaseLines.SETFILTER(PurchaseLines."Document Type", '%1', Rec."Document Type");
                    PurchaseLines.SETFILTER(PurchaseLines."Document No.", '%1', Rec."No.");
                    PurchaseLines.SETFILTER(PurchaseLines."Location Code", '<>%1', '');
                    IF PurchaseLines.FIND('-') THEN
                        REPEAT
                            PurchaseLines.VALIDATE(PurchaseLines."Location Code", PurchaseLines."Location Code");
                        UNTIL PurchaseLines.NEXT = 0;
                    //ND End;
                end;
            }
        }
        addafter(CopyDocument)
        {
            action("Update Reference Invoice No")
            {
                Caption = 'Update Reference Invoice No';
                Image = ApplyEntries;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ReferenceInvoiceNo: Record "Reference Invoice No.";
                    UpdateReferenceInvoiceNo: Page "Update Reference Inv. Journals";
                begin
                    /*IF GSTManagement.IsGSTApplicable(Structure) THEN BEGIN//16225 Codeunit N/F Start
                      IF NOT (Rec."Invoice Type" IN [Rec."Invoice Type"::"Debit Note",Rec."Invoice Type"::Supplementary]) THEN
                        ERROR(ReferenceNoErr);

                      PurchLine.CalculateStructures(Rec);
                      PurchLine.AdjustStructureAmounts(Rec);
                      PurchLine.UpdatePurchLines(Rec);

                      ReferenceInvoiceNo.RESET;
                      ReferenceInvoiceNo.SETRANGE("Document No.",Rec."No.");
                      ReferenceInvoiceNo.SETRANGE("Document Type","Document Type");
                      ReferenceInvoiceNo.SETRANGE("Source No.",Rec."Pay-to Vendor No.");
                      UpdateReferenceInvoiceNo.CustomerRecord(ReferenceInvoiceNo."Source Type"::Vendor);
                      UpdateReferenceInvoiceNo.SETTABLEVIEW(ReferenceInvoiceNo);
                      UpdateReferenceInvoiceNo.RUN;
                    END ELSE
                      ERROR(ReferenceInvoiceNoErr);*///16225 Codeunit N/F End
                end;
            }
        }
        addafter(Preview)
        {
            action("Freight Voucher")
            {
                Caption = '&Freight Voucher';
                Promoted = true;
                PromotedCategory = Category6;
                ApplicationArea = All;

                trigger OnAction()
                var
                    PILine: Record "Purchase Line";
                    FreightVoucher: Report "Freight Voucher1";
                begin
                    PILine.RESET;
                    PILine.SETFILTER(PILine."Document No.", Rec."No.");
                    IF PILine.FIND('-') THEN BEGIN
                        FreightVoucher.SETTABLEVIEW(PILine);
                        FreightVoucher.RUN;
                    END;
                end;
            }
        }
        addafter(Preview)
        {
            action("&Freight Voucher")
            {
                Caption = '&Freight Voucher';
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PILine.RESET;
                    PILine.SETFILTER(PILine."Document No.", Rec."No.");
                    IF PILine.FIND('-') THEN BEGIN
                        FreightVoucher.SETTABLEVIEW(PILine);
                        FreightVoucher.RUN;
                    END;
                end;
            }
        }
    }

    var
        "-- NAVIN --": Integer;
        WFAmount: Decimal;
        WFPurchLine: Record "Purchase Line";
        LineNo: Integer;
        IsValid: Boolean;
        ReleasePurchaseDocument: Codeunit "Release Purchase Document";
        UserSetup: Record "User Setup";
        UserLocation: Record "User Location";
        LocationFilterString: Text[250];
        PILine: Record "Purchase Line";
        FreightVoucher: Report "Production Planning Report";
        PaymentTerms: Record "Payment Terms";
        PurchLine: Record "Purchase Line";

        gstregistration: Code[15];
        vend: Record Vendor;
        // "--NAVIN--": ;
        Text13000: Label 'No Setup exists for this Amount.';
        Text13001: Label 'Do you want to send the Invoice for Authorization?';
        Text13002: Label 'The Invoice Is Authorized, You Cannot Resend For Authorization';
        Text13003: Label 'You Cannot Resend For Authorization';
        Text13004: Label 'This Invoice Has been Rejected. Please Create A New Invoice.';

    var
        vendorrec: Record Vendor;

    trigger OnAfterGetRecord()
    begin
        IF vend.GET(Rec."Buy-from Vendor No.") THEN
            gstregistration := vend."GST Registration No.";

    end;

    trigger OnOpenPage()
    begin
        //TRI SC
        //ND Tri Start Cust 38
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."View Purchase Invoice", '%1', TRUE);
        IF UserLocation.FIND('-') THEN
            REPEAT
                IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                    LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
            UNTIL UserLocation.NEXT = 0;

        LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');

        Rec.FILTERGROUP(2);
        //SETFILTER("Location Code",LocationFilterString);
        Rec.FILTERGROUP(0);

        //ND Tri End Cust 38
        //TRI SC

    end;

    procedure UpdateDueDate()
    begin
        IF (Rec."Payment Terms Code" <> '') AND (Rec."Vendor Invoice Date" <> 0D) THEN BEGIN
            PaymentTerms.GET(Rec."Payment Terms Code");
            IF ((Rec."Document Type" IN [Rec."Document Type"::Invoice]))
            THEN
                Rec."Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", Rec."Vendor Invoice Date");
        END;
    end;

    local procedure UpdatePage()
    begin
        CurrPage.UPDATE;
    end;
}

