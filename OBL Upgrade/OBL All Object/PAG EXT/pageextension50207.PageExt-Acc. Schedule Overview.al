pageextension 50207 pageextension50207 extends "Acc. Schedule Overview"
{
    layout
    {

        addafter("Dimension Filters")
        {
            repeater(Group)
            {
                Editable = false;

            }
        }
        moveafter(Group; "Row No.", Description)
    }
}

