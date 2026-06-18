pageextension 70057 "AVTD_PAG9305" extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        //SetRange("Purchase Status", "Purchase Status"::" ");
        Rec.SetRange("AVTD_Sales Status", Rec."AVTD_Sales Status"::" ");
        Rec.FilterGroup(0);
    end;

}