table 50052 "Customer Group"
{

    fields
    {
        field(1; "No."; Code[10])
        {
        }
        field(2; "Group Type"; Option)
        {
            OptionCaption = 'State,Customer Type,Customer';
            OptionMembers = State,"Customer Type",Customer;
        }
        field(3; "Code"; Code[20])
        {

            trigger OnValidate()
            begin
                TESTFIELD(All, FALSE);

                // For States
                CustGroup.RESET;
                CustGroup.SETRANGE("Group Type", "Group Type"::State);
                CustGroup.SETRANGE("Include/Exclude", "Include/Exclude"::Include);
                CustGroup.SETRANGE(All, TRUE);
                IF CustGroup.FINDFIRST THEN
                    //ERROR(Text50001,CustGroup."No.");

                    // For Customer type
                    CustGroup.RESET;
                CustGroup.SETRANGE("Group Type", "Group Type"::"Customer Type");
                CustGroup.SETRANGE("Include/Exclude", "Include/Exclude"::Include);
                CustGroup.SETRANGE(All, TRUE);
                IF CustGroup.FINDFIRST THEN
                    // ERROR(Text50003,CustGroup."No.");

                    // For Customer
                    CustGroup.RESET;
                CustGroup.SETRANGE("Group Type", "Group Type"::Customer);
                CustGroup.SETRANGE("Include/Exclude", "Include/Exclude"::Include);
                CustGroup.SETRANGE(All, TRUE);
                IF CustGroup.FINDFIRST THEN;
                //ERROR(Text50005,CustGroup."No.");
            end;
        }
        field(4; "Include/Exclude"; Option)
        {
            OptionMembers = Include,Exclude;

            trigger OnValidate()
            begin
                IF "Include/Exclude" = "Include/Exclude"::Include THEN
                    VALIDATE(Code);
            end;
        }
        field(5; "Line No."; Integer)
        {
        }
        field(10; All; Boolean)
        {

            trigger OnValidate()
            begin
                TESTFIELD(Code, '');

                // For States
                CustGroup.RESET;
                CustGroup.SETRANGE("Group Type", "Group Type"::State);
                CustGroup.SETRANGE("Include/Exclude", "Include/Exclude"::Include);
                CustGroup.SETFILTER(Code, '<>%1', '');
                IF CustGroup.FINDFIRST THEN
                    //ERROR(Text50000,CustGroup."No.");

                    // For Customer Type
                    CustGroup.RESET;
                CustGroup.SETRANGE("Group Type", "Group Type"::"Customer Type");
                CustGroup.SETRANGE("Include/Exclude", "Include/Exclude"::Include);
                CustGroup.SETFILTER(Code, '<>%1', '');
                IF CustGroup.FINDFIRST THEN
                    //ERROR(Text50002,CustGroup."No.");

                    // For Customer
                    CustGroup.RESET;
                CustGroup.SETRANGE("Group Type", "Group Type"::Customer);
                CustGroup.SETRANGE("Include/Exclude", "Include/Exclude"::Include);
                CustGroup.SETFILTER(Code, '<>%1', '');
                IF CustGroup.FINDFIRST THEN;
                //ERROR(Text50004,CustGroup."No.");
            end;
        }
        field(11; Description; Text[100])
        {
        }
        field(12; "Valid From"; Date)
        {
        }
        field(13; "Valid To"; Date)
        {
        }
        field(14; Status; Option)
        {
            OptionCaption = ' ,Enable,Disable';
            OptionMembers = " ",Enable,Disable;
        }
        field(15; "State Name"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Group Type", "Code", "Include/Exclude", All, "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Status, "Valid From", "Valid To", All)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        DiscountHeader.RESET;
        DiscountHeader.SETRANGE("No.", "No.");
        IF DiscountHeader.FIND('-') THEN BEGIN
            Status := DiscountHeader.Status;
        END;
        IF Status = Status::Enable THEN BEGIN
            ERROR(Text50006);
        END;
    end;

    trigger OnInsert()
    begin
        CustGroup.RESET;
        CustGroup.SETRANGE("No.", "No.");
        CustGroup.SETRANGE("Group Type", "Group Type");
        CustGroup.SETRANGE(Code, Code);
        IF CustGroup.FIND('-') THEN
            REPEAT
                IF CustGroup."Line No." <> "Line No." THEN
                    ERROR(Text50002, "Group Type", "No.");

            UNTIL CustGroup.NEXT = 0;
    end;

    trigger OnModify()
    begin
        DiscountHeader.RESET;
        DiscountHeader.SETRANGE("No.", "No.");
        IF DiscountHeader.FIND('-') THEN BEGIN
            Status := DiscountHeader.Status;
        END;
        IF Status = Status::Enable THEN BEGIN
            //ERROR(Text50006);
        END;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        CustGroup: Record "Customer Group";
        Text50000: Label 'State(s) already defined for Discount No. %1.';
        Text50001: Label 'All States are defined for Discount No. %1.';
        Text50002: Label 'This Group Type %1 already defined for Discount No. %2 .';
        Text50003: Label 'All Customer Types are defined for Discount No. %1.';
        Text50004: Label 'Customer(s) already defined for Discount No. %1.';
        Text50005: Label 'All Customer are defined for Discount No. %1.';
        DiscountHeader: Record "Discount Header";
        Status: Option " ",Enable,Disable;
        Text50006: Label 'You cannot change Discount offer after it Enabled.';
}

