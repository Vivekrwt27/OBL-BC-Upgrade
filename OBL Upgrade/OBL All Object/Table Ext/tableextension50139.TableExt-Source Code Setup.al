tableextension 50139 tableextension50139 extends "Source Code Setup"
{
    fields
    {
        /*  field(13708; "TDS Above Threshold Opening"; Code[10])
          {
              DataClassification = ToBeClassified;
          }*/ // 15578
        field(50010; Payroll; Code[10])
        {
            TableRelation = "Source Code";
        }
        field(50011; "Payroll Payment Journal"; Code[10])
        {
            Caption = 'Payroll Payment Journal';
            TableRelation = "Source Code";
        }
        field(50012; "Payroll Entry Application"; Code[10])
        {
            Caption = 'Payroll Entry Application';
            TableRelation = "Source Code";
        }
    }
}

