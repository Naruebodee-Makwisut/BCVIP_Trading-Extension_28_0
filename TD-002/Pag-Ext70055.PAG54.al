pageextension 70055 "AVTD_PAG54" extends "Purchase Order Subform" //MyTargetPageId
{
    layout
    {
        addfirst(Control1)
        {
            field("AVTD_Ref. Doc. No."; Rec."AVTD_Ref. Doc. No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("AVTD_Ref. Line No."; Rec."AVTD_Ref. Line No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}