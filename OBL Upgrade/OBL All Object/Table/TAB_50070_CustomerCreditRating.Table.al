table 50070 "Customer Credit Rating"
{
    //DrillDownPageID = 50033;
    // LookupPageID = 50033;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(10; Date; Date)
        {
        }
        field(20; "Overall Rating"; Decimal)
        {
        }
        field(50; "Credit Class Rating"; Option)
        {
            OptionCaption = ' ,A,B,C,D,E';
            OptionMembers = " ",A,B,C,D,E;
        }
        field(100; "Turn-Over Rating"; Option)
        {
            OptionCaption = ' ,P,G,S,B';
            OptionMembers = " ",P,G,S,B;
        }
        field(130; TurnOver; Decimal)
        {
        }
        field(200; "Payment Term Score"; Decimal)
        {
        }
        field(300; "Credit Utilisation Score"; Decimal)
        {
        }
        field(310; "Credit Utilisation Percentage"; Decimal)
        {
        }
        field(400; "Average Account Age"; Decimal)
        {
        }
        field(410; "Date of Joining"; Date)
        {
        }
        field(415; "No. of Days"; Integer)
        {
        }
        field(600; "Wt. Avg. Due Payment Term(Days"; Decimal)
        {
        }
        field(610; "Wt. Avg. Collection Term(Days)"; Decimal)
        {
        }
        field(900; "Parent Customer No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(1000; "No. of Accounts"; Integer)
        {
            CalcFormula = Count("Customer Credit Rating" WHERE("Parent Customer No." = FIELD("Parent Customer No."),
                                                                Date = FIELD(Date)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7000; "Credit Class Score"; Decimal)
        {
        }
        field(8000; "Parent Turn-Over Rating"; Option)
        {
            OptionCaption = ' ,P,G,S,B';
            OptionMembers = " ",P,G,S,B;
        }
        field(8010; "Total Turnover"; Decimal)
        {
        }
        field(8050; "Parent Average Account Age"; Decimal)
        {
        }
        field(8060; "Parent Wt. Avg. Due P.T.(Days)"; Decimal)
        {
        }
        field(8070; "Parent Wt. Avg. C.T.(Days)"; Decimal)
        {
        }
        field(8090; "Parent Payment Term Score"; Decimal)
        {
        }
        field(9100; "Parent Credit Util. Score"; Decimal)
        {
        }
        field(9110; "Parent Credit Util. Percentage"; Decimal)
        {
        }
        field(9200; "Parent Credit Class Rating"; Option)
        {
            OptionCaption = ' ,A,B,C,D,E';
            OptionMembers = " ",A,B,C,D,E;
        }
        field(9210; "Parent Credit Class Score"; Decimal)
        {
        }
        field(90000; Static; Boolean)
        {
        }
        field(90001; "Credit Days"; Integer)
        {
        }
        field(90002; "Credit Amt"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Customer No.", Date)
        {
            Clustered = true;
        }
        key(Key2; Static)
        {
        }
    }

    fieldgroups
    {
    }
}

