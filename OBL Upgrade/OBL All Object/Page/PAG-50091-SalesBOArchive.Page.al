page 50091 "Sales BO Archive"
{
    Caption = 'Sales Order Archive';
    Editable = false;
    PageType = Card;
    SourceTable = "Item Amount3";
    //   SourceTableView = WHERE("Item No." = CONST(4));
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Amount 2"; Rec."Amount 2")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }

                field("Production Order No."; Rec."Production Order No.")
                {
                    ApplicationArea = All;
                }
                field("Additional Amount"; Rec."Additional Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    Caption = 'Locked';
                    ApplicationArea = All;
                }

                field("Plant Code"; Rec."Plant Code")
                {
                    ApplicationArea = All;
                }
                field("ILE Entry No."; Rec."ILE Entry No.")
                {
                    ApplicationArea = All;
                }
            }
            part(SalesLinesArchive; "Sales BO Archive Subform")
            {
                // SubPageLink = "Variant Code" = FIELD("Amount 2"), Field5048 = FIELD(Field5048), Field5047 = FIELD(Field5047);
                ApplicationArea = All;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';

                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }

            }
            group(Shipping)
            {
                Caption = 'Shipping';

                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }

            }

            group(Version)
            {
                Caption = 'Version';

            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ver&sion")
            {
                Caption = 'Ver&sion';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Customer Card";
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    //  RunObject = Page 5158;
                    ApplicationArea = All;
                }
                action("List Other Version")
                {
                    Caption = 'List Other Version';
                    RunObject = Page "Sales List Archive";
                    //   RunPageLink = "Document Type" = FIELD("Item No."), "No." = FIELD("Amount 2");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            action("&Restore")
            {
                Caption = '&Restore';
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ArchiveManagement: Codeunit "Post Auto Application";
                begin
                    //  ArchiveManagement.RestoreSalesDocument(Rec);
                end;
            }
        }
    }

    trigger OnInit()
    begin
        "Version No.Visible" := TRUE;
    end;

    trigger OnOpenPage()
    begin

        //Pr Start Tri
        "Version No.Visible" := FALSE;
        //Pr Start Tri
    end;

    var
        [InDataSet]
        "Version No.Visible": Boolean;
}

