xmlport 50056 "Purchase Header Update"
{
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement("purchase header1")
        {
            XmlName = 'MinMaxInventory';
            tableelement(Integer; 2000000026)
            {
                AutoSave = false;
                XmlName = 'MinMaxInventory';
                SourceTableView = SORTING(Number)
                                  WHERE(Number = CONST(1));
                textelement(purhead)
                {
                    XmlName = 'PurHead';
                }
                textelement(sta)
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    ItemRec: Record "Purchase Header";
                begin
                    ItemRec.RESET;
                    ItemRec.SETRANGE("No.", PurHead);
                    IF ItemRec.FINDFIRST THEN BEGIN
                        ItemRec.VALIDATE(Status, ItemRec.Status::"Short Close");
                        ItemRec.MODIFY;
                        //MESSAGE('recVar %1 = %2', ItemRec."No.", PurHead);
                    END;
                    //MESSAGE('%1', PurHead);
                end;
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

    trigger OnInitXmlPort()
    var
        ItemREC: Record Item;
    begin
    end;

    var
        msta: Integer;
}

