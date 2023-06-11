table 50082 "Budget Master Archive"
{
    // DrillDownPageID = 50305;
    // LookupPageID = 50305;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Capex Request"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Regular,Non-Regular';
            OptionMembers = Regular,"Non-Regular";
        }
        field(7; "Archive No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Description 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Project Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Location;
        }
        field(35; "Operation Unit"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,SKD,HSK,DORA,HO';
            OptionMembers = " ",SKD,HSK,DORA,HO;
        }
        field(40; "Budget Amount (In Rs)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Investment (In INR)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Pending for Approval,Released,Completed,Rejected';
            OptionMembers = Open,"Pending for Approval",Released,Completed,Rejected;
        }
        field(51; "Estimated Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Estimated Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Created By"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(80; "Created Date & Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(85; "Rejected Date & Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(90; "UnPosted Amount"; Decimal)
        {
            CalcFormula = Sum("Capex Entry".Amount WHERE("Entry Type" = CONST("Purchase Order"),
                                                          "Document Type" = CONST(Order),
                                                          "Capex No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(100; "Amount Utilised"; Decimal)
        {
            CalcFormula = Sum("Capex Entry".Amount WHERE("Capex No." = FIELD("No."),
                                                          "Entry Type" = CONST(Invoice),
                                                          "Document Type" = CONST(Invoice)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(105; "Payment Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(110; "Authorization 1"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "User Setup"."User ID";
        }
        field(115; "Authorization 2"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "User Setup"."User ID";
        }
        field(120; "Authorization 3"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "User Setup"."User ID";
        }
        field(125; "Authorization 4"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(128; "Authorization 5"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(131; "Authorization 6"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(134; "Authorization 7"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(137; "Authorization 8"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(140; "Authorization 1 Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(145; "Authorization 1 Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(150; "Authorization 2 Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(155; "Authorization 2 Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(160; "Authorization 3 Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(165; "Authorization 3 Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(167; "Authorization 4 Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(168; "Authorization 4 Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(170; "Authorization 5 Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(171; "Authorization 5 Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(173; "Authorization 6 Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(174; "Authorization 6 Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(176; "Authorization 7 Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(177; "Authorization 7 Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(178; "Authorization 8 Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(179; "Authorization 8 Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(180; "Included In Capex Plan"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(190; Supplementary; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(195; "Type of Investment"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Replacement (R),Legal (L)/Compliance , Improvement (I) , Expansion (E) , Strategic (S),Environment';
            OptionMembers = " ","Replacement (R)","Legal (L)/Compliance "," Improvement (I) "," Expansion (E) "," Strategic (S)",Environment;
        }
        field(196; "Investment Class"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Fixed Assets ,Financial Assets';
            OptionMembers = " ","Fixed Assets ","Financial Assets";
        }
        field(200; "Executive Summary"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Memo;
        }
        field(210; "Project Rational"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Memo;
        }
        field(220; "Financial Evaluation"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Memo;
        }
        field(230; "Capital Investment (in INR)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(231; "NPV (In INR)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(240; "IRR%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(245; "Expenditure Sum"; Decimal)
        {
            CalcFormula = Sum("Budget Master Line"."Estimation (In INR)" WHERE("Document No." = FIELD("No."),
                                                                                "Capex Request" = FIELD("Capex Request"),
                                                                                Type = FILTER("Project Budget")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(250; "Pay Back Period (In Years)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(260; Contigency; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(270; "AFE Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(280; "Pending Approval UserID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(282; Currency; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(283; Conversion; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(284; Department; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                DimensionValue: Record "Dimension Value";
            begin
            end;

            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin

            end;
        }
        field(285; "Department Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(287; "Posting No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(1000; "Archive By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(1200; "Archive Date and Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Capex Request", "No.", "Archive No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

