tableextension 70054 "AVTD_TAB233" extends "Item Journal Batch" //MyTargetTableId
{
    fields
    {
        field(50000; "AVTD_Journal Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Journal Type';
            OptionCaption = ' ,Issue';
            OptionMembers = " ",Issue;
            Description = '//TD-004';
        }
    }

}