pageextension 50237 pageextension50237 extends "Purchase Credit Memo"
{
    layout
    {

        modify("Vendor Cr. Memo No.")
        {
            trigger OnBeforeValidate()
            begin
                IF (STRLEN(rec."Vendor Cr. Memo No.") > 16) THEN
                    ERROR('Cannot Greator Or Less then Sixteen Digit');

            end;
        }
        modify("Currency Code")
        {
            trigger OnAssistEdit()
            begin
                CurrPage.Update();
            end;
        }
        addafter(Status)
        {
            field("Posting Description New"; Rec."Posting Description New")
            {
                ApplicationArea = all;
            }
        }
        moveafter("Buy-from Post Code"; "Location Code")
        moveafter("Buy-from Contact"; "Posting Description")
        moveafter("Vendor Cr. Memo No."; Status, "Assigned User ID", "Responsibility Center")
        addafter("Vendor Cr. Memo No.")
        {
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    IF (STRLEN(Rec."Vendor Invoice No.") > 16) THEN
                        ERROR('Cannot Greator Or Less then Sixteen Digit');
                end;
            }
            field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
            {
                ApplicationArea = all;
            }


            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Job Queue Status"; "Vendor Authorization No.", "Incoming Document Entry No.", "Order Address Code", "GST Reason Type", "Campaign No.")
        modify("Vendor Authorization No.")
        {
            Importance = Promoted;
        }
        modify("Order Address Code")
        {
            QuickEntry = false;

        }
        addafter("VAT Bus. Posting Group")
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
            }
            field("Vendor CN Date"; Rec."Vendor CN Date")
            {
                ApplicationArea = all;
            }
        }
        moveafter("Posting Date"; "Vendor Cr. Memo No.")
        moveafter("Applies-to ID"; "Nature of Supply")
    }
    actions
    {
        modify(Release)
        {
            trigger OnAfterAction()
            begin
                IF (rec."Vendor GST CN  available" = rec."Vendor GST CN  available"::Yes) AND (rec."Vendor Cr. Memo No." = '') THEN
                    ERROR('Please Enter Vendor GST CN No.');

                IF (rec."Vendor Cr. Memo No." <> '') AND (rec."Vendor CN Date" = 0D) THEN
                    ERROR('Please Enter Vendor GST Date');

            end;
        }

        addafter("Get St&d. Vend. Purchase Codes")
        {
            action("Get Shortage Trans. Rcpt")
            {
                Caption = 'Get Shortage Trans. Rcpt';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TransferReceiptHeader: Record "Transfer Receipt Header";
                //  PostedTransReceipts: Page 50108;
                begin
                    MESSAGE('Location code must be shortage in header');
                    TransferReceiptHeader.SETCURRENTKEY("Post Credit Memo", "Shortage TO", TransferReceiptHeader."Transporter's Name");
                    TransferReceiptHeader.FILTERGROUP(2);
                    TransferReceiptHeader.SETRANGE("Post Credit Memo", FALSE);
                    TransferReceiptHeader.SETRANGE("Shortage TO", TRUE);
                    TransferReceiptHeader.SETRANGE("Transporter's Name", Rec."Buy-from Vendor No.");
                    TransferReceiptHeader.FILTERGROUP(0);
                    /*  PostedTransReceipts.SETTABLEVIEW(TransferReceiptHeader);
                      PostedTransReceipts.LOOKUPMODE := TRUE;
                      PostedTransReceipts.SetPurchHeader(Rec);
                      PostedTransReceipts.RUNMODAL;*/
                end;
            }
        }
        addafter("Copy Document")
        {
            /*  action("Update Reference Invoice No")
              {
                  Caption = 'Update Reference Invoice No';
                  Image = ApplyEntries;
                  Promoted = true;
                  PromotedCategory = Process;

                  trigger OnAction()
                  var
                      ReferenceInvoiceNo: Record "Reference Invoice No.";
                      UpdateReferenceInvoiceNo: Page "Update Reference Invoice No";
                  begin
                      IF GSTManagement.IsGSTApplicable(Structure) THEN BEGIN
                          PurchLine.CalculateStructures(Rec);
                          PurchLine.AdjustStructureAmounts(Rec);
                          PurchLine.UpdatePurchLines(Rec);

                          ReferenceInvoiceNo.RESET;
                          ReferenceInvoiceNo.SETRANGE("Document No.", Rec."No.");
                          ReferenceInvoiceNo.SETRANGE("Document Type", Rec."Document Type");
                          ReferenceInvoiceNo.SETRANGE("Source No.", Rec."Buy-from Vendor No.");
                          UpdateReferenceInvoiceNo.CustomerRecord(ReferenceInvoiceNo."Source Type"::Vendor);
                          UpdateReferenceInvoiceNo.SETTABLEVIEW(ReferenceInvoiceNo);
                          UpdateReferenceInvoiceNo.RUN;
                      END ELSE
                          ERROR(ReferenceInvoiceNoErr);
                  end;
              }*/
        }
    }



    var
        UserSetup: Record "User Setup";
        UserLocation: Record "User Location";
        LocationFilterString: Text[1024];


    trigger OnOpenPage()
    begin
        //TRI SC
        //ND Tri Start Cust 38
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."View Purchase Credit memo", '%1', TRUE);
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

