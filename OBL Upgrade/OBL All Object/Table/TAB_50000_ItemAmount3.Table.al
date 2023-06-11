table 50000 "Item Amount3"
{


    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(2; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(3; "Amount 2"; Decimal)
        {
            Caption = 'Amount 2';
        }
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
        field(50005; "Plant Code"; Code[20])
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
        field(50014; "Item Description"; Text[50])
        {
        }
        field(50015; Retained; Boolean)
        {
        }
        field(50016; "Manuf. Strategy"; Option)
        {
            Description = 'Kulbhushan Field for to know the production purpose';
            OptionCaption = ' ,Non Retained ,Make-to-Stock,MTO';
            OptionMembers = " ","Non Retained ","Make-to-Stock",MTO;

        }
    }

    keys
    {
        key(Key1; "Item No.", "Item Description")
        {
            Clustered = true;
        }
        key(Key2; Retained, "Plant Code", "Additional Amount")
        {
        }
        key(Key3; "Additional Amount")
        {
        }
    }
    var



}

