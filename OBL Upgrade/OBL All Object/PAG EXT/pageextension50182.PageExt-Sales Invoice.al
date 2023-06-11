pageextension 50182 pageextension50182 extends "Sales Invoice"
{
    layout
    {
        modify("Currency Code")
        {
            trigger OnAssistEdit()
            begin
                CurrPage.UPDATE;
            end;
        }

        addafter("Sell-to Contact")
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Status)
        {
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
            field("Discount Charges %"; Rec."Discount Charges %")
            {
                ApplicationArea = All;
            }
            field("Sales Order No."; Rec."Sales Order No.")
            {
                ApplicationArea = All;
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
            field("Your Reference1"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
        }
        addafter("Transaction Specification")
        {
            field("Transport Mmethod"; Rec."Shipping Agent Code")
            {
                Caption = 'Transport Method';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addbefore(Approvals)
        {
            action(ImportXML)
            {
                Caption = 'Import XML SIL Cust';
                Promoted = true;
                RunObject = xmlport 50078;
                ApplicationArea = All;
            }
        }

        addafter(Approvals)
        {
            action("Update Reference Invoice No")
            {
                ApplicationArea = All;
                /*  Caption = 'Update Reference Invoice No';
                  Image = ApplyEntries;
                  Promoted = true;
                  PromotedCategory = Process;

                  trigger OnAction()
                  var
                      ReferenceInvoiceNo: Record "Reference Invoice No.";
                      UpdateReferenceInvoiceNo: Page "Update Reference Invoice No";
                      SalesLine: Record "Sales Line";

                  begin
                      IF GSTManagement.IsGSTApplicable(Structure) THEN BEGIN
                          IF NOT (Rec."Invoice Type" IN [Rec."Invoice Type"::"Debit Note", Rec."Invoice Type"::Supplementary]) THEN
                              ERROR(ReferenceNoErr);

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
                          ReferenceInvoiceNo.SETRANGE("Document Type", "Document Type");
                          ReferenceInvoiceNo.SETRANGE("Source No.", Rec."Bill-to Customer No.");
                          UpdateReferenceInvoiceNo.CustomerRecord(ReferenceInvoiceNo."Source Type"::Customer);
                          UpdateReferenceInvoiceNo.SETTABLEVIEW(ReferenceInvoiceNo);
                          UpdateReferenceInvoiceNo.RUN;
                      END ELSE
                          ERROR(ReferenceInvoiceNoErr);
                  end;*/
            }
        }
        addafter(Approve)
        {
            action("Calculate Tax On MRP")
            {
                Caption = 'Calculate Tax On MRP';
                ApplicationArea = All;

                /*  trigger OnAction()
                  var
                      "--------tri-rk----------": Integer;
                      // structureheader: Record "Structure Header"; 16630 table is close
                      SalesLineRec: Record "Sales Line";
                  begin
                      //trident-rakesh-start
                      IF structureheader.GET(Structure) THEN BEGIN
                          IF structureheader."Tax Abatement" THEN BEGIN
                              IF "Abatement Required" THEN BEGIN
                                  SalesLine.CalculateStructures(Rec);
                                  SalesLineRec.RESET;
                                  SalesLineRec.SETCURRENTKEY("Document Type", "Document No.");
                                  SalesLineRec.SETRANGE("Document Type", Rec."Document Type");
                                  SalesLineRec.SETRANGE("Document No.", Rec."No.");
                                  IF SalesLineRec.FIND('-') THEN
                                      REPEAT
                                          IF SalesLineRec."MRP Price" <> 0 THEN
                                              SalesLineRec."Unit Price" := SalesLineRec."MRP Price" - (SalesLineRec."MRP Price" * SalesLineRec."Tax %") / 100;
                                          SalesLineRec.MODIFY;
                                      UNTIL SalesLineRec.NEXT = 0;
                                  SalesLine.CalculateStructures(Rec);
                              END;
                          END;
                      END;
                      IF NOT (structureheader."Tax Abatement" AND "Abatement Required") THEN
                          MESSAGE('Please check the Abatement Required Field');
                      //trident-rakesh-end
                  end;*/
            }
        }
        addafter(Preview)
        {
            action(Temp)
            {
                ApplicationArea = All;

                /*  trigger OnAction()
                  var
                      ItemLedEntry: Record "Item Ledger Entry";
                      FileDir: Automation;
                      SMTPTop: Codeunit "SMTP Mail";
                  //SMTPSetup: Record "SMTP Mail Setup"; 16630 this table closed
                  begin
                      //Tem.openOutlookJoy('','');
                      //FileDir := ;
                      /*IF ISCLEAR(FileDir) THEN
                        CREATE(FileDir,FALSE,TRUE);

                      IF NOT FileDir.FolderExists('C:\MailPDF') THEN
                        FileDir.CreateFolder('C:\MailPDF');*/

                /*    SMTPSetup.GET();
                    SMTPTop.CreateMessage('Joy', SMTPSetup."User ID", 'Joydeep.c@teamcomputers.com', 'Test', 'Test1', TRUE);
                    SMTPTop.Send();

                end;*/
            }
        }
    }



    var
        UserLocation: Record "User Location";
        LocationFilterString: Text[1024];
        SalesLine: Record "Sales Line";
        Text0001: Label 'Sufficient Inventory not available.';
        Text0004: Label 'Unit Price of %1 %2 must not be zero while Release.';



    trigger OnOpenPage()
    begin
        //Upgrade(+)

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

        LocationFilterString := COPYSTR(LocationFilterString, 2, 1024);

        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');

        rec.FILTERGROUP(2);
        rec.SETFILTER("Location Code", LocationFilterString);
        rec.FILTERGROUP(0);
        //ND Tri End Cust 38

    end;

}

