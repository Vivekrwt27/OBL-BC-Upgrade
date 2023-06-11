table 50083 "Purchase Invoice Upload"
{

    fields
    {
        field(1; "Location Code"; Code[10])
        {
            TableRelation = Location;
        }
        field(5; "Vendor No."; Code[20])
        {
            TableRelation = Vendor;
        }
        field(10; "Vendor Invoice No."; Code[20])
        {
        }
        field(12; "Line No."; Integer)
        {
        }
        field(15; "Vendor Invoice Date"; Date)
        {
        }
        field(20; "Date of Transaction"; Date)
        {
        }
        field(30; Type; Option)
        {
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        }
        field(35; "No."; Code[20])
        {
            TableRelation = IF ("Type" = CONST("G/L Account")) "G/L Account"."No."
            ELSE
            IF ("Type" = CONST("Item")) "Item"."No.";

            trigger OnValidate()
            var
                ICPartner: Record "IC Partner";
              //  ItemCrossReference: Record "Item Cross Reference";
                PrepmtMgt: Codeunit "Prepayment Mgt.";
                GSTGroup: Record "GST Group";
            begin
            end;
        }
        field(40; Quantity; Decimal)
        {
        }
        field(50; Rate; Decimal)
        {
        }
        field(60; Amount; Decimal)
        {
        }
        field(70; "GST Group"; Code[10])
        {
            TableRelation = "GST Group".Code;
        }
        field(75; "HSN No."; Code[10])
        {
            TableRelation = "HSN/SAC".Code WHERE("GST Group Code" = FIELD("GST Group"));
        }
        field(80; Structure; Code[20])
        {
            // TableRelation = "Structure Header".Code;
        }
        field(81; "Gen. Prod. Posting Grp."; Code[10])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(100; Processed; Boolean)
        {
        }
        field(150; "Purchase Invoice No."; Code[20])
        {
        }
        field(151; "Posting Desc"; Text[200])
        {
        }
        field(152; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Invoice,Credit Memo';
            OptionMembers = Invoice,"Credit Memo";
        }
        field(153; "GST Group Type"; Option)
        {
            Caption = 'GST Group Type';
            Editable = false;
            OptionCaption = 'Goods,Service';
            OptionMembers = Goods,Service;
        }
        field(154; "ITC Type"; Option)
        {
            OptionCaption = ' ,Input Goods,Input Servce,Input Capital Goods,NON ITC';
            OptionMembers = " ","Input Goods","Input Servce","Input Capital Goods","NON ITC";
        }
        field(155; NOE; Code[15])
        {
            Description = 'MSVRN 060918';
            TableRelation = "NOE Permission".NOE WHERE("Location" = FIELD("Location Code"));
        }
        field(156; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Blocked" = CONST(false),
                                                          "Display Allow" = CONST(true));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
    }

    keys
    {
        key(Key1; "Vendor No.", "Vendor Invoice No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        /*OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
        IF "No." <> '' THEN
          //MODIFY;
        
        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
          MODIFY;
          IF PurchLinesExist THEN
            UpdateAllLineDim("Dimension Set ID",OldDimSetID);
        END;
        */

    end;
}

