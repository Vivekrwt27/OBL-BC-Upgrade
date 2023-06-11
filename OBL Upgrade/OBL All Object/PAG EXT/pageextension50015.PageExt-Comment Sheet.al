pageextension 50015 pageextension50015 extends "Comment Sheet"
{
    layout
    {
        addfirst(Control1)
        {
            field("Reply/Comment"; rec."Reply/Comment")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    IndentHeder.RESET;
                    IndentHeder.SETRANGE("No.", rec."No.");
                    IF IndentHeder.FINDFIRST THEN;

                    CASE rec."Reply/Comment" OF
                        rec."Reply/Comment"::" ":
                            BEGIN
                                CASE IndentHeder.Status OF
                                    IndentHeder.Status::Open:
                                        BEGIN
                                            IF UserSetup.GET(IndentHeder."User ID") THEN
                                                IF UPPERCASE(USERID) = UserSetup."User ID" THEN
                                                    rec."To User" := UserSetup."Authorization 1";
                                        END;
                                END;
                            END;

                        rec."Reply/Comment"::Comment:
                            BEGIN
                                CASE IndentHeder.Status OF
                                    IndentHeder.Status::Authorization1:
                                        BEGIN
                                            IF UserSetup.GET(IndentHeder."User ID") THEN
                                                IF UPPERCASE(USERID) = UserSetup."Authorization 1" THEN
                                                    rec."To User" := UserSetup."User ID";
                                        END;
                                    IndentHeder.Status::Authorization2:
                                        BEGIN
                                            IF UserSetup.GET(IndentHeder."User ID") THEN
                                                IF UPPERCASE(USERID) = UserSetup."Authorization 2" THEN
                                                    rec."To User" := UserSetup."Authorization 1";

                                        END;
                                    IndentHeder.Status::Authorization3:
                                        BEGIN
                                            IF UserSetup.GET(IndentHeder."User ID") THEN
                                                IF UPPERCASE(USERID) = UserSetup."Authorization 3" THEN
                                                    rec."To User" := UserSetup."Authorization 2";
                                        END;
                                END
                            END;

                        rec."Reply/Comment"::Reply:
                            BEGIN
                                CASE IndentHeder.Status OF
                                    IndentHeder.Status::Authorization1:
                                        BEGIN
                                            IF UserSetup.GET(IndentHeder."User ID") THEN
                                                IF UPPERCASE(USERID) = UserSetup."User ID" THEN
                                                    rec."To User" := UserSetup."Authorization 1";
                                        END;
                                    IndentHeder.Status::Authorization2:
                                        BEGIN
                                            IF UserSetup.GET(IndentHeder."User ID") THEN
                                                IF UPPERCASE(USERID) = UserSetup."Authorization 1" THEN
                                                    rec."To User" := UserSetup."Authorization 2";
                                        END;
                                    IndentHeder.Status::Authorization3:
                                        BEGIN
                                            IF UserSetup.GET(IndentHeder."User ID") THEN
                                                IF UPPERCASE(USERID) = UserSetup."Authorization 2" THEN
                                                    rec."To User" := UserSetup."Authorization 3";
                                        END;
                                END
                            END;
                    END;
                end;
            }
        }
        addafter(Code)
        {
            field("Table Name"; rec."Table Name")
            {
                ApplicationArea = All;
            }
            field("No."; rec."No.")
            {
                ApplicationArea = All;
            }
            field("Line No."; rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
    }

    var
        CommentLine: Record "Comment Line";
        TotLine: Decimal;
        UserWiseLine: Decimal;
        IndentHeder: Record "Indent Header";
        UserSetup: Record "User Setup";
        [InDataSet]
        CommentEditable: Boolean;
        [InDataSet]
        CodeEditable: Boolean;
        [InDataSet]
        DateEditable: Boolean;
        userset: Record "User Setup";



    //Unsupported feature: Code Insertion on "OnNextRecord".

    //trigger OnNextRecord()
    //Parameters and return type have not been exported.
    //begin
    /*
    Editablemode;//MSBS.Rao 300914
    */
    //end;
    trigger OnOpenPage()
    begin
        IF rec."Table Name" = rec."Table Name"::Item THEN BEGIN
            IF userset.GET(USERID) THEN BEGIN
                IF userset."Allow Comments Editable" = TRUE THEN BEGIN
                    CurrPage.EDITABLE := TRUE;
                END ELSE BEGIN
                    CurrPage.EDITABLE := FALSE;
                END;
            END;
        END;
        DateEditable := TRUE;
        CodeEditable := TRUE;
        CommentEditable := TRUE;

    end;


    procedure CalledFrom(Release: Boolean)
    begin
        //mo tri1.0 Customization no.2.9 start
        IF Release = TRUE THEN BEGIN
            CommentEditable := FALSE;
            CodeEditable := FALSE;
            DateEditable := FALSE;
        END ELSE BEGIN
            CommentEditable := TRUE;
            CodeEditable := TRUE;
            DateEditable := TRUE;
        END;
        //mo tri1.0 Customization no.2.9 end
    end;

    procedure Editablemode()
    begin
        IF rec."Table Name" = rec."Table Name"::Item THEN BEGIN
            IF UserSetup.GET(USERID) THEN
                IF UserSetup."Allow Comments Editable" THEN
                    CurrPage.EDITABLE(TRUE)
                ELSE
                    CurrPage.EDITABLE(FALSE)
        END;
    end;
}

