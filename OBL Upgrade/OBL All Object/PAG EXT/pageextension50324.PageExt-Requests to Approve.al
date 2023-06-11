pageextension 50324 pageextension50324 extends "Requests to Approve"
{
    actions
    {
        modify(Approve)
        {
            trigger OnAfterAction()
            begin
                //Keshav13042020
                IF Rec."Document Type" = Rec."Document Type"::Order THEN BEGIN
                    rPurchaseHeader.RESET;
                    rPurchaseHeader.SETRANGE("Document Type", rPurchaseHeader."Document Type"::Order);
                    rPurchaseHeader.SETRANGE("No.", Rec."Document No.");
                    IF rPurchaseHeader.FIND('-') THEN BEGIN
                        IF rPurchaseHeader.Status = rPurchaseHeader.Status::Released THEN BEGIN
                            rPurchaseHeader."Approval Status" := rPurchaseHeader."Approval Status"::Approved;
                            rPurchaseHeader.MODIFY;
                        END ELSE BEGIN
                            rPurchaseHeader."Approval Status" := rPurchaseHeader."Approval Status"::"Not Approved";
                            rPurchaseHeader.MODIFY;
                        END;
                    END;
                END;
            end;
        }
    }

    var
        rPurchaseHeader: Record "Purchase Header";


}

