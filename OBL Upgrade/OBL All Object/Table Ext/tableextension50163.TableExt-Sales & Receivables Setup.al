tableextension 50163 tableextension50163 extends "Sales & Receivables Setup"
{
    fields
    {
        /* modify("Posted Invoice Nos. (Trading)")
         {
             Caption = 'Posted Invoice Nos. (Trading)';
         }
         modify("Posted Ret Rcpt Nos. (Trading)")
         {
             Caption = 'Posted Ret Rcpt Nos. (Trading)';
         }
         modify("Posted Sales Shpt. (Trading)")
         {
             Caption = 'Posted Sales Shpt. (Trading)';
         }
         modify("Posted Sale Cr. Memo (Trading)")
         {
             Caption = 'Posted Sale Cr. Memo (Trading)';
         }*/ // 15578
        field(50000; "% of MRP"; Decimal)
        {
            MaxValue = 100;
            MinValue = 0;
        }
        field(50001; "Prompt Pmt. Account No."; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50002; "Insurance Tax Charge Group"; Code[20])
        {
            // 15578 TableRelation = "Tax/Charge Group".Code;
        }
        field(50003; "UP State Code"; Code[20])
        {
            TableRelation = State.Code;
        }
        field(50004; "Nepal Country Code"; Code[20])
        {
            TableRelation = "Country/Region".Code;
        }
        field(50005; "Bhutan Country Code"; Code[20])
        {
            TableRelation = "Country/Region".Code;
        }
        field(50006; "Form Code For C-Form"; Code[10])
        {
            // 15578 TableRelation = "Form Codes".Code;
        }
        field(50007; "Cash Disc. Charge"; Code[20])
        {
            TableRelation = "Item Charge";
        }
        field(50008; "Tax Area Code For UPTT"; Code[20])
        {
            TableRelation = "Tax Area";
        }
        field(50009; "Tax Area Code For CST (Plant)"; Code[20])
        {
            TableRelation = "Tax Area";
        }
        field(50010; "Tax Jurisdiction Code For UPDT"; Code[20])
        {
            TableRelation = "Tax Jurisdiction";
        }
        field(50011; "Excise %"; Decimal)
        {
            Description = 'TRI H.B 25.04.06 - new field added';
            MaxValue = 100;
            MinValue = 0;
        }
        field(50012; "Discount No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50013; "QD Applicable"; Boolean)
        {
        }
        field(50014; City; Code[20])
        {
            Description = 'MSVC,MS-AN';
            TableRelation = Dimension;
        }
        field(50015; States; Code[20])
        {
            Description = 'MSVC,MS-AN';
            TableRelation = Dimension;
        }
        field(50016; Zone; Code[20])
        {
            Description = 'MSVC,MS-AN';
            TableRelation = Dimension;
        }
        field(50017; Division; Code[20])
        {
            Description = 'MSVC,MS-AN';
            TableRelation = Dimension;
        }
        field(50018; "Sales Matrix"; Code[20])
        {
            Description = 'MSVC,MS-AN';
            TableRelation = "No. Series";
        }
        field(50019; TempBoolean; Boolean)
        {
            Description = 'MSVC,MS-AN';
        }
        field(50020; "Area"; Code[20])
        {
            Description = 'MSVC,MS-AN';
            TableRelation = Dimension;
        }
        field(50021; "NPD Count"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Add';
        }
        field(50100; "E-Way User Name"; Text[30])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50101; "E-Way Password"; Text[30])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50102; "E-way Access Token"; Text[250])
        {
            Description = 'Alle-[E-Way API]';
        }
        field(50103; "E-way Access Token Validity"; DateTime)
        {
            Description = 'Alle-[E-Way API]';
        }
        field(60001; "Inter Customer A/c"; Code[20])
        {
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                 "Direct Posting" = CONST(true));
        }
        field(60002; "D1 Approval Limit"; Decimal)
        {
        }
        field(60003; "D2 Approval Limit"; Decimal)
        {
        }
        field(60004; "D3 Approval Limit"; Decimal)
        {
        }
        field(60005; "D4 Approval Limit"; Decimal)
        {
        }
        field(60006; "PSM Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code WHERE(Type = CONST(PSM));
        }
        field(80000; "CD Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(80001; "Manual Credit Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(80002; "Insurance Structure"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Charge";
        }

        field(80003; "Structure Frieght"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Charge";
        }

        field(80005; "Structure Trade Discount"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Charge";
        }


    }
    var
        r: Record "Item Charge";
}

