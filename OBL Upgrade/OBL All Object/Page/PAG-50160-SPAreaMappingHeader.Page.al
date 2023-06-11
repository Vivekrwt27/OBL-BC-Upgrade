page 50160 "SP Area Mapping Header"
{
    PageType = Card;
    SourceTable = "Physical Journal Header";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Plant; rec.Plant)
                {
                    ApplicationArea = All;
                }
                field("Voucher Type"; rec."Voucher Type")
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                /* field("End Date"; rec."End Date")
                 {
                     ApplicationArea = All;
                 }*/
                field("Creation Date"; rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = All;
                }
            }
            part("Physical Journal Store List"; "Physical Journal Store List")
            {
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unction")
            {
                Caption = 'F&unction';
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        SPHeader.RESET;
                        SPHeader.SETRANGE(SPHeader."No.", rec."No.");
                        IF SPHeader.FINDFIRST THEN
                            SPHeader.Status := SPHeader.Status::"Send to Approval";
                        SPHeader.MODIFY;
                    end;
                }
                action("&Open")
                {
                    Caption = '&Open';
                    ShortCutKey = 'Return';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        SPHeader.RESET;
                        SPHeader.SETRANGE(SPHeader."No.", rec."No.");
                        IF SPHeader.FINDFIRST THEN
                            SPHeader.Status := SPHeader.Status::Open;
                        SPHeader.MODIFY;
                    end;
                }
            }
        }
    }

    var
        SPHeader: Record "Physical Journal Header";
}

