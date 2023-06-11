page 50055 "Closed Indent Header"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Indent Header";
    SourceTableView = WHERE(Status = FILTER(Closed));

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Indent Date"; Rec."Indent Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Authorization 1"; Rec."Authorization 1")
                {
                    ApplicationArea = All;
                }
                field("Authorization 2"; Rec."Authorization 2")
                {
                    ApplicationArea = All;
                }
            }
            part("Indent Line Subform"; "Indent Line Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        CommentLine: Record "Comment Line";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        IndentHeader: Record "Indent Header";
        IndentLine: Record "Indent Line";
        i: Integer;
        VendorNo: array[100] of Code[20];
        j: Integer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchaseSetup: Record "Purchases & Payables Setup";
        LineNo: Integer;
        UserLocation: Record "User Location";
        UserSetup: Record "User Setup";
}

