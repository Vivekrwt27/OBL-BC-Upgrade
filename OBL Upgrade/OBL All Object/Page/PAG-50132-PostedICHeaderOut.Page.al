page 50132 "Posted IC Header - Out"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "IC Out Header";
    SourceTableView = SORTING("Transfer Type", "No.")
                      ORDER(Ascending)
                      WHERE("Transfer Type" = FILTER("Transfer Out"));
    UsageCategory = Lists;
    ApplicationArea = ALL;

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
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
            part("Posted IC Line - Out"; "Posted IC Line - Out")
            {
                SubPageLink = "Document No." = FIELD("No.");
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

