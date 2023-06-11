page 50014 "Customer/Vendor Type"
{
    // Cust 22 ravi

    PageType = Card;
    SourceTable = "Customer Type";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    Visible = "Vendor Posting GroupVisible";
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    Visible = "Customer Posting GroupVisible";
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Excise Bus. Posting Group"; Rec."Excise Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Structure; Rec.Structure)
                {
                    ApplicationArea = All;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        "Customer Posting GroupVisible" := TRUE;
        "Vendor Posting GroupVisible" := TRUE;
    end;

    trigger OnOpenPage()
    begin
        IF Rec.Type = Rec.Type::Customer THEN BEGIN
            "Vendor Posting GroupVisible" := FALSE;
            "Customer Posting GroupVisible" := TRUE;
        END;

        IF Rec.Type = Rec.Type::Vendor THEN BEGIN
            "Customer Posting GroupVisible" := FALSE;
            "Vendor Posting GroupVisible" := TRUE;
        END;
    end;

    var
        [InDataSet]
        "Vendor Posting GroupVisible": Boolean;
        [InDataSet]
        "Customer Posting GroupVisible": Boolean;
}

