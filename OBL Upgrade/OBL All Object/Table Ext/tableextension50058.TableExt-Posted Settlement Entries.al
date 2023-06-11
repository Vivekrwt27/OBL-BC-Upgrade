tableextension 50058 tableextension50058 extends "Posted Settlement Entries"
{
    Caption = 'GST Payment Buffer';
    fields
    {
        modify("GST Registration No.")
        {
            Caption = 'GST Registration No.';
        }
        modify("Document No.")
        {
            Caption = 'Document No.';

            //Unsupported feature: Property Modification (Editable) on ""Document No."(Field 2)".

        }
        modify("Posting Date")
        {
            Caption = 'Posting Date';

            //Unsupported feature: Property Modification (Editable) on ""Posting Date"(Field 3)".

        }
        modify("GST Component Code")
        {
            Caption = 'GST Component Code';

            //Unsupported feature: Property Modification (Editable) on ""GST Component Code"(Field 4)".

        }
        modify(Description)
        {
            Caption = 'Description';

            //Unsupported feature: Property Modification (Editable) on "Description(Field 5)".

        }
        modify("Payment Liability")
        {
            Caption = 'Payment Liability';
        }
        /*modify("TDS Credit Received")
        {

            //Unsupported feature: Property Modification (Name) on ""TDS Credit Received"(Field 8)".

            Caption = 'TDS Credit Received';
        }
        modify("TCS Credit Received")
        {

            //Unsupported feature: Property Modification (Name) on ""TCS Credit Received"(Field 9)".

            Caption = 'TCS Credit Received';
        }*/ // 15578
        modify("Net Payment Liability")
        {
            Caption = 'Net Payment Liability';
        }
        modify("Credit Availed")
        {
            Caption = 'Credit Availed';
        }
        modify("Distributed Credit")
        {
            Caption = 'Distributed Credit';
        }
        modify("Total Credit Available")
        {
            Caption = 'Total Credit Available';
        }
        modify("Credit Utilized")
        {
            Caption = 'Credit Utilized';
        }
        modify("Payment Amount")
        {
            Caption = 'Payment Amount';
        }


    }
}

