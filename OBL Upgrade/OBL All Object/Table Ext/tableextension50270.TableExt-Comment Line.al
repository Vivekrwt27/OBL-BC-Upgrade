tableextension 50270 tableextension50270 extends "Comment Line"
{
    fields
    {
        modify("Table Name")
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Item,Resource,Job,,Resource Group,Bank Account,Campaign,Fixed Asset,Insurance,Nonstock Item,IC Partner,Indent Header';

            //Unsupported feature: Property Modification (OptionString) on ""Table Name"(Field 1)".

        }
        modify("No.")
        {
            TableRelation = IF ("Table Name" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Table Name" = CONST(Customer)) Customer
            ELSE
            IF ("Table Name" = CONST(Vendor)) Vendor
            ELSE
            IF ("Table Name" = CONST(Item)) Item
            ELSE
            IF ("Table Name" = CONST(Resource)) Resource
            ELSE
            IF ("Table Name" = CONST(Job)) Job
            ELSE
            IF ("Table Name" = CONST("Resource Group")) "Resource Group"
            ELSE
            IF ("Table Name" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Table Name" = CONST(Campaign)) Campaign
            ELSE
            IF ("Table Name" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Table Name" = CONST(Insurance)) Insurance
            ELSE
            IF ("Table Name" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Table Name" = FILTER("Indent Header")) "Indent Header";
        }
        field(50000; "Creater ID"; Code[20])
        {
            Editable = false;
        }
        field(50001; "Creation Date"; Date)
        {
            Editable = false;
        }
        field(50002; "Reply/Comment"; Option)
        {
            OptionCaption = ' ,Comment,Reply';
            OptionMembers = " ",Comment,Reply;

            trigger OnValidate()
            begin
                IndentHeader.RESET;
                IndentHeader.SETRANGE("No.", "No.");
                IF IndentHeader.FINDFIRST THEN BEGIN
                    IF IndentHeader.Status = IndentHeader.Status::Open THEN BEGIN
                        CommentLine.RESET;
                        CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::"Indent Header");
                        CommentLine.SETRANGE("No.", "No.");
                        IF NOT CommentLine.FINDFIRST THEN BEGIN
                            IF (("Reply/Comment" = "Reply/Comment"::Reply) OR ("Reply/Comment" = "Reply/Comment"::Comment)) THEN
                                ERROR(Text50000);
                        END;
                    END;
                    IF IndentHeader.Status = IndentHeader.Status::Authorization1 THEN BEGIN
                        IF UserSetup.GET(UPPERCASE(IndentHeader."User ID")) THEN BEGIN
                            IF UserSetup."Authorization 1" = UPPERCASE(USERID) THEN BEGIN
                                IF ("Reply/Comment" = "Reply/Comment"::Reply) THEN
                                    ERROR(Text50001)
                                ELSE
                                    IF ("Reply/Comment" = "Reply/Comment"::Comment) THEN BEGIN
                                        // IF IndentHeader.Replied=TRUE THEN BEGIN
                                        IndentHeader.Commented := TRUE;
                                        IndentHeader.Replied := FALSE;
                                        IndentHeader.MODIFY;
                                        // END ELSE
                                        //   ERROR(Text50002);
                                    END;
                            END;
                            IF UserSetup."User ID" = UPPERCASE(USERID) THEN BEGIN
                                IF ("Reply/Comment" = "Reply/Comment"::Comment) THEN
                                    ERROR(Text50002)
                                ELSE
                                    IF ("Reply/Comment" = "Reply/Comment"::Reply) THEN BEGIN
                                        // IF IndentHeader.Commented=TRUE THEN BEGIN
                                        IndentHeader.Commented := FALSE;
                                        IndentHeader.Replied := TRUE;
                                        IndentHeader.MODIFY;
                                        // END ELSE
                                        //   ERROR(Text50001)
                                    END;
                            END;
                        END;
                    END;

                    IF IndentHeader.Status = IndentHeader.Status::Authorization2 THEN BEGIN
                        IF UserSetup.GET(UPPERCASE(IndentHeader."User ID")) THEN BEGIN
                            IF UserSetup."Authorization 1" = UPPERCASE(USERID) THEN BEGIN
                                IF ("Reply/Comment" = "Reply/Comment"::Comment) THEN
                                    ERROR(Text50002)
                                ELSE
                                    IF ("Reply/Comment" = "Reply/Comment"::Reply) THEN BEGIN
                                        // IF IndentHeader.Replied=TRUE THEN BEGIN
                                        IndentHeader.Commented := FALSE;
                                        IndentHeader.Replied := TRUE;
                                        IndentHeader.MODIFY;
                                        // END ELSE
                                        //   ERROR(Text50002);
                                    END;
                            END;
                        END;
                        IF UserSetup."Authorization 2" = UPPERCASE(USERID) THEN BEGIN
                            IF ("Reply/Comment" = "Reply/Comment"::Reply) THEN
                                ERROR(Text50001)
                            ELSE
                                IF ("Reply/Comment" = "Reply/Comment"::Comment) THEN BEGIN
                                    // IF IndentHeader.Replied=TRUE THEN BEGIN
                                    IndentHeader.Commented := TRUE;
                                    IndentHeader.Replied := FALSE;
                                    IndentHeader.MODIFY;
                                    // END ELSE
                                    //   ERROR(Text50002);
                                END;
                        END;
                    END;

                    IF IndentHeader.Status = IndentHeader.Status::Authorization3 THEN BEGIN
                        IF UserSetup.GET(UPPERCASE(IndentHeader."User ID")) THEN BEGIN
                            IF UserSetup."Authorization 2" = UPPERCASE(USERID) THEN BEGIN
                                IF ("Reply/Comment" = "Reply/Comment"::Comment) THEN
                                    ERROR(Text50002)
                                ELSE
                                    IF ("Reply/Comment" = "Reply/Comment"::Reply) THEN BEGIN
                                        // IF IndentHeader.Replied=TRUE THEN BEGIN
                                        IndentHeader.Commented := FALSE;
                                        IndentHeader.Replied := TRUE;
                                        IndentHeader.MODIFY;
                                        //  END ELSE
                                        //    ERROR(Text50002);
                                    END;
                            END;
                        END;
                        IF UserSetup."Authorization 3" = UPPERCASE(USERID) THEN BEGIN
                            IF ("Reply/Comment" = "Reply/Comment"::Reply) THEN
                                ERROR(Text50001)
                            ELSE
                                IF ("Reply/Comment" = "Reply/Comment"::Comment) THEN BEGIN
                                    //   IF IndentHeader.Replied =FALSE THEN BEGIN
                                    IndentHeader.Commented := TRUE;
                                    IndentHeader.Replied := FALSE;
                                    IndentHeader.MODIFY;
                                    //   END ELSE
                                    //      ERROR(Text50002);
                                END;
                        END;
                    END;
                END;
            end;
        }
        field(50003; "To User"; Code[20])
        {
            TableRelation = "User Setup";
        }
        field(50004; "Ref Code"; Code[20])
        {
            CalcFormula = Lookup(Item."Old Code" WHERE("No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50005; IPG; Code[50])
        {
            CalcFormula = Lookup(Item."Inventory Posting Group" WHERE("No." = FIELD("No.")));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key2; "No.")
        {
        }
    }

    //Unsupported feature: Code Insertion on "OnInsert".

    trigger OnInsert()// 15578
    begin
        "Creater ID" := USERID; //TRI S.R
        "Creation Date" := TODAY; //TRI S.R
    end;

    //Unsupported feature: Code Insertion on "OnModify".

    trigger OnModify()// 15578
    begin
        "Creater ID" := USERID; //TRI S.R
        "Creation Date" := TODAY; //TRI S.R
    end;

    var
        CommentLine: Record "Comment Line";
        IndentHeader: Record "Indent Header";
        UserSetup: Record "User Setup";
        Text50000: Label 'You Cannot Comment or Reply.';
        Text50001: Label 'You can select Comment Only.';
        Text50002: Label 'You can select Reply Only.';
}

