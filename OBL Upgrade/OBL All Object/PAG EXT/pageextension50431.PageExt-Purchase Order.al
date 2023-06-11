pageextension 50431 pageextension50431 extends "Purchase Order"
{
    layout
    {
        addafter("Vendor Shipment No.")
        {
            field("Transporter's Code"; Rec."Transporter's Code")
            {
                ApplicationArea = all;
            }
            field("Transporter Name"; Rec."Transporter Name")
            {
                ApplicationArea = all;
            }
            field("Posting Description New"; Rec."Posting Description New")
            {
                ApplicationArea = all;

            }
        }
        modify("Posting Description")
        {
            Visible = false;
        }


        /*   modify("No.")
          {
              trigger OnAssistEdit()
              begin
                  //Keshav08042020
                                   rNoSeries.RESET;
                                  rNoSeries.SETRANGE(Code, Rec."No. Series");
                                  IF rNoSeries.FIND('-') THEN BEGIN
                                      rNoSeries.TESTFIELD(Location);
                                      rUserLocation.RESET;
                                      rUserLocation.SETRANGE("User ID", USERID);
                                      rUserLocation.SETRANGE("Location Code", rNoSeries.Location);
                                      rUserLocation.SETRANGE("Create Purchase Order", TRUE);
                                      IF rUserLocation.FIND('-') THEN BEGIN
                                          Rec.VALIDATE("Location Code", rNoSeries.Location);
                                          Rec.MODIFY;
                                      END ELSE BEGIN
                                          ERROR('You are not authorised to use this location : ' + rNoSeries.Location);
                                      END;
                                  END;
                                   //Keshav08042020

              end;
          } */


        addafter("No. of Archived Versions")
        {
            field("Approver ID"; Rec."Approver ID")
            {
                ApplicationArea = All;
            }
            field("Approver Name"; Rec."Approver Name")
            {
                Editable = false;
                ApplicationArea = All;
            }

            field("Approval Status"; Rec."Approval Status")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Releasing Date"; Rec."Releasing Date")
            {
                Editable = false;
                Enabled = true;
                ApplicationArea = All;
            }
            field("Releasing Time"; Rec."Releasing Time")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Ordered Qty"; Rec."Ordered Qty")
            {
                Editable = false;
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("Total Recd. Quantity"; Rec."Total Recd. Quantity")
            {
                Editable = false;
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            /*   field("Your Reference"; Rec."Your Reference")
              {
                  ApplicationArea = All;
              } */
            field("Return Order Pend. For Posting"; Rec."Return Order Pend. For Posting")
            {
                ApplicationArea = All;
            }
            field(Residue; Rec.Residue)
            {
                Caption = 'Residue';
                ApplicationArea = All;
            }
            field(Moisture; Rec.Moisture)
            {
                Caption = 'Moisture';
                ApplicationArea = All;
            }
            field("Amendment No."; Rec."Amendment No.")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    Rec."Amendment Date" := 0D;
                    IF STRLEN(Rec."Amendment No.") <> 0 THEN
                        Rec."Amendment Date" := TODAY
                end;
            }
            field("Amendment Date"; Rec."Amendment Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        movebefore("Approval Status"; Status)
        movebefore(Residue; "GST Vendor Type")
        addafter("Document Date")
        {
            field("Advance Payment"; Rec."Adv Payment")
            {
                Editable = false;
                ApplicationArea = All;
            }
            /* field("E-Way Bill No."; "E-Way Bill No. Base")//16225 Table Field N/F
             {
                 Caption = 'E-Way Bill No.';
             }*/
        }
        moveafter("Order Date"; "Shortcut Dimension 2 Code")
        addafter("Order Date")
        {
            field("Nature of Expense"; Rec.NOE)
            {
                ApplicationArea = All;
            }
            field("Delivery Period"; Rec."Delivery Period")
            {
                ApplicationArea = All;
            }
            field("User Location Code"; Rec."User Location Code")
            {
                ApplicationArea = all;

            }

            field("Delivary Date"; Rec."Delivary Date")
            {
                ApplicationArea = All;
            }
            field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
            {
                ApplicationArea = All;
            }
            /* field("Vendor Shipment Date"; "Vendor Shipment Date")//16225 table Field N/F
             {
             }*/
            field("GE No."; Rec."GE No.")
            {
                Caption = 'Gate Entry No.';
                Importance = Promoted;
                ApplicationArea = All;
            }
            field("GE Date"; Rec."GE Date")
            {
                ApplicationArea = All;
            }
            field("Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = All;
            }

            field("Due Date Calc. On"; Rec."Due Date Calc. On")
            {
                ApplicationArea = All;
            }
            field("Reason for Approval"; Rec."Reason for Approval")
            {
                ApplicationArea = All;
            }
            field(Currency_Code; Rec.Currency_Code)
            {
                ApplicationArea = All;
            }
            field("Exchange Rate"; Rec."Exchange Rate")
            {
                ApplicationArea = All;
            }
            field("Quotation No."; Rec."Quotation No.")
            {
                Caption = 'Quotation No.';
                Editable = true;
                ApplicationArea = All;
            }
            field("Quotation Date"; Rec."Quotation Date")
            {
                ApplicationArea = All;
            }
            field("PUrchase Type"; Rec."PUrchase Type")
            {
                Caption = 'Purchase Type';
                ApplicationArea = All;
            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
            field("Receiving No. Series"; Rec."Receiving No. Series")
            {
                ApplicationArea = All;
            }
        }
        movebefore("Delivary Date"; "Shortcut Dimension 1 Code", "Location Code")
        movebefore("Vendor Invoice Date"; "Vendor Invoice No.", "Shipment Method Code", "Payment Terms Code")
        movebefore("GE No."; "Vendor Order No.", "Vendor Shipment No.")
        movebefore("Reason for Approval"; "Payment Method Code")
        modify("Vendor Order No.")
        {
            Caption = 'Truck No.';
            Importance = Standard;
            Style = Ambiguous;
            StyleExpr = TRUE;

        }
        addafter("Ship-to Code")
        {
            /*  field("Transporter's Code"; Rec."Transporter's Code")
             {
                 ApplicationArea = All;
             }
             field("Transporter Name"; Rec."Transporter Name")
             {
                 ApplicationArea = All;
             } */
            field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
            {
                Editable = false;
                Importance = Promoted;
                ApplicationArea = All;
            }
            field("Form 31 Amount"; Rec."Form 31 Amount")
            {
                ApplicationArea = All;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("Receiving No."; Rec."Receiving No.")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("GST Inv. Rounding Precision"; Rec."GST Inv. Rounding Precision")
            {
                ApplicationArea = All;
            }
            field("GST Inv. Rounding Type"; Rec."GST Inv. Rounding Type")
            {
                ApplicationArea = All;
            }
            field("GST Input Service Distribution"; Rec."GST Input Service Distribution")
            {
                ApplicationArea = All;
            }
        }
        moveafter("GST Input Service Distribution"; "Payment Reference", "Creditor No.")
        movebefore("GST Inv. Rounding Precision"; "Invoice Type", "Associated Enterprises", "Nature of Supply", "Prepmt. Pmt. Discount Date"
      , "Prepmt. Payment Discount %", "VAT Bus. Posting Group", "Prices Including VAT", "On Hold", "Pmt. Discount Date", "Payment Discount %"
      , "Due Date")
        movebefore("Form 31 Amount"; "Pay-to Contact", "Pay-to City", "Pay-to Post Code", "Pay-to Address", "Pay-to Address 2", "Pay-to Name", "Pay-to Contact No.")
        movebefore("Pay-to Post Code"; "Vendor Cr. Memo No.", "Prepayment Due Date", "Prepmt. Payment Terms Code", "Compress Prepayment", "Prepayment %", "Currency Code")
    }
    actions
    {
        modify(Statistics)
        {
            trigger OnBeforeAction()
            begin
                //Upgarde(+)
                //MSBS.Rao Start 231214
                RecPL.RESET;
                RecPL.SETRANGE("Document No.", Rec."No.");
                IF RecPL.FINDFIRST THEN
                    REPEAT
                        IF NewIndentLine.GET(RecPL."Indent No.", RecPL."Indent Line No.") THEN BEGIN
                            IF NewIndentLine."Order No." = '' THEN BEGIN
                                NewIndentLine."Order No." := RecPL."Document No.";
                                NewIndentLine."Order Line No." := RecPL."Line No.";
                                NewIndentLine.Status := NewIndentLine.Status::Closed;
                                NewIndentLine.MODIFY;
                            END;
                        END;
                    UNTIL RecPL.NEXT = 0;
                //MSBS.Rao Stop 231214
                //Upgarde(-)
            end;
        }

        modify(Release)
        {
            trigger OnBeforeAction()
            begin
                IF NOT Rec.CheckTradingPO THEN
                    ERROR('Please use Approval Cycle');
                //ReleasePurchDoc.PerformManualRelease(Rec);

                Rec.TESTFIELD(Status, Rec.Status::Open);

                IF Rec."Due Date Calc. On" = Rec."Due Date Calc. On"::" " THEN
                    ERROR('Please Select the Due Date Calculation Option');

                IF Rec."Payment Terms Code" = '' THEN
                    ERROR('Please Select the Payment Term Code');

                IF Rec."Shortcut Dimension 2 Code" = '' THEN
                    ERROR('Select the Department');

                IF Rec.NOE = '' THEN
                    ERROR('Please Select the Nature of Expense');

                IF UserSetup.GET(USERID) THEN BEGIN
                    IF UserSetup."Allow PO Release" = FALSE THEN
                        ERROR('%1 has no permission to Release the Purchase Order', UserSetup."User ID");
                END;

                //mo tri1.0 Customization no.44 start
                Rec.TESTFIELD("Buy-from Post Code");
                //Rec.TESTFIELD(Structure);//MSBS.Rao 231214//16225 table Field N/F
                PurchLine1.RESET;
                PurchLine1.SETRANGE("Document Type", Rec."Document Type");
                PurchLine1.SETRANGE("Document No.", Rec."No.");
                PurchLine1.SETFILTER(Type, '>0');
                PurchLine1.SETFILTER(Quantity, '<>0');
                IF PurchLine1.FIND('-') THEN
                    REPEAT
                        PurchLine1.VALIDATE("Qty. to Receive", 0);
                        PurchLine1.VALIDATE("Qty. to Invoice", 0);
                        PurchLine1.MODIFY;

                    UNTIL PurchLine1.NEXT = 0;

                //mo tri1.0 Customization no.44 end
                //Trident-Rakesh-Start 260906
                IF Rec."Document Type" = Rec."Document Type"::Order THEN BEGIN    //TRI A.S 04.08.09 Code Added
                    Rec."Locked Order" := TRUE;
                    Rec.MODIFY;
                    COMMIT;
                    //Trident-Rakesh-End 260906
                END;
                IF Rec.Status = Rec.Status::Open THEN BEGIN
                    ArchiveManagement.ArchivePurchDocument(Rec);
                    Rec."Amendment Date" := TODAY;
                    Rec."Releasing Date" := WORKDATE;  //ravi
                    Rec."Releasing Time" := TIME;   //ravi
                    Rec.MODIFY;
                END;


                IF (USERID IN ['pu006', 'pu009', 'ma025']) THEN
                    ReleasePurchDoc.PerformManualRelease(Rec)
                ELSE
                    ReleasePurchaseDocument.RUN(Rec);

                //mo tri1.0 Customization no. start
                PurchLine1.RESET;
                PurchLine1.SETRANGE("Document Type", Rec."Document Type");
                PurchLine1.SETRANGE("Document No.", Rec."No.");
                PurchLine1.SETFILTER(Type, '>0');
                PurchLine1.SETFILTER(Quantity, '<>0');
                PurchLine1.SETFILTER("Direct Unit Cost", '%1', 0);
                IF PurchLine1.FIND('-') THEN
                    ERROR('Unit Cost of the Item %1 must not be zero while Release', PurchLine1."No.");



                /*"Releasing Date" := WORKDATE;  //ravi
                "Releasing Time" := TIME;   //ravi
                MODIFY;*/
                //mo tri1.0 Customization no. end

                //Keshav13042020

                IF xRec.Status <> Rec.Status THEN BEGIN
                    IF Rec.Status = Rec.Status::Released THEN BEGIN
                        Rec."Approval Status" := Rec."Approval Status"::Approved;
                    END ELSE BEGIN
                        Rec."Approval Status" := Rec."Approval Status"::"Not Approved";
                    END;
                END;
                //Keshav13042020

            end;
        }

        modify(Reopen)
        {
            trigger OnBeforeAction()
            begin
                //Upgrade(+)
                Rec.TESTFIELD("Locked Order", FALSE);
                IF UserSetup.GET(USERID) THEN BEGIN
                    IF UserSetup."Allow PO Reopen" = FALSE THEN
                        ERROR('%1 has no permission to Reopen the Purchase Order', UserSetup."User ID");
                END;

                //upgrade(-)
                Rec.RemoveCapexEntry();//MSRG 15.11.2021
                ReleasePurchDoc.PerformManualReopen(Rec);
                IF xRec.Status <> Rec.Status THEN BEGIN
                    IF Rec.Status = Rec.Status::Open THEN BEGIN
                        Rec."Approval Status" := Rec."Approval Status"::"Not Approved";
                    END ELSE BEGIN
                        Rec."Approval Status" := Rec."Approval Status"::Approved;
                    END;
                END;

            end;
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            begin
                Rec.TESTFIELD(Status, Rec.Status::Open);
                //MSAK
                PurchaseLine3.RESET;
                PurchaseLine3.SETRANGE("Document Type", PurchaseLine3."Document Type"::Order);
                PurchaseLine3.SETRANGE("Document No.", Rec."No.");
                IF PurchaseLine3.FINDFIRST THEN
                    REPEAT
                        IF PurchaseLine3."Item Category Code" IN ['T001', 'D001', 'M001', 'H001', 'SAMPLE'] THEN
                            ERROR(Text010);
                    UNTIL PurchaseLine3.NEXT = 0;

                IF Rec."Due Date Calc. On" = Rec."Due Date Calc. On"::" " THEN
                    ERROR('Please Select the Due Date Calculation Option');

                IF Rec."Payment Terms Code" = '' THEN
                    ERROR('Please Select the Payment Term Code');

                IF Rec."Payment Method Code" = '' THEN
                    ERROR('Please Select the Payment Method');

                IF Rec."Delivary Date" = 0D THEN
                    ERROR('Please Enter the Delivery Date');


                //MSAK
                IF Rec.Status = Rec.Status::Open THEN BEGIN
                    ArchiveManagement.ArchivePurchDocument(Rec);
                    Rec."Amendment Date" := TODAY;
                    Rec."Releasing Date" := WORKDATE;  //ravi
                    Rec."Releasing Time" := TIME;   //ravi
                    Rec.MODIFY;
                END;
                Rec.CreateApprovalEnt(Rec);
                Rec.CheckCapexEntry(); //MSRG 15.11.2021
            end;
        }

        modify(CancelApprovalRequest)
        {
            trigger OnAfterAction()
            begin
                Rec.CancelApprovalEntry(Rec);
            end;
        }

        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                IF Rec.Status <> Rec.Status::Released THEN
                    ERROR('PO Not Approved');


                IF vendorrec.GET(Rec."Buy-from Vendor No.") THEN BEGIN
                    IF ((vendorrec."Micro Enterprises" = TRUE) OR (vendorrec."Small Enterprises" = TRUE) OR (vendorrec."Medium Enterprises" = TRUE)) THEN
                        IF (Rec."Vendor Invoice Date" < TODAY - 30) THEN
                            ERROR('MSME Vendor Invoice Date Cannot be Greater Then 30 Days');

                    IF vendorrec."Vendor Posting Group" = 'TRD' THEN
                        vendorrec.TESTFIELD("Morbi Location Code");
                END;

                IF vendorrec.GET(Rec."Buy-from Vendor No.") THEN BEGIN
                    IF NOT ((vendorrec."Micro Enterprises" = FALSE) OR (vendorrec."Small Enterprises" = FALSE) OR (vendorrec."Medium Enterprises" = FALSE)) THEN
                        IF (Rec."Vendor Invoice Date" < TODAY - 60) THEN
                            ERROR('Vendor Invoice Date Cannot be Greater Then 60 Days')

                END;


                /* IF Structure <> '' THEN BEGIN
                     PurchLine.CalculateStructures(Rec);
                     PurchLine.AdjustStructureAmounts(Rec);
                     PurchLine.UpdatePurchLines(Rec);
                     COMMIT;
                 END;*/

                rPurcLine.RESET;
                rPurcLine.SETRANGE("Document Type", Rec."Document Type");
                rPurcLine.SETRANGE("Document No.", Rec."No.");
                rPurcLine.SETFILTER(Type, '>0');
                rPurcLine.SETFILTER(Quantity, '<>0');
                rPurcLine.SETFILTER("Item Category Code", '<>%1&<>%2', 'T001', 'SAMPLE');
                IF rPurcLine.FIND('-') THEN BEGIN
                    REPEAT
                        xdecQty[ROUND(rPurcLine."Line No." / 100, 1.0, '=')] := rPurcLine."Qty. to Receive";
                    UNTIL rPurcLine.NEXT = 0;
                END;

                //CODEUNIT.RUN(91,Rec);
                // NAVIN
                //Upgrade(+)

                // Post(CODEUNIT::"Purch.-Post (Yes/No)");

                //PO Auto Closed IF Order Qty = Received Qty - Kulbhushan Sharma
                Rec.CALCFIELDS("Ordered Qty");
                Rec.CALCFIELDS("Total Recd. Quantity");
                IF Rec."Ordered Qty" = Rec."Total Recd. Quantity" THEN
                    Rec.Status := Rec.Status::"Short Close";

                //Upgrade(+)
                //MSBS.Rao Start 231214
                Rec.VALIDATE("Transporter's Code", '');
                Rec.MODIFY;
                //MSBS.Rao Stop 231214
                //mo tri1.0 Customization no.44 start
                PurchLine1.RESET;
                PurchLine1.SETRANGE("Document Type", Rec."Document Type");
                PurchLine1.SETRANGE("Document No.", Rec."No.");
                PurchLine1.SETFILTER(Type, '>0');
                PurchLine1.SETFILTER(Quantity, '<>0');
                //PurchLine1.SETFILTER("Item Category Code",'<>%1','T001');
                IF PurchLine1.FIND('-') THEN
                    REPEAT
                        //Keshav16042020
                        IF ((PurchLine1.Quantity * 5 / 100) >= PurchLine1."Outstanding Quantity") AND (xdecQty[ROUND(PurchLine1."Line No." / 100, 1.0, '=')] <> 0) AND NOT (PurchLine1."Item Category Code" IN ['T001', 'SAMPLE']) THEN BEGIN
                            rPurchRcptHdr.RESET;
                            rPurchRcptHdr.SETRANGE("Order No.", Rec."No.");
                            rPurchRcptHdr.FIND('+');
                            //      txtMessage:='';
                            //      txtMessage+='Item has achieved more than or equal to 95% : <br>' ;
                            //      txtMessage+=' Plant Code : ' + "Location Code" ;
                            //      txtMessage+=', Document No. : ' + "No.";
                            txtMessage += 'Rect Date : ' + FORMAT(Rec."Posting Date");
                            txtMessage += ', Vendor Name  :  ' + Rec."Buy-from Vendor Name";
                            txtMessage += ', Item Description : ' + PurchLine1.Description;
                            txtMessage += ', PO Quantity : ' + FORMAT(PurchLine1.Quantity);
                            txtMessage += ', Rect Quantity : ' + FORMAT(PurchLine1."Quantity Received");
                            txtMessage += ', Balance Quantity : ' + FORMAT(PurchLine1."Outstanding Quantity");

                            NotifyRecRef.OPEN(DATABASE::"Purchase Header");
                            NotifyRecRef.SETPOSITION(Rec.GETPOSITION);
                            PurchNotifyRecID := NotifyRecRef.RECORDID;
                            NotifyRecRef.CLOSE;

                            rLocation.RESET;
                            IF rLocation.GET(Rec."Location Code") THEN BEGIN
                                rNotifyUserMapping.RESET;
                                IF rNotifyUserMapping.FIND('-') THEN BEGIN
                                    cdNotifyCd := '';
                                    IF rLocation."Store Location" = rLocation."Store Location"::SKD THEN
                                        cdNotifyCd := 'SKD-GRN';
                                    IF rLocation."Store Location" = rLocation."Store Location"::HSK THEN
                                        cdNotifyCd := 'HSK-GRN';
                                    IF rLocation."Store Location" = rLocation."Store Location"::DRA THEN
                                        cdNotifyCd := 'DRA-GRN';
                                    IF cdNotifyCd <> '' THEN
                                        NotifyManagement.CreateNotifyEntry(cdNotifyCd, PurchNotifyRecID, 38, Rec."Document Type".AsInteger(), Rec."No.", PurchLine1."Line No.", txtMessage, 0, 1, Rec."Location Code");
                                END;
                            END;
                        END;

                    //Keshav16042020
                    /* IF PurchLine1."Qty. to Receive" > 0 THEN BEGIN
                         PurchLine1.VALIDATE("Qty. to Receive", 0);
                         PurchLine1.VALIDATE("Qty. to Invoice", 0);
                         //mo tri1.0 Customization no.10
                         PurchLine1."Challan Quantity" := 0;
                         PurchLine1."Actual Quantity" := 0;
                         PurchLine1."Accepted Quantity" := 0;
                         PurchLine1."Shortage Quantity" := 0;
                         PurchLine1."Rejected Quantity" := 0;
                         PurchLine1.MODIFY;
                     END;*/
                    UNTIL PurchLine1.NEXT = 0;
                //mo tri1.0 Customization no.44 end
                //Upgrade(-)

            end;


            trigger OnAfterAction()
            var

            begin
                PurchLine1.RESET;
                PurchLine1.SETRANGE("Document Type", Rec."Document Type");
                PurchLine1.SETRANGE("Document No.", Rec."No.");
                PurchLine1.SETFILTER(Type, '<>%1', PurchLine1.Type::" ");
                PurchLine1.SETFILTER(Quantity, '<>%1', 0);
                //PurchLine1.SETFILTER("Item Category Code",'<>%1','T001');
                IF PurchLine1.FIND('-') THEN
                    REPEAT
                        IF PurchLine1.Quantity > 0 THEN BEGIN
                            PurchLine1.VALIDATE("Qty. to Receive", 0);
                            PurchLine1.VALIDATE("Qty. to Invoice", 0);
                            PurchLine1."Challan Quantity" := 0;
                            PurchLine1."Actual Quantity" := 0;
                            PurchLine1."Accepted Quantity" := 0;
                            PurchLine1."Shortage Quantity" := 0;
                            PurchLine1."Rejected Quantity" := 0;
                            PurchLine1.MODIFY;
                        END;
                    until PurchLine1.Next = 0; // 15578
            end;
        }

        modify("Post and &Print")
        {
            trigger OnAfterAction()
            begin
                // NAVIN
                /* IF Structure <> '' THEN BEGIN//16225 table field N/F
                     PurchLine.CalculateStructures(Rec);
                     PurchLine.AdjustStructureAmounts(Rec);
                     PurchLine.UpdatePurchLines(Rec);
                     COMMIT;
                 END;*/

                //CODEUNIT.RUN(91,Rec);
                // NAVIN
                //Upgrade(-)

                // Post(CODEUNIT::"Purch.-Post + Print");
                //Upgrade(+)
                //MSBS.Rao Start 231214
                Rec.VALIDATE("Transporter's Code", '');
                Rec.MODIFY;
                //MSBS.Rao Stop 231214
                //mo tri1.0 Customization no.44 start
                PurchLine1.RESET;
                PurchLine1.SETRANGE("Document Type", Rec."Document Type");
                PurchLine1.SETRANGE("Document No.", Rec."No.");
                PurchLine1.SETFILTER(Type, '>0');
                PurchLine1.SETFILTER(Quantity, '<>0');
                IF PurchLine1.FIND('-') THEN
                    REPEAT
                        IF PurchLine1.Quantity > PurchLine1."Qty. to Receive" THEN BEGIN
                            PurchLine1.VALIDATE("Qty. to Receive", 0);
                            PurchLine1.VALIDATE("Qty. to Invoice", 0);
                            //mo tri1.0 Customization no.10
                            PurchLine1."Challan Quantity" := 0;
                            PurchLine1."Actual Quantity" := 0;
                            PurchLine1."Accepted Quantity" := 0;
                            PurchLine1."Shortage Quantity" := 0;
                            PurchLine1."Rejected Quantity" := 0;
                            PurchLine1.MODIFY;
                        END;
                    UNTIL PurchLine1.NEXT = 0;
                //mo tri1.0 Customization no.44 end

                //Upgrade(-)

            end;
        }

        addafter(Dimensions)
        {
            action("Update Buy from vendor No onLines")
            {
                Caption = 'Update Buy from vendor No onLines';
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PlRec.RESET;
                    PlRec.SETRANGE(PlRec."Document No.", Rec."No.");
                    IF PlRec.FINDSET THEN
                        REPEAT
                            PlRec."Buy-from Vendor No." := Rec."Buy-from Vendor No.";
                            PlRec.MODIFY;
                        UNTIL PlRec.NEXT = 0
                end;
            }
        }
        addafter("O&rder")
        {
            group(Attachment)
            {
                Caption = 'Attachment';
                action(Import)
                {
                    Caption = 'Attachment Document';
                    Image = PostedTaxInvoice;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Rec.Status <> Rec.Status::Open THEN
                            ERROR('Status must be Open');

                        AttachmentRecRef.OPEN(DATABASE::"Purchase Header");
                        AttachmentRecRef.SETPOSITION(Rec.GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;
                        AttachmentManagment.ImportAttachment(AttachmentRecID, DATABASE::"Indent Header", 0, Rec."No.", 0);
                    end;
                }
                action(Export)
                {
                    Caption = 'Open Attachment';
                    Image = PostedVendorBill;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        AttachmentRecRef.OPEN(DATABASE::"Purchase Header");
                        AttachmentRecRef.SETPOSITION(Rec.GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;
                        AttachmentManagment.ExportAttachment(AttachmentRecID);
                    end;
                }
                action(Delete)
                {
                    Caption = 'Delete Attachment';
                    Image = VoidRegister;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Rec.Status <> Rec.Status::Open THEN
                            ERROR('Status must be Open');

                        AttachmentRecRef.OPEN(DATABASE::"Purchase Header");
                        AttachmentRecRef.SETPOSITION(Rec.GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;
                        AttachmentManagment.DeleteAttachment(AttachmentRecID);
                    end;
                }
            }
        }
        addafter(CalculateInvoiceDiscount)
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
                    /*IF GSTManagement.IsGSTApplicable(Structure) THEN BEGIN//16225 Codeunit N/F start
                        IF NOT ("Invoice Type" IN ["Invoice Type"::"Debit Note", "Invoice Type"::Supplementary]) THEN
                            ERROR(ReferenceNoErr);

                        PurchLine.CalculateStructures(Rec);
                        PurchLine.AdjustStructureAmounts(Rec);
                        PurchLine.UpdatePurchLines(Rec);

                        ReferenceInvoiceNo.RESET;
                        ReferenceInvoiceNo.SETRANGE("Document No.", "No.");
                        ReferenceInvoiceNo.SETRANGE("Document Type", "Document Type");
                        ReferenceInvoiceNo.SETRANGE("Source No.", "Buy-from Vendor No.");
                        UpdateReferenceInvoiceNo.CustomerRecord(ReferenceInvoiceNo."Source Type"::Vendor);
                        UpdateReferenceInvoiceNo.SETTABLEVIEW(ReferenceInvoiceNo);
                        UpdateReferenceInvoiceNo.RUN;
                    END ELSE
                        ERROR(ReferenceInvoiceNoErr);*///16225 Codeunit N/F end
                end;
            }
        }
        addafter("Archive Document")
        {
            action(ShortClose)
            {
                Caption = 'ShortClose';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    rPurchaseLine: Record "Purchase Line";
                    rIndentLine: Record "Indent Line";
                begin
                    ShortClose.Cancel(Rec, 1);
                    //ShortClose.ShortClosePurchaseOrder(Rec);
                    //Keshav16042020

                    rec.testfield("Reason Code");
                    rPurchaseLine.RESET;
                    rPurchaseLine.SETRANGE("Document Type", rPurchaseLine."Document Type"::Order);
                    rPurchaseLine.SETRANGE("Document No.", Rec."No.");
                    IF rPurchaseLine.FIND('-') THEN BEGIN
                        REPEAT
                            //    rPurchaseLine."Indent Original Quantity":=rPurchaseLine."Indent Original Quantity"-rPurchaseLine."Outstanding Quantity";
                            rPurchaseLine.VALIDATE("Indent Original Quantity", rPurchaseLine."Indent Original Quantity" - rPurchaseLine."Outstanding Quantity");
                            rPurchaseLine.MODIFY;
                            IF rPurchaseLine."Indent Original Quantity" < 0 THEN
                                ERROR('Indent Original Quantity must be Greater then Zero');


                            rIndentLine.RESET;
                            rIndentLine.SETRANGE("Document No.", rPurchaseLine."Indent No.");
                            rIndentLine.SETRANGE("Line No.", rPurchaseLine."Indent Line No.");
                            rIndentLine.SETRANGE("No.", rPurchaseLine."No.");
                            rIndentLine.SETFILTER(Status, '%1|%2', rIndentLine.Status::Closed, rIndentLine.Status::Authorized);
                            IF rIndentLine.FIND('-') THEN BEGIN
                                REPEAT
                                    rIndentLine.CALCFIELDS("Actual PO Qty");
                                    IF rIndentLine.Quantity = rIndentLine."Actual PO Qty" THEN BEGIN
                                        rIndentLine.Status := rIndentLine.Status::Closed;
                                    END ELSE BEGIN
                                        rIndentLine.Status := rIndentLine.Status::Authorized;
                                    END;
                                    rIndentLine.MODIFY;
                                UNTIL rIndentLine.NEXT = 0;
                            END;
                        UNTIL rPurchaseLine.NEXT = 0;
                    END;
                    //Keshav16042020
                end;
            }
            action(Cancel)
            {
                Caption = 'Cancel';
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ShortClose.Cancel(Rec, 2);
                end;
            }
            action("Lock/Unlock")
            {
                Caption = 'Lock/Unlock';
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //TRI DG Add start
                    Rec.TESTFIELD(Status, Rec.Status::Released);
                    LockPurchDoc.PurchLockUnlock(Rec);
                    //TRI DG Add stop
                end;
            }
            action(UpdateQuantity)
            {
                Caption = 'UpdateQuantity';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                var
                    recPurchaseLine: Record "Purchase Line";
                begin
                    recPurchaseLine.RESET;
                    recPurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                    recPurchaseLine.SETRANGE("Document No.", Rec."No.");
                    IF recPurchaseLine.FINDFIRST THEN BEGIN
                        REPEAT
                            //    recPurchaseLine.VALIDATE(Quantity);
                            recPurchaseLine.VALIDATE("Challan Quantity", recPurchaseLine.Quantity);
                            recPurchaseLine.VALIDATE("Actual Quantity", recPurchaseLine.Quantity);
                            recPurchaseLine.MODIFY;
                        UNTIL recPurchaseLine.NEXT = 0;
                    END;
                end;
            }
            action("Update Purchase Lines")
            {
                Caption = 'Update Purchase Lines';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you want to update the Lines', FALSE) THEN BEGIN
                        PlRec.SETRANGE("Document Type", Rec."Document Type");
                        PlRec.SETRANGE("Document No.", Rec."No.");
                        IF PlRec.FINDFIRST THEN BEGIN
                            REPORT.RUNMODAL(Report::"Update Purchase Line", FALSE, FALSE, PlRec);
                            MESSAGE('Done');
                        END;
                    END;
                end;
            }
            group("&Reject")
            {
                Caption = '&Reject';
                action("&Post Rejection Note")
                {
                    Caption = '&Post Rejection Note';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        tgPurchHdr: Record "Purchase Header";
                        tgPurchLine: Record "Purchase Line";
                        tgRejectNo: Code[20];
                        tgNoSeriesMgt: Codeunit NoSeriesManagement;
                        tgPurchSetup: Record "Purchases & Payables Setup";
                        tgRejectHdr: Record "Rejection Purchase Header";
                        tgRejectLine: Record "Rejection Purchase Line";
                        tgRecRejectHdr: Record "Rejection Purchase Header";
                        tgVendor: Record Vendor;
                        Text001: Label 'No reject quantity found in Purchase order No. %1';
                        Text002: Label 'Do you want to post reject note?';
                        Text004: Label 'Cancelled by %1.';
                        Text008: Label 'Rejection successfully posted by %1.';
                        tgText002: Label 'Rejection Note No. %1 for Vendor Invoice No. %2 already exists.';
                        tgRejectNo2: Code[20];
                    begin
                        IF NOT CONFIRM(Text002, FALSE) THEN
                            ERROR(Text004, UPPERCASE(USERID));

                        Rec.TESTFIELD(Status, Rec.Status::Released);
                        Rec.TESTFIELD("Vendor Invoice No.");
                        Rec.TESTFIELD("Vendor Invoice Date");
                        Rec.TESTFIELD("Vendor Shipment No.");
                        //Rec. TESTFIELD("Vendor Shipment Date");//16225 field N/F
                        Rec.TESTFIELD("Transporter's Code");
                        Rec.TESTFIELD("GE No.");
                        Rec.TESTFIELD("Buy-from Vendor No.");

                        tgVendor.GET(Rec."Buy-from Vendor No.");
                        tgVendor.TESTFIELD(tgVendor.Blocked, tgVendor.Blocked::" ");

                        tgRecRejectHdr.RESET;
                        tgRecRejectHdr.SETCURRENTKEY("Vendor Invoice No.");
                        tgRecRejectHdr.SETRANGE(tgRecRejectHdr."Vendor Invoice No.", Rec."Vendor Invoice No.");
                        IF tgRecRejectHdr.FIND('-') THEN
                            ERROR(tgText002, tgRecRejectHdr."Rejection No.", Rec."Vendor Invoice No.");

                        tgPurchSetup.GET;
                        tgPurchSetup.TESTFIELD(tgPurchSetup."Reject No.");

                        tgRejectNo := '';
                        tgRejectNo := tgNoSeriesMgt.GetNextNo(tgPurchSetup."Reject No.", Rec."Rejection Date", TRUE);

                        tgPurchSetup.GET;
                        tgPurchSetup.TESTFIELD(tgPurchSetup."Store Reject No");
                        tgRejectNo2 := '';
                        tgRejectNo2 := tgNoSeriesMgt.GetNextNo(tgPurchSetup."Store Reject No", Rec."Rejection Date", TRUE);


                        tgRejectHdr.INIT;
                        tgRejectHdr.TRANSFERFIELDS(Rec);
                        tgRejectHdr."Rejection No." := tgRejectNo;
                        tgRecRejectHdr."Posting Date" := Rec."Rejection Date";
                        tgRejectHdr."Store Rejection No" := tgRejectNo2;
                        tgRejectHdr."Rejection created by" := USERID;
                        tgRejectHdr.INSERT;

                        tgPurchLine.RESET;
                        tgPurchLine.SETRANGE(tgPurchLine."Document Type", tgPurchLine."Document Type"::Order);
                        tgPurchLine.SETRANGE(tgPurchLine."Document No.", Rec."No.");
                        //tgPurchLine.SETFILTER(tgPurchLine."Rejected Quantity",'<>%1',0);
                        //tgPurchLine.SETFILTER(tgPurchLine."Shortage Quantity",'<>%1',0);

                        IF tgPurchLine.FIND('-') THEN
                            REPEAT
                                tgRejectLine.INIT;
                                tgRejectLine.TRANSFERFIELDS(tgPurchLine);
                                tgRejectLine."Rejection No." := tgRejectNo;
                                tgRejectLine."Rejection Date" := Rec."Rejection Date";
                                tgRejectLine."Buy-from Vendor No." := Rec."Buy-from Vendor No.";
                                tgRejectLine.INSERT;
                            UNTIL tgPurchLine.NEXT = 0
                        ELSE
                            ERROR(Text001);
                        MESSAGE(Text008, UPPERCASE(USERID));
                        //TRI V.D 30.10.10 STOP
                    end;
                }
                action("Show Rej&ection")
                {
                    Caption = 'Show Rej&ection';
                    RunObject = Page "Rejection List";
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            separator(Action1000000001)
            {
            }
            action("Approve Excise")
            {
                Caption = 'Approve Excise';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    UsrSetup.GET(USERID);
                    IF UsrSetup."Verify Excise on PO" THEN BEGIN
                        Rec."Excise Approved (Accounts)" := TRUE;
                        Rec.MODIFY;
                    END ELSE
                        ERROR('You are not Authorized to Approve Excise');
                end;
            }
        }
        addafter("F&unctions")
        {
            group(Action1000000013)
            {
                action("&Get Indent Headers")
                {
                    Caption = '&Get Indent Headers';
                    Enabled = false;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CompletlyOrdered;

                        PurchaseLine2.RESET;
                        PurchaseLine2.SETFILTER(PurchaseLine2."Document Type", '%1', PurchaseLine2."Document Type"::Order);
                        PurchaseLine2.SETFILTER(PurchaseLine2."Document No.", Rec."No.");
                        IF PurchaseLine2.FIND('+') THEN
                            LineNo1 := PurchaseLine2."Line No.";

                        IndentHeader.RESET;
                        IndentHeader.SETFILTER(Deleted, '%1', FALSE);
                        IndentHeader.SETFILTER(Status, '%1', IndentLine.Status::Authorized);
                        IndentHeader.SETFILTER(IndentHeader."Completely Ordered", '%1', FALSE);
                        IF PAGE.RUNMODAL(Page::"Indent Header List", IndentHeader) = ACTION::LookupOK THEN BEGIN
                            IndentHeader.SETFILTER(IndentHeader.Selection, '%1', TRUE);
                            IF IndentHeader.FIND('-') THEN
                                REPEAT
                                    IndentHeader.Selection := FALSE;
                                    IndentHeader.MODIFY;
                                    IndentLine.RESET;
                                    IndentLine.SETFILTER(IndentLine."Document No.", IndentHeader."No.");
                                    IndentLine.SETFILTER(IndentLine.Deleted, '%1', FALSE);
                                    IndentLine.SETFILTER(IndentLine.Status, '%1', IndentLine.Status::Authorized);
                                    IndentLine.SETFILTER(IndentLine."Order No.", '%1', '');
                                    IndentLine.SETFILTER("No.", '<>%1', '');
                                    IF IndentLine.FIND('-') THEN
                                        REPEAT
                                            LineNo1 := LineNo1 + 10000;

                                            IF IndentLine.Type = IndentLine.Type::Item THEN BEGIN
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Document Type", PurchaseLine2."Document Type"::Order);
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Document No.", Rec."No.");
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Line No.", LineNo1);
                                                PurchaseLine2.VALIDATE(PurchaseLine2.Type, PurchaseLine2.Type::Item);
                                                PurchaseLine2.VALIDATE(PurchaseLine2."No.", IndentLine."No.");
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Unit of Measure", IndentLine."Unit of Measurement");
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Item Category Code", IndentLine."Item Category Code");
                                                PurchaseLine2.VALIDATE(PurchaseLine2.Quantity, IndentLine.Quantity);
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Direct Unit Cost", IndentLine.Rate);
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Indent No.", IndentLine."Document No.");
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Indent Line No.", IndentLine."Line No.");
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Indent Date", IndentLine.Date);
                                                IF CONFIRM('Do you want to use Indent Location?', TRUE) THEN
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Location Code", IndentLine."Location Code");
                                                PurchaseLine2.INSERT(TRUE);
                                            END ELSE
                                                IF IndentLine.Type = IndentLine.Type::"Non Stock Item" THEN BEGIN
                                                    IndentLine.TESTFIELD(IndentLine."G/L Account");
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Document Type", PurchaseLine2."Document Type"::Order);
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Document No.", Rec."No.");
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Line No.", LineNo1);
                                                    PurchaseLine2.VALIDATE(PurchaseLine2.Type, PurchaseLine2.Type::"G/L Account");
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Indent Date", IndentLine.Date);
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."No.", IndentLine."G/L Account");
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Unit of Measure", IndentLine."Unit of Measurement");
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Item Category Code", IndentLine."Item Category Code");
                                                    PurchaseLine2.VALIDATE(PurchaseLine2.Quantity, IndentLine.Quantity);
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Direct Unit Cost", IndentLine.Rate);
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Indent No.", IndentLine."Document No.");
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Indent Line No.", IndentLine."Line No.");
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Indent Date", IndentLine.Date);
                                                    IF CONFIRM('Do you want to use Indent Location?', TRUE) THEN
                                                        PurchaseLine2.VALIDATE(PurchaseLine2."Location Code", IndentLine."Location Code");
                                                    PurchaseLine2.INSERT(TRUE);
                                                END;

                                            /*
                                              PurchaseLine2.RESET;
                                              PurchaseLine2.VALIDATE(PurchaseLine2."Document Type",PurchaseLine2."Document Type"::Order);
                                              PurchaseLine2.VALIDATE(PurchaseLine2."Document No.","No.");
                                              IF IndentLine.Type = IndentLine.Type::Item THEN
                                                PurchaseLine2.VALIDATE(PurchaseLine2.Type,PurchaseLine2.Type::Item);
                                              IF IndentLine.Type = IndentLine.Type::"Non Stock Item" THEN
                                                PurchaseLine2.VALIDATE(PurchaseLine2.Type,PurchaseLine2.Type::"Non Stock Item");
                                              IF CONFIRM('Do you want to use Indent Location.',TRUE) THEN
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Location Code",IndentLine."Location Code");
                                              PurchaseLine2.VALIDATE(PurchaseLine2."No.",IndentLine."No.");
                                              PurchaseLine2.VALIDATE(PurchaseLine2."Unit of Measure",IndentLine."Unit of Measurement");
                                              PurchaseLine2.VALIDATE(PurchaseLine2."Item Category Code",IndentLine."Item Category Code");
                                              PurchaseLine2.VALIDATE(PurchaseLine2.Quantity,IndentLine.Quantity);
                                              PurchaseLine2.VALIDATE(PurchaseLine2."Direct Unit Cost",IndentLine.Rate);
                                              PurchaseLine2.VALIDATE(PurchaseLine2."Indent No.",IndentLine."Document No.");
                                              PurchaseLine2.VALIDATE(PurchaseLine2."Indent Line No.",IndentLine."Line No.");
                                              PurchaseLine2.VALIDATE(PurchaseLine2."Line No.",LineNo1);
                                              PurchaseLine2.INSERT(TRUE);
                                            */

                                            IndentLine."Order No." := PurchaseLine2."Document No.";
                                            IndentLine."Order Line No." := PurchaseLine2."Line No.";
                                            IndentLine."Order Date" := Rec."Posting Date";
                                            //  IndentLine.VALIDATE(IndentLine.Status,IndentLine.Status::Closed);
                                            IndentLine.MODIFY;

                                        UNTIL IndentLine.NEXT = 0;
                                    //  IndentHeader.VALIDATE(IndentHeader.Status,IndentHeader1.Status::Closed);
                                    IndentHeader.MODIFY;

                                UNTIL IndentHeader.NEXT = 0;
                        END;

                    end;
                }
                action("&Get Indent Lines")
                {
                    Caption = '&Get Indent Lines';
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Item: Record Item;
                        POQty: Decimal;
                        I: Integer;
                        CountTemp: Integer;
                        IndentLineTemp: Record "Indent Line";
                        txtItemSerApp: Text;
                        rNoSeries: Record "No. Series";
                    begin
                        //Keshav10042020
                        rNoSeries.RESET;
                        rNoSeries.SETRANGE(Code, Rec."No. Series");
                        IF rNoSeries.FIND('-') THEN BEGIN
                            txtItemSerApp := '';
                            IF rNoSeries.Domestic = TRUE THEN
                                txtItemSerApp := 'DOMESTIC';

                            IF rNoSeries.Imported = TRUE THEN BEGIN
                                IF txtItemSerApp = '' THEN
                                    txtItemSerApp := 'IMPORTED' ELSE
                                    txtItemSerApp := txtItemSerApp + '|IMPORTED';
                            END;
                            IF rNoSeries."U Series" = TRUE THEN BEGIN
                                IF txtItemSerApp = '' THEN
                                    txtItemSerApp := 'U Series' ELSE
                                    txtItemSerApp := txtItemSerApp + '|U Series';
                            END;
                            IF rNoSeries."SRV Service" = TRUE THEN BEGIN
                                IF txtItemSerApp = '' THEN
                                    txtItemSerApp := 'SRV Service' ELSE
                                    txtItemSerApp := txtItemSerApp + '|SRV Service';
                            END;
                        END;
                        IF txtItemSerApp = '' THEN
                            ERROR('Item Code Service App must not be Blank in No. Series : ' + Rec."No. Series");
                        //Keshav10042020

                        PurchaseLine2.RESET;
                        PurchaseLine2.SETFILTER(PurchaseLine2."Document Type", '%1', PurchaseLine2."Document Type"::Order);
                        PurchaseLine2.SETFILTER(PurchaseLine2."Document No.", Rec."No.");
                        IF PurchaseLine2.FIND('+') THEN
                            LineNo1 := PurchaseLine2."Line No.";

                        IndentLine.RESET;
                        //IndentLine.SETFILTER(Deleted,'%1',FALSE);
                        //IndentLine.SETFILTER(Status,'%1',IndentLine.Status::Authorized);
                        //IndentLine.SETFILTER("Order No.",'%1','');
                        //TRI SC 27.05.10
                        //IndentLine.SETCURRENTKEY(IndentLine.Date);
                        //IndentLine.SETCURRENTKEY("Order No.",Deleted,Status,"No.",Type,"Due Date");
                        IndentLine.SETCURRENTKEY(Status, "Order No.", Deleted);
                        IndentLine.SETRANGE(Status, IndentLine.Status::Authorized);
                        // IndentLine.SETRANGE("Order No.",'');//Keshav14042020
                        IndentLine.SETRANGE(Deleted, FALSE);
                        //IndentLine.SETRANGE(Status,IndentLine.Status::Authorized);
                        //IF IndentLine.FINDSET THEN;
                        //TRI SC
                        //IndentLine.SETFILTER("No.",'<>%1',''); //MSBS.Rao 091213 Code Commited as required by Mr. Kulbhushan
                        //IF NOT IndentLine.FIND('-') THEN
                        //  ERROR('There are no pending Indents');
                        //Keshav10042020
                        IndentLine.SETFILTER("Item Code Service App", txtItemSerApp);
                        IndentLine.SETRANGE("Location Code", Rec."Location Code");
                        //Keshav10042020

                        IF PAGE.RUNMODAL(Page::"Indent Lines List", IndentLine) = ACTION::LookupOK THEN BEGIN
                            IndentLineList.GETRECORD(IndentLine);
                            IndentLine.SETFILTER(Selection, '%1', TRUE);
                            CountTemp := IndentLine.COUNT;

                            IF IndentLine.FINDFIRST THEN
                                REPEAT
                                    I += 1;
                                    IndentLine.Selection := FALSE;
                                    IndentLine.MODIFY;

                                    LineNo1 := LineNo1 + 10000;
                                    IF IndentLine.Type = IndentLine.Type::Item THEN BEGIN
                                        PurchaseLine2.INIT;
                                        PurchaseLine2.VALIDATE(PurchaseLine2."Document Type", PurchaseLine2."Document Type"::Order);
                                        PurchaseLine2.VALIDATE(PurchaseLine2."Document No.", Rec."No.");
                                        PurchaseLine2.VALIDATE(PurchaseLine2."Line No.", LineNo1);
                                        PurchaseLine2.VALIDATE(PurchaseLine2.Type, PurchaseLine2.Type::Item);
                                        PurchaseLine2.VALIDATE(PurchaseLine2."No.", IndentLine."No.");
                                        PurchaseLine2.Description := IndentLine.Description;//MSBS.Rao 091213
                                        PurchaseLine2."Description 2" := IndentLine."Description 2";//MSBS.Rao 091213
                                                                                                    //PurchaseLine2.VALIDATE(PurchaseLine2."Unit of Measure",IndentLine."Unit of Measurement");
                                        PurchaseLine2."Unit of Measure Code" := IndentLine."Unit of Measurement"; //Kulbhushan Sharma
                                        PurchaseLine2.VALIDATE(PurchaseLine2."Item Category Code", IndentLine."Item Category Code");
                                        PurchaseLine2.VALIDATE(PurchaseLine2."Indent No.", IndentLine."Document No.");
                                        PurchaseLine2.VALIDATE(PurchaseLine2."Indent Line No.", IndentLine."Line No.");
                                        PurchaseLine2.VALIDATE(PurchaseLine2."Indent Date", IndentLine.Date);


                                        //Keshav13042020
                                        //PurchaseLine2.VALIDATE(Quantity,IndentLine.Quantity);//-GetPOQty(IndentLine."Document No.",IndentLine."No."));
                                        IndentLine.CALCFIELDS("Actual PO Qty");
                                        PurchaseLine2.VALIDATE(Quantity, IndentLine.Quantity - IndentLine."Actual PO Qty");
                                        PurchaseLine2.VALIDATE("Original PO Qty", PurchaseLine2.Quantity);
                                        PurchaseLine2.VALIDATE("Indent Original Quantity", PurchaseLine2.Quantity);
                                        //Keshav13042020

                                        IF PurchaseLine2.Quantity = 0 THEN
                                            ERROR('You can not select 0 Qty Indent');

                                        PurchaseLine2."Old Pending Qty" := PurchaseLine2.Quantity;//MSBS.Rao 231214
                                        PurchaseLine2.VALIDATE(PurchaseLine2."Direct Unit Cost", IndentLine.Rate);
                                        //16225  PurchaseLine2.VALIDATE(PurchaseLine2."Excise Bus. Posting Group", "Excise Bus. Posting Group");
                                        IF PurchaseLine2.Type = PurchaseLine2.Type::Item THEN
                                            IF Item.GET(PurchaseLine2."No.") THEN
                                                //16225   PurchaseLine2.VALIDATE(PurchaseLine2."Excise Prod. Posting Group", Item."Excise Prod. Posting Group");

                                                IndentLine.CALCFIELDS(IndentLine."Capex No.");
                                        PurchaseLine2."Capex No." := IndentLine."Capex No.";
                                        //IF CONFIRM('Do you want to use Indent Location?',TRUE) THEN
                                        PurchaseLine2.VALIDATE(PurchaseLine2."Location Code", IndentLine."Location Code");
                                        PurchaseLine2.INSERT(TRUE);
                                    END ELSE
                                        IF IndentLine.Type = IndentLine.Type::"Non Stock Item" THEN BEGIN
                                            IndentLine.TESTFIELD(IndentLine."G/L Account");
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Document Type", PurchaseLine2."Document Type"::Order);
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Document No.", Rec."No.");
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Line No.", LineNo1);
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Indent Date", IndentLine.Date);
                                            PurchaseLine2.VALIDATE(PurchaseLine2.Type, PurchaseLine2.Type::"G/L Account");
                                            PurchaseLine2."No." := IndentLine."G/L Account"; //Kulbhushan Sharma

                                            PurchaseLine2.Description := IndentLine.Description;//MSBS.Rao 091213
                                            PurchaseLine2."Description 2" := IndentLine."Description 2";//MSBS.Rao 091213
                                            PurchaseLine2."Unit of Measure Code" := IndentLine."Unit of Measurement";

                                            PurchaseLine2.VALIDATE(PurchaseLine2."Item Category Code", IndentLine."Item Category Code");

                                            IF IndentLine.Quantity > GetPOQty(IndentLine."Document No.", IndentLine."No.") THEN BEGIN
                                                PurchaseLine2.VALIDATE(PurchaseLine2.Quantity, IndentLine.Quantity - GetPOQty(IndentLine."Document No.", IndentLine."No."
                                                ));
                                            END
                                            ELSE BEGIN
                                                PurchaseLine2.VALIDATE(PurchaseLine2.Quantity, IndentLine.Quantity);
                                            END;
                                            IF PurchaseLine2.Quantity = 0 THEN
                                                ERROR('You can not select 0 Qty Indent');

                                            PurchaseLine2.VALIDATE(PurchaseLine2."Direct Unit Cost", IndentLine.Rate);
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Indent No.", IndentLine."Document No.");
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Indent Line No.", IndentLine."Line No.");
                                            IF IndentLine."Planning Date" <> 0D THEN
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Planned Receipt Date", IndentLine."Planning Date");
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Indent Date", IndentLine.Date);
                                            //IF CONFIRM('Do you want to use Indent Location?',TRUE) THEN
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Location Code", IndentLine."Location Code");
                                            PurchaseLine2.INSERT(TRUE);
                                        END ELSE BEGIN
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Document Type", PurchaseLine2."Document Type"::Order);
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Document No.", Rec."No.");
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Line No.", LineNo1);
                                            PurchaseLine2.VALIDATE(PurchaseLine2.Type, PurchaseLine2.Type::" ");
                                            PurchaseLine2.Description := IndentLine.Description;//MSBS.Rao 091213
                                            PurchaseLine2."Description 2" := IndentLine."Description 2";//MSBS.Rao 091213
                                            PurchaseLine2."Unit of Measure Code" := IndentLine."Unit of Measurement";
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Indent No.", IndentLine."Document No.");
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Indent Line No.", IndentLine."Line No.");
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Indent Date", IndentLine.Date);
                                            IndentLine.CALCFIELDS(IndentLine."Capex No.");
                                            PurchaseLine2."Capex No." := IndentLine."Capex No.";
                                            PurchaseLine2.INSERT(TRUE);
                                            //MSBS.Rao Stop 091213
                                        END;

                                    IndentLineTemp.RESET;
                                    IndentLineTemp.SETRANGE("Document No.", IndentLine."Document No.");
                                    IndentLineTemp.SETRANGE("Line No.", IndentLine."Line No.");
                                    IF IndentLineTemp.FINDFIRST THEN BEGIN
                                        IndentLineTemp."Order No." := Rec."No.";//MSBS.Rao 0713 Code commited // PurchaseLine2."Document No.";
                                        IndentLineTemp."Order Line No." := PurchaseLine2."Line No.";
                                        IF IndentLineTemp.Quantity = PurchaseLine2.Quantity THEN
                                            IndentLineTemp.VALIDATE(IndentLineTemp.Status, IndentLineTemp.Status::Closed);
                                        IndentLineTemp."Order Date" := Rec."Posting Date";
                                        IndentLineTemp.MODIFY;
                                    END;
                                //IndentLineTemp.COPY(IndentLine);
                                UNTIL IndentLine.NEXT = 0;

                        END;
                    end;
                }
            }
        }
        addafter("&Print")
        {
            action("  Job Order")
            {
                Caption = '  Job Order';
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    RecPurchaseHeader: Record "Purchase Header";
                begin
                    RecPurchaseHeader.SETRANGE("Document Type", Rec."Document Type");
                    RecPurchaseHeader.SETRANGE("No.", Rec."No.");
                    RecPurchaseHeader.SETRANGE("Buy-from Vendor No.", Rec."Buy-from Vendor No.");
                    IF RecPurchaseHeader.FINDFIRST THEN
                        REPORT.RUNMODAL(Report::"Job Purchase Order GST", TRUE, TRUE, RecPurchaseHeader);
                end;
            }
            action("GST Purchase Order Print")
            {
                Caption = 'GST Purchase Order Print';
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    RecPurHed.RESET;
                    RecPurHed.SETRANGE("No.", Rec."No.");
                    IF RecPurHed.FINDFIRST THEN
                        REPORT.RUNMODAL(Report::"Purchase Order GST ", TRUE, TRUE, RecPurHed);
                end;
            }
        }
    }

    var
        PurchCommenLineAr: Record "Purch. Comment Line Archive";
        txtMessage: Text;

    var
        ApprovalMgt: Codeunit "Approvals Mgmt.";//439 Rep "Approvals Mgmt."

    var
        PurchaseLine3: Record "Purchase Line";
        Text010: Label 'Approval is not needed. You can directly release the document.';

    var
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchLine1: Record "Purchase Line";
        PurchLine2: Record "Purchase Line";
        NotifyManagement: Codeunit "Notify Management";
        NotificationEntry: Record "Notification Entry Table";
        //txtMessage: Text;
        NotifyRecRef: RecordRef;
        PurchNotifyRecID: RecordID;
        rPurchRcptHdr: Record "Purch. Rcpt. Header";
        rLocation: Record Location;
        rNotifyUserMapping: Record "Notification - User Mapping";
        cdNotifyCd: Code[20];
        xdecQty: array[1000000] of Decimal;
        rPurcLine: Record "Purchase Line";


    var
        rNoSeries: Record "No. Series";
        rUserLocation: Record "User Location";

    var
        RecPurHed: Record "Purchase Header";

    var
        WFAmount: Decimal;
        WFPurchLine: Record "Purchase Line";
        LineNo: Integer;
        IsValid: Boolean;
        ReleasePurchaseDocument: Codeunit "Release Purchase Document";
        ShortClose: Codeunit ShortClose;
        UserSetup: Record "User Setup";
        IndentLine: Record "Indent Line";
        PurchaseLine2: Record "Purchase Line";
        GetFilters: Code[80];
        LineNo1: Integer;
        IndentHeader: Record "Indent Header";
        IndentLine1: Record "Indent Line";
        IndentHeader1: Record "Indent Header";
        IndentLine2: Record "Indent Line";
        IndentHeader2: Record "Indent Header";
        LockPurchDoc: Codeunit "Lock Sales Document";
        UserLocation: Record "User Location";
        LocationFilterString: Text[1024];
        recpurchaseHeader2: Record "Purchase Header";
        // SMTP: Codeunit 400;//16225 N/F
        chrLineBreak: Char;
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        // PurchLine1: Record "39";
        PurchaseHeader: Record "Purchase Header";
        UsrSetup: Record "User Setup";
        UsrSetup1: Record "User Setup";
        UserId: Code[10];
        RecPL: Record "Purchase Line";
        NewIndentLine: Record "Indent Line";
        [InDataSet]
        BTReleaseEnable: Boolean;
        [InDataSet]
        PurchHistoryBtnVisible: Boolean;
        [InDataSet]
        PayToCommentPictVisible: Boolean;
        [InDataSet]
        PayToCommentBtnVisible: Boolean;
        [InDataSet]
        PurchHistoryBtn1Visible: Boolean;
        [InDataSet]
        "Buy-from Vendor No.Editable": Boolean;
        [InDataSet]
        BTOrderEnable: Boolean;
        [InDataSet]
        BTFunctionEnable: Boolean;
        [InDataSet]
        BtPostingEnable: Boolean;
        [InDataSet]
        BtLineEnable: Boolean;
        IndentLineList: Page "Indent Lines List";
        PlRec: Record "Purchase Line";
        // "...tri1.0": ;
        Text0001: Label 'Challan Quantity must be filled in.';
        Text0002: Label 'Actual Quantity must be filled in.';
        Text0003: Label 'Accepted Quantity must be filled in.';
        Text0004: Label 'Rejection Reason Code must be entered.';
        Text0005: Label 'Shortage Reason Code must be entered.';
        Text0006: Label 'Status must be Released while posting.';
        Text0007: Label 'Status must be Open while changing the "Buy-from Post code".';
        Text000: Label 'Do you want to convert the Order to an Import order?';
        Error0001: Label 'You can''t Insert Indent Line, Please contact to your system administrator !!!';
        nqty: Decimal;
        MS00001: Label 'Status Must be Released';

    var
        AttachmentRecRef: RecordRef;
        AttachmentManagment: Record "Attachment Management";
        AttachmentRecID: RecordID;
        vendorrec: Record Vendor;

    trigger OnAfterGetRecord()
    begin
        //Upgrade(+)
        EnabledFalse;
        OnAfterGetCurrRecord1;
        //upgarde(-)

    end;

    trigger OnOpenPage()
    begin
        //Upgrade(+)//Oninit Start
        BtLineEnable := TRUE;
        BtPostingEnable := TRUE;
        BTFunctionEnable := TRUE;
        BTOrderEnable := TRUE;
        "Buy-from Vendor No.Editable" := TRUE;
        BTReleaseEnable := TRUE;
        //Upgrade(-)Oninit End
        //onopen start
        IF USERID IN ['pu006', 'pu009', 'ma025'] THEN BEGIN
            BTReleaseEnable := FALSE;
        END;
        //upgrade(+)
        //TRI SC
        //ND Tri Start Cust 38
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."View Purchase Order", '%1', TRUE);
        IF UserLocation.FIND('-') THEN
            REPEAT
                IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                    LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
            UNTIL UserLocation.NEXT = 0;

        LocationFilterString := COPYSTR(LocationFilterString, 2, 1024);

        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');

        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Location Code", LocationFilterString);
        Rec.FILTERGROUP(0);
        //ND Tri End Cust 38

    end;


    procedure SendOrderNo() OrderNo: Code[20]
    begin
        OrderNo := Rec."No.";
    end;

    procedure CompletlyOrdered()
    var
        IndentLine2: Record "Indent Line";
        IndentHeader2: Record "Indent Header";
    begin
        IndentHeader2.RESET;
        IndentHeader2.SETFILTER(Deleted, '%1', FALSE);
        IndentHeader2.SETFILTER(IndentHeader2."Completely Ordered", '%1', FALSE);
        IF IndentHeader2.FIND('-') THEN
            REPEAT
                IndentLine2.RESET;
                IndentLine2.SETFILTER(IndentLine2."Document No.", IndentHeader2."No.");
                IndentLine2.SETFILTER(IndentLine2.Deleted, '%1', FALSE);
                IndentLine2.SETFILTER(IndentLine2."Order No.", '%1', '');
                IF NOT IndentLine2.FIND('-') THEN BEGIN
                    IndentHeader2."Completely Ordered" := TRUE;
                    IndentHeader2.MODIFY;
                END;
                COMMIT;
            UNTIL IndentHeader2.NEXT = 0;
    end;

    procedure EnabledFalse()
    begin
        IF Rec.Status = Rec.Status::"Short Close" THEN BEGIN
            CurrPage.EDITABLE := FALSE;
            BTOrderEnable := FALSE;
            BTFunctionEnable := FALSE;
            BtPostingEnable := FALSE;
            //CurrForm.btPrint.ENABLED := FALSE;
            BtLineEnable := FALSE;
            BTReleaseEnable := FALSE;
        END ELSE BEGIN
            CurrPage.EDITABLE := TRUE;
            BTOrderEnable := TRUE;
            BTFunctionEnable := TRUE;
            BtPostingEnable := TRUE;
            //CurrForm.btPrint.ENABLED := TRUE;
            BtLineEnable := TRUE;
            BTReleaseEnable := TRUE;
        END;

        PurchaseHeader.CALCFIELDS("No. of Archived Versions");
        IF Rec."No. of Archived Versions" <> 0 THEN
            "Buy-from Vendor No.Editable" := FALSE;
    end;

    procedure GetPOQty(IndentNo: Code[20]; ItemNo: Code[20]): Decimal
    var
        RecIndentLine: Record "Indent Line";
        POQty: Decimal;
    begin
        POQty := 0;
        RecIndentLine.SETRANGE("Document No.", IndentNo);
        RecIndentLine.SETRANGE("No.", ItemNo);
        IF RecIndentLine.FINDFIRST THEN BEGIN
            REPEAT
                RecIndentLine.CALCFIELDS("PO Qty");
                POQty += RecIndentLine."PO Qty";
            UNTIL RecIndentLine.NEXT = 0;
            EXIT(POQty);
        END;
    end;

    procedure GetIndentQty(IndentNo: Code[20]; ItemNo: Code[20]): Decimal
    var
        RecIndentLine: Record "Indent Line";
    begin
        RecIndentLine.SETRANGE("Document No.", IndentNo);
        RecIndentLine.SETRANGE("No.", ItemNo);
        IF RecIndentLine.FINDFIRST THEN
            EXIT(RecIndentLine.Quantity);
    end;

    procedure GetRectQty(IndentNo: Code[20]; ItemNo: Code[20]): Decimal
    var
        RecIndentLine: Record "Indent Line";
        RectQty: Decimal;
    begin
        RectQty := 0;
        RecIndentLine.SETRANGE("Document No.", IndentNo);
        RecIndentLine.SETRANGE("No.", ItemNo);
        IF RecIndentLine.FINDFIRST THEN BEGIN
            REPEAT
                RecIndentLine.CALCFIELDS("Received Qty");
                RectQty += RecIndentLine."Received Qty";
            UNTIL RecIndentLine.NEXT = 0;
            EXIT(RectQty);
        END;
    end;

    procedure GetOrginalQty(IndentNo: Code[20]; ItemNo: Code[20]): Decimal
    var
        RecIndentLine: Record "Indent Line";
        RectQty: Decimal;
    begin
        RecIndentLine.SETRANGE("Document No.", IndentNo);
        RecIndentLine.SETRANGE("No.", ItemNo);
        RecIndentLine.SETRANGE("Orginal Entry", TRUE);
        IF RecIndentLine.FINDFIRST THEN
            EXIT(RecIndentLine.Quantity);
    end;

    local procedure OnAfterGetCurrRecord1()
    begin
        xRec := Rec;
        EnabledFalse;
    end;
}

