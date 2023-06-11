tableextension 50034 tableextension50034 extends State
{
    fields
    {
        field(50000; Dimension; Code[20])
        {

            trigger OnLookup()
            begin
                //mo tri1.0 Customization no.64 start
                GLSetUp.GET;
                DimValue.SETFILTER("Dimension Code", GLSetUp."State Dimension Code");
                IF DimValue.FIND('-') THEN
                    IF PAGE.RUNMODAL(PAGE::"Dimension Value List", DimValue) = ACTION::LookupOK THEN;
                //mo tri1.0 Customization no.64 end
            end;
        }
        field(50001; Zone; Text[7])
        {
        }
    }

    var
        GLSetUp: Record "General Ledger Setup";
        DimValue: Record "Dimension Value";
        DefDim: Record "Default Dimension";
}

