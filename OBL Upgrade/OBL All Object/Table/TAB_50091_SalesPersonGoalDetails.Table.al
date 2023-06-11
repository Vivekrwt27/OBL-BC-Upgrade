table 50091 "Sales Person Goal Details"
{

    fields
    {
        field(1; "Field Force Code"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(2; "FF Type"; Option)
        {
            OptionCaption = ' ,Sales Person,PCH,Zonal Manager,ZH';
            OptionMembers = " ","Sales Person",PCH,"Zonal Manager",ZH;
        }
        field(5; "Joining Date"; Date)
        {

            trigger OnValidate()
            begin
                IF "Revenue for the Year Date" < "Joining Date" THEN
                    "Revenue for the Year Date" := "Joining Date";
            end;
        }
        field(10; PCH; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(20; ZM; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(30; ZH; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(50; Territory; Code[10])
        {
        }
        field(55; "For Month"; Date)
        {
        }
        field(57; "Annual Revenue Target"; Decimal)
        {
        }
        field(60; "Revenue Target"; Decimal)
        {

            trigger OnValidate()
            begin
                "Percentage Achieved" := FieldForceGoalMgt.CalculatePercentage("Revenue Achieved", "Revenue Target");
                CalculatePointsONRevenue("FF Type", "Percentage Achieved");
            end;
        }
        field(70; "Revenue Achieved"; Decimal)
        {

            trigger OnValidate()
            begin
                "Percentage Achieved" := FieldForceGoalMgt.CalculatePercentage("Revenue Achieved", "Revenue Target");
                CalculatePointsONRevenue("FF Type", "Percentage Achieved");
            end;
        }
        field(72; "Revenue Qty."; Decimal)
        {
        }
        field(75; "Percentage Achieved"; Decimal)
        {
        }
        field(78; "Points on Revenue"; Decimal)
        {
        }
        field(80; "90 Days Sale"; Decimal)
        {

            trigger OnValidate()
            begin
                UpdateOtherFields;
            end;
        }
        field(90; "Average Last 12 Month Sale"; Decimal)
        {

            trigger OnValidate()
            begin
                UpdateOtherFields;
            end;
        }
        field(150; Outstanding; Decimal)
        {

            trigger OnValidate()
            begin
                UpdateOtherFields;
            end;
        }
        field(160; "Outstanding per Day"; Decimal)
        {
        }
        field(190; "Points on Outstanding"; Decimal)
        {
        }
        field(210; ASP; Decimal)
        {
        }
        field(220; "Points on ASP"; Decimal)
        {
        }
        field(300; "CD Sales"; Decimal)
        {
        }
        field(305; "CD Qty."; Decimal)
        {
        }
        field(310; "Point on CD"; Decimal)
        {
        }
        field(320; "Billing Per. Month CD"; Decimal)
        {
            Description = 'MSAK';
        }
        field(400; "PMT Sales"; Decimal)
        {
        }
        field(405; "PMT Qty."; Decimal)
        {
        }
        field(410; "Points on PMT"; Decimal)
        {
        }
        field(420; "Billing Per. Month PMT"; Decimal)
        {
            Description = 'MSAK';
        }
        field(500; "Focus Sale"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(510; "Focus Sale Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(520; "Focus Sale Count"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(530; "Focus Sale Points"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(540; "Focus Sale Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(550; "YTD Focus Sales"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5000; "Total Points Earned"; Decimal)
        {
        }
        field(5010; Ranking; Integer)
        {
        }
        field(6000; "OBTP Sales - Same Growth"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6010; "OBTP LY Sales - Same Growth"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6015; "OBTP Strong Market"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6020; "OBTP Count - Same Growth"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10000; "Revenue for the Start Date"; Date)
        {
        }
        field(10001; "Revenue for the End Date"; Date)
        {
        }
        field(10002; "Revenue for the Year Date"; Date)
        {
        }
        field(19990; "YTD Target"; Decimal)
        {
        }
        field(20000; "YTD Revenue Achieved"; Decimal)
        {
        }
        field(20001; "YTD Revenue Qty."; Decimal)
        {
        }
        field(20002; "YTD CD Sales"; Decimal)
        {
        }
        field(20004; "YTD CD Qty."; Decimal)
        {
        }
        field(20010; "YTD PMT Sales"; Decimal)
        {
        }
        field(20015; "YTD PMT Qty."; Decimal)
        {
        }
        field(20017; "YTD DSO Points"; Decimal)
        {
        }
        field(20050; "YTD Revenue Points"; Decimal)
        {
        }
        field(20051; "YTD CD Points"; Decimal)
        {
        }
        field(20052; "YTD PMT Points"; Decimal)
        {
        }
        field(20053; "YTD ASP Points"; Decimal)
        {
        }
        field(20054; "Tableau Zone"; Text[10])
        {
            //16225 CalcFormula = Lookup(Customer."Tableau Zone" WHERE("Salesperson Code" = FIELD("Force Code")));
            FieldClass = FlowField;
        }
        field(20055; "Total YTD Points Earned"; Decimal)
        {
        }
        field(20056; "YTD Ranking"; Decimal)
        {
        }
        field(20057; "Base Line Last Year"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20058; "Creation Sales"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20059; "Revival Sales"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20060; "YTD Creation Sales"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20061; "YTD Revival Sales"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20064; "Points on Creation/Revival"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20065; "YTD Creation/Revival Points"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20066; "No. of Sales Force"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20067; "No. of Months"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(30000; "LY Sales"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30010; "CY Sales"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30020; "CY Cust. Count"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30021; "Strong Market"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30022; "Points on Market Type"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30030; "YTD LY Sales"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30040; "YTD CY Sales"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30050; "YTD CY Cust. Count"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30060; "YTD Points on Market Type"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30065; "Points on Same Sales Growth"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30067; "YTDPoints on Same Sales Growth"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30070; "Points on New SAles Growth"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30072; "YTDPoints on New SAles Growth"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30080; "Total No. of CP"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30088; "Total No. of CP Greater 2L"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30090; "Pt. on CP Counts"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30095; "YTD Pt. on CP Counts"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30100; "No. of Attrition"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30110; "Total Team Members"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30120; "Pts. on Attrition"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30130; "Outstanding 75 DAys"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30140; "Last Revenue 90 Days"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30150; "Pts. on Increase Cash FLow"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30155; "LY Sales New Market"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30157; "CY Sales New Market"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30158; "CY Cust. Count New Market"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30160; "YTD LY Sales New Market"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30170; "YTD CY Sales New Market"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30180; "YTD CY Cust. Count New Market"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30190; "YTD Pts. on Attrition"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(30191; "Total No. CP Count Week Mkt CY"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ZH';
        }
        field(40000; "Last Year DSO"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40001; "Point On DSO"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40002; "Last Year Focus Sales (Same P)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40003; "Last Year Focus Sales Qty.(SP)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40004; "AOP % Age Total Revenue"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40010; "Revival Sales Contribution %ag"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40011; "PMT Opportunity Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40012; "Last Year ASP"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40013; "PMT Opportunity Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PMT Opp. Qty.  * Last Year ASP';
        }
        field(40015; "PMT Opportunity Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40016; "Focus AOP Growth %age"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40019; "YTD Base Line Sales"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40020; "YTD AOP % Age Total Revenue"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40022; "YTD Focus AOP Growth %age"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40023; "YTD Last Year Focus Sale"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40024; "YTD LY Focus Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "FF Type", "Field Force Code", "For Month")
        {
            Clustered = true;
            SumIndexFields = "Last Year Focus Sales (Same P)", "Focus Sale Target", "Focus Sale";
        }
        key(Key2; "For Month", "Total Points Earned")
        {
        }
        key(Key3; "For Month", "Total YTD Points Earned")
        {
        }
    }

    fieldgroups
    {
    }

    var
        FieldForceGoalMgt: Codeunit "SP  PCH Goal Sheet Calculation"; //16225 CODUNIT N/F

    procedure CalculatePointsONRevenue(FFType: Option " ","Sales Person",PCH,"Zonal Manager",ZH; PercentageofRevenue: Decimal) Points: Decimal
    var
        BasePoint: Decimal;
        BaseConst: Decimal;
    begin
        BasePoint := 40;
        //PercentageofRevenue := ROUND(PercentageofRevenue,0.5,'=');

        IF FFType = FFType::PCH THEN BEGIN
            IF PercentageofRevenue > 150 THEN
                PercentageofRevenue := 150;

            PercentageofRevenue := ROUND(PercentageofRevenue, 0.01, '=');
            CASE PercentageofRevenue OF
                90 .. 94.99:
                    BaseConst := 17.5;
                95 .. 99.99:
                    BaseConst := 28;
                100 .. 104.99:
                    BaseConst := 35;
                105 .. 109.99:
                    BaseConst := 43.75;
                110 .. 9999:
                    BaseConst := 52.5;
            END;
        END ELSE
            IF FFType = FFType::"Sales Person" THEN BEGIN
                IF PercentageofRevenue > 150 THEN
                    PercentageofRevenue := 150;

                PercentageofRevenue := ROUND(PercentageofRevenue, 0.01, '=');
                CASE PercentageofRevenue OF
                    90 .. 94.99:
                        BaseConst := 20;
                    95 .. 99.99:
                        BaseConst := 32;
                    100 .. 104.99:
                        BaseConst := 40;
                    105 .. 109.99:
                        BaseConst := 50;
                    110 .. 9999:
                        BaseConst := 60;
                END;

            END ELSE BEGIN
                IF PercentageofRevenue > 150 THEN
                    PercentageofRevenue := 150;

                PercentageofRevenue := ROUND(PercentageofRevenue, 0.01, '=');
                CASE PercentageofRevenue OF
                    90 .. 94.99:
                        BaseConst := 15;
                    95 .. 99.99:
                        BaseConst := 24;
                    100 .. 104.99:
                        BaseConst := 30;
                    105 .. 109.99:
                        BaseConst := 37.5;
                    110 .. 9999:
                        BaseConst := 45;
                END;
            END;

        //"Points on Revenue" := (BaseConst);

        //EXIT((BaseConst*BasePoint/100)); //Last YEar
        EXIT(BaseConst);
    end;

    procedure CalculateASP(Value: Decimal; Qty: Decimal) DecASp: Decimal
    begin
        IF Qty <> 0 THEN
            DecASp := Value / Qty ELSE
            DecASp := 0;
    end;

    procedure CalculatePointsONASP(ASP: Decimal) Points: Decimal
    var
        BasePoint: Decimal;
        BaseConst: Decimal;
    begin
        BasePoint := 15;
        ASP := ROUND(ASP, 0.01, '=');
        /*19-20
        CASE ASP OF
          0..199.99:
            BaseConst :=0;
          200..224.99:
            BaseConst :=40;
          225..249.99:
            BaseConst:= 60;
          250..274.99:
            BaseConst:= 100;
          275..289.99:
            BaseConst:= 120;
          290..9999:
            BaseConst:= 135;
        
        END;
        //20-21
        CASE ASP OF
          0..199.99:
            BaseConst :=0;
          200..224.99:
            BaseConst :=6;
          225..249.99:
            BaseConst:= 9;
          250..274.99:
            BaseConst:= 15;
          275..289.99:
            BaseConst:= 18;
          290..9999:
            BaseConst:= 20;
        END;
        */
        //21-22
        CASE ASP OF
            0 .. 199.99:
                BaseConst := 0;
            200 .. 224.99:
                BaseConst := 6;
            225 .. 249.99:
                BaseConst := 9;
            250 .. 274.99:
                BaseConst := 15;
            275 .. 289.99:
                BaseConst := 18;
            290 .. 9999:
                BaseConst := 20;
        END;
        //"Points on ASP" := (BaseConst*BasePoint/100);

        //EXIT((BaseConst*BasePoint/100)); Last Year
        EXIT((BaseConst));

    end;

    procedure CalculatePointsOnOutstanding(FFType: Option " ","Sales Person",PCH,"Zonal Manager",ZH; OutDays: Decimal; LastYearDays: Decimal) Points: Decimal
    var
        BasePoint: Decimal;
        BaseConst: Decimal;
        DecInDSO: Decimal;
        PointonDSO: Decimal;
        ProtectionVar: Decimal;
    begin
        CASE FFType OF
            FFType::"Sales Person":
                BEGIN
                    BasePoint := 15;
                    IF LastYearDays = 0 THEN EXIT;
                    DecInDSO := (LastYearDays - OutDays) / LastYearDays * 100;
                    CASE LastYearDays OF
                        0.01 .. 15:
                            BEGIN
                                ProtectionVar := 0.3;
                                DecInDSO := (LastYearDays - OutDays) / LastYearDays * 100;
                                IF DecInDSO > 15 THEN
                                    EXIT(15) ELSE BEGIN
                                    //IF (DecInDSO >= CalcProtectionRange(DecInDSO,ProtectionVar,FALSE)) AND (DecInDSO >= CalcProtectionRange(DecInDSO,ProtectionVar,TRUE)) THEN
                                    IF (OutDays >= CalcProtectionRange(LastYearDays, ProtectionVar, FALSE)) AND (OutDays <= CalcProtectionRange(LastYearDays, ProtectionVar, TRUE)) THEN
                                        EXIT(10);
                                END;
                            END;
                        15.01 .. 30:
                            BEGIN
                                ProtectionVar := 0.2;
                                DecInDSO := (LastYearDays - OutDays) / LastYearDays * 100;
                                IF DecInDSO > 15 THEN
                                    EXIT(15) ELSE BEGIN
                                    //IF (DecInDSO >= CalcProtectionRange(DecInDSO,ProtectionVar,FALSE)) AND (DecInDSO >= CalcProtectionRange(DecInDSO,ProtectionVar,TRUE)) THEN
                                    IF (OutDays >= CalcProtectionRange(LastYearDays, ProtectionVar, FALSE)) AND (OutDays <= CalcProtectionRange(LastYearDays, ProtectionVar, TRUE)) THEN
                                        EXIT(10);
                                END;
                            END;
                        30.01 .. 45:
                            BEGIN
                                ProtectionVar := 0.1;
                                DecInDSO := ROUND((LastYearDays - OutDays) / LastYearDays * 100);
                                IF DecInDSO > 15 THEN
                                    EXIT(15) ELSE BEGIN
                                    //IF (DecInDSO >= CalcProtectionRange(DecInDSO,ProtectionVar,FALSE)) AND (DecInDSO >= CalcProtectionRange(DecInDSO,ProtectionVar,TRUE)) THEN
                                    IF (OutDays >= CalcProtectionRange(LastYearDays, ProtectionVar, FALSE)) AND (OutDays <= CalcProtectionRange(LastYearDays, ProtectionVar, TRUE)) THEN
                                        EXIT(10);
                                END;
                            END;
                        45.01 .. 99999999:
                            CASE DecInDSO OF
                                0.01 .. 5:
                                    BaseConst := 0;
                                5.01 .. 10:
                                    BaseConst := 7.5;
                                10.01 .. 15:
                                    BaseConst := 15;
                                15.01 .. 9999:
                                    BaseConst := 22.5;
                            END;
                    END;
                END;
            FFType::PCH:
                BEGIN
                    BasePoint := 15;
                    IF LastYearDays = 0 THEN EXIT;
                    DecInDSO := (LastYearDays - OutDays) / LastYearDays * 100;
                    CASE LastYearDays OF
                        0.01 .. 15:
                            BEGIN
                                ProtectionVar := 0.3;
                                DecInDSO := (LastYearDays - OutDays) / LastYearDays * 100;
                                IF DecInDSO > 15 THEN
                                    EXIT(15) ELSE BEGIN
                                    //IF (DecInDSO >= CalcProtectionRange(DecInDSO,ProtectionVar,FALSE)) AND (DecInDSO >= CalcProtectionRange(DecInDSO,ProtectionVar,TRUE)) THEN
                                    IF (OutDays >= CalcProtectionRange(LastYearDays, ProtectionVar, FALSE)) AND (OutDays <= CalcProtectionRange(LastYearDays, ProtectionVar, TRUE)) THEN
                                        EXIT(10);
                                END;
                            END;
                        15.01 .. 30:
                            BEGIN
                                ProtectionVar := 0.2;
                                DecInDSO := (LastYearDays - OutDays) / LastYearDays * 100;
                                IF DecInDSO > 15 THEN
                                    EXIT(15) ELSE BEGIN
                                    //IF (DecInDSO >= CalcProtectionRange(DecInDSO,ProtectionVar,FALSE)) AND (DecInDSO >= CalcProtectionRange(DecInDSO,ProtectionVar,TRUE)) THEN
                                    IF (OutDays >= CalcProtectionRange(LastYearDays, ProtectionVar, FALSE)) AND (OutDays <= CalcProtectionRange(LastYearDays, ProtectionVar, TRUE)) THEN
                                        EXIT(10);
                                END;
                            END;
                        30.01 .. 45:
                            BEGIN
                                ProtectionVar := 0.1;
                                DecInDSO := ROUND((LastYearDays - OutDays) / LastYearDays * 100);
                                IF DecInDSO > 15 THEN
                                    EXIT(15) ELSE BEGIN
                                    //IF (DecInDSO >= CalcProtectionRange(DecInDSO,ProtectionVar,FALSE)) AND (DecInDSO >= CalcProtectionRange(DecInDSO,ProtectionVar,TRUE)) THEN
                                    IF (OutDays >= CalcProtectionRange(LastYearDays, ProtectionVar, FALSE)) AND (OutDays <= CalcProtectionRange(LastYearDays, ProtectionVar, TRUE)) THEN
                                        EXIT(10);
                                END;
                            END;
                        45.01 .. 99999999:
                            CASE DecInDSO OF
                                0.01 .. 5:
                                    BaseConst := 0;
                                5.01 .. 10:
                                    BaseConst := 5;
                                10.01 .. 15:
                                    BaseConst := 10;
                                15.01 .. 9999:
                                    BaseConst := 15;
                            END;
                    END;
                END;
        END;
        EXIT((BaseConst));
    end;

    procedure UpdateOtherFields()
    var
        FieldForceGoalMgt: Codeunit "SP  PCH Goal Sheet Calculation";//16225 CODEUNIT N/F
        YtdAsp: Decimal;
        YtdPMT: Decimal;
        YTDCD: Decimal;
        PointonPMT: Decimal;
        YtdDSOCnt: Decimal;
        YTDDSO: Decimal;
        SalesPersonGoalDetails: Record "Sales Person Goal Details";
        YTDDSOPoint: Decimal;
    begin
        //Score Calculation
        YTDDSOPoint := 0;
        SalesPersonGoalDetails.RESET;
        SalesPersonGoalDetails.SETFILTER("For Month", '%1..%2', 20220104D, "For Month");//16225 //040122D Replace 20220104D  
        SalesPersonGoalDetails.SETFILTER("FF Type", '%1', "FF Type");
        SalesPersonGoalDetails.SETFILTER("Field Force Code", '%1', "Field Force Code");
        IF SalesPersonGoalDetails.FINDFIRST THEN BEGIN
            YtdDSOCnt := SalesPersonGoalDetails.COUNT;
            REPEAT
                YTDDSO += SalesPersonGoalDetails."Outstanding per Day";
            UNTIL SalesPersonGoalDetails.NEXT = 0;
        END;

        IF YtdDSOCnt <> 0 THEN
            YTDDSO := YTDDSO / YtdDSOCnt;

        //YTDDSOPoint := SalesPersonGoalDetails.CalculatePointsOnOutstanding(YTDDSO,SalesPersonGoalDetails."Last Year DSO");

        YTDDSOPoint := SalesPersonGoalDetails.CalculatePointsOnOutstanding(SalesPersonGoalDetails."FF Type", YTDDSO, SalesPersonGoalDetails."Last Year DSO");

        "Average Last 12 Month Sale" := "90 Days Sale" / 90;

        IF "Average Last 12 Month Sale" <> 0 THEN
            "Outstanding per Day" := Outstanding / "Average Last 12 Month Sale"
        ELSE
            "Outstanding per Day" := 0;

        "Points on Outstanding" := SalesPersonGoalDetails.CalculatePointsOnOutstanding("FF Type", Rec."Outstanding per Day", "Last Year DSO");

        "Billing Per. Month CD" := FieldForceGoalMgt.CalculatePercentage("CD Sales", "Revenue Achieved");
        //"Billing Per. Month PMT" := FieldForceGoalMgt.CalculatePercentage("PMT Sales","Revenue Achieved");
        "Billing Per. Month PMT" := FieldForceGoalMgt.CalculatePercentage("PMT Sales", "Revenue Target");

        "Point On DSO" := CalculatePointsOnOutstanding("FF Type", "Outstanding per Day", "Last Year DSO");
        //"Point on CD":= CalculatePointsOnCD("Billing Per. Month CD");



        YtdAsp := CalculateASP("YTD Revenue Achieved", "YTD Revenue Qty.");
        //YtdPMT := FieldForceGoalMgt.CalculatePercentage("YTD PMT Sales","YTD Revenue Achieved");
        YtdPMT := FieldForceGoalMgt.CalculatePercentage("YTD PMT Sales", "YTD Target");
        YTDCD := FieldForceGoalMgt.CalculatePercentage("YTD CD Sales", "YTD Revenue Achieved");

        "YTD ASP Points" := CalculatePointsONASP(YtdAsp);
        "YTD CD Points" := CalculatePointsOnCD(YTDCD);
        "YTD PMT Points" := CalculatePointsOnCD(YtdPMT);
        "YTD Revenue Points" := CalculatePointsONRevenue("FF Type", FieldForceGoalMgt.CalculatePercentage("YTD Revenue Achieved", "YTD Target"));

        "Total Points Earned" := "Points on Revenue" + "Points on Outstanding" + "Points on ASP" + "Points on PMT";

        //Note YTD CD Point = YTD Revenue Point
        "YTD DSO Points" := YTDDSOPoint;
        "Total YTD Points Earned" := "YTD Revenue Points" + "YTD PMT Points" + YTDDSOPoint + "YTD ASP Points"; //MSAK 020819

        IF "Joining Date" <> 0D THEN
            IF "Revenue for the Year Date" < "Joining Date" THEN
                "Revenue for the Year Date" := "Joining Date";
    end;

    procedure CalculatePointsOnCD(CDPercentage: Decimal) Points: Decimal
    var
        BasePoint: Decimal;
        BaseConst: Decimal;
    begin
        BasePoint := 15;
        //"Point on CD" := (CDPercentage*BasePoint/100);

        EXIT((CDPercentage * BasePoint / 100));
    end;

    procedure CalculatePointsOnPMT(FFType: Option " ","Sales Person",PCH,"Zonal Manager",ZH; PMTPercentage: Decimal): Decimal
    var
        BasePoint: Decimal;
        BaseConst: Decimal;
        PointonPMT: Decimal;
    begin
        /*
        BasePoint := 15;
        IF PMTPercentage >= 20 THEN
          PointonPMT := BasePoint
        ELSE
          PointonPMT := (BasePoint/20)*PMTPercentage;
        
        */
        IF FFType = FFType::"Sales Person" THEN BEGIN
            BasePoint := 15;

            CASE PMTPercentage OF
                0 .. 14.99:
                    BaseConst := 0;
                15.0 .. 19.99:
                    BaseConst := 7.5;
                20.0 .. 25:
                    BaseConst := 15;
                25.01 .. 9999:
                    BaseConst := 18.75;
            END;
        END;
        IF FFType = FFType::PCH THEN BEGIN
            BasePoint := 15;

            CASE PMTPercentage OF
                0 .. 14.99:
                    BaseConst := 0;
                15.0 .. 19.99:
                    BaseConst := 7.5;
                20.0 .. 25:
                    BaseConst := 15;
                25.01 .. 9999:
                    BaseConst := 18.75;
            END;
        END;
        IF FFType IN [FFType::"Zonal Manager", FFType::ZH] THEN BEGIN
            BasePoint := 15;

            CASE PMTPercentage OF
                0 .. 14.99:
                    BaseConst := 0;
                15.0 .. 19.99:
                    BaseConst := 5;
                20.0 .. 25:
                    BaseConst := 10;
                25.01 .. 9999:
                    BaseConst := 12.5;
            END;
        END;

        EXIT(BaseConst);

    end;

    procedure CalculatePointsOnRevivalSales(FFType: Option " ","Sales Person",PCH,"Zonal Manager",ZH; RevivalSales: Decimal): Decimal
    var
        BasePoint: Decimal;
        BaseConst: Decimal;
        PointonPMT: Decimal;
    begin
        IF FFType IN [FFType::ZH, FFType::"Zonal Manager"] THEN BEGIN
            RevivalSales := ROUND(RevivalSales, 1, '=');
            CASE RevivalSales OF
                0 .. 9.99:
                    EXIT(0);
                10.0 .. 19.99:
                    EXIT(5);
                20.0 .. 29.99:
                    EXIT(10);
                30.0 .. 2000000:
                    EXIT(12.5);
            END;
        END;
        IF FFType IN [FFType::"Sales Person"] THEN BEGIN
            CASE RevivalSales OF
                0 .. 9.99:
                    EXIT(0);
                10.0 .. 19.99:
                    EXIT(7.5);
                20.0 .. 29.99:
                    EXIT(15);
                30.0 .. 2000000:
                    EXIT(18.75);
            END;
        END;

        IF FFType = FFType::PCH THEN BEGIN
            CASE RevivalSales OF
                0 .. 9.99:
                    EXIT(0);
                10.0 .. 19.99:
                    EXIT(5);
                20.0 .. 29.99:
                    EXIT(10);
                30.0 .. 2000000:
                    EXIT(12.5);
            END;
        END;
    end;

    procedure CalculatePointsOnRangeSales(FFType: Option " ","Sales Person",PCH,"Zonal Manager",ZH; RangeSalesPoints: Decimal; TargetRangePoints: Decimal): Decimal
    var
        BasePoint: Decimal;
        BaseConst: Decimal;
        PointonPMT: Decimal;
    begin
        IF TargetRangePoints = 0 THEN EXIT;
        BaseConst := 15;
        //RangeSalesPoints := ROUND((RangeSalesPoints/TargetRangePoints)*100,0.01,'=');
        RangeSalesPoints := FieldForceGoalMgt.CalculateIncDecPercentage(TargetRangePoints, RangeSalesPoints);
        IF FFType = FFType::"Sales Person" THEN BEGIN
            CASE RangeSalesPoints OF
                0 .. 2.99:
                    EXIT(BaseConst * 50 / 100);
                3 .. 4.99:
                    EXIT(BaseConst * 80 / 100);
                5 .. 9.99:
                    EXIT(BaseConst * 100 / 100);
                10 .. 999999:
                    EXIT(BaseConst * 150 / 100);
            END;
        END;
        IF FFType = FFType::PCH THEN BEGIN
            BaseConst := 10;
            CASE RangeSalesPoints OF
                0 .. 2.99:
                    EXIT(BaseConst * 50 / 100);
                3 .. 4.99:
                    EXIT(BaseConst * 80 / 100);
                5 .. 9.99:
                    EXIT(BaseConst * 100 / 100);
                10 .. 999999:
                    EXIT(BaseConst * 150 / 100);
            END;
        END;
        IF FFType = FFType::"Zonal Manager" THEN BEGIN
            BaseConst := 10;
            CASE RangeSalesPoints OF
                0 .. 2.99:
                    EXIT(BaseConst * 50 / 100);
                3 .. 4.99:
                    EXIT(BaseConst * 80 / 100);
                5 .. 9.99:
                    EXIT(BaseConst * 100 / 100);
                10 .. 999999:
                    EXIT(BaseConst * 150 / 100);
            END;
        END;

        IF FFType = FFType::ZH THEN BEGIN
            BaseConst := 10;
            CASE RangeSalesPoints OF
                0 .. 2.99:
                    EXIT(BaseConst * 50 / 100);
                3 .. 4.99:
                    EXIT(BaseConst * 80 / 100);
                5 .. 9.99:
                    EXIT(BaseConst * 100 / 100);
                10 .. 999999:
                    EXIT(BaseConst * 150 / 100);
            END;
        END;
    end;

    procedure CalculatePointsonMarket(FFType: Option " ","Sales Person",PCH,"Zonal Manager"; MnthDate: Date; StrongMarketType: Boolean; LYSales: Decimal; CYSales: Decimal; Cnt: Decimal): Decimal
    var
        PercentageInc: Decimal;
        AvgSales: Decimal;
    begin
        IF FFType IN [FFType::PCH, FFType::"Zonal Manager"] THEN BEGIN
            IF StrongMarketType THEN BEGIN
                //IF DATE2DMY(MnthDate,2) IN [4,5,6] THEN EXIT(15);
                IF (CYSales - LYSales) < 0 THEN EXIT(0);
                IF LYSales = 0 THEN EXIT(0);
                PercentageInc := ROUND(((CYSales - LYSales) / LYSales) * 100);

                CASE PercentageInc OF
                    0.01 .. 9.99:
                        EXIT(0);
                    10 .. 14.99:
                        EXIT(5);
                    15 .. 20:
                        EXIT(10);
                    20.01 .. 9999999999999.0:
                        EXIT(15);
                END;
            END ELSE BEGIN
                IF Cnt <= 2 THEN EXIT(0);
                AvgSales := ROUND(CYSales / Cnt);
                CASE AvgSales OF
                    0 .. 699999:
                        EXIT(0);
                    700000 .. 799999:
                        EXIT(6);
                    800000 .. 899999:
                        EXIT(8);
                    900000 .. 999999:
                        EXIT(10);
                    1000000 .. 999999999:
                        EXIT(15);
                END;
            END;
        END;
    end;

    procedure CalculatePointsonSameStoreGrowth(FFType: Option " ","Sales Person",PCH,"Zonal Manager",ZH; MnthDate: Date; StrongMarketType: Boolean; LYSales: Decimal; CYSales: Decimal; Cnt: Decimal): Decimal
    var
        PercentageInc: Decimal;
        AvgSales: Decimal;
    begin
        IF FFType = FFType::PCH THEN BEGIN
            IF (CYSales - LYSales) < 0 THEN EXIT(0);
            IF LYSales = 0 THEN EXIT(0);

            PercentageInc := ROUND(((CYSales - LYSales) / LYSales) * 100);
            CASE PercentageInc OF
                0.01 .. 9.99:
                    EXIT(0);
                10 .. 14.99:
                    EXIT(6);
                15 .. 20:
                    EXIT(12);
                20.01 .. 9999999999999.0:
                    EXIT(15);
            END;
        END;

        IF FFType IN [FFType::ZH, FFType::"Zonal Manager"] THEN BEGIN
            IF (CYSales - LYSales) < 0 THEN EXIT(0);
            IF LYSales = 0 THEN EXIT(0);

            //  IF DATE2DMY(MnthDate,2) IN [4,5,6] THEN EXIT(15);
            PercentageInc := ROUND(((CYSales - LYSales) / LYSales) * 100);
            CASE PercentageInc OF
                0.01 .. 9.99:
                    EXIT(0);
                10 .. 14.99:
                    EXIT(6);
                15 .. 20:
                    EXIT(12);
                20.01 .. 9999999999999.0:
                    EXIT(15);
            END;
        END;
    end;

    procedure CalculatePointsonNewStoreGrowth(FFType: Option " ","Sales Person",PCH,"Zonal Manager",ZH; MnthDate: Date; StrongMarketType: Boolean; LYSales: Decimal; CYSales: Decimal; Cnt: Decimal): Decimal
    var
        PercentageInc: Decimal;
        AvgSales: Decimal;
    begin
        IF FFType IN [FFType::ZH, FFType::"Zonal Manager"] THEN BEGIN
            //  IF LYSales = 0 THEN EXIT(0);
            IF Cnt <= 0 THEN EXIT(0);
            AvgSales := ROUND(CYSales / Cnt);
            CASE AvgSales OF
                0 .. 599999:
                    EXIT(0);
                600000 .. 699999:
                    EXIT(4);
                700000 .. 799999:
                    EXIT(6);
                800000 .. 899999:
                    EXIT(8);
                900000 .. 999999999:
                    EXIT(10);
            END;
        END;
        IF FFType = FFType::PCH THEN BEGIN
            IF Cnt <= 0 THEN EXIT(0);
            AvgSales := ROUND(CYSales / Cnt);
            CASE AvgSales OF
                0 .. 699999:
                    EXIT(0);
                700000 .. 799999:
                    EXIT(4);
                800000 .. 899999:
                    EXIT(6);
                900000 .. 999999:
                    EXIT(8);
                1000000 .. 999999999:
                    EXIT(10);
            END;
        END;
    end;

    procedure CalculatePointsonCP2L(NoOfCPBilled: Decimal; TotalCPs: Decimal): Decimal
    var
        PercentageInc: Decimal;
        AvgSales: Decimal;
    begin
        IF "FF Type" = "FF Type"::ZH THEN BEGIN
            IF TotalCPs = 0 THEN EXIT(0);
            AvgSales := ROUND((NoOfCPBilled / TotalCPs) * 100);
            CASE AvgSales OF
                0 .. 59.99:
                    EXIT(0);
                60 .. 64.99:
                    EXIT(5);
                65 .. 69.99:
                    EXIT(8);
                70 .. 74.99:
                    EXIT(10);
                75 .. 79.99:
                    EXIT(15);
                80 .. 999999999:
                    EXIT(20);
            END;

        END;
    end;

    procedure CalculatePointsonAttritions(NoOfAttritions: Decimal; TotalTeamMembers: Decimal): Decimal
    var
        PercentageInc: Decimal;
        AvgSales: Decimal;
    begin
        IF "FF Type" = "FF Type"::ZH THEN BEGIN
            IF TotalTeamMembers = 0 THEN EXIT(0);
            AvgSales := ROUND((NoOfAttritions / TotalTeamMembers) * 100);
            CASE AvgSales OF
                0 .. 9.99:
                    EXIT(20);
                10 .. 14.99:
                    EXIT(15);
                15 .. 19.99:
                    EXIT(10);
                20 .. 29.99:
                    EXIT(5);
                30 .. 999999999:
                    EXIT(0);
            END;
        END;
    end;

    procedure CalculatePointsonCashFlowIncrease(FFType: Option " ","Sales Person",PCH,"Zonal Manager",ZH; LastBase: Decimal; ForThePeriod: Decimal): Decimal
    var
        PercentageInc: Decimal;
        AvgSales: Decimal;
    begin
        IF FFType IN [FFType::ZH, FFType::"Zonal Manager"] THEN BEGIN
            IF LastBase <= 0 THEN EXIT(0);
            AvgSales := -1 * ROUND(((ForThePeriod - LastBase) / LastBase) * 100);
            //MESSAGE('%1=%2  %3',LastBase,ForThePeriod,AvgSales);
            CASE AvgSales OF
                0.01 .. 1.99:
                    EXIT(5);
                2 .. 4.99:
                    EXIT(10);
                5 .. 199999999999.0:
                    EXIT(15);
            END;
        END;
    end;

    local procedure CalcProtectionRange(AvgDec: Decimal; ProtectionPer: Decimal; MaxMin: Boolean): Decimal
    var
        a: Decimal;
    begin
        IF MaxMin THEN BEGIN
            a := AvgDec + (AvgDec * ProtectionPer);
        END ELSE BEGIN
            a := AvgDec - (AvgDec * ProtectionPer);
        END;
        EXIT(ROUND(a, 0.01, '='));
    end;
}

