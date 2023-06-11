page 50127 "IC Header - Out"
{
    DeleteAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "IC Header";
    SourceTableView = SORTING("Transfer Type", "No.")
                      ORDER(Ascending)
                      WHERE("Transfer Type" = FILTER("Transfer Out"));

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

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
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
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
            }
            part("IC Line - Out"; "IC Line - Out")
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
                        IF Rec."Transfer Type" = Rec."Transfer Type"::"Transfer Out" THEN
                            ICCompanyHandler.InsertOut(Rec);


                        //ELSE
                        //ICCompanyHandler2.InsertReceipt(Rec);
                    end;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.InsertPreData;
        Rec."Posting Date" := WORKDATE;
    end;

    trigger OnOpenPage()
    begin
        Rec."Posting Date" := TODAY;
    end;

    var
        ICCompanyHandler: Codeunit "IC Transfer - Out";
        UserLocation: Record "User Location";
        TEXT50000: Label 'From Company and To Company Cannot be Same';
        ICCompanyHandler2: Codeunit "IC Transfer - In";
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        TempSalesLine: Record "Sales Line" temporary;
        ICLines: Record "IC Line";
}

