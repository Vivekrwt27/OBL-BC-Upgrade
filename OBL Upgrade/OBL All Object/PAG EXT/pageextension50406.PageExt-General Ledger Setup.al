pageextension 50406 pageextension50406 extends "General Ledger Setup"
{


    Editable = false;
    layout
    {

        addafter("Register Time")
        {
            field("SMS Updatation"; Rec."SMS Updatation")
            {
                ApplicationArea = All;
            }
        }
        addafter("Acc. Sched. for Balance Sheet")
        {
            field("TDS Inv. Rounding Precision"; Rec."TDS Inv. Rounding Precision")
            {
                ApplicationArea = All;
            }
            field("TDS Inv. Rounding Type"; Rec."TDS Inv. Rounding Type")
            {
                ApplicationArea = All;
            }
            field("TDS Inv. Rounding Account"; Rec."TDS Inv. Rounding Account")
            {
                ApplicationArea = All;
            }
        }
        /*  moveafter("Control 4"; "Sub-Con Interim Account")
          moveafter("Control 1500058"; "Control 1900309501")
          moveafter("Control 1500014"; "Control 1500023")*/
    }
}

