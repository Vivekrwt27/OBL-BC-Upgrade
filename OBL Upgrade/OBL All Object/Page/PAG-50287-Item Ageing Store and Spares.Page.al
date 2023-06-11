page 50287 "Item Ageing -Store and Spares"
{
    Editable = false;
    PageType = List;
    SourceTable = 50063;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; rec."Entry No.")
                {
                }
                field("Item No."; rec."Item No.")
                {
                }
                field("Posting Date"; rec."Posting Date")
                {
                }
                field("Entry Type"; rec."Entry Type")
                {
                }
                field("Document No."; rec."Document No.")
                {
                }
                field(Description; rec.Description)
                {
                }
                field("Location Code"; rec."Location Code")
                {
                }
                field(Quantity; rec.Quantity)
                {
                }
                field("Remaining Quantity"; rec."Remaining Quantity")
                {
                }
                field("Invoiced Quantity"; rec."Invoiced Quantity")
                {
                }
                field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
                {
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                }
                field("Derived from Blanket Order"; rec."Derived from Blanket Order")
                {
                }
                field("Item Category Code"; rec."Item Category Code")
                {
                }
                field("Completely Invoiced"; rec."Completely Invoiced")
                {
                }
                field("Last Invoice Date"; rec."Last Invoice Date")
                {
                }
                field("Net Weight"; rec."Net Weight")
                {
                }
                field("Qty in PCS."; rec."Qty in PCS.")
                {
                }
                field("Direct Consumption Entries"; rec."Direct Consumption Entries")
                {
                }
                field("Depot. Prod Order"; rec."Depot. Prod Order")
                {
                }
                field("Temp Entry to Adjust"; rec."Temp Entry to Adjust")
                {
                }
                field("Mfg. Batch No."; rec."Mfg. Batch No.")
                {
                }
                field("Ageing Date"; rec."Ageing Date")
                {
                }
                field("Indent No."; rec."Indent No.")
                {
                }
                field("Cost Amount"; rec."Cost Amount")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        creater := '';
        indenter := '';
        indenter_Name := '';
        creater_name := '';

        IF IndentHeader.GET(rec."Indent No.") THEN BEGIN
            creater := IndentHeader."User ID";
            indenter := IndentHeader."Created By";
            IF UserSetup.GET(creater) THEN
                creater_name := UserSetup."User Name";
        END;

    end;

    var
        IndentHeader: Record 50016;
        creater: Code[30];
        indenter: Text[100];
        indenter_Name: Text[100];
        UserSetup: Record 91;
        creater_name: Text[100];
}

