pageextension 70053 "AVTD_PAG461" extends "Inventory Setup" //MyTargetPageId
{
    layout
    {
        addafter("Internal Movement Nos.")
        {
            field("AVTD_AVTD_Issue Gen. Bus Posting Group"; Rec."AVTD_Iss. Gen.Bus Post. Grp")
            {
                ApplicationArea = All;
            }
            field("AVTD_AVTD_Issue Journal Batch Name"; Rec."AVTD_Iss. Jnl Batch Name")
            {
                ApplicationArea = All;
            }
            field("AVTD_AVTD_Issue Journal Template Name"; Rec."AVTD_Iss. Jnl Template Name")
            {
                ApplicationArea = All;
            }
            field("AVTD_AVTD_Issue Nos."; Rec."AVTD_Issue Nos.")
            {
                ApplicationArea = All;
            }
        }

    }

}