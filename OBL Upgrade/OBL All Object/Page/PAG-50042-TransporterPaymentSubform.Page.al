page 50042 "Transporter Payment Subform"
{
    AutoSplitKey = true;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Transporter Payment Line";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(GROUP)
            {
                field("MRN No."; rec."MRN No.")
                {
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Transfer; rec.Transfer)
                {
                    ApplicationArea = All;
                }
                field("GR No."; rec."GR No.")
                {
                    ApplicationArea = All;
                }
                field("GR Date"; rec."GR Date")
                {
                    ApplicationArea = All;
                }
                field("Invoice No."; rec."Invoice No.")
                {
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
                    ApplicationArea = All;
                }
                field("Rate/Kg"; rec."Rate/Kg")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        TransporterPaymentLine.RESET;
                        TransporterPaymentLine.SETFILTER(TransporterPaymentLine."MRN No.", '%1', rec."MRN No.");
                        TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Line No.", '<>%1', REC."Line No.");
                        TransporterPaymentLine.SETFILTER(TransporterPaymentLine."Rate/Kg", '<>%1', REC."Rate/Kg");
                        IF TransporterPaymentLine.FIND('-') THEN
                            REPEAT
                                TransporterPaymentLine.VALIDATE(TransporterPaymentLine."Rate/Kg", REC."Rate/Kg");
                                TransporterPaymentLine.MODIFY;
                            UNTIL TransporterPaymentLine.NEXT = 0;
                        RateKgOnAfterValidate;
                    end;
                }
                field(Amount; REC.Amount)
                {
                    Editable = false;
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

