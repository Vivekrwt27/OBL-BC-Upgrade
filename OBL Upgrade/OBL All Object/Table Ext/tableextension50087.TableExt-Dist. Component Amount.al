tableextension 50087 tableextension50087 extends "Dist. Component Amount"
{
    fields
    {
        modify("Distribution No.")
        {
            Caption = 'Distribution No.';
        }
        modify("GST Component Code")
        {
            Caption = 'GST Component Code';
        }
        modify("GST Base Amount")
        {
            Caption = 'GST Base Amount';
        }
        modify("GST Amount")
        {
            Caption = 'GST Amount';
        }
        modify("GST Registration No.")
        {
            Caption = 'GST Registration No.';
        }
        field(25; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(26; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
    }
}

