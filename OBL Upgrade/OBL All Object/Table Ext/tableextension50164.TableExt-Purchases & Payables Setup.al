tableextension 50164 tableextension50164 extends "Purchases & Payables Setup"
{
    fields
    {
        /*  modify("Posted Invoice Nos. (Trading)")
          {
              Caption = 'Posted Invoice Nos. (Trading)';
          }
          modify("Posted Ret Shpt Nos. (Trading)")
          {
              Caption = 'Posted Ret Shpt Nos. (Trading)';
          }
          modify("Posted Purch. Rcpt. (Trading)")
          {
              Caption = 'Posted Purch. Rcpt. (Trading)';
          }
          modify("Posted Purch Cr. Memo(Trading)")
          {
              Caption = 'Posted Purch Cr. Memo(Trading)';
          }*/ // 15578
        modify("Multiple Subcon. Order Det Nos")
        {
            Caption = 'Multiple Subcon. Order Det Nos';
        }
        field(50000; "Rejection Reason Code"; Code[10])
        {
            Description = 'Customization No. 10';
            TableRelation = "Reason Code";
        }
        field(50001; "Shortage Reason Code"; Code[10])
        {
            Description = 'Customization No. 10';
            TableRelation = "Reason Code";
        }
        field(50002; "RFQ No."; Code[20])
        {
            Description = 'Customization No. 3';
            TableRelation = "No. Series";
        }
        field(50003; "Indent Nos."; Code[10])
        {
            Description = 'Customization No. 1 ND';
            TableRelation = "No. Series";
        }
        field(50004; "Transportor Nos."; Code[20])
        {
            Description = 'Customization No. 9';
            TableRelation = "No. Series";
        }
        field(50005; "Form Code For Form 38"; Code[10])
        {
            // 15578  TableRelation = "Form Codes".Code;
        }
        field(50006; "Form Code For Form 31"; Code[10])
        {
            Description = 'report 50028';
            /* 15578   TableRelation = "Form Codes".Code;

               trigger OnValidate()
               var
                   FormCodes: Record "13756";
               begin
                   FormCodes.RESET;
                   FormCodes.SETFILTER(FormCodes.Code, "Form Code For Form 31");
                   FormCodes.SETRANGE(FormCodes."Transit Document", TRUE);
                   IF NOT FormCodes.FIND('-') THEN
                       ERROR('Form code is not a Transit Document');
               end;*/ // 15578
        }
        field(50010; "Vendor Nos. 2"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'MSVrn';
            TableRelation = "No. Series";
        }
        field(50011; "EY Token User Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'EY-AIM';
        }
        field(50012; "EY Toekn Password"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'EY-AIM';
        }
        field(50013; "EY Api Access Key"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'EY-AIM';
        }
        field(50014; "EY Purchase Register URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'EY-AIM';
        }
        field(50015; "EY Reconcilation Detail URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'EY-AIM';
        }
        field(50016; "EY Reconcilation Report URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'EY-AIM';
        }
        field(50017; "EY Token URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'EY-AIM';
        }
        field(60000; "Reject No."; Code[20])
        {
            Description = 'TRI V.D 30.10.10 - New Field added';
            TableRelation = "No. Series";
        }
        field(60001; "Store Reject No"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(60002; "RGP No. Series"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(60003; "Auto Indent No. Series"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(60004; "Indent No. Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60005; "Budget No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    local procedure CheckGLAcc(AccNo: Code[20])
    var
        GLAcc: Record "G/L Account";
    begin
        IF AccNo <> '' THEN BEGIN
            GLAcc.GET(AccNo);
            GLAcc.CheckGLAcc;
        END;
    end;
}

