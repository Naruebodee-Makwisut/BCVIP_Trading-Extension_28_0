pageextension 70052 "AVTD_PAG97" extends "Purchase Quote Subform" //MyTargetPageId
{
    layout
    {
        addafter("Line Discount Amount")
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