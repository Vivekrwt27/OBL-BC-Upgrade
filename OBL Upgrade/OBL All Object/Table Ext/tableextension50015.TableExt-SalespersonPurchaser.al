tableextension 50015 tableextension50015 extends "Salesperson/Purchaser"
{
    fields
    {
        modify("E-Mail")// 15578
        {
            trigger OnBeforeValidate()
            begin
                IF "E-Mail" <> '' THEN
                    FOR I := 1 TO STRLEN("E-Mail") DO BEGIN
                        IF (COPYSTR("E-Mail", I, 1) IN ['"', ' ']) OR (STRPOS("E-Mail", '@') = 0) THEN
                            ERROR('Email is Invalid');
                    END;

            end;
        }

        field(50000; "Customer No."; Code[20])
        {
            Description = 'Customization No. 26';
            TableRelation = Customer."No.";
        }
        field(50001; Dimension; Code[20])
        {

            trigger OnLookup()
            begin
                //ND Tri1.0 start
                GLSetUp.GET;
                DimValue.SETFILTER("Dimension Code", '%1', GLSetUp."Employee Dimension Code");
                IF DimValue.FIND('-') THEN
                    IF PAGE.RUNMODAL(PAGE::"Dimension Value List", DimValue) = ACTION::LookupOK THEN
                        Dimension := DimValue.Code;
                //ND Tri1.0 end
            end;
        }
        field(50002; "Customer Name"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Customer No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Customer City"; Text[30])
        {
            CalcFormula = Lookup(Customer.City WHERE("No." = FIELD("Customer No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Customer State"; Text[100])
        {
            CalcFormula = Lookup(Customer."State Desc." WHERE("No." = FIELD("Customer No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Emp Code"; Code[10])
        {
        }
        field(50006; Status; Option)
        {
            OptionCaption = ' ,Enable,Disabled,COCO';
            OptionMembers = " ",Enable,Disabled,COCO;
        }
        field(50007; PCH; Boolean)
        {
        }
        field(50008; "Sales Person"; Boolean)
        {
        }
        field(50009; "Is Coco"; Boolean)
        {
        }
        field(50010; "Sub-Ordinate (Leave)"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(50011; "G E T"; Boolean)
        {
        }
        field(50012; Set; Boolean)
        {
        }
        field(50013; OBTB; Boolean)
        {
        }
        field(50014; "Margin Display"; Boolean)
        {
        }
        field(50015; "Tableau Zone"; Text[30])
        {
        }
        field(50016; Pet; Boolean)
        {
        }
        field(50017; Misc; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Date of Bith"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(80000; Type; Option)
        {
            OptionCaption = ' ,PCH,Zone Manager,PSM,PAC,Zonal Heads';
            OptionMembers = " ",PCH,"Zone Manager",PSM,PAC,"Zonal Heads";

            trigger OnValidate()
            begin
                PCH := (Type = Type::PCH);
            end;
        }
        field(80001; "HQ Town"; Text[50])
        {
        }
        field(80002; "Joining Date"; Date)
        {
        }
        field(80003; "Last Year DSO"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(80004; "Last Year ASP"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(80005; "SP Sales Territory"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(80006; "SP Jone"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(80007; "Employee Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Sales Person,Branch Head,Zonal Manager,Zonal Head';
            OptionMembers = " ","Sales Person","Branch Head","Zonal Manager","Zonal Head";

            trigger OnValidate()
            begin
                CASE "Employee Type" OF
                    "Employee Type"::"Sales Person":
                        Type := Type::" ";
                    "Employee Type"::"Branch Head":
                        Type := Type::PCH;
                    "Employee Type"::"Zonal Manager":
                        Type := Type::"Zone Manager";
                    "Employee Type"::"Zonal Head":
                        Type := Type::"Zonal Heads";

                END;
            end;
        }
        field(80008; "Last Year Range Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(80009; "Credit Approver Matrix"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,CA1,CA2,CA3,CA4,CA5';
            OptionMembers = " ",CA1,CA2,CA3,CA4,CA5;
        }
        field(80010; "Credit Approver Limit-A"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(80011; "Credit Approver Limit-B"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(80012; "Credit Approver Limit-C"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key5; Name)
        {
        }
    }

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: DropDown)".


    var
        I: Integer;
        GLSetUp: Record "General Ledger Setup";
        DimValue: Record "Dimension Value";
        DefDim: Record "Default Dimension";
}

