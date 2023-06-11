page 50040 "Vendor Requisition"
{
    Caption = 'Vendor Creation';
    PageType = Card;
    Permissions = TableData "Approval Entry" = rim;
    PromotedActionCategories = 'New,Process,Report,Approve,Request Approval';
    RefreshOnActivate = true;
    SourceTable = "Vendor Requisition";
   


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Name; Rec.Name)
                {
                    Importance = Promoted;
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = All;
                }
                field("State Description"; Rec."State Desc")
                {
                    Caption = 'State Description';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Zone; Rec.Zone)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Pin Code"; Rec."Pin Code")
                {
                    ApplicationArea = All;
                }
                field("Mobile No.>"; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Landline No."; Rec."Landline No.")
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
                field("Supplier's E-Mail"; Rec."E-Mail")
                {
                    Caption = 'Supplier''s E-Mail';
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Vendor Address"; Rec."Vendor Address")
                {
                    ApplicationArea = All;
                }
                field("Vendor Address 2"; Rec."Vendor Address 2")
                {
                    ApplicationArea = All;
                }
                field("Vendor City"; Rec."Vendor City")
                {
                    ApplicationArea = All;
                }
                field("Vendor Contact"; Rec."Vendor Contact")
                {
                    ApplicationArea = All;
                }
                field("Vendor Phone No."; Rec."Vendor Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Telex No."; Rec."Vendor Telex No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Detail"; Rec.Picture)
                {
                    Caption = 'Bank Details';
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                group("Employee Details")
                {
                    field(Dsgn; Rec.Dsgn)
                    {
                        ApplicationArea = All;
                    }
                    field("Emp Code"; Rec."Emp Code")
                    {
                        ApplicationArea = All;
                    }
                    field(Section; Rec.Section)
                    {
                        ApplicationArea = All;
                    }
                    field("Department Code"; Rec."Department Code")
                    {
                        ApplicationArea = All;
                    }
                    field(Grade; Rec.Grade)
                    {
                        ApplicationArea = All;
                    }
                    field(DOJ; Rec.DOJ)
                    {
                        ApplicationArea = All;
                    }
                }
                field(Region; Rec.Region)
                {
                    ApplicationArea = All;
                }
                field("Vendor Classification"; Rec."Vendor Classification")
                {
                    ApplicationArea = All;
                }
                field("Vend. Company Type"; Rec."Vend. Company Type")
                {
                    ApplicationArea = All;
                }
                field("Security Amount"; Rec."Security Amount")
                {
                    ApplicationArea = All;
                }
                field("Security Date"; Rec."Security Date")
                {
                    ApplicationArea = All;
                }
                field(Transporter; Rec.Transporter)
                {
                    ApplicationArea = All;
                }
                field(Transporter1; Rec.Transporter1)
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Msme Code"; Rec."Msme Code")
                {
                    ApplicationArea = All;
                }
                field("Micro Enterprises"; Rec."Micro Enterprises")
                {
                    ApplicationArea = All;
                }
                field("Small Enterprises"; Rec."Small Enterprises")
                {
                    ApplicationArea = All;
                }
                field("Medium Enterprises"; Rec."Medium Enterprises")
                {
                    ApplicationArea = All;
                }
                field("A/C user E-mail"; Rec."A/C user E-mail")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Editable = false;
                    Enabled = true;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Excise Bus. Posting Group"; Rec."Excise Bus. Posting Group")
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    Importance = Promoted;
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                group("Bank Details")
                {
                    field("Bank Beneficiary Name"; Rec."Bank Beneficiary Name")
                    {
                        ShowMandatory = true;
                        ApplicationArea = All;
                    }
                    field("Bank A/c"; Rec."Bank A/c")
                    {
                        Editable = "BankA/cEditable";
                        ShowMandatory = true;
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            IF rec.Status <> rec.Status::Approved THEN
                                "BankA/cEditable" := FALSE;

                        end;
                    }
                    field("Bank Account Name"; Rec."Bank Account Name")
                    {
                        ShowMandatory = true;
                        ApplicationArea = All;
                    }
                    field("Bank Address"; Rec."Bank Address")
                    {
                        ShowMandatory = true;
                        ApplicationArea = All;
                    }
                    field("Bank Address 2"; Rec."Bank Address 2")
                    {
                        ShowMandatory = true;
                        ApplicationArea = All;
                    }
                    field("RTGS/NEFT Code"; Rec."RTGS/NEFT Code")
                    {
                        ShowMandatory = true;
                        ApplicationArea = All;
                    }
                }
                field("P.A.N. No."; Rec."P.A.N. No.")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("GST No."; Rec."GST No.")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("P.A.N. Status"; Rec."P.A.N. Status")
                {
                    ApplicationArea = All;
                }
                field("P.A.N. Reference No."; Rec."P.A.N. Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Tax Registration No."; Rec."Tax Registration No.")
                {
                    ApplicationArea = All;
                }
                field("Aggregate Turnover"; Rec."Aggregate Turnover")
                {
                    ApplicationArea = All;
                }
                field("GST Registration No."; Rec."GST Registration No.")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("GST Vendor Type"; Rec."GST Vendor Type")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Zone Region"; Rec."Zone Region")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Vendor Class"; Rec."Vendor Class")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Vendor Code"; Rec."No. Series Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /*field('------------------------------------------------------';'------------------------------------------------------')
                {
                    Visible = false;
                }*/ // 15578
            }
            group(gernal)
            {
                Visible = false;
                field(Contact; Rec.Contact)
                {
                    Editable = ContactEditable;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ContactOnAfterValidate;
                    end;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        VendLedgEntry: Record "Vendor Ledger Entry";
                        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
                    begin
                        DtldVendLedgEntry.SETRANGE("Vendor No.", Rec."No.");
                        Rec.COPYFILTER("Global Dimension 1 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 1");
                        Rec.COPYFILTER("Global Dimension 2 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 2");
                        Rec.COPYFILTER("Currency Filter", DtldVendLedgEntry."Currency Code");
                        VendLedgEntry.DrillDownOnEntries(DtldVendLedgEntry);
                    end;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Blocked Vendor"; Rec."Blocked Vendor")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Net Change"; Rec."Net Change")
                {
                    ApplicationArea = All;
                }
                field("<City1>"; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
                field("Service Entity Type"; Rec."Service Entity Type")
                {
                    ApplicationArea = All;
                }
                field("Balance confirmation"; Rec."Balance confirmation")
                {
                    ApplicationArea = All;
                }
                field("Balance Conf Date"; Rec."Balance Conf Date")
                {
                    ApplicationArea = All;
                }
                field("Bal on Balance Conf Date"; Rec."Bal on Balance Conf Date")
                {
                    Caption = '"Bal on Balance Conf Date"';
                    ApplicationArea = All;
                }
                field("Vend Ledger Balance"; Rec."Vend Ledger Balance")
                {
                    ApplicationArea = All;
                }
                field("194Q "; Rec."194Q")
                {
                    Caption = '194Q';
                    ApplicationArea = All;
                }
                field("194Q Recived Data"; Rec."194Q Recived Data")
                {
                    ApplicationArea = All;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                Visible = false;
                field("E-Mail of Requested By Person"; Rec."Requested By")
                {
                    ApplicationArea = All;
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                Visible = false;
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
                    begin
                        //VATRegistrationLogMgt.AssistEditVendorVATReg(Rec);  //--Vrn
                    end;
                }
                field(GLN; Rec.GLN)
                {
                    ApplicationArea = All;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                }
                field(SSI; Rec.SSI)
                {
                    ApplicationArea = All;
                }
                field("SSI Validity Date"; Rec."SSI Validity Date")
                {
                    ApplicationArea = All;
                }
                field("Invoice Disc. Code"; Rec."Invoice Disc. Code")
                {
                    NotBlank = true;
                    ApplicationArea = All;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = All;
                }
                field(Structure; Rec.Structure)
                {
                    ApplicationArea = All;
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                Visible = false;
                field("Application Method"; Rec."Application Method")
                {
                    ApplicationArea = All;
                }
                field("Partner Type"; Rec."Partner Type")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
                field("Cash Flow Payment Terms Code"; Rec."Cash Flow Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Our Account No."; Rec."Our Account No.")
                {
                    ApplicationArea = All;
                }
                field("Block Payment Tolerance"; Rec."Block Payment Tolerance")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /* --Vrn
                        IF "Block Payment Tolerance" THEN BEGIN
                          IF CONFIRM(Text002,FALSE) THEN
                            PaymentToleranceMgt.DelTolVendLedgEntry(Rec);
                        END ELSE BEGIN
                          IF CONFIRM(Text001,FALSE) THEN
                            PaymentToleranceMgt.CalcTolVendLedgEntry(Rec);
                        END;
                        */

                    end;
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                    ApplicationArea = All;
                }
                field("Preferred Bank Account"; Rec."Preferred Bank Account")
                {
                    ApplicationArea = All;
                }
            }
            group(Receiving)
            {
                Caption = 'Receiving';
                Visible = false;
                field("Location Code"; Rec."Location Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Branch Filter"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Branch Filter';
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    DrillDown = false;
                    ApplicationArea = All;
                }
                /* field("Customized Calendar"; CalendarMgmt.CustomizedCalendarExistText(CustomizedCalendar."Source Type"::Vendor, Rec."No.", '', Rec."Base Calendar Code"))
                 {
                     Caption = 'Customized Calendar';
                     Editable = false;
                     ApplicationArea = All;

                     trigger OnDrillDown()
                     begin
                         CurrPage.SAVERECORD;
                         Rec.TESTFIELD("Base Calendar Code");
                      //   CalendarMgmt.ShowCustomizedCalendar(CustomizedCalEntry."Source Type"::Vendor, Rec."No.", '', Rec."Base Calendar Code");
                     end;
                 }*/
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                Visible = false;
                field("Currency Code"; Rec."Currency Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Language Code"; Rec."Language Code")
                {
                    ApplicationArea = All;
                }
            }
            group("Tax Information")
            {
                Caption = 'Tax Information';
                Visible = false;
                group(Tax)
                {
                    Caption = 'Tax';
                    field("L.S.T. No."; Rec."L.S.T. No.")
                    {
                        ApplicationArea = All;
                    }
                    field("C.S.T. No."; Rec."C.S.T. No.")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Excise)
                {
                    Caption = 'Excise';
                    field("E.C.C. No."; Rec."E.C.C. No.")
                    {
                        ApplicationArea = All;
                    }
                    field(Range; Rec.Range)
                    {
                        ApplicationArea = All;
                    }
                    field(Collectorate; Rec.Collectorate)
                    {
                        ApplicationArea = All;
                    }
                    field("Vendor Type"; Rec."Vendor Type")
                    {
                        ApplicationArea = All;
                    }
                    field("<State Code1>"; Rec."State Code")
                    {
                        ApplicationArea = All;
                    }
                    field("<EExcise Bus. Posting Group>"; Rec."Excise Bus. Posting Group")
                    {
                        ApplicationArea = All;
                    }
                    field("<SsSI>"; Rec.SSI)
                    {
                        ApplicationArea = All;
                    }
                    field("<SSSI Validity Date>"; Rec."SSI Validity Date")
                    {
                        ApplicationArea = All;
                    }
                    field("<Sstructure>"; Rec.Structure)
                    {
                        ApplicationArea = All;
                    }
                }
                group(VAT)
                {
                    Caption = 'VAT';
                    field("T.I.N. No."; Rec."T.I.N. No.")
                    {
                        Importance = Promoted;
                        ApplicationArea = All;
                    }
                    field(Composition; Rec.Composition)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Income Tax")
                {
                    Caption = 'Income Tax';
                    field("Tranporter RCM GST No."; Rec."GST No.")
                    {
                        ApplicationArea = All;
                    }
                    field("<Sservice Tax Registration No.>"; Rec."Service Tax Registration No.")
                    {
                        ApplicationArea = All;
                    }
                    field("CST Tin"; Rec."CST Tin")
                    {
                        ApplicationArea = All;
                    }
                }
                group("Service Tax")
                {
                    Caption = 'Service Tax';
                    field("Service Tax Registration No."; Rec."Service Tax Registration No.")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Subcontractor1)
                {
                    Caption = 'Subcontractor';
                    field(Subcontractor; Rec.Subcontractor)
                    {
                        Importance = Promoted;
                        ApplicationArea = All;
                    }
                    field("Vendor Location"; Rec."Vendor Location")
                    {
                        ApplicationArea = All;
                    }
                    field("Commissioner's Permission No."; Rec."Commissioner's Permission No.")
                    {
                        ApplicationArea = All;
                    }
                }
                group(GST)
                {
                    Caption = 'GST';
                    field("Associated Enterprises"; Rec."Associated Enterprises")
                    {
                        ApplicationArea = All;
                    }
                    field("ARN No."; Rec."ARN No.")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //SendMail.SendVendorMialApproval(Rec);

                        //MSVrn -->>
                        Rec.TESTFIELD(Name);
                        Rec.TESTFIELD(Address);
                        //TESTFIELD("Address 2");

                        IF Rec."Country/Region Code" = '01' THEN
                            Rec.TESTFIELD("Post Code"); //(In Case Of India )

                        Rec.TESTFIELD("State Code");

                        Rec.TESTFIELD(Status, Rec.Status::Open);
                        Rec.TESTFIELD("Country/Region Code");

                        Rec.TESTFIELD("P.A.N. No.");
                        //TESTFIELD("Msme Code");

                        Rec.TESTFIELD("Pin Code");
                        //TESTFIELD(Contact);
                        Rec.TESTFIELD("Vendor Classification");
                        Rec.TESTFIELD("E-Mail");
                        Rec.TESTFIELD("Bank A/c");
                        Rec.TESTFIELD("Bank Account Name");
                        Rec.TESTFIELD("Bank Address");
                        Rec.TESTFIELD("Bank Beneficiary Name");
                        Rec.TESTFIELD("GST Vendor Type");
                        IF Rec."GST Vendor Type" IN [Rec."GST Vendor Type"::Registered] THEN
                            Rec.TESTFIELD("GST Registration No.");

                        //TESTFIELD("Vendor Type");
                        Rec.TESTFIELD("Zone Region");
                        Rec.TESTFIELD("Vendor Class");

                        Rec.GetVendorNoSeries;

                        //SendMail.AppEntryVendor1(Rec);

                        Rec.SendForApproval(Rec);

                        //--<<

                        /*
                        IF ApprovalsMgmt.CheckVendorApprovalsWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnSendVendorForApproval(Rec);
                          */

                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        IF CONFIRM('Do you want to cancel %1 approval?', TRUE, Rec."No.") THEN BEGIN
                            recAppEnt.RESET;
                            //recAppEnt.SETFILTER("Approval Code", 'VENDOR');
                            recAppEnt.SETRANGE("Document No.", Rec."No.");
                            //recAppEnt.SETFILTER(Status, '%1', recAppEnt.Status::Open);
                            IF recAppEnt.FINDFIRST THEN BEGIN
                                REPEAT
                                    //recAppEnt.DELETEALL;
                                    recAppEnt.Status := recAppEnt.Status::Cancelled;
                                    recAppEnt.MODIFY(TRUE);

                                UNTIL recAppEnt.NEXT = 0;
                                Rec."Approver ID" := '';
                                Rec.Status := Rec.Status::Open;
                                Rec.MODIFY;
                            END;
                            MESSAGE('Vendor %1 approval request canceled!', Rec."No.");
                        END
                        ELSE
                            EXIT;

                        //ApprovalsMgmt.OnCancelVendorApprovalRequest(Rec);
                    end;
                }
                action(Attachments)
                {
                    Image = Attachment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        AttachmentLines: Page "Attachment Lines";
                    begin
                        CLEAR(AttachmentLines);
                        AttachmentLines.SetDocumentDetails(Rec."No.", 0, Rec.RECORDID);
                        AttachmentLines.RUN;
                    end;
                }
                action("Re-Open")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF NOT (USERID IN ['FA006', 'ADMIN']) THEN ERROR('You are not authorised to Reopen');
                        IF CONFIRM('Do you want to Reopen the Vendor Requisition for Editing', TRUE) THEN BEGIN
                            Rec.ReOpen;
                        END;
                    end;
                }
            }
            group(Attachment)
            {
                Caption = 'Attachment';
                Visible = false;
                action(Import)
                {
                    Caption = 'Attachment Document';
                    Image = PostedTaxInvoice;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Rec.Status <> Rec.Status::Open THEN
                            ERROR('Status must be Open');

                        AttachmentRecRef.OPEN(DATABASE::"Vendor Requisition");
                        AttachmentRecRef.SETPOSITION(Rec.GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;
                        AttachmentManagment.ImportAttachment(AttachmentRecID, DATABASE::"Vendor Requisition", 0, Rec."No.", 0);
                    end;
                }
                action(Export)
                {
                    Caption = 'Open Attachment';
                    Image = PostedVendorBill;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        AttachmentRecRef.OPEN(DATABASE::"Vendor Requisition");
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
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Rec.Status <> Rec.Status::Open THEN
                            ERROR('Status must be Open');

                        AttachmentRecRef.OPEN(DATABASE::"Vendor Requisition");
                        AttachmentRecRef.SETPOSITION(Rec.GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;
                        AttachmentManagment.DeleteAttachment(AttachmentRecID);
                    end;
                }
            }
            group("Approval History")
            {
                Caption = 'Approval History';
                action(Approvals)
                {
                    Ellipsis = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalEntriesList: Page "Approval Entries List";
                        ApprovalEntry: Record "Approval Entry";
                    begin
                        ApprovalEntry.RESET;
                        ApprovalEntry.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Sequence No.", "Record ID to Approve");
                        ApprovalEntry.SETRANGE("Table ID", 50062);
                        ApprovalEntry.SETFILTER("Document No.", Rec."No.");
                        IF ApprovalEntry.FINDFIRST THEN BEGIN
                            ApprovalEntriesList.SETTABLEVIEW(ApprovalEntry);
                            ApprovalEntriesList.RUN;
                        END;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ActivateFields;
        OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
        //ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    end;

    trigger OnAfterGetRecord()
    begin
        ActivateFields;
    end;

    trigger OnInit()
    begin
        IF rec.Status <> rec.Status::Approved THEN BEGIN
            ContactEditable := TRUE;
            "P.A.N. No.Editable" := TRUE;
            NameEditable := TRUE;
            "BankA/cEditable" := TRUE;
            MapPointVisible := TRUE;
        end;
    end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit "Online Map Management";
    begin


        ActivateFields;
        IF NOT MapMgt.TestSetup THEN
            MapPointVisible := FALSE;
        IF rec.Status <> rec.Status::Approved THEN BEGIN
            CurrPage.EDITABLE := TRUE
        END;

    end;

    var
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CustomizedCalEntry: Record "Customized Calendar Entry";
        CustomizedCalendar: Record "Customized Calendar Change";
        Text001: Label 'Do you want to allow payment tolerance for entries that are currently open?';
        Text002: Label 'Do you want to remove payment tolerance from entries that are currently open?';
        [InDataSet]
        MapPointVisible: Boolean;
        [InDataSet]
        "P.A.N. No.Editable": Boolean;
        [InDataSet]
        ContactEditable: Boolean;
        [InDataSet]
        SocialListeningSetupVisible: Boolean;
        [InDataSet]
        SocialListeningVisible: Boolean;
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        NameEditable: Boolean;
        "BankA/cEditable": Boolean;
        SendMail: Codeunit "QD Test, PDF Creation & Email";
        MasterAproval: Codeunit "Master Aproval";
        recAppEnt: Record "Approval Entry";
        recVendor: Record Vendor;
        AttachmentRecRef: RecordRef;
        AttachmentRecID: RecordID;
        AttachmentManagment: Record "Attachment Management";

    local procedure ActivateFields()
    begin
        SetSocialListeningFactboxVisibility;
        ContactEditable := Rec."Primary Contact No." = '';
        "P.A.N. No.Editable" := Rec."P.A.N. Status" = 0;
        "BankA/cEditable" := FALSE;
        NameEditable := FALSE;
        "P.A.N. No.Editable" := FALSE;
        IF (Rec."P.A.N. No." = '') OR (UPPERCASE(USERID) = 'IN001') THEN
            "P.A.N. No.Editable" := TRUE;

        IF (Rec.Name <> '') AND (UPPERCASE(USERID) = 'FA011') THEN
            NameEditable := TRUE
        ELSE
            IF Rec.Name = '' THEN
                NameEditable := TRUE;

        IF (Rec."Bank A/c" <> '') AND (UPPERCASE(USERID) = 'FA011') THEN
            "BankA/cEditable" := TRUE
        ELSE
            IF Rec."Bank A/c" = '' THEN
                "BankA/cEditable" := TRUE;
    end;

    local procedure ContactOnAfterValidate()
    begin
        ActivateFields;
    end;

    local procedure PANStatusOnAfterValidate()
    begin
        ActivateFields();
    end;

    local procedure SetSocialListeningFactboxVisibility()
    var
    // SocialListeningMgt: Codeunit 871;
    begin
        //SocialListeningMgt.GetVendFactboxVisibility(Rec,SocialListeningSetupVisible,SocialListeningVisible);
    end;
}

