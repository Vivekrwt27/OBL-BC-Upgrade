tableextension 50028 tableextension50028 extends "TDS Entry"
{
    fields
    {


        //Unsupported feature: Property Modification (Editable) on ""Remaining TDS Amount"(Field 65)".

        /* modify("TDS Group")
         {
             OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others,Rent for Plant & Machinery,Rent for Land & Building,Banking Services,Compensation On Immovable Property,PF Accumulated,Payment For Immovable Property,Goods';

         
         }*/ // 15578


        /* modify("TDS Section")
         {
             OptionCaption = ' ,194C,194G,194J,194A,194I,194,193,194B,194D,194EE,194F,194H,194K,194L,194BB,194E,195,196A,196B,196C,196D,194IA,194IB,197A1F,194LA,192A,194Q';

        
         }*/ // 15578


        /* field(136; "Over & Above Threshold Opening"; Boolean)
         {
             DataClassification = ToBeClassified;
         }*/ // 15578
        field(137; "Calc. Over & Above Threshold"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50000; "Adjusted TDS Doc No."; Code[20])
        {
            Description = 'mo tri1.0';
        }
        field(50001; "Posted Pay TDS Document No."; Code[20])
        {
            Description = 'VPB Tri1.0';
        }
        field(50002; Picture; BLOB)
        {
        }
        field(50003; "Location Code"; Code[20])
        {
            TableRelation = Location;
        }
    }
    keys
    {

        //Unsupported feature: Property Insertion (SumIndexFields) on ""Document No.,Posting Date"(Key)".

        key(Key12; "Posting Date", "Document No.")
        {
        }
        key(Key13; "Pay TDS Document No.", "Posting Date", "Document No.")
        {
        }
        /* key(Key14; "Adjusted TDS Doc No.", "Posting Date", "Document No.")
         {
         }*/
        key(Key15; /*"TDS Group",*/ "Party Code")
        {
        }
        key(Key16; /*"TDS Section", */"Posted Pay TDS Document No.")
        {
        }
        key(Key17; "Party Type", "Party Code",/* "TDS Section",*/ "BSR Code", "Challan No.", "Challan Date")
        {
        }
        key(Key18; "Pay TDS Document No.", "Challan Date")
        {
        }
    }

    //Unsupported feature: Property Deletion (CaptionML).

}

