page 50326 "Production Order IT"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Permissions = tabledata "Production Order" = rimd;
    SourceTable = "Production Order";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
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
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Finished Date"; Rec."Finished Date")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }

                field(Finished; Rec.Finished)
                {
                    ApplicationArea = All;
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(UpdateStatus)
            {
                ApplicationArea = All;
                Promoted = true;
                trigger OnAction();
                var
                    ProductionComp: Record 5405;
                begin
                    ProductionComp.Reset();
                    ProductionComp.SetRange("No.", rec."No.");
                    if ProductionComp.FindFirst() then begin
                        ProductionComp.Status := ProductionComp.Status::Finished;
                        ProductionComp.Rename(ProductionComp.Status::Finished);
                        Message('OK');

                    end;
                end;
            }
        }
    }
}