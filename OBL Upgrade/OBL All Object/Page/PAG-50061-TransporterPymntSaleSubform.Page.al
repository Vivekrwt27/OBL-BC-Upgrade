page 50061 "Transporter Pymnt Sale Subform"
{
    AutoSplitKey = true;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Transporter Payment Line";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(GROUP)
            {
                field(Transfer; rec.Transfer)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("MRN No."; rec."MRN No.")
                {
                    Caption = 'Shipment No. / Receipt No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line No."; rec."Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("MRN Date"; rec."MRN Date")
                {
                    Caption = 'Shipment / Receipt Date';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer No."; rec."Customer No.")
                {
                    Caption = 'Customer No. / Location';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Invoice No."; rec."Invoice No.")
                {
                    Caption = 'Transfer Shpt. No. / Sales Inv. No.';
                    ApplicationArea = All;
                }
                field(City; rec.City)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Item; rec.Item)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(UOM; rec.UOM)
                {
                    ApplicationArea = All;
                }
                field("K.G."; rec."K.G.")
                {
                    Caption = 'KG';
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Rate/Kg"; rec."Rate/Kg")
                {
                    Caption = 'Rate/KG';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        TransporterPaymentLine.RESET;
                        TransporterPaymentLine.SETFILTER(TransporterPaymentLine."MRN No.", '%1', Rec."MRN No.");
                        TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Line No.", '<>%1', Rec."Line No.");
                        TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Rate/Kg", '<>%1', Rec."Rate/Kg");
                        TransporterPaymentLine.SETFILTER(TransporterPaymentLine.Transfer, '%1', Rec.Transfer);
                        IF TransporterPaymentLine.FIND('-') THEN
                            REPEAT
                                TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Rate/Kg", Rec."Rate/Kg");
                                TransporterPaymentLine.MODIFY;
                            UNTIL TransporterPaymentLine.NEXT = 0;
                        RateKgOnAfterValidate;
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("GR No."; Rec."GR No.")
                {
                    ApplicationArea = All;
                }
                field("GR Date"; Rec."GR Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        TransporterPaymentLine: Record "Transporter Payment Line";

    local procedure RateKgOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;
}

