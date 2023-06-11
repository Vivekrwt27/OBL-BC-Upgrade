page 50028 "Posted RGP In Header"
{
    // Customization No. 63

    Editable = false;
    PageType = Card;
    SourceTable = "RGP Header";
    SourceTableView = WHERE(Posted = CONST(true),
                            "Document Type" = CONST(In));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec."Document Type" := Rec."Document Type"::"In";
                    end;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Employee ID"; Rec."Employee ID")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
            }
            part("RGP In Line"; "RGP In Line")
            {
                Editable = false;
                SubPageLink = "RGP No." = FIELD("No."),
                               "Document Type" = FIELD("Document Type");
                ApplicationArea = All;
            }



        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Customization No. 63 Start Vipul
        Rec."Document Type" := xRec."Document Type"
        //Customization No. 63 End Vipul
    end;

    var
        RgpLine: Record "RGP Line";
}

