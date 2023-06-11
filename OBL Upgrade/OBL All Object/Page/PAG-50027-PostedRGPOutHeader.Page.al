page 50027 "Posted RGP Out Header"
{
    // Customization No. 63

    DataCaptionFields = "No.";
    Editable = true;
    PageType = Card;
    SourceTable = "RGP Header";
    SourceTableView = WHERE(Posted = CONST(true),
                            "Document Type" = CONST(Out));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Employee ID"; Rec."Employee ID")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Tin No."; Rec."Tin No.")
                {
                    ApplicationArea = All;
                }
            }
            part("RGP Out Line"; "RGP Out Line")
            {
                Editable = false;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "RGP No." = FIELD("No.");
                ApplicationArea = All;


            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Print RGP")
            {
                Caption = '&Print RGP';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    RGPHeader.RESET;
                    RGPHeader.SETFILTER(RGPHeader."No.", rec."No.");
                    RGPReport.SETTABLEVIEW(RGPHeader);
                    RGPReport.RUN;
                end;
            }

        }
    }

    var
        DimensionValue: Record "Dimension Value";
        GeneralLedgerSetup: Record "General Ledger Setup";
        RGPHeader: Record "RGP Header";
        RGPReport: Report RGP;
}

