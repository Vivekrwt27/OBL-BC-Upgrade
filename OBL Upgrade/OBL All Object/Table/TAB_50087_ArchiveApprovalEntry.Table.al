table 50087 "Archive Approval Entry"
{
    Caption = 'Approval Entry';

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "Sequence No."; Integer)
        {
            Caption = 'Sequence No.';
        }
        field(5; "Approval Code"; Code[20])
        {
            Caption = 'Approval Code';
        }
        field(6; "Sender ID"; Code[50])
        {
            Caption = 'Sender ID';
        }
        field(7; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
        }
        field(8; "Approver ID"; Code[50])
        {
            Caption = 'Approver ID';
        }
        field(9; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Created,Open,Cancelled,Rejected,Approved';
            OptionMembers = Created,Open,Cancelled,Rejected,Approved;
        }
        field(10; "Date-Time Sent for Approval"; DateTime)
        {
            Caption = 'Date-Time Sent for Approval';
        }
        field(11; "Last Date-Time Modified"; DateTime)
        {
            Caption = 'Last Date-Time Modified';
        }
        field(12; "Last Modified By ID"; Code[50])
        {
            Caption = 'Last Modified By ID';
        }
        field(13; Comment; Boolean)
        {
            CalcFormula = Exist("Approval Comment Line" WHERE("Table ID" = FIELD("Table ID"),
                                                               "Document Type" = FIELD("Document Type"),
                                                               "Document No." = FIELD("Document No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(15; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(16; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
        }
        field(17; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(18; "Approval Type"; Option)
        {
            Caption = 'Approval Type';
            OptionCaption = ' ,Sales Pers./Purchaser,Approver';
            OptionMembers = " ","Sales Pers./Purchaser",Approver;
        }
        field(19; "Limit Type"; Option)
        {
            Caption = 'Limit Type';
            OptionCaption = 'Approval Limits,Credit Limits,Request Limits,No Limits';
            OptionMembers = "Approval Limits","Credit Limits","Request Limits","No Limits";
        }
        field(20; "Available Credit Limit (LCY)"; Decimal)
        {
            Caption = 'Available Credit Limit (LCY)';
        }
        field(29; "Approval Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(30; "Workflow Step Instance ID"; Guid)
        {
            Caption = 'Workflow Step Instance ID';
        }
        field(50; "Entry No."; Integer)
        {
        }
        field(55; "Old Status"; Option)
        {
            OptionCaption = 'Created,Open,Cancelled,Rejected,Approved';
            OptionMembers = Created,Open,Cancelled,Rejected,Approved;
        }
        field(50000; "GUID Key"; Guid)
        {
        }
        field(50001; "Comment Text"; Text[250])
        {
        }
        field(50002; "Approver Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(50003; "Auto Approved"; Boolean)
        {
        }
        field(50004; "Auto Approved By"; Code[20])
        {
        }
        field(50005; "Approval Date & Time"; DateTime)
        {
        }
        field(50006; "Last Modified By ID1"; Code[50])
        {
        }
        field(50007; EmailID; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Table ID", "Document Type", "Document No.", "Sequence No.")
        {
            Clustered = true;
        }
        key(Key3; "Approver ID", Status)
        {
        }
        key(Key4; "Sender ID")
        {
        }
    }

    fieldgroups
    {
    }

    procedure ShowDocument()
    var
        SalesHeader: Record "Sales Header";
        PurchHeader: Record "Purchase Header";
    begin
        CASE "Table ID" OF
            DATABASE::"Sales Header":
                BEGIN
                    IF NOT SalesHeader.GET("Document Type", "Document No.") THEN
                        EXIT;
                    CASE "Document Type" OF
                        "Document Type"::Quote:
                            PAGE.RUN(PAGE::"Sales Quote", SalesHeader);
                        "Document Type"::Invoice:
                            PAGE.RUN(PAGE::"Sales Invoice", SalesHeader);
                        "Document Type"::"Credit Memo":
                            PAGE.RUN(PAGE::"Sales Credit Memo", SalesHeader);
                        "Document Type"::"Blanket Order":
                            PAGE.RUN(PAGE::"Blanket Sales Order", SalesHeader);
                        "Document Type"::"Return Order":
                            PAGE.RUN(PAGE::"Sales Return Order", SalesHeader);
                    END;
                END;
            DATABASE::"Purchase Header":
                BEGIN
                    IF NOT PurchHeader.GET("Document Type", "Document No.") THEN
                        EXIT;
                    CASE "Document Type" OF
                        "Document Type"::Quote:
                            PAGE.RUN(PAGE::"Purchase Quote", PurchHeader);
                        "Document Type"::Order:
                            PAGE.RUN(PAGE::"Purchase Order Subform", PurchHeader);
                        "Document Type"::Invoice:
                            PAGE.RUN(PAGE::"Purchase Invoice", PurchHeader);
                        "Document Type"::"Credit Memo":
                            PAGE.RUN(PAGE::"Purchase Credit Memo", PurchHeader);
                        "Document Type"::"Blanket Order":
                            PAGE.RUN(PAGE::"Blanket Purchase Order", PurchHeader);
                        "Document Type"::"Return Order":
                            PAGE.RUN(PAGE::"Purchase Return Order", PurchHeader);
                    END;
                END;
            ELSE
                EXIT;
        END;
    end;
}

