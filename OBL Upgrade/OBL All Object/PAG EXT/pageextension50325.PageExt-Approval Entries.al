pageextension 50325 pageextension50325 extends "Approval Entries"
{
    layout
    {

        addafter("Salespers./Purch. Code")
        {
            field("Approver Code"; Rec."Approver Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Last Modified By User ID")
        {
            field("Comment Text"; Rec."Comment Text")
            {
                ApplicationArea = All;
            }
        }
        addafter(Comment)
        {
            field(EmailID; Rec.EmailID)
            {
                ApplicationArea = All;
            }
        }
    }

    var
        Filterstring: Text;
        // Approval: Codeunit 440; //16225 Codeunit N/F
        Approvalentry: Record "Approval Entry";

        Usersetup: Record "User Setup";

        Overdue: Option Yes," ";


    trigger OnOpenPage()
    begin
        //Code commented  of base and upgraded code from NAV 2013R2
        //Upgrade
        IF Usersetup.GET(USERID) THEN BEGIN
            Rec.FILTERGROUP(2);
            Filterstring := Rec.GETFILTERS;
            Rec.FILTERGROUP(0);
            IF STRLEN(Filterstring) = 0 THEN BEGIN
                Rec.FILTERGROUP(2);
                Rec.SETCURRENTKEY("Approver ID");
                IF Overdue = Overdue::Yes THEN
                    Rec.SETRANGE("Approver ID", Usersetup."User ID");
                Rec.SETRANGE(Status, Rec.Status::Open);
                Rec.FILTERGROUP(0);
            END ELSE
                Rec.SETCURRENTKEY("Table ID", "Document Type", "Document No.");
        END;
        //Upgrade

    end;

}

