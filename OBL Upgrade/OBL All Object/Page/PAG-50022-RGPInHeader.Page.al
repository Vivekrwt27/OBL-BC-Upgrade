page 50022 "RGP In Header"
{
    // Customization No. 63

    PageType = Card;
    SourceTable = "RGP Header";
    SourceTableView = WHERE(Posted = CONST(false),
                            "Document Type" = FILTER(In));
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

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;

                    trigger OnValidate()
                    begin
                        Rec."Document Type" := Rec."Document Type"::"In";
                    end;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        TypeOnAfterValidate;
                    end;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CodeOnAfterValidate;
                    end;
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

                    trigger OnValidate()
                    begin
                        PurposeOnAfterValidate;
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    NotBlank = true;
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    NotBlank = true;
                    ApplicationArea = All;
                }
                field("Employee ID"; Rec."Employee ID")
                {
                    NotBlank = true;
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
            }
            part("RGP In Line"; "RGP In Line")
            {
                SubPageLink = "RGP No." = FIELD("No."),
                              "Document Type" = CONST(In);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        RgpoutLine: Record "RGP Line";
                        Check1: Boolean;
                    begin
                        REC.TESTFIELD("Posting Date");
                        REC.TESTFIELD("Order Date");
                        REC.TESTFIELD("Employee ID");

                        RgpLine.RESET;
                        RgpLine.SETRANGE(RgpLine."RGP No.", REC."No.");
                        RgpLine.SETRANGE(RgpLine."Document Type", REC."Document Type");

                        IF RgpLine.FIND('-') THEN
                            REPEAT
                                IF (RgpLine."Receiving Quantity" = 0) AND (RgpLine.Type <> RgpLine.Type::" ") THEN
                                    ERROR('Receiving Quantity can not be 0 in Line No. %1', RgpLine."Line No.");
                            UNTIL RgpLine.NEXT = 0;

                        IF CONFIRM('Do you want to post RGP In?') THEN BEGIN
                            CLEAR(Check1);
                            RgpLine.RESET;
                            RgpLine.SETRANGE(RgpLine."RGP No.", REC."No.");
                            RgpLine.SETRANGE(RgpLine."Document Type", REC."Document Type");
                            IF RgpLine.FIND('-') THEN
                                REPEAT
                                    RgpoutLine.SETRANGE(RgpoutLine."Document Type", RgpoutLine."Document Type"::Out);
                                    RgpoutLine.SETRANGE(RgpoutLine."RGP No.", RgpLine."RGP Out No.");
                                    RgpoutLine.SETRANGE(RgpoutLine."Line No.", RgpLine."RGP Outline No.");
                                    RgpoutLine.SETFILTER(RgpoutLine."Quantity to Receive", '<>0');
                                    IF RgpoutLine.FIND('-') THEN BEGIN
                                        RgpLine.Posted := TRUE;
                                        RgpLine.MODIFY;
                                        Check1 := TRUE;
                                        RgpoutLine."Quantity to Receive" := RgpoutLine."Quantity to Receive" - RgpLine."Receiving Quantity";
                                        RgpLine."Receiving Date" := REC."Posting Date";
                                        IF RgpoutLine."Quantity to Receive" < 0 THEN
                                            RgpoutLine.FIELDERROR(RgpoutLine."Quantity to Receive")
                                        ELSE
                                            RgpoutLine.MODIFY;
                                    END;
                                UNTIL RgpLine.NEXT = 0;
                            IF Check1 THEN
                                REC.Posted := TRUE
                            ELSE
                                ERROR('There is nothing to post');
                            CurrPage.UPDATE;
                        END;
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Customization No. 63 Start Vipul
        REC."Document Type" := REC."Document Type"::"In";
        //Customization No. 63 End Vipul
    end;

    var
        RgpLine: Record "RGP Line";

    local procedure TypeOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure CodeOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure PurposeOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;
}

