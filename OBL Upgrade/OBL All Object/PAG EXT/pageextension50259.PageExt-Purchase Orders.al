pageextension 50259 pageextension50259 extends "Purchase Orders"
{
    layout
    {
        addafter(Amount)
        {
            field("Descriptions 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
        }
        addafter("Direct Unit Cost")
        {
            field("Ref Code"; Rec."Ref Code")
            {
                ApplicationArea = All;
            }
            field("Indent No."; Rec."Indent No.")
            {
                ApplicationArea = All;
            }
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Line Discount %")
        {
            field("Vendor Name"; Rec."Vendor Name")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Phone No."; vendphone)
            {
                ApplicationArea = All;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
            }
            field("Order Date"; Rec."Order Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
            }
            field("Approval Status"; appstatus)
            {
                Editable = false;
                OptionCaption = 'Not Approved,Approved';
                ApplicationArea = All;
            }
            field("Capex No."; Rec."Capex No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {


    }

    var
        vendname: Text[50];
        vend: Record Vendor;
        purhead: Record "Purchase Header";
        vendphone: Code[50];
        Status: Option Open,Released,"Pending Approval","Pending Prepayment","Short Close",Authorization1,Approved,Authorization3,Authorized,Closed;
        appstatus: Option;

    trigger OnAfterGetRecord()
    begin
        IF vend.GET(Rec."Buy-from Vendor No.") THEN
            vendname := vend.Name;
        vendphone := vend."Phone No.";

        //MSVRN 270319 >>
        purhead.RESET;
        purhead.SETRANGE("No.", Rec."Document No.");
        purhead.SETRANGE("Document Type", Rec."Document Type");
        IF purhead.FINDFIRST THEN
            // Rec.Status := purhead.Status;//16225 Table Field N/F
            appstatus := purhead."Approval Status";
        //MSVRN 270319 <<

    end;

}

