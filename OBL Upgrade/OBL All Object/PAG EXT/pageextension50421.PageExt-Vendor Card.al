pageextension 50421 pageextension50421 extends "Vendor Card"
{
    layout
    {
        moveafter(Name; "Name 2")
        moveafter(Contact; "IC Partner Code")

        addafter(Blocked)
        {
            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
            field("<City1>"; Rec.City)
            {
                ApplicationArea = All;
            }
        }
        addafter("State Code")
        {
            field(Transporter1; Rec.Transporter1)
            {
                ApplicationArea = all;
            }
        }
        addafter("Home Page")
        {
            field(Balance; Rec.Balance)
            {
                ApplicationArea = All;
            }
        }
        addafter("Location Code")
        {
            field("Branch Filter"; Rec."Global Dimension 1 Code")
            {
                Caption = 'Branch Filter';
                ApplicationArea = All;
            }
            field("Balance confirmation"; Rec."Balance confirmation")
            {
                ApplicationArea = all;
            }

        }
        addafter(City)
        {
            field("<State Code1>"; Rec."State Code")
            {
                ApplicationArea = All;
            }
        }
        moveafter("P.A.N. Reference No."; "Aggregate Turnover")
        moveafter("Associated Enterprises"; "ARN No.")
        moveafter("Post Code"; City)
    }
    actions
    {


        addafter("Request Approval")
        {
            action(SendApprovalRequestOld)
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
                    SendMail: Codeunit "QD Test, PDF Creation & Email";
                begin
                    //SendMail.SendVendorMialApproval(Rec);

                    //MSVrn -->>
                    Rec.TESTFIELD(Name);
                    Rec.TESTFIELD(Address);
                    Rec.TESTFIELD("Address 2");
                    //TESTFIELD("Country/Region Code");
                    //IF "Country/Region Code" =  '01' THEN

                    Rec.TESTFIELD("Post Code"); //(In Case Of India )
                    Rec.TESTFIELD("Pin Code");
                    Rec.TESTFIELD(Contact);
                    Rec.TESTFIELD("Vendor Classification");
                    Rec.TESTFIELD("E-Mail");

                    Rec.TESTFIELD("Bank A/c");
                    Rec.TESTFIELD("Bank Account Name");
                    Rec.TESTFIELD("Bank Address");
                    Rec.TESTFIELD("Bank Beneficiary Name");
                    Rec.TESTFIELD("P.A.N. No.");
                    Rec.TESTFIELD("GST Registration No.");
                    Rec.TESTFIELD("GST Vendor Type");
                    Rec.TESTFIELD("GST No.");
                    //  Rec.TESTFIELD("Vendor Type");

                    SendMail.AppEntryVendor(Rec);

                    IF Rec."Approver ID" <> '' THEN
                        CurrPage.EDITABLE(FALSE);
                    CurrPage.UPDATE(TRUE);

                    //--<<

                    /*
                    IF ApprovalsMgmt.CheckVendorApprovalsWorkflowEnabled(Rec) THEN
                      ApprovalsMgmt.OnSendVendorForApproval(Rec);
                      */

                end;
            }
            action(CancelApprovalRequestOld)
            {
                Caption = 'Cancel Approval Re&quest';
                Enabled = OpenApprovalEntriesExist;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category5;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    recAppEnt: Record "Approval Entry";
                begin
                    IF CONFIRM('Do you want to cancel %1 approval?', TRUE, Rec."No.") THEN BEGIN
                        recAppEnt.RESET;
                        recAppEnt.SETRANGE("Document No.", Rec."No.");
                        recAppEnt.SETFILTER(Status, '%1', recAppEnt.Status::Open);
                        IF recAppEnt.FINDFIRST THEN BEGIN
                            recAppEnt.Status := recAppEnt.Status::Canceled;
                            recAppEnt.MODIFY;
                            Rec."Approver ID" := '';
                            Rec.MODIFY;
                        END;
                        MESSAGE('Vendor %1 approval request cancelled!', Rec."No.");
                    END
                    ELSE
                        EXIT;

                    //ApprovalsMgmt.OnCancelVendorApprovalRequest(Rec);
                end;
            }
            action(ArchiveVendor)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you want to Arcive Vendor', TRUE) THEN
                        Rec.ArchiveVendor(Rec, USERID);
                end;
            }
        }
        /* modify("Vendor Sections")
        {
            trigger OnAfterAction()
            begin
                IF CONFIRM('Do You want to Create NOD/NOC Lines for 194Q Section', FALSE) THEN BEGIN
                    rec.GenerateNODNOCData();
                end;

            end;
        }15578 */



        addafter(VendorReportSelections)
        {
            action("Vendor Balance Update")
            {
                Caption = 'Vendor Balance Update';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Vendor Balance Update";
                ApplicationArea = All;

                trigger OnAction()
                var
                    VENDLEntry: Record "Vendor Ledger Entry";
                    VENDLEntry2: Record "Vendor Ledger Entry";
                begin
                    VENDLEntry.RESET;
                    VENDLEntry.SETCURRENTKEY("Vendor No.", "Posting Date", "Currency Code");
                    VENDLEntry.SETFILTER("Vendor No.", '%1', 'D0110300107');
                    IF VENDLEntry.FINDFIRST THEN
                        REPEAT
                            VENDLEntry2.RESET;
                            VENDLEntry2.COPY(VENDLEntry);
                            VENDLEntry2.NEXT;
                            MESSAGE('%1    %2', VENDLEntry."Vendor No.", VENDLEntry2."Vendor No.");
                        UNTIL
                        VENDLEntry.NEXT = 0;
                end;
            }

            action("Generate NOD/NOC Lines")
            {
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you Want to Create NOD/NOC Lines for 194Q', FALSE) THEN BEGIN
                        Rec.GenerateNODNOCData();
                    END;
                end;
            }
            action("Generate All NOD/NOC Lines")
            {
                Enabled = true;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                Visible = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Vendor: Record Vendor;
                begin
                    IF CONFIRM('Do You want to Create Allowed Section 194Q', FALSE) THEN BEGIN
                        /*    Vendor.RESET;
                           Vendor.SETFILTER("GST Vendor Type", '<%1', Vendor."GST Vendor Type"::Import);
                           Vendor.SETFILTER(Blocked, '%1', Vendor.Blocked::" ");
                           IF Vendor.FINDFIRST THEN
                               REPEAT
                                   Rec.GenerateNODNOCData(Vendor);
                               UNTIL Vendor.NEXT = 0; */
                        rec.GenerateNODNOCData();
                    END;
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        rec."Creation Date" := Today;
        rec."Created By" := UserId;
    end;

    var
        NameEditable: Boolean;
        "BankA/cEditable": Boolean;
        OpenApprovalEntriesExist: Boolean;




    //Unsupported feature: Code Modification on "ActivateFields(PROCEDURE 3)".

    //procedure ActivateFields();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetSocialListeningFactboxVisibility;
    ContactEditable := "Primary Contact No." = '';
    "P.A.N. No.Editable" := "P.A.N. Status" = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    "BankA/cEditable" := FALSE;
    NameEditable := FALSE;
    "P.A.N. No.Editable" := FALSE;
    IF ("P.A.N. No." = '') OR (UPPERCASE(USERID) = 'IN001') THEN
        "P.A.N. No.Editable" := TRUE;

    IF (Name <> '') AND (UPPERCASE(USERID) = 'FA011') THEN
        NameEditable := TRUE
    ELSE IF Name = '' THEN
      NameEditable := TRUE;

    IF ("Bank A/c" <> '') AND (UPPERCASE(USERID) = 'FA011') THEN
        "BankA/cEditable" := TRUE
    ELSE IF "Bank A/c" = '' THEN
      "BankA/cEditable" := TRUE;
    */
    //end;
}

