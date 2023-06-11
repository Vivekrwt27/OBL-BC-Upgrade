page 50138 GIT
{
    Editable = false;
    PageType = List;
    SourceTable = "Transfer Line";
    SourceTableView = WHERE("Quantity Shipped" = FILTER(> 0),
                            "Quantity Received" = FILTER(= 0));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Transporter Code"; tpt_name)
                {
                    ApplicationArea = All;
                }
                field("Transporter Name"; Ven_name)
                {
                    ApplicationArea = All;
                }
                field("Truck No."; truck_no)
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Invoice No."; inv_no)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("Shipped Qty (Base)"; Rec."Quantity (Base)" - Rec."Outstanding Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ApplicationArea = All;
                }
                field("Qty. in Transit"; Rec."Qty. in Transit")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        trfshp.SETRANGE("Transfer Order No.", Rec."Document No.");
        IF trfshp.FINDFIRST THEN
            inv_no := trfshp."No.";
        truck_no := trfshp."Truck No.";
        tpt_name := trfshp."Transporter's Name";

        VendorRec.SETRANGE("No.", trfshp."Transporter's Name");
        IF VendorRec.FINDFIRST THEN
            Ven_name := VendorRec.Name;
    end;

    var
        trfshp: Record "Transfer Shipment Header";
        inv_no: Text[30];
        truck_no: Text[30];
        tpt_name: Text[30];
        VendorRec: Record Vendor;
        Ven_name: Text[30];
}

