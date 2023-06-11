page 50051 "Update Variant Code"
{
    PageType = Card;
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            group("Update Variant Code In Item")
            {
                Caption = 'Update Variant Code In Item';
                field(Varcode; Varcode)
                {
                    Caption = 'Variant Code';
                    Editable = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
            field(Updateforall; Updateforall)
            {
                Caption = 'Update All';
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    IF Updateforall THEN BEGIN
                        PostingGroup := '';
                        PostingGroupEditable := FALSE;
                    END ELSE BEGIN
                        PostingGroup := '';
                        PostingGroupEditable := TRUE;
                    END;
                end;
            }
            field(PostingGroup; PostingGroup)
            {
                Caption = 'Posting Setup';
                Editable = PostingGroupEditable;
                TableRelation = "Inventory Posting Group";
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Update)
            {
                Caption = 'Update';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM(Text001, FALSE) THEN BEGIN
                        IF Updateforall THEN BEGIN
                            RecItem.RESET;
                            IF RecItem.FIND('-') THEN
                                REPEAT
                                    IF NOT RecItemVariant.GET(RecItem."No.", Varcode) THEN BEGIN
                                        RecItemVariant."Item No." := RecItem."No.";
                                        RecItemVariant.Code := Varcode;
                                        RecItemVariant.INSERT;
                                    END;
                                UNTIL RecItem.NEXT = 0;
                        END ELSE BEGIN
                            IF PostingGroup = '' THEN
                                ERROR(Text002);
                            RecItem.RESET;
                            RecItem.SETRANGE("Inventory Posting Group", PostingGroup);
                            IF RecItem.FIND('-') THEN
                                REPEAT
                                    IF NOT RecItemVariant.GET(RecItem."No.", Varcode) THEN BEGIN
                                        RecItemVariant."Item No." := RecItem."No.";
                                        RecItemVariant.Code := Varcode;
                                        RecItemVariant.INSERT;
                                    END;
                                UNTIL RecItem.NEXT = 0;
                            CurrPage.CLOSE;
                        END;
                    END ELSE
                        CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        PostingGroupEditable := TRUE;
    end;

    trigger OnOpenPage()
    begin
        PostingGroup := '';
        Updateforall := TRUE;
        PostingGroupEditable := FALSE;
    end;

    var
        Varcode: Code[20];
        Updateforall: Boolean;
        PostingGroup: Code[20];
        Text001: Label 'Do you want to Update Variant in Item?';
        RecItem: Record Item;
        RecItemVariant: Record "Item Variant";
        Text002: Label 'Please Select posting Group. ';
        [InDataSet]
        PostingGroupEditable: Boolean;


    procedure SetParameter(variantcode: Code[20])
    begin
        Varcode := variantcode;
    end;
}

