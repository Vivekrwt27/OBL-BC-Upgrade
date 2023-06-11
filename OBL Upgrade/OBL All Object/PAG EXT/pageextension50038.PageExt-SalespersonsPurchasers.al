pageextension 50038 pageextension50038 extends "Salespersons/Purchasers"
{
    Editable = false;
    layout
    {


        addafter(Code)
        {
            field("Customer No."; REC."Customer No.")
            {
                ApplicationArea = All;
            }
            field("Customer Name"; REC."Customer Name")
            {
                ApplicationArea = All;
            }
            field("Customer City"; REC."Customer City")
            {
                ApplicationArea = All;
            }

            field("Customer State"; REC."Customer State")
            {
                ApplicationArea = All;
            }
            field("Joining Date"; REC."Joining Date")
            {
                ApplicationArea = All;
            }
            field("E-Mail"; REC."E-Mail")
            {
                ApplicationArea = All;
            }
            field("Emp Code"; Rec."Emp Code")
            {
                ApplicationArea = all;
            }
            field(Dimension; Rec.Dimension)
            {
                ApplicationArea = all;
            }
            field(Set; Rec.Set)
            {
                ApplicationArea = all;
            }
            field("G E T"; Rec."G E T")
            {
                ApplicationArea = all;
            }
            field(Pet; Rec.Pet)
            {
                ApplicationArea = all;
            }
            field("Employee Type"; Rec."Employee Type")
            {
                ApplicationArea = all;
            }
            field(Type; Rec.Type)
            {
                ApplicationArea = all;
            }

            field("HQ Town"; Rec."HQ Town")
            {
                ApplicationArea = all;
            }

            field(Status; REC.Status)
            {
                ApplicationArea = All;
            }
        }
        addafter(Name)
        {
            field("Sales Person"; REC."Sales Person")
            {
                ApplicationArea = All;
            }

            field(PCH; REC.PCH)
            {
                ApplicationArea = All;
            }
        }

    }
}

