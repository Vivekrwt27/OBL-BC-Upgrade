tableextension 50181 tableextension50181 extends "Detailed Cust. Ledg. Entry"
{
    fields
    {
        /*  modify("TDS Group")
          {
              OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others,Goods';

              //Unsupported feature: Property Modification (OptionString) on ""TDS Group"(Field 13703)".

          }*/
        field(50000; "Collection Date"; Date)
        {
        }
    }
    keys
    {
        key(Key18; "Currency Code", "Customer No.", "Entry Type", "Initial Document Type")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
        key(Key19; "Entry Type", "Cust. Ledger Entry No.", "Customer No.")
        {
        }
        key(Key20; "Customer No.", "Posting Date", "Document Type", "Entry Type")
        {
            SumIndexFields = "Debit Amount", "Credit Amount";
        }
        key(Key21; "Currency Code", "Customer No.", "Entry Type", "Initial Document Type", "Posting Date")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
    }
}

