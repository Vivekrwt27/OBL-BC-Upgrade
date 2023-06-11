tableextension 50047 tableextension50047 extends "G/L Account"
{
    fields
    {
        field(50000; "Source Code Amount"; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                        "Source Code" = FILTER('')));
            FieldClass = FlowField;
        }
        field(50001; wip; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                        "Document No." = FIELD("Document Filter"),
                                                        "System-Created Entry" = CONST(true),
                                                        "Posting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(50002; "Document Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50003; "Create for Orient"; Boolean)
        {
            Description = 'MIPL,MSBS.Rao Dt. 03-10-11';
            Editable = false;
        }
        field(50004; "Create for Bell"; Boolean)
        {
            Description = 'MIPL,MSBS.Rao Dt. 03-10-11';
            Editable = false;
        }
        field(85000; "Not Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    procedure "--MIPL,MSBS.Rao---"()
    begin
    end;

    procedure CreateForBell(RecGLAcc: Record "G/L Account"; DocumentNO: Code[20])
    var
        RecGLAccount: Record "G/L Account";
        ToCompany: Text[50];
        GLCode: Code[20];
        Err0001: Label 'Please contact your system administrator !!!';
    begin
        WITH RecGLAccount DO BEGIN
            IF COMPANYNAME = 'Orient Bell Ceramics (Master)' THEN BEGIN
                ToCompany := 'Bell Ceramics Ltd.';
                GLCode := RecGLAccount."No.";
                RecGLAccount.CHANGECOMPANY(ToCompany);
                IF NOT RecGLAccount.GET(GLCode) THEN BEGIN
                    RecGLAccount.TRANSFERFIELDS(Rec);
                    RecGLAccount.INSERT;
                END;
                RecGLAcc.RESET;
                RecGLAcc.SETRANGE("No.", DocumentNO);
                IF RecGLAcc.FINDFIRST THEN BEGIN
                    RecGLAcc."Create for Bell" := TRUE;
                    RecGLAcc.MODIFY;
                END;
            END ELSE
                ERROR(Err0001);
        END;
    end;

    procedure CreateForOrient(RecGLAcc: Record "G/L Account"; DocumentNO: Code[20])
    var
        RecGLAccount: Record "G/L Account";
        ToCompany: Text[50];
        GLCode: Code[20];
        Err0001: Label 'Please contact your system administrator !!!';
    begin
        WITH RecGLAccount DO BEGIN
            IF COMPANYNAME = 'Orient Bell Ceramics (Master)' THEN BEGIN
                ToCompany := 'Orient Tiles Live Set Up';
                GLCode := RecGLAccount."No.";
                RecGLAccount.CHANGECOMPANY(ToCompany);
                IF NOT RecGLAccount.GET(GLCode) THEN BEGIN
                    RecGLAccount.TRANSFERFIELDS(Rec);
                    RecGLAccount.INSERT;
                END;
                RecGLAcc.RESET;
                RecGLAcc.SETRANGE("No.", DocumentNO);
                IF RecGLAcc.FINDFIRST THEN BEGIN
                    RecGLAcc."Create for Orient" := TRUE;
                    RecGLAcc.MODIFY;
                END;
            END ELSE
                ERROR(Err0001);
        END;
    end;

    procedure CreateForAll(RecGLAcc: Record "G/L Account"; DocumentNO: Code[20])
    var
        RecGLAccount: Record "G/L Account";
        ToCompany: Text[50];
        RecCompany: Record Company;
        GLCode: Code[20];
        Err0001: Label 'Please contact your system administrator !!!';
    begin
        WITH RecGLAccount DO BEGIN
            IF COMPANYNAME = 'Orient Bell Ceramics (Master)' THEN BEGIN
                IF RecCompany.FINDFIRST THEN BEGIN
                    REPEAT
                        ToCompany := RecCompany.Name;
                        GLCode := RecGLAccount."No.";
                        RecGLAccount.CHANGECOMPANY(ToCompany);
                        IF NOT RecGLAccount.GET(GLCode) THEN BEGIN
                            RecGLAccount.TRANSFERFIELDS(Rec);
                            RecGLAccount.INSERT;
                        END;
                    UNTIL RecCompany.NEXT = 0;
                END;
                RecGLAcc.RESET;
                RecGLAcc.SETRANGE("No.", DocumentNO);
                IF RecGLAcc.FINDFIRST THEN BEGIN
                    RecGLAcc."Create for Orient" := TRUE;
                    RecGLAcc."Create for Bell" := TRUE;
                    RecGLAcc.MODIFY;
                END;
            END ELSE
                ERROR(Err0001);
        END;
    end;
}

