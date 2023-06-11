pageextension 50183 pageextension50183 extends "Sales Credit Memo"
{
    layout
    {
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            begin
                if Rec."Sell-to Customer No." <> xRec."Sell-to Customer No." then begin
                    Rec."Trade Discount" := 0;
                    Rec."Structure Freight Amount" := 0;
                    Rec."Discount Amount" := 0;
                    Rec."Insurance Amount" := 0;

                    CurrPage.Update;
                end;
            end;
        }
        modify("Currency Code")
        {
            trigger OnAssistEdit()
            begin
                CurrPage.Update();
            end;

        }
        moveafter("Sell-to Contact"; "Location Code")
        moveafter("Salesperson Code"; "Reference Invoice No.", "Sale Return Type")
        moveafter(Status; "Your Reference", "Campaign No.")
        modify("Campaign No.")
        {
            Importance = Additional;
        }
        addafter(Status)
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
            }
            field("Transport meathod"; Rec."Shipping Agent Code")
            {
                Caption = 'Transport meathod';
                ApplicationArea = All;
            }
            field("GST Reason Type"; Rec."GST Reason Type")
            {
                ApplicationArea = All;
            }

        }
        addafter("Bill-to Contact")
        {
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
        }
        addbefore("Currency Code")
        {
            field("Structure Freight Amount"; Rec."Structure Freight Amount")
            {
                ApplicationArea = All;
            }
            field("Trade Discount"; Rec."Trade Discount")
            {
                ApplicationArea = All;
            }
            field("Insurance Amount"; Rec."Insurance Amount")
            {
                ApplicationArea = All;
            }
            field("Discount Amount"; Rec."Discount Amount")
            {
                ApplicationArea = All;
                Caption = 'Cash Discount';
            }
            field("Invoice Discount Amount"; Rec."Invoice Discount Amount")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }

    }
    actions
    {

        addafter(CopyDocument)
        {
            action("Update Reference Invoice No")
            {
                Caption = 'Update Reference Invoice No';
                Image = ApplyEntries;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                /*    trigger OnAction()
                    var
                        ReferenceInvoiceNo: Record "Reference Invoice No.";
                        UpdateReferenceInvoiceNo: Page "Update Reference Invoice No";
                    begin
                        IF GSTManagement.IsGSTApplicable(Structure) THEN BEGIN
                            Rec.CALCFIELDS("Price Inclusive of Taxes");
                            IF "Price Inclusive of Taxes" THEN BEGIN
                                SalesLine.InitStrOrdDetail(Rec);
                                SalesLine.GetSalesPriceExclusiveTaxes(Rec);
                                SalesLine.UpdateSalesLinesPIT(Rec);
                            END;
                            SalesLine.CalculateStructures(Rec);
                            SalesLine.AdjustStructureAmounts(Rec);
                            SalesLine.UpdateSalesLines(Rec);

                            ReferenceInvoiceNo.RESET;
                            ReferenceInvoiceNo.SETRANGE("Document No.", Rec."No.");
                            ReferenceInvoiceNo.SETRANGE("Document Type", Rec."Document Type");
                            ReferenceInvoiceNo.SETRANGE("Source No.", Rec."Bill-to Customer No.");
                            UpdateReferenceInvoiceNo.CustomerRecord(ReferenceInvoiceNo."Source Type"::Customer);
                            UpdateReferenceInvoiceNo.SETTABLEVIEW(ReferenceInvoiceNo);
                            UpdateReferenceInvoiceNo.RUN;
                        END ELSE
                            ERROR(ReferenceInvoiceNoErr);
                    end;*/
            }
        }
    }

    var
        UserLocation: Record "User Location";
        LocationFilterString: Text[1024];
        "---TRI TDS": Integer;
        RecSalesLine: Record "Sales Line";
        str: Text[30];

    trigger OnAfterGetRecord()
    begin
        rec.VALIDATE("Posting No.", rec."No.");
    end;

    trigger OnOpenPage()
    begin
        //TRI SC
        //ND Tri Start Cust 38
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."View Sales Credit memo", '%1', TRUE);
        IF UserLocation.FIND('-') THEN
            REPEAT
                IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                    LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
            UNTIL UserLocation.NEXT = 0;

        LocationFilterString := COPYSTR(LocationFilterString, 2, 1024);

        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');

        rec.FILTERGROUP(2);
        rec.SETFILTER("Location Code", LocationFilterString);
        rec.FILTERGROUP(0);
        //ND Tri End Cust 38
        //TRI SC

    end;


}

