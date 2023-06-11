page 50134 "Posted IC Header - In"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "IC In Header";
    SourceTableView = SORTING("Transfer Type", "No.")
                      ORDER(Ascending)
                      WHERE("Transfer Type" = FILTER("Transfer In"));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("From Company"; Rec."From Company")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("To Company"; Rec."To Company")
                {
                    ApplicationArea = All;
                }
                field("From Location"; Rec."From Location")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        UserLocation.RESET;
                        UserLocation.SETFILTER("User ID", '%1', USERID);
                        IF PAGE.RUNMODAL(Page::"User Locations", UserLocation) = ACTION::LookupOK THEN
                            Rec.VALIDATE("From Location", UserLocation."Location Code");
                    end;
                }
                field("To Location"; Rec."To Location")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(Lines; "Posted IC Line - In")
            {
                SubPageLink = "Transfer Type" = FIELD("Transfer Type"),
                              "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec."Posting Date" := TODAY;
    end;

    var
        ICCompanyHandler: Codeunit "IC Transfer - Out";
        UserLocation: Record "User Location";
        TEXT50000: Label 'From Company and To Company Cannot be Same';
        ICCompanyHandler2: Codeunit "IC Transfer - In";
}

