table 50098 "Sales Person Goal Target"
{

    fields
    {
        field(1; "Field Force Code"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(5; "FF Type"; Option)
        {
            OptionCaption = ' ,Sales Person,PCH,Zonal Manager,ZH';
            OptionMembers = " ","Sales Person",PCH,"Zonal Manager",ZH;
        }
        field(10; Period; Date)
        {

            trigger OnValidate()
            begin
                IF "FF Type" = "FF Type"::"Sales Person" THEN BEGIN
                    IF DATE2DMY(Period, 1) <> 1 THEN
                        ERROR('Please check the Period Date');
                END;
                Date := UpdatePeriod("Target Type", Period);
            end;
        }
        field(20; "Target Type"; Option)
        {
            OptionCaption = 'Monthly,Annually';
            OptionMembers = Monthly,Annually;

            trigger OnValidate()
            begin
                IF "FF Type" = "FF Type"::"Sales Person" THEN BEGIN
                    Date := UpdatePeriod("Target Type", Period);
                END;
            end;
        }
        field(30; "Revenue Target"; Decimal)
        {
        }
        field(40; "Base Range Sales Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; Date; Date)
        {
        }
        field(55; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(56; Name; Text[50])
        {
            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE(Code = FIELD("Field Force Code")));
            Editable = false;
            Enabled = true;
            FieldClass = FlowField;
        }
        field(57; "City Name"; Text[30])
        {
            CalcFormula = Lookup("Post Code".City WHERE(Code = FIELD("Post Code")));
            Editable = false;
            Enabled = true;
            FieldClass = FlowField;
        }
        field(58; Inventive; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Range Sales Target"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'SRCC';
        }
        field(60; Attrition; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Total Team Members"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Last Year Focus Sales"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "FF Type", "Field Force Code", "Target Type", Period, "Post Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "FF Type" = "FF Type"::"Sales Person" THEN BEGIN
            IF DATE2DMY(Period, 1) <> 1 THEN
                ERROR('Please check the Period Date');
        END;
    end;

    procedure UpdatePeriod(TType: Option Monthly,Annually; Dt: Date) PerriodDt: Date
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        IF TType = TType::Monthly THEN
            PerriodDt := CALCDATE('-CM', Dt);

        IF TType = TType::Annually THEN BEGIN
            AccountingPeriod.RESET;
            AccountingPeriod.SETFILTER("Starting Date", '<=%1', Dt);
            AccountingPeriod.SETFILTER("New Fiscal Year", '%1', TRUE);
            IF AccountingPeriod.FINDLAST THEN
                PerriodDt := CALCDATE('-CM', AccountingPeriod."Starting Date");
        END;
    end;
}

