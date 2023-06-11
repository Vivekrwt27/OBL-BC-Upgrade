tableextension 50027 tableextension50027 extends "TDS Setup"
{
    fields
    {
        /*  modify("TDS Group")
          {
              OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others,Rent for Plant & Machinery,Rent for Land & Building,Banking Services,Compensation On Immovable Property,PF Accumulated,Payment For Immovable Property,Goods';

              //Unsupported feature: Property Modification (OptionString) on ""TDS Group"(Field 20)".

          }*/ // 15578


        field(27; "Calc. Over & Above Threshold"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Tds Certificate"; Text[30])
        {
        }
    }



}

