pageextension 70058 "AVTD_PAG49" extends "Purchase Quote"
{
    actions
    {
        // Add changes to page actions here
        addlast("F&unctions")
        {
            action("AVTD_Cancel PR")
            {
                ApplicationArea = All;
                Caption = 'Cancel Purchase Quote';
                Image = Cancel;
                trigger OnAction()
                begin
                    if not Confirm(StrSubstNo('Do you want to Cancel PR %1 ?', Rec."No."), false) then
                        Error('');
                    UpdateHeaderField(true);
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref("AVTD_Cancel PR_Promoted"; "AVTD_Cancel PR")
            {
            }
        }

    }
    local procedure UpdateHeaderField(cancel: Boolean)
    var
        PurchHeader: Record "Purchase Header";
    begin
        Clear(PurchHeader);
        PurchHeader.SetRange("Document Type", Rec."Document Type");
        PurchHeader.SetRange("No.", Rec."No.");
        if PurchHeader.FindSet() then begin
            if not PurchHeader."AVTD_Finished PR" then begin
                if not PurchHeader."AVTD_Cancel PR" then begin
                    PurchHeader."AVTD_Cancel PR" := cancel;
                    //AVBCLSVIP.OP.45 PR-Cancel
                    PurchHeader."AVTD_Finished PR" := true;
                    //C-AVBCLSVIP.OP.45 PR-Cancel
                    PurchHeader.Modify()
                end else
                    Error('This document no. %1 alrady cancel!', PurchHeader."No.");
            end else
                Error('This document no. %1 already %2', PurchHeader."No.", Rec.FieldCaption(Rec."AVTD_Finished PR"));
        end;
    end;
}