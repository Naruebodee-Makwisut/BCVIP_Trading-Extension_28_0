tableextension 70055 "AVTD_TAB32" extends "Item Ledger Entry" //MyTargetTableId
{
    fields
    {
        field(50000; "AVTD_Create Date"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Create Date';
            Description = '//TD-001';
        }
    }

}