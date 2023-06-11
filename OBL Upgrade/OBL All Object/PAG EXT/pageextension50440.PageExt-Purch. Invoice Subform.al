pageextension 50440 pageextension50440 extends "Purch. Invoice Subform"
{
    layout
    {
        /* modify("Invoice Discount Amount")
         {
             Visible = false;
         }*/
        modify("Invoice Disc. Pct.")
        {
            Visible = false;
        }
        addfirst(Control15)
        {
            field("Document Type"; Rec."Document Type")
            {
                ApplicationArea = All;
            }
        }
        moveafter(Type; "Document No.", "GST Credit", "GST Group Code", "GST Group Type", "HSN/SAC Code", "GST Assessable Value"
        , "Tax Area Code", "Tax Liable", "Tax Group Code")
        addafter(Type)
        {
            field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
            {
                ApplicationArea = All;
            }
            field("PO Status"; PoStatus)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Quantity Invoiced"; Rec."Quantity Invoiced")
            {
                ApplicationArea = All;
            }
            field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
            {
                ApplicationArea = All;
            }
            field(Amount; Rec.Amount)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("ITC Type"; Rec."ITC Type")
            {
                ApplicationArea = All;
            }
            field("Excise Amount Per Unit"; Rec."Excise Amount Per Unit")
            {
                ApplicationArea = All;
            }
            field("Source Order No."; Rec."Source Order No.")
            {
                ApplicationArea = All;
            }
            field("Orient MRP"; Rec."Orient MRP")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Capex No."; Rec."Capex No.")
            {
                ApplicationArea = All;
            }
            //16225 Table field N/F Start

            /* field("Assessable Value"; "Assessable Value")
             {
             }
             field("Tax %"; "Tax %")
             {
                 Editable = false;
             }
             field("Tax Base Amount"; "Tax Base Amount")
             {
                 Editable = true;
             }
            field("Service Tax Amount"; "Service Tax Amount")
            {
            }
            field("Service Tax SBC Amount"; "Service Tax SBC Amount")
            {
            }
            field("KK Cess Amount"; "KK Cess Amount")
            {
            }
            field("Tax Amount"; "Tax Amount")
            {
                Editable = false;
                Enabled = true;
            }
            field("TDS Category"; "TDS Category")
            {
            }

            field("GST Base Amount"; "GST Base Amount")
            {
            }
            field("GST %"; "GST %")
            {
            }
            field("Total GST Amount"; "Total GST Amount")
            {
            }
            field("TDS Group"; "TDS Group")
            {
            }
            field("Excise Accounting Type"; "Excise Accounting Type")
            {
            }
            field("Excise Bus. Posting Group"; "Excise Bus. Posting Group")
            {
            }
            field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")
            {
            }
            field("Capital Item"; "Capital Item")
            {
            }
    
            field("Assessee Code"; "Assessee Code")
            {
            }
            field("TDS Nature of Deduction"; "TDS Nature of Deduction")
            {
            }
            field("TDS Amount"; "TDS Amount")
            {
                Editable = false;
            }
            field("TDS %"; "TDS %")
            {
                Editable = true;
            }*/
            //16225 Table field N/F End
        }

        addafter("No.")
        {
            field("Qty. to Invoice"; Rec."Qty. to Invoice")
            {
                ApplicationArea = All;
            }
            /*
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
             field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
             {
                 ApplicationArea = all;
             } */

        }
        // moveafter("Gen. Bus. Posting Group"; "Gen. Prod. Posting Group")
        //16225 Table Field N/F
        /* addafter("Control 72") 
         {
             field("Service Tax Group"; "Service Tax Group")
             {
             }
         }
         addafter("Control 186")
         {
             field("Form Code"; "Form Code")
             {
             }
             field("Form No."; "Form No.")
             {
             }
         }*/
        moveafter(Description; "Description 2", "Nature of Remittance", "Act Applicable")
        // moveafter("TDS Nature of Deduction"; )
        /*    addafter("TDS Nature of Deduction")
            {

                field("Country Code"; "Country Code")//16225 Table field N/F
                {
                    Visible = false;
                }
            }*/
        addafter("Shortcut Dimension 1 Code")
        {
            field(NOE; Rec.NOE)
            {
                ApplicationArea = All;
            }
        }
        /*    addafter("Control 310")
            {
                field("CWIP G/L Type"; "CWIP G/L Type")//16225 Table field N/F
                {
                    Visible = false;
                }
            }*/
        moveafter("Line No."; "IC Partner Ref. Type", "Custom Duty Amount", Exempted, "Job No.", "Job Task No.", "Job Line Type"
        , "Job Unit Price", "Job Line Amount", "Job Line Discount Amount", "Job Line Discount %", "Job Total Price", "Job Unit Price (LCY)"
        , "Job Line Amount (LCY)", "Job Line Disc. Amount (LCY)", "Deferral Code")
        addafter("Line No.")
        {
            field("Receipt No."; Rec."Receipt No.")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("Receipt Line No."; Rec."Receipt Line No.")
            {
                Editable = false;
                ApplicationArea = All;
            }

            field("PO No."; Rec."PO No.")
            {
                ApplicationArea = All;

                trigger OnValidate()

                begin
                    //MSVRN 160419 >>
                    PurchHeader.RESET;
                    PurchHeader.SETRANGE("No.", Rec."PO No.");
                    IF PurchHeader.FINDFIRST THEN
                        Rec.VALIDATE(NOE, PurchHeader.NOE);
                    //MSVRN 160419 <<
                end;
            }
        }
    }
    actions
    {
        addafter(GetReceiptLines)
        {
            action("Detailed GST Entry Buffer")
            {
                Caption = 'Detailed GST Entry Buffer';
                RunObject = Page "Detailed GST Entry Buffer";
                RunPageLink = "Document No." = FIELD("Document No.");
                ShortCutKey = 'Ctrl+g';
                ApplicationArea = All;
            }
        }
        addafter("Detailed GST Entry Buffer")
        {
            action(Orders)
            {
                Caption = 'Orders';
                Image = Document;
                RunObject = Page "Purchase Orders";
                RunPageLink = Type = CONST(Item),
                              "No." = FIELD("No.");
                RunPageView = SORTING("Document Type", Type, "No.");
                ShortCutKey = 'Ctrl+O';
                ApplicationArea = All;
            }
        }
    }

    var
        PurchHeader: Record "Purchase Header";
        [InDataSet]
        PoStatus: Text;

    trigger OnAfterGetRecord()
    begin
        GetPOStatus;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        GetPOStatus;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GetPOStatus;
    end;


    local procedure ValidateSaveShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        Rec.ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
        CurrPage.SAVERECORD;
    end;

    local procedure GetPOStatus()
    var
        PurchaseHeader: Record "Purchase Header";
        RecPurchReceptHeader: Record "Purch. Rcpt. Header";
    begin
        PoStatus := '';
        IF Rec."Source Order No." <> '' THEN BEGIN
            IF PurchaseHeader.GET(Rec."Document Type"::Order, Rec."Source Order No.") THEN BEGIN
                PoStatus := FORMAT(PurchaseHeader."Approval Status");
            END;
        END;

        //TEAM 14763
        Clear(PoStatus);
        if Rec."Receipt No." <> '' then begin
            RecPurchReceptHeader.Reset;
            RecPurchReceptHeader.SetRange("No.", Rec."Receipt No.");
            if RecPurchReceptHeader.FindFirst then begin
                Rec."Source Order No." := RecPurchReceptHeader."Order No.";
                IF PurchaseHeader.GET(Rec."Document Type"::Order, Rec."Source Order No.") then
                    PoStatus := FORMAT(PurchaseHeader."Approval Status");
            end;
        end;
        //TEAM 14763
    end;
}