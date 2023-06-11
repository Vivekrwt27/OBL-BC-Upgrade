tableextension 50271 tableextension50271 extends "General Ledger Setup"
{
    fields
    {
        field(50000; "Tour Dimension Code"; Code[20])
        {
            Description = 'Customization No. 2.9';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                //mo tri1.0 Customization no.64 start
                /*IF Dim.CheckIfDimUsed("Tour Dimension Code",17,'','') tHEN
                  ERROR(Text023,Dim.GetCheckDimErr);
                MODIFY;
                //mo tri1.0 Customization no.64 end
                 *///TRIRJ

            end;
        }
        field(50001; "Employee Dimension Code"; Code[20])
        {
            Description = 'Customization No. 2.9';
            TableRelation = Dimension;

            trigger OnValidate()
            var

            begin
                //mo tri1.0 Customization no.64 start
                IF Dim.CheckIfDimUsed("Employee Dimension Code", 18, '', '', 0) THEN
                    ERROR(Text023, Dim.GetCheckDimErr);
                MODIFY;
                //mo tri1.0 Customization no.64 end
            end;
        }
        field(50002; "Tour Nos."; Code[10])
        {
            Description = 'Customization No. 2.9';
            TableRelation = "No. Series";
        }
        field(50003; "Customer Dimension Code"; Code[20])
        {
            Description = 'Customization No. 64';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                //mo tri1.0 Customization no.64 start
                IF Dim.CheckIfDimUsed("Customer Dimension Code", 19, '', '', 0) THEN
                    ERROR(Text023, Dim.GetCheckDimErr);
                MODIFY;
                //mo tri1.0 Customization no.64 end
            end;
        }
        field(50004; "Vendor Dimension Code"; Code[20])
        {
            Description = 'Customization No. 64';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                //mo tri1.0 Customization no.64 start
                IF Dim.CheckIfDimUsed("Vendor Dimension Code", 20, '', '', 0) THEN
                    ERROR(Text023, Dim.GetCheckDimErr);
                MODIFY;

                //mo tri1.0 Customization no.64 end
            end;
        }
        field(50005; "Item Dimension Code"; Code[20])
        {
            Description = 'Customization No. 64';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                //mo tri1.0 Customization no.64 start
                IF Dim.CheckIfDimUsed("Item Dimension Code", 21, '', '', 0) THEN
                    ERROR(Text023, Dim.GetCheckDimErr);
                MODIFY;
                //mo tri1.0 Customization no.64 end
            end;
        }
        field(50006; "Location Dimension Code"; Code[20])
        {
            Description = 'Customization No. 64';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                //mo tri1.0 Customization no.64 start
                IF Dim.CheckIfDimUsed("Location Dimension Code", 22, '', '', 0) THEN
                    ERROR(Text023, Dim.GetCheckDimErr);
                MODIFY;
                //mo tri1.0 Customization no.64 end
            end;
        }
        field(50007; "State Dimension Code"; Code[20])
        {
            Description = 'Customization No. 64';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                //mo tri1.0 Customization no.64 start
                IF Dim.CheckIfDimUsed("State Dimension Code", 23, '', '', 0) THEN
                    ERROR(Text023, Dim.GetCheckDimErr);
                MODIFY;
                //mo tri1.0 Customization no.64 end
            end;
        }
        field(50008; "Voith Attachment Storage Type"; Option)
        {
            OptionCaption = 'Embedded,Disk File';
            OptionMembers = Embedded,"Disk File";
        }
        field(50009; "Voith Attmt. Storage Location"; Text[250])
        {
        }
        field(50010; "Salesperson Dimension Code"; Code[20])
        {
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                //ND Tri1.0 Start
                IF Dim.CheckIfDimUsed("Salesperson Dimension Code", 24, '', '', 0) THEN
                    ERROR(Text023, Dim.GetCheckDimErr);
                MODIFY;
                //ND Tri1.0 End
            end;
        }
        field(50011; "Discount Charge"; Code[10])
        {
            //15578 TableRelation = "Tax/Charge Group";
        }
        field(50012; "Tax Exempted"; Boolean)
        {
        }
        field(50013; "Tax 1"; Code[20])
        {
        }
        field(50014; "Tax 2"; Code[20])
        {
        }
        field(50015; "Tax 3"; Code[20])
        {
        }
        field(50016; "SMS Updatation"; Boolean)
        {
            Description = 'MSBS.Rao Dt. 24-04-13';
        }
        field(50018; AddInsuranceDisc; Code[10])
        {
        }
        field(50019; "Posting Date Changed On"; Date)
        {
        }
        field(50020; "Trade Discount Charge"; Code[10])
        {
            //15578 TableRelation = "Tax/Charge Group";
        }
        field(50021; "TDS Inv. Rounding Precision"; Decimal)
        {
            Caption = 'TDS Inv. Rounding Precision';
            DataClassification = ToBeClassified;
        }
        field(50022; "TDS Inv. Rounding Type"; Option)
        {
            Caption = 'TDS Inv. Rounding Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest,Up,Down;
        }
        field(50023; "TDS Inv. Rounding Account"; Code[20])
        {
            Caption = 'TDS Inv. Rounding Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" WHERE(Blocked = CONST(false),
                                                 "Account Type" = FILTER(Posting));
        }
    }

    var
        Dim: Record Dimension;
        Text023: Label '%1\You cannot use the same dimension twice in the same setup.';
}

