tableextension 70056 "AVTD_TAB37" extends "Sales Line" //MyTargetTableId
{
    fields
    {
        field(50001; "AVTD_AVCancel"; Boolean)
        {
            Caption = 'Cancel';
            Description = '//TD-003 สำหรับติ๊กเพื่อ cancel SO';
            DataClassification = CustomerContent;
            //FieldPropertyName = FieldPropertyValue;
        }
    }

}