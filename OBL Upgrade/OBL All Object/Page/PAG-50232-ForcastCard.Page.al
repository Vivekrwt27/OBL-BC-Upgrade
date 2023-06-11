page 50232 "Forcast Card"
{
    PageType = Card;
    SourceTable = "Purchase order Attachment";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Posted UserID"; Rec."Posted UserID")
                {
                    ApplicationArea = All;
                }
                field(Recieved; Rec.Recieved)
                {
                    ApplicationArea = All;
                }
                field("Posting DateTime"; Rec."Posting DateTime")
                {
                    ApplicationArea = All;
                }
                //16225 Table N/F
                /*field("Total Prod. Qty."; "Total Prod. Qty.")
                {
                }
                field("Total Quantity"; "Total Quantity")
                {
                }*/
            }
            part("Forcast SubPage"; "Forcast SubPage")
            {
                SubPageLink = "Sales Territory" = FIELD("No.");
                SubPageView = SORTING("Sales Territory");
//16225 , Field10 N/F//                ApplicationArea = All;

            }
            group(Audit)
            {
                /*field("Creation Date"; "Creation Date")//16225 Table N/F
                {
                }*/
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Re-update Forcast")
            {
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F7';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /// RecieveDocument(Rec);
                end;
            }
            action("Forcast Report")
            {
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ForCastHeader: Record "Purchase order Attachment";
                begin
                    ForCastHeader.RESET;
                    ForCastHeader.SETRANGE(ForCastHeader."No.", Rec."No.");
                    IF ForCastHeader.FINDFIRST THEN
                        REPORT.RUN(50570, TRUE, FALSE, ForCastHeader);
                end;
            }
        }
    }

    var
    ///   Forecast: Report 50570;
}

