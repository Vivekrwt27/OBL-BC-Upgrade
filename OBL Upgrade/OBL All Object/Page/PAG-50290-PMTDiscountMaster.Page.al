page 50290 "PMT Discount Master"
{
    /*  DeleteAllowed = false;
     InsertAllowed = false;
     ModifyAllowed = false;
     */
    UsageCategory = Lists;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "PMT Discount Master";
    Permissions = tabledata "PMT Discount Master" = rimd;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("PMT ID"; Rec."PMT ID")
                {
                    ApplicationArea = All;
                }
                field("Lead ID"; Rec."Lead ID")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Price Validaty"; Rec."Price Validaty")
                {
                    ApplicationArea = All;
                }
                field("Discount Amount"; Rec."Discount Amount")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Creation Date & Time"; Rec."Creation Date & Time")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("PMT Qty."; Rec."PMT Qty.")
                {
                    ApplicationArea = All;
                }
                field("Order Qty."; Rec."Order Qty.")
                {
                    ApplicationArea = All;
                }
                field("Despatch Qty."; Rec."Despatch Qty.")
                {
                    ApplicationArea = All;
                }
                field("Remaining Qty."; Rec."Remaining Qty.")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
                field("Cash Discount"; Rec."Cash Discount")
                {
                    ApplicationArea = All;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                }
                field(Tolerance; Rec.Tolerance)
                {
                    ApplicationArea = All;
                }
                field("First Inv Date"; Rec."First Inv Date")
                {
                    ApplicationArea = All;
                }
                field("Last Inv Date"; Rec."Last Inv Date")
                {
                    ApplicationArea = All;
                }
                field("Total AD"; Rec."Total AD")
                {
                    ApplicationArea = All;
                }
                field("Actual AD"; Rec."Actual AD")
                {
                    ApplicationArea = All;
                }
                field("Sales Return"; Rec."Sales Return")
                {
                    ApplicationArea = All;
                }
                field("Ship To Address"; Rec."Ship To Address")
                {
                    ApplicationArea = All;
                }
                field("Ship To Pin"; Rec."Ship To Pin")
                {
                    ApplicationArea = All;
                }
                field("PMT Creation Date"; Rec."PMT Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Ship To Address 2"; Rec."Ship To Address 2")
                {
                    ApplicationArea = All;
                }
                field("Order Qty upto 310322"; Rec."Order Qty upto 310322")
                {
                    ApplicationArea = All;
                }
                field("Despatch Qty. 310322"; Rec."Despatch Qty. 310322")
                {
                    ApplicationArea = All;
                }
                field("Contractor Name"; Rec."Contractor Name")
                {
                    ApplicationArea = All;
                }
                field("Complete Description"; Rec."Complete Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Zone; Rec.Zone)
                {
                    Editable = false;
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
        IF ritem.GET(Rec."Item No.") THEN
            Rec."Complete Description" := ritem."Complete Description";

        IF Rcust.GET(Rec."Customer No.") THEN
            Rec."Customer Name" := Rcust.Name;
        Rec.City := Rcust.City;
        Rec.State := Rcust."State Desc.";
        Rec.Zone := Rcust."Tableau Zone";
        Rec.MODIFY;

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF ritem.GET(Rec."Item No.") THEN
            Rec."Complete Description" := ritem."Complete Description";
        Rec.MODIFY;
    end;

    var
        ritem: Record Item;
        Rcust: Record Customer;
}

