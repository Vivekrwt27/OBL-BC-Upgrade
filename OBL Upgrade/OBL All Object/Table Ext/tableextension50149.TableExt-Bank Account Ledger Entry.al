tableextension 50149 tableextension50149 extends "Bank Account Ledger Entry"
{

    // Team 7739 Upgrade 08062016
    fields
    {
        field(50000; "Issuing Bank"; Text[100])
        {
            Editable = false;
        }
        field(50001; "Description 2"; Text[200])
        {
            Editable = false;
        }
        field(50002; "Value Date"; Date)
        {
            CalcFormula = Lookup("Bank Account Statement Line"."Value Date" WHERE("Statement No." = FIELD("Statement No."),
                                                                                   "Statement Line No." = FIELD("Statement Line No."),
                                                                                   "Bank Account No." = FIELD("Bank Account No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50084; "PO No."; Code[25])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No.";
        }
        field(60000; "Beneficiary Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Saving,Current,Cash Credit';
            OptionMembers = " ",Saving,Current,"Cash Credit";
        }
        field(60001; "Beneficiary Account No."; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(60002; "Beneficiary Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60003; "Beneficiary IFSC Code"; Code[12])
        {
            DataClassification = ToBeClassified;
        }
        field(60004; "Payment Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,NEFT,RTGS,IMPS';
            OptionMembers = " ",NEFT,RTGS,IMPS;
        }
        field(60005; "File Creation DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(60006; "Online Bank Transfer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60007; "File Create By User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60008; "File Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(60009; "Bank RF Status"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60010; "Bank UTR/Ref. No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key9; "Posting Date")
        {
        }
    }


    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 3)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Bank Account No." := GenJnlLine."Account No.";
    "Posting Date" := GenJnlLine."Posting Date";
    "Document Date" := GenJnlLine."Document Date";
    "Document Type" := GenJnlLine."Document Type";
    "Document No." := GenJnlLine."Document No.";
    "External Document No." := GenJnlLine."External Document No.";
    Description := GenJnlLine.Description;
    "Global Dimension 1 Code" := GenJnlLine."Shortcut Dimension 1 Code";
    "Global Dimension 2 Code" := GenJnlLine."Shortcut Dimension 2 Code";
    "Dimension Set ID" := GenJnlLine."Dimension Set ID";
    "Our Contact Code" := GenJnlLine."Salespers./Purch. Code";
    "Source Code" := GenJnlLine."Source Code";
    "Journal Batch Name" := GenJnlLine."Journal Batch Name";
    "Reason Code" := GenJnlLine."Reason Code";
    "Currency Code" := GenJnlLine."Currency Code";
    "User ID" := USERID;
    "Bal. Account Type" := GenJnlLine."Bal. Account Type";
    "Bal. Account No." := GenJnlLine."Bal. Account No.";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    Description := GenJnlLine.Narration;
    "Description 2" :=  GenJnlLine.Description2;  //TRI V.D 28.06.10 ADD //Team 7739 Upgrade 08062016
    "PO No." := GenJnlLine."PO No.";
    #8..15
    "Issuing Bank" := GenJnlLine."Issuing Bank"; //Team 7739 Upgrade 08062016
    #16..18
    //
    "Online Bank Transfer" := GenJnlLine."Online Bank Transfer";
    "Beneficiary Account No." := GenJnlLine."Beneficiary Account No.";
    "Beneficiary Account Type" := GenJnlLine."Beneficiary Account Type";
    "Beneficiary IFSC Code" := GenJnlLine."Beneficiary IFSC Code";
    "Beneficiary Name" := GenJnlLine."Beneficiary Name";
    "Payment Mode" := GenJnlLine."Payment Mode";
    //
    */
    //end;

    procedure GetCurrencyCodeFromBank(): Code[10]
    var
        BankAcc: Record "Bank Account";
    begin
        IF ("Bank Account No." = BankAcc."No.") THEN
            EXIT(BankAcc."Currency Code")
        ELSE
            IF BankAcc.GET("Bank Account No.") THEN
                EXIT(BankAcc."Currency Code")
            ELSE
                EXIT('');
    end;
}

