pageextension 50470 EmailEditor extends "Email Editor"
{
    layout
    {
        modify(Account)
        {
            trigger OnAssistEdit()
            var
                UserSetup: Record "User Setup";
                UserSetupPage: Page 119;
            begin
                UserSetup.get(UserId);
                // if UserSetupPage.RunModal() = Action::LookupOK then

            end;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}