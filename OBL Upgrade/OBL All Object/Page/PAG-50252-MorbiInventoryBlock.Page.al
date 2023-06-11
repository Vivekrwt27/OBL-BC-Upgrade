page 50252 "Morbi Inventory Block"
{
    PageType = List;
    Permissions = TableData "Item Ledger Entry" = rm;
    SourceTable = "Item Ledger Entry";
    SourceTableView = SORTING("Item No.", "Open", "Variant Code", "Positive", "Location Code", "Posting Date")
                      WHERE(Open = CONST(false),
                            "Remaining Quantity" = FILTER(> 0));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Mfg. Batch No."; Rec."Mfg. Batch No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Morbi Batch No."; Rec."Morbi Batch No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                //16225 field N/F Start
                /* field(Blocked; "Laboratory Test")
                 {
                     Caption = 'Blocked';
                     ApplicationArea = All;
                 }*///16225 field N/F End
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Block Entry")
            {
                Image = BreakRulesOff;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //16225 Field N/F Start
                    /* TESTFIELD("Laboratory Test", FALSE);
                     IF CONFIRM('Do you want to Block the Inventory', FALSE) THEN BEGIN
                         "Laboratory Test" := TRUE;
                         MODIFY;
                     END;*///16225 Field N/F End
                end;
            }
            action("UnBlock Entry")
            {
                Image = BreakRulesOn;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //16225 Field N/F Start
                    /* TESTFIELD("Laboratory Test", TRUE);
                     IF CONFIRM('Do you want to Un-Block the Inventory', FALSE) THEN BEGIN
                         "Laboratory Test" := FALSE;
                         MODIFY;
                     END;*///16225 Field N/F End
                end;
            }
        }
    }

    trigger OnInit()
    var
        CompanyInformation: Record "Company Information";
    begin
        CompanyInformation.GET;
        IF NOT CompanyInformation."Block ILE Functionality" THEN
            ERROR('Not Allowed in this Company');
    end;
}

