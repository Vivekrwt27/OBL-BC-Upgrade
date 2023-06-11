tableextension 50141 tableextension50141 extends "Vendor Ledger Entry"
{
    // Team 7739 Upgrade 08062016
    fields
    {


        /* modify("TDS Group")
         {
             OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others,Goods';

             //Unsupported feature: Property Modification (OptionString) on ""TDS Group"(Field 13703)".

         }*/ // 15578


        modify("Payment Reference")// 15578
        {
            trigger OnBeforeValidate()
            begin
                IF "Payment Reference" <> '' THEN
                    TESTFIELD("Creditor No.");
            end;
        }
        field(50001; Description2; Text[200])
        {
        }
        field(50002; "Cheque No."; Code[10])
        {
        }
        field(50003; "Cheque Date"; Date)
        {
        }
        field(50045; Month; Integer)
        {
            Description = 'Tri18.1PG For Multi Balancing Option In Vendor Ledger';
        }
        field(50046; Year; Integer)
        {
            Description = 'Tri18.1PG For Multi Balancing Option In Vendor Ledger';
        }
        field(50047; "Vendor Order No."; Code[20])
        {
            CalcFormula = Lookup("Purch. Inv. Line"."Source Order No." WHERE("Document No." = FIELD("Document No.")));
            Description = 'Track';
            Enabled = false;
            FieldClass = FlowField;
        }
        field(50048; "Vendor Invoice No."; Code[50])
        {
            CalcFormula = Lookup("Purch. Inv. Header"."Vendor Invoice No." WHERE("No." = FIELD("Document No.")));
            Description = 'Track';
            Enabled = false;
            FieldClass = FlowField;
        }
        field(50049; "Vendor Invoice Date"; Date)
        {
            CalcFormula = Lookup("Purch. Inv. Header"."Vendor Invoice Date" WHERE("No." = FIELD("Document No.")));
            Description = 'Track';
            Enabled = false;
            FieldClass = FlowField;
        }
        field(50050; "Vendor Shipment No."; Code[20])
        {
            CalcFormula = Lookup("Purch. Inv. Header"."Vendor Shipment No." WHERE("No." = FIELD("Document No.")));
            Enabled = false;
            FieldClass = FlowField;
        }
        field(50051; "Vendor Shipment Date"; Date)
        {
            // 15578CalcFormula = Lookup("Purch. Inv. Header"."Vendor Shipment Date" WHERE("No." = FIELD("Document No.")));
            Enabled = false;
            // FieldClass = FlowField;
        }
        field(50052; "Entry No. 3.7"; Integer)
        {
        }
        field(50053; "Closed By Entry No. 3.7"; Integer)
        {
        }
        field(50054; "Closed By Amount 3.7"; Decimal)
        {
            Editable = false;
        }
        field(50055; Narration; Text[150])
        {
            CalcFormula = Lookup("Posted Narration".Narration WHERE("Transaction No." = FIELD("Transaction No."),
                                                                     "Entry No." = FILTER(0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50056; "TDS Amount"; Decimal)
        {
            CalcFormula = Sum("TDS Entry"."Total TDS Including SHE CESS" WHERE("Document No." = FIELD("Document No."),
                                                                                "Posting Date" = FIELD("Posting Date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50057; "Line Narration"; Text[150])
        {
            CalcFormula = Lookup("Posted Narration".Narration WHERE("Entry No." = FIELD("Entry No."),
                                                                     "Transaction No." = FIELD("Transaction No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50058; "Concurrent Balance"; Decimal)
        {
            Description = 'TSPL SA';
        }
        field(50090; "Form C No."; Code[15])
        {
        }
        field(50091; "Form C Amt"; Decimal)
        {
        }
        field(50092; "Service Tax Amount"; Decimal)
        {
            /*   CalcFormula = Lookup("Service Tax Entry"."Service Tax Amount" WHERE("Document No." = FIELD("Document No."),
                                                                                    "Posting Date" = FIELD("Posting Date")));*/ // 15578
            Enabled = false;
            // FieldClass = FlowField;
        }
        field(50093; "Return Shipment No."; Code[20])
        {
            CalcFormula = Lookup("Purch. Cr. Memo Hdr."."Vendor Invoice No." WHERE("No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50094; "KKC Amount"; Decimal)
        {
            /* CalcFormula = Lookup("Service Tax Entry"."KK Cess Amount" WHERE("Document No." = FIELD("Document No."),
                                                                              "Posting Date" = FIELD("Posting Date")));*/ // 15578
            Enabled = false;
            // FieldClass = FlowField;
        }
        field(50095; "SBC Amount"; Decimal)
        {
            /*   CalcFormula = Lookup("Service Tax Entry"."Service Tax SBC Amount" WHERE("Document No." = FIELD("Document No."),
                                                                                        "Posting Date" = FIELD("Posting Date")));*/ // 15578
            Enabled = false;
            // FieldClass = FlowField;
        }
        field(50100; "Total GST Amount"; Decimal)
        {
            CalcFormula = Sum("Detailed GST Ledger Entry"."GST Amount" WHERE("Document No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50101; Comment; Text[250])
        {
        }
        field(50102; "Updated in Staging"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'EYAIM';
        }
        field(60028; NOE; Code[15])
        {
            CalcFormula = Lookup("Purch. Inv. Header".NOE WHERE("No." = FIELD("Document No."),
                                                                 "Posting Date" = FIELD("Posting Date")));
            Description = 'MSVRN 060918';
            FieldClass = FlowField;
        }
        field(60029; Matched; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'EYAIM';
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Vendor No.,Entry No.,Open,Document Type,GST on Advance Payment,GST Group Code"(Key)".

        /*   key(Key26; "Vendor No.", Year, Month, "Posting Date")
           {
           }
           key(Key27; "Document Type", "Entry No. 3.7", Open)
           {
           }*/
        key(Key28; "Vendor No.")
        {
        }
        key(Key29; "Closed by Entry No.", "Posting Date")
        {
        }
        key(Key30; "Document No.", "Document Type", "Buy-from Vendor No.")
        {
        }
        key(Key31; "Document Type", "Document No."/* "TDS Nature of Deduction", "TDS Group"*/)
        {
        }
    }


    //Unsupported feature: Code Modification on "CalcAppliedTDSBase(PROCEDURE 1500002)".// Function N/F

    //procedure CalcAppliedTDSBase();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CALCFIELDS(Amount);
    IF Amount = 0 THEN
      EXIT(0);
    TDSEntry.SETRANGE("Transaction No.","Transaction No.");
    TDSEntry.SETRANGE("TDS Nature of Deduction",TDSNatureofDeduction);
    IF TDSEntry.FINDSET THEN
      REPEAT
        IF TDSEntry."TDS Base Amount" = 0 THEN
          TDSBaseAmount += TDSEntry."Work Tax Base Amount"
        ELSE
          TDSBaseAmount += TDSEntry."TDS Base Amount";
      UNTIL TDSEntry.NEXT = 0;

    IF TDSEntry."TDS Line Amount" > TDSBaseAmount THEN
      IF ABS(AppliedAmount) >= TDSBaseAmount THEN
        ApplicationRatio := 1
      ELSE
        ApplicationRatio := ABS(TDSBaseAmount - AppliedAmount) / TDSBaseAmount
    ELSE
      IF ABS(AppliedAmount) >= TDSBaseAmount THEN
        ApplicationRatio := 1
      ELSE
        ApplicationRatio := ABS(AppliedAmount) / TDSBaseAmount;

    EXIT(ROUND(TDSBaseAmount * ApplicationRatio));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    TDSEntry.SETCURRENTKEY("Transaction No.");
    #4..9
        ELSE BEGIN // >>ALLE.TDS-REGEF START
          IF TDSEntry."Calc. Over & Above Threshold" THEN BEGIN
            IF TDSEntry."TDS Base Amount" < TDSEntry."Invoice Amount" THEN
              TDSBaseAmount += TDSEntry."Invoice Amount"
        ELSE
          TDSBaseAmount += TDSEntry."TDS Base Amount";
          END ELSE // <<ALLE.TDS-REGEF STOP
            TDSBaseAmount += TDSEntry."TDS Base Amount";
        END;
    #12..19
    IF ABS(AppliedAmount) >= TDSBaseAmount THEN
      ApplicationRatio := 1
    ELSE
      ApplicationRatio := ABS(AppliedAmount) / TDSBaseAmount;

    EXIT(ROUND(TDSBaseAmount * ApplicationRatio));
    */
    //end;


    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 6)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Vendor No." := GenJnlLine."Account No.";
    "Posting Date" := GenJnlLine."Posting Date";
    "Document Date" := GenJnlLine."Document Date";
    "Document Type" := GenJnlLine."Document Type";
    "Document No." := GenJnlLine."Document No.";
    "External Document No." := GenJnlLine."External Document No.";
    Description := GenJnlLine.Description;
    "Currency Code" := GenJnlLine."Currency Code";
    "Purchase (LCY)" := GenJnlLine."Sales/Purch. (LCY)";
    "Inv. Discount (LCY)" := GenJnlLine."Inv. Discount (LCY)";
    "Buy-from Vendor No." := GenJnlLine."Sell-to/Buy-from No.";
    "Vendor Posting Group" := GenJnlLine."Posting Group";
    "Global Dimension 1 Code" := GenJnlLine."Shortcut Dimension 1 Code";
    "Global Dimension 2 Code" := GenJnlLine."Shortcut Dimension 2 Code";
    "Dimension Set ID" := GenJnlLine."Dimension Set ID";
    #16..27
    "Bal. Account No." := GenJnlLine."Bal. Account No.";
    "No. Series" := GenJnlLine."Posting No. Series";
    "IC Partner Code" := GenJnlLine."IC Partner Code";
    Prepayment := GenJnlLine.Prepayment;
    "Recipient Bank Account" := GenJnlLine."Recipient Bank Account";
    "Message to Recipient" := GenJnlLine."Message to Recipient";
    #34..79
        ELSE
          "GST Reverse Charge" := GenJnlLine."GST Group Type" = GenJnlLine."GST Group Type"::Service;

    "Location GST Reg. No." := GenJnlLine."Location GST Reg. No.";
    "Provisional Entry" := GenJnlLine."Provisional Entry";
    OnAfterCopyVendLedgerEntryFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    Description := GenJnlLine.Narration;
    Description2 := GenJnlLine.Description2; //Vipul Tri1.0 //Team 7739 Upgrade 08062016
    #8..12
    //Team 7739 Upgrade 08062016 Start-
    //TRI
    "Entry No. 3.7" := GenJnlLine."Entry No. 3.7";
    "Closed By Entry No. 3.7" := GenJnlLine."Closed By Entry No. 3.7";
    "Closed By Amount 3.7" := GenJnlLine."Closed By Amount 3.7";
    //TRI
    //Team 7739 Upgrade 08062016 End-
    #13..30
    //Team 7739 Upgrade 08062016 Start-
    "Cheque No.":=GenJnlLine."Cheque No.";
    "Cheque Date":=GenJnlLine."Cheque Date";
    //Team 7739 Upgrade 08062016 End-
    #31..82
    Comment :=  GenJnlLine.Comment; //MS
    #83..85
    */
    //end;
}

