pageextension 70051 "AVTD_PAG38" extends "Item Ledger Entries" //MyTargetPageId
{
    layout
    {
        addafter("Posting Date")
        {
            field("AVTD_Create Date"; Rec."AVTD_Create Date")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}