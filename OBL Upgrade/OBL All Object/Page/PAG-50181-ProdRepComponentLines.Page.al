page 50181 "Prod. Rep. Component Lines"
{
    Editable = false;
    PageType = List;
    SourceTable = "Prod. Order Component";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Expected Quantity"; Rec."Expected Quantity")
                {
                    ApplicationArea = All;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = All;
                }
                field("Flushing Method"; Rec."Flushing Method")
                {
                    ApplicationArea = All;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; ipg)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        Rec.Inventory := 0;
        CalculateInventory;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.Inventory := 0;
        CalculateInventory;

        IF recitem.GET(Rec."Item No.") THEN
            ipg := recitem."Inventory Posting Group";
    end;

    trigger OnOpenPage()
    begin

        IF ProdRepDoc = '' THEN
            ERROR('Run from Reporting page');

        PrepareData(ProdRepDoc, ProdRepDocLine);
    end;

    var
        ProdOrderComponent: Record "Prod. Order Component";
        LineNo: Integer;
        ProdRepDoc: Code[20];
        ProdRepDocLine: Integer;
        Inventory: Decimal;
        ipg: Code[10];
        recitem: Record Item;

    procedure PrepareData(ProdRepNo: Code[20]; ProdRepLineNo: Integer)
    begin
        LineNo := 10000;
        IF Rec.FINDFIRST THEN
            Rec.DELETEALL;
        ProdOrderComponent.SETRANGE("Prod. Reporting No.", ProdRepNo);
        IF ProdRepLineNo <> 0 THEN
            ProdOrderComponent.SETRANGE("Prod. Reporting Line No.", ProdRepLineNo);
        IF ProdOrderComponent.FINDFIRST THEN BEGIN
            //WITH ProdOrderComponent DO BEGIN
            REPEAT
                Rec.RESET;
                Rec.SETRANGE("Item No.", ProdOrderComponent."Item No.");
                IF NOT Rec.FINDFIRST THEN BEGIN
                    Rec."Prod. Reporting No." := ProdOrderComponent."Prod. Reporting No.";
                    Rec."Prod. Reporting Line No." := ProdOrderComponent."Prod. Reporting Line No.";
                    Rec."Item No." := ProdOrderComponent."Item No.";
                    Rec.Description := ProdOrderComponent.Description;
                    Rec."Line No." := LineNo;
                    Rec.Quantity := ProdOrderComponent.Quantity;
                    Rec."Quantity (Base)" := ProdOrderComponent."Quantity (Base)";
                    Rec."Expected Quantity" := ProdOrderComponent."Expected Quantity";
                    Rec."Expected Qty. (Base)" := ProdOrderComponent."Expected Qty. (Base)";
                    Rec."Location Code" := ProdOrderComponent."Location Code";
                    Rec."Remaining Quantity" := ProdOrderComponent."Remaining Quantity";
                    Rec."Remaining Qty. (Base)" := ProdOrderComponent."Remaining Qty. (Base)";
                    LineNo += 1000;
                    Rec.INSERT;
                END ELSE BEGIN
                    Rec.Quantity += ProdOrderComponent.Quantity;
                    Rec."Quantity (Base)" += ProdOrderComponent."Quantity (Base)";
                    Rec."Expected Quantity" += ProdOrderComponent."Expected Quantity";
                    Rec."Expected Qty. (Base)" += ProdOrderComponent."Expected Qty. (Base)";
                    Rec."Remaining Quantity" += ProdOrderComponent."Remaining Quantity";
                    Rec."Remaining Qty. (Base)" += ProdOrderComponent."Remaining Qty. (Base)";

                    Rec.MODIFY;
                END;
            UNTIL ProdOrderComponent.NEXT = 0;
        END;
        Rec.RESET;
        Rec.FINDFIRST;
    end;

    procedure SetDocument(Doc: Code[20]; DocLine: Integer)
    begin
        ProdRepDoc := Doc;
        ProdRepDocLine := DocLine;
    end;

    local procedure CalculateInventory()
    var
        Items: Record Item;
    begin
        Items.RESET;
        Items.SETRANGE("No.", Rec."Item No.");
        Items.SETRANGE("Location Filter", Rec."Location Code");
        IF Items.FINDFIRST THEN BEGIN
            Items.CALCFIELDS(Inventory);
            Rec.Inventory := Items.Inventory;
        END;
    end;
}

