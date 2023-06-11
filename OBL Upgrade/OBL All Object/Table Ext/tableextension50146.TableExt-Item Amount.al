tableextension 50146 tableextension50146 extends "Item Amount"
{
    fields
    {
        field(50000; "Inventory Posting Group"; Code[20])
        {
            Description = 'TRI';
        }
        field(50001; Quantity; Decimal)
        {
            Description = 'TRI';
        }
        field(50002; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            Description = 'TRI';
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output;
        }
        field(50003; "Production Order No."; Code[20])
        {
            Description = 'TRI';
        }
        field(50004; "ILE Entry No."; Integer)
        {
            Description = 'TRI';
        }
        field(50005; "Plant Code"; Code[10])
        {
            Description = 'TRI';
        }
        field(50006; "Additional Amount"; Decimal)
        {
            Description = 'TRI';
        }
        field(50007; "RM Item No."; Code[20])
        {
            Description = 'TRI';
        }
        field(50008; "Expected Quantity"; Decimal)
        {
            Description = 'TRI';
        }
        field(50009; "Remaining Quantity"; Decimal)
        {
            Description = 'TRI';
        }
        field(50010; "Due Date"; Date)
        {
            Description = 'TRI';
        }
        field(50011; "Location Code"; Code[20])
        {
            Description = 'TRI';
        }
        field(50012; "Comp Line No."; Integer)
        {
            Description = 'TRI';
        }
        field(50013; "Prod. Order Line No."; Integer)
        {
            Description = 'TRI';
        }
        field(50014; Description; Text[80])
        {
        }
        field(50015; NewString; Code[20])
        {
        }
    }
    keys
    {
        /*  key(Key4; "Plant Code", "Inventory Posting Group", "Item No.")
          {
              SumIndexFields = "Additional Amount";
          }*/
        key(Key5; "Item No.")
        {
        }
        /* key(Key6; "Item No.", "RM Item No.", "Prod. Order Line No.", "Comp Line No.")
         {
             SumIndexFields = Quantity, "Expected Quantity", "Remaining Quantity";
         }*/
        key(Key7; "Inventory Posting Group", "Additional Amount")
        {
        }
    }
}

