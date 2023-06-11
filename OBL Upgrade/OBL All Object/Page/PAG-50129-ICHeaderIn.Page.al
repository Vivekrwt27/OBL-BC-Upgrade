page 50129 "IC Header - In"
{
    Editable = true;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "IC Header";
    SourceTableView = SORTING("Transfer Type", "No.")
                      ORDER(Ascending)
                      WHERE("Transfer Type" = FILTER("Transfer In"));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Transfer Type"; Rec."Transfer Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("From Company"; Rec."From Company")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("To Company"; Rec."To Company")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("From Location"; Rec."From Location")
                {
                    Editable = false;
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part("IC Line - In"; "IC Line - In")
            {
                SubPageLink = "Transfer Type" = FIELD("Transfer Type"),
                              "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Function)
            {
                Caption = 'Function';
                action(Post)
                {
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ICCompanyHandler2.InsertReceipt(Rec);
                    end;
                }
            }
        }
    }

    var
        ICCompanyHandler: Codeunit "IC Transfer - Out";
        UserLocation: Record "User Location";
        TEXT50000: Label 'From Company and To Company Cannot be Same';
        ICCompanyHandler2: Codeunit "IC Transfer - In";
}

