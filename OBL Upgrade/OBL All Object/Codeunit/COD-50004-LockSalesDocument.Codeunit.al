codeunit 50004 "Lock Sales Document"
{
    // //mo tri1.0

    TableNo = "Sales Header";

    trigger OnRun()
    begin
        UserSetup.GET(UPPERCASE(USERID));
        IF rec."Locked Order" = TRUE THEN BEGIN
            IF CONFIRM(STRSUBSTNO(TEXT0005, rec."No.")) THEN BEGIN
                IF UserSetup."Allow UnLock" = TRUE THEN BEGIN
                    rec."Locked Order" := FALSE;
                    rec.MODIFY;
                END;
                IF UserSetup."Allow UnLock" = FALSE THEN BEGIN
                    ERROR(TEXT0004, rec."No.");
                END;
            END;
        END ELSE BEGIN
            IF CONFIRM(STRSUBSTNO(TEXT0002, rec."No.")) THEN BEGIN
                IF rec.Status = rec.Status::Released THEN BEGIN
                    rec."Locked Order" := TRUE;
                    rec.MODIFY;
                END ELSE BEGIN
                    ERROR(TEXT0001, rec."No.");
                END;
            END;
        END;

        /*
        IF "Locked Order" = TRUE THEN BEGIN
          IF UserSetup."Allow UnLock" = TRUE THEN
            "Locked Order" := FALSE
          ELSE
            ERROR(TEXT0004,"No.");
        END;
        
        IF CONFIRM(STRSUBSTNO(TEXT0002,"No.")) THEN BEGIN
          IF Status = Status::Released THEN BEGIN
            "Locked Order" := TRUE;
            MODIFY;
          END ELSE BEGIN
            ERROR(TEXT0001,"No.");
          END;
        END;
        */

    end;

    var
        TEXT0001: Label 'Status must be Released for locking the sales order %1.';
        TEXT0002: Label 'Are you sure you want to lock the Sales Order %1?';
        TEXT0003: Label 'Sales Order %1 has already been locked.';
        UserSetup: Record "User Setup";
        TEXT0004: Label 'You are not allowed to Unlock the Sales Order %1.';
        TEXT0005: Label 'Are you sure you want to Unlock the Sales Order %1?';
        TEXT0006: Label 'Status must be Released for locking the transfer order %1.';
        TEXT0007: Label 'Are you sure you want to lock the Transfer Order %1?';
        TEXT0008: Label 'Transfer Order %1 has already been locked.';
        TEXT0009: Label 'You are not allowed to Unlock theTransfer Order %1.';
        TEXT0010: Label 'Are you sure you want to Unlock the Transfer Order %1?';
        TEXT0011: Label 'Status must be Released for locking the Export order %1.';
        TEXT0012: Label 'Are you sure you want to lock the Export Order %1?';
        TEXT0013: Label 'Export Order %1 has already been locked.';
        TEXT0014: Label 'You are not allowed to Unlock the Export Order %1.';
        TEXT0015: Label 'Are you sure you want to Unlock the Export Order %1?';
        TEXT0016: Label 'You are not allowed to Unlock the Purchase Order %1.';
        TEXT0017: Label 'Are you sure you want to Unlock the Purchase Order %1?';
        TEXT0018: Label 'Are you sure you want to lock the Purchase Order %1?';
        TEXT0019: Label 'Status must be Released for locking the Purchase  order %1.';


    procedure CheckLock(var TransferHeader: Record "Transfer Header")
    begin
        UserSetup.GET(USERID);
        IF TransferHeader."Locked Order" = TRUE THEN BEGIN
            IF CONFIRM(STRSUBSTNO(TEXT0010, TransferHeader."No.")) THEN BEGIN
                IF UserSetup."Allow UnLock" = TRUE THEN BEGIN
                    TransferHeader."Locked Order" := FALSE;
                    TransferHeader.MODIFY;
                END;
                IF UserSetup."Allow UnLock" = FALSE THEN BEGIN
                    ERROR(TEXT0009, TransferHeader."No.");
                END;
            END;
        END ELSE BEGIN
            IF CONFIRM(STRSUBSTNO(TEXT0007, TransferHeader."No.")) THEN BEGIN
                IF TransferHeader."Transfer order Status" = TransferHeader."Transfer order Status"::Released THEN BEGIN
                    TransferHeader."Locked Order" := TRUE;
                    TransferHeader.MODIFY;
                END ELSE BEGIN
                    ERROR(TEXT0006, TransferHeader."No.");
                END;
            END;
        END;
    end;


    procedure ExpLockUnlock(var SalesHeader: Record "Sales Header")
    begin
        //ravi Tri1.0 Start

        UserSetup.GET(UPPERCASE(USERID));
        IF SalesHeader."Locked Order" = TRUE THEN BEGIN
            IF CONFIRM(STRSUBSTNO(TEXT0015, SalesHeader."No.")) THEN BEGIN
                IF UserSetup."Allow UnLock" = TRUE THEN BEGIN
                    SalesHeader."Locked Order" := FALSE;
                    SalesHeader.MODIFY;
                END;
                IF UserSetup."Allow UnLock" = FALSE THEN BEGIN
                    ERROR(TEXT0014, SalesHeader."No.");
                END;
            END;
        END ELSE BEGIN
            IF CONFIRM(STRSUBSTNO(TEXT0012, SalesHeader."No.")) THEN BEGIN
                IF SalesHeader.Status = SalesHeader.Status::Released THEN BEGIN
                    SalesHeader."Locked Order" := TRUE;
                    SalesHeader.MODIFY;
                END ELSE BEGIN
                    ERROR(TEXT0011, SalesHeader."No.");
                END;
            END;
        END;

        //ravi Tri1.0 End
    end;


    procedure PurchLockUnlock(var SalesHeader: Record "Purchase Header")
    begin
        //TRI DG Add Start

        UserSetup.GET(UPPERCASE(USERID));
        IF SalesHeader."Locked Order" = TRUE THEN BEGIN
            IF CONFIRM(STRSUBSTNO(TEXT0017, SalesHeader."No.")) THEN BEGIN
                IF UserSetup."Allow PO UnLock" = TRUE THEN BEGIN
                    SalesHeader."Locked Order" := FALSE;
                    SalesHeader.MODIFY;
                END;
                IF UserSetup."Allow PO UnLock" = FALSE THEN BEGIN
                    ERROR(TEXT0016, SalesHeader."No.");
                END;
            END;
        END ELSE BEGIN
            IF CONFIRM(STRSUBSTNO(TEXT0018, SalesHeader."No.")) THEN BEGIN
                IF SalesHeader.Status = SalesHeader.Status::Released THEN BEGIN
                    SalesHeader."Locked Order" := TRUE;
                    SalesHeader.MODIFY;
                END ELSE BEGIN
                    ERROR(TEXT0019, SalesHeader."No.");
                END;
            END;
        END;

        //Tri DG Add End
    end;
}

