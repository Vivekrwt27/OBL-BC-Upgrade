table 50085 "Capex Entry"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Purchase Order,Invoice';
            OptionMembers = "Purchase Order",Invoice;
        }
        field(10; "Capex No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Order,Invoice,Credit Memo';
            OptionMembers = "Order",Invoice,"Credit Memo";
        }
        field(40; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(60; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        }
        field(70; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(80; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(90; Rate; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(100; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(120; "Total GST Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(130; "Other Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(140; "Amount to Vendor"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(150; "Invoice Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(160; "Capex Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    procedure GetLastEntryNo(): Integer
    var
        CapexEntry: Record "Capex Entry";
    begin
        CapexEntry.RESET;
        IF CapexEntry.FINDLAST THEN
            EXIT(CapexEntry."Entry No." + 1)
        ELSE
            EXIT(1);
    end;

    procedure GenerateCapexEntry(ISPurchCrMemo: Boolean; PurchInvLine: Record "Purch. Inv. Line"; PurchCrMemoLine: Record "Purch. Cr. Memo Line")
    var
        LineNo: Integer;
        CapexEntry: Record "Capex Entry";
    begin
        IF ISPurchCrMemo THEN BEGIN
            WITH PurchCrMemoLine DO BEGIN
                LineNo := GetLastEntryNo;
                REPEAT
                    CapexEntry.INIT;
                    CapexEntry."Document Type" := CapexEntry."Document Type"::"Credit Memo";
                    CapexEntry."Document No." := PurchCrMemoLine."Document No.";
                    CapexEntry."Document Line No." := PurchCrMemoLine."Line No.";
                    CapexEntry.Type := PurchCrMemoLine.Type;
                    CapexEntry."No." := PurchCrMemoLine."No.";
                    CapexEntry.Quantity := PurchCrMemoLine.Quantity;
                    CapexEntry.Rate := PurchCrMemoLine."Direct Unit Cost";
                    // CapexEntry."Total GST Amount" := PurchCrMemoLine."Total GST Amount";//16225 TABLE FIELD N/F
                    //  CapexEntry."Amount to Vendor" := PurchCrMemoLine."Amount To Vendor";//16225 TABLE FIELD N/F
                    //  CapexEntry."Other Charges" := PurchCrMemoLine."Amount To Vendor" - (PurchCrMemoLine.Quantity * PurchCrMemoLine."Direct Unit Cost") - PurchCrMemoLine."Total GST Amount";//16225 TABLE FIELD N/F
                    CapexEntry."Capex No." := '';
                    CapexEntry."Location Code" := PurchCrMemoLine."Location Code";
                    CapexEntry."Posting Date" := PurchCrMemoLine."Posting Date";
                    CapexEntry."Entry No." := LineNo;
                    CapexEntry.INSERT;
                    LineNo += 1;
                UNTIL PurchCrMemoLine.NEXT = 0;
            END;
        END ELSE BEGIN
            WITH PurchInvLine DO BEGIN
                LineNo := GetLastEntryNo;
                REPEAT
                    CapexEntry.INIT;
                    CapexEntry."Document Type" := CapexEntry."Document Type"::"Credit Memo";
                    CapexEntry."Document No." := PurchInvLine."Document No.";
                    CapexEntry."Document Line No." := PurchInvLine."Line No.";
                    CapexEntry.Type := PurchInvLine.Type;
                    CapexEntry."No." := PurchInvLine."No.";
                    CapexEntry.Quantity := PurchInvLine.Quantity;
                    CapexEntry.Rate := PurchInvLine."Direct Unit Cost";
                    //CapexEntry."Total GST Amount" := PurchInvLine."Total GST Amount";
                    // CapexEntry."Amount to Vendor" := PurchInvLine."Amount To Vendor";
                    //CapexEntry."Other Charges" := PurchInvLine."Amount To Vendor" - (PurchInvLine.Quantity * PurchInvLine."Direct Unit Cost") - PurchInvLine."Total GST Amount";
                    CapexEntry."Capex No." := '';
                    CapexEntry."Location Code" := PurchInvLine."Location Code";
                    CapexEntry."Posting Date" := PurchInvLine."Posting Date";
                    CapexEntry."Entry No." := LineNo;
                    CapexEntry.INSERT;
                    LineNo += 1;
                UNTIL PurchInvLine.NEXT = 0;
            END;


        END;
    end;

    procedure CreateCapexEntry(EntryTyp: Option "Purchase Order",Invoice; CapexNo: Code[50]; LocCode: Code[10]; PostingDt: Date; DocTyp: Option "Order",Invoice,"Credit Memo"; DocNo: Code[50]; DocLineNo: Decimal; Typ: Option " ","G/L Account",Item,,"Fixed Asset","Charge (Item)"; No: Text; Qty: Decimal; Rate: Decimal; Amt: Decimal; AmtToVendor: Decimal; TotGSTAmount: Decimal; OthChrg: Decimal; InvAmt: Decimal; CapexAmt: Decimal)
    var
        CapexEntry: Record "Capex Entry";
    begin
        CapexEntry.INIT();
        CapexEntry."Entry No." := GetLastEntryNo();
        CapexEntry."Entry Type" := EntryTyp;
        CapexEntry."Capex No." := CapexNo;
        CapexEntry."Location Code" := LocCode;
        CapexEntry."Posting Date" := PostingDt;
        CapexEntry."Document Type" := DocTyp;
        CapexEntry."Document No." := DocNo;
        CapexEntry."Document Line No." := DocLineNo;
        CapexEntry.Type := Typ;
        CapexEntry."No." := No;
        CapexEntry.Quantity := Qty;
        CapexEntry.Rate := Rate;
        CapexEntry.Amount := Amt;
        CapexEntry."Total GST Amount" := TotGSTAmount;
        CapexEntry."Other Charges" := OthChrg;
        CapexEntry."Amount to Vendor" := AmtToVendor;
        CapexEntry."Invoice Amount" := InvAmt;
        CapexEntry."Capex Amount" := CapexAmt;
        CapexEntry.INSERT();
    end;
}

