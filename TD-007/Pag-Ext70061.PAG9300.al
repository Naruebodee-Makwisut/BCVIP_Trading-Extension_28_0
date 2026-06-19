pageextension 70061 "AVTD_PAG9300" extends "Sales Quotes"
{
    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange("AVTD_Finished SQ", false);
        Rec.FilterGroup(0);
    end;
}