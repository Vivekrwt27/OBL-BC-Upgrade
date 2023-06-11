pageextension 50367 pageextension50367 extends "Administrator Role Center"
{
    actions
    {
        modify("Page Data Classifications")
        {
            Visible = false;
        }
        modify(Classified)
        {
            Visible = false;
        }
        modify(Unclassified)
        {
            Visible = false;
        }
        modify("Page Data Subjects")
        {
            Visible = false;
        }
        modify("Page Change Log Entries")
        {
            Visible = false;
        }
    }
}

