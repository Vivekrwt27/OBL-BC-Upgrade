xmlport 50022 "Temp Upload"
{
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Itemdata)
        {
            tableelement("QuickLook API Data"; 50089)
            {
                XmlName = 'Itemimportdata';
                /* fieldelement(a; "BOM Line Update".Field1)
                 {
                 }
                 fieldelement(b; "BOM Line Update".Field2)
                 {
                 }
                 fieldelement(c; "BOM Line Update".Field3)
                 {
                 }
                 fieldelement(d; "BOM Line Update".Field4)
                 {
                 }
                 fieldelement(e; "BOM Line Update".Field5)
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

