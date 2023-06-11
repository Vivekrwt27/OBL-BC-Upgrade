tableextension 50129 tableextension50129 extends "G/L Entry"
{
    // 
    // 
    // 1. TRI KARAN 02.09.10 - "Posting Date" Added in Existing Key "System-Created Entry,G/L Account No."
    // 2.Team 7739 Upgrade 08062016

    //Unsupported feature: Property Insertion (Permissions) on ""G/L Entry"(Table 17)".

    fields
    {

        //Unsupported feature: Property Modification (Data type) on "Description(Field 7)".


        //Unsupported feature: Property Modification (Data type) on ""External Document No."(Field 56)".

        field(50000; "Doc Type"; Option)
        {
            CalcFormula = Lookup("Item Ledger Entry"."Entry Type" WHERE("Document No." = FIELD("Document No.")));
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output;
        }
        field(50001; "Description 2"; Text[200])
        {
            Editable = false;
        }
        field(50002; FYear; Integer)
        {
        }
        field(50003; "Inventory Posting Group"; Code[10])
        {
        }
        field(50004; Reversal; Boolean)
        {
            Description = 'TRI KKS';
        }
        field(50005; "Issuing Bank"; Text[100])
        {
            Editable = false;
        }
        field(50055; Narration; Text[150])
        {
            CalcFormula = Lookup("Posted Narration".Narration WHERE("Entry No." = FILTER(0),
                                                                     "Transaction No." = FIELD("Transaction No.")));
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
        }
        field(50056; "Line Narration"; Text[150])
        {
            CalcFormula = Lookup("Posted Narration".Narration WHERE("Entry No." = FIELD("Entry No."),
                                                                     "Transaction No." = FIELD("Transaction No.")));
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
        }
        field(50057; "Export Reference No."; Text[30])
        {
            Description = 'ORI UT';
        }
        field(50058; "NOE Code"; Code[15])
        {
            CalcFormula = Lookup("Purch. Inv. Line".NOE WHERE("Document No." = FIELD("Document No."),
                                                               "No." = FILTER(<> '')));
            Enabled = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key14; "Document No.", "G/L Account No.", "Posting Date", Amount)
        {
        }
        key(Key15; "Source Code", "G/L Account No.")
        {
            SumIndexFields = Amount;
        }
        key(Key16; "System-Created Entry", "G/L Account No.", "Posting Date")
        {
            SumIndexFields = Amount;
        }
        key(Key17; "Posting Date")
        {
            SumIndexFields = Amount;
        }
        key(Key18; "G/L Account No.")
        {
            SumIndexFields = "Debit Amount", "Credit Amount";
        }

        //Unsupported feature: Move on ""Transaction No."(Key)".

    }

    //Unsupported feature: Variable Insertion (Variable: DimSetTemp) (VariableCollection) on "CopyFromGenJnlLine(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: LocRec) (VariableCollection) on "CopyFromGenJnlLine(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: MadeChange) (VariableCollection) on "CopyFromGenJnlLine(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: SlaesInv) (VariableCollection) on "CopyFromGenJnlLine(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: LocationRec) (VariableCollection) on "CopyFromGenJnlLine(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: PurchInv) (VariableCollection) on "CopyFromGenJnlLine(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: TSH) (VariableCollection) on "CopyFromGenJnlLine(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: TRH) (VariableCollection) on "CopyFromGenJnlLine(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 4)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Posting Date" := GenJnlLine."Posting Date";
    "Document Date" := GenJnlLine."Document Date";
    "Document Type" := GenJnlLine."Document Type";
    "Document No." := GenJnlLine."Document No.";
    "External Document No." := GenJnlLine."External Document No.";
    Description := GenJnlLine.Description;
    "Business Unit Code" := GenJnlLine."Business Unit Code";
    "Tax Type" := GenJnlLine."Tax Type";
    "Global Dimension 1 Code" := GenJnlLine."Shortcut Dimension 1 Code";
    "Global Dimension 2 Code" := GenJnlLine."Shortcut Dimension 2 Code";
    #11..24
    Quantity := GenJnlLine.Quantity;
    "Journal Batch Name" := GenJnlLine."Journal Batch Name";
    "Reason Code" := GenJnlLine."Reason Code";
    "User ID" := USERID;
    "No. Series" := GenJnlLine."Posting No. Series";
    "IC Partner Code" := GenJnlLine."IC Partner Code";
    "Location Code" := GenJnlLine."Location Code";
    IF GenJnlLine."GST in Journal" THEN BEGIN
      "Gen. Bus. Posting Group" := GenJnlLine."Gen. Bus. Posting Group";
      "Gen. Prod. Posting Group" := GenJnlLine."Gen. Prod. Posting Group";
    END;

    OnAfterCopyGLEntryFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    Description := GenJnlLine.Narration;
    "Description 2" := GenJnlLine.Description2;  //Vipul Tri1.0 -Team 7739 Upgrade 08062016
    "Business Unit Code" := GenJnlLine."Business Unit Code";
    //
    IF GenJnlLine."Check Printed" = TRUE THEN BEGIN
      GenJnlLine."Check Printed" := FALSE;
      MadeChange := TRUE;
    END;



    {IF GenJnlLine."Location Code" <> '' THEN BEGIN
      IF LocationRec.GET(GenJnlLine."Location Code") THEN;
      GenJnlLine.VALIDATE("Shortcut Dimension 1 Code",LocationRec."Location Dimension");
    END ELSE }

    IF SlaesInv.GET(GenJnlLine."Document No.") THEN
      GenJnlLine.VALIDATE("Shortcut Dimension 1 Code",SlaesInv."Shortcut Dimension 1 Code");

    IF PurchInv.GET(GenJnlLine."Document No.") THEN
      GenJnlLine.VALIDATE("Shortcut Dimension 1 Code",PurchInv."Shortcut Dimension 1 Code");

    IF TSH.GET(GenJnlLine."Document No.") THEN
      GenJnlLine.VALIDATE("Shortcut Dimension 1 Code",TSH."Shortcut Dimension 1 Code");

    IF TRH.GET(GenJnlLine."Document No.") THEN
      GenJnlLine.VALIDATE("Shortcut Dimension 1 Code",TRH."Shortcut Dimension 1 Code");

    //6700

    IF MadeChange THEN
      GenJnlLine."Check Printed" := TRUE;
    //
    #8..27
    "Issuing Bank" := GenJnlLine."Issuing Bank";//TRI S.R 150310 - New code Add-Team 7739 Upgrade 08062016
    #28..31
    "Export Reference No.":=GenJnlLine."Export Reference No.";//Ori ut-Team 7739 Upgrade 08062016
    #32..37
    */
    //end;
}

