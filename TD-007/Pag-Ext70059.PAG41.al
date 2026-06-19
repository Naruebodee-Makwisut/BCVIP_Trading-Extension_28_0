pageextension 70059 "AVTD_PAG41" extends "Sales Quote"
{
    actions
    {
        // Add changes to page actions here
        addlast("F&unctions")
        {
            action("AVTD_Finished SQ")
            {
                ApplicationArea = All;
                Caption = 'Finished Sales Quote';
                Image = Completed;
                trigger OnAction()
                begin
                    if not Confirm(StrSubstNo('Do you want to Finished SQ %1 ?', Rec."No."), false) then
                        Error('');
                    UpdateHeaderField(Rec."AVTD_Finished SQ", true);
                end;
            }
            separator("AVTD_Superate") { }
            action("AVTD_Cancel SQ")
            {
                ApplicationArea = All;
                Caption = 'Cancel Sales Quote';
                Image = Cancel;
                trigger OnAction()
                begin
                    if not Confirm(StrSubstNo('Do you want to Cancel SQ %1 ?', Rec."No."), false) then
                        Error('');
                    UpdateHeaderField(Rec."AVTD_Cancel SQ", true);
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref("AVTD_Finished SQ_Promoted"; "AVTD_Finished SQ")
            {
            }
            actionref("AVTD_Cancel SQ_Promoted"; "AVTD_Cancel SQ")
            {
            }
        }
    }
    local procedure UpdateHeaderField(fin: Boolean; can: Boolean)
    var
        SalesHeader: Record "Sales Header";
    begin
        Clear(SalesHeader);
        SalesHeader.SetRange("Document Type", Rec."Document Type");
        SalesHeader.SetRange("No.", Rec."No.");
        if SalesHeader.FindSet() then begin
            if not SalesHeader."AVTD_Finished SQ" then begin
                if not SalesHeader."AVTD_Cancel SQ" then begin
                    if can then
                        fin := can;
                    SalesHeader."AVTD_Finished SQ" := fin;
                    SalesHeader."AVTD_Cancel SQ" := can;
                    SalesHeader.Modify()
                end else
                    Error('This document no. %1 alrady cancel!', SalesHeader."No.");
            end else
                Error('This document no. %1 already %2', SalesHeader."No.", Rec.FieldCaption(Rec."AVTD_Finished SQ"));
        end;
    end;
}