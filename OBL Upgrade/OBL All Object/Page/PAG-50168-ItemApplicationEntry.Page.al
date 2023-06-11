page 50168 "Item Application Entry"
{
    Editable = false;
    PageType = List;
    SourceTable = "Item Application Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Transferred-from Entry No."; rec."Transferred-from Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Created By User"; rec."Created By User")
                {
                    ApplicationArea = All;
                }
                field("Last Modified Date"; rec."Last Modified Date")
                {
                    ApplicationArea = All;
                }
                field("Last Modified By User"; rec."Last Modified By User")
                {
                    ApplicationArea = All;
                }
                field("Cost Application"; rec."Cost Application")
                {
                    ApplicationArea = All;
                }
                field("Output Completely Invd. Date"; rec."Output Completely Invd. Date")
                {
                    ApplicationArea = All;
                }
                field("Outbound Entry is Updated"; rec."Outbound Entry is Updated")
                {
                    ApplicationArea = All;
                }
                field("Item Code"; rec."Item Code")
                {
                    ApplicationArea = All;
                }
                field("Item Code1"; rec."Item Code1")
                {
                    ApplicationArea = All;
                }
                field("In Bond Entries"; rec."In Bond Entries")
                {
                    ApplicationArea = All;
                }
                field("Out Bond Entries"; rec."Out Bond Entries")
                {
                    ApplicationArea = All;
                }
                field("Posted Purch Invoice"; rec."Posted Purch Invoice")
                {
                    ApplicationArea = All;
                }
                field("Vend Name"; rec."Vend Name")
                {
                    ApplicationArea = All;
                }
                field("Vend Inv"; rec."Vend Inv")
                {
                    ApplicationArea = All;
                }
                field(Location; rec.Location)
                {
                    ApplicationArea = All;
                }
                field("Cust Name"; rec."Cust Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

