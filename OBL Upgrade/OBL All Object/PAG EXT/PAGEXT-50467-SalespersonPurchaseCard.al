pageextension 50467 "EXtSalesperson/Purchaser Card" extends "Salesperson/Purchaser Card"
{
    layout
    {
        addafter("E-Mail")
        {
            field("Emp Code"; rec."Emp Code")
            {
                ApplicationArea = all;
            }
            field(Dimension; rec.Dimension)
            {
                ApplicationArea = all;
            }
            field("Customer No."; rec."Customer No.")
            {
                ApplicationArea = all;
            }
            field("Joining Date"; Rec."Joining Date")
            {
                ApplicationArea = all;
            }
            field(Set; rec.Set)
            {
                ApplicationArea = all;
            }
            field("G E T"; rec."G E T")
            {
                ApplicationArea = all;
            }
            field(Pet; rec.Pet)
            {
                ApplicationArea = all;
            }
            field("Employee Type"; rec."Employee Type")
            {
                ApplicationArea = all;
            }
            field("Customer Name"; rec."Customer Name")
            {
                ApplicationArea = all;
            }
            field(Status; rec.Status)
            {
                ApplicationArea = all;
            }
            field(Type; rec.Type)
            {
                ApplicationArea = all;
            }
            field(PCH; rec.PCH)
            {
                ApplicationArea = all;
            }
            field("Sales Person"; rec."Sales Person")
            {
                ApplicationArea = all;
            }
            field("HQ Town"; rec."HQ Town")
            {
                ApplicationArea = all;
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}