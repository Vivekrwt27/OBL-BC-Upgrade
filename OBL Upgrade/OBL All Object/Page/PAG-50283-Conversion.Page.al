page 50283 convesion
{
    PageType = List;
    Permissions = TableData 50031 = rimd;
    SourceTable = 50031;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Size; rec.Size)
                {
                }
                field(Packing; rec.Packing)
                {
                }
                field(CRT; rec.CRT)
                {
                }
                field(Pcs; rec.Pcs)
                {
                }
                field(SQfeet; rec.SQfeet)
                {
                }
                field("nt wt"; rec."nt wt")
                {
                }
                field("g wt"; rec."g wt")
                {
                }
                field("Size Description"; rec."Size Description")
                {
                }
                field("Packing Description"; rec."Packing Description")
                {
                }
                field("SQ.MT"; rec."SQ.MT")
                {
                }
            }
        }
    }

    actions
    {
    }
}

