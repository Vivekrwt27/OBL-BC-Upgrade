page 50300 "Power and Cons. Card"
{
    PageType = Card;
    SourceTable = "Power and Fuel Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Date of Reporting"; Rec."Date of Reporting")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec."Inventory At Location" := Rec.CalculateInventory(Rec."Item No.", Rec.Location, Rec."Date of Reporting");
                    end;
                }
                field("Prod. Start Date"; Rec."Prod. Start Date")
                {
                    ApplicationArea = All;
                }
                field("Prod. End Date"; Rec."Prod. End Date")
                {
                    ApplicationArea = All;
                }
                field("Prod. Units"; Rec."Prod. Units")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec."Inventory At Location" := Rec.CalculateInventory(Rec."Item No.", Rec.Location, Rec."Prod. Start Date");
                    end;
                }
                field("Item Description"; Rec."Item Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Inventory At Location"; Rec."Inventory At Location")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Consumed Qty."; Rec."Consumed Qty.")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Size Filter"; Rec."Size Filter")
                {
                    ApplicationArea = All;
                }
                field("Size Code Desc"; Rec."Size Code Desc")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Tableau Group Code Filter"; Rec."Tableau Group Code Filter")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Production"; Rec."Total Production")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(Lines; "Power and Cons. Lines")
            {
                Caption = 'Lines';
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;


            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Suggest Consumption Lines")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CheckDuplicateEntry;
                    Rec."Inventory At Location" := Rec.CalculateInventory(Rec."Item No.", Rec.Location, Rec."Prod. End Date");
                    IF Rec."Inventory At Location" < Rec."Consumed Qty." THEN
                        ERROR('Insufficient Inventory');

                    IF Rec."Inventory At Location" >= Rec."Consumed Qty." THEN
                        IF CONFIRM('Material At Location is more than the requested Consumption Qty, Do you want to continue?', FALSE) THEN
                            Rec.GenerateOutputLines;
                end;
            }
            action("Release ")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TESTFIELD(Status, Rec.Status::Open);
                    Rec."Inventory At Location" := Rec.CalculateInventory(Rec."Item No.", Rec.Location, Rec."Prod. End Date");
                    IF Rec."Inventory At Location" < Rec."Consumed Qty." THEN
                        ERROR('Insufficient Inventory');

                    IF CONFIRM('Do you want to Release the Document?', FALSE) THEN BEGIN
                        Rec.Status := Rec.Status::Release;
                    END;
                end;
            }
            action("ReOpen ")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TESTFIELD(Status, Rec.Status::Release);
                    IF CONFIRM('Do you want to ReOpen the Document?', FALSE) THEN BEGIN
                        Rec.Status := Rec.Status::Open;
                    END;
                end;
            }
            action(Post)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec."Inventory At Location" := Rec.CalculateInventory(Rec."Item No.", Rec.Location, Rec."Prod. End Date");
                    IF Rec."Inventory At Location" < Rec."Consumed Qty." THEN
                        ERROR('Insufficient Inventory');
                    IF Rec."Inventory At Location" >= Rec."Consumed Qty." THEN
                        Rec.Post(Rec."No.") ELSE
                        ERROR('Inventory is not available');
                end;
            }
        }
    }

    local procedure CheckDuplicateEntry()
    var
        PowerFuelConsLines: Record "Power & Fuel Cons. Lines";
        CurrPowerFuelConsLines: Record "Power & Fuel Cons. Lines";
    begin
        CurrPowerFuelConsLines.RESET;
        CurrPowerFuelConsLines.SETRANGE("Document No.", Rec."No.");
        IF CurrPowerFuelConsLines.FINDFIRST THEN BEGIN
            REPEAT
                PowerFuelConsLines.RESET;
                PowerFuelConsLines.SETFILTER("Document No.", '<>%1', Rec."No.");
                PowerFuelConsLines.SETRANGE(Location, CurrPowerFuelConsLines.Location);
                PowerFuelConsLines.SETRANGE("Consumed Item No.", CurrPowerFuelConsLines."Consumed Item No.");
                PowerFuelConsLines.SETRANGE("Prod. Order No.", CurrPowerFuelConsLines."Prod. Order No.");
                IF PowerFuelConsLines.FINDFIRST THEN
                    ERROR('Already Production Reporting exist %1 for this combination', PowerFuelConsLines."Document No.");
            UNTIL CurrPowerFuelConsLines.NEXT = 0;
        END;
    end;
}

