tableextension 50134 tableextension50134 extends "Cust. Ledger Entry"
{
    // Team 7739 Upgrade 0806201
    fields
    {

        //Unsupported feature: Property Modification (Data type) on "Description(Field 7)".

        /* modify("TDS Group")
         {
             OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others,Goods';

             //Unsupported feature: Property Modification (OptionString) on ""TDS Group"(Field 13703)".

         }*/ // 15578

        modify("Due Date")// 15578
        {
            trigger OnBeforeValidate()
            begin
                TESTFIELD(Open, TRUE);
                IF "Due Date" <> xRec."Due Date" THEN BEGIN

                    UserSetup.RESET;
                    UserSetup.SETFILTER("User ID", USERID);
                    IF UserSetup.FIND('-') THEN BEGIN
                        IF NOT UserSetup."IC Posting" THEN
                            ERROR('You cannot change the Due Date. Please contact your system administrator.');
                    END;
                end;
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
        field(50043; "Dealer Code"; Code[20])
        {
            Description = 'TRI';
            TableRelation = "Salesperson/Purchaser".Code WHERE("Customer No." = FILTER(<> ''));
        }
        field(50044; "Dealer's Salesperson Code"; Code[20])
        {
            Description = 'TRI';
            TableRelation = "Salesperson/Purchaser".Code WHERE("Customer No." = FILTER(= ''));
        }
        field(50045; Month; Integer)
        {
            Description = 'Tri18.1PG For Multi Balancing Option In Customer Ledger';
        }
        field(50046; Year; Integer)
        {
            Description = 'Tri18.1PG For Multi Balancing Option In Customer Ledger';
        }
        field(50047; FYEAR; Integer)
        {
            Description = 'Tri18.1PG For Multi Balancing Option In Customer Ledger';
        }
        field(50048; "Entry No. 3.7"; Integer)
        {
        }
        field(50049; "Closed By Entry No. 3.7"; Integer)
        {
        }
        field(50050; "Closed By Amount 3.7"; Decimal)
        {
            Editable = false;
        }
        field(50055; Narration; Text[150])
        {
            CalcFormula = Lookup("Posted Narration".Narration WHERE("Entry No." = FIELD("Entry No."),
                                                                     "Transaction No." = FIELD("Transaction No."),
                                                                     "Entry No." = FILTER(0)));
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
        field(50058; "Cash Discount"; Decimal)
        {
            /* CalcFormula = Sum("Posted Str Order Line Details".Amount WHERE(Type = FILTER(Sale),
                                                                             "Invoice No." = FIELD("Document No."),
                                                                             "Tax/Charge Group" = FILTER(DISCOUNT)));*/ // 15578
            Description = 'TRI V.D 16.09.10 New Field Added';
            Editable = false;
            // FieldClass = FlowField;
        }
        field(50059; "Ship To Name"; Text[50])
        {
            CalcFormula = Lookup("Sales Invoice Header"."Ship-to Name" WHERE("No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50060; "Ship To Address"; Text[50])
        {
            CalcFormula = Lookup("Sales Invoice Header"."Ship-to Address" WHERE("No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50061; "Ship To Address2"; Text[50])
        {
            CalcFormula = Lookup("Sales Invoice Header"."Ship-to Address 2" WHERE("No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50062; "Ship To City"; Text[30])
        {
            CalcFormula = Lookup("Sales Invoice Header"."Ship-to City" WHERE("No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50063; "Cust Type"; Code[20])
        {
            CalcFormula = Lookup(Customer."Customer Type" WHERE("No." = FIELD("Customer No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50065; "Additional Ins Discount"; Decimal)
        {
            /* CalcFormula = Sum("Posted Str Order Line Details".Amount WHERE(Type = FILTER(Sale),
                                                                             "Invoice No." = FIELD("Document No."),
                                                                             "Tax/Charge Group" = FILTER(ADDINSDISC)));*/ // 15578
            Description = 'TRI V.D 16.09.10 New Field Added';
            Editable = false;
            // FieldClass = FlowField;
        }
        field(50066; "Bill To Address"; Text[50])
        {
            CalcFormula = Lookup(Customer.Address WHERE("No." = FIELD("Customer No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50067; "Bill To Address 2"; Text[50])
        {
            CalcFormula = Lookup(Customer."Address 2" WHERE("No." = FIELD("Customer No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50068; "Bill To City"; Text[30])
        {
            CalcFormula = Lookup(Customer.City WHERE("No." = FIELD("Customer No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50069; CashDiscountDebitFlag; Boolean)
        {
        }
        field(50070; DebitAmtOnCashDisc; Decimal)
        {
        }
        field(50071; DebitInvNo; Code[25])
        {
        }
        field(50072; AutoDebitCheckFlag; Boolean)
        {
        }
        field(50073; DebitCheckStateFlag; Boolean)
        {
        }
        field(50074; DebitSuspFlag; Boolean)
        {
        }
        field(50075; "Chain Name"; Code[20])
        {
            CalcFormula = Lookup(Customer."Chain Name" WHERE("No." = FIELD("Customer No.")));
            FieldClass = FlowField;
        }
        field(50076; "Customer State"; Code[30])
        {
            CalcFormula = Lookup(Customer."State Code" WHERE("No." = FIELD("Customer No.")));
            FieldClass = FlowField;
        }
        field(50077; "Total GST Amount"; Decimal)
        {
            CalcFormula = Sum("Detailed GST Ledger Entry"."GST Amount" WHERE("Document No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50078; Comment; Text[250])
        {
        }
        field(50079; "Not Enclude CFORM"; Boolean)
        {
            Description = 'Used for Debotor Ageing Sent Report  to MGMT.';
        }
        field(50080; Set; Boolean)
        {
        }
        field(50081; Pet; Boolean)
        {
        }
        field(50082; "Get."; Boolean)
        {
        }
        field(50083; "Entry Skipped"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50085; "TCS On Collection Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50086; "TCS Amount"; Decimal)
        {
            /* CalcFormula = Sum("Sales Invoice Line"."TDS/TCS Amount" WHERE("Document No." = FIELD("Document No."),
                                                                            "Posting Date" = FIELD("Posting Date"),
                                                                            Quantity = FILTER(<> 0)));*/ // 15578
            // FieldClass = FlowField;
        }
        field(50087; "Sales Territory"; Code[20])
        {
            CalcFormula = Lookup(Customer."Area Code" WHERE("No." = FIELD("Customer No.")));
            FieldClass = FlowField;
        }
        field(90001; "Last Payment Receipt Date"; Date)
        {
            CalcFormula = Max("Detailed Cust. Ledg. Entry"."Posting Date" WHERE("Document Type" = FILTER(Payment),
                                                                                 Amount = FILTER(< -10),
                                                                                 "Cust. Ledger Entry No." = FIELD("Entry No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key37; "Closed by Entry No.", "Posting Date")
        {
        }
        /*  key(Key37; "Dealer Code", "Dealer's Salesperson Code", "Customer No.")
          {
          }
          key(Key38; "Customer No.", Year, Month, "Posting Date")
          {
          }
          key(Key39; "Document Type", "Entry No. 3.7", Open)
          {
          }*/
        key(Key40; "Posting Date", "Document Type")
        {
        }
        key(Key41; "Posting Date", "Document Type", "Document No.")
        {
        }
        key(Key42; "Customer No.", "Posting Date", "Document No.")
        {
        }
        key(Key43; "Due Date")
        {
        }
        key(Key44; DebitInvNo)
        {
        }
    }

    //Unsupported feature: Variable Insertion (Variable: SalesInvHead) (VariableCollection) on "CopyFromGenJnlLine(PROCEDURE 6)".



    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 6)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Customer No." := GenJnlLine."Account No.";
    "Posting Date" := GenJnlLine."Posting Date";
    "Document Date" := GenJnlLine."Document Date";
    "Document Type" := GenJnlLine."Document Type";
    "Document No." := GenJnlLine."Document No.";
    "External Document No." := GenJnlLine."External Document No.";
    Description := GenJnlLine.Description;
    "Currency Code" := GenJnlLine."Currency Code";
    "Sales (LCY)" := GenJnlLine."Sales/Purch. (LCY)";
    "Profit (LCY)" := GenJnlLine."Profit (LCY)";
    "Inv. Discount (LCY)" := GenJnlLine."Inv. Discount (LCY)";
    "Sell-to Customer No." := GenJnlLine."Sell-to/Buy-from No.";
    #13..29
    "Bal. Account No." := GenJnlLine."Bal. Account No.";
    "No. Series" := GenJnlLine."Posting No. Series";
    "IC Partner Code" := GenJnlLine."IC Partner Code";
    Prepayment := GenJnlLine.Prepayment;
    "Recipient Bank Account" := GenJnlLine."Recipient Bank Account";
    "Message to Recipient" := GenJnlLine."Message to Recipient";
    "Applies-to Ext. Doc. No." := GenJnlLine."Applies-to Ext. Doc. No.";
    "Payment Method Code" := GenJnlLine."Payment Method Code";
    "Exported to Payment File" := GenJnlLine."Exported to Payment File";
    "TDS Group" := GenJnlLine."TDS Group";
    "TDS Nature of Deduction" := GenJnlLine."TDS Nature of Deduction";
    IF NOT GenJnlLine."TDS Certificate Receivable" THEN
      "Total TDS/TCS Incl SHE CESS" := GenJnlLine."Total TDS/TCS Incl. SHE CESS"
    ELSE
    #44..85
        END;
    END;
    "GST Customer Type" := GenJnlLine."GST Customer Type";
    "Location GST Reg. No." := GenJnlLine."Location GST Reg. No.";
    OnAfterCopyCustLedgerEntryFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    Description := GenJnlLine.Narration;
    Description2 := GenJnlLine.Description2; //Vipul Tri1.0 //Team 7739 Upgrade 08062016
    "Currency Code" := GenJnlLine."Currency Code";
    "Sales (LCY)" := GenJnlLine."Sales/Purch. (LCY)";
    //Team 7739 Upgrade 08062016 Start-
    //TRI
    "Entry No. 3.7" := GenJnlLine."Entry No. 3.7";
    "Closed By Entry No. 3.7" := GenJnlLine."Closed By Entry No. 3.7";
    "Closed By Amount 3.7" := GenJnlLine."Closed By Amount 3.7";
    //TRI
    //Team 7739 Upgrade 08062016 End-
    #10..32
    //Team 7739 Upgrade 08062016 Start-
    "Cheque No.":=GenJnlLine."Cheque No.";
    "Cheque Date":=GenJnlLine."Cheque Date";
    //Team 7739 Upgrade 08062016 End-
    #33..40
    //Team 7739 Upgrade 08062016 Start-
    IF "Dealer Code" = '' THEN BEGIN
      IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice THEN
        IF SalesInvHead.GET("Document No.") THEN
          "Dealer Code":=SalesInvHead."Dealer Code"
    END ELSE
      "Dealer Code":=GenJnlLine."Dealer Code";
    "Dealer's Salesperson Code":=GenJnlLine."Dealer's Salesperson Code";
    //Team 7739 Upgrade 08062016 End-
    #41..88
    Comment :=   GenJnlLine.Comment; //MS
    "Location GST Reg. No." := GenJnlLine."Location GST Reg. No.";
    OnAfterCopyCustLedgerEntryFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;

    var
        UserSetup: Record "User Setup";
}

