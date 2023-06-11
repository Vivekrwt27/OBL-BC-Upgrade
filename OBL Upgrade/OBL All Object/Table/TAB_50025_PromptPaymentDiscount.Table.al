table 50025 "Prompt Payment Discount"
{

    fields
    {
        field(1; "Invoice No."; Code[20])
        {
            Editable = false;
        }
        field(2; Date; Date)
        {
            Editable = false;
        }
        field(3; "Invoice Amount"; Decimal)
        {
            Editable = false;
        }
        field(4; "Payment Due Date"; Date)
        {
            Editable = false;
        }
        field(5; "Payment Rcpt. Date"; Date)
        {
            Editable = false;

            trigger OnValidate()
            begin
                //"No. of Days" := "Payment Due Date" - "Payment Rcpt. Date";
            end;
        }
        field(6; "No. of Days"; Integer)
        {
            Editable = false;

            trigger OnValidate()
            begin
                VALIDATE("Discount Applicable For Days", "No. of Days");
            end;
        }
        field(7; "Discount Applicable For Days"; Integer)
        {

            trigger OnValidate()
            begin
                IF "Discount Applicable For Days" > "No. of Days" THEN
                    ERROR('Discount Applicable For Days cannot be greater than No. of Days');
                IF "Discount No. of Days" <> 0 THEN
                    "Discount Amount" := ("Total Payment Received" * "Discount Applicable For Days" * "Discount %" / ("Discount No. of Days" * 100))
                    * (1 - "Tax Adjustment" / 100);
            end;
        }
        field(8; "Discount No. of Days"; Integer)
        {

            trigger OnValidate()
            begin
                IF "Discount No. of Days" <> 0 THEN
                    "Discount Amount" := "Total Payment Received" * "Discount Applicable For Days" * "Discount %" / ("Discount No. of Days" * 100)
                    * (1 - "Tax Adjustment" / 100);
            end;
        }
        field(9; "Discount %"; Decimal)
        {

            trigger OnValidate()
            begin
                IF "Discount No. of Days" <> 0 THEN
                    "Discount Amount" := "Invoice Amount" * "Discount Applicable For Days" * "Discount %" / ("Discount No. of Days" * 100)
                    * (1 - "Tax Adjustment" / 100);
            end;
        }
        field(10; "Discount Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                IF ("Total Payment Received" * "Discount Applicable For Days") <> 0 THEN
                    "Discount %" := ("Discount Amount" * (1 / (1 - "Tax Adjustment" / 100))
                   * 100 * "Discount No. of Days" / ("Total Payment Received" * "Discount Applicable For Days"));
            end;
        }
        field(11; "Total Payment Received"; Decimal)
        {
            Editable = false;
        }
        field(12; "Customer Code"; Code[20])
        {
            Editable = false;
        }
        field(13; "Credit Memo No."; Code[20])
        {
        }
        field(14; "Discount Date"; Date)
        {
        }
        field(15; "Tax Adjustment"; Decimal)
        {

            trigger OnValidate()
            begin
                /*IF (xRec."Tax Adjustment" <> 0) AND ("Discount Amount" <> 0) THEN
                  "Discount Amount" := "Discount Amount" * (1-"Tax Adjustment") / (1-xRec."Tax Adjustment")
                ELSE*/
                IF "Discount No. of Days" <> 0 THEN
                    "Discount Amount" := "Invoice Amount" * "Discount Applicable For Days" * "Discount %" / ("Discount No. of Days" * 100)
                      * (1 - "Tax Adjustment" / 100);

            end;
        }
    }

    keys
    {
        key(Key1; "Invoice No.")
        {
            Clustered = true;
        }
        key(Key2; Date)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        IF Customer.GET("Customer Code") THEN BEGIN
            Customer."Prompt Pmt. Details" := TRUE;
            Customer.MODIFY;
        END;

        PromptPaymentDiscount.RESET;
        PromptPaymentDiscount.SETFILTER("Customer Code", "Customer Code");
        PromptPaymentDiscount.SETFILTER("Credit Memo No.", '%1', '');
        IF NOT PromptPaymentDiscount.FIND('-') THEN
            IF Customer.GET("Customer Code") THEN BEGIN
                Customer."Prompt Pmt. Details" := FALSE;
                Customer.MODIFY;
            END;
    end;

    var
        Customer: Record Customer;
        PromptPaymentDiscount: Record "Prompt Payment Discount";

    procedure Navigate()
    var
        NavigateForm: Page Navigate;
    begin
        NavigateForm.SetDoc(Date, "Invoice No.");
        NavigateForm.RUN;
    end;
}

