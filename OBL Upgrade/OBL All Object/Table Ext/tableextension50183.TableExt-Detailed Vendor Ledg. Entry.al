tableextension 50183 tableextension50183 extends "Detailed Vendor Ledg. Entry"
{
    fields
    {

        //Unsupported feature: Property Insertion (Editable) on ""Posting Date"(Field 4)".

        /* modify("TDS Group")
         {
             OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others,Goods';

             //Unsupported feature: Property Modification (OptionString) on ""TDS Group"(Field 13703)".

         }*/
        field(50090; "Form C No."; Code[15])
        {
        }
        field(50091; "Form C Amt"; Decimal)
        {
        }
        field(60029; Matched; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'EYAIM-AZZ';
        }
    }
}

