tableextension 50275 tableextension50275 extends "Manufacturing Setup"
{
    // 
    // 1.TRI S.R 190310 - New field Added
    // 2.TRI S.R 210310 - New field Add
    fields
    {
        field(50000; "Consumption Quantity"; Option)
        {
            Caption = 'Preset Output Quantity';
            Description = 'TRI S.R 190310 - New field Add';
            OptionCaption = 'Expected Quantity,Zero on All Operations';
            OptionMembers = "Expected Quantity","Zero on All Operations";
        }
        field(50001; "Forecast Authorization 1"; Code[20])
        {
            Description = 'TRI S.R 210310 - New field Add';
            TableRelation = "User Setup"."User ID";
        }
        field(50002; "Forecast Authorization 2"; Code[20])
        {
            Description = 'TRI S.R 210310 - New field Add';
            TableRelation = "User Setup"."User ID";
        }
        field(50003; "Default Forecast Location"; Code[20])
        {
            Description = 'TRI S.R 210310 - New field Add';
            TableRelation = Location.Code WHERE("Use As In-Transit" = FILTER(false));
        }
        field(50004; "Normal Variant Code"; Code[4])
        {
            Description = 'TRI S.R 210310 - New field Add';
            TableRelation = "Item Variant".Code;
        }
        field(50005; "Create Release Prod. Order"; Boolean)
        {
            Description = 'TRI S.R 04.02.10 - New field Added for Manufacturing';
        }
        field(50006; "Con. Bus. Posting Group"; Code[20])
        {
            Description = 'TRI S.R 210310 - New field Add';
            TableRelation = "Gen. Business Posting Group".Code;
        }
        field(50007; "Sampling No. Series"; Code[20])
        {
            Description = 'TRI S.R 210310 - New field Add';
            TableRelation = "No. Series";
        }
        field(50008; "Output Batch Name"; Code[10])
        {
            Description = 'TRI-VKG ADD';
            TableRelation = "Item Journal Batch".Name;
        }
        field(50009; "Consumption Batch Name"; Code[10])
        {
            Description = 'TRI-VKG ADD';
            TableRelation = "Item Journal Batch".Name;
        }
        field(50010; "Automatic RPO UOM"; Code[10])
        {
            Description = 'TRI-VKG ADD';
            TableRelation = "Unit of Measure";
        }
        field(50011; "Post Output (Days)"; DateFormula)
        {
            Description = 'TSPL SA';
        }
        field(50012; "Allow Discoutinued"; Boolean)
        {
            Description = 'MIPL- MSBS.Rao Dt. 11-04-13';
        }
        field(50013; "Forcast No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50014; "Production Reporting No.Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50015; "Power & Fuel No. Cons. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}

