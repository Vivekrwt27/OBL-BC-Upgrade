page 50115 "Discount Offer"
{
    PageType = Card;
    SourceTable = "Discount Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = "No.Editable";
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; Rec.Description)
                {
                    Editable = DescriptionEditable;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Valid From"; Rec."Valid From")
                {
                    Editable = "Valid FromEditable";
                    ApplicationArea = All;
                }
                field("Valid To"; Rec."Valid To")
                {
                    Editable = "Valid ToEditable";
                    ApplicationArea = All;
                }
            }
            part("Customer Group"; "Customer Group")
            {
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(Slab)
            {
                Caption = 'Slab';
                field("Slab Group"; Rec."Slab Group")
                {
                    Editable = "Slab GroupEditable";
                    ApplicationArea = All;
                }
            }
            part("Discount Line"; "Discount Line")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&uncton")
            {
                Caption = 'F&uncton';
                action("&Disable")
                {
                    Caption = '&Disable';
                    ShortCutKey = 'Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Rec.Status <> Rec.Status::Disable THEN BEGIN
                            Rec.Status := Rec.Status::Disable;
                            Rec.MODIFY;
                        END;
                        /*
                        CustGroup.RESET;
                        CustGroup.SETRANGE("No.","No.");
                        IF CustGroup.FINDFIRST THEN;
                        CASE CustGroup."Group Type" OF
                          CustGroup."Group Type"::State:
                            BEGIN
                              IF NOT CustGroup.All THEN BEGIN
                                CustomerGroup.SETRANGE(Code,CustGroup.Code);
                                CustomerGroup.SETRANGE("Include/Exclude",CustGroup."Include/Exclude"::Include);
                                IF CustomerGroup.FINDFIRST THEN
                                  CustomerGroup.TESTFIELD("Include/Exclude",CustomerGroup."Include/Exclude"::Exclude);
                              END;
                              {
                              REPEAT
                        
                              UNTIL CustomerGroup.NEXT = 0;
                              }
                            END;
                        END;
                        */

                    end;
                }
                action("&Enable")
                {
                    Caption = '&Enable';
                    ShortCutKey = 'Ctrl+E';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Valid From");
                        Rec.TESTFIELD("Valid To");
                        Rec.TESTFIELD("Slab Group");

                        IF Rec.Status <> Rec.Status::Enable THEN BEGIN
                            Rec.Status := Rec.Status::Enable;
                            Rec.MODIFY;
                        END;

                        CustomerGroup.RESET;
                        CustomerGroup.SETRANGE(CustomerGroup."No.", Rec."No.");
                        IF CustomerGroup.FIND('-') THEN BEGIN
                            REPEAT
                                CustomerGroup.Status := Rec.Status;
                                CustomerGroup."Valid From" := Rec."Valid From";
                                CustomerGroup."Valid To" := Rec."Valid To";

                                CustomerGroup.MODIFY;
                            UNTIL CustomerGroup.NEXT = 0;
                        END;

                        DiscountLine.RESET;
                        DiscountLine.SETRANGE(DiscountLine."Document No.", Rec."No.");
                        IF DiscountLine.FIND('-') THEN BEGIN
                            REPEAT
                                DiscountLine.Status := Rec.Status;
                                DiscountLine."Valid From" := Rec."Valid From";
                                DiscountLine."Valid To" := Rec."Valid To";
                                DiscountLine.MODIFY;
                            UNTIL DiscountLine.NEXT = 0;
                        END;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        IF Rec.Status = Rec.Status::Enable THEN BEGIN
            "No.Editable" := FALSE;
            DescriptionEditable := FALSE;
            "Slab GroupEditable" := FALSE;
            "Valid FromEditable" := FALSE;
            "Valid ToEditable" := FALSE;

        END ELSE BEGIN
            "No.Editable" := TRUE;
            DescriptionEditable := TRUE;
            "Slab GroupEditable" := TRUE;
            "Valid FromEditable" := TRUE;
            "Valid ToEditable" := TRUE;

        END;
    end;

    trigger OnInit()
    begin
        "Valid ToEditable" := TRUE;
        "Valid FromEditable" := TRUE;
        "Slab GroupEditable" := TRUE;
        DescriptionEditable := TRUE;
        "No.Editable" := TRUE;
    end;

    var
        CustGroup: Record "Customer Group";
        CustomerGroup: Record "Customer Group";
        Text5000: Label 'State(s) already defined for Discount No. %1.';
        DiscountLine: Record "Discount Line";
        [InDataSet]
        "No.Editable": Boolean;
        [InDataSet]
        DescriptionEditable: Boolean;
        [InDataSet]
        "Slab GroupEditable": Boolean;
        [InDataSet]
        "Valid FromEditable": Boolean;
        [InDataSet]
        "Valid ToEditable": Boolean;
}

