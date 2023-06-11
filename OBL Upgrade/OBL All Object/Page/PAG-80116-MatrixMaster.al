page 80116 "Matrix Master"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Permissions = tabledata "Matrix Master" = rimd;
    SourceTable = "Matrix Master";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Mapping Type"; Rec."Mapping Type")
                {
                    ApplicationArea = All;
                }
                field("Type 1"; Rec."Type 1")
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field("Tableau Zone"; Rec."Tableau Zone")
                {
                    ApplicationArea = All;
                }

                field(PCH; Rec.PCH)
                {
                    ApplicationArea = All;
                }
                field("Target GVT"; Rec."Target GVT")
                {
                    ApplicationArea = All;
                }
                field("PCH Name"; Rec."PCH Name")
                {
                    ApplicationArea = All;
                }
                field(ZH; Rec.ZH)
                {
                    ApplicationArea = All;
                }
                field("Sorting Order"; Rec."Sorting Order")
                {
                    ApplicationArea = All;
                }
                field("Annual Target"; Rec."Annual Target")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Q1 Tgt"; Rec."Q1 Tgt")
                {
                    ApplicationArea = All;
                }
                field("Retail Sales Tgt"; Rec."Retail Sales Tgt")
                {
                    ApplicationArea = All;
                }
                field(Target; Rec.Target)
                {
                    ApplicationArea = All;
                }

                field("Enterprise Tgt"; Rec."Enterprise Tgt")
                {
                    ApplicationArea = All;
                }
                field("Sales Tgt Phasing 1-7"; Rec."Sales Tgt Phasing 1-7")
                {
                    ApplicationArea = All;
                }
                field("Sales Tgt Phasing 8-14"; Rec."Sales Tgt Phasing 8-14")
                {
                    ApplicationArea = All;
                }
                field("Sales Tgt Phasing 15-21"; Rec."Sales Tgt Phasing 15-21")
                {
                    ApplicationArea = All;
                }
                field("Sales Tgt Phasing 22-27"; Rec."Sales Tgt Phasing 22-27")
                {
                    ApplicationArea = All;
                }
                field("Sales Tgt Phasing 28-30"; Rec."Sales Tgt Phasing 28-30")
                {
                    ApplicationArea = all;
                }
                field("Type 2"; Rec."Type 2")
                {
                    ApplicationArea = All;
                }
                field("Collection Phasing 1-7"; Rec."Collection Phasing 1-7")
                {
                    ApplicationArea = All;
                }
                field("Collection Phasing 8-14"; Rec."Collection Phasing 8-14")
                {
                    ApplicationArea = All;
                }
                field("Collection Phasing 15-21"; Rec."Collection Phasing 15-21")
                {
                    ApplicationArea = All;
                }
                field("Collection Phasing 22-27"; Rec."Collection Phasing 22-27")
                {
                    ApplicationArea = All;
                }
                field("Collection Phasing 28-30"; Rec."Collection Phasing 28-30")
                {
                    ApplicationArea = All;
                }
                field("Enterprise SP Tgt Direct"; Rec."Enterprise SP Tgt Direct")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                    ApplicationArea = All;
                }

                field("OverDue Amount"; Rec."OverDue Amount")
                {
                    ApplicationArea = All;
                }
                field("Collection Amount"; Rec."Collection Amount")
                {
                    ApplicationArea = All;
                }



                field(Hide; Rec.Hide)
                {
                    ApplicationArea = All;
                }
                field("Strong Market"; Rec."Strong Market")
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}