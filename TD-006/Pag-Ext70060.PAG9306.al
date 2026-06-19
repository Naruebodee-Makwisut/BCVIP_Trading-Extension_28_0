pageextension 70060 "AVTD_PAG9306" extends "Purchase Quotes"
{
    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange("AVTD_Finished PR", false);
        Rec.FilterGroup(0);
    end;
}