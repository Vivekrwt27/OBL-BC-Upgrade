query 50099 "Pending Approval Entries"
{
    OrderBy = Ascending(Table_ID), Ascending(Document_No);

    elements
    {
        dataitem(Approval_Entry; 454)
        {
            DataItemTableFilter = Status = FILTER(Open | Created);
            filter(ApproverFilter; "Approver ID")
            {
            }
            column(Table_ID; "Table ID")
            {
            }
            column(Document_No; "Document No.")
            {
            }
            column(Min_Sequence_No; "Sequence No.")
            {
                Method = Min;
            }
        }
    }
}

