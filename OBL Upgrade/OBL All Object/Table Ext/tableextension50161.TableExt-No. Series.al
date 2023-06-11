tableextension 50161 tableextension50161 extends "No. Series"
{
    fields
    {
        field(50000; Location; Code[10])
        {
            TableRelation = Location.Code;
        }
        field(50001; "Sales Order No. Series"; Code[10])
        {
            Description = 'TRI DP 140309';
            TableRelation = "No. Series";
        }
        field(50002; "Posted Invoice No. Series"; Code[10])
        {
            Description = 'TRI DG';
            TableRelation = "No. Series";
        }
        field(50003; Structure; Code[10])
        {
            Description = 'TRI P.G 22.06.2009';
            // 15578 TableRelation = "Structure Header";
        }
        field(50004; Trading; Boolean)
        {
            Description = 'TRI DG';
        }
        field(50005; "Group Code"; Code[2])
        {
            Description = 'MSBS.Rao 300924';
            TableRelation = "Item Group";
        }
        field(50006; "Job Indent"; Boolean)
        {
        }
        field(50010; "Sales Imp. or Exp."; Option)
        {
            Description = 'MSVRN 061119';
            OptionMembers = " ",Import,Domestic;
        }
        field(50011; Domestic; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Keshav';
            Editable = true;
        }
        field(50012; Imported; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Keshav';
            Editable = true;
        }
        field(50013; "U Series"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Keshav';
            Editable = true;
        }
        field(50014; "SRV Service"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Keshav';
            Editable = true;
        }
        field(50015; "TCS On Collection Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}

