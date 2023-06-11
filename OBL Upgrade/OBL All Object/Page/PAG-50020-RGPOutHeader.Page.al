page 50020 "RGP Out Header"
{
    // Customization No. 63

    DataCaptionFields = "No.";
    PageType = Card;
    SourceTable = "RGP Header";
    SourceTableView = WHERE(Posted = CONST(false),
                            "Document Type" = CONST(Out));
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
                    NotBlank = true;
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

                    trigger OnValidate()
                    begin
                        RGPLine.RESET;
                        RGPLine.SETRANGE("RGP No.", rec."No.");
                        RGPLine.SETRANGE("Indent No.", '<>%1', '');
                        IF RGPLine.FINDSET THEN BEGIN
                            IF CONFIRM('If you will change Location, Line(s) will be deleted!', FALSE) THEN BEGIN
                                REPEAT
                                    MESSAGE('%1 = %2', RGPLine."Indent No.", RGPLine."Indent Line No.");
                                    RGPLine.DELETEALL;
                                UNTIL RGPLine.NEXT = 0;
                            END;
                        END;

                        LocationOnAfterValidate;
                    end;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                }
                field("GST No."; Rec."Tin No.")
                {
                    Caption = 'GST No.';
                    ApplicationArea = All;
                }
            }
            part("RGP Out Line"; "RGP Out Line")
            {
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
                    begin
                        rec.TESTFIELD("Posting Date");
                        rec.TESTFIELD("Order Date");
                        rec.TESTFIELD("Employee ID");
                        rec.TESTFIELD(Code);  //Customer Vendor or Party Code

                        RGPLine.RESET;
                        RGPLine.SETFILTER(RGPLine."Document Type", '%1', rec."Document Type");
                        RGPLine.SETFILTER(RGPLine."RGP No.", rec."No.");
                        IF NOT RGPLine.FIND('-') THEN
                            ERROR('There is nothing to Post');

                        IF RGPLine.FIND('-') THEN
                            REPEAT
                                IF (RGPLine.Quantity = 0) AND (RGPLine.Type <> RGPLine.Type::" ") THEN
                                    ERROR('Quantity must not be 0 in Line No. %1', RGPLine."Line No.");
                            UNTIL RGPLine.NEXT = 0;
                        //EXIT;
                        IF CONFIRM('Do you want to post RGP Out?') THEN BEGIN
                            RGPLine.RESET;
                            RGPLine.SETFILTER(RGPLine."Document Type", '%1', rec."Document Type");
                            RGPLine.SETFILTER(RGPLine."RGP No.", rec."No.");
                            IF RGPLine.FIND('-') THEN
                                REPEAT
                                    RGPLine.Posted := TRUE;
                                    RGPLine.MODIFY;
                                UNTIL RGPLine.NEXT = 0;
                            rec.Posted := TRUE;
                            rec.MODIFY;
                        END;
                    end;
                }
                action("Post and &Print....")
                {
                    Caption = 'Post and &Print....';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        rec.TESTFIELD("Posting Date");
                        rec.TESTFIELD("Order Date");
                        rec.TESTFIELD("Employee ID");
                        rec.TESTFIELD(Code);
                        RGPLine.RESET;
                        RGPLine.SETFILTER(RGPLine."Document Type", '%1', rec."Document Type");
                        RGPLine.SETFILTER(RGPLine."RGP No.", rec."No.");
                        IF NOT RGPLine.FIND('-') THEN
                            ERROR('There is nothing to Post');

                        IF RGPLine.FIND('-') THEN
                            REPEAT
                                IF (RGPLine.Quantity = 0) AND (RGPLine.Type <> RGPLine.Type::" ") THEN
                                    ERROR('Quantity must not be 0 in Line No. %1', RGPLine."Line No.");
                            UNTIL RGPLine.NEXT = 0;

                        IF CONFIRM('Do you want to post and print the RGP Out?') THEN BEGIN
                            //--
                            RGPHeader.RESET;
                            RGPHeader.SETRANGE("No.", rec."No.");
                            RGPReport.SETTABLEVIEW(RGPHeader);
                            //--

                            RGPLine.RESET;
                            RGPLine.SETFILTER(RGPLine."Document Type", '%1', rec."Document Type");
                            RGPLine.SETFILTER(RGPLine."RGP No.", rec."No.");
                            IF RGPLine.FIND('-') THEN
                                REPEAT
                                    RGPLine.Posted := TRUE;
                                    RGPLine.MODIFY;
                                UNTIL RGPLine.NEXT = 0;
                            rec.Posted := TRUE;
                            rec.MODIFY;
                        END ELSE
                            EXIT;

                        /*
                        //print RGP
                        RGPHeader.RESET;
                        RGPHeader.SETFILTER(RGPHeader."No.","No.");
                        RGPReport.SETTABLEVIEW(RGPHeader);
                        RGPReport.RUN;
                        */

                    end;
                }
                action(Comment)
                {
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CommentLine1.RESET;
                        CommentLine1.SETRANGE("Table Name", CommentLine1."Table Name"::"Indent Header");
                        CommentLine1.SETRANGE("No.", rec."Indent No.");
                        IF PAGE.RUNMODAL(PAGE::"Comment List", CommentLine1) = ACTION::LookupOK THEN;
                    end;
                }
                action("Get Indent")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IndentHeader.SETFILTER("Location Code", rec.Location);
                        IF IndentHeader.FINDSET THEN
                            CLEAR(IndentList);
                        IndentList.LOOKUPMODE := TRUE;
                        IndentList.Getsourceno(rec."No.");
                        IndentList.SETTABLEVIEW(IndentHeader);
                        IndentList.RUNMODAL;
                    end;
                }
                action("RGP Report")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        RGPHeader.RESET;
                        RGPHeader.SETRANGE("No.", rec."No.");
                        REPORT.RUN(REPORT::RGP, TRUE, FALSE, RGPHeader);
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Cust 63 Start Vipul

        rec."Document Type" := xRec."Document Type";

        //Cust 63 End Vipul
    end;

    var
        DimensionValue: Record "Dimension Value";
        GeneralLedgerSetup: Record "General Ledger Setup";
        RGPLine: Record "RGP Line";
        RGPHeader: Record "RGP Header";
        RGPReport: Report RGP;
        IndentHeader: Record "Indent Line";
        IndentLine: Record "Indent Line";
        recRGPLine: Record "RGP Line";
        IndentList: Page "Indent Line List";
        DocNo: Code[250];
        LineNo: Integer;
        SalesLine: Record "Sales Line";
        ItemType: Text;
        CommentLine: Record "Comment Line";
        CommentLine1: Record "Comment Line";
        IndentLineList: Page "Indent Line List";

    local procedure PurposeOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure TypeOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure CodeOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure LocationOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;
}

