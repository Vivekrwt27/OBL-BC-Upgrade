codeunit 90030 "WS Approval Mgt"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntry: Record "Approval Entry";
        PurchaseHeader: Record "Purchase Header";
        MailMgt: Codeunit "Report Audit Mgt/Discount Mail";
        SalesHeader: Record "Sales Header";
        ApprovalEntryPAC: Record "Approval Entry";
        OlDAppEntry: Record "Approval Entry";


    procedure ApproveDocument(TxtGUID: Text; TxtComment: Text)
    var
        SalesHeader: Record "Sales Header";
        DocNo: Code[20];
        SP: Record "Salesperson/Purchaser";
        PACApproval: Boolean;
    begin

        IF TxtGUID = '' THEN
            EXIT;
        CLEAR(OlDAppEntry);
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE("GUID Key", TxtGUID);
        IF ApprovalEntry.FINDFIRST THEN BEGIN
            IF (ApprovalEntry.Status = ApprovalEntry.Status::Approved) THEN
                ERROR('Already Approved');
            DocNo := ApprovalEntry."Document No.";
            // IF (ApprovalEntry.Status<>ApprovalEntry.Status::Created) OR (ApprovalEntry.Status<>ApprovalEntry.Status::Open) THEN
            //   ERROR('Not a Valid Document');
            OlDAppEntry := ApprovalEntry;
            ApprovalEntry.VALIDATE(Status, ApprovalEntry.Status::Approved);
            ApprovalEntry."Comment Text" := COPYSTR(TxtComment, 1, 249);

            ArchiveApprovalEntry(ApprovalEntry, OlDAppEntry); //MSKS1312
            ApprovalEntry.MODIFY;

            //New Code Added for PAC Approval.
            SP.RESET;
            IF SP.GET(ApprovalEntry."Approver Code") THEN
                IF SP.Type = SP.Type::PAC THEN
                    PACApproval := TRUE;

            IF PACApproval THEN BEGIN
                ApprovalEntryPAC.RESET;
                ApprovalEntryPAC.SETRANGE("Document No.", DocNo);
                IF ApprovalEntryPAC.FINDFIRST THEN BEGIN
                    REPEAT
                        IF ApprovalEntryPAC.Status = ApprovalEntryPAC.Status::Created THEN BEGIN
                            OlDAppEntry := ApprovalEntryPAC;
                            ApprovalEntryPAC.VALIDATE(Status, ApprovalEntryPAC.Status::Approved);
                            //ApprovalEntryPAC."Comment Text" := 'PAC APPROVAL1';

                            ArchiveApprovalEntry(ApprovalEntryPAC, OlDAppEntry); //MSKS1312
                            ApprovalEntryPAC.MODIFY;
                        END;
                    UNTIL ApprovalEntryPAC.NEXT = 0;
                END;
                SalesHeader.RESET;
                SalesHeader.SETRANGE("No.", ApprovalEntry."Document No.");
                IF SalesHeader.FINDFIRST THEN BEGIN
                    SalesHeader.Status := SalesHeader.Status::"Price Approved";
                    SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::" ";
                    SalesHeader.MODIFY;
                END;
            END;
            //New Code Added for PAC Approval.



            ApprovalEntry.RESET;
            ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", 36);
            ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocNo);
            ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Created);
            IF ApprovalEntry.FINDFIRST THEN BEGIN
                CLEAR(MailMgt);
                SalesHeader.RESET;
                SalesHeader.SETRANGE("No.", ApprovalEntry."Document No.");
                IF SalesHeader.FINDFIRST THEN BEGIN
                    MailMgt.CreateMailForPO(SalesHeader, ApprovalEntry."Approver Code");
                    IF SP.GET(ApprovalEntry."Approver Code") THEN BEGIN
                        CASE SP.Type OF
                            SP.Type::PCH:
                                BEGIN
                                    SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::PCH;
                                    SalesHeader.MODIFY;
                                END;
                            SP.Type::"Zone Manager":
                                BEGIN
                                    SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::ZM;
                                    SalesHeader.MODIFY;
                                END;
                            SP.Type::PSM:
                                BEGIN
                                    SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::PSM;
                                    SalesHeader.MODIFY;
                                END;
                            SP.Type::PAC:
                                BEGIN
                                    SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::PAC;
                                    SalesHeader.MODIFY;
                                END;

                        END;
                    END;

                END;
            END ELSE BEGIN
                SalesHeader.RESET;
                SalesHeader.SETRANGE("No.", ApprovalEntry."Document No.");
                IF SalesHeader.FINDFIRST THEN BEGIN
                    SalesHeader.Status := SalesHeader.Status::"Price Approved";
                    SalesHeader."Approval Pending At" := SalesHeader."Approval Pending At"::" ";
                    SalesHeader.MODIFY;
                END;
            END;
        END;
    end;


    procedure RejectDocument(TxtGUID: Text; TxtComment: Text)
    var
        DocNo: Code[20];
    begin
        IF TxtGUID = '' THEN
            EXIT;
        IF TxtComment = '' THEN
            ERROR('Please mention Rejection Reason');

        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE(ApprovalEntry."GUID Key", TxtGUID);
        IF ApprovalEntry.FINDFIRST THEN BEGIN
            IF ApprovalEntry.Status = ApprovalEntry.Status::Rejected THEN
                ERROR('Already Rejected');
            DocNo := ApprovalEntry."Document No.";
            //IF (ApprovalEntry.Status<>ApprovalEntry.Status::Created) OR (ApprovalEntry.Status<>ApprovalEntry.Status::Open) THEN
            // ERROR('Not a Valid Document');
            OlDAppEntry := ApprovalEntry;
            ApprovalEntry.VALIDATE(Status, ApprovalEntry.Status::Rejected);
            ApprovalEntry."Comment Text" := COPYSTR(TxtComment, 1, 249);
            ArchiveApprovalEntry(ApprovalEntry, OlDAppEntry); //MSKS1312
            ApprovalEntry.MODIFY;

            ApprovalEntry.RESET;
            ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocNo);
            ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", 36);
            ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Created);
            IF ApprovalEntry.FINDFIRST THEN BEGIN
                ApprovalEntry.MODIFYALL(Status, ApprovalEntry.Status::Cancelled);
            END;
            SalesHeader.RESET;
            SalesHeader.SETRANGE("No.", ApprovalEntry."Document No.");
            IF SalesHeader.FINDFIRST THEN BEGIN
                SalesHeader.Status := SalesHeader.Status::Open;
                SalesHeader.MODIFY;
            END;

            ApprovalEntry.RESET;
            ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", 36);
            ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocNo);
            ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Rejected);
            IF ApprovalEntry.FINDFIRST THEN BEGIN
                REPEAT
                    CLEAR(MailMgt);
                    SalesHeader.RESET;
                    SalesHeader.SETRANGE("No.", ApprovalEntry."Document No.");
                    IF SalesHeader.FINDFIRST THEN BEGIN
                        MailMgt.CreateMailForPORejection(SalesHeader, ApprovalEntry."Approver Code");
                    END;
                UNTIL ApprovalEntry.NEXT = 0;
            END;
        END;
    end;


    procedure ArchiveApprovalEntry(AppEntry: Record "Approval Entry"; xRecAppEntry: Record "Approval Entry")
    var
        ArchApprovalEntry: Record "Archive Approval Entry";
        EntryNo: Integer;
    begin
        ArchApprovalEntry.RESET;
        IF ArchApprovalEntry.FINDLAST THEN
            EntryNo := ArchApprovalEntry."Entry No." + 1
        ELSE
            EntryNo := 1;

        ArchApprovalEntry.INIT;
        ArchApprovalEntry.TRANSFERFIELDS(AppEntry);
        ArchApprovalEntry."Entry No." := EntryNo;
        ArchApprovalEntry.Status := xRecAppEntry.Status;
        ArchApprovalEntry.INSERT;
    end;
}

