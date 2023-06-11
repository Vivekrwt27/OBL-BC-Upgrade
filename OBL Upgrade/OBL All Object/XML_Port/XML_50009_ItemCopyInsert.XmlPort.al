xmlport 50009 "Item Copy Insert"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Itemcopy)
        {
            tableelement("Item-Customer Group Discount"; 50064)
            {
                XmlName = 'Salesprice';
                /* fieldelement(ab; "Item Copy".Field1)
                 {
                 }
                 fieldelement(bc; "Item Copy".Field2)
                 {
                 }*/// 16767

            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

