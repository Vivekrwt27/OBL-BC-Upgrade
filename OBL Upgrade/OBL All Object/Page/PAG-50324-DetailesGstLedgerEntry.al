/* page 50324 PageName
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Detailed GST Ledger Entry";
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Name; NameSource)
                {
                    ApplicationArea = All;
                    
                }
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                
                trigger OnAction();
                begin
                    
                end;
            }
        }
    }
} */