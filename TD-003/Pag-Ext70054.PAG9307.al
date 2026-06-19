pageextension 70054 "AVTD_PAG9307" extends "Purchase Order List" //MyTargetPageId
{
    layout
    {

    }

    actions
    {

    }
    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        //SetRange(FINISHED, false);
        Rec.SetRange("AVTD_Purchase Status", Rec."AVTD_Purchase Status"::" ");
        Rec.FilterGroup(0);
    end;

}