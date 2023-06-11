page 50226 "Create Purchase Invoice (BULK)"
{
    PageType = List;
    SourceTable = "Purchase Invoice Upload";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
                {
                    ApplicationArea = All;
                }
                field("Date of Transaction"; Rec."Date of Transaction")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cose Rate"; Rec.Rate)
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Grp."; Rec."Gen. Prod. Posting Grp.")
                {
                    ApplicationArea = All;
                }
                field("GST Group"; Rec."GST Group")
                {
                    ApplicationArea = All;
                }
                field("HSN No."; Rec."HSN No.")
                {
                    ApplicationArea = All;
                }
                field(Structure; Rec.Structure)
                {
                    ApplicationArea = All;
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = All;
                }
                field("Purchase Invoice No."; Rec."Purchase Invoice No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Desc"; Rec."Posting Desc")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("GST Group Type"; Rec."GST Group Type")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("ITC Type"; Rec."ITC Type")
                {
                    ApplicationArea = All;
                }
                field(NOE; Rec.NOE)
                {
                    ApplicationArea = All;
                }
                field(Department; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Department';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Create Purchase Invoice")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you want to create purchase invoice(s)?') THEN
                        REPORT.RUN(Report::"Generate Purchase Invoices");
                end;
            }
        }
    }
}

