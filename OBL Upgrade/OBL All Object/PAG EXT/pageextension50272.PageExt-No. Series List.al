pageextension 50272 pageextension50272 extends "No. Series List"
{

    layout
    {
        addafter(StartDate)
        {
            field(Location; Rec.Location)
            {
                ApplicationArea = All;
            }
            field("Sales Order No. Series"; Rec."Sales Order No. Series")
            {
                ApplicationArea = all;
            }
            field("Posted Invoice No. Series"; Rec."Posted Invoice No. Series")
            {
                ApplicationArea = all;
            }
            field(Trading; Rec.Trading)
            {
                ApplicationArea = all;
            }
            field("Group Code"; Rec."Group Code")
            {
                ApplicationArea = all;
            }
            field("Job Indent"; Rec."Job Indent")
            {
                ApplicationArea = all;
            }
            field("Sales Imp. or Exp."; Rec."Sales Imp. or Exp.")
            {
                ApplicationArea = all;
            }

            field(Domestic; Rec.Domestic)
            {
                ApplicationArea = All;
            }
            field(Imported; Rec.Imported)
            {
                ApplicationArea = All;
            }
            field("U Series"; Rec."U Series")
            {
                ApplicationArea = All;
            }
            field("SRV Service"; Rec."SRV Service")
            {
                ApplicationArea = All;
            }
        }
        addafter("Default Nos.")
        {
            field("TCS On Collection Entry"; Rec."TCS On Collection Entry")
            {
                ApplicationArea = All;
            }
        }
    }
}

