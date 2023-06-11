tableextension 50148 tableextension50148 extends "Bank Account"
{
    fields
    {

        //Unsupported feature: Property Modification (CalcFormula) on ""Total on Checks"(Field 62)".

        /* modify("Check Report ID")
         {
             TableRelation = Object.ID WHERE(Type = CONST(Report));
         }*/
        modify("Credit Transfer Msg. Nos.")
        {
            Caption = 'SEPA CT Msg. ID No. Series';
        }
        modify("Direct Debit Msg. Nos.")
        {
            Caption = 'SEPA DD Msg. ID No. Series';
        }

        modify("Global Dimension 1 Code")// 15578
        {
            trigger OnBeforeValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
                MODIFY;
            end;
        }
        modify("Global Dimension 2 Code")// 15578
        {
            trigger OnBeforeValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
                MODIFY;
            end;
        }


        field(50000; "Amount X"; Integer)
        {
        }
        field(50001; "Amount Y"; Integer)
        {
        }
        field(50002; "Name X"; Integer)
        {
        }
        field(50003; "Name Y"; Integer)
        {
        }
        field(50004; "Text Amount L1 X"; Integer)
        {
        }
        field(50005; "Text Amount L1 Y"; Integer)
        {
        }
        field(50006; "Date X"; Integer)
        {
        }
        field(50007; "Date Y"; Integer)
        {
        }
        field(50008; "Text Amount L2 X"; Integer)
        {
        }
        field(50009; "Text Amount  L2 Y"; Integer)
        {
        }
        field(50010; "Text Amount L1 Length"; Integer)
        {
            MaxValue = 80;
            MinValue = 0;
        }
        field(50011; "Add Half Line"; Boolean)
        {
        }
        field(50012; "Create for Orient"; Boolean)
        {
            Description = 'MIPL,MSBS.Rao Dt. 03-10-11';
            Editable = false;
        }
        field(50013; "Create for Bell"; Boolean)
        {
            Description = 'MIPL,MSBS.Rao Dt. 03-10-11';
            Editable = false;
        }
        field(50014; "MIS Sequence"; Integer)
        {
            Description = 'MSPB';
        }
        field(50015; "Integration Bank"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Axis Bank,IDFC Bank';
            OptionMembers = " ","Axis Bank","IDFC Bank";
        }
        field(50016; "AD Code"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "RTGS/NEFT/IFSC Code"; Code[15])
        {
            DataClassification = ToBeClassified;
            Description = 'MIPLRK270422';
        }
        field(85000; "Not Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key6; "MIS Sequence")
        {
        }
        key(Key7; Name)
        {
        }
    }



    trigger OnModify()
    begin
        IF NOT (USERID IN ['FA003', 'IT005', 'ADMIN']) THEN
            ERROR('You Do not have permission to modify');
    end;


    //Unsupported feature: Code Modification on "GetPaymentExportCodeunitID(PROCEDURE 6)".

    //procedure GetPaymentExportCodeunitID();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetBankExportImportSetup(BankExportImportSetup);
    EXIT(BankExportImportSetup."Processing Codeunit ID");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GetBankExportImportSetup(BankExportImportSetup);
    BankExportImportSetup.TESTFIELD("Processing Codeunit ID");
    EXIT(BankExportImportSetup."Processing Codeunit ID");
    */
    //end;// Function not found

    procedure GetCreditTransferMessageNo(): Code[20]
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        TESTFIELD("Credit Transfer Msg. Nos.");
        EXIT(NoSeriesManagement.GetNextNo("Credit Transfer Msg. Nos.", TODAY, TRUE));
    end;

    procedure GetDirectDebitMessageNo(): Code[20]
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        TESTFIELD("Direct Debit Msg. Nos.");
        EXIT(NoSeriesManagement.GetNextNo("Direct Debit Msg. Nos.", TODAY, TRUE));
    end;

    procedure "--MIPL,MSBS.Rao---"()
    begin
    end;

    procedure CreateForBell(RecBankAcc: Record "Bank Account"; DocumentNO: Code[20])
    var
        RecBankAccount: Record "Bank Account";
        ToCompany: Text[50];
        BankCode: Code[20];
        Err0001: Label 'Please contact your system administrator !!!';
    begin
        WITH RecBankAccount DO BEGIN
            IF COMPANYNAME = 'Orient Bell Ceramics (Master)' THEN BEGIN
                ToCompany := 'Bell Ceramics Ltd.';
                BankCode := RecBankAccount."No.";
                RecBankAccount.CHANGECOMPANY(ToCompany);
                IF NOT RecBankAccount.GET(BankCode) THEN BEGIN
                    RecBankAccount.TRANSFERFIELDS(Rec);
                    RecBankAccount.INSERT;
                END;
                RecBankAcc.RESET;
                RecBankAcc.SETRANGE("No.", DocumentNO);
                IF RecBankAcc.FINDFIRST THEN BEGIN
                    RecBankAcc."Create for Bell" := TRUE;
                    RecBankAcc.MODIFY;
                END;
            END ELSE
                ERROR(Err0001);
        END;
    end;

    procedure CreateForOrient(RecBankAcc: Record "Bank Account"; DocumentNO: Code[20])
    var
        RecBankAccount: Record "Bank Account";
        ToCompany: Text[50];
        BankCode: Code[20];
        Err0001: Label 'Please contact your system administrator !!!';
    begin
        IF COMPANYNAME = 'Orient Bell Ceramics (Master)' THEN BEGIN
            ToCompany := 'Orient Tiles Live Set Up';
            BankCode := RecBankAccount."No.";
            RecBankAccount.CHANGECOMPANY(ToCompany);
            IF NOT RecBankAccount.GET(BankCode) THEN BEGIN
                RecBankAccount.TRANSFERFIELDS(Rec);
                RecBankAccount.INSERT;
            END;
            RecBankAcc.RESET;
            RecBankAcc.SETRANGE("No.", DocumentNO);
            IF RecBankAcc.FINDFIRST THEN BEGIN
                RecBankAcc."Create for Orient" := TRUE;
                RecBankAcc.MODIFY;
            END;
        END ELSE
            ERROR(Err0001);
    end;

    procedure CreateForAll(RecBankAcc: Record "Bank Account"; DocumentNO: Code[20])
    var
        RecBankAccount: Record "Bank Account";
        ToCompany: Text[50];
        RecCompany: Record Company;
        BankCode: Code[20];
        Err0001: Label 'Please contact your system administrator !!!';
    begin
        IF COMPANYNAME = 'Orient Bell Ceramics (Master)' THEN BEGIN
            IF RecCompany.FINDFIRST THEN BEGIN
                REPEAT
                    ToCompany := RecCompany.Name;
                    BankCode := RecBankAccount."No.";
                    RecBankAccount.CHANGECOMPANY(ToCompany);
                    IF NOT RecBankAccount.GET(BankCode) THEN BEGIN
                        RecBankAccount.TRANSFERFIELDS(Rec);
                        RecBankAccount.INSERT;
                    END;
                UNTIL RecCompany.NEXT = 0;
            END;
            RecBankAcc.RESET;
            RecBankAcc.SETRANGE("No.", DocumentNO);
            IF RecBankAcc.FINDFIRST THEN BEGIN
                RecBankAcc."Create for Orient" := TRUE;
                RecBankAcc."Create for Bell" := TRUE;
                RecBankAcc.MODIFY;
            END;
        END ELSE
            ERROR(Err0001);
    end;


}

